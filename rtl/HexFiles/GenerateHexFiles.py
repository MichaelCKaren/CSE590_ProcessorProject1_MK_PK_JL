import numpy as np

mem = np.int8(np.zeros(128))
#for i in range(mem.shape[0]):
    #mem[i] = (i+1)*2048*(pow(-1,i))
    #mem[i] = ((i+1)*8)-1
    #mem[i] = (i+1)*2
    #mem[i] = 0 # ALL ZEROS

# For full instruction test
mem = {
    # Load immediate BOBA into registers R1, R2, R3, R4, keep R0 as zero register
    0: 0x0B,    #
    1: 0x31,    # 0x310B = ADDI R1, R0, B
    2: 0x00,    #
    3: 0x32,    # 0x3200 = ADDI R2, R0, 0
    4: 0x0B,    #
    5: 0x33,    # 0x3300 = ADDI R3, R0, B
    6: 0x0A,    #
    7: 0x34,    # 0x3400 = ADDI R4, R0, A

    # Shift left to align word
    # Fourth Nibble
    8: 0x0C,    #
    9: 0x3F,    # 0x3400 = ADDI R15, R0, 12      # Load the amount 12 into R15
    10: 0xF2,    #
    11: 0x01,    # 0x0452 = SLL R1, R5, FUNCT    # shift R4(B) by R16(12)

    # Third Nibble
    12: 0x04,    #
    13: 0x3E,    # 0x3400 = ADDI R14, R0, 4      # Shift amount of 12 to align to upper byte
    14: 0xE1,
    15: 0x0F,     # 0x0FE1 = SUB R15-R14, Funct   # 12 - 4 = 8, stored back in R14
    16: 0xE2,    #
    17: 0x02,    # 0x0452 = SLL R2, R5, FUNCT    # Shift R2(0) by 8

    # Second Nible
    18: 0x02,    #
    19: 0x3D,    # 0x3400 = ADDI R3, R0, 2     # Load the amount 2 into R13
    20: 0xD0,
    21: 0x0D,    # 0x0DD0 = ADD R13 + R13      # Increase R13 to 4
    22: 0xD2,    #
    23: 0x03,    # 0x0452 = SLL R3(b), R13(4)  # Shift R3(B) by 4

    # Allign word
    24: 0x10,
    25: 0x02,    # Add R1(B000) and R2(0000) into R2, giving 0xB000
    26: 0x20,
    27: 0x03,    # ADD R2(B000) and R3(00B0) into R3, giving 0xB0B0
    28: 0x30,
    29: 0x04,    # ADD R3(B0B0) and R4(000A) into R4, giving 0xB0BA


}
print(mem)
np.savetxt('SW_TEST_REG.txt', mem, fmt='%02X', delimiter=' ')
