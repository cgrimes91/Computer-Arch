# Starter code for threeTimes.asm
# Put in comments your name and date please.  You will be
# revising this code.
#
# Chris Grimes
# 9/24/19
# 
# This code displays the authors name (you must change
# outpAuth to display YourFirstName and YourLastName".
#
# The code then prompts the user for 3 integer values.
# The code outputs the summation of these 3 values multiplied by 3.
#
# In MARS, make certain in "Settings" to check
# "popup dialog for input syscalls 5,6,7,8,12"
#
            .data      # data segment
	    .align 2   # align the next string on a word boundary
outpAuth:   .asciiz  "This is Chris Grimes presenting threeTimes.\n"
outpPrompt: .asciiz  "Please enter an integer: "
	    .align 2   #align next prompt on a word boundary
outpStr:    .asciiz  "The sum of your numbers multiplied by 3 is: "
            .align 2   # align users input on a word boundary
#
# main begins
            .text      # code section begins
            .globl	main 
main:  
###############################################################
# system call to display the author of this code
	 la $a0,outpAuth	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
#
# system call to prompt user for input
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
###############################################################
# write a system call to read the user's integer value
	 li $v0,5		# wait for user to enter the first integer
	 syscall
	 
	 move $t0, $v0		# move the user's first input to register t0
	 
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall
	 
	 li $v0,5		# wait for the user to enter the second integer
	 syscall
	 
	 move $t1, $v0		# move the user's second input to t1
	 
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall
	 
	 li $v0,5		# wait for the user to enter the third integer
	 syscall
	 
	 move $t2, $v0		# move the user's third input to t2

# We have not studied looping, so you will need to repeat the prompt for input
# and do the calculation as you see fit
	 add $t3, $t0, $t1		# adds the user's first two input together and puts them in t3
	 add $t4, $t3, $t2		# adds the users third input to the first two and saves the result in t4
	 add $t5, $t4, $t4		# adds the value in t4 to itself; effectivly multipling by 2; and saves the result in t5
	 add $t5, $t5, $t4		# adds the value from t4 to t5; finishing the times 3; and stores the result in t5
	 
	 

#
# system call to display "The sum of your numbers multiplied by 3 is: "
	 la $a0,outpStr 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
################################################################
# write a system call to display the calculation
	 li $v0,1		# syscall to display an integer
	 move $a0, $t5		# moves the value stored in t5 to a0 for display purposes
	 syscall

#
# Exit gracefully
         li   $v0, 10       # system call for exit
         syscall            # close file
###############################################################
