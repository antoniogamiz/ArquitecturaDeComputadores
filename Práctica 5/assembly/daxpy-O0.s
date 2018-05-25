	.file	"daxpy.c"
	.comm	x,1200000000,32
	.comm	y,1200000000,32
	.section	.rodata
.LC0:
	.string	"Formato: %s <N> \n"
	.align 8
.LC4:
	.string	"T(s) %11.9f \t / y[0]=%5.3f / y[%d]=%5.3f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -84(%rbp)
	movq	%rsi, -96(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$2, -84(%rbp)
	je	.L2
	movq	-96(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$-1, %edi
	call	exit
.L2:
	movq	-96(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -68(%rbp)
	cmpl	$300000000, -68(%rbp)
	jle	.L3
	movl	$300000000, -68(%rbp)
.L3:
	movl	$0, -64(%rbp)
	jmp	.L4
.L5:
	pxor	%xmm0, %xmm0
	cvtsi2sd	-64(%rbp), %xmm0
	movsd	.LC1(%rip), %xmm1
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movl	-64(%rbp), %eax
	cltq
	movss	%xmm0, x(,%rax,4)
	addl	$1, -64(%rbp)
.L4:
	movl	-64(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.L5
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	movl	$0, -60(%rbp)
	jmp	.L6
.L7:
	movl	-60(%rbp), %eax
	cltq
	movss	x(,%rax,4), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movsd	.LC2(%rip), %xmm1
	mulsd	%xmm0, %xmm1
	movl	-60(%rbp), %eax
	cltq
	movss	y(,%rax,4), %xmm0
	cvtss2sd	%xmm0, %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movl	-60(%rbp), %eax
	cltq
	movss	%xmm0, y(,%rax,4)
	addl	$1, -60(%rbp)
.L6:
	movl	-60(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.L7
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	movq	-32(%rbp), %rdx
	movq	-48(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movq	-24(%rbp), %rdx
	movq	-40(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC3(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -56(%rbp)
	movl	-68(%rbp), %eax
	subl	$1, %eax
	cltq
	movss	y(,%rax,4), %xmm0
	cvtss2sd	%xmm0, %xmm1
	movss	y(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movl	-68(%rbp), %edx
	movq	-56(%rbp), %rax
	movapd	%xmm1, %xmm2
	movl	%edx, %esi
	movapd	%xmm0, %xmm1
	movq	%rax, -104(%rbp)
	movsd	-104(%rbp), %xmm0
	movl	$.LC4, %edi
	movl	$3, %eax
	call	printf
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L9
	call	__stack_chk_fail
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
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
