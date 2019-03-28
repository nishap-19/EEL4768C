.data
nameValid: .asciiz "the sum is:\n"
nameInvalid: .asciiz "Invalid entry"
.text
main:
#Get an integer N from the user
li $v0,5
syscall
move $t0,$v0

bgt $t0,100,invalid	#t0>100 branch to invalid
blt $t0, 0, invalid	#t0<0 branch to invalid

valid:		#print sum
move $s0,$0	#set incrementer value to 0
move $s1,$0	#set sum value to 0
loop:	#loop between 0 and N
beq $s0,$t0,done
add $s1,$s1,$s0 #sum=sum+i
addi $s0,$s0,1 #i=i+1
j loop #loop back
done:
add $s1,$s1,$s0 #sum=sum+i
la $a0,nameValid #load nameValid string
li $v0,4
syscall
#print the sum
li $v0,1
move $a0,$s1 #move the sum to argument register
syscall
b end

invalid:	#print error
la $a0,nameInvalid #load nameInvalid string
li $v0,4
syscall
b end

end:
li $v0,10
syscall		#exit the system