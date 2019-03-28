#print prime numbers between a and b
.data
primeNotFound: .asciiz "No prime number exists between your inputs"
space: .asciiz " "
.text
main:
#Get the first number a
li $v0, 5
syscall
move $t0, $v0	#$t0=a
#get second number b
li $v0, 5
syscall
move $t1,$v0	#$t1=b
move $s0, $0	#set $s0=0 to show a number is prime

loop:
bgt $t0, $t1, done	#terminate loop if a > b
beq $t0, 1, increase	#if $t0 is 1, increase $t0 by 1
addi $t2, $0, 2		#$t2=0+2 which represents the incrementing value
beq $t0, 2, printOne
for:
beq $t0, $t2, prime	#if a($t0)=$t2, the number is prime
div $t0, $t2		#divide a($t0) by $t2
mfhi $s1	#move remainder from hi to $s1
beqz $s1, increase	#if the remainder is zero, increase $t0 by 1
addi $t2, $t2, 1	#increase $t2 by 1 if remainder is not zero, increases inner loop
j for
printOne:
addi $s3, $0, 1
move $a0, $s3
li $v0, 1	#print the prime number
syscall
la $a0, space
li $v0, 4	#print a space
syscall
j for
prime:
addi $s0, $0, 1		#$s0=1 so a prime number exists
move $a0, $t0
li $v0, 1	#print the prime number
syscall
la $a0, space
li $v0, 4	#print a space
syscall
increase:
addi $t0, $t0, 1	#a($t0)=a+1 to increase outer loop counter
j loop
done:
bnez $s0, end		#if $s0 is not 0, prime numbers were found
la $a0, primeNotFound	#if $s0 is 0, a prime number was not found
li $v0, 4		#print prime not found message
syscall
end: