Interrupt List, part 3 of 18
Copyright (c) 1989-1999,2000 Ralf Brown
--------O-1510-------------------------------
INT 15 - VMiX - "sys_virtual" - EXECUTE CONFORMING FUNCTION IN PROTECTED MODE
	AH = 10h
	STACK:	DWORD	pointer to function
	      N WORDs	function args
Return: AX = function's return value??? (not specified in documentation)
Note:	while the function is executing, the following global descriptors are
	  available:
		20h stack segment
		38h code segment of function
		40h data alias for function's code segment
	  additional GDT descriptors can be allocated using AH=02h with
	  function "assign gdt"
SeeAlso: AH=02h"VMiX",AH=51h"VMiX"
--------T-1510-------------------------------
INT 15 - MultiDOS Plus - TEST RESOURCE SEMAPHORE
	AH = 10h
	AL = semaphore number (00h-3Fh)
Return: AH = status
	    00h semaphore not in use
	    01h semaphore owned by another task
	    02h invalid semaphore number
	    03h semaphore owned by caller
SeeAlso: AH=02h"MultiDOS",AH=0Dh"MultiDOS",AH=1Dh"MultiDOS"
--------Q-151000-----------------------------
INT 15 - TopView - "PAUSE" - GIVE UP CPU TIME
	AX = 1000h
Return: after other processes run
Note:	under DESQview, if the process issuing this call has hooked INT 08h,
	  the current time-slice is set to expire at the next clock tick rather
	  than immediately
SeeAlso: AH=00h"MultiDOS",AX=5305h,INT 21/AH=89h,INT 21/AH=EEh"DoubleDOS"
SeeAlso: INT 2F/AX=1680h,INT 60/DI=0106h,INT 62/AH=01h,INT 6F/AH=2Ah"F_YIELD"
SeeAlso: INT 7A/BX=000Ah,INT 7F/AH=02h"MultiLink",INT 7F/AH=E8h
--------Q-151001-----------------------------
INT 15 - TopView - "GETMEM" - ALLOCATE "SYSTEM" MEMORY
	AX = 1001h
	BX = number of bytes to allocate
Return: ES:DI -> block of memory or 0000h:0000h (DV v2.26+)
	AX = status (DV v2.42)
	    0000h successful
	    0001h failed
Note:	use SETERROR (AX=DE15h) to avoid a user prompt if there is insufficient
	  common memory.  Under DV v2.42, this call never generates a user
	  prompt regardless of the SETERROR value; instead, it always returns
	  AX=0001h and ES:DI=0000h:0000h if out of memory
SeeAlso: AX=1002h,AX=102Eh,AX=DE0Ch,AX=DE15h
--------Q-151002-----------------------------
INT 15 - TopView - "PUTMEM" - DEALLOCATE "SYSTEM" MEMORY
	AX = 1002h
	ES:DI -> previously allocated block
Return: block freed
SeeAlso: AX=1001h,AX=DE0Dh
--------Q-151003-----------------------------
INT 15 - TopView - "PRINTC" - DISPLAY CHARACTER/ATTRIBUTE ON SCREEN
	AX = 1003h
	BH = attribute
	BL = character
	DX = segment of object handle for window
Return: nothing
Note:	BX=0000h does not display anything, it only positions the hardware
	  cursor to the logical cursor's current position
--------Q-1510-------------------------------
INT 15 - TopView - UNIMPLEMENTED IN DV 2.x
	AH = 10h
	AL = 04h thru 12h
Return: pops up "Programming error" window in DV 2.x
--------Q-151013-----------------------------
INT 15 - TopView - "GETBIT" - DEFINE A 2ND-LEVEL INTERRUPT HANDLER
	AX = 1013h
	ES:DI -> FAR service routine
Return: BX = bit mask indicating which bit was allocated
	    0000h if no more bits available
SeeAlso: AX=1014h,AX=1015h
Note:	only a few TopView/DESQview API calls are allowed during a hardware
	  interrupt; if other calls need to be made, the interrupt handler
	  must schedule a 2nd-level interrupt with "SETBIT" (AX=1015h)
--------Q-151014-----------------------------
INT 15 - TopView - "FREEBIT" - UNDEFINE A 2ND-LEVEL INTERRUPT HANDLER
	AX = 1014h
	BX = bit mask from INT 15/AX=1013h
Return: nothing
SeeAlso: AX=1013h,AX=1015h
--------Q-151015-----------------------------
INT 15 - TopView - "SETBIT" - SCHEDULE ONE OR MORE 2ND-LEVEL INTERRUPTS
	AX = 1015h
	BX = bit mask for interrupts to post
Return: indicated routines will be called: (DV 2.0x) at next task switch
					   (DV 2.2x) immediately on return from
						     hardware interrupt
Notes:	this is one of the few TopView calls which are allowed from a hardware
	  interrupt handler
	the handler will be called with ES containing the segment of the handle
	  of the next task to be executed; on return, ES must be the segment of
	  a task handle
SeeAlso: AX=1013h,AX=1014h
--------Q-151016-----------------------------
INT 15 - TopView - "ISOBJ" - VERIFY OBJECT HANDLE
	AX = 1016h
	ES:DI = possible object handle
Return: BX = status
	    FFFFh if ES:DI is a valid object handle (see #00414)
	    0000h if ES:DI is not
Note:	under DESQview versions prior to 2.50, an object handle is always a
	  pointer to the object; for versions 2.50 and up, only task handles
	  are always pointers--other handles may consist of a unique object
	  number and offset into DESQview's common memory (see #00423)
SeeAlso: AX=DE14h,AX=DE2Bh,AX=DE2Ch

(Table 00413)
Values for DESQview object type:
 00h	window/task
 01h	mailbox
 02h	keyboard
 03h	timer
 04h	pointer
 05h	panel
 06h	objectq

Format of DESQview object:
Offset	Size	Description	(Table 00414)
 00h	WORD	offset in common memory of previous object of same type
 02h	WORD	offset in common memory of next object of same type
 04h	WORD	signature FEDCh (DV 2.42-)
		signature FEDCh or object number (DV 2.50+)
 06h	WORD	object type (see #00413)
 08h	DWORD	object handle to return to caller
 0Ch	DWORD	canonicalized object address (segment = common memory)
 10h	WORD	offset in common memory of owning task
		(0000h for unowned OBJECTQs)
 12h	WORD	mapping context
		offset in common memory of mapping context record (see #00416)
	remainder varies by object type and DESQview version
---v2.42 keyboard object---
 14h	WORD	flag bits (see also AH=12h/BH=0Ah"OBJECT")
		bit 15: keyboard opened
 16h  4 BYTEs	???
 1Ah	WORD	priority in OBJECTQ???
 1Ch	...
 25h	WORD	offset in common memory of ??? task
 27h  4 BYTEs	???
---v2.42 objectq object---
 14h	WORD	flag bits (see also AH=12h/BH=0Ah"OBJECT")
		bit 15: OBJECTQ opened
 16h  2 BYTEs	???
 18h	WORD	offset in common memory of ??? task
 1Ah  6 BYTEs	???
---v2.42 mailbox object---
 14h	WORD	flag bits (see also AH=12h/BH=0Ah"OBJECT")
		bit 15: mailbox opened
 1Ah	WORD	priority in OBJECTQ???
 1Ch  6 BYTEs	???
 22h	WORD	offset in common memory of mailbox name (counted string)
		0000h if no name
    <= 5 BYTEs	???
---v2.22-2.42,2.52,2.60 window/task object---
 14h	BYTE	00h window, 01h task
 15h	BYTE	internal (not Switch menu) window number???
 16h	BYTE	internal (not Switch menu) window number???
 17h	WORD	segment of internal window record (see #00417)
 19h  2 BYTEs	???
 1Bh	BYTE	cursor row
 1Ch	BYTE	cursor column
 1Dh	BYTE	visible window origin, row
 1Eh	BYTE	visible window origin, column
 1Fh	BYTE	window height (logical)
 20h	BYTE	window width (logical)
 21h	BYTE	window position, row
 22h	BYTE	window position, column
 23h	BYTE	window height (visible)
 24h	BYTE	window width (visible)
 25h	BYTE	row of top of frame (or window if unframed)
 26h	BYTE	column of left of frame (or window if unframed)
 27h	BYTE	window height (physical, including frame)
 28h	BYTE	window width (physical, including frame)
 29h	BYTE	unzoomed visible origin, row (00h before first zoom)
 2Ah	BYTE	unzoomed visible origin, column (00h before first zoom)
 2Bh	BYTE	unzoomed window position, row (00h before first zoom)
 2Ch	BYTE	unzoomed window position, column (00h before first zoom)
 2Dh	BYTE	unzoomed window height (00h before first zoom)
 2Eh	BYTE	unzoomed window width (00h before first zoom)
		unzoomed parameters above are updated when window is zoomed
		  to full screen
 2Fh	BYTE	??? initially logical window height
 30h	BYTE	??? initially logical window width
 31h  2 BYTEs	???
 33h	BYTE	minimum height of window
 34h	BYTE	minimum width of window
 35h	BYTE	maximum height of window
 36h	BYTE	maximum width of window
 37h  3 BYTEs	???
 3Ah  8 BYTEs	window frame characters: ul,ur,ll,lr,t,b,l,r
 42h 24 BYTEs	attributes???
 5Ah  8 BYTEs	window frame characters: ul,ur,ll,lr,t,b,l,r
 62h  3 BYTEs	???
 65h	BYTE	??? bitflags
 66h	BYTE	bit 0: window is zoomed
 67h	BYTE	???
 68h	WORD	offset in common memory of window name or 0000h if untitled
 6Ah	WORD	length of window name
 6Ch  2 BYTEs	???
 6Eh	WORD	offset of logical cursor in window (in character cells)
 70h	DWORD	pointer to field table for window
 74h	BYTE	???
 75h  2 BYTEs	???
 77h	BYTE	number of last-visited field
 78h	DWORD	pointer to field table entry for last-visited field
 7Ch  3 BYTEs	???
 7Fh	BYTE	select field marker character
 80h	BYTE	??? bit flags
		bit 0: allow ECh window stream opcode to change reverse logattr
		bit 1: alternate field processing mode selected
 81h	BYTE	???
 82h	DWORD	notification function (manager stream opcode 8Ah)
		no notification if segment = 0000h
 86h	DWORD	notification argument (manager stream opcode 8Bh)
 8Ah	WORD	offset in common memory of ??? window object or 0000h
 8Ch	WORD	offset in common memory of ??? window object or 0000h
 8Eh	WORD	offset in common memory of ??? window object or 0000h
 90h	BYTE	??? bitflags
 91h	BYTE	???
 ---task object only
 92h	BYTE	bit flags (bits 0-4)
 93h	BYTE	character for ??? (default 20h)
 94h	BYTE	??? flag
 95h	WORD	offset in common memory of ???
 97h  2 BYTEs	???
 99h	WORD	???
 9Bh	BYTE	??? bit flags
		bit 3: ???
		bit 6: perform protected-attribute processing on select fields
 9Ch	BYTE	???
 9Dh	WORD	offset in common memory of current register save record
		  (see #00415).	No register save record in use if < 01C0h
 9Fh	WORD	offset in common memory of task's keyboard object
 A1h	WORD	offset in common memory of task's OBJECTQ object
 A3h	WORD	offset in common memory of task's mailbox object
 A5h	WORD	semaphore: FFFFh if on user stack, else on task's private stack
 A7h	DWORD	user's SS:SP
 ABh	WORD	task's private SP (SS read from offset 0Ah)
 ADh  6 BYTEs	???
 B3h	BYTE	??? bit flags
		bit 0: run in foreground only
 B4h	BYTE	???
 B5h	BYTE	??? bitflags
 B6h	BYTE	task status (see #00555 at AX=DE2Ch)
 B7h  9 BYTEs	???
 C0h	WORD	head pointer for keyboard buffer (wraps back to 00h after 80h)
 C2h	WORD	tail pointer for keyboard buffer (wraps back to 00h after 80h)
 C4h  2 BYTEs	??? (0000h)
 C6h	WORD	segment of keyboard buffer for task
 C8h	WORD	offset in common memory of ??? keyboard object
 CAh	BYTE	???
---v2.22-2.42
 CBh	WORD	offset in common memory of ??? object
 CEh	BYTE	??? flag
 CFh	WORD	offset in common memory of default notify window for task
		  or 0000h if none
 D1h  4 BYTEs	???
 D5h	BYTE	window number on Switch Window menu
 D6h  5 BYTEs	???
 DBh	WORD	offset in common memory of ??? object
 DDh  2 BYTEs	???
 DFh	WORD	API level for task
 E1h	WORD	offset in common memory of object task is waiting on if task
		  status is 'waiting', else 0000h
 E7h	WORD	segment of ???
 E9h 4	BYTEs	???
 EDh	WORD	EMS handle of virtualization buffer, 0000h if no virtualization
 F1h 12 BYTEs	???
 FBh	WORD	???
 FDh	BYTE	???
 FFh 12 BYTEs	???
10Bh	DWORD	pointer to process record (see #00418,#00419)
10Dh 10 BYTEs	???
119h	DWORD	SS:SP for ???
11Dh  4 BYTEs	???
121h	DWORD	pointer to ???
125h 25 BYTEs	???
13Eh	DWORD	pointer to ??? in system memory
---v2.22
142h  3 BYTEs	???
145h		task's default keyboard object
---v2.42
142h	DWORD	pointer to first task instance data record in system memory
148h	DWORD	pointer to last task instance data record in system memory
		(see #00420)
14Ah	BYTE	???
14Dh 42 BYTEs	task's default keyboard object
177h 32 BYTEs	task's ObjectQ object
197h 41 BYTEs	task's default mailbox object
1C0h 24 BYTEs	first register save record
450h	--	default top of private stack
---v2.52 (probably all DV/X)
Same as v2.60 below except there is an extra 29 bytes inserted somewhere
  before offset 9Fh, but not yet known exactly where.  Also, for the WAIT_ON
  field (v2.60 offset E3h), some X apps (probably waiting on a socket) have
  0000h even when waiting.
---v2.60
 CBh	WORD	??? (added in 2.50 - rest is same as 2.42)
 CDh	WORD	offset in common memory of ??? object
 D0h	BYTE	??? flag
 D1h	WORD	offset in common memory of default notify window for task
		  or 0000h if none
 D3h  4 BYTEs	???
 D7h	BYTE	window number on Switch Window menu
 D8h  5 BYTEs	???
 DDh	WORD	offset in common memory of ??? object
 DFh  2 BYTEs	???
 E1h	WORD	API level for task
 E3h	WORD	If status at B6h=waiting, offset in common memory of object
		  that task is waiting on, else 0000h. (Task with CPU also
		  has 0000h here)
 E9h	WORD	segment of ???
 EBh 4	BYTEs	???
 EFh	WORD	EMS handle of virtualization buffer, 0 if no virtualization
 F3h 12 BYTEs	???
 FDh	WORD	???
 FFh	BYTE	???
101h  8 BYTEs	???
109h	DWORD	pointer to process record in system memory
10Dh 14 BYTEs  ???
11Bh	DWORD	SS:SP for ???
11Fh  4 BYTEs	???
123h	DWORD	pointer to ???
127h 25 BYTEs	???
140h	DWORD	pointer to ??? in system memory
144h	DWORD	pointer to first task instance data record in system memory
148h	DWORD	pointer to last task instance data record in system memory
		(from INT 15/AX=DE27h) (see #00420)
14Ch	BYTE	???
14Eh 42 BYTEs	task's default keyboard object
179h 32 BYTEs	task's ObjectQ object
199h 41 BYTEs	task's default mailbox object
1C2h 24 BYTEs	first register save record
452h	--	default top of private stack

Format of DESQview Register Save Record:
Offset	Size	Description	(Table 00415)
 00h	WORD	AX
 02h	WORD	BX
 04h	WORD	CX
 06h	WORD	DX
 08h	WORD	DI
 0Ah	WORD	SI
 0Eh	WORD	DS
 10h	WORD	ES
 12h	DWORD	return address
 16h	WORD	original flags

Format of DESQview mapping context record:
Offset	Size	Description	(Table 00416)
 00h	WORD	lowest segment in process's memory
		(often start of system memory chain)
 02h	WORD	size of process's memory in paragraphs
 04h	BYTE	flag: 00h if process swapped out, 01h otherwise
 05h	BYTE	flag: 00h if allocated in conventional memory, 01h if EMS
 06h  2 BYTEs	???
 08h	WORD	EMS handle if in EMS, else 0
 0Ah  2 BYTEs	??? (nonzero if system memory resides in shared mem???)
 0Ch	WORD	segment of system memory block that contains process record,
		  referenced from segment of start of system memory chain
 0Eh	BYTE	???
 0Fh	WORD	size of system memory block that contains process record
		  and DOS memory in paragraphs
 11h	BYTE	bit flags
		Bit 0: Swapped out???
		Bit 1: ???
		Bit 2: Swapped out???
 12h	BYTE	???
 13h	BYTE	reference count
 ---v2.31
 14h 10 BYTEs	???
 1Eh	WORD	segment of process record
 20h  2 BYTEs	???
 22h	WORD	segment of ???	(in first free system memory block???)
 24h	WORD	segment of end of system memory chain
 26h	WORD	segment of start of system memory chain
 28h  8 BYTEs	???
 2Ah	DWORD	pointer to ??? (process record???)
 2Dh 10 BYTEs	???
 37h	BYTE	lowest interrupt vector to save on context switch
 38h	BYTE	highest interrupt vector to save on context switch
 39h	WORD	offset in common memory of main task with this context
 3Ah 12 BYTEs	???
 46h	BYTE	internal mapping context number
 47h 12 BYTEs	???
 ---v2.5x-2.60
 14h  6 BYTEs	???
 1Ah	WORD	segment of process record
 1Ch  2 BYTEs	???
 1Eh	WORD	segment of first free system memory block
 20h	WORD	segment of start of system memory chain
 22h	WORD	segment of end of system memory chain
 24h 8	BYTEs	???
 2Ch	DWORD	pointer to ??? (1 segment into process record???)
 30h 3	BYTEs	???
 33h	WORD	Offset in common memory of main task with this context
 35h 7	BYTEs	???
 3Ch	BYTE	internal mapping context number
 3Dh 14 BYTEs	???
 4Bh	WORD	first DOS memory segment (first MCB segment+1)
 4Dh	BYTE	??? (flag???)
 ---v2.53 (2.5x???)
 4Eh 12 BYTEs	???
 ---v2.60
 4Eh	WORD	segment of script buffer (see #00421)
 50h  6 BYTEs	???

Format of DESQview Internal Window Record (v2.31-2.60):
Offset	Size	Description	(Table 00417)
 00h	BYTE	internal window number???
 01h	BYTE	display page???
 02h	BYTE	video mode
 03h  3 BYTEs	???
 06h	BYTE	logical window height
 07h	BYTE	logical window width
 08h	DWORD	pointer to text video buffer
 0Ch 116 BYTEs	???

Format of DESQview process record (v2.31):
Offset	Size	Description	(Table 00418)
-470h 13 BYTEs	filename of ??? Script
-463h 1117 BYTEs ??? (script buffer???)
 -6h  6 BYTEs	???
 00h	WORD	segment of parent PSP in process
 02h  5 BYTEs	???
 07h	WORD	segment of current PSP in process
 09h	WORD	segment of first MCB in process
 0Bh 13 BYTEs	???
 18h 1024 BYTEs process's interrupt vector table
418h 376 BYTEs	???
590h		first MCB in process
SeeAlso: #00419

Format of DESQview process record (v2.52-v2.60) (probably also 2.5x):
Offset	Size	Description	(Table 00419)
 00h 28 BYTEs	EXE header of last EXE, ??? if last program run was COM
 1Ch ??? BYTEs	overwritten with ASCIZ filename of last program run (EXE/COM)
11Ch	WORD	segment of parent PSP in process
11Eh  4 BYTEs	???
122h	WORD	segment of current PSP
124h	WORD	segment of current PSP
126h	WORD	segment of first MCB in process
128h  4 BYTEs	???
12Ch	DWORD	pointer to first process instance data record in system memory
130h	DWORD	pointer to last process instance data record in system memory
		(from INT 15/AX=DE27h) (see #00420)
134h  8 BYTEs	???
13Ch	WORD	size of current environment
13Eh	WORD	segment of current environment
140h	WORD	segment of current PSP
142h	DWORD	entry point of current program
146h 10 BYTEs	???
---v2.52 (v2.5x???)
150h	BYTE	???
151h	WORD	segment of parent PSP in process
153h	WORD	???
155h	WORD	???
157h	WORD	???
159h  4 BYTEs	???
15Dh	WORD	segment of current environment
15Fh	WORD	segment of current PSP
161h	WORD	segment of ???
162h	WORD	???
164h  3 BYTEs	???
168h 1024 BYTEs process's interrupt vector table
568h 120 BYTEs	???
5E0h		first MCB in process
---v2.60
150h	WORD	segment of parent PSP in process
152h	WORD	???
154h	WORD	???
156h	WORD	???
158h  4 BYTEs	???
15Ch	WORD	segment of current environment
15Eh	WORD	segment of current PSP
160h	WORD	segment of ???
162h	WORD	???
164h 1024 BYTEs process's interrupt vector table
564h 108 BYTEs	???
5D0h		first MCB in process
SeeAlso: #00418

Format of DESQview task or process instance data record (v2.5x???, v2.60):
Offset	Size	Description	(Table 00420)
 00h	DWORD	pointer to next record of same type or 00000000
 04h	DWORD	pointer to previous record of same type or 00000000
 08h	DWORD	pointer to source area of memory during restore state
 0Ch	WORD	number of bytes to save/restore
 0Eh	DWORD	pointer to destination area of memory during restore state
 12h	WORD	??? (0)
 14h  N BYTEs	source memory buffer during restore state

Format of DESQview script buffer (v2.60):
Offset	Size	Description	(Table 00421)
 00h 13 BYTEs	ASCIZ Script filename
 0Dh 80 BYTEs	???
 5Eh  N BYTEs	script records (see #00422)

Format of one DESQview script record (v2.60):
Offset	Size	Description	(Table 00422)
 00h	BYTE	signature 12h
 01h 18 BYTEs	blank-padded script name
 13h	BYTE	ASCII code of key attached to script or 0 if non-ASCII key
 14h	BYTE	scan code of key attached to script if non-ASCII, else 0
 15h	BYTE	???
 16h	WORD	size of script in bytes
 18h  N	BYTEs	script (ASCII code of each keystroke; if 0, next byte is
		  scan code of non-ASCII key)
SeeAlso: #00421

Format of DESQview Common Memory Header (v2.31-2.60):
Offset	Size	Description	(Table 00423)
 00h	WORD	offset of lowest used block
 02h	WORD	bytes of commom memory, including header
 04h	WORD	offset of first free block
 06h  N BYTEs	size depends of DV version, ??? (DVP buffer???)
Note:	the above is located at the beginning of the commom memory segment
SeeAlso: #00424,#00425,#00433

Format of DESQview Free block header:
Offset	Size	Description	(Table 00424)
 00h	WORD	size of block in bytes including header
 02h	WORD	offset of next free block
 04h  N BYTEs	free block
SeeAlso: #00423,#00425

Format of DESQview Used block header:
Offset	Size	Description	(Table 00425)
 00h	WORD	size of block in bytes including header
 02h  N BYTEs	used block
SeeAlso: #00423,#00424
--------Q-151017-----------------------------
INT 15 - TopView - UNIMPLEMENTED IN DV 2.x
	AX = 1017h
Return: pops up "Programming error" window in DV 2.x
--------Q-151018-----------------------------
INT 15 - TopView - "LOCATE" - FIND WINDOW AT A GIVEN SCREEN LOCATION
	AX = 1018h
	BH = column
	BL = row
	ES = segment of object handle for window below which to search
	    0000h = start search with topmost window
Return: ES = segment of object handle for window which is visible at the
	       indicated position, or covered by indicated window
	    0000h if no window
SeeAlso: AX=1023h,AX=1024h
--------Q-151019-----------------------------
INT 15 - TopView - "SOUND" - MAKE TONE
	AX = 1019h
	BX = frequency in Hertz (0000h = silence)
	CX = duration in clock ticks (18.2 ticks/sec)
Return: immediately, tone continues to completion
Notes:	if another tone is already playing, the new tone does not start until
	  completion of the previous one.  Up to 32 tones may be queued before
	  the process is blocked until a note completes.
	in DV 2.00, the lowest tone allowed is 20 Hz
	if CX = 0, the current note is cancelled; if BX = 0 as well, all queued
	  notes are also cancelled
SeeAlso: AH=82h"HUNTER",INT 16/AH=73h
--------Q-15101A-----------------------------
INT 15 - TopView - "OSTACK" - SWITCH TO TASK'S INTERNAL STACK
	AX = 101Ah
Return: stack switched
Notes:	this call may not be nested; a second call must be preceded by a call
	  to "USTACK" (AX=1025h)
	while TopView requires many API calls to be executed while on the
	  task's internal stack, DESQview allows those calls to be executed
	  regardless of the current stack
SeeAlso: AX=1025h
--------Q-15101B-----------------------------
INT 15 - TopView - "BEGINC" - BEGIN CRITICAL REGION
	AX = 101Bh
Return: task-switching temporarily disabled
Notes:	will not task-switch until "ENDC" (AX = 101Ch) called unless task
	  voluntarily releases the CPU (upon regaining the CPU, task-switching
	  will again be disabled)
	suspends the caller until DOS is free
SeeAlso: AH=0Dh"MultiDOS",AX=101Ch,AX=DE13h,AX=DE1Ch,INT 2F/AX=1681h
SeeAlso: INT 60/DI=0602h
--------Q-15101C-----------------------------
INT 15 - TopView - "ENDC" - END CRITICAL REGION
	AX = 101Ch
Return: task-switching enabled
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=DE13h,AX=DE1Bh,INT 2F/AX=1682h,INT 60/DI=0603h
--------Q-15101D-----------------------------
INT 15 - TopView - "STOP" - STOP TASK
	AX = 101Dh
	ES = segment of object handle for task to be stopped
	    (== handle of main window for that task)
Return: indicated task will not get any CPU time until restarted with AX=101Eh
Note:	once a task has been stopped, additional "STOP"s are ignored
BUG:	in DV 2.00, this function is ignored unless the indicated task is the
	  current task
SeeAlso: AX=101Eh,AX=102Bh,AH=12h"VMiX",INT 21/AH=81h
--------Q-15101E-----------------------------
INT 15 - TopView - "START" - START TASK
	AX = 101Eh
	ES = segment of object handle for task to be started
	    (== handle of main window for that task)
Return: indicated task is started up again
Note:	once a task has been started, additional "START"s are ignored
SeeAlso: AX=101Dh,AX=102Bh,INT 21/AH=82h
--------Q-15101F-----------------------------
INT 15 - TopView - "DISPEROR" - POP-UP ERROR WINDOW
	AX = 101Fh
	BX = bit fields
	    bits 0-12: number of characters to display
	    bits 13,14: which mouse button may be pressed to remove window
			 00 = either
			 01 = left
			 10 = right
			 11 = either
	    bit 15: beep if 1
	ES:DI -> text of message
	CH = width of error window (0 = default)
	CL = height of error window (0 = default)
	DX = segment of object handle
Return: BX = status: 1 = left button, 2 = right, 27 = ESC pressed
Note:	window remains on-screen until ESC or indicated mouse button is pressed
--------Q-151020-----------------------------
INT 15 - TopView - UNIMPLEMENTED IN DV v2.00+
	AX = 1020h
Return: pops up "Programming error" window in DV v2.00+
--------Q-151021-----------------------------
INT 15 - TopView - "PGMINT" - INTERRUPT ANOTHER TASK
	AX = 1021h
	BX = segment of object handle for task to interrupt (not self)
	DX:CX -> FAR routine to jump to next time task is run
Return: nothing
Notes:	the FAR routine is entered with the current ES, DS, SI, DI, and BP
	  values, using the task's internal stack (see AX=101Ah); only SS:SP
	  needs to be preserved
	multiple PGMINTs to a single task are processed last-in first-out
	if the other task is in a DOS or DV API call, the interruption will
	  occur on return from that call
--------Q-151022BX0000-----------------------
INT 15 - TopView - "GETVER" - GET VERSION
	AX = 1022h
	BX = 0000h
Return: BX nonzero, TopView or compatible loaded
	(BL = major version, BH = minor version)
Notes:	TaskView returns BX = 0001h, DESQview v2.00+ returns BX = 0A01h
--------Q-151023-----------------------------
INT 15 - TopView - "POSWIN" - POSITION WINDOW
	AX = 1023h
	BX = segment of object handle for parent window within which to
	       position the window (0 = full screen)
	ES = segment of object handle for window to be positioned
	DL = general window position (see #00426)
	CH = number of columns to offset from position specified by DL
	CL = number of rows to offset from position specified by DL
Return: nothing

Bitfields for TopView general window position:
Bit(s)	Description	(Table 00426)
 0,1	horizontal position
	00 = current, 01 = center, 10 = left, 11 = right
 2,3	vertical position
	00 = current, 01 = center, 10 = top, 11 = bottom
 4	don't redraw screen if set
 5-7	not used
--------Q-151024-----------------------------
INT 15 - TopView - "GETBUF" - GET VIRTUAL SCREEN INFO
	AX = 1024h
	BX = segment of object handle for window (0000h = use default)
Return: ES:DI -> virtual screen
	CX = size of virtual screen in bytes
	DL = screen type
	    00h text screen
	    01h graphics screen
SeeAlso: INT 10/AH=FEh,INT 21/AH=2Bh/CX=4445h
--------Q-151025-----------------------------
INT 15 - TopView - "USTACK" - SWITCH BACK TO USER'S STACK
	AX = 1025h
Return: stack switched back
Notes:	call only after having switched to internal stack with AX=101Ah
	while TopView requires many API calls to be executed while on the
	  task's private stack, DESQview allows those calls to be executed
	  regardless of the current stack
SeeAlso: AX=101Ah
--------Q-1510-------------------------------
INT 15 - DESQview (TopView???) - UNIMPLEMENTED IN DV 2.x
	AH = 10h
	AL = 26h thru 2Ah
Return: pops up "Programming error" window in DV 2.x
--------Q-15102B-----------------------------
INT 15 - DESQview v2.00+ (TopView???) - "POSTTASK" - AWAKEN TASK
	AX = 102Bh
	BX = segment of object handle for task
Return: nothing
Note:	forces a task which is waiting on its objectq to continue by placing
	  the handle for the task on the objectq
SeeAlso: AX=101Dh,AX=101Eh,INT 21/AH=82h
--------Q-15102C-----------------------------
INT 15 - DESQview v2.00+ - "NEWPROC" - START NEW APPLICATION IN NEW PROCESS
	AX = 102Ch
	ES:DI -> contents of .PIF/.DVP file (see #00427)
	BX = size of .PIF/.DVP info
Return: BX = segment of object handle for new task
	    0000h on error
SeeAlso: AX=DE24h,INT 21/AH=4Bh

Format of .PIF/.DVP file:
Offset	Size	Description	(Table 00427)
 00h	BYTE	reserved (0)
 01h	BYTE	checksum of bytes 02h through 170h
 02h 30 BYTEs	blank-padded program title
 20h	WORD	maximum memory to allocate to partition in KB
 22h	WORD	minimum memory required in KB
 24h 64 BYTEs	ASCIZ program pathname
 64h	BYTE	default drive letter ('A',...)
 65h 64 BYTEs	ASCIZ default directory name
 A5h 64 BYTEs	ASCIZ program parameters
 E5h	BYTE	initial screen mode (0-7) (also see offset 189h)
 E6h	BYTE	number of text pages used
 E7h	BYTE	number of first interrupt to save
 E8h	BYTE	number of last interrupt to save
 E9h	BYTE	rows in virtual screen buffer
 EAh	BYTE	columns in virtual screen buffer
 EBh	BYTE	initial window position, row
 ECh	BYTE	initial window position, column
 EDh	WORD	system memory in KB
 EFh 64 BYTEs	ASCIZ shared program name
12Fh 64 BYTEs	ASCIZ shared program data file
16Fh	BYTE	program flags 1 (see #00428)
170h	BYTE	flags2
		bit 6: uses command-line parameters in field at A5h
		bit 5: swaps interrupt vectors
---information unique to .DVP files---
171h  2 BYTEs	keys to use on open menu
173h	WORD	size of script buffer in bytes
175h	WORD	automatically give up CPU after this many tests for keyboard
		  input in one clock tick (default 0 = never)
177h	BYTE	nonzero = "uses own colors"
178h	BYTE	nonzero if application swappable
179h  3 BYTEs	reserved (0) according to Quarterdeck documentation
		in actual .DVP files, frequently 01h
17Ch	BYTE	nonzero to automatically close on exit (see also #00430)
17Dh	BYTE	nonzero if copy-protect floppy is required
---information unique to DESQview 2.0+---
17Eh	BYTE	.DVP version number
		00h DESQview v1.2+
		01h DESQview v2.0+
		02h DESQview v2.2+
17Fh	BYTE	reserved (0)
180h	BYTE	initial number of rows in physical window
181h	BYTE	initial number of columns in physical window
182h	WORD	maximum expanded memory to allow, in KB
184h	BYTE	DVP program flags 3 (see #00429)
185h	BYTE	keyboard conflict level (0-4 for DV<2.26, 00h-0Fh for DV2.26+)
		(see #00431)
186h	BYTE	number of graphics pages used
187h	WORD	extra system memory size
189h	BYTE	initial screen mode (FFh = default) (overrides offset E5h)
---information unique to DESQview 2.2+---
18Ah	BYTE	serial port usage
		FFh uses all serial ports
		00h no serial ports
		01h only COM1
		02h only COM2
18Bh	BYTE	DVP program flags 4 (see #00430)
18Ch	BYTE	protection level for 386 machines
18Dh 19 BYTEs	reserved (0) for regular DESQview
---information unique to DESQview/X 1.0---
18Dh	BYTE	X flags
		bits 3-7: unused (0)
		bit 2: don't display wait message when opening window
		bit 1: don't display DOS window
		bit 0: (XNEWPROC) use DOS client layer (DOS-to-X)
		       (NEWPROC) inherit DOS client layer usage
18Eh	BYTE	X keyboard behavior (0-3)
18Fh	BYTE	font scaling
		00h fixed fonts
		01h scalable fonts
190h 10 BYTEs	reserved (0)
19Ah	WORD	length of data follownig XDVP signature
19Ch  4 BYTEs	signature "XDVP"
1A0h  N BYTEs	list of variable length records (see #00432)

Bitfields for .PIF/.DVP program flags 1:
Bit(s)	Description	(Table 00428)
 7	writes text directly to screen
 6	runs in foreground only (see also #00427 offset 184h)
 5	uses math coprocessor
 4	accesses system keyboard buffer directly
 3-1	reserved (0)
 0	swappable
SeeAlso: #00427,#00429,#00430

Bitfields for .DVP program flags 3:
Bit(s)	Description	(Table 00429)
 7	automatically assign window position
 5	maximum memory value has been specified
 4	disallow "Close" command
 3	foreground-only when doing graphics
	set by DV 2.3+ when "Runs in Background" = "D" (undoc)
 2	don't virtualize (see also #00430)
 1	foreground-only during DOS calls
	set by DV 2.3+ when "Runs in Background" = "D" (undoc)
SeeAlso: #00427,#00428,#00430

Bitfields for .DVP program flags 4:
Bit(s)	Description	(Table 00430)
 7	automatically close application on exit if .COM or .EXE	specified
	(see also #00427 offset 17Ch)
 6	swappable if not using serial ports
 5	start program with window hidden (v2.26+)
 4	start program in background (v2.26+)
 3	virtualize text (see also #00429)
 2	virtualize graphics (see also #00429)
 1	share CPU when foreground
 0	share EGA when foreground and zoomed
SeeAlso: #00427,#00428,#00429

Bitfields for DESQview keyboard conflict level:
Bit(s)	Description	(Table 00431)
 3	save/restore entire INT 09 handler state every taskswtch
 2	take special precautions for programs which read the BIOS keyboard
	  buffer directly from memory
 1	never indicate keystroke available during scripts/xfers
 0	only indicate keystroke available every sixth poll
SeeAlso: #00427

Format of DESQview/X variable length record:
Offset	Size	Description	(Table 00432)
 00h	WORD	length of following record, 0000h if end of record list
 02h	BYTE	record type
		01h script filename, up to 64 characters
		02h command-line parameters (allows >64 characters on cmdline)
		03h environment inheritance
		04h environment string
		05h starting window position
---types 01h,02h,04h---
 03h  N BYTEs	ASCII data
---type 03h---
 03h	BYTE	inheritance
		00h do not inherit
		01h inherit environment
---type 05h---
 03h  N BYTEs	ASCII copy of fields as typed into DVPMAN, separated by commas:
		starting row, starting column, starting height, starting width
Note:	if there are multiple occurrences of record types 01h, 02h, or 03h,
	  only the last instance of each type is used; multiple occurrences of
	  type 04h are concatenated
SeeAlso: #00427
--------Q-15102D-----------------------------
INT 15 - DESQview v2.00+ - "KMOUSE" - KEYBOARD MOUSE CONTROL
	AX = 102Dh
	BL = subfunction
	    00h determine whether using keyboard mouse
		Return: BL = 00h using real mouse
			     01h using keyboard mouse
	    01h turn keyboard mouse on
	    02h turn keyboard mouse off
SeeAlso: INT 33/AX=0024h
--------Q-15102E-----------------------------
INT 15 - DESQview v2.40+ - ALLOCATE SYSTEM MEMORY
	AX = 102Eh
	BX = number of bytes
Return: AX = status
	    0000h successful
		ES:DI -> allocated system memory (see #00433)
	    0001h failed
		ES:DI = 0000h:0000h
Note:	under DV 2.42, this call is identical to AX=1001h
SeeAlso: AX=1001h,AX=1002h,AX=DE0Ch

Format of DESQview system memory block header:
Offset	Size	Description	(Table 00433)
 00h	WORD	segment of next header or 0000h
 02h	WORD	segment of previous header or 0000h
 04h	WORD	size of block in paragraphs, including header
 06h	BYTE	availability flag (00h in use, 01h free)
Note:	this header is located one paragraph before the memory block proper
SeeAlso: #00423
--------Q-1511-------------------------------
INT 15 - TopView commands
	AH = 11h
	AL = various (except 17h)
Return: varies by function
Note:	in DESQview 2.x, these function calls are identical to AH=DEh, so
	  see those below
SeeAlso: AX=DE00h,AX=DE22h,AX=DE30h
--------T-1511-------------------------------
INT 15 - VMiX - "sys_system" - EXECUTE SHELL SYSTEM COMMANDS
	AH = 11h
	STACK:	DWORD	pointer to ASCIZ string containing a VMiX shell
			request (max len = 127)
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=0Ch"VMiX"
--------T-1511-------------------------------
INT 15 - MultiDOS Plus - TURN OFF AltZ TOGGLE
	AH = 11h
Note:	disables the Alt-Z MultiDOS command/program-selection hotkey
SeeAlso: AH=12h"MultiDOS"
Index:	hotkeys;MultiDOS Plus
--------Q-151117BX0000-----------------------
INT 15 - DESQview v2.20+ - "ASSERTMAP" - GET/SET MAPPING CONTEXT
	AX = 1117h
	BX = 0000h	get current mapping context without setting
	     nonzero	set new mapping context
Return: BX = mapping context in effect before call
	interrupts enabled
Notes:	this function differs from AX = DE17h for DESQview v2.20 through 2.25
	mapping contexts determine conventional-memory addressability; setting
	  a mapping context ensures that the associated program and data areas
	  are in memory for access.  Usable by drivers, TSRs and shared
	  programs.
	caller need not be running under DESQview, but must ensure that the
	  stack in use will not be mapped out by the call
SeeAlso: AX=DE17h,INT 2F/AX=1685h
--------m-1511DE-----------------------------
INT 15 - DESQview - QEXT.SYS - INSTALLATION CHECK
	AX = 11DEh
Return: CF clear if installed
	    AX = segment at which QEXT.SYS is located
Desc:	QEXT.SYS is Quarterdeck's HMA manager for DESQview; more recent
	  versions also implement the XMS standard
Note:	a private entry point (see #00434) may be found by searching the
	  beginning of the returned segment for the signature string
	  "QUARTERDECK EXTENDED MEMORY MANAGER 286"; the word immediately
	  prior to the signature contains the QEXT version number in BCD,
	  and the word prior to that contains the offset within the QEXT
	  code segment of the private entry point
SeeAlso: INT 2F/AX=4310h"XMS",INT 67/AH=3Fh

(Table 00434)
Call QEXT.SYS private entry point with:
	AH = 00h ???
	AH = nonzero ???
--------T-1512-------------------------------
INT 15 - VMiX - "sys_sleep" - PUT PROCESS TO SLEEP
	AH = 12h
	STACK:	WORD	process ID
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=03h"MultiDOS",AX=101Dh,AH=13h"VMiX"
--------T-1512-------------------------------
INT 15 - MultiDOS Plus - TURN ON AltZ TOGGLE
	AH = 12h
Note:	enables the Alt-Z MultiDOS command/program-selection hotkey
SeeAlso: AH=11h"MultiDOS"
Index:	hotkeys;MultiDOS Plus
--------Q-1512--BH00-------------------------
INT 15 - TopView - SEND MESSAGE - "HANDLE" - RETURN OBJECT HANDLE
	AH = 12h
	BH = 00h
	BL = which handle to return
	    00h handle in DWORD on top of stack
	    01h current task's window handle
	    02h given task's mailbox handle (task's handle on stack)
	    03h current task's mailbox handle
	    04h given task's keyboard handle (task's handle on stack)
	    05h current task's keyboard object handle
	    06h given task's OBJECTQ handle (task's handle on stack)
	    07h current task's OBJECTQ handle
	    08h	  \
	      thru > return 0000:0000 under DV < 2.26
	    10h	  /
	    0Ch (2.26+) task owning object with handle in DWORD on top of stack
	    0Dh (2.26+) task handle of owner (parent) of current task
Return: DWORD on top of stack is object handle
Note:	BL=0Ch,0Dh returns 00000000h if the object is not open (keyboard,
	  mailbox, panel, pointer, and timer objects) or is an orphan (task,
	  window)
SeeAlso: AH=12h/BH=02h,AH=12h/BH=80h
--------Q-1512--BH01-------------------------
INT 15 - TopView - SEND MESSAGE - "NEW" - CREATE NEW OBJECT
	AH = 12h
	BH = 01h
	BL = object type to create (see #00435)
	STACK: (only if window object or WINDOW class)
	       DWORD address to jump to (no new task if high word == 0)
	       DWORD (reserved) 0 = non-task window, FFFFh = task window
	       DWORD bytes for task's private stack (FFFFh == default of 0100h)
	       DWORD bytes system memory for input buffer for READ/READN
			(0 == none, -1 == default--same as logical window size)
	       DWORD window size, columns
	       DWORD window size, rows
	       DWORD length of window title
	       DWORD address of window title
Return: DWORD on top of stack is new object handle
Notes:	if a new task is created, it is started with
	  AX = BX = SI = DI = BP = 0
	  DX:CX = handle of parent task
	  DS = ES = SS = segment of private stack (and new task's handle)
	new windows are orphans, inherit the colors/hidden status of the
	  creating task's window, and are placed in the upper left hand corner
	  of the screen but not automatically redrawn
	new keyboards are closed, and have all object bits cleared except for
	  the hardware cursor bit
SeeAlso: AH=12h/BH=02h,AH=12h/BH=81h

(Table 00435)
Values for TopView/DESQview object type (for creation):
 00h	(DV 2.0x only) handle is DWORD on top of stack
 01h	(DV 2.0x only) use task's window handle
 02h	(DV 2.0x only) given task's mailbox (task's handle on stack)
 03h	(DV 2.0x only) current task's mailbox
 04h	(DV 2.0x only) given task's keyboard (task's handle on stack)
 05h	(DV 2.0x only) current task's keyboard object
 08h	WINDOW class
 09h	MAILBOX class
 0Ah	KEYBOARD class
 0Bh	TIMER object (counts down 32-bit time in 10ms increments)
 0Fh	POINTER object
 10h	PANEL object
--------Q-1512--BH02-------------------------
INT 15 - TopView - SEND MESSAGE - "FREE" - FREE AN OBJECT
	AH = 12h
	BH = 02h
	BL = object
	    00h handle in DWORD on top of stack
		window: close window and free
		timer: free timer
		panel: free panel object
		pointer: free pointer
	    01h task's window handle - kills task, never returns
	    02h given task's mailbox (task's handle on top of stack)
	    03h current task's mailbox
	    04h given task's keyboard (task's handle on top of stack)
	    05h current task's keyboard object
Return: STACK popped if handle passed on stack
Notes:	when a window is freed, its keyboard and pointer objects are freed;
	  task windows also free any mailbox, objectq, and panel objects held
	  by the task and any child tasks
	if the keyboard being freed is the default keyboard for a task, this
	  call is equivalent to CLOSE
	panel and pointer objects are automatically closed if open
SeeAlso: AH=12h/BH=01h,AH=12h/BH=0Dh,AH=12h/BH=82h
--------Q-1512--BH03-------------------------
INT 15 - TopView - SEND MESSAGE - "ADDR" - GET HANDLE OF MESSAGE SENDER
	AH = 12h
	BH = 03h
	BL = object
	    00h mailbox handle in DWORD on top of stack
	    02h sender of last msg read from mailbox (task's handle on stack)
	    03h sender of last msg read from current task's mailbox
Return: DWORD on stack is task handle of message sender
SeeAlso: AH=12h/BH=00h,AH=12h/BH=83h
--------Q-1512--BH03-------------------------
INT 15 - DESQview v2.26+ - "CONNECT" - CONNECT TWO WINDOWS
	AH = 12h
	BH = 03h
	BL = window to be connected
	    00h handle of window to be attached in DWORD on top of stack
	    01h attach current task's main window
	STACK: DWORD handle of window to attach to or 00000000h to detach
Return: STACK popped
Notes:	when two windows are connected, both will move if the user moves either
	multiple windows may be attached to a single window, but each window
	  may only be attached to one window at a time
SeeAlso: AH=12h/BH=83h
--------Q-1512--BX0300-----------------------
INT 15 - TopView - SEND MESSAGE - "DIR" - GET PANEL FILE DIRECTORY
	AH = 12h
	BX = 0300h
	STACK: DWORD handle of panel object (see #00436)
Return: STACK: DWORD length of directory (always multiple of 14 bytes)
	       DWORD address of directory
Note:	a null string is returned if the object is not open
SeeAlso: AH=12h/BX=0400h"APPLY",AH=12h/BH=83h

Format of TopView panel file:
Offset	Size	Description	(Table 00436)
 00h  2 BYTEs	C0h C3h
 02h	BYTE	number of panels in file
 03h	for each panel in file:
	    8 BYTEs  blank-padded panel name
	      DWORD  panel offset in file
	      WORD   panel length
	data for panels (each consists of one or more window/query/manager
	  streams); first byte of each panel must be 1Bh, fifth byte must be
	  E5h
--------Q-1512--BH04-------------------------
INT 15 - TopView - SEND MESSAGE - "READ" - READ NEXT LOGICAL LINE OF WINDOW
	AH = 12h
	BH = 04h
	BL = window to read from
	    00h handle is DWORD on top of stack
	    01h use calling task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent task of current task
Return: STACK:	DWORD number of bytes read
		DWORD address of buffer
Notes:	reading starts at the current logical cursor position; the cursor is
	  updated to point at the character following the last one read
	any translucent blanks (FFh) which are visible on screen are changed
	  to the character which is seen through them
	the string produced by the read is placed in an input buffer which may
	  be reused by the next READ or READN of a window
	window stream opcodes D8h and D9h determine whether the read returns
	  characters or attributes
SeeAlso: AH=12h/BH=05h"WINDOW",AH=12h/BH=12h,AH=12h/BH=84h
--------Q-1512--BH04-------------------------
INT 15 - TopView - SEND MESSAGE - "READ" - GET NEXT RECORD FROM OBJECT
	AH = 12h
	BH = 04h
	BL = object
	    00h handle is DWORD on top of stack
		mailbox: wait for and get next message
		keyboard: wait for and get pointer to next input buffer
		pointer: wait for and get next message
	    02h get next message from mailbox (task's handle on top of stack)
	    03h get next message from current task's mailbox
	    04h get the next input from keyboard (handle on top of stack)
	    05h get the next input from task's default keyboard
	    06h wait for input from any object in OBJECTQ (handle on stack)
	    07h wait for input from any object in task's default OBJECTQ
Return: STACK: (if objectq) DWORD handle of object with input
	       (otherwise)  DWORD number of bytes
			    DWORD address of pointer message (see #00437)
Notes:	for a keyboard in keystroke mode, the input buffer is a single byte
	  containing the character code as returned by the BIOS; the BIOS scan
	  code is available via the STATUS call if the character is zero
	for a keyboard in field mode, the input buffer format is determined
	  by the field table header for the window the keyboard is attached to
	keyboard input buffers and mailbox message buffers may be invalidated
	  by the next READ, ERASE, CLOSE, or FREE message to the same object
SeeAlso: AH=12h/BH=05h"OBJECT",AH=12h/BH=84h

Format of DESQview pointer message:
Offset	Size	Description	(Table 00437)
 00h	WORD	row
 02h	WORD	column
 04h	BYTE	status (see #00438)
 05h	BYTE	field number or zero (APILEVEL >= 2.00 only)

Bitfields for DESQview pointer status:
Bit(s)	Description	(Table 00438)
 7-2	number of clicks-1 if multiple-click mode active
 7	set when press/release mode active and button pressed
 6	set when press/release mode active and button released
 1-0	button pressed (00=none,01=button1,10=button2)
SeeAlso: #00437
--------Q-1512--BX0400-----------------------
INT 15 - TopView - SEND MESSAGE - "READ" - WAIT FOR TIMER TO EXPIRE
	AH = 12h
	BX = 0400h
	STACK: DWORD timer's handle
Return: after timer expires
	STACK: DWORD time in 1/100 sec after midnight when timer expired
SeeAlso: AH=12h/BH=0Ah,AH=12h/BH=84h
--------Q-1512--BX0400-----------------------
INT 15 - TopView - SEND MESSAGE - "APPLY" - WRITE PANEL TO WINDOW
	AH = 12h
	BX = 0400h
	STACK: DWORD handle of panel object
	       DWORD window's handle (or 0 for current task's window)
	       DWORD length of panel name
	       DWORD pointer to panel name
Return: STACK: DWORD handle of window which was used
	       DWORD handle of keyboard or 0
Notes:	status of APPLY may be checked with STATUS message
	panel MUST have the following format
	  first byte must be 1Bh (i.e. must start with a stream)
	  first opcode in stream must be E5h
	    single byte arg of opcode is interpreted thus:
	      bits 7,6	11 means create new window
			10 means create new field table for existing window
			01 means use existing window and field table
	      bit 5 if set, panel contains a field table
			(creates a new keyboard and puts it in field mode)
	      bit 4 if set, panel contains input fields
	      bit 3 if set, panel contains select fields but no input fields
	if the panel contains input or select fields, a keyboard handle is
	  returned; either the window's current open keyboard or a
	  newly-created keyboard object.  The caller should read that keyboard
	  to obtain input from the panel.
SeeAlso: AH=12h/BH=84h
--------Q-1512--BH05------------------------
INT 15 - TopView - SEND MESSAGE - "WRITE" - WRITE TO OBJECT
	AH = 12h
	BH = 05h
	BL = object
	    00h handle is DWORD on top of stack
		timer: start timer to end at a specified time
		keyboard: add input buffer to queue
		pointer: move pointer icon to specified position
	    02h send message by value/status=0 to mbox (task's handle on stack)
	    03h send message by value/status=0 to current task's mailbox
	    04h add input buffer to KEYBOARD queue (handle on top of stack)
	    05h add input buffer to task's default KEYBOARD queue
	    06h add an object to OBJECTQ (handle on top of stack)
	    07h add an object to task's default OBJECTQ
	STACK: (if mailbox)  DWORD length
			     DWORD address
	       (if keyboard) DWORD status (scan code in keystroke mode)
			     DWORD length (should be 1 in keystroke mode)
			     DWORD address
	       (if objectq)  DWORD handle of object to add
	       (if timer)    DWORD 1/100ths seconds since midnight (actually
				   only accurate to 1/18 sec)
	       (if pointer)  DWORD column relative to origin of window
			     DWORD row relative to origin of window
Return: STACK popped
Notes:	under DV 2.2+, failed mailbox writes may return CF set (see AX=DE15h)
	the data and status written to a keyboard object must match the format
	  returned by the keyboard object in the current mode
	the pointer position is scaled according to the current scaling factors
SeeAlso: AH=12h/BH=04h,AH=12h/BH=85h
--------Q-1512--BH05-------------------------
INT 15 - TopView - SEND MESSAGE - "WRITE" - WRITE STRING TO WINDOW
	AH = 12h
	BH = 05h
	BL = window to write to
	    00h DWORD on top of stack is window handle
	    01h write string to task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent of current task
	STACK: DWORD object handle if handle passed on stack
	       DWORD total length of string (high word == 0)
	       DWORD address of string to display (see #00439)
Return: indicated actions performed
	a. non-control characters are displayed (opcodes DEh and DFh control
	   whether the attributes are left or changed to the current attrib)
	b. CR/LF/BS/Tab cause the usual cursor movement
	c. ESC starts a data structure with additional commands if following
	   byte is less than 20h; otherwise, it is written to the window
	STACK:	DWORD handle of new window if window stream opcode E6h
		else nothing (arguments have been popped)
SeeAlso: AH=12h/BH=04h,AH=12h/BH=85h

Format of stream data structure:
Offset	Size	Description	(Table 00439)
 00h	BYTE	1Bh magic value identifying start of stream
 01h	BYTE	stream type (00h, 01h, 10h, 14h-1Fh legal)
		(see #00440,#00446,#00447,#00448)
 02h	WORD	length of remainder of stream in bytes
	var-length fields follow, each an OPCODE followed by
	     zero or more args

(Table 00440)
Values for MODE 00h (set or display values) "WINDOW STREAM" opcodes:
Opcodes:args
 00h  display 20h blanks with the default attribute
 01h-1Fh display OPCODE blanks with the default attribute
 20h  display char with default attribute 20h times
	BYTE char to repeat
 21h-3Fh display char with default attribute OPCODE-20h times
	BYTE char to repeat
 40h  display 20h blanks with specified attribute
	BYTE attribute of blanks
 41h-5Fh display OPCODE-40h blanks with specified attribute
	BYTE attribute of blanks
 60h  display next 20h characters
	20h BYTEs characters to display
 61h-7Fh display next OPCODE-60h characters
	N BYTEs characters to display
 80h-87h display N blanks with default attribute
	BYTE low 8 bits of 11-bit count (high 3 in low 3 bits of OPCODE)
		  [000h means 800h]
 88h-8Fh display N copies of the character
	BYTE low 8 bits of 11-bit count (high 3 in low 3 bits of OPCODE)
		  [000h means 800h]
	BYTE character to repeat
 90h-97h display N blanks with specified attribute
	BYTE low 8 bits of 11-bit length (high 3 in low 3 bits of OPCODE)
		  [000h means 800h]
	BYTE attribute
 98h-9Fh display string at logical cursor pos
	BYTE low 8 bits of 11-bit length (high 3 in low 3 bits of OPCODE)
		  [000h means 800h]
	N BYTEs string to display
 A0h  set logical cursor row
	BYTE row number (0 is top)
 A1h  set logical cursor column
	BYTE column number (0 is leftmost)
 A2h  set top edge of scrolling region
	BYTE row
 A3h  set left edge of scrolling region
	BYTE column
 A4h  set row of physical window position
	BYTE line
 A5h  set column of physical window position
	BYTE column
 A6h  set height of physical window
	BYTE number of rows
 A7h  set width of physical window
	BYTE number of columns
 A8h  set viewport row
	BYTE row
 A9h  set viewport column
	BYTE column
 AAh  set virtual screen height [contents of window unpredictable after]
	BYTE rows
 ABh  set virtual screen width [contents of window unpredictable after]
	BYTE columns
 ACh-AEh unused
 AFh  set compatible/preferred video modes
	BYTE compatibility/preference mask
		bit 7	compatible with monochrome
		bit 6	compatible with color text, EGA/VGA graphics
		bit 5	compatible with medium-resolution CGA graphics
		bit 4	compatible with high-resolution CGA graphics
		bit 3	prefer monochrome
		bit 2	prefer color text, EGA/VGA graphics
		bit 1	prefer medium-resolution CGA graphics
		bit 0	prefer high-resolution CGA graphics
 B0h  move logical cursor down
	BYTE number of rows (signed, negative values move up)
		[if rows=0 and hardware cursor owner, update hardware cursor]
 B1h  move logical cursor right
	BYTE number of columns (signed, negative values move left)
		[if cols=0 and hardware cursor owner, update hardware cursor]
 B2h  shift top edge of scrolling region
	BYTE number of rows (signed)
 B3h  shift left edge of scrolling region
	BYTE number of columns (signed)
 B4h  shift physical window down
	BYTE number of lines (signed)
 B5h  shift physical window right
	BYTE number of columns (signed)
 B6h  expand physical window vertically
	BYTE number of lines (signed)
 B7h  expand physical window horizontally
	BYTE number of columns (signed)
 B8h  adjust viewport row
	BYTE number of rows (signed)
 B9h  adjust viewport column
	BYTE number of columns (signed)
 BAh  adjust virtual screen height [contents of window unpredict after]
	BYTE number of rows to increase (signed)
 BBh  adjust virtual screen width [contents of window unpredictbl after]
	BYTE number of columns to increase (signed)
 BCh-BFh reserved (currently unused)
 C0h  set logical cursor position
	BYTE row number (0 is top border)
	BYTE column number (0 is left border)
 C1h  set top left corner of scrolling region
	BYTE row
	BYTE column
 C2h  set physical window pos
	BYTE upper left row (no top border if 0)
	BYTE upper left column (no left border if 0)
 C3h  set current window size
	BYTE number of rows
	BYTE number of columns
 C4h  set upper left corner of viewport (portion of virtual screen displayed
	  in window)
	BYTE row
	BYTE column
 C5h  set size of virtual screen [contents unpredictable afterwards]
	BYTE number of rows
	BYTE number of columns
 C6h  unused
 C7h  unused
 C8h  set logical cursor relative to current position
	BYTE number of rows to move down (signed)
	BYTE number of columns to move right (signed)
		[if rows=cols=0 and hardware cursor owner, update hardw cursor]
 C9h  shift top left corner of scrolling region
	BYTE number of rows (signed)
	BYTE number of columns (signed)
 CAh  set window pos relative to current position
	BYTE number of rows to shift down (signed)
	BYTE number of columns to shift right (signed)
 CBh  set window size relative to current size
	BYTE number of rows to expand (signed)
	BYTE number of cols to expand (signed)
 CCh  shift viewport relative to current position
	BYTE rows to shift (signed)
	BYTE cols to shift (signed)
 CDh  resize virtual screen
	BYTE number of rows to expand (signed)
	BYTE number of columns to expand (signed)
 CEh  scroll text when using E8h-EBh/F8h-FBh opcodes (default)
 CFh  scroll attributes when using  E8h-EBh/F8h-FBh opcodes
 D0h  allow window frame to extend beyond screen
 D1h  always display a complete frame, even if window extends beyond edge of
	  screen
 D2h  allow DV to change logical colors on video mode switch (default)
 D3h  application changes logical attributes
 D4h  window is visible [must redraw to actually make visible]
 D5h  window is hidden [must redraw to actually remove]
 D6h  window has frame (default)
 D7h  window unframed [must redraw to actually remove frame]
 D8h  READ/READN will read characters from window (default)
 D9h  READ/READN will read attributes from window
 DAh  use logical attributes, which may be remapped (see #00441)
 DBh  use physical attributes for characters
 DCh  enable special actions for control characters (default)
 DDh  disable special control char handling, all chars displayable by BIOS TTY
	  call
 DEh  write both character and attribute (default)
 DFh  write character only, leave attribute untouched
 E0h  repeat following commands through E1h opcode
	BYTE number of times to repeat (00h means 256 times)
 E1h  end of commands to repeat, start repeating them
 E2h  set current output color
	BYTE color
 E3h  clear virtual screen from scroll origin to end using current color
 E4h  redraw window
 E5h  select menu style
	BYTE style (normally 18h)
		bits 5,4 = 01 use two-letter menu entries for remainder of
		  this stream
 E5h  (panel file only)
	BYTE modifier
		bits 7,6 = 11 panel stream creates new window
			 = 10 panel defines new field table for existing window
			 = 01 panel stream uses existing window & field table
		bit 5 = 1 stream contains a field table (create kyboard object)
		bit 4 = 1 stream defines input fields (create keyboard object)
		bit 3 = 1 stream defines select fields but not input fields
		bit 2 = 1 stream defines exclusive input window (DV 2.2)
		bit 1 reserved
		bit 0 reserved
 E6h  create new window and perform rest of manipulations in new window
	BYTE number of rows
	BYTE number of columns
	Return: DWORD object handle of new window returned on stack at end
	Note:	the window is created with a physical size of 0x0 at the
		  same position as the window to which this stream was sent
 E7h  no operation
 E8h  scroll area up (top left corner defined by opcode C1h)
	BYTE height
	BYTE width
 E9h  scroll area down (top left corner defined by opcode C1h)
	BYTE height
	BYTE width
 EAh  scroll area left (top left corner defined by opcode C1h)
	BYTE height
	BYTE width
 EBh  scroll area right (top left corner defined by opcode C1h)
	BYTE height
	BYTE width
 ECh  set logical attributes for window contents
	BYTE video modes command applies to
		bit 7	monochrome
		bit 6	color text, EGA/VGA graphics
		bit 5	medium-resolution CGA graphics
		bit 4	high-resolution CGA graphics
	BYTE which attributes to set
		bit 7	if set, copy single following byte to indicated attribs
		bits 4-6  number of first attribute to change - 1
		bits 0-3  number of consecutive attributes to change
	N BYTEs new attributes
 EDh  set logical attributes for window frame
	BYTE video modes command applies to (also see opcode ECh)
	BYTE which attributes to set
		bit 7	if set, copy single following byte to indicated attrs
		bits 4-6  number of first attribute to change - 1
		bits 0-3  number of consecutive attributes to change
	N BYTEs new attributes
		  attributes
		       1 = top left corner
		       2 = top right corner
		       3 = bottom left corner
		       4 = bottom right corner
		       5 = top edge
		       6 = bottom edge
		       7 = left edge
		       8 = right edge
 EEh  set characters for window frame
	BYTE video modes command applies to (also see opcode ECh)
	BYTE which characters to set
		bit 7	if set, copy single following byte to indicated chars
		bits 4-6  number of first character to change - 1
		bits 0-3  number of consecutive characters to change
	N BYTEs new chars (same relative position as attributes above)
 EFh  set window name
	BYTE length of name (should be in range 0 to logical screen width)
	N BYTEs name
 F0h  clear input field to blanks
	BYTE field number
 F1h  fill input field with character
	BYTE field number
	BYTE char
 F2h  set color of input field
	BYTE field number (1-N)
	BYTE attribute
 F3h  set initial contents of input field
	BYTE field number (1-N)
	N BYTEs enough chars to exactly fill field as defined by op FFh
 F4h  position cursor to start of specific input field
	BYTE field number (1-N)
 F5h  change field table entry
	BYTE field number
	7-8 BYTEs field table entry (also see opcode FFh below)
 F6h  set field type
	BYTE field number
	BYTE type
		00h inactive
		40h output field
		80h input field
		C0h deselected field
		C2h selected field
 F7h  "broadcast write"	write data to fields with program output bit set in
	  the field table entry, in field number order
	N BYTEs (total length of all program output fields)
 F8h  scroll field up a line
	BYTE field number
 F9h  scroll field down a line
	BYTE field number
 FAh  scroll field left
	BYTE field number
 FBh  scroll field right
	BYTE field number
 FCh  set field table header
	6 BYTEs	field table header (see #00442)
 FDh  reset modified bit for all fields
 FEh  reset selected and modified bits for all fields
 FFh  set up input fields
	6 BYTEs	table header (see #00442)
	7/8N BYTEs the field table entries, one for each field (see #00444)
	Note:	DESQview uses and updates the actual copy of the information
		  which is contained in the stream.  Thus this info must remain
		  intact until after the data entry is complete.
SeeAlso: #00439,#00446

(Table 00441)
Values for TopView logical attributes:
 01h	normal text
 02h	highlighted normal text
 03h	help text
 04h	highlighted help text
 05h	error message
 06h	highlighted error message
 07h	emphasized text
 08h	marked text
 9-16	reverse video versions of 1-8
SeeAlso: #00440

Format of TopView field table header:
Offset	Size	Description	(Table 00442)
 00h	BYTE	number of fields (must be <= existing number of fields)
 01h	BYTE	screen behavior bits (see #00443)
 02h	BYTE	current input field (updated by DESQview)
 03h	BYTE	current select field (updated by DESQview)
 04h	BYTE	attribute for select fields when they are pointed at
 05h	BYTE	attribute for select fields which have been selected
SeeAlso: #00440,#00444

Bitfields for TopView screen behavior bits:
Bit(s)	Description	(Table 00443)
 7	reserved
 6	menu items may be selected via keyboard
 5	left mouse button in "status" mode (press anywhere in window
	  immediately returns control to application)
 4	right mouse button in "status" mode
 3	select fields return contents or blanks rather than 'Y' or 'N'
 2	modified bits reset on return to application
 1-0	type of data returned
	00 no data returned on read of keyboard
	01 data returned as array of characters containing all fields packed
	      together, with no field numbers
	10 data returned as numbered variable-length records for all fields
	11 data returned as numbered variable-length records for the fields
	      which were modified
SeeAlso: #00440

Format of TopView field table entry:
Offset	Size	Description	(Table 00444)
 00h	BYTE	start row    \
 01h	BYTE	start column  \ if menu selection and start is to
 02h	BYTE	end row	      / right or below end, select from kbd only
 03h	BYTE	end column   /
 04h	BYTE	field type (see #00445)
 05h	BYTE	modifier
		if type is fill-in, then bit flags to determine behavior
		  bit 7	 automatically enter CR when field full
		  bit 6	 move to next field when current field is full
		  bit 5	 enter text from right end (for numbers)
		  bit 4	 force input to uppercase
		  bit 3	 clear old contents on first keystroke
		  bit 2	 input returned when cursor moves out of
			  modified field ("validate", API level 2.02+)
		  bit 1	 reserved
		  bit 0	 reserved
		if select field, first key to press to activate
		  00h if have to point-&-click or is an extended-ASCII
		      keystroke (only if two-key menus enabled)
 06h	BYTE	(select field only) normal color of field
 07h	BYTE	second key for select field.  This byte is present iff
		  two-letter menu entries selected with opcode E5h, and in that
		  case is present regardless of field type
SeeAlso: #00442

Bitfields for TopView field type:
Bit(s)	Description	(Table 00445)
 7,6	field class
	00 inactive (non-entry) field
	01 echos keystrokes input to make menu selection
	10 fill-in field
	11 select field
 5	field can be filled by broadcast write (F7h opcode)
 4	reserved
 3	reserved
 2	reserved
 1	set if field selected
 0	set if field modified
SeeAlso: #00444

(Table 00446)
Values for MODE 01h "QUERY STREAM" opcodes:
(valid only for those opcodes listed here)
 A0h return logical cursor row in next byte
 A1h return logical cursor column in next byte
 A2h return top row of scrolling region in next byte
 A3h return left column of scrolling region in next byte
 A4h return row of physical window origin in next byte
 A5h return column of physical window origin in next byte
 A6h return height of physcial window in next byte
 A7h return width of physical window in next byte
 A8h return row of viewport origin in next byte
 A9h return column of viewport origin in next byte
 AAh return height of virtual screen in next byte
 ABh return width of virtual screen in next byte
 AFh return current video mode in next byte
 C0h return current logical cursor position in next two bytes
 C1h return top left corner of scrolling region in next two bytes
 C2h return current window position in next two bytes
 C3h return current window size in next two bytes
 C4h return current viewport origin in next two bytes
 C5h return current virtual screen size in next two bytes
 D0h \ overwritten with D0h if frames may fall off screen edge
 D1h /		       D1h if frames always displayed entirely
 D2h \ overwritten with D2h if DESQview controls color palette
 D3h /		       D3h if application changes color palette
 D4h \ overwritten with D4h if window visible
 D5h /		       D5h if window hidden
 D6h \ overwritten with D6h if window has frame
 D7h /		       D7h if window unframed
 D8h \ overwritten with D8h if reading characters from window
 D9h /		       D9h if reading attributes from window
 DAh \ overwritten with DAh if using logical attributes
 DBh /		       DBh if using physical attributes
 DCh \ overwritten with DCh if TTY control char interpretation on
 DDh /		       DDh if TTY control char interpretation off
 DEh \ overwritten with DEh if writing both characters and attributes
 DFh /		       DFh if leaving attributes untouched
 E2h return current color in next byte
 ECh get logical attributes for window contents
	BYTE execute call if currently in specified video mode
		bit 7	monochrome
		bit 6	color text, EGA/VGA graphics
		bit 5	medium-resolution CGA graphics
		bit 4	high-resolution CGA graphics
	BYTE which attributes to get
		bit 7	unused???
		bits 4-6 first attribute to get - 1
		bits 0-3 number of consecutive attributes
	N BYTEs buffer to hold attributes
 EDh get logical attributes for window frame
	BYTE execute call if currently in video mode (also see opcode ECh)
	BYTE which attributes to get
		bit 7	unused???
		bits 4-6 first attribute to get - 1
		bits 0-3 number of consecutive attributes
	N BYTEs buffer to hold attributes
 EEh get characters for window frame
	BYTE execute call if currently in video mode (also see opcode ECh)
	BYTE which attributes to get
		bit 7	unused???
		bits 4-6 first char to get - 1
		bits 0-3 number of consecutive chars
	N BYTEs buffer to hold chars
 EFh return first N characters of current window name
	BYTE	max length of returned name
	N BYTEs buffer to hold window name
 F3h return contents of specified field
	BYTE field number
	N BYTEs buffer to hold field contents (size equal to field size)
 F5h get field table entry
	BYTE field number
	7-8 BYTEs buffer to hold field table entry (see #00444)
	Notes:	DV < 2.26 always returns 7 bytes
		DV 2.26+ w/ APILEVEL < 2.26 returns 8 bytes iff field table
		  is using 8-byte entries and eighth byte after	F5h is E7h
		  (NOP); otherwise, 7 bytes are returned
		DV 2.26+ w/ APILEVEL > 2.26 returns 7 or 8 bytes depending
		  on the field table entry size
 F6h get type of a field
	BYTE field number
	BYTE type
 FCh get field table header
	6 BYTEs buffer to store field table header (see #00442)
SeeAlso: #00439,#00447

(Table 00447)
Values for MODE 10h "MANAGER STREAM" opcodes (valid only for those listed):
 00h allow window to be moved horizontally
 01h allow window to be moved vertically
 02h allow window to change width
 03h allow window to change height
 04h allow window to be scrolled horizontally
 05h allow window to be scrolled vertically
 06h allow "Close Window" menu selection for application
 07h allow "Hide Window" menu selection for application
 08h allow application to be suspended ("Rearrange/Freeze")
 0Eh allow "Scissors" menu
 10h allow DESQview main menu to be popped up
 11h allow "Switch Windows" menu
 12h allow "Open Window" menu
 13h allow "Quit" menu selection
 20h-33h opposite of 00h-13h, disallow specified action
 40h notify if horizontal position of window changes
 41h notify if vertical position of window changes
 42h notify if width of window changes
 43h notify if height of window changes
 44h notify if window scrolled horizontally
 45h notify if window scrolled vertically
 46h notify if window is closed--program has to clean up and exit itself
 47h notify if window is hidden
 48h notify if "?" on main menu selected
 49h notify if pointer message sent to window
 4Ah notify if window is placed in foreground
 4Bh notify if window is placed in background
 4Ch notify if video mode changes
 4Dh notify if "Scissors" menu "Cut" option selected
 4Eh notify if "Scissors" menu "Copy" option selected
 4Fh notify if "Scissors" menu "Paste" option selected
 50h notify if DESQview main menu about to pop up
 51h notify if DESQview main menu popped down
 60h-71h	 opposite of 40h-51h: don't notify on specified event
 84h attach window to parent task's window (both move together)
 85h detach window from parent task's window (may move independently)
 86h disable background operation for application
 87h enable running in background
 88h set minimum size of physical window
	BYTE rows
	BYTE columns
 89h set maximum size of physical window
	BYTE rows
	BYTE cols
 8Ah set primary asynchronous notification routine (see #00449)
	DWORD address of routine, 0000h:0000h means none (see also below)
 8Bh set async notification parameter
	DWORD 32-bit value passed to 8Ah async routine in DS:SI
 ACh (DV2.2+) perform regular select field attribute processing
 ADh (DV2.2+) protect attributes in selected field from being lost
 AEh make window default notify window for owning app (API level 2.00+)
 AFh set selected field marker character
	BYTE character to display at left edge of selected fields
 BCh set standard field processing mode
 BDh set alternate field processing mode (enables cursor pad for menus)
 BEh disables changing reverse logical attributes with ECh opcode
 BFh enables changing reverse logical attributes with ECh opcode
 C0h make current window topmost in system
 C1h force current process into foreground
 C2h make current window topmost in process
 C3h position mouse pointer relative to origin of current field
	BYTE rows below upper left corner of field
	BYTE columns to right of upper left corner of field
 C4h position mouse pointer relative to origin of given field
	BYTE field number
	BYTE rows below upper left corner of field
	BYTE columns to right of upper left corner of field
 C5h orphan current window (also hides it)
	Note: must be last in stream; all subsequent commands ignored
 C6h show all windows for this process
 C7h hide all windows for this process
 C8h suspend process and hide all its windows
 C9h force current process into background
 CAh make current window bottom-most in process
 CBh cancel current window manager operation, remove DV menu, give control
	  to topmost application
 CCh orphan window and give it to the system for use as paste data
 CEh reorder windows
	DWORD pointer to null-terminated list of words; each word is segment
		  of object handle for a window
 FFh no operation
SeeAlso: #00439,#00446,#00448

(Table 00448)
Values for MODES 14h to 1Fh "USER STREAMS":
	normally NOPs, but may be defined by SETESC message to invoke FAR
	routines, one for each mode number
	  on entry to handler,
		DS:SI -> first byte of actual stream (not header)
		CX = number of bytes in stream
		ES:DI = window's handle
SeeAlso: #00446,#00447

(Table 00449)
Values asynchronous notification routine defined by man.stream 8Ah called with:
	ES:DI = handle of window
	DS:SI is 32-bit value set by 8Bh manager stream opcode
	   mailbox contains message indicating event
	      Opcode
	       40h  horizontal movement
		   DWORD object handle of window
		   BYTE	 new row
		   BYTE	 new col
	       41h  vertical movement
		   DWORD object handle of window
		   BYTE	 new row
		   BYTE	 new col
	       42h  horizontal size change
		   DWORD object handle of window
		   BYTE	 new rows
		   BYTE	 new cols
	       43h  vertical size change
		   DWORD object handle of window
		   BYTE	 new rows
		   BYTE	 new cols
	       44h  scrolled horizontally
		   DWORD object handle of window
		   BYTE	 mouse row within window
		   BYTE	 mouse column within window
		   BYTE	 field mouse is on, 0 if none
		   BYTE	 amount moved: >0 right, <0 left, 0 done
	       45h  scrolled vertically
		   DWORD object hande of window
		   BYTE	 mouse row within window
		   BYTE	 mouse column within window
		   BYTE	 field mouse is on, 0 if none
		   BYTE	 amount moved: >0 down, <0 up, 0 done
	       46h  window close request
		   DWORD object handle of window
		   BYTE	 mouse pointer row
		   BYTE	 mouse pointer column
		   BYTE	 field mouse is on, 0 if none
	       47h  application's windows hidden
	       48h  Help for Program selected
		   DWORD object handle of window
		   BYTE	 mouse pointer row
		   BYTE	 mouse pointer column
		   BYTE	 field mouse is on, 0 if none
	       49h  pointer message sent to window
		   DWORD pointer handle which received message
	       4Ah  switched to window from another ("raise")
	       4Bh  switched away from the window ("lower")
	       4Ch  video mode changed
		   BYTE new BIOS video mode
	       4Dh  Scissors/cUt selected
		   DWORD object handle of window
		   BYTE	 row of upper left corner
		   BYTE	 column of upper left corner
		   BYTE	 field number ul corner is in, 0=none
		   DWORD handle of orphaned window created with
			 copy of data from specified region
		   BYTE	 height of region
		   BYTE	 width of region
	       4Eh  Scissors/Copy selected
		   DWORD object handle of window
		   BYTE	 row of upper left corner
		   BYTE	 column of upper left corner
		   BYTE	 field number ul corner is in, 0=none
		   DWORD handle of orphaned window created with
			 copy of data from specified region
		   BYTE	 height of region
		   BYTE	 width of region
	       4Fh  Scissors/Paste selected
		   DWORD object handle of window
		   BYTE	 row of upper left corner
		   BYTE	 column of upper left corner
		   BYTE	 field number ul corner is in, 0=none
		   DWORD handle of orphaned window with data
		   BYTE	 height of region
		   BYTE	 width of region
			Note: orphaned data window should be adopted or freed
				when done
	       50h  main menu about to pop up
	       51h  main menu popped down
Return: all registers unchanged
--------Q-1512--BH06-------------------------
INT 15 - DESQview 2.20+ - SEND MESSAGE - "SETPRI" - SET PRIORITY WITHIN OBJECTQ
	AH = 12h
	BH = 06h
	BL = object
	    00h object handle in DWORD on top of stack
		mailbox, keyboard, pointer, or timer
		(DV 2.50+) window
	    01h (DV 2.50+) current task's window
	    04h given task's keyboard (task's handle on top of stack)
	    05h current task's default keyboard
	STACK: DWORD new priority of object in task's OBJECTQ
			(new priority of task if window handle)
Return: STACK popped
Notes:	initially all objects have the same default value.  Should only make
	  relative adjustments to this default value.
	when changing priorities, all objects already on the objectq are
	  reordered
	for window handles, only the non-blocked task(s) with the highest
	  priority receive CPU time under DESQview 2.50-2.52; the default
	  priority is 0Ah
SeeAlso: AH=12h/BH=07h,AH=12h/BH=87h
--------Q-1512--BH07-------------------------
INT 15 - DESQview 2.20+ - SEND MESSAGE - "GETPRI" - GET PRIORITY WITHIN OBJECTQ
	AH = 12h
	BH = 07h
	BL = object
	    00h object handle in DWORD on top of stack
		mailbox, keyboard, pointer, or timer
		(DV 2.50+) window
	    01h (DV 2.50+) current task's window
	    04h given task's keyboard (task's handle on top of stack)
	    05h current task's default keyboard
Return: STACK: DWORD object priority
Note:	initially all objects have the same default value.  Should only make
	  relative adjustments to this default value.
SeeAlso: AH=12h/BH=06h
--------Q-1512--BH08-------------------------
INT 15 - TopView - SEND MESSAGE - "SIZEOF" - GET OBJECT SIZE
	AH = 12h
	BH = 08h
	BL = object
	    00h handle in DWORD on top of stack
		window: total character positions in window
		timer: elapsed time since timer started
		pointer: number of messages queued to pointer object
		panel: number of panels in panel file
		keyboard: number of input buffers queued
	    01h total chars in current task's default window
	    02h number of messages in task's mailbox (task's handle on stack)
	    03h number of messages in current task's mailbox
	    04h number of input buffers queued in task's kbd (handle on stack)
	    05h number of input buffers queued for current task's default kbd
	    06h number of objects queued in OBJECTQ (task's handle on stack)
	    07h number of objects queued in current task's OBJECTQ
	    0Ch (DV 2.26+) total chars in window owning handle on top of stack
	    0Dh (DV 2.26+) total chars in parent task's window
Return: DWORD on top of stack is result (any handle on stack has been popped)
Note:	for panel objects, a count of zero is returned if no panel file is open
	  for the object
SeeAlso: AH=12h/BH=04h,AH=12h/BH=09h
--------Q-1512--BH09-------------------------
INT 15 - TopView - SEND MESSAGE - "LEN" - GET OBJECT LENGTH
	AH = 12h
	BH = 09h
	BL = object
	    00h handle in DWORD on top of stack
		window: get chars/line
		timer: get 1/100 seconds remaining before timer expires
		mailbox: (DV/X) get number of bytes queued to mailbox
	    01h get number of chars/line in current task's default window
	    0Ch (DV 2.26+) get chars/line in window owning handle on top of stk
	    0Dh (DV 2.26+) get chars/line in parent task's window
Return: DWORD on top of stack is length (any handle on stack has been popped)
SeeAlso: AH=12h/BH=08h
--------Q-1512--BH0A-------------------------
INT 15 - TopView - SEND MESSAGE - "ADDTO" - WRITE CHARS AND ATTRIBS TO WINDOW
	AH = 12h
	BH = 0Ah
	BL = window to write to
	    00h window handle is DWORD on top of stack
	    01h current task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent of current task
	STACK:	DWORD count of attributes
		DWORD address of attribute string
		DWORD count of characters
		DWORD address of character string
Return: STACK popped
Notes:	if one string is longer than the other, the shorter one will be reused
	  until the longer one is exhausted
	the cursor is left just after the last character written
SeeAlso: AH=12h/BH=0Bh"WINDOW"
--------Q-1512--BH0A-------------------------
INT 15 - TopView - SEND MESSAGE - "ADDTO" - SEND MAILBOX MESSAGE/STAT BY VALUE
	AH = 12h
	BH = 0Ah
	BL = mailbox to write to
	    00h handle is DWORD on top of stack
	    02h default mailbox of task whose handle is on top of stack
	    03h current task's default mailbox
	STACK:	DWORD	status (low byte)
		DWORD	length of message
		DWORD	address of message
Return: STACK popped
Notes:	the message is copied into either system or common memory
	insufficient memory normally causes the process to be aborted; under
	  DESQview 2.2+, failed writes may return CF set instead (see AX=DE15h)
SeeAlso: AH=12h/BH=0Bh"MAILBOX"
--------Q-1512--BH0A-------------------------
INT 15 - TopView - SEND MESSAGE - "ADDTO" - SET OBJECT BITS
	AH = 12h
	BH = 0Ah
	BL = object
	    00h handle is DWORD on top of stack
		timer: start timer for specified interval
		pointer: set control flags (see #00451)
		keyboard: set control flags (see #00450)
	    04h set control flags on KEYBOARD object (handle on top of stack)
	    05h set control flags on task's default KEYBOARD object
	STACK: (if timer)   DWORD duration in 1/100 seconds
	       (otherwise)  DWORD bits to set
Return: STACK popped
SeeAlso: AH=12h/BH=0Bh"OBJECT"

Bitfields for DESQview keyboard object bits:
Bit(s)	Description	(Table 00450)
 15	reserved, can't be set
 14	unused
 13	reserved, can't be set
 12-6	unused
 5	(DV 2.2+) exclusive input
 4	filter all keys (used with handler established by SETESC)
	if 0, only keys that would normally be displayed are filtered
 3	program continues executing while input in progress
 2	insert mode active for field mode
 1	hardware cursor displayed when task is hardware cursor owner
	must be set if keyboard in field mode and field table includes input
	  fields
 0	keyboard is in field mode rather than keystroke mode

Bitfields for DESQview pointer object bits:
Bit(s)	Description	(Table 00451)
 15	reserved, can't be set
 14-8	unused
 7	mouse pointer is hidden while in window
 6	get messages even if window not topmost
 5	get messages even if window not foreground
 4	multiple clicks separated by less than 1/3 second are counted and
	  returned in a single message
 3	pointer position is relative to screen origin, not window origin
 2	send message on button release as well as button press
 1	(DV 2.23+) send message with row=FFFFh and col=FFFFh whenever the
	  pointer leaves the window
 0	send message only on button activity, not movement
	DV-specific, and INT 15/AX=DE0Fh must have been called first
--------Q-1512--BH0B-------------------------
INT 15 - TopView - SEND MESSAGE - "SUBFROM" - WRITE ATTRIBUTES TO WINDOW
	AH = 12h
	BH = 0Bh
	BL = window to write attributes to
	    00h handle is DWORD on top of stack
	    01h current task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent of current task
	STACK:	DWORD number of attributes to write
		DWORD address of attributes
Return: STACK popped
Note:	the attributes are written starting at the current cursor position; the
	  cursor is left just after the last position written
SeeAlso: AH=12h/BH=0Ah"WINDOW"
--------Q-1512--BH0B-------------------------
INT 15 - TopView - SEND MESSAGE - "SUBFROM" - SEND MAILBOX MESSAGE/STAT BY REF
	AH = 12h
	BH = 0Bh
	BL = mailbox to write to
	    00h handle is DWORD on top of stack
	    02h default mailbox of task whose handle is on top of stack
	    03h current task's default mailbox
	STACK:	DWORD	status (low byte)
		DWORD	length of message
		DWORD	address of message
Return: STACK popped
Notes:	only a pointer to the message is stored, but the write may still fail
	  due to insufficient memory
	under DV 2.2+, failed mailbox writes may return CF set (see AX=DE15h)
SeeAlso: AH=12h/BH=0Ah"MAILBOX"
--------Q-1512--BH0B-------------------------
INT 15 - TopView - SEND MESSAGE - "SUBFROM" - REMOVE OBJECT FROM OBJECTQ
	AH = 12h
	BH = 0Bh
	BL = OBJECTQ from which to remove all copies of a particular object
	    06h OBJECTQ of task whose handle is on top of stack
	    07h task's default OBJECTQ
	STACK:	DWORD	handle of object to remove
Return: STACK popped
Note:	should be sent whenever an object is erased or closed
--------Q-1512--BH0B-------------------------
INT 15 - TopView - SEND MESSAGE - "SUBFROM" - RESET OBJECT BITS
	AH = 12h
	BH = 0Bh
	BL = object
	    00h handle is DWORD on top of stack
		pointer: reset control flags
		keyboard: reset control flags
	    04h clear control flags on KEYBOARD object (handle on top of stack)
	    05h clear control flags on task's default KEYBOARD object
	STACK:	DWORD	which bits to clear (see #00450,#00451)
Return: STACK popped
SeeAlso: AH=12h/BH=0Ah"OBJECT"
--------Q-1512--BH0C-------------------------
INT 15 - TopView - SEND MESSAGE - "OPEN" - OPEN OBJECT
	AH = 12h
	BH = 0Ch
	BL = object
	    00h handle is DWORD on top of stack
		window:	  fill with given character from scroll origin to end
		keyboard: attach to a window
		timer:	  open
		pointer:  start taking input for window
		panel:	  associate with a panel file
	    01h fill task's default window with given char from scrl org to end
	    02h open given task's mailbox for input (task's handle on stack)
	    03h open current task's mailbox
	    04h attach a KEYBOARD to a window (handle on top of stack)
	    05h attach task's default KEYBOARD to a window
	    06h open a task's OBJECTQ (task's handle on top of stack)
	    07h open current task's OBJECTQ
	    0Ch (DV 2.26+) fill def window of task owning handle on top of stck
	    0Dh (DV 2.26+) fill default window of parent of current task
	 STACK: (if window)   DWORD character to fill with
		(if keyboard) DWORD handle of window to attach to
		(if pointer)  DWORD handle of window to attach to
		(if panel)    DWORD length of filename or resident panel
			      DWORD address of filename or resident panel
		(otherwise)   nothing
Return: STACK popped
Notes:	if first byte of panel file name is 1Bh, then the "name" IS a panel
	if first two bytes of panel file "name" are C0hC3h, then the "name" IS
	  the panel file
	result code of open may be retrieved with STATUS message
	logical cursor is left at scroll origin after filling window
	the task opening a mailbox becomes its owner, and the only task allowed
	  to read the mailbox
	messages are only sent to a pointer object when the mouse is positioned
	  in the window to which the pointer has been attached
	there is no need to explicitly open a timer object, as ADDTO and WRITE
	  messages automatically open the timer
SeeAlso: AH=12h/BH=0Dh,AH=12h/BH=14h"LOCK"
--------Q-1512--BH0D-------------------------
INT 15 - TopView - SEND MESSAGE - "CLOSE" - CLOSE OBJECT
	AH = 12h
	BH = 0Dh
	BL = object
	    00h handle is DWORD on top of stack
		timer:	  close
		keyboard: detach from window and discard queued input
		pointer:  stop taking input
		panel:	  close
		mailbox:  close, unlock, and discard any pending messages
	    02h close given task's mailbox (task's handle on top of stack)
	    03h close task's default mailbox
	    04h close KEYBOARD object (handle on top of stack)
	    05h close task's default KEYBOARD
	    06h close given task's OBJECTQ (task's handle on top of stack)
	    07h close current task's OBJECTQ
Return: STACK popped if handle passed on stack
Notes:	when an OBJECTQ is closed, each object in the OBJECTQ is sent an
	  ERASE message (AH=12h/BH=0Eh)
	when a panel object is closed, the panel file and any panels currently
	  in use are freed; window and keyboard objects created by APPLY are
	  not affected, but field mode input ceases
	open but idle timer objects consume a small amount of CPU time
SeeAlso: AH=12h/BH=0Ch,AH=12h/BH=0Eh,AH=12h/BH=14h"LOCK"
--------Q-1512--BH0E-------------------------
INT 15 - TopView - SEND MESSAGE - "ERASE" - ERASE OBJECT
	AH = 12h
	BH = 0Eh
	BL = object
	    00h handle is DWORD on top of stack
		window:	  clear from scroll origin to end of window
		keyboard: discard input
		timer:	  cancel current interval
		pointer:  discard all pending messages
		mailbox:  discard all pending messages
	    01h clear task's default window from scroll origin to end
	    02h discard all queued messages in mailbox (handle on top of stack)
	    03h discard all queued messages in current task's default mailbox
	    04h discard all input queued to KEYBOARD (handle on top of stack)
	    05h discard all input queued to task's default KEYBOARD
	    06h remove all objects from OBJECTQ (task's handle on top of stack)
	    07h remove all objects from current task's OBJECTQ
	    0Ch (DV 2.26+) clear window of task owning handle on top of stack
	    0Dh (DV 2.26+) clear default window of parent of current task
Return: STACK popped if handle passed on stack
Note:	when an OBJECTQ is erased, each object in the OBJECTQ is also erased
SeeAlso: AH=12h/BH=02h
--------Q-1512--BH0F-------------------------
INT 15 - TopView - SEND MESSAGE - "STATUS" - GET OBJECT STATUS
	AH = 12h
	BH = 0Fh
	BL = object
	    00h handle is DWORD on top of stack
		timer:	 is it running?
		pointer: return status of last message
		panel:	 verify success of last OPEN or APPLY
	    02h return status of last msg READ from mailbox (handle on stack)
	    03h return status of last msg READ from task's default mailbox
	    04h get stat of last msg from task's KEYBOARD (task handle on stk)
	    05h get status of last msg from task's default KEYBOARD
	    06h return whether OBJECTQ is open or not (handle on top of stack)
	    07h return whether task's default OBJECTQ is open or not
Return: DWORD on top of stack is status (any handle passed on stack popped)
Notes:	if object is a panel object, the status indicates the error code:
	  00h successful
	  14h panel name not in panel directory
	  15h not enough memory to apply panel
	  16h invalid panel format
	  17h panel file already open
	  81h-92h  DOS error codes+80h			\  codes > 80h indicate
	  95h not enough memory to open panel file	 > that the panel was
	  98h null panel file name			/  not opened
	if object is a timer, the status is:
	  00000000h open but not running
	  40000000h open and running
	  80000000h closed
	if object is an OBJECTQ, the status is:
	  00000000h open
	  80000000h closed
	if object is a keyboard in keystroke mode, the status is the extended
	  character code (scan code) of the last keystroke
	if object is a keyboard in field mode, the status indicates the reason
	  for the last return from the field manager
	  00h Enter key pressed
	  01h Button 1 or keystroke selection
	  02h Button 2
	  03h validation
	  04h auto Enter on field
	  1Bh Escape pressed
	  46h ^Break pressed
	  other: extended code for key terminating input
	the status of mailbox messages sent by the window manager is always 80h
	the status of a pointer message is the same as the status field in the
	  message
SeeAlso: AH=12h/BH=04h"READ"
--------Q-1512--BH10-------------------------
INT 15 - TopView - SEND MESSAGE - "EOF" - GET OBJECT EOF STATUS
	AH = 12h
	BH = 10h
	BL = object
	    00h handle is DWORD on top of stack
		window: return TRUE if logical cursor past end of window
		mailbox: ???
	    01h returns TRUE if logical cursor past end of task's def window
	    02h return ??? for task's mailbox (task's handle on top of stack)
	    03h return ??? for current task's mailbox
	    0Ch (DV 2.26+) check log crsr of window owning handle on top of stk
	    0Dh (DV 2.26+) check log cursor of window of parent task
Return: DWORD on top of stack is status (any handle on stack has been popped)
--------Q-1512--BH11-------------------------
INT 15 - TopView - SEND MESSAGE - "AT" - POSITION OBJECT CURSOR
	AH = 12h
	BH = 11h
	BL = window for which to move cursor
	    00h window's handle is DWORD on top of stack
	    01h task's default window
	    0Ch (DV 2.26+) default window of task owning handle on top of stack
	    0Dh (DV 2.26+) default window of parent of current task
	STACK: DWORD column
	       DWORD row
Return: STACK popped
--------Q-1512--BH11-------------------------
INT 15 - TopView - SEND MESSAGE - "SETNAME" - ASSIGN NAME TO MAILBOX
	AH = 12h
	BH = 11h
	BL = mailbox to name
	    00h DWORD on top of stack is mailbox handle
	    02h use given task's mailbox (task's handle on top of stack)
	    03h use current task's default mailbox
	STACK: DWORD length of name
	       DWORD address of name
Return: STACK popped
SeeAlso: AH=12h/BH=12h"GETNAME",AX=DE0Eh
--------Q-1512--BX1100-----------------------
INT 15 - TopView - SEND MESSAGE - "SETSCALE" - SET POINTER SCALE FACTOR
	AH = 12h
	BX = 1100h
	STACK: DWORD object handle for pointer object
	       DWORD number of colums to scale pointer position to
	       DWORD number of rows to scale pointer position to
Return: STACK popped
SeeAlso: AH=12h/BX=1200h
--------Q-1512--BH12-------------------------
INT 15 - TopView - SEND MESSAGE - "READN" - GET NEXT N OBJECT BYTES
	AH = 12h
	BH = 12h
	BL = window to read from
	    00h handle is DWORD on top of stack
	    01h read next N chars or attributes on task's default window
	    0Ch (DV 2.26+) read window of task owning handle on top of stack
	    0Dh (DV 2.26+) read default window of parent of current task
	STACK: DWORD count
Return: STACK: DWORD number of bytes actually read
	       DWORD address of buffer containing data
Notes:	reading starts at the current logical cursor position; the cursor is
	  updated to point at the character following the last one read
	any translucent blanks (FFh) which are visible on screen are changed
	  to the character which is seen through them
	the string produced by the read is placed in an input buffer which may
	  be reused by the next READ or READN of a window
	window stream opcodes D8h and D9h determine whether the read returns
	  characters or attributes
SeeAlso: AH=12h/BH=04h"WINDOW",AH=12h/BH=05h"WINDOW"
--------Q-1512--BH12-------------------------
INT 15 - DESQview 2.50+ - SEND MESSAGE - "GETNAME" - GET NAME OF MAILBOX
	AH = 12h
	BH = 12h
	BL = mailbox for which to retrieve name
	    00h DWORD on top of stack is mailbox handle
	    02h use given task's mailbox (task's handle on top of stack)
	    03h use current task's default mailbox
	STACK: DWORD length of buffer for name
	       DWORD pointer to buffer
Return: STACK: DWORD length of returned name (or size of buffer, if less)
Program: DESQview 2.5x is distributed as part of DESQview/X 1.0x
Note:	the returned name is not NUL-terminated
SeeAlso: AH=12h/BH=11h"SETNAME",AX=DE0Eh
--------Q-1512--BX1200-----------------------
INT 15 - TopView - SEND MESSAGE - "GETSCALE" - GET POINTER SCALE FACTOR
	AH = 12h
	BX = 1200h
	STACK: DWORD object handle for pointer
Return: STACK: DWORD pointer pos scaled as if window were this many colums wide
	       DWORD pointer pos scaled as if window were this many rows high
SeeAlso: AH=12h/BX=1100h
--------Q-1512--BH13-------------------------
INT 15 - TopView - SEND MESSAGE - "REDRAW" - REDRAW WINDOW
	AH = 12h
	BH = 13h
	BL = window object
	    00h DWORD on top of stack is handle for window to redraw
	    01h redraw task's default window
	    0Ch (DV 2.26+) redraw window of task owning handle on top of stack
	    0Dh (DV 2.26+) redraw default window of parent of current task
Return: STACK popped if handle was passed on stack
SeeAlso: AH=12h/BH=05h"WINDOW",AH=12h/BH=0Eh
--------Q-1512--BH13-------------------------
INT 15 - DESQview 2.50+ - SEND MESSAGE - "READINTO" - GET NEXT MAIL MESSAGE
	AH = 12h
	BH = 13h
	BL = mailbox from which to read
	    00h DWORD on top of stack is mailbox handle
	    02h use given task's mailbox (task's handle on top of stack)
	    03h use current task's default mailbox
	STACK: DWORD size of buffer in bytes
	       DWORD pointer to buffer
Return: STACK: DWORD number of bytes read
Program: DESQview 2.5x is distributed as part of DESQview/X 1.0x
Notes:	this call blocks if no input is available, but will return less than
	  the requested number of bytes if some (but insufficient) data is
	  available
	use this call instead of AH=12h/BH=04h if the mailbox has flag bits
	  4 or 5 set, as common memory may be exhausted by that call when
	  attempting to read the next message
SeeAlso: AH=12h/BH=04h"READ",AH=12h/BH=05h,AH=12h/BH=16h
--------Q-1512--BX1300-----------------------
INT 15 - TopView - SEND MESSAGE - "SETICON" - SPECIFY POINTER ICON
	AH = 12h
	BX = 1300h
	STACK: DWORD object handle for pointer
	       DWORD character to use for pointer
Return: STACK popped
--------Q-1512--BH14-------------------------
INT 15 - TopView - SEND MESSAGE - "SETESC" - SET ESCAPE ROUTINE ADDRESS
	AH = 12h
	BH = 14h
	BL = message modifier
	    00h handle is DWORD on top of stack
	    01h define user stream
	    04h intercept keystrokes from KEYBOARD to window (handle on stack)
	    05h intercept keystrokes from task's default KEYBOARD to a window
	STACK: (if window)   DWORD user stream number (14h-1Fh)
			     DWORD address of FAR user stream handler
	       (if keyboard) DWORD address of FAR filter function (see #00452)
Return: STACK popped

(Table 00452)
Values keyboard filter function is called with when keyboard is in field mode:
	AL = character
	AH = 00h or extended ASCII code if AL = 00h
	BL = field number
	CH = cursor column
	CL = cursor row
	DL = field type modifier (sixth item in field table entry)
	DH = seventh item in field table entry
	ES:SI = window's handle
	DS:DI -> field table entry for field containing the cursor
Return: AH = action to take
	    00h use keystroke
	    01h ignore keystroke
	    FFh beep and ignore keystroke
Note: the filter function is not allowed to make INT 15, DOS, or BIOS calls
--------Q-1512--BH14-------------------------
INT 15 - TopView - SEND MESSAGE - "LOCK" - REQUEST EXCLUSIVE ACCESS TO RESOURCE
	AH = 12h
	BH = 14h
	BL = object
	    00h mailbox handle is DWORD on top of stack
	    02h use given task's mailbox (task's handle on top of stack)
	    03h use current task's default mailbox
Return: STACK popped if BL=00h
Note:	release exclusive access by sending CLOSE message to mailbox
	access may be requested multiple times, and requires multiple CLOSEs
SeeAlso: AH=12h/BH=0Dh
--------Q-1512--BH15-------------------------
INT 15 - DESQview v2.20+ - SEND MESSAGE - "SETFLAGS" - SET OBJECT FLAGS
	AH = 12h
	BH = 15h
	BL = object
	    00h DWORD on top of stack
		mailbox, keyboard, or pointer only
	    02h mailbox for task whose handle is on top of stack
	    03h mailbox for current task
	    04h keyboard for task whose handle is on top of stack
	    05h keyboard for current task
	STACK: DWORD flags (see #00453,#00454)
Return: STACK popped
Notes:	only available if the API level has been set to at least 2.20
	equivalent to performing SUBFROM and ADDTO calls on the object
	if a mailbox has bits 4 or 5 set, you must use "READINTO" rather than
	  "READ" (see AH=12h/BH=13h"READINTO") to retrieve messages
SeeAlso: AH=12h/BH=0Ah,AH=12h/BH=0Bh,AH=12h/BH=16h

Bitfields for DESQview mailbox object flags:
Bit(s)	Description	(Table 00453)
 0	all mail messages in common memory
 1	allow write even if closed
 2	don't erase messages when mailbox closed
 4	(DV/X) append messages with like status and sender (stream-oriented
	  mail)
 5	(DV/X) store mail in expanded memory (pool grows as needed)
 6	(DV/X) make mailbox into non-owned mailbox

Bitfields for DESQview keyboard object flags:
Bit(s)	Description	(Table 00454)
 5	exclusive input when keyboard in use for input
--------Q-1512--BH16-------------------------
INT 15 - DESQview v2.20+ - SEND MESSAGE - "GETFLAGS" - GET OBJECT FLAGS
	AH = 12h
	BH = 16h
	BL = object
	    00h DWORD on top of stack
		mailbox, keyboard, or pointer only
	    02h mailbox for task whose handle is on top of stack
	    03h mailbox for current task
	    04h keyboard for task whose handle is on top of stack
	    05h keyboard for current task
Return: STACK: DWORD current control flags (see #00453,#00454)
Notes:	only available if the API level has been set to at least 2.20
	if a mailbox has bits 4 or 5 set, you must use "READINTO" rather than
	  "READ" (see AH=12h/BH=13h"READINTO") to retrieve messages
SeeAlso: AH=12h/BH=0Ah,AH=12h/BH=0Bh,AH=12h/BH=13h"READINTO",AH=12h/BH=15h
--------Q-1512--BH17-------------------------
INT 15 - DESQview v2.42-2.52 - BUG
	AH = 12h
	BH = 17h
	BL = object
	    00h DWORD on top of stack
		mailbox, keyboard, or pointer only
	    02h mailbox for task whose handle is on top of stack
	    03h mailbox for current task
	    04h keyboard for task whose handle is on top of stack
	    05h keyboard for current task
Return: STACK popped if handle passed on stack
Notes:	due to a fencepost error, message 17h is accepted for mailboxes,
	  keyboards, and pointers, but causes a random branch
	DESQview v2.50-2.52 are distributed as part of DESQview/X v1.02
--------Q-1512--BH80-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 00h WITH ERROR RECOVERY
	AH = 12h
	BH = 80h
Note:	this function is identical to AH=12h/BH=00h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=00h

(Table 00455)
Values for DESQview error code:
 00h	no error
 01h	invalid values
 02h	alias invalid
 03h	handle valid but wrong type
 04h	invalid handle
--------Q-1512--BH81-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 01h WITH ERROR RECOVERY
	AH = 12h
	BH = 81h
Note:	this function is identical to AH=12h/BH=01h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=01h
--------Q-1512--BH82-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 02h WITH ERROR RECOVERY
	AH = 12h
	BH = 82h
Note:	this function is identical to AH=12h/BH=02h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=02h
--------Q-1512--BH83-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 03h WITH ERROR RECOVERY
	AH = 12h
	BH = 83h
Note:	this function is identical to AH=12h/BH=03h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=03h,AH=12h/BX=0300h
--------Q-1512--BH84-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 04h WITH ERROR RECOVERY
	AH = 12h
	BH = 84h
Note:	this function is identical to AH=12h/BH=04h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=04h,AH=12h/BX=0400h
--------Q-1512--BH85-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 05h WITH ERROR RECOVERY
	AH = 12h
	BH = 85h
Note:	this function is identical to AH=12h/BH=05h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=05h
--------Q-1512--BH86-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 06h WITH ERROR RECOVERY
	AH = 12h
	BH = 86h
Note:	this function is identical to AH=12h/BH=06h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=06h
--------Q-1512--BH87-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 07h WITH ERROR RECOVERY
	AH = 12h
	BH = 87h
Note:	this function is identical to AH=12h/BH=07h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=07h
--------Q-1512--BH88-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 08h WITH ERROR RECOVERY
	AH = 12h
	BH = 88h
Note:	this function is identical to AH=12h/BH=08h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=08h
--------Q-1512--BH89-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 09h WITH ERROR RECOVERY
	AH = 12h
	BH = 89h
Note:	this function is identical to AH=12h/BH=09h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=09h
--------Q-1512--BH8A-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Ah WITH ERROR RECOVERY
	AH = 12h
	BH = 8Ah
Note:	this function is identical to AH=12h/BH=0Ah, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=0Ah
--------Q-1512--BH8B-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Bh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Bh
Note:	this function is identical to AH=12h/BH=0Bh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=0Bh
--------Q-1512--BH8C-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Ch WITH ERROR RECOVERY
	AH = 12h
	BH = 8Ch
Note:	this function is identical to AH=12h/BH=0Ch, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=0Ch
--------Q-1512--BH8D-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Dh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Dh
Note:	this function is identical to AH=12h/BH=0Dh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=0Dh
--------Q-1512--BH8E-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Eh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Eh
Note:	this function is identical to AH=12h/BH=0Eh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=0Eh
--------Q-1512--BH8F-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 0Fh WITH ERROR RECOVERY
	AH = 12h
	BH = 8Fh
Note:	this function is identical to AH=12h/BH=0Fh, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=0Fh
--------Q-1512--BH90-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 10h WITH ERROR RECOVERY
	AH = 12h
	BH = 90h
Note:	this function is identical to AH=12h/BH=10h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=10h
--------Q-1512--BH91-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 11h WITH ERROR RECOVERY
	AH = 12h
	BH = 91h
Note:	this function is identical to AH=12h/BH=11h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=11h,AH=12h/BX=1100h
--------Q-1512--BH92-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 12h WITH ERROR RECOVERY
	AH = 12h
	BH = 92h
Note:	this function is identical to AH=12h/BH=12h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=12h,AH=12h/BX=1200h
--------Q-1512--BH93-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 13h WITH ERROR RECOVERY
	AH = 12h
	BH = 93h
Note:	this function is identical to AH=12h/BH=13h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=13h
--------Q-1512--BH94-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 14h WITH ERROR RECOVERY
	AH = 12h
	BH = 94h
Note:	this function is identical to AH=12h/BH=14h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=14h
--------Q-1512--BH95-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 15h WITH ERROR RECOVERY
	AH = 12h
	BH = 95h
Note:	this function is identical to AH=12h/BH=15h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=15h
--------Q-1512--BH96-------------------------
INT 15 - DESQview v2.50+ - SEND MESSAGE 16h WITH ERROR RECOVERY
	AH = 12h
	BH = 96h
Note:	this function is identical to AH=12h/BH=16h, except that DESQview will
	  not pop up a "Programming Error" window, instead returning an error
	  code in AL (see #00455)
SeeAlso: AH=12h/BH=16h
--------T-1513-------------------------------
INT 15 - VMiX - "sys_wake" - WAKE SLEEPING PROCESS
	AH = 13h
	STACK:	WORD	process ID
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=12h"VMiX"
--------T-1513-------------------------------
INT 15 - MultiDOS Plus - GET TASK CONTROL BLOCK
	AH = 13h
Return: BX:AX -> task control block (see #00456)
SeeAlso: AH=15h"MultiDOS"

Format of MultiDOS Plus v4.0 task control block:
Offset	Size	Description	(Table 00456)
 00h	DWORD	pointer to next TCB
 04h  8 BYTEs	ASCIZ task name
 0Ch  2 BYTEs	???
 0Eh	WORD	task PSP segment
 10h	WORD	abort/suspend flags
 12h	WORD	current screen segment (see AH=0Bh,AH=0Ch)
 14h	WORD	priority level (0000h-FFFEh)
 16h	WORD	time slice counter
 18h  2 BYTEs	???
 1Ah	WORD	suspend timer value
 1Ch	WORD	stack segment
 1Eh	WORD	stack pointer
 20h	WORD	display type
 22h	WORD	display memory
 24h  2 BYTEs	???
 26h	WORD	termination count
 28h	WORD	equipment flag for BIO10 driver
 2Ah	BYTE	background CRT mode
 2Bh	WORD	screen width in columns
 2Dh	WORD	screen size in bytes
 2Fh	WORD	segment of physical screen memory
 31h 16 BYTEs	eight cursor positions
 41h	WORD	current cursor shape
 43h	BYTE	active display page
 44h	WORD	CRT controller I/O port base
 46h  2 BYTEs	???
 48h	WORD	foreground task flag
 4Ah  6 BYTEs	???
 50h	WORD	saved video segment (see AH=0Bh,AH=0Ch)
 52h	DWORD	old INT 22
 56h	DWORD	old INT 23
 5Ah	DWORD	old INT 24
 5Eh	WORD	top of memory for task
 60h  4 BYTEs	???
 64h	WORD	DTA segment (see INT 21/AH=1Ah)
 66h	WORD	DTA offset
 68h  4 BYTEs	???
 6Ch	BYTE	current ANSI.SYS attribute
 6Dh	BYTE	current ANSI.SYS column
 6Eh	BYTE	current ANSI.SYS row
 6Fh	BYTE	current ANSI.SYS display state
 70h	BYTE	maximum ANSI.SYS columns
 71h	BYTE	current ANSI.SYS page
 72h	WORD	saved ANSI.SYS cursor position
 74h	BYTE	ANSI.SYS parameter buffer index
 75h	BYTE	current ANSI.SYS screen mode
 76h	BYTE	ANSI.SYS wrap flag
 77h  6 BYTEs	ANSI.SYS parameter buffer
 7Dh	BYTE	ANSI.SYS keyboard DSR state
 7Eh  7 BYTEs	ANSI.SYS keyboard DSR buffer
 85h  3 BYTEs	???
 88h 16 BYTEs	request header for DOS driver calls
 98h 14 BYTEs	???
 A6h	WORD	segment of EMS map if EMS task
 A8h	WORD	flag: task makes EMS calls
 AAh	WORD	EMS handle for task
 ACh	WORD	keyboard shift state
 AEh 12 BYTEs	???
 BAh	WORD	TCB of parent if child task
 BCh	WORD	termination code
 BEh	WORD	COM port number
 C0h  4 BYTEs	???
 C4h	WORD	current IRQ number
 C6h  2 BYTEs	???
 C8h	WORD	miscellaneous flag word
 CAh  2 BYTEs	???
 CCh	DWORD	old INT 10
 D0h	WORD	EMS alternate map set number
 D2h 414 BYTEs	DOS current disk and directory context (optional)
--------T-1514-------------------------------
INT 15 - VMiX - "sys_clrwindow" - CLEAR WINDOW
	AH = 14h
	STACK:	WORD	top left corner of window (high byte = row, low = col)
		WORD	bottom right corner of window (high = row, low = col)
Return: AX = status (SYS_OK)
Note:	clears window to color set with "sys_setcolors" (AH=18h)
SeeAlso: AH=15h"VMiX",AH=16h"VMiX",AH=18h"VMiX",AH=1Fh"VMiX"
--------T-1514-------------------------------
INT 15 - MultiDOS Plus - CHECK IF MultiDOS FOREGROUND OR BACKGROUND
	AH = 14h
Return: AX = current state
	    0000h MultiDOS Plus command prompt is background task
	    0001h command prompt is foreground task
SeeAlso: AH=0Bh"MultiDOS"
--------T-1515-------------------------------
INT 15 - VMiX - "sys_setbwindow" - SET BANNER WINDOW MESSAGE
	AH = 15h
	STACK:	DWORD	pointer to ASCIZ banner message for top of screen
Return: AX = status (SYS_OK)
SeeAlso: AH=14h"VMiX",AH=16h"VMiX"
--------T-1515-------------------------------
INT 15 - MultiDOS Plus - GET SYSTEM BLOCK
	AH = 15h
Return: BX:AX -> system block (see #00457)
SeeAlso: AH=13h"MultiDOS"

Format of MultiDOS Plus 4.0 system block:
Offset	Size	Description	(Table 00457)
 00h	WORD	segment of system control block
 02h	WORD	redirection flag set by /NOREDIRECT
 04h	WORD	no-INT 10 flag set by /NO10
 06h	DWORD	old INT 10
 0Ah	DWORD	new INT 10
 0Eh	DWORD	pointer to WORD with current TCB offset (see #00456)
 12h	DWORD	pointer to WORD with idle task TCB offset
 16h	DWORD	pointer to WORD with foreground TCB offset (see #00456)
 1Ah	DWORD	pointer to WORD with MultiDOS TCB offset (see #00456)
 1Eh	WORD	Task Control Block size
 20h	WORD	number of TCBs
 22h	WORD	flag: EMS present
 24h	WORD	EMS page frame base segment
 26h	WORD	16K pages in EMS page frame
 28h	WORD	base segment for conventional memory tasks
 2Ah	WORD	conventional memory size in paragraphs
 2Ch	DWORD	pointer to list of queue pointers
--------T-1516-------------------------------
INT 15 - VMiX - "sys_setwindow" - SET ROOT WINDOW SIZE AND HOME CURSOR
	AH = 16h
	STACK:	DWORD	pointer to I/O Request Packet
		WORD	top left corner of window (high byte = row, low = col)
		WORD	bottom right corner of window (high = row, low = col)
Return: AX = status (SYS_OK or SYS_ERROR)
SeeAlso: AH=14h"VMiX",AH=17h"VMiX"
--------T-1516-------------------------------
INT 15 - MultiDOS Plus - INITIALIZATION
	AH = 16h
Note:	used internally during initialization; any other calls will cause
	  unpredictable results
--------T-1517-------------------------------
INT 15 - VMiX - "sys_getcolors" - GET CONSOLE WINDOW COLORS
	AH = 17h
Return: AH = foreground color
	AL = background color
SeeAlso: AH=16h"VMiX",AH=18h"VMiX"
--------T-1517-------------------------------
INT 15 - MultiDOS Plus - MAP IRQ
	AH = 17h
	AL = IRQ to map (01h-0Fh)
	BX = offset of task control block (see #00456) to associate with IRQ
Return: AX = status
	    0000h successful
	    other invalid IRQ
Note:	the EMS map of the specified TCB is associated with the given interrupt
SeeAlso: AH=18h"MultiDOS",AH=19h"MultiDOS"
--------T-1518-------------------------------
INT 15 - VMiX - "sys_setcolors" - SET CONSOLE COLORS
	AH = 18h
	STACK:	WORD	new background/foreground colors
			bits 3-0: foreground
			bits 7-4: background
			bits 15-8: unused
Return: AX = color
SeeAlso: AH=14h"VMiX",AH=17h"VMiX",AH=19h"VMiX"
--------T-1518-------------------------------
INT 15 - MultiDOS Plus - UNMAP IRQ
	AH = 18h
	AL = IRQ to unmap (01h-0Fh)
Return: AX = status
	    0000h successful
	    0001h invalid IRQ
Note:	results are unpredictable if the IRQ has not been mapped
SeeAlso: AH=17h"MultiDOS",AH=19h"MultiDOS"
--------T-1519-------------------------------
INT 15 - VMiX v2+ - "sys_setconwn" - SET WINDOW COLORS
	AH = 19h
	STACK:	WORD	new background/foreground colors
			bits 3-0: foreground
			bits 7-4: background
			bits 15-8: unused
Return: AX = color
SeeAlso: AH=18h"VMiX"
--------T-1519-------------------------------
INT 15 - MultiDOS Plus - UNMAP ALL IRQs
	AH = 19h
Return: AX destroyed
Note:	for MultiDOS internal use only
SeeAlso: AH=17h"MultiDOS",AH=18h"MultiDOS"
--------T-151A-------------------------------
INT 15 - VMiX v2+ - "sys_sint" - INVOKE SOFTWARE INTERRUPT
	AH = 1Ah
	STACK:	WORD	interrupt number
		DWORD	pointer to register structure
Return: AX = returned flags
--------T-151A-------------------------------
INT 15 - MultiDOS Plus - MAP SEMAPHORE NAME TO NUMBER
	AH = 1Ah
	DS:SI -> 8-byte name
Return: AL = status
	    00h successful
		AH = semaphore number (20h-3Fh)
	    04h out of string space
Notes:	all eight bytes of the name are significant
	if the name does not already exist, it is added to the name table and
	  associated with a free semaphore number
	names cannot be destroyed
SeeAlso: AH=1Bh"MultiDOS",AH=1Ch"MultiDOS",AH=1Dh"MultiDOS"
--------T-151B-------------------------------
INT 15 - VMiX v2+ - "sys_blkmov" - MOVE MEMORY BLOCK
	AH = 1Bh
	STACK:	DWORD	source address
		DWORD	destination address
		WORD	number of words to move
Return: nothing
--------T-151B-------------------------------
INT 15 - MultiDOS Plus - REQUEST RESOURCE SEMAPHORE BY NAME
	AH = 1Bh
	DS:SI -> 8-byte name
Return: AH = status
	    00h successful
	    02h invalid semaphore number
	    03h caller already owns semaphore
	    04h out of string space
Notes:	(see AH=01h"MultiDOS")
	equivalent to AH=1Ah followed by AH=01h
SeeAlso: AH=01h"MultiDOS",AH=1Ah"MultiDOS",AH=1Ch"MultiDOS",AH=1Dh"MultiDOS"
--------T-151C-------------------------------
INT 15 - VMiX v2+ - "sys_bitblt" - PUT GRAPHICAL OBJECT AT CURSOR POSITION
	AH = 1Ch
	STACK:	WORD	AND/OR pixel with background (00h = OR, 01h = AND)
		DWORD	pointer to object bitmap
		WORD	object width in pixels
		WORD	object height in pixels
Return: nothing
SeeAlso: AH=1Dh"VMiX"
--------T-151C-------------------------------
INT 15 - MultiDOS Plus - RELEASE RESOURCE SEMAPHORE BY NAME
	AH = 1Ch
	DS:SI -> 8-byte name
Return: AH = status
	    00h successful
	    01h not semaphore owner
	    02h invalid semaphore number
	    04h out of string space
Notes:	(see AH=02h"MultiDOS")
	equivalent to AH=1Ah followed by AH=02h
SeeAlso: AH=02h"MultiDOS",AH=1Ah"MultiDOS",AH=1Bh"MultiDOS",AH=1Dh"MultiDOS"
--------T-151D-------------------------------
INT 15 - VMiX v2+ - "sys_getfont" - GET CURRENT CONSOLE GRAPHICS FONT
	AH = 1Dh
Return: AX = current font number (00h-03h)
SeeAlso: AH=1Ch"VMiX",AH=1Eh"VMiX"
--------T-151D-------------------------------
INT 15 - MultiDOS Plus - TEST RESOURCE SEMAPHORE BY NAME
	AH = 1Dh
	DS:SI -> 8-byte name
Return: AH = status
	    00h semaphore not in use
	    01h semaphore owned by another task
	    02h invalid semaphore number
	    03h caller owns semaphore
	    04h out of string space
Notes:	(see AH=10h"MultiDOS")
	equivalent to AH=1Ah followed by AH=10h
SeeAlso: AH=10h"MultiDOS",AH=1Ah"MultiDOS",AH=1Bh"MultiDOS",AH=1Ch"MultiDOS"
--------T-151E-------------------------------
INT 15 - VMiX v2+ - "sys_setfont" - SET CONSOLE GRAPHICS FONT
	AH = 1Eh
	STACK: WORD new font number (00h-03h)
Return: AX = current font number (00h-03h)
SeeAlso: AH=1Dh"VMiX"
--------T-151E00-----------------------------
INT 15 - MultiDOS Plus - CLEAR EVENT COUNTER
	AX = 1E00h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
SeeAlso: AX=1E01h,AX=1E02h
--------T-151E01-----------------------------
INT 15 - MultiDOS Plus - TRIGGER EVENT
	AX = 1E01h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
	    01h invalid event/trigger number
Notes:	schedules any task waiting for event; if no task is waiting, the event
	  counter is incremented (and will roll over if it was 65535)
	may be invoked by interrupt handler
SeeAlso: AX=1E00h,AX=1E02h
--------T-151E02-----------------------------
INT 15 - MultiDOS Plus - WAIT FOR EVENT
	AX = 1E02h
	DX = event/trigger number (00h-3Fh)
Return: AH = status
	    00h successful
	    01h invalid event/trigger number
Note:	if the event counter is zero, the task is suspended until the event is
	  triggered with AX=1E01h; else, the counter is decremented and the
	  call returns immediately
SeeAlso: AX=1E00h,AX=1E01h
--------T-151E08-----------------------------
INT 15 - MultiDOS Plus 4.01 - SET CONTEXT-SWITCH FUNCTIONS
	AX = 1E08h
	DX:BX -> context save handler (see #00458)
	DX:CX -> context restore handler (see #00458)
Return: nothing
Note:	handlers may be removed by setting addresses to 0000h:0000h

(Table 00458)
Values MultiDOS Plus context-switch handlers are called with:
	ES:BX -> task's TCB
Return: all registers preserved
--------T-151F-------------------------------
INT 15 - VMiX v2.???+ - "sys_scrollwin" - SCROLL WINDOW
	AH = 1Fh
	STACK:	WORD	top left corner of window (high byte = row, low = col)
		WORD	bottom right corner of window
Return: AX = status (SYS_OK)
SeeAlso: AH=14h"VMiX",AH=18h"VMiX"
--------T-151F-------------------------------
INT 15 - MultiDOS Plus v4.01 - GET MEMORY PARAMETERS
	AH = 1Fh
Return: BX = first segment of conventional memory
	DX = first segment of EMS swap frame into which MultiDOS will load
		programs
--------T-1520-------------------------------
INT 15 - MultiDOS Plus v4.01 - CHECK IF MULTITASKING ENABLED
	AH = 20h
Return: AX = current state
	    0000h multitasking enabled
	    other TCB of task that disabled multitasking
SeeAlso: AH=0Dh"MultiDOS",AH=13h"MultiDOS"
--------c-152000-----------------------------
INT 15 U - DOS 3.0+ PRINT.COM - DISABLE CRITICAL REGION FLAG
	AX = 2000h
Return: nothing
Desc:	stop setting user flag on entry to PRINT critical region
Note:	also supported by PC Network v1.00 RECEIVER.COM
SeeAlso: AX=2001h
--------c-152001-----------------------------
INT 15 U - DOS 3.0+ PRINT.COM - SET CRITICAL REGION FLAG
	AX = 2001h
	ES:BX -> byte which is to be incremented while in a DOS call
Return: nothing
Desc:	specify a user flag which PRINT should set to let an interested
	  application know it is in a critical region
Note:	also supported by PC Network v1.00 RECEIVER.COM
SeeAlso: AX=2000h
--------O-152010-----------------------------
INT 15 - OS HOOK - SETUP SYSREQ ROUTINE (AT,XT286,PS50+)
	AX = 2010h
	???
Return: ???
SeeAlso: AX=2011h
--------O-152011-----------------------------
INT 15 - OS HOOK - COMPLETION OF SYSREQ FUNCTION (AT,XT286,PS50+)
	AX = 2011h
	???
Return: ???
SeeAlso: AX=2010h
--------B-1521-------------------------------
INT 15 - SYSTEM - POWER-ON SELF-TEST ERROR LOG (PS50+)
	AH = 21h
	AL = subfunction
	    00h read POST log
	    01h write POST log
		BH = device ID
		BL = error code
Return: CF clear if successful
	CF set on error
	AH = status
	    00h OK
	    01h list full
	    02h unsupported subfunction
	    80h invalid command
	    86h unsupported function
	if function 00h:
	   BX = number of error codes stored
	   ES:DI -> error log
Notes:	the log is a series of words, the first byte of which identifies the
	  error code and the second the device.
	supported by AMI PCI BIOS
	IBM considers this a required BIOS function
	if the device ID is FFh, the "error code" is the actual device number
	  minus 255 (thus these devices have no specific error codes)
SeeAlso: AH=23h"SYSTEM",AH=24h"SYSTEM"
--------B-1522-------------------------------
INT 15 - SYSTEM - later PS/2s - LOCATE ROM BASIC
	AH = 22h
Return: CF set on error
	    AH = status (86h if function not supported)
	CF clear on success
	    AH = 00h
	    ES:BX -> ROM BASIC
Notes:	if this function is not supported, ROM BASIC is at F600h:0000h
	IBM classifies this function as optional
SeeAlso: INT 86"BASIC",INT F0"BASIC"
--------B-152300-----------------------------
INT 15 u - IBM BIOS - SMART ENERGY SYSTEM - GET ??? CMOS DATA
	AX = 2300h
Return: CF clear if successful
	    CL = value of CMOS location 2Dh
	    CH = value of CMOS location 2Eh
	CF set on error
	    AH = error code (80h,86h)
Note:	IBM classifies this function as optional
SeeAlso: AX=2301h,AX=2304h,AX=2305h
--------B-152301-----------------------------
INT 15 u - IBM BIOS - SMART ENERGY SYSTEM - SET ??? CMOS DATA
	AX = 2301h
	CL = new value for CMOS location 2Dh
	CH = new value for CMOS location 2Eh
Return: CF clear if successful
	CF set on error
	    AH = error code (80h,86h)
Notes:	sets the contents of CMOS locations 2Dh and 2Eh
	IBM classifies this function as optional
SeeAlso: AX=2300h,AX=2304h,AX=2305h
--------B-152302-----------------------------
INT 15 u - IBM BIOS - SMART ENERGY SYSTEM - GET ROM STARTUP VIDEO REG TABLES
	AX = 2302h
	BL = data index (00h-0Dh) (see #00459)
Return: ES:BX -> table for register (see #00460,#00461)
	CX = size of table in bytes (may be 0000h)
Note:	IBM classifies this function as optional
SeeAlso: AX=2300h,AX=2301h,AX=2303h

(Table 00459)
Values for PS/1 ROM startup video register tables:
 00h	DAC registers
 01h	???
 02h	Palette registers
 03h-0Dh ???

Format of PS/1 ROM startup DAC register table:
Offset	Size	Description	(Table 00460)
 00h	WORD	number of DAC registers in table
 02h	var	array of 3-byte DAC register values, starting at register 00h
SeeAlso: #00459

Format of PS/1 ROM startup Palette register table:
Offset	Size	Description	(Table 00461)
 00h 16 BYTEs	colors for palette registers 00h through 0Fh
 10h	BYTE	border color
SeeAlso: #00459,#00018
--------B-152303-----------------------------
INT 15 U - IBM BIOS - SMART ENERGY SYSTEM - ???
	AX = 2303h
	BX = ??? ('x')
	DX = 'y' and 'z'
		bits 15-7 = 'y'
		bits 6-3 unused
		bits 2-0 = 'z'
	DI = ??? (0352h)
Return: ???
Notes:	performs graphics functions, writes to segment A000h and VGA I/O ports
	IBM classifies this function as optional
--------B-152304-----------------------------
INT 15 u - IBM BIOS - SMART ENERGY SYSTEM - SYSTEM SETUP
	AX = 2304h
	DX = segment of 32K buffer
Return: CF clear if successful
	    AX = 0003h (left over from setting video mode 3)
	    BX,CX,DX,BP,DS,ES destroyed
	CF set on error
	    AH = error code (80h,86h)
Desc:	run system setup utility, and optionally save any changed settings to
	  CMOS RAM
Note:	IBM classifies this function as optional
SeeAlso: AX=2301h,AX=2305h
--------B-152305-----------------------------
INT 15 u - IBM BIOS - SMART ENERGY SYSTEM - GET PROCESSOR SPEED
	AX = 2305h
Return: CF clear if successful
	    AL = processor speed in MHz
	CF set on error
	    AL = FFh (speed unknown or >80 MHz)
	    AL = error code (80h,86h = unsupported function)
Note:	IBM classifies this function as optional
SeeAlso: AX=2301h,AX=2304h,AH=BCh
--------b-152400-----------------------------
INT 15 - SYSTEM - later PS/2s - DISABLE A20 GATE
	AX = 2400h
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Notes:	also supported by AMI PCI BIOS and Qualitas 386MAX v6.01+
	IBM classifies this function as optional
BUG:	AMI BIOS v1.00.03.AV0M never reports an error on failure to disable
	  the A20 gate; it simply writes 0 to PORT 0092h
SeeAlso: AX=2401h,AX=2402h,AX=2403h,PORT 0092h
--------b-152401-----------------------------
INT 15 - SYSTEM - later PS/2s - ENABLE A20 GATE
	AX = 2401h
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Notes:	also supported by AMI PCI BIOS and Qualitas 386MAX v6.01+
	IBM classifies this function as optional
SeeAlso: AX=2400h,AX=2402h,PORT 0092h
--------b-152402-----------------------------
INT 15 - SYSTEM - later PS/2s - GET A20 GATE STATUS
	AX = 2402h
Return: CF clear if successful
	    AH = 00h
	    AL = current state (00h disabled, 01h enabled)
	    CX = ??? (set to 0000h-000Bh or FFFFh by AMI BIOS v1.00.03.AV0M)
		FFFFh if keyboard controller does not become ready within C000h
			 read attempts
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Notes:	also supported by AMI PCI BIOS and Qualitas 386MAX v6.01+
	IBM classifies this function as optional
SeeAlso: AX=2400h,AX=2401h
--------b-152403-----------------------------
INT 15 - SYSTEM - later PS/2s - QUERY A20 GATE SUPPORT
	AX = 2403h
Return: CF clear if successful
	    AH = 00h
	    BX = status of A20 gate support (see #00462)
	CF set on error
	    AH = status
		01h keyboard controller is in secure mode
		86h function not supported
Notes:	also supported by AMI PCI BIOS and Qualitas 386MAX v6.01+
	IBM classifies this function as optional
BUG:	at one point early in processing INT 15/AH=24h, the AMI PCI BIOS
	  version 1.00.05.AX1 compares whether AL==03h instead of AL>=03h,
	  thus causing a random branch on any value of AL greater than 3.
SeeAlso: AX=2402h

Bitfields for A20 gate support status:
Bit(s)	Description	(Table 00462)
 0	supported on keyboard controller
 1	supported with bit 1 of I/O port 92h
 14-2	reserved
 15	additional data is available (location not yet defined)
--------T-153000-----------------------------
INT 15 - Object Kernel for DOS - INSTALLATION CHECK
	AX = 3000h
Return: AX:BX = 4F42h:4A21h ('OBJ!') if installed
	    CX = resident segment
Program: the Object Kernel is a program by M.W. Pieters which is currently
	  under development
Note:	Central Point's CPBACKUP v9 calls INT 15/AX=3000h at startup, but it
	  may be checking for a different program's presence
SeeAlso: AX=3001h,AX=3008h
--------T-153001-----------------------------
INT 15 - Object Kernel for DOS - GET STATUS BLOCK
	AX = 3001h
Return: AX = FFFFh
	ES:DI -> status block
SeeAlso: AX=3000h,AX=3008h
--------T-153002-----------------------------
INT 15 - Object Kernel for DOS - KILL PROCESS
	AX = 3002h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153003-----------------------------
INT 15 - Object Kernel for DOS - STOP PROCESS
	AX = 3003h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153004-----------------------------
INT 15 - Object Kernel for DOS - START PROCESS
	AX = 3004h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153005-----------------------------
INT 15 - Object Kernel for DOS - RESTART PROCESS
	AX = 3005h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153006-----------------------------
INT 15 - Object Kernel for DOS - EXECUTE PROCESS
	AX = 3006h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153007-----------------------------
INT 15 - Object Kernel for DOS - LIST PROCESSES
	AX = 3007h
	(not yet implemented)
SeeAlso: AX=3000h
--------T-153008-----------------------------
INT 15 - Object Kernel for DOS - SWITCH ObjectKernel ON/OFF
	AX = 3008h
	BH = new state (00h disabled, 01h enabled)
Return: AX = FFFFh
SeeAlso: AX=3000h,AX=3009h
--------T-153009-----------------------------
INT 15 - Object Kernel for DOS - RESERVED FOR FUTURE USE
	AX = 3009h to 30FFh
SeeAlso: AX=3000h
Program: the Object Kernel is a program by M.W. Pieters which is currently
	  under development
----------153D-------------------------------
INT 15 - IBM SurePath BIOS - Officially "Private" Function
	AH = 3Dh
SeeAlso: AH=07h"IBM",AH=3Eh"IBM"
----------153E-------------------------------
INT 15 - IBM SurePath BIOS - Officially "Private" Function
	AH = 3Eh
SeeAlso: AH=3Dh"IBM",AH=3Fh"IBM"
----------153F-------------------------------
INT 15 - IBM SurePath BIOS - Officially "Private" Function
	AH = 3Fh
SeeAlso: AH=07h"IBM",AH=3Eh"IBM"
--------B-1540-------------------------------
INT 15 - SYSTEM - READ/MODIFY PROFILES (CONVERTIBLE)
	AH = 40h
	AL = subfunction
	    00h get system profile in CX and BX
	    01h set system profile from CX and BX
	    02h get internal modem profile in BX
	    03h set internal modem profile from BX
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (80h = profile execution failed)
--------V-154000-----------------------------
INT 15 - Compaq SLT/286 or Portable 386 - READ LCD/PLASMA TIMEOUT
	AX = 4000h
Return: AX = 4000h
	CL = timeout in minutes, 00h if disabled
SeeAlso: AX=4001h,AX=4600h
--------V-154001-----------------------------
INT 15 - Compaq SLT/286 or Portable 386 - SET LCD/PLASMA TIMEOUT
	AX = 4001h
	CL = timeout in minutes, 00h to disable
Return: AL = status
	    00h timeout modified
	    01h timeout cannot be modified
	    40h timeout cannot be modified
	CL = timeout in minutes, 00h if disabled
SeeAlso: AX=4000h,AX=4601h
--------B-1541-------------------------------
INT 15 - SYSTEM - WAIT ON EXTERNAL EVENT (CONVERTIBLE and some others)
	AH = 41h
	AL = condition type (see #00463)
	BH = condition compare or mask value
	BL = timeout value times 55 milliseconds
	    00h means no timeout
	DX = I/O port address if AL bit 4 set
	ES:DI -> user byte if AL bit 4 clear
Return: after event or timeout occurs
Note:	call AH=C0h and examine bit 3 of feature byte 1 to determine whether
	  this function is supported
SeeAlso: AH=83h,AH=86h,AH=C0h

Bitfields for external event wait condition type:
Bit(s)	Description	(Table 00463)
 0-2	condition to wait for
	0 any external event
	1 compare and return if equal
	2 compare and return if not equal
	3 test and return if not zero
	4 test and return if zero
 3	reserved
 4	1=port address, 0=user byte
 5-7	reserved
--------B-1542-------------------------------
INT 15 - SYSTEM - REQUEST POWER OFF (CONVERTIBLE,HP 95LX)
	AH = 42h
	AL = suspend type
	    00h to use system profile
	    01h to force suspend regardless of system profile
Return: nothing
Note:	the HP 95LX apparently suspends regardless of the value in AL; on
	  power-up, execution will resume following the instruction calling
	  this function
SeeAlso: AH=44h
--------b-154280-----------------------------
INT 15 - Compaq SLT/286 - ENTER STANDBY
	AX = 4280h
Return: AH = 42h
	CF clear if successful
	CF set if unable to enter standby
SeeAlso: AX=4600h,AX=5307h/CX=0001h"STAND-BY"
--------B-1543-------------------------------
INT 15 - SYSTEM - READ SYSTEM STATUS (CONVERTIBLE)
	AH = 43h
Return: AL = status bits (see #00464)

Bitfields for Convertible system status:
Bit(s)	Description	(Table 00464)
 7	power low
 6	external power in use
 5	standby power lost
 4	power activated by alarm
 3	internal modem powered on
 2	RS232/parallel adapter powered on
 1	reserved
 0	LCD detached
--------B-1544-------------------------------
INT 15 - SYSTEM - (DE)ACTIVATE INTERNAL MODEM POWER (CONVERTIBLE)
	AH = 44h
	AL = new modem power state (00h power off, 01h power on)
Return: nothing
SeeAlso: AH=42h
--------b-1544C0-----------------------------
INT 15 - Olivetti Quaderno - INITIALIZE DIGITAL SIGNAL PROCESSING???
	AX = 44C0h
	ES:DI -> new DSP procedure (exchanged with CMOS[28h])
	ES:SI -> ??? buffer
Return: ES:DI -> old DSP procedure
	ES:SI buffer filled with ten bytes from CMOS (addresses 14h-1Ch)
	  followed by 00h (addresses 15h-1Ch copied only if less than 21h)
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C1-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C1h
	???
Return: ???
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C2-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C2h
	DL = byte to be written to I/O port 350h
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C3h,AX=44C9h
--------b-1544C3-----------------------------
INT 15 - Olivetti Quaderno - GET ???
	AX = 44C3h
Return: DH = bitfields (see #00465)
	DL = value read from I/O port 350h
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C2h,AX=44C9h

Bitfields for Olivetti Quaderno ???:
Bit(s)	Description	(Table 00465)
 5-7	5-7 read from I/O port 351h
 2-4	zero
 1-0	"tres complique"
--------b-1544C4-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C4h and 44C5h
	???
Return: ???
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C6-----------------------------
INT 15 - Olivetti Quaderno - READ LCD
	AX = 44C6h
Return: DX = FFFFh clock is displayed on LCD display
	DX = other: hex number displayed in first four positions of display
	BH = left alphanumeric character on display (see #00466)
	BL = right alphanumeric character on display (see #00466)
	CL = colon flags (see #00467)
Notes:	the LCD display has the format HH:HH:AA, where H is a hex digit and A
	  is an alphanumeric character
	this function is also supported by XBIOS.COM
SeeAlso: AX=44C7h,AX=44C9h

(Table 00466)
Values for Olivetti Quaderno LCD alphanumeric characters:
 00h-0Fh hex digit
 2Bh	"+"
 2Dh	"-"
 30h-39h "0" to "9"
 41h-5Ah "A" to "Z"
 61h-6Ah "a" to "z"
 else	blank

Bitfields for Olivetti Quaderno LCD colon flags:
Bit(s)	Description	(Table 00467)
 0	left colon on
 1	right colon on
 2-7	unused
--------b-1544C7-----------------------------
INT 15 - Olivetti Quaderno - WRITE LCD
	AX = 44C7h
	DX = hex display
	    FFFFh display clock and "HI", "Md", or "Lo"
		BH,BL,CL unused
	    other: display specified hex number in first four positions
		BH = left alphanumeric character on display (see #00466)
		BL = right alphanumeric character on display (see #00466)
		CL = colon flags (see #00467)
Return: nothing
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C6h
--------b-1544C8-----------------------------
INT 15 - Olivetti Quaderno - ???
	AX = 44C8h
	CL = ??? (00h,02h,21h)
	CH = ???
	???
Return: ???
Note:	this function is also supported by XBIOS.COM
SeeAlso: AX=44C9h
--------b-1544C9-----------------------------
INT 15 - Olivetti Quaderno - GET XBIOS VERSION
	AX = 44C9h
Return: AL = major version
	AH = minor version
Note:	this function is also supported by XBIOS.COM
--------B-1544F1-----------------------------
INT 15 U - Toshiba laptops - SECURITY LEVEL CHECK
	AX = 44F1h
	DS:DX -> byte with 00h ???
Return: ???
Note:	used by Toshiba BIOS setup utility TSETUP.EXE to distinguish
	  between USER and SUPERVISOR security level
SeeAlso: AX=44F2h,AX=44F3h
--------B-1544F2BX0604-----------------------
INT 15 U - Toshiba laptops - SECURITY LEVEL CHECK
	AX = 44F2h
	BX = 0604h ???
Return: CF = ???
	AH = ???
	DX = ???
Note:	used by Toshiba BIOS setup utility TSETUP.EXE to distinguish
	  between USER and SUPERVISOR security level
SeeAlso: AX=44F1h,AX=44F3h
--------B-1544F3-----------------------------
INT 15 U - Toshiba laptops - SECURITY LEVEL CHECK
	AX = 44F3h
	DS:DX -> byte with 00h or 01h ???
Return: DS:DX -> changed ???
Note:	used by Toshiba BIOS setup utility TSETUP.EXE to distinguish
	  between USER and SUPERVISOR security level
SeeAlso: AX=44F1h,AX=44F2h
--------b-1545-------------------------------
INT 15 U - HP 100LX/200LX - SET DISPLAY CONTROL STATUS
	AH = 45h
	AL = new display control status
	    bit 0: DISPCTL flag +C instead of -C
	    bit 1: DISPCTL flag +K instead of -K
SeeAlso: AH=46h"HP",AH=47h"HP"
--------b-1546-------------------------------
INT 15 U - HP 100LX/200LX - SET POWER OFF TIMEOUT
	AH = 46h
	BX = timeout value in ticks
	    0000h inhibit auto power off
Note:	the 200LX default timeout is 0CCDh = 3277 ticks = approx. 3 min.
SeeAlso: AH=45h"HP",AH=47h"HP"
--------b-154600-----------------------------
INT 15 - Compaq SLT/286 - READ POWER CONSERVATION/MODEM CONFIGURATION
	AX = 4600h
Return: AH = modem configuration information (see #00468)
	AL = power conservation status information (see #00469)
	BH = default system inactivity timeout (1-21 minutes)
	BL = current system inactivity timeout (1-21 minutes)
	CH = default video display inactivity timeout (1-63 minutes)
	CL = current video display inactivity timeout (1-63 minutes)
	DH = default fixed disk drive inactivity timeout (1-21 minutes)
	DL = current fixed disk drive inactivity timeout (1-21 minutes)
SeeAlso: AX=4280h,AX=4601h,INT 77

Bitfields for Compaq SLT/286 modem configuration information:
Bit(s)	Description	(Table 00468)
 0	powerup state (0 off, 1 on)
 1	modem installed
 2	IRQ line assignment (0 IRQ 4, 1 IRQ 3)
 3	COM port assignment (0 = COM 2, 1 = COM 1)
 4	modem state (0 not assigned, 1 assigned)
 5	modem is on

Bitfields for Compaq SLT/286 power conservation status:
Bit(s)	Description	(Table 00469)
 0	power source (0 internal, 1 external)
 1-2	low battery state
	00 no low battery condition
	01 low battery 1
	10 reserved
	11 low battery 2
 3-4	power conservation mode
	00 automatic, 01 on, 10 off, 11 reserved
--------b-154601-----------------------------
INT 15 - Compaq SLT/286 - MODIFY POWER CONSERVATION/MODEM CONFIGURATION
	AX = 4601h
	BL = system inactivity timeout (1-21 minutes)
	    FFh do not change
	CL = video display inactivity timeout (1-63 minutes)
	    FFh do not change
	DL = current fixed disk drive inactivity timeout (1-21 minutes)
	    FFh do not change
	DH = new modem state (00h turn off, 01h turn on, FFh don't change)
Return: CF clear if successful
	    AH = 00h
	    BL = current system inactivity timeout (1-21 minutes)
	    CL = current video display inactivity timeout (1-63 minutes)
	    DL = current fixed disk drive inactivity timeout (1-21 minutes)
	    DH = modem state (FFh unchanged, 00h turned off, 01h turned on)
	CF set on error
	    AH = error code
		01h input is out of range
		02h no modem present
SeeAlso: AX=4600h,INT 77
--------b-154604-----------------------------
INT 15 - Compaq Contura 486 and "Alladin" 1993/08/05 ROMs - GET ???
	AX = 4604h
Return: CF clear if successful
	    AL = byte read from I/O port 03F8h
	CF set on error (not supported)
	    AH = 86h (unsupported function)
Note:	also supported by 1993/7/26 LTE Lite 386 ROM
--------b-154605-----------------------------
INT 15 - Compaq Contura 486 and "Alladin" 1993/08/05 ROMs - ???
	AX = 4605h
Return: CF clear if successful
	CF set on error (not supported)
	    AH = 86h (unsupported function)
Note:	this function is a NOP (other than clearing CF) in the 1993/08/05
	  version of the Contura 486/486c/486cx and "Aladdin" ROM, and the
	  1993/7/26 LTE Lite 386 ROM
--------b-1547-------------------------------
INT 15 U - HP 100LX/200LX - GET/SET DISPLAY CONTRAST
	AH = 47h
	AL = subfunction
	   00h set contrast
		BL = new contrast
		    (00h-0Fh, 0Fh is darkest, 10h-FFh are same as 0Fh)
	   other get current contrast
Return: AL = contrast (00h-0Fh, 0Fh is darkest)
Note:	may be for backward compatibility with HP95LX, as INT 15/AH=62h does
	  substantially the same thing as this function
SeeAlso: AH=45h"HP",AH=48h"HP",AH=62h"HP"
--------b-1548-------------------------------
INT 15 U - HP 100LX/200LX - SET BUZZER VOLUME
	AH = 48h
	AL = volume (00h-03h; 03h is loudest, 04h-FFh are same as 03h)
SeeAlso: AH=47h"HP"
--------S-1549-------------------------------
INT 15 U - HP 100LX/200LX - SERIAL INTERFACE SELECT
	AH = 49h
	AL = serial interface
	    00h wired (COM1)
	    01h infrared
Note:	interface should only be changed in deactivated state (see AH=4Ah)
SeeAlso: AH=4Ah"HP"
--------J-154900-----------------------------
INT 15 - Far East MS-DOS - GET BIOS TYPE
	AX = 4900h
Return: CF clear if successful
	    AH = 00h
	    BL = BIOS mode
		00h DOS/V
		01h standard DBCS DOS (hardware DBCS support)
	CF set on error
	    AH = 86h (function not supported)
Note:	in practice, DOS/J returns AH=86h; AX DOS does not support this call
SeeAlso: AH=50h,INT 21/AH=30h
--------S-154A-------------------------------
INT 15 U - HP 100LX/200LX - SERIAL INTERFACE CONTROL
	AH = 4Ah
	AL = control
	    00h deactivate
	    01h activate
Note:	interface selected with AH=49h will be (de)activated
SeeAlso: AH=49h"HP",AH=4Bh"HP"
--------b-154B-------------------------------
INT 15 U - HP 100LX/200LX - ADJUST SYSTEM TIME
	AH = 4Bh
Desc:	adjust system time based on real-time clock
SeeAlso: AH=4Ah"HP",INT 1A/AH=02h,INT 21/AH=2Ch
--------b-154DD4-----------------------------
INT 15 - HP 95LX/100LX/200LX - INSTALLATION CHECK
	AX = 4DD4h
Return: BX = 4850h ("HP") if HP 95LX/100LX/200LX
	    CX = model
		0101h HP 95LX
		0102h HP 100LX/200LX
	    DH = ???
		02h HP 200LX 2MB BIOS 1.01 A D german
	    DL = ???
		00h HP 95LX
		01h HP 200LX 2MB BIOS 1.01 A D german
SeeAlso: INT 0B"HP 95LX",INT 0F"HP 95LX",INT 5F/AH=00h,INT 60/DI=0100h
SeeAlso: INT 61"HP 95LX"
--------b-154E-------------------------------
INT 15 - HP 95LX - ENABLE/DISABLE LIGHT SLEEP
	AH = 4Eh
	AL = light sleep
	    00h disabled
	    01h enabled
Note:	when light sleep is disabled, the system will continue running at full
	  speed; when enabled, it may automatically slow to conserve batteries
SeeAlso: INT 06"HP 95LX",INT 60/DI=0100h
----------154E-------------------------------
INT 15 - IBM SurePath BIOS - Officially "Private" Function
	AH = 4Eh
SeeAlso: AH=07h"IBM",AH=3Eh"IBM"
--------B-154F-------------------------------
INT 15 C - KEYBOARD - KEYBOARD INTERCEPT (AT model 3x9,XT2,XT286,CONV,PS)
	AH = 4Fh
	AL = hardware scan code (see #00006)
	CF set
Return: CF set to continue processing scan code
	   AL = possibly-altered hardware scan code (see #00006)
	CF clear
	   scan code should be ignored
Notes:	called by INT 09 handler to translate scan codes; the INT 09 code does
	  not examine the scan code it reads from the keyboard until after
	  this function returns.  This permits software to rearrange the
	  keyboard; for example, swapping the CapsLock and Control keys, or
	  turning the right Shift key into Enter.
	DOS 6 KEYB.COM will not pass through this function if Ctrl-Alt-Del is
	  pressed and a SmartDrive v4-compatible cache is installed which has
	  dirty cache buffers; some other disk caches such as HyperDisk
	  operate similarly in order to prevent loss of cached data which has
	  not yet been written to disk
	IBM classifies this function as required
SeeAlso: INT 09,INT 15/AH=C0h
--------J-1550-------------------------------
INT 15 - DOS/V - FONT SUBSYSTEM ACCESS
	AH = 50h
	AL = which function address to retrieve
	    00h "read font" function
	    01h "write font" function
	BL = 00h
	BH = character size (00h single-byte, 01h double-byte)
	DH = width of character cell
	DL = height of character cell
	BP = code page (see #00470)
Return: CF clear if successful
	    AH = 00h
	    ES:BX -> requested function's address
	CF set on error
	    AH = error code (see #00471)
SeeAlso: AH=49h

(Table 00470)
Values for DOS/V code page:
 0	default
 437	US English
 932	Japanese
 934	Korea
 936	China
 938	Taiwan
SeeAlso: #01757

(Table 00471)
Values for DOS/V error code:
 01h	invalid font type in BH
 02h	BL not zero
 03h	invalid font size
 04h	invalid code page
 80h	unsupported function (PC)
 86h	unsupported function (XT)
SeeAlso: #01680
--------T-1550-------------------------------
INT 15 - VMIX v2.???+ - "sys_vm_page" - SET NEW VIRTUAL PAGE TABLE
	AH = 50h
	BX = segment of page directory table
	CX = page number of page table
SeeAlso: AH=10h"VMiX",AH=51h"VMiX",AH=52h"VMiX"
--------T-1551-------------------------------
INT 15 - VMiX v2.???+ - "sys_vm_func" - EXECUTE FUNCTION IN PROTECTED MODE
	AH = 51h
	STACK:	DWORD	selector:offset of function
Return: registers as returned by function
Note:	executes function with privilege level 0 (highest privilege)
SeeAlso: AH=10h"VMiX",AH=52h"VMiX"
--------B-155101-----------------------------
INT 15 - SYSTEM - later PS/2s - EXPANSION UNIT, RETURN CONFIGURATION NUMBER
	AX = 5101h
Return: CF set if successful
	    AH = 00h
	    AL = current configuration number
		00h system unit only
		FFh configuration not recognized
	    BX = status flag
		bits 0-14: reserved
		bit 15: additional data is available (location TBD)
	CF clear on error
	    AH = status
		01h expansion unit is not present
		86h function not supported
Note:	CF convention is the reverse of the standard convention for this
	  interrupt.  (Perhaps a typo in the IBM BIOS Tech Ref?)
--------T-1552-------------------------------
INT 15 - VMiX v2.???+ - "sys_vm_init" - INITIALIZE PROTECTED-MODE ENVIRONMENT
	AH = 52h
SeeAlso: AH=50h"VMiX",AH=51h"VMiX"
--------d-1552-------------------------------
INT 15 C - IBM/MS INT 13 Extensions - MEDIA EJECT INTERCEPT
	AH = 52h
	DL = drive number
Return: CF clear if OK to eject media
	    AH = 00h
	CF set if ejection disallowed
	    AH = error code (B1h,B3h) (see #00234)
Note:	called by the IBM/MS INT 13 Extensions driver/BIOS when an ejection
	  request is made
SeeAlso: INT 13/AH=46h"INT 13 Extensions"
--------p-155300-----------------------------
INT 15 - Advanced Power Management v1.0+ - INSTALLATION CHECK
	AX = 5300h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	    AH = major version (BCD)
	    AL = minor version (BCD)
	    BX = 504Dh ("PM")
	    CX = flags (see #00472)
	CF set on error
	    AH = error code (06h,09h,86h) (see #00473)
BUG:	early versions of the Award Modular BIOS with built-in APM support
	  reportedly do not set BX on return

Bitfields for APM flags:
Bit(s)	Description	(Table 00472)
 0	16-bit protected mode interface supported
 1	32-bit protected mode interface supported
 2	CPU idle call reduces processor speed
 3	BIOS power management disabled
 4	BIOS power management disengaged (APM v1.1)
 5-7	reserved

(Table 00473)
Values for APM error code:
 01h	power management functionality disabled
 02h	interface connection already in effect
 03h	interface not connected
 04h	real-mode interface not connected
 05h	16-bit protected-mode interface already connected
 06h	16-bit protected-mode interface not supported
 07h	32-bit protected-mode interface already connected
 08h	32-bit protected-mode interface not supported
 09h	unrecognized device ID
 0Ah	invalid parameter value in CX
 0Bh	(APM v1.1) interface not engaged
 0Ch	(APM v1.2) function not supported
 0Dh	(APM v1.2) Resume Timer disabled
 0Eh-1Fh reserved for other interface and general errors
 20h-3Fh reserved for CPU errors
 40h-5Fh reserved for device errors
 60h	can't enter requested state
 61h-7Fh reserved for other system errors
 80h	no power management events pending
 81h-85h reserved for other power management event errors
 86h	APM not present
 87h-9Fh reserved for other power management event errors
 A0h-FEh reserved
 FFh	undefined
--------p-155301-----------------------------
INT 15 - Advanced Power Management v1.0+ - CONNECT REAL-MODE INTERFACE
	AX = 5301h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	CF set on error
	    AH = error code (02h,05h,07h,09h) (see #00473)
Note:	on connection, an APM v1.1 or v1.2 BIOS switches to APM v1.0
	  compatibility mode until it is informed that the user supports a
	  newer version of APM (see AX=530Eh)
SeeAlso: AX=5302h,AX=5303h,AX=5304h
--------p-155302-----------------------------
INT 15 R - Advanced Power Management v1.0+ - CONNECT 16-BIT PROTMODE INTERFACE
	AX = 5302h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	    AX = real-mode segment base address of protected-mode 16-bit code
		segment
	    BX = offset of entry point
	    CX = real-mode segment base address of protected-mode 16-bit data
		segment
	    ---APM v1.1---
	    SI = APM BIOS code segment length
	    DI = APM BIOS data segment length
	CF set on error
	    AH = error code (02h,05h,06h,07h,09h) (see #00473)
Notes:	the caller must initialize two consecutive descriptors with the
	  returned segment base addresses; these descriptors must be valid
	  whenever the protected-mode interface is called, and will have
	  their limits arbitrarily set to 64K.
	the protected mode interface is invoked by making a far call with the
	  same register values as for INT 15; it must be invoked while CPL=0,
	  the code segment descriptor must have a DPL of 0, the stack must be
	  in a 16-bit segment and have enough room for BIOS use and possible
	  interrupts, and the current I/O permission bit map must allow access
	  to the I/O ports used for power management.
	functions 00h-03h are not available from protected mode
	on connection, an APM v1.1 or v1.2 BIOS switches to APM v1.0
	  compatibility mode until it is informed that the user supports a
	  newer version of APM (see AX=530Eh)
SeeAlso: AX=5301h,AX=5303h,AX=5304h
--------p-155303-----------------------------
INT 15 - Advanced Power Management v1.0+ - CONNECT 32-BIT PROTMODE INTERFACE
	AX = 5303h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	    AX = real-mode segment base address of protected-mode 32-bit code
		segment
	    EBX = offset of entry point
	    CX = real-mode segment base address of protected-mode 16-bit code
		segment
	    DX = real-mode segment base address of protected-mode 16-bit data
		segment
	    ---APM v1.1---
	    SI = APM BIOS code segment length
	    DI = APM BIOS data segment length
	CF set on error
	    AH = error code (02h,05h,07h,08h,09h) (see #00473)
Notes:	the caller must initialize three consecutive descriptors with the
	  returned segment base addresses for 32-bit code, 16-bit code, and
	  16-bit data, respectively; these descriptors must be valid whenever
	  the protected-mode interface is called, and will have their limits
	  arbitrarily set to 64K.
	the protected mode interface is invoked by making a far call to the
	  32-bit code segment with the same register values as for INT 15; it
	  must be invoked while CPL=0, the code segment descriptor must have a
	  DPL of 0, the stack must be in a 32-bit segment and have enough room
	  for BIOS use and possible interrupts, and the current I/O permission
	  bit map must allow access to the I/O ports used for power management.
	functions 00h-03h are not available from protected mode
	on connection, an APM v1.1 or v1.2 BIOS switches to APM v1.0
	  compatibility mode until it is informed that the user supports a
	  newer version of APM (see AX=530Eh)
SeeAlso: AX=5301h,AX=5302h,AX=5304h
--------p-155304-----------------------------
INT 15 - Advanced Power Management v1.0+ - DISCONNECT INTERFACE
	AX = 5304h
	BX = device ID of system BIOS (0000h)
Return: CF clear if successful
	CF set on error
	    AH = error code (03h,09h) (see #00473)
SeeAlso: AX=5301h,AX=5302h,AX=5303h
--------p-155305-----------------------------
INT 15 - Advanced Power Management v1.0+ - CPU IDLE
	AX = 5305h
Return: CF clear if successful (after system leaves idle state)
	CF set on error
	    AH = error code (03h,0Bh) (see #00473)
Notes:	call when the system is idle and should be suspended until the next
	  system event or interrupt
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	if an interrupt causes the system to resume normal processing, the
	  interrupt may or may not have been handled when the BIOS returns
	  from this call; thus, the caller should allow interrupts on return
	interrupt handlers may not retain control if the BIOS allows
	  interrupts while in idle mode even if they are able to determine
	  that they were called from idle mode
	the caller should issue this call continuously in a loop until it needs
	  to perform some processing of its own
SeeAlso: AX=1000h,AX=5306h,INT 2F/AX=1680h
--------p-155306-----------------------------
INT 15 - Advanced Power Management v1.0+ - CPU BUSY
	AX = 5306h
Return: CF clear if successful
	CF set on error
	    AH = error code (03h,0Bh) (see #00473)
Notes:	called to ensure that the system runs at full speed even on systems
	  where the BIOS is unable to recognize increased activity (especially
	  if interrupts are hooked by other programs and not chained to the
	  BIOS)
	this call may be made even when the system is already running at full
	  speed, but it will create unnecessary overhead
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5305h
--------p-155307-----------------------------
INT 15 - Advanced Power Management v1.0+ - SET POWER STATE
	AX = 5307h
	BX = device ID (see #00474)
	CX = system state ID (see #00475)
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,03h,09h,0Ah,0Bh,60h) (see #00473)
Note:	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=530Ch

(Table 00474)
Values for APM device IDs:
 0000h	system BIOS
 0001h	all devices for which the system BIOS manages power
 01xxh	display (01FFh for all attached display devices)
 02xxh	secondary storage (02FFh for all attached secondary storage devices)
 03xxh	parallel ports (03FFh for all attached parallel ports)
 04xxh	serial ports (04FFh for all attached serial ports)
---APM v1.1+ ---
 05xxh	network adapters (05FFh for all attached network adapters)
 06xxh	PCMCIA sockets (06FFh for all)
 0700h-7FFFh reserved
 80xxh	system battery devices (APM v1.2)
 8100h-DFFFh reserved
 Exxxh	OEM-defined power device IDs
 F000h-FFFFh reserved

(Table 00475)
Values for system state ID:
 0000h	ready (not supported for device ID 0001h)
 0001h	stand-by
 0002h	suspend
 0003h	off (not supported for device ID 0001h in APM v1.0)
---APM v1.1---
 0004h	last request processing notification (only for device ID 0001h)
 0005h	last request rejected (only for device ID 0001h)
 0006h-001Fh reserved system states
 0020h-003Fh OEM-defined system states
 0040h-007Fh OEM-defined device states
 0080h-FFFFh reserved device states
--------p-155307CX0001-----------------------
INT 15 - Advanced Power Management v1.0+ - SYSTEM STAND-BY
	AX = 5307h
	CX = 0001h
	BX = 0001h (device ID for all power-managed devices)
Return: CF clear
Notes:	puts the entire system into stand-by mode; normally called in response
	  to a System Stand-by Request notification after any necessary
	  processing, but may also be invoked at the caller's discretion
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	the stand-by state is typically exited on an interrupt
SeeAlso: AX=4280h,AX=5307h/CX=0002h"SUSPEND",AX=5307h/CX=0003h,AX=530Bh
--------p-155307CX0002-----------------------
INT 15 - Advanced Power Management v1.0+ - SUSPEND SYSTEM
	AX = 5307h
	CX = 0002h
	BX = 0001h (device ID for all power-managed devices)
Return: after system is resumed
	CF clear
Notes:	puts the entire system into a low-power suspended state; normally
	  called in response to a Suspend System Request notification after
	  any necessary processing, but may also be invoked at the caller's
	  discretion
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	the caller may need to update its date and time values because the
	  system could have been suspended for a long period of time
SeeAlso: AX=5307h/CX=0001h"STAND-BY",AX=530Bh
--------p-155307CX0003-----------------------
INT 15 - Advanced Power Management v1.2 - TURN OFF SYSTEM
	AX = 5307h
	CX = 0003h
	BX = 0001h (device ID for all power-managed devices)
Return: after system is resumed
	CF clear
Notes:	if supported by the system's power supply, turns off the system power
SeeAlso: AX=5307h/CX=0001h"STAND-BY",AX=530Bh
--------p-155308-----------------------------
INT 15 - Advanced Power Management v1.0+ - ENABLE/DISABLE POWER MANAGEMENT
	AX = 5308h
	BX = device ID for all devices power-managed by APM
	    0001h (APM v1.1+)
	    FFFFh (APM v1.0)
	CX = new state
	    0000h disabled
	    0001h enabled
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,03h,09h,0Ah,0Bh) (see #00473)
Notes:	when power management is disabled, the system BIOS will not
	  automatically power down devices, enter stand-by or suspended mode,
	  or perform any power-saving actions in response to AX=5305h calls
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	the APM BIOS should never be both disabled and disengaged at the same
	  time
SeeAlso: AX=5309h,AX=530Dh,AX=530Fh
--------p-155309-----------------------------
INT 15 - Advanced Power Management v1.0+ - RESTORE POWER-ON DEFAULTS
	AX = 5309h
	BX = device ID for all devices power-managed by APM
	    0001h (APM v1.1)
	    FFFFh (APM v1.0)
Return: CF clear if successful
	CF set on error
	    AH = error code (03h,09h,0Bh) (see #00473)
Note:	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5308h
--------p-15530A-----------------------------
INT 15 - Advanced Power Management v1.0+ - GET POWER STATUS
	AX = 530Ah
	BX = device ID
	    0001h all devices power-managed by APM
	    80xxh specific battery unit number XXh (01h-FFh) (APM v1.2)
Return: CF clear if successful
	    BH = AC line status
		00h off-line
		01h on-line
		02h on backup power (APM v1.1)
		FFh unknown
		other reserved
	    BL = battery status (see #00476)
	    CH = battery flag (APM v1.1+) (see #00477)
	    CL = remaining battery life, percentage
		00h-64h (0-100) percentage of full charge
		FFh unknown
	    DX = remaining battery life, time (APM v1.1) (see #00478)
	    ---if specific battery unit specified---
	    SI = number of battery units currently installed
	CF set on error
	    AH = error code (09h,0Ah) (see #00473)
Notes:	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
	supported in real mode (INT 15) and both 16-bit and 32-bit protected
	  mode

(Table 00476)
Values for APM v1.0+ battery status:
 00h	high
 01h	low
 02h	critical
 03h	charging
 FFh	unknown
 other	reserved
SeeAlso: #00477,#00478

Bitfields for APM v1.1+ battery flag:
Bit(s)	Description	(Table 00477)
 0	high
 1	low
 2	critical
 3	charging
 4	selected battery not present (APM v1.2)
 5-6	reserved (0)
 7	no system battery
Note:	all bits set (FFh) if unknown
SeeAlso: #00476,#00478

Bitfields for APM v1.1+ remaining battery life:
Bit(s)	Description	(Table 00478)
 15	time units: 0=seconds, 1=minutes
 14-0	battery life in minutes or seconds
Note:	all bits set (FFFFh) if unknown
SeeAlso: #00476,#00477
--------p-15530B-----------------------------
INT 15 - Advanced Power Management v1.0+ - GET POWER MANAGEMENT EVENT
	AX = 530Bh
Return: CF clear if successful
	    BX = event code (see #00479)
	    CX = event information (APM v1.2) if BX=0003h or BX=0004h
		bit 0: PCMCIA socket was powered down in suspend state
	CF set on error
	    AH = error code (03h,0Bh,80h) (see #00473)
Notes:	although power management events are often asynchronous, notification
	  will not be made until polled via this call to permit software to
	  only receive event notification when it is prepared to process
	  power management events; since these events are not very time-
	  critical, it should be sufficient to poll once or twice per second
	the critical resume notification is made after the system resumes
	  from an emergency suspension; normally, the system BIOS only notifies
	  its partner that it wishes to suspend and relies on the partner to
	  actually request the suspension, but no notification is made on an
	  emergency suspension
	should not be called from within a hardware interrupt handler to avoid
	  reentrance problems
SeeAlso: AX=5307h,AX=5307h/CX=0001h"STAND-BY",AX=5307h/CX=0002h"SUSPEND"

(Table 00479)
Values for APM event code:
 0001h	system stand-by request
 0002h	system suspend request
 0003h	normal resume system notification
 0004h	critical resume system notification
 0005h	battery low notification
---APM v1.1---
 0006h	power status change notification
 0007h	update time notification
 0008h	critical system suspend notification
 0009h	user system standby request notification
 000Ah	user system suspend request notification
 000Bh	system standby resume notification
---APM v1.2---
 000Ch	capabilities change notification (see AX=5310h)
------
 000Dh-00FFh reserved system events
 01xxh	reserved device events
 02xxh	OEM-defined APM events
 0300h-FFFFh reserved
--------p-15530C-----------------------------
INT 15 - Advanced Power Management v1.1+ - GET POWER STATE
	AX = 530Ch
	BX = device ID (see #00474)
Return: CF clear if successful
	    CX = system state ID (see #00475)
	CF set on error
	    AH = error code (01h,09h) (see #00473)
SeeAlso: AX=5307h
--------p-15530D-----------------------------
INT 15 - Advanced Power Management v1.1+ - EN/DISABLE DEVICE POWER MANAGEMENT
	AX = 530Dh
	BX = device ID (see #00474)
	CX = function
	    0000h disable power management
	    0001h enable power management
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,03h,09h,0Ah,0Bh) (see #00473)
Desc:	specify whether automatic power management should be active for a
	  given device
SeeAlso: AX=5308h,AX=530Fh
--------p-15530E-----------------------------
INT 15 - Advanced Power Management v1.1+ - DRIVER VERSION
	AX = 530Eh
	BX = device ID of system BIOS (0000h)
	CH = APM driver major version (BCD)
	CL = APM driver minor version (BCD) (02h for APM v1.2)
Return: CF clear if successful
	    AH = APM connection major version (BCD)
	    AL = APM connection minor version (BCD)
	CF set on error
	    AH = error code (03h,09h,0Bh) (see #00473)
SeeAlso: AX=5300h,AX=5303h
--------p-15530F-----------------------------
INT 15 - Advanced Power Management v1.1+ - ENGAGE/DISENGAGE POWER MANAGEMENT
	AX = 530Fh
	BX = device ID (see #00474)
	CX = function
	    0000h disengage power management
	    0001h engage power management
Return: CF clear if successful
	CF set on error
	    AH = error code (01h,09h) (see #00473)
Notes:	unlike AX=5308h, this call does not affect the functioning of the APM
	  BIOS
	when cooperative power management is disengaged, the APM BIOS performs
	  automatic power management of the system or device
SeeAlso: AX=5308h,AX=530Dh
--------p-155310-----------------------------
INT 15 - Advanced Power Management v1.2 - GET CAPABILITIES
	AX = 5310h
	BX = device ID (see #00474)
	    0000h (APM BIOS)
	    other reserved
Return: CF clear if successful
	    BL = number of battery units supported (00h if no system batteries)
	    CX = capabilities flags (see #00480)
	CF set on error
	    AH = error code (01h,09h,86h) (see #00473)
Notes:	this function is supported via the INT 15, 16-bit protected mode, and
	  32-bit protected mode interfaces; it does not require that a
	  connection be established prior to use
	this function will return the capabilities currently in effect, not
	  any new settings which have been made but do not take effect until
	  a system restart
SeeAlso: AX=5300h,AX=530Fh,AX=5311h,AX=5312h,AX=5313h

Bitfields for APM v1.2 capabilities flags:
Bit(s)	Description	(Table 00480)
 15-8	reserved
 7	PCMCIA Ring Indicator will wake up system from suspend mode
 6	PCMCIA Ring Indicator will wake up system from standby mode
 5	Resume on Ring Indicator will wake up system from suspend mode
 4	Resume on Ring Indicator will wake up system from standby mode
 3	resume timer will wake up system from suspend mode
 2	resume timer will wake up system from standby mode
 1	can enter global suspend state
 0	can enter global standby state
--------p-155311-----------------------------
INT 15 - Advanced Power Management v1.2 - GET/SET/DISABLE RESUME TIMER
	AX = 5311h
	BX = device ID (see #00474)
	    0000h (APM BIOS)
	    other reserved
	CL = function
	    00h disable Resume Timer
	    01h get Resume Timer
	    02h set Resume Timer
		CH = resume time, seconds (BCD)
		DL = resume time, minutes (BCD)
		DH = resume time, hours (BCD)
		SI = resume date (BCD), high byte = month, low byte = day
		DI = resume date, year (BCD)
Return: CF clear if successful
	    ---if getting timer---
	    CH = resume time, seconds (BCD)
	    DL = resume time, minutes (BCD)
	    DH = resume time, hours (BCD)
	    SI = resume date (BCD), high byte = month, low byte = day
	    DI = resume date, year (BCD)
	CF set on error
	    AH = error code (03h,09h,0Ah,0Bh,0Ch,0Dh,86h) (see #00473)
Notes:	this function is supported via the INT 15, 16-bit protected mode, and
	  32-bit protected mode interfaces
SeeAlso: AX=5300h,AX=5310h,AX=5312h,AX=5313h
--------p-155312-----------------------------
INT 15 - Advanced Power Management v1.2 - ENABLE/DISABLE RESUME ON RING
	AX = 5312h
	BX = device ID (see #00474)
	    0000h (APM BIOS)
	    other reserved
	CL = function
	    00h disable Resume on Ring Indicator
	    01h enable Resume on Ring Indicator
	    02h get Resume on Ring Indicator status
Return: CF clear if successful
	    CX = resume status (0000h disabled, 0001h enabled)
	CF set on error
	    AH = error code (03h,09h,0Ah,0Bh,0Ch,86h) (see #00473)
Notes:	this function is supported via the INT 15, 16-bit protected mode, and
	  32-bit protected mode interfaces
SeeAlso: AX=5300h,AX=5310h,AX=5311h,AX=5313h
--------p-155313-----------------------------
INT 15 - Advanced Power Management v1.2 - ENABLE/DISABLE TIMER-BASED REQUESTS
	AX = 5313h
	BX = device ID (see #00474)
	    0000h (APM BIOS)
	    other reserved
	CL = function
	    00h disable timer-based requests
	    01h enable timer-based requests
	    02h get timer-based requests status
Return: CF clear if successful
	    CX = timer-based requests status (0000h disabled, 0001h enabled)
	CF set on error
	    AH = error code (03h,09h,0Ah,0Bh,86h) (see #00473)
Notes:	this function is supported via the INT 15, 16-bit protected mode, and
	  32-bit protected mode interfaces
	some BIOSes set AH on return even when successful
SeeAlso: AX=5300h,AX=5310h,AX=5311h,AX=5312h
--------p-155380BH00-------------------------
INT 15 - APM SL Enhanced v1.0 - GET SUSPEND/GLOBAL STANDBY MODE
	AX = 5380h
	BH = 00h
Return: CF clear if successful
	    AL = 82360SL Auto Power Off Timer High Count (APWR_TMRH)
	    BL = sustdbymode (see #00481)
SeeAlso: AX=5380h/BH=01h,AX=5380h/BH=02h,AX=5380h/BH=7Fh

Bitfields for APM SL sustdbymode:
Bit(s)	Description	(Table 00481)
 2	???
 1	Auto Power Off Timer Enable (APWR_TMR_EN)
 0	???
--------p-155380BH01-------------------------
INT 15 - APM SL Enhanced v1.0 - SET SUSPEND/GLOBAL STANDBY MODE
	AX = 5380h
	BH = 01h
	BL = sustdbymode (see #00481)
Return: CF clear if successful
SeeAlso: AX=5380h/BH=00h,AX=5380h/BH=7Fh
--------p-155380BH02-------------------------
INT 15 - APM SL Enhanced v1.0 - GET GLOBAL STANDBY TIMER
	AX = 5380h
	BH = 02h
Return: CF clear if successful
	SI:DI = timer count in seconds (actually 1.024 seconds)
Desc:	reads the value of 82360SL GSTDBY_TMRH & GSTDBY_TMRL registers
SeeAlso: AX=5380h/BH=00h,AX=5380h/BH=03h,AX=5380h/BH=04h,AX=5380h/BH=7Fh
--------p-155380BH03-------------------------
INT 15 - APM SL Enhanced v1.0 - SET GLOBAL STANDBY TIMER
	AX = 5380h
	BH = 03h
	SI:DI = timer count in seconds (actually 1.024 seconds)
Return: CF clear if successful
Desc:	sets the value of 82360SL GSTDBY_TMRH & GSTDBY_TMRL registers
Note:	the maximum timer count is 268431 seconds
SeeAlso: AX=5380h/BH=02h,AX=5380h/BH=7Fh
--------p-155380BH04-------------------------
INT 15 - APM SL Enhanced v1.0 - GET AUTO POWER OFF TIMER
	AX = 5380h
	BH = 04h
Return: CF clear if successful
	SI:DI = timer count in seconds (actually 1.024 seconds)
Desc:	reads the value of 82360SL APWR_TMRH & APWR_TMRL registers
SeeAlso: AX=5380h/BH=02h,AX=5380h/BH=05h,AX=5380h/BH=06h,AX=5380h/BH=7Fh
--------p-155380BH05-------------------------
INT 15 - APM SL Enhanced v1.0 - SET AUTO POWER OFF TIMER
	AX = 5380h
	BH = 05h
	SI:DI = timer count in seconds (actually 1.024 seconds)
Return: CF clear if successful
Desc:	sets the value of 82360SL APWR_TMRH & APWR_TMRL registers
Note:	the maximum timer count is 134213 seconds
SeeAlso: AX=5380h/BH=04h,AX=5380h/BH=7Fh
--------p-155380BH06-------------------------
INT 15 - APM SL Enhanced v1.0 - GET RESUME CONDITION
	AX = 5380h
	BH = 06h
Return: CF clear if successful
	    BL = resume condition (see #00482)
Desc:	reads the value of 82360SL RESUME_MASK register
SeeAlso: AX=5380h/BH=04h,AX=5380h/BH=07h,AX=5380h/BH=08h,AX=5380h/BH=7Fh

Bitfields for APM SL resume condition:
Bit(s)	Description	(Table 00482)
 7-2	reserved (0)
 1	alarm enabled (resume on CMOS alarm)
 0	ring enabled
--------p-155380BH07-------------------------
INT 15 - APM SL Enhanced v1.0 - SET RESUME CONDITION
	AX = 5380h
	BH = 07h
	BL = resume condition (see #00482)
Return: CF clear if successful
Desc:	sets the value of 82360SL RESUME_MASK register
SeeAlso: AX=5380h/BH=06h,AX=5380h/BH=7Fh
--------p-155380BH08-------------------------
INT 15 - APM SL Enhanced v1.0 - GET CALENDAR EVENT TIME
	AX = 5380h
	BH = 08h
Return: CF clear if successful
	    CH = hours
	    CL = minutes
	    SI = seconds
	CF set on error
	    AH = error code (see #00483)
Desc:	gets calendar event time from CMOS ram
SeeAlso: AX=5380h/BH=06h,AX=5380h/BH=09h,AX=5380h/BH=0Ah,AX=5380h/BH=7Fh

(Table 00483)
Values for APM SL error code:
 02h	no alarm set
 03h	no battery
--------p-155380BH09-------------------------
INT 15 - APM SL Enhanced v1.0 - SET CALENDAR EVENT TIME
	AX = 5380h
	BH = 09h
	CH = hours
	CL = minutes
	SI = seconds
Return: CF clear if successful
	CF set on error
	    AH = error code (see #00483)
Desc:	sets calendar event time in CMOS ram, enables Alarm resume
SeeAlso: AX=5380h/BH=08h,AX=5380h/BH=7Fh
--------p-155380BH0A-------------------------
INT 15 - APM SL Enhanced v1.0 - GET CALENDAR EVENT DATE
	AX = 5380h
	BH = 0Ah
Return: CF clear if successful
	    SI = century
	    DI = year
	    CH = month
	    CL = day
	CF set on error
	    AH = error code (see #00483)
Desc:	reads calendar event date from Extended CMOS ram
SeeAlso: AX=5380h/BH=08h,AX=5380h/BH=0Bh,AX=5380h/BH=0Ch,AX=5380h/BH=7Fh
--------p-155380BH0B-------------------------
INT 15 - APM SL Enhanced v1.0 - SET CALENDAR EVENT DATE
	AX = 5380h
	BH = 0Bh
	SI = century
	DI = year
	CH = month
	CL = day
Return: CF clear if successful
	CF set on error
	    AH = error code (see #00483)
Desc:	sets calendar event date in Extended CMOS ram
SeeAlso: AX=5380h/BH=0Ah,AX=5380h/BH=7Fh
--------p-155380BH0C-------------------------
INT 15 - APM SL Enhanced v1.0 - GET CPU SPEED MODE
	AX = 5380h
	BH = 0Ch
Return: CF clear if successful
	CL = CPU clock divider (1,2,4 or 8)
	BL = autocpumode ???
Desc:	reads bits 4-5 of CPUPWRMODE register
SeeAlso: AX=5380h/BH=0Ah,AX=5380h/BH=0Dh,AX=5380h/BH=7Fh
--------p-155380BH0D-------------------------
INT 15 - APM SL Enhanced v1.0 - SET CPU SPEED MODE
	AX = 5380h
	BH = 0Dh
	CL = CPU clock divider (1,2,4 or 8)
	BL = autocpumode ???
Return: CF clear if successful
Desc:	writes bits 4-5 of CPUPWRMODE register
SeeAlso: AX=5380h/BH=0Ch,AX=5380h/BH=7Eh,AX=5380h/BH=7Fh
--------p-155380BH7E-------------------------
INT 15 - APM SL Enhanced v1.0 - SL HW PARAMETER
	AX = 5380h
	BH = 7Eh
Return: AL = ???
	    03h on A-Step 386SL BIOSes
	    12h on later steps
	BX = Control port (00B0h)
SeeAlso: AX=5380h/BH=00h,AX=5380h/BH=7Fh
--------p-155380BH7F-------------------------
INT 15 - Advanced Power Management v1.1 - OEM APM INSTALLATION CHECK
	AX = 5380h
	BH = 7Fh
Return: CF clear if successful
	    BX = OEM identifier
	    all other registers OEM-defined
	    ---Intel SL Enhanced Option BIOS---
	    BX = 534Ch ('SL')
	    CL = 4Fh ('O')
	    AL = version (10h = 1.0)
	    ---HP APM BIOS---
	    BX = 4850h ('HP')
	    CX = version (0001h)
	CF set on error
	    AH = error code (03h) (see #00473)
SeeAlso: AX=5380h/BH=00h
--------p-155380-----------------------------
INT 15 - Advanced Power Management v1.1 - OEM APM FUNCTIONS
	AX = 5380h
	BH <> 7Fh
	all other registers OEM-defined
Return: OEM-defined
SeeAlso: AX=5380h/BH=7Fh
--------p-155380BX8000-----------------------
INT 15 U - Phoenix BIOS 4.0 Rel 6.0 - ???
	AX = 5380h
	BX = 8000h
	CX = 0020h
Return: ???
Note:	although a check for the indicated value is present in the examined
	  copy of the BIOS, no code was associated with it (possibly an OEM
	  option not included in that copy) and this function always returns
	  CF set/AH=03h if CX=0020h and CF set/AH=86h for CX<>0020h
SeeAlso: AX=5380h/BX=8001h
--------p-155380BX8001-----------------------
INT 15 U - Phoenix BIOS 4.0 Rel 6.0 - ???
	AX = 5380h
	BX = 8001h
	CX = 0020h
Return: ???
Note:	although a check for the indicated value is present in the examined
	  copy of the BIOS, no code was associated with it (possibly an OEM
	  option not included in that copy)
SeeAlso: AX=5380h/BX=8000h
--------X-1553B0BH00-------------------------
INT 15 - Intel System Management Bus - RESERVED
	AX = 53B0h
	BH = 00h
Program: the SMBus is a variant of ACCESS.bus being used by Intel and Duracell
	  for the Smart Battery proposal, but designed to be generic enough to
	  handle other devices besides batteries
--------X-1553B0BH01-------------------------
INT 15 - Intel System Management Bus - INSTALLATION CHECK
	AX = 53B0h
	BH = 01h
	BL = 72h ('r')
	CX = 6164h ('ad')
Return: CF clear if installed
	    AH = SMBus BIOS Interface Specification major version (01h)
	    AL = SMBus BIOS Interface Specification minor version (00h)
	    BL = number of SMBus devices present
	    CX = 6941h ('iA')
	    DX = vendor-specified SMBus hardware code
		0000h means undefined hardware type
	CF set if error
	    AH = Error code 0Ah, 86h (see #00484)
Note:	this function is only supported in INT 15h mode
SeeAlso: AX=53B0h/BH=02h,AX=53B0h/BH=03h,AX=53B0h/BH=04h,AX=53B0h/BH=06h
SeeAlso: #01105 at INT 1A/AX=B10Ah/SF=8086h

(Table 00484)
Values for Intel System Management Bus error codes:
 00h	SMBus OK
 01h	SMBus connect failed
 02h	SMBus already connected (see also #00485)
 03h	SMBus disconnect failed
 04h	SMBus not connected
 05h	SMBus INT 15 interface disabled
 06h	SMBus device address request out of range
 07h	SMBus unknown failure
 08h	SMBus message list empty
 09h	SMBus message list overflow
 0Ah	SMBus invalid signature
 10h	SMBus device address not acknowledged
 11h	SMBus device error detected
 12h	SMBus device command access denied
 13h	SMBus unknown error
 14h	SMBus transaction pending
 15h	SMBus no transaction pending
 16h	SMBus request does not match pending transaction
 17h	SMBus device access denied
 18h	SMBus timeout
 19h	SMBus protocol not supported
 1Ah	SMBus busy
 1Bh	SMBus SMI detected
 80h	SMBus OK (previously unreported SMI occurred)
 86h	SMBus not supported

(Table 00485)
Values for Intel System Management Bus Already Connected sub-error codes:
 01h	real mode connect already established
 02h	16-bit PMode connect already established
 03h	32-bit PMode connect already established
SeeAlso: #00484
--------X-1553B0BH02-------------------------
INT 15 - Intel System Management Bus - REAL MODE CONNECT
	AX = 53B0h
	BH = 02h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AX = SMBus Real mode code segment
	    BX = offset of entry point into SMBus BIOS Interface
	    CX = SMBus Real mode data segment
	CF set if error
	    AH = error code (01h,02h,0Ah,86h) (see #00484)
	    AL = sub-error code if error code is 02h (see #00485)
Desc:	connect to SMBus interface; once connected, all SMBus calls are made
	  to the supplied entry point instead of INT 15 (with registers
	  identical to those described here for INT 15)
Notes:	Support for this function is optional
	this function is only supported in INT 15 mode when implemented
SeeAlso: AX=53B0h/BH=01h,AX=53B0h/BH=03h,AX=53B0h/BH=04h,AX=53B0h/BH=05h
--------X-1553B0BH03-------------------------
INT 15 - Intel System Management Bus - 16-BIT PROTECTED-MODE CONNECT
	AX = 53B0h
	BH = 03h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AX = SMBus 16-bit code segment (real mode base address)
	    BX = offset of entry point into SMBus BIOS Interface
	    CX = SMBus 16-bit data segment (real mode base address)
	    SI = code segment length in bytes
	    DI = data segment length in bytes
	CF set if error
	    AH = error code (01h,02h,0Ah,86h) (see #00484)
	    AL = sub-error code if error code is 02h (see #00485)
Desc:	connect to SMBus interface; once connected, all SMBus calls are made
	  to the supplied entry point instead of INT 15 (with registers
	  identical to those described here for INT 15)
Notes:	before calling the entry point, two descriptors must be initialized
	  in the GDT or LDT.  They must be consecutive and be in the order of
	  code, then data.  At the time	of the call, the descriptors must be
	  valid and have CPL=0.
	the code descriptor must be ring-0 privilege
	this function is only supported in INT 15 mode
SeeAlso: AX=53B0h/BH=01h,AX=53B0h/BH=02h,AX=53B0h/BH=04h,AX=53B0h/BH=05h
--------X-1553B0BH04-------------------------
INT 15 - Intel System Management Bus - 32-BIT PROTECTED-MODE CONNECT
	AX = 53B0h
	BH = 04h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AX = SMBus 32-bit code segment (real mode base address)
	    EBX = offset of entry point into SMBus BIOS Interface
	    CX = SMBus 16-bit code segment (real mode base address)
	    DX = SMBus data segment (real mode base address)
	    SI = code segment length in bytes
	    DI = data segment length in bytes
	CF set if error
	    AH = error code (01h,02h,0Ah,86h) (see #00484)
	    AL = sub-error code if error code is 02h (see #00485)
Desc:	connect to SMBus interface; once connected, all SMBus calls are made
	  to the supplied entry point instead of INT 15 (with registers
	  identical to those described here for INT 15)
Notes:	before calling the entry point, two descriptors must be initialized in
	  the GDT or LDT.  They must be consecutive and be in the order of
	  32-bit code, 16-bit code, then data.	At the time of the call, the
	  descriptors must be valid and have CPL=0.
	the code descriptors must be ring-0 privilege
	this function is supported only in INT 15 mode
SeeAlso: AX=53B0h/BH=01h,AX=53B0h/BH=02h,AX=53B0h/BH=03h,AX=53B0h/BH=05h
--------X-1553B0BH05-------------------------
INT 15 - Intel System Management Bus - DISCONNECT
	AX = 53B0h
	BH = 05h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	CF set if error
	    AH = error code (03h,04h,05h,0Ah,86h) (see #00484)
Note:	this function is supported in connected mode (far CALL entry point)
	  only
SeeAlso: AX=53B0h/BH=01h,AX=53B0h/BH=02h,AX=53B0h/BH=03h,AX=53B0h/BH=04h
--------X-1553B0BH06-------------------------
INT 15 - Intel System Management Bus - GET DEVICE ADDRESSES
	AX = 53B0h
	BH = 06h
	BL = position in list to report
	CH = 6941h ('iA')
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	    BH = number of SMBus devices
	    BL = SMBus Device Address of device at position BL in list
		(see #00486)
	CF set if error
	    AH = error code (06h,0Ah,86h) (see #00484)
Desc:	retrieves already assigned SMBus device addresses
Notes:	this function is supported in INT 15h mode only
	bit 0 of the device address indicates read/write, so a device may
	  be listed at both xxxxxxx0b and xxxxxxx1b
SeeAlso: I2C A0h [and I2C.LST in general]

(Table 00486)
Values for System Management Bus predefined device addresses:
 10h	SMBus host
 12h	Smart Battery charger
 14h	Smart Battery selector
 16h	Smart Battery
 18h	SMBus Alert response
 50h	ACCESS.bus host
 58h	LCD contrast controller
 5Ah	CCFL backlight driver
 6Eh	ACCESS.bus default address
 80h-86h PCMCIA socket controllers
 88h	VGA graphics controller
 90h-96h unrestricted addresses
 82h	SMBus device default address
--------X-1553B0BH07-------------------------
INT 15 - Intel System Management Bus - RETRIEVE CRITICAL MESSAGES
	AX = 53B0h
	BH = 07h
	CX = 6941h ('iA')
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	    AL = device address
	    BX = device message
	CF set if error
	    AH = error code (05h,07h,08h,09h,0Ah,86h) (see #00484)
Desc:	retrieves oldest queued critical message from an SMBus device to the
	  host
Notes:	up to five messages are queued; if the queue is full, messages will be
	  lost and error 09h returned
--------X-1553B0BH08-------------------------
INT 15 - Intel System Management Bus - RESERVED
	AX = 53B0h
	BH = 08h-0Fh
--------X-1553B0BH10-------------------------
INT 15 - Intel System Management Bus - REQUEST
	AX = 53B0h
	BH = 10h
	BL = protocol (see #00487)
	CH = device address
	CL = device command (see #00488)
	DH = MSB Data or block length (for BlockWrite)
	DL = LSB Data or first byte of block (for BlockWrite)
Return: CF clear if successful
	    AH = 00h or 80h (SMBus OK)
		 (80h indicates a previously unreported SMI took place)
	CF set if error
	    AH = error code (05h,10h,11h,12h,13h,14h,17h,19h,1Ah,86h)
		  (see #00484)
Desc:	request access to a device on the SMBus
SeeAlso: AX=53B0h/BH=11h, AX=53B0h/BH=13h

(Table 00487)
Values for Intel System Management Bus protocol codes:
 00h	Quick Command
 01h	Send Byte
 02h	Receive Byte
 03h	Write Byte
 04h	Read Byte
 05h	Write Word
 06h	Read Word
 07h	Block Write
 08h	Block Read
 09h	Process Call
 0Ah-FFh reserved
SeeAlso: #00488

(Table 00488)
Values for Intel System Management Bus Smart Battery command codes:
 Cmd	Protocol(s)	Description
 00h	Rd/Wr Word	"ManufacturerAccess" implementation-specific
 01h	Rd/Wr Word	get/set Low Capacity Alarm threshold
 02h	Rd/Wr Word	get/set Remaining Time Alarm value (in minutes)
 03h	Rd/Wr Word	get/set battery characteristics (see #00489)
 04h	Rd/Wr Word	"AtRate" indicate charge/discharge rate
 05h	Read Word	"AtRateTimeToFull" time to completely charge (in min.)
 06h	Read Word	"AtRateTimeToEmpty" time to entirely discharge (min.)
 07h	Read Word	"AtRateOK" boolean: can battery supply another 10sec?
 08h	Read Word	internal battery temperature (in 0.1 Kelvins)
 09h	Read Word	current battery voltage in millivolts
 0Ah	Read Word	current flowing through battery in milliamperes
			(positive if charging, negative if discharging)
 0Bh	Read Word	average current over the past minute
 0Ch	Read Word	expected error margin in capacity computations in %
 0Dh	Read Word	predicted remaining charge as % of full charge
 0Eh	Read Word	predicted remaining charge as % of design capacity
 0Fh	Read Word	predicted remaining charge in mAh or 10mWh
 10h	Read Word	predicted full charge capacity in mAh or 10mWh
 11h	Read Word	predicted remaining battery life in minutes
			FFFFh = not discharging
 12h	Read Word	rolling average of predicted life over past minute
 13h	Read Word	rolling average of predicted charge time over past min.
			FFFFh = not charging
 14h	Read Word	get battery's desired charging current in mA
 14h	Write Word	set charging current in mA
 15h	Read Word	get battery's desired charging current in mV
 15h	Write Word	set desired charging voltage in mV
 16h	Read Word	get current battery status (see #00490)
 17h	Read Word	get number of charge/discharge cycles for battery
 18h	Read Word	get design capacity in mAh or 10mWh
 19h	Read Word	get design voltage
 1Ah	Read Word	get specification information (see #00491)
 1Bh	Read Word	get manufacture date (see #01665 at INT 21/AX=5700h)
 1Ch	Read Word	get serial number
 1Dh-1Fh		reserved
 20h	Read Block	get manufacturer's name
 21h	Read Block	get device name
 22h	Read Block	get device chemistry (see #00492)
 23h	Read Block	get manufacturer data
 24h-2Eh		reserved
 2Fh			manufacturer-specific
 30h-3Bh		reserved
 3Ch-3Fh		manufacturer-specific
Note:	bits 7-6 are reserved for addressing multiple batteries in a future
	  version of the specification
SeeAlso: #00487

Bitfields for Smart Battery battery characteristics:
Bit(s)	Description	(Table 00489)
 0	battery has internal charge controller (read-only)
 1	primary/secondary battery support (read-only)
 6-2	reserved
 7	conditioning cycle requested
 8	internal charge controller enabled
 9	battery operating in primary mode
 13-10	reserved
 14	disable broadcast to charger
 15	report capacity in units of 10mW / 10mWh instead of mA / mAh
SeeAlso: #00488,#00490

Bitfields for Smart Battery battery status:
Bit(s)	Description	(Table 00490)
 15	overcharged
 14	terminate-charge alarm
 13	reserved
 12	over-temperature alarm
 11	terminate-discharge alarm
 10	reserved
 9	remaining-capacity alarm
 8	remaining-time alarm
 7	initialized
 6	charging
 5	fully charged
 4	fully discharged
 3-0	error codes
	0000 OK
	0001 busy
	0010 reserved command
	0011 unsupported command
	0100 access denied (tried to write to read-only value)
	0101 overflow/underflow
	0110 bad size
	0111 unknown error
SeeAlso: #00488,#00489,#00491

Bitfields for Smart Battery specification information:
Bit(s)	Description	(Table 00491)
 3-0	SmartBattery specification minor revision number
 7-4	SmartBattery specification version number
 11-8	voltage scaling (0-3, multiply voltages by 10^scale)
 15-12	current scaling (0-3, multiply currents by 10^scale)
SeeAlso: #00488,#00490

(Table 00492)
Values for Smart Battery device chemistry (not case-sensitive):
 "LION"	Lithium ion
 "NiMH"	Nickel metal hydride
 "PbAc"	lead-acid
 "NiCd" Nickel Cadmium
 "NiZn" Nickel Zinc
 "RAM"	rechargeable Alkaline Manganese
 "ZnAr" Zinc-Air
SeeAlso: #00488
--------X-1553B0BH11-------------------------
INT 15 - Intel System Management Bus - REQUEST CONTINUATION
	AX = 53B0h
	BH = 11h
	BL = protocol (see #00487)
	CH = device address
	CL = number of valid bytes in DX (1 or 2)
	DH = MSB Data (CL = 1 or 2)
	DL = LSB Data (CL = 2)
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	    CL = SMBus status
		00h SMBus hardware not ready for more data
		01h SMBus hardware ready for 2 more data bytes
	CF set if error
	    AH = error code (05h,11h,13h,15h,16h,18h,1Bh,86h) (see #00484)
Desc:	continue WriteBlock protocol started with function 10h
SeeAlso: AX=53B0h/BH=10h, AX=53B0h/BH=13h
--------X-1553B0BH12-------------------------
INT 15 - Intel System Management Bus - REQUEST ABORT
	AX = 53B0h
	BH = 12h
	BL = protocol (see #00487)
	CH = device address
	CL = device command
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	CF set if error
	    AH = error code (05h,13h,15h,16h,86h) (see #00484)
Desc:	stop the currently pending SMBus request; usually used to terminate
	  a request after an SMI Detected error
--------X-1553B0BH13-------------------------
INT 15 - Intel System Management Bus - REQUEST DATA AND STATUS
	AX = 53B0h
	BH = 13h
	BL = protocol (see #00487)
	CH = device address
	CL = device command
Return: CF clear if successful
	    AH = 00h (SMBus OK)
	    CH = status
		00h no data pending, transaction complete
		01h no data pending, transaction continues
		02h data pending
	    CL = number of valid bytes in DX (0-2)
	    DH = MSB data
	    DL = LSB data
	CF set if error
	    AH = error code (05h,10h,11h,13h,15h,16h,18h,1Bh,86h) (see #00484)
Desc:	determine when a transaction is complete, gather data returned by read
	  transactions
Note:	for Block Read protocol (08h), first call returns block	length in DH
	  and the first byte of the block in DL
----------1554-------------------------------
INT 15 - IBM SurePath BIOS - Officially "Private" Function
	AH = 54h
SeeAlso: AH=07h"IBM",AH=3Eh"IBM"
--------T-155400-----------------------------
INT 15 C - Omniview Multitasker - INSTALLATION NOTIFICATION
	AX = 5400h
	ES:BX -> device information tables
	DI:DX -> dispatcher entry point
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5407h,INT 2F/AX=DE00h
--------T-155401-----------------------------
INT 15 C - Omniview Multitasker - PROCESS CREATION
	AX = 5401h
	ES:BX = process handle
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5402h,INT 2F/AX=DE04h
--------T-155402-----------------------------
INT 15 C - Omniview Multitasker - PROCESS DESTRUCTION
	AX = 5402h
	ES:DX = process handle
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5401h,INT 2F/AX=DE05h
--------T-155403-----------------------------
INT 15 C - Omniview Multitasker - SAVE
	AX = 5403h
	ES:DX = process swapping out
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5404h,INT 2F/AX=DE08h
--------T-155404-----------------------------
INT 15 C - Omniview Multitasker - RESTORE
	AX = 5404h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5403h,INT 2F/AX=DE09h
--------T-155405-----------------------------
INT 15 C - Omniview Multitasker - SWITCHING TO BACKGROUND
	AX = 5405h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5406h
--------T-155406-----------------------------
INT 15 C - Omniview Multitasker - SWITCHING TO FOREGROUND
	AX = 5406h
	ES:DX = process swapping in
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5405h
--------T-155407-----------------------------
INT 15 C - Omniview Multitasker - EXIT NOTIFICATION
	AX = 5407h
Note:	called by OmniView to notify programs loaded before OmniView of state
	  changes inside OmniView
SeeAlso: AX=5400h,INT 2F/AX=DE03h
--------V-155F31-----------------------------
INT 15 C - Chips & Technologies '65530' BIOS - POST INITIALIZATION NOTIFICATION
	AX = 5F31h
Return:	nothing
Desc:	this function is called after the video BIOS completes power-up
	  initialization and just prior to displaying the sign-on message
SeeAlso: AX=5F33h,AX=5F35h,INT 10/AX=5F50h
--------V-155F33-----------------------------
INT 15 C - Chips & Technologies '65530' BIOS - MODE SET HOOK
	AX = 5F33h
	BL = current width in characters
	BH = curent video mode
	CH = active display page
Return:	nothing
Desc:	this function is called at the end of a video mode set
Note:	the OEM has the option of enabling or disabling this callout, as well
	  as specifying whether the callout occurs on INT 15h or INT 42h
SeeAlso: AX=5F31h,AX=5F35h,INT 10/AX=5F50h,INT 42/AX=5F33h
--------V-155F35-----------------------------
INT 15 C - Chips & Technologies '65530' BIOS - MONITOR SENSING HOOK
	AX = 5F35h
Return:	DL = boot display
	    00h CRT
	    01h flat panel (LCD)
	    02h both simultaneously
	    leave unchanged to boot according to BIOS settings
SeeAlso: AX=5F31h,AX=5F33h,INT 10/AX=5F50h
--------b-1560------------------------------------
INT 15 - HUNTER 16 - SET SYSTEM CLOCK SPEED
	AH = 60h
	AL = new speed
	    00h normal (8 MHz)
	    01h Slow Mode 1 (4 MHz)
	    02h Slow Mode 2 (2 MHz)
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
SeeAlso: AX=6301h
--------p-156000-----------------------------
INT 15 U - HP 100LX/200LX - GET MAIN BATTERY LEVEL
	AX = 6000h
Return: AX = battery level
Note:	multiply the returned value with 1Bh and add 622h to get millivolts
SeeAlso: AX=6001h,AX=6002h,AX=6003h,AX=6004h
--------p-156001-----------------------------
INT 15 U - HP 100LX/200LX - GET BACKUP BATTERY LEVEL
	AX = 6001h
Return: AX = battery level
Note:	multiply the returned value with 1Bh and add 622h to get millivolts
SeeAlso: AX=6000h,AX=6002h
--------p-156002-----------------------------
INT 15 U - HP 100LX/200LX - GET POWER INFO
	AX = 6002h
Return: AL = power settings (see #00493)
SeeAlso: AX=6000h,AX=6003h,AX=6004h

Bitfields for power settings:
Bit(s)	Description	(Table 00493)
 0-1	unused ???
 2	card battery status low (OK if bit clear)
 3	battery charging off (disabled if bits 3-5 clear)
 4	battery charging slow
 5	battery charging fast
 6	power adaptor active
 7	battery type NiCad (alkaline if bit clear)
--------p-156003-----------------------------
INT 15 U - HP 100LX/200LX - SET MAIN BATTERY TYPE
	AX = 6003h
	BL = battery type
	    00h alkaline
	    01h NiCad
SeeAlso: AX=6000h,AX=6004h
--------p-156004-----------------------------
INT 15 U - HP 100LX/200LX - SET BATTERY CHARGING MODE
	AX = 6004h
	BL = charging
	    00h disabled
	    01h enabled
SeeAlso: AX=6000h,AX=6003h
--------b-1561------------------------------------
INT 15 - HUNTER 16 - GET POWER LEVEL
	AH = 61h
Return: AH = percentage of full power left (0..100)
Desc:	determine how much battery power is left
SeeAlso: AH=62h,AH=66h,AH=73h"HUNTER"
--------b-1561-------------------------------
INT 15 U - HP 100LX/200LX - SET ANNOUNCIATORS POSITION
	AH = 61h
	AL = position (20h = left, 60h = right)
Note:	The announciators are the indicator symbols for the Shift and Fn keys
	  in the bottom line
SeeAlso: AH=62h"HP",INT 16/AH=02h
--------b-1562------------------------------------
INT 15 - HUNTER 16 - SET LOW POWER THRESHOLD
	AH = 62h
	AL = level (00h 5%, 01h 10%, ... 12h 95%)
	BX = interval between power low warnings in seconds (1..600)
Return: AH = Status
Desc:	set the level (relative to full power) when power-low warnings begin
	  and the interval between the warnings
SeeAlso: AH=61h,AH=65h,AH=66h
--------b-1562-------------------------------
INT 15 U - HP 100LX/200LX - SET DISPLAY CONTRAST
	AH = 62h
	BL = contrast (00h-1Fh, 1Fh is the darkest)
SeeAlso: AH=47h"HP",AH=61h"HP"
--------b-156300----------------------------------
INT 15 - HUNTER 16 - GET IDLE TIMEOUT
	AX = 6300h
Return: AH = status
	BX = timeout in seconds (0-3600)
Desc:	get the idle timeout value, the interval without keyboard or
	   communications activity before the system shuts down
SeeAlso: AX=6301h
--------b-156301----------------------------------
INT 15 - HUNTER 16 - SET IDLE TIMEOUT
	AX = 6301h
	BX = timeout in seconds (0-3600)
Desc:	sets the idle timeout value, the interval without keyboard or
	  communications activity before the system shuts down
SeeAlso: AX=6300h
--------b-1564------------------------------------
INT 15 - HUNTER 16 - CONTROL RESUME MODE
	AH = 64h
	AL = new state
	    00h disable Resume mode
	    01h enable Resume mode
Return: AH = status
Desc:	turn Resume mode on or off. In Resume mode the system starts in
	  the application that was running when it shut down as if nothing
	  had happened.
SeeAlso: AH=67h,AH=68h,AH=69h
--------b-1565------------------------------------
INT 15 - HUNTER 16 - AUTHORISE CHARGING
	AH = 65h
	AL = charging level
	    01h charging not allowed
	    02h charging allowed until power down
	    03h charging allowed until batteries changed or fail.
		Ask user if charging is still allowed on next poweron
	    04h charging allowed indefinitely
	BX = 0203h
	CX = 0405h
	DX = 0607h
Return: AH = status
SeeAlso: AH=66h,AH=68h
--------b-1566------------------------------------
INT 15 - HUNTER 16 - SET BATTERY LEVEL
	AH = 66h
	AL = level in percent of maximum (0..100)
Return: AH = status
SeeAlso: AH=61h,AH=65h
--------b-1567------------------------------------
INT 15 - HUNTER 16 - CONTROL STOP MODE
	AH = 67h
	AL = mode when waiting for input
	    00h use STOP mode (allows communication)
	    01h use HALT mode (disallows communication)
Return: AH = status
Desc:	select the power save mode to use when waiting for input
SeeAlso: AH=69h
----------156700BXFFFF-----------------------
INT 15h - Arabic/Hebrew MS-DOS 5.0???+ - INSTALLATION CHECK
	AX = 6700h
	BX = FFFFh
Return: BX = FFFFh (Arabic/Hebrew MS-DOS not installed)
	BX = version (e.g. 0101h for Arabic/Hebrew MS-DOS 5.0)
Note:	This call is made by the SK_HGC.COM TSR for HGC and HGC/RAMFont
	  graphics adapters to ensure it runs on the correct version of
	  Arabic or Hebrew MS-DOS.
	The function is probably implemented in the ARABIC.COM/HEBREW.COM
	  driver.
	Arabic/Hebrew versions of MS-DOS 3.3 existed, but no details are
	  available.
SeeAlso: AX=67C3h,INT 2F/AX=AD41h
----------1567C3CX1Bh
-----------------------
INT 15h - Arabic/Hebrew MS-DOS 5.0???+ - HGC & HGC/RAMFont support???
	AX = 67C3h
	CX = 1Bh
	CS|DS???:SI -> buffer
Return: ES:DI -> ???
	AX = ???
Program: The SK_HGC.COM TSR is used to support operation of ARABIC.COM/
	  HEBREW.COM with the Hercules Graphic Card series of video adapters.
	  It is provided for compatibility with ADOS 3.30/HDOS 3.30 only.
	  This file must be loaded immediately after ARABIC.COM/HEBREW.COM
	  to insure correct operation with these devices.
Notes:	This call is made by the SK_HGC.COM TSR for HGC and HGC/RAMFont
	  graphics adapters when it has successfully detected an Arabic/Hebrew
	  issue of MS-DOS via INT15h/6700h/BX=FFFFh to ensure it runs on the
	  correct version of Arabic or Hebrew MS-DOS.
	At some unknown offset in the buffer it contains a flag indicating
	  if a HGC or HGC/RAMFont adapter is present or not.
	ARABIC/HEBREW does not operate with Monochrome Display Adapters (MDA)
	  and the Hercules Graphic Card Plus (HGC+). ARABIC/HEBREW does operate
	  with Hercules Graphic Card (HGC) with a burnt-in ROM/EPROM font (many
	  HGC cards, even the highly integrated ones, allow for this kind of
	  user customization), though this is not officially supported.
	In some pre-1987 IBM XT/AT and compatibles, the Hercules Graphic
	  Card Plus operates like a MDA card. This hardware limitation
	  prevents ARABIC/HEBREW from running on this combination of hardware.
SeeAlso: AX=6700h
--------b-1568------------------------------------
INT 15 - HUNTER 16 - REQUEST POWER DOWN
	AH = 68h
Desc:	turns off the Hunter 16 if power down is allowed (see AH=69h)
SeeAlso: AH=69h
--------b-1569------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER DOWN AVAILABILITY
	AH = 69h
	AL = mode
	    00h inhibit power down
	    01h allow power down
Return: AH = status
SeeAlso: AH=67h,AH=68h,AH=6Ah
--------b-156A------------------------------------
INT 15 - HUNTER 16 - CONTROL SLOW MODE
	AH = 6Ah
	AL = mode
	    00h inhibit Slow mode
	    01h allow Slow mode
Return: AH = status
SeeAlso: AH=69h
--------b-156B------------------------------------
INT 15 - HUNTER 16 - GET ROM BIOS VERSION
	AH = 6Bh
Return: BH = version number (ASCII)
	BL = release number (ASCII)
	CH = major??? release number (ASCII)
	CL = minor??? release number (ASCII)
SeeAlso: AH=6Ch
--------b-156C------------------------------------
INT 15 - HUNTER 16 - GET SERIAL NUMBER
	AH = 6Ch
Return: BL:CX = BCD serial number
Note:	when shipped, all Hunter 16s have the same Serial Number, but a
	  different number can be stored (see AH=72h)
SeeAlso: AH=6Bh,AH=72h
--------b-156D------------------------------------
INT 15 - HUNTER 16 - GET EVENT DETAIL
	AH = 6Dh
Return: AH = 00h if successful
	CX:BX = event flags bit 0..31 (see #00494)
Note:	this function allows testing for events
SeeAlso: AH=6Eh,AH=6Fh

Bitfields for HUNTER 16 events:
Bit(s)	Description	(Table 00494)
 6	RI received
 5	RTC Alarm
 4	data received on COM2
 3	data received on COM1
 2	error on COM2
 1	error on COM1
 0	PWR button pressed
--------b-156E------------------------------------
INT 15 - HUNTER 16 - ENABLE/TRAP EVENT
	AH = 6Eh
	AL = Software Interrupt
	      00h  do not trap event
	      else trap as software interrupt number AL
	BH = event number (see AH=6Dh)
	BL = enable mask
	    00h disable event
	    01h enable event
Return: AH = 00h if successful
SeeAlso: AH=6Dh,AH=6Fh
--------b-156F------------------------------------
INT 15 - HUNTER 16 - ACKNOWLEDGE EVENT
	AH = 6Fh
	AL = event number (see AH=6Dh)
Return: AH = 00h if successful
Desc:	Acknowledges the event, so the next similar event can be detected
SeeAlso: AH=6Dh"HUNTER",AH=6Eh
--------b-1570------------------------------------
INT 15 - HUNTER 16 - CONTROL SOUND
	AH = 70h
	AL = new state
	    00h disable sound
	    else enable sound
Note:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
--------x-157000-----------------------------
INT 15 - Tandy 1000SL/TL - READ FROM EEPROM
	AX = 7000h
	BL = number of word to read (00h-3Fh)
Return: CF clear if function supported
	    DX = contents of EEPROM word
Note:	newer Tandy 1000-series machines use EEPROM instead of CMOS RAM in
	  the clock chip to store system configuration information
SeeAlso: AX=7001h
--------x-157001-----------------------------
INT 15 - Tandy 1000SL/TL - WRITE TO EEPROM
	AX = 7001h
	BL = number of word to read (00h-3Fh)
	DX = new value for EEPROM word
Return: CF clear if function supported
Note:	the EEPROMs are normally written only by the system setup program;
	  changing the values can badly mess up a Tandy
SeeAlso: AX=7000h
----------157002-----------------------------
INT 15 U - Tandy 1000 Model ??? - GET ROM PAGE
	AX = 7002h
Return: AL = ROM page mapped at 0E0000h (0-6 (13?))
Note:	some Tandy machines have DOS and DeskMate in a 512k paged ROM.	The
	  BIOS uses this call to determine what ROM page is mapped in the 64k
	  segment at 0E0000h.
	the 1000TL has 8 64k ROM pages; page 7 is permanently mapped at
	  0F0000h.  There may be 16 32k ROM pages on other systems.
SeeAlso: AX=7003h,INT E0"DeskMate"
----------157003-----------------------------
INT 15 U - Tandy 1000 Model ??? - SET ROM PAGE
	AX = 7003h
	DL = ROM page to be mapped at 0E0000h (0-6 (13?))
Return: CF clear if valid ROM page specified
Note:	Some Tandy machines have DOS and DeskMate in a 512k paged ROM.	The
	  BIOS uses this call to map ROM pages in the 64k segment at 0E0000h.
	The 1000TL has 8 64k ROM pages; page 7 is permanently mapped at
	  0F0000h.  There may be 16 32k ROM pages on other systems.
SeeAlso: AX=7002h,INT E0"DeskMate"
--------b-1571------------------------------------
INT 15 - HUNTER 16 - SELECT POWER UP KEYS
	AH = 71h
	BL = column
	BH = row
	AL = column switch (00h disable, 01h enable)
	CL = row switch (00h disable, 01h enable)
Return: AH = status
SeeAlso: AH=7Bh,AH=88h
--------b-157200----------------------------------
INT 15 - HUNTER 16 - RESET SERIAL NUMBER
	AX = 7200h
Return: AH = 00h if successful
Desc:	reset the serial number to the default serial number present when the
	  Hunter 16 was shipped
SeeAlso: AH=6Ch,AH=72h
--------b-1572------------------------------------
INT 15 - HUNTER 16 - REDIRECT SERIAL NUMBER
	AH = 72h
	AL nonzero
	DS:BX -> new serial number (6 ASCII digits)
Return: AH = 00h if successful
Desc:	install a new serial number
SeeAlso: AH=6Ch,AX=7200h
--------b-1573------------------------------------
INT 15 - HUNTER 16 - GET ORACLE GT POWER LEVEL
	AH = 73h
	AL = drive (0: A:, 1: B:)
Return: AH = status
	    00h successful
	    FFh Oracle GT drive not connected
	AL = power level in percent of maximum (0..100)
Desc:	get the power remaining in the Oracle GT batteries
SeeAlso: AH=61h
--------b-1574------------------------------------
INT 15 - HUNTER 16 - SET BACKLIGHT POWER UP STATE
	AH = 74h
	AL = new level
	    01h off
	    02h unchanged
	    03h change level
		BL = desired level (00h-7Fh)
Return: AH = status
Desc:	select the backlight level to use when the Hunter is next turned on
SeeAlso: AH=64h,AH=75h,INT 10/AH=64h,INT 10/AH=78h
--------b-1575------------------------------------
INT 15 - HUNTER 16 - SET CONTRAST POWER UP STATE
	AH = 75h
	AL = new level
	    01h off
	    02h unchanged
	    03h change level
		BL = desired level (00h-7Fh)
Return: AH = status
Desc:	select the LCD contrast level to use when the Hunter is next turned on
SeeAlso: AH=63h,AH=74h
--------b-1576------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER SAVE
	AH = 76h
	BX = power save control (see #00495)
SeeAlso: AH=74h

Bitfields for HUNTER 16 power save control:
Bit(s)	Description	(Table 00495)
 0	power save enabled
 1	inhibit power save when waiting for COM1 data
 2	inhibit power save when waiting for COM2 data
 3	inhibit power save when waiting for data from barcode wand
 4	inhibit power up on timer tick
--------b-1579------------------------------------
INT 15 - HUNTER 16 - REDIRECT LPT1
	AH = 79h
	AL = port to which to redirect (00h COM1, 01h COM2)
--------b-157A------------------------------------
INT 15 - HUNTER 16 - INVOKE HOT KEY
	AH = 7Ah
Desc:	this function has the same effect as pressing the HOT key
SeeAlso: AH=7Bh
--------b-157B------------------------------------
INT 15 - HUNTER 16 - CONTROL HOT KEY
	AH = 7Bh
	AL = 00h prevent HOT key
	    else allow HOT key
Desc:	Allow or prevent the HOT key function which is used to examine and
	  change the Hunter setup
SeeAlso: AH=71h,AH=7Ah,AH=7Ch
--------b-157C------------------------------------
INT 15 - HUNTER 16 - CONTROL HOT KEY POWER OPTION
	AH = 7Ch
	AL = 00h prevent HOT key power option
	    else allow HOT key power option
Desc:	allow or prevent changing the power options
SeeAlso: AH=7Bh,AH=7Dh
--------b-157D------------------------------------
INT 15 - HUNTER 16 - OVERRIDE LOW POWER TURN OFF
	AH = 7Dh
	AL = 00h turn off after 10 warnings
	    else never turn off
Desc:	specify whether the Hunter 16 turns off after 10 low power warnings
SeeAlso: AH=7Ch
--------b-157E------------------------------------
INT 15 - HUNTER 16 - CONTROL BATTERY CHANGE FACILITIES (APM)
	AH = 7Eh
	AL = 00h do not prompt
	    else prompt
Desc:	select whether the user is prompted for the battery state if the
	  battery cap has been off when the system is turned on
SeeAlso: AH=7Fh
--------b-157F------------------------------------
INT 15 - HUNTER 16 - SET BATTERY TYPE (APM)
	AH = 7Fh
	AL = battery type
	    00h	 non-rechargeable
	    else rechargeable
SeeAlso: AH=7Eh
--------B-1580-------------------------------
INT 15 C - OS HOOK - DEVICE OPEN (AT,XT286,PS)
	AH = 80h
	BX = device ID
	CX = process ID
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see #00496)
Note:	this function should be hooked by a multitasker which wishes to keep
	  track of device ownership; the default BIOS handler merely returns
	  successfully
SeeAlso: AH=81h,AH=82h

(Table 00496)
Values for status:
 80h	invalid command (PC,PCjr)
 86h	function not supported (XT)
--------b-1580------------------------------------
INT 15 - HUNTER 16 - GET/SET BATTERY CAPACITY (APM)
	AH = 80h
	AL = function
	    00h get
		Return: AL = capacity (500mA + AL * 50mA, max 40 = 2500mA)
	    else set
		BL = battery capacity (same as AL above)
SeeAlso: AH=61h"HUNTER",AH=81h"HUNTER"
--------B-1581-------------------------------
INT 15 C - OS HOOK - DEVICE CLOSE
	AH = 81h
	BX = device ID
	CX = process ID
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see #00496)
Note:	this function should be hooked by a multitasker which wishes to keep
	  track of device ownership; the default BIOS handler merely returns
	  successfully
SeeAlso: AH=80h,AH=82h
--------b-1581------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER OUTPUT
	AH = 81h
	AL = new state of power output (00h off, nonzero on)
Desc:	turn the +5V low power output on or off
SeeAlso: AH=80h"HUNTER"
--------B-1582-------------------------------
INT 15 C - OS HOOK - PROGRAM TERMINATION
	AH = 82h
	BX = process ID
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see #00496)
Notes:	closes all devices opened by the given process ID with function 80h
	this function should be hooked by a multitasker which wishes to keep
	  track of device ownership; the default BIOS handler merely returns
	  successfully
SeeAlso: AH=80h,AH=81h
--------b-1582------------------------------------
INT 15 - HUNTER 16 - SOUND OUTPUT
	AH = 82h
	DX = length (duration in seconds = DX * 666670 / frequency)
	BX = pitch (see #00497)
Desc:	Sound the tone specified in BX for the duration in DX
SeeAlso: AX=1019h

(Table 00497)
Values for HUNTER 16 sound pitch:
BX(dec)	 Note	Frequency	BX(dec)	 Note	Frequency
  425	G	1568.000	 1515	A	 440.000
  451	F#	1479.503	 1605	G#	 415.307
  477	F	1396.900	 1701	G	 392.000
  506	E	1318.500	 1802	F#	 369.998
  536	D#	1244.523	 1909	F	 349.230
  568	D	1174.700	 2022	E	 329.630
  601	C#	1108.749	 2143	D#	 311.127
  637	C	1046.500	 2270	D	 293.660
  675	B	 958.770	 2405	C#	 277.183
  715	A#	 932.329	 2548	MID C	 261.630
  758	A	 880.000	 2700	B	 246.940
  803	G#	 830.609	 2860	A#	 233.081
  850	G	 783.990	 3030	A	 220.000
  901	F#	 739.990	 3210	G#	 207.654
  954	F	 698.460	 3401	G	 196.000
 1011	E	 659.260	 3604	F#	 184.996
 1071	D#	 622.257	 3818	F	 174.610
 1135	D	 587.330	 4045	E	 164.810
 1203	C#	 554.365	 4286	D#	 155.560
 1274	C	 523.250	 4540	D	 146.830
 1350	B	 493.880	 4668	C#	 142.827
 1430	A#	 466.162	 4803	C	 138.810
--------B-1583-------------------------------
INT 15 - BIOS - SET EVENT WAIT INTERVAL (AT,PS50+)
	AH = 83h
	AL = subfunction
	    00h set interval
		CX:DX = microseconds to delay
		ES:BX -> byte whose high bit is to be set at end of interval
	    01h cancel wait interval
Return: CF set on error or function already busy
	    AH = status
		80h invalid command (PC,PCjr)
		86h function not supported (XT and later)
	CF clear if successful
Notes:	the resolution of the wait period is 977 microseconds on many systems
	  because many BIOSes use the 1/1024 second fast interrupt from the AT
	  real-time clock chip which is available on INT 70
	IBM AT 1984/1/10 BIOS ignores AL and always performs subfunction 00h
SeeAlso: AH=41h,AH=86h,INT 70,MEM 0040h:0098h,MEM 0040h:009Ch
--------b-1583------------------------------------
INT 15 - HUNTER 16 - CONTROL SCREEN SYNCHRONISATION
	AH = 83h
	AL = state of LCD window (00h disabled, nonzero enabled)
Desc:	Enable/disable the facility where the displayed window tracks the
	  cursor output to keep the focus visible
--------B-1584-------------------------------
INT 15 - BIOS - JOYSTICK SUPPORT (XT after 1982/11/8,AT,XT286,PS)
	AH = 84h
	DX = subfunction
	    0000h read joystick switches
		Return: AL bits 7-4 = switch settings
	    0001h read positions of joysticks
		Return: AX = X position of joystick A
			BX = Y position of joystick A
			CX = X position of joystick B
			DX = Y position of joystick B
Return: CF set on error
	    AH = status (see #00496)
	CF clear if successful
Notes:	if no game port is installed, subfunction 0000h returns AL=00h (all
	  switches open) and subfunction 0001h returns AX=BX=CX=DX=0000h
	a 250kOhm joystick typically returns 0000h-01A0h
SeeAlso: AH=84h"V20-XT-BIOS"
--------b-1584-------------------------------
INT 15 - V20-XT-BIOS - JOYSTICK SUPPORT
	AH = 84h
	DX = subfunction
	    0000h read joystick switches
		Return: AL bits 7-4 = switch settings
	    other: read positions of joysticks as indicated by bits 0-3
		Return: AX = X position of joystick A (if DX bit 0 set)
			BX = Y position of joystick A (if DX bit 1 set)
			CX = X position of joystick B (if DX bit 2 set)
			DX = Y position of joystick B (if DX bit 3 set)
Return: CF set on error
	    AH = status (see #00496)
	CF clear if successful
Program: V20-XT-BIOS is a ROM BIOS replacement with extensions by Peter
	   Koehlmann / c't magazine
SeeAlso: AH=84h"PS",INT 10/AH=0Eh/CX=ABCDh
----------1584--DX0002-----------------------
INT 15 - AMIGATSR - INSTALLATION CHECK
	AH = 84h
	DX = 0002h
Return: AX = 1234h if installed
Program: AMIGATSR is a serial-port driver for using an Amiga gamepad on a PC
SeeAlso: AH=84h/DX=0002h"MULTIJOY"
----------1584--DX0002-----------------------
INT 15 - MULTIJOY - INSTALLATION CHECK
	AH = 84h
	DX = 0002h
Return: AX = 4321h if installed
SeeAlso: AH=84h/DX=0002h"AMIGATSR",AH=84h/DX=0003h"MULTIJOY"
----------1584--DX0003-----------------------
INT 15 - MULTIJOY - GET ACTIVE JOYSTICK
	AH = 84h
	DX = 0003h
Return: AX = number of the currently-active joystick device
	BX = device classification (see #04098)
SeeAlso: AH=84h/DX=0002h"MULTIJOY"
 !!! more info to follow

Bitfields for MULTIJOY device classification:
Bit(s)	Description	(Table 04098)
 15	device connected and ready
 14	no buttons (overrides bits 12-9)
 13	no axes (overrides bits 8-5)
 12-9	number of buttons, less one
 8-5	number of axes, less one
 4	digital device rather than analog
 3-0	device type
	0000 keyboard emulating joystick
	0001 gamepad
	0010 joystick
	0011 steering wheel
	0100 flight yoke
	0101 mouse emulating joystick
	0110 trackball emulating joystick
	0111 GlidePoint (touchpad) emulating joystick
	1000 touchscreen emulating joystick
	1001 steering wheel
	1010 light pen emulating joystick
	1011 speech recognition emulating joystick
	1100 TV remote emulating joystick
	1101 network/Internet remote control
	1110 PC software-controlled (demo mode, etc.)
	1111 other device
----------1584--DX0004-----------------------
INT 15 - MULTIJOY - SELECT JOYSTICK
	AH = 84h
	DX = 0004h
	BX = number of the joystick device to make active
Return: ???
SeeAlso: AH=84h/DX=0003h"MULTIJOY"
--------b-158400----------------------------------
INT 15 - HUNTER 16 - GET DISKETTE PORT
	AX = 8400h
	BH = Drive (0: A:, 1: B:)
Return: AL = Port (0: COM1, >0: COM2)
Desc:	return the COM port used for the floppy drive
SeeAlso: AX=8401h
--------b-158401----------------------------------
INT 15 - HUNTER 16 - SET DISKETTE PORT
	AX = 8401h
	BH = Drive (0: A:, 1: B:)
	BL = Port (0: COM1, >0: COM2)
Desc:	set the COM port used for the floppy drive
SeeAlso: AX=8400h
--------B-1585-------------------------------
INT 15 C - OS HOOK - SysReq KEY ACTIVITY (AT,PS)
	AH = 85h
	AL = SysReq key action (00h pressed, 01h released)
	CF clear
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (see #00496)
Notes:	called by keyboard decode routine
	the default handler simply returns successfully; programs which wish
	  to monitor the SysReq key must hook this call
	the SysReq key is often labeled SysRq
SeeAlso: INT 09
--------b-158500----------------------------------
INT 15 - HUNTER 16 - RESTORE POWER MENU (APM)
	AX = 8500h
Desc:	restore the standard power menu
SeeAlso: AX=8501h"HUNTER"
--------b-158501----------------------------------
INT 15 - HUNTER 16 - SET POWER MENU (APM)
	AX = 8501h
	BL = user software interrupt number
Desc:	install an alternate power menu routine
SeeAlso: AX=8500h"HUNTER"
--------B-1586-------------------------------
INT 15 - BIOS - WAIT (AT,PS)
	AH = 86h
	CX:DX = interval in microseconds
Return: CF clear if successful (wait interval elapsed)
	CF set on error or AH=83h wait already in progress
	    AH = status (see #00496)
Note:	the resolution of the wait period is 977 microseconds on many systems
	  because many BIOSes use the 1/1024 second fast interrupt from the AT
	  real-time clock chip which is available on INT 70; because newer
	  BIOSes may have much more precise timers available, it is not
	  possible to use this function accurately for very short delays unless
	  the precise behavior of the BIOS is known (or found through testing)
SeeAlso: AH=41h,AH=83h,INT 1A/AX=FF01h,INT 70
--------b-1586------------------------------------
INT 15 - HUNTER 16 - GET/SET SCREEN ATTRIBUTE TABLE
	AH = 86h
	AL = function (00h get, nonzero set)
	BX = 1234h
	DS:SI -> 256-byte Attribute buffer
Note:	In text modes each character has its attribute byte XOR'd with the
	  corresponding byte in the attribute table.  If the attribute is 15,
	  15 is XOR'd with Table[15]
--------B-1587-------------------------------
INT 15 - SYSTEM - COPY EXTENDED MEMORY
	AH = 87h
	CX = number of words to copy (max 8000h)
	ES:SI -> global descriptor table (see #00499)
Return: CF set on error
	CF clear if successful
	AH = status (see #00498)
Notes:	copy is done in protected mode with interrupts disabled by the default
	  BIOS handler; many 386 memory managers perform the copy with
	  interrupts enabled
	on the PS/2 30-286 & "Tortuga" this function does not use the port 92h
	  for A20 control, but instead uses the keyboard controller (8042).
	  Reportedly this may cause the system to crash when access to the
	  8042 is disabled in password server mode (see also PORT 0064h,#P0398)
	this function is incompatible with the OS/2 compatibility box
SeeAlso: AH=88h,AH=89h,INT 1F/AH=90h

(Table 00498)
Values for extended-memory copy status:
 00h	source copied into destination
 01h	parity error
 02h	interrupt error
 03h	address line 20 gating failed
 80h	invalid command (PC,PCjr)
 86h	unsupported function (XT,PS30)

Format of global descriptor table:
Offset	Size	Description	(Table 00499)
 00h 16 BYTEs	zeros (used by BIOS)
 10h	WORD	source segment length in bytes (2*CX-1 or greater)
 12h  3 BYTEs	24-bit linear source address, low byte first
 15h	BYTE	source segment access rights (93h)
 16h	WORD	(286) zero
		(386+) extended access rights and high byte of source address
 18h	WORD	destination segment length in bytes (2*CX-1 or greater)
 1Ah  3 BYTEs	24-bit linear destination address, low byte first
 1Dh	BYTE	destination segment access rights (93h)
 1Eh	WORD	(286) zero
		(386+) extended access rights and high byte of destin. address
 20h 16 BYTEs	zeros (used by BIOS to build CS and SS descriptors)
--------b-1587------------------------------------
INT 15 - HUNTER 16 - SET INT 72h VECTOR
	AH = 87h
	DS:DX = new service routine
Desc:	set the INT 72h vector which is called in 2 cases:
	  - when the machine is about to turn off or reboot, INT 72h is called
	    with AH=0
	  - when the machine is powering up INT 72h is called with AH=01h
Note:	the actual INT 72h vector must also be changed with INT 21/AH=25h
--------B-1588-------------------------------
INT 15 - SYSTEM - GET EXTENDED MEMORY SIZE (286+)
	AH = 88h
Return: CF clear if successful
	    AX = number of contiguous KB starting at absolute address 100000h
	CF set on error
	    AH = status
		80h invalid command (PC,PCjr)
		86h unsupported function (XT,PS30)
Notes:	TSRs which wish to allocate extended memory to themselves often hook
	  this call, and return a reduced memory size.	They are then free to
	  use the memory between the new and old sizes at will.
	the standard BIOS only returns memory between 1MB and 16MB; use AH=C7h
	  for memory beyond 16MB
	not all BIOSes correctly return the carry flag, making this call
	  unreliable unless one first checks whether it is supported through
	  a mechanism other than calling the function and testing CF
	Due to applications not dealing with more than 24-bit descriptors
	  (286), Windows 3.0 has problems when this function reports more
	  than 15 MB. Some releases of HIMEM.SYS are therefore limited to use
	  only 15 MB, even when this function reports more.
SeeAlso: AH=87h,AH=8Ah"Phoenix",AH=C7h,AX=DA88h,AX=E801h,AX=E820h
--------b-1588------------------------------------
INT 15 - HUNTER 16 - GET POWER UP KEYS
	AH = 88h
Return: AH = 00h
	BX = column
	CL = row
SeeAlso: AH=71h
--------B-1589-------------------------------
INT 15 - SYSTEM - SWITCH TO PROTECTED MODE
	AH = 89h
	BL = interrupt number of IRQ0 (IRQ1-7 use next 7 interrupts)
	BH = interrupt number of IRQ8 (IRQ9-F use next 7 interrupts)
	ES:SI -> GDT for protected mode (see #00500)
Return: CF set on error
	   AH = FFh  error enabling address line 20
	CF clear if successful
	   AH = 00h
	   in protected mode at specified address
	   BP may be destroyed; all segment registers change
Notes:	BL and BH must be multiples of 8
	the protected-mode CS must reference the same memory as the CS this
	  function is called from because execution continues with the address
	  following the interrupt call
SeeAlso: AH=87h,AH=88h,INT 67/AX=DE0Ch

Format of BIOS switch-to-protected-mode Global Descriptor Table:
Offset	Size	Description	(Table 00500)
 00h  8 BYTEs	null descriptor (initialize to zeros)
 08h  8 BYTEs	GDT descriptor (see #00501)
 10h  8 BYTEs	IDT descriptor
 18h  8 BYTEs	DS descriptor
 20h  8 BYTEs	ES
 28h  8 BYTEs	SS
 30h  8 BYTEs	CS
 38h  8 BYTEs	uninitialized, used to build descriptor for BIOS CS

Format of segment descriptor table entry:
Offset	Size	Description	(Table 00501)
 00h	WORD	segment limit, low word
 02h  3 BYTEs	segment base address, low 24 bits
 05h	BYTE	access mode (see #00502)
 06h	BYTE	386+ extended access mode (see #00505)
 07h	BYTE	386+ segment base address, high 8 bits
SeeAlso: #00500,INT 2C/AX=0002h,INT 31/AX=0009h

Bitfields for segment descriptor table access mode field:
Bit(s)	Description	(Table 00502)
 3-0	segment type (see #00503,#00504)
 4	descriptor type (1 = application, 0 = system)
 6-5	descriptor privilege level
 7	segment is present in RAM
SeeAlso: #00501,#00505

(Table 00503)
Values for system segment descriptor type:
 0	reserved
 1	available 16-bit TSS
 2	LDT
 3	busy 16-bit TSS
 4	16-bit call gate
 5	task gate
 6	16-bit interrupt gate
 7	16-bit trap gate
 8	reserved
 9	available 32-bit TSS
 10	reserved
 11	busy 32-bit TSS
 12	32-bit call gate
 13	reserved
 14	32-bit interrupt gate
 15	32-bit trap gate
SeeAlso: #00502,#00504

Bitfields for application segment descriptor type:
Bit(s)	Description	(Table 00504)
 3	code/data
	0 date
	1 code
---data segments---
 2	expand down
 1	writeable
---code segments---
 2	conforming
 1	readable
------
 0	accessed
SeeAlso: #00502,#00503

Bitfields for 386+ segment descriptor table extended access mode field:
Bit(s)	Description	(Table 00505)
 3-0	high 4 bits of segment limit
 4	available
 5	reserved (0)
 6	default operation size (1 = 32 bits, 0 = 16 bits)
 7	granularity (1 = 4K, 0 = byte)
SeeAlso: #00501,#00502,#02557
--------b-158900----------------------------------
INT 15 - HUNTER 16 - GET POWER MODE
	AX = 8900h
Return: AH = 00h
	BL = current power mode
	    00h Standard Power Mode (SPM)
	    01h Advanced Power Mode (APM)
SeeAlso: AX=8901h
--------b-158901----------------------------------
INT 15 - HUNTER 16 - SET POWER MODE
	AX = 8901h
	BL = new mode
	    00h Standard Power Mode (SPM)
	    01h Advanced Power Mode (APM)
Return: AH = 00h
SeeAlso: AX=8900h
--------b-158A------------------------------------
INT 15 - HUNTER 16 - CONTROL POWER INPUT (SPM)
	AH = 8Ah
	AL = new state of Power Input (00h disabled, nonzero enabled)
	SI = 1234h
	DI = 5678h
Return: AH = status
	    00h success
	    FFh failure
Desc:	Enable or disable Power Input. When Power Input is disabled the AC
	  adapter will neither charge the batteries nor supply power to the
	  Hunter 16. Disable Power Input if using Alkaline batteries.
--------b-158A-------------------------------
INT 15 - Phoenix BIOS v4.0 - GET BIG MEMORY SIZE
	AH = 8Ah
Return: DX:AX = extended memory size in K
SeeAlso: AH=88h,AX=E801h,AX=E820h
--------b-158B------------------------------------
INT 15 - HUNTER 16 - GET/SET CHARGER TEMPERATURE OVERRIDE
	AH = 8Bh
	AL = function
	    00h get
		Return:	BH = Maximum charging temperature
				Temp = -20 + (n * 0.63) degrees Centigrade
			BL = Minimum charging temperature
	    else set
		BH = maximum charging temperature (as above)
		BL = minimum charging temperature (as above)
Return: AH = status
	    00h success
	    FFh failure
Desc:	get/set the temperature interval within which the charger should
	  operate
--------b-158C------------------------------------
INT 15 - HUNTER 16 - GET/SET POWER SAVE ENTRY FLAG
	AH = 8Ch
	AL = function
	    00h get
		Return: BX = which operations disable power save (see #00506)
	    else set
		BX = which operations should disable power save (see #00506)
SeeAlso: AH=8Dh

Bitfields for HUNTER 16 operations disabling power save:
Bit(s)	Description	(Table 00506)
 0	INT 10h prevents power save
 1	INT 13h prevents power save
 2	INT 14h prevents power save
 3	INT 15h prevents power save
 4	INT 1Ah prevents power save
 5	INT 21h prevents power save
 6	direct write to video RAM prevents power save
 7	access to 8250 UART prevents power save
 8	access to 8253 (Sound) prevents power save
--------b-158D------------------------------------
INT 15 - HUNTER 16 - GET/SET BOOST CHARGE (SPM)
	AH = 8Dh
	AL = function
	    00h get
		Return: AL = Fast Charge state (00h prevented, else allowed)
	    nonzero set
		BH = Fast Charge state (00h prevent, nonzero allow)
Return: AH = status
	    00h success
	    FFh failure
Desc:	control whether Fast Charging (200ma rather than 70ma) is allowed
SeeAlso: AH=8Ch
--------B-1590-------------------------------
INT 15 - OS HOOK - DEVICE BUSY (AT,PS)
	AH = 90h
	AL = device type (see #00507)
	ES:BX -> request block for type codes 80h through BFh
	CF clear
Return: CF set if wait time satisfied
	CF clear if driver must perform wait
	    AH = 00h
Notes:	type codes are allocated as follows:
	  00-7F non-reentrant devices; OS must arbitrate access
	  80-BF reentrant devices; ES:BX points to a unique control block
	  C0-FF wait-only calls, no complementary INT 15/AH=91h call
	floppy and hard disk BIOS code uses this call to implement a timeout;
	  for device types 00h and 01h, a return of CF set means that the
	  timeout expired before the disk responded.
	this function should be hooked by a multitasker to allow other tasks
	  to execute while the BIOS is waiting for I/O completion; the default
	  handler merely returns with AH=00h and CF clear
SeeAlso: AH=91h,INT 13/AH=00h,INT 17/AH=00h,INT 1A/AH=83h

(Table 00507)
Values for device type:
 00h	disk
 01h	diskette
 02h	keyboard
 03h	PS/2 pointing device
 21h	waiting for keyboard input (Phoenix BIOS)
 80h	network
 FBh	digital sound (Tandy)
 FCh	disk reset (PS)
 FDh	diskette motor start
 FEh	printer
--------B-1591-------------------------------
INT 15 - OS HOOK - DEVICE POST (AT,PS)
	AH = 91h
	AL = device type (see #00507)
	ES:BX -> request block for type codes 80h through BFh
	CF clear
Return: AH = 00h
Note:	this function should be hooked by a multitasker to allow other tasks
	  to execute while the BIOS is waiting for I/O completion; the default
	  handler merely returns with AH=00h and CF clear
SeeAlso: AH=90h
--------B-1592-------------------------------
INT 15 - IBM SurePath BIOS - Officially "Private" Function
	AH = 92h
SeeAlso: AH=07h"IBM",AH=3Eh"IBM"
--------B-15A0-------------------------------
INT 15 - IBM SurePath BIOS - ACCESS LOADABLE-ABIOS SIGNATURE
	AH = A0h
	AL = function
	    00h get loadable-ABIOS signature
		Return: BL = signature value
			    00h loadable-ABIOS prompting not required
			    A1h loadable-ABIOS prompting is required
	    01h write loadable-ABIOS signature
		BL = new signature value
		    00h loadable-ABIOS prompting not required
		    A1h loadable-ABIOS prompting is required
Return: CF clear if successful
	CF set on error
	AH = status
	    00h successful
	    01h invalid subfunction
	    02h unable to read/write signature
	    86h function not supported
Note:	IBM classifies this function as optional
SeeAlso: AH=08h"IBM"
--------x-15A100-----------------------------
INT 15 U - AMI PCI BIOS - SET ??? FLAG
	AX = A100h
Return: AX = 0000h
	CF clear
	BX,CX,DI may be destroyed
Desc:	sets bit 7 of CMOS RAM location 37h and updates the CMOS checksum in
	  locations 3Eh and 3Fh
Notes:	in the examined version of the BIOS, nonzero values in AL cause it to
	  drop through to checking the next possible value of AH, i.e. only
	  subfunction 00h is supported
	also supported by Dell XPS P90 and IBM PS/PV 6384, which also use
	  AMI BIOSes
--------B-15AB-------------------------------
INT 15 - IBM SurePath BIOS - Officially "Private" Function
	AH = ABh
SeeAlso: AH=07h"IBM",AH=3Eh"IBM"
----------15B001CX5354-----------------------
INT 15 - Stac STACKER - INSTALLATION CHECK
	AX = B001h
	CX = 5354h ('ST')
	DX = 4143h ('AC')
Return: AX = 4F4Bh ('OK') if installed
Note:	this function is encapsulated in Stac's STACKER.LIB C library; it is
	  called by Novell DOS 7+ NWCACHE v1.01, which makes use of this
	  library
--------n-15BA10-----------------------------
INT 15 - HP OmniShare - Pen Driver - REPORT PEN CONTROL AREA EVENT
	AX = BA10h
	BL = event
	   00h the pen left control areas
	   01h the pen entered the Brightness- area
	   02h the pen entered the Brightness+ area
	   03h the pen entered the Contrast- area
	   04h the pen entered the Contrast+ area
Return: CF clear if successfully processed
	CF set on error (function not supported, ie. not an OmniShare BIOS)
Note:	The pen driver is responsible for detecting when the pen enters and
	  leaves control areas of the OmniShare tablet, and notifying the BIOS.
	The BIOS manages the events, including the autorepetition, and sets
	  the status LEDs.
SeeAlso: AX=BA20h,AX=BA13h
--------n-15BA11-----------------------------
INT 15 - HP OmniShare - Pen Driver - SET THE COMMUNICATION LED STATE
	AX = BA11h
	BL = new LED state (00h steady, 01h flashing)
Return: CF clear if successful
	CF set on error
Note:	this function is for use by communication software to give visual
	  feedback of active communications even if the display is in standby
	  mode.
SeeAlso: AX=BA10h,AX=BA24h
--------n-15BA12-----------------------------
INT 15 - HP OmniShare - Pen Driver - STORE PEN BATTERY CHARGE
	AX = BA12h
	BL = new battery state (00h good, 01h low charge)
Return: CF set on error
	CF clear if successfully stored in CMOS
Note:	The last report will be displayed by the Power-On Self Test the next
	  time the OmniShare boots.  This allows something meaningful to be
	  reported even if the pen is not detected during the POST.
SeeAlso: AX=BA13h
--------n-15BA13-----------------------------
INT 15 - HP OmniShare - Pen Driver - GET PEN BATTERY CHARGE
	AX = BA13h
Return: CF clear if successful
	    BL = pen battery state (00h good, 01h low charge)
	CF set on error
Note:	returns the last value set by AX=BA12h.
SeeAlso: AX=BA12h
--------p-15BA20-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - INSTALLATION CHECK
	AX = BA20h
Return: CF clear if successful (installed)
	CF set on error (not installed)
Notes:	The display controller can enter a standby mode after a given timeout,
	  to conserve power or (for the OmniShare) to increase the life of
	  the backlight.
	A side effect of standby mode is that the communications LED turns on
	  automatically when the display is in standby mode.  This is done in
	  hardware, and is intended to show that the unit is still on.
SeeAlso: AX=BA10h,AX=BA20h,AX=BA22h,AX=BA24h,AX=BA26h
--------p-15BA21-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - SET STANDBY DURATION
	AX = BA21h
	BL = new timeout before standby mode in minutes (01h-0Fh)
	    00h to disable automatic switch to standby mode
Return: CF clear if successful
	CF set on error (function not supported)
Note:	The actual timeout with a GD6205 controller is ((N*64)-32) seconds,
	  instead of (N*60) seconds as documented.
SeeAlso: AX=BA20h,AX=BA22h
--------p-15BA22-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - GET STANDBY DURATION
	AX = BA22h
Return: CF clear if successful
	   BL = standy duration in minutes (01h-0Fh), or 00h if disabled
	CF set on error (function not supported)
Note:	The actual timeout with a GD6205 controller is ((N*64)-32) seconds,
	  instead of (N*60) seconds as documented.
SeeAlso: AX=BA20h,AX=BA21h
--------p-15BA23-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - TURN ON THE SCREEN IMMEDIATELY
	AX = BA23h
Return: CF clear if successful
	CF set on error
SeeAlso: AX=BA11h,AX=BA20h,AX=BA24h
--------p-15BA24-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - TURN OFF THE SCREEN IMMEDIATELY
	AX = BA24h
Return: CF clear if successful
	CF set on error
Note:	This function is not implemented yet. Reserved for future versions
	  of the OmniShare.
SeeAlso: AX=BA11h,AX=BA20h,AX=BA23h
--------p-15BA25-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - PREPARE FOR UNINSTALL
	AX = BA25h
Return: CF clear if successful
	    AX = 25BAh
	    BX = PSP of STANDBY.COM resident portion
	    DX:CX -> previous INT 15 handler
	CF set on error
Note:	This function is used internally by the STANDBY.COM /u option, and
	  should not be used by application programs.
SeeAlso: AX=BA20h
--------p-15BA26-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - IS THE DISPLAY IN STANDBY MODE?
	AX = BA26h
Return: CF clear if successful
	    AL	= display state (00h active, 01h in standby mode)
	CF set on error (function not supported)
SeeAlso: AX=BA20h,AX=BA23h
--------p-15BA27-----------------------------
INT 15 - HP OmniShare - STANDBY.COM - RESERVED FUNCTIONS
	AX = BA27h to BA2Fh
Desc:	reserved for future use
--------b-15BC-------------------------------
INT 15 - Phoenix 386 BIOS - DETERMINE CPU SPEED FOR DELAY LOOPS
	AH = BCh
Return: CF clear
	(Phoenix 1.10 10a) BYTE 0040h:00B0h set to delay loop count
	(Dell 4xxDE BIOS A11) WORD 0040h:00ECh set to delay loop count
Note:	this function reads system timer channel 0 twice, then does
	  calculations on the returned values to determine the delay loop
	  counter needed by the BIOS for beeps and floppy timeouts
SeeAlso: AX=2305h,MEM 0040h:00B0h
--------E-15BF00-----------------------------
INT 15 - Rational Systems DOS/16M - ???
	AX = BF00h
	???
Return: ???
Note:	under DESQview/X 1.02 DVDOS4GX.DVR, this call is identical to AX=BF02h
SeeAlso: AX=BF02h
--------E-15BF01-----------------------------
INT 15 - Rational Systems DOS/16M - ???
	AX = BF01h
	???
Return: ???
Notes:	under DESQview/X 1.02 DVDOS4GX.DVR, this call is identical to AX=BF02h
	called by DOS/4GW
SeeAlso: AX=BF00h,AX=BF02h
--------E-15BF02DX0000-----------------------
INT 15 - Rational Systems DOS/16M - INSTALLATION CHECK
	AX = BF02h
	DX = 0000h
Return: DX = nonzero if installed
	    DX:SI -> XBRK structure (see #00508)
Note:	this function is also supported by DOS/4G
SeeAlso: AX=BF01h,AX=BFDCh,AX=BFDEh/BX=0000h
SeeAlso: INT 21/AH=FFh/DH=0Eh,INT 2F/AH=A1h,INT 2F/AX=F100h,INT 2F/AX=FBA1h

Format of DOS/16M XBRK structure:
Offset	Size	Description	(Table 00508)
 00h	DWORD	linear address of first available byte
 04h	DWORD	linear address of last available byte + 1 ???
 08h	DWORD	real-mode address of XBRK structure???
 0Ch	DWORD	???
 10h  2 BYTEs	???
 12h	WORD	segment of ???
 14h  8 BYTEs	???
 1Ch 512 BYTEs	protected-mode IDT
21Ch  N BYTEs	protected-mode GDT
--------E-15BF03-----------------------------
INT 15 - Rational Systems DOS/4GW - UNINSTALL???
	AX = BF03h
	BX = PSP segment of extender
	???
Return: ???
Note:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
SeeAlso: AX=BF06h
--------E-15BF04-----------------------------
INT 15 - Rational Systems DOS/4GW - ???
	AX = BF04h
	BX = PSP segment of extender
Return: nothing???
Notes:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
	grabs INT 2Fh and installs handlers for INT 2F/AX=1605h-1607h
SeeAlso: INT 2F/AX=1607h/BX=22C0h
--------E-15BF05-----------------------------
INT 15 - Rational Systems DOS/4GW - INITIALIZE PROTECTED-MODE INTERFACE
	AX = BF05h
	BX = PSP segment of extender
Return: nothing???
Notes:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
	calls INT 67/AX=DE01h if ???
--------E-15BF06-----------------------------
INT 15 - Rational Systems DOS/4GW - ???
	AX = BF06h
	BX = PSP segment of extender
	???
Return: ???
Note:	if BX is not the PSP segment of the extender, it passes the call down
	  the INT 15 chain; this allows nested instances of the extender
SeeAlso: AX=BF03h
--------E-15BFDCDX0000-----------------------
INT 15 - Rational Systems DOS/4GW - INSTALLATION CHECK
	AX = BFDCh
	DX = 0000h
	SI = 0000h
Return: DX = nonzero if installed
	    DX:SI -> XBRK structure (see #00508)
SeeAlso: AX=BF02h
--------E-15BFDEBX0000-----------------------
INT 15 - DESQview/X - DVDOS4GX.DVR - INSTALLATION CHECK
	AX = BFDEh
	BX = 0000h
Return: AX = ??? (0003h)
	BX = FFFFh
SeeAlso: AX=BF02h
--------E-15BFDEBX0001-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET PROCESS MANAGER NAME
	AX = BFDEh
	BX = 0001h
Return: BX = 0000h (success)
	CX:DX -> name of process manager executable
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0002-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - SET ???
	AX = BFDEh
	BX = 0002h
	CX:DX -> ???
Return: BX = 0000h (success)
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0003h
--------E-15BFDEBX0003-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0003h
Return: BX = 0000h (success)
	CX:DX -> ???
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0002h
--------E-15BFDEBX0004-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 0004h
	CL = ???
Return: BX = 0000h (success)
	CX:DX -> XBRK structure (see #00508)
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0005-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 0005h
	CX = new value for ???
Return: BX = 0000h (success)
	AX = old value of ???
	DS:SI -> ??? (if AX nonzero on return)
	ES:DI -> ??? (if AX zero on return)
Note:	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0006-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0006h
Return: BX = 0000h (success)
	AH = interrupt number??? (BEh)
	CX:DX = ???
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0007h,INT BE"DESQview"
--------E-15BFDEBX0007-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - SET ???
	AX = BFDEh
	BX = 0007h
	CX:DX = ???
Return: BX = 0000h (success)
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=0006h
--------E-15BFDEBX0008-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 0008h
	CX = segment of ???
	DS = ???
Return: BX = status
	    0000h successful
		AL = ??? (80h or C0h)
		DX = ??? (0603h) if AL=C0h
	    0001h failed
		AX = 0000h
Note:	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0009-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET PROTECTED MODE PROGRAM LOADER
	AX = BFDEh
	BX = 0009h
Return: BX = 0000h (success)
	CX:DX -> full pathname to LOAD32.EXP
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX000A-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - DECREMENT ???
	AX = BFDEh
	BX = 000Ah
Return: BX = 0000h (success)
	AX = new value of ??? counter
Notes:	also resets a variety of values if the counter goes negative
	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=000Bh
--------E-15BFDEBX000B-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - INCREMENT ???
	AX = BFDEh
	BX = 000Bh
Return: AX = new value of ??? counter
Note:	called by DOS4GW.EXE
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=000Ah
--------E-15BFDEBX000C-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Ch
	CL = ???
	    00h
	    nonzero
Return: ???
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX000D-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Dh
	???
Return: ???
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX000E-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Eh
	DX:CX -> ???
Return: AX = segment of handle for calling task
	BX = ??? (probably destroyed)
	DX:CX -> ???
SeeAlso: AX=BFDEh/BX=0000h,AX=BFDEh/BX=000Fh,AX=BFDEh/BX=0013h
--------E-15BFDEBX000F-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - ???
	AX = BFDEh
	BX = 000Fh
Return: AX = segment of handle for calling task
	BX = ??? (probably destroyed)
	DX:CX -> ???
Note:	identical to AX=BFDEh/BX=000Eh with CX:DX = 0000h:0000h
SeeAlso: AX=BFDEh/BX=000Eh,AX=BFDEh/BX=0010h
--------E-15BFDEBX0010-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET TASK HANDLE
	AX = BFDEh
	BX = 0010h
Return: AX = segment of caller's task handle
	BX destroyed
SeeAlso: AX=BFDEh/BX=000Fh
--------E-15BFDEBX0011-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0011h
Return: CX = code segment of DVDOS4GX.DVR
	BX = ??? (0004h)
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0012-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0012h
Return: DX = code segment of DVDOS4GX.DVR
	BX = ??? (012Ch)
	CX = ??? (0006h)
SeeAlso: AX=BFDEh/BX=0000h
--------E-15BFDEBX0013-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = 0013h
Return: DX:CX -> ???
SeeAlso: AX=BFDEh/BX=000Eh
--------E-15BFDEBX0014-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - LOCK ??? MAILBOX
	AX = BFDEh
	BX = 0014h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX,BX destroyed
SeeAlso: AX=BFDEh/BX=0015h,AX=BFDEh/BX=0017h
--------E-15BFDEBX0015-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - UNLOCK ??? MAILBOX
	AX = BFDEh
	BX = 0015h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX,BX destroyed
SeeAlso: AX=BFDEh/BX=0014h,AX=BFDEh/BX=0016h
--------E-15BFDEBX0016-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - CHECK IF ??? MAILBOX OWNED
	AX = BFDEh
	BX = 0016h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX = status
	    0000h no one owns mailbox
	    0001h mailbox has an owner
	BX destroyed
SeeAlso: AX=BFDEh/BX=0015h,AX=BFDEh/BX=0017h
--------E-15BFDEBX0017-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ??? MAILBOX OWNER
	AX = BFDEh
	BX = 0017h
	CX = index of ??? mailbox
		(0000h-0004h valid, but no range checking done)
Return: AX = segment of mailbox owner's handle
	BX = segment of caller's task handle
SeeAlso: AX=BFDEh/BX=0015h,AX=BFDEh/BX=0016h
--------E-15BFDEBXFFFD-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - GET ???
	AX = BFDEh
	BX = FFFDh
Return: CX:DX = ???
SeeAlso: AX=BFDEh/BX=FFFEh
--------E-15BFDEBXFFFE-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - SET ???
	AX = BFDEh
	BX = FFFEh
	CX:DX = ???
SeeAlso: AX=BFDEh/BX=FFFDh
--------E-15BFDEBXFFFF-----------------------
INT 15 - DESQview/X 1.02+ - DVDOS4GX.DVR - NOP
	AX = BFDEh
	BX = FFFFh
SeeAlso: AX=BFDEh/BX=0000h
--------B-15C0-------------------------------
INT 15 - SYSTEM - GET CONFIGURATION (XT >1986/1/10,AT mdl 3x9,CONV,XT286,PS)
	AH = C0h
Return: CF set if BIOS doesn't support call
	CF clear on success
	    ES:BX -> ROM table (see #00509)
	AH = status
	    00h successful
		The PC XT (since 1986/01/10), PC AT (since 1985/06/10), the
		  PC XT Model 286, the PC Convertible and most PS/2 machines
		  will clear the CF flag and return the table in ES:BX.
	    80h unsupported function
		The PC and PCjr return AH=80h/CF set
	    86h unsupported function
		The PC XT (1982/11/08), PC Portable, PC AT (1984/01/10),
		or PS/2 prior to Model 30 return AH=86h/CF set
Notes:	the 1986/1/10 XT BIOS returns an incorrect value for the feature byte
	the configuration table is at F000h:E6F5h in 100% compatible BIOSes
	Dell machines contain the signature "DELL" or "Dell" at absolute FE076h
	  and a model byte at absolute address FE845h (see #00516)
	Hewlett-Packard machines contain the signature "HP" at F000h:00F8h and
	  a product identifier at F000h:00FAh (see #00519)
	Compaq machines can be identified by the signature string "COMPAQ" at
	  F000h:FFEAh, and is preceded by additional information (see #00517)
	Tandy 1000 machines contain 21h in the byte at F000h:C000h and FFh in
	  the byte at FFFFh:000Eh; Tandy 1000SL/TL machines only provide the
	  first three data bytes (model/submodel/revision) in the returned
	  table
	the ID at F000h:C000h is used by some Microsoft software before
	  trusting the floppy flags bits 1 and 0 at 0040h:00B5h.
	the Wang PC contains the signature "WANG" at FC00h:0000h. This is used
	  by Peter Reilley's portable binary editor and viewer BEAV to detect
	  a Wang PC.
	Toshiba laptops contain the signature "TOSHIBA" at FE010h as part of
	  a laptop information record at F000h:E000h (see #00520)
	some AST machines contain the string "COPYRIGHT AST RESEARCH" one byte
	  past the end of the configuration table
	the Phoenix 386 BIOS contains a second version and date string
	  (presumably the last modification for that OEM version) beginning at
	  F000h:FFD8h, with each byte doubled (so that both ROM chips contain
	  the complete information)
SeeAlso: AH=C7h,AH=C9h,AX=D100h,AX=D103h

Format of ROM configuration table:
Offset	Size	Description	(Table 00509)
 00h	WORD	number of bytes following
 02h	BYTE	model (see #00515)
 03h	BYTE	submodel (see #00515)
 04h	BYTE	BIOS revision: 0 for first release, 1 for 2nd, etc.
 05h	BYTE	feature byte 1 (see #00510)
 06h	BYTE	feature byte 2 (see #00511)
 07h	BYTE	feature byte 3 (see #00512)
 08h	BYTE	feature byte 4 (see #00513)
 09h	BYTE	feature byte 5 (see #00514)
		??? (08h) (Phoenix 386 v1.10)
		??? (0Fh) (Phoenix 486 v1.03 PCI)
---AWARD BIOS---
 0Ah  N BYTEs	AWARD copyright notice
---Phoenix BIOS---
 0Ah	BYTE	??? (00h)
 0Bh	BYTE	major version
 0Ch	BYTE	minor version (BCD)
 0Dh  4 BYTEs	ASCIZ string "PTL" (Phoenix Technologies Ltd)
		also on Phoenix Cascade BIOS
---Quadram Quad386---
 0Ah 17 BYTEs	ASCII signature string "Quadram Quad386XT"
---Toshiba (Satellite Pro 435CDS at least)---
 0Ah  7 BYTEs	signature "TOSHIBA"
 11h	BYTE	??? (8h)
 12h	BYTE	??? (E7h) product ID??? (guess)
 13h  3 BYTEs	"JPN"

Bitfields for feature byte 1:
Bit(s)	Description	(Table 00510)
 7	DMA channel 3 used by hard disk BIOS
 6	2nd interrupt controller (8259) installed
 5	Real-Time Clock installed
 4	INT 15/AH=4Fh called upon INT 09h
 3	wait for external event (INT 15/AH=41h) supported
 2	extended BIOS area allocated (usually at top of RAM)
 1	bus is Micro Channel instead of ISA
 0	system has dual bus (Micro Channel + ISA)
SeeAlso: #00509,#00511

Bitfields for feature byte 2:
Bit(s)	Description	(Table 00511)
 7	32-bit DMA supported
 6	INT 16/AH=09h (keyboard functionality) supported (see #00585)
 5	INT 15/AH=C6h (get POS data) supported
 4	INT 15/AH=C7h (return memory map info) supported
 3	INT 15/AH=C8h (en/disable CPU functions) supported
 2	non-8042 keyboard controller
 1	data streaming supported
 0	reserved
SeeAlso: #00509,#00512,AH=C6h,AH=C7h,AH=C8h,INT 16/AH=09h

Bitfields for feature byte 3:
Bit(s)	Description	(Table 00512)
 7	not used
 6-5	reserved
 4	POST supports ROM-to-RAM enable/disable
 3	SCSI subsystem supported on system board
 2	information panel installed
 1	IML (Initial Machine Load) system (BIOS loaded from disk)
 0	SCSI supported in IML
SeeAlso: #00509,#00511,#00512

Bitfields for feature byte 4:
Bit(s)	Description	(Table 00513)
 7	IBM "private" (set on N51SX, CL57SX)
 6	system has EEPROM
 5-3	ABIOS presence
	001 not supported
	010 supported in ROM
	011 supported in RAM (must be loaded)
 2	"private"
 1	system supports memory split at/above 16M
 0	POSTEXT directly supported by POST
SeeAlso: #00509,#00512,#00514

Bitfields for feature byte 5 (IBM):
Bit(s)	Description	(Table 00514)
 7-5	IBM "private"
 4-2	reserved
 1	system has enhanced mouse mode
 0	flash EPROM
SeeAlso: #00509,#00513

(Table 00515)
Values for model/submodel/revision:
Model  Submdl  Rev	BIOS date	System
 FFh	*	*	04/24/81	PC (original)
 FFh	*	*	10/19/81	PC (some bugfixes)
 FFh	*	*	10/27/82	PC (HD, 640K, EGA support)
 FFh	00h	rev	  ???		Tandy 1000SL
 FFh	01h	rev	  ???		Tandy 1000TL
 FFh	46h	***	  ???		Olivetti M15
 FEh	*	*	08/16/82	PC XT
 FEh	*	*	11/08/82	PC XT and Portable
 FEh	*	*	../..x..	Toshiba laptops up to ~1987
					("x"=product ID) (see #00521)
 FEh	00h	*** *	  ???		Olivetti M19
 FEh	43h	***	  ???		Olivetti M240
 FEh	A6h	???	  ???		Quadram Quad386
 FDh	*	*	06/01/83	PCjr
 FCh	*	*	01/10/84	AT models 068,099 6 MHz 20MB
 FCh	*	*	02/25/93	Linux DOSEMU (all versions)
 FCh	00h	00h	  ???		PC3270/AT
 FCh	00h	01h	06/10/85	AT model  239	  6 MHz 30MB
 FCh	00h	> 01h	  ???		7531/2 Industrial AT
 FCh	01h	00h	11/15/85	AT models 319,339 8 MHz, Enh Keyb, 3.5"
 FCh	01h	00h	09/17/87	Tandy 3000
 FCh	01h	00h	../..x..	Toshiba laptops since ~1988
					("x"=product ID) (see #00521)
 FCh	01h	00h	03/08/93	Compaq DESKPRO/i
 FCh	01h	00h	 various	Compaq DESKPRO, SystemPro, ProSignia
 FCh	01h	00h	07/20/93	Zenith Z-Lite 425L
 FCh	01h	00h	04/09/90	AMI BIOS
 FCh	01h	20h	06/10/92	AST
 FCh	01h	30h	  ???		Tandy 3000NL
 FCh	01h	???	  ???		Compaq 286/386
 FCh	02h	00h	04/21/86	PC XT-286
 FCh	02h	00h	 various	Compaq LTE Lite
 FCh	02h	00h	08/05/93	Compaq Contura 486/486c/486cx
 FCh	02h	00h	08/11/88	SoftWindows 1.0.1 (Power Macintosh)
 FCh	04h	00h	02/13/87     ** PS/2 Model 50 (10 MHz/1 ws 286)
 FCh	04h	01h	05/09/87	PS/2 Model 50 (10 Mhz 286, LW-type 32)
 FCh	04h	02h	  ???		PS/2 Model 50
 FCh	04h	02h	01/28/88	PS/2 Model 50Z (10 Mhz 286, LW-type 33)
 FCh	04h	03h	04/18/88	PS/2 Model 50Z (10 MHz/0 ws 286)
 FCh	04h	04h	  ???		PS/2 Model 50Z
 FCh	05h	00h	02/13/87     ** PS/2 Model 60 (10 MHz 286)
 FCh	06h	00h	  ???		IBM 7552-140 "Gearbox"
 FCh	06h	01h	  ???		IBM 7552-540 "Gearbox"
 FCh	08h	***	  ???		Epson, unknown model
 FCh	08h	00h	  ???		PS/2 Model 25/286
 FCh	09h	00h	  ???		PS/2 Model 25 (10 MHz 286)
 FCh	09h	00h	08/25/88	PS/2 Model 30 286 (10 Mhz, LW-type 37)
 FCh	09h	02h	06/28/89	PS/2 Model 30-286
 FCh	09h	02h	06/28/89	PS/2 Model 25 286 (10 Mhz, LW-type 37)
 FCh	0Bh	00h	12/01/89	PS/1 (LW-Type 44)
 FCh	0Bh	00h	02/16/90	PS/1 Model 2011 (10 MHz 286)
 FCh	20h	00h	02/18/93	Compaq ProLinea
 FCh	25h	09h	12/07/91	PS/2 Model 56 SLC (20 MHz 386SLC)
 FCh	30h	***	  ???		Epson, unknown model
 FCh	31h	***	  ???		Epson, unknown model
 FCh	33h	***	  ???		Epson, unknown model
 FCh	42h	***	  ???		Olivetti M280
 FCh	45h	***	  ???		Olivetti M380 (XP 1, XP3, XP 5)
 FCh	48h	***	  ???		Olivetti M290
 FCh	4Fh	***	  ???		Olivetti M250
 FCh	50h	***	  ???		Olivetti M380 (XP 7)
 FCh	51h	***	  ???		Olivetti PCS286
 FCh	52h	***	  ???		Olivetti M300
 FCh	81h	00h	01/15/88	Phoenix 386 BIOS v1.10 10a
 FCh	81h	01h	  ???		"OEM machine"
 FCh	82h	01h	  ???		"OEM machine"
 FCh	94h	00h	  ???		Zenith 386
 FBh	00h	01h	01/10/86	PC XT-089, Enh Keyb, 3.5" support
 FBh	00h	01h	05/13/94	HP 200LX 2MB BIOS 1.01 A D german
 FBh	00h	02h	05/09/86	PC XT
 FBh	00h	04h	08/19/93	HP 100LX 1MB BIOS 1.04 A
 FBh	4Ch	***	  ???		Olivetti M200
 FAh	00h	00h	09/02/86	PS/2 Model 30 (8 MHz 8086)
 FAh	00h	01h	12/12/86	PS/2 Model 30
 FAh	00h	02h	02/05/87	PS/2 Model 30
 FAh	01h	00h	06/26/87	PS/2 Model 25/25L (8 MHz 8086)
 FAh	30h	00h	  ???		IBM Restaurant Terminal
 FAh	4Eh	***	  ???		Olivetti M111
 FAh	FEh	00h	  ???		IBM PCradio 9075
 F9h	00h	00h	09/13/85	PC Convertible
 F9h	FFh	00h	  ???		PC Convertible
 F8h	00h	00h	03/30/87     ** PS/2 Model 80 (16MHz 386)
 F8h	00h	00h	  ???		PS/2 Model 75 486 (33Mhz 486)
 F8h	01h	00h	10/07/87	PS/2 Model 80 (20MHz 386)
 F8h	02h	00h	  ???		PS/2 Model 55-5571
 F8h	04h	00h	01/29/88	PS/2 Model 70 (20 Mhz 386DX,LW-type 33)
 F8h	04h	02h	04/11/88	PS/2 Model 70 20MHz, type 2 system brd
 F8h	04h	03h	03/17/89	PS/2 Model 70 20MHz, type 2 system brd
 F8h	05h	00h	  ???		IBM PC 7568
 F8h	06h	00h	  ???		PS/2 Model 55-5571
 F8h	07h	00h	  ???		IBM PC 7561/2
 F8h	07h	01h	  ???		PS/2 Model 55-5551
 F8h	07h	02h	  ???		IBM PC 7561/2
 F8h	07h	03h	  ???		PS/2 Model 55-5551
 F8h	09h	00h	01/29/88	PS/2 Model 70 16MHz 386DX, type 1 sysbd
 F8h	09h	02h	04/11/88	PS/2 Model 70 some models
 F8h	09h	03h	03/17/89	PS/2 Model 70 some models
 F8h	09h	04h	12/15/89	PS/2 Model 70 (16 Mhz 386, LW-type 33)
 F8h	0Bh	00h	01/18/89	PS/2 Model P70 (8573-121) typ 2 sys brd
 F8h	0Bh	02h	12/16/89	PS/2 Model P70 ??
 F8h	0Ch	00h	11/02/88	PS/2 Model 55SX (16 MHz 386SX)
 F8h	0Dh	00h	  ???		PS/2 Model 70 25MHz, type 3 system brd
 F8h	0Dh	00h	06/08/88	PS/2 Model 70 386 25MHz, type 3 sys brd
 F8h	0Dh	01h	02/20/89	PS/2 Model 70 386 25MHz, type 3 sys brd
 F8h	0Dh	???	12/01/89	PS/2 Model 70 486 25Mhz, type 3 sys brd
 F8h	0Eh	00h	  ???		PS/1 486SX
 F8h	0Fh	00h	  ???		PS/1 486DX
 F8h	10h	00h	  ???		PS/2 Model 55-5551
 F8h	11h	00h	10/01/90	PS/2 Model 90 XP (25 MHz 486)
 F8h	12h	00h	  ???		PS/2 Model 95 XP
 F8h	13h	00h	10/01/90	PS/2 Model 90 XP (33 MHz 486)
 F8h	14h	00h	10/01/90	PS/2 Model 90-AK9 (25 MHz 486), 95 XP
 F8h	15h	00h	  ???		PS/2 Model 90 XP
 F8h	16h	00h	10/01/90	PS/2 Model 90-AKD / 95XP486 (33MHz 486)
 F8h	17h	00h	  ???		PS/2 Model 90 XP
 F8h	19h	05h	  ???		PS/2 Model 35/35LS or 40 (20 MHz 386SX)
 F8h	19h	05h	03/15/91	PS/2 Model 35 SX / 40 SX (LW-type 37)
 F8h	19h	06h	04/04/91	PS/2 Model 35 SX / 40 SX (LW-type 37)
 F8h	1Ah	00h	  ???		PS/2 Model 95 XP
 F8h	1Bh	00h	09/29/89	PS/2 Model 70 486 (25 Mhz 386DX)
 F8h	1Bh	00h	10/02/89	PS/2 Model 70-486 (25 MHz 486)
 F8h	1Ch	00h	02/08/90	PS/2 Model 65-121 / 65 SX (16MHz 386SX)
 F8h	1Eh	00h	02/08/90	PS/2 Model 55LS (16 MHz 386SX)
 F8h	23h	00h	  ???		PS/2 Model L40 SX
 F8h	23h	01h	  ???		PS/2 Model L40 SX (20 MHz 386SX)
 F8h	23h	02h	02/27/91	PS/2 Model L40 SX (20Mhz386SX,LW-typ37)
 F8h	25h	00h	  ???		PS/2 Model 57 SLC
 F8h	25h	06h	  ???		PS/2 Model M57 (20 MHz 386SLC)
 F8h	26h	00h	  ???		PS/2 Model 57 SX
 F8h	26h	01h	  ???		PS/2 Model 57 (20 MHz 386SX)
 F8h	26h	02h	07/03/91	PS/2 Model 57 SX (20Mhz 386SX, SCSI)
 F8h	28h	00h	  ???		PS/2 Model 95 XP
 F8h	29h	00h	  ???		PS/2 Model 90 XP
 F8h	2Ah	00h	  ???		PS/2 Model 95 XP (50 MHz 486)
 F8h	2Bh	00h	  ???		PS/2 Model 90 / 90XP486 (50 MHz 486)
 F8h	2Ch	00h	  ???		PS/2 Model 95 XP
 F8h	2Ch	01h	  ???		PS/2 Model 95 (20 MHz 486SX)
 F8h	2Dh	00h	  ???		PS/2 Model 90 XP (20 MHz 486SX)
 F8h	2Eh	00h	  ???		PS/2 Model 95 XP
 F8h	2Eh	00h	  ???		PS/2 Model 95 XP486 (20 Mhz 486SX)
 F8h	2Eh	01h	  ???		PS/2 Model 95 (20 MHz 486SX + 487SX)
 F8h	2Fh	00h	  ???		PS/2 Model 90 XP (20 MHz 486SX + 487SX)
 F8h	30h	00h	  ???		PS/1 Model 2121 (16 MHz 386SX)
 F8h	33h	00h	  ???		PS/2 Model 30-386
 F8h	34h	00h	  ???		PS/2 Model 25-386
 F8h	36h	00h	  ???		PS/2 Model 95 XP
 F8h	37h	00h	  ???		PS/2 Model 90 XP
 F8h	38h	00h	  ???		PS/2 Model 57
 F8h	39h	00h	  ???		PS/2 Model 95 XP
 F8h	3Fh	00h	  ???		PS/2 Model 90 XP
 F8h	40h	00h	  ???		PS/2 Model 95 XP
 F8h	41h	00h	  ???		PS/2 Model 77
 F8h	45h	00h	  ???		PS/2 Model 90 XP (Pentium)
 F8h	46h	00h	  ???		PS/2 Model 95 XP (Pentium)
 F8h	47h	00h	  ???		PS/2 Model 90/95 E (Pentium)
 F8h	48h	00h	  ???		PS/2 Model 85
 F8h	49h	00h	  ???		PS/ValuePoint 325T
 F8h	4Ah	00h	  ???		PS/ValuePoint 425SX
 F8h	4Bh	00h	  ???		PS/ValuePoint 433DX
 F8h	4Eh	00h	  ???		PS/2 Model 295
 F8h	50h	00h	  ???		PS/2 Model P70 (8573) (16 MHz 386)
 F8h	50h	01h	12/16/89	PS/2 Model P70 (8570-031)
 F8h	52h	00h	  ???		PS/2 Model P75 (33 MHz 486)
 F8h	56h	00h	  ???		PS/2 Model CL57 SX
 F8h	57h	00h	  ???		PS/2 Model 90 XP
 F8h	58h	00h	  ???		PS/2 Model 95 XP
 F8h	59h	00h	  ???		PS/2 Model 90 XP
 F8h	5Ah	00h	  ???		PS/2 Model 95 XP
 F8h	5Bh	00h	  ???		PS/2 Model 90 XP
 F8h	5Ch	00h	  ???		PS/2 Model 95 XP
 F8h	5Dh	00h	  ???		PS/2 Model N51 SLC
 F8h	5Eh	00h	  ???		IBM ThinkPad 700
 F8h	61h	***	  ???		Olivetti P500
 F8h	62h	***	  ???		Olivetti P800
 F8h	80h	00h	  ???		PS/2 Model 80 (25 MHz 386)
 F8h	80h	01h	11/21/89	PS/2 Model 80-A21 (25 Mhz 386)
 F8h	81h	00h	  ???		PS/2 Model 55-5502
 F8h	87h	00h	  ???		PS/2 Model N33SX
 F8h	88h	00h	  ???		PS/2 Model 55-5530T
 F8h	97h	00h	  ???		PS/2 Model 55 Note N23SX
 F8h	99h	00h	  ???		PS/2 Model N51 SX
 F8h	F2h	30h	  ???		Reply Model 32
 F8h	F6h	30h	  ???		Memorex Telex
 F8h	FDh	00h	  ???		IBM Processor Complex (with VPD)
 F8h	???	???	  ???		PS/2 Model 90 (25 MHz 486SX)
 F8h	???	???	  ???		PS/2 Model 95 (25 MHz 486SX)
 F8h	???	???	  ???		PS/2 Model 90 (25 MHz 486SX + 487SX)
 F8h	???	???	  ???		PS/2 Model 95 (25 MHz 486SX + 487SX)
 E4h	???	???	  ???		Triumph Adler PC/XT
 E1h	???	???	  ???		??? (checked for by DOS4GW.EXE)
 E1h	00h	00h	  ???		PS/2 Model 55-5530 Laptop
 D9h	???	???	  ???		Peacock XT
 9Ah	*	*	  ???		Compaq XT/Compaq Plus
 30h	???	???	  ???		Sperry PC
 2Dh	*	*	  ???		Compaq PC/Compaq Deskpro
 ???	56h	???	  ???		Olivetti, unknown model
 ???	74h	???	  ???		Olivetti, unknown model
Notes:	BIOS dates may vary without changes to the revision code, especially
	  for non-IBM machines
    * This BIOS call is not implemented in these early versions or under
      Linux's DOSEMU.  Read the Model byte at F000h:FFFEh and BIOS date at
      F000h:FFF5h instead.
   ** These BIOS versions require the DASDDRVR.SYS patches.
  *** These Olivetti and Epson machines store the submodel in the byte at
	F000h:FFFDh.
SeeAlso: #00509,#00516

(Table 00516)
Values for Dell model byte:
 02h	Dell 200
 03h	Dell 300
 05h	Dell 220
 06h	Dell 310
 07h	Dell 325
 09h	Dell 310A
 0Ah	Dell 316
 0Bh	Dell 220E
 0Ch	Dell 210
 0Dh	Dell 316SX
 0Eh	Dell 316LT
 0Fh	Dell 320LX
 11h	Dell 425E
SeeAlso: #00509,#00515

Format of Compaq product information:
Address		Size	Description	(Table 00517)
 F000h:FFE4h	BYTE	product family code (first byte)
 F000h:FFE5h	BYTE	Point release number
 F000h:FFE6h	BYTE	ROM version code
 F000h:FFE7h	BYTE	product family code (second byte)
 F000h:FFE8h	WORD	BIOS type code
SeeAlso: #00518,#00520

Format of Hewlett-Packard ROM ID at F000h:00F8h:
Offset	Size	Description	(Table 00518)
 00h  2 BYTEs	signature "HP" (48h 50h)
 02h  2 BYTEs	00h 00h
 04h	BYTE	secondary code revision
 05h	BYTE	primary code revision
 06h	BYTE	date code, year-1960 (BCD)
 07h	BYTE	date code, week of year (BCD)
SeeAlso: #00517,#00519

Bitfields for Hewlett-Packard product identifier:
Bit(s)	Description	(Table 00519)
 4-0	machine code
	0 original Vectra
	1 ES/12
	2 RS/20
	3 Portable/CS
	4 ES
	5 CS
	6 RS/16
	other reserved
 7-5	CPU type
	0 = 80286
	1 = 8088
	2 = 8086
	3 = 80386
	other reserved
SeeAlso: #00518

Format of Toshiba laptop information:
Offset	Size	Description	(Table 00520)
 00h  8 BYTEs	ASCII product number (e.g. "T2200SX ")
 08h  8 BYTEs	ASCII version number (e.g. "V1.20   ")
 10h  8 BYTEs	ASCII signature string "TOSHIBA "
 18h  8 BYTEs	always zero???
 20h	DWORD	-> built-in BIOS setup program entry point or 0000h:0000h
Note:	this record is located at F000h:E000h
SeeAlso: #00517,#00518

(Table 00521)
Values for Toshiba product ID:
model prodID   version	  date	   product number
 FEh	29h		../..)..   Toshiba T1000LE
 FEh	2Ah		../..*..   Toshiba T1000XE
 FEh	2Bh		../..+..   Toshiba T1000SE
 FEh	2Ch		../..,..   Toshiba T1000
 FEh	2Dh		../..-..   Toshiba T1200F
 FEh	2Dh	V4.00	12/26-87   Toshiba T1200H
 FEh	2Eh		../.....   Toshiba T1100+
 FCh	22h		../.."..   Toshiba T8500
 FCh	26h		01/15&88   Toshiba T5200
 FCh	27h		../..'..   Toshiba T5100
 FCh	28h		../..(..   Toshiba T2000
 FCh	2Ah		12/26*89   Toshiba T1200XE
 FCh	2Bh		../..+..   Toshiba T1600
 FCh	2Ch		../..,..   Toshiba T3100e
 FCh	2Dh		../..-..   Toshiba T3200
 FCh	2Fh		../../..   Toshiba T3100
 FCh	34h	V1.50	02/04494   Toshiba T100X
 FCh	38h		../..8..   Toshiba T2000SXe
 FCh	39h	V1.20	09/16991   Toshiba T2200SX
 FCh	39h	V1.40	10/01992   Toshiba T2200SX
 FCh	3Ch	V1.50	01/28<91   Toshiba T2000SX
 FCh	3Dh		../..=..   Toshiba T3200SXC
 FCh	3Eh		../..>..   Toshiba T3100SX
 FCh	3Fh		../..?..   Toshiba T3200SX
 FCh	40h		../..@..   Toshiba T4500C
 FCh	41h	V1.20	04/05A92   Toshiba T4500     ("T4500SXC" ???)
 FCh	45h	V3.20	04/14E92   Toshiba T4400SX   ("C" or "SXC" on cover)
 FCh	45h		01/13E93   Toshiba T4400SXC
 FCh	46h *		../..F..   Toshiba T6400
 FCh	46h *		../..F..   Toshiba T6400C
 FCh	5Fh	V1.40	01/18_94   Toshiba T3300SL
 FCh	69h		../..i..   Toshiba T1900C    ("T1900CT" ???)
 FCh	6Ah	V1.30	05/19j93   Toshiba T1900     ("T1900S" ???)
 FCh	6Dh	V1.10	12/25m92   Toshiba T1850C
 FCh	6Eh	V1.00	08/19n92   Toshiba T1850
 FCh	6Eh	V1.10	12/25n92   Toshiba T1850
 FCh	6Fh	V1.00	07/17o92   Toshiba T1800
 FCh	6Fh	V1.10	12/25o92   Toshiba T1800
 FCh	7Eh	V1.30	06/17~93   Toshiba T4600C
 FCh	7Fh	V1.40	11/10x94   Toshiba T4600
 FCh	8Ah	V1.30	10/22x93   Toshiba T6600C
 FCh	91h	V1.20	07/15x94   Toshiba T2400CT
 FCh	91h	V5.00	07/28x95   Toshiba T2400CS/CT
 FCh	92h	V5.00	07/28x95   Toshiba T3600CT
 FCh	96h *	V1.40	12/08x94   Toshiba T200
 FCh	96h *	V1.50	12/08x94   Toshiba T200CS	(T200)
 FCh	97h		../..x..   Toshiba T4800CT
 FCh	98h *	V1.10	12/22x93   Toshiba T1910
 FCh	98h *	V2.40	07/12x94   Toshiba T1910/CS	(T19XX)
 FCh	99h		../..x..   Toshiba T4700CS
 FCh	9Bh	V2.30	01/31x94   Toshiba T4700CT
 FCh	9Bh	V2.50	03/22x94   Toshiba T4700CT
 FCh	9Bh	V5.00	07/28x95   Toshiba T4700CT
 FCh	9Ch	V1.30	01/11x94   Toshiba T1950CT
 FCh	9Ch	V2.50	07/22x94   Toshiba T1950CT	(T19XX)
 FCh	9Dh *	V2.40	07/12x94   Toshiba T1950/CS	(T19XX)
 FCh	9Eh *	V1.20	12/25x93   Toshiba T3400
 FCh	9Eh *	V1.30	03/22x94   Toshiba T3400/CT
 FCh	B5h **	V5.10	08/25x95   Toshiba T2110/CS	(T21XX)
 FCh	B5h	V5.10	08/25x95   Toshiba T2130CS/CT	(T21XX)
 FCh	BAh	V1.30	02/16x95   Toshiba T2150CDS/CDT
 FCh	BAh	V5.00	07/27x95   Toshiba T2150CDS/CDT (T2150)
 FCh	BBh **	V1.30	01/25x95   Toshiba T2100/CS/CT
 FCh	BBh **	V5.00	07/27x95   Toshiba T2100/CS/CT
 FCh	BCh	V1.20	12/05x94   Toshiba T2450CT
 FCh	BCh	V5.00	07/28x95   Toshiba T2450CT
 FCh	BEh	V5.00	07/28x95   Toshiba T4850CT
 FCh	C0h	V5.20	05/30x96   Toshiba 420CDS/CDT
 FCh	C1h	V5.20	03/27x96   Toshiba 100CS
 FCh	C3h	V5.60	07/19x96   Toshiba 710CDT / 720CDT
 FCh	C6h	V5.30	11/30x95   Toshiba 410CS/CDT
 FCh	CAh	V5.10	08/18x95   Toshiba 400CS/CDT
 FCh	CAh	V5.40	12/18x95   Toshiba 400CS/CDT
 FCh	CBh	V5.10	09/01x95   Toshiba 610CT
 FCh	CCh	V5.50	06/13x96   Toshiba 700CS/CT
 FCh	CFh	V5.00	08/07x95   Toshiba T4900CT
 FCh	DCh	V5.10	06/17x96   Toshiba 650CT
 FCh	DCh	V5.10	05/10x96   Toshiba 110CS/CT
 FCh	DDh	V5.10	05/10x96   Toshiba 110CS/CT
 FCh	DFh	V5.20	05/27x96   Toshiba 500CS/CDT
 FCh	???	V5.???	../..x..   Toshiba 620CT
 FCh	???	V5.???	../..x..   Toshiba 660CDT
 FCh	???	V5.30	11/22/96   Toshiba 730CDT
 FCh	???	V6.00	09/20/96   Toshiba 200CDS/CDT
 FCh	???	V6.20	11/14/96   Toshiba 430CDS/CDT
 FCh	???	V6.40	12/05/96   Toshiba 510CS/CDT
Notes:	the 8-bit ASCII graphics character in the "date" column above
	  has been substituted by "x" if larger than 80h
	BIOS version numbers and dates may vary, esp. due to harddisk and
	  (flash) BIOS upgrades; all BIOS versions 5.xx are flash updates
	  for Windows95, the product number may indicate the series only
	  (T21XX) or does no longer contain the exact type suffix (CS/CT)
	the most recent versions of the BIOS have stopped including the
	  product ID code in the BIOS date
	[*] These models have monochrome and color versions which can be
	  distinguished with INT 42/AX=7503h (WD90C24 chipset)
	[**] These models have monochrome and color versions which can be
	  distinguished with INT 10/AX=5F50h (CT655xx chipset)
	models not found here like T21x5 are variants differing only in
	  bundled software
SeeAlso: #00515
--------B-15C1-------------------------------
INT 15 - SYSTEM - RETURN EXTENDED-BIOS DATA-AREA SEGMENT ADDRESS (PS)
	AH = C1h
Return: CF set on error
	CF clear if successful
	    ES = segment of data area (see #M0001,#M0004,#M0005)
SeeAlso: AH=04h"ABIOS",MEM 0040h:000Eh"DATA"
--------M-15C200-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - ENABLE/DISABLE
	AX = C200h
	BH = new state
	    00h disabled
	    01h enabled
Return: CF set on error
	AH = status (see #00522)
Note:	IBM classifies this function as required
SeeAlso: AX=C201h,AX=C207h,AX=C208h

(Table 00522)
Values for pointing device function status:
 00h	successful
 01h	invalid function
 02h	invalid input
 03h	interface error
 04h	need to resend
 05h	no device handler installed
--------M-15C201-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - RESET
	AX = C201h
Return: CF set on error
	    AH = status (see #00522)
	CF clear if successful
	    BH = device ID
	    BL = value returned by attached device after reset
		AAh if device is a mouse
Notes:	after successful completion of this call, the pointing device is set
	  as follows: disabled, sample rate 100 Hz, resolution 4 counts/mm,
	  scaling 1:1, unchanged data package size
	this function should be called before rebooting the system (see
	  INT 15/AH=4Fh), since otherwise the mouse may behave erratically on
	  some systems after the boot.	Before calling this function, the 
	  caller should check that the INT 15h vector is in fact initialized
	  (on some very old machines the IVT may contain 0000h:0000h).
	IBM classifies this function as required
SeeAlso: INT 33/AX=0000h,AX=C200h,AX=C207h
--------M-15C202-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET SAMPLING RATE
	AX = C202h
	BH = sampling rate
	    00h 10/second
	    01h 20/second
	    02h 40/second
	    03h 60/second
	    04h 80/second
	    05h 100/second
	    06h 200/second
Return: CF set on error
	    AH = status (see #00522)
SeeAlso: INT 33/AX=001Ch
--------M-15C203-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET RESOLUTION
	AX = C203h
	BH = resolution (see #00523)
Return: CF set on error
	    AH = status (see #00522)

(Table 00523)
Values for pointing device resolution:
 00h	one count per mm
 01h	two counts per mm
 02h	four counts per mm
 03h	eight counts per mm
--------M-15C204-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - GET TYPE
	AX = C204h
Return: CF set on error
	    AH = status (see #00522)
	CF clear if successful
	    BH = device ID
--------M-15C205-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - INITIALIZE
	AX = C205h
	BH = data package size (1 - 8 bytes)
Return: CF set on error
	    AH = status (see #00522)
Note:	the pointing device is set as follows: disabled, 100 Hz sample rate,
	  resolution 4 counts/mm, scaling 1:1
SeeAlso: AX=C201h
--------M-15C206-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - EXTENDED COMMANDS
	AX = C206h
	BH = subfunction
	    00h return device status
		Return: BL = pointing device status (see #00524)
			CL = resolution (see #00523)
			DL = sample rate, reports per second
	    01h set scaling at 1:1
	    02h set scaling at 2:1
Return: CF set on error
	    AH = status (see #00522)

Bitfields for pointing device status:
Bit(s)	Description	(Table 00524)
 0	right button pressed
 1	reserved
 2	left button pressed
 3	reserved
 4	0 if 1:1 scaling, 1 if 2:1 scaling
 5	device enabled
 6	0 if stream mode, 1 if remote mode
 7	reserved
--------M-15C207-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE (PS) - SET DEVICE HANDLER ADDR
	AX = C207h
	ES:BX -> FAR user device handler or 0000h:0000h to cancel
Return: CF set on error
	    AH = status (see #00522)
Note:	when the subroutine is called, it is passed the following values on
	  the stack; the handler should return with a FAR return without
	  popping the stack:
		WORD 1: status (see #00525)
		WORD 2: X data (high byte = 00h)
		WORD 3: Y data (high byte = 00h)
		WORD 4: 0000h
SeeAlso: INT 33/AX=000Ch

Bitfields for pointing device status:
Bit(s)	Description	(Table 00525)
 15-8	reserved (0)
 7	Y data overflowed
 6	X data overflowed
 5	Y data is negative
 4	X data is negative
 3	reserved (1)
 2	reserved (0)
 1	right button pressed
 0	left button pressed
--------M-15C208-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE - WRITE TO POINTER PORT
	AX = C208h
	BL = byte to be sent to the pointing device
Note:	IBM classifies this function as optional
SeeAlso: AX=C200h,AX=C209h
--------M-15C209-----------------------------
INT 15 - SYSTEM - POINTING DEVICE BIOS INTERFACE - READ FROM POINTER PORT
	AX = C209h
Return: BL = first byte read from pointing device
	CL = second byte read
	DL = third byte read
Note:	IBM classifies this function as optional
SeeAlso: AX=C200h,AX=C208h
--------M-15C2-------------------------------
INT 15 - IBM SurePath BIOS - Officially "Private" Function
	AH = C2h
	AL = 10h-23h
SeeAlso: AH=07h"IBM",AH=3Eh"IBM"
--------B-15C3------------------------------
INT 15 - SYSTEM - ENABLE/DISABLE WATCHDOG TIMEOUT (PS50+)
	AH = C3h
	AL = function
	    00h disable PS/2 watchdog timer
	    01h enable PS/2 watchdog timer
		BX = timer counter (0001h-00FFh)
	    02h disable Gearbox system
	    03h enable Gearbox system
Return: CF set on error
	CF clear if successful
Note:	the watchdog timer generates an NMI
SeeAlso: INT 21/AH=2Bh/CX=6269h"WDTSR"
--------B-15C4-------------------------------
INT 15 - SYSTEM - PROGRAMMABLE OPTION SELECT (PS50+)
	AH = C4h
	AL = subfunction
	    00h return base POS register address
	    01h enable selected slot for setup
		BL = slot number (1 to 8)
	    02h disable setup for all slots (enable adapter)
Return: CF set on error
	DX = base POS register address (if subfunction 00h)
SeeAlso: AH=C6h
--------B-15C5-------------------------------
INT 15 UC - OS HOOK - ROM BIOS TRACING CALLOUT (PS30/286,PS50Z,PS95)
	AH = C5h
	AL = interrupt being invoked
	    01h INT 19
	    02h INT 14
	    03h INT 16
	    04h INT 40 (floppy INT 13)
	    05h INT 17
	    06h INT 10
	    07h INT 12
	    08h INT 11
	    09h INT 1A
Return: all registers except AX must be preserved
Notes:	called as the very first action of the indicated ROM BIOS interrupt
	  handlers on the PS/2 Models 30/286, 50Z, and 95
	default handler does nothing and returns CF clear for the above
	  subfunctions, CF set and AH=86h for all other subfunctions
	value of AX passed to the original interrupt handler is pushed on
	  stack immediately prior to call
--------B-15C6-------------------------------
INT 15 U - later PS/2 models - GET POS DATA
	AH = C6h
	???
Return: ???
Notes:	this function is referenced by name and number in some IBM BIOS manuals
	IBM reports that "there are a number of problems with this call" and
	  does not recommend its use.
SeeAlso: AH=C4h
--------B-15C7-------------------------------
INT 15 - SYSTEM - later PS/2s - RETURN MEMORY-MAP INFORMATION
	AH = C7h
	DS:SI -> user supplied memory map table (see #00526)
Return: CF set on error
	CF clear if successful
Notes:	call AH=C0h and examine bit 4 of feature byte 2 to check if this
	  function is supported
	IBM classifies this function as optional
	Windows95 OSR2 reportedly does not support this function even though
	  INT 15/AH=C0h indicates that it is available (observed on several
	  different systems)
SeeAlso: AH=C0h,AH=C9h,AH=D1h,AX=E820h

Format of memory-map table structure:
Offset	Size	Description	(Table 00526)
 00h	WORD	length of table (excluding this word)
 02h	DWORD	local memory between 1M and 16M, in 1K blocks
 06h	DWORD	local memory between 16M and 4G, in 1K blocks
 0Ah	DWORD	system memory between 1M and 16M, in 1K blocks
 0Eh	DWORD	system memory between 16M and 4G, in 1K blocks
 12h	DWORD	cacheable memory between 1M and 16M, in 1K blocks
 16h	DWORD	cacheable memory between 16M and 4G, in 1K blocks
 1Ah	DWORD	1K blocks before start of non-system memory between 1M and 16M
 1Eh	DWORD	1K blocks before start of non-system memory between 16M and 4G
 22h	WORD	start segment of largest free block from C0000h-DFFFFh
 24h	WORD	size of largest free block
 26h	DWORD	reserved
--------B-15C8-------------------------------
INT 15 - SYSTEM - ENABLE/DISABLE PROCESSOR FUNCTIONS
	AH = C8h
	AL = function
	    00h disable L1 cache
	    01h enable L1 cache
	    ---models 90 and 95 only---
	    02h disable L2 cache
	    03h enable L2 cache
	    04h disable both caches
	    05h enable both caches
	    06h return status of both caches
	    07h-FFh Reserved
Return: CF set on error
	CF clear if successful
	AH = status (see #00527)
	For subfunction 06h only:
	    BL = status of L1 cache
		00h enabled
		01h disabled or not installed
		02h disabled due to test error (can not be enabled)
	    BH = status of L2 cache (same codes as BL)
Notes:	 supported by at least PS/2 70, 70/486, 80-A21, 90, 95
	call AH=C0h and examine bit 3 of feature byte 2 to check if this
	  function is supported.
	on a 486 system, any external caches must be disabled when the
	  on-chip cache (L1) is disabled.
SeeAlso: AH=C0h

(Table 00527)
Values for status:
 00h	operation successful
 01h	function choice (in AL) is invalid
 02h	NVRAM data is invalid
 03h	cache test error
 04h	(90 and 95 only) cannot perform operation requested due to state of
	  other cache (also see note above)
 05h	no L2 cache is present
 07h	invalid input values
 09h	CPU in protected mode
--------B-15C9-------------------------------
INT 15 - newer PS/2; various BIOSes - GET CPU TYPE AND MASK REVISION
	AH = C9h
	AL = 10h (may be required on some non-PS BIOSes)
Return: CF clear if successful
	    AH = 00h
	    CH = CPU type (see #00528)
	    CL = mask revision (stepping level) (see #00529)
	CF set on error
	    AH = status (80h,86h = function not supported)
Notes:	the BIOS must save DX at startup in order to be able to support this
	  call; PS/2 Models 56, 57, 90, and 95 are known to support it
	the PS/2 BIOS merely reads CMOS locations 190h (type) and 191h (rev)
	IBM classifies this function as optional
SeeAlso: AX=D100h,AX=DA92h,MEM 0040h:00BCh

(Table 00528)
Values for CPU type:
 03h	80386DX or clone
 04h	80486
 05h	Pentium
 23h	80386SX or clone
 33h	Intel i376
 43h	80386SL or clone
 A3h	IBM 386SLC
 A4h	IBM 486SLC

(Table 00529)
Values for stepping level:
---i376 (type code 33h)---
 05h	A0
 08h	B
---80386/80386DX (type code 03h)---
 03h	Intel B1 to B10, Am386DX/DXL step A
 05h	Intel D0
 08h	Intel D1/D2/E1, Am386DX/DXL step B
---80386SL (type code 43h)---
 05h	A
 1xh	B
---80386SX (type code 23h)---
 04h	Intel A0
 05h	Intel B, Am386SX/SXL step A1
 08h	Intel C/D1, Am386SX/SXL step B
 09h	Intel 386CX/386EX/386SXstatic step A
---80486DX (type code 04h)---
 00h	Intel A0/A1
 01h	Intel B2 to B6
 02h	Intel C0
 03h	Intel C1
 04h	Intel D0
 10h	Intel cA2/cA3, Cx486SLC step A
 11h	Intel cB0/cB1
---486DX2 (type code 04h)---
 02h	Am486DX2 (unknown stepping)
 32h	Intel DX2/Overdrive steps A0 to A2
 33h	Intel DX2/Overdrive step B1
---486SX (type code 04h)---
 20h	Intel A0
 22h	Intel B0
 27h	Intel cA0
 28h	Intel cB0
---486SL (type code 04h)---
 40h	Intel A
---IntelSX2 (type code 04h)---
 5xh	Intel A
---IntelDX4 (type code 04h)---
 8xh	Intel A
---487SX (type code 04h)---
 20h	Intel A0
 21h	Intel B0
---Pentium (type code 05h)---
 0xh	Intel P5 steps Ax (1993)
 1xh	Intel P5 steps Bx (1994)
 2xh	Intel P54C step A
---RapidCAD (type code 03h)---
 40h	A
--------B-15CA-------------------------------
INT 15 U - PS/2 Model 95 - READ/WRITE CMOS MEMORY
	AH = CAh
	AL = function
	    00h read CMOS
		Return: CL = value of CMOS location
	    01h write CMOS
		CL = new value for CMOS location
	BL = CMOS location (0Eh-3Fh)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (see #00530)
Note:	writes do not update the CMOS checksum

(Table 00530)
Values for CMOS read/write error code:
 01h	CMOS lost power or has invalid checksum
 03h	specified location out of range (too high)
 04h	specified location out of range (too low)
 80h	unsupported function (PC)
 86h	unsupported function (XT)
--------B-15CB-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CBh
	???
Return: ???
--------B-15CC-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CCh
	???
Return: ???
--------V-15CCCC-----------------------------
INT 15 U - Toshiba laptops - VCHAD.EXE - INSTALLATION CHECK
	AX = CCCCh
Return: AX = ABCDh if installed
Note:	supported by Toshiba VGA change display utility VCHAD.EXE ver 2.90+
	  older versions have the string "VCHAD" 2 bytes after the address of
	  the INT 15 handler which is hooked by all versions for the SysReq key
SeeAlso: AH=85h
--------B-15CD-------------------------------
INT 15 U - PS/2 Model 95 - RESERVED
	AH = CDh
	???
Return: ???
--------B-15CE--BL00-------------------------
INT 15 - later PS/2s - ALLOCATE DMA ARBITRATION LEVEL
	AH = CEh
	BL = 00h-0Eh arbitration level to be allocated
	     0Fh-FFh reserved
	AL = option byte
	    bit 7-1: reserved (0)
	    bit 0: 0 = need DMA channel for arbitration level requested
		   1 = no channel required for arbitration level
Return: CF set on error
	    AH = status (80h,86h = function not supported)
	CF clear on success
	    AL = channel number
		00h-07h channel number allocated for the arbiration level
		08h-FEh reserved
		FFh	no channel requested for arbitration level
	    AH = status (see #00531)
Notes:	 arbitration level 00h has the highest priority, 0Eh the lowest
	 to perform a DMA transfer operation, be sure to call this function
	   first, and call AH=CFh afterward.  Failure to use this function
	   can cause unpredictable results.
SeeAlso: AH=CFh

(Table 00531)
Values for DMA arbitration status:
 00h	success
 01h	arbitration level not available
 02h	channel not available
 03h	invalid arbitration level passed
--------B-15CF-------------------------------
INT 15 - later PS/2s - DEALLOCATE DMA ARBITRATION LEVEL
	AH = CFh
	BL = arbitration level to be deallocated (see AH=CEh)
Return: CF set on error
	    AH = status (80h,86h = function not supported)
	CF clear on success
	    AH = status
		00h success
		04h arbitration level not allocated
SeeAlso: AH=CEh
--------B-15D0-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D0h
	???
Return: ???
----------15D042BL00-------------------------
INT 15 R - Intel Pentium Pro BIOS UPDATE - INSTALLATION CHECK
	AX = D042h
	BL = 00h
Return: CF clear if successful
	CF set on error
	AH = status
	    00h successful
		EBX:ECX = signature "INTELPEP"
		EDX = BIOS update loader version
		SI = number of 2K update blocks which can be recorded in NVRAM
	    86h not implemented
	AL = OEM error (if AH is not 00h or 86h, otherwise undefined)
	    00h successful
Program: the Pentium Pro BIOS update allows the system BIOS or other software
	  to install a microcode patch into the Pentium Pro processor
Notes:	this API must be called from actual real mode, not V86 mode
	at least 32K stack space must be available when this function is called
SeeAlso: AX=D042h/BL=01h,AX=D042h/BL=02h,AX=D042h/BL=03h
SeeAlso: @xxxxh:xxxxh"Intel BIOS Upgrade",MSR 00000079h
----------15D042BL01-------------------------
INT 15 R - Intel Pentium Pro BIOS UPDATE - WRITE BIOS UPDATE AREA
	AX = D042h
	BL = 01h
	ES:DI -> microcode update block (see #00533)
	CX,DX,SI = segments of three 64K scratchpad areas for BIOS use
Return: CF clear if successful
	CF set on error
	AH = status (see #00532)
	AL = OEM error (if AH is not 00h or 86h, otherwise undefined)
	    00h successful
Notes:	a microcode update may also be initiated by a WRMSR instruction
	  with ECX=0079h, EDX=00000000h, and EAX=linear address of update
	  block (see #00533)
	at least 32K stack space must be available when this function is called
SeeAlso: AX=D042h/BL=00h,AX=D042h/BL=02h,AX=D042h/BL=03h,MSR 00000079h

(Table 00532)
Values for Pentium Pro BIOS update status:
 00h	successful
 86h	not implemented
 90h	unable to erase NVRAM device
 91h	unable to write to NVRAM device
 92h	unable to read storage
 93h	NVRAM is full
 94h	specified processor stepping is not present in system
 95h	invalid header or loader version
 96h	wrong checksum in header
 97h	processor rejected the update
 98h	the same or a more recent update is already stored
 99h	update block number was out of range

Format of Pentium Pro microcode update block:
Offset	Size	Description	(Table 00533)
 00h	DWORD	update header version number (currently 00000001h)
		FFFFFFFFh = unused block
 04h	DWORD	revision number of this microcode update
 08h	DWORD	update creation date, as BCD mmddyyyy (month,day,year)
 0Ch	DWORD	family/model/stepping of processor to which update applied
		(same value as returned by CPUID instruction)
 10h	DWORD	checksum (used to force sum of all 512 DWORDs of the update
		block to 00000000h)
 14h	DWORD	revision number of loader needed to install update
		(currently 00000001h)
 18h 24 BYTEs	reserved for future expansion
 30h 2000 BYTEs	encrypted microcode data
SeeAlso: MSR 00000079h,OPCODE "CPUID"
----------15D042BL02-------------------------
INT 15 R - Intel Pentium Pro BIOS UPDATE - BIOS UPDATE CONTROL
	AX = D042h
	BL = 02h
	BH = function
	    01h enable update loading at initialization time
	    02h check whether update loading is enabled
	CX,DX,SI = segments of three 64K scratchpad areas for BIOS use
Return: CF clear if successful
	CF set on error
	AH = status (see #00532)
	    00h successful
		BL = enabled/disabled flag
	    86h not implemented
	AL = OEM error (if AH is not 00h or 86h, otherwise undefined)
	    00h successful
Notes:	this API must be called from actual real mode, not V86 mode
	at least 32K stack space must be available when this function is called
	there is no call to disable update loading due to security risks; the
	  BIOS setup can disable loading
SeeAlso: AX=D042h/BL=00h,AX=D042h/BL=02h,AX=D042h/BL=03h
----------15D042BL03-------------------------
INT 15 R - Intel Pentium Pro BIOS UPDATE - READ BIOS UPDATE AREA
	AX = D042h
	BL = 03h
	ES:DI -> buffer for microcode update block (see #00533)
	ECX = two real-mode 64K scratchpad segments (upper and lower words)
	DX = segment of 64K scratchpad area for BIOS use
	SI = zero-based index number of update block to retrieve
Return: CF clear if successful
	CF set on error
	AH = status
	    00h successful
		ES:DI buffer filled with 2048-byte update block
	    86h not implemented
	AL = OEM error (if AH is not 00h or 86h, otherwise undefined)
	    00h successful
Program: the Pentium Pro BIOS update allows the system BIOS or other software
	  to install a microcode patch into the Pentium Pro processor
Notes:	this API must be called from actual real mode, not V86 mode
	at least 32K stack space must be available when this function is called
SeeAlso: AX=D042h/BL=00h,AX=D042h/BL=01h,AX=D042h/BL=03h
--------B-15D100DX0000-----------------------
INT 15 - later PS/2s - GET NUMBER OF DEVICE DESCRIPTOR TABLE (DDT) ENTRIES
	AX = D100h
	DX = 0000h (reserved, must set to 0)
Return: BL = size of one DDT entry, in bytes
	CX = number of DDT entries
	AH = return code (see #00534)
	CF set on error
	CF clear on success
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D101h,AX=D102h,AX=D103h,AX=D104h

(Table 00534)
Values for return code:
 00h	success
 01h	requested DDT entry not found
 02h	DDT data not valid
 86h	function not supported
--------B-15D101-----------------------------
INT 15 - later PS/2s - RETURN DEVICE DESCRIPTOR TABLE (DDT) ENTRY BY NUMBER
	AX = D101h
	BX = number of requested entry (starting with 1)
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see #00535)
Return: AH = return code (see #00534)
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D102h,AX=D104h

Format of Device Descriptor Table (DDT):
Offset	Size	Description	(Table 00535)
 00h	BYTE	bits 7-4: reserved (set to 0)
		bits 3-0: slot of device (0 = system board)
 01h	BYTE	bits 7-4: second interrupt for this device (0 = none)
		bits 3-0: first interrupt for this device (0 = none)
 02h	BYTE	bits 7-4: second arbitration level for this device
		bits 3-0: first arbitration level for this device
 03h	WORD	DDT indicators (see #00536)
 05h	BYTE	reserved (0)
 06h	WORD	device ID (0 = none)
 08h	WORD	starting address of first  I/O block (0 = none)
 0Ah	WORD	starting address of second I/O block (0 = none)
 OCh	WORD	starting address of third  I/O block (0 = none)
 OEh	DWORD	start of first non-system memory block (0 = none)
 12h	WORD	size of first non-system memory block (in kilobytes)
 14h	DWORD	start of second non-system memory block (0 = none)
 18h	WORD	size of second non-system memory block (in kilobytes)
 1Ah	BYTE	implementation identifier of the device
 1Bh	BYTE	implementation revision level of the device
Note:	I/O block addresses and non-system memory addresses are listed in
	  ascending order in each DDT entry.

Bitfields for DDT indicators:
Bit(s)	Description	(Table 00536)
 15	reserved (0)
 14	second arbitration level exists
 13	first arbitration level exists
 12	serial interface is RS-422
 11	not address limited
 10	DMA channel used
 9	second arbitration level can be shared
 8	first arbitration level can be shared
 7-0	reserved (0)
--------B-15D102-----------------------------
INT 15 - later PS/2s - RETURN DEVICE DESCRIPTOR TABLE (DDT) ENTRY BY I/O ADDRSS
	AX = D102h
	BX = entry number at which to start searching
	CX = requested I/O port address
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see #00535)
Return: AH = return code (see #00534)
	BX = DDT entry number where I/O port was found, or total entries
	     plus 1 if port was not found.
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
Desc:	the DDT is searched from the specified entry for the I/O port in CX,
	  and the first entry in which it is found is returned
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D101h,AX=D103h,AX=D104h
--------B-15D103DX0000-----------------------
INT 15 - later PS/2s - RETURN ENTIRE DDT
	AX = D103h
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see #00535)
Return: AH = return code (see #00534)
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D104h
--------B-15D104-----------------------------
INT 15 - later PS/2s - RETURN DEVICE DESCRIPTOR TABLE (DDT) ENTRY BY DEVICE ID
	AX = D104h
	BX = entry number at which to start searching
	CX = requested device ID
	DX = 0000h (reserved, must be set to 0)
	ES:DI -> buffer to contain DDT entry (see #00535)
Return: AH = return code (see #00534)
	BX = DDT entry number where device ID was found, or total entries
	      plus 1 if port was not found.
	CF set on error
	CF clear on success
	    ES:DI buffer filled with DDT entry
Desc:	the DDT is searched from the specified entry for the device ID in CX,
	  and the first entry in which it is found is returned.
SeeAlso: AH=C0h,AH=C7h,AH=C9h,AX=D100h,AX=D101h,AX=D103h
--------B-15D2-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D2h
	???
Return: ???
--------B-15D3-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D3h
	???
Return: ???
--------B-15D4-------------------------------
INT 15 - later PS/2s - GET PHYSICAL FIXED DISK DRIVE NUMBER (SELECTABLE BOOT)
	AH = D4h
	DL = logical fixed disk drive number
Return: AH = return code (see #00537)
	CF set on error
	CF clear on success
	    AL = physical fixed disk drive number

(Table 00537)
Values for return code:
 00h	success
 01h	specified logical drive number is invalid
 80h	function not supported (on PCjr and PC)
 86h	function not supported
--------B-15D5-------------------------------
INT 15 - later PS/2s - RESERVED
	AH = D5h
	???
Return: ???
--------B-15D600BL00-------------------------
INT 15 - later PS/2s - READ BOOT DEVICE ID
	AX = D600h
	BL = 00h
	DX = device ID
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=01h,AX=D601h/BL=00h,AX=D602h
--------B-15D600BL01-------------------------
INT 15 - later PS/2s - WRITE BOOT DEVICE ID
	AX = D600h
	BL = 01h
	DX = device ID
Return: CF clear on success
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=00h,AX=D601h/BL=01h
--------B-15D601BL00-------------------------
INT 15 - later PS/2s - READ BOOT DEVICE KEY
	AX = D601h
	BL = 00h
	DX = device ID
Return: CF clear on success
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=00h,AX=D601h/BL=01h,AX=D602h
--------B-15D601BL01-------------------------
INT 15 - later PS/2s - WRITE BOOT DEVICE KEY
	AX = D601h
	BL = 01h
	DX = device ID
Return: CF clear on success
	    AH = 00h
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D600h/BL=01h,AX=D601h/BL=00h
--------B-15D602-----------------------------
INT 15 - later PS/2s - QUERY BOOT REFERENCE PARTITION
	AX = D602h
Return: CF clear on success
	    AH = 00h
	    AL = status of reference-partition boot request
		00h boot not requested
		01h boot requested
	CF set on error
	    AH = status (86h for function not supported)
SeeAlso: AX=D601h/BL=00h
--------X-15D800-----------------------------
INT 15 - EISA SYSTEM ROM - READ SLOT CONFIGURATION INFORMATION
	AX = D800h
	CL = slot number (including embedded and virtual)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (80h,82h,83h,86h,87h)(see #00539)
	AL = bit flags (see #00538)
	BH = major revision level of configuration utility
	BL = minor revision level of configuration utility
	CX = checksum of configuration file
	DH = number of device functions
	DL = combined function information byte (see #00540)
	SI:DI = 4-byte compressed ID (DI = bytes 0&1, SI = bytes 2&3)
Note:	call with AL=80h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D801h,AX=D804h

Bitfields for EISA AL bit flags:
Bit(s)	Description	(Table 00538)
 7	set if duplicate IDs
 6	set if product ID readable
 4,5	slot type (00=expansion, 01=embedded, 10=virtual device)
 0-3	duplicate ID number if bit 7 set
SeeAlso: #00540

(Table 00539)
Values for EISA error code:
 80h	invalid slot number
 81h	invalid function number
 82h	EISA CMOS corrupt
 83h	empty slot
 84h	error clearing CMOS
 85h	EISA CMOS is full
 86h	invalid BIOS-FW function call
 87h	invalid system configuration
 88h	config utility version not supported

Bitfields for EISA combined function information byte:
Bit(s)	Description	(Table 00540)
 7	reserved
 6	slot has free-form data entries
 5	slot has port initialization entries
 4	slot has port-range entries
 3	slot has DMA entries
 2	slot has IRQ entries
 1	slot has memory entries
 0	slot has function type entries
SeeAlso: #00538
--------X-15D801-----------------------------
INT 15 - EISA SYSTEM ROM - READ FUNCTION CONFIGURATION INFORMATION
	AX = D801h
	CH = function number to read
	CL = slot number (including embedded and virtual)
	DS:SI -> 320-byte buffer for standard configuration data block
Return: CF clear if successful
	    AH = 00h
	    DS:SI buffer filled
	CF set on error
	    AH = error code (80h-83h,86h,87h) (see #00539)
	BX destroyed
Note:	call with AL=81h if using 32-bit CS addressing mode instead of 16-bit
	this function is also supported by the Compaq SystemPro 486, but it
	  uses more than 1297 bytes of stack.
BUG:	some implementations appear to destroy the DF direction flag;
	  the Novell DOS 7+ memory managers explicitly clear it afterwards.
--------X-15D802-----------------------------
INT 15 - EISA SYSTEM ROM - CLEAR NONVOLATILE MEMORY (EISA CMOS)
	AX = D802h
	BH = EISA config utility major revision level
	BL = EISA config utility minor revision level
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (84h,86h,88h) (see #00539)
Note:	call with AL=82h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D803h
--------X-15D803-----------------------------
INT 15 - EISA SYSTEM ROM - WRITE NONVOLATILE MEMORY
	AX = D803h
	CX = length of data structure (0000h = empty slot)
		includes two bytes for config file checksum
	DS:SI -> configuration data
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (84h-86h) (see #00539)
Note:	call with AL=83h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D802h
--------X-15D804-----------------------------
INT 15 - EISA SYSTEM ROM - READ PHYSICAL SLOT
	AX = D804h
	CL = slot number (including embedded and virtual)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (80h,83h,86h) (see #00539)
	SI:DI = 4-byte compressed ID (DI = bytes 0&1, SI = bytes 2&3)
Note:	call with AL=84h if using 32-bit CS addressing mode instead of 16-bit
SeeAlso: AX=D800h
--------b-15D820-----------------------------
INT 15 - Compaq LTE Lite - GET ???
	AX = D820h
	DS:SI -> 17-byte buffer for ???
Return: DS:SI buffer filled (first byte is length of remaining data, unless
	  it is greater than 10h, in which case the second byte is 00h and no
	  other data is returned)
Note:	this function is also supported by Compaq's EISA System ROM, Contura
	  486/486c/486cx and recent DESKPRO/i ROMs
SeeAlso: AX=D821h
--------b-15D821-----------------------------
INT 15 - Compaq LTE Lite - SET ???
	AX = D821h
	DS:SI -> counted string (should not be more than 16 bytes)
Return: AH = 00h
Note:	this function is also supported by Compaq's EISA System ROM, Contura
	  486/486c/486cx and recent DESKPRO/i ROMs
SeeAlso: AX=D820h
--------b-15D822BL00-------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - GET ???
	AX = D822h
	BL = 00h
	CX = size of buffer or 0000h to retrieve required buffer size
	DS:SI -> buffer for ??? (if CX nonzero)
Return: CF clear if successful
	    AH = 00h
	    DH = 08h
	    CX = required buffer size to retrieve all data (if CX=0 on entry)
	    DS:SI buffer filled (if CX nonzero on entry)
	CF set on error (BL nonzero)
	    AH = 86h
--------b-15D823-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D823h
	BL = subfunction??? (00h or 80h)
	BH = ???
	DS:SI -> buffer for ??? (see #00541)
Return: CF clear if successful
	    AH = 00h
	    DH = 08h
	    DL = ???
	CF set on error
	    AH = error code
		86h BL neither 00h nor 80h
		87h ???

Format of Compaq EISA buffer:
Offset	Size	Description	(Table 00541)
 00h	BYTE	???
 01h	WORD	???
 03h	BYTE	???
 04h	WORD	???
 06h	WORD	???
	???
----------15D824-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D824h
	CX = ???
	DS:SI -> ASCIZ string containing ???
Return: CF clear if successful
	    AH = 00h
	    CX = ???
	CF set on error
	    AH = error code
		87h ??? failed
		88h ???
Note:	these functions are only available if ??? from keyboard controller
	  command C0h
----------15D825-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D825h
	CX = ???
	SI = ???
	DI = ???
	???
Return: CF clear if successful
	    AH = 00h
	    CX = ???
	CF set on error
	    AH = error code
		87h ??? failed
		88h ???
		    CX = ???
Note:	these functions are only available if ??? from keyboard controller
	  command C0h
----------15D826-----------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - ???
	AX = D826h
	BX = ???
	CX = size of buffer in bytes
	DS:SI -> buffer for ???
	???
Return: CF clear if successful
	    AH = 00h
	    CX = ???
	CF set on error
	    AH = error code
		87h ??? failed
		88h ???
Note:	these functions are only available if ??? from keyboard controller
	  command C0h
--------X-15D8-------------------------------
INT 15 - EISA SYSTEM ROM - 32-bit CS ADDRESSING MODE CALLS
	AH = D8h
	AL = 80h to 84h
	other registers as appropriate for AL=00h to 04h
Return: as appropriate for AL=00h to 04h
Note:	these functions are identical to AX=D800h to D804h, except that they
	  should be called when using 32-bit CS addressing mode (pointers use
	  ESI rather than SI as offset) instead of 16-bit addressing mode
SeeAlso: AX=D800h,AX=D801h,AX=D802h,AX=D803h,AX=D804h
--------b-15D8-------------------------------
INT 15 - Compaq EISA System ROM 04/08/93 - 32-bit CS ADDRESSING MODE CALLS
	AH = D8h
	AL = A0h to A6h
	other registers as appropriate for AL=20h to 26h
Return: as appropriate for AL=20h to 26h
Note:	these functions are identical to AX=D820h to D826h, except that they
	  should be called when using 32-bit CS addressing mode
----------15DA-------------------------------
INT 15 U - AMI PCI BIOS v1.00.05.AX1 - ???
	AH = DAh
	AL = function (00h-08h,12h,14h,15h,19h,88h-8Eh,92h,99h)
	other registers vary by function
Return: CF clear if successful
	    varies by function
	CF set on error
	    AH = error code (86h unsupported [sub]function)
Note:	functions not listed above always return CF set and AH=86h; in the
	  examined BIOS, functions 02h-04h,06h-07h,89h-8Bh, and 8Dh also
	  always return CF set and AH=86h
SeeAlso: AX=DA00h,AX=DA01h,AX=DA88h,AX=DA99h,AX=DB00h
--------b-15DA00-----------------------------
INT 15 U - AMI PCI BIOS - ???
	AX = DA00h
	CL = subfunction
	    00h ???
	    01h ???
	    02h get ???
	???
Return: CF clear if successful
	    ???
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	in the v1.00.05.AX1 BIOS, subfunctions 00h and 01h always return
	  failure
SeeAlso: AX=DA01h
--------b-15DA01-----------------------------
INT 15 U - AMI PCI BIOS - CPU SPEED CONTROL
	AX = DA01h
	CL = subfunction (00h-02h)
	    00h set low CPU speed
	    01h set high CPU speed
	    02h get current CPU speed
Return: CF clear if successful
	    AH = current/new CPU speed (00h low, 01h high)
	    AL = ??? (00h)
	CF set on error
	    AH = error code (86h unsupported subfunction)
Notes:	in the v1.00.05.AX1 BIOS, subfunctions 00h and 01h are NOPs in both
	  protected and V86 modes due to a test of MSW bit 0
	setting the CPU speed also generates the same audible signals generated
	  when manually switching speeds with Ctrl-Alt-Gray- and Ctrl-Alt-Gray+
BUG:	the BIOS apparently intends to return CF set if ???, but fails to use
	  a different exit path in that case, resulting in CF clear
----------15DA05-----------------------------
INT 15 U - AMI PCI BIOS - GET ??? AND BIOS REVISION STRINGS
	AX = DA05h
	ES:SI -> 8-byte buffer for ??? and BIOS revision strings
Return: CF clear
	ES:SI buffer filled
	AL = 00h
	CX = ??? (0000h)
Notes:	for BIOS v1.00.05.AX1, the ??? string is "IDNO" and the BIOS revision
	  string is "AX1 "
SeeAlso: AX=DA15h,AX=DB04h
----------15DA08-----------------------------
INT 15 U - AMI PCI BIOS - ???
	AX = DA08h
	???
Return: CF clear if successful
	    ???
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	in the examined v1.00.05.AX1 BIOS, this call always returns failure
----------15DA12-----------------------------
INT 15 U - AMI PCI BIOS - v1.00.05.AX1 - ???
	AX = DA12h
	CL = subfunction
	    00h ???
	    01h	???
	    02h get ???
	    03h ???
	    04h ???
	???
Return: CF clear if successful
	    ???
	CF set on error
	    AH = error code (86h unsupported subfunction)
Desc:	??? performs various manipulations on system chipset registers
Notes:	subfunctions 00h and 01h are NOPs in protected and V86 modes due to
	  a test of MSW bit 0
	subfunctions 00h-02h always return success
----------15DA14-----------------------------
INT 15 U - AMI PCI BIOS - GET/SET ???
	AX = DA14h
	CL = subfunction
	    00h read
	    01h write
		DH = new value for ??? (00h-02h)
	DL = index of ??? (00h-03h, but not range-checked)
	???
Return: CF clear if successful
	    DH = current value of ??? if reading
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	the values for indexes 00h and 01h are stored in CMOS RAM location 19h,
	  and the values for 02h and 03h are stored in location 36h
BUG:	the v1.00.05.AX1 BIOS range-checks DH on subfunction 00h instead of
	  subfunction 01h, even though DH is never used by subfunction 00h
----------15DA15-----------------------------
INT 15 U - AMI PCI BIOS - GET ??? AND BIOS REVISION STRINGS
	AX = DA15h
	ES:DI -> 8-byte buffer for ??? and BIOS revision strings
Return: CF clear
	ES:DI buffer filled
	AL = 00h
Note:	for BIOS v1.00.05.AX1, the ??? string is "IDNO" and the BIOS revision
	  string is "AX1 "
SeeAlso: AX=DA05h,AX=DB04h
----------15DA19-----------------------------
INT 15 U - AMI PCI BIOS - GET/SET ???
	AX = DA19h
	CL = subfunction
	    00h get first ???
	    01h get second ???
	    02h set first ???
		BX = ???
		DX = ???
	    03h set second ???
		BX = ???
		DX = ???
Return: CF clear if successful
	    AX = 0000h
	    BX,DX = ??? (subfunctions 00h and 01h only)
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	the first ??? is stored in CMOS RAM locations 1Bh-1Eh, the second in
	  locations 1Fh-22h in the v1.00.05.AX1 BIOS
--------b-15DA20-----------------------------
INT 15 U - AMI PCI BIOS v1.00.12.AX1T - CMOS RAM BITFIELD MANIPULATION
	AX = DA20h
	BL = subfunction
	    00h set CMOS data field
		BH = CMOS data field number (00h-4Dh)
		CH = new value for bitfield (in lowest bits of register)
	    01h read CMOS data field
		BH = CMOS data field number (00h-4Dh)
		Return: CH = value of bitfield
			CL = mask of valid bits
		Note:	both CL/CH shifted to move valid bits into lowest pos
	    02h set CMOS byte
		CL = CMOS RAM address (00h-7Fh)
		CH = new value for CMOS byte
	    03h get CMOS byte
		CL = CMOS RAM address (00h-7Fh)
		Return: CH = value of CMOS byte
	    04h update CMOS checksums
		Note:	sets 2Eh/2Fh to checksum of 10h-2Dh and 7Eh/7Fh to
			  checksum of 48h-7Dh
	    05h verify CMOS checksums
		Return:	CF clear if checksums OK
			    AH = 00h
			CF set if checksum mismatch
			    AH = 01h
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (86h unsupported function/data field)
Notes:	this function was not supported by the v1.00.05.AX1 BIOS, but had been
	  added by 1.00.12.AX1T
	after using subfunctions 00h or 02h, the application must call
	  subfunction 04h to update the checksums to prevent an error the next
	  time the system is booted

(Table 00542)
Values for AMI BIOS v1.00.12.AX1T CMOS bitfield identifier:
 ID	address	bit(s)	contents
 00h	1Ah	7-6
 01h	1Dh	7-6
 02h	6Eh	1
 03h	77h	0
 04h	77h	1
 05h	77h	2
 06h	77h	3
 07h	77h	5
 08h	77h	6
 09h	77h	7
 0Ah	78h	7	power management enabled???
 0Bh	78h	6
 0Ch	10h	7-4	first floppy drive type
 0Dh	10h	3-0	second floppy drive type
 0Eh	11h	7
 0Fh	20h	4-0	selected language for error messages/setup utility
 10h	11h	2-1
 11h	11h	4
 12h	11h	0
 13h	11h	3
 14h	13h	7
 15h	13h	6-5
 16h	13h	4-2
 17h	19h	7
 18h	19h	6
 19h	19h	5
 1Ah	19h	4
 1Bh	1Eh	2-0
 1Ch	1Bh	7-6
 1Dh	1Ch	7
 1Eh	1Ch	3
 1Fh	1Ah	5-4
 20h	1Dh	5-4
 21h	1Bh	5-4
 22h	1Ch	6
 23h	1Ch	2
 24h	1Ah	3-2
 25h	1Dh	3-2
 26h	1Bh	3-2
 27h	1Ch	5
 28h	1Ch	1
 29h	1Ah	1-0
 2Ah	1Dh	1-0
 2Bh	1Bh	1-0
 2Ch	1Ch	4
 2Dh	1Ch	0
 2Eh	50h	7-0
 2Fh	51h	7-0
 30h	52h	7-0
 31h	53h	7-0
 32h	60h	0
 33h	60h	0
 34h	60h	0
 35h	60h	0
 36h	60h	0
 37h	60h	0
 38h	60h	1
 39h	61h	7
 3Ah	60h	2
 3Bh	61h	6-4
 3Ch	61h	2-0
 3Dh	60h	7-6
 3Eh	60h	5-4
 3Fh	78h	5-4
 40h	6Eh	5
 41h	1Eh	3
 42h	6Eh	0
 43h	6Eh	2
 44h	6Fh	1-0
 45h	6Fh	1-0
 46h	28h	4-2
 47h	28h	7-5
 48h	6Eh	4
 49h	6Eh	3
 4Ah	76h	7-0
 4Bh	77h	4
 4Ch	11h	6
 4Dh	1Fh	7-0
----------15DA88-----------------------------
INT 15 U - AMI PCI BIOS - GET EXTENDED MEMORY SIZE
	AX = DA88h
Return: CF clear (successful)
	AX = 0000h
	CL:BX = extended memory size in KBytes
SeeAlso: AH=88h
----------15DA8C-----------------------------
INT 15 U - AMI PCI BIOS - GET BIOS AND CHIPSET IDENTIFICATION
	AX = DA8Ch
	CL = subfunction
	    00h get BIOS version string
		ES:DI -> 12-byte buffer for version string
	    01h get chipset identification
		BL = what to retrieve
		    (00h host/PCI bridge,01h motherboard chipset)
		ES:DI -> 12-byte buffer for chipset identification (see #00543)
Return: CF clear if successful
	    ES:DI buffer filled
	CF set on error
	    AH = error code (86h unsupported subfunction)
Notes:	the v1.00.05.AX1 BIOS returns "1.00.05.AX1 " as its version string
	subfunction 01h returns the five bytes read from the PCI configuration
	  registers 00h-05h (see #00878), padded to 12 bytes with NULs
SeeAlso: AX=DB04h,PORT C000h"Neptune"

Format of AMI PCI BIOS chipset identification:
Offset	Size	Description	(Table 00543)
 00h	WORD	vendor ID (see #00732 at AX=B102h)
		8086h = Intel
 02h	WORD	device ID
		0484h (BL=01h)
		04A3h (BL=00h)
 04h	BYTE	low byte of PCI Command Register
 05h  7 BYTEs	unused (00h)
----------15DA8E-----------------------------
INT 15 U - AMI PCI BIOS - ???
	AX = DA8Eh
	???
Return: CF clear if successful
	    ???
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	in the	v1.00.05.AX1 BIOS, this call always returns failure
----------15DA92-----------------------------
INT 15 U - AMI PCI BIOS - GET CPU TYPE AND SPEED
	AX = DA92h
Return: CF clear (successful)
	AL = CPU stepping (see also #00529 at INT 15/AH=C9h)
	AH = CPU model
	BL = CPU family (05h = Pentium, etc.)
	CX = external clock speed in MHz (BCD)
	    (0040h,0050h,0060h,0066h are possible return values on my
	      Pentium with the Intel "Neptune" chipset)
	EAX high word destroyed
Note:	90 MHz and faster Pentium CPUs can be configured to run at varying
	  multiples of the external clock speed, i.e. a typical 90 MHz Pentium
	  system will run the motherboard at 60 MHz (my 90 MHz Pentium returns
	  0060h in CX)
SeeAlso: AH=C9h
----------15DA99-----------------------------
INT 15 U - AMI PCI BIOS - GET/SET ??? FLAG
	AX = DA99h
	CL = subfunction
	    00h check if ???
	    01h set ??? flag
	    02h clear ??? flag
Return: CF clear if successful
	    AH = ??? (00h,01h)
	    AL = 00h
	CF set on error
	    AH = error code (86h unsupported subfunction)
Note:	the flag is stored in bit 0 of CMOS RAM location 2Ch for BIOS
	  v1.00.05.AX1
--------b-15DB00-----------------------------
INT 15 U - AMI BIOS - Flash ROM - READ FLASH BIOS
	AX = DB00h
	DS:SI -> parameter block (see #00544)
	ES:DI -> buffer for copied information
Return: CF clear if successful
	CF set on error
	    AH = status (86h if not implemented)
	DS,ES destroyed, possibly other registers
Note:	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AH=DAh,AX=DB01h,AX=DB04h

Format of AMI BIOS Flash ROM parameter block:
Offset	Size	Description	(Table 00544)
 00h 32 BYTEs	ASCIZ description of the file's contents
 20h	BYTE	Logical area type (see #00545)
 21h	DWORD	logical area size (overall size of area)
 25h	BYTE	flag: load from file (FF=yes, 00=no)
 26h	BYTE	flag: reboot after update (FF=yes, 00=no)
 27h	BYTE	flag: update entire image (FF=yes, 00=no)
 28h 24	BYTEs	ASCIZ logical area name (cooresponds to offset 20)
		"System BIOS"
		"Logo Data Area", etc.
 40h 15 BYTEs	ASCIZ time stamp string: MM/DD/YY-HH:MM
 4Fh	BYTE	checksum for this header (sum of all bytes except this one)
		if checksum would be 00h,01h, or FFh, it is set to 2Ah
 50h	DWORD	this file's starting address (offset in image)
 54h	DWORD	size of image chunk in this file
 58h	BYTE	logical area type - same as offset 20h
 59h	BYTE	flag: last file in chain (FF=yes, 00=no)
 5Ah  6 BYTEs	ASCIZ signature "FLASH"
 60h 16 BYTEs	ASCIZ filename of next file in chain
 70h 16 BYTEs	ASCIZ BIOS reserved string (usually version #)
Notes:	this block is identical in format to the 128-byte header on an AMI
	  BIOS Update file
	for AX=DB00h, the following fields must be specified: 50h,54h,58h;
	  the fields at offset 20h and 5Ah should also be set if possible
	the fields at offsets 40h and 70h will be set on return, if available
SeeAlso: #00546
--------b-15DB01-----------------------------
INT 15 U - AMI BIOS - Flash ROM - GET BIOS SUBSYSTEM INFORMATION
	AX = DB01h
	CL = BIOS subsystem information identifier (see #00545)
Return: CF clear if successful
	    AX = 0000h
	    ES:DI -> 56-byte record describing subsystem (see #00546)
	CF set on error
	    AH = status
		01h nonexistent subsystem
		86h function not supported
	    AL = 00h
Note:	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AX=DB00h,AX=DB02h

(Table 00545)
Values for AMI BIOS subsystem identifier:
 00h	recovery code
 01h	system BIOS
 02h	PCI configuration data
 03h	OEM logo data area (see #00547)
 04h	system BIOS/Language Set (one system)
	configuration utility (another system)
SeeAlso: #00546

Format of AMI BIOS subsystem information:
Offset	Size	Description	(Table 00546)
 00h	BYTE	subsystem identifier/logical area type (see #00545)
 01h	DWORD	subsystem (FlashROM page) size in bytes
 05h	BYTE	flag: loadable from file (FFh=yes)
 06h	BYTE	flag: reboot after update (FFh=yes)
 07h	BYTE	flag: update entire image (FFh=yes)
 08h 24 BYTEs	subsystem/logical area name
 20h	BYTE	subsystem identifier???
 21h	BYTE	flag: reprogrammable if FFh
 22h	BYTE	??? (01h,02h seen)
 23h  5 BYTEs	??? (apparently always 00h)
 28h 16 BYTEs	BIOS reserved string (usually version number)
SeeAlso: #00544

Format of AMI OEM Logo data area:
Offset	Size	Description	(Table 00547)
 00h  8 BYTEs	signature
		"TEXTLOGO" if text-mode OEM logo
		8 DUP (FFh) if unused
 08h	WORD	offset of logo font definition table
 0Ah	WORD	offset of logo data
 0Ch	WORD	size of logo font table in words
 0Eh	WORD	offset of upper left corner of logo in video page
 10h	WORD	width of logo
 12h	WORD	height of logo
 14h	BYTE	reserved???
 var	var	logo font definition (16 bytes per character)
 var	var	logo data as character/attribute pairs
Note:	the attribute for the logo characters specifies which font will be used
	  for that character.  If bit 3 is cleared, the normal system font is
	  used; if bit 3 is set, the logo font is used, with screen colors
	  adjusted to match the corresponding non-bright attribute for the
	  system font
SeeAlso: #00545,#00546
--------b-15DB02-----------------------------
INT 15 U - AMI BIOS - Flash ROM - GET SIZE OF FLASH ROM PROGRAMMING CODE
	AX = DB02h
Return: CF clear
	AX = 0000h
	BX = size of ROM programming code in bytes
Note:	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AX=DB00h,AX=DB03h
--------b-15DB03-----------------------------
INT 15 U - AMI BIOS - Flash ROM - GET FLASH ROM PROGRAMMING CODE
	AX = DB03h
	DS:SI -> ???
	ES:DI -> buffer for Flash ROM programming code
	BX = ???
	DX = ???
Return: CF clear if successful
	    AH = ???
	    BX = ???
	    DX = ???
	CF set on error
	    AH = error code
Notes:	the entry point for the copied code (which is fully relocatable) is
	  the very first byte (see #00548)
	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AX=DB00h,AX=DB02h

(Table 00548)
Call AMI BIOS ??? code with:
	AL = function
	    00h erase Flash ROM block
		CX = ???
			bit 8: address line A16 inverted
		???
	    01h program new data into Flash ROM
		???
	    02h perform cold reboot
	DS:SI -> ??? (see #00549)
	ES:DI -> ???
Return: AH = status
	    00h successful
	    01h invalid function
	    02h ???
	    03h ???
	    04h ???
Note:	DS:SI and ES:DI are ignored for function 02h

Format of AMI BIOS Flash ROM programming parameters:
Offset	Size	Description	(Table 00549)
 00h 32 BYTEs	???
 20h	BYTE	BIOS section number
 21h	DWORD	length of BIOS code/data in bytes
 25h 43 BYTEs	???
 50h	DWORD	???
 54h 44 BYTEs	???
SeeAlso: #00548
--------b-15DB04-----------------------------
INT 15 U - AMI BIOS - Flash ROM - GET BIOS REVISION
	AX = DB04h
Return: CF clear if supported
	    BL:BH:DL:DH = BIOS revision string
		(e.g. 'AX1 ' for v1.00.05.AX1, 'AV0M' for v1.00.03.AV0M)
	    CL = flag: DH valid?
		00h ignore DH; ignore DL as well if 20h (space)
		01h ignore DH if 20h (space)
	    CH = BIOS status
		00h normal mode
		01h ROM recovery mode
	    AL = ??? (02h)
Note:	used by FMUP.EXE, Intel's Flash Memory Update utility
SeeAlso: AX=DA05h,AX=DA15h,AX=DA8Ch,AX=DB00h,AX=DB03h
--------Q-15DE00-----------------------------
INT 15 - DESQview - GET PROGRAM NAME
	AX = DE00h
Return: AX = offset into DESQVIEW.DVO of program most recently selected from
	      the "Switch Windows" menu (see #00550)
Note:	always returns AX=0000h under DESQview/X
SeeAlso: AX=DE07h

Format of program entry in DESQVIEW.DVO:
Offset	Size	Description	(Table 00550)
 00h	BYTE	length of name (FFh if end of file)
 01h  N BYTEs	name
      2 BYTEs	keys to invoke program (second = 00h if only one key used)
	BYTE	program type
		00h normal program
		04h divider
		80h Delete a Program
		81h Change a Program
	WORD	??? apparently always 0000h
--------Q-15DE01-----------------------------
INT 15 - DESQview - UPDATE "OPEN WINDOW" MENU
	AX = DE01h
Return: nothing
Notes:	reads DESQVIEW.DVO, disables Open menu if file not in current directory
	NOP for DESQview/X
--------Q-15DE02-----------------------------
INT 15 - DESQview 1.x only - SET ??? FLAG FOR CURRENT WINDOW
	AX = DE02h
Return: nothing
Note:	this call is a NOP in DV 2.x
SeeAlso: AX=DE03h
--------Q-15DE03-----------------------------
INT 15 - DESQview 1.x only - GET ??? FOR CURRENT WINDOW
	AX = DE03h
Return: AX = ??? for current window
	BX = ??? for current window
Note:	this call is a NOP in DV 2.x
SeeAlso: AX=DE02h
--------Q-15DE04-----------------------------
INT 15 - DESQview - GET AVAILABLE COMMON MEMORY
	AX = DE04h
Return: BX = bytes of common memory available
	CX = largest block available
	DX = total common memory in bytes
SeeAlso: AX=DE05h,AX=DE06h
--------Q-15DE05-----------------------------
INT 15 - DESQview - GET AVAILABLE CONVENTIONAL MEMORY
	AX = DE05h
Return: BX = KB of memory available
	CX = largest block available
	DX = total conventional memory in KB
SeeAlso: AX=DE04h,AX=DE06h
--------Q-15DE06-----------------------------
INT 15 - DESQview - GET AVAILABLE EXPANDED MEMORY
	AX = DE06h
Return: BX = KB of expanded memory available
	CX = largest block available
	DX = total expanded memory in KB
SeeAlso: AX=DE04h,AX=DE05h
--------Q-15DE07-----------------------------
INT 15 - DESQview - "APPNUM" - GET CURRENT PROGRAM'S NUMBER
	AX = DE07h
Return: AX = number of program as it appears on the "Switch Windows" menu
Note:	this API call may be made from a hardware interrupt handler
SeeAlso: AX=DE00h
--------Q-15DE08-----------------------------
INT 15 - DESQview - GET ???
	AX = DE08h
Return: AX = 0000h if ??? is not set to the current task
	     0001h if ??? is set to the current task
--------Q-15DE09-----------------------------
INT 15 - DESQview - UNIMPLEMENTED
	AX = DE09h
Return: nothing (NOP in DV 1.x and 2.x)
--------Q-15DE0A-----------------------------
INT 15 - DESQview v2.00+ - "DBGPOKE" - DISPLAY CHARACTER ON STATUS LINE
	AX = DE0Ah
	BL = character
Return: character displayed, next call will display in next position (which
	wraps back to the start of the line if off the right edge of screen)
Notes:	displays character on bottom line of *physical* screen, regardless
	  of current size of window (even entirely hidden)
	does not know about graphics display modes, just pokes the characters
	  into display memory
	this API call may be made from a hardware interrupt handler
SeeAlso: AX=1003h
--------Q-15DE0B-----------------------------
INT 15 - DESQview v2.00+ - "APILEVEL" - DEFINE MINIMUM API LEVEL REQUIRED
	AX = DE0Bh
	BL = API level minor version number
	BH = API level major version number
Return: AX = maximum API level (AH = major, AL = minor)
Notes:	if the requested API level is greater than the version of DESQview, a
	  "You need a newer version" error window is popped up
	the API level defaults to 1.00, and is inherited by child tasks
--------Q-15DE0C-----------------------------
INT 15 - DESQview v2.00+ - "GETMEM" - ALLOCATE "SYSTEM" MEMORY
	AX = DE0Ch
	BX = number of bytes
Return: ES:DI -> allocated block or 0000h:0000h (DV 2.26+)
Note:	use SETERROR (AX=DE15h) to avoid a user prompt if there is insufficient
	  system memory
SeeAlso: AX=1001h,AX=102Eh,AX=DE0Dh,AX=DE15h,AX=DE19h
--------Q-15DE0D-----------------------------
INT 15 - DESQview v2.00+ - "PUTMEM" - DEALLOCATE "SYSTEM" MEMORY
	AX = DE0Dh
	ES:DI -> previously allocated block
Return: nothing
SeeAlso: AX=1002h,AX=DE0Ch
--------Q-15DE0E-----------------------------
INT 15 - DESQview v2.00+ - "FINDMAIL" - FIND MAILBOX BY NAME
	AX = DE0Eh
	ES:DI -> name to find (see #00551)
	CX = length of name
Return: BX = 0000h not found
	     0001h found
		DS:SI = object handle
SeeAlso: AH=12h/BH=11h,AH=12h/BH=12h"GETNAME"

(Table 00551)
Values for special DESQview mailbox names:
 "COM1" ... "COM4"	RBcomm using COM1 ... COM4
 "DESQview/X Help Engine"
 "DESQview/X Network Server"  Network Manager
 "DESQview X Server0"	X-Windows server
 "DESQview X Server7"	X-Windows printing service
 "INBOX"		DESQview/X LPD requests
 "OUTBOX"		DESQview/X LPD responses
 "WAITBOX"		semaphore to synchronize DESQview/X LPD communications
 "_DVNM_"		DV/X v1.10 network manager
--------Q-15DE0F-----------------------------
INT 15 - DESQview v2.00+ - ENABLE DESQview EXTENSIONS
	AX = DE0Fh
Return: AX and BX destroyed (seems to be bug, weren't saved&restored)
Notes:	sends a manager stream with opcodes AEh, BDh, and BFh to task's window
	enables an additional mouse mode
--------Q-15DE10-----------------------------
INT 15 - DESQview v2.00+ - "PUSHKEY" - PUT KEY INTO KEYBOARD INPUT STREAM
	AX = DE10h
	BH = scan code
	BL = character
Return: nothing
Notes:	a later read will get the keystroke as if it had been typed by the user
	multiple pushes are read last-in first-out
	if a script exists for the pushed key in the current application, the
	  script will be executed
	early copies of DV 2.00 destroy AX, BX, ES, and DI
SeeAlso: INT 16/AH=05h
--------Q-15DE11BL00-------------------------
INT 15 - DESQview v2.00+ - "JUSTIFY" - EN/DISABLE AUTOM. WINDOW JUSTIFICATION
	AX = DE11h
	BL = 00h      viewport will not move automatically
	     nonzero  viewport will move to keep cursor visible (default)
Return: nothing
--------Q-15DE12BX0000-----------------------
INT 15 - DESQview v2.01+ - "CSTYLE" - SET "C"-COMPATIBLE CONTROL CHAR INTERPRET
	AX = DE12h
	BX = 0000h    select normal style (linefeed only moves down)
	     nonzero  select C style (linefeed moves to start of next line)
Return: nothing
Note:	set on a per-task basis, and inherited from the parent task
--------Q-15DE13-----------------------------
INT 15 - DESQview v2.20+ - "GETCRIT" - GET CRITICAL NESTING COUNT
	AX = DE13h
Return: BX = number of calls to BEGINC or ENTERC
	      (see INT 15/AX=101Bh,INT 15/AX=DE1Ch) without matching ENDC
	      (see INT 15/AX=101Ch)
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=101Ch,AX=DE1Bh,AX=DE1Ch
--------Q-15DE14-----------------------------
INT 15 - DESQview v2.20+ - GET OBJECT TYPE
	AX = DE14h
	ES:DI -> object
Return: BL = 00h not an object
	     08h window or task
	     09h mailbox
	     0Ah keyboard
	     0Bh timer
	     0Ch objectq
	     0Fh pointer
	     10h panel
SeeAlso: AX=1016h
--------Q-15DE15-----------------------------
INT 15 - DESQview v2.20+ - SET ERROR HANDLING
	AX = DE15h
	BL = error handling mode
	    00h post system error on all error conditions
	    01h return carry flag set on calls to ADDTO, SUBFROM, and WRITE
		messages sent to mailboxes which fail due to lack of system
		or common memory
	    02h (v2.26+) same as 01h, but also return null pointer for GETMEM
		calls which fail due to lack of system memory
Return: nothing
SeeAlso: AX=DE0Ch,AX=DE16h
--------Q-15DE16-----------------------------
INT 15 - DESQview v2.20+ - GET ERROR HANDLING
	AX = DE16h
Return: BL = current mode
	    00h always post system error
	    01h return carry flag set on failed mailbox writes
	    02h return CF set on failed mailbox writes and NULL on failed
		GETMEM calls
SeeAlso: AX=DE15h
--------Q-15DE17-----------------------------
INT 15 - DESQview v2.20-2.25 - reserved
	AX = DE17h
Return: pops up "Programming error" window
Note:	AX = 1117h is NOT identical to this call under DESQview 2.20 thru 2.25
SeeAlso: AX=1117h
--------Q-15DE17-----------------------------
INT 15 - DESQview v2.26+ - "ASSERTMAP" - GET/SET MAPPING CONTEXT
	AX = DE17h
	BX = function
	    0000h   get current mapping context without setting
	    nonzero set new mapping context to BX
Return: BX = mapping context in effect before call
Notes:	mapping contexts determine conventional-memory addressability; setting
	  a mapping context ensures that the associated program and data areas
	  are in memory for access.  Usable by drivers, TSRs and shared
	  programs.
	caller need not be running under DESQview
	this API call may be made from a hardware interrupt handler
SeeAlso: AX=1016h,AX=1117h,AX=DE21h,INT 2F/AX=1685h
--------Q-15DE18-----------------------------
INT 15 - DESQview v2.20+ - internal - ???
	AX = DE18h
	BP = function number
	    high byte must be 10h
	    low byte is function
		00h set ???
		    BL = ???  (00h-10h, video mode???)
		    BH = value to store
		03h set ???
		    BL = ??? (stored in driver)
		0Ah get ???
		    ES:DI -> 18-byte buffer to hold ???
Note:	calls video driver (NOP for Hercules driver,probably CGA and MCGA also)
--------Q-15DE19-----------------------------
INT 15 - DESQview v2.23+ - "GETCOMMON" - ALLOCATE "COMMON" MEMORY
	AX = DE19h
	BX = number of bytes to allocate
Return: AX = 0000h successful
		ES:DI -> allocated block
	     nonzero insufficient memory
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=DE0Ch,AX=DE15h,AX=DE1Ah
--------Q-15DE1A-----------------------------
INT 15 - DESQview v2.23+ - "PUTCOMMON" - DEALLOCATE "COMMON" MEMORY
	AX = DE1Ah
	ES:DI -> previously allocated block
Return: AX = 0000h (successful)
Note:	this function may be called from within a hardware interrupt handler
SeeAlso: AX=DE0Dh,AX=DE19h
--------Q-15DE1B-----------------------------
INT 15 - DESQview v2.23+ internal - DECREMENT CRITICAL NESTING COUNT
	AX = DE1Bh
Return: nothing
SeeAlso: AX=101Ch,AX=DE13h,AX=DE1Ch
--------Q-15DE1C-----------------------------
INT 15 - DESQview v2.23+ - "ENTERC" - INCREMENT CRITICAL NESTING COUNT
	AX = DE1Ch
Return: nothing
Notes:	similar to AX=101Bh, but begins the critical region without ensuring
	  that DOS is free
	the official documentation states that this call should be paired with
	  "ENDC" (AX=101Ch); no mention is made of AX=DE1Bh
	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=101Bh,AX=101Ch,AX=DE13h,AX=DE1Bh
--------Q-15DE1D-----------------------------
INT 15 - DESQview v2.23+ - "PUTKEY" - FAKE USER KEYSTROKES
	AX = DE1Dh
	DX = segment of handle for task to receive keystroke
	BL = character
	BH = scan code
Return: AX = 0000h if successful
	   nonzero if receiver's keyboard buffer was full
Notes:	the key is treated as though the user had pressed it, ignoring any
	  script which may be bound to the key, and using the current field
	  table if the keyboard object is in field processing mode
	multiple PUTKEYs are seen in the order in which they are executed
SeeAlso: AX=DE10h
--------Q-15DE1E-----------------------------
INT 15 - DESQview v2.23+ - "SCRNINFO" - GET TRUE VIDEO PARAMETERS
	AX = DE1Eh
Return: CL = actual number of rows on screen
	CH = actual number of columns on screen
	BL = actual video mode (may differ from INT 10/AH=0Fh return) (v2.26+)
Note:	this API call may be made from a hardware interrupt handler
SeeAlso: INT 10/AH=0Fh
--------Q-15DE1F-----------------------------
INT 15 - DESQview v2.23+ - "DOSUSER" - GET HANDLE OF TASK CURRENTLY USING DOS
	AX = DE1Fh
Return: BX = segment of task handle or 0000h if no tasks are using DOS
Note:	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=DE13h,INT 21/AH=34h
--------Q-15DE20-----------------------------
INT 15 - DESQview v2.26+ - "DISPATCHINT" - INTERRUPT ANOTHER TASK
	AX = DE20h
	BX = segment of handle of task to interupt
	DX:CX -> FAR interrupt routine
	BP,SI,DI,DS,ES as required by interrupt routine
Return: nothing
Notes:	unlike "PGMINT" (AX=1021h), DISPATCHINT may be applied to the task
	  making the DISPATCHINT call
	multiple "DISPATCHINT" calls are processed in the order in which they
	  were executed
	the FAR routine is entered with the current ES, DS, SI, DI, and BP
	  values, using the task's internal stack (see AX=101Ah); only SS:SP
	  needs to be preserved
	this API call may be made from within a hardware interrupt handler
SeeAlso: AX=1021h,AX=DE2Ah
--------Q-15DE21-----------------------------
INT 15 - DESQview v2.26+ - "ASSERTVIR" - CONTROL 386 SCREEN VIRTUALIZATION
	AX = DE21h
	BX = new state
	    0000h turn off
	    nonzero turn on
Return: BX = old state of virtualization
Notes:	this API call may be made from within a hardware interrupt handler
	under DV 2.40 and 2.42, this call appears to have no effect and always
	  returns a nonzero value in BX which appears to be the offset within
	  the DV common memory segment of the caller's task object; it may
	  only have an effect within a hardware interrupt handler
SeeAlso: AX=1117h,AX=DE17h
--------Q-15DE22-----------------------------
INT 15 - DESQview v2.26+ - "PROCESSMEM" - GET TASK MEMORY STATUS
	AX = DE22h
	DX = segment of task handle
Return: DX = total amount of memory in paragraphs
	BX = amount of system memory in paragraphs
	CX = largest block of system memory available in paragraphs
	AX = memory flags (see #00552)
Notes:	if the task handle is a child task, the returned values will be for the
	  process containing the task, rather than the task itself
	if the process's system memory is swapped out, BX,CX,DX remain
	  unchanged, because the memory usage cannot be determined
SeeAlso: AX=DE04h,AX=DE05h,AX=DE06h

Bitfields for DESQview process memory flags:
Bit(s)	Description	(Table 00552)
 0	system memory resides in shared memory
 1	process's memory is swapped out
 2	process's system memory is swapped out
--------Q-15DE23-----------------------------
INT 15 U - DESQview v2.31+ - ???
	AX = DE23h
	BX = ??? IRQ number on first PIC?
	CX = ??? IRQ number on second PIC?
Return: ???
Note:	called by QEMM 6.00+
--------Q-15DE24-----------------------------
INT 15 - DESQview v2.40+ - "XNEWPROC" - START NEW APPLICATION
	AX = DE24h
	BX = length of .DVP data
	CX = length of ??? string
	DS:SI -> ??? string
	ES:DI -> .DVP data (see #00427 at AX=102Ch)
Return: BX = segment of task handle??? or 0000h on error
Note:	this call is similar to AX=102Ch except that it can interpret the
	  extended DVP data
SeeAlso: AX=102Ch
--------Q-15DE25-----------------------------
INT 15 - DESQview v2.40+ - "GETDVPATH" - GET DESQview DIRECTORY
	AX = DE25h
	ES:DI -> 67-byte buffer for ASCIZ directory name
Return: ES:DI buffer filled with directory from which DESQview was started
BUG:	DV 2.42 does not place a terminating NUL at the end of the directory
	  name, so if the buffer is not cleared to zeros before the call,
	  there is no way to tell where the directory name ends.  This bug
	  has been fixed in DV 2.52 (DV/X 1.02)
SeeAlso: AX=DE2Eh,INT 21/AH=47h
--------Q-15DE26-----------------------------
INT 15 - DESQview v2.40+ - "GETFOREGROUND" - GET KEYBOARD FOCUS
	AX = DE26h
Return: BX = segment of handle for task with keyboard focus
Note:	under DESQview/X, the X server always has the keyboard focus unless a
	  "direct" window is active
SeeAlso: AX=DE2Fh,INT 2F/AX=DE0Ah
--------Q-15DE27-----------------------------
INT 15 - DESQview v2.50+ - "ADDINSTANCEDATA" - ADD PER-TASK SAVE/RESTORE AREA
	AX = DE27h
	BX = type
	    0000h process
	    0001h task
	ES:DI -> list of Instance Item Structures (see #00553)
Return: CF clear if successful
	    AX = ???
	    BX = ???
	CF set on error
	    AX = error code???
		0004h invalid BX value
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
SeeAlso: INT 2F/AX=DE08h,INT 2F/AX=DE09h

Format of DESQview Instance Item Structure [one element of list]:
Offset	Size	Description	(Table 00553)
 00h	WORD	length of data area DESQview should save and restore on context
		  switches (0000h = end of list)
 02h	DWORD	pointer to area to be saved/restored
--------Q-15DE28-----------------------------
INT 15 U - DESQview v2.50+ - ???
	AX = DE28h
	BX = segment of ??? or 0000h for default
	???
Return: ???
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
SeeAlso: AX=DE2Ah
--------Q-15DE29BX0000-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0000h
	???
Return: CF clear if successful
	    ???
	CF set on error
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	under DESQview 2.60, this function and all other subfunctions of
	  AX=DE29h always return CF set, as they are unique to DESQview/X
--------Q-15DE29BX0001-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0001h
	DX = segment of window handle
Return: CF clear if successful
	    AX = ???
	    DX = ???
	CF set on error
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
--------Q-15DE29BX0002-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0002h
	DX = segment of window handle
Return: CF clear if successful
	    AX = ???
	    DX = ???
	CF set on error
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
--------Q-15DE29BX0003-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0003h
	DX = segment of window handle
Return: CF clear if successful
	    ???
	CF set on error
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
--------Q-15DE29BX0004-----------------------
INT 15 U - DESQview/X - GET DISPLAY NAME
	AX = DE29h
	BX = 0004h
	CX = size of buffer in bytes
	DX = segment of window handle
	ES:DI -> buffer for display name
Return: CF clear if successful
	    buffer filled with ASCIZ display name (truncated if necessary) or
	      null string if no display
	CF set on error
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	the name ":0" refers to the local display
--------Q-15DE29BX0005-----------------------
INT 15 U - DESQview/X - ???
	AX = DE29h
	BX = 0005h
	???
Return: CF clear if successful
	    ???
	CF set on error
Note:	under DESQview 2.60, this function and all other subfunctions of
	  AX=DE29h always return CF set, as they are unique to DESQview/X
--------Q-15DE2A-----------------------------
INT 15 - DESQview v2.50+ - "DISPATCHINTAFTERDOS" - INTERRUPT ANOTHER TASK
	AX = DE2Ah
	BX = segment of handle for task to interrupt or 0000h for caller
	DX:CX -> interrupt routine
	BP,SI,DI,DS,ES as required by interrupt routine
Return: nothing
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	this call is the same as AX=DE20h except that it will delay
	  interrupting the specified task until after it has exited DOS
SeeAlso: AX=1021h,AX=DE20h
--------Q-15DE2B-----------------------------
INT 15 - DESQview v2.50+ - "OBJNEXT" - TRAVERSE OBJECT LIST
	AX = DE2Bh
	ES:DI -> starting object
		0000h:0000h for first object in list???
Return: AX = status
	    0000h successful
		ES:DI -> next object of same type (window/non-window)
	    0001h failed (ES:DI was not a valid handle)
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	there are two separate lists, one for window/task objects and one
	  for all other objects
SeeAlso: AX=1016h,AX=DE2Ah,AX=DE2Ch
--------Q-15DE2C-----------------------------
INT 15 - DESQview v2.50+ - "WININFO" - GET WINDOW INFORMATION
	AX = DE2Ch
	DX = window information format version (0100h for DESQview 2.5x)
	BX = segment of window handle or 0000h for default
	ES:DI -> buffer for window information (see #00554)
Return: AX = status
	    0000h successful
Note:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
SeeAlso: AX=1000h,AX=1016h,AX=DE01h,AX=DE2Bh

Format of DESQview window information:
Offset	Size	Description	(Table 00554)
 00h	BYTE	task flag: 00h window, 01h task
 01h	BYTE	process number if owner task
		00h if non-owner task
 02h	WORD	segment of owner's handle, 0000h if orphaned
 04h	WORD	mapping context (see #00416 at AX=1016h)
 06h	BYTE	task status (see #00555)
 07h	BYTE	unused
 08h	WORD	status bits (see #00556)
 0Ah	BYTE	01h if foreground-only window

(Table 00555)
Values for DESQview task status:
 00h	"Waiting" waiting for input
 01h	"Idle" keyboard poll limit reached
 03h	same as 01h
 04h	"Pausing" INT 15/AX=1000h pause called
 04h	DV/X direct: user did something to allow task switch
 05h	"ModeChg" video mode about to be changed
 06h	"ModeNtf" notify that video mode changed
 07h	"MoniCh" requested change to other monitor
 08h	"StartPgm" control relinquished to start new process
 09h	"MgrCan" made window manager CANCEL command
 0Ah	"Slicing" time slice expired
 0Bh	"Exit DOS" notify on DOS calls
 0Ch	"Enter DOS" process is re-entering DOS
 0Dh	"Terminate" INT 21/AH=4Ch or task freed
 0Eh	"BrkNxt" Control-Break pressed
 0Fh	"MgrCol" keyboard focus taken away
 10h	"PgmInt" interrupted by API call from another task
 11h	"BldOpen" call to INT 15/AX=DE01h

Bitfields for DESQview task status bits:
Bit(s)	Description	(Table 00556)
 6	task is freeing another task
 5	process is being created
 4	user suspended process
 3	process suspended itself
 2	process is resized direct window (suspended)
 1	process swapped out
 0	DESQview process
--------Q-15DE2D-----------------------------
INT 15 U - DESQview v2.50+ - GET/SET SOCKET HANDLER
	AX = DE2Dh
	CX = direction
	    FFFFh set socket handler
		DX:BX -> FAR function for socket interface
			must be of the format described under INT 63"DESQview"
			  at #03515
	    other get socket handler
		Return: DX:BX -> socket handler (see #03515)
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	the "set" subfunction is normally called only by SOCKET.DVR
SeeAlso: AX=DE2Eh,INT 63"DESQview",#03515
--------Q-15DE2E-----------------------------
INT 15 U - DESQview v2.50+ - SOCKET API
	AX = DE2Eh
	DX:BX -> socket record (see #00558)
		0000h:0000h to create a new socket record
Return: CX = size of socket record in bytes
	DX:BX -> socket record which was used
Notes:	DESQview 2.50-2.52 are distributed as part of DESQview/X v1.0x.
	socket records are allocated from common memory
	for Unix compatibility, each socket and connection on a socket is
	  allocated a DOS file handle (referencing an SFT for NUL) which is
	  used on various calls to specify which of possibly multiple
	  connections is to be operated upon
SeeAlso: AX=DE2Dh,INT 61/AX=0001h/SF=0001h"VINES",INT 63"DESQview"

(Table 00557)
Values for DESQview/X socket API function number:
 0000h	initialize socket???
 0001h	"gethostname"
 0002h	"ioctl" check for input
 0003h	"sleep" delay for specified period
 0004h	"htons" convert word to network (big-endian) byte order
 0005h	"select"
 0006h	"bsd_close"/"so_close" close socket
 0007h	NOP
 0008h	"connect" initiate connection on socket
 0009h	"recv"/"recvfrom" read from socket
 000Ah	"socket"
 000Bh	???
 000Ch	"gethostbyname"
 000Dh	"send"/"sendto" write to socket
 000Eh	??? (does something to all connections for process)
 000Fh	"getpid" get process identifier
 0010h	"gettimeofday"
 0011h	"bind" assign name to socket
 0012h	"listen" listen for connections on socket
 0013h	"accept" accept connection on socket
 0014h	connect to X server
 0015h	"gethostbyaddr" get host information for an address
 0016h	"getprotobyname"
 0017h	"getprotobynumber"
 0018h	"getservbyname"
 0019h	"getservbyport"
 001Ah	"getsockname" determine name bound to socket
 001Bh	"getpeername" get name of connected peer
 001Ch	"getsockopt"/"setsockopt"
 001Dh	"so_exit"	 close all sockets for calling process
 001Eh	"issock" determine whether file handle references socket
 001Fh	"so_attach" reattach previously detached socket
 0020h	"so_detach" temporarily detach socket
 0021h	"dvpath" get DESQview directory (see also AX=DE24h)
 0022h	"NewProc" start new application (see also AX=102Ch)
 0023h	"so_linkup"
 0024h	"CanonicalPath" canonicalize filename (see also INT 21/AH=60h)
 0025h	indirect INT 15h call
 0026h	Network Manager interface
 0027h	"so_unlink"    close connection from "so_linkup"
 0028h	"raisepriority"
 0029h	"lowerpriority"
 002Ah	"so_private" ???
 FFFFh	"NetExit" (appears to be a NOP)

Format of DESQview/X socket record:
Offset	Size	Description	(Table 00558)
 00h	WORD	signature F0ADh
 02h	WORD	function number (see #00557)
 04h	WORD	returned error code (see #00578)
 06h	WORD	maximum message size??? (usually 0400h)
 08h	WORD	PSP segment to use or 0000h if socket not valid
 0Ah	WORD	scratch space (JFT size)
 0Ch	DWORD	scratch space (JFT address)
 10h	DWORD	mailbox handle (initialized by function 0000h)
 14h	DWORD	timer object handle (initialized by function 0000h)
---function 0000h---
 18h	WORD	(ret) ???
---function 0001h---
 18h	WORD	(ret) status???
 1Ah 128 BYTEs	(ret) ASCIZ hostname (empty string if not on network)
 9Ah	WORD	maximum length of hostname to return
---function 0002h---
 18h	WORD	(ret) status
 1Ah	WORD	socket's file handle
 1Ch	WORD	IOCTL function
		05h "FIONREAD" determine available input
		06h "FIONBIO" set blocking state of socket
 1Eh	WORD	(return, subfn 05h) number of bytes available for reading
		(call, subfn 06h) 0000h blocking, nonzero nonblocking
---function 0003h---
 18h  2 BYTEs	unused
 1Ah	WORD	delay time in seconds
---function 0004h---
 18h	WORD	(ret) result in network (big-endian) byte order
 1Ah	WORD	value to convert to network byte order
---function 0005h---
 18h	WORD	(ret) number of handles meeting the specified conditions???
 1Ah	WORD	number of file handles in each bitset
 1Ch	DWORD	bitset of socket handles to check for readability
 20h	DWORD	bitset of socket handles to check for writability
 24h	DWORD	bitset of socket handles to check for errors
 28h	WORD	timeout in ??? or 0000h to block until some socket ready
 2Ah	DWORD	???
 2Eh	DWORD	???
---function 0006h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
---function 0008h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	0001h if socket name specified, 0000h if not
 1Eh	WORD	length of socket name
 20h  N BYTEs	name of socket to which to connect
---function 0009h---
 18h	WORD	(ret) number of bytes actually read, 0000h if connection
			closed, or FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	number of bytes to read
 1Eh	WORD	flags
 20h	WORD	0000h if no source address desired
		0001h if source address is to be stored (datagram sockets)
 22h	WORD	length of source address
 24h 110 BYTEs	source address
 92h 1K BYTEs	buffer for data to be read
---function 000Ah---
 18h	WORD	(ret) socket's file handle or FFFFh on error
 1Ah	WORD	address family (0001h,0002h)
 1Ch	WORD	socket type
 1Eh	WORD	protocol
---function 000Bh---
 18h	WORD	(ret) 0001h if ??? or FFFFh on error
 1Ah	WORD	socket's file handle
 1Eh	WORD	(call) ???
---function 000Ch---
 18h 128 BYTEs	ASCIZ hostname (special case if empty string or "unix")
 98h	???	(ret) packed 'hostent' structure
 A2h	???	(ret) ???
---function 000Dh---
 18h	WORD	(ret) number of bytes actually written or FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	number of bytes to write
 1Eh	WORD	number of bytes to follow in subsequent writes???
 20h	WORD	flags
 22h	WORD	0000h if no destination specified, 0001h if destination present
 24h	WORD	0001h if broadcast message???, 0000h if not
		(ignored if no destination specified)
 26h	WORD	length of destination address
 28h 110 BYTEs	destination address
 96h 1K BYTEs	buffer containing data to be written
---function 000Eh---
 no additional fields
---function 000Fh---
 18h	DWORD	(ret) DESQview task handle of calling process
---function 0010h---
 18h	DWORD	(ret) current time
 1Ch	DWORD	(ret) ???
---function 0011h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	length of name
 1Eh  N BYTEs	buffer for socket name
---function 0012h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	maximum backlog of pending connections allowed on socket
---function 0013h---
 18h	WORD	(ret) file handle for new connection or FFFFh on error
 1Ah	WORD	listen()ing socket's file handle
 1Ch	WORD	(call) length of buffer for connecting entity's address
		(ret) actual length of address
 1Eh  N BYTEs	buffer for connecting entity's address (110 bytes???)
---function 0014h---
 18h	WORD	(ret) socket's file handle or FFFFh on error
 1Ah  4 BYTEs	(ret) ???
 1Eh	WORD	(ret) ???
 20h	WORD	(ret) ???
 22h 256 BYTEs	ASCIZ X display name
122h	???
---function 0015h---
 18h	WORD	(call) type of address??? (test for 0001h seen)
 1Ah	WORD	(call) length of buffer for host address
 1Ch 110 BYTEs	buffer containing ASCIZ host address
 8Ah	WORD	(ret) offset of official host name
 8Ch	WORD	(ret) offset of alias list???
 8Eh	WORD	(ret) address type???
 90h	WORD	(ret) length of an address in bytes???
 92h	WORD	(ret) offset of address???
 9Ah  N BYTEs	(ret) buffer for hostname, alias list, and host address
---function 0016h---
 18h	???	buffer for ASCIZ protocol name
 98h	???
---function 0017h---
 18h	WORD	(call) protocol number
 1Ah	WORD	(ret) ??? or 0001h
---function 0018h---
 18h 128 BYTEs	buffer containing ASCIZ ???
 98h 128 BYTEs	buffer containing ASCIZ ???
118h	WORD	(ret) ???
---function 0019h---
 18h	WORD	port number
 1Ah 128 BYTEs	(call) ASCIZ host name
		(ret) packed servent strctures???
 9Ah	WORD	(ret) ???
---function 001Ah---
 18h	WORD	(ret) 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	(call) length of buffer for socket name
		(ret) actual length of socket name
 1Eh  N BYTEs	buffer for socket name
---function 001Bh---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	WORD	(call) size of buffer for name
		(ret) actual size of name
 1Eh  N BYTEs	buffer for peer's name
---function 001Ch---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	direction: 0000h to get, 0001h to set
 1Ch	WORD	socket's file handle
 1Eh	WORD	option level
 20h	WORD	option name
 22h	WORD	(call) length of buffer for option value
		(ret) actual length of option value
 24h  N BYTEs	buffer for option value
---function 001Dh---
 no additional fields
---function 001Eh---
 18h	WORD	(ret) status: 0000h ??? or 0001h ???
 1Ah	WORD	file handle which may or may not be a socket
---function 001Fh---
 18h	WORD	(ret) file handle or FFFFh on error
 1Ah	DWORD	(call) pointer to Socket Context Record (see #00579) of a
			previously detached socket
---function 0020h---
 18h	WORD	(ret) status: 0000h if successful or FFFFh on error
 1Ah	WORD	socket's file handle
 1Ch	DWORD	(ret) pointer to Socket Context Record (see #00579) for
			the file handle
---function 0021h---
 18h 64 BYTEs	buffer for DESQview startup directory (see AX=DE25h)
---function 0022h---
 18h	DWORD	(ret) task handle of new application
 1Ch	WORD	size of .DVP data
 1Eh 129 BYTEs	ASCIZ ???
 9Fh  N BYTEs	.DVP data (see #00427 at AX=102Ch)
---function 0023h---
 18h	WORD	(ret) ??? or FFFFh on error
 1Ah	WORD	socket's file handle???
---function 0024h---
 18h	WORD	(ret) DOS error code (see #01680 at INT 21/AH=59h/BX=0000h)
			0000h if successful
 1Ah 129 BYTEs	ASCIZ filename/pathname
11Bh 129 BYTEs	ASCIZ canonicalized filename/pathname (see INT 21/AH=60h)
---function 0025h---
 18h	WORD	value of AX
 1Ah	WORD	value of BX
 1Ch	WORD	(call) value of CX for call if AH value other than 12h
		(call) number of stack parameters if AH value is 12h
		(ret) returned CX for calls other than INT 15/AH=12h
 1Eh	WORD	value of DX
 20h	WORD	value of DI
 22h	WORD	value of SI
 24h	WORD	value of DS
 26h	WORD	value of ES
 28h	WORD	(ret) value of FLAGS after call
 2Ah  N DWORDs	(call) stack parameters for INT 15/AH=12h call
		(ret) stack results from INT 15/AH=12h call
---function 0026h---
 18h	WORD	(call) Network Manager subfunction (see #00559)
		(ret) status??? (0000h on error)
 1Ah	WORD	(call) size of parameter data
		(ret) size of returned data
 1Ch  N BYTEs	(call) parameter data required by call (see #00560,#00561,#00577)
		(ret) result data (see #00570,#00571,#00576)
---function 0027h---
 18h	WORD	(ret) status: 0000h if successful, FFFFh on error
 1Ah	WORD	socket's file handle
---functions 0028h,0029h---
 18h	WORD	(call) file handle for which to set priority low/high
			FFFFh to change calling task's priority
---function 002Ah---
 no additional fields

(Table 00559)
Values for DESQview/X Network Manager subfunction:
 0004h	"so_exit"???
 0005h	"gethostbyname"
 0006h	"gethostname"
 0009h	"socket"
 000Dh	"gethostbyaddr"
 000Fh	"getprotobyname"
 0010h	get protocol name for protocol number
 0011h	"getservbyname"
 0012h	"getservbyport" (see #00563)
 0013h	"getsockname"??? (see #00564)
 0016h	"shutdown" (see #00565)
 0017h	kill Network Manager
 0018h	"getpeername"??? (see #00566)
 0019h	??? (called by socket function 0000h) (see #00567)
 001Ah	??? (see #00568)
 001Bh	"so_linkup" (see #00569)
 001Dh	"getnetstatus" get network services (see #00570)
 001Fh	"getpwuid"
 0020h	"getpwnam"
 0021h	"getpwvar"
 0022h	"crypt"
 0023h	"so_unlink"
 0024h	"getlogin" (see #00571)
 0028h	"sethostent"
 0029h	"gethostent"
 002Ah	"soaddhost"
 002Bh	"soupdatehost"
 002Ch	"sodeletehost"
 002Dh	"setservent"
 002Eh	"getservent"
 002Fh	"setpwent"
 0030h	"getpwent" (see #00572)
 0031h	"sethostpath" (see #00573)
 0032h	"endservent"
 0033h	"endhostent"
 0034h	"getnettype" get IP network number (see #00574)
 0035h	??? (pops up Network Manager window)
 0037h	"getnettimeout" (see #00575)
 0038h	get machine name and IP address (see #00576)
 0039h	"getuid" (see #00577)
---DV/X v2.0+ ---
 0041h	"deletepwnam"
 0045h	"renamepw"

Format of Function 0026h/Subfunction 000Fh data:
Offset	Size	Description	(Table 00560)
 00h  8 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0010h data:
Offset	Size	Description	(Table 00561)
 00h  2 BYTEs	(ret) ???
 02h	WORD	(ret) protocol number
 04h	WORD	(call) protocol number for which to get name
 06h	WORD	(ret) ???
 08h	var	(ret) ASCIZ protocol name
 N	var	(ret) ASCIZ protocol name

Format of Function 0026h/Subfunction 0011h data:
Offset	Size	Description	(Table 00562)
 00h  8 BYTEs	???
 08h	var	(ret) ASCIZ protocol name
	var	(ret) ASCIZ ??? name
	var	(ret) ASCIZ ??? name

Format of Function 0026h/Subfunction 0012h data:
Offset	Size	Description	(Table 00563)
 00h  8 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0013h data:
Offset	Size	Description	(Table 00564)
 00h 116 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0016h ("shutdown") data:
Offset	Size	Description	(Table 00565)
 00h	WORD	(ret) shutdown status (0000h successful, FFFFh error)
 02h  4 BYTEs	(ret) ???
 04h	WORD	(call) socket handle
 06*h	WORD	(call) what (0 = receives, 1 = sends, 2 = both)

Format of Function 0026h/Subfunction 0018h data:
Offset	Size	Description	(Table 00566)
 00h 116 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0019h data:
Offset	Size	Description	(Table 00567)
 00h  4 BYTEs	(ret) ???
 04h	DWORD	(ret) task handle of ???

Format of Function 0026h/Subfunction 001Ah data:
Offset	Size	Description	(Table 00568)
 00h 38 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 001Bh data:
Offset	Size	Description	(Table 00569)
 00h 10 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 001Dh return data [array]:
Offset	Size	Description	(Table 00570)
 00h	WORD	??? or FFFFh if end of array
 02h  7 BYTEs	???
 09h 27 BYTEs	ASCIZ name of service

Format of Function 0026h/Subfunction 0024h return data:
Offset	Size	Description	(Table 00571)
 00h	var	ASCIZ username

Format of Function 0026h/Subfunction 0030h data:
Offset	Size	Description	(Table 00572)
 00h	WORD	(call) UID or 0000h for current user
		(ret) ???
 02h	WORD	(ret) UID
 04h  6 BYTEs	(ret) ???
 0Ah	var	(ret) ASCIZ username
	var	(ret) ASCIZ encrypted password
	var	(ret) ASCIZ initial ("home") directory

Format of Function 0026h/Subfunction 0031h ("sethostpath") data:
Offset	Size	Description	(Table 00573)
 00h   4 BYTEs	???
 04h 144 BYTEs	ASCIZ ???

Format of Function 0026h/Subfunction 0034h data:
Offset	Size	Description	(Table 00574)
 00h  1-3 BYTEs IP network number of caller's machine (low byte first)

Format of Function 0026h/Subfunction 0037h ("getnettimeout") return data:
Offset	Size	Description	(Table 00575)
 00h	WORD	(ret) timeout
 02h  2 BYTEs	(ret) ???

Format of Function 0026h/Subfunction 0038h return data:
Offset	Size	Description	(Table 00576)
 00h	BYTE	???
 01h  4 BYTEs	IP address
 05h	var	ASCIZ machine name
	???

Format of Function 0026h/Subfunction 0039h ("getuid") return data:
Offset	Size	Description	(Table 00577)
 00h	WORD	user ID
 02h  2 BYTEs	???
SeeAlso: #00573,#00576

(Table 00578)
Values for DESQview/X socket error code:
 0000h	successful
 0009h	"BADF" bad file handle
 000Ch	"ENOMEM" out of memory
 000Eh	"EFAULT" bad address
 0016h	"EINVAL" invalid argument
 0018h	"EMFILE" too many open files
 0020h	"EPIPE" ??? broken pipe
 0023h	"EWOULDBLOCK" operation cannot be completed at this time
 0024h	"EINPROGRESS" operation now in progress
 0026h	"ENOTSOCK" socket invalid
 0028h	"EMSGSIZE" message too long to send atomically
 002Ch	"ESOCKTNOSUPPORT" socket type not supported
 002Fh	"EAFNOSUPPORT" address family not supp. by protocol fam.
 0031h	"EDOM" argument too large
 0038h	"EISCONN" socket is already connected
 0039h	"ENOTCONN" socket is not connected

Format of DESQview/X Socket Context Record:
Offset	Size	Description	(Table 00579)
 00h	DWORD	pointer to next Socket Context Record, 0000h:0000h if last
 04h	WORD	SFT index for socket, 00FFh if not connected, FFFFh if detached
 06h	WORD	PSP segment of owner or 0000h
 08h	WORD	mapping context of owning window (see #00416 at AX=1016h)
 0Ah  2 BYTEs	???
 0Ch	WORD	address family
 0Eh	WORD	socket type
 10h	WORD	protocol
 12h	WORD	socket state
		0001h created
		0002h bound
		0003h listening???
		0005h connected
 14h	DWORD	timer object handle
 18h	DWORD	object handle (mailbox???)
 1Ch	DWORD	object handle of parent of above object or 0000h:0000h
 20h	DWORD	pointer to ??? or 0000h
 24h  6 BYTEs	???
 2Ah	WORD	file handle for socket or FFFFh
 2Ch  2 BYTEs	???
 2Eh	WORD	nonzero if socket nonblocking
---network connections only---
 30h  2 BYTEs	???
 32h	WORD	???
 34h  4 BYTEs	(big-endian) IP address of remote
 38h  6 BYTEs	???
--------Q-15DE2F-----------------------------
INT 15 - DESQview v2.50+ - "VIDEONOTIFY" - HAS DIRECT WINDOW BEEN ACTIVE?
	AX = DE2Fh
Return: BX = status
	    0001h keyboard focus has been given to a direct window since the
		last call
	    0000h if not
Notes:	DESQview 2.50-2.53 are distributed as part of DESQview/X v1.00-1.10.
	Quarterdeck stated that this call would not be available under future
	  versions of DESQview Classic, but it is still present in v2.60
--------Q-15DE30-----------------------------
INT 15 - DESQview v2.50+ - "GETDVXVERSION" - GET DESQview/X VERSION
	AX = DE30h
Return: BX = version (BH=major, BL=minor) or 0000h if not DESQview/X
Notes:	DESQview 2.50-2.53 are distributed as part of DESQview/X v1.00-1.10.
	you must first check the DESQview version to verify that it is 2.50 or
	  greater
SeeAlso: INT 21/AH=2Bh/CX=4445h
--------Q-15DE31-----------------------------
INT 15 - DESQview/X v1.10 - ???
	AX = DE31h
	CX = ???
	    0000h ???
	    nonzero ???
	???
Return: ???
--------b-15DF-------------------------------
INT 15 - Juko UNIQUE UX BIOS - TURBO MODE CONTROL
	AH = DFh
	AL = function
	    00h turn on Turbo mode
	    01h turn off Turbo mode
	    02h set Turbo mode according to hardware switch
SeeAlso: INT 13/AX=FFFFh
--------b-15E00F-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR DISPATCH
	AX = E00Fh
	ES:BX -> start of 2nd processor's execution
Return: AL = status
	    0Fh successful
	    00h failure
SeeAlso: AX=E10Eh,AX=E200h
--------b-15E10E-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR END-OF-DISPATCH
	AX = E10Eh
	ES:BX -> start of 2nd processor's execution
Return: AL = status
	    0Fh successful (halted)
	    00h failure (not halted)
SeeAlso: AX=E00Fh,AX=E200h
--------b-15E200-----------------------------
INT 15 - Compaq Systempro - MULTIPROCESSOR AVAILABLE
	AX = E200h
Return: AX bit 15 set if 2nd processor available
SeeAlso: AX=E00Fh,AX=E10Eh
--------b-15E4-------------------------------
INT 15 - Tandy??? - ???
	AH = E4h
	AL = subfunction
	    21h, 89h, 8Ah, 8Bh called by 386MAX v6.01
	DL = ???
Return: DL = 00h if successful???
Note:	the section of code in 386MAX which calls these functions also checks
	  whether the ROM BIOS has both Tandy and Phoenix Technologies
	  signatures if these calls fail; the Tandy 1000SL/TL BIOS does not
	  support this function, however, returning the usual CF set/AH=86h for
	  "unsupported function".
--------b-15E4-------------------------------
INT 15 - Compaq ROM BIOS 1993/08/03 and newer - ???
	AH = E4h
	AL = subfunction
	    00h get advanced system info
		Return: CF clear
			AH = 00h
			CX = 0000h
			BX = advanced system info flags (read from [XBDA:0094h])
			     bit 4: "mode 2" (dual harddisk controller) enabled
	    01h,02h unsupported by this ROM version
		Return: CF set, AH = 86h
	    80h set advanced system info
		BX = advanced system info flags
		     bit 4: enable "mode 2" (dual harddisk controller)
		???
		Return: ???
		Note:	On Compaq machines with "COMPAQ" signature at
			  F000h:FFEAh (see also MEM F000h:FFE0h), MS-DOS/PC DOS
			  IO.SYS/IBMBIO.COM use	this function to set bit 4
			  before calling INT 13h/AH=08h to retrieve the number
			  of hard disks installed (DL).
	    90h,A0h,B0h,C0h,D0h,E0h,F0h set ???
		Return: CF clear
			AH = 00h
			CX = 0000h
			BX = ???
	    81h,91h,A1h,B1h,C1h,D1h,E1h,F1h unsupported by 3/8/93&4/8/93 ROMs
		Return: CF set, AH = 86h
Notes:	functions 80h/90h/etc. are not supported by the 4/8/93 EISA System ROM
	these functions are not supported by the 7/26/93 LTE Lite 386 ROM
--------!---Section--------------------------
