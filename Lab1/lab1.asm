.data 
	fib: .word 0 1
.text
	la $s0,fib
	lw $t0, 0($s0)
	lw $t1, 4($s0)
	add $s1, $t0,$t1
	sw $s1, 8($s0)
	add $t0,$t1 , $s1
	sw $t0, 12($s0)
	add $t1, $t0,$s1
	sw $t1 , 16($s0)
	add $t3, $t1,$t0
	sw $t3, 20($s0)
	add $t4,$t3, $t1
	sw $t4, 24($s0)
	 
