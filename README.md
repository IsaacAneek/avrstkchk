<div align="center">
<h1>avrstkchk</h1>
avrstkchk is a simple static stack analyzer tool for AVR microcontrollers. It generates worst case stack usage and function call graph directly from assembly generated from .elf files. It can also detect recursion and simulate recursion call depth. Simulating ISR call depth will be added in future. Since it depends on assembly instructions, it only works for AVR platforms.
</div>

# TODO
- [x] ~~Detect recursion~~
- [x] ~~Simulate recursion call depth~~
- [ ] Calculate function call depth
- [ ] Simulate ISR call depth
- [ ] Build a GUI
- [ ] Refactor code 
# Usage
## Windows
- Install <a href="https://luabinaries.sourceforge.net/">Lua Binaries</a>

  Add path of Lua Binaries folder to the environment variables
  
- dump the .text section from your .elf file into an .asm file

  ```
  avr-objdump -d [path to your .elf] > something.asm
  ```


- Run 

  ```
  lua55 avrstkchk.lua [path to your asm file]
  ```
