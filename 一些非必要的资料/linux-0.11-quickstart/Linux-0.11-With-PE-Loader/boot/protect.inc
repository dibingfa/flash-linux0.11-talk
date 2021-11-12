
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

struc SegmentDescriptor
    .wLimitLow     RESW      1               ;段界限低16位
    .wBaseLow      RESW      1               ;基地址低16位
    .bBaseMiddle   RESB      1               ;基地址中间8位
    .bAttrib       RESB      1               ;段属性
    .bLimitHight4Bit_AttribHight4Bit    RESB      1 ;段界限的高4位和段属性的高4位
    .bBaseHigh     RESB      1               ;基地址的高8位
endstruc

;                    varaible ,offset,Base
%macro SetDescriptor_Base_Offset 3
	xor	eax, eax
	mov	ax, %3
	shl	eax, 4
	add	eax, %2
	mov	word [%1 + SegmentDescriptor.wBaseLow], ax
	shr	eax, 16
	mov	byte [%1 + SegmentDescriptor.bBaseMiddle], al
	mov	byte [%1 + SegmentDescriptor.bBaseHigh], ah
%endmacro

;                    varaible , Base
%macro SetDescriptor_Base 2
  mov eax,%2
	mov	word [%1 + SegmentDescriptor.wBaseLow], ax
	shr	eax, 16
	mov	byte [%1 + SegmentDescriptor.bBaseMiddle], al
	mov	byte [%1 + SegmentDescriptor.bBaseHigh], ah
%endmacro

; %1 new descriptor name
; %2 base      : 32 bit
; %3 limit     : 20 bit
; %4 attribute ; 12 bit
%macro NewDescriptor  4
%1:
    istruc  SegmentDescriptor 
        at SegmentDescriptor.wLimitLow 	,                    dw      %3 & 0xffff 
        at SegmentDescriptor.wBaseLow 	,	                    dw      %2 & 0xffff
        at SegmentDescriptor.bBaseMiddle,                     db      (%2>>16) & 0xff
        at SegmentDescriptor.bAttrib		,	                    db      %4 & 0xff
        at SegmentDescriptor.bLimitHight4Bit_AttribHight4Bit, db      ( (%3>>16) & 0x0F) | (%4 >> 8)
        at SegmentDescriptor.bBaseHigh  ,	                    db      (%2 >> 24) & 0xff
    iend
%endmacro 


