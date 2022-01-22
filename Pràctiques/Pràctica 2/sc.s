# (c) FIBerHub, https://fiberhub.tk
# Pràctica 2 - Activitat 2.C

	  .data

w:        .asciiz "8754830094826456674949263746929"
resultat: .byte 0

	  .text
	  .globl main
	
main:
	addiu	$sp, $sp, -4		# Inici main
	sw	$ra, 0($sp)
	la	$a0, w			# Preparem paràmetres
	li	$a1, 31
	jal	moda			# Cridem funció moda
	la	$s0, resultat		
	sb	$v0, 0($s0)		# Guardem el valor que retorna moda a resultat
	move	$a0, $v0		
	li	$v0, 11
	syscall				# Imprimim moda per pantalla
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr 	$ra			# Fi del programa

nofares:
	li	$t0, 0x12345678		# Inici nofares
	move	$t1, $t0
	move	$t2, $t0
	move	$t3, $t0
	move	$t4, $t0
	move 	$t5, $t0
	move	$t6, $t0
	move 	$t7, $t0
	move 	$t8, $t0
	move 	$t9, $t0
	move	$a0, $t0
	move	$a1, $t0
	move	$a2, $t0
	move	$a3, $t0
	jr	$ra			# Fi nofares


moda:
	addiu $sp, $sp, -60		# Inici moda
	sw $s0, 40($sp)			# Reservem espai, 40 per histo[], 20 per $s0-$s3 + $ra
	sw $s1, 44($sp)
	sw $s2, 48($sp)
	sw $s3, 52($sp)
	sw $ra, 56($sp)

	li $t0, 0			# Loop de 10 iteracions
	li $t1, 10
	move $t2, $sp			# Adreça inici de histo[]
for:	beq $t0, $t1, fi		# Iniciem tots els valors de histp[] a 0
	sw $zero, 0($t2)
	addi $t2, $t2, 4
	addi $t0, $t0, 1
	b for

fi:	move $s0, $a0			# Guardem els paràmetres en reg segurs per si de cas
	move $s1, $a1
	li $s2, 0			# També fiquem $s2 (k en el for) i $s3 (max = '0')
	li $s3, '0'
	

for_2:	bge $s2, $s1, fi_2		# Comprovem si es dona la condició de fi del for
	
	move $a0, $sp			# Preparem els arguments per cridar update
	add $t0, $s0, $s2
	lb $t0, 0($t0)
	addiu $a1, $t0, -48		# Nota: '0' == 48 (en decimal)
	addiu $a2, $s3, -48
	
	jal	update
	
	addiu $s3, $v0, '0'		# max += update(...)
	addiu $s2, $s2, 1
	b for_2

fi_2:	move $v0, $s3

	lw $s0, 40($sp)
	lw $s1, 44($sp)
	lw $s2, 48($sp)
	lw $s3, 52($sp)
	lw $ra, 56($sp)
	addiu	$sp, $sp, 60
	jr 	$ra


update:
	addiu	$sp, $sp, -16		# Inici update
	sw $s0, 0($sp)			# Reservem espai, 16 per $s0-$s2 (necessaris per guardar
	sw $s1, 4($sp)			# els paràmetres abans de cridar nofares +  4 de $ra
	sw $s2, 8($sp)
	sw $ra, 12($sp)
	
	move $s0, $a0			# Movem els arguments a registres segurs
	move $s1, $a1
	move $s2, $a2

	jal nofares
	
	sll $t0, $s1, 2			
	addu $t0, $s0, $t0		# Obtenim adreça h[i] a $t0
	lw $t1, 0($t0)			# $t1 = h[i]
	addiu $t1, $t1, 1		# $t1 += 1
	sw $t1, 0($t0)			# h[i] = $t1

	sll $t0, $s2, 2			
	addu $t0, $s0, $t0
	lw $t0, 0($t0)			# Carreguem h[imax] a $t0
	
	ble $t1, $t0, else
	move $v0, $s1			# return i
	b fi_3
	
else:	move $v0, $s2			# return imax

fi_3:	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addiu	$sp, $sp, 16
	jr $ra
