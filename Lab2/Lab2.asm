.data 
	Arr: .word 21,20,51,83,20,20
	len: .word 6
	x: .word 20
	y: .word 5
	nl: .asciiz "\n"
	string: .asciiz "values of array: "
	space: .asciiz " "
.text
main:
	la $s0, Arr
	lw $s1, len
	lw $s2, x
	lw $s3, y
	
	addi $a0, $s0 0
	addi $a1, $s1 0
	addi $a2, $s2 0
	addi $a3, $s3 0
	
	jal replace
	
	#li $v0,1 # print_int syscall code = 1
	#move $a0, $s0 # Load integer to print in $a0
	#syscall
	
	li $v0,4 # print_string syscall code = 4
	la $a0, nl
	syscall
	
	li $v0, 10
	syscall
	
replace: 
	addi $sp,$sp, -16
	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)
	addi $t0,$zero,0 # index =0
	
	addi $sp, $sp, -4
	sw $a0, 0($sp)
		
	addi $a0 $zero 0
	
	li $v0,4 # print_string syscall code = 4
	la $a0, string
	syscall
	
	
	lw $a0, 0($sp)
	addi $sp $sp 4

	while:
		beq $t0, $a1,exit
		lw $t1,0($a0)
		addi $t0,$t0,1
		beq $t1,$a2,br1
		addi $a0,$a0,4
		
		
		#print
		addi $sp, $sp, -4
		sw $a0, 0($sp)
		
		addi $a0 $zero 0
		
		li $v0, 1
		addi $a0 $t1 0
		syscall
		
		
		li $v0,4
		la $a0, space
		syscall
		
		lw $a0, 0($sp)
		addi $sp $sp 4
		
		
    
		
		j while
		
	br1:	sw $a3, 0($a0)
		addi $a0,$a0,4
		
		addi $sp, $sp, -4
		sw $a0, 0($sp)
		
		addi $a0 $zero 0
		
		li $v0, 1
		addi $a0 $a3 0
		syscall
		
		li $v0,4 # print_string syscall code = 4
		la $a0, space
		syscall

		lw $a0, 0($sp)
		addi $sp $sp 4 
		
		
		j while
			
	exit:
		lw $s0,0($sp)
		lw $s1,4($sp)
		lw $s2,8($sp)
		lw $s3,12($sp)
		addi $sp,$sp,16
		jr $ra
	
	
	

	
	
