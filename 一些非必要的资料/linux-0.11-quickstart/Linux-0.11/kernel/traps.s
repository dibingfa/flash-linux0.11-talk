	.file	"traps.c"
	.text
LC0:
	.ascii "%s: %04x\12\15\0"
	.align 32
LC1:
	.ascii "EIP:\11%04x:%p\12EFLAGS:\11%p\12ESP:\11%04x:%p\12\0"
LC2:
	.ascii "fs: %04x\12\0"
LC3:
	.ascii "base: %p, limit: %p\12\0"
LC7:
	.ascii "Pid: %d, process nr: %d\12\15\0"
LC8:
	.ascii "%02x \0"
LC9:
	.ascii "\12\15\0"
LC4:
	.ascii "Stack: \0"
LC5:
	.ascii "%p \0"
LC6:
	.ascii "\12\0"
	.p2align 2,,3
	.def	_die;	.scl	3;	.type	32;	.endef
_die:
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	20(%esp), %esi
	pushl	%ebx
	movzwl	28(%esp), %eax
	pushl	%eax
	pushl	24(%esp)
	pushl	$LC0
	call	_printk
	popl	%edx
	popl	%ecx
	pushl	12(%esi)
	pushl	16(%esi)
	pushl	8(%esi)
	pushl	(%esi)
	pushl	4(%esi)
	pushl	$LC1
	call	_printk
/APP
	mov %fs,%ax
/NO_APP
	addl	$24, %esp
	movzwl	%ax, %eax
	pushl	%eax
	pushl	$LC2
	call	_printk
	addl	$12, %esp
	movl	$23, %edx
	movl	_current, %eax
/APP
	lsll %edx,%ecx
	incl %ecx
/NO_APP
	addl	$728, %eax
/APP
	movb 7(%eax),%dh
	movb 4(%eax),%dl
	shll $16,%edx
	movw 2(%eax),%dx
/NO_APP
	pushl	%ecx
	pushl	%edx
	pushl	$LC3
	call	_printk
	addl	$16, %esp
	cmpl	$23, 16(%esi)
	je	L18
L3:
	xorl	%edx, %edx
	movl	%edx, %eax
/APP
	str %ax
	subl $32,%eax
	shrl $4,%eax
/NO_APP
	movl	%eax, %ebx
	pushl	%eax
	movzwl	%bx,%eax
	pushl	%eax
	movl	_current, %eax
	pushl	556(%eax)
	pushl	$LC7
	call	_printk
	xorl	%ebx, %ebx
	addl	$16, %esp
	.p2align 2,,3
L13:
	movl	4(%esi), %eax
	movl	(%esi), %edx
/APP
	push %fs;mov %ax,%fs;movb %fs:(%ebx,%edx),%al;pop %fs
/NO_APP
	subl	$8, %esp
	movzbl	%al, %eax
	pushl	%eax
	pushl	$LC8
	incl	%ebx
	call	_printk
	addl	$16, %esp
	cmpl	$9, %ebx
	jle	L13
	subl	$12, %esp
	pushl	$LC9
	call	_printk
	addl	$16, %esp
	movl	$11, 16(%esp)
	popl	%ebx
	popl	%esi
	popl	%edi
	jmp	_do_exit
L18:
	subl	$12, %esp
	pushl	$LC4
	call	_printk
	xorl	%ebx, %ebx
	addl	$16, %esp
	movl	$23, %edi
L8:
	subl	$8, %esp
	movl	12(%esi), %edx
	movl	%edi, %eax
/APP
	push %fs;mov %ax,%fs;movl %fs:(%edx,%ebx,4),%eax;pop %fs
/NO_APP
	pushl	%eax
	pushl	$LC5
	incl	%ebx
	call	_printk
	addl	$16, %esp
	cmpl	$3, %ebx
	jle	L8
	subl	$12, %esp
	pushl	$LC6
	call	_printk
	addl	$16, %esp
	jmp	L3
LC10:
	.ascii "double fault\0"
	.p2align 2,,3
.globl _do_double_fault
	.def	_do_double_fault;	.scl	2;	.type	32;	.endef
_do_double_fault:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC10
	call	_die
	addl	$28, %esp
	ret
LC11:
	.ascii "general protection\0"
	.p2align 2,,3
.globl _do_general_protection
	.def	_do_general_protection;	.scl	2;	.type	32;	.endef
_do_general_protection:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC11
	call	_die
	addl	$28, %esp
	ret
LC12:
	.ascii "divide error\0"
	.p2align 2,,3
.globl _do_divide_error
	.def	_do_divide_error;	.scl	2;	.type	32;	.endef
_do_divide_error:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC12
	call	_die
	addl	$28, %esp
	ret
	.align 32
LC13:
	.ascii "eax\11\11ebx\11\11ecx\11\11edx\12\15%8x\11%8x\11%8x\11%8x\12\15\0"
	.align 32
LC14:
	.ascii "esi\11\11edi\11\11ebp\11\11esp\12\15%8x\11%8x\11%8x\11%8x\12\15\0"
	.align 32
LC15:
	.ascii "\12\15ds\11es\11fs\11tr\12\15%4x\11%4x\11%4x\11%4x\12\15\0"
	.align 32
LC16:
	.ascii "EIP: %8x   CS: %4x  EFLAGS: %8x\12\15\0"
	.p2align 2,,3
.globl _do_int3
	.def	_do_int3;	.scl	2;	.type	32;	.endef
_do_int3:
	pushl	%ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$40, %esp
	movl	68(%esp), %eax
	movl	%eax, 36(%esp)
	movl	72(%esp), %eax
	movl	%eax, 32(%esp)
	movl	76(%esp), %eax
	movl	%eax, 28(%esp)
	movl	84(%esp), %eax
	movl	60(%esp), %esi
	movl	80(%esp), %ebp
	movl	88(%esp), %edi
	movl	%eax, 24(%esp)
	pushl	92(%esp)
	pushl	100(%esp)
	pushl	108(%esp)
	pushl	116(%esp)
	xorl	%ebx, %ebx
	movl	%ebx, %eax
	pushl	$LC13
/APP
	str %ax
/NO_APP
	movl	%eax, %ebx
	call	_printk
	addl	$20, %esp
	pushl	%esi
	pushl	%ebp
	pushl	%edi
	pushl	36(%esp)
	pushl	$LC14
	call	_printk
	addl	$20, %esp
	pushl	%ebx
	pushl	40(%esp)
	pushl	40(%esp)
	pushl	40(%esp)
	pushl	$LC15
	call	_printk
	movl	8(%esi), %eax
	movl	%eax, 92(%esp)
	movl	4(%esi), %eax
	movl	%eax, 88(%esp)
	movl	(%esi), %eax
	movl	%eax, 84(%esp)
	movl	$LC16, 80(%esp)
	addl	$60, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	jmp	_printk
LC17:
	.ascii "nmi\0"
	.p2align 2,,3
.globl _do_nmi
	.def	_do_nmi;	.scl	2;	.type	32;	.endef
_do_nmi:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC17
	call	_die
	addl	$28, %esp
	ret
LC18:
	.ascii "debug\0"
	.p2align 2,,3
.globl _do_debug
	.def	_do_debug;	.scl	2;	.type	32;	.endef
_do_debug:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC18
	call	_die
	addl	$28, %esp
	ret
LC19:
	.ascii "overflow\0"
	.p2align 2,,3
.globl _do_overflow
	.def	_do_overflow;	.scl	2;	.type	32;	.endef
_do_overflow:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC19
	call	_die
	addl	$28, %esp
	ret
LC20:
	.ascii "bounds\0"
	.p2align 2,,3
.globl _do_bounds
	.def	_do_bounds;	.scl	2;	.type	32;	.endef
_do_bounds:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC20
	call	_die
	addl	$28, %esp
	ret
LC21:
	.ascii "invalid operand\0"
	.p2align 2,,3
.globl _do_invalid_op
	.def	_do_invalid_op;	.scl	2;	.type	32;	.endef
_do_invalid_op:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC21
	call	_die
	addl	$28, %esp
	ret
LC22:
	.ascii "device not available\0"
	.p2align 2,,3
.globl _do_device_not_available
	.def	_do_device_not_available;	.scl	2;	.type	32;	.endef
_do_device_not_available:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC22
	call	_die
	addl	$28, %esp
	ret
LC23:
	.ascii "coprocessor segment overrun\0"
	.p2align 2,,3
.globl _do_coprocessor_segment_overrun
	.def	_do_coprocessor_segment_overrun;	.scl	2;	.type	32;	.endef
_do_coprocessor_segment_overrun:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC23
	call	_die
	addl	$28, %esp
	ret
LC24:
	.ascii "invalid TSS\0"
	.p2align 2,,3
.globl _do_invalid_TSS
	.def	_do_invalid_TSS;	.scl	2;	.type	32;	.endef
_do_invalid_TSS:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC24
	call	_die
	addl	$28, %esp
	ret
LC25:
	.ascii "segment not present\0"
	.p2align 2,,3
.globl _do_segment_not_present
	.def	_do_segment_not_present;	.scl	2;	.type	32;	.endef
_do_segment_not_present:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC25
	call	_die
	addl	$28, %esp
	ret
LC26:
	.ascii "stack segment\0"
	.p2align 2,,3
.globl _do_stack_segment
	.def	_do_stack_segment;	.scl	2;	.type	32;	.endef
_do_stack_segment:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC26
	call	_die
	addl	$28, %esp
	ret
LC27:
	.ascii "coprocessor error\0"
	.p2align 2,,3
.globl _do_coprocessor_error
	.def	_do_coprocessor_error;	.scl	2;	.type	32;	.endef
_do_coprocessor_error:
	subl	$12, %esp
	movl	_current, %eax
	cmpl	%eax, _last_task_used_math
	je	L35
L33:
	addl	$12, %esp
	ret
	.p2align 2,,3
L35:
	pushl	%eax
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC27
	call	_die
	addl	$16, %esp
	jmp	L33
LC28:
	.ascii "reserved (15,17-47) error\0"
	.p2align 2,,3
.globl _do_reserved
	.def	_do_reserved;	.scl	2;	.type	32;	.endef
_do_reserved:
	subl	$16, %esp
	pushl	24(%esp)
	pushl	24(%esp)
	pushl	$LC28
	call	_die
	addl	$28, %esp
	ret
	.p2align 2,,3
.globl _trap_init
	.def	_trap_init;	.scl	2;	.type	32;	.endef
_trap_init:
	pushl	%ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	$_divide_error, %edx
	movl	$524288, %eax
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt
	movl %edx,_idt+4
/NO_APP
	movl	$_debug, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+8
	movl %edx,_idt+12
/NO_APP
	movl	$_nmi, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+16
	movl %edx,_idt+20
/NO_APP
	movl	$_int3, %edx
/APP
	movw %dx,%ax
	movw $-4352,%dx
	movl %eax,_idt+24
	movl %edx,_idt+28
/NO_APP
	movl	$_overflow, %edx
/APP
	movw %dx,%ax
	movw $-4352,%dx
	movl %eax,_idt+32
	movl %edx,_idt+36
/NO_APP
	movl	$_bounds, %edx
/APP
	movw %dx,%ax
	movw $-4352,%dx
	movl %eax,_idt+40
	movl %edx,_idt+44
/NO_APP
	movl	$_invalid_op, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+48
	movl %edx,_idt+52
/NO_APP
	movl	$_device_not_available, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+56
	movl %edx,_idt+60
/NO_APP
	movl	$_double_fault, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+64
	movl %edx,_idt+68
/NO_APP
	movl	$_coprocessor_segment_overrun, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+72
	movl %edx,_idt+76
/NO_APP
	movl	$_invalid_TSS, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+80
	movl %edx,_idt+84
/NO_APP
	movl	$_segment_not_present, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+88
	movl %edx,_idt+92
/NO_APP
	movl	$_stack_segment, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+96
	movl %edx,_idt+100
/NO_APP
	movl	$_general_protection, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+104
	movl %edx,_idt+108
/NO_APP
	movl	$_page_fault, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+112
	movl %edx,_idt+116
/NO_APP
	movl	$_reserved, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+120
	movl %edx,_idt+124
/NO_APP
	movl	$_coprocessor_error, %edx
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+128
	movl %edx,_idt+132
/NO_APP
	movl	$17, %edi
	movl	$_idt, %esi
	movl	$_idt+4, %ebx
	movl	$_reserved, %ecx
	movl	$524288, %ebp
	.p2align 2,,3
L42:
	movl	%ecx, %edx
	movl	%ebp, %eax
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,(%esi,%edi,8)
	movl %edx,(%ebx,%edi,8)
/NO_APP
	incl	%edi
	cmpl	$47, %edi
	jle	L42
	movl	$_irq13, %edx
	movl	$524288, %eax
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+360
	movl %edx,_idt+364
/NO_APP
	movl	$33, %edx
/APP
	inb %dx,%al
	jmp 1f
1:	jmp 1f
1:
/NO_APP
	andl	$251, %eax
/APP
	outb %al,%dx
	jmp 1f
1:	jmp 1f
1:
/NO_APP
	movl	$161, %edx
/APP
	inb %dx,%al
	jmp 1f
1:	jmp 1f
1:
/NO_APP
	andl	$223, %eax
/APP
	outb %al,%dx
/NO_APP
	movl	$_parallel_interrupt, %edx
	movl	$524288, %eax
/APP
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,_idt+312
	movl %edx,_idt+316
/NO_APP
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.def	_parallel_interrupt;	.scl	2;	.type	32;	.endef
	.def	_irq13;	.scl	2;	.type	32;	.endef
	.def	_coprocessor_error;	.scl	2;	.type	32;	.endef
	.def	_reserved;	.scl	2;	.type	32;	.endef
	.def	_page_fault;	.scl	2;	.type	32;	.endef
	.def	_general_protection;	.scl	2;	.type	32;	.endef
	.def	_stack_segment;	.scl	2;	.type	32;	.endef
	.def	_segment_not_present;	.scl	2;	.type	32;	.endef
	.def	_invalid_TSS;	.scl	2;	.type	32;	.endef
	.def	_coprocessor_segment_overrun;	.scl	2;	.type	32;	.endef
	.def	_double_fault;	.scl	2;	.type	32;	.endef
	.def	_device_not_available;	.scl	2;	.type	32;	.endef
	.def	_invalid_op;	.scl	2;	.type	32;	.endef
	.def	_bounds;	.scl	2;	.type	32;	.endef
	.def	_overflow;	.scl	2;	.type	32;	.endef
	.def	_int3;	.scl	2;	.type	32;	.endef
	.def	_nmi;	.scl	2;	.type	32;	.endef
	.def	_debug;	.scl	2;	.type	32;	.endef
	.def	_divide_error;	.scl	2;	.type	32;	.endef
	.def	_do_exit;	.scl	2;	.type	32;	.endef
	.def	_printk;	.scl	2;	.type	32;	.endef
