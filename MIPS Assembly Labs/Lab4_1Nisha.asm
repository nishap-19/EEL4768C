#Calculate n choose r
.text
main:
#Get n value
li $v0, 5
syscall
move $t0, $v0	#n=$t0
#Get r value
li $v0, 5
syscall
move $t1, $v0	#r=$t1

sub $t2, $t0, $t1	#n-r=$t2
move $s0, $t0		#set $s0 to n value
move $s1, $0		#set $s1 to 0 to hold sum value
move $s2, $0		#checks to see which factorial is calculated

factloop:
beq $s0, $1, one	#if $s0 equals 1, break
mul $s1, $s1, $s0	#$s1=$s1*$s0, where $s1 holds sum of factorial
sub $s0, $s0, 1		#decrements $s0 by 1
j factloop
one:
addi $s2, $s2, 1

beq $s2, 1, doneN
beq $s2, 2, doneNMR
j doneR

doneN:
move $t0, $s1	#set sum of n! to $t0
move $s0, $t2	#set $s0 to hold n-r value
move $s1, $0	#reset sum value to 0
j factloop
doneNMR:
move $t2, $s1	#set sum of (n-r)! to $t1
move $s0, $t1	#set $s0 to hold r value
move $s1, $0	#reset sum value to 0
j factloop
doneR:
move $t1, $s1	#set sum of r! to $t2

mul $t3, $t1, $t2
div $t4, $t0, $t3

li $v0, 1
add $a0, $t4, $0
syscall