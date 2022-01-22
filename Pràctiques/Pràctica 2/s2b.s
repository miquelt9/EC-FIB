	.data
result: .word 0
num:	.byte ';'

	.text
	.globl main
main:
	la $t0, num
	lb $t0, 0($t0)
	la $t1, result

	li $t2, 'a'
	blt $t0, $t2, or_if
	li $t2, 'z'
	ble $t0, $t2, fi 	 #((num >= ’a’) && (num <= ’z’)) is true
or_if:
	li $t2, 'A'
	blt $t0, $t2, else_if 
	li $t2, 'Z'
	ble $t0, $t2, fi	 #((num >= ’A’) && (num <= ’Z’)) is true
else_if:
	li $t2, '0'
	blt $t0, $t2, else
	li $t2, '9'
	bgt $t0, $t2, else	 #((num >= ’0’) && (num <= ’ 9’)) is true
	addiu $t0, $t0, -48      # Note: 48 == '0'
	b fi
else:
	li $t0, -1
fi:
	sw $t0, 0($t1)
	jr $ra

