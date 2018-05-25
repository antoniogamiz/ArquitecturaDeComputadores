	.file	"pmm-secuencial.c"
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L26
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movl	$10000, %ebx
	call	strtol
	cmpl	$10000, %eax
	cmovle	%eax, %ebx
	testl	%ebx, %ebx
	jle	.L3
	leal	-1(%rbx), %r14d
	xorl	%ebp, %ebp
	leaq	1(%r14), %r15
	movq	%r14, %r12
	imulq	$40000, %r15, %rdx
	leaq	0(,%r15,4), %r13
.L5:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	movl	$1, m1(%rbp,%rax)
	movl	$1, m2(%rbp,%rax)
	movl	$0, m3(%rbp,%rax)
	addq	$4, %rax
	cmpq	%rax, %r13
	jne	.L4
	addq	$40000, %rbp
	cmpq	%rdx, %rbp
	jne	.L5
	movq	%rsp, %rsi
	xorl	%edi, %edi
	addq	$m3, %r13
	call	clock_gettime
	imulq	$-40000, %r14, %rax
	movq	%r14, %rdx
	movl	$m1, %r9d
	imulq	$40004, %r15, %r11
	negq	%rdx
	addq	$m2, %rbp
	leaq	-4(,%rdx,4), %r14
	leaq	-40000(%rax), %r10
	addq	$m3, %r11
.L10:
	leaq	(%r14,%r13), %r8
	movq	%rbp, %rdi
	.p2align 4,,10
	.p2align 3
.L8:
	movl	(%r8), %esi
	leaq	(%r10,%rdi), %rax
	movq	%r9, %rcx
	.p2align 4,,10
	.p2align 3
.L7:
	movl	(%rcx), %edx
	addq	$40000, %rax
	addq	$4, %rcx
	imull	-40000(%rax), %edx
	addl	%edx, %esi
	cmpq	%rdi, %rax
	jne	.L7
	movl	%esi, (%r8)
	addq	$4, %r8
	leaq	4(%rax), %rdi
	cmpq	%r8, %r13
	jne	.L8
	addq	$40000, %r13
	addq	$40000, %r9
	cmpq	%r11, %r13
	jne	.L10
.L11:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	subq	$8, %rsp
	.cfi_def_cfa_offset 120
	pxor	%xmm0, %xmm0
	movl	m3(%rip), %ecx
	movl	%ebx, %edx
	movl	%r12d, %r9d
	movl	%r12d, %r8d
	movl	$.LC2, %esi
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	24(%rsp), %rax
	subq	8(%rsp), %rax
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	divsd	.LC1(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movslq	%r12d, %rax
	imulq	$40004, %rax, %rax
	movl	m3(%rax), %eax
	pushq	%rax
	.cfi_def_cfa_offset 128
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	__printf_chk
	popq	%rax
	.cfi_def_cfa_offset 120
	popq	%rdx
	.cfi_def_cfa_offset 112
	xorl	%eax, %eax
	movq	40(%rsp), %rbx
	xorq	%fs:40, %rbx
	jne	.L27
	addq	$56, %rsp
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
.L3:
	.cfi_restore_state
	movq	%rsp, %rsi
	xorl	%edi, %edi
	leal	-1(%rbx), %r12d
	call	clock_gettime
	jmp	.L11
.L26:
	movq	(%rsi), %rcx
	movq	stderr(%rip), %rdi
	movl	$.LC0, %edx
	movl	$1, %esi
	call	__fprintf_chk
	movl	$-1, %edi
	call	exit
.L27:
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
