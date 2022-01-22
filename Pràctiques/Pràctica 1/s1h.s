	.data
cadena:	.byte -1, -1, -1, -1, -1, -1 
	.align 2
vec:	.word 5, 6, 8, 9, 1
	.text
	.globl main
main:
	li $s0, 0
while:
	li $t0,5
	bge $s0, $t0, fi

	la $t1, cadena
	la $t2, vec
	sll $t3, $s0, 2
	subu $t2, $t2, $t3
	lw $t3, 16($t2)	
	addiu $t3, $t3, 0x30
	addu $t1, $t1, $s0
	sb $t3, 0($t1)

	addiu $s0, $s0, 1
	b while

	la $t0, cadena
	sb $zero, 5($t0)

	li $v0, 4
	move $a0, $t0
	syscall
fi:
	jr $ra
