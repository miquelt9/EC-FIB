	.data
A:  		.word 3, 5, 7
punter:  	.word 0
	.text
	.globl main
main:
	la $t0, punter 		#punter = &A[2]
	la $t1, A
	addiu $t1, $t1, 8
	sw $t1, 0($t0)
	lw $s0, 0($t1)		#temp = *punter +2
	addiu $s0, $s0, 2
	lw $t2, -8($t1)		#temp = *(punter-2) + temp
	addu, $s0, $s0, $t2
	sw $s0, -4($t1)		#A[1] = temp
	li $v0, 1		#print_integer(temp)
	move $a0, $s0
	syscall
	jr $ra
