
# This code works fine in QtSpim simulator

.data
    strIn: .space 6
    str1:  .asciiz "\nEnter string\n"
    finish: .byte '-'
    str2:  .asciiz "\nReverse:\n"
    newLine: .byte '\n'

.text

loop:
    la $a0, str1    # Load and print string asking for string
    li $v0, 4
    syscall
			
    li $v0, 8       # take in input
    la $a0, strIn  # load byte space into address
    li $a1, 6      
    move $t0 $a0   # save string to t0
    syscall
    
    lb $t1, finish
    lb $t7 , 0($t0)
    beq $t1, $t7, exit
    bne $t1, $t7, reverse 
    
    
exit:
    li $v0, 10
    syscall
    
reverse: 
	lb $t2, 4($t0)   #save last char
	lb $t3, 0($t0) # save fisrt char
	
	sb $t2, 0($t0) # putting last char into first place
	sb $t3, 4($t0) # putting first char into last place
	
	lb $t2, 3($t0)
	lb $t3, 1($t0)
	
	sb $t2, 1($t0)
	sb $t3, 3($t0)   
        
        la $a0, str2    # prints: "Reverse: "
        li $v0, 4
        syscall
     			 			
	li $v0,4       
	move $a0, $t0
        syscall 
        
	j loop
