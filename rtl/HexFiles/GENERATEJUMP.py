import numpy as np

mem = np.zeros(128, dtype=np.uint8)

# mem[0-1] ADDI R1, R0, 1
mem[1]  = 0x31;  mem[0]  = 0x01  # ADDI R1, R0, 1

# mem[2-3] BNE R1, R0 -> branch to mem[10] if R1 != R0
# PC at branch = 4, target = 10, distance = 10-4 = 6, offset = 6>>1 = 3
mem[3]  = 0x51;  mem[2]  = 0x03  # BNE R1, R0, 3 -> mem[10]

# mem[4-9] empty
# already zeroed

# mem[10-11] BNE R1, R1 -> R1 == R1, does NOT branch, falls through
mem[11] = 0x51;  mem[10] = 0x10  # BNE R1, R1, 0

# mem[12-13] BEQ R1, R1 -> branch to mem[20]
# PC at branch = 14, target = 20, distance = 20-14 = 6, offset = 6>>1 = 3
mem[13] = 0x41;  mem[12] = 0x13  # BEQ R1, R1, 3 -> mem[20]

# mem[14-19] empty
# already zeroed

# mem[20-21] BEQ R1, R0 -> R1 != R0, does NOT branch, falls through
mem[21] = 0x41;  mem[20] = 0x00  # BEQ R1, R0, 0

# mem[22-23] JMP -> back to mem[2]
# PC at jump = 24, target = 2, distance = 2-24 = -22, offset = -22>>1 = -11 = 0xFF5
mem[23] = 0x6F;  mem[22] = 0xF5  # JMP -11 -> mem[2]

np.savetxt('BRANCH_TEST.txt', mem, fmt='%02X')