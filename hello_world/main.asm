# x64 Assembly Multithreading from Scratch
# Hello World Example.
#
# This program will print to standard output from
# two processes (parent and child) different messages.
#
# This example makes use of the 'fork' system call on
# x64 Linux systems. It will fork the main (parent)
# process and check for the return of 'fork' syscall to
# determine if the current process is the parent or the 
# child and jump accordingly.
#
# 2023 - Ahmed Elkhalifa.

.intel_syntax
.global _start
.section .text

.extern print # Use our print function

_start:
	# Call the 'fork' syscall
	mov %rax, 0x39 # fork syscall on x64 Linux
	syscall
	cmp %rax, 0 # 'fork' will return 0 to the child process
	je _child

_parent:
	# Print 'Hello from parent!'
	lea %rdi, [%rip + msg1]
	mov %rsi, OFFSET msg1len
	call print
	jmp _exit

_child:
	# Print 'Hello from child!'
	lea %rdi, [%rip + msg2]
	mov %rsi, OFFSET msg2len
	call print

_exit:
	# Call the 'exit' syscall
	mov %rax, 0x3c # exit syscall on x64 Linux
	mov %rdi, 0x0 # Exit code
	syscall

.section .data
msg1:
	.ascii "Hello from parent!\n"
	msg1len = . - msg1
msg2:
	.ascii "Hello from child!\n"
	msg2len = . - msg2
	
