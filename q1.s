.global _start
_start:
    LDR R0, =data // set base of A = first address of array “data”
    MOV R1, #2 // i=1
    MOV R2, #2 // j=1
    MOV R3, #1 // k=1
    BL func
END: B END // infinite loop; R0 should contain return value of func
.global func
func:
    CMP R1, R2
    BEQ equal
    // A[1] = A[0] - k
    LDR R4, [R0] 
    SUB R4, R4, R3
    STR R4, [R0, #4]
    B next_1
    
equal:
    // A[0] = A[1] + k
    LDR R4, [R0, #4] 
    ADD R4, R4, R3
    STR R4, [R0]

next_1:

    CMP R1, R3
    BLT less_ik
    ADD R4, R2, #1
    STR R4, [R0, #12]
    B done
    
less_ik:
    CMP R1, R2
    BLT less_ij
    B done

less_ij:
    MOV R4, R2
    MVN R4, R4
    ADD R4, R4, #1
    STR R4, [R0, #8]
    
done:
    ADD R0, R1, R2
    SUB R0, R0, R3
    MOV PC, LR
data:
    .word 4
    .word 1
    .word 2
    .word 1