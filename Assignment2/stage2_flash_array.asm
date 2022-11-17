; function stage2_flash_array
; flashes the contents of array given
; Arguments:
; r0 - BASE address of peripherals
; r1 - size of array
; r2 - array to flash
; Function returns nothing

stage2_flash_array:
    ; implement your function here
    ; remember to push any registers you use to the stack before you use them
    ; ( and pop them off at the very end)

    push {r8}

    for_loop:
        ldr r8, [r2], #4
        
        push {lr, r1-r2}
            mov r1, r8
            mov r2, $50000  ; pause time between flashes r10
            bl FLASH
            mov r1, $120000 ; pause time
            bl PAUSE
        pop {lr, r1-r2}

        sub r1, #1
        cmp r1, #0
    bgt for_loop

    pop {r8}
bx lr