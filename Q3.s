.global _start

.text

_start:
#mov $10,%rbx		# store the value of n in %rbx
mov %rsp,%r8		# store the initial value of stack pointer in %r8, for checking later if the stack can be considered empty 
#leaq 1000(%rsp),%rcx	# store base address of input array in %rcx	
#leaq 2000(%rsp) ,%rdx	# store base address of output array in %rdx
mov %rcx,%r10		# copy value of %rcx, to %r10, for storing values in that input array for testing
mov $0,%r9		# count = 0 (counts the number of elements stored)

#movq $9,(%rcx)
#movq $12,8(%rcx)
#movq $9,16(%rcx)
#movq $12,24(%rcx)
#movq $9,32(%rcx)
#movq $12,40(%rcx)
#movq $9,48(%rcx)
#movq $12,56(%rcx)
#movq $9,64(%rcx)
#movq $12,72(%rcx)


mov %rdx,%r10		# copy value of %rdx, to %r10, for initializing values of output array to -1
mov $0,%r9		# c = 0 (counts the number of elements stored)

# say output array is output[],and output[k] , represents value in the index k,

initialize:
movq $-1,(%r10)		# output[k]=-1
add $8,%r10		# k++
add $1,%r9		# c++
cmp %rbx,%r9		# check if c<n, to repeat this process
jl initialize
		
mov $0,%r9		# i = 0
mov %rcx,%rdi		# copy base address of input array to %rdi
mov %rdx,%rbp		# copy base address of output array to %rbp

# say input array is input[],and input[k] , represents value in the index k,

mainloop:
cmp %rsp,%r8		# check if stack is empty
je pushval		# if yes, directly push input[i] into the stack (pushval procedure)
mov (%rdi),%r11		
mov (%rsp),%r12
cmp %r11,%r12		# if input[i] <= (value in top of stack) , jump to popval procedure
jge popval

setans:
cmp %rsp,%r8		# check if stack is empty
je pushval		# if yes, jump to pushval procedure
mov (%rsp),%r13		
mov %r13,(%rbp)		# if stack is not empty, do : output[i] = (value in top of stack)

pushval:
mov (%rdi),%r14		
pushq %r14		# push input[i] into the stack
add $1,%r9		# i++
add $8,%rdi		# increment pointer of input array, to access its next element
add $8,%rbp		# increment pointer of output array, to access its next element
cmp %rbx,%r9		# check if i<n
jge exit		# if not , exit
jmp mainloop		# if yes , repeat the same procedure by jumping to mainloop


popval:
popq %rax		# pop the top value from stack while: stack is not empty and input[i]<= (stack top value)
jmp mainloop		# jump to mainloop for checking the condition again

exit:			# Thus, final output array, that satisfies the required conditions, is updated, (whose base address is in %rdx) 
#mov (%rdx),%r9
#mov 8(%rdx),%r10
#mov 16(%rdx),%r11
#mov 24(%rdx),%r12
#mov 32(%rdx),%r13
#mov 40(%rdx),%r14
#mov 48(%rdx),%r15
#mov 56(%rdx),%rbx
#mov 64(%rdx),%rsi
#mov 72(%rdx),%r8
mov $60,%rax
xor %rdi,%rdi
syscall
