dofile("avrstkchk.lua")

local function test1()
	local asm_file = OpenAsmFile("E:/avrstkchk/tests/test1/test1.asm")
	if asm_file then
		GetFunctionInfoFromASMFile(asm_file)
		SimulateRecursionDepth()
		assert(FunctionStackUsage["bar"] == 104, "bar() function in ..\\test1.asm allocates 104 bytes")
		asm_file:close()
	else
		print("File not found")
	end
end

local function test2()
	local asm_file = OpenAsmFile("E:/avrstkchk/tests/test2/test2.asm")
	if asm_file then
		GetFunctionInfoFromASMFile(asm_file)
		SimulateRecursionDepth()
		assert(FunctionStackUsage["bar"] == 104, "bar() function in ..\\test2.asm allocates 104 bytes")
		assert(FunctionStackUsage["foo"] == 104, "foo() function in ..\\test2.asm allocates 104 bytes")
		asm_file:close()
	else
		print("File not found")
	end
end

test1()
test2()
