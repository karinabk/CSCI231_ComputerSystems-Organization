.data 
x:  .double  45
pi: .double 3.142
degr: .double 180
one: .double 1
mone: .double -1
zero: .double 0

.text
rad:

 	l.d $f4,x
 	l.d $f6 , pi
 	l.d $f8, degr
 	mul.d $f4,$f4,$f6
 	div.d $f4,$f4,$f8 # $f4 = rad
 my_sin:
 	l.d $f20,zero
 	add.d $f28,$f20,$f20 # answer = 0
 	addi $t0,$zero,0 # iterator i = 0
 	addi $t1, $zero, 11 # when exit
 	
 loop1:
 	beq $t0, $t1 , exit1
 	
 	l.d $f22, one
 	add.d $f6,$f22 , $f20 # temp = 1
 	add.d $f8,$f22 , $f20 # fact = 1
 	
 	
 	
 	addi $t2,$zero, 2 # for checking even or odd
 	div $t0, $t2
 	mfhi $t6
 	beq $t6,$zero, contin
 	
 	l.d $f24, mone # =  -1
 	
 	mul.d $f6,$f6,$f24 # temp
 contin: 
 	
 	addi $t3,$zero, 1 # k = 1 
 	sll $t4 , $t0, 1 # 2* i 
 	addi $t4,$t4,2 # 2*i +1 <=2*i +2  when break  
 loop2: 
 	beq $t3 , $t4, exit2
 	mul.d $f6 , $f6, $f4 # temp *= rad 
 	addi $t3,$t3,1 # increment k
 	
 	j loop2
 	
 	
 exit2:
 
 	addi $t5,$zero, 1 # iterator f = 1
 loop3:
 	beq $t5, $t4 , exit3
 	
 	mtc1.d $t5, $f26
  	cvt.d.w $f26, $f26	#convert from int to double
  	
 	mul.d $f8, $f8 , $f26  # fact*= f
 	
 	addi $t5,$t5,1 # invrement f
 	
 	j loop3
 exit3:
 
 	div.d $f6,$f6,$f8 # temp = temp/ fact

 	add.d $f28,$f28, $f6
 	addi $t0,$t0,1 #increment i
 	j loop1
 	
 exit1:
 
 	li $v0, 3
	mov.d $f12, $f28
	syscall

 
 	  	
