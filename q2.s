.global funky
funky:
    MOV R2, #0 // result = 0
    MOV R3, #-1 // top = -1
    MOV R4, #0 // next = 0
    
    loop:
    LDR R5, [R0, R4, LSL #2]
    CMP R5, #0
    BNE A_next_nonzero
    
    ADD R5, R4, #1
    LDR R6, [R0, R5, LSL #2]
    ADD R2, R6
    CMP R3, #0
    BGE top_geq_zero
    MOV R4, #-1
    B skip

    top_geq_zero:
    LDR R4, [R1, R3, LSL #2]
    SUB R3, R3, #1
    B skip

    A_next_nonzero:
    ADD R3, R3, #1
    ADD R5, R4, #2
    ADD R6, R4, #1
    LDR R7, [R0, R5, LSL #2]
    STR R7, [R1, R3, LSL #2] 
    LDR R4, [R0, R6, LSL #2]

    skip:
    CMP R4, #0
    BGE loop
    
    MOV R0, R2
    MOV PC, LR
.global _start
_start:
    LDR R0,=A
    LDR R1,=B
    BL funky
end: B end // infinite loop; R0 should contain return value of funky
A: .word 1,3,6, 1,9,12, 0,1,0, 0,2,0, 0,3,0
B: .word 0,0,0,0,0
