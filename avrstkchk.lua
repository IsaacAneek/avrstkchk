
-- local asm_file = io.open("E:\\avr-playground\\firmware.asm", "r")
local asm_file = io.open(arg[1], "r")
if not asm_file then
	print("File not found")
	return
end

StackUsage = 2
FunctionName = ""
local hex_str = ""
FunctionStackUsage = {}
FunctionCallGraph = {}
for line in asm_file:lines() do
	--print(line)
	local nibble = string.match(line, "s...%s+r2[89],%s*0x(%x+)")
	if nibble then
		hex_str = hex_str .. nibble:reverse()
		if hex_str:len() == 4 then
			local hex = tonumber(hex_str:reverse(), 16)
			StackUsage = StackUsage + hex
			hex_str = ""
		end
	end
	local push = line:match("push")
	local rcall = line:match("rcall")
	local call = line:match("[^%a]call")
	--local pop = line:match("pop")
	if push then
		StackUsage = StackUsage + 1
	elseif rcall then
		StackUsage = StackUsage + 2
	elseif call then
		local callee_func_name = line:match("0x%x+%s+<([%w_]+)>")
		if FunctionCallGraph[FunctionName] then
			table.insert(FunctionCallGraph[FunctionName], callee_func_name)
		end
		--elseif pop then
		--StackUsage = StackUsage - 2
	end
	--print(StackUsage)
	local func_name = line:match("%x%x%x%x%x%x%x%x <([%w_]+)>")
	if func_name ~= FunctionName and func_name then
		--print(FunctionName .. "\t" .. StackUsage)
		FunctionStackUsage[FunctionName] = StackUsage
		StackUsage = 2
		hex_str = ""
		FunctionName = func_name
		FunctionCallGraph[FunctionName] = {}
	end
end

function rec_print_call_graph(key)
	if FunctionCallGraph == nil then
		return
	end
	
	for key, array in pairs(FunctionCallGraph) do
		print("---" .. key)
		for index, val in ipairs(array) do
			print("---" .. val)
			rec_print_call_graph(val)
		end
	end
end

for func_name, stack_usage in pairs(FunctionStackUsage) do
	print(func_name .. "\t" .. stack_usage)
end

for key, arr in pairs(FunctionCallGraph) do
	io.write(key .. "\t\t {")
	for index, val in ipairs(arr) do
		io.write(val .. ", ")
	end
	io.write(" }\n")
end

asm_file:close()
