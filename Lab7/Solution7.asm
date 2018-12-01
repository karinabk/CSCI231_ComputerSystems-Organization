.data 

array: .space  1024
.text


#C code
#void myMemoryUpdate (int repCount, int loopSize, int arrSize, int stepSize){
#for (int index = 0; index < arrSize/loopSize; index ++) {
#	for (int repIdx=0; repIdx < repCount ; repIdx ++) {
#		for (int loopIdx = 0; loopIdx < loopSize ; loopIdx += stepSize){
# 			arrain[index] = array[index] +1
# 			arrain[index+1] = array[index+1] + 1
# 			arrain[index+2] = array[index+2] + 1
# 			arrain[index+3] = array[index+3] + 1
#		}
#	}
#}
#}

#

main:
addi $a0,$zero , 4	#number of repetitions
addi $a1 , $zero, 4     #loop size
addi $a2 , $zero, 1024  #array size int =  1024 
addi $a3 , $zero, 4 	#int step Size
jal myMemoryUpdate
li $v0, 10
syscall

myMemoryUpdate:
la $t7, array
div $t3, $a2,$a1		#t3 = arrSize/loopSize
addi $t0 , $zero, 0		#t0 = index
#la $t2, array			#t2 = address of array

loop1:
beq $t0, $t3, exit1		#while index < arrSize/loopSize
		#index++
	addi $t4,$zero,0	#loopInedx =0 = t4
		
	loop2:
	beq $t4,$a0 , exit2	#while loopIdx < repCount( 4 )
	mul $t6,$t0, $a1
	add $t2, $zero, $t7	
	add $t2,$t2,$t6
	addi $t4,$t4,1		#repIdx++
	addi $t5,$zero,0	#loopIdx =0 = t5
	
		loop3:
			beq $t5, $a1,loop2	#while loopIdx < loopSize
			add $t5,$t5,$a3		#loopIdx +=stepSize
	

			lb $t1, 0($t2)
			addi $t1,$t1,1
			sb $t1,0($t2)
			addi $t2,$t2,1
			
			lb $t1, 0($t2)
			addi $t1,$t1,1
			sb $t1,0($t2)
			addi $t2,$t2,1
			
			lb $t1, 0($t2)
			addi $t1,$t1,1
			sb $t1,0($t2)
			addi $t2,$t2,1
			
			lb $t1, 0($t2)
			addi $t1,$t1,1
			sb $t1,0($t2)
			addi $t2,$t2,1
			

			j loop3
exit2:
addi $t0,$t0,1	
j loop1
exit1:
jr $ra


#Number of blocks:  1

#Cache block size:  32 
#The reasons for my optimization:
#   1)  In Assembly code: My step size equals to 4 bytes instead of 1 byte.
#As a result I work with one word instead of 4 bytes so I read and write only once instead of four times.
#So my cache hit rate is 100%  
#   2)In the configurations of cache parameters: I used minimal amount of blocks which is 1 and cache block size is 32 because If I take larger amount 
#cache size will be higher than 128 bytes. By increasing the cache block size miss rate dicreases. Additionally, by increasing block size
#number of compulsory misses is reduced because larger amount of data is brought in the cache on each miss. 
#spatial locality makes performance better by loading data from nearby addresses not from just one.
