;Kshitij Agarwal;
;G00980156

	AREA mydata,DATA
output space 16					;Maximum number of queens possible
queenNum dcd 4					;Current number of queens

	AREA mycode,CODE
	THUMB
	EXPORT __main
	

__main
	ldr r1, = output			;Stack of queens
	;ldr r2, = queenNum 			;Number of queens
	;ldr r2, [r2,#0]
	mov r2, #4
	
	mov r0, #0; keeps track of the possible solutions
	mov r3, #0; keeps track of current queen
	mov r4, #0; keeps track of current queen attack position
	
	mov r5, #0; keeps track of temp queen
	mov r6, #0; keeps track of temp queen position
	
	push {r1}
	
setQueens; Sets all the initial values to 0
	str r4, [r1, r3]
	add r3, r3, #1
	cmp r3, r2
	beq start
	b setQueens
	
start
	mov r3, #0
	
colLoopStart
	mov r5, r3
	sub r5, r5, #1
	ldr r4, [r1,r3]
	
checkCol
	cmp r5, #0
	blt rightLoopStart
	ldr r6, [r1,r5]
	cmp r6, r4
	beq reset
	sub r5, r5, #1
	b checkCol
	
rightLoopStart
	mov r5, r3
	sub r5, r5, #1
	add r4, r4, #1
	
checkRight
	cmp r5, #0
	blt leftLoopStart
	cmp r4, r2
	beq leftLoopStart
	ldr r6, [r1,r5]
	cmp r6, r4
	beq reset
	sub r5, r5, #1
	add r4, r4, #1
	b checkRight
	
leftLoopStart
	mov r5, r3
	sub r5, r5, #1
	ldr r4, [r1,r3]
	sub r4, r4, #1

checkLeft
	cmp r5, #0
	blt nextQueen
	cmp r4, #0
	blt nextQueen
	ldr r6, [r1,r5]
	cmp r6, r4
	beq reset
	sub r5, r5, #1
	sub r4, r4, #1
	b checkLeft

nextQueen
	add r3, r3, #1
	cmp r3, r2
	beq solution
	b colLoopStart

solution
	add r0, r0, #1
	sub r3, r3, #1
	b reset

reset
	ldr r4, [r1,r3]
	add r4, r4, #1
	cmp r4, r2
	beq goBack
	str r4, [r1,r3]
	b colLoopStart

goBack
	cmp r3, #0
	beq exit
	mov r4, #0
	str r4, [r1,r3]
	sub r3, r3, #1
	b reset

exit
	pop {r1}
	b exit
	END
	