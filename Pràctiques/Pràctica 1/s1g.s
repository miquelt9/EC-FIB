	.data
	
fib: .space 40
	
	.text
	.globl main
main:	
	li $s0, 2
	la $t1, fib
	sw $zero, 0($t1)
	li $t2, 1
	sw $t2, 4($t1)
while:	
	slti $t0, $s0, 10
	beq $t0, $zero, fi

	sll $t2, $s0, 2
	addu $t0, $t1, $t2
	lw $t2, -4($t0)
	lw $t3, -8($t0)
	addu $t2, $t2, $t3
	sw $t2, 0($t0)
	
	addiu $s0, $s0, 1
	b while
fi:
	jr $ra
