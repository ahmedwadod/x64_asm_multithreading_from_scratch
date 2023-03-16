# x64 Assembly Multithreading from Scratch
# This fil contains the definition of the basic functions:
# 	'thread_run'
# 	'thread_wait'
#
# 2023 - Ahmed Elkhalifa

.intel_syntax
.section .text

# thread_run
# A function to start running the given code on a child process
#
# Arguments:
# 	rax: Pointer to function(label)
# 	rdi, rsi, rdx, rcx, r8 : The arguments to the function
#
# Returns:
# 	rax: Child process id
#
.global thread_run
thread_run:
	push %rax # Push rax value to the stack

	# Fork this process
	mov %rax, 0x39
	syscall
	
	cmp %rax, 0x00 # Compare the returned PID
	mov %r10, %rax # Store the PID in r10 temporarily
	pop %rax # Get back rax value (Function pointer)
	je _invoke # Jump if this is the child process

	# If this is the parent process then return 
	mov %rax, %r10 # Restore the PID
	ret

_invoke:
	# Jump to the pointer of the function
	call %rax

	# Safe exit
	mov %rax, 0x3c
	mov %rdi, 0x00
	syscall

# thread_wait
# Wait for a process to exit
#
# Arguments: 
# 	rax: Process PID
#
# Returns:
# 	rax: Exit code
#
.global thread_wait
thread_wait:
	# Allocate space in the stack to store the exit code
	sub %rsp, 4
	
	mov %rdi, %rax # Move the PID to %rdi for wait4 syscall
	mov %rax, 0x3d # wait4 syscall
	mov %rsi, %rsp # Pointer to the exit code space
	mov %rdx, 0x00 # Flags
	mov %r10, 0x00 # NULL pointer
	syscall

	# Store the exit code in EAX (4 byte value of rax)
	mov %eax, [%rsp]
	add %rsp, 4

	ret


