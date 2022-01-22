	.data	
V1:     .space  64
M:      .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
V2:     .word   -5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10

	.text
	.globl main
main:
        move    $t0, $zero			# set k = 0
        li      $t1, 4				# nº of k iterations
for_k:	
	bge $t0, $t1, end_k
	move $t3, $zero				# set i = 0
	li $t2, 16				# nº of i iterations
for_i:
	bge $t3, $t2, end_i
	move $t5 $zero				# set temp = 0
	move $t6, $zero				# set j = 0
for_j:
	bge $t6, $t1, end_j			# notice that nº of j iterations = nº k iterations
	sll $t7, $t0, 2				# Getting [4*k + j]
	addu $t7, $t6, $t7
	
	la $s0, M
	sll $s2, $t3, 4				# Getting [i] (which is a row of a 16 lenght vector with 16 rows)
	addu $s2, $s2, $t7			# Getting [i][4*k + j]
	sll $s2, $s2, 2				# We are looking for an int
	addu $s0, $s0, $s2			# Got: M[i][4*k + j]
	lw $s0, 0($s0)				# Load int
	
	la $s1, V2			
	sll $s3, $t7, 2
	addu $s1, $s3, $s1
	lw $s1, 0($s1)
	mult $s0, $s1
	mflo $s0
	addu $t5, $t5, $s0
	
	addiu $t6, $t6, 1
	b for_j
end_j:
	la $s4, V1
	sll $s5, $t3, 2
	addu $s4, $s5, $s4
	lw $s6, 0($s4)
	addu $s6, $s6, $t5
	sw $s6, 0($s4)
	addiu $t3, $t3, 1
	b for_i
end_i:
	addiu $t0, $t0, 1
	b for_k
end_k:
	jr	$ra


