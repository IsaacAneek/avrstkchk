![avrstk](https://github.com/user-attachments/assets/1fbe993b-960e-46e4-b98c-6520d245324e)
# avrstkchk
avrstkchk is a simple static stack analyzer tool for AVR microcontrollers. It generates worst case stack usage and function call graph directly from assembly code from .elf files.
Currently it can only get plain stack usage of functions (recursion call and ISR call depth are not not taken into account). Also since it depends on assembly instructions, it only works for AVR platforms.
# TODO
- [ ] Detect recursion
- [ ] Simulate recursion call depth
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
