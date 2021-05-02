.global _start

.text

_start:
#mov $30,%rbx      #taking input 'a' in %rbx
#mov $8,%rcx	  #taking input 'b' in %rcx
mov %rbx,%r8	  #storing value of a,for iterating from a to 0 for finding desired answer	
mov $0,%r12	  #initializing ans=0
mov $10,%r13	  #storing 10 in %r13 for using it later in calculation of sum of digits

forloop:
mov %r8,%rdx		#the main loop which iterates from a to 0, so as to find the MAXIMUM number in this interval which satisfies given condition
mov %rbx,%rax		#looping variable in %rbx,initialized with i=a
mov $0,%rdx
div %r8			#checking if a is divisible by i
cmp $0,%rdx
je gcdcheck		#if it's divisible,one condition is satisfied, jumping to another label for evaluating second condition
sub $1,%r8		#i--
cmp $1,%r8		
jge forloop		#if i>=1,exit loop; else,go to next iteration
jmp answer

gcdcheck:
mov %r8,%r10		#checking if i(that divides a) is co-prime to b
mov %rcx,%r11		
cmp %r10,%r11
jg setpos
jmp gcdloop		#setting values in registers %r10,%r11 (i and b) such that the latter always has smaller value , for checking gcd

setpos:
mov %r11,%r14
mov %r10,%r11
mov %r14,%r10		#setting values in registers %r10,%r11 such that the latter always has smaller value , for checking gcd
			#let c=%r10, d=%r11

gcdloop:
cmp $0,%r11		#if c==0,we have the final answer stored in d.
je finalcheck
mov %r11,%rdx		
mov %r10,%rax		
mov %r11,%r10		#c=d, for next iteration
mov $0,%rdx
div %r11		
mov %rdx,%r11		#d=c%d,for next iteration
jmp gcdloop

finalcheck:
cmp $1,%r10		#checking if gcd of i and b equals 1
je finalanswer		#if yes, proceed to evaluate final answer
sub $1,%r8		#if it is not 1, go to next iteration of main loop
cmp $1,%r8
jge forloop
jmp answer

finalanswer:
cmp $0,%r8		#checking if the actual answer, i>0
jg ansloop		#if yes, continue to calculate sum of digits
jmp answer		#Otherwise, exit 

ansloop:
mov %r13,%rdx		
mov %r8,%rax
mov $0,%rdx
div %r13		# r = i%10
add %rdx,%r12		# ans = ans+r
mov %rax,%r8		# i = i/10
jmp finalanswer		#check if i>0

answer:
mov %r12,%rdx		#final required answer is stored in %rdx
jmp exit

exit:
mov $60,%rax
xor %rdi,%rdi
syscall

