import numpy as np

mem = np.zeros(128, dtype=np.uint8)

# ---- Build DEAD ----

# Load R1 = 0x0D (split: 7+6)
mem[1]  = 0x31;  mem[0]  = 0x07  # ADDI R1, R0, 7
mem[3]  = 0x31;  mem[2]  = 0x16  # ADDI R1, R1, 6 -> R1 = 0x0D

# Load R2 = 0x0E (split: 7+7)
mem[5]  = 0x32;  mem[4]  = 0x07  # ADDI R2, R0, 7
mem[7]  = 0x32;  mem[6]  = 0x27  # ADDI R2, R2, 7 -> R2 = 0x0E

# Load R3 = 0x0A (split: 7+3)
mem[9]  = 0x33;  mem[8]  = 0x07  # ADDI R3, R0, 7
mem[11] = 0x33;  mem[10] = 0x33  # ADDI R3, R3, 3 -> R3 = 0x0A

# Load R4 = 0x0D (split: 7+6)
mem[13] = 0x34;  mem[12] = 0x07  # ADDI R4, R0, 7
mem[15] = 0x34;  mem[14] = 0x46  # ADDI R4, R4, 6 -> R4 = 0x0D

# Shift left - Fourth Nibble (R15 = 12, split 7+5)
mem[17] = 0x3F;  mem[16] = 0x07  # ADDI R15, R0, 7
mem[19] = 0x3F;  mem[18] = 0xF5  # ADDI R15, R15, 5 -> R15 = 12
mem[21] = 0x01;  mem[20] = 0xF2  # SLL R1, R15 -> R1 = 0xD000

# Third Nibble (R14 = 8, 12-4)
mem[23] = 0x3E;  mem[22] = 0x04  # ADDI R14, R0, 4
mem[25] = 0x0E;  mem[24] = 0xF1  # SUB R14, R15 -> R14 = 8
mem[27] = 0x02;  mem[26] = 0xE2  # SLL R2, R14 -> R2 = 0x0E00

# Second Nibble (R13 = 4, split 2+2)
mem[29] = 0x3D;  mem[28] = 0x02  # ADDI R13, R0, 2
mem[31] = 0x0D;  mem[30] = 0xD0  # ADD R13, R13 -> R13 = 4
mem[33] = 0x03;  mem[32] = 0xD2  # SLL R3, R13 -> R3 = 0x00A0

# Align DEAD word
mem[35] = 0x02;  mem[34] = 0x10  # ADD R1 + R2 -> R2 = 0xDE00
mem[37] = 0x03;  mem[36] = 0x20  # ADD R2 + R3 -> R3 = 0xDEA0
mem[39] = 0x04;  mem[38] = 0x30  # ADD R3 + R4 -> R4 = 0xDEAD

# ---- Build BEEF nibbles ----

# Load base address R5 = 0
mem[41] = 0x35;  mem[40] = 0x00  # ADDI R5, R0, 0

# Load R6 = 0x0B (split: 7+4)
mem[43] = 0x36;  mem[42] = 0x07  # ADDI R6, R0, 7
mem[45] = 0x36;  mem[44] = 0x64  # ADDI R6, R6, 4 -> R6 = 0x0B

# Load R7 = 0x0E (split: 7+7)
mem[47] = 0x37;  mem[46] = 0x07  # ADDI R7, R0, 7
mem[49] = 0x37;  mem[48] = 0x77  # ADDI R7, R7, 7 -> R7 = 0x0E

# Load R8 = 0x0E (split: 7+7)
mem[51] = 0x38;  mem[50] = 0x07  # ADDI R8, R0, 7
mem[53] = 0x38;  mem[52] = 0x87  # ADDI R8, R8, 7 -> R8 = 0x0E

# Load R9 = 0x0F (split: 5+5+5)
mem[55] = 0x39;  mem[54] = 0x05  # ADDI R9, R0, 5
mem[57] = 0x39;  mem[56] = 0x95  # ADDI R9, R9, 5 -> R9 = 0x0A
mem[59] = 0x39;  mem[58] = 0x95  # ADDI R9, R9, 5 -> R9 = 0x0F

# Store nibbles to memory
mem[61] = 0x26;  mem[60] = 0x50  # SW R6 -> mem[R5 + 0] (B)
mem[63] = 0x27;  mem[62] = 0x51  # SW R7 -> mem[R5 + 1] (E)
mem[65] = 0x28;  mem[64] = 0x52  # SW R8 -> mem[R5 + 2] (E)
mem[67] = 0x29;  mem[66] = 0x53  # SW R9 -> mem[R5 + 3] (F)

# Load nibbles back into R10-R13
mem[69] = 0x1A;  mem[68] = 0x50  # LW R10 <- mem[R5 + 0] (B)
mem[71] = 0x1B;  mem[70] = 0x51  # LW R11 <- mem[R5 + 1] (E)
mem[73] = 0x1C;  mem[72] = 0x52  # LW R12 <- mem[R5 + 2] (E)
mem[75] = 0x1D;  mem[74] = 0x53  # LW R13 <- mem[R5 + 3] (F)

# Reuse R5 = 4 for second nibble shift amount
mem[77] = 0x35;  mem[76] = 0x04  # ADDI R5, R0, 4

# Shift in place
mem[79] = 0x0A;  mem[78] = 0xF2  # SLL R10, R15 -> R10 = 0xB000
mem[81] = 0x0B;  mem[80] = 0xE2  # SLL R11, R14 -> R11 = 0x0E00
mem[83] = 0x0C;  mem[82] = 0x52  # SLL R12, R5  -> R12 = 0x00E0
# R13 = 0x000F, no shift needed

# Accumulate BEEF
mem[85] = 0x0B;  mem[84] = 0xA0  # ADD R11 + R10 -> R11 = 0xBE00
mem[87] = 0x0C;  mem[86] = 0xB0  # ADD R12 + R11 -> R12 = 0xBEE0
mem[89] = 0x0D;  mem[88] = 0xC0  # ADD R13 + R12 -> R13 = 0xBEEF

# ---- Print Loop ----

# LOOP_DEAD at mem[90]
mem[91]  = 0xF0;  mem[90]  = 0x10  # DIG R1  (D000)
mem[93]  = 0xF0;  mem[92]  = 0x20  # DIG R2  (DE00)
mem[95]  = 0xF0;  mem[94]  = 0x30  # DIG R3  (DEA0)
mem[97]  = 0xF0;  mem[96]  = 0x40  # DIG R4  (DEAD)
mem[99]  = 0x60;  mem[98]  = 0x00  # JMP +0 -> LOOP_BEEF at mem[100]

# LOOP_BEEF at mem[100]
mem[101] = 0xF0;  mem[100] = 0xA0  # DIG R10 (B000)
mem[103] = 0xF0;  mem[102] = 0xB0  # DIG R11 (BE00)
mem[105] = 0xF0;  mem[104] = 0xC0  # DIG R12 (BEE0)
mem[107] = 0xF0;  mem[106] = 0xD0  # DIG R13 (BEEF)
# JMP back to LOOP_DEAD at mem[90]
# PC = 110, target = 90, distance = 90 - 110 = -20, offset = -20 >> 1 = -10 = 0xFF6
mem[109] = 0x6F;  mem[108] = 0xF6  # JMP -10 -> LOOP_DEAD

np.savetxt('IM_DEADBEEF.txt', mem, fmt='%02X')
