	.file	"sobel_filter.cpp"
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.p2align 4
	.globl	_Z7getGrayRKN2cv3MatEii
	.type	_Z7getGrayRKN2cv3MatEii, @function
_Z7getGrayRKN2cv3MatEii:
.LFB10338:
	.cfi_startproc
	endbr64
	movq	72(%rdi), %rax
	movslq	%esi, %rsi
	movslq	%edx, %rdx
	imulq	(%rax), %rsi
	leaq	(%rdx,%rdx,2), %rax
	leaq	(%rsi,%rax), %rdx
	addq	16(%rdi), %rdx
	movzbl	1(%rdx), %ecx
	movzbl	(%rdx), %eax
	movzbl	2(%rdx), %edx
	imull	$183, %ecx, %ecx
	leal	(%rax,%rax,8), %eax
	imull	$54, %edx, %edx
	shrl	$7, %eax
	sarl	$8, %ecx
	addl	%ecx, %eax
	addb	%dh, %al
	ret
	.cfi_endproc
.LFE10338:
	.size	_Z7getGrayRKN2cv3MatEii, .-_Z7getGrayRKN2cv3MatEii
	.p2align 4
	.globl	_Z17streamingPipelineRKN2cv3MatEPS0_RS0_R14PipelineTiming
	.type	_Z17streamingPipelineRKN2cv3MatEPS0_RS0_R14PipelineTiming, @function
_Z17streamingPipelineRKN2cv3MatEPS0_RS0_R14PipelineTiming:
.LFB10339:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rsi, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rcx, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	leaq	16(%r15), %r8
	xorl	%esi, %esi
	movq	(%r8), %rdi
	movq	%rax, %rbx
	movl	12(%rbp), %eax
	testl	%eax, %eax
	jle	.L4
.L30:
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L5:
	movq	72(%rbp), %rax
	movq	(%rax), %rdx
	leaq	(%rcx,%rcx,2), %rax
	imulq	%rsi, %rdx
	addq	%rax, %rdx
	addq	16(%rbp), %rdx
	movzbl	1(%rdx), %r9d
	movzbl	(%rdx), %eax
	movzbl	2(%rdx), %edx
	imull	$183, %r9d, %r9d
	leal	(%rax,%rax,8), %eax
	imull	$54, %edx, %edx
	shrl	$7, %eax
	sarl	$8, %r9d
	addl	%r9d, %eax
	sarl	$8, %edx
	addl	%edx, %eax
	movb	%al, (%rdi,%rcx)
	movl	12(%rbp), %eax
	addq	$1, %rcx
	cmpl	%ecx, %eax
	jg	.L5
	cmpq	$2, %rsi
	je	.L4
	addq	$96, %r8
	addq	$1, %rsi
	movq	(%r8), %rdi
	testl	%eax, %eax
	jg	.L30
.L4:
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	pxor	%xmm0, %xmm0
	subq	%rbx, %rax
	cmpl	$2, 8(%rbp)
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC0(%rip), %xmm0
	addsd	(%r14), %xmm0
	movsd	%xmm0, (%r14)
	jle	.L3
	movl	$2, 36(%rsp)
	movl	$1, %r12d
	movl	$1, 32(%rsp)
	movl	$0, 28(%rsp)
	.p2align 4,,10
	.p2align 3
.L7:
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	%rax, %rsi
	movslq	28(%rsp), %rax
	leaq	(%rax,%rax,2), %rax
	salq	$5, %rax
	addq	%r15, %rax
	movq	%rax, 40(%rsp)
	movq	16(%rax), %r8
	movslq	32(%rsp), %rax
	leaq	(%rax,%rax,2), %rax
	salq	$5, %rax
	movq	16(%r15,%rax), %rbx
	movslq	36(%rsp), %rax
	leaq	(%rax,%rax,2), %rax
	salq	$5, %rax
	movq	16(%r15,%rax), %rdi
	movq	72(%r13), %rax
	movq	(%rax), %rcx
	movl	$1, %eax
	imulq	%r12, %rcx
	addq	$3, %rcx
	addq	16(%r13), %rcx
	cmpl	$2, 12(%rbp)
	jle	.L12
	movq	%r12, 8(%rsp)
	movq	%rsi, 16(%rsp)
	.p2align 4,,10
	.p2align 3
.L11:
	movzbl	-1(%r8,%rax), %r11d
	movzbl	(%r8,%rax), %r12d
	movzbl	1(%r8,%rax), %esi
	movzbl	-1(%rdi,%rax), %r10d
	movl	%r11d, %edx
	addl	%r12d, %r12d
	movzbl	1(%rdi,%rax), %r9d
	negl	%edx
	subl	%r12d, %edx
	movzbl	(%rdi,%rax), %r12d
	subl	%esi, %edx
	addl	%r10d, %edx
	leal	(%rdx,%r12,2), %r12d
	addl	%r9d, %r12d
	movl	%r12d, %edx
	negl	%edx
	cmovs	%r12d, %edx
	movzbl	-1(%rbx,%rax), %r12d
	subl	%r11d, %esi
	movzbl	1(%rbx,%rax), %r11d
	negl	%r12d
	leal	(%rsi,%r12,2), %esi
	leal	(%rsi,%r11,2), %esi
	subl	%r10d, %esi
	addl	%r9d, %esi
	movl	%esi, %r9d
	negl	%r9d
	cmovns	%r9d, %esi
	addl	%esi, %edx
	movl	$255, %esi
	cmpl	%esi, %edx
	cmovg	%esi, %edx
	addq	$1, %rax
	addq	$3, %rcx
	movb	%dl, -3(%rcx)
	movb	%dl, -2(%rcx)
	movb	%dl, -1(%rcx)
	movl	12(%rbp), %esi
	leal	-1(%rsi), %edx
	cmpl	%eax, %edx
	jg	.L11
	movq	8(%rsp), %r12
	movq	16(%rsp), %rsi
.L12:
	movq	%rsi, 8(%rsp)
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	8(%rsp), %rsi
	pxor	%xmm0, %xmm0
	subq	%rsi, %rax
	cvtsi2sdq	%rax, %xmm0
	movl	8(%rbp), %eax
	divsd	.LC0(%rip), %xmm0
	addsd	8(%r14), %xmm0
	leal	-2(%rax), %edx
	movsd	%xmm0, 8(%r14)
	cmpl	%r12d, %edx
	jg	.L31
.L10:
	addq	$1, %r12
	subl	$1, %eax
	cmpl	%r12d, %eax
	jg	.L7
.L3:
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
	.p2align 4,,10
	.p2align 3
.L31:
	.cfi_restore_state
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	leal	2(%r12), %esi
	xorl	%ecx, %ecx
	movq	%rax, %rbx
	movq	40(%rsp), %rax
	movq	16(%rax), %rdi
	movl	12(%rbp), %eax
	testl	%eax, %eax
	jle	.L15
	.p2align 4,,10
	.p2align 3
.L14:
	movq	72(%rbp), %rax
	movq	(%rax), %rdx
	leaq	(%rcx,%rcx,2), %rax
	imulq	%rsi, %rdx
	addq	%rax, %rdx
	addq	16(%rbp), %rdx
	movzbl	1(%rdx), %r8d
	movzbl	(%rdx), %eax
	movzbl	2(%rdx), %edx
	imull	$183, %r8d, %r8d
	leal	(%rax,%rax,8), %eax
	imull	$54, %edx, %edx
	shrl	$7, %eax
	sarl	$8, %r8d
	addl	%r8d, %eax
	sarl	$8, %edx
	addl	%edx, %eax
	movb	%al, (%rdi,%rcx)
	addq	$1, %rcx
	cmpl	%ecx, 12(%rbp)
	jg	.L14
.L15:
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	pxor	%xmm0, %xmm0
	movl	28(%rsp), %edx
	subq	%rbx, %rax
	movl	32(%rsp), %ebx
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC0(%rip), %xmm0
	movl	8(%rbp), %eax
	addsd	(%r14), %xmm0
	movl	%ebx, 28(%rsp)
	movl	36(%rsp), %ebx
	movl	%edx, 36(%rsp)
	movl	%ebx, 32(%rsp)
	movsd	%xmm0, (%r14)
	jmp	.L10
	.cfi_endproc
.LFE10339:
	.size	_Z17streamingPipelineRKN2cv3MatEPS0_RS0_R14PipelineTiming, .-_Z17streamingPipelineRKN2cv3MatEPS0_RS0_R14PipelineTiming
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"Usage: ./sobel_filter <video-file>"
	.align 8
.LC4:
	.string	"basic_string: construction from null is not valid"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"Could not open video"
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"Could not read a frame from the video"
	.section	.rodata.str1.1
.LC7:
	.string	"\nPerformance Results"
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"-------------------------------"
	.section	.rodata.str1.1
.LC9:
	.string	"Resolution:        %d x %d\n"
.LC10:
	.string	"Frames processed:  %d\n"
	.section	.rodata.str1.8
	.align 8
.LC11:
	.string	"Grayscale time:    %.2f ms total (%.2f ms/frame)\n"
	.align 8
.LC12:
	.string	"Sobel time:        %.2f ms total (%.2f ms/frame)\n"
	.align 8
.LC13:
	.string	"Overall time:      %.2f ms total (%.2f ms/frame)\n"
	.align 8
.LC14:
	.string	"Time per output pixel: %.9f ms\n"
	.section	.rodata.str1.1
.LC16:
	.string	"Processing FPS:    %.2f\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB17:
	.section	.text.startup,"ax",@progbits
.LHOTB17:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB10341:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA10341
	endbr64
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
	subq	$1016, %rsp
	.cfi_def_cfa_offset 1072
	movq	%fs:40, %rax
	movq	%rax, 1000(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L84
	movq	8(%rsi), %rbp
	leaq	656(%rsp), %rax
	leaq	640(%rsp), %r14
	movq	%rax, 40(%rsp)
	movq	%rax, 640(%rsp)
	testq	%rbp, %rbp
	je	.L85
	movq	%rbp, %rdi
	call	strlen@PLT
	movq	%rax, 112(%rsp)
	movq	%rax, %rbx
	cmpq	$15, %rax
	ja	.L86
	cmpq	$1, %rax
	jne	.L39
	movzbl	0(%rbp), %eax
	movb	%al, 656(%rsp)
	leaq	112(%rsp), %rax
	movq	%rax, 32(%rsp)
.L40:
	movq	112(%rsp), %rax
	movq	640(%rsp), %rdx
	movq	%r14, %rsi
	movq	32(%rsp), %rbx
	movq	%rax, 648(%rsp)
	movb	$0, (%rdx,%rax)
	movq	%rbx, %rdi
	xorl	%edx, %edx
.LEHB0:
	call	_ZN2cv12VideoCaptureC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi@PLT
.LEHE0:
	movq	%r14, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT
	movq	%rbx, %rdi
.LEHB1:
	call	_ZNK2cv12VideoCapture8isOpenedEv@PLT
.LEHE1:
	testb	%al, %al
	je	.L87
	leaq	160(%rsp), %r12
	leaq	256(%rsp), %r13
	xorl	%ebx, %ebx
	movq	%r12, %rdi
	leaq	352(%rsp), %rbp
	call	_ZN2cv3MatC1Ev@PLT
	movq	%r13, %rdi
	call	_ZN2cv3MatC1Ev@PLT
	movq	%rbp, %rdi
	call	_ZN2cv3MatC1Ev@PLT
	leaq	448(%rsp), %rax
	movq	%rax, %rdi
	movq	%rax, 72(%rsp)
	call	_ZN2cv3MatC1Ev@PLT
	leaq	544(%rsp), %rax
	movq	%rax, %rdi
	movq	%rax, 64(%rsp)
	call	_ZN2cv3MatC1Ev@PLT
	leaq	80(%rsp), %rax
	movq	$0x000000000, 16(%rsp)
	movq	%rax, 24(%rsp)
	leaq	848(%rsp), %rax
	movq	%rax, 48(%rsp)
	leaq	752(%rsp), %rax
	movq	$0x000000000, 8(%rsp)
	movq	$0x000000000, (%rsp)
	movq	%rax, 56(%rsp)
	.p2align 4,,10
	.p2align 3
.L43:
	movq	24(%rsp), %rsi
	movq	32(%rsp), %rdi
	movq	$33619968, 80(%rsp)
	movq	$0, 96(%rsp)
	movq	%r12, 88(%rsp)
.LEHB2:
	call	_ZN2cv12VideoCapture4readERKNS_12_OutputArrayE@PLT
	testb	%al, %al
	je	.L88
	movq	224(%rsp), %rdx
	movq	320(%rsp), %rcx
	movl	(%rdx), %eax
	movl	4(%rdx), %esi
	movl	160(%rsp), %edx
	cmpl	%eax, (%rcx)
	jne	.L44
	cmpl	%esi, 4(%rcx)
	je	.L89
.L44:
	salq	$32, %rax
	andl	$4095, %edx
	movq	%r14, %rdi
	orq	%rax, %rsi
	call	_ZN2cv3Mat5zerosENS_5Size_IiEEi@PLT
.LEHE2:
	movq	640(%rsp), %rdi
	movl	$-1, %ecx
	movq	%r13, %rdx
	movq	%r14, %rsi
	movq	(%rdi), %rax
.LEHB3:
	call	*24(%rax)
.LEHE3:
	movq	48(%rsp), %rdi
	movq	%rbp, %r15
	call	_ZN2cv3MatD1Ev@PLT
	movq	56(%rsp), %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	40(%rsp), %rdi
	call	_ZN2cv3MatD1Ev@PLT
.L46:
	movl	172(%rsp), %edx
	xorl	%ecx, %ecx
	movl	$1, %esi
	movq	%r14, %rdi
.LEHB4:
	call	_ZN2cv3MatC1Eiii@PLT
.LEHE4:
	movq	%r14, %rsi
	movq	%r15, %rdi
.LEHB5:
	call	_ZN2cv3MataSEOS0_@PLT
.LEHE5:
	movq	%r14, %rdi
	addq	$96, %r15
	call	_ZN2cv3MatD1Ev@PLT
	cmpq	%r14, %r15
	jne	.L46
.L47:
	movq	$0x000000000, 80(%rsp)
	addl	$1, %ebx
	movq	$0x000000000, 88(%rsp)
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	24(%rsp), %rcx
	movq	%r13, %rdx
	movq	%rbp, %rsi
	movq	%r12, %rdi
	movq	%rax, %r15
	call	_Z17streamingPipelineRKN2cv3MatEPS0_RS0_R14PipelineTiming
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	pxor	%xmm0, %xmm0
	movsd	8(%rsp), %xmm2
	movsd	16(%rsp), %xmm3
	subq	%r15, %rax
	addsd	80(%rsp), %xmm2
	addsd	88(%rsp), %xmm3
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC0(%rip), %xmm0
	addsd	(%rsp), %xmm0
	movsd	%xmm2, 8(%rsp)
	movsd	%xmm0, (%rsp)
	movsd	%xmm3, 16(%rsp)
	cmpl	$30, %ebx
	jne	.L43
	movsd	.LC2(%rip), %xmm0
.L48:
	movsd	(%rsp), %xmm5
	movsd	16(%rsp), %xmm6
	leaq	.LC7(%rip), %rdi
	movsd	8(%rsp), %xmm7
	movl	168(%rsp), %eax
	divsd	%xmm0, %xmm5
	imull	172(%rsp), %eax
	divsd	%xmm0, %xmm6
	movsd	%xmm5, 24(%rsp)
	divsd	%xmm0, %xmm7
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movsd	%xmm6, 48(%rsp)
	movapd	%xmm5, %xmm6
	divsd	%xmm0, %xmm6
	movsd	%xmm7, 40(%rsp)
	movsd	%xmm6, 56(%rsp)
.LEHB6:
	call	puts@PLT
	leaq	.LC8(%rip), %rdi
	call	puts@PLT
	movl	168(%rsp), %ecx
	movl	172(%rsp), %edx
	leaq	.LC9(%rip), %rsi
	xorl	%eax, %eax
	movl	$2, %edi
	call	__printf_chk@PLT
	movl	%ebx, %edx
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movsd	40(%rsp), %xmm1
	movsd	8(%rsp), %xmm0
	movl	$2, %edi
	leaq	.LC11(%rip), %rsi
	movl	$2, %eax
	call	__printf_chk@PLT
	movsd	48(%rsp), %xmm1
	movsd	16(%rsp), %xmm0
	movl	$2, %edi
	leaq	.LC12(%rip), %rsi
	movl	$2, %eax
	call	__printf_chk@PLT
	movsd	24(%rsp), %xmm1
	movsd	(%rsp), %xmm0
	movl	$2, %edi
	leaq	.LC13(%rip), %rsi
	movl	$2, %eax
	call	__printf_chk@PLT
	movsd	56(%rsp), %xmm0
	movl	$2, %edi
	movl	$1, %eax
	leaq	.LC14(%rip), %rsi
	call	__printf_chk@PLT
	leaq	.LC16(%rip), %rsi
	movl	$2, %edi
	movl	$1, %eax
	movsd	.LC15(%rip), %xmm0
	divsd	24(%rsp), %xmm0
	call	__printf_chk@PLT
.LEHE6:
	xorl	%ebx, %ebx
.L51:
	movq	64(%rsp), %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	72(%rsp), %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	%rbp, %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	%r13, %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	%r12, %rdi
	call	_ZN2cv3MatD1Ev@PLT
.L42:
	movq	32(%rsp), %rdi
	call	_ZN2cv12VideoCaptureD1Ev@PLT
.L32:
	movq	1000(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L82
	addq	$1016, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebx, %eax
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
.L86:
	.cfi_restore_state
	leaq	112(%rsp), %rax
	movq	%r14, %rdi
	xorl	%edx, %edx
	movq	%rax, %rsi
	movq	%rax, 32(%rsp)
.LEHB7:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm@PLT
	movq	%rax, 640(%rsp)
	movq	%rax, %rdi
	movq	112(%rsp), %rax
	movq	%rax, 656(%rsp)
.L38:
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	call	memcpy@PLT
	jmp	.L40
.L89:
	movl	256(%rsp), %ecx
	xorl	%edx, %ecx
	andl	$4095, %ecx
	je	.L47
	jmp	.L44
.L84:
	leaq	.LC3(%rip), %rdi
	movl	$1, %ebx
	call	puts@PLT
.LEHE7:
	jmp	.L32
.L87:
	leaq	.LC5(%rip), %rdi
.LEHB8:
	call	puts@PLT
.LEHE8:
	movl	$1, %ebx
	jmp	.L42
.L39:
	leaq	112(%rsp), %rax
	movq	%rax, 32(%rsp)
	testq	%rbx, %rbx
	je	.L40
	movq	40(%rsp), %rdi
	jmp	.L38
.L88:
	testl	%ebx, %ebx
	jne	.L50
	leaq	.LC6(%rip), %rdi
.LEHB9:
	call	puts@PLT
.LEHE9:
	movl	$1, %ebx
	jmp	.L51
.L50:
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%ebx, %xmm0
	jmp	.L48
.L82:
	call	__stack_chk_fail@PLT
.L85:
	movq	1000(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L82
	leaq	.LC4(%rip), %rdi
.LEHB10:
	call	_ZSt19__throw_logic_errorPKc@PLT
.LEHE10:
.L62:
	endbr64
	movq	%rax, %rbx
	jmp	.L52
.L64:
	endbr64
	movq	%rax, %rbx
	jmp	.L54
.L63:
	endbr64
	movq	%rax, %rbx
	jmp	.L57
.L65:
	endbr64
	movq	%rax, %rbx
	jmp	.L56
.L66:
	endbr64
	movq	%rax, %rbx
	jmp	.L55
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA10341:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE10341-.LLSDACSB10341
.LLSDACSB10341:
	.uleb128 .LEHB0-.LFB10341
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L62-.LFB10341
	.uleb128 0
	.uleb128 .LEHB1-.LFB10341
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L63-.LFB10341
	.uleb128 0
	.uleb128 .LEHB2-.LFB10341
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L66-.LFB10341
	.uleb128 0
	.uleb128 .LEHB3-.LFB10341
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L64-.LFB10341
	.uleb128 0
	.uleb128 .LEHB4-.LFB10341
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L66-.LFB10341
	.uleb128 0
	.uleb128 .LEHB5-.LFB10341
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L65-.LFB10341
	.uleb128 0
	.uleb128 .LEHB6-.LFB10341
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L66-.LFB10341
	.uleb128 0
	.uleb128 .LEHB7-.LFB10341
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB8-.LFB10341
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L63-.LFB10341
	.uleb128 0
	.uleb128 .LEHB9-.LFB10341
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L66-.LFB10341
	.uleb128 0
	.uleb128 .LEHB10-.LFB10341
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
.LLSDACSE10341:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC10341
	.type	main.cold, @function
main.cold:
.LFSB10341:
.L52:
	.cfi_def_cfa_offset 1072
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%r14, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT
	movq	1000(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L83
.L58:
	movq	%rbx, %rdi
.LEHB11:
	call	_Unwind_Resume@PLT
.LEHE11:
.L54:
	leaq	848(%rsp), %rdi
	call	_ZN2cv3MatD1Ev@PLT
	leaq	752(%rsp), %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	40(%rsp), %rdi
	call	_ZN2cv3MatD1Ev@PLT
.L55:
	movq	64(%rsp), %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	72(%rsp), %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	%rbp, %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	%r13, %rdi
	call	_ZN2cv3MatD1Ev@PLT
	movq	%r12, %rdi
	call	_ZN2cv3MatD1Ev@PLT
.L57:
	movq	32(%rsp), %rdi
	call	_ZN2cv12VideoCaptureD1Ev@PLT
	movq	1000(%rsp), %rax
	subq	%fs:40, %rax
	je	.L58
.L83:
	call	__stack_chk_fail@PLT
.L56:
	movq	%r14, %rdi
	call	_ZN2cv3MatD1Ev@PLT
	jmp	.L55
	.cfi_endproc
.LFE10341:
	.section	.gcc_except_table
.LLSDAC10341:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC10341-.LLSDACSBC10341
.LLSDACSBC10341:
	.uleb128 .LEHB11-.LCOLDB17
	.uleb128 .LEHE11-.LEHB11
	.uleb128 0
	.uleb128 0
.LLSDACSEC10341:
	.section	.text.unlikely
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE17:
	.section	.text.startup
.LHOTE17:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1093567616
	.align 8
.LC2:
	.long	0
	.long	1077805056
	.align 8
.LC15:
	.long	0
	.long	1083129856
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
