	.file	"pmm-secuencial-a.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Formato: %s <N>\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"Tiempo(seg): %11.9f \t N=%d \t (m3[0][0]=%d m3[%d][%d]=%d)\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB3:
	.section	.text.startup,"ax",@progbits
.LHOTB3:
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L31
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	$10000, %ebx
	call	strtol
	cmpl	$10000, %eax
	cmovle	%eax, %ebx
	testl	%ebx, %ebx
	jle	.L3
	leal	-1(%rbx), %r13d
	xorl	%edx, %edx
	leaq	1(%r13), %r12
	movq	%r13, %rbp
	imulq	$40000, %r12, %rcx
	salq	$2, %r12
.L5:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	movl	$1, m1(%rdx,%rax)
	movl	$1, m2(%rdx,%rax)
	movl	$0, m3(%rdx,%rax)
	addq	$4, %rax
	cmpq	%rax, %r12
	jne	.L4
	addq	$40000, %rdx
	cmpq	%rcx, %rdx
	jne	.L5
	imulq	$40000, %r13, %r13
	movq	%rsp, %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movl	$m2, %r9d
	addq	%r9, %r12
	movq	%r9, %r8
	leaq	40000(%r13), %r10
.L8:
	leaq	(%r10,%r8), %rdi
	movq	%r8, %rax
	movq	%r9, %rdx
	.p2align 4,,10
	.p2align 3
.L7:
	movl	(%rdx), %ecx
	movl	(%rax), %esi
	addq	$40000, %rax
	addq	$4, %rdx
	movl	%esi, -4(%rdx)
	movl	%ecx, -40000(%rax)
	cmpq	%rdi, %rax
	jne	.L7
	addq	$4, %r8
	addq	$40000, %r9
	cmpq	%r12, %r8
	jne	.L8
	xorl	%esi, %esi
	xorl	%r8d, %r8d
.L13:
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L11:
	movl	m3(%rsi,%rdx,4), %edi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L10:
	movl	m1(%rsi,%rax,4), %ecx
	imull	m2(%rsi,%rax,4), %ecx
	addq	$1, %rax
	addl	%ecx, %edi
	cmpl	%eax, %ebx
	jg	.L10
	movl	%edi, m3(%rsi,%rdx,4)
	addq	$1, %rdx
	cmpl	%edx, %ebx
	jg	.L11
	addl	$1, %r8d
	addq	$40000, %rsi
	cmpl	%ebx, %r8d
	jl	.L13
.L14:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	subq	$8, %rsp
	.cfi_def_cfa_offset 104
	pxor	%xmm0, %xmm0
	movl	m3(%rip), %ecx
	movl	%ebx, %edx
	movl	%ebp, %r9d
	movl	%ebp, %r8d
	movl	$.LC2, %esi
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC1(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movslq	%ebp, %rax
	imulq	$40004, %rax, %rax
	movl	m3(%rax), %eax
	pushq	%rax
	.cfi_def_cfa_offset 112
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	__printf_chk
	popq	%rax
	.cfi_def_cfa_offset 104
	popq	%rdx
	.cfi_def_cfa_offset 96
	xorl	%eax, %eax
	movq	40(%rsp), %rdx
	xorq	%fs:40, %rdx
	jne	.L32
	addq	$56, %rsp
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
.L3:
	.cfi_restore_state
	movq	%rsp, %rsi
	xorl	%edi, %edi
	leal	-1(%rbx), %ebp
	call	clock_gettime
	jmp	.L14
.L31:
	movq	(%rsi), %rcx
	movq	stderr(%rip), %rdi
	movl	$.LC0, %edx
	movl	$1, %esi
	call	__fprintf_chk
	movl	$-1, %edi
	call	exit
.L32:
	call	__stack_chk_fail
	.cfi_endproc
.LFE38:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE3:
	.section	.text.startup
.LHOTE3:
	.comm	m3,400000000,32
	.comm	m2,400000000,32
	.comm	m1,400000000,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
