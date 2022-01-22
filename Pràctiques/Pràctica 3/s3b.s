	.data

	.align 2
mat1:   .space 120
mat4:   .word 2, 3, 1, 2, 4, 3
col:   .word 2

	.text
	.globl main
main:
	addiu $sp, $sp, -4		#Reservem espai per $ra
	sw $ra, 0($sp)

	la $a0, mat4			#Preparem $a0-$a2 per fer la crida a subr
	lw $a1, 8($a0)
	la $a2, col
	lw $a2, 0($a2)
	jal subr			#Cridem a subr

	la $t0, mat1			#Guradem el resultat a mat1[4][3]
	sw $v0, 108($t0)

	la $a0, mat4			#Preparem $a0-$a2 per fer la crida a subr
	li $a1, 1
	move $a2, $a1
	jal subr			#Cridem a subr
	
	la $t0, mat1			#Guardem el resultat a mat1[0][0]
	sw $v0, 0($t0)

	lw $ra, 0($sp)			#Carreguem $ra que haviem guardat prèviament
	addiu $sp, $sp, 4

	jr $ra				#Fi del programa

subr:
	la $t0, mat1			#Obtenim la direcció mat1[j][5]
	li $t1, 6
	mult $a2, $t1
	mflo $t1
	addiu $t1, $t1, 5
	sll $t1, $t1, 2
	addu $t0, $t0, $t1		#Queda guardada a $t0

	li $t1, 3			#Obtenim la direcció de x[i][j] = mat4[i][j]s
	mult $a1, $t1
	mflo $t1
	addu $t1, $t1, $a2
	sll $t1, $t1, 2
	addu $t1, $t1, $a0		#Queda gurdada a $t1

	lw $t1, 0($t1)			#Movem el contingut de x[i][j] a mat1[j][5]
	sw $t1, 0($t0)		
	
	move $v0, $a1			# return i

	jr $ra				#Fi de la subrutina



