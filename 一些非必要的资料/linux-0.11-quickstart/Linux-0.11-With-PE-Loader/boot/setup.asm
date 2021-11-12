;
;	setup.s		(C) 1991 Linus Torvalds
;
; setup.s is responsible for getting the system data from the BIOS,
; and putting them into the appropriate places in system memory.
; both setup.s and system has been loaded by the bootblock.
;
; This code asks the bios for memory/disk/other parameters, and
; puts them in a "safe" place: 0x90000-0x901FF, ie where the
; boot-block used to be. It is then up to the protected mode
; system to read them from there before the area is overwritten
; for buffer-blocks.
;

; NOTE; These had better be the same as in bootsect.s;

INITSEG  equ 0x9000	; we move boot here - out of the way
SYSSEG   equ 0x1000	; system loaded at 0x10000 (65536).
SETUPSEG equ 0x9020	; this is the current segment

SYSTEM_ADDRESS equ 0x50000
DESTINATION_ADDRESS equ 0x0000


%include "pm.inc"
%include "protect.inc"
%include "pestruc.inc"

start:
; ok, the read went well so we get current cursor position and save it for
; posterity.
	mov	ax,INITSEG	; this is done in bootsect already, but...
	mov	ds,ax
	mov	ah,0x03	; read cursor pos
	xor	bh,bh
	int	0x10		; save it in known place, con_init fetches
	mov	[0],dx		; it from 0x90000.
; Get memory size (extended mem, kB)

	mov	ah,0x88
	int	0x15
	mov	[2],ax

; Get video-card data:

	mov	ah,0x0f
	int	0x10
	mov	[4],bx		; bh = display page
	mov	[6],ax		; al = video mode, ah = window width

; check for EGA/VGA and some config parameters

	mov	ah,0x12
	mov	bl,0x10
	int	0x10
	mov	[8],ax
	mov	[10],bx
	mov	[12],cx

; Get hd0 data

	mov	ax,0x0000
	mov	ds,ax
	lds	si,[4*0x41]
	mov	ax,INITSEG
	mov	es,ax
	mov	di,0x0080
	mov	cx,0x10
	rep
	movsb

; Get hd1 data

	mov	ax,0x0000
	mov	ds,ax
	lds	si,[4*0x46]
	mov	ax,INITSEG
	mov	es,ax
	mov	di,0x0090
	mov	cx,0x10
	rep
	movsb

; Check that there IS a hd1 :-)

	mov	ax,0x01500
	mov	dl,0x81
	int	0x13
	jc	no_disk1
	cmp	ah,3
	je	is_disk1
no_disk1:
	mov	ax,INITSEG
	mov	es,ax
	mov	di,0x0090
	mov	cx,0x10
	mov	ax,0x00
	rep
	stosb
is_disk1:

; now we want to move to protected mode ...

	cli			; no interrupts allowed ;

; first we move the system to it's rightful place

;--将System 模块从0x10000移到0x50000位置,这里默认System模块不会超过256KB
;--因为从PE格式的System模块中解析中的代码和数据可能会覆盖掉0x10000的代码,这样使会使数据还没完全按它的Virtual Address放好
;--原数据就已经破坏了
	mov	ax,0x1000
	mov ds,ax
	mov ax,0x5000
	mov es,ax
	cld			; 'direction'=0, movs moves forward
do_move:
	sub	di,di
	sub	si,si
	mov cx,0x8000
	rep
	movsw
	
	mov ax,ds
	add ax,0x1000
	cmp ax,0x5000
	jz end_move
	
	mov ds,ax

	mov ax,es 
	add ax,0x1000
	mov es,ax
	jmp	do_move

; then we load the segment descriptors

end_move:
	mov	ax,SETUPSEG	; right, forgot this at first. didn't work :-)
	mov	ds,ax
  
  mov eax,0x9000 
  mov es,ax
  
  mov ax,0x800
  mov [es:gdt_48_offset],ax
  mov eax,0x90200 +gdt
  mov dword [es:gdt_48_offset+2],0x90200+gdt

  xor eax,eax 
  mov word  [es:idt_48_offset],ax 
  mov dword [idt_48_offset+2],eax
  
;	lidt	[idt_48]		; load idt with 0,0
;	lgdt	[gdt_48]		; load gdt with whatever appropriate
	lgdt	[gdt_ptr]
; that was painless, now we enable A20

	call	empty_8042
	mov	al,0xD1		; command write
	out	0x64,al
	call	empty_8042
	mov	al,0xDF		; A20 on
	out	0x60,al
	call	empty_8042

; well, that went ok, I hope. Now we have to reprogram the interrupts :-(
; we put them right after the intel-reserved hardware interrupts, at
; int 0x20-0x2F. There they won't mess up anything. Sadly IBM really
; messed this up with the original PC, and they haven't been able to
; rectify it afterwards. Thus the bios puts interrupts at 0x08-0x0f,
; which is used for the internal hardware interrupts as well. We just
; have to reprogram the 8259's, and it isn't fun.

	mov	al,0x11		; initialization sequence
	out	0x20,al		; send it to 8259A-1
	dw	0x00eb,0x00eb		; jmp $+2, jmp $+2
	out	0xA0,al		; and to 8259A-2
	dw	0x00eb,0x00eb
	mov	al,0x20		; start of hardware int's (0x20)
	out	0x21,al
	dw	0x00eb,0x00eb
	mov	al,0x28		; start of hardware int's 2 (0x28)
	out	0xA1,al
	dw	0x00eb,0x00eb
	mov	al,0x04		; 8259-1 is master
	out	0x21,al
	dw	0x00eb,0x00eb
	mov	al,0x02		; 8259-2 is slave
	out	0xA1,al
	dw	0x00eb,0x00eb
	mov	al,0x01		; 8086 mode for both
	out	0x21,al
	dw	0x00eb,0x00eb
	out	0xA1,al
	dw	0x00eb,0x00eb
	mov	al,0xFF		; mask off all interrupts for now
	out	0x21,al
	dw	0x00eb,0x00eb
	out	0xA1,al

; well, that certainly wasn't fun :-(. Hopefully it works, and we don't
; need no steenking BIOS anyway (except for the initial loading :-).
; The BIOS-routine wants lots of unnecessary data, and it's less
; "interesting" anyway. This is how REAL programmers do it.
;
; Well, now's the time to actually move into protected mode. To make
; things as simple as possible, we do no register set-up or anything,
; we let the gnu-compiled 32-bit programs do that. We just jump to
; absolute address 0x00000, in 32-bit protected mode.



;	mov	ax,0x0001	; protected mode (PE) bit
;	lmsw	ax		; This is it;
;	jmp	8:0		; jmp offset 0 of segment 8 (cs)


;--设置代码段描述符的基址
  SetDescriptor_Base Code32Desc ,InitKernel + SETUPSEG * 16
   
;-- 打开地址线A20
	in	al, 92h
	or	al, 00000010b
	out	92h, al

	; 准备切换到保护模式
	mov	eax, cr0
	or	eax, 1
	mov	cr0, eax 
;--进入保护模式,开始在保护模式下执行InitKernel	
  jmp dword SelectorCode:0
  
; This routine checks that the keyboard command queue is empty
; No timeout is used - if this hangs there is something wrong with
; the machine, and we probably couldn't proceed anyway.
empty_8042:
	dw	0x00eb,0x00eb
	in	al,0x64	; 8042 status port
	test	al,2		; is input buffer full?
	jnz	empty_8042	; yes - loop
	ret
	
gdt:
	dw	0,0,0,0		; dummy
	
	dw	0x07FF		; 8Mb - limit=2047 (2048*4096=8Mb)
	dw	0x0000		; base address=0
	dw	0x9A00		; code read/exec
	dw	0x00C0		; granularity=4096, 386
	
	dw	0x07FF		; 8Mb - limit=2047 (2048*4096=8Mb)
	dw	0x0000		; base address=0
	dw	0x9200		; data read/write
	dw	0x00C0		; granularity=4096, 386
_idt_48:
	dw	0			; idt limit=0
	dw	0,0			; idt base=0L
_gdt_48:
	dw	0x800		; gdt limit=2048, 256 GDT entries
	dw	512+gdt,0x9	; gdt base = 0X9xxxx


[SECTION .s32]
ALIGN	32
[BITS	32]
InitKernel:
	mov	ax, SelectorVideo
	mov	gs, ax
	mov	ax, SelectorSystemData
	mov	ds, ax
	mov	es, ax
	mov	fs, ax

;--内核初始化
  xor eax,eax
  mov [sectionHeader],eax
  mov [counter],eax
  mov [numberOfSection],eax

	mov	eax, SYSTEM_ADDRESS
	add	eax, [eax+IMAGE_DOS_HEADER.e_lfanew]       ;-- 得到IMAGE_NT_HEADERS结构的基址

;--IMAGE_NT_HEADER.FileHeader.NumberOfSections 
 movzx edx,WORD [eax+IMAGE_NT_HEADERS.FileHeader+IMAGE_FILE_HEADER.NumberOfSections]        
 mov [numberOfSection],edx
 
;--获取基址
 mov edx,[eax+IMAGE_NT_HEADERS.OptionalHeader + IMAGE_OPTIONAL_HEADER32.ImageBase];
 mov [imageBase],edx

 ;--获取入口地址,入口地址=imageBase + EntryPoint,这已经是一个线性地址了
 mov edx,[eax+IMAGE_NT_HEADERS.OptionalHeader + IMAGE_OPTIONAL_HEADER32.AddressOfEntryPoint];
 add edx,[imageBase]
 mov [addressOfEntryPoint],edx
 
 add eax,IMAGE_NT_HEADERS_size ;
 mov [sectionHeader],eax       ;保存IMAGE_SECTION_HEADER的基址   

LoadData: 
  mov eax,[counter]
	cmp	eax, [numberOfSection]
	jge	SHORT finish
 
  mov edx,[sectionHeader]

;--移动的字节数
	mov eax,[edx+IMAGE_SECTION_HEADER.SizeOfRawData]
	jz 	next
	mov ecx,eax
	add [systemSize],ecx
	
;--源地址
	mov eax,[edx+IMAGE_SECTION_HEADER.PointerToRawData]
	add eax,SYSTEM_ADDRESS
	mov esi,eax
;--目标地址  
	mov eax,[edx+IMAGE_SECTION_HEADER.VirtualAddress]
	add eax,[imageBase]
	mov edi,eax
	rep movsb 
		
	mov eax,[sectionHeader]
	add eax,IMAGE_SECTION_HEADER_size
  mov [sectionHeader],eax 
  
next:  
  mov eax, [counter]
	inc eax
	mov [counter],eax
	jmp	SHORT LoadData

finish:

  lgdt [gdt_48];
  lidt [idt_48]
  
;--跳入内核!!我们已经将工作做完了,剩下的就交给Linux-0.11去做吧:)
  jmp 8:0

SEG_CODE_LEN equ $-InitKernel
[SECTION .data]
[BITS 32]
;               变量名     段基址    ,    段界限      ,   属性
GDT_TABEL:   
              dw 0,0,0,0            
NewDescriptor Code32Desc,  0,        SEG_CODE_LEN - 1, DA_CR  | DA_32    ; 代码段
NewDescriptor SystemDesc,  0,        0x90200,          DA_DRW | DA_32    ;数据段
NewDescriptor VideoDesc ,  0xB8000,  0x0ffff,          DA_DRW | DA_DPL3	 ; 显存首地址

gdt_ptr		dw	gdt_len - 1				           ; 段界限
          dd	0x90200 + GDT_TABEL 		     ; 基地址

SelectorCode          equ	Code32Desc  - GDT_TABEL
SelectorSystemData		equ	SystemDesc	- GDT_TABEL
SelectorVideo         equ VideoDesc   - GDT_TABEL
gdt_len		equ	$ - GDT_TABEL

;========================================================
;内核初始化要用到的变量
numberOfSection      equ  0x90100       ;SECTION总数
sectionHeader        equ  0x90104       ;IMAGE_SECTION_HEADER 指针
counter              equ  0x90108       ;计数器
addressOfEntryPoint  equ  0x9010C       ;内核开始执行的入口地址
imageBase            equ  0x90110       ;内核加载的基地址
systemSize           equ  0x90114       ;内核加载的基地址	


gdt_48_offset				 equ  0x118
idt_48_offset 			 equ  0x120

gdt_48							 equ  0x90118
idt_48 							 equ  0x90120

