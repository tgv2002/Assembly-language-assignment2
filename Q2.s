.global _start

.text

_start:
mov $1,%r8	#initializing three varaibles a,b,c for calculation of fibonacci numbers. Here a is in %r8, a=1
mov $1,%r9	#b is in %r9, b=1
mov $2,%r10	#c is in %r10, c=2
#mov $5,%rbx	#value n in %rbx
#mov $13,%rcx	#value k in %rcx
mov $0,%r11	# ans = 0
call fibon
jmp answer

fibon:
cmp %r9,%rbx		# check if b<=n
jl goToExit			# if not, exit
mov %r9,%rdi		# move b as argument to 'factorial' procedure, to evaluate b factorial 
call factorial
add %rax,%r11		# add value returned by 'factorial' procedure, say value, to ans.
mov %r11,%rax		
mov $0,%rdx
div %rcx	
mov %rdx,%r11		# ans = ans%k
mov %r9,%r8		# a = b
mov %r10,%r9		# b = c
mov %r8,%r12
add %r9,%r12
mov %r12,%r10		# c = a+b
jmp fibon		# repeat process until b becomes greater than n

factorial:
mov $1,%rbp	# initialize variable val = 1
mov $1,%r13	# initialize variable i = 1 

loop:
imul %r13,%rbp		# val = val*i
mov %rbp,%rax
mov $0,%rdx
div %rcx		
mov %rdx,%rbp		# val = val%k, (to avoid overflow) 
add $1,%r13		# i++
cmp %r13,%rdi		# checking if i<=n
jge loop		# if yes, repeat the same process again

endloop:
mov %rbp,%rax		# exit the function, by returning val , to where it was called
ret

goToExit:
ret

answer:
mov %r11,%rdx
jmp exit

exit:
mov $60,%rax
xor %rdi,%rdi
syscall
