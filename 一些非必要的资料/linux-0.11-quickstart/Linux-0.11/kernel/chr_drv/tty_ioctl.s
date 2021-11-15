	.file	"tty_ioctl.c"
	.data
	.align 32
_quotient:
	.word	0
	.word	2304
	.word	1536
	.word	1047
	.word	857
	.word	768
	.word	576
	.word	384
	.word	192
	.word	96
	.word	64
	.word	48
	.word	24
	.word	12
	.word	6
	.word	3
	.text
	.p2align 2,,3
	.def	_change_speed;	.scl	3;	.type	32;	.endef
_change_speed:
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	16(%esp), %eax
	movw	48(%eax), %si
	testw	%si, %si
	je	L1
	movl	8(%eax), %eax
	andl	$15, %eax
	movw	_quotient(%eax,%eax), %cx
/APP
	cli
/NO_APP
	movzwl	%si, %edi
	leal	3(%edi), %ebx
	movl	$128, %eax
	movl	%ebx, %edx
/APP
	outb %al,%dx
	jmp 1f
1:	jmp 1f
1:
/NO_APP
	movzbl	%cl, %eax
	movl	%esi, %edx
/APP
	outb %al,%dx
	jmp 1f
1:	jmp 1f
1:
/NO_APP
	movzbl	%ch, %ecx
	leal	1(%edi), %edx
	movl	%ecx, %eax
/APP
	outb %al,%dx
	jmp 1f
1:	jmp 1f
1:
/NO_APP
	movl	%ebx, %edx
	movl	$3, %eax
/APP
	outb %al,%dx
	sti
/NO_APP
L1:
	popl	%ebx
	popl	%esi
	popl	%edi
	ret
	.p2align 2,,3
	.def	_flush;	.scl	3;	.type	32;	.endef
_flush:
	movl	4(%esp), %edx
/APP
	cli
/NO_APP
	movl	8(%edx), %eax
	movl	%eax, 4(%edx)
/APP
	sti
/NO_APP
	ret
	.p2align 2,,3
	.def	_wait_until_sent;	.scl	3;	.type	32;	.endef
_wait_until_sent:
	ret
	.p2align 2,,3
	.def	_send_break;	.scl	3;	.type	32;	.endef
_send_break:
	ret
	.p2align 2,,3
	.def	_get_termios;	.scl	3;	.type	32;	.endef
_get_termios:
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	movl	24(%esp), %esi
	movl	28(%esp), %ebx
	pushl	$36
	pushl	%ebx
	call	_verify_area
	xorl	%edx, %edx
	addl	$16, %esp
	.p2align 2,,3
L12:
	movb	(%edx,%esi), %al
/APP
	movb %al,%fs:(%edx,%ebx)
/NO_APP
	incl	%edx
	cmpl	$35, %edx
	jbe	L12
	popl	%edx
	popl	%ebx
	xorl	%eax, %eax
	popl	%esi
	ret
	.p2align 2,,3
	.def	_set_termios;	.scl	3;	.type	32;	.endef
_set_termios:
	pushl	%ebx
	subl	$8, %esp
	movl	16(%esp), %ebx
	movl	20(%esp), %ecx
	xorl	%edx, %edx
	.p2align 2,,3
L21:
/APP
	movb %fs:(%edx,%ecx),%al
/NO_APP
	movb	%al, (%edx,%ebx)
	incl	%edx
	cmpl	$35, %edx
	jbe	L21
	subl	$12, %esp
	pushl	%ebx
	call	_change_speed
	addl	$24, %esp
	xorl	%eax, %eax
	popl	%ebx
	ret
	.p2align 2,,3
	.def	_get_termio;	.scl	3;	.type	32;	.endef
_get_termio:
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	movl	56(%esp), %esi
	movl	60(%esp), %ebx
	pushl	$18
	pushl	%ebx
	call	_verify_area
	movw	(%esi), %ax
	movw	%ax, 16(%esp)
	movw	4(%esi), %ax
	movw	%ax, 18(%esp)
	movw	8(%esi), %ax
	movw	%ax, 20(%esp)
	movw	12(%esi), %ax
	movw	%ax, 22(%esp)
	movb	16(%esi), %al
	movb	%al, 24(%esp)
	xorl	%edx, %edx
	addl	$16, %esp
	.p2align 2,,3
L29:
	movb	17(%edx,%esi), %al
	movb	%al, 9(%esp,%edx)
	incl	%edx
	cmpl	$7, %edx
	jle	L29
	xorl	%edx, %edx
	.p2align 2,,3
L35:
	movb	(%esp,%edx), %al
/APP
	movb %al,%fs:(%edx,%ebx)
/NO_APP
	incl	%edx
	cmpl	$17, %edx
	jbe	L35
	addl	$36, %esp
	popl	%ebx
	xorl	%eax, %eax
	popl	%esi
	ret
	.p2align 2,,3
	.def	_set_termio;	.scl	3;	.type	32;	.endef
_set_termio:
	pushl	%ebx
	subl	$40, %esp
	movl	48(%esp), %ebx
	movl	52(%esp), %ecx
	xorl	%edx, %edx
	.p2align 2,,3
L46:
/APP
	movb %fs:(%edx,%ecx),%al
/NO_APP
	movb	%al, (%esp,%edx)
	incl	%edx
	cmpl	$17, %edx
	jbe	L46
	movl	(%esp), %eax
	movw	%ax, (%ebx)
	movw	2(%esp), %ax
	movw	%ax, 4(%ebx)
	movl	4(%esp), %eax
	movw	%ax, 8(%ebx)
	movw	6(%esp), %ax
	movw	%ax, 12(%ebx)
	movb	8(%esp), %al
	movb	%al, 16(%ebx)
	xorl	%edx, %edx
	.p2align 2,,3
L51:
	movb	9(%esp,%edx), %al
	movb	%al, 17(%edx,%ebx)
	incl	%edx
	cmpl	$7, %edx
	jle	L51
	subl	$12, %esp
	pushl	%ebx
	call	_change_speed
	addl	$56, %esp
	xorl	%eax, %eax
	popl	%ebx
	ret
LC0:
	.ascii "tty_ioctl: dev<0\0"
	.p2align 2,,3
.globl _tty_ioctl
	.def	_tty_ioctl;	.scl	2;	.type	32;	.endef
_tty_ioctl:
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	16(%esp), %ebx
	movl	%ebx, %eax
	shrl	$8, %eax
	cmpl	$5, %eax
	movl	20(%esp), %esi
	movl	24(%esp), %edi
	je	L107
	andl	$255, %ebx
L59:
	leal	(%ebx,%ebx,4), %eax
	leal	(%eax,%eax,4), %eax
	sall	$2, %eax
	subl	%ebx, %eax
	leal	-21505(%esi), %edx
	sall	$5, %eax
	cmpl	$26, %edx
	leal	_tty_table(%eax), %ebx
	movl	$-22, %eax
	ja	L56
	jmp	*L100(,%edx,4)
	.p2align 2
	.align 4
L100:
	.long	L61
	.long	L64
	.long	L63
	.long	L62
	.long	L65
	.long	L68
	.long	L67
	.long	L66
	.long	L69
	.long	L98
	.long	L72
	.long	L98
	.long	L98
	.long	L98
	.long	L82
	.long	L84
	.long	L86
	.long	L98
	.long	L98
	.long	L98
	.long	L98
	.long	L98
	.long	L98
	.long	L98
	.long	L98
	.long	L98
	.long	L88
L61:
	movl	%edi, 20(%esp)
	movl	%ebx, 16(%esp)
	popl	%ebx
	popl	%esi
	popl	%edi
	jmp	_get_termios
L64:
	movl	%edi, 20(%esp)
	movl	%ebx, 16(%esp)
	popl	%ebx
	popl	%esi
	popl	%edi
	jmp	_set_termios
L63:
	subl	$12, %esp
	pushl	%ebx
	call	_wait_until_sent
	addl	$16, %esp
	jmp	L64
L62:
	subl	$12, %esp
	leal	48(%ebx), %eax
	pushl	%eax
	call	_flush
	addl	$16, %esp
	jmp	L63
L65:
	movl	%edi, 20(%esp)
	movl	%ebx, 16(%esp)
	popl	%ebx
	popl	%esi
	popl	%edi
	jmp	_get_termio
L68:
	movl	%edi, 20(%esp)
	movl	%ebx, 16(%esp)
	popl	%ebx
	popl	%esi
	popl	%edi
	jmp	_set_termio
L67:
	subl	$12, %esp
	pushl	%ebx
	call	_wait_until_sent
	addl	$16, %esp
	jmp	L68
L66:
	subl	$12, %esp
	leal	48(%ebx), %eax
	pushl	%eax
	call	_flush
	addl	$16, %esp
	jmp	L67
L69:
	testl	%edi, %edi
	jne	L104
	subl	$12, %esp
	pushl	%ebx
	call	_wait_until_sent
	movl	%ebx, (%esp)
	call	_send_break
L105:
	addl	$16, %esp
L104:
	xorl	%eax, %eax
	.p2align 2,,3
L56:
	popl	%ebx
	popl	%esi
	popl	%edi
	ret
L72:
	testl	%edi, %edi
	je	L108
	cmpl	$1, %edi
	je	L109
	cmpl	$2, %edi
	je	L110
	.p2align 2,,3
L98:
	movl	$-22, %eax
	jmp	L56
L110:
	subl	$12, %esp
	leal	48(%ebx), %eax
	pushl	%eax
	call	_flush
	popl	%ecx
L101:
	leal	1088(%ebx), %eax
L102:
	pushl	%eax
	call	_flush
	jmp	L105
L109:
	subl	$12, %esp
	jmp	L101
L108:
	subl	$12, %esp
	leal	48(%ebx), %eax
	jmp	L102
L82:
	subl	$8, %esp
	pushl	$4
	pushl	%edi
	call	_verify_area
	addl	$16, %esp
	movl	36(%ebx), %eax
L106:
/APP
	movl %eax,%fs:(%edi)
/NO_APP
	jmp	L104
L84:
/APP
	movl %fs:(%edi),%eax
/NO_APP
	movl	%eax, 36(%ebx)
	jmp	L104
L86:
	subl	$8, %esp
	pushl	$4
	pushl	%edi
	call	_verify_area
	movl	1092(%ebx), %eax
	addl	$16, %esp
	subl	1096(%ebx), %eax
L103:
	andl	$1023, %eax
	jmp	L106
L88:
	subl	$8, %esp
	pushl	$4
	pushl	%edi
	call	_verify_area
	movl	2132(%ebx), %eax
	addl	$16, %esp
	subl	2136(%ebx), %eax
	jmp	L103
	.p2align 2,,3
L107:
	movl	_current, %eax
	movl	616(%eax), %ebx
	testl	%ebx, %ebx
	jns	L59
	subl	$12, %esp
	pushl	$LC0
	call	_panic
	addl	$16, %esp
	jmp	L59
	.def	_panic;	.scl	2;	.type	32;	.endef
	.def	_verify_area;	.scl	2;	.type	32;	.endef
