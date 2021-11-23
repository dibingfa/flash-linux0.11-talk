; COMBINE.ASM	Interrupt List combiner
;		by Ralf Brown
;		last edit: 22mar98

		NAME	COMBINE
		TITLE	Combine Interrupt List sections

; declare all the segments in the order in which they are to appear in the
; executable
CODE	SEGMENT 'CODE'
CODE	ENDS
STACKSEG SEGMENT PUBLIC WORD 'STACK'
STACKSEG ENDS
BUFFERSEG SEGMENT PUBLIC WORD 'DATA'
BUFFERSEG ENDS
;
DGROUP	GROUP	CODE,STACKSEG,BUFFERSEG

;;------------------------------------------------------------------------

FFBLK struc
  ff_reserved	db 15h dup (?)
  ff_attrib	db ?
  ff_ftime	dw ?
  ff_fdate	dw ?
  ff_fsize	dd ?
  ff_fname	db 13 dup (?)
FFBLK ends

;;------------------------------------------------------------------------

CODE	SEGMENT 'CODE'
	ORG	100h			; this is a .COM file
	ASSUME	CS:DGROUP,DS:DGROUP,ES:DGROUP,SS:DGROUP

combine:
	jmp	near ptr main

banner		db	13,"COMBINE v2.10",9,"Ralf Brown 1996,1998",13,10,"$",26
usage_msg	db	"Usage:",9,"COMBINE [options] dest-dir",13,10
		db	9,"where {dest-dir} is the directory in which to place",13,10
		db	9,"  the combined list ('.' for the current directory)",13,10
		db	10
		db	9,"options:",13,10
		db	9,9,"-d",9,"delete sections after copying",13,10
		db	9,9,"-p",9,"combine PORTS.LST instead of INTERRUP.LST",13,10
		db	10
		db	"All sections of the interrupt/ports list must be in the current directory."
		db	"$"

bad_dos_msg	db	"Need DOS 2.0+$"
bad_drive_msg	db	"Invalid destination drive$"
no_mem_msg	db	"Insufficient memory$"
no_files_msg	db	"No section files found!$"
readerr_msg	db	"Read Error$"
writeerr_msg	db	"Write Error$"
diskfull_msg	db	"Disk full? while writing$"
no_disk_msg	db	"Out of space on destination drive",13,10,"$"
retry_msg	db	"Try again with -d to delete while copying$"

cant_create_msg db	"Check directory name -- unable to create "
combined_file	db	"INTERRUP.LST",0,"$"
combined_file2	db	"PORTS.LST",0
combined_file2_len equ $-combined_file2
section_file1	db	"INTERRUP.A",0,"$"
section_letter equ section_file1+9
section_file2	db	"   PORTS"
section_file2_len equ $-section_file2
section_file2_ofs equ 3
missing_msg	db	"unavailable (skipped)"
crlf		db	13,10,"$"
section_heading1 db	"Interrupt List, part "
section_hdr_len1 equ $-section_heading1
section_heading2 db	"Ports List, part "
section_hdr_len2 equ $-section_heading2
complete_msg	db	"Done.$"

;
; flags affecting operation
;
del_after_copy	db	0
section_file	dw	offset section_file1
section_heading dw	offset section_heading1
section_hdr_len	dw	section_hdr_len1

;
; data needed while processing
;
filehandle	equ	di		; output file's handle
numsections	db	26
dest_drive	db	0
nondefault_dest	db	0
ftime		dw	0
fdate		dw	0
filesize_lo	dw	0
filesize_hi	equ	bp

; (since we don't use disk_buffer until after FindFirst is no longer needed,
; save memory by overlaying the two)
FindFirst	equ	DGROUP:disk_buffer

;;------------------------------------------------------------------------

write_string:
	mov	ah,9
	int	21h
	ret

;;------------------------------------------------------------------------

skip_whitespace:
	lodsb
	cmp	al,' '
	je	skip_whitespace
	cmp	al,9
	je	skip_whitespace
	dec	si			; unget the last character
	; set ZF to indicate whether we got to end of cmdline
	cmp	al,0Dh
	ret

;;------------------------------------------------------------------------

get_destination_file:
	mov	bx,si			; remember start of destination name
get_dest_file_loop:
	lodsb
	cmp	al,' '
	je	got_dest_end
	cmp	al,9
	je	got_dest_end
	cmp	al,0Dh
	jne	get_dest_file_loop
got_dest_end:
	dec	si			; unget last character
	mov	di,si
	mov	al,[si-1]		; check end of path -- is it terminated
	cmp	al,'\'			;   by a slash or backslash?
	je	dest_has_slash
	cmp	al,'/'
	je	dest_has_slash
	cmp	al,':'
	je	dest_has_slash
	mov	al,'\'
	stosb
dest_has_slash:
	mov	si,offset combined_file
dest_copy_loop:
	lodsb
	stosb
	cmp	al,0
	jne	dest_copy_loop
	; OK, now open the destination file
	; (BX is still pointing at start of pathname)
	cmp	byte ptr [bx+1],':'
	jne	got_dest_drive
	mov	al,[bx]
	and	al,0DFh			; force to uppercase
	sub	al,'A'
	jb	got_dest_drive
	cmp	al,dest_drive
	je	got_dest_drive
	mov	dest_drive,al
	mov	nondefault_dest,al
got_dest_drive:
	mov	ah,3Ch			; create the output file
	xor	cx,cx			; no special file attributes
	mov	dx,bx
	int	21h
	mov	dx,offset cant_create_msg
	jc	exit_with_err_2
	mov	filehandle,ax
	ret

;;------------------------------------------------------------------------

check_total_size:
	mov	byte ptr section_letter,'A'-1
	mov	ah,1Ah			; set DTA
	mov	dx,offset FindFirst
	int	21h
	xor	si,si			; keep track of # of sections found
check_size_loop:
	inc	byte ptr section_letter
	cmp	byte ptr section_letter,'Z'
	ja	short get_free_space
	mov	ah,4Eh			; find first
	mov	cx,001Fh		; ...regardless of attribute
	mov	dx,section_file
	int	21h
	jc	check_size_loop
	inc	si			; another section found
	mov	ax,FindFirst.ff_ftime
	mov	ftime,ax
	mov	ax,FindFirst.ff_fdate
	mov	fdate,ax
	mov	ax,word ptr FindFirst.ff_fsize
	mov	dx,word ptr FindFirst.ff_fsize+2
	cmp	del_after_copy,0
	je	count_full_size
	cmp	nondefault_dest,0
	jnz	count_full_size
	cmp	dx,filesize_hi
	jb	check_size_loop
	ja	check_size_bigger
	cmp	ax,filesize_lo
	jbe	check_size_loop
check_size_bigger:
	mov	filesize_lo,ax
	mov	filesize_hi,dx
	jmp	check_size_loop

count_full_size:
	add	filesize_lo,ax
	adc	filesize_hi,dx
	jmp	check_size_loop

get_free_space:
	test	si,si			; check number of sections found
	mov	dx,offset no_files_msg
	jz	short exit_with_err_2
	mov	dl,dest_drive
	inc	dx
	mov	ah,36h			; get free disk space
	int	21h
	cmp	ax,0FFFFh
	jne	got_free_space
	mov	dx,offset bad_drive_msg
exit_with_err_2:
	jmp	near ptr exit_with_errmsg
got_free_space:
	mul	cx			; DX:AX <- AX*CX
	mov	cx,dx			; store high half of intermediate
	mul	bx			; DX:AX <- low(AX*CX)*BX
	xchg	ax,bx			; store low half of second interm.
	xchg	cx,dx			; store high half of second interm.
	mul	dx			; DX:AX <- high(AX*CX)*BX
	xchg	ax,bx			; DX:BX:0000h + CX:AX = result
	add	bx,cx
	adc	dx,0			; DX:BX:AX = AX*BX*CX = free space
	jnz	plenty_free_space	; >4G free?
	sub	ax,filesize_lo
	sbb	bx,filesize_hi
	jnb	plenty_free_space
not_enough_space:
	mov	dx,offset no_disk_msg
	call	write_string
	cmp	nondefault_dest,0
	jnz	size_check_failed
	cmp	del_after_copy,0
	jne	size_check_failed
	mov	dx,offset retry_msg
	call	write_string
size_check_failed:
	mov	al,2
	jmp	exit
plenty_free_space:
	ret

;;------------------------------------------------------------------------

check_section_header:
	push	si
	push	di
	mov	si,offset DGROUP:disk_buffer
	mov	di,section_heading
	mov	cx,section_hdr_len
	or	cx,cx
	rep	cmpsb
	jnz	not_section_heading
scan_curr_section:
	lodsb
	cmp	al,' '			; scan for the " of "
	jne	scan_curr_section
	add	si,3			; skip "of "
	xor	cl,cl
num_sections_loop:
	lodsb
	sub	al,'0'
	jb	num_sections_done
	cmp	al,9
	ja	num_sections_done
	mov	ch,al
	mov	al,10
	mul	cl
	mov	cl,al
	add	cl,ch
	jmp	num_sections_loop
num_sections_done:
	mov	numsections,cl
got_num_sections:
not_section_heading:	
	pop	di
	pop	si
	ret

;;------------------------------------------------------------------------

; in:	SI = file handle for current section
copy_section:
	mov	ax,4201h
	xor	cx,cx
	xor	dx,dx
	mov	bx,filehandle
	int	21h
	mov	filesize_lo,ax
	mov	filesize_hi,dx
copy_section_loop:
	mov	ah,3Fh
	mov	bx,si
	mov	cx,disk_buffer_end - disk_buffer
	mov	dx,offset DGROUP:disk_buffer
	int	21h
	jc	copy_read_error
	mov	cx,ax			; write same number of bytes read
	mov	ah,40h
;;	mov	dx,offset DGROUP:disk_buffer
	mov	bx,filehandle
	int	21h
	mov	dx,offset writeerr_msg
	jc	copy_error
	mov	dx,offset diskfull_msg
	cmp	ax,cx
	jb	copy_error
	; check for section header at start of buffer, and extract number
	; of sections from it
	push	cx
	call	check_section_header
	pop	ax
	cmp	ax,disk_buffer_end - disk_buffer ; continue until only partial
	je	copy_section_loop		 ;   buffer read (EOF hit)
	ret

copy_read_error:
	mov	dx,offset readerr_msg
copy_error:
	; truncate output to size before section was started
	push	dx			; store error message
	mov	ax,4200h
	mov	cx,filesize_hi
	mov	dx,filesize_lo
	mov	bx,filehandle
	int	21h
	mov	ah,40h
	xor	cx,cx			; write zero bytes to truncate
	int	21h
	pop	dx			; get back error message
	;; fall through to exit_with_errmsg ;;

;;------------------------------------------------------------------------

exit_with_errmsg:
	call	write_string
	; exit with errorlevel 1
	mov	al,01h
	jmp	near ptr exit

main:
	ASSUME	CS:DGROUP, DS:DGROUP, ES:DGROUP, SS:DGROUP
	mov	dx,offset banner
	call	write_string
	; relocate the stack
	mov	sp,offset DGROUP:stackbot
	; ensure that we have enough memory
	mov	ax,cs
	add	ax,1000h		; require 64K memory
	cmp	ax,ds:[0002h]		; is end of mem at least 64K above CS?
	mov	dx,offset no_mem_msg
	ja	exit_with_errmsg
	mov	si,81h			; point at start of cmdline
	mov	bl,[si-1]		; get length of cmdline
	mov	bh,0
	mov	byte ptr [bx+si],0Dh	; ensure cmdline properly terminated
	cld
	call	skip_whitespace
	mov	dx,offset usage_msg
	jz	exit_with_errmsg
get_cmdline_switches:
	call	skip_whitespace
	jz	not_a_switch
	cmp	al,'-'			; is it a switch?
	jne	not_a_switch
	lodsb				; get the switch character
	lodsb				; get the switch itself
	and	al,0DFh			; force to uppercase
	cmp	al,'P'
	je	want_ports
	cmp	al,'D'
;;	mov	dx,offset usage_msg
	jne	exit_with_errmsg
	mov	del_after_copy,1
	jmp	get_cmdline_switches
want_ports:
	jmp	config_for_ports
not_a_switch:
	mov	ah,19h			; get default drive
	int	21h
	mov	dest_drive,al
	mov	ah,30h
	int	21h
	cmp	al,2
	mov	dx,offset bad_dos_msg
	jb	exit_with_errmsg
	call	get_destination_file
	xor	filesize_hi,filesize_hi
	call	check_total_size
	;
	; OK, all the preliminaries are done now, so go concatenate the
	; sections of the interrupt list
	;
	mov	al,'A'-1
concat_loop:
	inc	ax
	mov	section_letter,al
	sub	al,'A'-1
	cmp	al,numsections
	ja	concat_done
	mov	dx,section_file
	call	write_string
	mov	ax,3D00h
	int	21h
	mov	dx,offset missing_msg
	jc	concat_loop_end
	mov	si,ax
	call	copy_section
	mov	bx,si			; BX <- section file's handle
	mov	ah,3Eh			; DOS function: close file handle
	int	21h
	cmp	del_after_copy,0
	je	concat_no_del
	mov	ah,41h			; DOS function: delete file
	mov	dx,section_file
	int	21h
concat_no_del:
	mov	dx,offset crlf
concat_loop_end:
	call	write_string
	mov	al,section_letter
	jmp	concat_loop

concat_done:
	mov	dx,offset complete_msg
	call	write_string
	mov	al,00h			; successful completion
exit:
	push	ax
	mov	dx,offset crlf
	call	write_string
	mov	ax,5701h		; (set file time & date)
	mov	bx,filehandle
	mov	cx,ftime		; set timestamp of combined file to
	mov	dx,fdate		;   be that of the last of the sections
	int	21h
	mov	ah,3Eh			; DOS function: close file handle
	int	21h
	pop	ax
	mov	ah,4Ch
	int	21h

config_for_ports:
	mov	section_heading,offset section_heading2
	mov	section_hdr_len,section_hdr_len2
	push	di
	push	si
	push	cx
	;; copy combined_file2 over combined_file
	mov	cx,combined_file2_len
	mov	si,offset combined_file2
	mov	di,offset combined_file
	rep	movsb
	;; copy section_file2 over section_file1
	mov	cx,section_file2_len
	mov	si,offset section_file2
	mov	di,offset section_file1
	rep	movsb
	pop	cx
	pop	si
	pop	di
	add	section_file,section_file2_ofs
	jmp	get_cmdline_switches

CODE ENDS

STACKSEG SEGMENT PUBLIC WORD 'STACK'
stacktop dw	160 dup (?)
stackbot label byte
STACKSEG ENDS

BUFFERSEG SEGMENT PUBLIC WORD 'DATA'
disk_buffer db 62*1024 dup (?)
disk_buffer_end label byte
BUFFERSEG ENDS

	END combine
