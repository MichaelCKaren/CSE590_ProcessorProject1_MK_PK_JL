There are a total of three memories that can be filled with data upon startup. These are the instruction memory located inside the PC module, the register file located inside the Decode module, and the data memory located inside the DataMemory module.
  - IM: Byte addressed meaning 8 bit width,   0-127 in size.
      - Purpose is to store the instructions, more useful to type out by hand rather than utilizing GenerateHexFiles.py.
  - RF: Word addressed meaning 16 bit width,  0-15 in size.
      - Purpose is to store data for computation, GenerateHexFiles.py can be useful.
  - DM: Byte addressed meaning 8 bit width,   0-127 in size.
      - Purpose is to store data for storage, GenerateHexFiles.py can be useful.
   
  To load the text files into memory, utilize $readmemh
  - example for use in DataMemory module:
```
  initial begin\
    $readmemh("/insert/path/to/file/here.txt", mem_data);\
  end
```
