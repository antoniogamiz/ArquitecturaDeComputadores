	.file	"daxpy.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Formato: %s <N> \n"
.LC4:
	.string	"T(s) %11.9f \t / y[0]=%5.3f / y[%d]=%5.3f\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB5:
	.section	.text.startup,"ax",@progbits
.LHOTB5:
	.globl	main
	.type	main, @function
main:
.LFB20:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$48, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	je	.L2
	movq	(%rsi), %rdx
	movl	$1, %edi
	movl	$.LC0, %esi
	call	__printf_chk
	orl	$-1, %edi
	call	exit
.L2:
	movq	8(%rsi), %rdi
	movl	$300000000, %ebx
	call	atoi
	movsd	.LC1(%rip), %xmm1
	cmpl	$300000000, %eax
	cmovle	%eax, %ebx
	xorl	%eax, %eax
.L3:
	cmpl	%ebx, %eax
	jge	.L10
	cvtsi2sd	%eax, %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm3
	movss	%xmm3, x(,%rax,4)
	incq	%rax
	jmp	.L3
.L10:
	leaq	8(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movsd	.LC2(%rip), %xmm2
	xorl	%eax, %eax
.L5:
	cmpl	%eax, %ebx
	jle	.L11
	cvtss2sd	x(,%rax,4), %xmm0
	cvtss2sd	y(,%rax,4), %xmm1
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm4
	movss	%xmm4, y(,%rax,4)
	incq	%rax
	jmp	.L5
.L11:
	leaq	24(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	leal	-1(%rbx), %edx
	movq	24(%rsp), %rcx
	subq	8(%rsp), %rcx
	movl	$.LC4, %esi
	movslq	%edx, %rdx
	movl	$1, %edi
	cvtss2sd	y(,%rdx,4), %xmm2
	movl	%ebx, %edx
	cvtsi2sdq	%rax, %xmm0
	movb	$3, %al
	cvtsi2sdq	%rcx, %xmm1
	divsd	.LC3(%rip), %xmm0
	addsd	%xmm1, %xmm0
	cvtss2sd	y(%rip), %xmm1
	call	__printf_chk
	xorl	%eax, %eax
	movq	40(%rsp), %rcx
	xorq	%fs:40, %rcx
	je	.L7
	call	__stack_chk_fail
.L7:
	addq	$48, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE20:
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
