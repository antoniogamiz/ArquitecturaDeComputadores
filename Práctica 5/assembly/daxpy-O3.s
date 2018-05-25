	.file	"daxpy.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Formato: %s <N> \n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC8:
	.string	"T(s) %11.9f \t / y[0]=%5.3f / y[%d]=%5.3f\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB9:
	.section	.text.startup,"ax",@progbits
.LHOTB9:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB38:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	jne	.L31
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	$300000000, %ebx
	call	strtol
	cmpl	$300000000, %eax
	cmovle	%eax, %ebx
	testl	%ebx, %ebx
	jle	.L3
	leal	-4(%rbx), %r13d
	leal	-1(%rbx), %r12d
	shrl	$2, %r13d
	addl	$1, %r13d
	cmpl	$2, %r12d
	leal	0(,%r13,4), %ebp
	jbe	.L18
	movdqa	.LC0(%rip), %xmm2
	xorl	%eax, %eax
	movdqa	.LC2(%rip), %xmm4
	movapd	.LC3(%rip), %xmm3
.L5:
	pshufd	$238, %xmm2, %xmm1
	cvtdq2pd	%xmm2, %xmm0
	addpd	%xmm3, %xmm0
	movq	%rax, %rdx
	addq	$1, %rax
	paddd	%xmm4, %xmm2
	salq	$4, %rdx
	cmpl	%eax, %r13d
	cvtdq2pd	%xmm1, %xmm1
	addpd	%xmm3, %xmm1
	cvtpd2ps	%xmm0, %xmm0
	cvtpd2ps	%xmm1, %xmm1
	movlhps	%xmm1, %xmm0
	movaps	%xmm0, x(%rdx)
	ja	.L5
	cmpl	%ebp, %ebx
	movl	%ebp, %eax
	je	.L32
.L4:
	pxor	%xmm0, %xmm0
	movslq	%eax, %rdx
	movsd	.LC4(%rip), %xmm2
	pxor	%xmm6, %xmm6
	cvtsi2sd	%eax, %xmm0
	addsd	%xmm2, %xmm0
	cvtsd2ss	%xmm0, %xmm6
	movss	%xmm6, x(,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %ebx
	jle	.L7
	pxor	%xmm1, %xmm1
	addl	$2, %eax
	movslq	%edx, %rcx
	pxor	%xmm7, %xmm7
	cmpl	%eax, %ebx
	cvtsi2sd	%edx, %xmm1
	addsd	%xmm2, %xmm1
	cvtsd2ss	%xmm1, %xmm7
	movss	%xmm7, x(,%rcx,4)
	jle	.L7
	pxor	%xmm0, %xmm0
	movslq	%eax, %rdx
	pxor	%xmm5, %xmm5
	cvtsi2sd	%eax, %xmm0
	addsd	%xmm2, %xmm0
	cvtsd2ss	%xmm0, %xmm5
	movss	%xmm5, x(,%rdx,4)
.L7:
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	cmpl	$2, %r12d
	jbe	.L19
.L16:
	movapd	.LC5(%rip), %xmm3
	xorl	%eax, %eax
	xorl	%edx, %edx
.L10:
	addl	$1, %edx
	addq	$16, %rax
	movaps	x-16(%rax), %xmm2
	cvtps2pd	%xmm2, %xmm0
	movaps	y-16(%rax), %xmm4
	mulpd	%xmm3, %xmm0
	movhps	%xmm2, (%rsp)
	movhps	%xmm4, 16(%rsp)
	movapd	%xmm0, %xmm1
	cvtps2pd	%xmm4, %xmm0
	addpd	%xmm1, %xmm0
	cvtps2pd	(%rsp), %xmm1
	cvtpd2ps	%xmm0, %xmm0
	movapd	%xmm1, %xmm2
	cvtps2pd	16(%rsp), %xmm1
	mulpd	%xmm3, %xmm2
	addpd	%xmm2, %xmm1
	cvtpd2ps	%xmm1, %xmm1
	movlhps	%xmm1, %xmm0
	movaps	%xmm0, y-16(%rax)
	cmpl	%edx, %r13d
	ja	.L10
	cmpl	%ebp, %ebx
	movl	%ebp, %eax
	je	.L15
.L14:
	pxor	%xmm1, %xmm1
	movslq	%eax, %rdx
	movsd	.LC6(%rip), %xmm0
	pxor	%xmm6, %xmm6
	cvtss2sd	x(,%rdx,4), %xmm1
	movapd	%xmm1, %xmm2
	pxor	%xmm1, %xmm1
	mulsd	%xmm0, %xmm2
	cvtss2sd	y(,%rdx,4), %xmm1
	addsd	%xmm2, %xmm1
	cvtsd2ss	%xmm1, %xmm6
	movss	%xmm6, y(,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%ebx, %edx
	jge	.L15
	pxor	%xmm1, %xmm1
	movslq	%edx, %rdx
	addl	$2, %eax
	pxor	%xmm7, %xmm7
	cmpl	%ebx, %eax
	cvtss2sd	x(,%rdx,4), %xmm1
	movapd	%xmm1, %xmm2
	pxor	%xmm1, %xmm1
	mulsd	%xmm0, %xmm2
	cvtss2sd	y(,%rdx,4), %xmm1
	addsd	%xmm2, %xmm1
	cvtsd2ss	%xmm1, %xmm7
	movss	%xmm7, y(,%rdx,4)
	jge	.L15
	pxor	%xmm1, %xmm1
	cltq
	pxor	%xmm5, %xmm5
	cvtss2sd	x(,%rax,4), %xmm1
	mulsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtss2sd	y(,%rax,4), %xmm1
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm5
	movss	%xmm5, y(,%rax,4)
.L15:
	leaq	48(%rsp), %rsi
	xorl	%edi, %edi
	movslq	%r12d, %r12
	call	clock_gettime
	movq	56(%rsp), %rax
	subq	40(%rsp), %rax
	movl	%ebx, %edx
	pxor	%xmm0, %xmm0
	movl	$.LC8, %esi
	pxor	%xmm2, %xmm2
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	48(%rsp), %rax
	subq	32(%rsp), %rax
	cvtss2sd	y(,%r12,4), %xmm2
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC7(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movl	$3, %eax
	addsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtss2sd	y(%rip), %xmm1
	call	__printf_chk
	xorl	%eax, %eax
	movq	72(%rsp), %rcx
	xorq	%fs:40, %rcx
	jne	.L33
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L19:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L14
.L32:
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	jmp	.L16
.L18:
	xorl	%eax, %eax
	jmp	.L4
.L3:
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	leal	-1(%rbx), %r12d
	call	clock_gettime
	jmp	.L15
.L31:
	movq	(%rsi), %rdx
	movl	$1, %edi
	movl	$.LC1, %esi
	call	__printf_chk
	orl	$-1, %edi
	call	exit
.L33:
	call	__stack_chk_fail
	.cfi_endproc
.LFE38:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE9:
	.section	.text.startup
.LHOTE9:
	.comm	y,1200000000,32
	.comm	x,1200000000,32
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC2:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC3:
	.long	2576980378
	.long	1069128089
	.long	2576980378
	.long	1069128089
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	2576980378
	.long	1069128089
	.section	.rodata.cst16
	.align 16
.LC5:
	.long	0
	.long	1073217536
	.long	0
	.long	1073217536
	.section	.rodata.cst8
	.align 8
.LC6:
	.long	0
	.long	1073217536
	.align 8
.LC7:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
