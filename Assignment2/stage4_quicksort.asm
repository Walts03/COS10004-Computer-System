; function stage4_quicksort
; sorts given array using the sorting algorithm quicksort
; Arguments:
; r0 - size of array
; r1 - array to flash
; r2 - BASE address of peripherals

stage4_quicksort:
        ; implement your function here
        ; remember to push any registers you use to the stack before you use them
        ; ( and pop them off at the very end)

        ; your function must mov the address of the sorted array to r0

push {r8-r9}
mov r8, #0
sub r9, r0, #1
push {lr, r0-r2}
bl qsort
pop {lr, r0-r2}

push {lr, r0-r2}
mov r8, r2
mov r9, r1
mov r1, r0
mov r0, r8
mov r2, r9
bl stage2_flash_array
 pop {lr, r0-r2}

    pop {r8-r9}
bx lr

qsort:
cmp r8, r9
bxge lr

push {r10}
push {lr, r0-r2, r8-r9}
bl parti
pop {lr, r0-r2, r8-r9}
push {lr, r8-r10}
sub r9, r10, #1
bl qsort
pop {lr, r8-r10}

push {lr, r8-r10}
add r8, r10, #1
bl qsort
pop {lr, r8-r10}

    pop {r10}
bx lr

parti:
push {r4-r7}
ldr r5, [r1, r9, lsl #2]
sub r4, r8, #1

lowhigh:
ldr r6, [r1, r8, lsl #2]
cmp r6, r5
bgt smallerswap
add r4, #1
ldr r7, [r1, r4, lsl #2]
str r7, [r1, r8, lsl #2]
str r6, [r1, r4, lsl #2]

smallerswap:
add r8, #1
cmp r8, r9
blt lowhigh
add r4, #1
ldr r7, [r1, r4, lsl #2]
str r7, [r1, r9, lsl #2]
str r5, [r1, r4, lsl #2]
mov r10, r4

    pop {r4-r7}
bx lr