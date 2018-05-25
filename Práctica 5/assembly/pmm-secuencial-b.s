	.file	"pmm-secuencial-b.c"
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
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
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
	leal	-1(%rbx), %r12d
	xorl	%edx, %edx
	leaq	1(%r12), %rbp
	movl	%r12d, 12(%rsp)
	imulq	$40000, %rbp, %rcx
	salq	$2, %rbp
.L5:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	movl	$1, m1(%rdx,%rax)
	movl	$1, m2(%rdx,%rax)
	movl	$0, m3(%rdx,%rax)
	addq	$4, %rax
	cmpq	%rax, %rbp
	jne	.L4
	addq	$40000, %rdx
	cmpq	%rcx, %rdx
	jne	.L5
	imulq	$40000, %r12, %r12
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movl	$m2, %r9d
	leaq	40000(%r12), %r10
	addq	%r9, %rbp
	movq	%r9, %r8
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
	cmpq	%rax, %rdi
	jne	.L7
	addq	$4, %r8
	addq	$40000, %r9
	cmpq	%r8, %rbp
	jne	.L8
	xorl	%r13d, %r13d
	movl	$0, 8(%rsp)
.L13:
	leaq	m3(%r13), %r14
	xorl	%r10d, %r10d
	xorl	%r15d, %r15d
	.p2align 4,,10
	.p2align 3
.L11:
	leaq	40000(%r10), %rbp
	leaq	80000(%r10), %r11
	leaq	120000(%r10), %r9
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	xorl	%edi, %edi
	xorl	%esi, %esi
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L10:
	movl	m1(%r13,%rax,4), %edx
	movl	m2(%r10,%rax,4), %r12d
	imull	%edx, %r12d
	addl	%r12d, %ecx
	movl	m2(%rbp,%rax,4), %r12d
	imull	%edx, %r12d
	addl	%r12d, %esi
	movl	m2(%r11,%rax,4), %r12d
	imull	%edx, %r12d
	imull	m2(%r9,%rax,4), %edx
	addq	$1, %rax
	addl	%r12d, %edi
	addl	%edx, %r8d
	cmpl	%eax, %ebx
	jg	.L10
	addl	$4, %r15d
	movl	%ecx, (%r14)
	movl	%esi, 4(%r14)
	movl	%edi, 8(%r14)
	movl	%r8d, 12(%r14)
	addq	$160000, %r10
	addq	$16, %r14
	cmpl	%ebx, %r15d
	jl	.L11
	addl	$1, 8(%rsp)
	addq	$40000, %r13
	movl	8(%rsp), %eax
	cmpl	%ebx, %eax
	jl	.L13
	jmp	.L14.L13:
	leaq	m3(%r13), %r14
	xorl	%r10d, %r10d
	xorl	%r15d, %r15d
	.p2align 4,,10
	.p2align 3
.L11:
	leaq	40000(%r10), %rbp
	leaq	80000(%r10), %r11
	leaq	120000(%r10), %r9
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	xorl	%edi, %edi
	xorl	%esi, %esi
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L10:
	movl	m1(%r13,%rax,4), %edx
	movl	m2(%r10,%rax,4), %r12d
	imull	%edx, %r12d
	addl	%r12d, %ecx
	movl	m2(%rbp,%rax,4), %r12d
	imull	%edx, %r12d
	addl	%r12d, %esi
	movl	m2(%r11,%rax,4), %r12d
	imull	%edx, %r12d
	imull	m2(%r9,%rax,4), %edx
	addq	$1, %rax
	addl	%r12d, %edi
	addl	%edx, %r8d
	cmpl	%eax, %ebx
	jg	.L10
	addl	$4, %r15d
	movl	%ecx, (%r14)
	movl	%esi, 4(%r14)
	movl	%edi, 8(%r14)
	movl	%r8d, 12(%r14)
	addq	$160000, %r10
	addq	$16, %r14
	cmpl	%ebx, %r15d
	jl	.L11
	addl	$1, 8(%rsp)
	addq	$40000, %r13
	movl	8(%rsp), %eax
	cmpl	%ebx, %eax
	jl	.L13
	jmp	.L14
.L3:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	leal	-1(%rbx), %eax
	movl	%eax, 12(%rsp)
.L14:
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	subq	$8, %rsp
	.cfi_def_cfa_offset 136
	pxor	%xmm0, %xmm0
	movl	m3(%rip), %ecx
	movl	%ebx, %edx
	movl	$.LC2, %esi
	cvtsi2sdq	%rax, %xmm0
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	movl	20(%rsp), %edi
	movl	%edi, %r9d
	movl	%edi, %r8d
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC1(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movslq	%edi, %rax
	imulq	$40004, %rax, %rax
	movl	$1, %edi
	movl	m3(%rax), %eax
	pushq	%rax
	.cfi_def_cfa_offset 144
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	__printf_chk
	popq	%rax
	.cfi_def_cfa_offset 136
	popq	%rdx
	.cfi_def_cfa_offset 128
	xorl	%eax, %eax
	movq	56(%rsp), %rbx
	xorq	%fs:40, %rbx
	jne	.L32
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L31:
	.cfi_restore_state
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
