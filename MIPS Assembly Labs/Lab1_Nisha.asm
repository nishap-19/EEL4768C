#print larger of two numbers
.text
main:
#Get the first number
li $v0,5
syscall
move $t0,$v0
#get second number
li $v0,5
syscall
move $t1,$v0
#compare the first two numbers
bgt $t0,$t1,larger #if statement
#t0>t1 branch to larger
move $t2,$t1 #print b -> else false sttement
b endif
larger:
move $t2,$t0 #print a -> if true statment
endif:

#Get the third number
li $v0,5
syscall
move $t3,$v0
#compare the larger value of the first two values with the third value
bgt $t2,$t3,largest
#t2>t3 branch to largest
move $t4,$t3 #print c -> else false statement
b endif2
largest:
move $t4,$t2 #print larger a,b -> if statement
endif2:

move $a0,$t4 #argument for syscall print
li $v0,1 #print the result
syscall
#exit the program
li $v0,10
syscall
