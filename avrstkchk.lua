FunctionStackUsage = {}
FunctionCallGraph = {}
ASMLines = {}
-- not clear who owns these global variables and when


local stack_usage_current_function = 2
local current_function = ""

function OpenAsmFile(filepath)
	local asm_file = io.open(filepath, "r")
	return asm_file
end

local function parse_call_instruction(line)
	local call = line:match("[^%a]call")
	if call then
		local callee_func_name = line:match("0x%x+%s+<([%w_]+)>")
		if FunctionCallGraph[current_function] then
			table.insert(FunctionCallGraph[current_function].calls, callee_func_name)
			-- check recursion
			if current_function == callee_func_name then
				FunctionCallGraph[current_function].is_recursive = true
			end
		end
	end
end

local function parse_push_instruction(line)
	local push = line:match("push")
	if push then
		stack_usage_current_function = stack_usage_current_function + 1
	end
end

local function parse_rcall_instruction(line)
	local rcall = line:match("rcall")
	if rcall then
		stack_usage_current_function = stack_usage_current_function + 2
	end
end


local function parse_stack_frame_pointer_adjustment(asm_line_index)
	local in0x3e = nil
	local lower_nibble = nil
	local upper_nibble = nil
	local hex_str = ""

	-- match r28 and r29 registers (which are used as frame pointers in avr)
	-- capture the values bcs these values are substracted from stack pointer

	-- match "in	r29, 0x3e" instruction bcs after this, the frame pointer is adjusted
	in0x3e = string.match(ASMLines[asm_line_index], "in%s+r29%s*,%s*0x3e")

	if in0x3e then
		lower_nibble = string.match(ASMLines[asm_line_index + 1], "s%a+%s+r28,%s*0x(%x+)")
		upper_nibble = string.match(ASMLines[asm_line_index + 2], "sbc[i]?%s+r29,%s*0x(%x+)")
	end

	if in0x3e then
		if lower_nibble then
			hex_str = hex_str .. lower_nibble:reverse()
		end
		if upper_nibble then
			hex_str = hex_str .. upper_nibble:reverse()
		end
		if hex_str ~= "" then
			-- this 'hex' is the size of the array allocated on the stack
			local hex = tonumber(hex_str:reverse(), 16)
			stack_usage_current_function = stack_usage_current_function + hex
		end
	end
end

function GetFunctionInfoFromASMFile(asm_file)
	for line in asm_file:lines() do
		table.insert(ASMLines, line)
	end
	for index, line in ipairs(ASMLines) do
		-- order dependent behaviour
		-- refactor
		parse_stack_frame_pointer_adjustment(index)
		parse_call_instruction(line)
		parse_rcall_instruction(line)
		parse_push_instruction(line)
		local new_func_name = line:match("%x%x%x%x%x%x%x%x <([^L][^L].+)>")
		-- if found new function
		-- update and reset all the function data
		-- and continue calculating the data of new function
		if new_func_name ~= current_function and new_func_name then
			FunctionStackUsage[current_function] = stack_usage_current_function
			stack_usage_current_function = 2
			FunctionCallGraph[new_func_name] = {
				calls = {},          -- contains callee function names
				is_recursive = false,
				max_recursion_depth = 10 --default recursion depth 10
			}
			current_function = new_func_name
		end
	end
end

function SetRecursionDepth(function_name, recursion_depth)
	if FunctionCallGraph[function_name].is_recursive then
		if recursion_depth then
			FunctionCallGraph[function_name].max_recursion_depth = recursion_depth
		end
	end
end

function SimulateRecursionDepth()
	for func_name, func_info_object in pairs(FunctionCallGraph) do
		if FunctionStackUsage[func_name] and func_info_object.is_recursive then
			FunctionStackUsage[func_name] = FunctionStackUsage[func_name] * func_info_object.max_recursion_depth
		end
	end
end

function GetStackUsage()
	return FunctionStackUsage
end

function GetCallGraph()
	return FunctionCallGraph
end

local function print_stack_usage()
	for func_name, stack_usage in pairs(FunctionStackUsage) do
		print(func_name .. "\t" .. stack_usage)
	end
end

local function print_call_graph()
	for key, obj in pairs(FunctionCallGraph) do
		io.write(key .. " {")
		for _, val in ipairs(obj.calls) do
			io.write(val .. ", ")
		end
		io.write(" }\n")
	end
end

local asm_file = OpenAsmFile(arg[1])
if asm_file then
	GetFunctionInfoFromASMFile(asm_file)
	SimulateRecursionDepth()
	print_stack_usage()
	print_call_graph()
	print(FunctionStackUsage["_Z13LTC6811_rdauxhP9cell_asic"])
	asm_file:close()
end

