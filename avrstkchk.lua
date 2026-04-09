FunctionStackUsage = {}
FunctionCallGraph = {}

local stack_usage_current_function = 2
local current_function = ""
local hex_str = ""

-- local asm_file = io.open("E:\\avr-playground\\firmware.asm", "r")
function OpenAsmFile(filepath)
	local asm_file = io.open(filepath, "r")
	return asm_file
end

local function parse_call_instruction(line)
	local call = line:match("[^%a]call")
	if call then
		local callee_func_name = line:match("0x%x+%s+<([%w_]+)>")
		if FunctionCallGraph[current_function] then
			table.insert(FunctionCallGraph[current_function], callee_func_name)
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

local function parse_stack_frame_pointer_adjustment(line)
	-- match r28 and r29 registers (which are used as frame pointers in avr)
	-- capture the values bcs these values are substracted from stack pointer
	local nibble = string.match(line, "s...%s+r2[89],%s*0x(%x+)")
	if nibble then
		hex_str = hex_str .. nibble:reverse()
		if hex_str:len() == 4 then
			-- this 'hex' is the size of the array allocated on the stack
			local hex = tonumber(hex_str:reverse(), 16)
			stack_usage_current_function = stack_usage_current_function + hex
			hex_str = ""
		end
	end
end

function AnalyzeAsmFile(asm_file)
	for line in asm_file:lines() do
		parse_stack_frame_pointer_adjustment(line)
		parse_call_instruction(line)
		parse_rcall_instruction(line)
		parse_push_instruction(line)
		local new_func_name = line:match("%x%x%x%x%x%x%x%x <([%w_]+)>")
		-- if found new function
		-- update and reset all the function data
		-- and continue calculating the data of new function
		if new_func_name ~= current_function and new_func_name then
			FunctionStackUsage[current_function] = stack_usage_current_function
			stack_usage_current_function = 2
			hex_str = ""
			FunctionCallGraph[new_func_name] = {}
			current_function = new_func_name
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
	for key, arr in pairs(FunctionCallGraph) do
		io.write(key .. " {")
		for _, val in ipairs(arr) do
			io.write(val .. ", ")
		end
		io.write(" }\n")
	end
end

local asm_file = OpenAsmFile(arg[1])
if asm_file then
	AnalyzeAsmFile(asm_file)
	print_stack_usage()
	print_call_graph()
	asm_file:close()
end

