.data
	DISPLAY: .space 16384
	DISPLAYWIDTH: .word 64
	DISPLAYHEIGHT: .word 64
	
	zero: .float 0.0
	step: .float 0.1
	thirty_two: .float 32,0
	minus_thirty_two: .float -32.0
	
	list: .word 0xff0000, 0xffa500,0xffff00, 0x00ff00, 0x00ffff, 0x0000ff, 0xff00ff 
	RED: .word 0xff0000 
	ORANGE: .word 0xffa500
	YELLOW: .word 0xffff00
	GREEN: .word 0x00ff00
	CYAN: .word 0x00ffff
	BLUE: .word 0x0000ff
	MAGENTA: .word 0xff00ff
	radius: .word 15
.text
	j main

set_pixel_color:
# Assume a display of width DISPLAYWIDTH and height DISPLAYHEIGHT
# Pixels are numbered from 0,0 at the top left
# a0: x-coordinate
# a1: y-coordinate
# a2: color
# address of pixel = DISPLAY + (y*DISPLAYWIDTH + x)*4
#			y rows down and x pixels across
# write color (a2) at arrayposition

	lw $t0, DISPLAYWIDTH
	mul $t0, $t0, $a1 	# y*DISPLAYWIDTH
	add $t0,$t0, $a0 	# +x
	sll $t0, $t0, 2 	# *4
	la $t1, DISPLAY 	# get address of display: DISPLAY
	add $t1, $t1, $t0	# add the calculated address of the pixel
	sw $a2, ($t1) 		# write color to that pixel
	jr $ra 			# return
	
main:
addi $t2,$zero,0
addi $t3,$zero,7		# storing 7 number for comparing with iterator
la $t4, list 			# load array with colors
add $t5, $t4,$zero		# saving address of array (pointer to the first color)
		loop:
			
						# void drawRainbow(int x, int y, int radius, int color).
			li $a0,32		# param int x
			li $a1,32		# param int y
			lw $t7, radius	 	# storing radius in t7   
			sub $a2,$t7, $t2	# decrementing radius      param int radius
			lw $a3 , 0($t5)		# param color	
			
			jal drawRainbow
			
			addi $t2,$t2, 1  	# incrementing iterator of for loop
			addi $t5,$t5,4		# increment pointer of array to the next color
			beq $t2,$t3, exit
			j loop
	
exit:
	li      $v0, 10              # terminate program run and
    	syscall                      # Exit 
	
	
	

drawRainbow:
	li $s0, 0	# xcoor
	li $s1, 0	# ycoor
	
	l.s $f3, zero  # s0
	l.s $f4, zero  # s1
	

	li $s2, 64		# width
	li $s3, 32		# height
	mul $t7, $a2, $a2 	# t7 = r*r
	
	loop1:
		l.s $f3, zero	# xcoor=0 again
	
		loop2: 
			cvt.w.s $f30, $f3
			mfc1 $s0, $f30
			
			cvt.w.s $f30, $f4
			mfc1 $s1, $f30
			
			addi $a0, $s0, 0	# a0 = xcoor	
			addi $a1, $s1, 0	# a1 = ycoor 		
			
			l.s $f29, minus_thirty_two
			
			add.s $f3, $f3, $f29
			add.s $f4, $f4, $f29
			
			mul.s $f18, $f3, $f3	# f18 = x*x
			mul.s $f19, $f4, $f4	# f19 = y*y
			add.s $f18, $f18, $f19 	# f18 = x*x + y*y
	
	
			l.s $f29, thirty_two
			
			add.s $f3,$f3,$f29
			add.s $f4,$f4,$f29
			
			cvt.w.s $f18, $f18
			mfc1 $t8, $f18
			
			
			beq $t8, $t7, color   # if x*x + y*y = r*r then color this pixel
			       
			j skipColor	      # and skip color if not equal	
			color:
			
			addi $sp,$sp,-4 #Save space in the stack for registers $s0, $s7 + $ra
      			sw   $ra,4($sp)
       			sw   $a2,0($sp) # a1 and a0 registers will stay the same but a2 will change thats why I store it in stack
       			
       			
			move $a2 , $a3		# store color from array				
			jal set_pixel_color	# color the current pixel
			
			lw $a2, 0($sp)
			lw $ra, 4($sp)
			addi $sp,$sp,4
			
			skipColor:
			
			l.s $f21, step
			add.s $f3, $f3, $f21	# increment x
			
			cvt.w.s $f22, $f3
			mfc1 $s0, $f22
			bne $s0, $s2, loop2	# loop until s0 = 64
			
			add.s $f4, $f4, $f21	# increment y
			cvt.w.s $f22, $f4
			mfc1 $s1, $f22
			bne $s1, $s3, loop1	# loop until s1 = 32
			
			jr $ra
			
			
