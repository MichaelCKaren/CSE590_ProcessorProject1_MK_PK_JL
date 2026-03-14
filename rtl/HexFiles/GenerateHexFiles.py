import numpy as np

mem = np.int16(np.zeros(16))
for i in range(mem.shape[0]):
    #mem[i] = (i+1)*2048*(pow(-1,i))
    #mem[i] = ((i+1)*8)-1
    mem[i] = (i+1)*2
    #mem[i] = 0 # ALL ZEROS

print(mem)
np.savetxt('SW_TEST_REG.txt', mem, fmt='%04X', delimiter=' ')