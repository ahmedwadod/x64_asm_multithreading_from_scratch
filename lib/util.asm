# x64 Assembly Multithreading from Scratch
# Utilities
#
# This file contains a bunch of utilities to use instead of libstd
#
# 2023 - Ahmed Elkhalifa

.intel_syntax
.section .text

# print function that takes (ptr, len)
# as arguments (rdi, rsi)
.global print
print:
	mov %rdx, %rsi # move the length to rdx
	mov %rsi, %rdi # move the pointer to string (rdi) to rsi
	mov %rax, 0x01 # write syscall on x64 Linux
	mov %rdi, 0x01 # STDOUT file descriptor
	syscall
	ret

