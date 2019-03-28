#Sort an array of N integers and print the sorted array. N should be greater than or equal to 10.
.data
intArray:  .word 3, 65, 6, 18, 23, 17, 45, 34, 81, 42
size:  .word 10
sorted: .asciiz "Sorted: "
unsorted: .asciiz "Unsorted: "
space:	.asciiz " "
.text
main:
lw $a1, size
la $s1, intArray
li $t1, 0	#loop counter set to zero

addi $s0, $s0, 0
j print

continue:
addi $s0, $s0, 1

sorting: #descending order
beq $t2, 9, continueSort	#go to continue sort if t2=9
lw $t3, 0($s1)
lw $t4, 4($s1)
addi $s1, $s1, 4	#move array position
addi $t2, $t2, 1	#for(t2=0;t2!=9;t2++)
bge $t3, $t4, sorting	#if t3>t4, go to sorting
sw $t3, 0($s1)		#swap positions
sw $t4, -4($s1)
bne $t2, 9, sorting

continueSort:	#continue sorting with the next pair of numbers
la $s1, intArray
addi $t1, $t1, 1
addi $t2, $t1, 0
bne $t1, 9, sorting

sub $t1, $t1, $t1	#reset $t1 to 0

print:
li $v0, 1
lw $a0, 0($s1)
syscall
li $v0, 4
la $a0, space
syscall
addi $s1, $s1, 4
addi $t1, $t1, 1
bne $t1, $a1, print
beqz $s0, continue