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
jal displayMessage#Calling the prompt message
li $v0, 5
syscall
move $t0, $v0	#Taking the user input and moving it to $t0

slt $t1,$t0,$zero	#Checks if $s0 > $s1
beq $t1,1,SendError 

jal displayResult	#Calling the method that prints the first line

addi $t5, $zero, 25
loop:
  #quaters
  slt $t2,$t0,$t5	# checks if $s0 > $s1

  beq $t2,1,dimesLabel

  addi $t3, $t3, 1
  subi $t0, $t0, 25
  j loop
  
dimesLabel:
#Printing the quarts
li $v0 1
add $a0 , $zero , $t3
syscall
jal displayResultQ

sub $t3, $t3, $t3
sub $t5, $t5, $t5
#li $v0 1
#add $a0 , $zero , $t0
#syscall
addi $t5, $t5, 10
loopDimes:
  #dimes
  slt $t2,$t0,$t5	# checks if $s0 > $s1

  beq $t2,1,nickelLabel

  addi $t3, $t3, 1
  subi $t0, $t0, 10
  j loopDimes
  
nickelLabel:
#Printing the dimes
li $v0 1
add $a0 , $zero , $t3
syscall
jal displayResultD

sub $t3, $t3, $t3
sub $t5, $t5, $t5
addi $t5, $t5, 5
loopNickel:
  #dimes
  slt $t2,$t0,$t5	# checks if $s0 > $s1

  beq $t2,1,pennyLabel

  addi $t3, $t3, 1
  subi $t0, $t0, 5
  j loopNickel
  
pennyLabel:
#Printing the dimes
li $v0 1
add $a0 , $zero , $t3
syscall
jal displayResultN


#Printing the pennys
li $v0 1
add $a0 , $zero , $t0
syscall
jal displayResultP



li $v0, 10
syscall

SendError:
jal displayErrorMessage

displayResult:
li $v0 1
add $a0 , $zero , $t0
syscall

li $v0, 4
la $a0, result
syscall

jr $ra

displayResultQ:
li $v0, 4
la $a0, resultQ
syscall
jr $ra

displayResultD:
li $v0, 4
la $a0, resultD
syscall
jr $ra

displayResultN:
li $v0, 4
la $a0, resultN
syscall
jr $ra

displayResultP:
li $v0, 4
la $a0, resultP
syscall
jr $ra

displayMessage:
li $v0, 4
la $a0, prompt
syscall
jr $ra

displayErrorMessage:
li $v0, 4
la $a0, errorMsg
syscall

li $v0, 10
syscall
