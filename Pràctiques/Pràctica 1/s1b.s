# PRACTICA 1 #######################

	.data
aa:  .byte -5
bb:  .half -344  
cc:  .dword -3
dd:  .byte 0xA0
ee:  .word 5799
ff:  .half -1

	.text
	.globl main
main:
	la $s3, aa        #la
	li $s4, 65535     #li 1
	li $s5, 65536	  #li 2
	move $s0, $s1	  #move

	jr $ra		# main retorna al codi de startup

