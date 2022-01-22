	.data
signe:		.word 0
exponent:	.word 0
mantissa:	.word 0
cfixa:		.word 0x0080000F		#0x87D18A00
cflotant:	.float 0.0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$t0, cfixa
	lw	$a0, 0($t0)
	la	$a1, signe
	la	$a2, exponent
	la	$a3, mantissa
	jal	descompon

	la	$a0, signe
	lw	$a0,0($a0)
	la	$a1, exponent
	lw	$a1,0($a1)
	la	$a2, mantissa
	lw	$a2,0($a2)
	jal	compon

	la	$t0, cflotant
	swc1	$f0, 0($t0)

	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra


descompon:
	slt $t0, $a0, $0		# Si és negatiu val 1, sinó 0
	sw $t0, 0($a1)			# Guardem el signe resultant
	sll $a0, $a0, 1			# Eliminem el signe
	
	bne $a0, $0, else
	li $t0, 0			# El número és un 0
	b end

else:	li $t0, 18
	
while: 	blt $a0, $0, fi_while
	sll $a0, $a0, 1
	addiu $t0, $t0, -1
	b while
	
fi_while:  sra $a0, $a0, 8		# Alinear i eliminar el bit ocult
	li $t1, 0x7FFFFF
	and $a0, $a0, $t1
	addiu $t0, $t0, 127		# Codificar en excés a 127
	
end:	sw $t0, 0($a2)			# Guardem l'exponent resultant
	sw $a0, 0($a3)			# Guardem la mantissa resultant
	
	jr $ra
	
compon:
	
	sll $a0, $a0, 31		# Desplaçem 31 bits el signe
	sll $a1, $a1, 23		# Desplaçem 23 bits l'exponent
	or $v0, $a0, $a1		# Obtenim el resultat a $v0
	or $v0, $v0, $a2
	
	mtc1 $v0, $f0			# Guardem el resultat al coprocessador
	jr $ra
