.data 

array: .space  1024
.text

main:

addi $a0 , $zero, 1024 
addi $a1 , $zero, 4 
jal myMemoryUpdate
li $v0, 10
syscall

myMemoryUpdate:
addi $t0 , $zero, 0
la $t2, array

loop:
beq $t0, $a0, exit

lw $t1, 0($t2)

addi $t1,$t1, 16843009 	
sw $t1 ,0($t2)
		
add $t2,$t2 , $a1 
add $t0, $t0, $a1
j loop

exit:
jr $ra


#Number of blocks:  1

#Cache block size:  32 
#The reasons for my optimization:
#   1)  In Assembly code: My step size equals to 4 bytes instead of 1 byte, and add 16843009 which is 0x01010101. 
#As a result I work with one word instead of 4 bytes so I read and write only once instead of four times.
#So my memory access count is 512  
#   2)In the configurations of cache parameters: I used minimal amount of blocks which is 1 and cache block size is 32 because If I take larger amount 
#cache size will be higher than 128 bytes. By increasing the cache block size miss rate dicreases. Additionally, by increasing block size
#number of compulsory misses is reduced because larger amount of data is brought in the cache on each miss. 
#spatial locality makes performance better by loading data from nearby addresses not from just one.

