# Programmer: Jeffrey B. Cuadros
# Project #1
# Course: CSC320, Fall 2016
# Date: 9/29/2016
# Description: This program converts cents into quarters, dimes, nickels, and pennies.

.data
prompt:	.asciiz "Enter some number of cents: \r"
result:	.asciiz " cents is equivalent to "
resultQ:	.asciiz " quarter(s), "
resultD:	.asciiz " dime(s), "
resultN:	.asciiz " nickel(s), and "
resultP:	.asciiz " penny(s).\r"
errorMsg:	.asciiz "Error! You must enter a positive number. Please try again."
.text
main:
#Displaying to message to the user
jal displayMessage

#Taking the user input and moving it to $t0
li $v0, 5
syscall
move $t0, $v0	

#Checks if $s0 > $s1
slt $t1,$t0,$zero
#if user input is less than 0 call SendError label
beq $t1,1,SendError 

#displayResult prints the user input and result String
jal displayResult	

#Creating a varible to hold 25
addi $t5, $zero, 25

#Looping to get number of quaters
loop:
  #Checks if $t0(cents) > $t5(25), if yes then it returns 0
  slt $t2,$t0,$t5	
  #If $t2 is 1 then it jumps to dimesLabel
  beq $t2,1,dimesLabel
  #Adds one to $t3 each to it loops
  #Subtracts 25 to $t0(cents) each time it loops
  addi $t3, $t3, 1
  subi $t0, $t0, 25
  #retun to top
  j loop
  
#dimeLabel (we get here if the amount of quarters are less than 25)
dimesLabel:
#Printing the number of quarters collected
li $v0 1
add $a0 , $zero , $t3
syscall
#Printing the message resultQ
jal displayResultQ

#Resetting $t3 & $t5 to 0
sub $t3, $t3, $t3
sub $t5, $t5, $t5

#Setting $t5 to 10
addi $t5, $t5, 10

#loop to get the number of dimes left 
loopDimes:
  # checks if $t0(cents) > 10
  slt $t2,$t0,$t5	
  #If $t2 is 1 then it jumps to nickelLabel
  beq $t2,1,nickelLabel
  #Adds one to $t3 each to it loops
  #Subtracts 10 to $t0(cents) each time it loops
  addi $t3, $t3, 1
  subi $t0, $t0, 10
  j loopDimes
  
nickelLabel:
#Printing the number of dimes collected
li $v0 1
add $a0 , $zero , $t3
syscall
#Print the resultD String
jal displayResultD

#Resetting values for $t3 and $t5
sub $t3, $t3, $t3
sub $t5, $t5, $t5
#setting $t5 to 5
addi $t5, $t5, 5

#looping for nickels
loopNickel:
  # checks if $t0(cents) > $t5
  slt $t2,$t0,$t5	
  #If $t2 is 1 then there only pennies left, then we jump to pennyLabel 
  beq $t2,1,pennyLabel
  #Adding one to $t3 and subtracting 5 to $t0
  addi $t3, $t3, 1
  subi $t0, $t0, 5
  #going to the top
  j loopNickel
  
#There are only pennies left, so just print the value of them.
pennyLabel:
#Printing the number of dimes
li $v0 1
add $a0 , $zero , $t3
syscall
#Printing the message resultN
jal displayResultN

#Printing the number of pennies
li $v0 1
add $a0 , $zero , $t0
syscall
#printing the resultP string
jal displayResultP

#Exit call
li $v0, 10
syscall

#Calls the displayErrorMessage display
SendError:
jal displayErrorMessage

#Print starting string and number of cents recieved
displayResult:
li $v0 1
add $a0 , $zero , $t0
syscall

li $v0, 4
la $a0, result
syscall

jr $ra

#Print string resultQ
displayResultQ:
li $v0, 4
la $a0, resultQ
syscall
jr $ra
#Print string resultD
displayResultD:
li $v0, 4
la $a0, resultD
syscall
jr $ra
#Print string resultD
displayResultN:
li $v0, 4
la $a0, resultN
syscall
jr $ra
#Print string resultP
displayResultP:
li $v0, 4
la $a0, resultP
syscall
jr $ra
#Print string resultQ
displayMessage:
li $v0, 4
la $a0, prompt
syscall
jr $ra
#Print string displayErrorMessage
displayErrorMessage:
li $v0, 4
la $a0, errorMsg
syscall

li $v0, 10
syscall
