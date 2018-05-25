	.file	"daxpy.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Formato: %s <N> \n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"T(s) %11.9f \t / y[0]=%5.3f / y[%d]=%5.3f\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB5:
	.section	.text.startup,"ax",@progbits
.LHOTB5:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB38:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	jne	.L17
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	$300000000, %r12d
	call	strtol
	cmpl	$300000000, %eax
	cmovle	%eax, %r12d
	testl	%r12d, %r12d
	jle	.L3
	leal	-1(%r12), %ebx
	movsd	.LC1(%rip), %xmm1
	xorl	%eax, %eax
	movq	%rbx, %rbp
	addq	$1, %rbx
	.p2align 4,,10
	.p2align 3
.L4:
	pxor	%xmm0, %xmm0
	pxor	%xmm3, %xmm3
	cvtsi2sd	%eax, %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm3
	movss	%xmm3, x(,%rax,4)
	addq	$1, %rax
	cmpq	%rax, %rbx
	jne	.L4
	movq	%rsp, %rsi
	xorl	%edi, %edi
	salq	$2, %rbx
	call	clock_gettime
	movsd	.LC2(%rip), %xmm2
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L6:
	pxor	%xmm0, %xmm0
	addq	$4, %rax
	pxor	%xmm1, %xmm1
	pxor	%xmm4, %xmm4
	cvtss2sd	x-4(%rax), %xmm0
	cvtss2sd	y-4(%rax), %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm4
	movss	%xmm4, y-4(%rax)
	cmpq	%rax, %rbx
	jne	.L6
.L7:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	movslq	%ebp, %rbp
	call	clock_gettime
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	movl	%r12d, %edx
	pxor	%xmm0, %xmm0
	movl	$.LC4, %esi
	pxor	%xmm2, %xmm2
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	16(%rsp), %rax
	subq	(%rsp), %rax
	cvtss2sd	y(,%rbp,4), %xmm2
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC3(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movl	$3, %eax
	addsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtss2sd	y(%rip), %xmm1
	call	__printf_chk
	xorl	%eax, %eax
	movq	40(%rsp), %rcx
	xorq	%fs:40, %rcx
	jne	.L18
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L3:
	.cfi_restore_state
	movq	%rsp, %rsi
	xorl	%edi, %edi
	leal	-1(%r12), %ebp
	call	clock_gettime
	jmp	.L7
.L17:
	movq	(%rsi), %rdx
	movl	$1, %edi
	movl	$.LC0, %esi
	call	__printf_chk
	orl	$-1, %edi
	call	exit
.L18:
	call	__stack_chk_fail
	.cfi_endproc
.LFE38:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE5:
	.section	.text.startup
.LHOTE5:
	.comm	y,1200000000,32
	.comm	x,1200000000,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	2576980378
	.long	1069128089
	.align 8
.LC2:
	.long	0
	.long	1073217536
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
