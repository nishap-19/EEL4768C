#calculate n choose r
.data
primeNotFound: .asciiz "Invalid entries, n is less than r"
.text
main:
li $v0,5
syscall
move $s0, $v0	#$s0 stores n

li $v0,5
syscall
move $s1, $v0	#$s0 stores r

blt $s0, $s1, error	#check to see if n is less than r

#compute n!
move $a0, $s0 #pass n as an argument to factorial
jal factorial
move $t3, $v0	#save result n! into $t3

#compute r!
move $a0, $s1 #pass n as an argument to factorial
jal factorial
move $t4, $v0	#save result r! into $t3

sub $s2, $s0, $s1	#calculate n-r and set it to $s2

#compute n-r!
move $a0, $s2 #pass n as an argument to factorial
jal factorial
move $t5, $v0	#save result n! into $t3

mul $t6, $t5, $t4	#multiply (n-r)! * r!
div $t7, $t3, $t6	#divide n! by (n-r)!r!

#print the result
li $v0, 1
move $a0, $t7
syscall

#exit the program
li $v0,10
syscall

factorial:
addi $sp, $sp, -8	#allocate 8 bytes on the stack
sw $a0, 4($sp)
sw $ra, 0($sp)
addi $t0, $0, 2
slt $t0, $a0, $t0 	#is n<=1
beq $t0, $0, else
addi $v0, $0, 1		#return 1
addi $sp, $sp, 8	#deallocate space on the stack
jr $ra	#return to the calling function/main
else:
addi $a0, $a0, -1	#n=n1
jal factorial
lw $ra, 0($sp)	#read from memory, restore return address
lw $a0, 4($sp)	#restore $a0
addi $sp, $sp, 8	#deallocate space on the stack
mul $v0, $a0, $v0	#n*factorial(n-1)
jr $ra

error:	#print error when n is less than r
la $a0, primeNotFound	#if $s0 is 0, a prime number was not found
li $v0, 4		#print prime not found message
syscall
