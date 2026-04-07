import numpy as np

mem = np.zeros(128, dtype=np.uint8)

# ADD  opcode=0000 rt/rd=0000 rs=0000 funct=0000
mem[1]  = 0x00;  mem[0]  = 0x00  # ADD  R0, R0, funct=0000

# SUB  opcode=0000 rt/rd=0000 rs=0000 funct=0001
mem[3]  = 0x00;  mem[2]  = 0x01  # SUB  R0, R0, funct=0001

# SLL  opcode=0000 rt/rd=0000 rs=0000 funct=0010
mem[5]  = 0x00;  mem[4]  = 0x02  # SLL  R0, R0, funct=0010

# AND  opcode=0000 rt/rd=0000 rs=0000 funct=0011
mem[7]  = 0x00;  mem[6]  = 0x03  # AND  R0, R0, funct=0011

# LW   opcode=0001 rt/rd=0000 rs=0000 imm=0000
mem[9]  = 0x10;  mem[8]  = 0x00  # LW   R0, R0, 0

# SW   opcode=0010 rt/rd=0000 rs=0000 imm=0000
mem[11] = 0x20;  mem[10] = 0x00  # SW   R0, R0, 0

# ADDI opcode=0011 rt/rd=0000 rs=0000 imm=0000
mem[13] = 0x30;  mem[12] = 0x00  # ADDI R0, R0, 0

# BEQ  opcode=0100 rt/rd=0000 rs=0000 imm=0000
mem[15] = 0x40;  mem[14] = 0x00  # BEQ  R0, R0, 0

# BNE  opcode=0101 rt/rd=0000 rs=0000 imm=0000
mem[17] = 0x50;  mem[16] = 0x00  # BNE  R0, R0, 0

# JMP  opcode=0110 address=000000000000
mem[19] = 0x60;  mem[18] = 0x00  # JMP  0

np.savetxt('ALL_INSTR_TEST.txt', mem, fmt='%02X')