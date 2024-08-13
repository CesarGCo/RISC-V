addi x2, x0, 7
sw x2, 4(x0)
lw x1, 4(x0)
add x2, x1, x0
add x1, x1, x2
add x1, x1, x2
bne x1, x2, 3
add x8, x1, x1
sw x1, 0(x0)
sll x1, x1, x2
xor x31, x1, x2
sw x1, 0(x0)

