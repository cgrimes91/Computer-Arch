
# Created by Chris Grimes 


            .data      # data segment
	    .align 2   # align the next string on a word boundary
outpAuth:   .asciiz  "This is Chris Grimes presenting average.\n"
outpPrompt: .asciiz  "Please enter the amount of numbers you wish to average:\n"
	    .align 2   #align next prompt on a word boundary 
outpStr:    .asciiz  "\nPlease enter a 3 digit decimal d.dd: "
            .align 2   # align users input on a word boundary
Average: .asciiz    "The average is:\n "

number1: .float 0.00
#
            .text      # code section begins
            .globl	main 
main:  
#
# system call to display the author of this code
#
	 la $a0,outpAuth	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

#
# system call to prompt user for input
#
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
#
# system call to store user input
#
	li $v0,5 # user inputs the amount of inputs to be averaged
	syscall
	move $t0, $v0 # moves the amount of inputs to register t0 as an integer
	
	
# loop to take desired amount of inputs from user
#
	addi $t1, $zero, 0 # loop variable for while loop
	lwc1 $f14, number1 # preps $f3 to hold the sum of the user's input
	lwc1 $f6, number1 # puts 0 in f6
	while:
	    bge $t1,  $t0 exit # loop while register $t1 is less than desired number of inputs
	    la $a0,outpStr 	# system call 4 for print string needs address of string in $a0
	    li $v0,4		# system call 4 for print string needs 4 in $v0
	    syscall  
	    li $v0, 6 # reads float from user
	    syscall
	    add.s  $f1, $f0, $f6 # move float to f1 to prep for addition
	    add.s $f14, $f14, $f1 # adds $f1 to $f2
	    addi $t1, $t1, 1 # increments the loop variable
	    j while
	exit:
		
#
# system call to display the average
#
	
	 mtc1 $t0, $f4 # moves to number os inputs to $f3
	 cvt.s.w $f4, $f4 # converts to integer in $f3 to float
	 div.s $f5, $f14, $f4 # divides the sum of the user's inpits by the amount of user inputs
	 la $a0,Average  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall
	 li $v0, 2
	 add.s $f12, $f5, $f6 # move $f4 to $a0 for display purposes
	 syscall
	 
#exit
	li $v0 , 10 # syscall for gracefull exit
	syscall
	 
	 
	 
	 
	 
	 
	 
	 	
	 		
