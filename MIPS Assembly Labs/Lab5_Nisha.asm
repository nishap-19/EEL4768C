#Sort an array of N integers and print the sorted array. N should be greater than or equal to 10.
.data
intArray:  .word 3, 65, 6, 18, 23, 17, 45, 34, 81, 42
size:  .word 10
sorted: .asciiz "\nSorted: "
unsorted: .asciiz "Unsorted: "
space:	.asciiz " "
.text

main:
lw $a1, size		#load value of array size to $a1
la $s1, intArray	#load address of array to $s1

addi $t1, $t1, 0	#print counter set to zero
addi $t0, $t0, 1	#sortArray outer loop counter set to one
addi $t8, $t8, 10	#sortArray inner loop counter set to ten

addi $s0, $s0, 0	#uses $s0 to allow program to jump back to the sorting algorithm

li $v0, 4
la $a0, unsorted
syscall			#prints label unsorted
j print

continue:		#continue running the program, move to sort
addi $s0, $s0, 1	#increment $s0 so the program does not run after sorted

sortArray:		#outer array for sorting
la $t4, intArray	#load address of array to $t4 (first value)
la $t5, intArray	#load address of array to $t5 (first value)
addi $t5, $t5, 4	#shift $t5 to next address (second value)

swap:			#inner array for sorting
lw $t6, ($t4)		#load value at $t4 to $t6
lw $t7, ($t5)		#load value at $t5 to $t7
bgt $t6, $t7, next	#if $t6 > $t7, jump to next
sw $t6, ($t5)		#swap value at $t5 with value of $t6
sw $t7, ($t4)		#swap value at $t4 with value of $t7

next:			#prepares for next inner loop iteration
addi $t4, $t4, 4	#increments address of $t4 (first value)
addi $t5, $t5, 4	#increments address of $t5 (second value)
addi $t0, $t0, 1	#counter for inner loop
blt $t0, $a1, swap

addi $t0, $0, 1		#reset inner loop counter to 1
subi $t8, $t8, 1	#decrement counter for outer loop
bne $t8, 1, sortArray	#if size counter does not equal 1, jump to sortArray

li $v0, 4
la $a0, sorted
syscall			#prints label sorted

la $s1, intArray	#re-loads updated array into $s1
addi $t1, $0, 0		#resets print counter counter to 0

print:		#print array with spaces
li $v0, 1
lw $a0, ($s1)	#load value in array at current address
syscall
li $v0, 4
la $a0, space
syscall		#print space
addi $s1, $s1, 4	#shift address by 4 bytes
addi $t1, $t1, 1	#increment print counter
bne $t1, $a1, print	#if print counter does not equal size of array, jump back to print
beqz $s0, continue