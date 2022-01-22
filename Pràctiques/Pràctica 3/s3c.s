	# Sessio 3

	.data 
mat:	.word 0,0,2,0,0,0
	.word 0,0,4,0,0,0
	.word 0,0,6,0,0,0
	.word 0,0,8,0,0,0

resultat: .word 0

	.text 
	.globl main
main:
	addiu $sp, $sp, -4		#Reservem espai per $ra
	sw $ra, 0($sp)

	la $a0, mat			#Preparem $a0 per cridar suma_col
	
	jal suma_col			#Cridem suma_col
	
	la $t0, resultat		#Guardem el valor retornat per suma_col a resultat
	sw $v0, 0($t0)

	lw $ra, 0($sp)			#Carreguem el $ra que haviem guardat
	addiu $sp, $sp, 4

	jr $ra				#Fi del programa

suma_col:
	move $t0, $zero			# suma = 0
	move $t1, $a0			# Preparem adreça inicial
	addiu $t1, $t1, 8

	move $t2, $zero			# i = 0
	li $t3, 4			# marca de fi 
	
for:	beq $t2, $t3, fi		# Loop
	lw $t4, 0($t1)			# Carreguem el calor en m[i][2]
	addu $t0, $t0, $t4		# Sumem el valor obringut a resultat
	addiu $t1, $t1, 24		# Sumem l'strude al nostre punter

	addiu $t2, $t2, 1		# ++i
	b for

fi:	 move $v0, $t0			# return suma
	jr $ra





