Interrupt List, part 4 of 18
Copyright (c) 1989-1999,2000 Ralf Brown
--------b-15E800-----------------------------
INT 15 - Compaq Contura - GET ???
	AX = E800h
Return: AX = 0000h
	BH = 00h
	BL = ??? (read from port 0C7Ch)
	CH = ???
	CL = ???
	DX = 0000h
Note:	also supported by 3/8/93 DESKPRO/i and 7/26/93 LTE Lite 386 ROM BIOS
--------b-15E800-----------------------------
INT 15 - Compaq Contura Aero, Contura 400 - GET SYSTEM MODEL CODE???
	AX = E800h
	BX = ??? (0000h)
Return: CF clear if successful
	    BH = 02h
	    BL = submodel??? (0Ch,0Dh,34h,38h,40h,44h,48h,64h,68h)
	CF set on error
	others???
Notes:	used by Compaq's SOFTPAQ number 0937 EPPBIOS.SYS to determine whether
	  the Enhanced Parallel Port expected by that driver is available
	used by Compaq's SOFTPAW number 0856 VOLCTRL.EXE to determine whether
	  volume control hardware expected by that driver is available
--------b-15E800-----------------------------
INT 15 - Compaq Prolinea - GET ???
	AX = E800h
	BX = ??? (1369h)
Return: BH = 01h
	BL = ???
	others???
Note:	used by Compaq's SOFTPAQ number 0718 INT10_04.SYS to determine whether
	  the fix that driver applies is required (will not install if BX on
	  return is other than 010Eh or 010Fh)
SeeAlso: AX=E802h
--------b-15E801-----------------------------
INT 15 - Phoenix BIOS v4.0 - GET MEMORY SIZE FOR >64M CONFIGURATIONS
	AX = E801h
Return: CF clear if successful
	    AX = extended memory between 1M and 16M, in K (max 3C00h = 15MB)
	    BX = extended memory above 16M, in 64K blocks
	    CX = configured memory 1M to 16M, in K
	    DX = configured memory above 16M, in 64K blocks
	CF set on error
Notes:	supported by the A03 level (6/14/94) and later XPS P90 BIOSes, as well
	  as the Compaq Contura, 3/8/93 DESKPRO/i, and 7/26/93 LTE Lite 386 ROM
	  BIOS
	supported by AMI BIOSes dated 8/23/94 or later
	on some systems, the BIOS returns AX=BX=0000h; in this case, use CX
	  and DX instead of AX and BX
	this interface is used by Windows NT 3.1, OS/2 v2.11/2.20, and is
	  used as a fall-back by newer versions if AX=E820h is not supported
	this function is not used by MS-DOS 6.0 HIMEM.SYS when an EISA machine
	  (for example with parameter /EISA) (see also MEM F000h:FFD9h), or no
	  Compaq machine was detected, or parameter /NOABOVE16 was given.
SeeAlso: AH=8Ah"Phoenix",AX=E802h,AX=E820h,AX=E881h"Phoenix"
--------b-15E802-----------------------------
INT 15 - Compaq Contura - GET ???
	AX = E802h
Return: CF clear
	AX = 0000h
	BX = ???
	CX = 0000h
Note:	this function is also supported by the LTE Lite 25c, 25E, and 486; not
	  supported by LTE Lite 20 and 25.
SeeAlso: AX=E801h"Phoenix"
--------b-15E820-----------------------------
INT 15 - newer BIOSes - GET SYSTEM MEMORY MAP
	AX = E820h
	EAX = 0000E820h
	EDX = 534D4150h ('SMAP')
	EBX = continuation value or 00000000h to start at beginning of map
	ECX = size of buffer for result, in bytes (should be >= 20 bytes)
	ES:DI -> buffer for result (see #00581)
Return: CF clear if successful
	    EAX = 534D4150h ('SMAP')
	    ES:DI buffer filled
	    EBX = next offset from which to copy or 00000000h if all done
	    ECX = actual length returned in bytes
	CF set on error
	    AH = error code (86h) (see #00496 at INT 15/AH=80h)
Notes:	originally introduced with the Phoenix BIOS v4.0, this function is
	  now supported by most newer BIOSes, since various versions of Windows
	  call it to find out about the system memory
	a maximum of 20 bytes will be transferred at one time, even if ECX is
	  higher; some BIOSes (e.g. Award Modular BIOS v4.50PG) ignore the
	  value of ECX on entry, and always copy 20 bytes
	some BIOSes expect the high word of EAX to be clear on entry, i.e.
	  EAX=0000E820h
	if this function is not supported, an application should fall back
	  to AX=E802h, AX=E801h, and then AH=88h
	the BIOS is permitted to return a nonzero continuation value in EBX
	  and indicate that the end of the list has already been reached by
	  returning with CF set on the next iteration
	this function will return base memory and ISA/PCI memory contiguous
	  with base memory as normal memory ranges; it will indicate
	  chipset-defined address holes which are not in use and motherboard
	  memory-mapped devices, and all occurrences of the system BIOS as
	  reserved; standard PC address ranges will not be reported
SeeAlso: AH=C7h,AX=E801h"Phoenix",AX=E881h,MEM xxxxh:xxx0h"ACPI"

Format of Phoenix BIOS system memory map address range descriptor:
Offset	Size	Description	(Table 00580)
 00h	QWORD	base address
 08h	QWORD	length in bytes
 10h	DWORD	type of address range (see #00581)

(Table 00581)
Values for System Memory Map address type:
 01h	memory, available to OS
 02h	reserved, not available (e.g. system ROM, memory-mapped device)
 03h	ACPI Reclaim Memory (usable by OS after reading ACPI tables)
 04h	ACPI NVS Memory (OS is required to save this memory between NVS
	  sessions)
 other	not defined yet -- treat as Reserved
SeeAlso: #00580
--------b-15E881-----------------------------
INT 15 - Phoenix BIOS v4.0 - GET MEMORY SIZE FOR >64M CONFIGURATIONS (32-bit)
	AX = E881h
Return: CF clear if successful
	    EAX = extended memory between 1M and 16M, in K (max 3C00h = 15MB)
	    EBX = extended memory above 16M, in 64K blocks
	    ECX = configured memory 1M to 16M, in K
	    EDX = configured memory above 16M, in 64K blocks
	CF set on error
Notes:	supported by AMI BIOSes dated 8/23/94 or later
	this interface is used by Windows NT 3.1, OS/2 v2.11/2.20, and is
	  used as a fall-back by newer versions if AX=E820h is not supported
SeeAlso: AX=E801h"Phoenix",AX=E820h"Phoenix"
----------15E900-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - RESET WATCHDOG TIMER
	AX = E900h
Return: nothing
----------15E901-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - WRITE DIAGNOSTIC CONTROL POINT CODE
	AX = E901h
	CX = control point code (codes 000h-1FFh system backup)
Return: nothing
Note:	Provided by PhysTechSoft's PTS ROM-DOS and displayed by SETUP.COM.
SeeAlso: AX=E902h,INT 14/AH=05h"PTS ROM-DOS",INT 14/AH=06h"PTS ROM-DOS"

(Table 04093)
Values for PhysTechSoft PTS ROM-DOS control point code:
 ???	LOADER: Stack loaded
	LOADER: IVT initialized
	LOADER: Channel initialized
	LOADER: Local loading
	LOADER: Flash tested
	LOADER: Load from ROM
	LOADER: Load ROM comp.
	LOADER: Load from Flash
	LOADER: Load Flash co.
	BIOS: Chipset initialized
	BIOS: CPU tested
	BIOS: Stack tested
	BIOS: CRC tested
	BIOS: IVT initialized
	BIOS: Vars initialized
	BIOS: Resident init
	BIOS: Channel initialized
	BIOS: Memory tested
	BIOS: SRAM tested
	BIOS: EMS tested
	BIOS: PIC initialized
	BIOS: PPI initialized
	BIOS: DMA initialized
	BIOS: Timer initialized
	BIOS: Disks initialized
	BIOS: Boot loaded
	BIOS: Failed boot
	DOS: Job point: (up to 25???)
SeeAlso: #04091
----------15E902-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - SET DIAGNOSTIC DOS ERROR FLAG
	AX = E902h
	CX = diagnostic flag mask (see #04091,#04092)
Return: nothing
Note:	Provided by PhysTechSoft's PTS ROM-DOS and displayed by SETUP.COM.
	  DOS error flags can be assigned by application software.
SeeAlso: AX=E901h,INT 14/AH=05h"PTS ROM-DOS", INT 14/AH=06h"PTS ROM-DOS"

Bitfields for PhysTechSoft PTS ROM-DOS BIOS error flags:
Bit(s)	Description	(Table 04091)
 ???	Processor test failed.
	Stack test failed.
	BIOS code damaged.
	Conventional memory test failed.
	SRAM test failed.
	EMS test failed.
	Boot-sector damaged.
	Boot-sector read error.
	Loader setup damaged.
	BIOS setup damaged.
SeeAlso: #04092,#04093

Bitfields for PhysTechSoft PTS ROM-DOS LOADER error flags::
Bit(s)	Description	(Table 04092)
 ???	Processor test failed.
	Loader code damaged.
	Loader code in RAM damaged.
	Loader setup in flash-memory damaged.
	BIOS setup in flash-memory damaged.
	BIOS offset in flash-memory field damaged.
	BIOS size in flash-memory field damaged.
	BIOS in flash-memory damaged.
	BIOS in ROM damaged.
	Last operation field damaged.
	Channel error.
	Setup in flash-memory damaged.
	Loading BIOS from control channel failed.
	Loading DOS from control channel failed.
SeeAlso: #04091
----------15E903-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - WRITE-ENABLE FLASH-DISK
	AX = E903h
Return: nothing
Note:	Enabling writing on Flash disk can lead to corruption of EMS disk info.
SeeAlso: AX=E904h,AX=E905h
----------15E904-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - WRITE-PROTECT FLASH-DISK
	AX = E904h
Return: nothing
SeeAlso: AX=E903h,AX=E905h
----------15E905-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - WRITE IMAGE OF BIOS TO FLASH-MEMORY
	AX = E905h
	DS:SI -> buffer
Return: nothing
SeeAlso: AX=E903h,INT 14/AH=05h"PTS ROM-DOS",INT 14/AH=06h"PTS ROM-DOS"
----------15E906-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - READ SETUP INFORMATION FROM FLASH-DISK
	AX = E906h
	DS:SI -> buffer
Return:	AL = error code (00h = no error, 01h = setup information not found)
SeeAlso: AX=E907h,INT 14/AH=05h"PTS ROM-DOS",INT 14/AH=06h"PTS ROM-DOS"
----------15E907-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - WRITE SETUP INFORMATION ON FLASH-DISK
	AX = E907h
	DS:SI -> buffer
Return:	nothing
SeeAlso: AX=E906h
----------15E908-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - SET BREAKPOINT
	AX = E908h
	CL = flags
	    bit 1: =0 operate in one-fold mode
		   =1 operate in many-fold mode
	    bit 0: =0 send debug information to control channel
		   =1 activate handler
	ES:SI = breakpoint address
	DX:DI = handler address
Return: AH = error code
	    00h no error
	    01h incorrect parameter
	    02h no room in breakpoint table
SeeAlso: AX=E909h,INT 14/AH=05h"PTS ROM-DOS",INT 14/AH=06h"PTS ROM-DOS"
----------15E909-----------------------------
INT 15 - PhysTechSoft PTS ROM-DOS - REMOVE BREAKPOINT
	AX = E909h
	ES:SI = breakpoint address
Return:	AH = error code
	    00h no error
	    01h incorrect parameter
SeeAlso: AX=E908h,INT 14/AH=05h"PTS ROM-DOS",INT 14/AH=06h"PTS ROM-DOS"
--------m-15F200CX454D-----------------------
INT 15 - Tandon memory mapper - Tandon MAPPER HARDWARE INITIALIZATION CHECK ???
	AX = F200h
	CX = 454Dh
Return: CF clear if hardware already initialised
	    BX = upper RAM areas in use
		bit 0: C000-C3FF
		bit 1: C400-C7FF
		...
		bit 11: EC00-EFFF
	CF set if hardware not initialised yet
--------B-1600-------------------------------
INT 16 - KEYBOARD - GET KEYSTROKE
	AH = 00h
Return: AH = BIOS scan code
	AL = ASCII character
Notes:	on extended keyboards, this function discards any extended keystrokes,
	  returning only when a non-extended keystroke is available
	the BIOS scan code is usually, but not always, the same as the hardware
	  scan code processed by INT 09.  It is the same for ASCII keystrokes
	  and most unshifted special keys (F-keys, arrow keys, etc.), but
	  differs for shifted special keys
	some (older) clone BIOSes do not discard extended keystrokes and manage
	  function AH=00h and AH=10h the same
	the K3PLUS v6.00+ INT 16 BIOS replacement doesn't discard extended
	  keystrokes (same as with functions 10h and 20h), but will always
	  translate prefix E0h to 00h. This allows old programs to use extended
	  keystrokes and should not cause compatibility problems
SeeAlso: AH=01h,AH=05h,AH=10h,AH=20h,AX=AF4Dh"K3PLUS",INT 18/AH=00h
SeeAlso: INT 09,INT 15/AH=4Fh
--------B-1601-------------------------------
INT 16 - KEYBOARD - CHECK FOR KEYSTROKE
	AH = 01h
Return: ZF set if no keystroke available
	ZF clear if keystroke available
	    AH = BIOS scan code
	    AL = ASCII character
Note:	if a keystroke is present, it is not removed from the keyboard buffer;
	  however, any extended keystrokes which are not compatible with 83/84-
	  key keyboards are removed by IBM and most fully-compatible BIOSes in
	  the process of checking whether a non-extended keystroke is available
	some (older) clone BIOSes do not discard extended keystrokes and manage
	  function AH=00h and AH=10h the same
	the K3PLUS v6.00+ INT 16 BIOS replacement doesn't discard extended
	  keystrokes (same as with functions 10h and 20h), but will always
	  translate prefix E0h to 00h. This allows old programs to use extended
	  keystrokes and should not cause compatibility problems
SeeAlso: AH=00h,AH=11h,AH=21h,INT 18/AH=01h,INT 09,INT 15/AH=4Fh
--------B-1602-------------------------------
INT 16 - KEYBOARD - GET SHIFT FLAGS
	AH = 02h
Return: AL = shift flags (see #00582)
	AH destroyed by many BIOSes
SeeAlso: AH=12h,AH=22h,INT 17/AH=0Dh,INT 18/AH=02h,MEM 0040h:0017h

Bitfields for keyboard shift flags:
Bit(s)	Description	(Table 00582)
 7	Insert active
 6	CapsLock active
 5	NumLock active
 4	ScrollLock active
 3	Alt key pressed (either Alt on 101/102-key keyboards)
 2	Ctrl key pressed (either Ctrl on 101/102-key keyboards)
 1	left shift key pressed
 0	right shift key pressed
SeeAlso: #00587,#03743,MEM 0040h:0017h,#M0010
--------B-1603-------------------------------
INT 16 - KEYBOARD - SET TYPEMATIC RATE AND DELAY
	AH = 03h
	AL = subfunction
	    00h set default delay and rate (PCjr and some PS/2)
	    01h increase delay before repeat (PCjr)
	    02h decrease repeat rate by factor of 2 (PCjr)
	    03h increase delay and decrease repeat rate (PCjr)
	    04h turn off typematic repeat (PCjr and some PS/2)
	    05h set repeat rate and delay (AT,PS)
		BH = delay value (00h = 250ms to 03h = 1000ms)
		BL = repeat rate (00h=30/sec to 0Ch=10/sec [def] to 1Fh=2/sec)
	    06h get current typematic rate and delay (newer PS/2s)
		Return: BL = repeat rate (above)
			BH = delay (above)
Return: AH destroyed by many BIOSes
Note:	use INT 16/AH=09h to determine whether some of the subfunctions are
	  supported
SeeAlso: INT 16/AH=09h,AH=29h"HUNTER",AH=2Ah"HUNTER"
--------B-1604-------------------------------
INT 16 - KEYBOARD - SET KEYCLICK (PCjr only)
	AH = 04h
	AL = keyclick state
	    00h off
	    01h on
Return: AH destroyed by many BIOSes
SeeAlso: AH=03h,AH=04h"K3PLUS"
--------b-1604-------------------------------
INT 16 - Tandy 2000 - KEYBOARD - FLUSH KEYBOARD BUFFER
	AH = 04h
Note:	this interrupt is identical to INT 51 on the Tandy 2000
SeeAlso: INT 16/AH=00h,INT 16/AH=02h,INT 16/AH=05h"Tandy 2000"
SeeAlso: INT 51"Tandy 2000"
--------K-1604-------------------------------
INT 16 - K3PLUS v6.22+ - SET KEYCLICK
	AH = 04h
	AL = keyclick state
	    00h keyclick off, leave loudness setting unchanged
	    01h keyclick on, leave loudness setting unchanged
	    else
	       bit 0: keyclick enabled if set
	       bits 7-1: new keyclick loudness (non-zero)
Return: AH destroyed by many BIOSes
Note:	Applications which try to set a new loudness, but are unsure of the
	  results of other INT 16/AH=04h implementations, should set the new
	  loudness first, and then call this function again with AL=01h or
	  AL=00h
SeeAlso: AH=03h,AH=04h"KEYBOARD",AX=AF4Dh
--------B-1605-------------------------------
INT 16 - KEYBOARD - STORE KEYSTROKE IN KEYBOARD BUFFER (AT/PS w enh keybd only)
	AH = 05h
	CH = BIOS scan code
	CL = ASCII character
Return: AL = status
	    00h if successful
	    01h if keyboard buffer full
	AH destroyed by many BIOSes
Notes:	under DESQview, a number of "keystrokes" invoke specific
	  DESQview-related actions when they are read from the keyboard
	  buffer (see #00583)
	similarly, some "keystrokes" invoke special functions on the HP 100LX
	  and HP 200LX (see #00584)
SeeAlso: AH=00h,AH=25h"K3",AH=71h,AX=AF4Dh,AH=FFh,INT 15/AX=DE10h
SeeAlso: MEM 0040h:001Eh

(Table 00583)
Values for pseudo-keystrokes for DESQview:
 38FBh or FB00h	switch to next window (only if main menu already popped up)
 38FCh or FC00h	pop up DESQview main menu
 38FEh or FE00h	close the current window
 38FFh or FF00h	pop up DESQview learn menu

(Table 00584)
Values for pseudo-keystrokes for HP 100LX/200LX:
 EE00h	pop up topcard display and set other system manager applications
	  into sleep mode
--------B-1605-------------------------------
INT 16 - KEYBOARD - SELECT KEYBOARD LAYOUT (PCjr only)
	AH = 05h
	AL = function
	    01h set keyboard layout to French
	    02h set keyboard layout to German
	    03h set keyboard layout to Italian
	    04h set keyboard layout to Spanish
	    05h set keyboard layout to UK
	    80h check if function supported
		Return: AL <> 80h if supported
Return: ???
	AH destroyed by many BIOSes
Note:	this function is called by the DOS 3.2 KEYBxx.COM
SeeAlso: AH=92h,AH=A2h,AX=AF4Dh
--------b-1605-------------------------------
INT 16 - Tandy 2000 - KEYBOARD - RESET KEYBOARD
	AH = 05h
Desc:	reset the keyboard and flush the keyboard buffer
Note:	this interrupt is identical to INT 51 on the Tandy 2000
SeeAlso: INT 16/AH=00h,INT 16/AH=02h,INT 16/AH=03h,INT 51"Tandy 2000"
----------160600-----------------------------
INT 16 - AAKEYS - GET NEXT KEYBOARD EVENT
	AX = 0600h
Return:	CF clear if successful
	    AL = next keyboard event in event buffer, FFh if buffer overflowed
	CF set on error
	    AL = 00h buffer empty
	BX destroyed
Program: AAKEYS is a TSR by Anthony Appleyard which records keyboard scan
	  codes in a 256-byte buffer in addition to any normal processing which
	  takes place
Note:	the installation check consists of calling INT 16/AX=06xxh (where 'xx'
	  is any subfunction other than those listed here) and testing whether
	  AX=BEEFh on return
SeeAlso: AX=0601h,AX=0602h,AX=0603h,AX=0604h
----------160601-----------------------------
INT 16 - AAKEYS - EMPTY KEY-EVENT BUFFER
	AX = 0601h
Return:	nothing
SeeAlso: AX=0600h,AX=0602h,AX=0603h,AX=0604h
----------160602-----------------------------
INT 16 - AAKEYS - DISABLE AAKEYS
	AX = 0602h
Return:	AX,DX destroyed
Desc:	restores INT 09 and INT 16 and clears the TSRs signature byte
SeeAlso: AX=0600h,AX=0601h,AX=0603h,AX=0604h
----------160603-----------------------------
INT 16 - AAKEYS - GET KEY-EVENT BUFFER
	AX = 0603h
Return:	ES:BX -> 256-byte circular key-event buffer
	ES:[AX] = offset of head of buffer
	ES:[AX+1] = offset of tail of buffer
SeeAlso: AX=0600h,AX=0601h,AX=0602h,AX=0604h
----------160604-----------------------------
INT 16 - AAKEYS - EMPTY BIOS KEYBOARD BUFFER
	AX = 0604h
Return:	AX destroyed
SeeAlso: AX=0600h,AX=0601h,AX=0602h,AX=0603h
--------B-1609-------------------------------
INT 16 - KEYBOARD - GET KEYBOARD FUNCTIONALITY
	AH = 09h
Return: AL = supported keyboard functions (see #00585)
	AH destroyed by many BIOSes
Note:	this function is only available if bit 6 of the second feature byte
	  returned by INT 15/AH=C0h is set (see #00509)
SeeAlso: AH=03h,AH=0Ah,AH=10h,AH=11h,AH=12h,AH=20h,AH=21h,AH=22h,INT 15/AH=C0h

Bitfields for supported keyboard functions:
Bit(s)	Description	(Table 00585)
 7	reserved
 6	INT 16/AH=20h-22h supported (122-key keyboard support)
 5	INT 16/AH=10h-12h supported (enhanced keyboard support)
 4	INT 16/AH=0Ah supported
 3	INT 16/AX=0306h supported
 2	INT 16/AX=0305h supported
 1	INT 16/AX=0304h supported
 0	INT 16/AX=0300h supported
SeeAlso: #00511
--------K-160A-------------------------------
INT 16 - KEYBOARD - GET KEYBOARD ID
	AH = 0Ah
Return: BX = keyboard ID (see #00586)
	AH destroyed by many BIOSes
Notes:	check return value from AH=09h to determine whether this function is
	  supported
	this function is also supported by the K3PLUS v6.00+ INT 16 BIOS
	  replacement
SeeAlso: AH=09h,AX=AF4Dh,MEM 0040h:00C2h"AMI"

(Table 00586)
Values for keyboard ID:
 0000h	no keyboard attached
 41ABh	Japanese "G" keyboard (translate mode)
	MF2 Keyboard (usually in translate mode)
 54ABh	Japanese "P" keyboard (translate mode)
 83ABh	Japanese "G" keyboard (pass-through mode)
	MF2 Keyboard (pass-through mode)
 84ABh	Japanese "P" keyboard (pass-through mode)
 86ABh	122-key keyboard
 90ABh	old Japanese "G" keyboard
 91ABh	old Japanese "P" keyboard
 92ABh	old Japanese "A" keyboard
--------B-1610-------------------------------
INT 16 - KEYBOARD - GET ENHANCED KEYSTROKE (enhanced kbd support only)
	AH = 10h
Return: AH = BIOS scan code
	AL = ASCII character
Notes:	if no keystroke is available, this function waits until one is placed
	  in the keyboard buffer
	the BIOS scan code is usually, but not always, the same as the hardware
	  scan code processed by INT 09.  It is the same for ASCII keystrokes
	  and most unshifted special keys (F-keys, arrow keys, etc.), but
	  differs for shifted special keys.
	unlike AH=00h, this function does not discard extended keystrokes
	INT 16/AH=09h can be used to determine whether this function is
	  supported, but only on later model PS/2s
SeeAlso: AH=00h,AH=09h,AH=11h,AH=20h,MEM 0040h:0019h,MEM 0040h:001Eh
--------B-1611-------------------------------
INT 16 - KEYBOARD - CHECK FOR ENHANCED KEYSTROKE (enh kbd support only)
	AH = 11h
Return: ZF set if no keystroke available
	ZF clear if keystroke available
	    AH = BIOS scan code
	    AL = ASCII character
Notes:	if a keystroke is available, it is not removed from the keyboard buffer
	unlike AH=01h, this function does not discard extended keystrokes
	some versions of the IBM BIOS Technical Reference erroneously report
	  that CF is returned instead of ZF
	INT 16/AH=09h can be used to determine whether this function is
	  supported, but only on later model PS/2s
SeeAlso: AH=01h,AH=09h,AH=10h,AH=21h,INT 09,INT 15/AH=4Fh
--------B-1612-------------------------------
INT 16 - KEYBOARD - GET EXTENDED SHIFT STATES (enh kbd support only)
	AH = 12h
Return: AL = shift flags 1 (same as returned by AH=02h) (see #00587)
	AH = shift flags 2 (see #00588)
Notes:	AL bit 3 set only for left Alt key on many machines
	AH bits 7 through 4 always clear on a Compaq SLT/286
	INT 16/AH=09h can be used to determine whether this function is
	  supported, but only on later model PS/2s
	many BIOSes (including at least some versions of Phoenix and AMI) will
	  destroy AH on return from functions higher than AH=12h, returning
	  12h less than was in AH on entry (due to a chain of DEC/JZ
	  instructions)
SeeAlso: AH=02h,AH=09h,AH=22h,AH=51h,INT 17/AH=0Dh,MEM 0040h:0017h

Bitfields for keyboard shift flags 1:
Bit(s)	Description	(Table 00587)
 7	Insert active
 6	CapsLock active
 5	NumLock active
 4	ScrollLock active
 3	Alt key pressed (either Alt on 101/102-key keyboards)
 2	Ctrl key pressed (either Ctrl on 101/102-key keyboards)
 1	left shift key pressed
 0	right shift key pressed
SeeAlso: #00582,#00588,MEM 0040h:0017h,#M0010

Bitfields for keyboard shift flags 2:
Bit(s)	Description	(Table 00588)
 7	SysReq key pressed (SysReq is often labeled SysRq)
 6	CapsLock pressed
 5	NumLock pressed
 4	ScrollLock pressed
 3	right Alt key pressed
 2	right Ctrl key pressed
 1	left Alt key pressed
 0	left Ctrl key pressed
SeeAlso: #00587,MEM 0040h:0018h,#M0011
--------J-1613-------------------------------
INT 16 - DOS/V - DOUBLE-BYTE CHARACTER SET SHIFT CONTROL
	AH = 13h
	AL = function
	    00h set shift status
		DX = shift status (see #00589), must preserve internal status
			  bits
	    01h get shift status
		Return: DX = current shift status (see #00589)
Note:	these functions are supplied by the Japanese Front-End Processor
SeeAlso: AH=14h,INT 21/AX=6301h

Bitfields for DOS/V shift status:
Bit(s)	Description	(Table 00589)
 0	full-size rather than half-size
 2-1	character input mode
	00 alphanumeric, 01 Katakana, 10 Hiragana, 11 unused
 5-3	internal status
 6	Romaji enabled
 7	Katakana to Kanji conversion enabled
 15-8	internal status
--------J-1614-------------------------------
INT 16 - DOS/V - SHIFT STATUS DISPLAY CONTROL
	AH = 14h
	AL = function
	    00h enable display
	    01h disable display
	    02h get display state
		Return: AL = current state (00h enabled, 01h disabled)
Desc:	control the screen-bottom shift status row(s) for the Japanese
	  Front-End Processor
SeeAlso: AH=13h,INT 10/AH=19h,INT 10/AH=1Dh
--------B-1620-------------------------------
INT 16 - KEYBOARD - GET 122-KEY KEYSTROKE (122-key kbd support only)
	AH = 20h
Return: AH = BIOS scan code (see AH=10h)
	AL = ASCII character
Note:	use AH=09h to determine whether this function is supported
SeeAlso: AH=00h,AH=09h,AH=10h,AH=21h,AH=22h
--------b-1620------------------------------------
INT 16 - HUNTER 16 - SET TEMPORARY SHIFT
	AH = 20h
	AL = shift status (see #00590)
Notes:	the Husky Hunter 16 is an 8088-based ruggedized laptop.	 Other family
	  members are the Husky Hunter, Husky Hunter 16/80, and Husky Hawk.
	the user can override the specified settings by pressing the keys

Bitfields for HUNTER 16 shift status:
Bit(s)	Description	(Table 00590)
 4	Scroll Lock on
 5	Num Lock on
 6	Caps Lock on
--------K-1620-------------------------------
INT 16 O - K3 v1.5x, K3PLUS v5.xx - GET EXTENDED BUFFER STATE
	AH = 20h
Return: AX = K3 version
	ES:BX -> extended keyboard buffer start
	ES:DX -> extended keyboard buffer end
	ES:SI -> next keystroke
	ES:DI -> last keystroke in buffer
	CX = number of keystrokes in buffer
Program: K3PLUS is an extended keyboard driver by Matthias Paul and Axel C.
	  Frinke, originally based on the K3 extended German keyboard driver
	  by Martin Gerdes published in c't magazine in 1988
Note:	this function was normally unsupported under K3PLUS v6.00-v6.22 and
	  is no longer supported by v6.30+; use AX=AF20h instead
SeeAlso: AH=25h"K3",AX=AF20h,INT 2F/AX=D44Fh/BX=0000h,INT 2F/AX=ED58h
--------B-1621-------------------------------
INT 16 - KEYBOARD - CHECK FOR 122-KEY KEYSTROKE (122-key kbd support only)
	AH = 21h
Return: ZF set if no keystroke available
	ZF clear if keystroke available
	    AH = BIOS scan code
	    AL = ASCII character
Notes:	use AH=09h to determine whether this function is supported
	some versions of the IBM BIOS Technical Reference erroneously report
	  that CF is returned instead of ZF
	K3PLUS v6.00+ supports this function as an alias of AH=11h
SeeAlso: AH=01h,AH=09h,AH=11h,AH=20h,AH=21h
--------b-1621------------------------------------
INT 16 - HUNTER 16 - CONTROL SHIFT KEYS
	AH = 21h
	AL = shift keys to control (see #00582)
	BL = shift state for disabled keys
Note:	If a bit in AL is set the key is disabled and set to the state of the
	  corresponding bit in BL
SeeAlso: AH=20h"HUNTER",AH=22h"HUNTER"
--------B-1622-------------------------------
INT 16 - KEYBOARD - GET 122-KEY SHIFT STATUS (122-key kbd support only)
	AH = 22h
Return: AL = shift flags 1 (see #00587)
	AH = shift flags 2 (see #00588)
Notes:	use AH=09h to determine whether this function is supported
	K3PLUS v6.00+ supports this function as an alias of AH=12h
SeeAlso: AH=02h,AH=09h,AH=12h,AH=20h,AH=21h
--------b-1622------------------------------------
INT 16 - HUNTER 16 - CONTROL CTRL-ALT-DEL
	AH = 22h
	AL = new Ctrl-Alt-Del state (00h enabled, nonzero disabled)
	BX = 0708h
	CX = 0910h
	DX = 1112h
Return: AL = 00h if successful
SeeAlso: AH=21h"HUNTER",AH=23h"HUNTER",AH=2Ah
--------b-1623------------------------------------
INT 16 - HUNTER 16 - CONTROL EMERGENCY BREAKOUT
	AH = 23h
	AL = new state of breakout (00h enabled, nonzero disabled)
	BX = 0708h
	CX = 0910h
	DX = 1112h
Return: AL = 00h if successful
Desc:	Enables or disables the emergency breakout feature, where the
	  Hunter 16 at power on checks whether the X and P keys are pressed.
	  If so the machine will boot rather than continue the running program
SeeAlso: AH=22h"HUNTER"
--------b-1624------------------------------------
INT 16 - HUNTER 16 - REDEFINE KEY CODES
	AH = 24h
	AL = Matrix Code (see #00591)
	BL = new Key code
Return: AL = status (00h successful, nonzero failed)
SeeAlso: AH=2Bh,AH=2Ch

(Table 00591)
Values for HUNTER 16 Matrix Code:
 Code  Key		Code	Key		Code	Key
 00h   Esc key		1Eh	Space		3Bh	L
 01h   1		21h	0		3Ch	,
 02h   Q		22h	-		3Eh	Right shift
 03h   Tab		23h	'		42h	8
 04h   Num Lock		24h	Keypad 4	43h	7
 05h   \		25h	Enter		44h	U
 08h   LShift		26h	Keypad 7	45h	I
 09h   Ctrl		27h	.		46h	J
 0Ah   "Paw" key	28h	Keypad 1	47h	K
 0Bh   2		29h	Keypad 0	48h	M
 0Ch   W		2Ch	=		49h	N
 0Dh   A		2Dh	Backspace	4Ah	/
 0Eh   S		2Eh	Keypad 8	4Dh	6
 0Fh   Z		2Fh	Keypad 9	4Eh	5
 11h   Alt		30h	Keypad 5	4Fh	T
 16h   4		31h	Keypad 6	50h	Y
 17h   3		32h	Keypad 2	51h	G
 18h   E		33h	Keypad 3	52h	H
 19h   R		34h	Keypad .	53h	B
 1Ah   D		37h	9		54h	V
 1Bh   F		38h	O		55h	#
 1Ch   X		39h	P		58h	Pwr
 1Dh   C		3Ah	;		59h	Shift Pwr
--------b-1625------------------------------------
INT 16 - HUNTER 16 - RESET KEYBOARD
	AH = 25h
Return: AL = 00h
Desc:	restores the standard keyboard layout after any remapping
SeeAlso: AH=24h,AH=2Bh,AH=2Ch
--------K-1625-------------------------------
INT 16 O - K3 v1.5x, K3PLUS v5.xx - COPY INTO EXTENDED BUFFER
	AH = 25h
	CX = number of keystrokes to copy
	ES:SI -> buffer containing keystrokes
Return: CF clear if successful
	CF set on error (i.e. buffer full)
	    CX = number of keystrokes NOT transferred
	    ES:SI -> first keystroke not transferred
Note:	this function was normally unsupported under K3PLUS v6.00-v6.22 and
	  is no longer supported by v6.30+; use AX=AF25h instead
SeeAlso: AH=05h,AH=20h"K3",AX=AF25h,INT 2F/AX=D44Fh/BX=0001h
--------b-1626------------------------------------
INT 16 - HUNTER 16 - CONTROL KEYCLICK
	AH = 26h
	AL = new state of keyclicks (00h disabled, 01h enabled)
Return: AL = 00h
SeeAlso: AH=2Ah
--------b-1627------------------------------------
INT 16 - HUNTER 16 - CONTROL SCREEN DUMP AREA
	AH = 27h
	AL = what to dump
	    00h whole (virtual) window
	    01h LCD window only
Return: AL = 00h
Desc:	control whether printscren dumps the whole 80x25 screen or only the
	  part displayed in the LCD window
Note:	the Hunter 16 has a 240x64 LCD display which serves as a window into
	  a 640x200 virtual screen
--------b-1629------------------------------------
INT 16 - HUNTER 16 - GET KEY REPEAT
	AH = 29h
Return: BL = Typematic rate (characters per second) (see #00592)
	BH = delay (00h = 250ms, 01h = 500ms, 02h = 750ms, 03h = 1s)
SeeAlso: AH=03h,AH=2Ah

(Table 00592)
Values for HUNTER 16 Typematic rate:
 00h	30.0	 08h	15.0	 10h	7.5	 18h	3.7
 01h	26.7	 09h	13.3	 11h	6.7	 19h	3.3
 02h	24.0	 0Ah	12.0	 12h	6.0	 1Ah	3.0
 03h	21.8	 0Bh	10.9	 13h	5.5	 1Bh	2.7
 04h	20.0	 0Ch	10.0	 14h	5.0	 1Ch	2.5
 05h	18.5	 0Dh	 9.2	 15h	4.6	 1Dh	2.3
 06h	17.1	 0Eh	 8.6	 16h	4.3	 1Eh	2.1
 07h	16.0	 0Fh	 8.0	 17h	4.0	 1Fh	2.0
SeeAlso: AH=2Ah
--------b-162A------------------------------------
INT 16 - HUNTER 16 - CONTROL KEY REPEAT
	AH = 2Ah
	AL = new state of keyboard autorepeat (00h disabled, 01h enabled)
SeeAlso: AH=03h,AH=26h,AH=29h,AH=2Bh
--------b-162B------------------------------------
INT 16 - HUNTER 16 - REDEFINE KEY SCAN CODES
	AH = 2Bh
	AL = which key table to redefine
	    00h unshifted
	    01h shifted
	    02h Numlock
	BH = standard scan code of key (00h-80h)
	BL = new scan code
Desc:	redefine the generated scan code from BH to BL
SeeAlso: AH=24h,AH=2Ah,AH=2Ch
--------b-162C------------------------------------
INT 16 - HUNTER 16 - REDEFINE RAW KEY CODES
	AH = 2Ch
	AL = Matrix code of key (see AH=29h)
	BL = new key code
Return: AL = status (00h success, nonzero failed)
Desc:	redefine the key code generated by holding the PAW key down and
	  pressing the key in AL
SeeAlso: AH=24h,AH=2Bh
--------b-162D------------------------------------
INT 16 - HUNTER 16 - CONTROL BREAK KEYS
	AH = 2Dh
	AL = enabled break keys
	    bit 0 Ctrl-C
	    bit 1 Ctrl-Break
	BX = 0708h
	CX = 0910h
	DX = 1112h
Return: AL = status (00h success, FFh failed)
SeeAlso: AH=21h"HUNTER"
--------U-163577-----------------------------
INT 16 U - TextWare TWTSR - API
	AX = 3577h
	CX = function
	    00CBh ???
		Return: AX = 0000h
			BX = 0000h
			DX:CX -> ???
	    00CCh uninstall
		Return: AX = status
			    0000h successful
			    FFFDh unable to unload because vectors taken
	    00CDh ???
		Return: AX = 0000h
			BX = 0000h
			DX:CX -> ???
	    other
		Return: AX = 5345h ('SE')
Program: TWTSR is a TSR which allows the TextWare hypertext browser to be
	  popped up via hotkey
SeeAlso: AX=D724h
--------U-164252-----------------------------
INT 16 - TEXTCAP 2.0 - INSTALLATION CHECK
	AX = 4252h
Return: AX = 5242h if installed
Program: TEXTCAP 2.0 is a heavily modified (by Gisbert W. Selke) version of
	  the PC Magazine utility CAPTURE written by Tom Kihlken
SeeAlso: AX=4253h,AX=4254h
--------U-164253-----------------------------
INT 16 - TEXTCAP 2.0 - UNINSTALL
	AX = 4253h
Return: AX = segment of resident code
Notes:	the uninstall code does not check whether interrupt vectors have been
	  chained by other programs
	the caller must free the main memory block (using the returned segment)
SeeAlso: AX=4252h,AX=4254h
--------U-164254-----------------------------
INT 16 - TEXTCAP 2.0 - DUMP TEXT SCREEN TO FILE
	AX = 4254h
Return: AX = status
	    4254h if screen dump will be written as soon as disk becomes idle
	    5442h if screen dump written
SeeAlso: AX=4252h,AX=4253h
--------e-164500-----------------------------
INT 16 - Shamrock Software EMAIL - GET STATUS
	AX = 4500h
	DL = port number (01h = COM1)
	ES:BX -> 13-byte buffer for ASCIZ name
Return: AX = 4D00h if EMAIL installed on specified port
	    ES:BX -> "" if no connection
		  -> "*" if connection but caller has not identified name
		  -> name otherwise
	    CX = version (CH = major, CL = minor)
	    DL = privilege level of user (00h = guest)
	    DH = chosen language (00h German, 01h English)
SeeAlso: AX=4501h,AX=4502h
--------e-164501-----------------------------
INT 16 - Shamrock Software EMAIL - GET ELAPSED ONLINE TIME AND MAXIMUM TIME
	AX = 4501h
	DL = port number (01h = COM1)
Return: AX = 4D00h if EMAIL installed on specified port
	    BX = maximum connect time in clock ticks
	    CX = maximum connect time for guests (without name) in clock ticks
	    DX = elapsed connect time of current user in clock ticks
SeeAlso: AX=4500h
--------e-164502-----------------------------
INT 16 - Shamrock Software EMAIL - GET CURRENT COMMUNICATIONS PARAMETERS
	AX = 4502h
	DL = port number (01h = COM1)
Return: AX = 4D00h if EMAIL installed on specified port
	    BL = current value of serial port's Line Control Register
	    BH = flags (see #00593)
	    CX = selected country code (33 = France, 49 = Germany, etc)
	    DX = baudrate divisor (115200/DX = baudrate)
SeeAlso: AX=4500h

Bitfields for Shamrock Software EMAIL flags:
Bit(s)	Description	(Table 00593)
 0	ISO code
 1	pause
 2	linefeed
 3	ANSI sequences
--------e-164503-----------------------------
INT 16 - Shamrock Software EMAIL - SPECIFY COMMAND-WORD FOR USER FUNCTION
	AX = 4503h
	DL = port number (01h = COM1)
	DH = maximum execution time in clock ticks (00h = 5 seconds)
	ES:BX -> ASCIZ string with new user command-word
Return: AX = 4D00h if EMAIL installed on specified port
Notes:	a single user command (consisting of only uppercase letters and digits)
	  may be defined, and remains valid until it is overwritten or the
	  EMAIL program terminates; the user command must be activated by
	  calling AX=4504h at least once.
	an existing command word may be redefined with this function
SeeAlso: AX=4504h,AX=4505h
--------e-164504-----------------------------
INT 16 - Shamrock Software EMAIL - CHECK FOR USER FUNCTION COMMAND-WORD
	AX = 4504h
	DL = port number (01h = COM1)
	ES:BX -> 80-byte buffer for ASCIZ user input line
Return: AX = 4D00h if EMAIL installed on specified port
	    DL = flags
		bit 0: user function supported (always set)
		bit 1: user entered user-function command word
	    if DL bit 1 set,
		ES:BX buffer contains line entered by user which begins with
			the defined command word and has been converted to all
			caps
Note:	caller must process the returned commandline and invoke AX=4505h
	  within five seconds with the result of that processing
SeeAlso: AX=4503h,AX=4505h
--------e-164505-----------------------------
INT 16 - Shamrock Software EMAIL - SEND RESULT OF USER FUNCTION
	AX = 4505h
	DL = port number (01h = COM1)
	DH = error flag
	    bit 3: set on error
	ES:BX -> ASCIZ text to return to user, max 1024 bytes
Return: AH = 4Dh if EMAIL installed on specified port
	AL = status
	    00h successful
	    02h unable to perform function (timeout, prev call not complete)
	    other error
Notes:	if the error flag in DH is set, the string is not sent and an error
	  message is generated instead; if this function is not called within
	  five seconds of AX=4504h, EMAIL automatically generates an error
	  message
	the string is copied into an internal buffer, allowing this function's
	  caller to continue immediately
SeeAlso: AX=4503h,AX=4504h,INT 17/AX=2400h
--------e-164506-----------------------------
INT 16 - Shamrock Software EMAIL - MONITOR XMODEM DOWNLOAD
	AX = 4506h
	DL = port number (01h = COM1)
	ES:BX -> 13-byte buffer for ASCIZ filename
Return: AX = 4D00h if EMAIL installed on specified port
	    DH = Xmodem status
		00h no XGET command given
		01h XGET in progress
		02h XGET completed successfully
	    ES:BX buffer filled with last filename given to XGET command
		(without path)
Note:	DH=02h will only be returned once per XGET; subsequent calls will
	  return DH=00h
SeeAlso: AX=4500h,INT 17/AX=2408h
--------K-164B-------------------------------
INT 16 - Frank Klemm Keyboard Driver v2.0 - API
	AH = 4Bh
	CX = code or action
	    0000h-FEFFh key code
	    FF00h-FFFFh action (see #00594)
	BL = scan code (normal keys) or scan code + 60h (enhanced keys)
	BH = shift state (see #00595)
Return: CX = previous code or action

(Table 00594)
Values for Frank Klemm Keyboard Driver action code:
 FF00h	no action
 FF01h	hardcopy
 FF02h	left shift
 FF03h	right shift
 FF04h	left Ctrl
 FF05h	right Ctrl
 FF06h	left Alt
 FF07h	right Alt / AltGr
 FF08h	CapsLock
 FF09h	NumLock
 FF0Ah	ScrlLock
 FF0Bh	Insert (returns code 5200h or 52E0h)
 FF0Ch	Pause
 FF0Dh	Ctrl-Break function
 FF0Eh	warm boot via far jump to F000h:FFF0h
 FF0Fh	terminate current program
 FF10h	key for entering keys via Alt-numpad (read-only)
 FF11h	clear keyboard buffer
 FF12h	reset (warmboot on XT)
 FF13h	mouse sensitivity (read-only)
 FF14h	keyjobs (read-only)
 FF15h	SysRq
 FF16h	turn on CPU cache (486+)
 FF17h	turn off CPU cache (486+)
SeeAlso: #00595

(Table 00595)
Values for Frank Klemm Keyboard Driver shift state:
 00h	no shift keys
 01h	either Shift
 02h	either Ctrl
 03h	left Alt
 04h	Ctrl + Alt
---standard keyboard---
 05h	right Alt / AltGr
---Russian keyboard---
 05h	Russian + no shift keys
 06h	Russian + either Shift
SeeAlso: #00594
--------K-164D4F-----------------------------
INT 16 - M16_KBD.COM v5.6 - INSTALLATION CHECK
	AX = 4D4Fh
Return: AX = 6F6Dh if installed
	    ES = segment of resident code
Program: M16_KBD is a shareware Cyrillic keyboard driver by I.V. Morozov
SeeAlso: INT 10/AX=1130h/BX=4D4Fh
--------J-165000-----------------------------
INT 16 - KEYBOARD - AX PC - SET KEYBOARD COUNTRY CODE
	AX = 5000h
	BX = country code
	    0001h USA (English), 0051h Japan
Return: AL = status
	    00h successful
	    01h bad country code
	    02h other error
Notes:	This function is called with BX=0051h by Japanese versions of
	  MS-DOS/PC DOS/DR DOS IO.SYS/IBMBIO.COM at initialization time.
	the K3PLUS v6.00+ INT 16 BIOS replacement will switch between the
	  supported country specific layout (e.g. BX=0031h Germany, BX=001Fh
	  Netherlands, BX=0020h Belgium, BX=0022h Spain) (as with <Ctrl>+
	  <Alt>+<F2>) and K3PLUS' transparent mode (as with <Ctrl>+<Alt>+<F1>).
	In transparent mode (BX=0001h), K3PLUS chains to the underlying
	  driver (normally the BIOS driver with US-layout). K3PLUS beeps on
	  mode changes
SeeAlso: AX=5001h,AX=AF4Dh,INT 10/AX=5000h,INT 17/AX=5000h
--------J-165001-----------------------------
INT 16 - KEYBOARD - AX PC - GET KEYBOARD COUNTRY CODE
	AX = 5001h
Return: AL = status
	    00h successful
		BX = country code
	    02h error
Note:	also supported by K3PLUS v6.00+
SeeAlso: AX=5000h,INT 10/AX=5001h,INT 17/AX=5001h
--------J-1651-------------------------------
INT 16 - KEYBOARD - AX PC - READ SHIFT KEY STATUS
	AH = 51h
Return: AL = standard shift key states (see #00582,#00587)
	AH = Kana lock (00h off, 01h on)
Note:	also supported by K3PLUS v6.00+, but K3PLUS always returns AH=00h
SeeAlso: AH=02h,AH=12h,AH=22h
--------t-165453BX5242-----------------------
INT 16 - TSRBONES - INSTALLATION CHECK
	AX = 5453h ('TS')
	BX = 5242h ('RB')
	CX = 4F4Eh ('ON')
	DX = 4553h ('ES')
Return: AX = 4553h if installed
	BX = 4F4Eh if installed
	CX = 5242h if installed
	DX = 5453h if installed
Program: TSRBONES is a skeletal TSR framework by Robert Curtis Davis
Note:	these values are the default as the TSRBONES package is distributed,
	  but will normally be changed when implementing an actual TSR with
	  the TSRBONES skeleton
SeeAlso: INT 2D/AL=00h"AMIS"
--------K-165472BX4C54-----------------------
INT 16 - TrLit - API
	AX = 5472h ('Tr')
	BX = 4C54h ('Lt')
	CL = function
	    00h installation check
		Return:	DX = 1234h if installed
			    AX = 100*version (binary, 00E9h = v2.33)
			    CX = resident code segment
	    01h get original INT 09 vector
		Return: ES:BX -> previous handler
	    02h get original INT 16 vector
		Return: ES:BX -> previous handler
	    else chained
	CH = 00h (for backward compatibility with versions before 2.30)
Program: TrLit is a Russian keyboard transliterator by Rostislav Krasny
Index:	installation check;TrLit
--------A-165500-----------------------------
INT 16 C - Microsoft Word internal - MICROSOFT WORD COOPERATION WITH TSR
	AX = 5500h
Return: AX = 4D53h ('MS') if keyboard TSR present
Notes:	during startup, Microsoft Word tries to communicate with any TSRs
	  that are present through this call.
	if the return is not 4D53h, Word installs its own INT 09 and INT 16
	  handlers; otherwise it assumes that the TSR will handle the keyboard
SeeAlso: AX=55FFh,INT 1A/AX=3601h
--------A-1655FE-----------------------------
INT 16 CU - Microsoft QBASIC internal - MICROSOFT COOPERATION WITH TSR
	AX = 55FEh
	DX = function
	    0000h initialize
		ES:BX -> ??? function
		ES:CX -> ??? structure
	    FFFFh shutdown/reset
Return: AX = result
	    4D4Bh only the INT 1B handler will be installed.
	    other: handlers for INT 08, INT 09, INT 16, INT 1B, and INT 1C
		  are installed
Notes:	The pointer in ES:CX seems to point at a structure defining a callback
	  function when new keyboard keys are pressed. If a TSR returns
	  AX=4D4Bh, QBASIC will stop (with IRQ's and interrupts enabled).
	these calls are also made by MS-DOS 6.0's DOSSHELL at startup, exit,
	  and before/after shelling out
	since EDIT.COM and HELP.COM merely invoke QBASIC, those two programs
	  will also cause this interface to be invoked
	K3PLUS v6.07+ supports this function, but will never invoke the
	  callback function
SeeAlso: AX=5500h,AX=AF4Dh,INT 1A/AX=3601h
--------U-1655FF-----------------------------
INT 16 C - Microsoft Word - TSR COOPERATION???
	AX = 55FFh
	BX >= 0004h (version of Microsoft Word [BL = major] ???)
	CX = function
	    0000h set ??? flag
	    other clear ??? flag
Notes:	hooks intercepting this call are present in SWAPSH and SWAPDT v1.77j,
	  distributed with PC Tools v7, as well as the Trusted Access
	  SCRNBLNK.COM; this may be part of the standard TesSeRact library
	known to be called by the German edition of Microsoft Word 5.0
SeeAlso: AX=5500h,INT 2F/AX=5453h
--------c-165758BX4858-----------------------
INT 16 U - Netroom CACHECLK - INSTALLATION CHECK
	AX = 5758h
	BX = 4858h ('HX')
	DX = 4443h ('DC')
	CX <> 5758h
Return: BX = 6878h if installed
	CX = 6463h if installed
	    AX = code segment of TSR
	    CX = internal version??? (v3.00 returns 0100h)
Program: CACHECLK is a "cloaked" disk cache included with Netroom
Notes:	if CX=5758h on entry, CACHECLK returns with all registers unchanged
	the cache statistics are located early in the segment pointed at by
	  AX on return
SeeAlso: INT 2F/AX=5758h
--------m-165758BX5754-----------------------
INT 16 U - Netroom ??? - ???
	AX = 5758h
	BX = 5754h
	???
Return: ???
--------m-165758BX5755-----------------------
INT 16 U - Netroom ??? - ???
	AX = 5758h
	BX = 5755h
	DS:SI -> ???
Return: ???
--------m-165758BX5756-----------------------
INT 16 U - Netroom ??? - INSTALLATION CHECK
	AX = 5758h
	BX = 5756h
Return: BX <> 5756h if installed
--------m-165758BX5858-----------------------
INT 16 U - Netroom PRENET - GET OLD INTERRUPT VECTORS
	AX = 5758h
	BX = 5858h
Return: CF clear
	DX:BX -> saved copy of interrupt vector table
InstallCheck:	call this function and compare BX against 5858h on return; if
	  it has changed, PRENET is installed
SeeAlso: AX=5758h/BX=5859h
Index:	installation check;Netroom PRENET
--------m-165758BX5859-----------------------
INT 16 U - Netroom POSTNET - GET OLD INTERRUPT VECTORS
	AX = 5758h
	BX = 5859h
Return: CF clear
	DX:BX -> saved copy of interrupt vector table
InstallCheck:	call this function and compare BX against 5859h on return; if
	  it has changed, POSTNET is installed
SeeAlso: AX=5758h/BX=5858h
Index:	installation check;Netroom POSTNET
----------1667-------------------------------
INT 16 - Doorway v2.x+ - INSTALLATION CHECK / REDIRECTION CONTROLa
	AH = 67h
	AL = Doorway mode
	    00h turn off DOS redirection
	    01h turn on DOS redirection
Return: AH = 80h if Doorway is actively redirecting output
	    AL = 80h if Doorway was already in requested mode
Program: Doorway is a program by Marshall Dudley which allows most DOS programs
	  to run as a BBS door without modification
Note:	to perform an installation check without changing the redirection
	  state, if is necessary to restore the original mode if AL was not
	  80h on return
SeeAlso: INT 10/AH=BBh"Doorway"
--------U-166969BX6968-----------------------
INT 16 - PC Tools v5.1+ BACKTALK - UNHOOK
	AX = 6969h
	BX = 6968h
Return: resident code unhooked, but not removed from memory
Index:	uninstall;BACKTALK
--------U-166969BX6969-----------------------
INT 16 - PC Tools v5.1+ BACKTALK - INSTALLATION CHECK
	AX = 6969h
	BX = 6969h
	DX = 0000h
Return: DX nonzero if installed
	    BX = CS of resident code
	    DX = PSP segment of resident code
	    DS:SI -> ASCIZ identification string "CPoint Talk"
--------i-166A6B-----------------------------
INT 16 U - FastJuice - DISABLE/UNLOAD???
	AX = 6A6Bh
Return: ???
Program: FastJuice is a resident battery-power monitor by SeaSide Software
SeeAlso: AX=7463h
Index:	uninstall;FastJuice
--------G-166C63-----------------------------
INT 16 U - TMED v1.6a - INSTALLATION CHECK
	AX = 6C63h ('lc')
Return: AX = 4C43h ('LC') if installed
Program: TMED is a freeware resident memory editor by Liang Chen
--------U-166D74-----------------------------
INT 16 - MTRTSR - INSTALLATION CHECK
	AX = 6D74h ('mt')
Return: AX = 4D54h ('MT') if installed
Program: MTRTSR is a part of the shareware MTR package by Mechon Mamre which
	  permits searching the large corpus of classical Hebrew texts in the
	  package
SeeAlso: INT 10/AX=6D74h"MTRFONTS"
--------b-166F00-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_INQUIRE" - Extended BIOS INSTALLATION CHECK
	AX = 6F00h
	BX <> 4850h (usually set to 0000h for simplicity)
Return: BX = 4850h ("HP") if present
Notes:	called by recent MS Mouse drivers looking for an HP-HIL mouse
	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F01h,AX=6F04h,AX=6F07h,AX=6F09h,AX=6F0Dh,AX=6F11h,AX=6F12h
SeeAlso: INT 14/AX=6F00h,INT 17/AX=6F00h,INT 33/AX=6F00h
SeeAlso: INT 6F/AH=00h"HP Vectra"
--------b-166F01-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_DEF_ATTR" - GET DEFAULT TYPEMATIC VALUES
	AX = 6F01h
Return: AH = 00h (successful)
	CX = 0004h (size of returned buffer)
	ES:SI -> buffer for typematic info (see #00596)
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F00h,AX=6F02h,AX=6F03h,AX=6F04h

Format of HP Vectra EX-BIOS typematic info:
Offset	Size	Description	(Table 00596)
 00h	BYTE	delay before repeat for all non-Cursor Control Pad keys
		(see #00597)
 01h	BYTE	typematic rate for all non-Cursor Control Pad keys (see #00598)
 02h	BYTE	delay before repeat for Cursor Control Pad keys	(see #00599)
 03h	BYTE	typematic rate for Cursor Control Pad keys (see #00598)

(Table 00597)
Values for HP Vectra EX-BIOS non-CCP delay time:
 00h	17 ms
 01h	150 ms
 02h	283 ms
 03h	417 ms
 04h	550 ms
 05h	683 ms
 06h	817 ms
 07h	950 ms
 08h	1083 ms
 09h	1217 ms
 0Ah	1350 ms
 0Bh	1483 ms
 0Ch	1617 ms
 0Dh	1750 ms
 0Eh	1883 ms
 0Fh	2017 ms
Note:	the above values assume that the key repeat rate has been set to 60 Hz;
	  double the times if set to 30 Hz
SeeAlso: #00596,#00598,#00599

(Table 00598)
Values for HP Vectra EX-BIOS typematic rate:
 00h	60 / sec
 01h	30 / sec
 02h	20
 03h	15
 04h	12
 05h	10
 06h	8.57
 07h	7.5
 08h	6.66
 09h	6 / sec
 0Ah	5.45
 0Bh	5
 0Ch	4.62
 0Dh	4.28
 0Eh	4 / sec
 0Fh	typematic disabled
Note:	the above values assume that the key repeat rate has been set to 60 Hz;
	  halve the rates if set to 30 Hz
SeeAlso: #00597,#00599

(Table 00599)
Values for HP Vectra EX-BIOS CCP delay time:
 00h	17 ms
 01h	83 ms
 02h	150 ms
 03h	217 ms
 04h	283 ms
 05h	350 ms
 06h	417 ms
 07h	483 ms
 08h	550 ms
 09h	617 ms
 0Ah	683 ms
 0Bh	750 ms
 0Ch	817 ms
 0Dh	883 ms
 0Eh	950 ms
 0Fh	1017 ms
Note:	the above values assume that the key repeat rate has been set to 60 Hz;
	  double the times if set to 30 Hz
SeeAlso: #00597,#00598
--------b-166F02-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_GET_ATTR" - GET CURRENT TYPEMATIC VALUES
	AX = 6F02h
Return: AH = 00h (successful)
	CX = 0004h (size of returned buffer)
	ES:SI -> buffer for typematic info (see #00596)
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F00h,AX=6F02h,AX=6F03h,AX=6F04h
SeeAlso: AX=6F00h,AX=6F01h,AX=6F03h
--------b-166F03-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_SET_ATTR" - SET TYPEMATIC VALUES
	AX = 6F03h
	ES:SI -> buffer containing typematic info (see #00596)
Return: AH = 00h (successful)
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F00h,AX=6F02h,AX=6F03h,AX=6F04h
SeeAlso: AX=6F00h,AX=6F01h,AX=6F02h
--------b-166F04-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_DEF_MAPPING" - GET DEFAULT KEY MAPPINGS
	AX = 6F04h
	ES:SI -> mapping buffer (see #00600)
Return: AH = 00h (successful)
	CX = 001Eh (number of bytes in buffer)
	ES:SI buffer filled
Notes:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
	the HIL input system translates the HIL keyboard events to simulate
	  an IBM-compatible keyboard; the translation can be altered
	  dynamically by applications
SeeAlso: AX=6F00h,AX=6F05h,AX=6F06h

Format of HP Vectra EX-BIOS keyboard mapping info:
Offset	Size	Description	(Table 00600)
 00h  3 WORDs	entry for V_QWERTY driver (IP, CS, DS)
 06h  3 WORDs	entry for V_SOFTKEY driver (IP, CS, DS)
 0Ch  3 WORDs	entry for V_FUNCTION driver
 12h  3 WORDs	entry for V_NUMPAD driver
 18h  3 WORDs	entry for V_CCP driver
--------b-166F05-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_GET_MAPPING" - GET CURRENT KEY MAPPINGS
	AX = 6F05h
	ES:SI -> mapping buffer (see #00600)
Return: AH = 00h (successful)
	CX = 001Eh (number of bytes in buffer)
	ES:SI buffer filled
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F04h,AX=6F06h
--------b-166F06-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_SET_MAPPING" - SET KEY MAPPINGS
	AX = 6F06h
	CX = number of bytes in buffer (001Eh)
	ES:SI -> mapping buffer (see #00600)
Return: AH = 00h (successful)
Notes:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
	any application which modifies the key mappings should restore them
	  before terminating
	drivers installed with this function are assured of 32 bytes of stack
	  space when they are invoked
SeeAlso: AX=6F04h,AX=6F05h,AX=6F07h
--------b-166F07-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_SET_XLATORS" - SET CCP AND SOFTKEY PADS
	AX = 6F07h
	BL = translation to set (see #00601)
Return: AH = 00h (successful)
Notes:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
	this function may no longer work properly if the application has
	  modified the key mappings with AX=6F06h
SeeAlso: AX=6F06h,AX=6F09h

(Table 00601)
Values for HP Vectra keyboard translation specifier:
 00h	map V_CCP to V_CCPCUR, forcing the cursor pad to return cursor keys
 01h	map V_CCP to V_CCPNUM, forcing the cursor pad to always return numbers
 02h	map V_CCP to V_OFF, disabling the cursor pad
 03h	map V_CCP to V_CCPGID, converting cursor pad keys to GID data
 04h	map V_CCP to V_RAW, passing cursor pad data untranslated to INT 09
 05h	map V_SOFTKEY to V_SKEY2KFEY, translating into standard function keys
 06h	map V_SOFTKEY to V_RAW, passing Softkey scancodes direct to INT 09
 07h	map V_SOFTKEY to V_OFF, disabling HP Softkeys
SeeAlso: #00602

(Table 00602)
Values for HP Vectra scancodes and BIOS keycodes for V_RAW translator:
	      INT 09		 INT 16 keycode
    Key	     scan code	Default	 Shifted   Ctrl	     Alt
 * (NumPd)	37h	2Ah	 (Prt Sc)  00/72h    00/37H
 Sysreq		54h	  --	 --	   --	     --
 CCP-Up		60h	00/D9h	 00/BFh	   00/A5h    00/8BH
 CCP-Left	61h	00/DAh	 00/C0h	   00/A6h    00/8CH
 CCP-Down	62h	00/DBh	 00/C1h	   00/A7h    00/8DH
 CCP-Right	63h	00/DCh	 00/C2h	   00/A8h    00/8EH
 CCP-Home	64h	00/DDh	 00/C3h	   00/A9h    00/8FH
 CCP-PgUp	65h	00/DEh	 00/C4h	   00/AAh    00/90H
 CCP-End	66h	00/DFh	 00/C5h	   00/ABh    00/91H
 CCP-PgDn	67h	00/E0h	 00/C6h	   00/ACh    00/92H
 CCP-Ins	68h	00/E1h	 00/C7h	   00/ADh    00/93H
 CCP-Del	69h	00/E2h	 00/C8h	   00/AEh    00/94H
 CCP-CNTR	6Ah	00/E3h	 00/C9h	   00/AFh    00/95H
 f1		70h	00/E9h	 00/CFh	   00/B5h    00/9BH
 f2		71h	00/EAh	 00/D0h	   00/B6h    00/9CH
 f3		72h	00/EBh	 00/D1h	   00/B7h    00/9DH
 f4		73h	00/ECh	 00/D2h	   00/B8h    00/9EH
 f5		74h	00/EDh	 00/D3h	   00/B9h    00/9FH
 f6		75h	00/EEh	 00/D4h	   00/BAh    00/A0H
 f7		76h	00/EFh	 00/D5h	   00/BBh    00/A1H
 f8		77h	00/F0h	 00/D6h	   00/BCh    00/A2H
Note:	only HP-specific codes are listed in this table; see INT 09 for a full
	  list of standard scan codes
SeeAlso: #00006,#00601
--------b-166F08-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_KBD" - GET KEYBOARD INFORMATION
	AX = 6F08h
Return: AH = status
	   00h successful
	   02h unsupported (non-HIL, i.e. standard, keyboard)
	BH = HP-HIL address (HP Vectra AT only???)
	BL = HP-HIL ID (HP Vectra AT only???)
	BL = keyboard language (ES/QS/RS only???) (see #00603)
Notes:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
	the driver's address in the HP_VECTOR_TABLE (see INT 6F/AH=00h) may
	  be computed as (BH-1)*6 + N, where N is the address of the first
	  HP-HIL device driver (see INT 6F/AH=0Ah"F_INQUIRE_FIRST")
SeeAlso: AX=6F05h,AX=6F09h,INT 6F/AH=0Ah"F_INQUIRE_FIRST"

(Table 00603)
Values for HP HIL keyboard language code:
 00h	reserved
 01h	Arabic-French
 02h	Kanji
 03h	Swiss-French
 04h	Portugese
 05h	Arabic
 06h	Hebrew
 07h	Canadian-English
 08h	Turkish
 09h	Greek
 0Ah	Thai
 0Bh	Italian
 0Ch	Hangul (Korean)
 0Dh	Dutch
 0Eh	Swedish
 0Fh	German
 10h	Chinese (PRC)
 11h	Chinese (Taiwan)
 12h	Swiss (French ii)
 13h	Spanish
 14h	Swiss (German ii)
 15h	Belgian (Flemish)
 16h	Finnish
 17h	United Kingdom
 18h	French-Canadian
 19h	French-German
 1Ah	Norwegian
 1Bh	French
 1Ch	Danish
 1Dh	Katakana
 1Eh	Latin American Spanish
 1Fh	United States-American
 20h-FEh reserved
 FFh	non-HP keyboard (IBM AT keyboard and IBM Enhanced keyboard)
--------b-166F09-----------------------------
INT 16 - HP Vectra EX-BIOS - "F16_KBD_RESET" - RESET KEYBOARD TO DEFAULTS
	AX = 6F09h
Return: AH = 00h (successful)
Desc:	reset all keyboard mappings to their default translators, and reset
	  typematic values to their defaults
Note:	supported by the original HP Vectra AT and ES/QS/RS series HP Vectras
SeeAlso: AX=6F04h,AX=6F07h,AX=6F08h
--------b-166F0A-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - READ PROCESSOR SPEED
	AX = 6F0Ah
Return: AH = 00h (successful)
	BX = speed code
	    0Bh for low speed (see #00604)
	    12h for medium speed (see #00604)
	    0Ch for high speed (see #00604)
Note:	supported by ES, QS, and RS series of HP Vectras
SeeAlso: AX=6F00h

(Table 00604)
Values for HP Vetra CPU speed:
	Vectra		Low	    Medium	High
	ES		8 MHz	     -		 8 MHz
	ES/12		8 MHz	     -		12 MHz
	QS/16, RS/16	8 MHz	     -		16 MHz
	QS/16S		8 MHz	     -		16 MHz
	QS/20, RS/20	8 MHz	     -		20 MHz
	RS/20C		5 MHz	    10 MHz	20 MHz
	RS/25C		5 MHz	    12.5 MHz	25 MHz
--------b-166F0B-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - SET PROCESSOR SPEED TO LOW
	AX = 6F0Bh
Return: AH = 00h (successful)
Notes:	see AX=6F0Ah for speed definitions
	supported by ES, QS, and RS series of HP Vectras
SeeAlso: AX=6F00h,AX=6F0Ah
--------b-166F0C-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - SET PROCESSOR SPEED TO HIGH
	AX = 6F0Ch
Return: AH = 00h (successful)
Notes:	see AX=6F0Ah for speed definitions
	supported by ES, QS, and RS series of HP Vectras
SeeAlso: AX=6F00h,AX=6F0Ah
--------b-166F0D-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - GET HIL Extended BIOS INTERRUPT NUMBER
	AX = 6F0Dh
Return: AH = interrupt number (default 6Fh, 02h means 6Fh as well)
Notes:	supported by ES, QS, and RS series of HP Vectras
	called by MS Windows HPSYSTEM.DRV and HPEBIOS.386 to support the HP-HIL
	  input system
SeeAlso: AX=6F00h,AX=6F0Eh,INT 6F/AH=00h"HP Vectra",INT 6F/AH=0Ah"HP"
--------b-166F0E-----------------------------
INT 16 - HP Vectra ES/QS/RS EX-BIOS - SET HIL Extended BIOS INTERRUPT NUMBER
	AX = 6F0Eh
	BL = new interrupt number (60h-6Fh,78h-7Fh)
Return: AH = status (00h = successful)
Desc:	allows the HIL Extended BIOS software to use a non-default interrupt
	  number in case of an interrupt conflict with another application
Notes:	supported by ES, QS, and RS series of HP Vectras
	called by MS Windows HPSYSTEM.DRV and HPEBIOS.386 to support the HP-HIL
	  input system
SeeAlso: AX=6F00h,AX=6F0Dh,INT 6F/AH=00h"HP",INT 6F/AH=0Ah"HP"
--------b-166F0F-----------------------------
INT 16 - HP Vectras RS/20C and RS/25C - ENABLE MEMORY CACHING
	AX = 6F0Fh
Return: AH = status
	    00h successful
	    FEh cache subsystem is bad
SeeAlso: AX=6F00h,AX=6F10h,AX=6F11h
--------b-166F10-----------------------------
INT 16 - HP Vectras RS/20C and RS/25C - DISABLE MEMORY CACHING
	AX = 6F10h
Return: AH = 00h (successful)
SeeAlso: AX=6F00h,AX=6F0Fh,AX=6F11h
--------b-166F11-----------------------------
INT 16 - HP Vectras RS/20C and RS/25C - GET MEMORY CACHING STATE
	AX = 6F11h
Return: AH = 00h (successful)
	AL bit 0 = cache state
	    0 cache disabled
	    1 cache enabled
SeeAlso: AX=6F00h,AX=6F0Fh,AX=6F10h
--------b-166F12-----------------------------
INT 16 - HP Vectras RS/20C and RS/25C - SET PROCESSOR SPEED TO MEDIUM
	AX = 6F12h
Return: AH = 00h (successful)
Note:	see AX=6F0Ah for speed definitions
SeeAlso: AX=6F00h,AX=6F0Ah
--------K-1670-------------------------------
INT 16 - FAKEY.COM - INSTALLATION CHECK
	AH = 70h
Return: AX = 1954h if installed
Program: FAKEY is a keystroke faking utility by System Enhancement Associates
--------K-1671-------------------------------
INT 16 - FAKEY.COM - PUSH KEYSTROKES
	AH = 71h
	CX = number of keystrokes
	DS:SI -> array of words containing keystrokes to be returned by AH=00h
Program: FAKEY is a keystroke faking utility by System Enhancement Associates
SeeAlso: AH=05h,AH=72h
--------K-1672-------------------------------
INT 16 - FAKEY.COM - CLEAR FAKED KEYSTROKES
	AH = 72h
Program: FAKEY is a keystroke faking utility by System Enhancement Associates
SeeAlso: AH=71h
--------K-1673-------------------------------
INT 16 - FAKEY.COM - PLAY TONES
	AH = 73h
	CX = number of tones to play
	DS:SI -> array of tones (see #00605)
Program: FAKEY is a keystroke faking utility by System Enhancement Associates
SeeAlso: INT 15/AX=1019h

Format of FAKEY.COM tone array entries:
Offset	Size	Description	(Table 00605)
 00h	WORD	divisor for timer channel 2
 02h	WORD	duration in clock ticks
--------i-167463-----------------------------
INT 16 U - FastJuice - INSTALLATION CHECK
	AX = 7463h ("tc")
Return: AX = 5443h ("TC") if installed
Program: FastJuice is a resident battery-power monitor by SeaSide Software
SeeAlso: AX=6A6Bh
--------R-1675-------------------------------
INT 16 - pcANYWHERE III - SET TICK COUNT FOR SCANNING
	AH = 75h
	AL = number of ticks between checks for new screen changes
--------R-1676-------------------------------
INT 16 - pcANYWHERE III - SET ERROR CHECKING TYPE
	AH = 76h
	AL = error checking type
	    00h none
	    01h fast
	    02h slow
--------R-1677-------------------------------
INT 16 - pcANYWHERE III - LOG OFF
	AH = 77h
	AL = mode
	    00h wait for another call
	    01h leave in Memory Resident Mode
	    02h leave in Automatic Mode
	    FFh leave in current operating mode
--------U-167761-----------------------------
INT 16 - WATCH.COM v2.x-v3.0 - INSTALLATION CHECK
	AX = 7761h ('wa')
Return: AX = 5741h ('WA') if installed
Note:	WATCH.COM is part of the "TSR" package by Kim Kokkonen
SeeAlso: INT 21/AX=7761h
--------U-167788BX7789-----------------------
INT 16 - PC Magazine PUSHDIR.COM - INSTALLATION CHECK
	AX = 7788h
	BX = 7789h
	DS:SI -> signature "PUSHDIR VERSION 1.0"
Return: AX = 7789h if installed and signature correct
	BX = 7788h
	SI destroyed
--------R-1679-------------------------------
INT 16 - pcANYWHERE III - CHECK STATUS
	AH = 79h
Return: AX = status
	    FFFFh if resident and active
	    FFFEh if resident but not active
	    FFFDh if in Memory Resident mode
	    FFFCh if in Automatic mode
	    other value if not resident
SeeAlso: AX=7B00h,INT 21/AX=2B44h
--------R-167A-------------------------------
INT 16 - pcANYWHERE III - CANCEL SESSION
	AH = 7Ah
--------R-167B00-----------------------------
INT 16 - pcANYWHERE III - SUSPEND
	AX = 7B00h
SeeAlso: AH=79h,AX=7B01h
--------R-167B01-----------------------------
INT 16 - pcANYWHERE III - RESUME
	AX = 7B01h
SeeAlso: AH=79h,AX=7B00h
--------R-167C-------------------------------
INT 16 - pcANYWHERE III - GET PORT CONFIGURATION
	AH = 7Ch
Return: AH = port number
	AL = baud rate (see #00606)
SeeAlso: AX=7B00h,AH=7Eh

(Table 00606)
Values for pcANYWHERE III baud rate:
 00h	50 baud
 01h	75 baud
 02h	110 baud
 03h	134.5 baud
 04h	150 baud
 05h	300 baud
 06h	600 baud
 07h	1200 baud
 08h	1800 baud
 09h	2000 baud
 0Ah	2400 baud
 0Bh	4800 baud
 0Ch	7200 baud
 0Dh	9600 baud
 0Eh	19200 baud
SeeAlso: #00309
--------R-167D-------------------------------
INT 16 - pcANYWHERE III - GET/SET TERMINAL PARAMETERS
	AH = 7Dh
	AL = subfunction
	    00h set terminal parameters
	    01h get terminal parameters
	    02h get configuration header and terminal parameters
	DS:CX -> terminal parameter block
SeeAlso: AH=7Ch,AH=7Eh
--------R-167E-------------------------------
INT 16 - pcANYWHERE III - COMMUNICATIONS I/O THROUGH PORT
	AH = 7Eh
	AL = subfunction
	    01h port input status
		Return AX = 0 if no characer ready,
		       AX = 1 if character ready
	    02h port input character
		Return AL = received character
	    03h port output character in CX
	    11h hang up phone
SeeAlso: AH=7Ch
--------R-167F-------------------------------
INT 16 - pcANYWHERE III - SET KEYBOARD/SCREEN MODE
	AH = 7Fh
	AL = subfunction
	    00h enable remote keyboard only
	    01h enable host keyboard only
	    02h enable both keyboards
	    08h display top 24 lines
	    09h display bottom 24 lines
	    10h Hayes modem
	    11h other modem
	    12h direct connect
--------U-1680-------------------------------
INT 16 - MAKEY.COM - INSTALLATION CHECK
	AH = 80h
Return: AX = 1954h if installed
Program: MAKEY is a utility by System Enhancement Associates
--------K-1687-------------------------------
INT 16 - DK.COM v1.03 - INSTALLATION CHECK
	AH = 87h
Return: AX = 4A57h ('JW') if installed
Program: DK.COM is the resident part of a small keyboard macro utility
	  by Digital Mechanics.
--------U-168765BX4321-----------------------
INT 16 - AT.COM version 8/26/87 - API
	AX = 8765h
	BX = 4321h
	CX = ??? or FFFFh
	if CX = FFFFh
		DX = number of event to remove or FFFFh
Return: ES:BX -> event record array (see #00607)
Program: AT.COM is a resident scheduler by Bill Frolik

Format of AT.COM event record:
Offset	Size	Description	(Table 00607)
 00h	BYTE	in-use flag (00h free, 01h in use, FFh end of array)
 01h	BYTE	day of date on which to trigger
 02h	BYTE	month of date on which to trigger
 03h	BYTE	trigger time, minute
 04h	BYTE	trigger time, hour
 05h	WORD	offset of command to be executed
--------K-1692-------------------------------
INT 16 - KEYB.COM KEYBOARD CAPABILITIES CHECK (not an actual function!)
	AH = 92h
Return: AH <= 80h if enhanced keyboard functions (AH=10h-12h) supported
Desc:	this function is called by the DOS 3.2 KEYBxx.COM and DOS 5+ KEYB.COM
	  to determine the highest supported keyboard function
Note:	many BIOSes (including at least some versions of Phoenix and AMI) will
	  destroy AH on return from functions higher than AH=12h, returning
	  12h less than was in AH on entry (due to a chain of DEC/JZ
	  instructions)
SeeAlso: AH=05h"PCjr",AH=A2h,INT 2F/AX=AD80h
--------U-1699-------------------------------
INT 16 - SCOUT v5.4 - GET ???
	AH = 99h
Return: AX = ABCDh
	BX:CX -> ??? (appears to be start of PSP for resident portion)
Program: Scout is a memory-resident file manager by New-Ware
SeeAlso: AH=9Eh
--------U-169E-------------------------------
INT 16 - SCOUT v5.4 - INSTALLATION CHECK
	AH = 9Eh
Return: AX = ABCDh if installed
Program: Scout is a memory-resident file manager by New-Ware
SeeAlso: AH=99h
--------K-16A2-------------------------------
INT 16 - KEYB.COM KEYBOARD CAPABILITIES CHECK (not an actual function!)
	AH = A2h
Return: AH <= 80h if 122-key keyboard functions (AH=20h-22h) supported
Desc:	this function is called by the DOS 3.2 KEYBxx.COM and DOS 5+ KEYB.COM
	  to determine the highest supported keyboard function
Note:	many BIOSes (including at least some versions of Phoenix and AMI) will
	  destroy AH on return from functions higher than AH=12h, returning
	  12h less than was in AH on entry (due to a chain of DEC/JZ
	  instructions)
SeeAlso: AH=05h"PCjr",AH=92h,INT 2F/AX=AD80h
--------V-16AA-------------------------------
INT 16 - PTxxx.COM - (xxx=CGA,EGA,VGA,HER...) CALL GATE FOR GRAPHICS
	AH = AAh
	Various registers set up by high level language.
Return: Graphics performed
Note:	PT stands for Paint Tools which is a graphics library for Turbo Pascal,
	  Modula 2 and others from DataBiten in Sweden. The library is
	  installed as a memory resident driver.
--------U-16AABBBXEEFF-----------------------
INT 16 U - JORJ v4.3 - INSTALLATION CHECK
	AX = AABBh
	BX = EEFFh
Return: AX = EEFFh if installed
	BX = AABBh if installed
	    CL = hotkey name (default 6Ah 'j' for Alt-J)
Program: JORJ is a shareware dictionary with phonetic lookup by Jorj Software
	  Co.
Index:	hotkeys;JORJ
--------K-16AF20BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.0+) - GET EXTENDED BUFFER STATE
	AX = AF20h
	BX = 4B33h ('K3')
Return: AX = K3 version (same as returned in BX by AX=AF4Dh)
	ES:BX -> extended keyboard buffer start
	ES:DX -> extended keyboard buffer end
	ES:SI -> next keystroke
	ES:DI -> last keystroke in buffer
	CX = number of keystrokes in buffer
Program: K3PLUS is an extended keyboard driver by Matthias Paul and Axel C.
	  Frinke, originally based on the K3 extended German keyboard driver
	  by Martin Gerdes published in c't magazine in 1988
Note:	this function replaces the identical function AH=20h"K3"
SeeAlso: AH=20h"K3",AX=AF25h,AX=AF4Dh,AX=AF50h,INT 2F/AX=ED58h
--------K-16AF25BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.0+) - COPY INTO EXTENDED BUFFER
	AX = AF25h
	BX = 4B33h ('K3')
	CX = number of keystrokes to copy
	ES:SI -> buffer containing keystrokes
Return: CF clear if successful
	CF set on error (i.e. buffer full)
	    CX = number of keystrokes NOT transferred
	    ES:SI -> first keystroke not transferred
Note:	this function replaces the identical function AH=25h"K3"
SeeAlso: AH=25h"K3",AX=AF20h,AX=AF4Dh,AX=AF50h,INT 2F/AX=D44Fh/BX=0001h
--------K-16AF4DBX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.0+) - GET VERSION INFORMATION
	AX = AF4Dh
	BX = 4B33h ('K3')
Return: AL = 50h if installed
	    BX = K3 version
	    DX = API version
	    ES:CX -> K3 structure (version-dependent) (see #00608)
Program: K3PLUS is an extended keyboard driver by Matthias Paul and Axel C.
	  Frinke, originally based on the K3 extended German keyboard driver
	  by Martin Gerdes published in c't magazine in 1988
SeeAlso: AX=AF20h,AX=AF50h,AX=AF80h,AX=AF82h/BX=4B33h,INT 2F/AX=D44Fh/BX=0000h
SeeAlso: INT 2F/AX=ED58h
Index:	installation check;K3PLUS

Format of internal K3 structure:
Offset	Size	Description	(Table 00608)
 00h  3 BYTEs	signature "K3$"
 03h	BYTE	length of structure, including this byte and signature
 04h	WORD	compiler switch option flags A (see #00609)
 06h	WORD	compiler switch option flags B (see #00610)
 08h	BYTE	internal flags A (see #00611)
 09h	BYTE	internal flags B (see #00612)
 0Ah	WORD	DOS version recorded at startup
 0Ch	WORD	"ActTypeSpeed"
 0Eh	WORD	last Keyboard-ID sent
		41ABh translated, 83ABh native (pass-through)
 10h	WORD	offset of K3TAB Special
 12h	WORD	offset of K3TAB German
 14h	WORD	offset of K3TAB Alt
 16h	WORD	offset of K3TAB AltGr
 18h	WORD	offset of K3TAB Ctrl
 1Ah	WORD	offset of K3TAB NPad
 1Ch	WORD	offset of K3TAB CtrlNPad
 1Eh	WORD	offset of K3TAB AltNPad
 20h	WORD	offset of K3TAB ApoTbl or 0000h
 22h	WORD	offset of K3TAB UmlautTbl or 0000h
 24h	WORD	offset of K3TAB UmlautTblExp or 0000h
 26h	WORD	length of video mode table
 28h	WORD	offset of VidMdTbl or 0000h
 2Ah	BYTE	'$' end marker

Bitfields for K3PLUS compiler switch option flags A:
Bit(s)	Description	(Table 00609)
 15	GuINT16Fct2 (general use of INT 16 function 2)
 14	Int15df (INT 15 has to be predefined)
 13	GuAltNP (general use of Alt Numpad)
 12	SupAT (ATs+ supported)
 11	GuINT16Fct3 (general use of INT 16 function 3)
 10	GuINT16Ret (general use of INT16 bad function return)
 9-8	Layout (0-2, 3 reserved; 0=PC, 1=AT, 2=MF)
 7	ForceMF (force MF decode without read-ID)
 6	KXlate (translate keys for special keyboard)
 5	UmlautX (umlaut translation capability included)
 4	ApoX (translate apostrophe)
 3	DoINT16 (INT 16 handler included)
 2	UseCC (CopyCursor included)
 1-0	UseEB
	0=no extended keystroke buffer, 1=reserve mem, 2=use PSP, 3=reserved

Bitfields for K3 compiler switch option flags B:
Bit(s)	Description	(Table 00610)
 15-11	reserved (0)
 10	CtrlSeq (Ctrl macro capability included)
 9-8	SupINT16fct55FE
 6	DoInstallCheck (check for double installation)
 5	SupINT16fct5PcJr (INT 16/AH=05h"PCjr" supported)
 4	SendOut (sound and message output supported)
 3	SupInt16fct5500 (INT 16/AX=5500h supported)
 2	GuINT15Fct4F (calls to INT 15/AH=4Fh supported)
 1-0	UseBufferStart (0=use standard area, 1=set standard area,
	2=use internal indexes, 3=reserved)

Bitfields for K3 internal flags A:
Bit(s)	Description	(Table 00611)
 7	DoingUmlautExp
 6	CallINT15fct4F
 5	Beep1 (requires SendOut set in option flags B)
 4	ATflag (set for AT, 386, PS/2 Models 50-80)
 3	XTflag (set for PC, PC/XT, Micromint PC, Pencock PC, PS/2 Model 30)
 2	KeyClick
 1	UmlautExp
 0	UmlautTrans

Bitfields for K3 internal flags B:
Bit(s)	Description	(Table 00612)
 7-5	reserved
 4	TranslateE0 enabled
 3	Boot enabled
 2	PrintScreen enabled
 1	Break enabled
 0	ApoPendingBeep
--------K-16AF50BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.0+) - CHECK IF FUNCTION SUPPORTED
	AX = AF50h
	BX = 4B33h ('K3')
	CH = function
	    00h get function flags
		CL = 00h
		Return: CX = supported function flags (see #00613)
	    nonzero reserved for extensions
SeeAlso: AX=AF20h,AX=AF4Dh,AX=AF51h,AX=AF80h

Bitfields for K3PLUS supported function list:
Bit(s)	Description	(Table 00613)
 0	function 4Dh supported
 1	function 50h supported
 2-3	reserved (0)
 4	function 20h supported
 5	function 25h supported
 6	function 51h supported
 7	reserved (0)
 8	function 80h supported
 9	function 81h supported
 10	function 82h supported
 11-15	reserved (0)
--------K-16AF51BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.00+) - SET OPTIONS
	AX = AF51h
	BX = 4B33h ('K3')
	CX = switches
Return: AL = status
	    00h done
		CX = previous switch settings
	    01h switch not supported
	    FFh other error
SeeAlso: AX=AF4Dh,AX=AF50h,AX=AF80h
--------K-16AF80BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.00+) - GET ORIGINAL INT 09h VECTOR
	AX = AF80h
	BX = 4B33h ('K3')
Return: AL = status
	    00h not supported
	    81h if successful
		ES:CX -> original INT 09 handler
SeeAlso: AX=AF4Dh,AX=AF50h,AX=AF81h,AX=AF82h
--------K-16AF81BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.00+) - GET ORIGINAL INT 16h HANDLER
	AX = AF81h
	BX = 4B33h ('K3')
Return: AL = status
	    00h not supported
	    82h if successful
		ES:CX -> original INT 16 handler
SeeAlso: AX=AF4Dh,AX=AF50h,AX=AF80h,AX=AF82h
--------K-16AF82BX4B33-----------------------
INT 16 - K3PLUS v6.00+ (API v2.00+) - GET ORIGINAL INT 10h HANDLER
	AX = AF82h
	BX = 4B33h ('K3')
Return: AL = status
	    00h not supported
	    83h if successful
		ES:CX -> original INT 10 handler
Program: K3PLUS is an extended keyboard driver by Matthias Paul and Axel C.
	  Frinke, originally based on the K3 extended German keyboard driver
	  by Martin Gerdes published in c't magazine in 1988
SeeAlso: AX=AF4Dh,AX=AF50h,AX=AF80h,AX=AF81h,INT 2F/AX=ED58h
--------m-16B0B1-----------------------------
INT 16 - VGARAM v1.00 - INSTALLATION CHECK
	AX = B0B1h
	ES:DI -> 6 byte signature "VGARAM"
Return: AX = B1B0h if installed,
	DS:BX -> VGARAM Status byte: 0 = OFF, 1 = ON
Program: VGARAM is a utility by Brett Warthen which makes VGA memory which is
	  not used in text modes available for DOS
--------K-16CA--BX736B-----------------------
INT 16 - CtrlAlt Associates STACKEY.COM v3.00 - API
	AH = CAh
	BX = 736Bh ("sk")
	CX = 736Bh
	AL = function
	    00h installation check
		Return: DX = words available in keyboard buffer
	    01h place keystroke in buffer
		DX = keystroke (DH = scan code, DL = ASCII character)
		Return: DX = words available in keyboard buffer
			    FFFFh on error
	    02h flush STACKEY and BIOS keyboard buffers
Return: AX = CAFFh if installed
	    BX = segment of resident code
	    CX = STACKEY version (CH = major, CL = minor)
Program: STACKEY is a shareware keyboard-input faking TSR
Index:	installation check;STACKEY
--------V-16CA00BX6570-----------------------
INT 16 - CtrlAlt Associates EGAPAL.COM v1.00 - INSTALLATION CHECK
	AX = CA00h
	BX = 6570h ("ep")
	CX = 6570h
Return: AX = CAFFh if installed
	    BX = segment of resident code
	    CX = ??? (0090h)
Program: EGAPAL is a TSR supplied with STACKEY which makes EGA palette
	  settings permanent across mode switches
SeeAlso: AX=CA00h/BX=7670h
--------V-16CA00BX7670-----------------------
INT 16 - CtrlAlt Associates VGAPAL.COM v1.00 - INSTALLATION CHECK
	AX = CA00h
	BX = 7670h ("vp")
	CX = 7670h
Return: AX = CAFFh if installed
	    BX = segment of resident code
	    CX = ??? (0090h)
Program: VGAPAL is a TSR supplied with STACKEY which makes VGA palette
	  settings permanent across mode switches
SeeAlso: AX=CA00h/BX=6570h
--------U-16CB00-----------------------------
INT 16 - PUPClip v1.12+ - INSTALLATION CHECK
	AX = CB00h
Return: BX = 4342h if installed
	    AX = version (AH = major version, AL = BCD minor version)
Program: PUPClip is the freeware PopUP Clipboard for DOS and Windows DOS
	 sessions by SkullC0DEr
SeeAlso: AX=CB01h,AX=CB02h,AX=CB03h,AX=CB04h,AX=CB05h,AX=CB06h,AX=CB08h
SeeAlso: INT 2F/AX=1701h
--------U-16CB01-----------------------------
INT 16 - PUPClip v1.12+ - GET CLIPBOARD CURSOR POSITION
	AX = CB01h
Return: BL = column (0-79)
	BH = row (0-49)
SeeAlso: AX=CB00h,AX=CB02h,AX=CB03h
--------U-16CB02-----------------------------
INT 16 - PUPClip v1.12+ - SET CLIPBOARD CURSOR POSITION
	AX = CB02h
	BL = column (0-79)
	BH = row (0-49)
Return: CF clear if successful
	CF set on error (invalid position)
SeeAlso: AX=CB00h,AX=CB01h,AX=CB04h
--------U-16CB03-----------------------------
INT 16 - PUPClip v1.12+ - GET CHARACTER FROM CURRENT CLIPBOARD CURSOR POSITION
	AX = CB03h
Return: BL = ASCII character at current position
SeeAlso: AX=CB00h,AX=CB02h,AX=CB04h,INT 2F/AX=1705h
--------U-16CB04-----------------------------
INT 16 - PUPClip v1.12+ - WRITE CHARACTER TO CURRENT CLIPBOARD CURSOR POSITION
	AX = CB04h
	BL = ASCII character to store
SeeAlso: AX=CB00h,AX=CB02h,AX=CB03h,AX=CB05h,INT 2F/AX=1703h
--------U-16CB05-----------------------------
INT 16 - PUPClip v1.12+ - CLEAR CLIPBOARD CONTENTS
	AX = CB05h
Return: nothing
SeeAlso: AX=CB00h,AX=CB04h,AX=CB06h,AX=CB07h,INT 2F/AX=1702h
--------U-16CB06-----------------------------
INT 16 - PUPClip v1.12+ - SCROLL UP CLIPBOARD CONTENTS
	AX = CB06h
Return: nothing
SeeAlso: AX=CB00h,AX=CB05h,AX=CB07h
--------U-16CB07-----------------------------
INT 16 - PUPClip v1.12+ - SCROLL DOWN CLIPBOARD CONTENTS
	AX = CB07h
Return: nothing
SeeAlso: AX=CB00h,AX=CB05h,AX=CB06h
--------U-16CB08-----------------------------
INT 16 - PUPClip v1.12+ - POP UP
	AX = CB08h
Return: CF clear if successful
	CF set on error (unsupported video mode)
SeeAlso: AX=CB00h
--------U-16D724CX00CB-----------------------
INT 16 U - APCAL v3.20 - GET ???
	AX = D724h
	CX = 00CBh
Return: AX = 0000h
	BX = 0000h
	DX:CX -> ??? or 0000h:0000h
Program: APCAL is an optionally-resident shareware appointment calendar by
	  Gamma Software
SeeAlso: AX=3577h,AX=D724h/CX=00CCh,AX=D724h/CX=00CDh
--------U-16D724CX00CC-----------------------
INT 16 U - APCAL v3.20 - GET ???
	AX = D724h
	CX = 00CCh
Return: AX = 0000h
	BX = 0000h
	DX:CX -> ??? (apparently an internal data area)
SeeAlso: AX=D724h/CX=00CBh,AX=D724h/CX=00CDh
--------U-16D724CX00CD-----------------------
INT 16 U - APCAL v3.20 - GET ???
	AX = D724h
	CX = 00CDh
Return: AX = ??? (5345h seen)
SeeAlso: AX=D724h/CX=00CBh,AX=D724h/CX=00CCh
--------v-16DD--------------------------
INT 16 - VIRUS - "Frumble" - INSTALLATION CHECK
	AH = DDh
Return: AL = DDh if resident
SeeAlso: INT 13/AX=FD50h,INT 21/AX=010Fh,INT 21/AX=0B56h
--------s-16DFDF-----------------------------
INT 16 U - Corel PowerSCSI - FDAUDIO.COM - INSTALLATION CHECK
	AX = DFDFh
Return: ES:DI -> ASCII signature "FDAUDIO/CD" followed by ASCII date, i.e.
	  "06/18/93" if installed
--------b-16E000-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - GET VERSION NUMBER
	AX = E000h
Return: CF clear if successful
	    AL = FAh
	    BX = version number (BCD) (0200h = v2.00)
	CF set on error (not implemented)
Notes:	this interface is available on AMI BIOSes built from AMI core version
	  8/8/93 (HiFlex BIOS) or 11/15/93 (WinBIOS) or later
	the "Meningitis" virus uses this API when attacking a system equipped
	  with an AMI BIOS; it is supposedly able to write itself into the
	  Flash ROM and thus make itself part of the BIOS
SeeAlso: AX=E001h,AX=E004h,AX=E006h,AX=E008h,AX=E00Ah,AX=E00Bh,AX=E0FFh
--------b-16E001-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - GET CHIPSET SAVE/RESTORE SIZE
	AX = E001h
Return: CF clear if successful
	    AL = FAh
	    BX = number of bytes required to save chipset configuration
	CF set on error
SeeAlso: AX=E000h,AX=E002h,AX=E003h
--------b-16E002-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - SAVE CHIPSET STATUS & PREPARE CHPSET
	AX = E002h
	ES:DI -> buffer for storing chipset status
Return: CF clear if successful
	    AL = FAh
	CF set on error
SeeAlso: AX=E000h,AX=E001h,AX=E003h
--------b-16E003-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface -  RESTORE CHIPSET STATUS
	AX = E003h
	ES:DI -> buffer in which chipset status was previously stored
Return: CF clear if successful
	    AL = FAh
	CF set on error
SeeAlso: AX=E000h,AX=E001h,AX=E002h
--------b-16E004-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - LOWER PROGRAMMING VOLTAGE Vpp
	AX = E004h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	this function does not return until the voltage level stabilizes
SeeAlso: AX=E000h,AX=E005h,AX=E006h
--------b-16E005-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - RAISE PROGRAMMING VOLTAGE Vpp
	AX = E005h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	this function does not return until the voltage level stabilizes
SeeAlso: AX=E000h,AX=E004h,AX=E007h
--------b-16E006-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - FLASH WRITE PROTECT
	AX = E006h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	this function performs any delay required to allow the Flash ROM to
	  stabilize in the write-protected state
SeeAlso: AX=E000h,AX=E004h,AX=E007h
--------b-16E007-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - FLASH WRITE ENABLE
	AX = E007h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	this function performs any delay required to allow the Flash ROM to
	  stabilize in the write-enabled state
SeeAlso: AX=E000h,AX=E005h,AX=E006h,AX=E008h
--------b-16E008-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - FLASH SELECT
	AX = E008h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Desc:	select the Flash ROM if the system contains both EPROM and Flash ROM
Note:	this function performs any delay required to allow the Flash ROM to
	  stabilize in the selected state; if no EPROM is present, this
	  function always returns successfully
SeeAlso: AX=E000h,AX=E007h,AX=E009h
--------b-16E009-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - FLASH DE-SELECT
	AX = E009h
Return: CF clear if successful
	    AL = FAh
	CF set on error
Desc:	select the EPROM if the system contains both EPROM and Flash ROM
Note:	this function performs any delay required to allow the Flash ROM to
	  stabilize in the de-selected state; if no EPROM is present, this
	  function always returns successfully
SeeAlso: AX=E000h,AX=E006h,AX=E008h
--------b-16E00A-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - VERIFY ALLOCATED MEMORY
	AX = E00Ah
	BX = number of paragraphs
	ES = starting segment of memory
Return: CF clear if successful
	    AL = FAh
	CF set on error
Desc:	determine whether the specified memory may be used for flash
	  programming
Note:	always returns error if BX is zero on entry
SeeAlso: AX=E000h,AX=E00Bh
--------b-16E00B-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - SAVE INTERNAL CACHE STATUS
	AX = E00Bh
	ES:DI -> buffer for internal cache status (minimum 4Kbytes)
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	always returns error if the hardware does not contain internal
	  cache or this call is made in protected mode
SeeAlso: AX=E000h,AX=E00Ah,AX=E00Ch
--------b-16E00C-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - RESTORE INTERNAL CACHE STATUS
	AX = E00Ch
	ES:DI -> buffer containing internal cache status (minimum 4Kbytes)
Return: CF clear if successful
	    AL = FAh
	CF set on error
Note:	always returns error if the hardware does not contain internal
	  cache or this call is made in protected mode
SeeAlso: AX=E000h,AX=E00Bh
--------t-16E0E0-----------------------------
INT 16 - TurboPower TSRs - ALTERNATE INSTALLATION CHECK
	AX = E0E0h
Return: AX = 1F1Fh if installed
	    DWORD 0040h:00F0h -> last data block in TSR list (see #00615)
Note:	the returned TSR list provides support for communication among TSRs
	  built with TurboPower's Turbo Professional and Object Professional
	  libraries for Turbo Pascal
SeeAlso: AX=F0F0h
--------b-16E0FF-----------------------------
INT 16 - AMI BIOS - BIOS-FLASH Interface - GENERATE CPU RESET
	AX = E0FFh
Return: never
SeeAlso: AX=E000h,INT 14/AH=17h"FOSSIL"
--------U-16ED--BHED-------------------------
INT 16 - BORLAND TURBO LIGHTNING - API
	AH = EDh
	BH = EDh
	BL = function
	    00h installation check
		Return: AX = 5205h
			CH = major version
			CL = minor version
	    01h identical to function 00h???
	    02h get resident data segment
		Return: AX = data segment of resident portion
	    03h get resident ???
		Return: AX = offset of some buffer in resident code seg
	    04h redefine auxiliary dictionary
		DS:SI -> counted filename string
		Return: AL = result code
	    05h select active environment
		AL = environment (00h to 0Ch)
		Return: AX = status
			    0000h if OK
			    0001h if out of range
	    06h toggle AutoProof???
		AL = state (00h off, 01h on)
	    07h ???
	    08h ???
		AL = char???
		CX = ???
		DX = ???
		Return: AX = 0, 1 or 2
	    09h ???
	    0Ah ???
		CX = ???
		DX = ???
		Return: AX = ???
	    0Bh check dictionary integrity???
		DS:SI -> counted dictionary filename string
		Return: AX = 0, 40h, 80h
	    0Ch spellcheck string (disk dictionary, possibly RAM dict as well)
		DS:SI -> counted string to check
		Return: AH = 0
			AL = result code
			   00h string found in dictionary
			   20h string begins more than one word
			   40h string not found
	    0Dh set ???
		(sets an internal flag)
	    0Eh spellcheck string (RAM dictionary only)
		DS:SI -> counted string to check
		Return: AH = 00h
			AL = result code
			    00h string found in dictionary
			    01h string not found
			    02h ???
	    0Fh ???
	    10h ???
Notes:	AX in general returns an error code from most functions.
Index:	installation check;Turbo Lightning
--------U-16EF-------------------------------
INT 16 - CALCULATOR - INSTALLATION CHECK
	AH = EFh
Return: AX = 0088h if installed
Program: CALCULATOR is a shareware popup calculator by Andrzej Brzezinski and
	  Marek Kosznik
--------b-16F0-------------------------------
INT 16 - Compaq 386 and newer - SET CPU SPEED
	AH = F0h
	AL = speed code (see #00614)
	if AL=09h,
	    CX = speed value, 1 (slowest) to 50 (full), 3 ~= 8088
Note:	also supported by some versions of AMI BIOS dated June 1992 or later;
	  speed codes 0 or 1 are used for Low Speed, 2 for High Speed
SeeAlso: AH=F1h,AH=F3h

(Table 00614)
Values for speed code:
 00h	equivalent to 6 MHz 80286 (COMMON)
 01h	equivalent to 8 MHz 80286 (FAST)
 02h	full 16 MHz (HIGH)
 03h	toggles between 8 MHz-equivalent and speed set by system board switch
	  (AUTO or HIGH)
 08h	full 16 MHz except 8 MHz-equivalent during floppy disk access
 09h	specify speed directly
--------t-16F0F0-----------------------------
INT 16 - TurboPower TSRs - INSTALLATION CHECK
	AX = F0F0h
Return: AX = 0F0Fh if installed
	    ES:DI -> last data block in TSR list (see #00615)
Note:	the returned TSR list provides support for communication among TSRs
	  built with TurboPower's Turbo Professional and Object Professional
	  libraries for Turbo Pascal
SeeAlso: AX=E0E0h

Format of TurboPower TSR data block:
Offset	Size	Description	(Table 00615)
 00h	DWORD	pointer to program tag (counted ASCII string)
 04h	WORD	interface version number (0400h)
 06h	DWORD	pointer to command entry point
 0Ah	DWORD	pointer to previous data block (0000h:0000h if none)
 0Eh	DWORD	pointer to next data block (0000h:0000h if none)
---swappable TSRs only---
 12h	DWORD	pointer to swapping data
 16h	DWORD	pointer to user data
	more???
--------b-16F1-------------------------------
INT 16 - Compaq 386 and newer - READ CURRENT CPU SPEED
	AH = F1h
Return: AL = speed code (see #00614)
	if AL = 09h, CX = speed code
Note:	also supported by some versions of AMI BIOS dated June 1992 or later
SeeAlso: AH=F0h,AH=F3h
--------b-16F2-------------------------------
INT 16 - Compaq 386 and newer - DETERMINE ATTACHED KEYBOARD TYPE
	AH = F2h
Return: AL = type
	    00h if 11-bit AT keyboard is in use
	    01h if 9-bit PC keyboard is in use
	AH = 00h (04/08/93 system ROM)
SeeAlso: MEM 0040h:00C2h
--------b-16F3-------------------------------
INT 16 - Compaq 80286s - SET CPU SPEED LIMIT (OVERRIDE JUMPER)
	AH = F3h
	AL = new limit
	    00h limit is 6 Mhz
	    01h limit is 8 Mhz/6 Mhz
SeeAlso: AH=F0h,AH=F1h
--------U-16F398-----------------------------
INT 16 U - NORTON GUIDES - INSTALLATION CHECK
	AX = F398h
Return: AX = 6A73h ("js")
	BH = BIOS scan code of current hot key
	BL = ASCII code of current hot key
Note:	NG.EXE was written by John Socha
--------b-16F400-----------------------------
INT 16 - Compaq Systempro and higher - CACHE CONTROLLER STATUS
	AX = F400h
Return: AH = E2h (*)
	AL = status
	    00h not present
	    01h enabled
	    02h disabled
	CX = cache memory size
	    bit 15:	cache size information is NOT valid
	    bits 14-0:	cache memory size in kilobytes
	DH = cache write technology
	    bit 7:	cache write information is NOT valid
	    bits 6-1:	reserved (0)
	    bit 0:	0 = Write-through caching
			1 = Write-back caching
	DL = cache type
	    bit 7:	cache type information is NOT valid
	    bits 6-1:	reserved (0)
	    bit 0:	0 = Direct mapped
			1 = Two-way set-associative
Notes:	also supported by some versions of AMI BIOS dated June 1992 or later
	many (most) BIOSes return a modified AH when called for an unsupported
	  or non-keyboard function (typically, the highest supported keyboard
	  function [normally 12h] is subtracted from the original AH)
SeeAlso: AX=F401h,AX=F402h
--------b-16F401-----------------------------
INT 16 - Compaq Systempro and higher - ENABLE CACHE CONTROLLER
	AX = F401h
Return: AX = E201h
Notes:	also supported by some versions of AMI BIOS dated June 1992 or later
	many (most) BIOSes return a modified AH when called for an unsupported
	  or non-keyboard function (typically, the highest supported keyboard
	  function [normally 12h] is subtracted from the original AH)
SeeAlso: AX=F400h,AX=F402h
--------b-16F402-----------------------------
INT 16 - Compaq Systempro and higher - DISABLE CACHE CONTROLLER
	AX = F402h
Return: AX = E202h
Notes:	also supported by some versions of AMI BIOS dated June 1992 or later
	many (most) BIOSes return a modified AH when called for an unsupported
	  or non-keyboard function (typically, the highest supported keyboard
	  function [normally 12h] is subtracted from the original AH)
SeeAlso: AX=F400h,AX=F401h
--------v-16FA00DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - INSTALLATION CHECK
	AX = FA00h
	DX = 5945h
Return: CF clear
	DI = 4559h
	BX = BIOS hotkey scancode (default 2F00h) (VSAFE only)
		FFFFh if disabled
Note:	MS-DOS 6.0 bundles VSAFE and VWATCH as part of its virus protection
SeeAlso: AX=FA05h,INT 13/AH=FAh,INT 21/AH=FAh"VDEFEND",INT 2F/AX=6282h
--------v-16FA01DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - UNINSTALL
	AX = FA01h
	DX = 5945h
Return: CF clear if successful
	DI = 4559h
SeeAlso: AX=FA00h
--------v-16FA02DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - GET/SET OPTIONS
	AX = FA02h
	DX = 5945h
	BL = new parameter flags (see #00616)
Return: CF clear
	DI = 4559h
	CL = old value of parameter flags

Bitfields for VSAFE/VWATCH parameter flags:
Bit(s)	Description	(Table 00616)
 7	Protect executable files
 6	Protect FD boot sector
 5	Protect HD boot sector
 4	Boot sector viruses
 3	Check executable files
 2	General write protect
 1	Resident
 0	HD Low level format
--------v-16FA03DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - GET ???
	AX = FA03h
	DX = 5945h
Return: CF clear
	DI = 4559h
	AX = 0002h
--------v-16FA04DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE - GET HOTKEY DISABLE FLAG
	AX = FA04h
	DX = 5945h
Return: CF clear
	DI = 4559h
	BL = hotkey disable flag (nonzero if hotkey disabled)
Note:	this function is a NOP under VWATCH, merely returning CF clear/DI=4559h
SeeAlso: AX=FA00h,AX=FA05h
--------v-16FA05DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE - SET HOTKEY DISABLE FLAG
	AX = FA05h
	DX = 5945h
	BL = new value of hotkey disable flag (nonzero to disable hotkey)
Return: CF clear
	DI = 4559h
Note:	this function is a NOP under VWATCH, merely returning CF clear/DI=4559h
SeeAlso: AX=FA00h,AX=FA04h
--------v-16FA06DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - GET NETWORK DRIVES TEST FLAG
	AX = FA06h
	DX = 5945h
Return: CF clear
	DI = 4559h
	BL = test status
	    00h don't monitor network drives (default for VWATCH v2.1)
	    FFh monitor network drives (default for VSAFE v2.0)
	CL = ??? (only VSAFE 2.0)
SeeAlso: AX=FA07h
--------v-16FA07DX5945-----------------------
INT 16 U - PC Tools v8+ VSAFE, VWATCH - SET NETWORK DRIVES TEST FLAG
	AX = FA07h
	DX = 5945h
	BL = new state
	    00h don't monitor
	    01h monitor network drives
Return: CF clear
	DI = 4559h
Note:	VWATCH v2.1 (from PC Tools 9.0) returns CF set instead
SeeAlso: AX=FA00h,AX=FA06h
--------v-16FA08DX5945-----------------------
INT 16 U - PC Tools v9+ VWATCH v2.1 - ???
	AX = FA08h
	DX = 5945h
Return: CF clear
	DI = 4559h
	AX = ??? (0002h)
	BX = version (BH=major, BL=two-digit minor)
Note:	this function is not supported by the PC Tools 9.0 VSAFE v2.0
SeeAlso: AX=FA00h,AX=FA06h
--------U-16FE55-----------------------------
INT 16 U - PC Tools v8+ programs - GET ???
	AX = FE55h
	CX = segment of resident program or 0000h for last loaded
	DX = 0000h
Return: DX = resident code segment (unchanged if CX=0000h on entry)
	AX = ??? or 0000h
Note:	this call is supported by CPSCHED, CPTASK, DATAMON, DPROTECT, DRIVEMAP,
	  and DSKLIGHT beginning in PC Tools v8.0; programs other than CPTASK
	  seem to hook it merely to return the same AX as the CPTASK loaded
	  prior to them returned
--------U-16FEA4-----------------------------
INT 16 U - PC Tools v7+ CPSCHED/DESKTOP - RESET ???
	AX = FEA4h
Return: nothing
Note:	this function is identical to AX=FFA4h, and is implemented by the same
	  code in DESKTOP
SeeAlso: AX=FFA4h
--------U-16FEC6-----------------------------
INT 16 U - PC Tools v7+ CPSCHED - ENABLE/DISABLE CPSCHED API
	AX = FEC6h
	BL = new state (00h enabled, nonzero disabled)
Return: nothing
Desc:	specify whether CPSCHED API calls other than this one and AX=FE55h will
	  be honored
--------U-16FED3-----------------------------
INT 16 U - PC Tools v7+ CPSCHED/DESKTOP - ???
	AX = FED3h
	DS:SI -> 92-byte data record for ???
Return: ???
Note:	this function is identical to AX=FFD3h, and is implemented by the same
	  code in DESKTOP
SeeAlso: AX=FFD3h
--------U-16FEDC-----------------------------
INT 16 U - PC Tools v7+ CPSCHED - UNHOOK INTERRUPTS
	AX = FEDCh
Return: AX,DX destroyed
Index:	uninstall;CPSCHED
--------U-16FEEFCX0000-----------------------
INT 16 U - PC Tools v7+ CPSCHED/DESKTOP - INSTALLATION CHECK
	AX = FEEFh
	CX = 0000h
Return: CX = ABCDh if PC Tools scheduler (CPSCHED or DESKTOP) installed
	    BX = segment of resident portion
	    DX = (CPSCHED v8.0) resident CS
Note:	this function is identical to AX=FFD3h, and is implemented by the same
	  code in DESKTOP
SeeAlso: AX=FFEFh
--------U-16FEF1-----------------------------
INT 16 U - PC Tools v7 only CPSCHED/DESKTOP - ALTERNATE INSTALLATION CHECK
	AX = FEF1h
	BX = ???
Return: CX = 5555h if PC Tools scheduler (CPSCHED or DESKTOP) installed
	DX = 5555h
Note:	this function is identical to AX=FFD3h, and is implemented by the same
	  code in DESKTOP
SeeAlso: AX=FFF1h
--------K-16FF-------------------------------
INT 16 - KEYBOARD - KBUF extensions - ADD KEY TO TAIL OF KEYBOARD BUFFER
	AH = FFh
	DX = scan code
Return: AL = status
	    00h success
	    01h failure
Program: KBUF is a keyboard buffer expander by Mark Adler
SeeAlso: AH=05h
--------V-16FF-------------------------------
INT 16 - OPTIMA 1024 VGA-Sync,ET-3000 chipset - QUERY ZOOM INTERRUPT
	AH = FFh
Return: AL = interrupt number to which BIOS keyboard handler has been relocated
	AL+1 = Zoom interrupt number
	BX = hotkey
Notes:	the default interrupts are 60h for keyboard and 61h for Zoom interrupt;
	  the default hot key is F10
	not all vendors include the Tseng TSR which supports these functions
SeeAlso: INT 61/AX=0000h"OPTIMA",INT 61/AX=0005h"OPTIMA"
Index:	hotkeys;OPTIMA 1024 VGA
----------16FF--BH00-------------------------
INT 16 - FREEZE.COM - INSTALLATION CHECK
	AH = FFh
	BH = 00h
Return: BH = FFh if installed
Program: FREEZE is a PC Magazine utility
--------d-16FF70BX0000-----------------------
INT 16 U - PC Tools v8+ DRIVEMAP - INSTALLATION CHECK
	AX = FF70h
	BX = 0000h
	CX = 4C69h ('Li')
	DX = 6E6Bh ('nk')
Return: AX = 0000h
	CX = 4350h ('CP')
	DH = major version
	DL = minor version
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
SeeAlso: AX=FF70h/BX=0001h,AX=FF70h/BX=0002h
--------d-16FF70BX0001-----------------------
INT 16 U - PC Tools v8+ DRIVEMAP - ???
	AX = FF70h
	BX = 0001h
	DL = ???
Return: AX = ???
	DH = ???
SeeAlso: AX=FF70h/BX=0000h,AX=FF70h/BX=0002h
--------d-16FF70BX0002-----------------------
INT 16 U - PC Tools v8+ DRIVEMAP - ???
	AX = FF70h
	BX = 0002h
	CX = ???
	DX = ???
Return: AX = ??? or FFFEh/FFFFh on error
	DL = ???
BUG:	DRIVEMAP will branch to random locations for BX values other than
	  those listed above for v8.0-9.0 because a) the incorrect register is
	  range-tested, resulting in BX=0003h-5CD6h being accepted as valid
	  function numbers, and b) the conditional which branches on invalid
	  function numbers jumps to the following instruction, becoming a NOP
SeeAlso: INT 2F/AX=9203h"DRIVEMAP"
Index:	installation check;DRIVEMAP
--------T-16FF80BX0000-----------------------
INT 16 U - PC Tools v8+ CPTASK - INSTALLATION CHECK
	AX = FF80h
	BX = 0000h
	CX = 0000h
	DX = 0000h
Return: CX = 5555h if installed
Program: CPTASK is a task switcher by Central Point Software
--------T-16FF80BX0001-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET ???
	AX = FF80h
	BX = 0001h
	???
Return: DX:SI -> task list??? (ten entries of 70h bytes in v9.0)
	BX = ??? (PSP segment of resident code???)
--------T-16FF80BX0002-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET ???
	AX = FF80h
	BX = 0002h
Return: DX:SI -> ???
--------T-16FF80BX0003-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET ??? FLAGS
	AX = FF80h
	BX = 0003h
Return: AX = flags (see #00617)
SeeAlso: AX=FF80h/BX=0004h,AX=FF80h/BX=0006h

Bitfields for CPTASK flags:
Bit(s)	Description	(Table 00617)
 10	???
 13	???
 14	???
 15	???
--------T-16FF80BX0004-----------------------
INT 16 U - PC Tools v8+ CPTASK - SET ???
	AX = FF80h
	BX = 0004h
	CX = new value of ???
Return: ???
Note:	this function also sets bit 14 of the flags word returned by
	  AX=FF80h/BX=0003h
--------T-16FF80BX0005-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET NUMBER OF ACTIVE TASKS???
	AX = FF80h
	BX = 0005h
Return: AX = number of active tasks???
--------T-16FF80BX0006-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET AND CLEAR ??? FLAG
	AX = FF80h
	BX = 0006h
Return: AX = old state (0000h clear, 0001h set)
Note:	the tested flag is bit 13 of the flags returned by AX=FF80h/BX=0003h
--------T-16FF80BX0007-----------------------
INT 16 U - PC Tools v8+ CPTASK - ???
	AX = FF80h
	BX = 0007h
	ES:DI -> ???
	???
Return: ???
--------T-16FF80BX0008-----------------------
INT 16 U - PC Tools v8+ CPTASK - ???
	AX = FF80h
	BX = 0008h
	???
Return: ???
--------T-16FF80BX0009-----------------------
INT 16 U - PC Tools v8+ CPTASK - GET ???
	AX = FF80h
	BX = 0009h
Return: CL = ???
	CH = ??? (01h or 02h)
--------T-16FF80BX000A-----------------------
INT 16 U - PC Tools v9+ CPTASK - SET ???
	AX = FF80h
	BX = 000Ah
	DS:SI -> 128-byte buffer containing ???
--------T-16FF80BX000B-----------------------
INT 16 U - PC Tools v9+ CPTASK - SET ???
	AX = FF80h
	BX = 000Bh
	DX = index of ??? task (1-10)
--------T-16FF80BX000C-----------------------
INT 16 U - PC Tools v9+ CPTASK - SET IDLE??? DELAY
	AX = FF80h
	BX = 000Ch
	CX = new delay time in minutes
--------T-16FF80BX4350-----------------------
INT 16 U - PC Tools v8+ CPTASK - UNINSTALL
	AX = FF80h
	BX = 4350h ('CP')
	CX = 5354h ('ST')
Return: never returns; terminates all tasks and exits to program originally
	  calling CPTASK
--------U-16FF90-----------------------------
INT 16 U - PC Tools v8+ DESKTOP - ???
	AX = FF90h
	???
Return: ???
Note:	available only when popped up
--------U-16FF91-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF91h
	???
Return: AX = 0000h
Note:	calls AX=FFFDh after ???
SeeAlso: AX=FF92h,AX=FFFDh
--------U-16FF92-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF92h
	???
Return: AX = 0000h
Note:	like AX=FF91h, but temporarily sets ??? to 3
SeeAlso: AX=FF91h,AX=FFFDh
--------U-16FF93-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - SET ??? FLAG
	AX = FF93h
--------U-16FF94-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - SET ???
	AX = FF94h
	CX = ??? (default 0017h)
--------U-16FF95-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - SET ???
	AX = FF95h
	BX = ???
--------U-16FF96-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF96h
	CL = ???
Return: AX = ???
--------U-16FF97-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF97h
	DS:DX -> buffer for ??? (see #00618)
Return: ???

Format of PC Tools DESKTOP buffer:
Offset	Size	Description	(Table 00618)
 00h 48 BYTEs	???
 30h 128 BYTEs	???
--------U-16FF98-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - OPEN \DESK.OVL FILE AND SEEK TO OVERLAY
	AX = FF98h
	DX = byte offset in file of overlay header (see #00619)
Return: BX = file handle for DESK.OVL file
Desc:	open the DESK.OVL file, seek to the specified offset, read in the
	  overlay header, and seek to the offset specified by the header

Format of PC Tools DESKTOP overlay header:
Offset	Size	Description	(Table 00619)
 00h 12 BYTEs	NUL-padded ASCII overlay filename
 0Ch	DWORD	offset within DESK.OVL file of actual overlay
--------U-16FF99-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF99h
	???
Return: ???
--------U-16FF9A-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - GET NAME OF COLOR SCHEME
	AX = FF9Ah
Return: ES:BX -> name of current color scheme
Note:	available even if not popped up
--------U-16FF9B-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - UNUSED
	AX = FF9Bh
Return: ???
Note:	sounds triple-length beep
--------T-16FF9C-----------------------------
INT 16 U - PC Tools v8+ CPTASK - SET/CLEAR ??? POINTER
	AX = FF9Ch
	BL = function
	    00h set ??? pointer
		DS:SI -> ???
	    01h clear pointer to 0000h:0000h
----------16FF9D-----------------------------
INT 16 U - PC Tools v8+ CPTASK, VSAFE - ???
	AX = FF9Dh
	ES:BX -> ??? word
Return: ???
Note:	if ES is non-zero, the word pointed at by ES:BX determines whether the
	  ??? flag is cleared (word = 0000h) or set (word is nonzero).	The
	  flag is always cleared if ES=0000h.
--------U-16FF9E-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FF9Eh
	DL = ???
	    bit 7: ???
	    bits 6-0: function number??? (00h,01h,other)
	???
Return: ???
--------U-16FFA1-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FFA1h
	???
Return: ???
Note:	same as AX=FFA2h, except ??? set to FFh
SeeAlso: AX=FFA2h
--------U-16FFA2-----------------------------
INT 16 U - PC Tools v7+ DESKTOP - ???
	AX = FFA2h
	???
Return: ???
Note:	calls AX=FFC7h (remove window) and AX=FFFDh
SeeAlso: AX=FFA1h,AX=FFC7h,AX=FFFDh
--------y-16FFA3BX0000-----------------------
INT 16 U - PC Tools v7-8 DATAMON, v9+ DPROTECT - INSTALLATION CHECK
	AX = FFA3h
	BX = 0000h
	CX = 0000h
Return: AX = segment of resident code
	BX = 5555h
	CX = 5555h
Note:	also supported by DOS 6 UNDELETE which is licensed from PC Tools
SeeAlso: INT 21/AH=3Fh"NB.SYS",INT 21/AX=4101h,INT 2F/AX=6284h
--------y-16FFA3BX0001-----------------------
INT 16 U - PC Tools v7-8 DATAMON, v9+ DPROTECT - GET ???
	AX = FFA3h
	BX = 0001h
	CX = 0001h
Return: AX:BX -> ???
	CX = BX
--------y-16FFA3BX0002-----------------------
INT 16 U - PC Tools v7-8 DATAMON, v9+ DPROTECT - GET ???
	AX = FFA3h
	BX = 0002h
	CX = 0002h
Return: AX = ??? (0 or 1)
	CX = BX = AX
--------y-16FFA3BX0003-----------------------
INT 16 U - PC Tools v7-8 DATAMON, v9+ DPROTECT - GET ???
	AX = FFA3h
	BX = 0003h
	CX = 0003h
Return: AX = ??? (0 or 1)
	CX = BX = AX
--------y-16FFA3BX0004-----------------------
INT 16 U - PC Tools v7+ DATAMON - SET ??? FLAG
	AX = FFA3h
	BX = 0004h
	CX = 0004h
SeeAlso: AX=FFA3h/BX=0005h
--------y-16FFA3BX0005-----------------------
INT 16 U - PC Tools v7+ DATAMON - CLEAR ??? FLAG
	AX = FFA3h
	BX = 0005h
	CX = 0005h
SeeAlso: AX=FFA3h/BX=0004h
--------y-16FFA3BX0006-----------------------
INT 16 U - PC Tools v7+ DATAMON - SET PSP SEGMENT ???
	AX = FFA3h
	BX = 0006h
	CX = 0006h
	DX = current PSP segment as known to DOS??? or 0000h
--------d-16FFA3BXFFA3-----------------------
INT 16 U - PC Tools v9 DSKLIGHT - INSTALLATION CHECK
	AX = FFA3h
	BX = FFA3h
	CX = FFA3h
Return: BX = CX = 5555h if installed
	    AX = resident code segment
Program: DSKLIGHT is a TSR included with PC Tools v9+ which displays a disk-
	  access indicator on the screen; in v7 and v8, this function was
	  provided by DATAMON
Note:	DSKLIGHT chains to the previous handler if BX or CX is not FFA3h
--------U-16FFA4-----------------------------
INT 16 U - PC Tools v7-8 DESKTOP - ???
	AX = FFA4h
Return: ???
Notes:	available even when not popped up
	sets unknown flag if ??? conditions met
SeeAlso: AX=FEA4h
--------c-16FFA5CX1111-----------------------
INT 16 - PC-Cache v6+ - INSTALLATION CHECK
	AX = FFA5h
	CX = 1111h
Return: CH = 00h if installed
	    ES:DI -> internal data (see #00620)
	    CL = cache state
		01h enabled
		02h disabled
SeeAlso: INT 13/AH=27h,INT 13/AH=A0h,INT 21/AH=2Bh/CX=4358h

Format of PC-Cache internal data:
Offset	Size	Description	(Table 00620)
-1Ch 20 BYTEs	cached drive list, one byte per drive A: to T:
		each byte is either blank (20h) or drive letter (41h-54h)
 -8	BYTE	???
 -7	WORD	number of physical transfers (scaled down to 0000h-7FFFh)
 -5	WORD	number of saved transfers (scaled down to 0000h-7FFFh)
 -3   3 BYTEs	???
--------c-16FFA5CXAAAA-----------------------
INT 16 - PC-Cache v6+ - ENABLE DELAYED WRITES
	AX = FFA5h
	CX = AAAAh
Return: AX = ??? (apparently either 0000h or sectors_in_cache - 5)
SeeAlso: AX=FFA5h/CX=CCCCh
--------c-16FFA5CXCCCC-----------------------
INT 16 - PC-Cache v6+ - FLUSH CACHE AND DISABLE DELAYED WRITES
	AX = FFA5h
	CX = CCCCh
Return: AX = ??? (apparently either 0000h or sectors_in_cache - 5)
Note:	delayed writes are automatically disabled on EXECing
	  (see INT 21/AH=4Bh) a program named either WIN.CO? or DV.E??;
	  however, delayed writes are not automatically reenabled upon the
	  program's termination in v6.
SeeAlso: AX=FFA5h/CX=AAAAh,AX=FFA5h/CX=FFFFh
--------c-16FFA5CXDDDD-----------------------
INT 16 - PC-Cache v6+ - FLUSH AND DISABLE CACHE
	AX = FFA5h
	CX = DDDDh
SeeAlso: AX=FFA5h/CX=EEEEh,AX=FFA5h/CX=FFFFh
--------c-16FFA5CXEEEE-----------------------
INT 16 - PC-Cache v6+ - ENABLE CACHE
	AX = FFA5h
	CX = EEEEh
SeeAlso: AX=FFA5h/CX=DDDDh
--------c-16FFA5CXFFFF-----------------------
INT 16 - PC-Cache v6+ - FLUSH CACHE
	AX = FFA5h
	CX = FFFFh
SeeAlso: AX=FFA5h/CX=CCCCh,AX=FFA5h/CX=DDDDh,INT 13/AH=A1h
--------U-16FFA6-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET ???
	AX = FFA6h
Return: DS:SI -> ???
Note:	available only when popped up
--------U-16FFA7-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET ??? PATH
	AX = FFA7h
Return: DS:SI -> ASCIZ path (directory from which PCTools was run???)
--------U-16FFA8-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - ???
	AX = FFA8h
	DS:SI -> three consecutive ASCIZ strings for ??? (max 256 bytes total)
	???
Return: ???
Notes:	available only when popped up
	strings copied into internal buffer, among other actions
--------U-16FFA9-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET VERSION STRING
	AX = FFA9h
Return: DS:SI -> version string
--------U-16FFAA-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - ???
	AX = FFAAh
	???
Return: ???
Note:	available only when popped up
--------U-16FFAB-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET EDITOR SETTINGS???
	AX = FFABh
Return: DS:SI -> editor setting strings???
--------U-16FFAC-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - SET ???
	AX = FFACh
	DL = ???
Note:	available only when popped up
--------U-16FFAD-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - SET ???
	AX = FFADh
	DL = ???
--------U-16FFAE-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - GET ???
	AX = FFAEh
Return: AL = ???
--------U-16FFAF-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - SET ???
	AX = FFAFh
	DL = ???
--------U-16FFB0-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - SET ???
	AX = FFB0h
	BL = ???
--------U-16FFB1-----------------------------
INT 16 U - PC Tools v6.0-8.0 DESKTOP - ???
	AX = FFB1h
	???
Return: ???
--------U-16FFB2-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - GET ???
	AX = FFB2h
Return: DS:SI -> ???
--------U-16FFB3-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - ???
	AX = FFB3h
	???
Return: ???
Note:	available only when popped up
--------U-16FFB4-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - SET ??? FLAG
	AX = FFB4h
Note:	available only when popped up
SeeAlso: AX=FFBBh
--------U-16FFB5-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - GET/SET WINDOW PARAMETERS
	AX = FFB5h
	BX = window specifier (000Fh to 0019h) (see #00621)
	DX = 0000h get, nonzero = set
	ES:DI -> window parameter buffer (see #00622)
SeeAlso: AX=FFCBh

(Table 00621)
Values for PC Tools DESKTOP window specifier:
 000Fh	comm/FAX
 0014h	hotkey selection
 0015h	ASCII table
 0016h	system colors menu

Format of PC Tools DESKTOP window parameters:
Offset	Size	Description	(Table 00622)
 00h	BYTE	rows in window, not counting frame
 01h	BYTE	columns in window, not counting frame
 02h	BYTE	row number of top of window
 03h	BYTE	2*column number of left of window
 04h	BYTE	character attribute for ???
 05h	BYTE	character attribute for background/border
 06h	BYTE	character attribute for ???
 07h	DWORD	pointer to ??? on screen
 0Bh  4 BYTEs	???
 0Fh	BYTE	nonzero if window may be resized
Note:	if running in monochrome mode, character attributes at offsets 04h to
	  06h are stored unchanged, but attributes other than 07h, 0Fh, or 70h
	  are changed to 07h on reading
--------U-16FFB6-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - GET ???
	AX = FFB6h
Return: AH = ???
	AL = ???
--------U-16FFB7-----------------------------
INT 16 U - PC Tools v5.5-8.0 DESKTOP - GET/SET ???
	AX = FFB7h
	BX = direction
	    0000h copy to buffer
	    else  copy from buffer
	DS:SI -> 70-byte buffer with ???
Return: data copied
Note:	available only when popped up under v6.0+
--------U-16FFB8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET/SET???
	AX = FFB8h
	BH = subfunction
	    00h get
		Return: BL = old value of ???
			CL = old value of ??? (v6.0+)
			CH = old value of ??? (v6.0+)
	    nonzero set
		BL = new value for ???
		CL = new value for ??? (v6.0+)
		CH = new value for ??? (v6.0+)
		DH = ???
		Return: AL = old value replaced by CL (v6.0+)
			AH = old value replaced by CH (v6.0+)
--------U-16FFB9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFB9h
	???
Return: AX = ???
	CX = ???
	DS:SI -> ???
	ES:DI -> ???
--------U-16FFBA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFBAh
	???
Return: AX = ???
Note:	available only when popped up
--------U-16FFBB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CLEAR ??? FLAG
	AX = FFBBh
Note:	available only when popped up
SeeAlso: AX=FFB4h
--------U-16FFBC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - RESTORE ORIGINAL SCREEN???
	AX = FFBCh
--------U-16FFBD-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ??? DATABASE INDEXING MESSAGES
	AX = FFBDh
	???
Return: ???
--------U-16FFBE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFBEh
	???
Return: ???
Note:	available only when popped up
--------U-16FFBF-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFBFh
	BX = DOS file handle to write on
	???
Return: ???
Note:	available only when popped up
--------U-16FFC0-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFC0h
	???
Return: AX = 0000h if successful
	AX = FFFFh on error
Note:	available only when popped up
--------U-16FFC1-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFC1h
	BL = ???
	ES:DI -> data structure (see #00623)
	???
Return: AX = ???
Note:	available only when popped up
SeeAlso: AX=FFC2h,AX=FFC3h

Format of PC Tools DESKTOP data structure:
Offset	Size	Description	(Table 00623)
 00h	WORD	???
 02h	WORD	???
 04h	WORD	???
 06h	WORD	???
 08h	WORD	???
 0Ah	BYTE	???
 0Bh	BYTE	??? (zero/nonzero)
---v7.1---
 0Ch	WORD	???
 0Eh	BYTE	???
 0Fh	WORD	???
 11h	WORD	???
	???
--------U-16FFC2-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFC2h
	BL = ???
	ES:DI -> data structure (see #00623)
	???
Return: AH = ???
	CX = ???
	DH = ???
	DL = ???
Note:	available only when popped up
SeeAlso: AX=FFC1h,AX=FFC3h
--------U-16FFC3-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFC3h
	BL = ???
	ES:DI -> data structure (see #00623)
	???
Return: AH = ???
	CX = ???
	DH = ???
	DL = ???
Note:	available only when popped up
SeeAlso: AX=FFC1h,AX=FFC2h
--------U-16FFC4-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET ???
	AX = FFC4h
Return: AL = ???
	BX = segment of scratch space???
	CX = segment of stored screen data (section covered by window???)
	DX = segment of window parameters for ???
	ES:BP -> ???
Note:	available only when popped up in versions prior to 6.0
--------U-16FFC5-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CHECK WHETHER DESKTOP LOADED RESIDENT
	AX = FFC5h
Return: BL = Desktop state
	    00h if nonresident
	    nonzero if loaded resident
Note:	available only when popped up; should call AX=FFEFh first to ensure
	  that DESKTOP is active
SeeAlso: AX=FFEFh,AX=FFF3h
--------U-16FFC6-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ???
	AX = FFC6h
	BL = new value for ???
--------U-16FFC7-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - REMOVE WINDOW
	AX = FFC7h
	???
Return: ???
--------U-16FFC8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET ???
	AX = FFC8h
Return: DS:SI -> ???
Note:	valid only while popped up
--------U-16FFC9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - COPY DATA TO CLIPBOARD
	AX = FFC9h
	DS:SI -> characters to store in clipboard
	CX = size in bytes
Return: CF set on error
Notes:	available only when popped up
	while copying, bytes of 00h and 0Ah are skipped
--------U-16FFCA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ???
	AX = FFCAh
	DX = ???
Return: AX destroyed
Note:	available only when popped up
--------U-16FFCB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SELECT WINDOW PARAMETERS???
	AX = FFCBh
	DX = window specifier???
Return: AX destroyed
Note:	available only when popped up
SeeAlso: AX=FFB5h
--------U-16FFCC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY ASCIZ STRING CENTERED IN WINDOW
	AX = FFCCh
	DS:SI -> ASCIZ string
Return: AX = ???
	CX = ???
	ES:DI -> address past last character displayed (v5.1/5.5)
	      -> ??? on menu bar (v6.0)
--------U-16FFCD-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFCDh
	DS:DX -> ???
Return: ???
Note:	available only when popped up
--------U-16FFCE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ??? DELAYS
	AX = FFCEh
	CX = ???
Return: nothing???
--------U-16FFCF-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CLOSE PRINTER/PRINT FILE
	AX = FFCFh
Note:	available only when popped up
--------U-16FFD0-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PREPARE TO PRINT???
	AX = FFD0h
	???
Return: ???
Note:	available only when popped up
--------U-16FFD1-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY PRINT OPTIONS MENU
	AX = FFD1h
Return: BX = number of copies
	DX = destination
	    00h cancel
	    01h LPT1
	    02h LPT2
	    03h LPT3
	    04h COM1
	    05h COM2
	    06h disk file
Note:	available only when popped up
--------U-16FFD2-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD2h
	BX = ???
Return: BL = ???
Note:	available only when popped up
--------U-16FFD3-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD3h
	DS:SI -> 92-byte data record for ???
Return: ???
SeeAlso: AX=FED3h
--------U-16FFD4BH3C-------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CREATE/OPEN/DELETE FILE
	AX = FFD4h
	BH = 3Ch create file (with no attributes)
	     3Dh open file
	     41h delete file
	BL = access mode
	     00h read only
	     01h write only
	     02h read/write
	DS:SI -> ASCIZ filename
Return: BX = file handle
	    0000h on error
Note:	operation is attempted in (in order) the directory from which the
	  desktop was started/run???, the directory specified with the
	  filename, X:\PCTOOLS\, and X:\
--------U-16FFD5-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD5h
	???
Return: ???
Note:	available only when popped up
--------U-16FFD6-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD6h
	BX = ???
	CX = ???
	DX = offset in ???
	???
Return: ???
Note:	available only when popped up
--------U-16FFD7-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFD7h
	???
Return: BL = ???
Note:	available only when popped up
--------U-16FFD8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SAFE CREATE FILE
	AX = FFD8h
	DS:BX -> ASCIZ filename
Return: BX = file handle
	    0000h on error
Note:	pops up confirmation menu if file already exists
	only available when popped up???
--------U-16FFD9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET ???
	AX = FFD9h
Return: AX = ???
Note:	available only when popped up
--------U-16FFDA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET NAME OF LAST FILE OPENED
	AX = FFDAh
	DS:SI -> ??? (v5.1/5.5 only)
Return: DS:SI -> filename
--------U-16FFDB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ???
	AX = FFDBh
	BL = ???
Note:	available only when popped up
--------U-16FFDC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - UNHOOK
	AX = FFDCh
Return: interrupt vectors 09h, 10h (v6.0+), 16h, 1Ch, and 21h restored to
	  original values
Index:	uninstall;PC Tools DESKTOP
--------U-16FFDDBX0000-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - INSTALLATION CHECK
	AX = FFDDh
	BX = 0000h
Return: CX = 5555h
	DX = 5555h if PCShell installed in resident mode
--------U-16FFDDBX0001-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - REQUEST POP-UP
	AX = FFDDh
	BX = 0001h
Return: CF clear if request successful (PCShell will pop up)
	CF set on error
SeeAlso: AX=FFDDh/BX=0003h
--------U-16FFDDBX0002-----------------------
INT 16 U - PC Tools v5.1-5.5 PCShell API - GET ???
	AX = FFDDh
	BX = 0002h
Return: AL =
	    00h ???
	    01h ???
Note:	PCShell v6.0+ displays the error message "Incorrect PCRUN version",
	  awaits a keystroke, and aborts the current process
--------U-16FFDDBX0003-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - REQUEST POP-UP
	AX = FFDDh
	BX = 0003h
SeeAlso: AX=FFDDh/BX=0001h
--------U-16FFDDBX0004-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - GET ???
	AX = FFDDh
	BX = 0004h
Return: CF clear if successful
	    DS:SI -> ???
--------U-16FFDDBX0005-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - ???
	AX = FFDDh
	BX = 0005h
	???
Return: ???
Note:	resets various variables if certain conditions are met
--------U-16FFDDBX0006-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - ???
	AX = FFDDh
	BX = 0006h
	???
Return: ???
Note:	resets various variables if certain conditions are met
--------U-16FFDDBX0007-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - SET ??? FLAG
	AX = FFDDh
	BX = 0007h
Return: CF clear if successful
SeeAlso: AX=FFDDh/BX=0008h
--------U-16FFDDBX0008-----------------------
INT 16 U - PC Tools v5.1+ PCShell API - CLEAR ??? FLAG
	AX = FFDDh
	BX = 0008h
Return: CF undefined
SeeAlso: AX=FFDDh/BX=0007h
--------U-16FFDDBX0009-----------------------
INT 16 U - PC Tools v6.0+ PCShell API - GET PCRUN PARAMETERS
	AX = FFDDh
	BX = 0009h
Return: CF clear if successful
	    DS:SI -> list of pointers (see #00624)

Format of PC Tools PCShell returned pointer list:
Offset	Size	Description	(Table 00624)
 00h	WORD	offset of WORD containing ???
 02h	WORD	offset of name of program to execute
 04h	WORD	offset of 80-byte buffer for ???
 06h	WORD	offset of buffer for ??? (length in WORD preceding buffer)
 08h	WORD	offset of buffer for ??? (length in WORD preceding buffer)
--------U-16FFDDBX000A-----------------------
INT 16 U - PC Tools v6.0+ PCRUN API - INSTALLATION CHECK
	AX = FFDDh
	BX = 000Ah
Return: CX = 5555h if running
	DX = 5555h
Note:	also sets a flag
--------U-16FFDDBX000B-----------------------
INT 16 U - PC Tools v6.0+ PCRUN API - ???
	AX = FFDDh
	BX = 000Bh
	???
Return: CX = 5555h if PCRUN active
	DX = 5555h
Note:	also clears flag set by AX=FFDDh/BX=000Ah
--------U-16FFDE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY POPUP MENU
	AX = FFDEh
	DS:DX -> menu description (must be on a paragraph boundary)
Return: AX = ???
	    AL seems to be the number of the selected button
Note:	available only when popped up
SeeAlso: AX=FFEEh
--------U-16FFDF-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFDFh
	???
Return: ???
--------U-16FFE0-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFE0h
	CX = ???
	DX = ???
Note:	available only when popped up
--------U-16FFE1-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - BEEP
	AX = FFE1h
--------U-16FFE2-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFE2h
	DX = ???
Return: ???
Note:	available only when popped up
--------U-16FFE3-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PRINT CHARACTER
	AX = FFE3h
	BL = character to print to currently open printer or print file
Return: CF set on error
Note:	available only when popped up
SeeAlso: INT 17/AH=00h
--------U-16FFE4-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFE4h
	DX = segment of ???
Return: ???
Note:	available only when popped up
--------U-16FFE5-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - POP UP FILE SELECTION MENU
	AX = FFE5h
	DS:SI -> ASCIZ wildcard filespec followed by ASCIZ menu title
	DX = segment of window parameters???
Return: AX = DOS file handle for file
		DS:DX -> filename???
	    FFFFh if function cancelled by user
Note:	available only when popped up
SeeAlso: AX=FFDAh
--------U-16FFE6-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - CHECK FOR AND GET KEYSTROKE
	AX = FFE6h
Return: AX = 0000h if no key available
	     else  BIOS keycode
Notes:	available only when popped up
	invokes INT 28 idle interrupt before checking for key
--------U-16FFE7-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFE7h
	BX = segment of ???
Return: ???
Note:	available only when popped up
--------U-16FFE8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY NUMBER
	AX = FFE8h
	CX = number
	DH = attribute
	DS:SI -> destination for ASCII number
Return: DS:SI buffer filled in with alternating characters and attributes
--------U-16FFE9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET FILE LIST???
	AX = FFE9h
Return: BX = segment of file/directory list (14 bytes per file, NUL-padded)
Note:	available only when popped up
--------U-16FFEA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY COUNTED STRING
	AX = FFEAh
	DS:SI -> counted string (count byte followed by string)
Return: ???
Note:	available only when popped up
--------U-16FFEB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFEBh
	???
Return: ???
--------U-16FFEC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET KEY
	AX = FFECh
	DS:SI -> FAR routine to ???
	BX = ???
	???
Return: AX = keystroke
	    FFFFh if F10 pressed to go to menu
Notes:	available only when popped up
	invokes INT 28 while waiting for keystroke
	F10 is hotkey to Desktop menu
Index:	hotkeys;PC Tools DESKTOP
--------U-16FFED-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET ???
	AX = FFEDh
Return: AX = ???
Note:	available only when popped up
--------U-16FFEE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DEFINE PULLDOWN MENUS
	AX = FFEEh
	DS:SI -> pulldown menu system description (see #00625)
Return: AX destroyed
Notes:	available only when popped up
	if the accessory does not need any menu items of its own, it should
	  call AX=FFFAh instead
SeeAlso: AX=FFF7h,AX=FFFAh

Format of PC Tools DESKTOP pulldown menu system description:
Offset	Size	Description	(Table 00625)
 00h	WORD	offset of menu bar contents (counted string)
 02h	WORD	number of items on menu bar
 04h 10 BYTEs	scan codes for hotkeying to each of up to ten menu items
 0Eh 10 BYTEs	which character to highlight in each menu item (01h=first)
 18h	WORD	offset of first menu definition (see #00626)
 1Ah	WORD	offset of second menu definition
	...

Format of PC Tools DESKTOP menu definition:
Offset	Size	Description	(Table 00626)
 00h	WORD	offset of menu contents (see #00627)
 02h	WORD	number of entries in menu
 04h	for each entry:
		Offset	Size	Description
		 00h	BYTE	scancode of Alt-key to invoke entry
		 01h	BYTE	character to highlight (01h=first, etc)
		 02h	WORD	offset of FAR routine to handle selection

Format of PC Tools DESKTOP menu contents:
Offset	Size	Description	(Table 00627)
 00h	BYTE	number of lines in menu
 01h	BYTE	width of menu
 02h  N BYTEs	counted strings, one for each line in menu
--------U-16FFEFCX0000-----------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - INSTALLATION CHECK
	AX = FFEFh
	CX = 0000h
Return: CX = ABCDh if PC Tools DESKTOP.EXE installed
	    BX = segment of resident portion
	    AX = ??? (v5.1/5.5 only)
SeeAlso: AX=FEEFh,AX=FFC5h,AX=FFF3h
--------U-16FFF0-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SET ???
	AX = FFF0h
	DX = ???
Return: AX destroyed
Note:	available only when popped up
--------U-16FFF1BX0000-----------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ALTERNATE INSTALLATION CHECK
	AX = FFF1h
	BX = 0000h  leave ??? flag as is
	    nonzero set ??? flag
Return: CX = 5555h if installed
	DX = 5555h
--------U-16FFF2-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DISPLAY HELP LINE
	AX = FFF2h
	DS:SI -> ASCIZ function key label string (each label preceded by '[')
		or help text
Return: AX destroyed
Notes:	available only when popped up
	if the specified string does not start with '[', it is displayed
	  centered on the bottom line, else the function key labels are shown
--------U-16FFF3-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PREPARE TO UNLOAD RESIDENT DESKTOP
	AX = FFF3h
Note:	releases any EMS being used; restores video mode, page, and cursor
	  shape; and restores interrupt vectors
SeeAlso: AX=FFC5h,AX=FFEFh
Index:	uninstall;PC Tools DESKTOP
--------U-16FFF4-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - ???
	AX = FFF4h
	???
Return: ???
Note:	available only when popped up
SeeAlso: AX=FFF6h
--------U-16FFF5-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET SCREEN ATTRIBUTE ARRAY
	AX = FFF5h
Return: ES:BX -> screen attributes data structure (see #00628)
	AL = ??? (v6.0+)

Format of PC Tools DESKTOP attribute data structure:
Offset	Size	Description	(Table 00628)
 -1	BYTE	attribute for desktop background
 00h	BYTE	attribute for normal characters on desktop menu
 01h	BYTE	attribute for highlighted characters on desktop menu
 02h  5 BYTEs	???
 07h	BYTE	attribute for dialog boxes
 08h 15 BYTEs	???
 17h	BYTE	attribute for message boxes
--------U-16FFF6-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - INVOKE NOTEPAD EDITOR
	AX = FFF6h
	DS = segment of editor buffer structure (see #00629)
	BX = ???
	DX = segment of window parameters structure (see #00622)
Return: ???
Note:	available only when popped up
SeeAlso: AX=FFF4h

Format of PC Tools DESKTOP editor buffer structure:
Offset	Size	Description	(Table 00629)
 00h	WORD	offset of current cursor position in buffer segment
 02h  2 BYTEs	???
 04h	WORD	offset of beginning of file data in buffer segment
 06h 10 BYTEs	???
 10h  N BYTEs	ASCIZ name of file being edited
--------U-16FFF7-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PROCESS MENU BAR ENTRY???
	AX = FFF7h
	DS:SI -> ???
	???
Return: ???
Notes:	available only when popped up
	performs input processing on the menu bar set up with AX=FFEEh
SeeAlso: AX=FFEEh,AX=FFFBh
--------U-16FFF8-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DRAW EMPTY WINDOW
	AX = FFF8h
	DS:0000h -> window parameters structure (see #00622)
	DS:BX -> DWORD to store address of ??? on screen
Return: ???
--------U-16FFF9-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DEFINE SCREEN REFRESH ROUTINE
	AX = FFF9h
	ES:BX -> FAR routine to redisplay the utility's window
Note:	available only when popped up
--------U-16FFFA-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - DEFINE STANDARD PULLDOWN MENUS
	AX = FFFAh
Notes:	available only when popped up
	adds the "Window" option to the "Desktop" option which is the only one
	  available when no accessories are active.  Unlike AX=FFEEh, no
	  additional menu items are added between "Desktop" and "Window"
SeeAlso: AX=FFEEh,AX=FFFBh
--------U-16FFFB-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - PROCESS STANDARD MENU BAR
	AX = FFFBh
Return: ???
Notes:	available only when popped up
	performs input processing on the standard menu bar set up with AX=FFFAh
SeeAlso: AX=FFF7h
--------U-16FFFC-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - GET HOTKEYS AND KEYBOARD VECTOR
	AX = FFFCh
Return: ES:BX -> hotkey table (see #00630)
	DS:DX = original INT 09 vector

Format of PC Tools DESKTOP hotkey table:
Offset	Size	Description	(Table 00630)
 00h  2 BYTEs	scancode/shift state for desktop hotkey
 02h  2 BYTEs	scancode/shift state for clipboard paste key
 04h  2 BYTEs	scancode/shift state for clipboard copy key
 06h  2 BYTEs	scancode/shift state for screen autodial key
--------U-16FFFD-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - COPY ???
	AX = FFFDh
Return: AX destroyed
Note:	copies 4000 bytes from ??? to ??? under certain circumstances
SeeAlso: AX=FF91h,AX=FF92h
--------M-16FFFE-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - SHOW MOUSE CURSOR
	AX = FFFEh
SeeAlso: AX=FFFFh,INT 33/AX=0001h
--------M-16FFFF-----------------------------
INT 16 U - PC Tools v5.1-8.0 DESKTOP - HIDE MOUSE CURSOR
	AX = FFFFh
SeeAlso: AX=FFFEh,INT 33/AX=0002h
--------P-17----DX0ABC-----------------------
INT 17 - PRINTER - LPTx v5.x INSTALLATION CHECK
	DX = 0ABCh
Return: AX = AAAAh
	DX = BAAAh
	ES = code segment of resident portion
--------P-17----DX0B90-----------------------
INT 17 - PRINTER - LPTx v6.x INSTALLATION CHECK
	DX = 0B90h
Return: DX = ABBBh
	ES = code segment of resident portion
--------P-17----DX0B91-----------------------
INT 17 - PRINTER - LPTx v7.x INSTALLATION CHECK
	DX = 0B91h
Return: DX = ABCBh
	ES = code segment of resident portion
--------P-17----DX0F5F-----------------------
INT 17 - PRINTER - LPTx v4.x INSTALLATION CHECK
	DX = 0F5Fh
Return: AX = AAAAh
	DX = F555h
	ES = code segment of resident portion
--------B-1700-------------------------------
INT 17 - PRINTER - WRITE CHARACTER
	AH = 00h
	AL = character to write
	DX = printer number (00h-02h)
Return: AH = printer status (see #00631)
Note:	Under PhysTechSoft's PTS ROM-DOS the parallel port can also be
	  accessed as COM5.
BUGS:	Some print spoolers trash the BX register on return.
	Some original IBM BIOSes set more than one printer status bits at
	  a time, while only one of them is correct.
SeeAlso: AH=02h,AH=84h"AX",AX=6F02h,AH=F1h,INT 16/AX=FFE3h,INT 1A/AH=11h"NEC"
SeeAlso: INT 4B/AH=00h,PORT 0278h"PRINTER",MEM 0040h:0008h,MEM 0040h:0078h

Bitfields for printer status:
Bit(s)	Description	(Table 00631)
 7	not busy
 6	acknowledge
 5	out of paper
 4	selected
 3	I/O error
 2-1	unused
 0	timeout
Notes:	If both, bit 5 "out of paper" and 4 "selected" are set, the MS-DOS/
	  PC DOS kernel assumes that no printer is attached.
	for Tandy 2000, bit 7 indicates printer-busy when set rather than clear
--------B-1701-------------------------------
INT 17 - PRINTER - INITIALIZE PORT
	AH = 01h
	DX = printer number (00h-02h)
Return: AH = printer status (see #00631)
Note:	some printers report that they are ready immediately after
	  initialization when they actually are not; a more reliable result may
	  be obtained by calling AH=02h after a brief delay
SeeAlso: AH=02h,AH=FFh"PC-MOS",INT 1A/AH=10h"NEC",INT 4B/AH=01h
--------B-1702-------------------------------
INT 17 - PRINTER - GET STATUS
	AH = 02h
	DX = printer number (00h-02h)
Return: AH = printer status (see #00631)
Note:	PRINTFIX from MS-DOS 5.0 hooks this function and always returns AH=90h
SeeAlso: AH=01h,AH=F2h,INT 1A/AH=12h"NEC",INT 4B/AH=02h
--------P-1702--DX0000-----------------------
INT 17 - INSET - INSTALLATION CHECK
	AH = 02h
	DX = 0000h
	CX = 07C3h (1987d)
Return: CX = 07C2h (1986d) if installed
Program: INSET is a text/graphics integration program
--------b-170200BX5050-----------------------
INT 17 - Enhanced Parallel Port (EPP) BIOS - INSTALLATION CHECK
	AX = 0200h
	BX = 5050h ('PP')
	CH = 45h   ('E')
	DX = printer port number (00h-02h)
Return: AH = status
	    00h if installed and port is an enhanced parallel port
		CX:AL = installed BIOS type
		    5050h:45h ('PPE') if EPP v3.0+ BIOS installed
		    4550h:50h ('EPP') if EPP v1.0 BIOS installed
		---EPP 1.0, 3.0---
		DX:BX -> far entry point to Advanced BIOS (see #00632)
		---EPP Revision 7---
		DX = EPP I/O base address
		ES:BX -> far entry point to EPP BIOS (see #00632,#00633)
	    03h if installed but specified port not supported
		CF set
Program: The Enhanced Parallel Port BIOS provides support for parallel
	  port peripherals using the enhanced modes of the IEEE 1284.
SeeAlso: AH=E0h,MEM 0040h:0008h,MEM 0040h:00DCh

(Table 00632)
Call EPP BIOS entry point with:
	DL = port number (v1.0,v3.0)
	DX = (Revision 7) EPP port I/O base address
	AH = function
	    00h Query Configuration
		Return: AH = 00h if successful
			    AL = IRQ number used by port or FFh if no IRQ
			    BH = EPP BIOS revision (major in high nybble,
				  minor in low nybble)
			    BL = I/O capabilities (see #00635)
			    ES:DI -> ASCIZ driver information/version text
			    ---v1.0,v3.0---
			    CX = I/O port base address for parallel port
			    ---Revision 7---
			    CL = EPP chipset code (see #00636)
			    CH = hardware manufacturer's product code
	    01h Set Mode
		AL = mode bits (see #00637)
		Return: AX,BX destroyed
	    02h Get Mode
		Return: AL = mode bits (see also #00637)
				bit 7: EPP port interrupts enabled
			AH = 00h
			CF clear
			BX destroyed
	    03h Interrupt Control
		AL = subfunction
		    00h enable parallel port interrupts
		    01h disable parallel port interrupts
		Return: AH = status (00h,05h,06h) (see also #00634)
	    04h EPP Reset
		Return: AH = 00h if successful
			AL destroyed
	    05h perform Address-Write/Device-Select I/O cycle
		AL = device address
		Return: AH = status
			AL destroyed
	    06h perform Address-Read I/O cycle
		Return: AL = returned address/device data
			AH = status
	    07h write byte
		AL = data byte to write
		Return: AH = status
	    08h output block of data
		DS:SI -> block of data to be sent to parallel port
		CX = number of bytes to output
		Return: AH = status (see #00634)
			CX = number of unsent bytes
	    09h read byte of data
		Return: AH = status (see #00634)
			AL = byte read from parallel port
	    0Ah read block of data
		ES:DI -> buffer for received data
		CX = number of bytes to read from paralle port
		Return: AH = status (see #00634)
			ES:DI buffer filled if successful
			CX = number of bytes not transferred
	    0Bh Address/Byte-Read
		AL = device address
		Return: AH = status (see #00634)
			AL = byte read if successful
	    0Ch Address/Byte-Write
		AL = device address
		DH = data byte (v1.0,v3.0)
		CL = data byte (Revision 7)
		Return: AH = status (see #00634)
	    0Dh Address/Block-Read
		AL = device address
		ES:DI -> buffer for received data
		CX = number of bytes to read
		Return: AH = status (see #00634)
			CX = number of bytes NOT transferred
	    0Eh Address/Block-Write
		AL = device address
		ES:DI -> data to be sent (v1.0,v3.0)
		DS:SI -> data to be send (Revision 7)
		CX = number of bytes to write
		Return: AH = status (see #00634)
			CX = number of bytes NOT transferred
	    0Fh Lock Port
		AL = multiplexor port number
			bits 7-4: daisy chain port number (1-8)
			bits 3-0: mux device port number (1-8, 0 if no mux)
		Return: AH = status (00h,03h,05h) (see #00634)
	    10h Unlock Port
		AL = multiplexor port number
			bits 7-4: daisy chain port number (1-8)
			bits 3-0: mux device port number (1-8, 0 if no mux)
		Return: AH = status (00h,03h,05h) (see #00634)
	    11h Device Interrupt
		BL = multiplexor port number
			00h if no multiplexor, else mux device port (01h-08h)
		AL = subfunction
		    00h disable device interrupts
		    01h enable device interrupt
			ES:DI -> interrupt event handler
		Return: AH = status (00h,03h,05h,06h) (see #00634)
		Note:	AMI BIOS v1.00.12.AX1T ignores the multiplexor port
			  number; it also always sets INT 0F to the address
			  specified in ES:DI
	    12h Real-Time Mode
		AL = subfunction
		    00h check whether any real-time devices present
		    01h add (advertise) real-time device
		    02h remove real-time device
		Return: AH = status (00h,05h,06h,07h) (see #00634)
			AL = real-time devices present? (00h no, 01h yes)
		Note:	unlike all other functions, this one does not use DL/DX
Return: AH = status (see #00634)
	CF clear if successful
	CF set on error
	BX destroyed
SeeAlso: #00633

(Table 00633)
Call EPP BIOS (Revision 7) entry point multiplexor functions with:
	DX = EPP port base I/O address
	AH = function
	    40h Query Mux
		Return: AH = status (see #00634)
			AL = currently-selected port
			CH = status flags
				bit 0: channel locked
				bit 1: interrupt pending
			BH destroyed
		Note:	the PhoenixBIOS v4.0 documentation lists BL as the
			  currently-selected port and AL as the status flags
	    41h Query Device Port
		AL = EPP multiplex device port (1-8)
		Return: AH = status (see #00634)
			CH = status flags (see #00638)
			BX = EPP product/device ID (0000h if undefined)
		Note:	the PhoenixBIOS v4.0 documentation lists AL as the
			  status flags and CX as the device ID
	    42h Set Product ID
		AL = EPP multiplex device port (1-8)
		CX = EPP product ID
		Return: AH = status (see #00634)
			BX destroyed
	    50h Query Daisy Chain
		AL = EPP multiplexor device port (1-8)
		Return: AH = status (see #00634)
			CH = status flags
				bit 0: channel locked
				bit 1: interrupt pending
			BL = currently-selected device
			BH = EPP daisy chain revision (high nybble = major)
			CL = daisy-chain depth (00h if no daisy chain)
			ES:DI -> ASCIZ driver vendor identification string
		Note:	the PhoenixBIOS v4.0 documentation lists AH=51h as
			  "Query Daisy Chain" and BL as the multiplexor port;
			  it also lists AL as status flags on return
	    51h Rescan Daisy Chain (dynamically reassign port numbers)
		AL = EPP multiplexor device port (1-8)
		Return: AH = status (see #00634)
			BX destroyed
		Note:	the PhoenixBIOS v4.0 documentation lists AH=50h as
			  "Rescan Daisy Chain" and BL as the multiplexor port
Notes:	these functions are only valid if a port multiplexor or daisy chain
	  is present
	PhoenixBIOS 4.0 documents function 50h as "Rescan" and 51h as
	  "Query Daisy Chain"
SeeAlso: #00632,INT 2D/AL=DCh

(Table 00634)
Values for EPP BIOS function status:
 00h	successful
 02h	unsupported command/feature
 03h	unsupported parallel port
 05h	unsupported in current mode
 06h	invalid subfunction
 07h	already ???
 20h	multiplexor not present (AMI)
 40h	multiplexor not present
 41h	multiplexor currently locked
 80h	I/O timeout
 FFh	invalid/unsupported function
SeeAlso: #00632,#00633

Bitfields for EPP (v3.0, Revision 7) I/O capabilities:
Bit(s)	Description	(Table 00635)
 0	multiplexor present
 1	PS/2 bi-directional capable
 2	daisy chain present
 3	ECP capable
 4	EPP software emulation supported
 5	EPP capable
 6	fast Centronics supported
 7	standard EPP I/O map
SeeAlso: #00632

(Table 00636)
Values for EPP (Revision 7) chipset code:
 00h	Intel SL
 01h	FarPoint Communications
 02h	SMC
 03h	Chips&Technologies
 04h	Western Digital
 05h	National Semiconductor
SeeAlso: #00632

Bitfields for EPP BIOS mode bits:
Bit(s)	Description	(Table 00637)
 0	set compatibility mode
 1	set bi-directional mode
 2	set EPP mode
---Revision 7,v3.0---
 3	set ECP mode
 4	set EPP software emulation
 5	set fast Centronics mode
 6-7 reserved (0)
SeeAlso: #00632,#M0053

Bitfields for EPP BIOS multiplex status flags:
Bit(s)	Description	(Table 00638)
 0	port is selected
 1	port is locked
 2	interrupts are enabled
 3	interrupt pending
SeeAlso: #00633
--------P-1703-------------------------------
INT 17 U - Emulaser ELTSR - INSTALL INTERRUPT HANDLERS
	AH = 03h
Return: BX = ???
	CX = ???
Program: ELTSR is the resident portion of the Emulaser PostScript emulator by
	  Vertisoft Systems, Inc.
SeeAlso: AH=04h"Emulaser",AH=0Eh,INT 1A/AH=E5h
----------1703-------------------------------
INT 17 - IBM SurePath BIOS - Officially "Private" Function
	AH = 03h
SeeAlso: AH=04h"IBM",AH=05h"IBM"
--------c-1703-------------------------------
INT 17 - PC-MOS/386 v5.01 - PRINT SPOOLER - PRINT STRING
	AH = 03h
	DX = printer port number
	CX = number of characters to print
	DS:SI -> string
Return: AH = printer status (see #00631)
	CX = number of characters actually printed
Desc:	send an entire string of chars to the print spooler with a single call
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
SeeAlso: AH=00h,AH=01h,AH=02h,AH=FFh"PC-MOS"
--------c-1703--BX5A00-----------------------
INT 17 - DMP Print Spooler v2.03 - INSTALLATION CHECK
	AH = 03h
	BX = 5A00h
Return: AX = 5ACBh
	DI = 0000h
	ES = DMP code segment (also data segment)
Program: DMP is a Printer driver/spooler, by DMP (USA), available on the
	  PCTODAY disk, volume 10, March 1991
--------N-170300-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "socket"
	AX = 0300h
	CX = type of socket from  socket( domain, type, protocol )
	DX = local identifier of socket (0 - 31)
Return: AX = 0000h success
	    CX = segment of 4500 byte transfer buffer
	    DX = offset of 4500 byte transfer buffer
	   = FFFFH failure
	    CX = error code
		ENFILE	    23
Program: DOSISODE is the ISO developers environment which has been ported to
	  DOS and will run with the Waterloo TCP turned into a resident TSR.
	  Currently it allows a maximum of 6 open sockets.
Note:	this function will initialize the interface the first time it is
	  called
SeeAlso: AX=0400h"DOSISODE",AX=0600h"DOSISODE",AX=0800h"DOSISODE"
SeeAlso: AX=0A00h"DOSISODE",AX=0C00h"DOSISODE",AX=0E00h"DOSISODE"
--------P-1704-------------------------------
INT 17 U - Emulaser ELTSR - BEGIN CAPTURING OUTPUT
	AH = 04h
Note:	has no effect unless ELTSR is deactivated (see AX=0503h)
SeeAlso: AH=03h"Emulaser",AX=0503h,INT 1A/AH=E5h
----------1704-------------------------------
INT 17 - IBM SurePath BIOS - Officially "Private" Function
	AH = 04h
SeeAlso: AH=03h"IBM",AH=05h"IBM"
--------N-170400-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "bind"
	AX = 0400h
Note:	this function just returns
SeeAlso: AX=0300h"DOSISODE",AX=0500h"DOSISODE",AX=0C00h"DOSISODE"
----------1705-------------------------------
INT 17 - IBM SurePath BIOS - Officially "Private" Function
	AH = 05h
SeeAlso: AH=03h"IBM",AH=04h"IBM"
--------P-170500-----------------------------
INT 17 U - Emulaser ELTSR - ???
	AX = 0500h
	???
Return: AX = unload status (0001h safe to unload, 0002h not safe)
	BX = ???
	CX = PSP segment of ELTSR
	DX = activity flag (0000h disabled, 0001h capturing, 0002h ???printing)
	SI = ???
	DI = ???
SeeAlso: AH=04h,INT 1A/AH=E5h
--------N-170500-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "connect"
	AX = 0500h
SeeAlso: AX=0400h"DOSISODE",AX=0700h"DOSISODE",AX=0C00h"DOSISODE"
--------P-170501-----------------------------
INT 17 U - Emulaser ELTSR - UNHOOK INTERRUPTS
	AX = 0501h
Return: (see AX=0500h)
Note:	restores interrupt vectors without checking whether they have been
	  hooked by later programs; should only be called if ELTSR reports
	  that it is safe to unload
SeeAlso: AH=04h,AX=0500h,AX=0503h,INT 1A/AH=E5h
Index:	uninstall;Emulaser ELTSR
--------P-170502-----------------------------
INT 17 U - Emulaser ELTSR - SET ???
	AX = 0502h
	BL = Emulaser port (31h = LPT1, 32h = LPT2, 33h = LPT3)
	CL = ???
	DL = ???
Return: (see AX=0500h)
SeeAlso: AH=04h,AX=0500h,INT 1A/AH=E5h
--------P-170503-----------------------------
INT 17 U - Emulaser ELTSR - DEACTIVATE???
	AX = 0503h
Return: (see AX=0500h)
SeeAlso: AH=04h,AX=0500h,AX=0501h,INT 1A/AH=E5h
--------P-1706-------------------------------
INT 17 U - Emulaser ELTSR - ???
	AH = 06h
	???
Return: ???
SeeAlso: AX=0500h,AX=0503h,AH=07h"ELTSR",INT 1A/AH=E5h
--------N-170600-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "listen"
	AX = 0600h
Note:	this function just returns
SeeAlso: AX=0300h"DOSISODE",AX=0700h"DOSISODE",AX=0C00h"DOSISODE"
SeeAlso: AX=0E00h"DOSISODE"
--------P-1707-------------------------------
INT 17 U - Emulaser ELTSR - OPEN CAPTURE FILE
	AH = 07h
	ES:DX -> ASCIZ filename to be opened
Return: ???
Note:	new output will be appended to the specified file
SeeAlso: AH=08h,INT 1A/AH=E5h
--------N-170700-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "accept"
	AX = 0700h
Note:	this function just returns
SeeAlso: AX=0600h"DOSISODE",AX=0800h"DOSISODE",AX=0C00h"DOSISODE"
--------P-1708-------------------------------
INT 17 U - Emulaser ELTSR - CLOSE CAPTURE FILE
	AH = 08h
	???
Return: ???
Desc:	close the file previously opened by function 07h
SeeAlso: AH=07h,INT 1A/AH=E5h
--------N-170800-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "recvfrom"
	AX = 0800h
SeeAlso: AX=0500h"DOSISODE",AX=0900h"DOSISODE",AX=0A00h"DOSISODE"
--------P-1709-------------------------------
INT 17 U - Emulaser ELTSR - PRINT CAPTURE FILE???
	AH = 09h
	BX = ???
	CX = ???
	DX = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AX = status
	    00h successful
	    FFh failed
Program: ELTSR is the resident portion of the Emulaser PostScript emulator by
	  Vertisoft Systems, Inc.
Note:	this function calls through to INT 1A/AX=E401h, and thus requires
	  that either ELSPL or Disk Spool II be installed
SeeAlso: AH=0Ah,INT 1A/AX=E401h,INT 1A/AH=E5h
--------N-170900-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "sendto"
	AX = 0900h
SeeAlso: AX=0700h"DOSISODE",AX=0800h"DOSISODE",AX=0A00h"DOSISODE"
--------P-170A-------------------------------
INT 17 U - Emulaser ELTSR - SET ??? FILENAME
	AH = 0Ah
	ES:BX -> ??? buffer
	CX = length of ??? buffer
Return: ???
Note:	copies the specified name into the buffer passed to ELSPL as the
	  filename by AH=09h
SeeAlso: AH=09h,INT 1A/AH=E5h
--------N-170A00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "select"
	AX = 0A00h
SeeAlso: AX=0800h"DOSISODE",AX=0B00h"DOSISODE",AX=0E00h"DOSISODE"
--------P-170B-------------------------------
INT 17 U - Emulaser ELTSR - GET ???
	AH = 0Bh
Return: AX:BX -> ???
SeeAlso: AH=0Ah,INT 1A/AH=E5h
----------170B-------------------------------
INT 17 - IBM SurePath BIOS - Officially "Private" Function
	AH = 0Bh
SeeAlso: AH=03h"IBM",AH=0Ch"IBM"
--------N-170B00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "ioctl"
	AX = 0B00h
	DX = local identifier of socket (0 - 31)
Note:	this function sets the socket into non_block mode
SeeAlso: AX=0A00h"DOSISODE",AX=0C00h"DOSISODE",AX=0E00h"DOSISODE"
--------P-170C-------------------------------
INT 17 U - Emulaser ELTSR - SET ??? FLAG
	AH = 0Ch
	???
Return: ???
SeeAlso: AH=0Bh,INT 1A/AH=E5h
----------170C-------------------------------
INT 17 - IBM SurePath BIOS - Officially "Private" Function
	AH = 0Ch
SeeAlso: AH=0Bh"IBM",AH=0Dh"IBM"
--------N-170C00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "close"
	AX = 0C00h
SeeAlso: AX=0300h"DOSISODE",AX=0500h"DOSISODE",AX=0D00h"DOSISODE"
--------P-170D-------------------------------
INT 17 U - Emulaser ELTSR - GET TRUE ScrlLk STATE
	AH = 0Dh
Return: AX = state (0000h off, 0010h on)
Desc:	determine the actual state of ScrlLk even when Emulaser is controlling
	  the ScrlLk light as its activity indicator
SeeAlso: AH=0Ch,INT 16/AH=02h,INT 1A/AH=E5h
----------170D-------------------------------
INT 17 - IBM SurePath BIOS - Officially "Private" Function
	AH = 0Dh
SeeAlso: AH=0Ch"IBM",AH=0Eh"IBM"
--------N-170D00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - "shutdown" - SHUTDOWN INTERFACE
	AX = 0D00h
Note:	this function is used to shutdown the interface
SeeAlso: AX=0C00h"DOSISODE",AX=0E00h"DOSISODE"
--------P-170E-------------------------------
INT 17 U - Emulaser ELTSR - BACKGROUND PROCESSING
	AH = 0Eh
Program: ELTSR is the resident portion of the Emulaser PostScript emulator by
	  Vertisoft Systems, Inc.
Note:	this function is called by ELTSR on every INT 08 to allow data to be
	  processed in the background, but may also be called by applications
	  to give Emulaser additional CPU time
SeeAlso: AH=0Dh,INT 1A/AH=E5h
----------170E-------------------------------
INT 17 - IBM SurePath BIOS - Officially "Private" Function
	AH = 0Eh
SeeAlso: AH=03h"IBM",AH=0Dh"IBM",AH=80h"IBM"
--------N-170E00-----------------------------
INT 17 - DOSISODE to WATTCP TSR Interface - INSTALLATION CHECK
	AX = 0E00h
Return: CX = 1234h if installed
Program: DOSISODE is the ISO developers environment which has been ported to
	  DOS and will run with the Waterloo TCP turned into a resident TSR.
	  Currently it allows a maximum of 6 open sockets.
Note:	this function is used to check if the interface is loaded
SeeAlso: AX=0300h"DOSISODE",AX=0A00h"DOSISODE"
--------P-172000-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - INSTALLATION CHECK
	AX = 2000h
	BL = printer number???
Return: AX = status (see #00639)
	BX = driver version number (BH=major,BL=minor)
	CH = ??? (00h)
	CL = ???
	DX = ??? (0100h)
Note:	also enables the remaining printer driver functions (2001h-2007h)
SeeAlso: AX=2001h,AX=2002h,AX=2003h,AX=2004h,AX=2005h,AX=2006h,AX=2007h

(Table 00639)
Values for PC Paint function status:
 0000h	successful
 0001h	invalid printer???
 0002h	???
 0003h	invalid subfunction
 0005h	driver disabled, must call function 00h first
 0009h	unknown printer error
 000Bh	printer not selected
 000Ch	printer out of paper
 000Eh	error while writing to serial printer
 000Fh	???
 0010h	invalid function number
 0011h	value out of range
--------P-172001-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - SET ??? FLAG
	AX = 2001h
	BL = printer number???
Return: AX = status (see #00639)
--------P-172002-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - GET INFORMATION
	AX = 2002h
	BL = printer number???
	CL = desired information
	    00h printer type
		Return: ES:DI -> ASCIZ printer name
	    01h paper size
		DX = size index
		Return: ES:DI -> ASCIZ paper size description
	    02h ???
		Return: BX = ???
	    03h printer information???
		DX = ???
		ES:BX -> buffer for ??? (min 134 bytes)
Return: AX = status (see #00639)
SeeAlso: AX=2000h,AX=2004h
--------P-172003-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - ???
	AX = 2003h
	ES:BX -> ???
Return: AX = status (see #00639)
SeeAlso: AX=2000h,AX=2004h
--------P-172004-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - GET ???
	AX = 2004h
	BL = printer number???
Return: AX = status (see #00639)
	ES:DI -> ???
SeeAlso: AX=2000h,AX=2003h
--------P-172005-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - ADVANCE PRINTER TO NEXT PAGE
	AX = 2005h
	BL = printer number???
Return: AX = status (see #00639)
Note:	this function also clears the flag set by AX=2001h
SeeAlso: AX=2000h,AX=2001h,AX=2006h
--------P-172006-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - ADVANCE TO NEXT PAGE & SHUT DOWN
	AX = 2006h
	BL = printer number???
Return: AX = status (see #00639)
Note:	this function also clears the flag set by AX=2001h and disables
	  functions other than AX=2000h
SeeAlso: AX=2000h,AX=2001h,AX=2005h
--------P-172007-----------------------------
INT 17 - PC Paint Plus 2.0 - PRINTER DRIVER - UNIMPLEMENTED
	AX = 2007h
Return: AX unchanged
SeeAlso: AX=2000h
--------N-172400-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - ENABLE/DISABLE API FUNCTIONS
	AX = 2400h
	DL = new state
	    00h disabled
	    01h enabled
Return: DL = 24h if installed
	DH = minor version number
	CX = network address of this machine
	AL = status (see #00640)
SeeAlso: AX=2403h,INT 16/AX=4500h

(Table 00640)
Values for NET.24 function status:
 00h	successful
 01h	timeout
 02h	header error
 03h	data error
 04h	busy
 05h	invalid parameters
--------N-172401-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - RECEIVE BLOCK, NO HANDSHAKE
	AX = 2401h
	BL = timeout in clock ticks
Return: AL = status (see #00640)
	DX:BX -> receive buffer
SeeAlso: AX=2402h,AX=2404h,AX=2408h
--------N-172402-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - TRANSMIT BLOCK, NO HANDSHAKE
	AX = 2402h
	transmit buffer filled (see AX=2403h)
Return: AL = status (see #00640)
SeeAlso: AX=2401h,AX=2403h,AX=2404h,AX=2409h
--------N-172403-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - GET STATUS AND TRANSMISSION BUFFER
	AX = 2403h
Return: AL = status (see #00640)
	CX = number of characters in receive ring buffer
	DX:BX -> transmit buffer
SeeAlso: AX=2400h,AX=2402h
--------N-172404-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - SEND ACK BLOCK
	AX = 2404h
	BX = target address
Return: AL = status (see #00640)
SeeAlso: AX=2402h,AX=2405h
--------N-172405-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - SEND NAK BLOCK
	AX = 2405h
	BX = target address
Return: AL = status (see #00640)
SeeAlso: AX=2402h,AX=2404h
--------N-172406-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - PREPARE CHARACTER-ORIENTED RECEIVE
	AX = 2406h
Return: AL = status (see #00640)
SeeAlso: AX=2407h,AX=240Ah
--------N-172407-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - RECEIVE CHARACTER FROM REMOTE
	AX = 2407h
Return: AL = status (see also #00640)
	    06h end of data
	DL = received character
SeeAlso: AX=2406h
--------N-172408-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - RECEIVE BLOCK, WITH HANDSHAKE
	AX = 2408h
Return: AL = status (see also #00640)
	    06h end of data
	CX = number of bytes in receive buffer
	DX:SI -> receive buffer
SeeAlso: AX=2401h,AX=2405h,AX=2409h
--------N-172409-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - TRANSMIT COMMAND, WITH HANDSHAKE
	AX = 2409h
	BX = target address
	CX = number of data bytes
	DL = command code to send
	DS:SI -> data bytes for command
Return: AL = status (see also #00640)
	    03h no response
	    06h remote currently unable to perform command
SeeAlso: AX=2405h,AX=2408h
--------N-17240A-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - PREPARE CHARACTER-ORIENTED TRANSMIT
	AX = 240Ah
Return: AL = status (see #00640)
SeeAlso: AX=2406h,AX=240Bh,AX=240Ch
--------N-17240B-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - TRANSMIT SINGLE CHARACTER TO REMOTE
	AX = 240Bh
	DL = character to send
Return: AL = status (see also AX=2400h)
	    03h transmission error
	    06h write error
SeeAlso: AX=2407h,AX=240Ah,AX=240Ch
--------N-17240C-----------------------------
INT 17 - Shamrock Software NET.24 v3.11+ - END CHARACTER-ORIENTED TRANSMIT
	AX = 240Ch
Return: AL = status (see also AX=2400h)
	    03h transmission error
	    06h remote breaks connection
SeeAlso: AX=240Ah,AX=240Bh
--------p-174B00-----------------------------
INT 17 - Brother P-Touch - INSTALLATION CHECK
	AX = 4B00h
Return:	AX = 4249h ('BI' = Brother International) if installed
	    BX = program ID
		4550h ('EP') for "Epson FX-80 Emulator"
		5047h ('PG') for "Printer to Disk Utility"
	    CX = numbero of parallel port being emulated or intercepted
SeeAlso: AX=4B01h
--------p-174B01-----------------------------
INT 17 - Brother P-Touch - UNINSTALL
	AX = 4B01h
Return: AX = segment of resident program or 0000h if unable to uninstall
Note:	the calling program must manually free both the indicated segment
	  and the environment segment for the TSR with INT 21/AH=49h
	  (the environment is pointed at by the WORD at AX:002Ch)
SeeAlso: AX=4B00h,INT 21/AH=49h
--------J-175000-----------------------------
INT 17 - AX (Japanese AT) PRINTER - SET PRINTER COUNTRY CODE
	AX = 5000h
	BX = country code
	    0001h USA (English), 0051h Japan
Return: AL = status
	    00h successful
	    01h bad country code
	    02h other error
SeeAlso: AX=5001h,AH=51h,INT 10/AX=5000h,INT 16/AX=5000h
--------J-175001-----------------------------
INT 17 - AX (Japanese AT) PRINTER - GET PRINTER COUNTRY CODE
	AX = 5001h
Return: AL = status
	    00h successful
		BX = country code
	    02h error
SeeAlso: AX=5000h,AH=51h,INT 10/AX=5001h,INT 16/AX=5001h
--------J-1751-------------------------------
INT 17 - AX (Japanese AT) PRINTER - JIS to Shift-JIS CONVERSION
	AH = 51h
	DX = 2-byte JIS code
Return: DX = shift-JIS value or 0000h on error
Note:	one of AH=51h and AH=52h converts from JIS (Japanese Industry Standard)
	  characters to Shift-JIS characters, and the other performs the
	  opposite conversion
SeeAlso: AX=5000h,AH=52h
--------J-1752-------------------------------
INT 17 - AX (Japanese AT) PRINTER - Shift-JIS to JIS CONVERSION
	AH = 52h
	DX = 2-byte shift-JIS code
Return: DX = JIS code or 0000h on error
Note:	one of AH=51h and AH=52h converts from JIS (Japanese Industry Standard)
	  characters to Shift-JIS characters, and the other performs the
	  opposite conversion
SeeAlso: AH=51h
--------P-175555BXAAAA-----------------------
INT 17 - LR - SET CONFIGURATION
	AX = 5555h
	BX = AAAAh
	CL = configuration flags (see #04117)
	DX = LPT number
Return: AX = A55Ah
	BX = BBBBh
Program: LR_xxxx.COM files are a set of printer-hardware dependent printer
	  drivers found in the LIR DOS/Windows 3.xx codepage support package
	  develoved by LABAS u.a.b.  LIR supports several different screen and
	  printer codepages and various keyboard layouts used in Lithuania.
	  Download at: ftp://ftp.labas.com/pub/drivers/language/lir422.zip
SeeAlso: AX=5555h/BX=BBBBh,INT 10/AX=5555h/BX=AAAAh

Bitfields for LR_xxxx.COM configuration flags:
Bit(s)	Description	(Table 04117)
 7	ESC sequence???
 6	ESC sequence???
 5-3	printer code page
 2	Lithuanian alphabet???
 1	Russian alphabet???
 0	???
--------P-175555BXBBBB-----------------------
INT 17 - LR - GET CONFIGURATION
	AX = 5555h
	BX = BBBBh
	DX = LPT number
Return: AX = A55Ah
	BX = CCCCh
	CL = configuration flags (see #04117)
SeeAlso: AX=5555h/BX=AAAAh,INT 10/AX=5555h/BX=BBBBh
--------V-1760-------------------------------
INT 17 - FLASHUP.COM - INSTALLATION CHECK
	AH = 60h
Return: AL = 60h
	DX = CS of resident code
Notes:	FLASHUP.COM is part of Flash-Up Windows by The Software Bottling Co.
	FLASHUP also hooks INT 10 and receives commands via INT 10/AH=09h,0Ah
	  consisting of an 80h followed by the actual command
SeeAlso: INT 10/AH=09h,INT 10/AH=0Ah
--------V-1761-------------------------------
INT 17 - SPEEDSCR.COM - INSTALLATION CHECK
	AH = 61h
Return: AL = 61h
	DX = CS of resident code
Note:	SPEEDSCR.COM is by The Software Bottling Co.
--------P-1762-------------------------------
INT 17 U - T2PS v1.0 - UNINSTALL
	AH = 62h
Return: nothing
SeeAlso: AH=63h,AH=64h,INT 05/AX=554Eh
--------P-1763-------------------------------
INT 17 U - T2PS v1.0 - SET PARAMETERS
	AH = 63h
	ES:SI -> settings (see #00641)
Program: T2PS is a shareware ASCII-to-PostScript converter by A.N.D.
	  Technologies
SeeAlso: AH=62h,AH=64h,INT 05/AX=4E57h

Format of T2PS settings:
Offset	Size	Description	(Table 00641)
 00h	WORD	LPT port number (0=LPT1, etc.)
 02h	WORD	page heigh in points
 04h	WORD	page width in points
 06h	WORD	top margin in points
 08h	WORD	bottom margin in points
 0Ah	WORD	left margin in points
 0Ch	WORD	right margin in points
 0Eh	WORD	font size in points
 10h	WORD	tab size
 12h	WORD	timeout in clock ticks
--------P-1764-------------------------------
INT 17 U - T2PS v1.0 - GET PARAMETERS
	AH = 64h
	ES:SI -> buffer for settings (see #00641)
Return: ES:SI buffer filled
SeeAlso: AH=62h,AH=63h,INT 05/AX=5053h
--------b-176F00BX0000-----------------------
INT 17 - HP Vectra - EXTENDED BIOS - "F17_INQUIRE" - INSTALLATION CHECK
	AX = 6F00h
	BX = 0000h
Return: BX = 4850h ("HP") if HP Extended BIOS printer extensions available
SeeAlso: AX=6F02h,INT 14/AX=6F00h,INT 10/AX=6F00h,INT 14/AX=6F00h
SeeAlso: INT 33/AX=6F00h,INT 6F/AH=00h"HP Vectra"
--------b-176F02-----------------------------
INT 17 - HP Vectra - EXTENDED BIOS - "F17_PUT_BUFFER" - PRINT BUFFER
	AX = 6F02h
	CX = size of buffer in bytes
	DX = port number (0-3)
	ES:DI -> buffer containing characters to be printed
Return: AH = printer status (see #00631)
	CX = number of bytes successfully printed
	---on error (AH bit 0 set)---
	    ES:DI -> next byte to be sent
	---if successful---
	    ES:DI unchanged
SeeAlso: AH=00h,AX=6F00h,INT 14/AX=6F02h
----------1780-------------------------------
INT 17 - IBM SurePath BIOS - Officially "Private" Function
	AH = 80h
SeeAlso: AH=03h"IBM",AH=0Bh"IBM"
--------N-1781-------------------------------
INT 17 - Alloy NTNX, MW386 - CANCEL JOBS FOR CURRENT USER
	AH = 81h
	AL = 00h (NTNX compatibility mode)
	CL = number of jobs to cancel
Return: AL = status (see #00642)
Note:	this function cancels the last CL printouts for the current task
SeeAlso: AH=82h

(Table 00642)
Values for Alloy status:
 00h	success
 01h-7Fh warning
 80h	general failure
 81h	host overloaded (NTNX only)
 82h	module busy (NTNX only)
 83h	host busy (NTNX only)
 84h	re-entry flag set
 85h	invalid request
 86h	invalid printer
 87h	invalid process ID
 89h	access denied
 8Ah	option not available for given port type
 8Bh	option not available for given task type
 91h	printer busy
 C2h	file not found
 C3h	path not found
 C4h	file access failure
--------N-1782-------------------------------
INT 17 - Alloy NTNX, MW386 - CANCEL ALL JOBS FOR CURRENT USER
	AH = 82h
	AL = 00h (NTNX compatibility mode)
Return: AL = status (see #00642)
SeeAlso: AH=81h
--------N-1783-------------------------------
INT 17 - Alloy NTNX, MW386 - SET NUMBER OF COPIES
	AH = 83h
	AL = mode
	    00h NTNX compatibility
		CL = number of copies (max 99, default 1)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		CX = number of copies
Return: AL = status (see #00642)
Note:	in NTNX compatibility mode, this function only affects LPT1
--------N-1784-------------------------------
INT 17 - Alloy NTNX, MW386 - GENERATE PRINT BREAK
	AH = 84h
	AL = mode
	    00h NTNX compatibility
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
Note:	closes spool file and tells spooler to queue the print job (LPT1 only
	  under MW386 in NTNX compatibility mode)
--------J-1784-------------------------------
INT 17 - AX (Japanese AT) PRINTER - OUTPUT CHARACTER WITHOUT CONVERSION
	AH = 84h
	AL = character
	DX = printer number
Return: AH = printer status (see #00631)
SeeAlso: AH=00h,AH=85h
--------J-1785-------------------------------
INT 17 - AX (Japanese AT) PRINTER - ENABLE/DISABLE CHARACTER CONVERSION
	AH = 85h
	AL = new state (00h enabled, 01h disabled)
SeeAlso: AH=84h"AX"
--------N-1787-------------------------------
INT 17 - Alloy NTNX - SET INDOS POINTER
	AH = 87h
	AL = 00h
	CX:BX -> buffer for user-written printer drivers
Return: BX,CX destroyed
Note:	must be executed before the printer is enabled
SeeAlso: AH=8Ah
--------N-1788-------------------------------
INT 17 - Alloy NTNX, MW386 - REMOVE PRINTER FROM SPOOLER
	AH = 88h
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see #00643)
	    01h MW386
		DX = MW386 printer number
Return: AH = status (see #00642)
Note:	removes specified printer from the spooler's list of printers
SeeAlso: AH=89h,AH=8Bh

(Table 00643)
Values for Alloy NTNX printer number:
 00h	host LPT1
 01h	host LPT2
 02h	host LPT3
 03h	host LPT4
 04h	host COM1
 05h	host COM2
 06h	user's logical COM2
 07h	user's terminal AUX port
 08h	user's logical COM1 (MW386 only)
--------N-1789-------------------------------
INT 17 - Alloy NTNX, MW386 - ADD PRINTER TO SPOOLER
	AH = 89h
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see #00643)
	    01h MW386
		DX = MW386 printer number
Return: AL = status (see #00642)
Note:	the specified printer is added to the spooler's list of available
	  printers
SeeAlso: AH=88h,AH=8Bh
--------N-178A-------------------------------
INT 17 - Alloy NTNX - ACTIVATE USER-WRITTEN PRINTER DRIVER
	AH = 8Ah
	???
SeeAlso: AH=92h
--------N-178B-------------------------------
INT 17 - Alloy MW386 - GET PHYSICAL DEVICE NUMBER FROM NAME
	AH = 8Bh
	DS:DX -> ASCIZ printer name
Return: AL = status (see also AH=81h)
	    00h successful
		DX = physical device number
SeeAlso: AH=89h,AH=8Ch,INT 14/AH=20h"Alloy"
--------N-178C-------------------------------
INT 17 - Alloy MW386 - GET DEVICE NAME FROM PHYSICAL DEVICE NUMBER
	AH = 8Ch
	DX = physical device number
	ES:DI -> 17-byte buffer for ASCIZ device name
Return: AL = status (see also AH=81h)
	    00h successful
		ES:DI buffer filled
SeeAlso: AH=88h,AH=8Bh
--------N-178D-------------------------------
INT 17 - Alloy NTNX,MW386 - RESET SPOOLER
	AH = 8Dh
	AL = 00h
Return: AL = status (see #00642)
Notes:	clears all buffers and resets spooler to boot-up values
	MW386 supports this function for compatibility only; it is a NOP
--------N-178E-------------------------------
INT 17 - Alloy NTNX - GET INT 28 ENTRY POINT
	AH = 8Eh
	AL = 00h
Return: CX:BX -> INT 28 entry point
SeeAlso: AH=8Fh
--------N-178F-------------------------------
INT 17 - Alloy NTNX - GET DOS INTERCEPT ENTRY POINT
	AH = 8Fh
	AL = 00h
Return: CX:BX -> DOS intercept routine
SeeAlso: AH=8Eh
--------N-1790-------------------------------
INT 17 - Alloy NTNX, MW386 - SPOOL FILE BY NAME
	AH = 90h
	AL = mode
	    00h NTNX compatibility
		DL = printer code (FFh=current) (NTNX, MW386 v1.x only)
		DH = number of copies (FFh=current) (NTNX, MW386 v1.x only)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
	CX:SI -> ASCIZ pathname
Return: AL = status (see #00642)
Note:	in mode 00h, the file is always sent to logical LPT1
SeeAlso: AH=A0h
--------N-1791-------------------------------
INT 17 - Alloy NTNX, MW386 - GET USER NUMBER AND CURRENT PRINTER
	AH = 91h
	AL = mode
	    00h NTNX compatibility
		Return: CX = user number (00h = host)
			DX = currently selected printer number (00h-08h)
	    01h MW386
		Return: CX = user number
			DX = physical dev number of currently selected printer
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		Return: CX = user number
			DX = physical device number
Return: AL = status (see #00642)
SeeAlso: AH=8Ch
--------N-1792-------------------------------
INT 17 - Alloy NTNX - CHECK PRINTER DRIVER
	AH = 92h
	AL = 00h
	CL = 00h
Return: CL = driver state
	    01h initialized
	    80h not initialized
	AX = status (see #00642)
SeeAlso: AH=8Ah
--------N-1794-------------------------------
INT 17 - Alloy NTNX, MW386 - SELECT PRINTER
	AH = 94h
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see #00643)
	    01h MW386
		DX = MW386 printer number
	    02h MW386 v2+
		BX = logical printer number
		DX = MW386 printer number
Return: AL = status (see #00642)
Note:	modes 00h and 01h affect only logical LPT1
SeeAlso: AH=8Bh,AH=95h
--------N-1795-------------------------------
INT 17 - Alloy NTNX, MW386 - GET CURRENT PRINTER
	AH = 95h
	AL = mode
	    00h NTNX compatibility
		Return: DX = NTNX printer number (see #00643)
			    (FFFFh if current printer not compatible with NTNX)
	    01h MW386
		Return: DX = MW386 printer number
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		Return: DX = MW386 printer number (FFFFh = none)
Return: AL = status (see #00642)
Note:	modes 00h and 01h return the printer number of logical LPT1 only
SeeAlso: AH=94h
--------N-1796-------------------------------
INT 17 - Alloy NTNX - SET SERIAL PORT PARAMETERS
	AH = 96h
	AL = 00h
Note:	documentation states that this is a NOP, doing only XOR AX,AX before
	  returning
SeeAlso: INT 14/AH=24h
--------N-1797-------------------------------
INT 17 - Alloy NTNX, MW386 - SET DATA DRIVEN PRINT BREAK
	AH = 97h
	AL = mode
	    00h NTNX compatibility
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
	CH,CL,DH = three character break sequence
	DL = subfunction
	    00h set break string
	    else reset break
Return: AL = status (see #00642)
Notes:	mode 00h affects only logical LPT1
	when the break string is encountered, the spool file will be closed and
	  queued for printing automatically
	the break string is not permanently saved, and will be reset each time
	  MW386 or the user is rebooted
SeeAlso: AH=9Bh
--------N-1798-------------------------------
INT 17 - Alloy NTNX,MW386 - RESTART PRINTER
	AH = 98h
	AL = 00h
	DL = printer number (FFh=current)
Return: AL = status
	    00h successful
	    01h incorrect printer
	    02h task not found
Note:	MW386 supports this function for compatibility only; it is a NOP
--------N-1799-------------------------------
INT 17 - Alloy NTNX, MW386 - GET/SET PRINTER MODE
	AH = 99h
	AL = mode
	    00h NTNX compatibility
		DL = NTNX printer number (see #00643)
			(FFh = task's current logical LPT1)
		DH = mode (see #00644)
	    01h MW386
		DX = MW386 printer number
		CL = mode (as for DH above)
Return: AL = status (see #00642)
	DH = mode (bits 1 and 2 set as above)
	DL = printer owner's user number if not spooled

Bitfields for Alloy printer mode:
 0	get mode if 1, set mode if 0	(Table 00644)
 1	private ("attached")
 2	direct instead of spooled
 3-7	reserved (0)
--------N-179A-------------------------------
INT 17 - Alloy NTNX,MW386 - SET TAB EXPANSION
	AH = 9Ah
	AL = mode
	    00h NTNX compatibility
		DX = NTNX printer number (see #00643)
			(FFFFh = current logical LPT1)
	    01h MW386
		DX = MW386 printer number
	CL = tab length (00h = no expansion, 01h-63h = spaces per tab)
Return: AL = status (see #00642)
Note:	beginning with MW386 v2.0, tab expansion is set on a per-printer basis
	  rather than a per-user basis; NTNX and MW386 v1.x ignore DX
SeeAlso: AH=A4h
--------N-179B-------------------------------
INT 17 - Alloy NTNX,MW386 - SET PRINT BREAK TIMEOUT
	AH = 9Bh
	AL = mode
	    00h NTNX compatibility
		CX = timeout value in clock ticks (1/18 sec) (00h = never)
	    01h MW386
		CX = timeout value in seconds (00h = never)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
		CX = timeout value in seconds (00h = never)
Return: AL = status (see #00642)
Notes:	modes 00h and 01h affect only the current logical LPT1
	if no data is sent to a printer for the specified amount of time, the
	  spool file will be closed and queued for printing automatically
SeeAlso: AH=97h
--------N-17A0-------------------------------
INT 17 - Alloy MW386 - SPOOL COPY OF FILE
	AH = A0h
	AL = mode
	    00h NTNX compatibility
		DX = ??? (NTNX, MW386 v1.x only)
	    02h MW386 v2+
		BX = logical device number
		    00h-03h = LPT1-LPT4
		    04h-07h = COM1-COM4
	CX:SI -> ASCIZ pathname
Return: AL = status (see #00642)
Notes:	makes a copy of the specified file in the spooler's directory, allowing
	  the original file to be modified or deleted while the copy is printed
	in mode 00h, the file is printed on logical LPT1
SeeAlso: AH=90h
--------N-17A4-------------------------------
INT 17 - Alloy MW386 - ENABLE/DISABLE FORM FEED
	AH = A4h
	AL = new state
	    00h form feed after end of print job disabled
	    01h form feed enabled
Return: AL = status (see #00642)
Note:	only affects the current logical LPT1
SeeAlso: AH=9Ah,AH=A6h,INT 7F/AH=05h"NTNX (Host)"
--------N-17A6-------------------------------
INT 17 - Alloy MW386 - ENABLE/DISABLE BANNER PAGE
	AH = A6h
	AL = new state
	    00h banner page before print job disabled
	    01h banner page enabled
Return: AL = status (see #00642)
Note:	only affects the current logical LPT1
SeeAlso: AH=A4h
--------N-17A7-------------------------------
INT 17 - Alloy MW386 v2+ - GET/SET SPOOL FLAGS
	AH = A7h
	AL = spool flags (see #00645)
	BX = logical device number
	    00h-03h = LPT1-LPT4
	    04h-07h = COM1-COM4
Return: AL = status (see #00642)
Note:	the documentation does not state which register contains the result of
	  a GET
SeeAlso: AH=A4h,AH=A6h

Bitfields for Alloy spool flags:
Bit(s)	Description	(Table 00645)
 0	banner page enabled (see AH=A6h)
 1	form feed enabled (see AH=A4h)
 2-6	reserved (0)
 7	set flags if 1, get flags if 0
--------N-17A8-------------------------------
INT 17 - Alloy MW386 - DEFINE TEMPORARY FILENAME
	AH = A8h
	CX:SI -> ASCIZ filename without extension (max 8 chars)
Return: AL = status (see #00642)
Note:	allows application to specify banner page filename for spool files
	  collected from the application's printer output
SeeAlso: AH=A9h
--------N-17A9-------------------------------
INT 17 - Alloy MW386 - CHANGE TEMPORARY SPOOL DRIVE
	AH = A9h
	AL = new spool drive (2=C:,3=D:,etc)
Return: AL = status (see #00642)
Note:	does not remove previous spooling directory since jobs may be pending
SeeAlso: AH=A8h
--------N-17AA-------------------------------
INT 17 - Alloy MW386 v2+ - GET REAL-TIME PRINTER STATUS
	AH = AAh
	AL = mode
	    00h NTNX
		DX = NTNX printer number (see #00643)
	    01h MW386
		DX = MW386 printer number
Return: AH = instantaneous printer status
	    00h printer ready
	    01h not ready
	    12h off line
	    13h out of paper
	    14h general device failure
	    15h device timeout
	    16h bad device number
--------N-17AF-------------------------------
INT 17 - Alloy MW386 - CHECK SPOOLER
	AH = AFh
Return: AX = 55AAh if spooler available
--------c-17C0-------------------------------
INT 17 - PC Magazine PCSpool - GET CONTROL BLOCK ADDRESS
	AH = C0h
	DX = printer port (0-3)
Return: ES:BX -> control block (see #00646)
SeeAlso: AH=C1h

Format of PCSpool control block:
Offset	Size	Description	(Table 00646)
 00h	WORD	printer number
 02h	WORD	address of printer status port
 04h	WORD	number of first record in queue
 06h	WORD	number of last record in queue
 08h	DWORD	characters already printed
 0Ch	DWORD	number of characters remaining
 10h	DWORD	pointer to dequeue buffer
 14h	DWORD	previous count of characters printed
 18h	DWORD	number of clock ticks taken to print them
 1Ch	WORD	offset of next character to output
 1Eh	WORD	offset of next character to print
 20h	WORD	pointer to spooling queue record
 22h	BYTE	current spooling status
 23h	BYTE	current printer status:
		00h OK
		01h not ready
		02h paused with message
		03h paused
		04h initializing
		FEh non-existent port
		FFh not spooled
 24h	BYTE	current control record type
 25h	WORD	observed printer speed
 27h	WORD	characters to print per service
 29h	BYTE	01h if disk write needed
 2Ah	BYTE	01h if queued data should be flushed
 2Bh	BYTE	01h to update cps status
--------c-17C1--------------------------------
INT 17 - PC Magazine PCSpool - BUILD PAUSE CONTROL RECORD
	AH = C1h
	DX = printer port (0-3)
	DS:SI -> ASCIZ string to save for display
Note:	flushes pending writes
SeeAlso: AH=C0h,AH=C2h
--------c-17C2-------------------------------
INT 17 - PC Magazine PCSpool - FLUSH PENDING WRITES
	AH = C2h
	DX = printer port (0-3)
SeeAlso: AH=C3h
--------c-17C3-------------------------------
INT 17 - PC Magazine PCSpool - CANCEL PRINTER QUEUE (FLUSH ALL QUEUED OUTPUT)
	AH = C3h
	DX = printer port (0-3)
SeeAlso: AH=C2h,AH=C7h
--------c-17C4-------------------------------
INT 17 - PC Magazine PCSpool - QUERY SPOOLER ACTIVE
	AH = C4h
Return: DI = B0BFh
	SI = segment
--------c-17C5-------------------------------
INT 17 - PC Magazine PCSpool - JOB SKIP PRINTER QUEUE
	AH = C5h
	DX = printer port (0-3)
Note:	cancels up to the pause record
--------c-17C6-------------------------------
INT 17 - PC Magazine PCSpool - CHECK PRINTER QUEUE STATUS
	AH = C6h
	DX = printer port (0-3)
Return: AX = queue status
	   0000h printer not active or at pause
	   0001h printer busy
--------c-17C7-------------------------------
INT 17 - PC Magazine PCSpool - CLOSE QUEUE
	AH = C7h
	DX = printer port (0-3)
SeeAlso: AH=C3h
--------P-17CD00-----------------------------
INT 17 - INSET - EXECUTE COMMAND STRING
	AX = CD00h
	DS:DX -> ASCIZ command string (max 80 bytes)
Return: CX = 07C2h (1986d)
Note:	user interface menus pop up after last command, unless that command
	exits INSET
--------P-17CD01-----------------------------
INT 17 - INSET - GET IMAGE SIZE
	AX = CD01h
	DS:DX -> ASCIZ name of image file
Return: AX = height in 1/720th inch
	BX = width in 1/720th inch
	CX = 07C2h (1986d)
--------P-17CD02-----------------------------
INT 17 - INSET - INITIALIZE
	AX = CD02h
Return: CX = 07C2h (1986d)
Note:	all open files are closed and the printer is reset
SeeAlso: AX=CD04h
--------P-17CD03-----------------------------
INT 17 - INSET - EXECUTE INSET MENU WITHIN OVERRIDE MODE
	AX = CD03h
Return: CX = 07C2h (1986d)
--------P-17CD04-----------------------------
INT 17 - INSET - INITIALIZE LINKED MODE
	AX = CD04h
	ES:SI -> FAR routine for linked mode (see #00647)
Return: CX = 07C2h
SeeAlso: AX=CD02h,AX=CD08h

(Table 00647)
Values INSET linked-mode routine is called with:
	AL = function
	    00h send character to printer
		BL = character to send
	    01h send string to printer
		CX = number of bytes to send
		DS:DX -> buffer containing data
	    02h move print head to horizontal starting position of image
Return: AX = status
	    0000h success
	    0001h failure
--------P-17CD05-----------------------------
INT 17 - INSET - START MERGING IMAGE INTO TEXT
	AX = CD05h
	DS:DX -> ASCIZ name of PIX file
	CX = left margin of text in 1/720th inch
Return: AH = printer type
	    00h page-oriented (multiple images may be placed side-by-side)
	    01h line-oriented (use AX=CD06h for vertical paper movement)
	CX = 07C2h (1986d)
SeeAlso: AX=CD07h
--------P-17CD06-----------------------------
INT 17 - INSET - GRAPHICS LINE FEED
	AX = CD06h
Return: AH = completion status
	    00h image complete
	    01h image incomplete
	CX = 07C2h (1986d)
SeeAlso: AX=CD09h
--------P-17CD07-----------------------------
INT 17 - INSET - FLUSH GRAPHICS FROM MERGE BUFFER
	AX = CD07h
Return: CX = 07C2h
SeeAlso: AX=CD05h
--------P-17CD08-----------------------------
INT 17 - INSET - CANCEL LINK MODE
	AX = CD08h
Return: CX = 07C2h
SeeAlso: AX=CD04h
--------P-17CD09-----------------------------
INT 17 - INSET - ALTER TEXT LINE SPACING
	AX = CD09h
	CX = line spacing in 1/720th inch
Return: CX = 07C2h
Note:	not yet implemented, line spacing is currently fixed at 1/6 inch
SeeAlso: AX=CD06h
--------P-17CD0A-----------------------------
INT 17 - INSET - GET SETUP
	AX = CD0Ah
	DS:DX -> buffer for IN.SET data
Return: CX = 07C2h
--------P-17CD0B-----------------------------
INT 17 - INSET - START GETTING SCALED IMAGE
	AX = CD0Bh
	DS:SI -> ASCIZ pathname of .PIX file
	BX = number of bitplanes
	CX = number of rows in output bitmap
	DX = number of columns in output bitmap
Return: AX = status
	    0000h OK
	    FFFFh error
Note:	image is returned in strips by repeated calls to AX=CD0Ch
--------P-17CD0C-----------------------------
INT 17 - INSET - GET NEXT IMAGE STRIP
	AX = CD0Ch
Return: AX = status
	    0000h OK but not complete
	    0001h OK and image complete
	    FFFFh error
	DS:SI -> buffer (max 4K) for bit map strip
	CX = start row
	DX = number of rows
	BX = offset in bytes between bit planes
Note:	buffer may be overwritten by subsequent calls
SeeAlso: AX=CD0Bh
--------P-17E0-------------------------------
INT 17 - EPP BIOS - INSTALLATION CHECK
	AH = E0h
Return: ??? (AH <> E0h if installed ???)
SeeAlso: AX=0200h"EPP",AH=E1h,AH=E2h
--------P-17E1-------------------------------
INT 17 - EPP BIOS - DISABLE EPP
	AH = E1h
	???
Return: ???
SeeAlso: AX=0200h"EPP",AH=E0h,AH=E2h
--------P-17E2-------------------------------
INT 17 - EPP BIOS - ENABLE EPP
	AH = E2h
	???
Return: ???
SeeAlso: AX=0200h"EPP",AH=E0h,AH=E1h
--------P-17F0-------------------------------
INT 17 - NorthNet Jetstream API - INSTALLATION CHECK
	AH = F0h
	DX = printer port (0-3)
Return: AX = 0001h Jetstream present
	     else  non-Jetstream port
Note:	NorthNet Jetstream is a high-performance DMA-driven parallel card able
	  to drive printers at up to 80000 characters per second
--------P-17F1-------------------------------
INT 17 - NorthNet Jetstream API - PRINT DATA BUFFER
	AH = F1h
	CX = data buffer length
	DX = printer port (0-3)
	DS:SI -> data buffer
Return: AX = status
	    0000h printer not ready (see also AH=02h)
	    other printing started
SeeAlso: AH=00h,AH=F2h,AH=F3h,AH=F5h
--------P-17F2-------------------------------
INT 17 - NorthNet Jetstream API - GET PRINT PROGRESS STATUS
	AH = F2h
	DX = printer port (0-3)
Return: AX = status
	    0000h prior print request finished
	    other number of characters left to print
SeeAlso: AH=02h,AH=F1h,AH=F3h
--------P-17F3-------------------------------
INT 17 - NorthNet Jetstream API - ABORT PRINT OPERATION
	AH = F3h
	DX = printer port (0-3)
Return: AX = number of unprinted characters due to abort
SeeAlso: AH=F1h,AH=F4h
--------P-17F4-------------------------------
INT 17 - NorthNet Jetstream API - SET COMPLETION (POST) ADDRESS
	AH = F4h
	DX = printer port (0-3)
	DS:DS -> FAR post address (called with interrupts on)
SeeAlso: AH=F1h,AH=F3h
--------P-17F5-------------------------------
INT 17 - NorthNet Jetstream API - PRINT DATA BUFFER FROM EXTENDED MEMORY
	AH = F5h
	CX = data buffer length
	DX = printer port (0-3)
	DS:SI -> data buffer (32-bit physical address)
Return: AX = status
	    0000h printer not ready (see also AH=02h)
	    other printing started
SeeAlso: AH=F1h
--------c-17FF--BX0000-----------------------
INT 17 U - PC-MOS/386 v5.01 - PRINT SPOOLER - CLOSE SPOOL FILE
	AH = FFh
	BX = 0000h
	CX = 0000h
	DX = printer port number
Return: AH = printer status (see #00631 at AH=00h)
Program: PC-MOS/386 v5.01 is a multitasking, multiuser MS-DOS 5.0-compatible
	  operating system by The Software Link, Inc.
Desc:	close the spool file immediately instead of waiting for the close time
	  to elapse
SeeAlso: AH=01h,AH=03h"PC-MOS"
--------B-18---------------------------------
INT 18 - DISKLESS BOOT HOOK (START CASSETTE BASIC)
Desc:	called when there is no bootable disk available to the system
Notes:	very few PCs other than those produced by IBM contain BASIC in ROM, so
	  the action is unpredictable on compatibles; this interrupt often
	  reboots the system, and often has no effect at all
	some PC and XT clones had an optional IBM CASSETTE BASIC stored
	  in the ROM, too.
	most BIOSes will display an error message similar to "NO BASIC", and
	  either reboot or return to the caller.
	PS/2 machines usually pop up a graphical box to the effect that
	  the user should enter a floppy and press F1.
	Some clones display the message "No boot device available,
	  strike F1 to retry, F2 for setup utility"
	network cards with their own BIOS can hook this interrupt to allow
	  a diskless boot off the network (even when a hard disk is present
	  if none of the partitions is marked as the boot partition)
SeeAlso: INT 2F/AX=4A06h,INT 86"NetBIOS",INT 2F/AX=4A06h,INT 2F/AX=4A07h
--------J-1800-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - GET KEYSTROKE
	AH = 00h
Return: AX = keystroke
SeeAlso: AH=01h,AH=02h,INT 16/AH=00h
--------J-1801-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - CHECK FOR KEYSTROKE
	AH = 01h
Return: BH = status
	    00h no keystrokes available
	    01h keystroke available
		AX = keystroke
SeeAlso: AH=00h,AH=02h,INT 16/AH=01h
--------J-1802-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - GET SHIFT STATUS
	AH = 02h
Return: AL = shift flags
SeeAlso: AH=00h,AH=02h,AH=03h,AH=04h,INT 16/AH=02h
--------J-1803-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - INITIALIZE
	AH = 03h
	???
Return: ???
SeeAlso: AH=00h,AH=04h
--------J-1804-------------------------------
INT 18 - NEC PC-9800 series - KEYBOARD - KEY PRESSED
	AH = 04h
	???
Return: ???
Note:	details are not available at this time
SeeAlso: AH=00h,AH=02h,INT 16/AH=00h,INT 16/AH=01h,INT 16/AH=02h
--------J-18---------------------------------
INT 18 - NEC PC-9800 series - VIDEO
	AH = function
	    0Ah set video mode
	    0Bh get video mode
	    0Ch start text screen display
	    0Dh end text screen display
	    0Eh set single display area
	    0Fh set multiple display area
	    10h set cursor shape
	    11h display cursor
	    12h terminate cursor
	    13h set cursor position
	    14h read font patter
	    16h initialize text video RAM
	    1Ah define user character
	    others
	???
Return: ???
Notes:	details are not available at this time
	text video RAM is located at segments A000h (characters) and A200h
	  (attributes), graphics video RAM at segment C000h

Bitfields for NEC PC-9800 series video attributes:
Bit(s)	Description	(Table 00648)
 0	disable drawing character
 1	blinking
 2	reverse video
 3	underline
 4	vertical line
 7-5	color
	(0=black, 1=blue, 2=red, 3=purple, 4=green, 5=cyan, 6=yellow, 7=white)
--------J-180E-------------------------------
INT 18 - NEC PC-9800 series - SET SINGLE DISPLAY AREA
	AH = 0Eh
	DX = offset of first byte to display???
Return: ???
SeeAlso: AH=1Bh,MEM 0050h:0001h
--------J-181B-------------------------------
INT 18 - NEC PC-9800 series - SET DISPLAY MODE
	AH = 1Bh
	AL = ??? (00h for text mode)
Return: ???
--------r-185350BX4849-----------------------
INT 18 - SPHINX C-- - WB.COM - API
	AX = 5350h ('SP')
	BX = 4849h ('HI')
	CX = 4E58h ('NX')
	DH = function
	    01h set ???
		DL = ???
	    02h get ???
		Return: DL = ???
	    03h get ???
		Return: ES:DI -> ??? data buffer
	    06h ???
Return: AX = 7370h ('sp') if installed
	BX = 6869h ('hi') if installed
	CX = 6E78h ('nx') if installed
Program: SPHINX C-- is a shareware compiler by Peter Cellik for a language
	  which is a cross between C and assembler; WB.COM is the driver which
	  launches the WorkBench
--------s-186900-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - GET STATUS
	AX = 6900h
Return: AX = amount of DRAM on card or 0000h if GUS not available
Program: YEA_GUS is a driver for the Graphics Ultra Sound which hooks INT 18h
	  and then shells out the the program requiring its services
SeeAlso: AX=6901h,AX=690Ah,AX=690Bh
--------s-186901-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - RESET
	AX = 6901h
	BX = number of active voices (14-32)
Return: nothing
SeeAlso: AX=6900h
--------s-186902-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SET VOLUME FOR SPECIFIC VOICE
	AX = 6902h
	BX = voice number (00h-1Fh)
	CX = linear volume (0000h-01FFh)
Return: nothing
SeeAlso: AX=6900h,AX=6903h,AX=6904h,AX=6909h,AX=690Ah
--------s-186903-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SET FREQUENCY FOR VOICE
	AX = 6903h
	BX = voice number (00h-1Fh)
	CX = frequency in Hz (0-44100)
Return: nothing
SeeAlso: AX=6902h,AX=6904h
--------s-186904-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SET LEFT/RIGHT BALANCE
	AX = 6904h
	BX = voice number (00h-1Fh)
	CX = balance (0 = left, 7 = even, 15 = right)
Return: nothing
SeeAlso: AX=6902h,AX=6903h
--------s-186905-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - PLAY MUSIC
	AX = 6905h
	BL = voice number
	BH = sample type (0 = 8-bit, 1 = 16-bit)
	CL = looping type (0 = none, 1 = forward, 2 = back and forth)
	CH:DI = 20-bit starting address for voice data
	DL:SI = 20-bit address for loop start
	DH:BP = 20-bit address for loop end
SeeAlso: AX=6903h,AX=6906h,AX=690Bh
--------s-186906-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - LOAD SOUND DATA
	AX = 6906h
	BL = data format (1 = twos-complement, 0 = not)
	BH = sample type (0 = 8-bit, 1 = 16-bit)
	CX = number of bytes to send
	ES:SI -> buffer containing data
	DL:DI = 20-bit address of GUS DRAM at which to load sound data
SeeAlso: AX=6900h,AX=6905h,AX=690Ch
--------s-186907-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - STOP VOICE
	AX = 6907h
	BX = voice number (00h-1Fh)
Return: nothing
SeeAlso: AX=6908h,AX=690Dh
--------s-186908-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SET VOICE END
	AX = 6908h
	BX = voice number (00h-1Fh)
	CL:DX = 20-bit ending address
Return: nothing
SeeAlso: AX=690Bh
--------s-186909-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - RAMP VOLUME
	AX = 6909h
	BL = voice number (00h-1Fh)
	BH = looping type (0 = none, 1 = forward, 2 = back and forth)
	CX = starting volume
	DX = ending volume
	DI:SI = time
Return: nothing
SeeAlso: AX=6902h,AX=690Ah
--------s-18690A-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - GET VOLUME
	AX = 690Ah
	BX = voice number (00h-1Fh)
Return: AX = current non-linear volume for voice
SeeAlso: AX=6902h,AX=6909h
--------s-18690B-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - GET POSITION
	AX = 690Bh
	BX = voice number
Return: BX:AX = 20-bit address at which voice is playing
SeeAlso: AX=6900h,AX=6905h,AX=6908h
--------s-18690C-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - SAVE SOUND DATA
	AX = 690Ch
	BL = data format (1 = twos-complement, 0 = not)
	BH = sample type (0 = 8-bit, 1 = 16-bit)
	CX = number of bytes to get
	ES:SI -> buffer for retrieved data
	DL:DI = 20-bit address in GUS DRAM from which to read voice data
Return: nothing
SeeAlso: AX=6906h
--------s-18690D-----------------------------
INT 18 - Gravis Ultra Sound YEA_GUS.EXE - RESTART VOICE
	AX = 690Dh
	BX = voice
	CX = sample type (0 = 8-bit, 1 = 16-bit)
	DX = looping type (0 = none, 1 = forward, 2 = back and forth)
Return: CX = balance value
SeeAlso: AX=6907h,AX=6908h
--------s-188000-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - INITIALIZE
	AX = 8000h
Program: EURO_MOD is a .MOD file player for the Gravis Ultra Sound which hooks
	  INT 18h and then shells out to the program requiring its services
SeeAlso: AX=8001h,AX=8004h
--------s-188001-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - LOAD .MOD FILE
	AX = 8001h
	BX:CX -> ASCIZ filename
SeeAlso: AX=8000h,AX=8002h
--------s-188002-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - PLAY .MOD FILE
	AX = 8002h
SeeAlso: AX=8002h,AX=8003h
--------s-188003-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - STOP PLAYING
	AX = 8003h
--------s-188004-----------------------------
INT 18 - Gravis Ultra Sound EURO_MOD.EXE - SHUTDOWN
	AX = 8004h
SeeAlso: AX=8000h,AX=8003h
--------B-19---------------------------------
INT 19 - SYSTEM - BOOTSTRAP LOADER
Desc:	This interrupt reboots the system without clearing memory or restoring
	  interrupt vectors.  Because interrupt vectors are preserved, this
	  interrupt usually causes a system hang if any TSRs have hooked
	  vectors from 00h through 1Ch, particularly INT 08.
Notes:	Usually, the BIOS will try to read sector 1, head 0, track 0 from drive
	  A: to 0000h:7C00h.  If this fails, and a hard disk is installed, the
	  BIOS will read sector 1, head 0, track 0 of the first hard disk.
	  This sector should contain a master bootstrap loader and a partition
	  table (see #00650).  After loading the master boot sector at
	  0000h:7C00h, the master bootstrap loader is given control
	  (see #00653).	It will scan the partition table for an active
	  partition, and will then load the operating system's bootstrap
	  loader (contained in the first sector of the active partition) and
	  give it control.
	true IBM PCs and most clones issue an INT 18 if neither floppy nor hard
	  disk have a valid boot sector
	to accomplish a warm boot equivalent to Ctrl-Alt-Del, store 1234h in
	  0040h:0072h and jump to FFFFh:0000h.	For a cold boot equivalent to
	  a reset, store 0000h at 0040h:0072h before jumping.
	VDISK.SYS hooks this interrupt to allow applications to find out how
	  much extended memory has been used by VDISKs (see #00649).  DOS 3.3+
	  PRINT hooks INT 19 but does not set up a correct VDISK header block
	  at the beginning of its INT 19 handler segment, thus causing some
	  programs to overwrite extended memory which is already in use.
	the default handler is at F000h:E6F2h for 100% compatible BIOSes
	MS-DOS 3.2+ hangs on booting (even from floppy) if the hard disk
	  contains extended partitions which point at each other in a loop,
	  since it will never find the end of the linked list of extended
	  partitions
	under Windows Real and Enhanced modes, calling INT 19 will hang the
	  system in the same was as under bare DOS; under Windows Standard
	  mode, INT 19 will successfully perform a cold reboot as it appears
	  to have been redirected to a MOV AL,0FEh/OUT 64h,AL sequence
BUG:	when loading the remainder of the DOS system files fails, various
	  versions of IBMBIO.COM/IO.SYS incorrectly restore INT 1E before
	  calling INT 19, assuming that the boot sector had stored the
	  contents of INT 1E at DS:SI instead of on the stack as it actually
	  does
SeeAlso: INT 14/AH=17h,INT 18"BOOT HOOK",INT 49"Tandy 2000",INT 5B"PC Cluster"
SeeAlso: MEM 0040h:0067h,MEM F000h:FFF0h,CMOS 0Fh

Format of VDISK header block (at beginning of INT 19 handler's segment):
Offset	Size	Description	(Table 00649)
 00h 18 BYTEs	n/a (for VDISK.SYS, the device driver header)
 12h 11 BYTEs	signature string "VDISK	 Vn.m" for VDISK.SYS version n.m
 1Dh 15 BYTEs	n/a
 2Ch  3 BYTEs	linear address of first byte of available extended memory

Format of hard disk master boot sector:
Offset	Size	Description	(Table 00650)
 00h 446 BYTEs	Master bootstrap loader code
1BEh 16 BYTEs	partition record for partition 1 (see #00651)
1CEh 16 BYTEs	partition record for partition 2
1DEh 16 BYTEs	partition record for partition 3
1EEh 16 BYTEs	partition record for partition 4
1FEh	WORD	signature, AA55h indicates valid boot block

Format of partition record:
Offset	Size	Description	(Table 00651)
 00h	BYTE	boot indicator (80h = active partition)
 01h	BYTE	partition start head
 02h	BYTE	partition start sector (bits 0-5)
 03h	BYTE	partition start track (bits 8,9 in bits 6,7 of sector)
 04h	BYTE	operating system indicator (see #00652)
 05h	BYTE	partition end head
 06h	BYTE	partition end sector (bits 0-5)
 07h	BYTE	partition end track (bits 8,9 in bits 6,7 of sector)
 08h	DWORD	sectors preceding partition
 0Ch	DWORD	length of partition in sectors
SeeAlso: #00650

(Table 00652)
Values for operating system indicator:
 00h	empty partition-table entry
 01h	DOS 12-bit FAT
 02h	XENIX root file system
 03h	XENIX /usr file system (obsolete)
 04h	DOS 16-bit FAT (up to 32M)
 05h	DOS 3.3+ extended partition
 06h	DOS 3.31+ Large File System (16-bit FAT, over 32M)
 07h	QNX
 07h	OS/2 HPFS
 07h	Windows NT NTFS
 07h	Advanced Unix
 07h	see partition boot record; could be any of the above or others
 08h	OS/2 (v1.0-1.3 only)
 08h	AIX bootable partition, SplitDrive
 08h	Commodore DOS
 08h	DELL partition spanning multiple drives
 09h	AIX data partition
 09h	Coherent filesystem
 0Ah	OS/2 Boot Manager
 0Ah	OPUS
 0Ah	Coherent swap partition
 0Bh	Windows95 with 32-bit FAT
 0Ch	Windows95 with 32-bit FAT (using LBA-mode INT 13 extensions)
 0Eh	logical-block-addressable VFAT (same as 06h but using LBA-mode INT 13)
 0Fh	logical-block-addressable VFAT (same as 05h but using LBA-mode INT 13)
 10h	OPUS
 11h	OS/2 Boot Manager hidden 12-bit FAT partition
 12h	Compaq Diagnostics partition
 14h	(resulted from using Novell DOS 7.0 FDISK to delete Linux Native part)
 14h	OS/2 Boot Manager hidden sub-32M 16-bit FAT partition
 16h	OS/2 Boot Manager hidden over-32M 16-bit FAT partition
 17h	OS/2 Boot Manager hidden HPFS partition
 17h	hidden NTFS partition
 18h	AST special Windows swap file ("Zero-Volt Suspend" partition)
 19h	Willowtech Photon coS
 1Bh	hidden Windows95 FAT32 partition
 1Ch	hidden Windows95 FAT32 partition (using LBA-mode INT 13 extensions)
 1Eh	hidden LBA VFAT partition
 20h	Willowsoft Overture File System (OFS1)
 21h	officially listed as reserved
 21h	FSo2
 23h	officially listed as reserved
 24h	NEC MS-DOS 3.x
 26h	officially listed as reserved
 31h	officially listed as reserved
 33h	officially listed as reserved
 34h	officially listed as reserved
 36h	officially listed as reserved
 38h	Theos
 3Ch	PowerQuest PartitionMagic recovery partition
 40h	VENIX 80286
 41h	Personal RISC Boot
 41h	PowerPC boot partition
 42h	SFS (Secure File System) by Peter Gutmann
 45h	EUMEL/Elan
 46h	EUMEL/Elan
 47h	EUMEL/Elan
 48h	EUMEL/Elan
 4Fh	Oberon boot/data partition
 50h	OnTrack Disk Manager, read-only partition
 51h	OnTrack Disk Manager, read/write partition
 51h	NOVELL
 52h	CP/M
 52h	Microport System V/386
 53h	OnTrack Disk Manager, write-only partition???
 54h	OnTrack Disk Manager (DDO)
 55h	EZ-Drive (see also INT 13/AH=FFh"EZ-Drive")
 56h	GoldenBow VFeature
 5Ch	Priam EDISK
 61h	SpeedStor
 63h	Unix SysV/386, 386/ix
 63h	Mach, MtXinu BSD 4.3 on Mach
 63h	GNU HURD
 64h	Novell NetWare 286
 64h	SpeedStore
 65h	Novell NetWare (3.11)
 67h	Novell
 68h	Novell
 69h	Novell
 70h	DiskSecure Multi-Boot
 71h	officially listed as reserved
 73h	officially listed as reserved
 74h	officially listed as reserved
 75h	PC/IX
 76h	officially listed as reserved
 7Eh	F.I.X.
 80h	Minix v1.1 - 1.4a
 81h	Minix v1.4b+
 81h	Linux
 81h	Mitac Advanced Disk Manager
 82h	Linux Swap partition
 82h	Prime
 82h	Solaris (Unix)
 83h	Linux native file system (ext2fs/xiafs)
 84h	OS/2-renumbered type 04h partition (related to hiding DOS C: drive)
 85h	Linux EXT
 86h	FAT16 volume/stripe set (Windows NT)
 87h	HPFS Fault-Tolerant mirrored partition
 87h	NTFS volume/stripe set
 93h	Amoeba file system
 94h	Amoeba bad block table
 98h	Datalight ROM-DOS SuperBoot
 99h	Mylex EISA SCSI
 A0h	Phoenix NoteBIOS Power Management "Save-to-Disk" partition
 A1h	officially listed as reserved
 A3h	officially listed as reserved
 A4h	officially listed as reserved
 A5h	FreeBSD, BSD/386
 A6h	OpenBSD
 A9h	NetBSD (http://www.netbsd.org/)
 B1h	officially listed as reserved
 B3h	officially listed as reserved
 B4h	officially listed as reserved
 B6h	officially listed as reserved
 B6h	Windows NT mirror set (master), FAT16 file system
 B7h	BSDI file system (secondarily swap)
 B7h	Windows NT mirror set (master), NTFS file system
 B8h	BSDI swap partition (secondarily file system)
 BEh	Solaris boot partition
 C0h	DR DOS/DR-DOS/Novell DOS secured partition
 C0h	CTOS
 C1h	DR DOS 6.0 LOGIN.EXE-secured 12-bit FAT partition
 C4h	DR DOS 6.0 LOGIN.EXE-secured 16-bit FAT partition
 C6h	DR DOS 6.0 LOGIN.EXE-secured Huge partition
 C6h	corrupted FAT16 volume/stripe set (Windows NT)
 C6h	Windows NT mirror set (slave), FAT16 file system
 C7h	Syrinx Boot
 C7h	corrupted NTFS volume/stripe set
 C7h	Windows NT mirror set (slave), NTFS file system
 CBh	Reserved for DR DOS/DR-DOS/OpenDOS secured FAT32
 CCh	Reserved for DR DOS/DR-DOS secured FAT32 (LBA)
 CEh	Reserved for DR DOS/DR-DOS secured FAT16 (LBA)
 D0h	Multiuser DOS secured FAT12
 D1h	Old Multiuser DOS secured FAT12
 D4h	Old Multiuser DOS secured FAT16 (<= 32M)
 D5h	Old Multiuser DOS secured extended partition
 D6h	Old Multiuser DOS secured FAT16 (> 32M)
 D8h	CP/M-86
 DBh	CP/M, Concurrent CP/M, Concurrent DOS
 DBh	CTOS (Convergent Technologies OS)
 E1h	SpeedStor 12-bit FAT extended partition
 E2h	DOS read-only (Florian Painke's XFDISK 1.0.4)
 E3h	DOS read-only
 E3h	Storage Dimensions
 E4h	SpeedStor 16-bit FAT extended partition
 E5h	officially listed as reserved
 E6h	officially listed as reserved
 EBh	BeOS BFS (BFS1)
 F1h	Storage Dimensions
 F2h	DOS 3.3+ secondary partition
 F3h	officially listed as reserved
 F4h	SpeedStor
 F4h	Storage Dimensions
 F5h	Prologue
 F6h	officially listed as reserved
 FEh	LANstep
 FEh	IBM PS/2 IML (Initial Microcode Load) partition
 FFh	Xenix bad block table
Note:	for partition type 07h, one should inspect the partition boot record
	  for the actual file system type
SeeAlso: #00651

(Table 00653)
Values Bootstrap loader is called with (IBM BIOS):
	CS:IP = 0000h:7C00h
	DH = access
	    bits 7-6,4-0: don't care
	    bit 5: =0 device supported by INT 13
	DL = boot drive
	    00h first floppy
	    80h first hard disk
--------B-1A00-------------------------------
INT 1A - TIME - GET SYSTEM TIME
	AH = 00h
Return: CX:DX = number of clock ticks since midnight
	AL = midnight flag, nonzero if midnight passed since time last read
Notes:	there are approximately 18.2 clock ticks per second, 1800B0h per 24 hrs
	  (except on Tandy 2000, where the clock runs at 20 ticks per second)
	IBM and many clone BIOSes set the flag for AL rather than incrementing
	  it, leading to loss of a day if two consecutive midnights pass
	  without a request for the time (e.g. if the system is on but idle)
	since the midnight flag is cleared, if an application calls this
	  function after midnight before DOS does, DOS will not receive the
	  midnight flag and will fail to advance the date
	Modern releases of MS-DOS/PC DOS (5.0+???) assume that AL is a day
	  rollover counter rather than a flag, as expected by older releases.
	  DOS 5 - 7.10 (Windows 98 SE) provide an undocumented CONFIG.SYS
	  SWITCHES=/T option to force the old behaviour of the day advancing
	  code, that is using a flag instead of a counter.
	DR DOS 3.31 - DR-DOS 7.03 handle AL as a flag.
SeeAlso: AH=01h,AH=02h,INT 21/AH=2Ch,INT 55"Tandy 2000",INT 4E/AH=02h"TI"
SeeAlso: INT 62/AX=0099h,MEM 0040h:006Ch,MEM 0040h:0070h
--------B-1A01-------------------------------
INT 1A - TIME - SET SYSTEM TIME
	AH = 01h
	CX:DX = number of clock ticks since midnight
Return: nothing
Notes:	there are approximately 18.2 clock ticks per second, 1800B0h per 24 hrs
	  (except on Tandy 2000, where the clock runs at 20 ticks per second)
	this call resets the midnight-passed flag
SeeAlso: AH=00h,AH=03h,INT 21/AH=2Dh
--------B-1A02-------------------------------
INT 1A - TIME - GET REAL-TIME CLOCK TIME (AT,XT286,PS)
	AH = 02h
	CF clear to avoid bug (see below)
Return: CF clear if successful
	    CH = hour (BCD)
	    CL = minutes (BCD)
	    DH = seconds (BCD)
	    DL = daylight savings flag (00h standard time, 01h daylight time)
	CF set on error (i.e. clock not running or in middle of update)
Notes:	this function is also supported by the Sperry PC, which predates the
	  IBM AT; the data is returned in binary rather than BCD on the Sperry,
	  and DL is always 00h
	MS-DOS/PC DOS IO.SYS/IBMBIO.COM use this function to detect if a RTC
	  is preset by checking if the returned values are non-zero. If they
	  are, this function is called one more time, before it is assumed
	  that no RTC is present.
BUG:	some BIOSes leave CF unchanged if successful, so CF should be cleared
	  before calling this function
SeeAlso: AH=00h,AH=03h,AH=04h,INT 21/AH=2Ch
--------b-1A02-------------------------------
INT 1A - Tandy 2000 - TIME - GET DATE AND TIME
	AH = 02h
Return: BX = number of days since January 1, 1980
	CH = hours
	CL = minutes
	DH = seconds
	DL = hundredths
SeeAlso: AH=03h"Tandy 2000",INT 55"Tandy 2000"
--------B-1A03-------------------------------
INT 1A - TIME - SET REAL-TIME CLOCK TIME (AT,XT286,PS)
	AH = 03h
	CH = hour (BCD)
	CL = minutes (BCD)
	DH = seconds (BCD)
	DL = daylight savings flag (00h standard time, 01h daylight time)
Return: nothing
Note:	this function is also supported by the Sperry PC, which predates the
	  IBM AT; the data is specified in binary rather than BCD on the
	  Sperry, and the value of DL is ignored
SeeAlso: AH=01h,AH=03h,AH=05h,INT 21/AH=2Dh,INT 4B/AH=01h
--------b-1A03-------------------------------
INT 1A - Tandy 2000 - TIME - SET DATE AND TIME
	AH = 03h
	BX = number of days since January 1, 1980
	CH = hours
	CL = minutes
	DH = seconds
	DL = hundredths
Return: nothing
SeeAlso: AH=02h"Tandy 2000",INT 55"Tandy 2000"
--------B-1A04-------------------------------
INT 1A - TIME - GET REAL-TIME CLOCK DATE (AT,XT286,PS)
	AH = 04h
	CF clear to avoid bug (see below)
Return: CF clear if successful
	    CH = century (BCD)
	    CL = year (BCD)
	    DH = month (BCD)
	    DL = day (BCD)
	CF set on error
Notes:	DR-DOS 7.02 (after 1998-06-06) and 7.03 hook this function and correct
	  the century to 20xx if the reported year is 1900..1980 to auto-fix
	  ROM-BIOSes which are not Year 2000 compliant. On a running system,
	  it would also correct the rollover bug from 1999/12/31 to 2000/01/01.
	  The latter can be turned off using the new CONFIG.SYS YEAR2000=ON|OFF
	  command, as hooking INT 1Ah can sometimes cause compatibility
	  problems with 3rd party software, e.g. NCR/Symbios/LSI Logic-based
	  SDMS PCI SCSI drivers (including all OEM drivers like from Asus,
	  Noma, etc.), some Flash-BIOS software like Asus PFLASH, Quarterdeck's
	  QEMM Stealth and Quick-Boot features.
	Using EXCLUDESTEALTHINT=1A, though, will allow QEMM's Stealth features
	  to coexist with the DR-DOS Year 2000 rollover support.
	Actually, the Y2K-fix is provided since OpenDOS 7.02 BETA 2+
	  (1997-08-13), but although these older releases corrected the
	  ROM-BIOS, they didn't pass all Y2K-test suites and had some obscure
	  and inexplicable PCI problems due to the fact that the original
	  INT 1Ah was called via indirect means.  Newer releases, however, use
	  a dynamically fixed-up direct jump to avoid these problems.
	PC DOS 7 plus Y2K fixes and PC DOS 2000 provide similar, though not
	  identical means, which cannot be switched off.
	MS-DOS and older issues of PC DOS do not provide any such means, and
	  thus requires extra Y2K-TSRs to be loaded when run on buggy BIOSes.
BUG:	some BIOSes, such as the 1998/07/25 system ROM in the Compaq Deskpro
	  EP/SB, leave CF unchanged if successful, so CF should be cleared
	  before calling this function
SeeAlso: AH=02h,AH=04h"Sperry",AH=05h,INT 21/AH=2Ah,INT 4B/AH=02h"TI"
--------b-1A04-------------------------------
INT 1A - Sperry PC - GET REAL-TIME CLOCK DATE
	AH = 04h
Return: CF clear if successful
	    CL = year-1980
	    DH = month (binary) (01h-0Ch)
	    DL = day (binary) (01h-1Fh)
	CF set on error
SeeAlso: AH=02h,AH=04h,AH=05h"Sperry",INT 21/AH=2Ah,INT 4B/AH=02h"TI"
----------1A04--CX4555-----------------------
INT 1A - CheckIt Year 2000 Fix v2.06 - INSTALLATION CHECK
	AH = 04h
	CX = 4555h ('EU')
	DX = 524Fh ('RO')
	BX = 0000h
Return: BX <> 0000h if installed
	    BX = major/minor/sub version (2068h = version 2.06.8)
Program: CheckIt is a TSR by Eurosoft (UK) Ltd. which corrects some Y2K-related
	  RTC bugs
--------B-1A05-------------------------------
INT 1A - TIME - SET REAL-TIME CLOCK DATE (AT,XT286,PS)
	AH = 05h
	CH = century (BCD)
	CL = year (BCD)
	DH = month (BCD)
	DL = day (BCD)
Return: nothing
SeeAlso: AH=04h,INT 21/AH=2Bh"DATE",INT 4B/AH=00h"TI"
--------b-1A05-------------------------------
INT 1A - Sperry PC - SET REAL-TIME CLOCK DATE
	AH = 05h
	CL = year-1980
	CH = 00h (???)
	DH = month (binary) (01h-0Ch)
	DL = day (binary) (01h-1Fh)
Return: nothing
SeeAlso: AH=02h,AH=04h"Sperry",AH=05h,INT 21/AH=2Bh"DATE"
--------B-1A06-------------------------------
INT 1A - TIME - SET ALARM (AT,XT286,PS)
	AH = 06h
	CH = hour (BCD)
	CL = minutes (BCD)
	DH = seconds (BCD)
Return: CF set on error (alarm already set or clock stopped for update)
	CF clear if successful
Notes:	the alarm occurs every 24 hours until turned off, invoking INT 4A each
	  time
	the BIOS does not check for invalid values for the time, so the CMOS
	  clock chip's "don't care" setting (any values between C0h and FFh)
	  may be used for any or all three parts.  For example, to create an
	  alarm once a minute, every minute, call with CH=FFh, CL=FFh, and
	  DH=00h.
SeeAlso: AH=07h,AH=0Ch,INT 4A"SYSTEM"
--------B-1A07-------------------------------
INT 1A - TIME - CANCEL ALARM (AT,XT286,PS)
	AH = 07h
Return: alarm disabled
Note:	does not disable the real-time clock's IRQ
SeeAlso: AH=06h,AH=0Dh,INT 70
--------B-1A08-------------------------------
INT 1A - TIME - SET RTC ACTIVATED POWER ON MODE (CONVERTIBLE)
	AH = 08h
	CH = hours in BCD
	CL = minutes in BCD
	DH = seconds in BCD
SeeAlso: AH=09h
--------B-1A09-------------------------------
INT 1A - TIME - READ RTC ALARM TIME AND STATUS (CONV,PS30)
	AH = 09h
Return: CH = hours in BCD
	CL = minutes in BCD
	DH = seconds in BCD
	DL = alarm status
	    00h alarm not enabled
	    01h alarm enabled but will not power up system
	    02h alarm will power up system
SeeAlso: AH=08h
--------B-1A0A-------------------------------
INT 1A - TIME - READ SYSTEM-TIMER DAY COUNTER (XT2,PS)
	AH = 0Ah
Return: CF set on error
	CF clear if successful
	    CX = count of days since Jan 1,1980
SeeAlso: AH=04h,AH=0Bh
--------B-1A0B-------------------------------
INT 1A - TIME - SET SYSTEM-TIMER DAY COUNTER (XT2,PS)
	AH = 0Bh
	CX = count of days since Jan 1,1980
Return: CF set on error
	CF clear if successful
SeeAlso: AH=05h,AH=0Ah
--------B-1A0C-------------------------------
INT 1A - TIME - SET RTC DATE/TIME ACTIVATED POWER-ON MODE (IBM)
	AH = 0Ch
	CH = hours (BCD)
	CL = minutes (BCD)
	DH = seconds (BCD)
	DL = day of month (BCD)
Return: CF clear if successful
	CF set on error (alarm already set or clock nonfunctional)
Desc:	set an automatic power-on for a given time in the future
Note:	IBM classifies this function as optional
SeeAlso: AH=06h,AH=0Dh,AH=0Eh,INT 4A
--------B-1A0D-------------------------------
INT 1A - TIME - RESET RTC DATE/TIME ACTIVATED POWER-ON MODE (IBM)
	AH = 0Dh
Return: CF clear if successful
	CF set on error
Desc:	cancel a previously-set power-on alarm
Note:	IBM classifies this function as optional
SeeAlso: AH=07h,AH=0Ch,AH=0Eh
--------B-1A0E-------------------------------
INT 1A - TIME - GET RTC DATE/TIME ALARM AND STATUS (IBM)
	AH = 0Eh
Return: CF clear if successful
	    BH = alarm status
		00h disabled
		01h enabled but will not power-up system
		02h enabled, system will power-up on activation
	    CH = alarm time, hours (BCD)
	    CL = alarm time, minutes (BCD)
	    DH = seconds (BCD)
	    DL = day of month (BCD)
	CF set on error
SeeAlso: AH=0Ch,AH=0Dh,AH=0Fh
--------B-1A0F-------------------------------
INT 1A - TIME - INITIALIZE REAL-TIME CLOCK
	AH = 0Fh
	AL = reserved (0)
Return: CF clear if successful
	CF set on error
SeeAlso: AH=0Ch,AH=0Dh,AH=0Eh
--------J-1A10-------------------------------
INT 1A - NEC PC-9800 series - PRINTER - INITIALIZE
	AH = 10h
	???
Return: ???
SeeAlso: AH=11h,AH=12h,INT 17/AH=01h
--------J-1A1000-----------------------------
INT 1A - NEC PC-9800 series - INSTALLATION CHECK
	AX = 1000h
Return: AX <> 1000h if NEC
--------J-1A11-------------------------------
INT 1A - NEC PC-9800 series - PRINTER - OUTPUT CHARACTER
	AH = 11h
	???
Return: ???
SeeAlso: AH=10h,AH=12h,INT 17/AH=00h
--------J-1A12-------------------------------
INT 1A - NEC PC-9800 series - PRINTER - SENSE STATUS
	AH = 12h
	???
Return: ???
SeeAlso: AH=10h,AH=11h,INT 17/AH=02h
--------A-1A3601-----------------------------
INT 1A - WORD PERFECT v5.0 Third Party Interface - INSTALLATION CHECK
	AX = 3601h
Return: DS:SI = routine to monitor keyboard input, immediately preceded by the
		ASCIZ string "WPCORP\0"
Notes:	WordPerfect 5.0 will call this interrupt at start up to determine if a
	  third party product wants to interface with it.  The third party
	  product must intercept this interrupt and return the address of a
	  keyboard monitor routine.
	Before checking for keyboard input, and after every key entered by the
	  user, Word Perfect will call the routine whose address was provided
	  in DS:SI with the following parameters:
		Entry:	AX = key code or 0
			BX = WordPerfect state flag
		Exit:	AX = 0 or key code
			BX = 0 or segment address of buffer with key codes
	See the "WordPerfect 5.0 Developer's Toolkit" for further information.
SeeAlso: INT 16/AX=5500h
--------N-1A6108-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SENDWITHREPLY" - SEND MSG AND GET REPLY
	AX = 6108h
	STACK:	WORD	conversation ID (0000h-0009h)
		DWORD	pointer to message buffer
		WORD	length of message
		DWORD	pointer to reply buffer
		WORD	length of reply buffer
		WORD	0000h (use default "Cparams" structure)
Return: AX = status (see #00654)
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6205h

(Table 00654)
Values for SNAP.EXE status:
 0000h	successful
 F830h	"SNAP_ABORTED"
 FC04h	"SNAP_SERVERDIED"
 FC05h	"SNAP_RESEND"
 FC06h	"SNAP_SELECTFAILED"
 FC07h	"SNAP_WRONGVERSION"
 FC08h	"SNAP_INVALIDACK"
 FC09h	"SNAP_TIMEOUT"
 FC0Ah	"SNAP_SERVERREJECT"
 FC0Bh	"SNAP_NOREPLYDUE"
 FC0Ch	"SNAP_NOAUTHENTICATE"/"SNAP_GUARDIAN_ERROR"
 FC0Dh	"SNAP_NOINIT"
 FC0Eh	"SNAP_SOCKETERROR"
 FC0Fh	"SNAP_BUFFERLIMIT"
 FC10h	"SNAP_INVALIDCID"
 FC11h	"SNAP_INVALIDOP"
 FC12h	"SNAP_XMITFAIL"
 FC13h	"SNAP_NOMORERETRIES"
 FC14h	"SNAP_BADPARMS"
 FC15h	"SNAP_NOMEMORY"
 FC16h	"SNAP_NOMORECONVS"
 FFFFh	failed (invalid function/parameter)
--------N-1A6205-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SENDNOREPLY" - SEND MSG, DON'T AWAIT REPLY
	AX = 6205h
	STACK:	WORD	conversation ID (0000h-0009h)
		DWORD	pointer to message
		WORD	length of message
		WORD	0000h (use default "Cparms" structure)
Return: AX = status (see #00654)
	STACK unchanged
SeeAlso: AX=6108h
--------N-1A6308-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_BEGINCONV" - BEGIN CONVERSATION
	AX = 6308h
	STACK:	WORD	offset of ASCIZ "guardian"
		WORD	offset of ASCIZ hostname
		WORD	offset of ASCIZ server name
		WORD	offset of ASCIZ userid
		WORD	offset of ASCIZ password
		WORD	offset of password length
		WORD	offset of password type
		WORD	offset of "Cparms" structure (see #00655)
Return: ???
	STACK unchanged
Note:	all stacked offsets are within the SNAP data segment (use AX=6A01h
	  to allocate a buffer)
SeeAlso: AX=6405h,AX=7202h

Format of SNAP.EXE Cparms structure:
Offset	Size	Description	(Table 00655)
 00h	WORD	retry delay in seconds
 02h	WORD	timeout delay in seconds
 04h	WORD	maximum buffer size
 06h	WORD	encryption level
--------N-1A6405-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_ENDCONV" - END CONVERSATION
	AX = 6405h
	STACK:	WORD	conversation ID (0000h-0009h)
		DWORD	pointer to message buffer
		WORD	length of message
		WORD	0000h (use default "Cparms" structure)
Return: AX = status (see #00654)
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6308h
--------N-1A6900-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_DATASEG" - GET RESIDENT DATA SEGMENT
	AX = 6900h
Return: AX = value used for DS by resident code
SeeAlso: AX=6A01h,AX=6F01h
--------N-1A6A01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_ALLOC" - ALLOCATE BUFFER IN SNAP DATA SEGMENT
	AX = 6A01h
	STACK:	WORD	number of bytes to allocate
Return: AX = offset of allocated buffer or 0000h if out of memory
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6B01h
--------N-1A6B01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_FREE" - DEALLOCATE BUFFER IN SNAP DATA SEGMENT
	AX = 6B01h
	STACK:	WORD	offset within SNAP data segment of previously allocated
			buffer
Return: STACK unchanged
Note:	this call is a NOP if the specified offset is 0000h
SeeAlso: AX=6A01h
--------N-1A6C04-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_COPYTO" - COPY DATA TO RESIDENT SNAP PACKAGE
	AX = 6C04h
	STACK:	WORD	offset within SNAP data segment of dest (nonzero)
		WORD	segment of source buffer
		WORD	offset of source buffer
		WORD	number of bytes to copy
Return: AX = offset of byte after last one copied to destination
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=6D04h
--------N-1A6D04-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_COPYFROM" - COPY DATA FROM RESIDENT SNAP PACKAGE
	AX = 6D04h
	STACK:	WORD	offset within SNAP data segment of source buffer
		WORD	segment of destination buffer
		WORD	offset of destination buffer
		WORD	number of bytes to copy
Return: AX = offset of byte after last one copied from source
	buffer filled
	STACK unchanged
SeeAlso: AX=6C04h
--------N-1A6E01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SETDEBUG" - SET ???
	AX = 6E01h
	STACK:	WORD	new value for ???
Return: AX = old value of ???
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
--------N-1A6F01-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_CHKINSTALL" - INSTALLATION CHECK
	AX = 6F01h
	STACK: WORD 0000h
Return: AX = status
	    0000h SNAP is resident
	    other SNAP not present
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol, and is
	  required by PCVENUS (a network shell).  The combination of SNAP and
	  PCVENUS allows the use of the Andrew File System as one or more
	  networked drives.
SeeAlso: AX=6900h,AX=7400h
--------N-1A7002-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SETANCHOR"
	AX = 7002h
	STACK:	WORD	anchor number (0000h-0009h)
		WORD	new value for the anchor
Return: AX = status
	    0000h successful
	    FFFFh failed (top word on stack not in range 00h-09h)
	STACK unchanged
SeeAlso: AX=7101h
--------N-1A7101-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_GETANCHOR"
	AX = 7101h
	STACK:	WORD	anchor number (0000h-0009h)
Return: AX = anchor's value
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
SeeAlso: AX=7002h
--------N-1A7202-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_SETCONVPARMS" - SET CONVERSATION PARAMETERS
	AX = 7202h
	STACK:	WORD	conversation ID (0000h-0009h)
		WORD	offset within resident data segment of "Cparms"
			  structure (see #00655)
Return: AX = status???
	STACK unchanged
SeeAlso: AX=6308h
--------N-1A7302-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_CLIENTVERSION" - ???
	AX = 7302h
	STACK:	WORD	conversation ID (0000h-0009h)
		WORD	offset within resident data segment of ???
Return: AX = ???
	???
	STACK unchanged
SeeAlso: AX=7400h
--------N-1A7400-----------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_VERSION" - GET VERSION
	AX = 7400h
Return: AX = version (AH=major, AL=minor)
Note:	this call is only valid if SNAP is installed
SeeAlso: AX=7302h,INT 1A/AX=6F01h
--------N-1A75-------------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_NOP" - ???
	AH = 75h
	AL = ???
Return: AX = ??? (0000h)
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
--------N-1A76-------------------------------
INT 1A - SNAP.EXE 3.2+ - "SNAP_802_5" - ???
	AH = 76h
	AL = ???
Return: AX = ???
--------N-1A77-------------------------------
INT 1A - SNAP.EXE 3.4 - ???
	AH = 77h
	AL = ??? (at least 01h)
	STACK:	WORD	???
		???
Return: ???
	STACK unchanged
--------N-1A7802-----------------------------
INT 1A - SNAP.EXE 3.4 - ???
	AX = 7802h
	STACK:	WORD	???
		WORD	???
Return: ???
	STACK unchanged
Program: SNAP.EXE is a TSR written by IBM and Carnegie Mellon University
	  which implements the Simple Network Application Protocol
--------s-1A7F-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - DIGITAL SOUND???
	AH = 7Fh
	???
Return: ???
Note:	this function is not supported by the Tandy 1000SL/TL BIOS
SeeAlso: AH=80h,AH=83h,AH=85h
--------s-1A80-------------------------------
INT 1A - PCjr, Tandy 2500???, Tandy 1000SL/TL - SET UP SOUND MULTIPLEXOR
	AH = 80h
	AL = 00h source is 8253 channel 2
	     01h source is cassette input
	     02h source is I/O channel "Audio IN"
	     03h source is sound generator chip
Note:	although documented in the 1000TL Technical Reference, the 1000TL
	  BIOS has just an IRET for this call
SeeAlso: AH=7Fh,AH=83h
--------X-1A80-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET NUMBER OF ADAPTERS
	AH = 80h
Return: CF clear if successful
	    CX = 5353h ('SS') if Socket Services installed
		AL = number of adapters present (0-16)
	    AH destroyed
	CF set on error
	    AH = error code (see #00656)
SeeAlso: AH=83h"PCMCIA"

(Table 00656)
Values for PCMCIA error codes:
 01h	"BAD_ADAPTER" nonexistent adapter
 02h	"BAD_ATTRIBUTE" invalid attribute specified
 03h	"BAD_BASE" invalid system memory base address
 04h	"BAD_EDC" invalid EDC generator specified
 05h	"BAD_INDICATOR" invalid indicator specified
 06h	"BAD_IRQ" invalid IRQ channel specified
 07h	"BAD_OFFSET" invalid PCMCIA card offset specified
 08h	"BAD_PAGE" invalid page specified
 09h	"BAD_READ" unable to complete request
 0Ah	"BAD_SIZE" invalid window size specified
 0Bh	"BAD_SOCKET" nonexistent socket specified
 0Ch	"BAD_TECHNOLOGY" unsupported Card Technology for writes
 0Dh	"BAD_TYPE" unavailable window type specified
 0Eh	"BAD_VCC" invalid Vcc power level index specified
 0Fh	"BAD_VPP" invalid Vpp1 or Vpp2 power level index specified
 10h	"BAD_WAIT" invalid number of wait states specified
 11h	"BAD_WINDOW" nonexistent window specified
 12h	"BAD_WRITE" unable to complete request
 13h	"NO_ADAPTERS" no adapters installed, but Socket Services is present
 14h	"NO_CARD" no card in socket
 15h	function not supported
 16h	invalid mode
 17h	invalid speed
 18h	busy
--------X-1A81-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - REGISTER STATUS CHANGE CALLBACK
	AH = 81h
	DS:DX -> callback routine (see #00657) or 0000h:0000h to disable
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (see #00656)
Note:	the callback will be invoked on any socket changes whose notification
	  has not been disabled with the status change enable mask; it may be
	  invoked either while processing a hardware interrupt from the adapter
	  or while processing the following Socket Services request
SeeAlso: AH=80h"PCMCIA",AH=82h"PCMCIA"

(Table 00657)
Values PCMCIA callback routine is invoked with:
	AL = adapter number
	BH = status change interrupt enable mask (see #00658)
	BL = socket number
	DH = current socket status (see #00659)
	DL = current card status (see #00660)
Return: all registers preserved
Notes:	the callback may be invoked during a hardware interrupt, and may not
	  call on Socket Services
	the callback will be invoked once for each socket with a status change

Bitfields for PCMCIA status change interrupt enable mask:
Bit(s)	Description	(Table 00658)
 7	card detect change
 6	ready change
 5	battery warning change
 4	battery dead change
 3	insertion request
 2	ejection request
 1-0	reserved (0)

Bitfields for PCMCIA current socket status:
Bit(s)	Description	(Table 00659)
 7	card changed
 6	reserved (0)
 5	card insertion complete
 4	card ejection complete
 3	card insertion request pending
 2	card ejection request pending
 1	card locked
 0	reserved (0)

Bitfields for PCMCIA current card status:
Bit(s)	Description	(Table 00660)
 7	card detect
 6	ready
 5	battery voltage detect 2 (battery warning)
 4	battery voltage detect 1 (battery dead)
 3-1	reserved (0)
 0	write protected
--------s-1A8100-----------------------------
INT 1A - Tandy 2500, Tandy 1000L series - DIGITAL SOUND - INSTALLATION CHECK
	AX = 8100h
Return: AL > 80h if supported
	AX = 00C4h if supported (1000SL/TL)
	    CF set if sound chip is busy
	    CF clear  if sound chip is free
Note:	the value of CF is not definitive; call this function until CF is
	  clear on return, then call AH=84h"Tandy"
--------s-1A82-------------------------------
INT 1A - Tandy 2500???, Tandy 1000SL/TL - DIGITAL SOUND - RECORD SOUND
	AH = 82h
	ES:BX -> buffer for sound samples
	CX = length of buffer
	DX = transfer rate (1-4095, 1 is fastest)
Return: AH = 00h
	CF set if sound busy
	CF clear if sound chip free
Note:	the value in DX should be 1/10 the corresponding value for
	  INT 1A/AH=83h on the 1000TL, 1/11.5 on the 1000SL.  Call
	  INT 1A/AX=8100h and INT 1A/AH=84h before invoking this function.
	The BIOS issues an INT 15/AX=91FBh when the input is complete
	DMA across a 64K boundary is masked by the BIOS
--------X-1A82-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - REGISTER CARD TECHNOLOGY CALLBACK
	AH = 82h
	DS:DX -> callback routine (see #00661) or 0000h:0000h
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (see #00656)
Note:	the callback is invoked on a Write Multiple request with an unsupported
	  card technology type
SeeAlso: AH=81h"PCMCIA",AH=94h

(Table 00661)
Values PCMCIA callback routine is invoked with:
	ES:AX -> Low-Level Socket Services Routines (see #00663)
	BH = socket attributes (see #00662)
	CX = number of bytes or words to write
	DS:SI -> data buffer to be written
	DX:DI -> 26-bit linear card address
	BP = card technology type
Return: CF clear if successful
	CF set on error
	    AH = error code (07h,0Ch,12h,14h) (see #00656)

Bitfields for PCMCIA socket attributes:
Bit(s)	Description	(Table 00662)
 7-4	reserved (0)
 3	packed buffer
 2	even bytes only (only valid if 1 set)
 1	data width (clear = byte, set = word)
 0	memory type (clear = common, set = attribute)

Format of PCMCIA Low-Level Socket Services Routines:
Offset	Size	Description	(Table 00663)
 00h	WORD	offset of Write Many routine (see #00664)
 02h	WORD	offset of Write One routine (see #00665)
 04h	WORD	offset of Read One routine (see #00666)
 06h	WORD	offset of Increment Offset routine (see #00667)
 08h	WORD	offset of Set Offset routine (see #00668)
 0Ah	WORD	offset of Get Status routine (see #00669)

(Table 00664)
Call Write Many routine with:
	BH = socket attributes (see #00662)
	CX = number of bytes or words to write
	DS:SI -> data to be written
Return: CF clear if successful
	CF set on error

(Table 00665)
Call Write One routine with:
	AL/AX = data to be written
	BH = socket attributes (see #00662)
Return: CF clear if successful
	CF set on error

(Table 00666)
Call Read One routine with:
	BH = socket attributes (see #00662)
Return: CF clear if successful
	    AL/AX = data read
	CF set on error

(Table 00667)
Call Increment Offset routine with:
	BH = socket attributes (see #00662)
Return: CF clear if successful
	CF set on error

(Table 00668)
Call Set Offset routine with:
	DX:DI = new offset address
Return: CF clear if successful
	CF set on error

(Table 00669)
Call Get Status routine with:
	nothing
Return: AL = current card status (see #00660)
--------s-1A83-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - START PLAYING DIGITAL SOUND
	AH = 83h
	AL = volume (0=silence, 7=highest)
	CX = number of bytes to play
	DX = time between sound samples (multiples of 273 nanoseconds)
	    only bits 11-0 used
	ES:BX -> sound data (array of 8-bit unsigned PCM samples)
Return: AH = 00h
	CF set if sound is busy
	CF clear if sound chip is free
Notes:	this call returns immediately while the sound plays in the
	  background; the sound chip is clocked at 3.57 MHz, with the low 12
	  bits of DX specifying the clock divisor
	The BIOS appears to call INT 15/AX=91FBh when the sound device
	  underflows to allow another INT 1A/AH=83h for seamless playing of
	  long sounds.
SeeAlso: AH=84h"Tandy",INT 15/AH=91h
--------X-1A83-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET SOCKET SERVICES VERSION NUMBER
	AH = 83h
	AL = adapter number
Return: CF clear if successful
	    AX = Socket Services version (BCD)
	    BX = implementation version (BCD)
	    CX = 5353h ("SS")
	    DS:SI -> ASCIZ implementor description
	CF set on error
	    AH = error code (01h) (see #00656)
Note:	the current version (from the Revision A.00 documentation) of Socket
	  Services is 1.00 (AX=0100h)
SeeAlso: AH=80h"PCMCIA"
--------s-1A84-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - STOP PLAYING DIGITAL SOUND
	AH = 84h
Return: ???
Note:	the BIOS will call INT 15/AX=91FBh when the sound has stopped playing
SeeAlso: AH=83h"Tandy",AH=85h"Tandy"
--------X-1A84-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE ADAPTER
	AH = 84h
	AL = adapter number
Return: CF clear if successful
	    AH destroyed
	    BH = number of windows
	    BL = number of sockets (1-16)
	    CX = number of EDCs
	    DH = capabilities (see #00670)
	    DL = status change interrupt used (only if DH bit 3 set)(see #00671)
	CF set on error
	    AH = error code (01h) (see #00656)
SeeAlso: AH=80h"PCMCIA",AH=85h"PCMCIA",AH=87h

Bitfields for PCMCIA capabilities:
Bit(s)	Description	(Table 00670)
 7-6	reserved (0)
 5	status change interrupt is hardware shareable
 4	status change interrupt is software shareable
 3	status change interrupt
 2	data bus width is per-socket rather than per-window
 1	power management is per-adapter rather than per-socket
 0	indicators are per-adapter rather than per-socket

(Table 00671)
Values for PCMCIA status change interrupt usage:
 00h-0Fh IRQ level
 10h	NMI
 11h	I/O check
 12h	bus error
 13h	vendor specific
 14h-FFh reserved
--------s-1A85-------------------------------
INT 1A - Tandy 2500, Tandy 1000L series - DIGITAL SOUND???
	AH = 85h
	???
Return: ???
Note:	this function is not supported by the Tandy 1000SL/TL BIOS
SeeAlso: AH=7Fh,AH=83h"Tandy"
--------X-1A85-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET ADAPTER
	AH = 85h
	AL = adapter number
Return: CF clear if successful
	    AH destroyed
	    DH = adapter attributes (see #00672)
	CF set on error
	    AH = error code (01h) (see #00656)
SeeAlso: AH=84h"PCMCIA",AH=86h

Bitfields for PCMCIA adapter attributes:
Bit(s)	Description	(Table 00672)
 7-5	reserved (0)
 4	hardware share status change
 3	software share status change
 2	enable status change interrupts
 1	adapter preserves state information during reduced power consumption
 0	attempting to reduce power consumption
--------X-1A86-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET ADAPTER
	AH = 86h
	AL = adapter number
	DH = new adapter attributes (see #00672)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h) (see #00656)
SeeAlso: AH=84h"PCMCIA",AH=85h"PCMCIA"
--------X-1A87-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE WINDOW
	AH = 87h
	AL = adapter number
	BH = window number
Return: CF clear if successful
	    AH destroyed
	    BL = capabilities (see #00673)
	    CX = bitmap of assignable sockets
	    DH = EISA A15-A12 address lines (in bits 7-4, bits 3-0 = 0)
	    DL = supported access speeds (see #00674)
	    DS:SI -> Memory Window Characteristics table (see #00675)
	    DS:DI -> I/O Window Characteristics table (see #00676)
	CF set on error
	    AH = error code (01h,11h) (see #00656)
SeeAlso: AH=84h"PCMCIA",AH=88h,AH=89h,AH=8Ch

Bitfields for PCMCIA window capabilities:
Bit(s)	Description	(Table 00673)
 7-5	reserved (0)
 4	separate enable for EISA comon space
 3	EISA I/O mappable
 2	I/O space
 1	attribute memory
 0	common memory

Bitfields for PCMCIA supported access speeds:
Bit(s)	Description	(Table 00674)
 7	reserved (0)
 6	600 ns
 5	300 ns
 4	250 ns
 3	200 ns
 2	150 ns
 1	100 ns
 0	WAIT line monitoring

Format of PCMCIA Memory Window Characteristics table:
Offset	Size	Description	(Table 00675)
 00h	WORD	window capabilities (see #00677)
 02h	WORD	minimum base address in 4K pages
 04h	WORD	maximum base address in 4K pages
 06h	WORD	minimum window size in 4K pages
 08h	WORD	maximum window size in 4K pages
 0Ah	WORD	window size granularity (4K units)
 0Ch	WORD	required base address alignment (4K units)
 0Eh	WORD	required card offset alignment (4K units)

Format of PCMCIA I/O Window Characteristics table:
Offset	Size	Description	(Table 00676)
 00h	WORD	window capabilities (see #00677)
 02h	WORD	minimum base address in bytes
 04h	WORD	maximum base address in bytes
 06h	WORD	minimum window size in bytes
 08h	WORD	maximum window size in bytes
 0Ah	WORD	window size granularity (bytes)

Bitfields for PCMCIA window capabilities:
Bit(s)	Description	(Table 00677)
 0	programmable base address
 1	programmable window size
 2	window disable/enable supported
 3	8-data bus
 4	16-data bus
 5	base address alignment on size boundary required
 6	power-of-two size granularity
---memory windows---
 7	card offset must be aligned on size boundary
 8	paging hardware available
 9	paging hardware shared
 10	page disable/enable supported
 11-15	reserved (0)
---I/O windows---
 7-15	reserved (0)
--------X-1A88-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET WINDOW
	AH = 88h
	AL = adapter number
	BH = window number
Return: CF clear if successful
	    AH destroyed
	    BL = socket number (0-16) (0 = not assigned)
	    CX = window size (bytes for I/O window, 4K units for memory window)
	    DH = window attributes (see #00678)
	    DL = access speed (only one bit set) (see #00674)
	    SI = window base address (bytes if I/O, 4K units if memory)
	    DI = card offset address (memory only, 4K units)
	CF set on error
	    AH = error code (01h,11h) (see #00656)
SeeAlso: AH=87h,AH=89h,AH=8Ah

Bitfields for PCMCIA window attributes:
Bit(s)	Description	(Table 00678)
 0	memory-mapped rather than I/O-mapped
 1	attribute memory rather than common (memory-mapped)
	EISA mapped (I/O)
 2	enabled
 3	16-data path
 4	subdivided into pages (memory-mapped only)
 5	non-specific access slot enable (EISA-mapped only)
 6-7	reserved (0)
--------X-1A89-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET WINDOW
	AH = 89h
	AL = adapter number
	BH = window number
	BL = socket number
	CX = window size (bytes if I/O window, 4K units if memory window)
	DH = window attributes (see #00678)
	DL = access speed (only one bit set) (see #00674)
	SI = window base address (bytes if I/O, 4K units if memory window)
	DI = card offset addrress (memory only, 4K units)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,03h,07h,08h,0Ah,0Bh,0Dh,10h,11h) (see #00656)
SeeAlso: AH=87h,AH=88h,AH=8Bh
--------X-1A8A-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET PAGE
	AH = 8Ah
	AL = adapter number
	BH = window number
	BL = page number
Return: CF clear if successful
	    AH destroyed
	    DX = page attributes (see #00679)
	    DI = memory card offset (4K units)
	CF set on error
	    AH = error code (01h,08h,11h) (see #00656)
Notes:	this function is only valid for memory-mapped windows
	the socket being operated on is implied by the previous AH=89h call
SeeAlso: AH=88h,AH=8Bh

Bitfields for PCMCIA page attributes:
Bit(s)	Description	(Table 00679)
 0	page enabled
 15-1	reserved (0)
--------X-1A8B-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET PAGE
	AH = 8Bh
	AL = adapter number
	BH = window number
	BL = page number
	DX = page attributes (see #00679)
	DI = memory card offset (4K units)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,02h,07h,08h,11h) (see #00656)
Notes:	this function is only valid for memory-mapped windows
	the socket being operated on is implied by the previous AH=89h call
SeeAlso: AH=89h,AH=8Ah
--------X-1A8C-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE SOCKET
	AH = 8Ch
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	    DH = capabilities (see #00680)
	    DL = hardware indicators (see #00681)
	    DS:SI -> Socket Characteristics table (see #00682)
	    DS:DI -> Power Management table (see #00684)
	CF set on error
	    AH = error code (01h,0Bh) (see #00656)
SeeAlso: AH=87h,AH=8Dh,AH=8Eh

Bitfields for PCMCIA socket capabilities:
Bit(s)	Description	(Table 00680)
 0	card change
 1	card lock
 2	insert card (motor control)
 3	eject card (motor control)
 4-7	reserved (0)

Bitfields for PCMCIA socket hardware indicators:
Bit(s)	Description	(Table 00681)
 0	busy status
 1	write-protected
 2	battery status
 3	card lock status
 4	XIP status (eXecute-In-Place)
 5-7	reserved (0)

Format of PCMCIA Socket Characteristics table:
Offset	Size	Description	(Table 00682)
 00h	WORD	supported card types (see #00683)
 02h	WORD	steerable IRQ levels (bit 0 = IRQ0 to bit 15 = IRQ15)
 04h	WORD	additional steerable IRQ levels
		bit 0: NMI
		bit 1: I/O check
		bit 2: bus error
		bit 3: vendor-unique
		bits 4-7 reserved (0)

Bitfields for supported card types:
Bit(s)	Description	(Table 00683)
 0	memory card
 1	I/O card
 2-7	reserved (0)

Format of PCMCIA Power Management table:
Offset	Size	Description	(Table 00684)
 00h	WORD	number of entries in table (0 if power management not avail)
 02h 2N BYTEs	power levels
		byte 0: voltage in 0.1V units
		byte 1: power supply
			bit 7: Vcc
			bit 6: Vpp1
			bit 5: Vpp2
--------X-1A8D-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET SOCKET
	AH = 8Dh
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	    BH = status change interrupt enable mask (see #00658)
	    CH = Vcc level (lower nybble) (see #00684)
	    CL = Vpp1 level (upper nybble) and Vpp2 level (lower nybble)
	    DH = current socket status (see #00659)
	    DL = indicators (see #00681)
	    SI = card type (see #00685)
	    DI = IRQ level steering (I/O only) (see #00686)
	CF set on error
	    AH = error code (01h,0Bh) (see #00656)
SeeAlso: AH=8Ch,AH=8Eh

Bitfields for PCMCIA card type:
Bit(s)	Description	(Table 00685)
 0	memory
 1	I/O
 2-15	reserved (0)

Bitfields for PCMCIA I/O level steering:
Bit(s)	Description	(Table 00686)
 15	interrupt steering enabled
 14-5	reserved (0)
 4-0	IRQ level (0-15=IRQ,16=NMI,17=I/O check,18=bus error,19=vendor)
--------X-1A8E-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET SOCKET
	AH = 8Eh
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = status change interrupt enable mask (see #00658)
	CL = Vpp1 level (upper nybble) and Vpp2 level (lower nybble)
	DH = current socket status (see #00659)
	DL = indicators (see #00681)
	SI = card type (see #00685)
	DI = IRQ level steering (I/O only) (see #00686)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,02h,05h,06h,0Bh,0Eh,0Fh) (see #00656)
SeeAlso: AH=8Ch,AH=8Dh
--------X-1A8F-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET CARD
	AH = 8Fh
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	    DL = current card status (see #00660)
	CF set on error
	    AH = error code (01h,0Bh) (see #00656)
SeeAlso: AH=8Dh,AH=90h
--------X-1A90-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - RESET CARD
	AH = 90h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,0Bh,14h) (see #00656)
Note:	toggles RESET pin of the specified card, but does not wait after
	  toggling the pin; it is the caller's responsibility to avoid
	  accessing the card before it is ready again
--------X-1A91-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - READ ONE
	AH = 91h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #00687)
	DX:SI = card address
Return: CF clear if successful
	    AH destroyed
	    CL/CX = value read
	CF set on error
	    AH = error code (01h,07h,09h,0Bh,14h) (see #00656)
	    CX may be destroyed
Note:	this function is only valid for I/O-mapped sockets
SeeAlso: AH=92h,AH=93h,INT 21/AX=440Dh"DOS 3.2+"

Bitfields for PCMCIA attributes:
Bit(s)	Description	(Table 00687)
 2	even bytes only
 1	word rather than byte
 0	attribute memory instead of common memory
--------X-1A92-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - WRITE ONE
	AH = 92h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #00687)
	CL/CX = value to write
	DX:SI = card address
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,07h,0Bh,12h,14h) (see #00656)
Note:	this function is only valid for I/O-mapped sockets; it also does not
	  implement Card Technology handling--use AH=94h when writing to
	  non-RAM technologies
SeeAlso: AH=91h,AH=94h,INT 21/AX=440Dh"DOS 3.2+"
--------X-1A93-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - READ MULTIPLE
	AH = 93h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #00687)
	CX = number of bytes or words to read
	DX:SI = card address
	DS:DI -> data buffer to be filled
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,07h,09h,0Bh,14h) (see #00656)
Note:	this function is only available on I/O-mapped sockets
SeeAlso: AH=91h,AH=94h,INT 21/AX=440Dh"DOS 3.2+"
--------X-1A94-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - WRITE MULTIPLE
	AH = 94h
	AL = adapter number
	BL = socket number (01h to maximum supported by adapter)
	BH = attributes (see #00687)
	CX = number of bytes or words to read
	DX:DI = card address
	DS:SI -> buffer containing data
	BP = Card Technology type (0000h = RAM)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,07h,0Bh,0Ch,12h,14h) (see #00656)
Notes:	this function is only available on I/O-mapped sockets
	Socket Services calls the Card Technology callback (see #00661) for
	  any card technology it does not directly support
SeeAlso: AH=82h"PCMCIA",AH=92h,AH=93h,INT 21/AX=440Dh"DOS 3.2+"
--------X-1A95-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - INQUIRE ERROR DETECTION CODE
	AH = 95h
	AL = adapter number
	BH = EDC generator number
Return: CF clear if successful
	    AH destroyed
	    CX = bitmap of assignable sockets
	    DH = EDC capabilities (see #00688)
	    DL = supported EDC types (see #00689)
	CF set on error
	    AH = error code (01h,04h) (see #00656)
SeeAlso: AH=96h,AH=9Ch

Bitfields for EDC capabilities:
Bit(s)	Description	(Table 00688)
 0	unidirectional only generation
 1	bidirectional only generation
 2	register-based (I/O-mapped) support
 3	memory-mapped support
 4	pausable
 5-7	reserved (0)

Bitfields for supported EDC types:
Bit(s)	Description	(Table 00689)
 0	8-checksum
 1	16-CRC-SDLC
 2-7	reserved (0)
--------X-1A96-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - GET ERROR DETECTION CODE
	AH = 96h
	AL = adapter number
	BH = EDC generator number
Return: CF clear if successful
	    AH destroyed
	    BL = socket number
	    DH = EDC attributes (see #00690)
	    DL = EDC type (see #00689) (only one bit set)
	CF set on error
	    AH = error code (01h,04h) (see #00656)
SeeAlso: AH=95h,AH=97h,AH=9Ch

Bitfields for EDC attributes:
Bit(s)	Description	(Table 00690)
 0	unidirectional only
 1	(if 0 set) clear=read, set=write
 2-7	reserved (0)
--------X-1A97-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - SET ERROR DETECTION CODE
	AH = 97h
	AL = adapter number
	BH = EDC generator
	BL = socket number
	DH = EDC attributes (see #00690)
	DL = EDC type (see #00689) (only one bit may be set)
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,02h,04h,0Bh) (see #00656)
SeeAlso: AH=96h,AH=9Ch
--------X-1A98-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - START ERROR DETECTION CODE
	AH = 98h
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,04h) (see #00656)
SeeAlso: AH=96h,AH=99h,AH=9Bh,AH=9Ch
--------X-1A99-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - PAUSE ERROR DETECTION CODE
	AH = 99h
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,04h) (see #00656)
SeeAlso: AH=9Ah
--------X-1A9A-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - RESUME ERROR DETECTION CODE
	AH = 9Ah
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (01h,04h) (see #00656)
SeeAlso: AH=99h,AH=98h
--------X-1A9B-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - STOP ERROR DETECTION CODE
	AH = 9Bh
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	CF set on error
	    AH = error code (see #00656)
SeeAlso: AH=98h,AH=99h,AH=9Ch
--------X-1A9C-------------------------------
INT 1A - PCMCIA Socket Services v1.00 - READ ERROR DETECTION CODE
	AH = 9Ch
	AL = adapter number
	BH = EDC generator
Return: CF clear if successful
	    AH destroyed
	    DL/DX = computed checksum or CRC
	CF set on error
	    AH = error code (01h,04h) (see #00656)
SeeAlso: AH=95h,AH=96h,AH=98h,AH=99h,AH=9Bh
--------X-1A9D-------------------------------
INT 1A - PCMCIA Socket Services v2.1??? - GET VENDOR INFO
	AH = 9Dh
	AL = adapter number
	BH = EDC generator
	ES:EDI -> vendor information structure (see #00691)
Return: CF clear if successful
	    AH destroyed
	    DX = vendor release number in BCD
	    ES:EDI unchanged
	CF set on error
	    AH = error code (01h,15h) (see #00656)
Notes:	this API is supported by recent versions of the AMI BIOS
	the low-level API described here is hidden by the higher-level
	  ExCA API once Card Services has been installed
SeeAlso: AH=9Dh"ExCA"

Format of Vendor Information structure:
Offset	Size	Description	(Table 00691)
 00h	WORD	buffer length (set to size of buffer below)
 04h	WORD	(ret) data length
 08h  x BYTEs	implementor name (ASCIIZ string)
--------X-1A9D-------------------------------
INT 1A - Intel PCMCIA ExCA Card Services - API
	AH = 9Dh
	AL = subfunction (see #00692)
	???
Return: ???
SeeAlso: AH=9Dh"ExCA",#00891

(Table 00692)
Values for PCMCIA ExCA Card Services subfunction number:
 00h	Client Services: Get Number of Sockets
 01h	Advanced Client Utilities: Initialize
 02h	Client Services: Register Client
 03h	Client Services: Deregister Client
 04h	Advanced Client Utilities: Enumerate Clients
 05h	Client Services: Register SCB
 06h	Client Services: Deregister SCB
 07h	Advanced Client Utilities: Register MTD
 08h	Advanced Client Utilities: Deregister MTD
 09h	Advanced Client Utilities: Enumerate MTD
 0Ah	Client Services: Get Status
 0Bh	Client Services: Reset Card
 0Ch	Client Utilities: Get First Tuple
 0Dh	Client Utilities: Get Next Tuple
 0Eh	Client Utilities: Determine First Region
 0Fh	Client Utilities: Determine Next Region
 10h	Client Utilities: Get First Region
 11h	Client Utilities: Get Next Region
 12h	Client Utilities: Get First Partition
 13h	Client Utilities: Get Next Partition
 14h	Bulk Memory Services: Open Region
 15h	Bulk Memory Services: Read Memory
 16h	Bulk Memory Services: Write Memory
 17h	Bulk Memory Services: Copy Memory
 18h	Bulk Memory Services: Erase Memory
 19h	Resource Management: Request I/O
 1Ah	Resource Management: Release I/O
 1Bh	Resource Management: Request Memory
 1Ch	Client Services: Modify Window
 1Dh	Resource Management: Release Memory
 1Eh	Client Services: Map Mem Page
 1Fh	Advanced Client Utilities: Return SS Entry
 20h	Advanced Client Utilities: Map Log to Phy
 21h	Advanced Client Utilities: Map Log Phy to Log
 22h	Resource Management: Request IRQ
 23h	Resource Management: Release IRQ
 24h	Bulk Memory Services: Close Region
--------X-1A9E-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - ACKNOWLEDGE INTERRUPT
	AH = 9Eh
	AL = adapter number
Return: CF clear if successful
	    AH destroyed
	    CX = bitmap representing sockets which have changed status
	CF set on error
	    AH = error code (01h) (see #00656)
Note:	this API is supported by recent versions of the AMI BIOS
--------X-1A9F-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - GET/SET PRIOR INT 1A HANDLER
	AH = 9Fh
	AL = adapter number
	BL = mode
	    00h get prior INT 1Ah handler
	    01h set prior INT 1Ah handler
		CX:DX -> new prior handler
Return: CF clear if successful
	    AH destroyed
	    CX:DX -> old prior handler
	CF set on error
	    AH = error code (01h,15h,18h) (see #00656)
Desc:	allows hooking of INT 16h "behind" the Socket Services hook
Note:	this API is supported by recent versions of the AMI BIOS
SeeAlso: AH=9Eh,AH=A0h"PCMCIA",AH=AEh"PCMCIA"
--------c-1AA0-------------------------------
INT 1A U - Disk Spool II v2.07+ - INSTALLATION CHECK
	AH = A0h
Return: AH = B0h if installed
	    AL = pending INT 1A/AH=D0h subfunction if nonzero???
	    ES = code segment
	    ES:BX -> name of current spool file
	    ES:SI -> current despool file
	    CL = despooler state (00h disabled, 41h enabled)
	    CH = spooler state (00h disabled, 41h enabled)
	    DL = despooler activity
		00h currently active printing a file
		41h standing by
	    DH = 00h ???
	       = 41h ???
	    DI = 0000h ???
		 0001h ???
Program: Disk Spool II is a shareware disk-based print spooler by Budget
	  Software Company
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=ABh,AH=C0h,AH=D0h,AH=E1h
--------X-1AA0-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - GET/SET SOCKET SERVICES ADDRESS
	AH = A0h
	AL = adapter number
	BH = mode
	    00h real mode
	    01h 16:16 protected mode
	    02h 16:32 protected mode
	    03h 00:32 (Flat) protected mode
	BL = subfunction
	    00h return number of additional data areas (see #00693)
	    01h return description of additional data areas (see #00694)
	    02h accept mode-specific pointers to data areas (see #00695)
	ES:EDI -> buffer supplied by caller
Return: CF clear if successful
	    AH destroyed
	    CX = number of additional data areas
	    ES:EDI unchanged
	CF set on error
	    AH = error code (01h,02h,15h,16h,18h) (see #00656)
SeeAlso: AH=9Fh,AH=AEh

Format of PCMCIA Subfunction 00h Buffer Table Entry structure:
Offset	Size	Description	(Table 00693)
 00h	DWORD	32-bit linear base address of the code segment
 04h	DWORD	segment limit of the code segment
 08h	DWORD	entry point offset
 0Ch	DWORD	32-bit linear base address of the data segment
		(ignored in 00:32 flat mode)
 10h	DWORD	segment limit of the data segment
 14h	DWORD	data area offset.  Only used in 32-bit protected mode.
SeeAlso: #00694,#00695

Format of PCMCIA Additional Data Area Description structure [array]:
Offset	Size	Description	(Table 00694)
 00h	DWORD	32-bit linear base address of the additional data segment
		(ignored in 00:32 flat mode)
 04h	DWORD	segment limit of the code segment
 08h	DWORD	data area offset (only used in 32-bit protected mode)
SeeAlso: #00693,#00695

Format of PCMCIA Subfunction 02h Buffer Table Entry structure:
Offset	Size	Description	(Table 00695)
 00h	DWORD	32-bit offset(ignored in 16:16 protected mode)
 04h	DWORD	selector (only used in 00:32 flat mode)
 08h	DWORD	reserved
SeeAlso: #00693,#00694
--------X-1AA1-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - GET ACCESS OFFSETS
	AH = A1h
	AL = adapter number
	BH = Mode
	     00h = Real Mode
	     01h = 16:16 Protected Mode
	     02h = 16:32 Protected Mode
	     03h = 00:32 Protected Mode
	CX = Number of access offsets
	ES:EDI -> buffer supplied by caller, CX words long (see #00696)
Return: CF clear if successful
	    AH destroyed
	    DX = number of access offsets supported
	    ES:EDI unchanged
	CF set on error
	    AH = error code (01h,15h,16h) (see #00656)
Desc:	Returns an array of low-level adapter-specific optimized
	PC Card access routines for adapters that use registers
	or I/O ports to access PC Card memory.	Adapters that access
	PC Card memory through windows mapped to host system memory
	do not support this function.
Note:	offsets returned are 16-bit offsets into the
	Socket Services code segment.  They must be called
	appropriately for the processor mode selected.
	(Real, 16:16 and 16:32 modes use FAR CALL,
	Flat 00:32 mode uses a 32-bit NEAR CALL).
SeeAlso: AH=AEh

Format of Offset Table structure:
Offset	Size	Description	(Table 00696)
 00h	WORD	Set Address
 02h	WORD	Set Auto Increment
 04h	WORD	Read Byte
 06h	WORD	Read Word
 08h	WORD	Read Byte with Auto Increment
 0Ah	WORD	Read Word with Auto Increment
 0Ch	WORD	Read Words
 0Eh	WORD	Read Words with Auto Increment
 10h	WORD	Write Byte
 12h	WORD	Write Word
 14h	WORD	Write Byte with Auto Increment
 16h	WORD	Write Word with Auto Increment
 18h	WORD	Write Words
 1Ah	WORD	Write Words with Auto Increment
 1Ch	WORD	Compare Byte
 1Eh	WORD	Compare Byte with Auto Increment
 20h	WORD	Compare Words
 22h	WORD	Compare Words with Auto Increment
--------X-1AA2-------------------------------
INT 1A - CardBus Socket Services - ACCESS CONFIGURATION SPACE
	AH = A2h
	??? details not available
Return: ???
--------X-1AA4-------------------------------
INT 1A - CardBus Socket Services - GET BRIDGE WINDOW / WINDOW CAPABILITIES
	AH = A4h
	??? details not available
Return: ???
SeeAlso: AH=A5h"CardBus"
--------X-1AA5-------------------------------
INT 1A - CardBus Socket Services - SET BRIDGE WINDOW
	AH = A5h
	??? details not available
Return: ???
SeeAlso: AH=A4h"CardBus"
--------c-1AAB-------------------------------
INT 1A U - Disk Spool II v1.83 - INSTALLATION CHECK
	AH = ABh
Return: AH = BAh if installed
	    AL = pending INT 1A/AH=ADh subfunction if nonzero???
	    ES = code segment
	    ES:BX -> name of current spool file
	    ES:SI -> current despool file
	    CL = despooler state (00h disabled, 41h enabled)
	    CH = spooler state (00h disabled, 41h enabled)
	    DL = despooler activity
		00h currently active printing a file
		41h standing by
	    DH = 00h ???
	       = 41h ???
	    DI = 0000h ???
		 0001h ???
Program: Disk Spool II is a shareware disk-based print spooler by Budget
	  Software Company
SeeAlso: AH=A0h,AH=ACh,AH=ADh,AH=E1h
--------c-1AAC-------------------------------
INT 1A U - Disk Spool II v1.83 - INSTALLATION CHECK
	AH = ACh
Return: (see AH=ABh)
Note:	this function is identical to AH=ABh
SeeAlso: AH=A0h,AH=ABh,AH=ADh
--------c-1AAD-------------------------------
INT 1A U - Disk Spool II v1.83 - FUNCTION CALLS
	AH = ADh
	AL = function code (see #00697)
Return: AH = 00h if successful
SeeAlso: AH=ABh

(Table 00697)
Values for Disk Spool function code:
 02h	enable spooler only
 03h	enable the despooler
 04h	disable the despooler
 08h	inhibit popup menu
 09h	enable popup menu
 0Ah	???
 0Bh	disable the spooler
 0Ch	start despooler after last successfully printed document???
 0Dh	start despooler at the exact point where it last left off???
 0Eh	pop up the menu
 0Fh	???
 11h	???
 14h	???
 15h	???
 16h	???
 17h	???
 18h	???
 19h	???
 20h	clear file pointed to by the despooler???
 21h	???
 22h	???
 23h	???
 30h	???
--------X-1AAE-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - VENDOR SPECIFIC
	AH = AEh
	AL = adapter number
	all other registers are vendor-specific
Return: vendor specific
SeeAlso: AH=A1h,AH=AFh
--------X-1AAE-------------------------------
INT 1A - PCMCIA Socket Services v2.1 - API
	AH = AEh
	SI = function
	    0002h ???
	    0100h ???
	    0101h ???
	    8000h ???
	    8001h ???
	details not yet available
Return: CF clear if successful
	CF set on error
	    AH = error code (02h,0Bh,11h,15h,17h) (see #00656)
SeeAlso: AH=9Eh
--------X-1AAF-------------------------------
INT 1A - PCMCIA v2 Card Services - API
	AH = AFh
	AL = function
	    00h close memory
	    01h copy memory
	    02h deregister client
	    03h get client information (see #00702)
	    04h get configuration information (see #00704)
	    05h get first partition
	    06h get first region
	    07h get first tuple (see #00711)
	    08h get next partition
	    09h get next region
	    0Ah get next tuple
	    0Bh	get Card Services information (see #00700)
	    0Ch get status
	    0Dh	get tuple data (see #00712)
	    0Eh	get first client (see #00701)
	    0Fh get/register Erase Queue
	    10h	register client (see #00713)
	    11h reset function
	    12h map logical socket
	    13h map logical window
	    14h map memory page
	    15h map physical socket
	    16h map physical window
	    17h modify window
	    18h open memory
	    19h read memory
	    1Ah register MTD
	    1Bh release I/O
	    1Ch release IRQ (see #00715)
	    1Dh release window
	    1Eh release configuration (see #00716)
	    1Fh request I/O (see #00717)
	    20h request IRQ (see #00718)
	    21h reqeust window (see #00720)
	    22h request socket mask
	    23h return SS entry
	    24h write memory
	    25h deregister Erase Queue
	    26h check Erase Queue
	    27h modify configuration
	    28h register timer
	    29h set region
	    2Ah get next client
	    2Bh validate CIS
	    2Ch request exclusive access (see #00723)
	    2Dh release exclusive access (see #00723)
	    2Eh get event mask
	    2Fh release socket mask
	    30h request configuration (see #00724)
	    31h set event mask
	    32h add Socket Service
	    33h replace Socket Service
	    34h vendor-specific
	    35h adjust resource information
	    36h access configuration register
	    37h get first window
	    38h get next window
	    39h get memory page
	    3Ah request DMA
	    3Bh release DMA
	further details not yet available
Return: ??? = result code (see #00698)
SeeAlso: AH=AEh

(Table 00698)
Values for PCMCIA Card Services result codes:
 00h	successful
 01h	invalid adapter number
 02h	bad value for attribute field
 03h	bad value for base system memory address
 04h	invalid EDC generator specified
 05h	(reserved for historical reasons)
 06h	invalid IRQ level specified
 07h	invalid PC Card memory array offset
 08h	invalid page number specified
 09h	unable to complete read request
 0Ah	invalid size specified
 0Bh	invalid socket number
 0Ch	(reserved for historical reasons)
 0Dh	invalid window or interface type
 0Eh	invalid Vcc power level specified
 0Fh	invalid Vpp1 or Vpp2 power level specified
 10h	(reserved for historical reasons)
 11h	invalid window number
 12h	unable to complete write request
 13h	(reserved for historical reasons)
 14h	no PC Card in socket
 15h	service not supported by implementation
 16h	unsupported processor mode
 17h	specified speed not available
 18h	busy -- retry later
 19h	undefined error (general failure)
 1Ah	storage medium write protected
 1Bh	argument length in (E)CX is invalid
 1Ch	bad value(s) in argument packet
 1Dh	configuration has already been locked
 1Eh	requested resource already in use
 1Fh	no more items of requested type available
 20h	out of resources
 21h	invalid client handle
 22h	unsupported client version

(Table 00699)
Values for Card Services Callback Event codes:
 01h	battery dead
 02h	battery low
 03h	card locked
 04h	card has become ready
 05h	card removed
 06h	card unlocked
 07h	motorized ejection complete
 08h	ejection requested
 09h	insertion complete
 0Ah	insertion requested
 0Bh	power management: resume
 0Ch	power management: suspend
 0Dh	exclusive access granted
 0Eh	exclusive access requested
 0Fh	perform physical reset
 10h	physical reset requested
 11h	card has been reset
 12h	MTD request (read/write/etc)
 14h	request for client info
 15h	timer has expired
 16h	Socket Service was modified
 17h	write-protected
 18h	attention requested
 40h	card insertion
 80h	reset complete
 81h	erase complete
 82h	registration complete

Format of Card Services Information:
Offset	Size	Description	(Table 00700)
 00h	WORD	length of information record in bytes
 02h	WORD	signature
 04h	WORD	number of sockets
 06h	WORD	revision level
 08h	WORD	Card Services level
 0Ah	WORD	offset of vendor string
 0Ch	WORD	length of vendor string
 0Eh	WORD	number of functions
 10h 255 BYTEs	vendor string
SeeAlso: #00702

Format of Card Services Client structure:
Offset	Size	Description	(Table 00701)
 00h	WORD	PCMCIA socket number
 02h	WORD	client attributes

Format of Cards Services Client Information:
Offset	Size	Description	(Table 00702)
 00h	WORD	maximum length of data in bytes (180)
 02h	WORD	(ret) length of returned data
 04h	WORD	attributes (see #00703)
 06h	WORD	revision level (BCD)
 08h	WORD	Card Services level (BCD)
 0Ah	WORD	revision date (DOS packed date format) (see #01666)
 0Ch	WORD	offset to name
 0Eh	WORD	length of name
 10h	WORD	offset to vendor string
 12h	WORD	length of vendor string
 14h 80 BYTEs	buffer for name
 64h 80 BYTEs	buffer for vendor string
SeeAlso: #00700,#00704

Bitfields for Card Services client attributes:
Bit(s)	Description	(Table 00703)
 0	memory client
 1	MTD client
 2	I/O client
 3	all clients can share this card
 4	only one client can use this card at a time
SeeAlso: #00702

Format of Card Services configuration information:
Offset	Size	Description	(Table 00704)
 00h	WORD	socket (usually 0000h)
 02h	WORD	attributes (see #00705)
 04h	BYTE	Vcc value
 05h	BYTE	Vpp1 value
 06h	BYTE	Vpp2 value
 07h	BYTE	interface type (see #00706)
 08h	DWORD	base address of configuration registers
 0Ch	BYTE	card's Status register setting (if present)
 0Dh	BYTE	card's Pin register setting (if present)
 0Eh	BYTE	card's Socket/Copy register setting (if present)
 0Fh	BYTE	card's Option register setting (if present)
 10h	BYTE	bitmap of present card configuration registers
 11h	BYTE	first device type
 12h	BYTE	function code
 13h	BYTE	SysInit mask
 14h	WORD	manufacturer code
 16h	WORD	manufacturer information
 18h	BYTE	valie card register values
 19h	BYTE	IRQ number assigned to PC Card
 1Ah	WORD	IRQ attributes (see #00708)
 1Ch	WORD	base port address (for I/O range 1)
 1Eh	BYTE	number of contiguous ports (for I/O range 1)
 1Fh	BYTE	bitmap of port attributes (for I/O range 1) (see #00709)
 20h	WORD	base port address (for I/O range 2)
 22h	BYTE	number of contiguous ports (for I/O range 2)
 23h	BYTE	bitmap of port attributes (for I/O range 2) (see #00709)
 24h	BYTE	number of I/O address lines decoded (16-bit PC Card only)
 25h	BYTE	extended status register setting (if present)
 26h	BYTE	bitmap of DMA attributes (see #00710)
		(note: value at call is used to set!)
 27h	BYTE	assigned DMA channel
 28h	BYTE	number of I/O windows in use on logical socket
 29h	BYTE	number of memory windows in use on logical socket
SeeAlso: #00703,#00724

Bitfields for Card Services Configuration attributes:
Bit(s)	Description	(Table 00705)
 0	exclusive
 1	IRQ active
 2	CardBus card
 3-5	reserved (0)
 6	DMA channel is active
 7	reserved (0)
 8	valid client
 9	overwrite voltage value
 10-15	reserved (0)
SeeAlso: #00704

Bitfields for Card Services Configuration interface type:
Bit(s)	Description	(Table 00706)
 0	memory interface
 1	I/O and memory interface
 2	CardBus interface
 3-7	reserved (0)
SeeAlso: #00704

Bitfields for Card Services Configuration registers:
Bit(s)	Description	(Table 00707)
 0	option value is value
 1	status value
 2	pin-replacement value
 3	copy value
 4	extended status value
 5-7	reserved (0)
SeeAlso: #00704

Bitfields for Card Services Configuration IRQ attributes:
Bit(s)	Description	(Table 00708)
 1-0	sharing
	00 no sharing
	01 time-multiplex sharing
	10 dynamic sharing
	11 reserved
 2	force pulse mode
 3	first used together
 4-7	reserved
 8	pulse IRQ has been assigned
 9-15	reserved
SeeAlso: #00704,#00709,#00710,#00715,#00718

Bitfields for Card Services Configuration Port attributes:
Bit(s)	Description	(Table 00709)
 0	shared I/O ports
 1	"CS_FirstCommonUsedCard"
 2	force alias access
 3	=1 sixteen-bit I/O
	=0 eight-bit I/O
 7-4	reserved (0)
SeeAlso: #00704,#00708,#00710,#00717

Bitfields for Card Services Configuration DMA attributes:
Bit(s)	Description	(Table 00710)
 1-0	sharing mode
	00 no sharing
	01 time-multiplex sharing
	10 dynamic sharing
	11 reserved
 3-2	DMA request signal
	00 reserved
	01 DMARQ uses pin SPKR#
	10 DMARQ uses pin IOIS16#
	11 DMARQ uses pin INPACK#
 4	DMA size
	0 eight bits
	1 sixteen bits
 7-5	reserved (0)
SeeAlso: #00704,#00708,#00709

Format of Card Services Tuple information:
Offset	Size	Description	(Table 00711)
 00h	WORD	logical socket number
 02h	WORD	attributes
		bit 0: return Link tuples
 04h	BYTE	code value of desired tuple
 05h	BYTE	reserved (0)
 06h	WORD	(ret) TupleFlags
 08h	DWORD	(ret) -> Card Services Link State Information
 0Ch	DWORD	(ret) -> Card Services CIS State Information
 10h	BYTE	(ret) code for tuple
 11h	BYTE	(ret) link value for tuple
SeeAlso: #00712

Format of Card Services GetTupleData record:
Offset	Size	Description	(Table 00712)
 00h	WORD	logical socket
 02h	WORD	attributes
 04h	BYTE	code value of desired tuple
 05h	BYTE	offset into tuple from link byte
 06h	WORD	flags
 08h	DWORD	-> Link
 0Ch	DWORD	-> CIS
 10h	WORD	(call) maximum amount of data to return (0004h)
 12h	WORD	(ret) amount of data returned
 14h	DWORD	(ret) tuple data
SeeAlso: #00711

Format of Card Services Client Registration record:
Offset	Size	Description	(Table 00713)
 00h	WORD	attributes
 02h	WORD	event mask
 04h	WORD	client data (passed to client event handler in DI)
--- 16-bit code ---
 06h	WORD	client data selector (passed to event handler in DS)
 08h	WORD	client data offset (passed to event handler in SI)
 0Ah	WORD	reserved
--- 32-bit code ---
 06h	WORD	reserved
 08h	DWORD	client data offset (passed to event handler in ESI)
------
 0Ch	WORD	expected Card Services version (0210h for v2.10)

Bitfields for Card Services client event codes:
Bit(s)	Description	(Table 00714)
 0	change in write-protect status
 1	change in card lock
 2	ejection request
 3	insertion request
 4	battery is dead
 5	battery low
 6	change in Ready
 7	change in Card Detect
 8	power management change
 9	reset
 10	Socket Services updated
 11	extended status change
SeeAlso: #00713

Format of Card Services ReleaseIRQ record:
Offset	Size	Description	(Table 00715)
 00h	WORD	logical socket number
 02h	WORD	attributes (see #00708)
 04h	BYTE	assigned IRQ number to be released

Format of Card Services Release Configuration record:
Offset	Size	Description	(Table 00716)
 00h	WORD	logical socket number

Format of Card Services Request I/O record:
Offset	Size	Description	(Table 00717)
 00h	WORD	logical socket number
 02h	WORD	base port 1
 04h	BYTE	size of port range 1
 05h	BYTE	attributes for port range 1 (see #00709)
 06h	WORD	base port 2
 08h	BYTE	size of port range 2
 09h	BYTE	attributes for port range 2 (see #00709)
 0Ah	BYTE	number of address lines (typically 16)
SeeAlso: #00718,#00716

Format of Card Services Request IRQ record:
Offset	Size	Description	(Table 00718)
 00h	WORD	logical socket number
 02h	WORD	attributes (see #00708)
 04h	BYTE	(ret) assigned IRQ number, if successful
 05h	BYTE	IRQ info (see #00719)
 06h	WORD	bitmap of available IRQs (bit 0 = IRQ0, etc.)
		(only if bit 4 of IRQ info set)
SeeAlso: #00717,#00716

Bitfields for Card Services Request IRQ info flags:
Bit(s)	Description	(Table 00719)
 7	IRQ is shared
 6	pulse (edge-triggered) interrupt
 5	level interrupt
 4	use IRQ bitmap
--- bit 4 set ---
 3	vendor-specific interrupt
 2	bus error
 1	I/O check interrupt
 0	NMI
--- bit 4 clear ---
 3-0	IRQ number
SeeAlso: #00718

Format of Card Services Request Window record:
Offset	Size	Description	(Table 00720)
 00h	WORD	logical socket number
 02h	WORD	attributes (see #00721)
 04h	DWORD	system base adress
 08h	DWORD	size of memory window
 0Ch	BYTE	additional info
		if attributes bit ??? is set, this is the address-lines field
		otherwise, this is the access-speed field (see #00722)

Bitfields for Card Services Request Window attributes:
Bit(s)	Description	(Table 00721)
 0	I/O window instead of memory window
 1	attribute memory instead of normal memory (16-bit PC Cards only)
 2	window enabled
 3	16-bit data path instead of 8-bit path (16-bit PC Cards only, v2.10+)
	(ignored if bit 9 set)
 4	size is given in 16K pages (invalid for CardBus PC Cards)
 5	shared (invalid for CardBus)
 6	first shared (invalid for CardBus)
 7	"CS_BindingSpecific" (memory window only)
 8	card offsets are window-size granular (16-bit PC Card memory window)
 9	32-bit data path (CardBus only)
 10	reserved (0)
 12-11	prefetch/cache
	00 neither prefetchable nor cacheable
	01 prefetchable but not cacheable
	10 prefetchable and cachable
	11 reserved
 15-13	decoded base address register number (CardBus only)
SeeAlso: #00720,#00722

Bitfields for Card Services Request Window access-speed:
Bit(s)	Description	(Table 00722)
 6-3	mantissa
	0000 use device speed code
	0001  1.0
	0010  1.2
	0011  1.2 ???
	0100  1.5
	0101  2.0
	0110  2.5
	0111  3.0
	1000  3.5
	1001  4.0
	1010  4.5
	1011  5.0
	1100  5.5
	1101  6.0
	1110  7.0
	1111  8.0
--- if mantissa==0 ---
 2-0	device speed code
	000 reserved
	001 250 ns
	010 200 ns
	011 150 ns
	100 100 ns
	101-111 reserved
--- if mantissa<>0 ---
 2-0	speed exponent
	000	1 ns
	001    10 ns
	010   100 ns
	011	1 us
	100    10 us
	101   100 us
	110	1 ms
	111    10 ms
SeeAlso: #00720,#00721

Format of Card Services Request/Release Exclusive Access record:
Offset	Size	Description	(Table 00723)
 00h	WORD	logical socket number
 02h	WORD	attributes (currently all reserved, must be 0000h)

Format of Card Services Request Configuration record:
Offset	Size	Description	(Table 00724)
 00h	WORD	socket (usually 0000h)
 02h	WORD	attributes (see #00705)
 04h	BYTE	Vcc value
 05h	BYTE	Vpp1 value
 06h	BYTE	Vpp2 value
 07h	BYTE	interface type (see #00706)
 08h	DWORD	base address of configuration registers
 0Ch	BYTE	card's Status register setting (if present)
 0Dh	BYTE	card's Pin register setting (if present)
 0Eh	BYTE	card's Socket/Copy register setting (if present)
 0Fh	BYTE	card's Option register setting (if present)
 10h	BYTE	bitmap of present card configuration registers
 11h	BYTE	extended status register setting (if present)
SeeAlso: #00704
--------X-1AB000-----------------------------
INT 1A U - HP 100LX/200LX - PCMCIA - ???
	AX = B000h
	ES:BX -> parameter block ???
Return: CF clear if ???
	CF set if ???
Note:	called by HP 100LX/200LX PCMCIA client CIC100.EXE
--------d-1AB001CX4D52-----------------------
INT 1A - Microsoft Real-Time Compression Interface (MRCI) - ROM-BASED SERVER
	AX = B001h
	CX = 4D52h ("MR")
	DX = 4349h ("CI")
Return: CX = 4943h ("IC") if installed
	DX = 524Dh ("RM") if installed
	    ES:DI -> MRCINFO structure (see #00725)
Note:	this call is functionally identical to INT 2F/AX=4A12h, which should
	  be called first, as this call is used for the first, ROM-based
	  MRCI server, while the other call is used for RAM-based servers
	  which may be partially or entirely replacing a prior server
SeeAlso: INT 2F/AX=4A12h

Format of MRCINFO structure:
Offset	Size	Description	(Table 00725)
 00h  4 BYTEs	vendor signature
		"MSFT" Microsoft
 04h	WORD	server version (high=major)
 06h	WORD	MRCI specification version
 08h	DWORD	address of server entry point (see #00727)
 0Ch	WORD	bit flags: server capabilities (see #00726)
 0Eh	WORD	bit flags: hardware assisted capabilities (see #00726)
 10h	WORD	maximum block size supported by server (at least 8192 bytes)

Bitfields for MRCI capabilities:
Bit(s)	Description	(Table 00726)
 0	standard compress
 1	standard decompress
 2	update compress
 3	MaxCompress (not present in initial public release)
 4	reserved
 5	incremental decompress
 6	MRCI 2.0 standard compress
 7	MRCI 2.0 standard decompress
 8-14	reserved
 15	this structure is in ROM and can't be modified
	(server capabilities only)

(Table 00727)
Call MRCI entry point with:
	DS:SI -> MRCREQUEST structure (see #00728)
	CX = type of client (0000h application, 0001h file system)
	AX = operation
	    0001h perform standard compression
	    0002h perform standard decompression
	    0004h perform update compression
	    0008h perform MaxCompress
	    0020h perform incremental decompression
	    0040h perform MRCI 2.0 standard compression
	    0080h perform MRCI 2.0 standard decompression
	AX = FFFFh clear flags
	    BX = bitmask of flags to clear (set bits in BX are flags to clear)
Return: AX = status
	    0000h successful
	    0001h invalid function
	    0002h server busy, try again
	    0003h destination buffer too small
	    0004h incompressible data
	    0005h bad compressed data format
	BP destroyed (MS-DOS 6.2)
Note:	MRCI driver may chain to a previous driver

Format of MRCREQUEST structure:
Offset	Size	Description	(Table 00728)
 00h	DWORD	pointer to source buffer
 04h	WORD	size of source buffer (0000h = 64K)
 06h	WORD	(UpdateCompress only)
		(call) offset in source buffer of beginning of changed data
		(ret) offset in destination buffer of beginning of changed
			  compressed data
 08h	DWORD	pointer to destination buffer
		must contain original compressed data for UpdateCompress
 0Ch	WORD	size of destination buffer (0000h = 64K)
		any compression: size of buffer for compressed data
		standard decompression: number of bytes to be decompressed
		incremental decompression: number of byte to decompress now
		(ret) actual size of resulting data
 0Eh	WORD	client compressed data storage allocation size
 10h	DWORD	incremental decompression state data
		set to 00000000h before first incremental decompression call
Notes:	the source and destination buffers may not overlap
	the source and destination buffer sizes should normally be the same
	application should not update the contents of the MRCREQUEST structure
	  between incremental decompression calls
--------!---Section--------------------------
