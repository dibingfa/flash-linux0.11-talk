Interrupt List, part 13 of 18
Copyright (c) 1989-1999,2000 Ralf Brown
--------N-2F7A00-----------------------------
INT 2F - Novell NetWare - LOW-LEVEL API (IPX) INSTALLATION CHECK
	AX = 7A00h
Return: AL = status
	    00h not installed
	    FFh installed
		ES:DI -> FAR entry point for routines accessed exclusively
			  through INT 7A in NetWare versions through 2.0a.
			  Call with same values as INT 7A
		ES:BX -> two bytes containing IPX major/minor version
			(IPXODI v2.12; BX unchanged by older IPX drivers)
		CX = ES ???
SeeAlso: AX=7AFFh/BX=0000h,AX=D800h,INT 64"Novell",INT 7A"LOW-LEVEL API"
--------N-2F7A10-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET TBMI STATUS
	AX = 7A10h
Return: DH = major TBMI version number
	DL = minor TBMI version number (01h for v1.1)
	CX = segment address of TBMI resident part
	BX = status word of TBMI (see #02857)
Note:	TBMI is the Task-Switched Buffer Manager Interface
SeeAlso: AX=7A11h,AX=7A12h,AX=7A13h,AX=7A14h

Bitfields for NetWare TBMI status word:
Bit(s)	Description	(Table 02857)
 0	INT2F intercepted by TBMI
 1	INT7A intercepted by TBMI
 2	INT64 intercepted by TBMI
 3-14	reserved or unused ???
 15	outstanding task ID was detected
--------N-2F7A11-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET INT2F HANDLERS
	AX = 7A11h
Return: ES:BX -> old INT 2F handler
	DS:DX -> TBMI INT 2F handler
SeeAlso: AX=7A10h,AX=7A12h,AX=7A13h,AX=7A1Ah
--------N-2F7A12-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET INT64 HANDLERS
	AX = 7A12h
Return: ES:BX -> old INT 64 handler
	DS:DX -> TBMI INT 64 handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A13h
--------N-2F7A13-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET INT7A HANDLERS
	AX = 7A13h
Return: ES:BX -> old INT 7A handler
	DS:DX -> TBMI INT 7A handler
SeeAlso: AX=7A10h,AX=7A11h,AX=7A12h
--------N-2F7A14-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - GET STATISTICS
	AX = 7A14h
	CX = statistic to retrieve
	    0000h available diagnostic functions???
		Return: CX = maximum available function??? (000Ch for v2.0)
	    0001h buffers in use
		Return: CX = TBMI buffers currently in use
	    0002h maximum buffers used
		Return: CX = maximum number of buffers ever in use
	    0003h unavailable buffers
		Return: CX = count of unavailable TBMI buffers
	    0004h old interrupt usage
		Return: CX = TBMI accesses to intercepted old vectors INT 2F,
			      INT 64, and INT 7A
	    0005h far call usage
		Return: CX = TBMI accesses to IPX/SPX far call handler (not
			      including internal accesses)
	    0006h task buffering
		Return: CX = TBMI task buffering status (enabled/disabled or
			      disable/enable switch count???)
	    0007h current task ID
		Return: CX = TBMI current task ID number (0000h if ???)
	    0008h outstanding ID count
		Return: CX = number of outstanding TBMI IDs
	    0009h configured ECBs
		Return: CX = number of TBMI Event Control Blocks configured
	    000Ah configured data ECBs
		Return: CX = number of TBMI data ECBs configured
	    000Bh configured sockets
		Return: CX = number of TBMI sockets configured (from NETCFG)
	    000Ch current sockets
		Return: CX = number of TBMI sockets currently in use
Return: BX = maximum supported subfunction (000Ch)
SeeAlso: AX=7A10h
--------N-2F7A15-----------------------------
INT 2F OU - Novell NetWare - TBMI v1.1 only - RESET ???
	AX = 7A15h
Return: BX = new value of ???
Desc:	set ??? to its default value
Note:	this call is a NOP under TBMI v2.0 (TBMI2)
SeeAlso: AX=7A17h
--------N-2F7A16-----------------------------
INT 2F OU - Novell NetWare - TBMI v1.1 only - ???
	AX = 7A16h
	CX = ???
	???
Return: ???
Note:	this call is a NOP under TBMI v2.0 (TBMI2)
--------N-2F7A17-----------------------------
INT 2F OU - Novell NetWare - TBMI v1.1 only - ???
	AX = 7A17h
	???
Return: BX = old value of ???
	CX = new value of ???
Note:	this call is a NOP under TBMI v2.0 (TBMI2)
SeeAlso: AX=7A15h
--------N-2F7A18-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - INSTALLATION CHECK
	AX = 7A18h
Return: AL = FFh if installed
	    BX = configuration flags (see #02858)
	    CX = resident code segment
SeeAlso: AX=7A10h

Bitfields for NetWare TASKID configuration flags:
Bit(s)	Description	(Table 02858)
 0	INT 2F hooked
 3	INT 08 hooked
 other	unused
--------N-2F7A19-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - GET INT 08 HANDLERS
	AX = 7A19h
Return: AL = FFh
	DS:DX -> TASKID INT 08 handler
	ES:BX -> original INT 08 handler
--------N-2F7A1A-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - GET INT 2F HANDLERS
	AX = 7A1Ah
Return: AL = FFh
	DX:DX -> TASKID INT 2F handler
	ES:BX -> original INT 2F handler
SeeAlso: AX=7A11h,AX=7A19h
--------N-2F7A1B-----------------------------
INT 2F U - Novell NetWare - TASKID v1.0 - GET DIAGNOSTICS INFORMATION
	AX = 7A1Bh
	CX = desired information
	    0000h supported functions
	    0001h TASKID ID number
		Return: CX = ID number
	    0002h set-ID count
		Return: CX = ID set count
Return: AL = FFh
	BX = highest supported subfunction number (0002h)
SeeAlso: AX=7A14h,AX=7A18h
--------N-2F7A1C-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - ???
	AX = 7A1Ch
	BP = ???
	CX:DX = ???
Return: AX = 70FFh
--------N-2F7A1D-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - ???
	AX = 7A1Dh
	???
Return: ES = ???
	???
	SI destroyed
--------N-2F7A1E-----------------------------
INT 2F U - Novell NetWare - TBMI v1.1+ - ???
	AX = 7A1Eh
	ES:SI -> ???
	???
Return: ???
--------N-2F7A20BX0000-----------------------
INT 2F - Novell NetWare - Adv NetWare 4.0 DOS Requester - GET VLM CALL ADDRESS
	AX = 7A20h
	BX = 0000h
Return: AX = 0000h on success (installed)
	    ES:BX -> far call address for DOS Requester (see #02859)
Notes:	the DOS Requester replaces the NetWare Shell (ANETx, NETx) on
	  NetWare LAN's as of the release of Advanced NetWare 4.0 (1993).  It
	  is backward compatible with NetWare 2.1x through 3.11 servers as
	  well.	 Note that there was a NetWare 4.0 in the early 1980's, which
	  can cause confusion.
	this call is used as the installation check by VLM.EXE, which is the
	  loader for all the modules of the DOS Requester
	.VLMs are standard old .EXE format executables whose normal entry point
	  merely terminates to prevent loading from the command line (Novell's
	  VLMs all return errorlevel 6).  The real entry point is found by
	  looking at the VLM header at the beginning of the load image
	  (see #02862)
Index:	installation check;NetWare 4.0 DOS Requester
SeeAlso: AX=7A20h/BX=0001h,AX=7A20h/BX=0002h

(Table 02859)
Call DOS Requester entry point with:
	STACK:	WORD	destination function
		WORD	destination VLM ID (see #02861)
		WORD	source VLM ID (0000h = application program)
	other registers (except BP) as appropriate for function
Return: AX = status code (0000h,8811h,8846h,8848h,8853h) (see #02860)
	ZF set if successful, clear on error
	other registers as appropriate for function
	STACK popped
	BP destroyed

(Table 02860)
Values for VLM status code:
 0000h	successful
 88xxh	error generated by requester
 8801h	invalid or non-attached connection handle
 8802h	drive in use (OS/2 only)
 8803h	cannot add CDS
 8804h	bad path
 8805h	error sending or receiving NCP packets
 8806h	unknown network error
 8807h	invalid server connection slot
 8808h	no connection slots available
 880Ah	no route to server
 880Bh	"BAD_LOCAL_TARGET" (OS/2 only)
 880Ch	too many request fragments
 880Dh	"CONNECT_LIST_OVERFLOW" (OS/2 only)
 880Eh	buffer overflow on receive
 880Fh	no connection to server
 8810h	no router found (OS/2 only)
 8811h	nonexistent function called
 8830h	internal server request attempted between two separate connections
 8831h	no primary connection set
 8833h	invalid buffer length
 8834h	invalid user name
 8835h	no local print spooler installed
 8836h	attempted function with invalid parameter
 8837h	failed to open configuration file (OS/2 only)
 8838h	no configuration file (OS/2 only)
 8839h	configuration file read failed (OS/2 only)
 883Ah	line too long in configuration file (OS/2 only)
 883Bh	configuration lines ignored (OS/2 only)
 883Ch	foreign resource
 883Dh	daemon already installed (OS/2 only)
 883Eh	print spooler already installed
 883Fh	local connection table already full
 8840h	configuration section not found (OS/2 only)
 8841h	invalid transport type
 8842h	TDS tag in use (OS/2 only)
 8843h	TDS out of memory (OS/2 only)
 8844h	called TDS function with invalid tag
 8845h	TDS write was truncated
 8846h	called partially asynchronous function while it was busy
 8847h	unable to find any responding servers
 8848h	non-loaded or nonexistent VLM called
 8849h	network drive already mapped
 884Ah	attempted map to local drive which was already in use
 884Bh	no more drives available for mapping
 884Ch	device is not redirected
 884Dh	no more SFT entries (too many handles)
 884Eh	unable to unload
 884Fh	connection entry was already in use
 8850h	too many reply fragments
 8851h	name table already full
 8852h	socket not open
 8853h	memory management error
 8854h	SFT III switch occurred in mid-transfer
 8855h	preferred server was not found (alternate returned)
 8856h	device not recognized
 8857h	bad network byte
 88A0h	memory allocation error
 88A1h	connection timeout failure
 88A2h	transport: bad request
 88A3h	specified transport not installed
 88A4h	unable to open connection with specified parameters
 88A6h	unsupported function
 88A7h	no such task
 88A8h	too many tasks
 88A9h	version mismatch
 88AAh	request cancelled
 88ABh	invalid NDS name
 88ACh	unable to perform operation while logged into NDS
 88ADh	requester not available for use
 88AEh	MacIPX not configured properly
 88AFh	no servers found
 88B0h	no volume or session associated with identifier
 88B1h	not a NetWare volume
 88B2h	MacIPX version incompatible with Requester
 88B4h	MacIPX not open
 88B5h	insufficient stack
 88B6h	client API already initialized
 88B7h	checksums required by client are not available
 88B8h	packet signing required by client are not available
 88B9h	server requires checksum
 88BAh	server requires packet signing
 88BBh	already logged in
 88BCh	negotiated checksums but connection timed out
 89xxh	error generated by server
	low byte = return code from server (see also #01927,#01961)
 8900h	server successful
 8901h	out of disk space
 897Eh	NCP boundary check failed
 897Fh	???
 8980h	lock failed; file in use
 8981h	out of handles
 8982h	no open privileges
 8983h	hard (non-correctable) I/O error
 8984h	no creation privileges
 8985h	no create/delete privileges
 8986h	attempted to create a file which already exists read-only
 8987h	filename error during creation (wildcards in name)
 8988h	invalid file handle
 8989h	no search privileges
 898Ah	no deletion privileges
 898Bh	no rename privileges
 898Ch	no modify privileges
 898Dh	some affected files are in use
 898Eh	all affected files are in use
 898Fh	some affected files are read-only
 8990h	all affected files are read-only; volume read-only
 8991h	some files could not be renamed because target names already exist
 8992h	all affected names exist
 8993h	no read privileges
 8994h	no write privileges
 8995h	file detached
 8996h	server out of memory
 8997h	no disk space for spool file
 8998h	disk map error; volume does not exist
 8999h	directory full
 899Ah	attempt to rename across volumes
 899Bh	bad directory handle
 899Ch	invalid path; no more trustees
 899Dh	no directory handles
 899Eh	bad filename
 899Fh	directory active
 89A0h	directory not empty
 89A1h	directory I/O error
 89A2h	I/O lock error
 89A3h-89A5h ???
 89A6h	auditing is active
 89A7h	auditing version error
 89A8h	no auditing rights
 89A3h-89BEh ???
 89BFh	invalid name space
 89C0h	no account privileges
 89C1h	no account balance
 89C2h	credit limit exceeded
 89C4h	account disabled
 89C5h	login lockout (intruder detection activated)
 89C6h	no console rights
 89C7h-89CFh
 89D0h	queue error
 89D1h	no queue
 89D2h	no queue server
 89D3h	no queue rights
 89D4h	queue full
 89D5h	no queue job
 89D6h	no job rights; unencrypted password
 89D7h	queue servicing error; duplicate password; bad account
 89D8h	queue not active; password too short
 89D9h	station not queue server; maximum logins exceeded
 89DAh	queue halted; bad login time
 89DBh	maximum queue servers; unauthorized login station
 89DCh	account disabled or expired
 89DEh	password expired (all grace logins used up)
 89DFh	password expired but login allowed (grace login)
 89E0h-89E6h ???
 89E7h	no disk track
 89E8h	property is not an item property; write to group
 89E9h	member exists
 89EAh	no such member
 89EBh	property is not a set property
 89ECh	no such set
 89EDh	property exists
 89EEh	object exists
 89EFh	illegal name
 89F0h	illegal wildcard
 89F1h	invalid bindery security level
 89F2h	not allowed to read object
 89F3h	not allowed to write/rename object
 89F4h	not allowed to delete object
 89F5h	not allowed to create object
 89F6h	not allowed to delete property
 89F7h	not allowed to create property; attempt to use non-local drive
 89F8h	not allowed to write property; already attached to server
 89F9h	not allowed to read property; no free connection slots
 89FAh	temporary remap error; no more server slots
 89FBh	no such property; invalid parameters
 89FCh	no such object; internet packet request canceled; unknown file server
 89FDh	bad station number; lock collision
 89FEh	directory locked; bindery locked; timeout
 89FFh	general error; hard error; lock error
Note:	some server-generated error codes have multiple interpretations; use
	  the one appropriate to the failing call

(Table 02861)
Values for VLM identifier:
 0001h	VLM.EXE		Virtual Loadable Modules manager (see also #02864)
 0010h	CONN.VLM	connection table manager (see also #02867)
 0020h	TRAN.VLM	transport protocol multiplexor (see also #02871)
 0021h	IPXNCP.VLM	transport protocol implementation using IPX (see #02873)
 0022h	TCPNCP.VLM	TCP/IP transport
 0030h	NWP.VLM		NetWare protocol multiplexor (see also #02875)
 0031h	BIND.VLM	bindery
 0032h	NDS.VLM		NetWare Directory Services (see also #02877)
 0033h	PNW.VLM		Personal NetWare
 0034h	RSA.VLM		RSA encryption for directory services re-authentication
 0040h	REDIR.VLM	DOS redirector (see also #02879)
 0041h	FIO.VLM		file I/O (see also #02882)
 0042h	PRINT.VLM	printer redirector (see also #02884)
 0043h	GENERAL.VLM	misc functions for NETx and REDIR (see also #02888)
 0050h	NETX.VLM	NetWare shell compatibility (see also #02890)
 0060h	AUTO.VLM	auto-reconnect/auto-retry
 0061h	SECURITY.VLM	enhanced security module (see #02892)
 0100h	NMR.VLM		NetWare management responder
 09F2h	DRVPRN.VLM	Desktop SNMP Services - Drive/Printer Mappings
 09F5h	SAA.VLM		SAA client API for Netware
 09F6h	IPXMIB.VLM	SNMP IPX-monitoring Module???
 09F7h	PNWMIB.VLM	Personal Netware SNMP Instrumentation Module
 09F8h	PNWTRAP.VLM	Personal Netware SNMP Trap Module
 09F9h	MIB2PROT.VLM	MIB-II Protocol Groups
 09FAh	MIB2IF.VLM	MIB-II Interfaces Group
 09FBh	NVT.VLM		???
 09FCh	WSTRAP.VLM	Desktop SNMP Services - Trap Module
 09FDh	WSREG.VLM	Desktop SNMP Services - Registration Module
 09FEh	WSASN1.VLM	Desktop SNMP Services - ASN.1 Module
 09FFh	WSSNMP.VLM	Desktop SNMP Services - Agent Module

Format of VLM header:
Offset	Size	Description	(Table 02862)
 00h	DWORD	-> initialization entry point
 04h	DWORD	-> VLM API entry point
 08h	DWORD	-> ??? entry point
 0Ch	DWORD	-> ??? entry point
 10h	DWORD	-> ??? entry point
	...
 var	DWORD	00000000h (end of entry point list)
      4 BYTEs	signature "NVlm"
	WORD	VLM identifier (see #02861)
---v1.20+ ---
 1Eh	WORD	???
 20h	WORD	Transient Switch Count
 22h	WORD	VLM Call Count
 24h	WORD	Offset ControlBlocks (See #02863)
 26h	WORD	Current VLMID
 28h	BYTE	Memory Type
		00h=Conventional 02h=EMS 04h=XMS
 29h	BYTE	Modules Loaded
 2Ah	WORD	BlockId
 2Ch	WORD	Transient Block
 2Eh	WORD	Global Segment
 30h  3	DWORDs	pointers to AsyncQueue head, tail, and s???
 3Ch  3	DWORDs	pointers BusyQueue head, tail, and s???
 48h	WORD	ReEntrance Level
 4Ah	WORD	Full Map Count
 4Ch	WORD	???
 4Eh 80 BYTEs	ASCIZ configuration file filename
Note:	the number of entry points in the header is reported as "Func" in the
	  VLM /D display.

Format of VLM Control Block for VLM v1.20 [array]:
Offset	Size	Description	(Table 02863)
 00h	WORD	Flag
 02h	WORD	VLM Identifier (See #02861)
 04h	WORD	Func
 06h	WORD	Maps
 08h	WORD	number of times called
 0Ah	WORD	???
 0Ch	WORD	Transient Segment
 0Eh	WORD	Global Segment
 10h	WORD	Address Low
 12h	WORD	Address High
 14h	WORD	TSegSize
 16h	WORD	GSegSize
 18h	WORD	SSegSize
 1Ah	BYTE	VLMName[9] ASCIZ
Note:	this information is shown in VLM /d under the dashed line. There are
	  as many 35-byte blocks as modules loaded
SeeAlso: #02862

(Table 02864)
Call VLM Manager (VLM.EXE, ID 0001h) with:
Func	Description/Registers
 01h	VLM Notify
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	VLM Statistics
	CX = length of buffer
	ES:DI -> buffer for statistics (see #02865)
	Return: AX = status (0000h if successful)
		buffer filled if successful
 04h	VLM internal use
	BX = function
	    0000h get interrupt vector (calls INT 21/AH=35h)
	    0001h begin critical section (calls INT 2F/AX=1681h)
	    0002h end critical section (calls INT 2F/AX=1682h)
	    0003h ???

Format of VLM.EXE statistics:
Offset	Size	Description	(Table 02865)
 00h	WORD	size of statistics record in bytes (including this word)
 02h	WORD	number of times a VLM has been mapped into memory
 04h	WORD	number of times a VLM has been called
 06h	WORD	offset of vcbArray buffer
 08h	WORD	VLM ID of VLM currently mapped into memory
 0Ah	BYTE	memory type: conventional/EMS/XMS
 0Bh	BYTE	number of loaded VLMs
 0Ch	WORD	EMS/XMS handle or 0000h if conventional memory
 0Eh	WORD	start segment for conventional memory swap
 10h	WORD	segment for global memory, or 0000h if conventional memory
 12h 12 BYTEs	queue structure for asynchronous calls (see #02866)
 1Eh 12 BYTEs	queue structure for synchronous calls (see #02866)
 2Ah	WORD	current re-entrance level
 2Ch	WORD	number of times EMS/XMS map-out performed
 2Eh	BYTE	stack switch control
 2Fh	BYTE	flag: nonzero if switcher loaded
 30h 80 BYTEs	pathname of configuration file
SeeAlso: #02864

Format of VLM.EXE queue structure:
Offset	Size	Description	(Table 02866)
 00h	DWORD	queue head (initially 00000000h)
 04h	DWORD	queue tail (initialized to be same as head)
 08h	WORD	current queue size (number of nodes in queue)
 0Ah	WORD	maximum queue size (in nodes)
SeeAlso: #02865

(Table 02867)
Call Connection Manager (CONN.VLM, ID 0010h) with:
Func	Description/Registers
 01h	Conn Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Conn Statistics
	CX = length of buffer
	ES:DI -> buffer for connection statistics (see #02868)
	Return: AX = status (0000h successful)
 04h	Conn Alloc Handle
	Return: AX = status (0000h successful)
		CX = connection handle
 05h	Conn Validate Handle
	CX = connection handle
	Return: AX = 0000h if valid handle
 06h	Conn Free Handle
	CX = connection handle
	Return: AX = status (0000h successful)
 07h	Conn Get Entry Field
	BH = connection parameter (see #02870)
	CX = connection handle
	DX = value if BH is non-array parameter
	DH = offset in array if BH is array parameter
	DL = number of bytes to copy if BH is array
	ES:DI -> return buffer if BH is array
	Return: AX = 0000h if successful
		DL/DX = value if non-array parameter
		DH = maximum number of bytes in buffer if array parameter
		DL = number of bytes copied if array
		BX destroyed
 08h	Conn Set Entry Field
	BH = connection parameter (see #02870)
	CX = connection handle
	DL/DX = value if BH is non-array parameter
	DH = offset in array if BH is array parameter
	DL = number of bytes to copy if BH is array
	DS:SI -> buffer if BH is array
	Return: AX = 0000h if successful
		DH = maximum number of bytes in buffer
		DL = number of bytes copied
		BX destroyed
 09h	Conn Reset Entry Field
	BH = connection parameter (see #02870)
	CX = connection handle
	Return: AX = 0000h if successful
		BX,DX destroyed
 0Ah	Conn Lookup Handle
	BL = lookup type (00h equal, 40h not equal)
	BH = connection parameter (see #02870)
	CX = connection handle, 0000h if first
	DL/DX = value if BH is non-array parameter
	DH = offset in array if BH is array parameter
	DL = number of bytes to copy if BH is array
	DS:SI (ES:DI???) -> buffer if BH is array
	Return: AX = 0000h if successful
		CX = handle matching given parameters
 0Dh	Conn Name Lookup
	CX = connection handle
	ES:DI -> 49-byte buffer for server name or 0000h:0000h
	Return: AX = 0000h if successful
		BX = length of server name
		ES:DI buffer filled if pointer not 0000h:0000h
 0Eh	Conn Name To Handle
	DS:SI -> uppercased server name
	CX = length of server name, 0000h if ASCIZ name
	Return: AX = error code or 0000h if successful
		    CX = connection handle if successful
 0Fh	Conn Get Num Connections
	Return: AX = status (0000h if successful)
		DX = number of connections
		CX = segment of connection table
		    first entry in table (See #02869)

Format of VLM connection statistics:
Offset	Size	Description	(Table 02868)
 00h	WORD	total length of statistics record (including this word)
 02h	WORD	number of connection handles allocated
 04h	WORD	average name length (configured in NET.CFG)
 06h	WORD	maximum number of tasks (configured in NET.CFG)
 08h	WORD	number of failed "allocate handle" calls
 0Ah	WORD	number of failed "add name" calls
 0Ch	WORD	number of failed task calls
Note:	some versions of the NetWare requester reportedly do not implement
	  this correctly
SeeAlso: #02867

Format of NetWare VLM Connection Table [array]:
Offset	Size	Description	(Table 02869)
 00h	WORD	Protocol VLMid	  0032(NDS) 0031(BIND)		Func 07 equiv.
				  0033(PNW) 0000(unused)       BH=01h
 02h	BYTE	(connection status)
		bit 6: connection locked		       BH=16h
		bit 5: authenticated			       BH=03h
		bit 4: permanent			       BH=02h
		bit 2: broadcast msg waiting		       BH=12h
 03h	BYTE	(connection capabilities)
		bit 5: Large Internet Packets		       none
		bit 3: Packet Burst Reset		       BH=07h
		bit 2: Max I/O				       BH=06h
		bit 1: SFT3 change			       BH=05h
		bit 0: Packet Burst Support		       BH=04h
 04h	WORD	reference count				       BH=09h
 06h	WORD	soft resource count			       BH=15h
 08h	BYTE	NCP Order Number			       BH=0Eh
 09h	BYTE	Server security options			       BH=14h
		bit 0: CRC enabled
		bit 1: packet signing required
		bit 5: packet signing enabled
 0Ah	BYTE	OS Major Version			       BH=08h
 0Bh	BYTE	OS Minor Version			       BH=08h
 0Ch	WORD	Hops to Server				       BH=0Ah
 0Eh	WORD	Maximum Packet Size for this connection	       BH=0Bh
 10h	WORD	LIP Parameters				       BH=13h
 12h	WORD	NCP Request Type			       BH=10h
 14h	BYTE	NCP Sequence				       BH=0Ch
 15h	WORD	Connection Number			       BH=0Dh
 17h	BYTE	???					       none
 18h	WORD	Transport VLMid 21(IPXNCP) 22(TCPNCP)	       BH=0Fh
 1Ah	BYTE	Node Address[4]				       BH=11h
 1Eh	BYTE	Network[6]				       BH=11h
 24h	BYTE	Socket[2]				       BH=11h
 26h	BYTE	Local Target[6]				       BH=11h
 2Ch	WORD	Round Trip Time				       BH=11h
 2Eh	WORD	???					       none
SeeAlso: #02867

(Table 02870)
Values for NetWare Connection Manager CEI (Connection Entry Information):
 number	flags	description
 00h	FR	error
 01h	WL	VLM id of transport protocol (NDS/BIND/PNW)
		00h = wildcard
 02h	FR	permanent flag (01h if connection is permanent)
 03h	F	authenticated flag (01h if connection is authenticated)
 04h	F	packet burst supported
 05h	FR	SFT3 change status
 06h	FR	connection needs maximum I/O transmission
 07h	FR	packet burst reset needed
 08h	W	server version
 09h	W	reference count (tasks using connection, 00h = dynamic)
 0Ah	W	distance to server associated with connection
 0Bh	W	maximum packet size supported by transport protocol
 0Ch	B	NCP sequence number
 0Dh	W	connection number
 0Eh	B	NCP order number
 0Fh	WL	VLM id for transport protocol
		00h = wildcard, 21h = IPX, 22h = TCP
 10h	W	NCP request type
 11h	A	transport specific buffer
		12 byte server address
		6 byte	router address
		2 byte round trip time
 12h	FR	broadcast message waiting
 13h	W	large internet packets supported
 14h	B	security options
		bit 0: CRC enabled
		bit 1: packet signing enabled
		bit 5: packet signing active
 15h	W	soft resource count
 16h	FR	connection locked
Note:	flag meanings
	    F=flag value
	    B=byte value
	    W=word value
	    A=array
	    R=resettable
	    L=settable only before authentication
	    others=read only
SeeAlso: #02867

(Table 02871)
Call TRAN.VLM (VLM ID 0020h) with:
Func	Description/Registers
 01h	TRAN Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	TRAN Statistics
 06h	TRAN Request Reply (see INT 21/AH=F2h)
	AL = NCP request code (see #02095 at INT 21/AH=F2h)
	BH = error handler flag
	    00h default error handler
	    01h return network errors to caller
	    02h handle network errors in requester
	BL = request list length (max 5 fragments) (see #02872)
	CX = connection handle
	DH = 00h (reserved)
	DL = reply list length (max 5 fragments) (see #02872)
	DS:SI -> address list (each element is DWORD address + WORD length)
	ES:DI -> address list
	Return: AX = error code, 0000h if successful (see #02860)
		BX,DX destroyed
		ES:DI buffer filled with reply packet fragments
 08h	TRAN Schedule/Cancel Event
	BX = subfunction
	    0000h schedule event
		AX = number of timer ticks to delay before calling function
		ES:SI -> event control block (including valid call address)
	    0001h cancel event
		ES:SI -> event control block (including call address)
	Return: AX = status (0000h = successful) (see #02860)
 09h	TRAN Get Max Phys Size
	BX = subfunction
	    00h get maximum node size
		Return: AX = status (0000h = successful) (see #02860)
			BX = maximum supported physical packet size
			DX = size of protocol header
			SI = RequestReply socket number
	    01h get maximum route size to specified server
		CX = connection handle for route to be checked
		Return: AX = status (0000h = successful) (see #02860)
			DX = maximum supported packet size for current route
 0Ah	TRAN Broadcast Mux
	BX = subfunction
	    0001h get stored broadcast (Personal NetWare)
		ES:DI -> 60-byte buffer for counted ASCIZ message string
	Return: AX = status (0000h = successful) (see #02860)

Format of TRAN.VLM request/reply fragment descriptor (array):
Offset	Size	Description	(Table 02872)
 00h	DWORD	address of buffer
 04h	WORD	length of buffer

(Table 02873)
Call IPXNCP.VLM (VLM ID 0021h) with:
Func	Description/Registers
 01h	IPX Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	IPX Statistics
	CX = length of buffer
	ES:DI -> buffer for statistics (see #02874)
	Return:	AX = status (see #02860)
 06h	IPXNCP Request Reply???
	functionally equivalent to Tran Request Reply???

Format of NetWare IPX statistics:
Offset	Size	Description	(Table 02874)
 00h	WORD	size of statistics, including this word
 02h	DWORD	number of TRAN Request Reply calls made
 06h	WORD	number of user aborts
 08h	WORD	number of user retries
 0Ah	WORD	IPX receive errors
 0Ch	WORD	IPX send errors
 0Eh	WORD	number of unrecognized responses
 10h	WORD	number of bad connection numbers in requests
 12h	WORD	number of bad sequence responses
 14h	WORD	receive buffer overflows
 16h	WORD	number of times route to attached server was lost
 18h	WORD	number of times server responded "busy"
 1Ah	WORD	number of unknown "NCPRepCompCode" values
 1Ch	WORD	number of bad connection numbers in responses
 1Eh	WORD	padding for NETX compatibility
 20h	WORD	padding for NETX compatibility
 22h	WORD	number of attach requests to server without route
 24h	WORD	number of times server responded to attach without slot
 26h	WORD	number of times a server went down during a request
 28h	DWORD	same-server optimizations
 2Ch	WORD	local route changes
 2Eh	WORD	IPX CRC errors
 30h	WORD	number of user fails
 32h	BYTE	flag: CRCs enabled
 33h	BYTE	flag: LIP enabled
 34h	BYTE	flag: configurable NET error handler
SeeAlso: #02873

(Table 02875)
Call NWP.VLM (VLM ID 0030h) with:
Func	Description/Registers
 01h	NWP Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	NWP Statistics
	CX = size of buffer for statistics
	ES:DI -> buffer for statistics (see #02876)
	Return: AX = status (see #02860)
 04h	NWP Connect
	DL = resource count state (NDS connections only)
	CX = proposed connection handle (not yet connected to server)
	DS:SI -> 48-byte server name (NUL-terminated if less than 48 bytes)
	Return: AX = status (0000h = successful) (see #02860)
		CX = actual connection handle to use
	Note:	if the returned handle differs from the proposed handle, the
		  proposed handle should be freed
 05h	NWP Disconnect
	DL = ???
	    00h global disconnect -- clear all resources associated with conn.
	    01h destroy connection -- send disconnect request to server
	CX = connected connection handle
	Return: AX = status (0000h = successful) (see #02860)
 06h	NWP Attach
	DL = resource count state (NDS connections only)
	CX = connection handle (allocated by not yet attached to server)
	DS:SI -> full network address for desired server
	Return: AX = status (0000h = successful) (see #02860)
 08h	NWP Login
	BX = object type
	CX = connection handle (must be connected) to be authenticated
	DS:SI -> ASCIZ user name (max 48 bytes)
	ES:DI -> ASCIZ user password (max 128 bytes)
	Return: AX = status (0000h = successful) (see #02860)
 09h	NWP Logout
	CX = connection handle
	Return: AX = status (0000h = successful) (see #02860)
 0Ah	NWP Get Bindery Object/Get Message Handler
	BX = subfunction
	    0002h set workstation's broadcast message mode
		DL = message mode
		    00h client hold client message set on, retrieve/display on
		    01h client hold client message set off, retr/display on
		    02h client hold client message set on, retrieve/dislay off
		    03h client hold client message set off, retr/display off
		    04h get current message mode
		    05h set broadcast callback
			CX:SI -> callback handler
		    06h get broadcast timeout
		    07h set broadcast timeout
			CX = timeout in timer ticks (0000h = never)
		CX = connection handle, or 0000h to notify all servers
	    0003h get object ID for object name
		AX = object type (big-endian)
		CX = connection handle
		DX = length of object name
		ES:DI -> uppercased ASCIZ object name
		Return: AX = status (see #02860)
			DX:BX = object ID
	    0004h get object name for object ID
		DX:SI = object ID
		CX = connection handle for server which is to do the lookup
		ES:DI -> 48-byte buffer for object name
		Return: AX = status (see #02860)
	    0005h retrieve broadcast message
 0Ch	NDS Fragment Request (passed to NDS.VLM's function 0Ch) (see #02877)
	AX = verb or request type
	CX = connection handle
	DS:SI -> request structure (DWORD data address followed by WORD size)
	ES:DI -> buffer for reply structure (same format as request)
	Return: AX = status (0000h = successful) (see #02860)
 0Eh	NWP Ordered Send To All
	AL = NCP request code
	AH = inverse request code (FFh if none) to back out from failures
	BX = number of fragments in request list
	DX = number of fragments in reply list buffer
	DS:SI -> request fragment list
	ES:DI -> reply fragment list
	Return: AX = status (see #02860)
		BX, CX, DX destroyed
	Note:	the available functions are described under INT 21/AX=F2xxh
 0Fh	NWP Preferred Handler
	BX = subfunction
	    0000h get preferred connection name
		DX = VLM ID (NDS/BIND/PNW)
		ES:DI -> 49-byte buffer for connection name
		Return: ES:DI buffer filled
	    0001h set preferred connection name
		DX = VLM ID (NDS/BIND/PNW)
		CX = length of connection name (may be 0000h, max 48)
		DS:SI -> name of preferred connection
	    0002h get preferred connection ID
		DX = VLM ID (NDS/BIND/PNW)
		Return: AX = status (see #02860)
			CX = connection handle if successful
	    0003h get server address
		CX = connection handle or 0000h
		DS:SI -> ASCIZ name to be resolved
		ES:DI -> 12-byte buffer for server address
 10h	NWP Security???
	BX = subfunction
	    0001h get security flags (see also INT 21/AX=B301h)
		Return: BX:CX indicates signature level
				= 0100h:0000h if signature level=0
				= 0300h:0000h if signature level=1
				= 0302h:0000h if signature level=2
				= 0302h:0202h if signature level=3
	    0002h create session keys (see also INT 21/AX=B302h)
		CX = server connection handle
		DS:SI -> 24-byte input buffer
	    0004h set security flags (see also INT 21/AX=B304h)
		BL:CL = new flags
	    0006h renegotiate security level (see also INT 21/AX=B306h)
		CX = server connection number (01h-08h)

Format of NWP.VLM statistics:
Offset	Size	Description	(Table 02876)
 00h	WORD	size of statistics record (including this byte)
 02h	BYTE	flag: Large Internet Packets enabled
 03h	BYTE	bit flags: enabled security features
 04h	BYTE	bit flags: preferred security features
 05h	BYTE	bit flags: required security features
 06h	BYTE	minimum level of required security
SeeAlso: #02875

(Table 02877)
Call NDS.VLM (VLM ID 0032h) with:
Func	Description/Registers
 01h	NDS Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	NDS Statistics
 06h	NDS Attach
	CX = allocated connection handle
	DS:SI -> server address
 08h	NDS Fragment Requst
	Return: AX = 8836h (invalid parameter)
	Note:	this function was documented but does not work
 0Ch	NDS context
	BX = subfunction
	    0000h get default name context
		CX = length of buffer for default context
		ES:DI -> buffer to receive name
		Return: ES:DI buffer filled
	    0001h set default context
		CX = length of new default context name
		DS:SI -> context name
	    0002h read from TDS
		CX = reply buffer length
		DX = 0110h ???
		SI = offset in TDS
		ES:DI -> reply buffer
	    0003h write to TDS
	    0005h "NWDSChangeResourceConnection/Lock Connection"
		CX = connection handle
		DL = subfunction (00h-09h)
		    04h = NWDSChangeResourceOnConnection
		    07h = NWDSChangeResourceOnConnection
		    08h = NWDSLockConnection
	    0006h NDS change connection state (internal)
		CX = connection handle
		AL = 00h or 01h
	    0007h "NWDSSetMonitoredConnection"
		AX = subfunction
		    0001h get monitored connection
			Return: CX = connection handle???
		    0002h set monitored connection
			CX = connection handle???
	    0008h send NDS request
		AX = NDS function
		CX = connection handle
		DS:SI -> request buffer descriptor (see #02878)
		ES:DI -> reply buffer descriptor (see #02878)
	    000Ah set NDS CEI Info
		DL = buffer length
		DS:SI -> input buffer

Format of NetWare NDS request/reply buffer descriptor:
Offset	Size	Description	(Table 02878)
 00h	DWORD	-> buffer
 04h	WORD	length of buffer in bytes
SeeAlso: #02877

(Table 02879)
Call REDIR.VLM (VLM ID 0040h) with:
Func	Description/Registers
 01h	Redir Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Redir Statistics
	CX = length of buffer
	ES:DI -> buffer for statistics (see #02880)
	Return: AX = status (0000h if successful) (see #02860)
		buffer filled if successful
 04h	Redir Build SFT (see INT 21/AH=B4h"NetWare")
	CX = connection handle
	ES:DI -> SFT build request (see #02881)
	Return: AX = 0000h if successful
		    BX = DOS file handle
 05h	Redir DOS To NW Handle
	BX = DOS file handle
	ES:DI -> 11-byte buffer for NetWare handle
 08h	Redir Specific
	BX = 0000h get item
	    DS:SI -> ASCIZ string "LPTx" (x='1'-'9') or drive spec ("d:")
	    ES:DI -> 512-byte reply buffer for
		      "\\server\resource",00h,"path",00h
	Return: AX = status (0000h if successful) (see #02860)

Format of REDIR.VLM statistics:
Offset	Size	Description	(Table 02880)
 00h	WORD	size of statistics record (including this word)
 02h	WORD	number of network errors causing a critical error (see INT 24)
 04h	WORD	number of drives currently redirected
SeeAlso: #02879

Format of NetWare SFT build request:
Offset	Size	Description	(Table 02881)
 00h  6 BYTEs	NetWare handle
 06h	WORD	reserved for internal use
 08h 14 BYTEs	ASCIZ filename
 16h	BYTE	DOS file attributes
		bit 7: file is shareable
 17h	BYTE	reserved
 18h	LONG	file size
 1Ch	WORD	creation date
 1Eh	WORD	last access date or 0000h
 20h	WORD	last update date or 0000h
 22h	WORD	last update time or 0000h

(Table 02882)
Call File I/O FIO.VLM (VLM ID 0041h) with:
Func	Description/Registers
 01h	FIO Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	FIO Statistics
	CX = length of buffer
	ES:DI -> buffer for statistics (see #02883)
	Return: AX = status (0000h if successful)
		buffer filled if successful
 04h	FIO Remote Copy

Format of NetWare FIO statistics:
Offset	Size	Description	(Table 02883)
 00h	WORD	length of statistics record (including this word)
 02h	WORD	number of read requests
 04h	WORD	number of write requests
 06h	WORD	number of cache read hits
 08h	WORD	number of cache write hits
 0Ah	WORD	number of cacheable files with free blocks
 0Ch	WORD	number of cacheable files without free blocks
 0Eh	WORD	number of standard read requests
 10h	WORD	number of standard write requests
 12h	WORD	number of burst read requests
 14h	WORD	number of burst write requests
 16h	BYTE	flag: cache writes enabled
 17h	BYTE	flag: true commits enabled
 18h	WORD	number of cache blocks
 1Ah	WORD	size of a cache buffer
 1Ch	WORD	number of ECBs for packet bursts (0000h if bursts disabled)
SeeAlso: #02882

(Table 02884)
Call PRINT.VLM (VLM ID 0042h) with:
Func	Description/Registers
 01h	Print Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Print Statistics
	CX = length of buffer
	ES:DI -> buffer for statistics (see #02885)
	Return: AX = status (0000h if successful) (see #02860)
		buffer filled if successful
 04h	Print Get/Set Data
	BX = subfunction
	    00h set printer control flags (see #02886)
	    01h get printer control flags
	    02h set extended printer control flags (see #02887)
	    03h get extended printer control flags
	AX = offset within Print structures at which to start read/write
	CX = number of bytes to transfer
	DX = printing device number (00h=LPT1/PRN, 01h=LPT2, etc.)
	DS:SI -> buffer containing values for flags (subfunctions 00h/02h)
	ES:DI -> buffer for flags (subfunctions 01h/03h
	Return: AX = status (see #02860)
		---if successful---
		CX = number of bytes returned (subfunctions 01h/03h)
		DX = maximum supported size for function/type of data
 05h	Print Open Capture File
 07h	Print Get Num Of Printers
	BX = subfunction
	    0000h get number of physical printers
	    nonzero: get configured printer (from NET.CFG)
	Return: AX = status (see #02860)
		---if successful---
		BX = number of physical/configured printers
 08h	Print Redirection
	BX = subfunction
	    0000h redirect device to queue
		AX = length of queue name, 0000h to use queue ID
		CX = connection handle
		DX = printer/device number (00h=LPT1/PRN, 01h=LPT2, etc.)
		DS:SI -> uppercased ASCIZ queue name
		ES:DI -> DWORD queue ID, 00000000h to use queue name
	    0001h test whether device is redirected
		DX = printer/device number (00h=LPT1/PRN, 01h=LPT2, etc.)
	    0002h cancel redirection
		DX = printer/device number (00h=LPT1/PRN, 01h=LPT2, etc.)
	    0003h redirect device to file
		AX = 0000h or 4E57h ('NW')
		CX = connection handle
		DX = printer/device number (00h=LPT1/PRN, 01h=LPT2, etc.)
		ES:DI -> ASCIZ path of file
	    0004h get extended redirection information (see #02886)
		DX = printer/device number (00h=LPT1/PRN, 01h=LPT2, etc.)
		ES:DI -> buffer for server/queue name
		Return: ES:DI buffer filled
	Return: AX = 0000h if successful
 09h	Print Flush And Close Job
	BX = subfunction
	    0000h unconditional close
	    nonzero: conditional close -- close only if concatenate flag is
		  clear
	DX = index of printing device (00h=LPT1/PRN, 01h=LPT2, etc.)
	Return: AX = status (see #02860)
 0Ch	Print Get/Set Banner Name
	BL = subfunction
	    00h set banner name
		DS:SI -> ASCIZ banner name (12 bytes, including NUL)
	    01h get banner name
		ES:DI -> 12-byte buffer for banner name
	Return: AX = status (see #02860)

Format of PRINT.VLM statistics:
Offset	Size	Description	(Table 02885)
 00h	WOFD	size of statistics buffer (including this word)
 02h	DWORD	-> old INT 17 handler
 06h	WORD	number of physical printers reported by BIOS
SeeAlso: #02884

Format of PRINT.VLM standard print control information:
Offset	Size	Description	(Table 02886)
 00h	BYTE	PFStatus (reserved, 00h)
 01h	BYTE	print flags (default 80h)
		bit 2: release job for printing if capture interrupted
		bit 3: suppress form feed
		bit 4: notify
		bit 6: text file
		bit 7: print banner
 02h	BYTE	tab size (01h-12h, default 08h)
 03h	BYTE	number of copies (default 01h)
 04h	BYTE	??? (may be number of copies instead of offset 03h)
 05h	BYTE	form type to be mounted in printer (default 00h)
 06h	BYTE	reserved (00h)
 07h 14 BYTEs	banner
 15h	BYTE	capture printer (LPT) number
 16h	WORD	capture timeout in seconds
 18h	BYTE	job concatenation flag (00h or 01h, default 00h)
 19h	BYTE	maximum lines per page (default 66)
 1Ah	BYTE	??? (may be maximum lines instead of offset 19h)
 1Bh	BYTE	maximum characters per line (default 132)
 1Ch	BYTE	??? (may be maximum characters instead of offset 1Ch)
 1Dh 13 BYTEs	name of form to be mounted in printer
 2Ah	BYTE	flag: capture active (00h or FFh, default 00h)
 2Bh	BYTE	flag: capturing to file (00h or 01h, default 00h)
 2Ch	BYTE	flag: timeout field is being decremented (default 00h)
 2Dh	DWORD	-> printer setup string
 31h	DWORD	-> printer reset string
 35h	BYTE	reserved (01h)
---remainder is read-only---
 36h	BYTE	flag: job has started printing (00h or FFh, default 00h)
 37h	BYTE	flag: job placed in queue (00h or FFh, default 00h)
 38h	BYTE	flag: PJobValid (00h or FFh, default 00h)
		FFh if associated capture file is open for capturing data
 39h	DWORD	print-queue ID
 3Dh	WORD	print-job number (default 00h) (1-999)
 3Fh	BYTE	number of chars in INT 17h print cache buffer (default 00h)
 40h	BYTE	???
 41h	WORD	high word of print-job number (default 00h)
SeeAlso: #02884,#02887

Format of PRINT.VLM extended print control information:
Offset	Size	Description	(Table 02887)
 00h	DWORD	NDS printer object ID or directory entry number (when capturing
		  to a file)
 04h	BYTE	connection handle for server
 06h 48 BYTEs	ASCIZ print queue name on server
 36h	DWORD	ID of target server, or FFFFFFFFh if any server may be used
 3Ah  6 BYTEs	target print time, FFFFFFFFFFFFh for immediate printing
 40h	BYTE	status flags
 41h	BYTE	???
 42h 13 BYTEs	client's banner name (overrides global banner if set)
 4Fh 13 BYTEs	job description
 5Ch  4 BYTEs	reserved (0)
SeeAlso: #02884,#02886

(Table 02888)
Call GENERAL.VLM (VLM ID 0043h) with:
Func	Description/Registers
 01h	Gen Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Gen Statistics
	CX = length of statistics buffer
	ES:DI -> buffer for statistics (see #02889)
	Return: AX = status (see #02860)
 04h	Gen Get/Set Primary
	BX = subfunction
	    0001h get primary connection
		CX = primary connection handle to be retrieved
		Return: AX = status (see #02860)
			CX = primary connection handle
	    0002h set primary connection
		CX = primary connection handle to be stored
		Return: AX = status (see #02860)
 06h	Gen Specific
	BX = subfunction
	    0000h get command processor and master environment addresses
		Return: DX = segment of master environment
			ES:DI -> command processor's private COMSPEC= copy
	    0001h get default or primary connection
		Return: AX = status (0000h successful)
			CX = connection handle if successful
	    0002h last queue information
		AL = operation
		    00h zap
		    01h set
		    02h get
		DI:DX = queue file handle
		CX = connection handle
		Return: AX = status (0000h successful)
			DI:DX = queue file handle
			CX = connection handle or 0000h if queue info invalid
	    0003h get/set machine name(s)
		AX = name type
		    00h get short machine name
		    02h get long machine name
		    04h set short machine name
		    06h set long machine name
		    08h get DOS name
		    0Ah set DOS name
		ES:SI -> ASCIZ name if setting
		Return: AX = status (0000h if successful)
			ES:SI -> ASCIZ name if getting
	    0004h set per-task EXEC search mode
		Return: AX = status (0000h if successful)
 09h	Gen Return Drive Info
	BX = subfunction
	    0000h get first available drive
		Return: AX = status (see #02860)
			BX = drive letter of first drive
	    0001h get Lastdrive
		Return: AX = status (see #02860)
			CH = number lastdrive 1=A: - 1Ah=Z:

Format of NetWare GENERAL.VLM statistics:
Offset	Size	Description	(Table 02889)
 00h	WORD	size of statistics record, including this word
 02h	DWORD	previous INT 21 vector
SeeAlso: #02888

(Table 02890)
Call NETX.VLM (VLM ID 0050h) with:
Func	Description/Registers
 01h	NetX Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	NetX Statistics
	CX = length of statistics buffer
	ES:DI -> buffer for statistics (see #02891)
	Return: AX = status (see #02860)

Format of NETX.VLM statistics:
Offset	Size	Description	(Table 02891)
 00h	WORD	buffer size, including this word
 02h	DWORD	previous INT 21 handler
SeeAlso: #02890

(Table 02892)
Call SECURITY.VLM (VLM ID 0061h) with:
Func	Description/Registers
 01h	Security Get Version
	BX = function
	    0000h get version
		Return: AX = status (see #02860)
			BX = major version of VLM supported (0001h)
			CX = minor version of VLM supported (0000h)
 03h	Security Statistics
 04h	???
	AL = subfunction
	    01h compute session key
		DS:SI -> 24-byte input buffer
		ES:DI -> 8-byte output buffer
--------N-2F7A20BX0001-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM CallA ADDRESS
	AX = 7A20h
	BX = 0001h
Return: AX = 0000h if request was handled
	    ES:BX -> CallA entry point (see #02893)
SeeAlso: AX=7A20h/BX=0000h

(Table 02893)
Call VLM CallA entry point with:
	AX = function
	    0000h submit
	    0001h cancel (not implemented)
	ES:DI -> Overlay Asynchronous Control Block structure (see #02894)
Return: DI, DS, ES preserved; all other registers may be destroyed
	interrupts disabled
Desc:	asychronously call the specified VLM and then return to caller, which
	  might be another VLM

Format of Overlay Asynchronous Control Block (OACB):
Offset	Size	Description	(Table 02894)
 00h	DWORD	link to next OACB, 0000h:0000h if last (filled by VLM.EXE)
 04h	DWORD	callback address or 0000h:0000h
 08h	BYTE	InUse flag (00h if complete) (set by VLM.EXE)
 09h	BYTE	flag, reserved for VLM use
 0Ah	WORD	destination VLM
 0Ch	WORD	destination function
 0Eh	WORD	temporary storage for VLM.EXE
 10h  6 BYTEs	reserved
 16h  6 DWORDs	EAX,EBX,ECX,EDX,ESI,EDI
 2Eh  4 WORDs	DS,ES,FS,GS (FS and GS not used)
--------N-2F7A20BX0002-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM MULTIPLEX ADDRESS
	AX = 7A20h
	BX = 0002h
Return: AX = 0000h
	ES:BX -> VLM multiplex entry point (see #02895)
Note:	for v1.10, this function is only available while VLM.EXE is loading
	  the .VLM modules, because ES is destroyed on return
SeeAlso: AX=7A20h/BX=0000h,AX=7A20h/BX=0001h,AX=7A20h/BX=0003h

(Table 02895)
Call DOS Requester entry point with:
	BX = function???
	    0000h
		DX = ???
		DI = ???
		BP = ???
	    0002h
		CX = ???
	    0003h
		DX = ???
		BP = ???
	    0006h
		AH = subfunction???
		AL = ???
		STACK: variable (0, 4, 10, 14 bytes seen)
--------N-2F7A20BX0003-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM PARSE API ADDRESS
	AX = 7A20h
	BX = 0003h
Return: AX = 0000h if request was handled
	    ES:BX -> VLM parse API entry point
--------N-2F7A20BX0004-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM MULTICAST CALLOUT
	AX = 7A20h
	BX = 0004h
Return: AX = 0000h if request was handled
	    ES:BX -> VLM multicast data (see #02896)
SeeAlso: AX=7A20h/BX=0000h,AX=7A20h/BX=0002h,AX=7A20h/BX=0005h

Format of DOS Requester data:
Offset	Size	Description	(Table 02896)
 00h	DWORD	pointer to ??? (code)
 04h  4 BYTEs	???
 08h	DWORD	pointer to ??? (code) (see #02897)
	???

(Table 02897)
Call offset 08h function with:
	AL = function (00h-07h)
	???
Return: ???
--------N-2F7A20BX0005-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET VLM INT 24 ADDRESS
	AX = 7A20h
	BX = 0005h
Return: AX = 0000h if request was handled
	    ES:BX -> VLM INT 24 handler
SeeAlso: AX=7A20h/BX=0000h,AX=7A20h/BX=0002h,AX=7A20h/BX=0004h
--------N-2F7A20BX0006-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0006h
Return: AX = 0000h if request was handled
	    ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
--------N-2F7A20BX0007-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0007h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
--------N-2F7A20BX0008-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0008h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
--------N-2F7A20BX0080-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0080h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
Note:	this function is identical to AX=7A20h/BX=0006h in v1.03 and v1.10
--------N-2F7A20BX0081-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0081h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
Note:	this function is identical to AX=7A20h/BX=0007h in v1.03 and v1.10
--------N-2F7A20BX0082-----------------------
INT 2F - Novell NetWare - DOS Requester v1.03+ - GET ??? ENTRY POINT
	AX = 7A20h
	BX = 0082h
Return: AX = 0000h
	ES:BX -> ??? entry point (RETF in v1.03 and v1.10)
Note:	this function is identical to AX=7A20h/BX=0008h in v1.03 and v1.10
--------N-2F7A21-----------------------------
INT 2F C - Novell NetWare - DOS Requester - BROADCAST CALLBACK
	AX = 7A21h
	CX = server connection (FFFFh if message from Personal NetWare user)
	interrupts disabled
Return: CX = 0000h if broadcast handled
	interrupts disabled
Note:	this function is only linked into INT 2F when INT 21/AH=DEh/DL=05h
	  has been issued
SeeAlso: AX=7A22h,AX=7A85h,INT 21/AH=DEh
--------N-2F7A22-----------------------------
INT 2F C - Novell NetWare - DOS Requester - BROADCAST/SFT3 INFORM
	AX = 7A22h
	DL = function
	    21h ('!') broadcast waiting for workstation
	    40h ('@') SFT3 server-change inform
	BX = transport type
	    0021h IPX
	    0022h TCP
	ES:SI -> transport-specific data block
	    (ECB for IPX, undefined for TCP)
	interrupts disabled
Return: AX = 0000h if event handled, unchanged if not
	interrupts disabled
Note:	this callback is made from within a hardware interrupt handler; a
	  separate call to AX=7A21h is made once the system is in a safe
	  state for receiving the message
SeeAlso: AX=7A21h
--------N-2F7A2F-----------------------------
INT 2F - Novell NetWare - IPXODI v2.12 - GET GNMA SUPPORT
	AX = 7A2Fh
Return: AX = 0000h if supported and active
	    BX = support level (0001h)
	    ES:DI -> GNMA entry point (see #02898)
Program: GNMA is the Generic NetWare Management Agent
Note:	IPXODI v2.12 is distributed as part of the Personal NetWare system
	  bundled with Novell DOS 7
SeeAlso: INT 7A/BX=001Fh

(Table 02898)
Call IPXODI GNMA entry point with:
	BX = function
	    0000h Register Responder
		ES:SI -> responder structure (see #02899)
		Return: CF clear if successful
			CF set on error
			AX = status
			    FFFFh if specified responder is already registered
			interrupts enabled
			all other registers except DS, CS:IP, SS:SP destroyed
		Note:	the responder structure must not be deallocated until
			  the responder is deregistered
	    0001h Deregister Responder
		AX = type of responder to deregister
		Return: AX = status
			    FFFFh if specified responder not registered
			interrupts enabled
			ES:SI buffer from original registration may now be
			      freed
			all other registers except DS, CS:IP, SS:SP destroyed
	    0002h Get Responders
		Return: ES:SI -> head of responder structure list (read-only)
			interrupts enabled
			all other registers except DS, CS:IP, SS:SP destroyed
		Note:	the returned list may change as tasks are swapped in
			  and out
	    0003h Send Acknowledgement
		AL = completion code
		    00h successful
		    01h-FCh responder-specific
		    FDh invalid function
		CX = length of return data (0000h if none)
		DX:SI -> return data
		Return: interrupts enabled
			all other registers except DS, CS:IP, SS:SP destroyed

Format of NetWare GNMA responder structure:
Offset	Size	Description	(Table 02899)
 00h	DWORD	-> next responder structure (used by GNMA)
 04h	DWORD	-> responder's request handler (called by GNMA) (see #02900)
 08h	WORD	responder ID
 0Ah	WORD	number of functions supported by responder
 0Ch	DWORD	reserved for use by GNMA
SeeAlso: #02898

(Table 02900)
Values GNMA responder's request handler is called with:
	AL = function
	    00h responder request
		CX = length of request data (not including header) (see #02901)
		DS:DI -> request data (see #02901)
		DS:BX -> 528-byte reply buffer
		ES:SI -> responder structure (see #02899) from registration
		DF clear
		interrupts disabled
		Return: AH = acknowledement status
			    00h acknowledgment being returned synchronously
			    nonzero: acknowledgment will be sent via GNMA
				  function 0003h (see #02898)
				CX = length of acknowledement data
				DX:BX -> acknowledgment (may use provided
					  buffer or another buffer)
			AL = completion code
			    00h successful
			    01h-FCh responder-specific
			    FDh invalid request
			DF clear
			interrupts disabled
			other registers may be destroyed
	    01h responder acknowledgement complete
		ES:SI -> responder structure (see #02899) from registration
		DF clear
		interrupts disabled
		Return:	DF clear
			interrupts disabled
			all registers (except SS:SP) may be destroyed
		Note:	this function is called if function 00h returned a
			  responder-provided data buffer; once this function
			  is called, the responder may deallocate the buffer
	    02h responder reset
		ES:SI -> responder structure (see #02899) from registration
		DF clear
		interrupts disabled
		Return:	DF clear
			interrupts disabled
			all registers (except SS:SP) may be destroyed
		Note:	called whenever a network managment application
			  terminates
Note:	the responder handler should switch to a local stack if it enables
	  interrupts or uses more than a few words of stack space
SeeAlso: #02899

Format of GNMA responder request data:
Offset	Size	Description	(Table 02901)
 00h	WORD	responder's assigned ID
 02h	WORD	function number (defined by responder)
 04h  N BYTEs	data for request (max 528 bytes; actual amount is determined
		  by CX)
SeeAlso: #02900
--------N-2F7A2FBX0EDC-----------------------
INT 2F U - Personal NetWare - HRMIB - UNINSTALL
	AX = 7A2Fh
	BX = 0EDCh ('EDC' = Novell European Development Center)
Return: ???
SeeAlso: AX=7AA0h
--------N-2F7A40-----------------------------
INT 2F - Novell NetWare - TCP/IP Protocol Stack - INSTALLATION CHECK
	AX = 7A40h
Return: AX = 7AFFh if installed
	    0000h:BX = address of interrupt vector for MLID ISR
	    CX = version (CH=major, CL=minor)
	    DX = 0000h
	    ES:DI -> entry point for TCP/IP stack (see #02903)
Notes:	Novell's LAN Workplace for DOS TCPIP.EXE also supports this interface
	this function is also supported by the Beame&Whiteside BWLWP40 shim,
	  but it only returns AL and ES:DI, and does not support AX=7A41h
SeeAlso: AX=7A41h,INT 15/AX=DE2Eh,INT 60"Excelan"


(Table 02902)
Values for NetWare TCP/IP function code:
 01h	"accept" accept a network connection request
 02h	"bind" associate an address with a socket
 03h	close socket
	Call:	socket number field set
 04h	"connect" connect to a remote host
 05h	"getmyipaddr" get IP address
	Call:	socket number field in sockaddr set to 0000h
 06h	"getmymacaddr" get hardware address
 07h	"getpeername"
 08h	"getsockname" get socket name
 09h	"getsockopt" get socket options
 0Ah	"getsubnetmask" get subnet mask
 0Bh	"ioctl"
 0Ch	"listen" wait for connection request on socket
 0Dh	"select"
	Return: socket bitmap updated (1=active)
 0Eh	"setmyipaddr" (obsolete) set IP address
 0Fh	"setsockopt" set socket options
 10h	"shutdown"
 11h	"socket" open socket
	Call:	socket number field set to 0000h
	Return: socket number set
 12h	"recv" get data from peer
 13h	"recvfrom" get data from specified remote host
	Call:	socket number set
		packet length and buffer descriptors set
	Return:	packet length and receive buffers updated
		sockaddr field set to source port number + IP address
 14h	"send" write data to socket
 15h	"sendto" write data to specified recipient
	Call:	socket number set
		flags at offset 18h = 0000h
		packet length and buffer descriptors set
---v4.02+ ---
 16h	get BOOTP data
	Return: BOOTP data stored in parameter block (see #02906)
 17h	"getsnmpinfo"
 18h	"getpathinfo" get/set configuration???
---v4.??? ---
 19h	"getifn"	get interface number
 1Ah	"setipinfo"	set IP information
 1Bh	"getipinfo"	get IP information
 1Ch	"setdnsinfo"	set DNS information
 1Dh	"getdnsinfo"	get DNS information
 1Eh	"setroutes"	set/modify route entry(ies)
 1Fh	"getroutes"	get route entry(ies)
 20h	"removeroutes"	remove route entry(ies)
 21h	"setarpe"	set/modify ARP entry(ies)
 22h	"getarpe"	get ARP entry(ies)
 23h	"removearpe"	remove ARP entry(ies)
Notes:	these functions are based on the Unix socket interface
	OR function number with 80h to call ESR
SeeAlso: #02904

(Table 02903)
Call NetWare TCP/IP entry point with:
	ES:SI -> parameter block (see #02904)
Return: ES:SI parameter block updated
	DX may be destroyed

Format of NetWare TCP/IP Request Control Block (RCB):
Offset	Size	Description	(Table 02904)
 00h	DWORD	-> next RCB
 04h	DWORD	-> previous RCB
 08h	DWORD	-> FAR post routine called if bit 7 of function code set
 0Ch	BYTE	flags (internal use)
		bit 0: request in progress
		bit 1: posted
		bit 2: Windows
		bit 3: "PROTBUF"
		bit 4: "ABORTRCB" for Ctrl-Break handling
		bit 5: call INT 21/AX=0B00h while blocking
 0Dh  7 BYTEs	???
 14h	BYTE	(ret) temporary result code
 15h	BYTE	(call) function code (bit 7 set if non-blocking) (see #02902)
 16h	BYTE	socket number
 17h	BYTE	(ret) result or error code (see #02905)
---accept/bind/connect/getmyipaddr/getpeername/getsockname commands---
 18h		sockaddr structure (WORD port + DWORD IP address)
---close comand---
 no additional fields
---getmymacaddr command---
 18h  6 BYTEs	low-level hardware network address
---BOOTP command---
 18h 64 BYTEs	BOOTP VSA data (see #02906)
---getpathinfo command
 18h  8 BYTEs	key
		"TCP_CFG" used by PING.EXE
 20h 128 BYTEs	path
 A0h	WORD	length of path in previous field
---getsockopt/setsockopt commands---
 18h	WORD	option name
		0004h SO_REUSEADDR
		0008h SO_KEEPALIVE
		0080h SO_LINGER
 1Ah	WORD	option value
 1Ch	WORD	"linger"
---getsubnetmask command---
 18h	DWORD	sockaddr structure (WORD port + DWORD subnet mask)
---ioctl command---
 18h	DWORD	argument value
 1Ch	WORD	ioctl number
---listen command---
 18h	WORD	maximum allowable connection backlog
---select command---
 18h	WORD	number of sockets
 1Ah		fd_set readfds (bitmap of sockets)
		fd_set writefds
		fd_set expectionfds
	DWORD	timeout in clock ticks
---shutdown command---
 18h	WORD	shutdown type
---socket command---
 18h	WORD	protocol (1 = ICMP, 6 = TCP, 17 = UDP)
---I/O commands (recv,recvfrom,send,sendto)---
 18h	WORD	flags
 1Ah  6 BYTEs	sockaddr from/to
		WORD	port number
		DWORD	IP address
 20h	WORD	length of packet sent/received
 22h	WORD	number of pointer/length pairs following (max 8)
 24h 6N BYTEs	buffer descriptors, each
		Offset	Size	Description
		 00h	DWORD	pointer to buffer
		 04h	WORD	length of buffer
---getsnmpinfo command---
 18h	DWORD	(ret) -> ??? data in TCPIP code segment
--getifn command---
 18h	WORD	interface number
 1Ah	WORD	MLID instance number
 1Ch 128 BYTEs	MLID name
---getipinfo/setipinfo commands---
 18h	WORD	interface number (00h = default)
 1Ah	DWORD	IP address
 1Eh	DWORD	IP netmask
 22h  3 DWORDs	router addresses (00000000h = unused entry)
---getdnsinfo/setdnsinfo commands---
 18h	WORD	interface number (00h = default)
 1Ah  3 DWORDs	name server IP addresses (00000000h = unused entry)
 26h 128 BYTEs	domain name
---getroutes/setroutes/removeroutes commands---
 18h	WORD	number of route entries to follow (max 5)
 1Ah 10N BYTEs	route entries
		DWORD	destination host/net IP address
		DWORD	IP address of first router
		WORD	route type
---getarpe/setarpe/removearpe commands---
 18h	WORD	number of ARP entries to follow (max 16)
 1Ah 10N BYTEs	ARP entries
		DWORD	destination IP address
		6 BYTEs	destination hardware address
---other commands---
 18h  4 WORDs	parameter words 0 to 3 (see #02902 for usage)

(Table 02905)
Values for NetWare TCP/IP status:
 00h	successful
 04h	would block
 09h	invalid socket
 23h	would block
 24h	operation in progress
 25h	already in progress
 26h	not a socket
 27h	destination address required
 28h	message too long
 29h	wrong protocol type for socket
 2Ah	protocol not available
 2Bh	protocol not supported
 2Ch	socket type not supported
 2Dh	operation not supported on socket
 2Eh	protocol family not supported
 2Fh	address family not supported by protocol family
 30h	address already in use
 31h	unable to assign requested address
 32h	network is down
 33h	network is unreachable
 34h	network dropped connection
 35h	software caused connection abort
 36h	connection reset by peer
 37h	no buffer space
 38h	socket is already connected
 39h	socket is not connected
 3Ah	socket is in shutdown mode
 3Bh	too many references
 3Ch	connection timed out
 3Dh	connection refused
 3Eh	too many levels of symbolic links
 3Fh	file name too long
 40h	host is down
 41h	host unreachable
 42h	protocol stack not installed
 43h	asynchronous operation not supported
 44h	synchronous operation not supported
 45h	no RCB available
 FFh	blocking (call has not yet returned)
SeeAlso: #02904

Format of BOOTP data (stored in parameter block):
Offset	Size	Description	(Table 02906)
 18h  4 BYTEs	???
 1Ch	BYTE	??? (01h)
 1Dh	BYTE	address length (04h)
 1Eh  4 BYTEs	subnet mask
 22h	BYTE	??? (03h)
 23h	BYTE	??? (04h)
 24h  4 BYTEs	IP address of nearest router
 28h	BYTE	??? (06h)
 29h	BYTE	length of following data (08h)
 2Ah  4 BYTEs	IP address of nameserver 1
 2Eh  4 BYTEs	IP address of nameserver 2
 32h	BYTE	??? (0Ch)
 33h	BYTE	length of local name
 34h  N BYTEs	local host name
	BYTE	FFh (end marker)
SeeAlso: #02904,#02902
--------N-2F7A41-----------------------------
INT 2F U - Novell NetWare - TCP/IP Protocol Stack - WINDOWS SUPPORT???
	AX = 7A41h
	ES:DI -> FAR entry point for ??? (will be called with BX=1,2,3,4)
Return: AX = 7AFFh if supported
	    0000h:BX = address of interrupt vector for MLID ISR
	    CX = version (CH=major, CL=minor)
	    DX = 0000h
	    ES:SI -> DWORD containing passed value of ES:DI
	    ES:DI -> entry point for TCP/IP stack
Notes:	Novell's LAN Workplace for DOS TCPIP.EXE also supports this interface
	the pointer which is set to ES:DI is cleared to 0000h:0000h when
	  a Windows exit broadcast is received
SeeAlso: AX=7A40h
--------N-2F7A42-----------------------------
INT 2F U - Novell NetWare - TCPIP.EXE v4.1 - GET ??? ENTRY POINT
	AX = 7A42h
Return: AX = 7AFFh if supported
	    ES:DI -> ??? entry point (see #02907)

(Table 02907)
Call NetWare TCPIP.EXE entry point with:
	DX = ???
	ES:DI -> ??? (see #02908)
Return: AX = 0000h
	other registers destroyed

Format of data buffer:
Offset	Size	Description	(Table 02908)
 00h	WORD	offset of WORD ??? or 0000h
 02h	WORD	offset of DWORD ??? or 0000h
 04h	WORD	offset of DWORD ??? or 0000h
--------N-2F7A43-----------------------------
INT 2F U - Novell NetWare - TCPIP.EXE v4.1 - GET ???
	AX = 7A43h
Return: AX = 7AFFh if supported
	    DX = offset of ???
SeeAlso: AX=7A44h
--------N-2F7A44-----------------------------
INT 2F U - Novell NetWare - TCPIP.EXE v4.1 - SET ???
	AX = 7A44h
	DX = offset of ??? (see AX=7A43h)
Return: AX = 7AFFh if supported
SeeAlso: AX=7A43h
--------N-2F7A4C-----------------------------
INT 2F U - Novell NetWare - TCPIP.EXE v4.1 - GET ???
	AX = 7A4Ch
Return: AX = 7AFFh if supported
	    BX = ??? (0037h)
	    CX = ??? (001Ch)
--------N-2F7A4DBX0001-----------------------
INT 2F U - Novell NetWare - ???
	AX = 7A4Dh
	BX = 0001h
	ES:DI -> ???
Return: AL = FFh if ???
	    ES:DI -> ???
Note:	called by NETBIOS.EXE v3.01
--------N-2F7A4E-----------------------------
INT 2F U - Novell LAN Workplace for DOS - RARPD.EXE - INSTALLATION CHECK
	AX = 7A4Eh
Return: AX = 7AFFh if installed
SeeAlso: AX=7A4Fh"RARPD"
--------N-2F7A4F-----------------------------
INT 2F U - Novell LAN Workplace for DOS - RARPD.EXE - UNINSTALL
	AX = 7A4Fh
Return: AX = 7AFFh if installed
	DX,ES destroyed
Note:	this call conflicts with SNMP.EXE (both RARPD and SNMP are supplied
	  with LAN Workplace for DOS!), such that running SNMP will uninstall
	  RARPD as SNMP checks whether it is already installed!
SeeAlso: AX=7A4Eh"RARPD",AX=7A4Fh/BX=0001h
--------N-2F7A4FBX0001-----------------------
INT 2F U - Novell NetWare - SNMP.EXE - INSTALLATION CHECK
	AX = 7A4Fh
	BX = 0001h
Return: AX = 7AFFh if installed
Note:	this call conflicts with RARPD.EXE (both SNMP and RARPD are supplied
	  with LAN Workplace for DOS!), such that running SNMP will uninstall
	  RARPD as SNMP checks whether it is already installed!
SeeAlso: AX=7A4Fh"RARPD",AX=7A4Fh/BX=0002h
--------N-2F7A4FBX0002-----------------------
INT 2F U - Novell NetWare - SNMP.EXE - ???
	AX = 7A4Fh
	BX = 0002h
Return: AL = status
	    4Fh if failed
	    FFh if successful
SeeAlso: AX=7A4Fh/BX=0001h
--------N-2F7A80-----------------------------
INT 2F C - Novell NetWare - SHELL 3.01d BROADCAST - ABNORMAL EXIT
	AX = 7A80h
Return: nothing
Notes:	called on abnormal exit of the NetWare shell to notify other Novell
	  TSRs that it is unsafe to call the shell in the future; also called
	  by NETX.VLM when it is unloaded
	must be passed through so that all interested programs see the exit
	on receiving this call, IPXODI clears an internal pointer to a
	  default value; Novell's NETBIOS.EXE clears its INT 21h pointer to
	  0000h:0000h and stops calling it
SeeAlso: AX=7A81h
--------N-2F7A81-----------------------------
INT 2F C - Novell NetWare - SHELL 3.01d BROADCAST - SET SHELL INT 21 HANDLER
	AX = 7A81h
	CX:DX -> shell's INT 21h entry point
Return: nothing
Notes:	the shell calls this function as it loads to allow interested TSRs
	  and drivers to make a local copy of the shell's entry point
	must be passed through so that all interested programs see it
--------N-2F7A85-----------------------------
INT 2F C - Novell NetWare - shell 3.01 - BROADCAST INFORM
	AX = 7A85h
	CX = broadcast server number
Return: CX = 0000h if broadcast message handled by another program
	CX unchanged if broadcast not handled
SeeAlso: AX=7A21h
--------N-2F7A90-----------------------------
INT 2F U - Novell NetWare - NETBIOS.EXE 3+ - INSTALLATION CHECK
	AX = 7A90h
Return: AL = 00h if present
	    BX = ???
	    CX = PSP segment of NETBIOS resident code
SeeAlso: AX=7AFEh
--------N-2F7AA0-----------------------------
INT 2F U - Personal NetWare - HRMIB - ???
	AX = 7AA0h
	BX = function
	    0000h ???
	    0001h ???
Return: ???
SeeAlso: AX=7A2Fh/BX=0EDCh
--------N-2F7AC1-----------------------------
INT 2F - LAN HiJack - LHR - DISABLE???
	AX = 7AC1h
Program: LAN HiJack is a NetWare utility by KDS Software which allows a user
	  to take over control of a workstation remotely; LHR is the program
	  run on the slave workstation
SeeAlso: AX=7AC8h,AX=7AC9h,AX=7ACFh
--------N-2F7AC2-----------------------------
INT 2F - LAN HiJack - LHR - SYNCHRONIZE SHIFT STATES???
	AX = 7AC2h
Note:	sets BIOS keyboard status byte to an internal variable
SeeAlso: AX=7AC3h,AX=7ACFh
--------N-2F7AC3-----------------------------
INT 2F - LAN HiJack - LHR - CLEAR ??? FLAG
	AX = 7AC3h
SeeAlso: AX=7AC2h,AX=7ACFh
--------N-2F7AC8-----------------------------
INT 2F - LAN HiJack - LHR - ENABLE FUNCTIONS
	AX = 7AC8h
	BL = function(s) to enable (see #02909)
SeeAlso: AX=7AC1h,AX=7AC9h,AX=7ACFh

Bitfields for LAN HiJack function(s) to enable/disable:
Bit(s)	Description	(Table 02909)
 0	???
 1	remote keyboard enabled
 2	support remote's mouse
 3-7	unused
--------N-2F7AC9-----------------------------
INT 2F - LAN HiJack - LHR - DISABLE FUNCTIONS
	AX = 7AC9h
	BL = function(s) to disable (see #02909)
SeeAlso: AX=7AC1h,AX=7AC8h
--------N-2F7ACA-----------------------------
INT 2F - LAN HiJack - LHJ - ???
	AX = 7ACAh
	BL = ???
Return: ???
Program: LAN HiJack is a NetWare utility by KDS Software which allows a user
	  to take over control of a workstation remotely; LHJ is the program
	  run on the controlling workstation
--------N-2F7ACB-----------------------------
INT 2F - LAN HiJack - LHJ - ???
	AX = 7ACBh
	BX = ???
Return: ???
Note:	this function appears to be related to the keyboard
SeeAlso: AX=7ACCh
--------N-2F7ACC-----------------------------
INT 2F - LAN HiJack - LHJ - ???
	AX = 7ACCh
	BX = ???
Return: ???
Note:	this function appears to be related to the mouse
SeeAlso: AX=7ACBh
--------N-2F7ACFBX0000-----------------------
INT 2F - LAN HiJack - LHR - INSTALLATION CHECK
	AX = 7ACFh
	BX = 0000h
Return: BX = segment of resident code if installed
Program: LAN HiJack is a NetWare utility by KDS Software which allows a user
	  to take over control of a workstation remotely; LHR is the program
	  run on the slave workstation
--------N-2F7AF0-----------------------------
INT 2F - Novell NetWare - DOSNP.EXE v1.30G - INSTALLATION CHECK
	AX = 7AF0h
Return: AL = FFh if present
	    ES = 7AF0h
	    CX = PSP segment of resident code
--------N-2F7AF1-----------------------------
INT 2F - Novell NetWare - Access Server Driver - INSTALLATION CHECK
	AX = 7AF1h
	BL = sequence number (01h first driver, 02h second, 00h no driver)
Return: AX <> 7AF1h if present
	    BH = total number of drivers
	    ---if BL nonzero on entry---
	    AL = number of ports provided by specified driver
	    ES:DI -> driver entry point
		      (see #02910,#02911,#02912,#02913,#02914,#02915,#02916,#02917)
	    ES:DX -> ID string
SeeAlso: INT 7A/BX=001Ch

(Table 02910)
Call Access Server driver "initialize port" function with:
	AH = 01h
	AL = port number (00h-0Fh)
	ES:BX -> configuration parameter block (see #02923)
	interrupts disabled
Return: CF clear if successful
	CF set on error
SeeAlso: #02911

(Table 02911)
Call Access Server driver "get port status" function with:
	AH = 02h
	AL = port number (00h-0Fh)
	interrupts disabled
Return: CF clear if successful
	    BL = transmitter status (see #02920)
	    BH = receiver status (see #02921)
	    DL = external status signals (see #02922)
	CF set on error
	interrupts disabled
SeeAlso: #02910,#02912,#02915

(Table 02912)
Call Access Server driver "get input from port" function with:
	AH = 03h
	AL = port number (00h-0Fh)
	CX = size of data buffer
	ES:BX -> buffer for data
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled
	CX = number of bytes read
Note:	the driver will add a NUL to the buffer when a break signal is detected
SeeAlso: #02912,#02913

(Table 02913)
Call driver "send output data to port" function with:
	AH = 04h
	AL = port number (00h-0Fh)
	CX = number of bytes to send
	ES:BX -> buffer containing data
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled
	CX = number of bytes actually written
SeeAlso: #02912,#02914

(Table 02914)
Call driver "get I/O character counts" function with:
	AH = 05h
	AL = port number (00h-0Fh)
	interrupts disabled
Return: CF clear if successful
	    BX = number of bytes pending transmission
	    CX = number of bytes available for reading
	CF set on error
	interrupts disabled
SeeAlso: #02912,#02913

(Table 02915)
Call driver "control XON/XOFF" function with:
	AH = 06h
	AL = port number (00h-0Fh)
	DL = new state
	    (00h software flow control disabled, else enabled)
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled
SeeAlso: #02916

(Table 02916)
Call driver "get error counts and statistics" function with:
	AH = 07h
	AL = port number (00h-0Fh)
	ES:BX -> buffer for statistics (see #02924)
	interrupts disabled
Return: CF clear if successful
	    ES:BX buffer filled
	CF set on error
	interrupts disabled
SeeAlso: #02917,#02918,#02919

(Table 02917)
Call driver "general request" function with:
	AH = 08h
	AL = port number (00h-0Fh)
	DX = requested operations
	    bit 0: flush transmit buffers
	    bit 1: flush receive buffers
	    bit 4: define XON/XOFF characters
	ES:BX -> XON/XOFF characters (see #02925) if DX bit 4 set
	interrupts disabled
Return: CF clear if successful
	CF set on error
	interrupts disabled

(Table 02918)
Call driver "deadman timer management" function with:
	AH = 09h
	AL = port number (00h-0Fh)
	BX = next time interval in seconds (0000h to disable timer)
	interrupts disabled
Return: CF clear
	interrupts disabled
SeeAlso: #02919

(Table 02919)
Call driver "get buffer sizes" function with:
	AH = 0Ah
	AL = port number (00h-0Fh)
	interrupts disabled
Return: CF clear if successful
	   BX = size of transmit buffer
	   CX = size of receive buffer
	CF set on error
	interrupts disabled
SeeAlso: #02918

(Table 02920)
Values for Access Server transmitter status:
 00h	uninitialized
 01h	ready, not transmitting
 02h	transmitting
 03h	XOFF received
 04h	transmitting, buffer full
 05h	XOFF received and buffer full

(Table 02921)
Values for Access Server receiver status:
 00h	uninitialized
 01h	ready
 02h	receive buffer full, data may have been lost

Bitfields for external status signals:
Bit(s)	Description	(Table 02922)
 7,6	undefined
 5	CTS active
 4	DSR active
 3	DCD active
 2,1	undefined
 0	ring indicator

Format of Access Server configuration parameter block:
Offset	Size	Description	(Table 02923)
 00h	BYTE	receive baud rate index
		00h 50 bps, 01h 75 bps, 02h 110 bps, 03h 134.5 bps,
		04h 150 bps, 05h 300 bps, 06h 600 bps, 07h 1200 bps,
		08h 1800 bps, 09h 2000 bps, 0Ah 2400 bps, 0Bh 3600 bps,
		0Ch 4800 bps, 0Dh 7200 bps, 0Eh 9600 bps, 0Fh 19200 bps,
		10h 38400 bps, 11h 57600 bps, 12h 115200 bps
 01h	BYTE	receive bits per character (0=5 bits..3=8 bits)
 02h	BYTE	receive stop bits
 03h	BYTE	receive parity
		00h none, 01h odd, 02h even, 03h mark, 04h space
 04h	BYTE	transmit baud rate index (same as receive baud rate)
 05h	BYTE	transmit bits per character (0=5 bits..3=8 bits)
 06h	BYTE	transmit stop bits
 07h	BYTE	transmit parity (same as receive parity)
 08h	BYTE	DTR state (00h off, 01h on)
 09h	BYTE	RTS state (00h off, 01h on)
 0Ah	BYTE	flow control (00h none, 01h XON/XOFF, 02h RTS/CTS, 03h both)
 0Bh	BYTE	break control (00h off, 01h on)

Format of Access Server statistics:
Offset	Size	Description	(Table 02924)
 00h	BYTE	port number
 01h	BYTE	external status signals (see #02922)
 02h	BYTE	transmitter status (see #02920)
 03h	BYTE	receiver status (see #02921)
 04h	DWORD	number of characters received
 08h	DWORD	number of characters transmitted
 0Ch	WORD	input parity errors
 0Eh	WORD	input framing errors
 10h	WORD	lost characters due to hardware overrun
 12h	WORD	lost characters due to data buffer overrun
Note:	the counts are not allowed to wrap around; once a count reaches FFFFh
	  or FFFFFFFFh, it is no longer incremented

Format of Access Server XON/XOFF characters:
Offset	Size	Description	(Table 02925)
 00h	BYTE	04h (number of bytes following)
 01h	BYTE	transmit XON character
 02h	BYTE	transmit XOFF character
 03h	BYTE	receive XON character
 04h	BYTE	receive XOFF character
--------N-2F7AFE-----------------------------
INT 2F U - Novell NetWare - DOSNP.EXE - INSTALLATION CHECK
	AX = 7AFEh
Return: AL = FFh if present
	    ES = (data???) segment of DOSNP
Program: DOSNP.EXE provides "named pipes" support for DOS workstations running
	   NetWare
Note:	the NetWare shell calls this function and refuses to load if DOSNP is
	  present
SeeAlso: AX=7A90h
--------N-2F7AFFBX0000-----------------------
INT 2F - Novell NetWare - TBMI v1.1+ - INSTALLATION CHECK / Windows SUPPORT
	AX = 7AFFh
	BX = 0000h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
	ES:DI -> Windows support procedure (see #02926)
Return: AL = FFh if installed
	    CX = configured sockets (14h)
	    DS:SI -> data table ???
	    ES:DI -> IPX far call handler
Notes:	for IPX/SPX this call reportedly returns DS:SI pointing to the table
	  of pointers to service events queue head and tail
	this function is also supported by IPXODI; v2.12 does not change DS,
	  but does set SI to an internal address
SeeAlso: AX=7AFFh/BX=0001h

(Table 02926)
Values Windows support procedure called with:
	BP = function
	    0001h Get ECB
		BX = socket number
		Return: ES:SI -> ECB or 0000h:0000h if none available
	    0002h Count Listen ECBs
		AX = BX = socket
		Return: CX = number of listen ECBs for socket
				(must be >= 2 for SPX to work)
	    0003h ???
	    0004h Inform task switcher of ECB locations
		Note:	registers other than those listed above are equal
			  to the values when IPX was called
Note:	the support function will not be called if IPX is called with BX
	  bit 15 set
--------N-2F7AFFBX0001-----------------------
INT 2F - Novell NetWare - TBMI v1.1+, shell v3.01d - INSTALLATION CHECK???
	AX = 7AFFh
	BX = 0001h
	CX = 4E65h ("Ne")
	DX = 7457h ("tW")
Return: AL = FFh if installed
	    CX = ???  (8000h)
	    SI = ??? (or -> ???) (0002h and 0007h seen)
	    ES:DI -> IPX far call handler
	    ES:DX -> 6-byte data area ???
Note:	this function is also supported by IPXODI, but IPXODI v2.12 does not
	  return ES:DX
SeeAlso: AX=7AFFh/BX=0000h
--------d-2F7F00-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - INSTALLATION CHECK
	AX = 7F00h
Return: AL = FFh if installed
SeeAlso: AX=7F01h"Harper",AX=7F02h"Harper",AX=7F03h"Harper"
--------P-2F7F00-----------------------------
INT 2F - PRINDIR v9.0 - INSTALLATION CHECK
	AX = 7F00h
Return: AL = FFh if installed
	    BX = version (BH = major, BL = minor)
	    CX:DX -> ASCIZ signature "PRINDIR"
Range:	AH=7Fh is the default, may be changed at installation time
Note:	prior versions of PRINDIR used INT 7C or INT 7A
SeeAlso: AX=7F01h"PRINDIR",AX=7F02h"PRINDIR",AX=7F03h"PRINDIR"
SeeAlso: AX=7F06h"PRINDIR",AX=7F08h,AX=7F0Ah,AX=7F0Ch,AX=7F0Eh,INT 7C"PRINDIR"
--------d-2F7F01-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - DO COMMAND
	AX = 7F01h
	DS:DX -> command record (see #02927)
Return: AL = status
	    00h successful
	    else error code
SeeAlso: AX=7F00h"Harper",AX=7F02h"Harper",INT 11/AH=FFh"SDLP"
SeeAlso: INT 21/AX=4402h"ASPI",INT 4F/AX=8100h

Format of CD-ROM redirector command record:
Offset	Size	Description	(Table 02927)
 00h	BYTE	ID
 01h 10 BYTEs	CDB (Command Descriptor Block) for operation (see #03236,#03237)
 0Bh	WORD	segment of buffer
 0Dh	WORD	offset of buffer
 0Fh	BYTE	status
 10h	BYTE	sense
 12h	WORD	count
--------P-2F7F01-----------------------------
INT 2F - PRINDIR v9.0 - SET CAPTURE DEVICE
	AX = 7F01h
	DX = capture device (as used by /GET commandline option)
Return: AX = status
	    0000h successful
	    FFFFh invalid device
SeeAlso: AX=7F00h"PRINDIR",AX=7F02h"PRINDIR",AX=7F03h"PRINDIR"
SeeAlso: AX=7F05h"PRINDIR"
--------d-2F7F02-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - DO RESET
	AX = 7F02h
SeeAlso: AX=7F00h,AX=7F01h
--------P-2F7F02-----------------------------
INT 2F - PRINDIR v9.0 - SET DESTINATION DEVICE
	AX = 7F02h
	DX = destination device number (as used by /PUT commandline option)
Return: AX = status
	    0000h successful
	    FFFFh invalid device number
SeeAlso: AX=7F00h"PRINDIR",AX=7F01h"PRINDIR",AX=7F04h"PRINDIR"
SeeAlso: AX=7F06h"PRINDIR"
--------d-2F7F03-----------------------------
INT 2F - Jim Harper's CD-ROM redirector SCSI driver - UNINSTALL
	AX = 7F03h
Return: AL = status
	    00h successful
	    01h unable to uninstall
SeeAlso: AX=7F00h
--------P-2F7F03-----------------------------
INT 2F - PRINDIR v9.0 - SET CAPTURE FILENAME
	AX = 7F03h
	CX:DX -> ASCIZ name of capture file
Return: AX = status
	    0000h successful
	    FFFFh name too long
SeeAlso: AX=7F00h"PRINDIR",AX=7F01h"PRINDIR",AX=7F04h"PRINDIR"
SeeAlso: AX=7F05h"PRINDIR",AX=7F07h"PRINDIR"
--------P-2F7F04-----------------------------
INT 2F - PRINDIR v9.0 - SET LOCK FILENAME
	AX = 7F04h
	CX:DX -> ASCIZ name of lock file
Return: AX = status
	    0000h successful
	    FFFFh invalid device number
SeeAlso: AX=7F00h"PRINDIR",AX=7F01h"PRINDIR",AX=7F03h"PRINDIR"
SeeAlso: AX=7F05h,AX=7F06h,AX=7F08h,AX=7F0Ah,AX=7F0Bh
--------P-2F7F05-----------------------------
INT 2F - PRINDIR v9.0 - DUMP CAPTURE BUFFER
	AX = 7F05h
Return: AX = status
	    0000h successful
SeeAlso: AX=7F00h"PRINDIR",AX=7F01h"PRINDIR",AX=7F04h"PRINDIR",AX=7F06h
--------P-2F7F06-----------------------------
INT 2F - PRINDIR v9.0 - SET NORMAL TEXT COLOR
	AX = 7F06h
	DH = new attribute for normal text
Return: AX = status
	    0000h successful
SeeAlso: AX=7F00h"PRINDIR",AX=7F01h"PRINDIR",AX=7F05h"PRINDIR",AX=7F07h
--------P-2F7F07-----------------------------
INT 2F - PRINDIR v9.0 - SET HIGHLIGHT TEXT COLOR
	AX = 7F07h
	DH = new attribute for highlighted text
Return: AX = status
	    0000h successful
SeeAlso: AX=7F00h"PRINDIR",AX=7F01h"PRINDIR",AX=7F06h"PRINDIR",AX=7F08h
--------P-2F7F08-----------------------------
INT 2F - PRINDIR v9.0 - SET POPUP HOTKEY
	AX = 7F08h
	DH = new scancode for hotkey
Return: AX = status
	    0000h successful
SeeAlso: AX=7F00h"PRINDIR",AX=7F05h"PRINDIR",AX=7F09h,AX=7F0Bh,AX=7F0Dh
--------P-2F7F09-----------------------------
INT 2F - PRINDIR v9.0 - SET BYTE COUNTER DISPLAY
	AX = 7F09h
	DH = new state (00h off, 01h on)
Return: AX = status
	    0000h successful
SeeAlso: AX=7F00h"PRINDIR",AX=7F07h"PRINDIR",AX=7F08h,AX=7F0Ah,AX=7F0Ch
--------P-2F7F0A-----------------------------
INT 2F - PRINDIR v9.0 - SET FLUSH DELAY
	AX = 7F0Ah
	DX = number of clock ticks before flushing
Return: AX = status
	    0000h successful
SeeAlso: AX=7F00h"PRINDIR",AX=7F07h"PRINDIR",AX=7F09h,AX=7F0Bh,AX=7F0Ch
--------P-2F7F0B-----------------------------
INT 2F - PRINDIR v9.0 - SET MINIMUM DUMP SIZE
	AX = 7F0Bh
	DX = number of kilobytes to accumulate before dumping
Return: AX = status
	    0000h successful
SeeAlso: AX=7F00h"PRINDIR",AX=7F0Ah,AX=7F0Ch,AX=7F0Dh,AX=7F0Eh
--------P-2F7F0C-----------------------------
INT 2F - PRINDIR v9.0 - SET ECHO STATE
	AX = 7F0Ch
	DX = new state (00h echo off, 01h echo on)
Return: AX = status
	    0000h successful
SeeAlso: AX=7F00h"PRINDIR",AX=7F0Ah,AX=7F0Bh,AX=7F0Dh,AX=7F0Eh
--------P-2F7F0D-----------------------------
INT 2F - PRINDIR v9.0 - SHOW POPUP PARAMETER MENU
	AX = 7F0Dh
Return: AX = status
	    0000h successful
	    else  failed
SeeAlso: AX=7F00h"PRINDIR",AX=7F0Ah,AX=7F0Bh,AX=7F0Ch,AX=7F0Eh
--------P-2F7F0E-----------------------------
INT 2F - PRINDIR v9.0 - SUBMIT BYTE TO CURRENT DESTINATION DEVICE
	AX = 7F0Eh
	DL = byte to send to destination device
Return: AX = status
	    0000h successful
	    else  failed
SeeAlso: AX=7F00h"PRINDIR",AX=7F0Ah,AX=7F0Bh,AX=7F0Ch,AX=7F0Dh
----------2F7F24-----------------------------
INT 2F - Multiplex - ???
	AX = 7F24h
	???
Return: ???
Note:	called by PC/370, an IBM 370 emulator by Donald S. Higgins
----------2F7F26-----------------------------
INT 2F - Multiplex - ???
	AX = 7F26h
	???
Return: ???
Note:	called by PC/370, an IBM 370 emulator by Donald S. Higgins
--------N-2F8000-----------------------------
INT 2F - EASY-NET - INSTALLATION CHECK
	AX = 8000h
Return: AL = 00h not installed
	     FFh installed
Program: EASY-NET is a shareware two-machine serial-port network
--------N-2F8000-----------------------------
INT 2F - Nanosoft, Inc. TurboNET server - INSTALLATION CHECK
	AX = 8000h
Return: AL = FFh if installed
	    BX = CS of resident code
	    CX = ??? (03FCh)
Program: TurboNET is a NetBIOS-based file redirector and server; a
	  demonstration version may be downloaded from Nanosoft's BBS
SeeAlso: AX=8100h
--------t-2F8000-----------------------------
INT 2F - CS_TSR specification - TSR INSTALLATION CHECK
	AX = 8000h
	DS:SI -> 4-byte CS_TSR signature (11h 43h 53h 10h)
Return: AL = status
	    00h no CS_TSR-compliant TSRs installed
	    01h installed, but signature did not match
	    FFh installed, signature matches
		ES:DI -> resident process block (see #02928) of last installed
			  TSR (if DS:SI pointed at signature on entry)
Program: the CS_TSR specification is a standardized TSR interface by Compact
	  Soft group in Kiev, Ukraine
Desc:	determine whether any CS_TSR-compliant TSRs are installed on the
	  selected multiplex number
Range:	AH=80h to AH=FFh
SeeAlso: AX=8001h"CS_TSR",AX=8002h"CS_TSR",AX=8003h"CS_TSR"

Format of CS_TSR process block:
Offset	Size	Description	(Table 02928)
 00h  4 BYTEs	CS_TSR signature 11h 43h 53h 10h
 04h	BYTE	INT 2F multiplex number
 05h	WORD	virtual process handle (unique among loaded TSRs)
 07h  2 BYTEs	version (binary minor version, then major version)
 09h	WORD	PSP segment of TSR
 0Bh	DWORD	pointer to ASCIZ program name
 0Fh  3 BYTEs	program creation date (day, month, year)
 12h  3 BYTEs	process start time (seconds, minutes, hours)
 15h  3 BYTEs	process start date (day, month, year)
--------F-2F8000DX0000-----------------------
INT 2F - FaxBIOS interface - INSTALLATION CHECK
	AX = 8000h
	DX = 0000h
	DI = 0000h
Return: AL = FFh if installed
	DX:DI -> signature "FaxBiosjpc"
Range:	AH=80h to AH=FFh, selected by scanning multiplex numbers for signature
SeeAlso: AH=2Ah,AX=80FBh
--------N-2F8001-----------------------------
INT 2F - Nanosoft, Inc. TurboNET server - ???
	AX = 8001h
	DS:SI -> 16-byte buffer for ???
Return: AH = status
	    00h successful
	    01h error (TurboNET busy)
Note:	makes NetBIOS calls
--------t-2F8001-----------------------------
INT 2F - CS_TSR specification - GET HANDLE (TSR-SPECIFIC INSTALLATION CHECK)
	AX = 8001h
	DS:SI -> ASCIZ signature string for desired TSR (see #02929)
Return: BX = process handle or 0000h if specified TSR not installed
	ES:DI -> process block for TSR (see #02928) if BX<>0000h
Note:	A widely-available copy of ASCII billing itself as "ASCII 2.OO by
	  Nick Zaikin Jr." is in fact a hacked copy of the Compact Soft
	  ASCII v4.23 which is identical except for the changed attribution
	  and version (in fact, some instances of "4.23" were missed); the
	  hacked copy requires the signature string
	  "ASCII 2.OO by Nick Zaikin Jr." instead of the unhacked version's
	  simple signature "ASCII"
SeeAlso: AX=8000h"CS_TSR",AX=8002h"CS_TSR"

(Table 02929)
Values for CS_TSR signature strings:
 "ASCII"	ASCII, a popup ASCII table with character input
 "Halculator"	HALC, a 32-bit RPN WYSIWIH calculator with undo and ptr support
 "AntiTurbo"	AT!, an intelligent system slow-down utility
--------t-2F8002-----------------------------
INT 2F - CS_TSR specification - GET PROCESS BLOCK BY PROCESS HANDLE
	AX = 8002h
	BX = process handle for TSR (see AX=8001h"CS_TSR")
Return: ES:DI -> process block for specified TSR (see #02928)
		unchanged if no match for process handle
Note:	This function is used to allocate a process handle when the TSR
	  installs itself, by setting ES:DI to point at something other than
	  a CS_TSR process block's signature string and iterating through the
	  possible process handles (0001h to FFFFh) until ES:DI is returned
	  unchanged
SeeAlso: AX=8000h"CS_TSR",AX=8001h"CS_TSR",AX=8003h"CS_TSR"
--------t-2F8003-----------------------------
INT 2F - CS_TSR specification - CUSTOM SUBFUNCTION
	AX = 8003h
	BX = process handle for TSR (see AX=8001h"CS_TSR")
	other registers vary by TSR
Return: vary by TSR, unchanged if not supported
Program: the CS_TSR specification is a standardized TSR interface by Compact
	  Soft group in Kiev, Ukraine
SeeAlso: AX=8000h"CS_TSR",AX=8001h"CS_TSR",AX=8002h"CS_TSR"
--------F-2F80FB-----------------------------
INT 2F - FaxBIOS interface - COMMAND SUBMISSION
	AX = 80FBh
	BX = function number (see #02930)
	DX:DI -> command buffer
		  (see #02932,#02935,#02936,#02937,#02938,#02939,#02944,#02950,#02957)
Return: AL = FFh if submitted OK
	CX = result code (see #02931)
Range:	AH=80h to AH=FFh, selected by scanning multiplex numbers for signature
SeeAlso: AX=8000h"FaxBIOS",AX=CBDDh

(Table 02930)
Values for FaxBIOS function number:
 0001h	SYS_LOGIN
 0002h	SYS_LOGOUT
 0003h	SYS_GET_FAXAPP_INFO
 0004h	STAT_IO_GET
 0005h	STAT_FAXBIOS_GET
 0006h	PDIR_OPEN
 0007h	PDIR_CLOSE (see #02940)
 0008h	PDIR_READ_PERSON (see #02941)
 0009h	PDIR_PARTIAL_READ
 000Ah	PDIR_READ_GROUP
 000Bh	PDIR_READ_MEMBER_LIST
 000Ch	PDIR_WRITE_PERSON
 000Dh	PDIR_WRITE_GROUP
 000Eh	PDIR_DELETE_PERSON
 000Fh	PDIR_DELETE_GROUP
 0010h	PDIR_READ_GROUP_LIST
 0011h	PDIR_IN_GROUP
 0012h	PDIR_OUT_GROUP
 0013h	SCHED_OPEN (see #02942)
 0014h	SCHED_ADD_DEST (see #02943)
 0015h	SCHED_ADD_FILE (see #02944)
 0016h	SCHED_SET_PARAMS (see #02945)
 0017h	SCHED_CANCEL (see #02942)
 0018h	SCHED_CLOSE (see #02946)
 0019h	SLOG_OPEN (see #02947)
 001Ah	SLOG_CLOSE (see #02947)
 001Bh	SLOG_SHORT_ENV_STAT
 001Ch	SLOG_LONG_ENV_STAT
 001Dh	SLOG_DEST_STAT
 001Eh	SLOG_FILE_STAT
 001Fh	SLOG_CANCEL_ENV
 0020h	RLOG_OPEN (see #02947)
 0021h	RLOG_CLOSE (see #02947)
 0022h	RLOG_READ
 0023h	GRAPH_GET_FILE_TYPE (see #02948)
 0024h	GRAPH_EXPORT_FILE
 0025h	GRAPH_GET_LAYOUT_INFO
 0026h	GRAPH_CREATE_FILE (see #02949)
 0027h	GRAPH_CLOSE_FILE (see #02950)
 0028h	GRAPH_CREATE_PAGE (see #02951)
 0029h	GRAPH_WRITE (see #02952)
 002Ah	GRAPH_END_PAGE
 002Bh	GRAPH_OPEN_FILE (see #02953)
 002Ch	GRAPH_GOTO_PAGE (see #02954)
 002Dh	GRAPH_READ (see #02955)
 002Eh	IOCTL_GET
 002Fh	IOCTL_SET
 0030h	IOCTL_ANSWER_FAX (see #02956)
 0031h	IOCTL_DIAL (see #02957)

(Table 02931)
Values for FaxBIOS result code:
 0000h	successful
 0001h	not prepared or servicing another client (busy)
 0002h	call failed due to sharing (LOCKED)
 0003h	logged-in client limit reached (FULL)
 0004h	transport denied (TRANSPORT_DENIED)
 0005h	not implemented (NOT_IMPLEMENTED)
 0006h	aborted while in progress (ABORTED)
 0007h	permissions denied (PERMISSION_DENIED)
 0008h	requested data is no longer valid (NO_LONGER_VALID)
 0080h	unspecified system error occurred
 0081h	an internal file was not found
 0082h	an internal file could not be created
 0083h	an internal file could not be opened
 0084h	an internal file could not be closed
 0085h	error occurred writing to an internal file
 0086h	error occurred reading from an internal file
 0087h	bad or corrupted file encountered
 0088h	an access violation occurred
 0089h	an internal file is empty
 008Ah	insufficient memory to process request
 008Bh	FaxBIOS was unable to issue a handle
 008Ch	an error internal to FaxBIOS occurred
 008Dh	no room on disk
 0100h	unspecified error accessing client file
 0101h	file not found
 0102h	creation fault
 0103h	open fault
 0104h	close fault
 0105h	write fault
 0106h	read fault
 0107h	file corrupted
 0108h	access violation
 0109h	empty file
 0200h	unspecified argument error
 0201h	bad function
 0202h	bad option
 0203h	bad structure size
 0204h	bad buffer size
 0205h	bad client ID
 0300h	unspecified error with token
 0301h	cover sheet token was invalid
 0302h	logo token was invalid
 0303h	signature token was invalid
 0304h	font token was invalid
 0305h	phone directory token was invalid
 0306h	outbound route token was invalid
 0307h	priority token was invalid
 0308h	sort token was invalid
 0309h	billing token was invalid
 0400h	unspecified handle error
 0401h	bad Phone Directory handle
 0402h	bad scheduling handle
 0403h	bad read send log handle
 0404h	bad read receive log handle
 0405h	bad graphics handle
 0500h	data passed in structure was invalid
 0501h	name field given is invalid
 0502h	phone number given is invalid
 0503h	poll code submitted is invalid
 0504h	file type constant was invalid
 0505h	BFT constant not defined or supported
 0506h	resolution not defined or supported
 0507h	page length not defined or supported
 0508h	page width not defined or supported
 0509h	date & time requested are ridiculous
 050Ah	Subject text was not an ASCIZ string
 050Bh	From text was not an ASCIZ string
 050Ch	requested envelope ID was not found
 050Dh	requested envelope ID is not valid
 050Eh	envelope requested was not found
 050Fh	destination index is out of range
 0510h	file index is out of range
 0511h	index into receive log is out of range
 0512h	file name specified was incomplete or invalid
 0513h	page selected was out of range
 0514h	bit width more than byte width
 0515h	mode for open is not defined
 0516h	person index is out of range
 0517h	person ID is out of range
 0518h	group index out of range or invalid
 0519h	group ID out of range or invalid
 051Ah	range of indices to read is invalid
 051Bh	group name given is invalid
 051Ch	field_to_use is badly specified
 051Dh	predicate invalid for field specified
 0600h	unspecified client procedure error
 0601h	device of interest is not present
 0602h	device of interest has been removed
 0603h	device of interest is not responding
 0604h	device of interest is disabled
 0605h	could not dial because device was in use
 0606h	maximum destination limit exceeded
 0607h	maximum file limit exceeded
 0608h	scheduling closed with no destination
 0609h	scheduling closed with no files or poll
 060Ah	scheduling closed with no parameters specified
 060Bh	file type specified does not match file
 060Ch	file type specified is not supported
 060Dh	file submitted is not exportable
 060Eh	file type specified is not imageable
 060Fh	error converting file
 0610h	envelope could not be cancelled
 0611h	Phone Directory is full
 0612h	record is already in the Phone Directory
 0613h	selected group in Phone Directory is full
 0614h	person is already in the group
 0615h	person is not in the group & cannot be removed
 0616h	a graphics file to be created already exists
 0617h	a graphics file to be read is empty
 0618h	GRAPH_CREATE_PAGE called before GRAPH_END_PAGE
 0619h	graph read or write attempted without goto or create
 061Ah	graph page contains no data
 061Bh	Phone Directory is already open for this client
 061Ch	schedule log is already open for this client
 061Dh	receive log is aready open for this client
 061Eh	Phone Directory function requires write mode
 0800h	denied exclusive use of the API

Format of FaxBIOS SYS_LOGIN command buffer:
Offset	Size	Description	(Table 02932)
 00h	WORD	structure size
 02h	WORD	function number
 04h	WORD	return code
 06h	WORD	client ID
 08h	WORD	API Major Version
 0Ah	WORD	API Minor Version
 0Ch	DWORD	reserved for manufacturer's use
 10h 22 BYTEs	manufacturer's ID
 26h	WORD	highest possible device number
 28h	WORD	maximum destinations per envelope
 2Ah	WORD	maximum files per envelope
 2Ch	WORD	FaxBIOS capabilities (see #02933)
 2Eh	DWORD	T.30 capabilities (see #02934)
 32h	WORD	IPC handle
 34h	DWORD	amount of memory needed to load
 38h	WORD	scope (00h for public, nonzero for private)
 3Ah  6 BYTEs	future expansion
 40h	WORD	structure size

Bitfields for FaxBIOS capabilities:
Bit(s)	Description	(Table 02933)
 0	transmit supported
 1	receive supported
 2	IOCTL supported
 3	IOCTL_DIAL supported
 4	IOCTL_ANSWER_FAX supported
 5	manual transmit supported
 6	optional phone services supported
 7	canonical phone objects
 8	seam with next supported

Bitfields for T.30 capabilities:
Bit(s)	Description	(Table 02934)
 0	low vertical resolution (minimum)
 1	high vertical resolution
 2	page width 107mm (4.21 in)
 3	page width 151mm (5.91 in)
 4	page width 215mm (8.46 in) (minimum)
 5	page width 255mm (10.04 in)
 6	page width 303mm (11.93 in)
 7	unused
 8	page length 297mm (11.69 in) (minimum)
 9	page length 364mm (14.33 in)
 10	page length 279mm (11 in)
 11	page length unlimited
 12	Group 4 resolution 300x300
 13	Group 4 resolution 400x400
 14	able to respond to poll from remote
 15	able to poll remote
 16	binary file transfer supported

Format of FaxBIOS SYS_LOGOUT command buffer:
Offset	Size	Description	(Table 02935)
 00h	WORD	structure size
 02h	WORD	function number
 04h	WORD	return code
 06h	WORD	client ID
 08h	DWORD	client tag (for client's internal use)
 0Ch  6 BYTEs	future expansion
 12h	WORD	structure size

Format of FaxBIOS SYS_GET_FAXAPP_INFO command buffer:
Offset	Size	Description	(Table 02936)
 00h 12 BYTEs	common data (see #02935)
 0Ch 80 BYTEs	FaxBIOS data
 5Ch 80 BYTEs	default cover
 ACh 80 BYTEs	default logo
 FCh 80 BYTEs	default signature
14Ch 80 BYTEs	default font 10
19Ch 80 BYTEs	default font 165
1ECh 80 BYTEs	default user font
23Ch 80 BYTEs	default Pdir
28Ch 80 BYTEs	default sort
2DCh 10 BYTEs	default bill
2E6h 10 BYTEs	default route
2F0h 40 BYTEs	default cover sheet form
318h 34 BYTEs	valid dial characters
33Ah  6 BYTEs	local country code
340h  6 BYTEs	local city or area code
346h  6 BYTEs	future expansion
34Ch	WORD	structure size

Format of FaxBIOS STAT_IO_GET command buffer:
Offset	Size	Description	(Table 02937)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	device number
 0Eh	WORD	current activity
 10h	WORD	number of rings (if ringing)
 12h	WORD	number of fascimiles transmitted
 14h	WORD	number of fascimiles received
 16h	WORD	status of last transmission
 18h	WORD	envelope number of last transmission
 1Ah	WORD	index of last destination in envelope
 1Ch	WORD	status of last reception
 1Eh	WORD	current page (if session in progress)
 20h 80 BYTEs	current file
 70h 104 BYTEs	remote number
 D8h 20 BYTEs	last name
 ECh 20 BYTEs	first name
100h 32 BYTEs	company name
120h 32 BYTEs	notes
140h	WORD	current envelope ID (if sending)
142h	WORD	total pages in transmission (if sending)
144h  6 BYTEs	future expansion
14h	WORD	structure size

Format of FaxBIOS STAT_FAXBIOS_GET command buffer:
Offset	Size	Description	(Table 02938)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	status ID
 0Eh	WORD	currenty FaxBIOS function number
 10h	WORD	current Client ID being serviced
 12h	WORD	number of things to do
 14h	WORD	number of them done
 16h	WORD	number of pages to do (if any)
 18h	WORD	number of them done
 1Ah	WORD	number of files to do
 1Ch	WORD	number of them done
 1Eh 80 BYTEs	current File
 6Eh	WORD	0 if all devices are idle
 70h	WORD	number of fascimiles transmitted
 72h	WORD	number of fascimiles received
 74h	WORD	status of last transmission in system
 76h	WORD	envelope ID of last transmission
 78h	WORD	index of last destination in envelope
 7Ah	WORD	status of last reception in system
 7Ch	DWORD	time of next transmission
 80h  6 BYTEs	future expansion
 86h	WORD	structure size

Format of FaxBIOS PDIR_OPEN command buffer:
Offset	Size	Description	(Table 02939)
 00h 12 BYTEs	common data (see #02935)
 0Ch 80 BYTEs	Phone Directory token
 5Ch 80 BYTEs	sort order token
 ACh	WORD	open Mode (0 = read, 1 = write)
 AEh	WORD	Phone Directory handle
 B0h	WORD	number of people
 B2h	WORD	number of groups
 B4h	WORD	bitmap of fields supported by partial read
 B6h  6 BYTEs	future expansion
 BCh	WORD	structure size

Format of FaxBIOS PDIR_CLOSE command buffer:
Offset	Size	Description	(Table 02940)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	Phone Directory handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size

Format of FaxBIOS PDIR_READ_PERSON command buffer:
Offset	Size	Description	(Table 02941)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	Phone Directory handle
 0Eh	WORD	retrieve by index
 10h	WORD	person ID or index
 12h	WORD	how many groups person is in
 14h	WORD	person ID
 16h 20 BYTEs	last name
 2Ah 20 BYTEs	first name
 3Eh 32 BYTEs	company
 5Eh 32 BYTEs	notes
 7Eh  6 BYTEs	FAX country code
 84h  6 BYTEs	FAX city/area code
 8Ah 14 BYTEs	FAX local number
 98h 14 BYTEs	FAX extension
 A6h 24 BYTEs	reserved
 BEh  6 BYTEs	voice country code
 C4h  6 BYTEs	voice city/area code
 CAh 14 BYTEs	voice local number
 D8h 14 BYTEs	voice extension
 E6h 24 BYTEs	reserved
 FEh 10 BYTEs	outbound routing information
108h 10 BYTEs	billing information, credit card etc
112h	DWORD	remote FAX capabilities
116h 21 BYTEs	T.30 poll code of FAX number
12Bh 15 BYTEs	reserved
13Ah  6 BYTEs	future expansion
140h	WORD	structure size

Format of FaxBIOS SCHED_OPEN, SCHED_CANCEL command buffer:
Offset	Size	Description	(Table 02942)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	scheduler handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size

Format of FaxBIOS SCHED_ADD_DEST command buffer:
Offset	Size	Description	(Table 02943)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	schedule handle
 0Eh	WORD	device number if manual send wanted
 10h	WORD	non-zero if poll desired
 12h	WORD	person ID
 14h 20 BYTEs	last name
 28h 20 BYTEs	first name
 3Ch 32 BYTEs	company
 5Ch 32 BYTEs	notes
 7Ch  6 BYTEs	FAX country code
 82h  6 BYTEs	FAX city/area code
 88h 14 BYTEs	FAX local number
 96h 14 BYTEs	FAX extension
 A4h 24 BYTEs	reserved
 BCh  6 BYTEs	voice country code
 C2h  6 BYTEs	voice city/area code
 C8h 14 BYTEs	voice local number
 D6h 14 BYTEs	voice extension
 E4h 24 BYTEs	reserved
 FCh 10 BYTEs	outbound routing information
106h 10 BYTEs	billing information, credit card etc
110h	DWORD	remote FAX capabilities
114h 21 BYTEs	T.30 poll code of FAX number
129h 15 BYTEs	reserved
138h  6 BYTEs	future expansion
13Eh	WORD	structure size
SeeAlso: #02944

Format of FaxBIOS SCHED_ADD_FILE command buffer:
Offset	Size	Description	(Table 02944)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	schedule handle
 0Eh	WORD	file type
		0000h unidentified
		0001h native file format
		0002h ASCII
		0003h FaxBIOS Tiff Class F
 10h 80 BYTEs	file name
 60h 80 BYTEs	font token
 B0h	WORD	conversion options bitmap
 B2h	WORD	resolution
		0000h standard 98 lines per inch, 204 dpi
		0001h fine 196 lines per inch, 204 dpi
		0002h Group4 300 dpi
		0003h Group4 400 dpi
 B4h	WORD	page length
		0000h 279 mm (11 in)
		0001h 297 mm (11.69 in)
		0002h 364 mm (14.33 in)
		0003h unlimited
 B6h	WORD	page width
		0000h 215 mm (8.46 in)
		0001h 255 mm (10.04 in)
		0002h 303 mm (11.93 in)
		0003h 151 mm (5.91 in)
		0004h 107 mm (4.21 in)
 B8h	WORD	binary file transfer specification
		0000h only as FAX
		0001h only as file (for non-faxable files)
		0002h as file when possible else FAX
 BAh	WORD	seam flag (nonzero for seam with next)
 BCh	WORD	delete flag (nonzero to delete when done)
 BEh  6 BYTEs	future expansion
 C4h	WORD	structure size
SeeAlso: #02943,#02945

Format of FaxBIOS SCHED_SET_PARAMS command buffer:
Offset	Size	Description	(Table 02945)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	scheduler handle
 0Eh	DWORD	time to send
 10h 10 BYTEs	priority token
 1Ch 80 BYTEs	logo file token
 6Ch 80 BYTEs	signature file token
 BCh 80 BYTEs	cover page token
10Ch 40 BYTEs	Subject text
134h 40 BYTEs	From text
15Ch	WORD	user ID
15Eh  6 BYTEs	future expansion
164h	WORD	structure size
SeeAlso: #02943,#02944,#02946

Format of FaxBIOS SCHED_CLOSE command buffer:
Offset	Size	Description	(Table 02946)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	scheduler handle
 0Eh	WORD	envelope ID generated
 10h  6 BYTEs	future expansion
 16h	WORD	structure size
SeeAlso: #02945

Format of FaxBIOS SLOG_OPEN, SLOG_CLOSE, RLOG_OPEN, RLOG_CLOSE command buffer:
Offset	Size	Description	(Table 02947)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	log handle
 0Eh	WORD	number of entries
 10h  6 BYTEs	future expansion
 16h	WORD	structure size

Format of FaxBIOS GRAPH_GET_FILE_TYPE command buffer:
Offset	Size	Description	(Table 02948)
 00h 12 BYTEs	common data (see #02935)
 0Ch 80 BYTEs	filename
 5Ch	WORD	file type
		0000h unidentified
		0001h native file format
		0002h ASCII
		0003h FaxBIOS Tiff Class F
 5Eh	WORD	bitmap of supported capabilities
 60h  6 BYTEs	future expansion
 66h	WORD	structure size
SeeAlso: #02949,#02950

Format of FaxBIOS GRAPH_CREATE_FILE command buffer:
Offset	Size	Description	(Table 02949)
 00h 12 BYTEs	common data (see #02935)
 0Ch 80 BYTEs	filename
 5Ch	WORD	graph handle
 5Eh  6 BYTEs	future expansion
 64h	WORD	structure size
SeeAlso: #02948,#02950,#02951

Format of FaxBIOS GRAPH_CLOSE_FILE, GRAPH_END_PAGE command buffer:
Offset	Size	Description	(Table 02950)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	graph handle
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size
SeeAlso: #02949,#02951

Format of FaxBIOS GRAPH_CREATE_PAGE command buffer:
Offset	Size	Description	(Table 02951)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	graph handle
 0Eh	WORD	resolution
 10h	WORD	page width
 12h  6 BYTEs	future expansion
 18h	WORD	structure size
SeeAlso: #02949,#02950,#02952

Format of FaxBIOS GRAPH_WRITE_PAGE command buffer:
Offset	Size	Description	(Table 02952)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	graph handle
 0Eh	DWORD	pointer to storage for image
 12h	WORD	band height in lines
 14h	WORD	width of page image in bytes
 16h	WORD	facsimile page width constant
 18h	WORD	width of page image in bits
 1Ah	WORD	number of bytes actually processed
 1Ch  6 BYTEs	future expansion
 22h	WORD	structure size
SeeAlso: #02951,#02953

Format of FaxBIOS GRAPH_OPEN_FILE command buffer:
Offset	Size	Description	(Table 02953)
 00h 12 BYTEs	common data (see #02935)
 0Ch 80 BYTEs	filename
 5Ch	WORD	file type
 5Eh	WORD	graph handle
 60h	WORD	number of pages
 62h  6 BYTEs	future expansion
 68h	WORD	structure size
SeeAlso: #02952,#02954

Format of FaxBIOS GRAPH_GOTO_PAGE command buffer:
Offset	Size	Description	(Table 02954)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	graph handle
 0Eh	WORD	page number
 10h	WORD	vertical resolution
 12h	WORD	page width
 14h	DWORD	page length
 18h  6 BYTEs	future expansion
 1Eh	WORD	structure size
SeeAlso: #02952,#02953,#02955

Format of FaxBIOS GRAPH_READ_PAGE command buffer:
Offset	Size	Description	(Table 02955)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	graph handle
 0Eh	DWORD	pointer to storage for image
 12h	WORD	band height in lines
 14h	WORD	width of page image in bytes
 16h	WORD	facsimile page width constant
 18h	WORD	width of page image in bits
 1Ah	WORD	number of bytes actually processed
 1Ch  6 BYTEs	future expansion
 22h	WORD	structure size

Format of FaxBIOS IOCTL_ANSWER_FAX command buffer:
Offset	Size	Description	(Table 02956)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	device number
 0Eh  6 BYTEs	future expansion
 14h	WORD	structure size
SeeAlso: #02957

Format of FaxBIOS IOCTL_DIAL command buffer:
Offset	Size	Description	(Table 02957)
 00h 12 BYTEs	common data (see #02935)
 0Ch	WORD	device number
 0Eh  6 BYTEs	country code
 14h  6 BYTEs	city or area code
 1Ah 14 BYTEs	local number
 28h 14 BYTEs	extension
 36h 14 BYTEs	reserved
 4Eh  6 BYTEs	future expansion
 54h	WORD	structure size
SeeAlso: #02956
--------N-2F8100-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - INSTALLATION CHECK
	AX = 8100h
Return: AL = FFh if installed
Program: TurboNET is a NetBIOS-based file redirector and server; a
	  demonstration version may be downloaded from Nanosoft's BBS
SeeAlso: AX=8000h"TurboNET"
--------N-2F8101-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8101h
Return: AL = ???
	DL = ???
--------N-2F8102-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8102h
Return: AL = ???
	DL = ???
--------N-2F8103-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - GET MACHINE NAME???
	AX = 8103h
	ES:DI -> 17-byte buffer
Return: buffer filled
--------N-2F8104-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8104h
	BL = ???
	BH = ???
	CX = ???
	DX = ???
	DS:SI -> 16-byte buffer containing ???
Return: AL = 00h ???
--------N-2F8105-----------------------------
INT 2F U - Nanosoft, Inc. TurboNET redirector - ???
	AX = 8105h
	CX = ??? (don't change current value if 0000h)
	DX = ??? (don't change current value if 0000h)
Return: AL = 00h successful
--------s-2F8200-----------------------------
INT 2F - RESPLAY - SAMPLE/PLAYBACK
	AX = 8200h
	DX:DI -> start of sample space
	CX:BX = length in bytes
Return: AX = status (see #02958)
Program: RESPLAY is a freeware sound sampling/playback utility by Mark J. Cox
SeeAlso: AX=8201h"RESPLAY",AX=8210h

(Table 02958)
Values for RESPLAY status:
 1000h	successful
 2000h	not initialized (see AX=8210h)
 other	RESPLAY not installed
--------G-2F8200-----------------------------
INT 2F U - Nanosoft, Inc. CAPDOS - INSTALLATION CHECK
	AX = 8200h
Return: AL = FFh if installed
Program: CAPDOS is a TSR by Nanosoft, Inc. which allows INT 21h calls to be
	  captured and recorded for later analysis
SeeAlso: AX=8100h,AX=8201h"CAPDOS",AX=8202h"CAPDOS",AX=8203h"CAPDOS"
SeeAlso: AX=8204h"CAPDOS"
--------s-2F8201-----------------------------
INT 2F - RESPLAY - INSTALLATION CHECK
	AX = 8201h
Return: AX = 7746h if installed
SeeAlso: AX=8202h"RESPLAY",AX=8210h
--------G-2F8201-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - CLEAR QUEUE
	AX = 8201h
Note:	resets queue of captured INT 21 calls
SeeAlso: AX=8200h"CAPDOS"
--------s-2F8202-----------------------------
INT 2F - RESPLAY - UNINSTALL
	AX = 8202h
Return: AX = status
	    1000h successful
SeeAlso: AX=8201h"RESPLAY",AX=8210h"RESPLAY"
--------G-2F8202-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - START COLLECTION
	AX = 8202h
SeeAlso: AX=8200h"CAPDOS",AX=8203h"CAPDOS"
--------G-2F8203-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - STOP COLLECTION
	AX = 8203h
SeeAlso: AX=8200h"CAPDOS",AX=8202h"CAPDOS",AX=8204h"CAPDOS"
--------G-2F8204-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - GET QUEUE PARAMETERS
	AX = 8204h
Return: AH = flag: queue wrapped if nonzero
	BX = index of current start of queue
	CX = size of queue in entries
SeeAlso: AX=8200h"CAPDOS",AX=8202h"CAPDOS",AX=8205h"CAPDOS"
--------G-2F8205-----------------------------
INT 2F - Nanosoft, Inc. CAPDOS - GET QUEUE ITEM
	AX = 8205h
	BX = queue item number
Return: AX,BX,CX,DX,SI,DI,DS,ES as on entry to captured DOS call
SeeAlso: AX=8200h"CAPDOS",AX=8204h"CAPDOS"
--------s-2F8210-----------------------------
INT 2F - RESPLAY - INITIALIZE
	AX = 8210h
	BL = sound device number (see #02959)
	BH = sample rate in multiples of 250 Hz (14h to A0h)
	CL = direction
	    00h playback
	    01h sample
Return: AX = status (see #02958)
SeeAlso: AX=8200h"RESPLAY",AX=8220h"MODRES"

(Table 02959)
Values for RESPLAY sound device:
 00h	printer port LPT1
 01h	printer port LPT2
 02h	prototype board at I/O address 0300h
 03h	printer port (alternative LPT1)
 04h	internal speaker
--------s-2F8220-----------------------------
INT 2F - MODRES - PLAY MODULE
	AX = 8220h
	DX:CX -> MODPARM structure (see #02960)
Return: AX = status
	    5722h succesful
	    2000h parameters out of range
	    other MODRES not installed
SeeAlso: AX=8221h,AX=8223h,AX=8225h,AX=8227h,AX=8200h"RESPLAY"

Format of MODPARM Structure:
Offset	Size	Description	(Table 02960)
 00h	WORD	signature 504Dh ("MP" = Modparm)
 02h	BYTE	output device (see #02962 at INT 2F/AX=8221h)
 03h	WORD	segment of start of main module (pattern) data
 05h 31	WORDs	segment of start of sample numbers 1-31
 43h	BYTE	pattern at which to start playing (00h to 7Fh)
 44h	BYTE	function
		00h play from pattern [offset 43h] until end of the song
		01h play indicated pattern [offset 43h] only
 45h	BYTE	Machine speed
		00h 10-12Mhz
		01h 12-25Mhz (default)
		02h 25Mhz+
		03h mix speed 10kHz (fast 8Mhz machines)
		04h mix speed 12kHz (10Mhz machines)
		05h mix speed 13kHz
		06h mix speed 8kHz (test for 8Mhz machines)
 46h	BYTE	allow >64k sample playing
		80h MOD has samples >64k in it
		else all samples in MOD are <64k
Notes:	Main module data and all samples must start on segment boundaries.
	In version 2.00 (ONLY) this function carries on playing (works in
	  the background)
SeeAlso: #02961
--------s-2F8221-----------------------------
INT 2F - MODRES - INSTALLATION CHECK
	AX = 8221h
Return: AX = status
	    5722h successful
	    other MODRES not installed
	BX = BCD version number (BH = major, BL = minor)
	DX:CX -> Output Device structure (read-only) (see #02961)
SeeAlso: AX=8220h,AX=8222h,AX=8225h,AX=8227h

Format of Output Device structure [array]:
Offset	Size	Description	(Table 02961)
 00h 20 BYTEs	ASCIZ name of the output device
		(end of list if first char is FFh)
 14h	WORD	apparently always FFFFh
 16h	WORD	0000h if output device not available
		else first I/O port for the output device
 18h	WORD	second I/O port for the output device (for example
		  if it is stereo)
		000oh if only one port used or device is not available
 1Ah  7 BYTEs	???
SeeAlso: #02960,#02962

(Table 02962)
Values for MODRES v1.52 output device index:
 00h	PC speaker
 01h	D/A Converter on LPT1
 02h	D/A Converter on LPT2
 03h	D/A Converter on LPT3
 04h	D/A Converter on LPT4
 05h	D/A Converter on LPT1&LPT2 (stereo)
 06h	D/A Converter on LPT1&LPT2 (mono)
 07h	Sound Blaster (port 02x0h)
 08h	User Defined D/A (mono)
 09h	User Defined D/A (stereo)
 0Ah	Stereo-on-1
 0Bh	Disney SS su LPT1
 0Ch	Disney SS su LPT2
 0Dh	Disney SS su LPT3
 0Eh	Disney SS su LPT4
Note:	this list may vary between versions of MODRES
--------s-2F8222-----------------------------
INT 2F - MODRES - UNINSTALL
	AX = 8222h
Return: AX = code segment of the program
Note:	this function does not release the TSRs memory; the caller must do so
SeeAlso: AX=8220h,AX=8221h,AX=8223h
--------s-2F8223-----------------------------
INT 2F - MODRES - PLAY SAMPLE
	AX = 8223h
	DX:CX -> SAMPARM structure (see #02963)
Return: AX = status
	    5722h succesful
	    2000h parameters out of range
	    other MODRES not installed
SeeAlso: AX=8221h,AX=8224h,AX=8225h,AX=8226h

Format of SAMPARM Structure:
Offset	Size	Description	(Table 02963)
 00h	WORD	signature 5053h ("SP" = SAMPARM)
 02h	WORD	segment of start of sample to play
 04h	WORD	length of sample (IN WORD)
 06h	BYTE	output device (see #02962 at INT 2F/AX=8221h)
 07h	WORD	pitch to play (see #02964)
 09h	BYTE	volume (from 00h to 40h)
 0Ah	WORD	loop start
 0Ch	WORD	loop length
 0Eh	BYTE	machine speed (see INT 2F/AX=8220h)
SeeAlso: #02960

(Table 02964)
Values for Pitch to play::
 C 0 is	06B0h
 C#0 is	06B0h / 2^(1/12)
 D 0 is	(06B0h / 2^(1/12)) / 2^(1/12)
 ...
Note:	C 1 is	06B0h / 2
	C 2 is	06B0h / 4
	etc.
SeeAlso: #02963
--------s-2F8224-----------------------------
INT 2F - MODRES - ???
	AX = 8224h
	DX:CX -> ???
Return: ???
SeeAlso: AX=8221h,AX=8223h,AX=8224h
--------s-2F8225-----------------------------
INT 2F - MODRES v2.00+ - GET LOCATION IN MOD
	AX = 8225h
Return: AL = status
	   00h playing
	   01h reached end or stopped
	AH = speed of MOD
	BX = position within pattern 0000h-0400h
	CL = position within the song (track number)
SeeAlso: AX=8220h,AX=8221h,AX=8223h,AX=8226h
--------s-2F8226-----------------------------
INT 2F - MODRES v2.00+ - STOP PLAYING
	AX = 8226h
Return: AX = status
	    5722h succesful
	    other MODRES not installed
Desc:	stops playing the MOD file before performing critical operations such
	  as disk accesses
SeeAlso: AX=8220h,AX=8221h,AX=8223h,AX=8225h,AX=8227h
--------s-2F8227-----------------------------
INT 2F - MODRES - CONFIGURE
	AX = 8227h
	BX = function
	    0001h set default playing speed (06h)
	    0002h select output device
		CL = output device (see #02962 at INT 2F/AX=8221h)
Return: AX = status
	    5722h succesful
	    2000h parameters out of range
	    other MODRES not installed
Note:	function 0001h should be called every time a new module is loaded
SeeAlso: AX=8220h,AX=8221h,AX=8222h,AX=8223h
----------2F86-------------------------------
INT 2F U - ???
	AH = 86h
	AL = function (at least 06h and 07h)
	???
Return: ???
Note:	called by Codeview for Windows
SeeAlso: AH=44h
--------U-2F8900-----------------------------
INT 2F - WHOA!.COM - INSTALLATION CHECK
	AX = 8900h
Return: AL = state
	    00h not installed
	    FFh installed
Program: WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8901h,AX=8902h
--------U-2F8901-----------------------------
INT 2F - WHOA!.COM - UNINSTALL
	AX = 8901h
Return: AL = status
	    FDh successful
	    FEh error
SeeAlso: AX=8900h
--------U-2F8902-----------------------------
INT 2F - WHOA!.COM - SET DELAY COUNT
	AX = 8902h
	BX = delay count (larger values slow system down more)
Return: AL = status
	    FDh successful
	    FEh error
Program: WHOA!.COM is a system slow-down utility by Brad D Crandall
SeeAlso: AX=8900h
--------U-2F9000-----------------------------
INT 2F U - RAID - INSTALLATION CHECK
	AX = 9000h
Return: AL = FFh if installed
Program: RAID (Resident AID) is a TSR utility program by Ross Neilson
	  Wentworth that resides mostly in EMS
--------U-2F9001-----------------------------
INT 2F U - RAID - GET ???
	AX = 9001h
Return: DX:AX -> ???
SeeAlso: AX=9000h
--------U-2F9002-----------------------------
INT 2F U - RAID - GET RESIDENT SEGMENT
	AX = 9002h
Return: AX = segment of resident (conventional memory) portion
SeeAlso: AX=9000h
--------U-2F9003-----------------------------
INT 2F U - RAID - UNINSTALL
	AX = 9003h
Return: ???
SeeAlso: AX=9000h
--------U-2F9004-----------------------------
INT 2F U - RAID - GET ???
	AX = 9004h
Return: AX = first available paragraph past end of resident portion???
	CX destroyed
SeeAlso: AX=9000h
--------e-2F92-------------------------------
INT 2F - Network Courier E-Mail - API
	AH = 92h
	AL = function
	    00h installation check
	    01h uninstall
	    02h pop down MICRO.EXE notification window
	    03h ???
	    04h ???
	    05h ???
Return: ???
Program: The Network Courier is an electronic mail package by Consumers
	  Software of Vancouver, BC which was bought by Microsoft in 1991 and
	  renamed Microsoft Mail v3.0.
SeeAlso: AX=9400h,AX=9401h,AX=9402h,AH=9Ch
Index:	installation check;Network Courier E-Mail
Index:	uninstall;Network Courier E-Mail
--------R-2F9200-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - BUG
	AX = 9200h
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
BUG:	jumps to data because jump table entry is 0000h
Note:	DRIVEMAP returns AX=FFFFh if not a valid function number in AL
--------R-2F9201-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - CHECK IF MAPPED DRIVE
	AX = 9201h
	DL = drive number (01h = A:, etc.)
Return: AL = 92h if mapped drive
	AH may be destroyed (v8.0 DRIVEMAP returns AX=0000h if not mapped)
SeeAlso: AX=9204h,AX=920Bh
--------R-2F9202-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - UNINSTALL
	AX = 9202h
	BX = caller's CS
Return: AX = status
	    0000h failed
	    nonzero successful
SeeAlso: AX=9204h
--------R-2F9203-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET VERSION
	AX = 9203h
Return: AH = major version
	AL = minor version
	CX = segment of resident code
Note:	the DRIVEMAP included with PC Tools v8.0 is version 1.00
SeeAlso: AX=9204h,INT 16/AX=FF70h
--------R-2F9204-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - INSTALLATION CHECK
	AX = 9204h
Return: AX = 9200h if installed
	   BL = ???
	   CX = segment of resident code
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
SeeAlso: AX=9201h,AX=9202h,AX=9203h
--------R-2F9205-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - SET ???
	AX = 9205h
	BX = ??? to set
Return: CX = new value of ???
--------R-2F9206-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9206h
	???
Return: ???
--------R-2F9207-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9207h
	???
Return: AX = ???
--------R-2F9208-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9208h
	???
Return: ???
--------R-2F9209-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9209h
	???
Return: AX = ???
	BX = ???
	CX = ???
	DX = ???
--------R-2F920A-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 920Ah
	BX = ???
Return: AX = ??? or FFFBh on error
--------R-2F920B-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - SET DRIVE MAPPING
	AX = 920Bh
	BL = drive letter (41h ['A'] = A:, etc)
	CX = ??? (0000h removes mapping)
Return: AX = ??? or FFF8h on error
SeeAlso: AX=9201h,AX=920Dh
--------R-2F920C-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 920Ch
	???
Return: AX = ??? (0002h)
	CX = ??? (0000h)
--------R-2F920D-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET DRIVE TYPE
	AX = 920Dh
	BL = drive letter (41h ['A'] = A:, etc)
Return: AX = type flags
		bit 0: ???
		bit 1: available
		bit 5: local
	BX = ???
	CX = segment of resident code (apparently an unintended side effect)
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
SeeAlso: AX=9218h,INT 16/AX=FF70h
--------R-2F920E-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - SET LPT MAPPING
	AX = 920Eh
	BX = port number (0-2)
	CX = ??? (0000h to unmap)
Return: ???
--------R-2F920F-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 920Fh
	ES:DI -> 3-byte buffer for ???
Return: CX = 0000h
	ES:DI buffer filled
--------R-2F9210-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9210h
	???
Return: ???
--------R-2F9211-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9211h
	ES:DI -> 8-word buffer for ???
Return: CX = 0000h
	ES:DI buffer filled
--------R-2F9212-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - CRITICAL SECTION???
	AX = 9212h
	BX = phase
	    0000h leave critical section???
	    nonzero enter critical section???
--------R-2F9213-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9213h
	BX = function number (0000h-000Bh)
	???
Return: ???
--------R-2F9214-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9214h
	ES:DI -> 6-word buffer for ???
Return: CX = 0000h
	AX = ???
	ES:DI buffer filled
--------R-2F9215-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 9215h
	ES:DI -> 100-word buffer for ???
Return: CX = 0000h
	ES:DI buffer filled
--------R-2F9216-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9216h
	ES:DI -> ???
Return: ???
--------R-2F9217-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9217h
	DS:SI -> 25-word buffer containing ???
Return: ???
--------R-2F9218-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET LPT TYPE???
	AX = 9218h
	BX = port number???
Return: AX = ???
	BX = ??? (0000h)
	CX = ??? (0000h)
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
--------R-2F9219-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 9219h
	???
Return: ???
--------R-2F921A-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Ah
	???
Return: AH = ???
	AL = ???
	BX = ???
--------R-2F921B-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Bh
	???
Return: AX = ???
	CX = segment of resident code (apparently an unintended side effect)
--------R-2F921C-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Ch
	???
Return: ???
--------R-2F921D-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - GET ???
	AX = 921Dh
Return: AX = ???
--------R-2F921E-----------------------------
INT 2F U - PC Tools v8.0 DRIVEMAP - ???
	AX = 921Eh
	???
Return: ???
Program: DRIVEMAP is a redirector which allows drives on computers connected
	  over the parallel or serial ports to appear as local drives
Note:	this function sets two variables to 24h each
SeeAlso: INT 16/AX=FF70h
--------V-2F93-------------------------------
INT 2F - InnerMission v1.7+ - INSTALLATION CHECK
	AH = 93h
	BX = CX = AX
Return: AL = state
	    FFh if installed and BX=CX=AX on entry
		BX = segment of resident code
	    01h if installed but BX or CX differ from AX (multiplex number not
		  available)
Program: InnerMission is a shareware graphical screen blanker by Kevin Stokes
SeeAlso: INT 14/AX=AA01h,INT 2F/AX=6400h
Index:	screen saver;InnerMission
--------e-2F9400-----------------------------
INT 2F - MICRO.EXE - INSTALLATION CHECK
	AX = 9400h
Return: AL = 07h or 08h if installed
Program: MICRO.EXE is a TSR of the Microsoft Mail part of Workgroup Connection
SeeAlso: AH=92h"Network Courier",AX=9401h,AX=9402h,AX=9403h,AX=9404h
SeeAlso: INT 21/AH=3Fh"WORKGRP.SYS"
--------e-2F9401-----------------------------
INT 2F - MICRO.EXE - SET ??? FLAG
	AX = 9401h
SeeAlso: AX=9400h,AX=9403h
--------e-2F9402-----------------------------
INT 2F - MICRO.EXE - ???
	AX = 9402h
	???
Return: ???
SeeAlso: AX=9400h
--------e-2F9403-----------------------------
INT 2F - MICRO.EXE - SET ??? FLAG
	AX = 9403h
SeeAlso: AX=9400h,AX=9404h
--------e-2F9404-----------------------------
INT 2F - MICRO.EXE - CLEAR ??? FLAG
	AX = 9404h
	ES:DI -> name of executable from which MICRO.EXE was started
Note:	if the specified name is identical to the name of the program file
	  from which MICRO was started, the ??? flag is cleared; otherwise,
	  it is left unchanged
SeeAlso: AX=9400h,AX=9403h
--------V-2F96C7-----------------------------
INT 2F U - STRETCH - INSTALLATION CHECK
	AX = 96C7h
Return: AX = AAAAh if installed
Program: stretch.exe is a TSR for Toshiba Laptops with WD90C24 video chip
	  to avoid blank screen areas in VGA text modes by increasing
	  inter-line spacing
----------2F97-------------------------------
INT 2F U - Micro Focus COBOL v3.1.31 internal - ???
	AH = 97h
	AL = function
	    00h installation check
		Return: AL = FFh if installed
	    08h get ???
		Return: AL = ???
			BX = ???
			DX = ???
			AH destroyed
	    20h get ???
		Return: AX:BX = far entry point of ???
			CX = segment of ???
	    80h ???
		Return: ???
Notes:	Micro Focus COBOL compiler v3.1.31 and companion programs supply
	  these functions for internal use; these programs call the
	  installation check at startup (before installing the INT 2F
	  handler) and crash the system if a not authorized program answers
	  with AL=FFh
	the handler checks AL only if an internal flag is 1, otherwise ???
SeeAlso: AH=98h"COBOL",AH=99h"COBOL",AH=9Ah"COBOL"
----------2F98-------------------------------
INT 2F U - Micro Focus COBOL v3.1.31 internal - ???
	AH = 98h
	AL = function
	    00h installation check
		Return: AL = FFh if installed
	    10h get ???
		Return: AX = ???
	    18h get segment of ???
		Return: AX = segment of ???
	    19h get pointer to ???
		Return: AX:BX -> ???
Notes:	Micro Focus COBOL compiler v3.1.31 and companion programs supply
	  these functions for internal use; these programs call the
	  installation check at startup (before installing the INT 2F
	  handler) and crash the system if a not authorized program answers
	  with AL=FFh
	the handler checks AL only if an internal flag is 0, otherwise ???
SeeAlso: AH=97h"COBOL",AH=99h"COBOL",AH=9Ah"COBOL"
--------V-2F9800-----------------------------
INT 2F U - S3RMDRV.SYS - INSTALLATION CHECK / VERSION CHECK
	AX = 9800h
	BX = function
	    0000h installation check
		Return: AX = 524Dh ('RM') if installed
	    0001h get driver version
		Return: AX = driver version (AH=major, AL=BCD minor)
Program: S3RMDRV.SYS provides support for the S3 MPEG driver FMPDRV
SeeAlso: AX=9803h
--------V-2F9803-----------------------------
INT 2F U - S3RMDRV.SYS - COPY ??? INTO USER BUFFER
	AX = 9803h
	DX:BX -> 116-byte buffer for ASCIZ ???
Return: AX = 0000h
	DX:BX buffer filled with string stored in driver from its parameter
	  list when it was loaded
Note:	the examined version of the driver returns CF set for any AL other
	  than 00h or 03h
SeeAlso: AX=9800h
----------2F99-------------------------------
INT 2F U - Micro Focus COBOL v3.1.31 internal - ???
	AH = 99h
	???
Return: ???
Note:	used internally by Micro Focus COBOL compiler v3.1.31 and companion
	  programs
SeeAlso: AH=97h"COBOL",AH=98h"COBOL",AH=9Ah"COBOL"
--------l-2F9900-----------------------------
INT 2F U - DOS Navigator II - INSTALLATION CHECK
	AX = 9900h
Return: BX = 444Eh ('DN') if installed
	    AX = number of DOS Navigator executions
	    CL = child process exit code
	    DX = version number (see #02965)
Notes:	old versions of DOS Navigator II always returned AH=1, while newer
	  ones return AH=0 and store AL in the DN.FLG file
Program: DOS Navigator is a multi-window shell for MS-DOS by RIT S.R.L.
	  DOS Navigator(TM) is a registered trademark of RIT S.R.L.
SeeAlso: AX=9901h,AX=9902h,AX=9903h,AX=9904h,AX=9905h,AX=9906h

(Table 02965)
Values for DOS Navigator II version code:
 2100h	version 1.35
 2138h	version 1.38
 2141h	version 1.41
 2150h	version 1.50
--------l-2F9901-----------------------------
INT 2F U - DOS Navigator II - RETURN POINTER TO COMMAND LINE
	AX = 9901h
Return: ES:BX -> command line (terminated with 0Dh)
	AX = ES
SeeAlso: AX=9900h,AX=9902h,AX=9903h
--------l-2F9902-----------------------------
INT 2F U - DOS Navigator II - SET 'TRUE' EXIT CODE OF DN.PRG
	AX = 9902h
	CL = exit code
Return: AX destroyed
SeeAlso: AX=9900h,AX=9901h,AX=9903h
--------l-2F9903-----------------------------
INT 2F U - DOS Navigator II - SPECIFY HOW TO EXECUTE COMMANDS
	AX = 9903h
	CL = 1 to use INT 2E
	CL <> 1 to use INT 21/AH=4Bh
SeeAlso: AX=9900h,AX=9901h,AX=9902h
--------l-2F9904-----------------------------
INT 2F U - DOS Navigator II v1.49 - SET ???
	AX = 9904h
	CX:DX = new value for ???
SeeAlso: AX=9900h,AX=9905h,AX=9906h
--------l-2F9905-----------------------------
INT 2F U - DOS Navigator II v1.49 - GET ???
	AX = 9905h
Return: CX:DX = current value of ??? (set by AX=9904h)
SeeAlso: AX=9900h,AX=9904h,AX=9906h
--------l-2F9906-----------------------------
INT 2F U - DOS Navigator II v1.49 - GET ???
	AX = 9906h
	DX = new value for ??? (bit 15 must be set, otherwise not changed)
Return: CX = previous value for ???
SeeAlso: AX=9900h,AX=9904h,AX=9905h
----------2F9A-------------------------------
INT 2F U - Micro Focus COBOL v3.1.31 internal - ???
	AH = 9Ah
	???
Return: ???
Note:	used internally by Micro Focus COBOL compiler v3.1.31 and companion
	  programs
SeeAlso: AH=97h"COBOL",AH=98h"COBOL",AH=99h"COBOL"
--------e-2F9C-------------------------------
INT 2F - Network Courier E-Mail OPERATOR.EXE - API
	AH = 9Ch
	AL = subfunction
	    01h uninstall
Return: ???
Program: The Network Courier is an electronic mail package by Consumers
	  Software of Vancouver, BC which was bought by Microsoft in 1991 and
	  renamed Microsoft Mail v3.0.
SeeAlso: AH=92h
Index:	uninstall;Network Courier E-Mail OPERATOR.EXE
--------G-2F9E00-----------------------------
INT 2F U - INTMON v2.1 - INSTALLATION CHECK
	AX = 9E00h
Return: AX = FFFFh if installed
	    BX = segment of resident code
Program: INTMON is a shareware interactive interrupt monitoring TSR for 386
	  and higher machines by Celso Minnitti, Jr.
SeeAlso: AX=9E01h,AX=9E02h,AX=9E03h,AX=9F00h
--------G-2F9E01-----------------------------
INT 2F U - INTMON v2.1 - RESET
	AX = 9E01h
Return: ???
Desc:	this function specifies that INTMON should assume that any interrupts
	  on which it is currently awaiting a return have completed (i.e.
	  interrupts which never return such as INT 20 and INT 27)
SeeAlso: AX=9E00h,AX=9E03h
--------G-2F9E02-----------------------------
INT 2F U - INTMON v2.1 - DISPLAY CPU REGISTERS???
	AX = 9E02h
Return: ???
SeeAlso: AX=9E00h
--------G-2F9E03-----------------------------
INT 2F U - INTMON v2.1 - HOOK INTERRUPT???
	AX = 9E03h
	BH = interrupt number???
Return: ???
Note:	if AL > 03h on entry, INTMON 2.1 returns immediately
SeeAlso: AX=9E00h,AX=9E01h
--------G-2F9F00-----------------------------
INT 2F U - INTCFG v2.1 - INSTALLATION CHECK
	AX = 9F00h
Return: AX = FFFFh if installed
Program: INTCFG is an optionally-resident control program for INTMON by Celso
	  Minnitti, Jr.
SeeAlso: AX=9E00h,AX=9F01h,AX=9F30h,AX=9F49h
--------G-2F9F01-----------------------------
INT 2F U - INTCFG v2.1 - ???
	AX = 9F01h
	???
Return: ???
SeeAlso: AX=9F00h
--------G-2F9F30-----------------------------
INT 2F U - INTCFG v2.1 - GET ???
	AX = 9F30h
Return: AX = ??? (0002h)
SeeAlso: AX=9F00h
--------G-2F9F49-----------------------------
INT 2F U - INTCFG v2.1 - UNINSTALL
	AX = 9F49h
Return: AX,DX,DS,ES destroyed
SeeAlso: AX=9F00h
--------E-2FA1--BX0081-----------------------
INT 2F - Ergo DOS extenders - INSTALLATION CHECK
	AH = A1h
	BX = 0081h
	AL = which
	    FEh OS/286,OS/386
	    FFh HummingBoard DOS extender
	ES:DI -> 16-byte buffer
Return: if installed, first four bytes of ES:DI buffer are "IABH"
Note:	since TKERNEL is a licensed version, it is likely that subfunctions
	  BX=0082h and BX=0084h are present and function identically to the
	  AX=FBA1h/BX=008xh calls
SeeAlso: AX=ED00h,AX=FBA1h/BX=0081h,INT 15/AX=BF02h
--------m-2FA189-----------------------------
INT 2F U - Biologic HRAMDEV.SYS - API
	AX = A189h
	BX = subfunction
	    0000h set ???
	    0001h remove ???
	    0002h get status ???
	    0003h enable ???
	    0004h disable ???
	    0005h set ??? flag
	    0006h clear ??? flag
	    0007h set ??? flag
	    0008h clear ??? flag
	    0009h set ???
	ES:DI -> function-specific arguments
		if func 0000h: 20-byte buffer containing ???
		if func 0001h: 20-byte buffer for returned ???
		if func 0002h: 16-byte buffer for returned ???
		if func 0009h: WORD containing ???
Return: BX = A189h if installed
	AH = status
	    00h successful
	    FFh failed or invalid function number
Program: HRAMDEV.SYS is a part of the shareware package HRAM by Biologic which
	  provides improved high memory access under MS-DOS 5.0
Note:	functions 00h and 01h use a stack of four entries; function 01h always
	  removes the values stored with the most recent function 00h call
	  which has not yet been matched with a function 01h call.
--------U-2FA4E0-----------------------------
INT 2F - Futurus Team - INSTALLATION CHECK
	AX = A4E0h
Return: AL = 52h ("R") if installed
	    AH = major version plus 30h ("0")
	    ES:BX -> ??? (INT A4 handler???)
Note:	older versions of Right Hand Man (from which Team evolved) store the
	  signature "RH" at offset 103h in the INT 2F handler's segment
SeeAlso: INT A4"Right Hand Man"
--------U-2FA900-----------------------------
INT 2F - METZTSR.COM - INSTALLATION CHECK
	AX = A900h
	CF set
Return: CF clear if resident
	    AX = 97FFh
	CF set if not present
Notes:	METZTSR.COM prevents METZ applications (such as the MAGIC screen
	  saver) inactivity timeout while running a DOSapp under MS Windows.
	the default multiplex number is A9h, but may be set to any value from
	  80h to FFh with a commandline switch
SeeAlso: AX=A901h,AX=A902h
--------U-2FA901-----------------------------
INT 2F - METZTSR.COM - GET TIME OF LAST KEYBOARD ACTIVITY
	AX = A901h
	CF set
Return: CF clear if successful
	    AX:DX = BIOS time at which INT 09 was last invoked
	CF set if not present
SeeAlso: INT 09,INT 1A/AH=00h
--------U-2FA902-----------------------------
INT 2F - METZTSR.COM - SET METZ Ctrl-Alt-Del FLAG
	AX = A902h
	BL = new value
	    00h Ctrl-Alt-Del not allowed
	    else Ctrl-Alt-Del allowed (startup default is 01h)
	CF set
Return: CF clear if successful
	    AX = 97FFh
	CF set if not resident
SeeAlso: AX=A903h
--------U-2FA903-----------------------------
INT 2F - METZTSR.COM - GET METZ Ctrl-Alt-Del FLAG
	AX = A903h
	CF set
Return: CF clear if successful
	    AX = 97FFh if Ctrl-Alt-Del allowed
	    AX = 0000h if Ctrl-Alt-Del not allowed
	CF set if not resident
SeeAlso: AX=A902h
--------U-2FAA-------------------------------
INT 2F - Player's Tool 3.996b+ - UNINSTALL
	AH = AAh
Return: AL = status
	    00h unloaded successfully
	    01h unable to unload: in DOS shell
Program: Player's Tool is a game cheater by Dima Yakunin & Andy Robinson
SeeAlso: AH=ABh"Player's Tool",AH=ACh"Player's Tool",INT 10/AH=AAh
--------U-2FAA00-----------------------------
INT 2F - VIDCLOCK.COM - INSTALLATION CHECK
	AX = AA00h
Return: AL = 00h not installed
	     FFh installed
Program: VIDCLOCK.COM is a memory-resident clock by Thomas G. Hanlin III
--------U-2FAB-------------------------------
INT 2F - Player's Tool 3.996b+ - INSTALLATION CHECK
	AH = ABh
Return: BH = FFh if installed
	    BL = DOS shell state
		01h in DOS shell
		00h not in DOS shell
SeeAlso: AH=AAh"Player's Tool",AH=ACh"Player's Tool",INT 10/AH=ABh
--------f-2FAB00-----------------------------
INT 2F - Btrieve Multi-User - INSTALLATION CHECK
	AX = AB00h
Return: AL = 4Dh if installed
SeeAlso: AX=AB01h,AX=AB02h,INT 7B"Btrieve"
----------2FAB00-----------------------------
INT 2F - SRSoft MODAL PC v2+ - INSTALLATION CHECK / GET VERSION
	AX = AB00h
Return: AX = 5253h ('SR' byte-swapped) if installed
	    BX = MODAL PC version (BL = major, BH = minor)
Program: MODAL PC is an algorithm/real-system simulation package by SR Soft
	  using Petri-nets to describe simulated objects
SeeAlso: AX=AB01h"MODAL",AX=AB02h"MODAL",AX=AB06h"MODAL"
--------f-2FAB01-----------------------------
INT 2F - Btrieve Multi-User - EXECUTE Btrieve OPERATION
	AX = AB01h
	BX = process ID
	DS:DX -> 38-byte parameter record (see #03840 at INT 7B"Btrieve")
Return: AL = status
	    00h OK
	    other retry after calling INT 7F/AX=0200h
SeeAlso: AX=AB00h"Btrieve",AX=AB02h"Btrieve",INT 7B"Btrieve",INT 7F/AX=0200h
----------2FAB01-----------------------------
INT 2F - SRSoft MODAL PC v2+ - GET PROCESS RUN PARAMETER
	AX = AB01h
Return: AX = 5253h ('SR' byte-swapped) if installed
	BL = run parameter
	    00h normal process
	    01h run with tracing enabled
	    02h run initialization process (first thread of main task)
SeeAlso: AX=AB00h"MODAL",AX=AB02h"MODAL"
--------f-2FAB02-----------------------------
INT 2F - Btrieve Multi-User - GET NEW PROCESS ID
	AX = AB02h
Return: AL = 00h successful
	    BX = process ID
	AL > 00h failed, retry after calling INT 7F/AX=0200h
SeeAlso: AX=AB00h,AX=AB01h,INT 7B"Btrieve",INT 7F/AX=0200h
----------2FAB02-----------------------------
INT 2F - SRSoft MODAL PC v2+ - SET PROCESS EXIT CODE
	AX = AB02h
	BL = exit code
Return: AX = 5253h ('SR' byte-swapped) if installed
SeeAlso: AX=AB00h"MODAL",AX=AB01h"MODAL",AX=AB03h"MODAL"
----------2FAB03-----------------------------
INT 2F - SRSoft MODAL PC v2+ - ALLOCATE COMMON MEMORY
	AX = AB03h
	BX = required size of common memory for variables/semaphores in bytes
Return: AX = 5253h ('SR' byte-swapped) if installed
SeeAlso: AX=AB00h"MODAL",AX=AB02h"MODAL",AX=AB04h"MODAL"
----------2FAB04-----------------------------
INT 2F - SRSoft MODAL PC v2+ - GET ALL COMMON VARIABLES AND SEMAPHORES
	AX = AB04h
	DS:DX -> buffer for common data
Return: AX = 5253h ('SR' byte-swapped) if installed
	CF clear if successful
	CF set on error
SeeAlso: AX=AB00h"MODAL",AX=AB03h"MODAL",AX=AB05h"MODAL",AX=AB06h,AX=AB07h
----------2FAB05-----------------------------
INT 2F - SRSoft MODAL PC v2+ - SET ALL COMMON VARIABLES AND SEMAPHORES
	AX = AB05h
	DS:DX -> buffer containing common data
Return: AX = 5253h ('SR' byte-swapped) if installed
	CF clear if successful
	CF set on error
SeeAlso: AX=AB00h"MODAL",AX=AB03h"MODAL",AX=AB04h"MODAL",AX=AB06h,AX=AB07h
----------2FAB06-----------------------------
INT 2F - SRSoft MODAL PC v2+ - GET A COMMON VARIABLE OR SEMAPHORE
	AX = AB06h
	BX = offset of variable or semaphore in common memory
	CX = variable/semaphore size in bytes
	DS:DX -> buffer for variable or semaphore
Return: AX = 5253h ('SR' byte-swapped) if installed
	CF clear if successful
	CF set on error
SeeAlso: AX=AB00h"MODAL",AX=AB04h,AX=AB05h,AX=AB07h
----------2FAB07-----------------------------
INT 2F - SRSoft MODAL PC v2+ - SET A COMMON VARIABLE OR SEMAPHORE
	AX = AB07h
	BX = offset of variable or semaphore in common memory
	CX = variable/semaphore size in bytes
	DS:DX -> buffer containing variable or semaphore
Return: AX = 5253h ('SR' byte-swapped) if installed
	CF clear if successful
	CF set on error
SeeAlso: AX=AB00h"MODAL",AX=AB04h,AX=AB05h,AX=AB06h
--------U-2FAC-------------------------------
INT 2F u - Player's Tool 3.996b+ - POP UP
	AH = ACh
Return: AX = 1001h
SeeAlso: AH=AAh"Player's Tool",AH=ABh"Player's Tool"
--------V-2FAC00-----------------------------
INT 2F - DOS 4.01+ GRAPHICS.COM - INSTALLATION CHECK
	AX = AC00h
Return: AX = FFFFh
	ES:DI -> ??? (graphics data?) (not documented)
Note:	this installation check was moved here to avoid the conflict with the
	  CD-ROM extensions that occurred in DOS 4.00
SeeAlso: AX=1500h"GRAPHICS"
--------V-2FAC00DI1092-----------------------
INT 2F - QRIP/TSR - GIVE CPU TO QRIP
	AX = AC00h
	DI = 1092h
Return: nothing
Program: QRIP/TSR is a shareware TSR by Shane Hathaway implementing the Remote
	  Imaging Protocol (RIP, RIPscrip) used by several BBS systems to
	  provide a graphical user interface
Desc:	give QRIP some CPU time to update music and flashing timers
Notes:	if DI <> 1092h on entry, QRIP chains the call
	this function should be called regularly whenever the terminal program
	  is otherwise idle; the updates are automatically performed on any
	  other QRIP call
SeeAlso: AX=AC01h,AX=ACF0h
--------V-2FAC01DI1092-----------------------
INT 2F - QRIP/TSR - CHANGE INTERNAL FLAGS
	AX = AC01h
	DI = 1092h
	BX = flags to be turned on (see #02966)
	CX = flags to be turned off (see #02966)
Return: AX = 9142h if installed
	    DX = DOS-takeover flag (nonzero if QRIP able to take over DOS)
	    ---if DX nonzero---
	    BX = QRIP version number in hex (BH = major, BL = minor)
	    CX = new flags (see #02966)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC00h/DI=1092h,AX=ACF0h

Bitfields for QRIP internal flags:
Bit(s)	Description	(Table 02966)
 0	ANSI emulation enabled (default on)
 1	RIP emulation enabled (default on)
 2	graphical commands allowed (default on)
 3	TTY text allowed (default on)
 4	disable @ variables (default off in TSR mode)
 5	wait for key on RIP "end scene" command (default off)
 6	anti-stripping (default off in TSR mode)
 7	sound enabled (default on)
 8	automatic message filter (default off in TSR mode)
 9	display-only mode (no user prompts)
 10	TTY text suppression (default off in TSR mode)
 11-15	reserved
--------V-2FAC02DI1092-----------------------
INT 2F - QRIP/TSR - TURN OFF GRAPHICS SCREEN
	AX = AC02h
	DI = 1092h
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC03h,AX=ACF0h
--------V-2FAC03DI1092-----------------------
INT 2F - QRIP/TSR - TURN ON GRAPHICS SCREEN
	AX = AC03h
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	this function does not restore the contents of the screen (see AX=AC15h)
SeeAlso: AX=AC02h,AX=AC14h,AX=AC15h
--------V-2FAC04DI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT STRING THROUGH QRIP
	AX = AC04h
	DI = 1092h
	DX:BX -> string
	CX = length of string
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC05h,AX=AC09h,AX=AC0Ah,AX=ACF0h
--------V-2FAC05DI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT NULL-TERMINATED STRING THROUGH QRIP
	AX = AC05h
	DI = 1092h
	DX:BX -> ASCIZ string
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=AC06h,AX=AC09h,AX=AC0Ah,AX=ACF0h
--------V-2FAC06DI1092-----------------------
INT 2F - QRIP/TSR - RECEIVE CHARACTERS FROM QRIP
	AX = AC06h
	DI = 1092h
Return: AX = character to send to BBS (0001h-00FFh) or special code (see #02967)
	BX = string-waiting flag
	    0001h entire string waiting to be sent to terminal (call AX=AC0Ch)
	CX = DX = AX
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=AC05h,AX=AC0Ch,AX=AC16h,AX=AC18h,AX=AC1Ah

(Table 02967)
Values for QRIP special codes:
 0000h	if none
 0100h	wait for user keypress (must call AX=AC16h/BL=00h or AX=AC18h)
 0101h	both/middle mouse button pressed
 0102h	entering block mode (up/download) (call AX=AC1Ah)
 0103h	right mouse button pressed
 0104h	BBS requested status bar on
 0105h	BBS requested status bar off
 0106h	BBS requested VT-102 terminal emulation
	(keypad keys should send VT-102 escape codes)
 0107h	BBS requested VT-102 mode off
 0108h	BBS requested doorway mode (raw IBM keyboard ASCII/scan code pairs)
 0109h	BBS requested doorway mode off
 010Ah	hotkey mode on
 010Bh	hotkey mode off
 010Ch	BBS requested Tab-key button changing on
 010Dh	BBS requested Tab-key mode off
 010Eh	XOFF (use flow control to stop incoming characters)
 010Fh	XON (use flow control to resume incoming characters)
 0110h-0119h BBS requested application (0-9) be run
	application 0 should be a standard text editor
 01FFh	send ASCII 00h to BBS
Note:	for special codes 0104h to 010Dh, the terminal program should report
	  any mode changes it make in response by calling AX=AC16h
--------V-2FAC07DI1092-----------------------
INT 2F - QRIP/TSR - GET FONT DIRECTORY
	AX = AC07h
	DI = 1092h
Return: DX:BX -> 80-byte internal buffer containing ASCIZ font directory name
Notes:	if DI <> 1092h on entry, QRIP chains the call
	the application may change the font directory by overwriting the
	  returned buffer, ensuring that it does not exceed 80 bytes incl. NUL
	if changed, the new path will not become effective until the graphics
	  screen is reinitialized
SeeAlso: AX=AC08h,AX=ACF0h
--------V-2FAC08DI1092-----------------------
INT 2F - QRIP/TSR - GET ICON DIRECTORY
	AX = AC08h
	DI = 1092h
Return: DX:BX -> 80-byte internal buffer containing ASCIZ icon directory name
Notes:	if DI <> 1092h on entry, QRIP chains the call
	the application may change the icon directory by overwriting the
	  returned buffer, ensuring that it does not exceed 80 bytes incl. NUL,
	  and includes a trailing backslash
	if changed, the new path becomes effective immediately
SeeAlso: AX=AC07h,AX=ACF0h
--------V-2FAC09DI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT STRING THROUGH QRIP
	AX = AC09h
	DI = 1092h
	DX:BX -> string
	CX = length of string
Return: AX = character to send to BBS (0001h-00FFh) or special code (see #02967)
	BX = string-waiting flag
	    0001h entire string waiting to be sent to terminal (call AX=AC0Ch)
	CX = DX = AX
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=AC06h,AX=AC0Ah,AX=ACF0h
--------V-2FAC0ADI1092-----------------------
INT 2F - QRIP/TSR - OUTPUT NULL-TERMINATED STRING THROUGH QRIP
	AX = AC0Ah
	DI = 1092h
	DX:BX -> ASCIZ string
Return: AX = character to send to BBS (0001h-00FFh) or special code (see #02967)
	BX = string-waiting flag
	    0001h entire string waiting to be sent to terminal (call AX=AC0Ch)
	CX = DX = AX
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC05h,AX=AC06h,AX=AC09h,AX=ACF0h
--------V-2FAC0BDI1092-----------------------
INT 2F - QRIP/TSR - EXECUTE RIP "END SCENE" COMMAND
	AX = AC0Bh
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	enables all mouse buttons and cancels the RIP timeout
SeeAlso: AX=AC01h,AX=AC04h,AX=ACF0h
--------V-2FAC0CDI1092-----------------------
INT 2F - QRIP/TSR - GET STRING TO BE SENT TO BBS
	AX = AC0Ch
	DI = 1092h
Return: AX = status
	    0000h nothing to be sent
	    0001h a string is waiting to be sent
		DX:BX -> string to be sent (may contain NULs)
		CX = length of string
	    0002h special code waiting (call AX=AC06h)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC06h,AX=ACF0h
--------V-2FAC0DDI1092-----------------------
INT 2F - QRIP/TSR - SET PROTECTED SCREEN AREA
	AX = AC0Dh
	DI = 1092h
	CL = number of text lines at bottom of screen to protect (00h = off)
	BL = attribute with which to fill area (bit 7 = high-int. background)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Eh,AX=AC0Fh,AX=AC10h,AX=ACF0h
--------V-2FAC0EDI1092-----------------------
INT 2F - QRIP/TSR - WRITE ASCIZ STRING IN PROTECTED AREA
	AX = AC0Eh
	DI = 1092h
	DX:BX -> ASCIZ string to be written
	CL = column at which to begin writing
	CH = row number within protected area (00h = first line)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Fh,AX=AC10h,AX=ACF0h
--------V-2FAC0FDI1092-----------------------
INT 2F - QRIP/TSR - SCROLL PROTECTED AREA
	AX = AC0Fh
	DI = 1092h
	BH,BL = row,column of upper-left corner in protected area
	DH,DL = row,column of lower-right corner
	CL = number of lines to scroll up
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Eh,AX=AC10h,AX=ACF0h
--------V-2FAC10DI1092-----------------------
INT 2F - QRIP/TSR - SET OUTPUT COLOR FOR PROTECTED AREA
	AX = AC10h
	DI = 1092h
	BL = new attribute (bit 7 set for high-intensity background)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Eh,AX=AC0Fh,AX=AC11h,AX=ACF0h
--------V-2FAC11DI1092-----------------------
INT 2F - QRIP/TSR - CONVERT PROTECTED AREA TO ENTIRE SCREEN
	AX = AC11h
	DI = 1092h
	BX = mode (0000h = normal protect, 0001h = allow full-screen access)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC0Dh,AX=AC0Eh,AX=AC0Fh,AX=AC10h,AX=AC12h,AX=ACF0h
--------V-2FAC12DI1092-----------------------
INT 2F - QRIP/TSR - BEGIN POPUP-WINDOW MODE
	AX = AC12h
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	while popup-mode is in effect, the terminal program can write to the
	  screen (and easily restore it) by outputting a RIP file with AX=AC04h
	  or AX=AC05h
	QRIP will automatically drop out of popup-window mode if the terminal
	  program invokes RIP pick-lists
	any changes to the protected area will be restored when popup-window
	  mode is cancelled
SeeAlso: AX=AC04h,AX=AC11h,AX=AC13h,AX=ACF0h
--------V-2FAC13DI1092-----------------------
INT 2F - QRIP/TSR - END POPUP-WINDOW MODE
	AX = AC13h
	DI = 1092h
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	restores screen
SeeAlso: AX=AC12h,AX=ACF0h
--------V-2FAC14DI1092-----------------------
INT 2F - QRIP/TSR - SAVE GRAPHICS SCREEN AND SWITCH TO TEXT MODE
	AX = AC14h
	DI = 1092h
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC03h,AX=AC15h
--------V-2FAC15DI1092-----------------------
INT 2F - QRIP/TSR - RESTORE GRAPHICS SCREEN
	AX = AC15h
	DI = 1092h
Return: nothing
Desc:	restores the graphics screen saved by the last call to AX=AC14h
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC03h,AX=AC14h
--------V-2FAC16DI1092-----------------------
INT 2F - QRIP/TSR - REPORT MODE CHANGE TO QRIP
	AX = AC16h
	DI = 1092h
	BL = new mode
	    00h terminate key wait
	    01h status bar on
	    02h status bar off
	    03h VT-102 mode on
	    04h VT-102 mode off
	    05h doorway mode on
	    06h doorway mode off
	    07h hotkeys mode on
	    08h hotkeys mode off
	    09h tabkey mode on
	    0Ah tabkey mode off
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	all modes default to OFF when QRIP is first installed
--------V-2FAC17DI1092-----------------------
INT 2F - QRIP/TSR - CALL (EXECUTE) A RIP FILE
	AX = AC17h
	DI = 1092h
	DX:BX -> ASCIZ filename for RIP file to be executed
Return: nothing
Notes:	if DI <> 1092h on entry, QRIP chains the call
	the specified file may be in the current icon directory, the QRIP
	  startup directory, or the current directory; any pathnames specified
	  with the filename are ignored
--------V-2FAC18DI1092-----------------------
INT 2F - QRIP/TSR - SEND USER KEY TO QRIP
	AX = AC18h
	DI = 1092h
	BX = key (00xxh is normal ASCII, xx00h is an extended key)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC06h,AX=ACF0h
--------V-2FAC19DI1092-----------------------
INT 2F - QRIP/TSR - HANGUP
	AX = AC19h
	DI = 1092h
Return: nothing
Desc:	inform QRIP that carrier has been lost
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=ACF0h
--------V-2FAC1ADI1092-----------------------
INT 2F - QRIP/TSR - GET RIP_ENTER_BLOCK_MODE INFORMATION
	AX = AC1Ah
	DI = 1092h
Return: AH = requested protocol (see #02968)
	AL = file type (see #02969)
	DX:BX -> ASCIZ filename or 0000h:0000h
	CX = length of filename
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=ACF0h

(Table 02968)
Values for QRIP protocol identifier:
 00h	Xmodem (checksum)
 01h	Xmodem-CRC
 02h	Xmodem-1K
 03h	Xmodem-1K-G
 04h	Kermit
 05h	Ymodem
 06h	Ymodem-G
 07h	Zmodem with crash recovery
 08h-0Fh same as 00h-07h, but for uploading instead of downloading
SeeAlso: #02969

(Table 02969)
Values for QRIP file type:
 00h	RIP file sequence to be displayed
 01h	RIP file sequence to be stored in icon directory
 02h	ICN file sequence to be stored in icon directory
 03h	HLP file sequence to be stored, then auto-loaded if needed
 04h	COMPOSITE DYNAMIC file sequence (batch protocols only)
 05h	ACTIVE DYNAMIC file sequence (batch protocols only)
Note:	for file types 04h and 05h, any .RIP or .ICN files are stored in
	  the icon directory; in mode 05h, any .RIP files are also played
	  back as they are received
SeeAlso: #02968
--------V-2FAC1BDI1092-----------------------
INT 2F - QRIP/TSR - SET SYSTEM FONT SIZE
	AX = AC1Bh
	DI = 1092h
	BX = font size (see #02970)
Return: nothing
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC04h,AX=ACF0h

(Table 02970)
Values for QRIP font size specifier:
 00h	8x8 font, 80x43 screen
 01h	7x8 font, 90x43 screen
 02h	8x14 font, 80x25 screen
 03h	7x14 font, 90x25 screen
 04h	16x14 font, 40x25 screen
--------V-2FACF0DI1092-----------------------
INT 2F - QRIP/TSR - INSTALLATION CHECK
	AX = ACF0h
	DI = 1092h
Return: AX = 9142h if installed
	    DX = DOS-takeover flag (nonzero if QRIP able to take over DOS)
	    ---if DX nonzero---
	    BX = QRIP version number in hex (BH = major, BL = minor)
	    CX = current flags (see AX=AC01h)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=AC00h/DI=1092h,AX=AC01h,AX=AC04h,AX=AC06h,AX=AC1Ah,AX=ACFFh
--------V-2FACFFDI1092-----------------------
INT 2F - QRIP/TSR - UNINSTALL
	AX = ACFFh
	DI = 1092h
Return: AX = status
	    0000h unable to remove (interrupt vector hooked by another prog)
	    0001h successful
	    0002h unable to take over DOS at this time (retry uninstall)
Note:	if DI <> 1092h on entry, QRIP chains the call
SeeAlso: AX=ACF0h
--------V-2FAD00-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - INSTALLATION CHECK
	AX = AD00h
Return: AL = FFh if installed
	    BX = ??? (0100h for MS-DOS 3.3+)
Note:	DOS 5+ DISPLAY.SYS chains to previous handler if AL is not one of the
	  subfunctions listed here
SeeAlso: AX=AD01h"DISPLAY",AX=AD02h"DISPLAY"
--------O-2FAD00-----------------------------
INT 2F U - DR DOS 3.41-5.0, Novell DOS 7 KEYB - INSTALLATION CHECK
	AX = AD00h
Return: AX = FFFFh if installed
	flags destroyed
Note:	the Novell DOS 7 KEYB driver only checks AL to determine whether it
	  is already installed
SeeAlso: AX=AD80h"Novell"
--------V-2FAD01-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - SET ACTIVE CODE PAGE
	AX = AD01h
	BX = new code page (see #01757 at INT 21/AX=6602h)
Return: CF clear if successful
	    AX = 0001h
	CF set on error (unsupported code page)
	    AX = 0000h
SeeAlso: AX=AD02h"DISPLAY"
--------O-2FAD01-----------------------------
INT 2F U - DR DOS 3.41,5.0 KEYB - GET CONFIGURATION
	AX = AD01h
Return: BX = current code page (see #01757 at INT 21/AX=6602h)
	CX = current keyboard layout (0100h = US, 0102h = foreign)
	ES = resident code segment
SeeAlso: AX=AD01h"Novell",AX=AD00h"KEYB",AX=AD02h"KEYB",AX=AD83h"KEYB"
--------O-2FAD01-----------------------------
INT 2F U - Novell DOS 7 KEYB - GET/SET??? CONFIGURATION
	AX = AD01h
	CX = ??? (0000h)
Return: AX = FFFFh if Novell DOS 7 KEYB installed
	BX = current code page (see #01757 at INT 21/AX=6602h)
	CX = current keyboard layout (0100h = US, 0102h = foreign)
	ES = resident code segment
SeeAlso: AX=AD01h"DR DOS",AX=AD00h"KEYB",AX=AD02h"KEYB",AX=AD83h"KEYB"
--------V-2FAD02-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - GET ACTIVE CODE PAGE
	AX = AD02h
Return: CF set if code page never set
	    AX = 0001h
	    BX = FFFFh (assume first hardware code page)
	CF clear if successful
	    BX = current code page (see #01757 at INT 21/AX=6602h)
SeeAlso: AX=AD01h"DISPLAY",AX=AD03h
--------O-2FAD02-----------------------------
INT 2F U - Novell DOS 7 KEYB - ???
	AX = AD02h
	DX = ??? (0000h)
Return: AX = FFFFh if installed
	flags destroyed
SeeAlso: AX=AD01h"KEYB"
--------V-2FAD03-----------------------------
INT 2F U - DOS 3.3+ DISPLAY.SYS internal - GET CODE PAGE INFORMATION
	AX = AD03h
	ES:DI -> buffer for code page information (see #02971)
	CX = size of buffer in bytes
Return: CF set if buffer too small
	CF clear if successful
	    ES:DI buffer filled
SeeAlso: AX=AD01h,AX=AD02h

Format of DOS 5.0-6.0 DISPLAY.SYS code page information:
Offset	Size	Description	(Table 02971)
 00h	WORD	number of software code pages
 02h	WORD	??? (0003h)
 04h	WORD	number of hardware code pages
 06h  N WORDs	hardware code page numbers (see #01757 at INT 21/AX=6602h)
      N WORDs	software (prepared) code pages (FFFFh if not yet prepared)
--------V-2FAD04-----------------------------
INT 2F U - DOS 4.x only DISPLAY.SYS internal - ???
	AX = AD04h
	???
Return: ???
--------V-2FAD10-----------------------------
INT 2F U - DOS 4.x DISPLAY.SYS internal - INSTALLATION CHECK???
	AX = AD10h
	???
Return: AX = FFFFh
	BX = ??? (0100h in PC-DOS 4.01)
--------V-2FAD10-----------------------------
INT 2F U - DOS 5+ DISPLAY.SYS internal - ???
	AX = AD10h
	???
Return: CF clear if successful
	CF set on error
Note:	this function is a NOP if the active code page has never been set
	  (AX=AD02h returns BX=FFFFh); its purpose otherwise is not known
--------V-2FAD40-----------------------------
INT 2F - DOS 4.0+ - ???
	AX = AD40h
	DX = ???
	???
Return: ???
Note:	called by PC-DOS 4.01 PRINT.COM
--------V-2FAD41-----------------------------
INT 2F - Arabic/Hebrew DOS 5.0???+ - GET CURRENT FONTPAGE
	AX = AD41h
	(CX = 0000h)
Return: CX = current fontpage
Notes:	Called by Arabic/Hebrew MS-DOS 5.0 CODEPAGE.COM immediately before
	  a call to INT21h/6601h to get the current codepage.
	The function is probably implemented in the ARABIC.COM/HEBREW.COM
	  driver.
	The CX = 0 on call is not actually a requirement, but it should be
	  initialized this way to receive a fontpage 0 if ARABIC.COM/
	  HEBREW.COM is not loaded. A fontpage 0 indicated no fontpage
	  support. At least this is what CODEPAGE.COM assumes (by using
	  the CX=0 init status of a .COM program, when not being loaded
	  in DEBUG.)
	Some European clones have code page 850 as their hardware font instead
	  of code page 437
	!!!more details to follow
SeeAlso: AX=AD42h,AX=AD43h
--------V-2FAD42-----------------------------
INT 2F - Arabic/Hebrew DOS 5.0???+ SET CURRENT FONTPAGE
	AX = AD42h
	CX = fontpage (> 0)
Return: ???
Note:	called by Arabic/Hebrew MS-DOS 5.0 CODEPAGE.COM almost immediately
	  before a call to INT21h/6602h to set the current codepage
	  (without checking any possible error codes returned from the call).
	The function is probably implemented in the ARABIC.COM/HEBREW.COM
	  driver.
SeeAlso: AX=AD41h,AX=AD43h,INT 21/AX=6601h,INT 21/AX=6602h
--------V-2FAD43-----------------------------
INT 2F - Arabic/Hebrew DOS 5.0???+ - GET FONTPAGE STATUS???
	AX = AD43h
Return: AL = status
	    00h successful
	    01h-0Ah codepage info not found
	    0Bh bad codepage info file
	    0Ch font page not found or not available with codepage
	    else device prepare error
Note:	called by Arabic/Hebrew MS-DOS 5.0 CODEPAGE.COM when the sequence
	  INT 2F/AX=AD42h & INT 21/AX=6602h to set fontpage & codepage returned
	  with CF set and AX <> 2, and the following INT 21/AH=59h returned
	  error code 41h (65) (that is, the codepage was prepared, but could
	  not be set).
SeeAlso: AX=AD41h,AX=AD42h,INT 21/AX=6601h,INT 21/AX=6602h
--------K-2FAD80-----------------------------
INT 2F u - MS-DOS 3.3+ KEYB.COM internal - INSTALLATION CHECK
	AX = AD80h
Return: AL = FFh if installed
	    BX = version number (BH = major, BL = minor)
	    ES:DI -> internal data (see #02972)
	    AH destroyed (set to FFh by some implementations/versions)
Notes:	MS-DOS 3.30, PC-DOS 4.01, MS-DOS 5.00, and MS-DOS 6.22 all report
	  version 1.00.
	this function was undocumented prior to the release of DOS 5.0
	most versions of KEYB completely replace the BIOS INT 09 handler, but
	  Novell DOS's KEYB partially uses the BIOS code and thus continues
	  to chain to the original INT 09 at times
	some utilities check for AX=FFFFh on return
SeeAlso: AX=AD80h"Novell",AX=AD81h,AX=AD82h,AX=AD83h

Format of KEYB internal data:
Offset	Size	Description	(Table 02972)
 00h	DWORD	original INT 09
 04h	DWORD	original INT 2F
 08h	DWORD	unused (0) original INT 16 in older KEYB versions???
 0Ch	WORD	flags A (see #02973)
 0Eh	WORD	flags B (see #02974)
 10h	BYTE	flags??? (bit1 used)
 11h	BYTE	???
 12h  4 BYTEs	???
 16h  2 BYTEs	country ID letters, default is "US"
 18h	WORD	current code page (see #01757 at INT 21/AX=6602h)
---DOS 3.3---
 1Ah	WORD	pointer to first item in list of code page tables???
 1Ch	WORD	pointer to ??? item in list of code page tables
 1Eh  2 BYTEs	unused???
 20h	WORD	pointer to key translation data (see #02976)
 22h	WORD	pointer to last item in code page table list (see #02975)
 24h  9 BYTEs	???
---DOS 4.01---
 1Ah  2 BYTEs	???
 1Ch	WORD	pointer to first item in list of code page tables???
 1Eh	WORD	pointer to ??? item in list of code page tables
 20h 2 BYTEs	unused???
 22h	WORD	pointer to key translation data (see #02976)
 24h	WORD	pointer to last item in code page table list (see #02975)
 26h  9 BYTEs	???
---DOS 6.22--- (checked out with 6.22, but might be earlier)
 1Ah  2 BYTEs	???
 1Ch	WORD	pointer to current (first???) item in list of code page tables
		(corresponding to codepage indicated at offset 18h)
		(initial value is FFFFh)
 1Eh	WORD	pointer to (entry to) list of code page tables (see #02975)
		If not FFFFh, INT 2F/AX=AD81h scans this list of code page
		  tables until the requested code page was found in list or
		  end of table was reached (FFFFh). If found, offsets 18h and
		  1Ch will be changed to requested new code page. If not found,
		  it returns with AX=0001h 'code page not supported').
 20h	WORD	unused??? (initial value: FFFFh)
 22h	WORD	pointer to key translation data (see #02455)
 24h	WORD	pointer to last item in code page table list (see #02454)
 26h	WORD	CAPSLock/ShiftLock management flags??? (0)
		Note:	It appears that none of the bits is ever set inside
			  KEYBs code!
			  The following is guesswork:
		bit15: =1: With country specific keyboard mapping (<Ctrl>+
			  <Alt>+<F2>) active, <CapsLock> works as CAPSLock
			  instead of ShiftLock??? Pressing a key in first row
			  resets CapsLock???
			  (Effective only on PC Convertible or with Enhanced
			  keyboard).
		bit14-10:  unused (0)
		bit 9: =1: With country specific keyboard mapping active:
			  some kind of temporary (table) shift???
		bit 8-0: unused (0)
 28h	BYTE	unused (0)
 29h	BYTE	make code xx for <Ctrl>+<Alt>+<xx> to set keyboard mapping
		  to US-layout (default is 3Bh=<F1>???)
		  (see INT 2F/AX=AD82h,INT 2F/AX=AD83h)
 2Ah	BYTE	make code yy for <Ctrl>+<Alt>+<yy> to set keyboard mapping
		  to country specific layout (default is 3Ch=<F2>???),
		  (see INT 2F/AX=AD82h,INT 2F/AX=AD83h)
 2Bh 16 BYTEs	unused (0) ???
Note:	at least in MS-DOS v6.22, the signature "SHARED DATA" immediately
	  precedes this structure

Bitfields for MS-DOS v6.22 KEYB flags A:
Bit(s)	Description	(Table 02973)
 15	unused??? (0)
 14	set on machine with BIOS machine type FBh or FEh/FFh without enh kbd
 13	not FAh: ???
 12	set on start of machine detection, cleared on machine types F9h, FBh,
	  FEh, FFh
 11	not FAh: ???
	(on ATs: override bit12 NOT to set NumLock on)
 10	set on machine type F9h
 9	unused??? (0)
 8	unused??? (0)
 7	used by INT 09, but never set!
	=1: after keyboard self test resulting AAh, INT 09 handler will (re)set
	      keyboard code-set 1 and temporarily disable a PS/2 mouseport.
 6	used by INT09, but never set!
	=1: after keyboard self test resulting AAh, INT 09 handler will (re)set
	      keyboard code-set 1 and temporarily disable a PS/2 mouseport.
 5	set for JP, KO, PR, TA layouts during installation???
	=1: some special codepage (>932???) management???
 4-0	unused??? (0)
SeeAlso: #02974,MEM F000h:FFFEh,INT 15/AH=C0h

Bitfields for MS-DOS v6.22 KEYB flags B:
Bit(s)	Description	(Table 02974)
 15	INT 16/AH=1xh supported (INT 16h/AH=92h call returns AH<=80h)
	if clear, extended keyboard scan codes are immediately discarded
 14	INT 16/AH=2xh supported (INT 16h/AH=A2h call returns AH<=80h)
 13	unused (0)
 12	network installed (INT 2F/AX=B800h)
 11	original IBM PC (BIOS date 1981)
 10	PC or PC/XT (BIOS machine type byte of FBh or FEh)
 9	PC Convertible (BIOS machine type byte of F9h); use INT 15/AX=4104h
 8	unused (0)
 7	IBM PS/2 model 30 (BIOS machine type byte of FAh)
 6	IBM AT (BIOS machine type FCh)
 5	IBM PS/2 (BIOS machine type F8h)
 4	PS/2 and unknown only: non-standard 8042 reported by INT 15/AH=C0h
	=1: after keyboard self test resulting AAh, INT 09 handler will (re)set
	      keyboard code-set 1 and temporarily disable a PS/2 mouseport.
 3	temporary flag???
 2-0	???
SeeAlso: #02972,#02973

Format of code page table list entries:
Offset	Size	Description	(Table 02975)
 00h	WORD	pointer to next item, FFFFh = last
 02h	WORD	code page (see #01757 at INT 21/AX=6602h)
 04h  2 BYTEs	???

Format of KEYB translation data:
Offset	Size	Description	(Table 02976)
 00h	WORD	size of data in bytes, including this word
 02h N-2 BYTEs	???
--------K-2FAD80-----------------------------
INT 2F u - Novell DOS 7 KEYB.COM - INSTALLATION CHECK
	AX = AD80h
Return: AX = FFFFh if installed
	    CX = Novell DOS KEYB version number (CL = major, CH = minor)
	    DX = current keyboard codepage
	    ES:DI -> internal data and tables (ES=FFFEh if KEYB in HMA)
	flags destroyed
Notes:	versions: v2.08 (original ship 4/94), v2.09 (Update 10, 11/18/94),
	  v2.10 (Update 12, 2/22/95), v2.11 (Update 13, 5/8/95),
	  v2.12 (Update 14, 7/31/95)
	although the installation check is via this INT 2F call, Novell DOS 7's
	  KEYB has no known INT 2F entry point!	 Presumably, the handler is
	  either coded in the kernel or reached via a FAR JMP from the kernel
SeeAlso: AX=AD80h"MS-DOS"
--------K-2FAD81-----------------------------
INT 2F - DOS 3.3+ KEYB.COM - SET KEYBOARD CODE PAGE
	AX = AD81h
	BX = code page (see #01757 at INT 21/AX=6601h)
Return: CF set on error
	    AX = 0001h (code page not available)
	CF clear if successful
Notes:	called by DISPLAY.SYS
	this function was undocumented prior to the release of DOS 5.0
SeeAlso: AX=AD80h,AX=AD82h
--------K-2FAD82-----------------------------
INT 2F - DOS 3.3+ KEYB.COM - SET KEYBOARD MAPPING
	AX = AD82h
	BL = new state
	    00h US keyboard (Control-Alt-F1)
	    FFh foreign keyboard (Control-Alt-F2)
Return: CF set on error (BL not 00h or FFh)
	CF clear if successful
Notes:	this function was undocumented prior to the release of DOS 5.0
	the states 00h and FFh correspond with the byte stored at offset +02h
	  in KEYBs INT 09h handler
SeeAlso: AX=AD80h,AX=AD81h,AX=AD83h,AX=AD84h
--------K-2FAD83-----------------------------
INT 2F - DOS 5+ KEYB.COM - GET KEYBOARD MAPPING
	AX = AD83h
Return: BL = current state
	    00h US keyboard
	    FFh foreign keyboard
Note:	the states 00h and FFh correspond with the byte stored at offset +02h
	  in KEYBs INT 09h handler
SeeAlso: AX=AD82h,AX=AD85h,INT 09
--------K-2FAD84-----------------------------
INT 2F - PC DOS 5.0+ KEYB.COM - SET KEYBOARD SUB-MAPPING
	AX = AD84h
Return: if KEYB is in foreign mode:
	    AL = current layout
		00h primary layout
		01h secondary layout
Note:	This function is not supported by MS-DOS 5 - 7.10.
SeeAlso: AX=AD85h,AX=AD82h
--------K-2FAD85-----------------------------
INT 2F - PC DOS 5.0+ KEYB.COM - GET KEYBOARD SUB-MAPPING
	AX = AD85h
	BL = new layout
	    00h primary layout
	    01h secondary layout
Note:	This function is not supported by MS-DOS 5.0 - 7.10.
SeeAlso: AX=AD84h,AX=AD83h
----------2FADC1-----------------------------
INT 2F U - DOS 4.0+ SELECT - DISPLAY FORMAT DISK PROMPT
	AX = ADC1h
Return:	AX destroyed???
Note:	This function is called by DOS 4.0+ FORMAT utility just as it prompts
	  for a disk to be formatted.  It is only issued when the undocumented
	  /SELECT option was specified and is intercepted by SELECT displaying
	  the prompt.  However, the callout is still present in DOS 6.0 at
	  least.
--------l-2FAE00-----------------------------
INT 2F U - DOS 3.3+ internal - INSTALLABLE COMMAND - INSTALLATION CHECK
	AX = AE00h
	DX = magic value FFFFh
	CH = FFh
	CL = length of command line tail (4DOS v4.0)
	DS:BX -> command line buffer (see #02977)
	DS:SI -> command name buffer (see #02978)
	DI = 0000h (4DOS v4.0)
Return: AL = FFh if this command is a TSR extension to COMMAND.COM
	AL = 00h if the command should be executed as usual
Notes:	This call provides a mechanism for TSRs to install permanent
	  extensions to the command repertoire of COMMAND.COM.	It appears
	  that COMMAND.COM makes this call before executing the current
	  command line, and does not execute it itself if the return is FFh.
	APPEND hooks this call, to allow subsequent APPEND commands to
	  execute without re-running APPEND
SeeAlso: AX=AE01h

Format of COMMAND.COM command line buffer:
Offset	Size	Description	(Table 02977)
 00h	BYTE	max length of command line, as in INT 21/AH=0Ah
 01h	BYTE	count of bytes to follow, excluding terminating 0Dh
      N BYTEs	command line text, terminated by 0Dh

Format of command name buffer:
Offset	Size	Description	(Table 02978)
 00h	BYTE	length of command name
 01h  N BYTEs	uppercased command name (blank-padded to 11 chars by 4DOS v4)
--------l-2FAE01-----------------------------
INT 2F U - DOS 3.3+ internal - INSTALLABLE COMMAND - EXECUTE
	AX = AE01h
	DX = magic value FFFFh
	CH = 00h
	CL = length of command name (4DOS v4.0)
	DS:BX -> command line buffer (see #02977)
	DS:SI -> command name buffer (see #02978)
Return: DS:SI buffer updated
	  if length byte is nonzero, the following bytes contain the uppercase
	  internal command to execute and the command line buffer contains the
	  command's parameters (the first DS:[SI] bytes are ignored)
Notes:	this call requests execution of the command which a previous call to
	  AX=AE00h indicated was resident
	APPEND hooks this call
BUG:	Novell DOS 7.0's COMMAND.COM (prior to Update 12) will attempt to run
	  a disk program with the indicated name even if the returned length
	  byte is zero, because the register used to flag this case is
	  clobbered without first checking it.	The workaround is to set the
	  command name buffer to "REM" followed by enough blanks to pad out
	  the original command's length, which will also work with MS-DOS 6.
	  (from padgett@tccslr.dnet.mmc.com)
SeeAlso: AX=AE00h
--------O-2FAF00-----------------------------
INT 2F - WinDOS v2.11 - INSTALLATION CHECK
	AX = AF00h
Return: AL = FFh if installed
Program: WinDOS is a DOS clone (claimed to be mostly MS-DOS 5.0 API compatible)
	  written by Heiko Goemann
SeeAlso: AX=AF01h"WinDOS",INT 21/AH=30h
----------2FAF00-----------------------------
INT 2F U - ???
	AX = AF00h
	???
Return: AX = 0000h if interface supported
SeeAlso: AX=AF02h,AX=AF03h,AX=AF04h,AX=AF13h,AX=AF30h
--------O-2FAF01-----------------------------
INT 2F - WinDOS v2.11 - TURN ON ONLINE MODE
	AX = AF01h
Return: nothing
Desc:	indicate that the user will not exchange floppy disks, allowing WinDOS
	  to cache disk sectors in memory and avoid writing modified sectors
	  back out to the floppy disk
SeeAlso: AX=AF00h"WinDOS",AX=AF02h"WinDOS"
--------O-2FAF02-----------------------------
INT 2F - WinDOS v2.11 - TURN OFF ONLINE MODE
	AX = AF02h
Return: nothing
Desc:	indicate that the floppy disk may be removed, and that WinDOS should
	  write all buffered sectors out to the floppy disk
SeeAlso: AX=AF00h"WinDOS",AX=AF01h"WinDOS"
----------2FAF02-----------------------------
INT 2F U - ???
	AX = AF02h
	???
Return: ES = ???
SeeAlso: AX=AF00h
--------O-2FAF03-----------------------------
INT 2F - WinDOS v2.11 - TURN VIDMEM ON
	AX = AF03h
Return: AX = status
	    0000h successful
	    0001h CPU not in mode set by DOS386=On
	    0002h video adapter in graphics mode
	    0003h memory chain corrupted
SeeAlso: AX=AF00h"WinDOS",AX=AF04h"WinDOS",AX=AF05h"WinDOS"
----------2FAF03-----------------------------
INT 2F U - ???
	AX = AF03h
	???
Return: DX = ???
SeeAlso: AX=AF00h
--------O-2FAF04-----------------------------
INT 2F - WinDOS v2.11 - TURN VIDMEM OFF
	AX = AF04h
Return: AX = status
	    0000h successful
	    0001h video memory is in use
SeeAlso: AX=AF00h"WinDOS",AX=AF03h"WinDOS",AX=AF05h"WinDOS"
----------2FAF04-----------------------------
INT 2F U - ???
	AX = AF04h
	???
Return: ???
SeeAlso: AX=AF00h
--------O-2FAF05-----------------------------
INT 2F - WinDOS v2.11 - GET VIDMEM STATE
	AX = AF05h
Return: AX = status (0000h off, 0001h on)
SeeAlso: AX=AF00h"WinDOS",AX=AF03h"WinDOS",AX=AF04h"WinDOS"
----------2FAF05-----------------------------
INT 2F U - ???
	AX = AF05h
	???
Return: ???
SeeAlso: AX=AF00h
--------O-2FAF06-----------------------------
INT 2F - WinDOS v2.11 - MAKE PROGRAM UNBREAKABLE
	AX = AF06h
	DS:DX -> break handler
	DI:BX = stack to use for break handler
Return: nothing
Desc:	set a handler which should be invoked when Ctrl-C is pressed instead of
	  aborting the program
SeeAlso: AX=AF00h"WinDOS",AX=AF0Ah"WinDOS",AX=AF0Ch"WinDOS"
--------O-2FAF07-----------------------------
INT 2F - WinDOS v2.11 - SIGNAL FATAL OVERLAY FAULT
	AX = AF07h
Return: never -- system reset
Desc:	pop up a window indicating that the system overlay file can not be
	  loaded
SeeAlso: AX=AF00h"WinDOS",AX=AF08h"WinDOS"
--------O-2FAF08-----------------------------
INT 2F - WinDOS v2.11 - SIGNAL RECOVERABLE OVERLAY FAULT
	AX = AF08h
Return: nothing
Desc:	pop up a window requesting that a disk containing SH.OVL be inserted
SeeAlso: AX=AF00h"WinDOS",AX=AF07h"WinDOS",AX=AF0Bh
--------O-2FAF09-----------------------------
INT 2F - WinDOS v2.11 - GET TERMINATED PSP
	AX = AF09h
Return: DS = PSP segment of most recently ended TSR
SeeAlso: AX=AF00h"WinDOS",AX=AF0Ah
--------O-2FAF0A-----------------------------
INT 2F - WinDOS v2.11 - GET MAIN SHELL PSP
	AX = AF0Ah
Return: AX = shell's PSP (same as DS on last call to AX=AF06h)
Desc:	get the PSP address of the last program to call AX=AF06h (normally
	  the main command interpreter)
SeeAlso: AX=AF00h"WinDOS",AX=AF06h"WinDOS",AX=AF09h
--------O-2FAF0B-----------------------------
INT 2F - WinDOS v2.11 - SIGNAL FATAL ERROR
	AX = AF0Bh
Return: never -- system reset
Desc:	pop up a window indicating a terminal system error
SeeAlso: AX=AF00h"WinDOS",AX=AF07h,AX=AF08h,AX=AF15h"WinDOS"
--------O-2FAF0C-----------------------------
INT 2F - WinDOS v2.11 - GET OTHER MAIN SHELL PARAMETERS
	AX = AF0Ch
Return: DI:AX = stack
	SI = offset of break handler
Desc:	retrieve the parameters last set by AX=AF06h (normally by the main
	  command interpreter)
SeeAlso: AX=AF00h"WinDOS",AX=AF06h"WinDOS"
--------O-2FAF0D-----------------------------
INT 2F - WinDOS v2.11 - GET CURRENT PARAMETER
	AX = AF0Dh
	BX = offset of desired parameter in global data area
Return: AX = current value of parameter (AH undefined if byte value)
SeeAlso: AX=AF00h"WinDOS",AX=AF0Eh
--------O-2FAF0E-----------------------------
INT 2F - WinDOS v2.11 - SET CURRENT PARAMETER BYTE VALUE
	AX = AF0Eh
	BX = offset of desired parameter in global data area
	DL = new value of parameter
Return: nothing
SeeAlso: AX=AF00h"WinDOS",AX=AF0Dh
--------O-2FAF0F-----------------------------
INT 2F - WinDOS v2.11 - GET HISTORY SEGMENT
	AX = AF0Fh
Return: AX = segment of buffer for input history, or 0000h if none
SeeAlso: AX=AF00h"WinDOS",AX=AF10h"WinDOS"
--------O-2FAF10-----------------------------
INT 2F - WinDOS v2.11 - SET HISTORY SEGMENT
	AX = AF10h
	BX = segment of new buffer for input history
Return: nothing
Note:	the buffer must have been allocated with INT 21/AH=48h
SeeAlso: AX=AF00h"WinDOS",AX=AF0Fh"WinDOS"
--------O-2FAF11-----------------------------
INT 2F - WinDOS v2.11 - FREE XMS BLOCKS
	AX = AF11h
Return: nothing
Desc:	free all XMS blocks whose XMS identification value (see AX=AF12h)
	  equals the current PSP
SeeAlso: AX=AF00h"WinDOS",AX=AF12h"WinDOS",INT 21/AH=50h
--------O-2FAF12-----------------------------
INT 2F - WinDOS v2.11 - SET XMS IDENTIFICATION VALUE
	AX = AF12h
	DS = new XMS identification value (normally caller's PSP segment)
Return: nothing
SeeAlso: AX=AF00h"WinDOS",AX=AF11h"WinDOS"
----------2FAF12-----------------------------
INT 2F U - ???
	AX = AF12h
	???
Return: ES = ???
SeeAlso: AX=AF00h
--------O-2FAF13-----------------------------
INT 2F - WinDOS v2.11 - SET ASSIGN VALUE
	AX = AF13h
	BL = number of drive to remap (00h = A:)
	DL = number of drive to be accessed via drive number BL
Return: nothing
Desc:	remap a drive letter
Note:	the remapping can be canceled by specifying DL=BL
SeeAlso: AX=AF00h"WinDOS",AX=AF14h"WinDOS",AX=0601h
----------2FAF13-----------------------------
INT 2F U - ???
	AX = AF13h
	???
Return: ???
SeeAlso: AX=AF00h
--------O-2FAF14-----------------------------
INT 2F - WinDOS v2.11 - GET ASSIGN VALUE
	AX = AF14h
	BL = drive number (00h = A:)
Return: DL = drive number which is actually accessed by drive number BL
Desc:	determine the current mapping for a drive
SeeAlso: AX=AF00h"WinDOS",AX=AF13h"WinDOS",AX=0601h
--------O-2FAF15-----------------------------
INT 2F - WinDOS v2.11 - SIGNAL STACK ERROR
	AX = AF15h
Return: never -- system reset
Desc:	pop up a window indicating a stack overflow
SeeAlso: AX=AF00h"WinDOS",AX=AF0Bh"WinDOS"
--------O-2FAF16-----------------------------
INT 2F - WinDOS v2.11 - GET SIMPLE TRUENAME
	AX = AF16h
	DS:SI -> path to be canonicalized
	ES:DI -> buffer for canonicalized filename/pathname
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = DOS error code (see #01680 at INT 21/AH=59h/BX=0000h)
Desc:	partially canonicalize a path, omitting SUBST, JOIN, ASSIGN, and
	  network redirections
SeeAlso: AX=AF00h"WinDOS",INT 21/AH=60h
--------O-2FAF17-----------------------------
INT 2F - WinDOS v2.11 - QUERY FOR NEW CURRENT DRIVE
	AX = AF17h
Return: nothing
Desc:	pop up a dialog allowing the user to select a new default drive
SeeAlso: AX=AF00h"WinDOS"
--------O-2FAF18-----------------------------
INT 2F - WinDOS v2.11 - SET CTRL-C/CTRL-BREAK DISABLE FLAG
	AX = AF18h
	DL = new break-checking state (00h enabled, 01h disabled)
Return: nothing
SeeAlso: AX=AF00h"WinDOS"
--------O-2FAF19-----------------------------
INT 2F - WinDOS v2.11 - SET HEAD SETTLE FLAG
	AX = AF19h
	DL = new state
	    00h diskette head settling time reset to 15ms before each access
	    01h no additional head settling time used between accesses
Return: nothing
SeeAlso: AX=AF00h"WinDOS"
--------O-2FAF1A-----------------------------
INT 2F - WinDOS v2.11 - SEARCH FOR NON-FRAGMENTED DISK AREA
	AX = AF1Ah
	BL = drive (00h = current, 01h = A:, etc.)
	CX = number of clusters desired
Return: CF clear if successful
	    DI = first free cluster on logical drive
	    BP = first cluster of contiguous free area
	    AX destroyed
	CF set on error
	    AX = DOS error code (see #01680 at INT 21/AH=59h/BX=0000h)
Desc:	attempt to find an area of the disk containing the specified number
	  of contiguous unallocated clusters
SeeAlso: AX=AF00h"WinDOS"
----------2FAF30-----------------------------
INT 2F U - ???
	AX = AF30h
	???
Return: ???
SeeAlso: AX=AF00h
--------d-2FAFDE-----------------------------
INT 2F - Disk-Emu - INSTALLATION CHECK / GET VERSION
	AX = AFDEh
	ES:DI -> 14-byte buffer for data (see #02979)
Return: AX = CFDEh (Carlos Fernandez Disk-Emu) if installed
	    BX = version (BH = major, BL = minor)

Format of Disk-Emu information data:
Offset	Size	Description	(Table 02979)
 00h	BYTE	number of tracks
 01h	BYTE	sectors per track
 02h	WORD	bytes per sector
 04h	BYTE	number of heads
 05h	BYTE	flag: 00h inactive, 01h active
 06h	BYTE	write protection (00h none, 01h full, 02h pseudo)
 07h	BYTE	saved (00h some unsaved data, 01h all data saved)
 08h	BYTE	disk in memory (00h no, 01h yes)
 09h	WORD	EMS handle
 0Bh	WORD	XMS handle
 0Dh	BYTE	memory type used for disk (00h XMS, 01h EMS)
--------V-2FB000-----------------------------
INT 2F - DOS 3.3+ GRAFTABL.COM - INSTALLATION CHECK
	AX = B000h
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
Notes:	called by DISPLAY.SYS
	documented for DOS 5.0, but undocumented in prior versions
SeeAlso: AX=2300h,AX=2E00h,AX=B001h
--------V-2FB001-----------------------------
INT 2F - DOS 3.3+ GRAFTABL.COM - GET GRAPHICS FONT TABLE
	AX = B001h
	DS:BX -> DWORD buffer for address of 8x8 font table
Return: buffer filled
	AL = FFh
Note:	PC-DOS 3.30/4.01 and MS-DOS 6.0 set the font table offset to 0130h,
	  MS-DOS 3.30 sets it to 0030h
SeeAlso: AH=2Eh"GRAFTABL",AX=B000h
--------I-2FB400-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - INSTALLATION CHECK
	AX = B400h
Return: AL = FFh if installed
--------I-2FB401-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - GET HOST BUFFER ADDRESS
	AX = B401h
Return: ES -> host screen buffer (PC ASCII format)
	ES unchanged if communications not started
--------I-2FB402-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B402h
	BX = ???
Return: ???
--------I-2FB403-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B403h
	???
Return: ???
--------I-2FB404-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B404h
	???
Return: ???
--------I-2FB405-----------------------------
INT 2F - IBM PC3270 EMULATION PROG v3 - ???
	AX = B405h
	???
Return: ???
--------f-2FB700-----------------------------
INT 2F - APPEND - INSTALLATION CHECK
	AX = B700h
Return: AL = status
	    00h not installed
	    FFh installed
Note:	MS-DOS 3.30 APPEND refuses to install itself when run inside TopView or
	  a TopView-compatible environment
SeeAlso: AX=B702h
--------f-2FB701-----------------------------
INT 2F U - APPEND v3.21 only - GET APPEND PATH
	AX = B701h
Return: ES:DI -> active APPEND path
Notes:	the only version of APPEND known to support this call is the APPEND
	  shipped with Microtek MS-DOS 3.21; MS-DOS 3.30-6.00 APPEND displays
	  "Incorrect APPEND Version" and aborts the caller
	use AX=B704h first, and only call this function if that one is not
	  supported
SeeAlso: AX=B700h,AX=B704h
--------f-2FB702-----------------------------
INT 2F - APPEND - GET VERSION
	AX = B702h
Return: AX = FFFFh if not DOS 4.0 APPEND (also if DOS 5.0 APPEND)
	AL = major version number
	AH = minor version number, otherwise
SeeAlso: AX=B700h,AX=B710h
--------f-2FB703-----------------------------
INT 2F U - DOS 3.3, DOS 5.0 APPEND - HOOK INT 21
	AX = B703h
	ES:DI -> INT 21 handler APPEND should chain to
Return: ES:DI -> APPEND's INT 21 handler
Note:	each invocation of this function toggles a flag which APPEND uses to
	  determine whether to chain to the user handler or the original
	  INT 21
SeeAlso: AX=B700h,AX=B706h
--------f-2FB704-----------------------------
INT 2F - DOS 3.3+ APPEND - GET APPEND PATH
	AX = B704h
Return: ES:DI -> active APPEND path (128 bytes max)
Note:	some versions of append do not support this call, and return ES
	  unchanged; in this case, you should call AX=B701h to get the APPEND
	  path
SeeAlso: AX=B701h
--------f-2FB706-----------------------------
INT 2F - DOS 4.0+ APPEND - GET APPEND FUNCTION STATE
	AX = B706h
Return: BX = APPEND state (see #02980)
SeeAlso: AX=B700h,AX=B707h

Bitfields for APPEND state:
Bit(s)	Description	(Table 02980)
 0	set if APPEND enabled
 1-11	reserved
 12	(DOS 5.0) set if APPEND applies directory search even if a drive has
	  been specified
 13	set if /PATH flag active
 14	set if /E flag active (environment var APPEND exists)
 15	set if /X flag active
--------f-2FB707-----------------------------
INT 2F - DOS 4.0+ APPEND - SET APPEND FUNCTION STATE
	AX = B707h
	BX = APPEND state bits (see #02980)
SeeAlso: AX=B700h,AX=B706h
--------f-2FB710-----------------------------
INT 2F U - DOS 3.3+ APPEND - GET VERSION INFO
	AX = B710h
Return: AX = current APPEND state (see #02980)
	BX = ??? (0000h in MS-DOS 3.30 and 5.00)
	CX = ??? (0000h in MS-DOS 3.30 and 5.00)
	DL = major version
	DH = minor version
SeeAlso: AX=B700h,AX=B702h
--------f-2FB711-----------------------------
INT 2F - DOS 4.0+ APPEND - SET RETURN FOUND NAME STATE
	AX = B711h
Note:	if the next INT 21h call (and ONLY the next) is function 3Dh, 43h, or
	  6Ch (also 4B03h and 4Eh if /X active), the fully qualified filename
	  is written over top of the filename passed to the INT 21h call.  The
	  application must provide a sufficiently large buffer.	 This state is
	  reset after the next INT 21h call processed by APPEND.
	APPEND uses the byte at offset 3Dh in the PSP
	  (see #01378 at INT 21/AH=26h) to store the flag telling it to
	  overwrite the filename
BUG:	DOS 4.0 APPEND reportedly overwrites DS:DX instead of DS:SI for
	  INT 21/AH=6Ch
SeeAlso: INT 21/AH=26h,INT 21/AH=4Eh
--------N-2FB800-----------------------------
INT 2F - NETWORK - INSTALLATION CHECK
	AX = B800h
Return: AL = status
	    00h	    not installed
	    nonzero installed
	      BX = installed component flags (test in this order!)
		   bit 6   server
		   bit 2   messenger
		   bit 7   receiver
		   bit 3   redirector
		   bit 1   LANPUP (LANtastic 4.0)
Notes:	this function is supported by PC LAN Program, LAN Manager, LANtastic,
	  NetWare Lite, SilverNET, 10NET, etc.
	LANtastic and NetWare Lite use only BL for the return value, preserving
	  BH; LAN Manager and DOS LAN Requester return BH=00h.	This permits
	  differentiation between those two groups by setting BH to a nonzero
	  value before the call and checking its value on return.
SeeAlso: AX=4E53h,AX=B809h
--------N-2FB800CXF041-----------------------
INT 2F - 10NET - INSTALLATION CHECK
	AX = B800h
	CX = F041h
Return: AL = status
	    00h	    not installed
	    nonzero installed
		BX = installed component flags (test in this order!)
		   bit 6   server
		   bit 2   messenger
		   bit 7   receiver
		   bit 3   redirector
		   bit 1   LANPUP (LANtastic 4.0)
		CX = 10Net data segment
		CX:DX -> 10Net Configuration Table
			  (see #01691 at INT 21/AX=5E01h"10NET")
Note:	if CX <> F041h on entry, neither CX nor DX will be changed, and this
	  call becomes identical to the standard installation check above
SeeAlso: AX=B800h"network",INT 21/AX=5E01h"10NET"
--------N-2FB803-----------------------------
INT 2F - NETWORK - GET NETWORK EVENT POST HANDLER
	AX = B803h
Return: ES:BX -> current event post handler (see AX=B804h)
Note:	this function is supported by PC LAN Program, 10NET v5.0,
	  NetSoft DOS-NET v1.20+
SeeAlso: AX=B800h,AX=B804h,AX=B903h
--------N-2FB804-----------------------------
INT 2F - NETWORK - SET NETWORK EVENT POST HANDLER
	AX = B804h
	CX = (10NET) 0370h if 10Windows is hooking post handler
	ES:BX -> new event post handler (see #02981)
Notes:	used in conjunction with AX=B803h to hook into the network event post
	  routine
	this function is supported by PC LAN Program, 10NET v5.0,
	  NetSoft DOS-NET v1.20+
	The specified handler is called on any network event.  Two events are
	  defined: message received and critical network error.
SeeAlso: AX=B800h,AX=B803h,AX=B904h

(Table 02981)
Values network post routine is called with:
	AX = 0000h single block message
	    DS:SI -> ASCIZ originator name
	    DS:DI -> ASCIZ destination name
	    ES:BX -> text header (see #02982)
	AX = 0001h start multiple message block
	    CX = block group ID
	    DS:SI -> ASCIZ originator name
	    DS:DI -> ASCIZ destination name
	AX = 0002h multiple block text
	    CX = block group ID
	    ES:BX -> text header (see #02982)
	AX = 0003h end multiple block message
	    CX = block group ID
	AX = 0004h message aborted due to error
	    CX = block group ID
	AX = 0101h server received badly formatted network request
	    Return: AX = FFFFh (PC LAN will process error)
	AX = 0102h unexpected network error
	    ES:BX -> NCB (see #03249 at INT 5C"NetBIOS")
	AX = 0103h server received INT 24 error
	    other registers as for INT 24, except AH is in BH
	    Return: as below, but only 0000h and FFFFh allowed
Return: AX = response code
	    0000h user post routine processed message
	    0001h PC LAN will process message, but message window not displayed
	    FFFFh PC LAN will process message

Format of text header:
Offset	Size	Description	(Table 02982)
 00h	WORD	length of text (maximum 512 bytes)
 02h  N BYTEs	text of message
Note:	all CRLF sequences in message text are replaced by 14h; all other
	  values below 20h (space) are reserved
--------N-2FB807-----------------------------
INT 2F - NETWORK - GET NetBIOS NAME NUMBER OF MACHINE NAME
	AX = B807h
Return: CH = NetBIOS name number of the machine name
SeeAlso: INT 21/AX=5E00h
--------N-2FB808-----------------------------
INT 2F U - NETWORK - RELINK KEYBOARD HANDLER
	AX = B808h
	ES:BX -> INT 09 handler network should call after it finishes INT 09
Notes:	this call replaces the address to which the network software chains on
	  an INT 09 without preserving the original value.  This allows a prior
	  handler to unlink, but does not allow a new handler to be added
	  such that the network gets the INT 09 first unless the new handler
	  completely takes over INT 09 and never chains.
	this function is called by the DOS 3.2 KEYBxx.COM and DOS 3.3+ KEYB.COM
SeeAlso: AX=B908h
--------N-2FB809-----------------------------
INT 2F - NETWORK - LANtastic, NetWare Lite - GET VERSION
	AX = B809h
Return: AH = major version
	AL = minor version (decimal)
Notes:	this function is supported in this form by LANtastic, NetWare Lite,
	  SilverNET, ...
	NetWare Lite returns its own version number rather than a PC LAN
	  compatibility version
SeeAlso: AX=4E53h,AX=B800h,AX=B809h"PC LAN Program"
--------N-2FB809-----------------------------
INT 2F - NETWORK - PC LAN Program, Microsoft Networking - GET VERSION
	AX = B809h
Return: AH = minor version (decimal)
	AL = major version
Notes:	this function is supported in this form by PC LAN Program, LAN Manager,
	  the DOS LAN Requester, 10NET v5.0, and Microsoft Networking under
	  WfWg 3.11
	10NET returns version 1.10 (AX=0A01h) for compatibility
SeeAlso: AX=4E53h,AX=B800h,AX=B809h"LANtastic"
--------N-2FB80A-----------------------------
INT 2F u - PC Network 1.00 - ???
	AX = B80Ah
	???
Return: ???
Program: PC Network is an early networking package which was renamed the
	  IBM PC Local Area Network Program (PC LAN Program) as of v1.10
Note:	called by RECEIVER (equivalent to NetWare Lite SERVER)
--------N-2FB80E-----------------------------
INT 2F U - DOS LAN Requester - GET XSI2 ADDRESS / DATA
	AX = B80Eh
Return: DS:DI -> XSI2 TSR's resident data (see #02983)
Note:	this function is used by NET.COM to locate the USERID and DOMAIN of
	  the logged-in user (which may differ from the NET START domain
	  name from DOSLAN.INI which is returned by AX=B80Fh)
SeeAlso: AX=B800h,AX=B80Fh

Format of XSI2 resident data:
Offset	Size	Description	(Table 02983)
 00h 254 BYTEs	???
 FEh 10 BYTEs	user ID 1
108h 10 BYTEs	user ID 2
112h 10 BYTEs	domain name 1
11Ch 10 BYTEs	domain name 2
126h  ? BYTEs	domain controller
--------N-2FB80F-----------------------------
INT 2F - DOS LAN Requester - GET START PARAMETERS
	AX = B80Fh
	CX = size of return data buffer
	ES:DI -> return data buffer (see #02984)
Return: AX = status
	     00h     network started
	     nonzero network not started
	CX = number of bytes returned in buffer
	ES:DI buffer filled
SeeAlso: AX=B809h"PC LAN Program",AX=B80Eh

Format of DOS LAN Requester return data buffer:
Offset	Size	Description	(Table 02984)
 00h	BYTE	major version
 01h	BYTE	minor version
 02h	WORD	configuration flags given when network was started (see #02985)
 04h 15 BYTEs	NET START machine name (space padded)
 13h	BYTE	00h
 14h 9	BYTEs	NET START domain name (NULL padded)
 1Dh	BYTE	00h
 1Eh 32 BYTEs	/WRK heuristics string (space padded, not terminated)
 3Eh	WORD	/SRV value
 40h	WORD	/ASG value
 42h	WORD	/NBC value
 44h	WORD	/NBS value
 46h	WORD	/BBC value
 48h	WORD	/BBS value
 4Ah	WORD	/PBC value
 4Ch	WORD	/PBS value
 4Eh	WORD	/PFS value
 50h	WORD	/PFT value
 52h	WORD	/PWT value
 54h	WORD	/KUC value
 56h	WORD	/KST value
 58h	WORD	/NVS value
 5Ah	WORD	/NMS value
 5Ch	WORD	/NDB value
 5Eh	WORD	/MBI value
 60h	BYTE	NetBIOS name number for machine name
 61h	BYTE	NetBIOS name number for domain name
 62h	WORD	NetBIOS sessions required for configuration
 64h	WORD	NetBIOS commands required for configuration
 66h	WORD	NetBIOS names required for configuration
 68h 128 BYTEs	NET START path (LANROOT)
 E8h	BYTE	00h

Bitfields for configuration flags:
Bit(s)	Description	(Table 02985)
 0	/NVS nonzero
 1	/NMS nonzero
 2	/API
 3	/HIM
 4	/LIM
 5	/ENC
 6	/POP
 7	/EMS
 8	/RPL
 9-12	reserved
 13	RDR started
 14	RCV started
 15	User is currently logged on
--------N-2FB900-----------------------------
INT 2F - PC Network RECEIVER.COM - INSTALLATION CHECK
	AX = B900h
Return: AL = state
	    00h if not installed
	    FFh if installed
--------N-2FB901-----------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM INT 2F HANDLER ADDRESS
	AX = B901h
Return: AL = ???
	ES:BX -> RECEIVER.COM INT 2F handler
Desc:	allows more efficient execution by letting the caller bypass any other
	  INT 2F handlers which have been added since RECEIVER.COM was
	  installed
--------N-2FB903-----------------------------
INT 2F - PC Network RECEIVER.COM - GET RECEIVER.COM POST ADDRESS
	AX = B903h
Return: ES:BX -> POST handler
SeeAlso: AX=B803h,AX=B904h
--------N-2FB904-----------------------------
INT 2F - PC Network RECEIVER.COM - SET RECEIVER.COM POST ADDRESS
	AX = B904h
	ES:BX -> new POST handler
SeeAlso: AX=B804h,AX=B903h
--------N-2FB905-----------------------------
INT 2F - PC Network RECEIVER.COM - GET FILENAME
	AX = B905h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: buffers filled from RECEIVER.COM internal buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B906h
--------N-2FB906-----------------------------
INT 2F - PC Network RECEIVER.COM - SET FILENAME
	AX = B906h
	DS:BX -> 128-byte buffer for filename 1
	DS:DX -> 128-byte buffer for filename 2
Return: RECEIVER.COM internal buffers filled from user buffers
Note:	use of filenames is unknown, but one appears to be for storing messages
SeeAlso: AX=B905h
--------N-2FB908-----------------------------
INT 2F - PC Network RECEIVER.COM - UNLINK KEYBOARD HANDLER
	AX = B908h
	ES:BX -> INT 09 handler RECEIVER should call after it finishes INT 09
Note:	this call replaces the address to which RECEIVER.COM chains on an
	  INT 09 without preserving the original value.	 This allows a prior
	  handler to unlink, but does not allow a new handler to be added
	  such that RECEIVER gets the INT 09 first.
SeeAlso: AX=B808h
----------2FBB00BX0000-----------------------
INT 2F - CATC USB4DOS Host Controller - INSTALLATION CHECK
	AX = BB00h
	BX = 0000h
Return: AX = 0001h if installed
----------2FBB00BX0001-----------------------
INT 2F - CATC USB4DOS Host Controller - GET ???
	AX = BB00h
	BX = 0001h
Return: AX = 0000h
	CX:BX -> ???
----------2FBB00BX0002-----------------------
INT 2F - CATC USB4DOS Host Controller - EXECUTE USB REQUEST
	AX = BB00h
	BX = 0002h
	CX:DX -> request packet (see #04097)
Return: AX = destroyed

Format of USB4DOS Host Controller request packet:
Offset	Size	Description	(Table 04097)
 00h	WORD	command number
 02h	WORD	(ret) major status
 04h	WORD	(ret) minor status
 06h	DWORD	-> callback function
 0Ah 25 BYTEs	data for command (varies by command number)
 23h 12 BYTEs	reserved for future use
----------2FBB00BX0003-----------------------
INT 2F - CATC USB4DOS Host Controller - ??? (POLLS VARIOUS I/O PORTS)
	AX = BB00h
	BX = 0003h
Return: AX = ???
----------2FBB00-----------------------------
INT 2F - CATC USB4DOS Host Controller - INVALID FUNCTION
	AX = BB00h
	BX > 0003h
Return: AX = FFFFh (invalid function)
--------V-2FBC00-----------------------------
INT 2F - Windows 3.0, DOS 5+ EGA.SYS - INSTALLATION CHECK
	AX = BC00h
Return: AL = state
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
		BX = 5456h ("TV")
Range:	AH=80h to AH=FFh, selected by commandline switch
SeeAlso: AX=BC06h"EGA",INT 10/AH=FAh"EGA"
----------2FBC00BL00-------------------------
INT 2F - CATC USB4DOS Device Manager - INSTALLATION CHECK
	AX = BC00h
	BL = 00h
Return: AX = installation state
	    0000h not installed
	    0001h installed
	    BC00h not installed
SeeAlso: AX=BC00h/BL=01h,AX=BC00h/BL=03h
----------2FBC00BL01-------------------------
INT 2F - CATC USB4DOS Device Manager - REGISTER DEVICE
	AX = BC00h
	BL = 01h
	CX:DX -> client_info structure (see #04096)
Return: AX = client number, 0000h on failure
SeeAlso: AX=BC00h/BL=02h,AX=BC00h/BL=00h

Format of CATC USB4DOS client_info structure:
Offset	Size	Description	(Table 04096)
 00h	DWORD	-> Attach() worker function
 04h	DWORD	-> Detach() worker function
----------2FBC00BL02-------------------------
INT 2F - CATC USB4DOS Device Manager - UNLOAD DEVICE
	AX = BC00h
	BL = 02h
	CX = client number
Return: AX destroyed
SeeAlso: AX=BC00h/BL=01h,AX=BC00h/BL=00h
----------2FBC00BL03-------------------------
INT 2F - CATC USB4DOS Device Manager - HUB DEVICE ATTACHED
	AX = BC00h
	BL = 03h
	BH = address and device type
	    bits 7-1: USB address of hub
	    bit 0: device speed
		=0 low-speed device
		=1 full-speed device
	CX:DX -> callback function
Return: AX = USB address of attached device, or 0000h on failure
SeeAlso: AX=BC00h/BL=04h,AX=BC00h/BL=00h
----------2FBC00BL04-------------------------
INT 2F - CATC USB4DOS Device Manager - HUB DEVICE DETACHED
	AX = BC00h
	BL = 04h
	BH = USB address of detached device (may be the hub itself)
Return: AX destroyed
SeeAlso: AX=BC00h/BL=03h,AX=BC00h/BL=00h
--------s-2FBC00BX3F3F-----------------------
INT 2F - MediaVision MVSOUND.SYS - INSTALLATION CHECK
	AX = BC00h
	BX = 3F3Fh ('??')
	CX = 0000h
	DX = 0000h
Return: if installed, BX XOR CX XOR DX = 4D56h ('MV')
Program: MVSOUND.SYS is a driver for the MediaVision ProAudio Spectrum family
	  of sound boards; its primary programmer was Bryan Crane
SeeAlso: AX=BC01h"MVSOUND",AX=BC02h,AX=BC03h,AX=BC04h,AX=BC06h"MVSOUND"
--------s-2FBC01-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET VERSION
	AX = BC01h
	BX = magic value 6D20h ('m ')
	CX = magic value 2076h (' v')
	DX = magic value 2020h ('  ')
Return: BX = ASCII major version (leading zeros significant)
	CX = ASCII minor version (leading zeros significant)
SeeAlso: AX=BC00h/BX=3F3Fh
--------s-2FBC02-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET STATE TABLE POINTER
	AX = BC02h
Return: AX = 4D56h ('MV')
	BX:DX -> state table
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC03h
--------s-2FBC03-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET FUNCTION TABLE POINTER
	AX = BC03h
Return: AX = 4D56h ('MV')
	BX:DX -> function table
	CX = ??? (000Eh)
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC02h
--------s-2FBC04-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET DMA AND IRQ CHANNELS
	AX = BC04h
Return: AX = 4D56h ('MV')
	BL = DMA channel
	CL = IRQ number
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC01h"MVSOUND"
--------V-2FBC06-----------------------------
INT 2F U - MS Windows 3.0, DOS 5+ EGA.SYS - GET VERSION INFO
	AX = BC06h
Return: BX = 5456h ("TV")
	CH = major version
	CL = minor version
	DL = revision
SeeAlso: AX=BC00h"EGA",INT 10/AH=FAh"EGA"
--------s-2FBC06-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET STATUS STRING
	AX = BC06h
Return: AX = 4D56h ('MV')
	DX:BX -> status string (first byte 0Ch if no status message to display)
SeeAlso: AX=BC00h/BX=3F3Fh,AX=BC01h"MVSOUND",AX=BC0Bh"MVSOUND"
--------s-2FBC0B-----------------------------
INT 2F - MediaVision MVSOUND.SYS - GET EXECUTABLE PATH
	AX = BC0Bh
Return: BX:DX -> ASCIZ path for MVPROAS.EXE, 0000h:0000h if not available
SeeAlso: AX=BC00h/BX=3F3Fh
--------s-2FBC0E-----------------------------
INT 2F - MediaVision MVSOUND.SYS - RE-INITIALIZE INT 09 HANDLER
	AX = BC0Eh
Return: BX = status
	    0000h on failure
		AX = 0000h
	    FFFFh if successful
		DX:AX -> prior INT 09 handler
Desc:	re-initialize INT 09 handler to re-enable hotkeys (e.g. after loading
	  KEYB)
--------U-2FBE00-----------------------------
INT 2F - REDVIEW - INSTALLATION CHECK
	AX = BE00h
Return: AL = FFh if installed
Program: REDVIEW is a public-domain TSR by Alexandr Novy and Petr Horak which
	  copies data sent to standard output to standard error when the
	  former has been redirected to a file, thus allowing the data to
	  be seen on the screen at the same time it is captured in a file
--------N-2FBF00-----------------------------
INT 2F - PC LAN PROGRAM REDIRIFS.EXE internal - INSTALLATION CHECK
	AX = BF00h
Return: AL = FFh if installed
Note:	this function is also supported by NetSoft's DOS-NET v1.20+; however,
	  none of the remaining BFxxh calls are supported
SeeAlso: AX=BF01h,AX=BF80h,INT 2A/AX=4147h
--------N-2FBF01-----------------------------
INT 2F U - PC LAN PROGRAM REDIRIFS.EXE internal - ???
	AX = BF01h
	???
Return: ???
SeeAlso: AX=BF00h
--------N-2FBF80-----------------------------
INT 2F - PC LAN PROG REDIR.SYS internal - SET REDIRIFS ENTRY POINT
	AX = BF80h
	ES:DI -> FAR entry point to IFS handler in REDIRIFS
Return: AL = FFh if installed
	    ES:DI -> internal workspace
Note:	all future IFS calls to REDIR.SYS are passed to the ES:DI entry point
SeeAlso: AX=BF00h
--------F-2FC0-------------------------------
INT 2F - METZ XpressFax Hardware TSR (CLASS2) - API
	AH = C0h
	AL = function code (01h to 15h)
Return: ???
SeeAlso: AX=C000h/BX=444Bh,AX=CB00h/BX=4D53h
--------N-2FC000-----------------------------
INT 2F - Novell ODI Link Support Layer (LSL.COM) - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    DX:BX -> FAR entry point (see #02986,#02987,#02988)
	    ES:SI -> signature string "LINKSUP$"
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	on return, ES = DX for LSL v1.10 and v2.05; LSL makes use of this in
	  its search for a previous installation
SeeAlso: AX=5100h,AX=C000h"NESL"

(Table 02986)
Call LSL function "Request MLID Registration" with:
	BX = 0001h
	ES:SI -> registration??? record (see #02990)
	DS:DI -> buffer for LSL information block (see #02991)
Return: AX = completion code (0000h,8001h) (see #02989)
	DS:DI buffer filled if successful
	BX,CX corrupted
Note:	see "Novell LAN Driver Developer's Guide, Volume III" for more details

(Table 02987)
Call LSL function "get support entry points" with:
	BX = 0002h
	ES:SI -> buffer for entry point record (see #02992)
Return: ES:SI buffer filled

(Table 02988)
Call LSL function "Request MLID API entry point" with:
	BX = 0003h
Return: ES:SI -> MLID (Multiple Link Interface Driver) API entry point
		(call with BX=function 00h-10h, not range-checked)
Note:	LSL v1.10 and v2.05 execute BX=0003h for BX=0000h and any BX >= 0003h

(Table 02989)
Values for LSL completion code:
 0000h	successful
 8001h	out of resources
 8002h	bad parameter
 8003h	no more items
 8004h	item not present
 8005h	failed
 8006h	receive overflow
 8007h	canceled
 8008h	bad command
 8009h	duplicate entry
 800Ah	no such handler
 800Bh	no such driver

Format of LSL registration record:
Offset	Size	Description	(Table 02990)
 00h	DWORD	-> ??? FAR function (to be called with ES:SI -> ??? and
		  returning AX = completion code)
 04h	DWORD	-> ???
 08h	DWORD	-> ??? data (at least 3Eh bytes)

Format of LSL information block:
Offset	Size	Description	(Table 02991)
 00h	DWORD	-> ??? entry point (called with BX=function 00h-11h)
 04h	WORD	???
 06h	WORD	???
Note:	due to a fencepost error, LSL v2.05 (distributed with Novell DOS 7)
	  will crash if the above entry point is called with BX=0012h

Format of entry point record:
Offset	Size	Description	(Table 02992)
 00h	DWORD	pointer to protocol support entry point in LSL (see #02993)
 04h	DWORD	pointer to general support entry point in LSL (see #02994)

(Table 02993)
Call protocol support entry point with:
	BX = function number
	    0000h ???
	    0001h ???
	    0002h ???
	    0003h "ScheduleAESEvent"
		ES:SI -> AES ECB to be scheduled (see #02997)
		Return: ES,SI preserved
	    0004h "CancelAESEvent"
		ES:SI -> ECB to be cancelled (see #02997)
		Return: ES,SI preserved
	    0005h "GetIntervalMarker"
		Return: DX:AX = current interval marker in milliseconds
			all other registers preserved
	    0006h "RegisterStack"
		AX = logical board number
		ES:SI -> bound stack info structure (see #03007)
		Return: BX = assigned Stack ID if AX=0000h
	    0007h "DeRegisterStack"
		AX = protocol stack's assigned Stack ID
	    0008h "RegisterDefaultStack"
		AX = logical board number
		ES:SI -> stack info structure (see #03008)
	    0009h "DeRegisterDefaultStack"
		AX = logical board number
	    000Ah "RegisterPrescanStack"
		AX = logical board number
		ES:SI -> stack info structure (see #03008)
	    000Bh "DeRegisterPrescanStack"
		AX = logical board number
	    000Ch "SendPacket"
		ES:SI -> send ECB
		Return: interrupts disabled
	    000Dh ???
	    000Eh ???
	    000Fh ???
	    0010h "GetStackIDFromName"
		ES:SI -> counted NUL-terminated protocol name (max 15 chars)
		Return: BX = Stack ID if AX=0000h
	    0011h "GetPIDFromStackIDBoard"
		AX = Stack ID for protocol
		CX = logical board number
		ES:SI -> 6-byte buffer for protocol ID
	    0012h "GetMLIDControlEntry"
		AX = logical board number
		Return: ES:SI -> MLID control handler (see #02995) if AX=0000h
	    0013h "GetProtocolControlEntry"
		AX = Stack ID or
			FFFEh Prescan stack
			    CX = logical board number
			FFFFh default protocol
			    CX = logical board number
		Return: ES:SI -> protocol stack control entry point if AX=0000h
				  (see #02996)
	    0014h "GetLSLStatistics"
		Return: AX = 0000h (successful)
			ZF set
			ES:SI -> LSL statistics table (see #02999)
	    0015h "BindStack"
		AX = protocol stack's assigned Stack ID
		CX = logical board number
	    0016h "UnbindStack"
		AX = protocol stack's assigned Stack ID
		CX = logical board number
	    0017h "AddProtocolID"
		AX = frame type ID code
		ES:SI -> 6-byte protocol ID
		CX:DI -> counted NUL-terminated short protocol name (max 15 ch)
	    0018h "RelinquishControl"
		Return: after LSL performs any necessary background processing
	    0019h "GetLSLConfiguration"
		Return: AX = 0000h (successful)
			ZF set
			ES:SI -> LSL configuration table (see #02998)
	    001Ah "GetTickMarker"
		Return: AX = number of 55ms ticks since LSL loaded
			BX destroyed
Return: AX = completion code (see #02989)
	ZF set if successful
	SS:SP, DS, BP preserved; most other registers may be destroyed

(Table 02994)
Call general support entry point with:
	BX = function number
	    0000h "Allocate Memory" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0001h "Free Memory" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0002h "Realloc Memory" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0003h "Memory Statistics" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0004h "Add Memory To Pool" (obsolete)
		 always returns AX=8008h (BAD_COMMAND)
	    0005h "AddGeneralService"
		ES:SI -> General Service Control Block (see #03009)
	    0006h "RemoveGeneralService"
		ES:SI -> General Service Control Block (see #03009)
	    0007h "GetNETcfgPath"
		Return: AX = 0000h (successful)
			DS:DX -> ASCIZ pathname for NET.CFG
	    0008h U ???	 (in LSL 1.10)
		Return: AX = 0000h
			ES:SI -> ??? (a 22-byte data area)
	    000Ah "GetCriticalSectionStatus"
		Return: BX = total outstanding calls to "StartCriticalSection"
	    000Bh "ServiceEvents"
		interrupts disabled
		Return: interrupts disabled
	    0010h "GetStackECB"
		DS:DI -> Lookahead structure (see #03010)
		interrupts disabled
		Return: ES:SI -> ECB if successful (AX=0000h,ZF set)
			interrupts disabled
	    8000h-FFFFh reserved for user general service providers
Return: AX = completion code (see #02989)
	ZF set if successful
	SS:SP, DS, BP preserved

(Table 02995)
Call MLID control handler with:
	AX = logical board number
	BX = function number
	    0000h "GetMLIDConfiguration"
		Return: ES:SI -> MLID's configuration table if successful
				  (see #03002 for format)
	    0001h "GetMLIDStatistics"
		Return: ES:SI -> MLID's statistics table if successful
				  (see #03002 for format)
	    0002h "AddMulticastAddress"
		ES:SI -> 6-byte multicast address to add
	    0003h "DeleteMulticastAddress"
		ES:SI -> 6-byte multicast address to delete
	    0005h "MLIDShutdown"
		CX = type
		    0000h permanent (also deregisters from LSL)
		    other temporary (shutdown hardware only)
	    0006h "MLIDReset" reinitialize board / restart from temp shutdown
	    0007h "Create Connection" (obsolete?)
		???
	    0008h "Delete Connection" (obsolete?)
		???
	    0009h "SetLookAheadSize"
		CX = requested lookahead size (00h-80h)
	    000Ah "PromiscuousChange"
		CX = what to receive promiscuously
		    bit 0: MAC frames
		    bit 1: non-MAC frames
	    000Bh "RegisterReceiveMonitor"
		CX = subfunction
		    0000h disable receive monitoring
		    else  enable receive monitoring
		ES:SI -> monitor receive routine
		ES:DI -> monitor transmit routine
	    000Ch "Driver Poll" (obsolete?)
		???
Return: AX = completion code (see #02989)
	ZF set if successful
Note:	not all boards/MLIDs support function 0010h; see bit 13 in the MLID
	  mode flags field of the MLID's configuration table

(Table 02996)
Call protocol stack control entry point with:
	BX = function number
	    0000h "GetProtocolStackConfiguration"
		Return: ES:SI -> protocol stack's configuration table
				   (see #03001)
	    0001h "GetProtocolStackStatistics"
		Return: ES:SI -> protocol stack's statistics table (see #03000)
	    0002h "BindToMLID"
		CX = board number to bind to
		ES:SI -> implementation-dependant parameter string
	    0003h "UnBindFromMLID"
		CX = board number from which protocol should unbind
		ES:SI -> optional implementation-dependant parameter string
	    0004h "MLIDDeRegistered"
		CX = board number that has de-registered from LSL
Return: AX = status
	    0000h successful
	    else implementation-dependant error codes
	ZF set if successful
	SS:SP, DS, BP preserved

Format of AES ECB:
Offset	Size	Description	(Table 02997)
 00h	DWORD	"AESLink" pointer used by LSL for list management
 04h	DWORD	number of milliseconds to wait
 08h	DWORD	"AESStatus" (is set to 00000000h when AES ESR is invoked)
 0Ch	DWORD	-> function to be invoked when time expires
		ES:SI will point to this structure on entry,
		DS, BP, and SS:SP must be preserved.
SeeAlso: #03011

Format of LSL Configuration Table:
Offset	Size	Description	(Table 02998)
 00h	BYTE	major version of configuration table
 01h	BYTE	minor version of configuration table (decimal, 0-99)
 02h  8 BYTEs	reserved
 0Ah	BYTE	LSL major version (decimal)
 0Bh	BYTE	LSL minor version (decimal, 0-99)
---LSL 1.0x ---
 0Ch 14 BYTEs	reserved
---LSL 1.10+ ---
 0Ch	WORD	maximum number of boards which LSL can handle
 0Eh	WORD	maximum number of protocol IDs which LSL can handle
 10h 12 BYTEs	reserved

Format of LSL Statistics Table:
Offset	Size	Description	(Table 02999)
 00h	BYTE	major version of statistics table format
 01h	BYTE	minor version of statistics table format (decimal, 0-99)
 02h	WORD	"GenericCounters" number of counters in static portion of
		  table
 04h	DWORD	"ValidCountersMask" bit mask indicating which generic
		  counters are actually used.  Bit 31 = TotalTxPackets, bit 30
		  is the next field, etc.
 08h	DWORD	"TotalTxPackets" total SendPacket requests made
 0Ch	DWORD	reserved
 10h	DWORD	reserved
 14h	DWORD	"AESEventsCount" number of completed AES events
 18h	DWORD	"PostponedEvents" number of events postponed due to critical
		  sections inside the MLIDs
 1Ch	DWORD	"CancelAESFailures" number of times CancelAESEvent failed
 20h	DWORD	reserved
 24h	DWORD	reserved
 28h	DWORD	"TotalRxPackets" total number of GetStackECB requests
 2Ch	DWORD	"UnclaimedPackets" total number of packets not consumed by a
		  protocol stack
 30h	WORD	"NumberCustom" number of custom variables that follow
 32h  N DWORDs	custom counters
      N DWORDs	-> CustomCounterStrN (one per custom counter)
	var	length-prepended and NULL terminated string for Counter 0
	...
	var	length-prepended and NULL terminated string for Counter N-1
SeeAlso: #03000,#03006

Format of Protocol Stack Statistics Table:
Offset	Size	Description	(Table 03000)
 00h	BYTE	statistics table major version
 01h	BYTE	statistics table minor version (decimal, 0-99)
 02h	WORD	number of generic counters following
 04h	DWORD	"ValidCountersMask" (bitmask, bit 31 is TotalTxPackets)
 08h	DWORD	TotalTxPackets
 0Ch	DWORD	TotalRxPackets
 10h	DWORD	IgnoredRxPackets
 14h	WORD	number of custom counters
 16h  N DWORDs	custom counters
      N DWORDs	-> CustomCounterStrN (one per custom counter)
	var	length-prepended and NULL terminated string for Counter 0
	...
	var	length-prepended and NULL terminated string for Counter N-1
SeeAlso: #02999,#03006

Format of Protocol Stack Configuration Table:
Offset	Size	Description	(Table 03001)
 00h	BYTE	configuration table major version
 01h	BYTE	configuration table minor version (decimal, 0-99)
 02h	DWORD	-> counted NUL-terminated long descriptive name for protocol
 06h	DWORD	-> counted NUL-terminated short name for protocol (15 chars)
 0Ah	BYTE	protocol stack major version
 0Bh	BYTE	protocol stack minor version (decimal, 0-99)
 0Ch 16 BYTEs	reserved for future use

Format of MLID Configuration Table:
Offset	Size	Description	(Table 03002)
 00h 26 BYTEs	signature 'HardwareDriverMLID	     ' (8 spaces on end)
 1Ah	BYTE	configuration table major version
 1Bh	BYTE	configuration table minor version (decimal, 0-99)
 1Ch  6 BYTEs	node address
 22h	WORD	MLID mode flags (see #03003)
 24h	WORD	board number
 26h	WORD	board instance (if more than one of same board installed)
 28h	WORD	maximum packet size
 2Ah	WORD	BestDataSize
 2Ch	WORD	WorstDataSize
 2Eh	DWORD	-> counted NUL-terminated long name for NIC
 32h	DWORD	-> counted NUL-terminated short name for NIC (8 chars max)
 36h	DWORD	-> counted NUL-terminated Frame and Media type
 3Ah	WORD	reserved (0000h)
 3Ch	WORD	frame type ID
 3Eh	WORD	TransportTime (milliseconds)
 40h	DWORD	-> SourceRouteHandler for TokenRing. (Used by ROUTE.COM)
 44h	WORD	lookahead size
 46h	WORD	line speed (Mbps if high bit clear, else Kbps)
 48h	WORD	QueueDepth
 4Ah  6 BYTEs	reserved (0)
 50h	BYTE	driver major version
 51h	BYTE	driver minor version (decimal, 0-99)
 52h	WORD	bus/multicast flags (see #03004)
 54h	WORD	send retries
 56h	DWORD	ConfigTableLink
 5Ah	WORD	MLID sharing flags (see #03005)
 5Ch	WORD	slot number
 5Eh	WORD	I/O address 1
 60h	WORD	I/O range 1
 62h	WORD	I/O address 2
 64h	WORD	I/O range 2
 66h	DWORD	memory address 1
 6Ah	WORD	memory size 1
 6Ch	DWORD	memory address 2
 70h	WORD	memory size 2
 72h	BYTE	interrupt line 1
 73h	BYTE	interrupt line 2
 74h	BYTE	DMA line 1
 75h	BYTE	DMA line 2

Bitfields for MLID mode flags:
Bit(s)	Description	(Table 03003)
 15	MLID supports Octet Reversal
 14	node address is non-canonical
 13	promiscuous mode is supported
 12-8	reserved
 7	LDataSize field in LookAhead structure supported
 6	raw send supported
 5	MLID needs to be polled by LSL
 4	reserved (0)
 3	multicasting is supported
 2	not currently used by DOS ODI, set to 0.
 1	network card uses DMA.
 0	RealDriverBit, always set to 1.

Bitfields for bus/multicast flags:
Bit(s)	Description	(Table 03004)
 10-9	specialized multicast support
	00 = Group addressing is default for medium
	01 = Invalid
	10 = Filter group address in MLID.
	11 = Adapter filters group address.
 2	supports Micro Channel cards
 1	supports ISA cards
 0	supports EISA cards

Bitfields for MLID sharing flags:
Bit(s)	Description	(Table 03005)
 8	NIC can share DMA2
 7	NIC can share DMA1
 6	NIC can share IRQ2
 5	NIC can share IRQ1
 4	NIC can share Memory2
 3	NIC can share Memory1
 2	NIC can share IO2
 1	NIC can share IO1
 0	MLID is currently shut down

Format of MLID Statistics Table:
Offset	Size	Description	(Table 03006)
 00h	BYTE	driver statistics table major version
 01h	BYTE	driver statistics table minor version (decimal, 0-99)
 02h	WORD	number of generic counters (typically 13)
 04h	DWORD	"ValidCountersMask" (bit mask, bit 31 is TotalTxCount)
 08h	DWORD	TotalTxCount
 0Ch	DWORD	TotalRxCount
 10h	DWORD	NoECBAvailableCount
 14h	DWORD	TxTooBigCount
 18h	DWORD	TxTooSmallCount
 1Ch	DWORD	RxOverflowCount
 20h	DWORD	RxTooBigCount
 24h	DWORD	RxTooSmallCount
 28h	DWORD	TxMiscCount
 2Ch	DWORD	RxMiscCount
 30h	DWORD	TxRetryCount
 34h	DWORD	RxChecksumErrorCount
 38h	DWORD	RxMismatchCount
 3Ch	WORD	number of custom counters
 3Eh  N DWORDs	custom counters
      N DWORDs	-> CustomCounterStrN (one per custom counter)
	var	length-prepended and NULL terminated string for Counter 0
	...
	var	length-prepended and NULL terminated string for Counter N-1
SeeAlso: #02999,#03000

Format of bound stack info structure:
Offset	Size	Description	(Table 03007)
 00h	DWORD	-> protocol stack's short name (counted, NUL-terminated)
 04h	DWORD	-> receive handler
 08h	DWORD	-> control handler

Format of stack info structure:
Offset	Size	Description	(Table 03008)
 00h	DWORD	-> receive handler
 04h	DWORD	-> control handler

Format of General Service Control Block:
Offset	Size	Description	(Table 03009)
 00h	DWORD	-> next GSCB (maintained internally by LSL)
 04h	DWORD	-> entry point for general service handler
 08h	WORD	command code for this general service (8000h-FFFFh)
Note:	the control block must not be altered or deallocated until the general
	  service is removed

Format of Lookahead structure:
Offset	Size	Description	(Table 03010)
 00h	DWORD	-> Media header
 04h	DWORD	-> lookahead buffer
 08h	WORD	length of lookahead buffer
 0Ah  6 BYTEs	protocol ID
 10h	WORD	logical board number
 12h	WORD	lookahead size

Format of ODI ECB:
Offset	Size	Description	(Table 03011)
 00h	DWORD	link to next ECB
 04h	DWORD	link to previous ECB
 08h	WORD	general status
		0000h received successfully
		8006h packet overflow
		8007h reception aborted (data not valid)
 0Ah	DWORD	-> event service routine or RETF (never 0000h:0000h)(see #03012)
 0Eh	WORD	protocol stack identifier
 10h  6 BYTEs	protocol ID (sending only)
 16h	WORD	MLID board number (sending only)
 18h  6 BYTEs	MAC destination address
 1Eh  4 BYTEs	driver workspace
 22h  8 BYTEs	protocol workspace
 2Ah	WORD	total length of sent buffer
 2Ch	WORD	fragment count
 2Eh  2 WORDs	segment,offset of first fragment buffer
 32h	WORD	length of first fragment buffer
	...
SeeAlso: #02997

(Table 03012)
Values event service routine is called with:
	ES:SI -> associated ODI ECB (see #03011)
	interrupts disabled
Return: DS,BP,SS,SP preserved
	interrupt disabled
Notes:	the service routine may invoke any IPX/ODI function except CloseSocket
	it is safe to send a packet and wait for completion if enough stack
	  space is available
--------N-2FC000-----------------------------
INT 2F - Novell NetWare Event Service Layer (NESL) 1.0 - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    DX:BX -> FAR entry point (see #03013,#03014,#03015,#03016,#03017,#03018)
	    ES:SI -> signature string "NESL_EVENTS"
Program: NESL is a generic interface for event handling in ODI drivers and
	  other NetWare-oriented modules.  Primarily intended to support
	  power management and "hot swapping" of PCMCIA cards, but it is not
	  limited to this.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"Link Support Layer",AX=C000h"NETWARN"

(Table 03013)
Call NESL function GetNESLConfigPointer with:
	BX = 0000h
Return: AX = completion code (0000h,8008h) (see #03019)
	ES:SI -> NESL configuration table if successful (see #03020)
	BP,DS,STACK preserved
Desc:	Obtain a pointer to the NESL Configuration Table
SeeAlso: #03014,#03017

(Table 03014)
Call NESL function RegisterEventProducer with:
	BX = 0001h
	ES:SI -> Producer Event Control Block (PECB) (see #03021)
Return: AX = completion code (0000h, 8005h, 8008h) (see #03019)
	ES:SI -> still points to PECB
	BP,DS,STACK preserved
Desc:	Allows a module to register as a producer of a given event class
Note:	PECB_ClassName and PECB_Flags must be filled in on entry
SeeAlso: #02870,#03015,#03016,#03017

(Table 03015)
Call NESL function DeRegisterEventProducer with:
	BX = 0002h
	ES:SI -> PECB previously passed to RegisterEventProducer (see #03021)
Return: AX = completion code (0000h, 8002h, 8008h) (see #03019)
	ES:SI -> still points to PECB
	BP,DS,STACK preserved
Desc:	Allows a module to de-register as a producer of a given event class
SeeAlso: #03014,#03018

(Table 03016)
Call NESL function EventNotification with:
	BX = 0003h
	ES:SI -> PECB previously registered (see #03021)
Return: AX = completion code (0h, 8005h, 8008h) (see #03019)
	ES:SI -> still points to PECB
	BP,DS,STACK preserved
Desc:	Allows a module to signal that an event has just occurred in a given
	  event class.
Notes:	Once called, NESL will generate corresponding callouts for this
	  event, as described in Table #03023.
	on entry, the PECB_DataPtr must point at an Event Parameter Block (EPB)
	  (see #03024) filled in to match the desired event
SeeAlso: #03014

(Table 03017)
Call NESL function RegisterEventConsumer with:
	BX = 0004h
	ES:SI -> Consumer Event Control Block (CECB) (see #03022)
Return: AX = completion code (0h, 8005h, 8008h) (see #03019)
	ES:SI -> still points to CECB
	BP,DS,STACK preserved
Desc:	Allows a module to register as a consumer of a given event class
Note:	on entry, the CECB_ClassName, CECB_NotifProc and CECB_OSILevel must be
	  filled in.
SeeAlso: #03014,#03018

(Table 03018)
Call NESL function DeRegisterEventConsumer with:
	BX = 0005h
	ES:SI -> CECB previously passed to RegisterEventConsumer (see #03022)
Return: AX = completion code (0h, 8002h, 8008h) (see #03019)
	ES:SI -> still points to CECB
	BP,DS,STACK preserved
Desc:	Allows a module to de-register as a consumer of a given event class
SeeAlso: #03015,#03017

(Table 03019)
Values for NESL Error code:
 0000h	Successful
 8002h	Bad Parameter
 8005h	Fail
 8008h	Bad Command

Format of NESL Configuration Table:
Offset	Size	Description	(Table 03020)
 00h	WORD	NESL_Cfg_MajVer	 Major Version of this table (=1)
 02h	WORD	NESL_Cfg_MinVer	 Minor Version of this table (=0)
 04h	DWORD	NESL_Cfg_ModLName   -> ASCIZ long name of NESL module
		(typically -> "NetWare Event Service Layer for 16-Bit DOS")
 08h	DWORD	NESL_Cfg_ModSName   -> ASCIZ short name of NESL module
		(typically -> "NESL")
 0Ch	WORD	NESL_Cfg_ModMajVer  Major Version of NESL itself (=1)
 0Eh	WORD	NESL_Cfg_ModMinVer  Minor Version of NESL itself (=0)

Format of NESL Producer Event Control Block (PECB):
Offset	Size	Description	(Table 03021)
 00h	WORD	PECB_MajVer  Major Version of this structure (=1)
 02h	WORD	PECB_MinVer  Minor Version of this structure (=0)
 04h	DWORD	PECB_NextProducer   -> next PECB.  NULL if last.
 08h	DWORD	PECB_ClassName	    -> ASCIZ string identifying event
					  class (see #03025)
 0Ch	DWORD	PECB_ConsumerList   -> list of consumers for this event class
 10h	DWORD	PECB_DataPtr	    -> points to additional data during events
 14h	DWORD	PECB_Flags
		Bit 0	=0  consumers should be called "top down" for this
			    event class.  (OSI level 7 down to OSI level 1)
			=1  consumers should be called "bottom up"
		Bits 1-31   Reserved =0
 18h  8 BYTEs	PECB_Reserved (all zeros)
Note:	Although the event producer provides the memory for the PECB, the
	  NESL module controls this memory until the event class is
	  de-registered.
	While owned by NESL, this structure should be treated as read-only,
	  except for the PECB_DataPtr field.

Format of NESL Consumer Event Control Block (CECB):
Offset	Size	Description	(Table 03022)
 00h	WORD	CECB_MajVer  Major Version of this structure (=1)
 02h	WORD	CECB_MinVer  Minor Version of this structure (=0)
 04h	DWORD	CECB_NextConsumer   -> next CECB.  NULL if last.
 08h	DWORD	CECB_ClassName	    -> ASCIZ string identifying event
					  class (see #03025)
 0Ch	DWORD	CECB_NotifProc	    -> FAR CALL event handler (see #03023)
 10h	WORD	CECB_OSILevel
		Bits 4-7 = OSI Layer of this module (1 through 7)
		Bits 0-3 = relative ordering with other modules on same layer
 13h 14 BYTEs	CECB_Reserved (all zeros)
Note:	Although the event consumer provides the memory for the CECB, the
	  NESL module controls this memory until the consumer is de-registered.
	While owned by NESL, this structure should be treated as read-only,

(Table 03023)
Values NESL Consumer Notification Procedure is called with:
	ES:SI -> Event Parameter Block (EPB) (see #03024)
Return: AX = completion code (0000h, 8005h) (see #03019)
	ES:SI -> still points to EPB
Desc:	Called by NESL to notify the consumer when an event has occurred in
	  an event class for which it has registered.
SeeAlso: #03022

Format of NESL Event Parameter Block (EPB):
Offset	Size	Description	(Table 03024)
 00h	WORD	EPB_MajVer  Major Version of this structure (=1)
 02h	WORD	EPB_MinVer  Minor Version of this structure (=0)
 04h	DWORD	EPB_ClassName  -> ASCIZ string identifying event class
				  (see #03025)
 08h	DWORD	EPB_EventName  -> ASCIZ string identifying event within
				  class (see #03026)
 0Ch	DWORD	EPB_ModuleName -> ASCIZ string identifying module
				  producing event
 10h	DWORD	EPB_DataPtr0   -> event-defined data or NULL if not used
 14h	DWORD	EPB_DataPtr1   -> event-defined data or NULL if not used
 18h  8 BYTEs	EPB_Reserved (all zeros)

(Table 03025)
Values for NESL Event Class Names:
 Event Class		Description
 -------------------	-----------------------------------------
 Service Suspend	Suspension of a service.  Called top-down.
 Service Resume		Resumption/availability of a service. Called bottom-up.
 Service/Status Change	Change in status or level of service.  Called top-down.
 Suspend Request	Request to suspend a service.  Called bottom-up.
Note:	Contact Novell Labs to register new event classes.

(Table 03026)
Values for NESL Event Names:
 Event Name			Class		    Description
 --------------------------	-------------	    ---------------------------
 MLID Cable Disconnect		Service Suspend	    Cable disconnected from NIC
 MLID Card Removal		Service Suspend	    PCMCIA card removed
 MLID Hardware Failure		Service Suspend	    Serious hardware
							  failure in NIC
 MLID Not In Range		Service Suspend	    Wireless access point
							  is out of range
 MLID Shutdown			Service Suspend	    MLID was shut down
 MLID Media Access Denied	Service Suspend	    Access to physical
							  medium unsuccessful
 MLID Cable Reconnect		Service Resume	    Cable re-connected to NIC
 MLID Card Insertion Complete	Service Resume	    PCMCIA card inserted
 MLID In Range			Service Resume	    Wireless access point
							  in range
 MLID Reset			Service Resume	    MLID was just reset
 MLID Access Point Change	Serv/Status Change  Station has moved to
							  new access point
 MLID Speed Change		Serv/Status Change  Change in communic. speed
Note:	Contact Novell Labs to register new event names.
	For all predefined events above, EPB_DataPtr0 (see #03024) points
	  to the MLID Configuration table (see AX=C000h"ODI") for the
	  affected MLID.
--------N-2FC000-----------------------------
INT 2F - Novell NetWare Connect NETWARN - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    SI = segment of resident portion
Program: NETWARN is a utility supplied with NetWare Connect to warn a
	  remote dialup user when programs are about to be loaded slowly over
	  the modem link.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	on return, verify that it is NETWARN responding by examining signature
	  at in NETWARN's data table in the resident segment (see #03027)
SeeAlso: AX=C000h"ODI",AX=C000h"NESL"

Format of NETWARN Configuration structure:
Offset	Size	Description	(Table 03027)
 103h 7 BYTEs	signature string "NETWARN"
 10Ah	BYTE	major version in ASCII (="1")
 10Bh	BYTE	minor version in ASCII (="0")
 10Ch	DWORD	minimum size of EXE cared about in bytes (/S=xxxx)
 110h	WORD	same value in kilobytes (see #03028 [bit 4])
 112h	BYTE	multiplex code (AH value) actually being used
 113h	WORD	options (see #03028)
 115h	DWORD	INT 21h vector before NETWARN loaded
 119h	DWORD	INT 2Fh vector before NETWARN loaded
 11Dh 16 BYTEs	ASCIIZ local name of last device which was checked
 12Dh 128 BYTEs ASCIIZ remote name of last device which was checked
Note:	the specified offsets are from the start of the resident segment

Bitfields for NETWARN options:
Bit(s)	Description	(Table 03028)
 0	??? (=0)
 1	/U (Unload) selected (never in resident)
 2	/E (Enabled) Will trap & check EXEC's
 3	/D (Disabled) No EXEC checking done
 4	/S (Size) was set (see #03027 [offsets 010Ch and 0110h])
 5	/P (Path shown)
 6	/H or /? (Help) (never in resident)
SeeAlso: #03027
--------f-2FC000-----------------------------
INT 2F - FN32 32 character filename utilities - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	   ES:DI -> signature string "FN32 32CHAR TSR"
Program: FN32 is a TSR which supports 32 character filenames under PC/MS-DOS
Note:	the TSR intercepts INT 21 calls and performs filename substitution by
	  managing dictionary files in each directory which contains long
	  filenames
--------M-2FC000-----------------------------
INT 2F - QMR - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    ES:DI -> signature string "QMR1!"
Program: QMR (Cove Software, Quick Mouse Reset) monitors the mouse
	  service interrupt (int 33h) and substitutes a fast software
	  reset (mouse fn 21h) for the slow hardware reset (mouse fn 0).
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C001h"QMR",AX=C002h"QMR",AX=C003h"QMR"
--------V-2FC000-----------------------------
INT 2F - VGAsave v1.93 - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = segment of resident code
Program: VGAsave is a freeware VGA-specific, mouse-aware screenblanker by Bill
	  Javurek
Range:	AH=C0h to AH=FFh, selected by scanning for a free multiplex number
Note:	the transient portion of VGAsave compares the first 38 bytes of the
	  resident code (addressed through BX) against its own copy of the
	  resident code to complete the installation check
SeeAlso: INT 14/AX=AA01h,INT 2F/AH=93h
Index:	screen saver;VGAsave
--------V-2FC000-----------------------------
INT 2F - AD-DOS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = 4144h ('AD')
	    CX = 2D44h ('-D')
	    DX = 4F53h ('OS')
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C001h"AD-DOS",AX=C003h"AD-DOS",AX=C005h"AD-DOS",AX=C007h"AD-DOS"
SeeAlso: AX=C009h"AD-DOS",AX=C020h"AD-DOS",INT 14/AX=AA01h
Index:	screen saver;AD-DOS
--------U-2FC000-----------------------------
INT 2F U - WANG_ER.COM - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    ES = segment of resident code
Program: WANG_ER is a TSR from Compaq which permits Compaq systems equipped
	  with 3-mode floppy drives to read Wang document diskettes
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	The installation check is completed by comparing the resident code
	  with the copy in the transient program
--------i-2FC000-----------------------------
INT 2F O - ASPIHOOK.SYS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if multiplex number in use
	    ES:DI -> ASCIZ signature "ASPIHOOK" if ASPIHOOK.SYS installed
Program: ASPIHOOK is a device driver for monitoring SCSI activity through an
	  ASPI host manager; it is part of the Personal Measure system
	  activity monitor from Spirit of Performance, Inc.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"PMEASURE"
--------i-2FC000-----------------------------
INT 2F - PMEASURE.EXE - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if multiplex number in use
	    ES:DI -> ASCIZ signature "PMEASURE.EXE" if PMEASURE.EXE installed
Program: PMEASURE.EXE is a TSR for monitoring system hardware activity which
	  is part of the Personal Measure system activity monitor from Spirit
	  of Performance, Inc.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	If a Personal Measure Hook Module, such as ASPIHOOK.SYS, is already
	  installed, PMEASURE.EXE uses the next highest free multiplex number.
SeeAlso: AX=C000h"ASPIHOOK",AX=C000h"PERSONAL MEASURE"
--------i-2FC000-----------------------------
INT 2F - PERSONAL MEASURE - HOOK MODULE INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	ES:DI -> signature string "PMEASUREHOOK"
	AX = C000 if not installed, per mux id conventions
	DH = major release number (binary)
	DL = minor release number (binary)
Program: The Personal Measure system activity monitor from Spirit of
	  Performance, Inc. uses an extensible series of modules to hook
	  into various operating system interfaces and monitor system calls.
	  Current hook modules are ASPIHOOK.SYS for ASPI device activity
	  and CDRHOOK.SYS for non-ASPI CD-ROM activity.	 All hook modules
	  share the same mux id.
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"PMEASURE.EXE",AX=C001h"PERSONAL MEASURE"
--------c-2FC000-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    SI = signature value 20D6h
	    DI = signature value 8761h
	    ES:BX -> configuration table (see #03029)
	    CX = ??? (0300h)
	    DX = ??? (0020h)
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=0100h/SI=20D6h,AX=C001h"PCACHE"

Format of PrintCache configuration table:
Offset	Size	Description	(Table 03029)
 00h 26 BYTEs	ASCIZ signature string "TORQ Configuration Table: "
 1Ah  2 BYTEs	???
 1Ch	DWORD	-> data table (see #03030)
 20h  4 BYTEs	ASCIZ version string ("3.1" for v3.1)
 24h  5 BYTEs	???
 29h 12 BYTEs	ASCIZ version date string ("Aug 31 1993" for v3.1)
 35h	WORD	buffered port type (01h = LPT, 02h = COM)
 37h	WORD	buffered port BIOS port number
 39h  5 BYTEs	ASCIZ buffered port name ("LPTn" or "COMn")
 3Eh	WORD	physical port type (01h = LPT, 02h = COM)
 40h	WORD	physical port BIOS port number
 42h  5 BYTEs	ASCIZ physical port name ("LPTn" or "COMn")
 47h	BYTE	port driver IRQ
 48h 21 BYTEs	???
 5Dh	WORD	buffer size in K
 5Fh 27 BYTEs	???
 7Ah	BYTE	popup hotkey shift states (see #00582 at INT 16/AH=02h)
 7Bh	BYTE	popup hotkey scan code (see #00006 at INT 09"IRQ1")
 7Ch  4 BYTEs	???
 80h 20 BYTEs	ASCIZ printer type name
	???

Format of PrintCache data table:
Offset	Size	Description	(Table 03030)
 00h  2 BYTEs	???
 02h	DWORD	-> ??? entry point
	???
--------U-2FC000-----------------------------
INT 2F - Frank Kintrup TSR Utilities - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    BX = program ID (see #03031)
	    CX = 464Bh (signature "FK")
	    DX = revision number (DH = major, DL = minor)
	    ES = resident segment of TSR
Range:	AH=C0h to AH=FFh, selected by searching for a free multiplex number
SeeAlso: AX=C001h"Kintrup",AX=C002h"Kintrup"

(Table 03031)
Values for Frank Kintrup TSR program ID:
 4153h	"AS"	ASCII.COM	ASCII table with paste function
 434Ch	"CL"	CLOCK.COM	clock with date/time display and alarm
 5043h	"PC"	PCALC.COM	programmer's calculator with paste function
 5343h	"SC"	SCRSAVE.COM	screen saver with mouse support and hotkey
 5544h	"UD"	UNDEL.COM	undelete program like SMARTCAN or DPROTECT
--------K-2FC000-----------------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if possibly installed
Range:	AH=C0h to AH=FFh, selected by scanning for signature with AL=AEh
SeeAlso: AX=C001h"HP 100LX",AX=C0AEh"HP 100LX",AX=C0AFh"HP 100LX"
--------V-2FC000-----------------------------
INT 2F - DIMWIT - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if installed
	    ES:DI -> signature string "DIMDOS" or "DIMWIN"
Program: DIMWIT is a freeware Windows-aware screen blanker by Larry Board
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"AD-DOS",AX=C001h"DIMWIT"
Index:	screen saver;DIMWIT
--------F-2FC000BX444B-----------------------
INT 2F - METZ XpressFax Hardware TSR (CLASS2) - INSTALLATION CHECK
	AX = C000h
	BX = 444Bh ('DK')
	CX = 4A4Eh ('AN')
Return: AL = status
	    00h not installed, OK to install
	    FFh installed
		BX = 646Bh ('dk')
		CX = 6A6Eh ('an')
Range:	AH=C0h to AH=FFh, selected automatically
SeeAlso: AH=C0h"METZ"
--------V-2FC000-----------------------------
INT 2F U - TSENGP.COM - INSTALLATION CHECK
	AX = C000h
Return: AL = status
	    00h not installed, OK to install
	    FFh installed
		DS = segment of resident code
Program: TSENGP.COM is a TSR supplied by Compaq to fix an incompatibility
	  between some applications and Tseng ET4000-based video adapters
Range:	AH=C0h to AH=FFh, selected automatically
Note:	the installation check is completed by comparing the first eleven
	  bytes at DS:005Fh against the TSR's code (80h FCh 06h 74h 0Ah
	  80h FCh 07h 74h 05h EAh)
--------N-2FC000-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - INSTALLATION CHECK
	AX = C000h
Return: AL = FFh if one of the components is installed
	CX:BX -> signature within LLRA component:
	    "TSI_LapLinkCore" for LLRA1.EXE
	    "TSI_Blackbird"   for LLRA2.EXE
	    "TSI_Redirector"  for LLRA3.EXE
	    "TSI_Compression" for LLRA4.EXE
	DL = major version number
	DH = minor version number
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	LapLink components are installed in the order listed above, but not
	  necessarily all four; each gets its own multiplex number (default
	  C0h-C3h)
SeeAlso: AX=C002h"LapLink",AX=C205h"LapLink",AX=C2F0h"LapLink"
SeeAlso: AX=C2F1h"LapLink",AX=C301h"LapLink",AX=C3F0h"LapLink"
SeeAlso: AX=C3F1h"LapLink"
--------M-2FC001-----------------------------
INT 2F - QMR - REQUEST HARDWARE RESET
	AX = C001h
Return: ES = QMR code segment
	AL destroyed
Desc:	this function is used to force a full mouse reset when QMR is installed
SeeAlso: AX=C000h"QMR",AX=C002h"QMR"
--------V-2FC001-----------------------------
INT 2F - DIMWIT - GET CONFIGURATION DATA
	AX = C001h
Return: ES:DI -> TSR configuration data (see #03032)
Program: DIMWIT is a freeware Windows-aware screen blanker by Larry Board
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"DIMWIT",AX=C001h"AD-DOS"
Index:	screen saver;DIMWIT

Format of DIMWIT TSR configuration data:
Offset	Size	Description	(Table 03032)
 00h	WORD	blanking delay in clock ticks
 02h	BYTE	instant-blanking hotkey scan code (see #00006)
		Ctrl and Alt must also be pressed
--------V-2FC001ES0000-----------------------
INT 2F - AD-DOS - GET RESIDENT CODE SEGMENT
	AX = C001h
	ES = 0000h
Return: AL = 00h if successful
	    ES = AD-DOS TSR Code Segment
SeeAlso: AX=C000h"AD-DOS",AX=C001h"DIMWIT"
Index:	screen saver;AD-DOS
--------c-2FC001-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ENTRY POINTS
	AX = C001h
Return: AL = FFh if installed
	    ES:BX -> ???
	    ES:DX -> ???
	    ES:SI -> ???
	    ES:DI -> ??? (equivalent to AX=C002h)
SeeAlso: AX=C000h"PCACHE",AX=C002h"PCACHE"
--------U-2FC001-----------------------------
INT 2F - Frank Kintrup TSR Utilities - CLOCK - DISABLE DISPLAY UPDATE
	AX = C001h
Range:	AH=C0h to AH=FFh, selected by searching for a free multiplex number
SeeAlso: AX=C000h"Kintrup",AX=C002h"Kintrup"
--------K-2FC001CX03FB-----------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INTERNAL - UNINSTALL
	AX = C001h
	CX = 03FBh return address to continue uninstall if possible
Return: program uninstalled
Range:	AH=C0h to AH=FFh, selected by scanning for signature with AL=AEh
SeeAlso: AX=C000h"HP 100LX",AX=C0AEh"HP 100LX",AX=C0AFh"HP 100LX"
--------i-2FC001-----------------------------
INT 2F - PERSONAL MEASURE - PASS PARAMETERS TO HOOK MODULE(S)
	AX = C001h
	DX = segment of PMEASURE.EXE or 0000h
	BX = offset in PMEASURE.EXE or 0000h
	CX = offset in PMEASURE.EXE or 0000h
Return: None
Program: PMEASURE.EXE is a TSR for monitoring system hardware activity which
	  is part of the Personal Measure system activity monitor from Spirit
	  of Performance, Inc.	PMEASURE uses this call to inform its hook
	  modules whether or not it is running and to pass information about
	  shared data and procedures.
Warning: This information documents a function that is private to Personal
	  Measure and is provided as information only.	It should NOT be called
	  by any software other than Personal Measure.
SeeAlso: AX=C000h"PERSONAL MEASURE"
--------V-2FC002-----------------------------
INT 2F - AD-DOS - CHECK FOR NEW INPUT
	AX = C002h
Return: AL = 00h if successful
	    BX = status
		0000h no input since last check
		0001h new input available
Note:	this call also resets the new-input flag
SeeAlso: AX=C000h"AD-DOS",AX=C004h
Index:	screen saver;AD-DOS
--------M-2FC002-----------------------------
INT 2F - QMR - DISABLE QMR
	AX = C002h
Return: ES = QMR code segment
	AL destroyed
Desc:	this call temporarily disables QMR
SeeAlso: AX=C000h"QMR",AX=C003h"QMR"
--------c-2FC002-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET BUFFER SIZE
	AX = C002h
Return: AX = ??? in K
	BX = size of print buffer in K
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
SeeAlso: AX=C000h"PCACHE"
--------U-2FC002-----------------------------
INT 2F - Frank Kintrup TSR Utilities - CLOCK - ENABLE DISPLAY UPDATE
	AX = C002h
Range:	AH=C0h to AH=FFh, selected by searching for a free multiplex number
SeeAlso: AX=C000h"Kintrup",AX=C002h"Kintrup"
--------N-2FC002-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Core - ???
	AX = C002h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C2F0h"LapLink"
SeeAlso: AX=C2F1h"LapLink",AX=C301h"LapLink"
--------V-2FC003-----------------------------
INT 2F - AD-DOS - SET MINUTES TO WAIT
	AX = C003h
	BX = minutes to wait before blanking screen
Return: AL = 00h if successful
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	this call also resets the delay timer
SeeAlso: AX=C000h"AD-DOS",AX=C004h
Index:	screen saver;AD-DOS
--------M-2FC003-----------------------------
INT 2F - QMR - ENABLE QMR
	AX = C003h
Return: ES = QMR code segment
	AL destroyed
Desc:	this call enables QMR after it has been disabled
SeeAlso: AX=C000h"QMR",AX=C002h"QMR"
--------c-2FC003-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ??? FLAG
	AX = C003h
Return: BX destroyed
SeeAlso: AX=C004h"PCACHE"
--------V-2FC004-----------------------------
INT 2F - AD-DOS - GET MINUTES TO WAIT
	AX = C004h
Return: AL = 00h if successful
	    BX = minutes to wait before blanking screen
SeeAlso: AX=C000h"AD-DOS",AX=C003h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC004-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - CLEAR ??? FLAG
	AX = C004h
Return: BX destroyed
SeeAlso: AX=C003h"PCACHE"
--------V-2FC005-----------------------------
INT 2F - AD-DOS - SET BLANKER STATUS
	AX = C005h
	BX = new state (0000h inactive, 0001h active) (default 0001h)
Return: AL = 00h if successful
SeeAlso: AX=C006h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC005-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C005h
	???
Return: BX destroyed
	???
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------V-2FC006-----------------------------
INT 2F - AD-DOS - GET BLANKER STATUS
	AX = C006h
Return: AL = 00h if successful
	    BX = current state of screen blanker (0000h inactive, 0001h active)
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"AD-DOS",AX=C005h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC006-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C006h
	???
Return: BX destroyed
	???
Note:	this function appears to be identical to AX=C007h
SeeAlso: AX=C000h"PCACHE",AX=C007h"PCACHE"
--------V-2FC007-----------------------------
INT 2F - AD-DOS - SET HOT KEY
	AX = C007h
	BX = hot key
	CL = hot key shift status
Return: AL = 00h if successful
SeeAlso: AX=C008h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC007-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C007h
	???
Return: BX destroyed
	???
Note:	this function appears to be identical to AX=C006h
SeeAlso: AX=C000h"PCACHE",AX=C006h"PCACHE"
--------V-2FC008-----------------------------
INT 2F - AD-DOS - GET CURRENT HOT KEY
	AX = C008h
Return: AX = status
	    0000h successful
		BX = Hot Key
		CL = Hot Key Shift Status
	    0008h otherwise
SeeAlso: AX=C000h"AD-DOS",AX=C007h"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC008-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - CLEAR ??? FLAG
	AX = C008h
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C009h"PCACHE"
--------V-2FC009-----------------------------
INT 2F - AD-DOS - UNBLANK MONITOR
	AX = C009h
Return: AL = 00h if successful
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	this function works by simulating keyboard activity
Index:	screen saver;AD-DOS
--------c-2FC009-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ??? FLAG
	AX = C009h
Return: BX destroyed
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE",AX=C008h"PCACHE"
--------V-2FC00A-----------------------------
INT 2F - AD-DOS - ???
	AX = C00Ah
Return: AX = status
	    0000h successful
		BH = ??
		BL = ??
	    000Ah failed
Index:	screen saver;AD-DOS
--------c-2FC00A-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C00Ah
	???
Return: AH = bit flags
	    bit 5: ???
	AL = bit flags
	    bit 4: ???
	    bit 3: ???
	BX destroyed
	???
SeeAlso: AX=C000h"PCACHE"
--------V-2FC00B-----------------------------
INT 2F - AD-DOS - ???
	AX = C00Bh
Return: AX = status
	    0000h successful
	    000Bh failed
Index:	screen saver;AD-DOS
--------c-2FC00B-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - NOP
	AX = C00Bh
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE"
--------V-2FC00C-----------------------------
INT 2F - AD-DOS - SET ??? INTERNAL FLAG TO 01h
	AX = C00Ch
Return: AX = status
	    0000h successful
	    000Ch failed
Program: AD-DOS is the DOS version of the After Dark screen blanker for
	  MS Windows
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Index:	screen saver;AD-DOS
--------c-2FC00C-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C00Ch
Return: AX = ??? (0000h)
	BX = ??? (0000h)
	CX = ??? (0100h)
	DL = ???
	DH = ???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC00D-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ???
	AX = C00Dh
	DL = ???
Return: BX destroyed
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------V-2FC00E-----------------------------
INT 2F - AD-DOS - SET PASSWORD STATUS
	AX = C00Eh
	BX = new state (0000h disabled, 0001h enabled)
Return: ???
SeeAlso: AX=C000h"AD-DOS",AX=C00Fh"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC00E-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - INSTALL ???
	AX = C00Eh
	ES:DX -> ???
Return: BX destroyed
Note:	ES:DX is stored internally if the variable is currently 0000h:0000h,
	  but ignored if already set; a counter is incremented
SeeAlso: AX=C000h"PCACHE",AX=C00Fh"PCACHE"
--------V-2FC00F-----------------------------
INT 2F - AD-DOS - GET PASSWORD STATUS
	AX = C00Fh
Return: BX = current state (0000h disabled, 0001h enabled)
SeeAlso: AX=C00Eh"AD-DOS"
Index:	screen saver;AD-DOS
--------c-2FC00F-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - REMOVE ???
	AX = C00Fh
Return: BX destroyed
Note:	this function decrements the counter used by AX=C00Eh, and clears the
	  internal pointer variable to 0000h:0000h when it reaches zero
SeeAlso: AX=C000h"PCACHE",AX=C00Eh"PCACHE"
--------c-2FC010-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C010h
	CX = index of ??? table (00h-02h, others treated as 00h)
	SI = offset into data table
Return: AL = byte at specified offset into table
	BX destroyed
SeeAlso: AX=C000h"PCACHE"
--------c-2FC011-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C011h
Return: AX = ??? (0007h)
	BX = ??? (0001h)
	CH = ???
	CL = ???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC012-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - GET ???
	AX = C012h
Return: AX = ???
	BX = ???
	CX = ???
	DX = ???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC013-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C013h
	???
Return: BX destroyed
	???
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------c-2FC014-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C014h
	???
Return: BX destroyed
	???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC015-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C015h
	???
Return: BX destroyed
	???
SeeAlso: AX=C000h"PCACHE"
--------c-2FC016-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - INCREMENT ???
	AX = C016h
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C017h"PCACHE"
--------c-2FC017-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - DECREMENT ???
	AX = C017h
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C016h"PCACH"
--------c-2FC018-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C018h
	???
Return: BX destroyed
	???
Note:	the first instruction of this function is an indirect jump which points
	  at a RET by default
SeeAlso: AX=C000h"PCACHE",AX=C019h"PCACHE"
--------c-2FC019-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C019h
	???
Return: BX destroyed
	???
Note:	the first instruction of this function is an indirect jump which points
	  at a RET by default
SeeAlso: AX=C000h"PCACHE",AX=C018h"PCACHE"
--------c-2FC01A-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - CLEAR ??? FLAG
	AX = C01Ah
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C01Bh"PCACHE"
--------c-2FC01B-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - SET ??? FLAG
	AX = C01Bh
Return: BX destroyed
SeeAlso: AX=C000h"PCACHE",AX=C01Ah"PCACHE"
--------c-2FC01C-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - ???
	AX = C01Ch
	???
Return: AX = ???
	BX destroyed
SeeAlso: AX=C000h"PCACHE"
--------c-2FC01D-----------------------------
INT 2F U - PrintCache v3.1 PCACHE.EXE - NOP
	AX = C01Dh to C01Fh
Return: BX destroyed
Program: PCACHE is the resident print spooler portion of PrintCache by
	  LaserTools; it may use either memory or disk space to spool output
Range:	AH=C0h to AH=FFh, selected by commandline switch
SeeAlso: AX=C000h"PCACHE"
--------V-2FC020-----------------------------
INT 2F - AD-DOS - GET AND RESET VxD API STATUS
	AX = C020h
Return: AL = 00h if successful
	    BX = VxD API Status
		0000h no error
		0001h error
		0100h neither Windows 3.X enhanced mode nor Windows/386 2.x
			  is running
		0200h VM API entry point not found (VxD not installed)
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
Note:	this call resets the VxD API Status to zero
SeeAlso: AX=1602h,AX=1607h"CALL OUT API"
Index:	screen saver;AD-DOS
--------V-2FC04E-----------------------------
INT 2F - Explosiv v2.00+ - NON-TSR EXECUTING CHECK
	AX = C04Eh
Return: AL = 4Fh if Explosiv is running but not memory-resident
Program: Explosiv is a shareware animated screen blanker for DOS and Windows 3
	  by H&G Software (Reidar Gresseth and Chris Hook)
Range:	AH=C0h to AH=C9h, selected by configuration
SeeAlso: AX=C050h
Index:	screen saver;Explosiv
--------V-2FC050-----------------------------
INT 2F - Explosiv v2.00+ - INSTALLATION CHECK
	AX = C050h
Return: AL = 51h if installed
	---v3.0+ ---
	    BX = interval in clock ticks
	    CH = animation display color (00h mono, 01h tinge, 02h color)
	    CL = animation delay factor
	    DH = animation parameters
	    DL = INT 10 checking (00h on, 01h off)
	    SI = number of bytes available for animation code
	    DI = display type (00h VGA, 01h EGA, 02h CGA, 03h HGC, 04h MDA)
Program: Explosiv is a shareware animated screen blanker for DOS and Windows 3
	  by H&G Software (Reidar Gresseth and Chris Hook)
Range:	AH=C0h to AH=C9h, selected by configuration
SeeAlso: AH=93h,AX=C000h"AD-DOS",AX=C04Eh,AX=C052h,AX=C054h"v3"
SeeAlso: INT 14/AX=AA01h
Index:	screen saver;Explosiv
--------V-2FC052-----------------------------
INT 2F - Explosiv v2.00+ - UNINSTALL
	AX = C052h
	DX:BX = address to return to on successful uninstall
Return: at specified address if successful
	AL = 53h on error
Note:	specified return address must have the segment of the caller's PSP
SeeAlso: AX=C050h
Index:	screen saver;Explosiv
--------V-2FC054-----------------------------
INT 2F - Explosiv v2.x - GET ANIMATION DELAY FACTOR
	AX = C054h
Return: AL = delay factor
SeeAlso: AX=C057h
Index:	screen saver;Explosiv
--------V-2FC054-----------------------------
INT 2F - Explosiv v3.0+ - UPDATE PARAMETERS
	AX = C054h
	BX = new interval in clock ticks
	CH = animation display color (00h mono, 01h tinge, 02h color)
	CL = animation delay factor
	DH = animation parameters
	DL = INT 10 checking (00h on, 01h off)
SeeAlso: AX=C050h
Index:	screen saver;Explosiv
--------V-2FC055-----------------------------
INT 2F - Explosiv v2.x - SET BLANKING INTERVAL
	AX = C055h
	BX = new interval in clock ticks
Index:	screen saver;Explosiv
--------V-2FC056-----------------------------
INT 2F - Explosiv v2.x - SET ANIMATION DISPLAY TYPE
	AX = C056h
	BL = animated display type (00h mono, 01h color)
SeeAlso: AX=C058h"v2.x"
Index:	screen saver;Explosiv
--------V-2FC056-----------------------------
INT 2F - Explosiv v3.0+ - ENABLE/DISABLE EXPLOSIV
	AX = C056h
	BX = new state
	    0000h disabled
	    0100h enabled
	    0101h enabled, but never blank
	    0102h enabled, always blank
--------V-2FC057-----------------------------
INT 2F - Explosiv v2.x - SET ANIMATION DELAY FACTOR
	AX = C057h
	BL = delay factor
SeeAlso: AX=C054h"v2.x"
Index:	screen saver;Explosiv
--------V-2FC058-----------------------------
INT 2F - Explosiv v2.x - SET ANIMATION PARAMETER
	AX = C058h
	BL = animation parameter
Note:	the animation parameter has different interpretations for each display
SeeAlso: AX=C056h"v2.x"
Index:	screen saver;Explosiv
--------V-2FC058-----------------------------
INT 2F - Explosiv v3.0+ - LOAD NEW ANIMATION DISPLAY CODE
	AX = C058h
	BX = file handle for file containing display code
	CX = number of bytes to load
	DX = offset at which animation code should be loaded
Return: AL = status (see #03033)
Note:	if AL=00h-03h on return, the file will be closed
Index:	screen saver;Explosiv

(Table 03033)
Values for Explosiv function status:
 00h	successful
 01h	code too large to available space
 02h	no data read, load aborted
 03h	incomplete load, default blanking display loaded instead
 58h	unexpected offset in DX
--------V-2FC059-----------------------------
INT 2F - Explosiv v2.x - DISABLE EXPLOSIV
	AX = C059h
Note:	clears flag set by AX=C05Ah
SeeAlso: AX=C05Ah
Index:	screen saver;Explosiv
--------V-2FC05A-----------------------------
INT 2F u - Explosiv v2.x - ENABLE EXPLOSIV
	AX = C05Ah
	BL = ???
Note:	sets flag cleared by AX=C059h then stores BL
SeeAlso: AX=C059h,AX=C05Bh
Index:	screen saver;Explosiv
--------V-2FC05B-----------------------------
INT 2F - Explosiv v2.x - CHANGE ANIMATION DISPLAY
	AX = C05Bh
	BL = animation display
Note:	this function fails silently if the requested display is not in memory
SeeAlso: AX=C05Ah,AX=C05Ch
Index:	screen saver;Explosiv
--------V-2FC05C-----------------------------
INT 2F - Explosiv v2.x - SET INT 10 CHECKING
	AX = C05Ch
	BL = new state of INT 10 checking (00h enabled, 01h disabled)
SeeAlso: AX=C05Bh
Index:	screen saver;Explosiv
--------v-2FC080-----------------------------
INT 2F U - AMI IAM.SYS - INSTALL ??? CALLBACK
	AX = C080h
	CX:DX -> ??? callback
	DI = segment of ??? buffer (first WORD copied into IAM.SYS)
Program: IAM.SYS is the Illegal Activity Monitor portion of American
	  Megatrends, Inc.'s PC-Defender anti-virus product
Note:	also sets ??? flag
SeeAlso: AX=C081h

Format of IAM.SYS buffer:
Offset	Size	Description	(Table 03034)
 00h	BYTE	???
 01h	BYTE	???
 02h  N BYTEs	??? (ASCIZ strings)
--------v-2FC081-----------------------------
INT 2F U - AMI IAM.SYS - CLEAR ???
	AX = C081h
Desc:	clears the ??? flag that AX=C080h sets
SeeAlso: AX=C080h
--------K-2FC0AE-----------------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INSTALLATION CHECK
	AX = C0AEh
Return: AX = 4453h if installed
	CX = 5259h if installed
Range:	AH=C0h to AH=FFh, selected by scanning for signature
SeeAlso: AX=C000h"HP 100LX",AX=C001h"HP 100LX",AX=C0AFh"HP 100LX"
--------K-2FC0AF-----------------------------
INT 2F U - HP 100LX/200LX - PUSHKEYS - INTERNAL - GET BUFFER ADDRESS
	AX = C0AFh
Return: ES:DI -> buffer (behind code)
Range:	AH=C0h to AH=FFh, selected by scanning for signature with AL=AEh
SeeAlso: AX=C000h"HP 100LX",AX=C001h"HP 100LX",AX=C0AEh"HP 100LX"
--------N-2FC100-----------------------------
INT 2F U - Personal NetWare - STPIPX v1.00 - INSTALLATION CHECK
	AX = C100h
Return: AL = FFh if installed
	    ES:SI -> signature string "STP-IPX$"
	    BX = version??? (0001h for v1.00)
	    DI corrupted
Note:	AH=C1h is the default value; STPIPX probably scans a range of
	  multiplex numbers to find a free one, as LSL does
SeeAlso: AX=C000h"LSL",AX=C101h
--------N-2FC101-----------------------------
INT 2F U - Personal NetWare - STPIPX v1.00 - UNINSTALL
	AX = C101h
Return: AL = status???
	BX corrupted
SeeAlso: AX=C101h
--------N-2FC205-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Redirector - ???
	AX = C205h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C2F0h"LapLink"
SeeAlso: AX=C2F1h"LapLink",AX=C301h"LapLink"
--------N-2FC2F0-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Redirector - ???
	AX = C2F0h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F1h"LapLink",AX=C301h"LapLink"
--------N-2FC2F1-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Redirector - ???
	AX = C2F1h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F0h"LapLink",AX=C301h"LapLink"
--------d-2FC300-----------------------------
INT 2F - SETWPR.COM - INSTALLATION CHECK
	AX = C300h
Return: AL = FFh if installed
Program: SETWPR is a hard-disk write-protection TSR by Jaroslaw Rafa
SeeAlso: AX=C302h"SETWPR"
--------k-2FC300DX0000-----------------------
INT 2F U - SpaceManager - INSTALLATION CHECK
	AX = C300h
	DX = 0000h
Return: AL = FFh if any SpaceManager programs installed
	    BX = 6F73h
	    CX = 6F68h
Program: SpaceManager is an enhancement for MS-DOS DoubleSpace by Vertisoft
	  Systems, Inc.
Range:	AH=C3h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C300h/BX=4F53h
--------k-2FC300BX4F53-----------------------
INT 2F U - SpaceManager - INSTALLATION VERIFICATION
	AX = C300h
	BX = 4F53h ('OS')
	CX = 4F48h ('OH')
	DX = program identifier (see #03035) or 0666h for any SpaceManager prog
Return: AL = FFh if BX/CX as specified and specified program installed
	    BX = 6F73h ('os')
	    CX = 6F68h ('oh')
Range:	AH=C3h to AH=FFh, selected by scanning for first free multiplex number
Note:	this call is chained if BX,CX, or DX are not as specified above
SeeAlso: AX=C300h/DX=0000h

(Table 03035)
Values for SpaceManager program identifier:
 9000h	SMOUNT (SuperMount)
 9001h	SELECTC (SelectCompress)
 9002h	SUPERX (SuperExchange)
 9003h	FORTUNE (FortuneTeller)
--------k-2FC301-----------------------------
INT 2F U - SpaceManager - ???
	AX = C301h
	DX = program identifier (9000h,9001h,9003h) (see #03035)
	???
Return: ???
--------N-2FC301-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Compression - ???
	AX = C301h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F0h"LapLink",AX=C3F0h"LapLink",AX=C3F1h"LapLink"
--------k-2FC302-----------------------------
INT 2F U - SpaceManager - ENABLE PROGRAM
	AX = C302h
	DX = program identifier (9000h,9001h,9003h) (see #03035)
Return: AX destroyed
SeeAlso: AX=C303h,AX=C306h
--------d-2FC302-----------------------------
INT 2F - SETWPR.COM - SET WRITE-PROTECTION STATE
	AX = C302h
	BL = new state
	    00h disk may be written
	    01h disk write-protected
Return: AL = FFh if installed
Program: SETWPR is a hard-disk write-protection TSR by Jaroslaw Rafa
SeeAlso: AX=C300h"SETWPR"
--------k-2FC303-----------------------------
INT 2F U - SpaceManager - DISABLE PROGRAM
	AX = C303h
	DX = program identifier (9000h,9001h,9003h) (see #03035)
Return: AX destroyed
SeeAlso: AX=C302h,AX=C306h
--------k-2FC304-----------------------------
INT 2F U - SpaceManager - GET PER-DRIVE ENABLEMENT TABLE
	AX = C304h
	DX = program identifier (9000h,9001h,9003h) (see #03035)
Return: ES:BX -> 26-byte drive table (00h disabled for drive, 01h enabled)
	AX destroyed
--------k-2FC305DX9003-----------------------
INT 2F U - SpaceManager - FORTUNE.EXE - NOP
	AX = C305h
	DX = 9003h
Return: AX destroyed
--------k-2FC305-----------------------------
INT 2F U - SpaceManager - ???
	AX = C305h
	DX = program identifier (9000h,9001h) (see #03035)
	???
Return: ???
--------k-2FC306-----------------------------
INT 2F U - SpaceManager - CHECK WHETHER PROGRAM ENABLED
	AX = C306h
	DX = program identifier (9000h,9001h,9003h) (see #03035)
Return: AL = current state (00h disabled, FAh enabled)
	AH destroyed
SeeAlso: AX=C302h,AX=C303h
--------k-2FC307DX9001-----------------------
INT 2F U - SpaceManager - SELECTC - ???
	AX = C307h
	DX = 9001h
	BX = ???
	CX = ???
	???
Return: ???
--------k-2FC308DX9001-----------------------
INT 2F U - SpaceManager - SELECTC - ???
	AX = C308h
	DX = 9001h
	???
Return: ???
--------N-2FC3F0-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Compression - ???
	AX = C3F0h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F0h"LapLink",AX=C301h"LapLink",AX=C3F1h"LapLink"
--------N-2FC3F1-----------------------------
INT 2F U - LapLink RemoteAccess (LLRA) - Compression - ???
	AX = C3F1h
	details not yet available
Range:	AH=C0h to AH=FFh, selected by scanning for first free multiplex number
SeeAlso: AX=C000h"LapLink",AX=C002h"LapLink",AX=C205h"LapLink"
SeeAlso: AX=C2F0h"LapLink",AX=C301h"LapLink",AX=C3F0h"LapLink"
--------N-2FC500-----------------------------
INT 2F - PC-DOS Econet v1.05 - INSTALLATION CHECK
	AX = C500h
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, can't install
	    FFh installed
Note:	the interrupt-enable state will be preserved, but interrupts may be
	  enabled during processing of this function
SeeAlso: AX=C501h,AX=C508h
--------N-2FC501-----------------------------
INT 2F - PC-DOS Econet v1.05 - RESET BOARD AND DRIVER
	AX = C501h
Return:	AX = return code (see #03037)
Desc:	reset both the network board and the driver software
Notes:	use this function with caution, as it will affect any other resident
	  software using the network board
	the interrupt-enable state will be preserved, but interrupts may be
	  enabled during processing of this function
SeeAlso: AX=C500h
--------N-2FC502-----------------------------
INT 2F - PC-DOS Econet v1.05 - PERFORM NETWORK OPERATION
	AX = C502h
	DS:DX -> control block (see #03036)
Return: AX = return code (see #03037) (same as returned in control block)
Note:	the interrupt-enable state will be preserved, but interrupts may be
	  enabled during processing of this function
SeeAlso: AX=C500h

Format of Econet control block:
Offset	Size	Description	(Table 03036)
 00h	DWORD	-> command block (see #03038)
 04h	WORD	length of transmit data block
 06h	DWORD	-> transmit data block
 0Ah	WORD	length of reply block (set to 0000h prior to call)
 0Ch	DWORD	-> reply block
 10h	WORD	return code (set to 0000h prior to call) (see #03037)
 12h	DWORD	reserved for Econet use

(Table 03037)
Values for Econet return code:
 0000h	successful
 0001h	bad command in command block
 0002h	no handles left
 0003h	bad handle
 0004h	bad argument in command
 0005h	buffer too small
 0006h	kill condition failed
 0007h	control block in use
 007Fh	command aborted
 01xxh	retryable board error XXh
 02xxh	fatal board error XXh
 0300h	invalid subfunction number in AL
 0301h	timeout
 03xxh	other driver errors
SeeAlso: #03036

Format of Econet command block:
Offset	Size	Description	(Table 03038)
 00h	BYTE	command code (see #03039)
---command 00h---
 01h	BYTE	direction (00h = read initialization data, 01h = set init data)
 02h	WORD	"TxCB" transmit control block size
 04h	WORD	"RxCB" receive control block size
		Notes:	TxCB and RxCB are always the same size in v1.05,
			  permitting any CB to be used for either receive
			  or transmit
			this command should not be used by applications to
			  set the buffer sizes
 06h  6 BYTEs	padding (0)
---command 01h---
 01h	BYTE	port number (00h = receive on all ports)
		if the RxCB is opened for RPC, the port number indicates the
		  allowable RPC (see #03040)
 02h	WORD	station number (FEFFh = broadcast)
 04h	BYTE	RPC flags
		bit 7: CB is open for RPCs only
		bit 6: restrict to RPC number given in next field
 05h	WORD	RPC number
 07h	BYTE	timeout in 1/2-second units (00h = never)
		if a timeout occurs, the RxCB can still receive data, and may
		  generate another event after the timeout unless it is
		  explicitly killed
 08h  4 BYTEs	padding (0)
---command 02h---
 01h	BYTE	control byte
 02h	BYTE	port number
 03h	WORD	station number
 05h	BYTE	number of retries
 06h	WORD	length of data to be sent (bits 14-0), 0000h allowed
		if bit 15 is set, no data will be transferred, but this field
		  will be updated (needed for peeking)
 08h	DWORD	-> destination address on remote machine
---command 03h---
 01h	BYTE	Control Block Handle
		FEh first filled-in RxCB
		FFh first TxCB which has been sent
 02h 10 BYTEs	padding (0)
---command 04h---
 01h	BYTE	Control Block Handle
 02h	BYTE	kill condition
		00h always
		01h kill only if bit7 of control byte is clear
		81h kill only if bit7 of control byte is set
 03h  9 BYTEs	padding (0)
		Notes:	control blocks are not freed until explicitly killed
			because all TxCBs for a given destination are stored
			  on a separate subchain, it is necessary to kill all
			  failed TxCBs to a given destination before any new
			  ones are opened to that destination
---command 06h---
 01h	BYTE	Control Block Handle
 02h	WORD	starting byte within CB to read
 04h	WORD	number of bytes
		if 0000h or greater than remaining bytes in CB, return all
		  bytes from starting byte to end of CB
 06h  6 BYTEs	padding (0)
---command 07h---
 01h	BYTE	subfunction
		00h-0Fh get/set M/C type (bit N=1 indicates to set byte N)
			four data bytes
		10h get station number
		11h set station number
		12h get Tx pause in 5ms units (default 20)
		13h set Tx pause
		14h get software version numbers
		16h get event enable mask
		17h set event enable mask
		18h get number of non-volatile bytes available
		80h+2N get non-volatile byte N
		81h+2N set non-volatile byte N
 02h	var	new data
Note:	all command blocks should be padded to twelve bytes with zeros if
	  needed
SeeAlso: #03036

(Table 03039)
Values for Econet command code:
 00h	initialize
 01h	open receive
 02h	open transmit
 03h	poll
 04h	kill
 06h	read
 07h	get/set system parameters
SeeAlso: #03038

(Table 03040)
Values for Econet RPC type:
 00h	all
 81h	peek
 82h	poke
 83h	remote JSR
 84h	remote procedure call
 85h	OS procedure
 86h	Halt
 87h	Continue
SeeAlso: #03038

Format of Econet Reply Block (command 00h):
Offset	Size	Description	(Table 03041)
 00h	WORD	TxCB size (default is 0500h, the maximum Econet packet length)
 02h	WORD	RxCB size
 04h	BYTE	number of TxCBs allocated	
 05h	BYTE	number of RxCBs allocated	
SeeAlso: #03036,#03042,#03044

Format of Econet Reply Block (commands 01h,02h):
Offset	Size	Description	(Table 03042)
 00h	BYTE	control block handle
SeeAlso: #03036,#03041,#03045

Format of Econet Reply Block (command 03h):
Offset	Size	Description	(Table 03043)
 00h	BYTE	CB number (when wildcard specified for poll)
 01h	BYTE	control
		(RxCB) 00h until received, then Sent Control byte
		(TxCB) transmit status
		    bit 7: transmission pending
		    bit 6: transmission failed
		    bits 3-0: error number
 02h	BYTE	Port number
 03h	WORD	station number
 05h	WORD	length
 07h	WORD	0000h
SeeAlso: #03036,#03041,#03044

Format of Econet Reply Block (command 06h):
Offset	Size	Description	(Table 03044)
 00h  N BYTEs	data read from network
SeeAlso: #03036,#03043,#03045

Format of Econet Reply Block (command 07h):
Offset	Size	Description	(Table 03045)
 00h  N BYTEs	returned information
SeeAlso: #03036,#03044
--------N-2FC503-----------------------------
INT 2F - PC-DOS Econet v1.05 - ADD EVENT HANDLER
	AX = C503h
	DS:DX -> event handler (see #03046)
Return: AX = return code (see #03037)
Note:	the interrupt-enable state will be preserved, but interrupts may be
	  enabled during processing of this function
SeeAlso: AX=C500h,AX=C504h,AX=C505h,AX=C508h

Format of Econet event handler:
Offset	Size	Description	(Table 03046)
 00h	DWORD	-> next handler's code (at offset 8, filled in by Econet)
 04h	DWORD	-> previous event handler (filled in by Econet)
 08h	var	entry point (executable code called on event) (see #03047)

(Table 03047)
Values Econet event handler is called with:
	AL = event number
	AH = timeout flag (01h if timeout, else 00h)
Return:	all registers preserved
	if event trapped by this handler, issue RETF
	if event not trapped, jump to address stored at offset 0
SeeAlso: #03046
--------N-2FC504-----------------------------
INT 2F - PC-DOS Econet v1.05 - REMOVE EVENT HANDLER
	AX = C504h
	DS:DX -> event handler
Return: AX = return code (see #03037)
Note:	the interrupt-enable state will be preserved, but interrupts may be
	  enabled during processing of this function
SeeAlso: AX=C500h,AX=C503h,AX=C506h,AX=C508h
--------N-2FC505-----------------------------
INT 2F - PC-DOS Econet v1.05 - SET DEFAULT EVENT ACTION
	AX = C505h
	DL = new default action
	    00h disable event handling (ignore incoming events)
	    01h enable (call event handler chain)
	    02h store until enabled or disabled (default)
Return: AX = return code (see #03037)
Note:	the interrupt-enable state will be preserved, but interrupts may be
	  enabled during processing of this function
SeeAlso: AX=C500h,AX=C503h,AX=C506h,AX=C508h
--------N-2FC506-----------------------------
INT 2F - PC-DOS Econet v1.05 - SET INDIVIDUAL EVENT ACTION
	AX = C506h
	DH = event number
	DL = new default action
	    00h disable event handling (ignore incoming events)
	    01h enable (call event handler chain)
	    02h store until enabled or disabled (default)
Return: AX = return code (see #03037)
Note:	the interrupt-enable state will be preserved, but interrupts may be
	  enabled during processing of this function
SeeAlso: AX=C500h,AX=C504h,AX=C505h,AX=C507h
--------N-2FC507-----------------------------
INT 2F - PC-DOS Econet v1.05 - TEST/CLEAR EVENT STATUS
	AX = C507h
	DH = event number (FFh = first event in queue)
	DL = disposition (00h test only, 01h test and clear)
Return: AX = return code (see #03037)
	DH = event number if one is pending, 00h if none
Note:	the interrupt-enable state will be preserved, but interrupts may be
	  enabled during processing of this function
SeeAlso: AX=C500h,AX=C503h,AX=C506h,AX=C508h
--------N-2FC508-----------------------------
INT 2F - PC-DOS Econet v1.05 - ENABLE/DISABLE EVENT SCHEDULER
	AX = C508h
	DL = new state of scheduler (01h enabled, 02h disabled)
Return: AX = return code (see #03037)
	DL = previous state
Notes:	the interrupt-enable state will be preserved, but interrupts may be
	  enabled during processing of this function
	while the scheduler is disabled, all events are queued until the
	  scheduler is re-enabled
SeeAlso: AX=C500h,AX=C503h,AX=C504h,AX=C506h,AX=C507h
--------d-2FC64CBX5553-----------------------
INT 2F U - Smart Prompt - INSTALLATION CHECK
	AX = C64Ch
	BX = 5553h
Return: AX = 4CC6h if installed
	BX = 5355h if installed
Program: Smart Prompt (SMARTPMT) is a freeware TSR by Steve Gibson which
	  forces an immediate flush of SmartDrive's (and compatible caches')
	  buffers on returning to the DOS prompt
--------V-2FC700CX434C-----------------------
INT 2F u - COLAP - INSTALLATION CHECK
	AX = C700h
	CX = 434Ch  "CL"
Return: AL = FFh if installed
Program: colap.com is a freeware TSR by Eric Meyer which controls contrast
	  and brightness of color laptops by changing the VGA palette colors;
	  for Toshiba laptops there are more hotkeys for shutting off display
	  and harddisk.
--------v-2FC900BP0000-----------------------
INT 2F U - ThunderByte??? - INSTALLATION CHECK
	AX = C900h
	BP = 0000h
Return: AL = FFh if installed
	    BP >= 0014h
Note:	called by TBSCANX
SeeAlso: AX=C987h,AX=CA00h
--------v-2FC987-----------------------------
INT 2F U - ThunderByte??? - DISINFECT FILE???
	AX = C987h
	BX:DX -> filename
	BX:CX -> virus name
Return: AX = status
	    0000h successful???
Note:	called by TBSCANX
SeeAlso: AX=CA00h
--------v-2FC9FD-----------------------------
INT 2F - ThunderByte TBLOG - WRITE STRING TO LOG
	AX = C9FDh
	DS:SI -> ASCIZ string (max 110 chars)
Return: AH = 00h
	AL = last character in string
	CX = number of unused characters in string
	SI,DI destroyed
Notes:	The string can also be terminated with a '%'-character.
	This function is never called within ThunderBYTE Anti-Virus.
SeeAlso: AX=C900h
--------r-2FC9FF-----------------------------
INT 2F C - StackMan - INSTALLATION BROADCAST
	AX = C9FFh
	BL = BCD version number
	CX = number of stacks
	DX = stack size in bytes
Program: StackMan is a freeware stack manager by Franz Veldman of ESaSS B.V.
	  which functions as a replacement for the DOS STACK= command as well
	  as permitting multiple TSRs to share a pool of stack space
InstallCheck:	test for the string "STACKXXX" at offset 0Ah from the INT B4
	  handler
Note:	called by StackMan when it goes resident to inform interested TSRs that
	  its API is available
SeeAlso: INT B4"StackMan",INT B5"StackMan"
Index:	installation check;STACKMAN|broadcasts;STACKMAN installation
--------F-2FCA-------------------------------
INT 2F - FAXPLUS - FAX TSR
	AH = CAh
	???
Return: ???
Program: FAXTSR is a resident FAX send/receive module for FAXPLUS by Frans
	  Veldman
SeeAlso: AH=2Ah"Gammafax"
--------v-2FCA00BX5442-----------------------
INT 2F - TBSCANX - INSTALLATION CHECK
	AX = CA00h
	BX = 5442h ('TB')
Return: AL = state
	    00h not installed
	    FFh installed
		BX = 7462h ('tb') if BX was 5442h on entry
Program: TBSCANX is a resident virus scanning module by Frans Veldman.
Notes:	programs may perform virus checks on themselves, other program files,
	  or their data files by invoking the TBSCANX API.
	current versions of TBScanX don't actually check the value of BX
SeeAlso: AX=4653h/CX=0002h,AX=4653h/CX=0007h,AX=C900h
--------v-2FCA01-----------------------------
INT 2F - TBSCANX - GET STATUS
	AX = CA01h
Return: AH = BCD version number (v2.2+)
	    CAh for versions before 2.2
	AL = state (00h = disabled, 01h = enabled)
	CX = number of signatures which will be searched
---v2.0---
	BX = EMS handle, 0000h if not using EMS
---v2.3+---
	BX = segment of swap area, 0000h if not swapped
	DX = EMS or XMS handle (XMS handle if BX=0000h), FFFFh if not using EMS
SeeAlso: AX=CA02h
--------v-2FCA02-----------------------------
INT 2F - TBSCANX - SET STATE
	AX = CA02h
	BL = new state (00h = disabled, 01h = enabled)
SeeAlso: AX=CA01h
--------v-2FCA03-----------------------------
INT 2F - TBSCANX - SCAN BUFFER
	AX = CA03h
	CX = size of buffer
	DS:DX -> buffer containing data to scan
Return: CF clear if no virus signatures found
	    BX,ES destroyed
	CF set if signature found
	    ES:BX -> ASCIZ virus name (v2.3+)
	    DS:DX -> ASCIZ virus name (v2.0)
	AX,CX,DX destroyed (v2.3+)
	all other registers except CS:IP and SS:SP destroyed (v2.0)
SeeAlso: AX=CA04h
--------v-2FCA04-----------------------------
INT 2F - TBSCANX - SCAN FILE
	AX = CA04h
	DS:DX -> filename
Return: CF clear if no virus signatures found
	    BX,SI,DI,ES destroyed
	CF set if signature found
	    ES:BX -> ASCIZ virus name
	AX,CX,DX destroyed
Note:	this function requires at least 4K free memory
SeeAlso: AX=CA03h
--------U-2FCAFEBX0000-----------------------
INT 2F U - THELP v3.0 - INSTALLATION CHECK
	AX = CAFEh
	BX = 0000h
Return: BX = segment of resident code if installed
	    0000h if not installed
SeeAlso: AX=5453h,INT 2D"AMIS"
--------F-2FCB00-----------------------------
INT 2F - Communicating Applications Specification - INSTALLATION CHECK
	AX = CB00h
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
Note:	AH = CBh is the default identifier, but may be reconfigured
SeeAlso: AH=2Ah,AX=8000h"FaxBIOS",AX=CB0Eh,AX=CBDCh
--------F-2FCB00BX4D53-----------------------
INT 2F - METZ XpressFax CASMGR - INSTALLATION CHECK
	AX = CB00h
	BX = 4D53h ('MS')
	CX = 4949h ('II')
Return: AL = status
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
		BX = 6D73h ('ms')
		CX = 6969h ('ii')
Note:	this function is equivalent to the standard CASMGR installation check,
	  but uses the additional magic values to identify which CAS is
	  installed
SeeAlso: AH=2Ah,AX=8000h"FaxBIOS",AX=C000h/BX=444Bh,AX=CB0Eh,AX=CB16h
--------F-2FCB01-----------------------------
INT 2F - Communicating Applications Specification - SUBMIT A TASK
	AX = CB01h
	DS:DX -> ASCIZ name of task control file
Return: AX >= 0: event handle
	AX < 0: two's complement of error code (see #03048)
Note:	files needed for an event must be kept until task is complete or error
SeeAlso: AX=CB0Bh,AX=CB15h

(Table 03048)
Values for CAS error code:
  (AH = class, AL = subcode, value passed back is 2's complement)
  Class 00h	--- FAX warnings
	Subcode 00h	no error
		02h	bad scanline count
		03h	page sent with errors, could not retransmit
		04h	received data lost
		05h	invalid or missing logo file
		06h	filename does not match nonstandard format (NSF) header
		07h	file size does not match NSF header
  Class 01h	--- DOS warnings (data was sent)
	Subcode 01h	invalid function
		05h	access denied
		06h	invalid handle
		others	see #01680 at INT 21/AH=59h/BX=0000h
  Class 02h	--- fatal errors (data not sent)
	Subcode 00h	multiplex handler failed
		01h	unknown command
		02h	bad event handle
		03h	FIND NEXT attempted before FIND FIRST
		04h	no more events
		07h	invalid queue type
		08h	bad control file
		09h	communication board busy
		0Ah	invalid command parameter
		0Bh	can't uninstall resident code
		0Ch	file exists
		80h	unknown task type
		81h	bad phone number
		82h	bad .PCX file header
		83h	unexpected EOF
		84h	unexpected disconnect
		85h	too many dialing retries
		86h	no file specified for send
		87h	communication board timeout
		88h	received too many pages (>1023) of data
		89h	manual connect initiated too long ago
		8Ah	hardware command set error
		8Bh	bad NonStandard Format (NSF) header file
  Class 03h	--- fatal DOS errors
	Subcode 02h	file not found
		03h	path not found
		others	see #01680 at INT 21/AH=59h/BX=0000h
  Class 04h	--- FAX errors
	Subcode 01h	remote unit not Group 3 compatible
		02h	remote unit did not send capabilities
		03h	other FAX machine incompatible
		04h	other FAX incapable of file transfers
		05h	exceeded retrain or FAX resend limit
		06h	line noise or failure to agree on bit rate
		07h	remote disconnected after receiving data
		08h	no response from remote after sending data
		09h	remote's capabilities incompatible
		0Ah	no dial tone (v1.2+)
		0Bh	invalid response from remote unit after sending data
		0Dh	phone line dead or remote unit disconnected
		0Eh	timeout while waiting for secondary dial tone (v1.2+)
		11h	invalid command from remote after receiving data
		15h	tried to receive from incompatible hardware
		5Ch	received data overflowed input buffer
		5Dh	remote unexpectedly stopped sending data
		5Eh	other FAX machine jammed (no data sent)
		5Fh	remote took too long to send fax scan line
		63h	can't get through to remote unit
		64h	user canceled event
  Class 05h	--- application-specific (v1.2+)
  ---Intel FAXPOP.EXE
	Subcode 00h	tried to send while in graphics mode
		01h	insufficient disk space
		02h	internal buffer overflow
  Class 06h	--- CAS implementation-specific (v1.2+)
--------F-2FCB02-----------------------------
INT 2F - Communicating Applications Specification - ABORT CURRENT EVENT
	AX = CB02h
Return: AX >= 0: event handle of aborted event
	AX < 0: error code (see #03048)
Note:	termination could take up to 30 seconds
SeeAlso: AX=CB08h,AX=CB10h
--------F-2FCB05-----------------------------
INT 2F - Communicating Applications Specification - FIND FIRST QUEUE ENTRY
	AX = CB05h
	CX = status of events to find
	    0000h successful completion
	    0001h waiting to be processed
	    0002h number has been dialed
	    0003h connection established, sending
	    0004h connection established, receiving
	    0005h event aborted
	    FFFFh find any event, regardless of status
	    other negative values, match error code
	DH = direction
	    00h chronological order, earliest to latest
	    01h reverse chronological order, latest to earliest
	DL = queue to search
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
	    BX = event handle for found event
	AX < 0	   error code (see #03048)
SeeAlso: AX=CB06h,AX=CB07h
--------F-2FCB06-----------------------------
INT 2F - Communicating Applications Specification - FIND NEXT QUEUE ENTRY
	AX = CB06h
	DL = queue to search
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
	    BX = event handle for found event
	AX < 0	   error code (see #03048)
Note:	direction of search is same as preceding FIND FIRST call
SeeAlso: AX=CB05h
--------F-2FCB07-----------------------------
INT 2F - Communicating Applications Specification - OPEN FILE
	AX = CB07h
	BX = event handle from find (AL=05h,06h) or submit task (AL=01h)
	CX = receive file number (ignored for task queue and log queue)
	    0000h  open receive control file
	    N	   open Nth received data file
	DL = queue
	    00h task queue
	    01h receive queue control file or received file, as given by CX
	    02h log queue
	    03h group file in task queue (v1.2+)
	    04h group file in log queue (v1.2+)
Return: AX = 0000h successful
	    BX = DOS file handle for requested file
	AX < 0	   error code (see #03048)
Note:	the returned file handle has been opened in read-only mode and should
	  be closed with INT 21/AH=3Eh after use
SeeAlso: AX=CB01h,AX=CB05h,AX=CB14h
--------F-2FCB08-----------------------------
INT 2F - Communicating Applications Specification - DELETE FILE
	AX = CB08h
	BX = event handle
	CX = receive file number
	    0000h delete ALL received files and receive control file
	    N	  delete Nth received file
	DL = queue
	    00h delete control file in task queue and corresponding group file
		  if it exists
	    01h delete file in receive queue, as given by CX
	    02h delete control file in log queue (individual deletions not
		  recommended, to maintain integrity of log) and corresponding
		  group file if it exists
Return: AX = 0000h successful
	AX < 0	   error code (see #03048)
SeeAlso: AX=CB02h,AX=CB09h
--------F-2FCB09-----------------------------
INT 2F - Communicating Applications Specification - DELETE ALL FILES IN Q
	AX = CB09h
	DL = queue
	    00h delete all control files in task queue, including all group
		  files
	    01h delete all files in receive queue
	    02h delete all control files in log queue, including all group
		  files
Return: AX = 0000h successful
	AX < 0	   error code (see #03048)
SeeAlso: AX=CB08h
--------F-2FCB0A-----------------------------
INT 2F - Communicating Applications Specification - GET EVENT DATE
	AX = CB0Ah
	BX = event handle
	DL = queue
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
	    CX = year
	    DH = month
	    DL = day
	AX < 0	   error code (see #03048)
SeeAlso: AX=CB0Bh,AX=CB0Ch
--------F-2FCB0B-----------------------------
INT 2F - Communicating Applications Specification - SET TASK DATE
	AX = CB0Bh
	BX = event handle (task event only)
	CX = year
	DH = month
	DL = day
Return: AX = 0000h successful
	AX < 0	   error code (see #03048)
Note:	setting a task's date and time to before the current date and time
	  causes it to execute immediately
SeeAlso: AX=CB01h,AX=CB0Ah,AX=CB0Dh
--------F-2FCB0C-----------------------------
INT 2F - Communicating Applications Specification - GET EVENT TIME
	AX = CB0Ch
	BX = event handle
	DL = queue
	    00h task queue
	    01h receive queue
	    02h log queue
Return: AX = 0000h successful
	    CH = hour
	    CL = minute
	    DH = second
	    DL = 00h
	AX < 0	   error code (see #03048)
SeeAlso: AX=CB0Ah,AX=CB0Dh
--------F-2FCB0D-----------------------------
INT 2F - Communicating Applications Specification - SET TASK TIME
	AX = CB0Dh
	BX = event handle (task events only)
	CH = hour
	CL = minute
	DH = second
	DL unused
Return: AX = 0000h successful
	AX < 0	   error code (see #03048)
Note:	setting a task's date and time to before the current date and time
	  causes it to execute immediately
SeeAlso: AX=CB0Bh,AX=CB0Ch,AX=CB10h
--------F-2FCB0E-----------------------------
INT 2F - Communicating Applications Specification - GET EXTERNAL DATA BLOCK
	AX = CB0Eh
	DS:DX -> 256-byte buffer for external data block (see #03049)
Return: AX = 0000h successful
	    DS:DX buffer filled
	AX < 0	   error code (see #03048)

Format of CAS external data block:
Offset	Size	Description	(Table 03049)
 00h	BYTE	CAS major version
 01h	BYTE	CAS minor version
 02h 68 BYTEs	ASCIZ path to directory containing CAS software, ends in slash
 46h 13 BYTEs	ASCIZ name of current phonebook (in CAS directory)
 53h 13 BYTEs	ASCIZ name of current logo file (in CAS directory)
 60h 32 BYTEs	ASCIZ default sender name
 80h 21 BYTEs	ASCIZ CCITT identification of fax device
 95h 107 BYTEs	reserved
--------F-2FCB0F-----------------------------
INT 2F - Communicating Applications Specification - GET/SET AUTORECEIVE
	AX = CB0Fh
	DL = subfunction
	    00h get current autoreceive state
	    01h set autoreceive state
		DH = number of rings before answer, 00h = never
Return: AX = 0000h autoreceive disabled
	AX = N	   number of rings before answer
	AX < 0	   error code (see #03048)
--------F-2FCB10-----------------------------
INT 2F - Communicating Applications Specification - GET CURRENT EVENT STATUS
	AX = CB10h
	DS:DX -> 512-byte buffer for status area (see #03051)
Return: AX = 0000h successful
		BX = event handle of current event or negative error code if
		      no current event
		buffer filled
	AX < 0	   error code (see #03048)
SeeAlso: AX=CB02h,AX=CB0Dh

(Table 03050)
Values for CAS event type:
 00h	send
 01h	receive
 02h	polled send
 03h	polled receive
 04h to 7Fh reserved
 FFh	serious hardware error

Format of CAS status area:
Offset	Size	Description	(Table 03051)
 00h	BYTE	event type (see #03050)
 01h	BYTE	transfer type
		00h 200x200 dpi, FAX mode
		01h 100x200 dpi, FAX mode
		02h file transfer mode
		03h to 7Fh reserved
 02h	WORD	event status (see #03052)
 04h	WORD	event time (packed DOS time format, see INT 21/AX=5700h)
 06h	WORD	event date (packed DOS date format, see INT 21/AX=5700h)
 08h	WORD	number of files to transfer, max 7FFFh
 0Ah	WORD	offset of file transfer record
 0Ch 47 BYTEs	ASCIZ phone number to call
 3Bh 64 BYTEs	ASCIZ application-specific tag string
 7Bh	BYTE	reserved (00h)
 7Ch	BYTE	connect time, seconds
 7Dh	BYTE	connect time, minutes
 7Eh	BYTE	connect time, hours
 7Fh	DWORD	total number of pages in all files
 83h	DWORD	pages already transmitted
 87h	WORD	number of files already transmitted
 89h	BYTE	cover page flag
		00h don't transmit cover page
		01h transmit cover page
		02h to 7Fh reserved
 8Ah	WORD	total number of transmission errors
 8Ch 78 BYTEs	reserved (zeros)
 DAh 21 BYTEs	ASCIZ remote FAX's CCITT identification
 EFH 32 BYTEs	ASCIZ destination name
10Fh 32 BYTEs	ASCIZ sender name
12Fh 80 BYTEs	filename of PCX logo file (max 1780x800 pixels)
17Fh 128 BYTEs	file transfer record for current event (see #03053)

(Table 03052)
Values for CAS event status:
 0000h	completed successfully
 0001h	waiting
 0002h	number dialed
 0003h	connected, sending
 0004h	connected, receiving
 0005h	aborted
 0006h to 007Fh reserved
 0080h to 7FFFh application-specific events
 8000h to FFFFh error codes

Format of CAS file transfer record:
Offset	Size	Description	(Table 03053)
 00h	BYTE	file type (ignored unless FAX)
		00h ASCII
		01h PCX
		02h DCX
		03h to 7Fh reserved
 01h	BYTE	text size for ASCII FAX file
		00h = 80 columns by 66 lines (11 inches)
		01h = 132 columns by 88 lines (11 inches)
		02h to 7Fh reserved
 02h	BYTE	status of file
		00h untouched
		01h opened
		02h moved
		03h deleted
		04h not yet received
		05h to 7Fh reserved
 03h	DWORD	bytes already transmitted
 07h	DWORD	file size in bytes
 0Bh	WORD	pages alread transmitted
 0Dh	WORD	number of pages in file
 0Fh 80 BYTEs	ASCIZ filename
 5Fh	BYTE	1/8 inch page length
		if page length below set to 01h through 7Fh, this value
		  specifies additional 1/8 inch increments to page length
 60h	BYTE	page length
		00h = 11 inches
		01h to 7Fh = page length is this number of inches plus value of
			  1/8 inch field above
		80h to FEh reserved
		FFh = ASCII pages ending with formfeed
 61h 31 BYTEs	reserved (zeros)
--------F-2FCB11-----------------------------
INT 2F - Communicating Applications Specification - GET QUEUE STATUS
	AX = CB11h
	DL = queue to get status of
	    00h task queue
	    01h receive queue
	    02h log queue
	    03h send events (v1.2+)
	    04h receive events (v1.2+)
Return: AX >= 0	 total number of changes made to queue, modulo 32768
	    BX = number of control files currently in queue
	    CX = number of received files (zero for task and log queues)
	AX < 0	error code (see #03048)
SeeAlso: AX=CB12h
--------F-2FCB11DL03-------------------------
INT 2F - Communicating Applications Spec v1.2+ - GET NUMBER OF SEND EVENTS
	AX = CB11h
	DL = 03h
Return: AX = number of successful sends since resident manager started
	BX = number of unsuccessful sends, including warnings
SeeAlso: AX=CB11h/DL=04h
--------F-2FCB11DL04-------------------------
INT 2F - Communicating Applications Spec v1.2+ - GET NUMBER OF RECEIVE EVENTS
	AX = CB11h
	DL = 04h
Return: AX = number of received file events since resident manager started
	BX = number of received FAX events
SeeAlso: AX=CB11h/DL=03h
--------F-2FCB12-----------------------------
INT 2F - Communicating Applications Specification - GET HARDWARE STATUS
	AX = CB12h
	DS:DX -> 128-byte status buffer (see #03054,#03056)
Return: AX = 0000h successful
	    DS:DX buffer filled with hardware-dependent status information
	   < 0	   error code (see #03048)
SeeAlso: AX=CB10h,AX=CB11h

Format of status buffer for Intel Connection CoProcessor:
Offset	Size	Description	(Table 03054)
 00h	BYTE	Connection CoProcessor connection status flags (see #03057)
 01h	BYTE	number of kilobytes of free buffer space
 02h	BYTE	page buffer status
		bit 7: Connection CoProcessor has documents to send
		bits 6-0: number of pages in buffer
 03h	BYTE	number of retries left for dialing number
 04h	BYTE	page number to retransmit
 05h	BYTE	communications status (see #03058)
 06h	BYTE	baud rate (see #03055)
 07h  3 BYTEs	reserved
 0Ah	BYTE	Connection CoProcessor hardware status (see #03059)
 0Bh	BYTE	Connection CoProcessor switch states (see #03060)
 0Ch	BYTE	communications flags (see #03061)
 0Dh	BYTE	reserved
 0Eh	WORD	error count (only valid while busy, reset when idle)
 10h	DWORD	size of nonstandard format (NSF) file in bytes
 14h	BYTE	'A' if Connection CoProcessor board present
 15h  9 BYTEs	reserved
 1Eh 21 BYTEs	ASCIZ CCITT identification
 33h 77 BYTEs	reserved
Note:	the Intel Connection CoProcessor and SatisFAXtion may be distinguished
	  by examining the byte at offset 14h

Bitfields for Connection CoProcessor baud rate:
Bit(s)	Description	(Table 03055)
 7	reserved
 6-4	baud rate
	000 = 300 baud	(V.21 SDLC or HDLC mode)
	100 = 2400 baud (V.27 ter)
	101 = 4800 baud (V.27 ter)
	110 = 7200 baud (V.29)
	111 = 9600 baud (V.29)
 3-0	reserved, should be 0110

Format of status buffer for Intel SatisFAXtion board:
Offset	Size	Description	(Table 03056)
 00h	BYTE	SatisFAXtion connection status flags (see #03062)
 01h	BYTE	SatisFAXtion board state (see #03063)
 02h	BYTE	number of KB free in buffer
 03h	BYTE	number of pages or files in buffer
 04h	BYTE	number of redials remaining on current number
 05h	BYTE	FAX page number to retransmit
 06h	BYTE	current page/file in block transfer
 07h	BYTE	number of rings received (only if auto-answer enabled)
 08h	WORD	error count
 0Ah	DWORD	length of file being transferred
 0Eh  6 BYTEs	reserved
 14h	BYTE	'B' if SatisFAXtion board present
 15h 13 BYTEs	ASCIZ transfer agent name
 22h  5 BYTEs	ASCIZ transfer agent version number
 27h 13 BYTEs	ASCIZ resident loader name
 34h  5 BYTEs	ASCIZ resident loader version number
 39h 21 BYTEs	ASCIZ remote CSID
 4Eh 13 BYTEs	ASCIZ resident manager name
 5Bh  5 BYTEs	ASCIZ resident manager version number
 60h 32 BYTEs	reserved
Note:	the Intel Connection CoProcessor and SatisFAXtion may be distinguished
	  by examining the byte at offset 14h

Bitfields for Connection CoProcessor connection status flags:
Bit(s)	Description	(Table 03057)
 7	hardware busy sending or receiving
 6	last page of data
 5	no data on current page
 4	retransmit request for current page being transmitted
 3	NSF (nonstandard file) mode active
 2-0	reserved

Bitfields for communications status:
Bit(s)	Description	(Table 03058)
 7	originating call
 6	FAX message to be sent
 5	on line
 4	ring detected and receive enabled
 3	buffer dumped on receive
 2-0	hardware sequence state
	000 idle
	001 dial
	010 answer
	011 transmit
	100 receive
	101 pre-message
	110 post-message
	111 disconnect

Bitfields for Connection CoProcessor hardware status:
Bit(s)	Description	(Table 03059)
 7	modem option installed
 6	Connection CoProcessor has control of DAA (not latched)
 5	on line (not latched)
 4	ring detected (not latched)
 3	data in command buffer (not latched)
 2	set if using DMA channel 1, clear if using DMA channel 3
 1	line length compensation 1 set (not latched)
 0	line length compensation 0 set (not latched)

Bitfields for Connection CoProcessor switch states:
Bit(s)	Description	(Table 03060)
 7	reserved
 6	unused
 5	spare switch open
 4	FAX ADR1 switch open
 3	FAX ADR0 switch open
 2	alternate interrupt switch open
 1	COM SEL 1 switch open
 0	COM SEL 0 switch open
Note:	valid combinations of 0-2 are
	000  COM2 IRQ3 IObase 2F8h
	001  COM1 IRQ4 IObase 3F8h
	010  COM4 IRQ3 IObase 2E8h
	011  COM3 IRQ4 IObase 3E8h
	110  COM4 IRQ2 IObase 2E8h
	111  COM3 IRQ5 IObase 3E8h

Bitfields for communications flags:
Bit(s)	Description	(Table 03061)
 7	reserved
 6	auxiliary relay forced ON
 5	modem select relay forced ON
 4	offhook relay forced ON
 3	9600 bps enabled
 2	7200 bps enabled
 1	4800 bps enabled
 0	2400 bps enabled

Bitfields for SatisFAXtion connection status flags:
Bit(s)	Description	(Table 03062)
 7	busy in T.30 CCITT fax protocol
 6	data on current page/file (only used for block xfers)
 5	retransmission of last page requested
 4	in file transfer mode
 3	data in buffer
 2	data buffer dumped on receive
 1	200x100 dpi resolution instead of 200x200 dpi
 0	data modem in use, FAX image modem not available

Bitfields for SatisFAXtion board state:
Bit(s)	Description	(Table 03063)
 7	reserved
 6	handset jack active, data and FAX modems not available
 5-3	current rate
	000  300 bps (V.21 HDLC)
	100 2400 bps (V.27 ter)
	101 4800 bps (V.27 ter)
	110 7200 bps (V.29)
	111 9600 bps (V.29)
 2-0	T.30 CCITT protocol state
	000 idle
	001 dialing
	010 answering
	011 transmitting
	100 receiving
	101 pre-message
	110 post-message
	111 disconnect
--------F-2FCB13DL00-------------------------
INT 2F - Communicating Applications Specification - GET DIAGNOSTICS RESULTS
	AX = CB13h
	DL = 00h
Return: AX = 0040h in progress
	   >= 0	   passed
	   < 0	   hardware-dependent failure code (see #03064,#03065)
SeeAlso: AX=CB13h/DL=01h

Bitfields for Intel Connection CoProcessor failure codes:
Bit(s)	Description	(Table 03064)
 3	9600 bps FAX modem module failed
 2	SDLC chip failed
 1	RAM failed
 0	ROM checksum failed

Bitfields for Intel SatisFAXtion failure codes:
Bit(s)	Description	(Table 03065)
 1	2400 bps data modem failed
 0	9600 bps FAX modem failed
--------F-2FCB13DL01-------------------------
INT 2F - Communicating Applications Specification - START DIAGNOSTICS
	AX = CB13h
	DL = 01h
Return: AX = 0000h successfully started
	AX < 0	   error code (see #03048)
SeeAlso: AX=CB13h/DL=00h
--------F-2FCB14-----------------------------
INT 2F - Communicating Applications Specification - MOVE RECEIVED FILE
	AX = CB14h
	BX = event handle
	CX = receive file number
	    0001h first received file
	    N	  Nth received file
	DS:DX -> ASCIZ string specifying new name for file (must not exist)
Return: AX = 0000h successful
	AX < 0	   error code (see #03048)
--------F-2FCB15-----------------------------
INT 2F - Communicating Applications Specification - SUBMIT FILE TO SEND
	AX = CB15h
	DS:DX -> variable-length data area (see #03066)
Return: AX >= 0 event handle
	AX < 0	error code (see #03048)
SeeAlso: AX=CB01h

Format of CAS file submission data area:
Offset	Size	Description	(Table 03066)
 00h	BYTE	transfer type
		00h = 200x200 dpi, fax mode
		01h = 100x200 dpi, fax mode
		02h = file transfer mode
		03h to 7Fh reserved
 01h	BYTE	text size
		00h = 80 columns
		01h = 132 columns
		02h to 7Fh reserved
 02h	WORD	time to send (DOS packed time, see #01665 at INT 21/AX=5700h)
 04h	WORD	date to send (DOS packed date, see #01666 at INT 21/AX=5700h)
 06h 32 BYTEs	ASCIZ destination name
 26h 80 BYTEs	ASCIZ name of file to send
 76h 47 BYTEs	ASCIZ phone number to dial
 A5h 64 BYTEs	ASCIZ application-specific tag string
 E5h	BYTE	reserved (00h)
 E6h	BYTE	cover page
		00h don't send cover page
		01h send cover page
		02h to 7Fh reserved
 E7h 23 BYTEs	reserved (zeros)
 FEh variable	ASCIZ string containing text of cover page (if cover page flag
		set to 01h)
--------F-2FCB16BX1234-----------------------
INT 2F - Communicating Applications Spec v1.2+ - UNLOAD RESIDENT MANAGER
	AX = CB16h
	BX = 1234h
	CX = 5678h
	DX = 9ABCh
Return: AX = 0000h successful
	AX < 0	   error code
Note:	the METZ XpressFax CASMGR ignores the values in BX,CX, and DX
SeeAlso: AX=C000h/BX=444Bh,AX=CB00h
Index:	uninstall;CAS Manager
--------F-2FCB17-----------------------------
INT 2F - Communicating Applications Spec v1.2+ - SET COVER PAGE STATUS
	AX = CB17h
	BX = event handle
	CL = cover page status
	    00h not read
	    01h read by user
Return: AX = 0000h successful
	AX < 0	   error code
--------F-2FCB80-----------------------------
INT 2F - Intel SatisFAXtion CASMGR - ???
	AX = CB80h
	???
Return: ???
--------F-2FCB81-----------------------------
INT 2F - Intel SatisFAXtion CASMGR - ???
	AX = CB81h
	???
Return: ???
--------F-2FCB82-----------------------------
INT 2F - Intel SatisFAXtion CASMGR - ???
	AX = CB82h
	???
Return: ???
--------F-2FCBDCBL56-------------------------
INT 2F - Comwave Microfax Specification - GET STATUS ARRAY
	AX = CBDCh
	BL = 56h
	BH = line number (starts with 1)
	CX:DX -> 32-byte status buffer or 80 character string
Return: AX = number of cards installed, or FFFFh on error
Program: Comwave manufacturers the Microfax line of fax cards which are a
	  high-performance multi-card FAX solution for OEMs.
Note:	defaults to AH=CBh but can be changed
SeeAlso: AX=CBDDh,AX=DA00h
--------F-2FCBDDBL56-------------------------
INT 2F - Comwave Microfax Specification - COMMAND SUBMISSION
	AX = CBDDh
	BL = 56h
	BH = ?
	CX:DX -> command to execute
Return: AX = status
	    0000h success
	    FFFFh on error
SeeAlso: AH=2Ah,AX=CBDCh,AX=80FBh
--------c-2FCC--SI5453-----------------------
INT 2F U - PC-Kwik Programs - API
	AH = CCh
	SI = 5453h or 7473h
	AL = function number (at least 00h,01h,04h,05h,07h,80h)
	DL = program identifier (see #03067)
Return: SI = 7473h
	other registers vary by function
Note:	Qualitas Qcache v4.00 is an OEM version of Super PC-Kwik v4.00, and
	  thus supports this call
SeeAlso: INT 21/AH=2Bh/CX=4358h

(Table 03067)
Values for PC-Kwik program identifier:
 00h	all installed PowerPak programs
 01h	SUPERPCK/SUPER/QCACHE v4.00+ (disk cache)
 02h	PCKSPL (print spooler)
 04h	PCKSCRN (screen accelerator)
 05h	PCKKEY (keyboard enhancer)
 06h	PCKRAMD (RAM disk)
 08h	PCKWIK.SYS
 10h	PCKCDROM (CD-ROM support for SUPERPCK)
--------N-2FCC00-----------------------------
INT 2F - Tsoft NFSDRVR - INSTALLATION CHECK
	AX = CC00h
Return: AX = 7777h
	BX = ???
	CX = ???
	DX = ???
	ES = data segment of resident portion
SeeAlso: AX=CC01h,AX=CC06h
--------N-2FCC01-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC01h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC02-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC02h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC03-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC03h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC04-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC04h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC05-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC05h
	???
Return: ???
SeeAlso: AX=CC00h
--------N-2FCC06-----------------------------
INT 2F - Tsoft NFSDRVR - ???
	AX = CC06h
	???
Return: ???
SeeAlso: AX=CC00h
--------P-2FCD00-----------------------------
INT 2F - Intel Image Processing Interface - INSTALLATION CHECK
	AX = CD00h
Return: AL = state
	    00h not installed, OK to install
	    01h not installed, not OK to install
	    FFh installed
SeeAlso: AX=CD02h"Image"
--------P-2FCD00-----------------------------
INT 2F - LaserPort Interface - INSTALLATION CHECK
	AX = CD00h
Return: AL = status
	    FFh installed
SeeAlso: AX=CD0Fh"LaserPort"
--------U-2FCD00-----------------------------
INT 2F - SWELL.EXE - INSTALLATION CHECK
	AX = CD00h
Return: AX = 00FFh installed
	    BH = major version
	    BL = minor version
Program: SWELL.EXE is a TSR which swaps programs to disk when they EXEC a
	  child process with INT 21/AH=4Bh
--------s-2FCD00BX464F-----------------------
INT 2F - Forte/Gravis ULTRAMID - INSTALLATION CHECK
	AX = CD00h
	BX = 464Fh ('FO')
	CX = 5254h ('RT')
	DX = 4520h ('E ')
Return: AL = FFh if installed
	    BX = 4155h ('AU')
	    CX = 4449h ('DI')
	    DX = 4F20h ('O ')
	    ES:SI -> program ID string
Program: ULTRAMID is a MIDI driver for the Gravis UltraSound which allows use
	  of AIL drivers with other software
Range:	AH=CDh-ECh, selected by scanning for an available multiplex number
SeeAlso: INT 21/AX=FD12h,AX=CD00h/DX=4957h
--------s-2FCD00DX4957-----------------------
INT 2F R - InterWave Game API - INSTALLATION CHECK
	AX = CD00h
	DX = 4957h ('IW')
	SI = 5645h ('VE')
Return: AL = FFh if installed
	    DX = 4554h ('ET')
	    SI = 454Bh ('EK')
Range:	AH=CDh-ECh, selected by scanning for an available multiplex number
SeeAlso: AX=CD00h/BX=464Fh,AX=CD01h"InterWave",AX=CD21h"InterWave"
SeeAlso: AX=CD80h"InterWave"
--------P-2FCD01-----------------------------
INT 2F - Intel Image Processing Interface - SET DEVICE NAME
	AX = CD01h
	CX:BX -> ASCIZ character device name ("LPTn", "COMn", "PRN")
Return: AL = status
	    00h successful
		CX:BX -> internal character device name
	    80h error
--------U-2FCD01-----------------------------
INT 2F - SWELL.EXE - SUSPEND ONCE
	AX = CD01h
Return: AX = 0000h
SeeAlso: AX=CD02h"SWELL"
--------s-2FCD01BX0000-----------------------
INT 2F R - InterWave Game API - GET NUMBER OF INTERWAVE PROGRAMS / PROGRAM ID
	AX = CD01h
	BX = 0000h
Return: BX = number of programs currently installed on the Game API
Desc:	get the number of programs supporting the InterWave Game API which are
	  currently installed in memory, which also forms the next program ID
	  number if the caller wishes to go resident on the API
Range:	AH=CDh-ECh, selected by scanning for an available multiplex number
Notes:	the first program to install on the IW Game API must use ID 00h
	the AMD-recommended implementation is for the handler to increment
	  BX and chain to the previous handler (if any), but this will fail
	  if TSRs are unloaded out-of-order
SeeAlso: AX=CD00h"InterWave",AX=CD02h"InterWave",AX=CD03h"InterWave"
SeeAlso: AX=CD05h"InterWave",AX=CD21h"InterWave",AX=CD80h"InterWave"
--------P-2FCD02-----------------------------
INT 2F - Intel Image Processing Interface - GET VERSION NUMBER
	AX = CD02h
Return: AL = status
	    00h/01h successful
		BH = major version number (BCD)
		BL = minor version number (BCD)
	    80h error
Note:	if return AL = 01h, the IPI supports network redirection
SeeAlso: AX=CD00h"Image"
--------U-2FCD02-----------------------------
INT 2F - SWELL.EXE - SUSPEND
	AX = CD02h
Return: AX = 0000h
SeeAlso: AX=CD03h"SWELL"
--------s-2FCD02-----------------------------
INT 2F R - InterWave Game API - GET PROGRAM STATUS AND INFORMATION
	AX = CD02h
	BX = program identifier
Return: CX = program status
	    bit 0: using synthesizer
	    bit 1: using Codec
	    bit 2: supports at least one Game Device (see AX=CD21h,AX=CD22h)
	BX = supported API version (BCD, BH=major, BL=minor) if CX bit 2 set
	ES:DI -> ASCIZ identification string
Range:	AH=CDh-ECh, selected by scanning for an available multiplex number
Note:	ordinarily, an application will loop through all valid program
	  identifiers (as returned by AX=CD01h); if any of the installed
	  programs conflicts with the use the caller wishes to make of the
	  InterWave chip, it should be disabled with AX=CD03h first
SeeAlso: AX=CD00h"InterWave",AX=CD01h"InterWave",AX=CD03h"InterWave"
SeeAlso: AX=CD05h"InterWave",AX=CD21h"InterWave",AX=CD80h"InterWave"
--------P-2FCD03-----------------------------
INT 2F - Intel Image Processing Interface - SELECT SCAN LINE
	AX = CD03h
	BX = scan line
	CX = requested density in dots per inch (300, 600, or 1200)
Return: AL = status (see also AX=CD04h"Image")
	    00h successful
		CX = density at which scan line was mapped
		ES:DI -> start of scan line
	    80h unsuccessful
	    81h scan line out of range
	    82h unsupported scan line density
	    83h out of memory
SeeAlso: AX=CD04h"Image"
--------U-2FCD03-----------------------------
INT 2F - SWELL.EXE - ACTIVATE
	AX = CD03h
Return: AX = 0000h
SeeAlso: AX=CD02h"SWELL"
--------s-2FCD03-----------------------------
INT 2F R - InterWave Game API - SUSPEND PROGRAM
	AX = CD03h
	BX = installed program identifier
	CX = InterWave section to be released
	    0000h all
	    0001h synthesizer
	    0002h Codec
Return: AL = status
	    00h successful
		BX = base port
		CL = IRQ
		CH = DMA channel (Codec only)
	    else failed
SeeAlso: AX=CD00h"InterWave",AX=CD01h"InterWave",AX=CD02h"InterWave"
SeeAlso: AX=CD04h"InterWave",AX=CD21h"InterWave",AX=CD80h"InterWave"
--------P-2FCD04-----------------------------
INT 2F - Intel Image Processing Interface - MOVE BITMAP TO SCANLINE
	AX = CD04h
	CX:BX -> structure (see #03069)
Return: AL = status (see #03068)
SeeAlso: AX=CD03h"Image"

(Table 03068)
Values for IPI function status:
 00h	successful
 80h	unsuccessful
 81h	scan line out of range
 82h	unsupported scan line density
 83h	out of memory
 84h	unrecognized source
 85h	initialization error

Format of structure:
Offset	Size	Description	(Table 03069)
 00h	WORD	image source (0 = conventional memory, 1 = expanded memory)
 02h	DWORD	pointer to image data
 06h	WORD	scan line on which to place
 08h	WORD	bit offset from start of scan line at which to place
 0Ah	WORD	density of bitmap data (300, 600, or 1200 dpi)
 0Ch	WORD	width in bits of data
 0Eh	WORD	source logical page number
 10h	WORD	source handle (only if source in expanded memory)
 12h	WORD	source offset (only if source in expanded memory)
--------U-2FCD04-----------------------------
INT 2F - SWELL.EXE - TURN OFF VERBOSE MODE
	AX = CD04h
Return: AX = 0000h
SeeAlso: AX=CD05h"SWELL"
--------s-2FCD04-----------------------------
INT 2F R - InterWave Game API - WAKE PROGRAM
	AX = CD04h
	BX = installed program identifier
Return: AL = status
	    00h successful
	    else failed
Note:	this function should only be called after the program has been
	  suspended with AX=CD03h
SeeAlso: AX=CD00h"InterWave",AX=CD01h"InterWave",AX=CD03h"InterWave"
SeeAlso: AX=CD05h"InterWave",AX=CD21h"InterWave",AX=CD80h"InterWave"
SeeAlso: INT 7E/AL=84h"IWSBSDRV"
--------P-2FCD05-----------------------------
INT 2F - Intel Image Processing Interface - PRINT PAGE
	AX = CD05h
Return: AL = status (00h,80h) (see #03068)
Note:	page image is retained, so multiple calls will print multiple copies of
	  the page
SeeAlso: AX=CD06h"Image"
--------U-2FCD05-----------------------------
INT 2F - SWELL.EXE - TURN ON VERBOSE MODE
	AX = CD05h
Return: AX = 0000h
SeeAlso: AX=CD04h"SWELL"
--------s-2FCD05-----------------------------
INT 2F R - InterWave Game API - UNINSTALL RESIDENT DEVICE DRIVER
	AX = CD05h
	BX = installed program identifier
Return: AL = status
	    00h successful
	    else failed
SeeAlso: AX=CD00h"InterWave",AX=CD01h"InterWave",AX=CD02h"InterWave"
SeeAlso: AX=CD03h"InterWave",AX=CD21h"InterWave",AX=CD80h"InterWave"
--------P-2FCD06-----------------------------
INT 2F - Intel Image Processing Interface - CLEAR PAGE
	AX = CD06h
Return: AL = status (00h,80h) (see #03068)
Note:	palette is reset to default
SeeAlso: AX=CD09h"Image"
--------U-2FCD06-----------------------------
INT 2F - SWELL.EXE - UNINSTALL
	AX = CD06h
Return: AX = status
	    0000h uninstalled
	    8002h programs still swapped, not uninstalled
--------P-2FCD07-----------------------------
INT 2F - Intel Image Processing Interface - reserved
	AX = CD07h
SeeAlso: AX=CD00h"Image"
--------U-2FCD07-----------------------------
INT 2F - SWELL.EXE - GET INFO
	AX = CD07h
	ES:BX -> 32-byte buffer for info (see #03070)
Return: AX = status
	    0000h successful
		ES:BX buffer filled
	    8001h buffer wrong size

Format of SWELL.EXE info buffer:
Offset	Size	Description	(Table 03070)
 00h	WORD	20h  (total size of buffer)
 02h	BYTE	suspend-once mode active if nonzero
 03h	BYTE	00h active, 01h suspended
 04h	BYTE	00h quiet, 01h verbose
 05h	BYTE	"Borland support" (allowing INT 21/AX=4B01h) on if nonzero
 06h 26 BYTEs	unused???
--------P-2FCD08-----------------------------
INT 2F - Intel Image Processing Interface - SCREEN IMAGE
	AX = CD08h
	CX:BX -> structure (see #03071)
Return: AL = status (00h,80h-85h) (see #03068)
SeeAlso: AX=CD05h"Image",AX=CD09h"Image"

Format of IPI screen image structure:
Offset	Size	Description	(Table 03071)
 00h	WORD	image source (0 = conventional memory, 1 = expanded memory)
 02h	DWORD	pointer to image data
 06h	WORD	horizontal position on paper of left edge (in 1200 dpi units)
 08h	WORD	vertical position on paper of top edge (in 1200 dpi units)
 0Ah	WORD	left cropping (currently must be zero)
 0Ch	WORD	top cropping (currently must be zero)
 0Eh	WORD	width (currently must be 8000h)
 10h	WORD	height (currently must be 8000h)
 12h	WORD	horizontal size of image in 1200 dpi units
 14h	WORD	vertical size of image in 1200 dpi units
 16h	WORD	aspect ratio (currently reserved)
 18h	WORD	initialization flag (if 01h, initialization is performed)
 1Ah	WORD	pixels per line of source data
 1Ch	WORD	number of scan lines in source data
 1Eh	WORD	number of scan lines in packet
 20h	WORD	bits per pixel (1,2,4,6, or 8)
 22h	WORD	pixels per byte (1,2,4, or 8)
 24h	WORD	compression type (currently only 00h [uncompressed] supported)
 26h	WORD	source page number (if in expanded memory)
 28h	WORD	source handle (if in expanded memory)
 2Ah	WORD	source offset (if in expanded memory)
--------U-2FCD08-----------------------------
INT 2F - SWELL.EXE - UNUSED
	AX = CD08h
Return: AX = FFFFh (error)
--------P-2FCD09-----------------------------
INT 2F - Intel Image Processing Interface - LOAD SCREEN
	AX = CD09h
	CX:BX -> structure (see #03072)
Return: AL = status (00h,80h) (see #03068)
SeeAlso: AX=CD06h"Image Processing",AX=CD0Ah"Image Processing"

Format of IPI load screen structure:
Offset	Size	Description	(Table 03072)
 00h	BYTE	style
		44h ('D') diamond style
		4Ch ('L') line style
 01h	BYTE	reserved (00h)
 02h	WORD	frequency in lines per inch [sic]
		currently, coerced to nearest of 50, 60, 68, 70, 75, 85, or 100
 04h	WORD	screen angle in degrees (-360 to 360)
		currently coerced to nearest of -45, 0, 45, or 90
--------U-2FCD09-----------------------------
INT 2F - SWELL.EXE - TURN OFF "BORLAND SUPPORT"
	AX = CD09h
Return: AX = 0000h
SeeAlso: AX=CD0Ah"SWELL"
--------P-2FCD0A-----------------------------
INT 2F - Intel Image Processing Interface - LOAD PALETTE
	AX = CD0Ah
	CX:BX -> palette structure (see #03073)
Return: AL = status (00h,80h) (see #03068)
SeeAlso: AX=CD09h"Image Processing"

Format of IPI palette structure:
Offset	Size	Description	(Table 03073)
 00h	BYTE	bits per pixel for which palette is to be used (1,2,4,6, or 8)
 01h	2**N	palette translation values, one per possible pixel value
--------U-2FCD0A-----------------------------
INT 2F - SWELL.EXE - TURN ON "BORLAND SUPPORT"
	AX = CD0Ah
Return: AX = 0000h
SeeAlso: AX=CD09h"SWELL"
--------P-2FCD0F-----------------------------
INT 2F - LaserPort Interface - EXECUTE FUNCTION
	AX = CD0Fh
	BL = function
		01h enable
		02h disable
		03h ???
Return: AL = status
	    00h success
SeeAlso: AX=CD00h"LaserPort"
--------s-2FCD21-----------------------------
INT 2F R - InterWave Game API - OPEN GAME DEVICE
	AX = CD21h
	BX = installed program identifier
	ES:DI -> ASCIZ device name
	    "MIDISIMPLE"
	    "MIDICOMPLEX"
	    "DIRECTCODEC"
Return: AL = status
	    00h successful
		DX = device handle
		---MIDISIMPLE and MIDICOMPLEX---
		BX = real-mode interrupt number (see #03074,#03075)
		---DIRECTCODEC---
		BX = base port
		CL = IRQ
		CH = DMA channel (04h = no DMA)
		SI = size of FIFO in bytes (0000h = use DMA)
	    nonzero failed (not supported or already in use)
	AH may be destroyed
Range:	AH=CDh-ECh, selected by scanning for an available multiplex number
SeeAlso: AX=CD00h"InterWave",AX=CD01h"InterWave",AX=CD02h"InterWave"
SeeAlso: AX=CD05h"InterWave",AX=CD22h"InterWave",AX=CD80h"InterWave"

(Table 03074)
Call MIDISIMPLE with:
	EAX = function number
	    0001h MIDI byte out
		BL = MIDI byte to send
	    0002h MIDI string out
		ECX = length of MIDI string in bytes
		ES:EDI -> MIDI string to send (should not include timing info)
	DX = device handle
	INT xxh (as returned by AX=CD21h)
Return: EAX = status
	    00000000h if successful
	    FFFFFFFFh on error (bad handle)
SeeAlso: #03075,INT 7E/AX=0001h"IWSBSDRV",INT 7E/AX=0002h"IWSBSDRV"

(Table 03075)
Call MIDICOMPLEX with:
	EAX = function number
	    ??? (specification is still in development)
	DX = device handle
	INT xxh (as returned by AX=CD21h)
Return: EAX = status
	    00000000h if successful
	    FFFFFFFFh on error (bad handle)
SeeAlso: #03074
--------s-2FCD22-----------------------------
INT 2F R - InterWave Game API - CLOSE GAME DEVICE
	AX = CD22h
	BX = installed program identifier
	DX = device handle (from AX=CD21h)
Return: AL = status
	    00h successful
	    FFh inavlid handle or device is not open
Range:	AH=CDh-ECh, selected by scanning for an available multiplex number
SeeAlso: AX=CD00h"InterWave",AX=CD01h"InterWave",AX=CD02h"InterWave"
SeeAlso: AX=CD05h"InterWave",AX=CD21h"InterWave",AX=CD80h"InterWave"
--------s-2FCD80-----------------------------
INT 2F RC - InterWave Game API - MIXER SETTINGS CHANGED BROADCAST
	AX = CD80h
Return: nothing
Desc:	called by an application controlling the InterWave chip's mixer
	  whenever the mixer's settings are changed
Range:	AH=CDh-ECh, selected by scanning for an available multiplex number
Note:	when an application intercepts this function call, it must read the
	  new mixer settings from the InterWave chip
SeeAlso: AX=CD00h"InterWave",AX=CD01h"InterWave",AX=CD02h"InterWave"
SeeAlso: AX=CD05h"InterWave",AX=CD21h"InterWave",AX=CD22h"InterWave"
--------K-2FCF00-----------------------------
INT 2F - TEMPLEXX 1.0 - INSTALLATION CHECK
	AX = CF00h
Return: AL = FFh if installed
Program: TEMPLEXX is a popup keyboard template by Henson Scientific, Inc.
Note:	values in AL other than 00h cause an immediate return without modifying
	  any registers
--------G-2FD000-----------------------------
INT 2F C - MDEBUG display driver - GET DRIVER STATUS
	AX = D000h
Return: CF set on error
	    all other registers must be unchanged)
	CF clear if successful
	    AL = FFh
	    AH = driver semaphor
		00h driver is not active
		01h driver is active
	    BX = CS of the driver
	    CX = driver version (CH = major, CL = minor, must be >= 013Ch)
	    DL = buffer semaphor
		00h driver is not pending
		01h driver is pending between functions 02h and 03h
	    DH = show semaphor
		00h driver is not pending
		01h driver is pending between functions 04h and 05h
Program: MDEBUG is a shareware memory-resident debugging tool by Bernd
	  Schemmer, including a memory monitor, an interpreter and a
	  disassembler
Range:	AH=C0h to AH=FFh, selected by switch or programmatically
Notes:	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver (call INT 60/AH=00h"MDEBUG" for the actual multiplex
	  numbers used)
	this function MUST be reentrant, as MDEBUG calls it after every popup
	  before any other actions.  The handler should not change any
	  registers if the display is in an unsupported mode or in a mode
	  MDEBUG supports itself, e.g. a normal text mode with at least 80x25
	  characters (i.e. 80x43 or 132x44 (v1.60+)). In this case MDEBUG will
	  not call any of the other functions for this popup session.
	MDEBUG will not call the other functions if the returned version is
	  less than the actual version of MDEBUG.
	if the driver is reentrant, DL and DH should be 00h
SeeAlso: AX=D001h,AX=D002h,AX=D003h,AX=D004h,AX=D005h
--------M-2FD000-----------------------------
INT 2F - ZWmous - INSTALLATION CHECK
	AX = D000h
Return: AX = 5A57h ("ZW") if installed
	    BX = segment of resident code
Program: ZWmous is a shareware TSR by Zen Wu which permits the use of a mouse
	  with many non-mouse applications by entering the letter under the
	  mouse cursor on button presses
SeeAlso: INT 33/AX=0003h
--------N-2FD000-----------------------------
INT 2F - Lotus CD/Networker - INSTALLATION CHECK
	AX = D000h
Return: AL = FFh if CD/Networker TSR is loaded
	BX = 4D44h ("MD") signature
	CX = Windows mode word (from INT 2F/AX=1600h) at time of TSR load
	DX = bitmap identifying all loaded CD/Networker TSRs.
Notes:	INT 2F/AH=D0h is used by CD/Networker to communicate between a
	  resident redirector TSR and a transient program that controls the
	  TSR's CD-ROM drive emulation (volume attachments, caching, etc).
	At present there is only one CD/Networker TSR; the bitmap always = 4.
SeeAlso: AX=D002h"Lotus",INT 2F/AX=1500h"CD-ROM"
--------G-2FD001-----------------------------
INT 2F C - MDEBUG display driver - INITIALIZE DRIVER
	AX = D001h
Return: CF set on error
	AL = driver semaphor
	AH = buffer semaphor
Range:	AH=C0h to AH=FFh, selected by switch or programmatically
Notes:	MDEBUG calls this function after every successful call of the function
	  00h. The function should reset all internal data and the status of
	  the driver. If this function returns an error, MDEBUG will not call
	  the other functions in this popup session.
	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver
SeeAlso: AX=D000h
--------G-2FD002-----------------------------
INT 2F C - MDEBUG display driver - SAVE GRAPHIC DATA
	AX = D002h
Return: CF set on error
	CF clear if successful
	    display memory saved and display switched to one of the text modes
	      02h, 03h or 07h.
Note:	MDEBUG calls this function only once every popup session before
	  displaying its windows.
SeeAlso: AX=D000h,AX=D003h
--------N-2FD002BX4D44-----------------------
INT 2F - Multiplex - Lotus CD/Networker GET DATA AREA
	AX = D002h
	BX = 4D44h
	DX = bitmap identifying one loaded CD/Networker TSR
Return: ES:DI -> data area owned by TSR
Note:	the format of the data area changes with each minor revision, so it
	  cannot be counted on
SeeAlso: AX=D000h"Lotus"
--------G-2FD003-----------------------------
INT 2F C - MDEBUG display driver - RESTORE GRAPHIC DATA
	AX = D003h
Return: CF set on error
	CF clear if successful
	    display restored to the mode it was in before calling AX=D002h and
	      the display memory is restored
Note:	MDEBUG calls this function only once every popup session just before
	 it exits to normal DOS.
SeeAlso: AX=D000h,AX=D002h
--------G-2FD004-----------------------------
INT 2F - MDEBUG display driver - SHOW SAVED DATA
	AX = D004h
Return: CF set on error
	CF clear if successful
	    display switched to mode it was in before calling AX=D002h and the
	      display memory is restored
Note:	This function needn't save the display memory before changing it.
SeeAlso: AX=D000h,AX=D005h
--------G-2FD005-----------------------------
INT 2F - MDEBUG display driver - SWITCH BACK TO TEXT SCREEN
	AX = D005h
Return: CF set on error
	CF clear if successful
	    display restored to mode it was in before calling AX=D004h
Note:	This function needn't save or change the display memory
SeeAlso: AX=D000h,AX=D004h
--------G-2FD0-------------------------------
INT 2F - MDEBUG display driver - RESERVED FUNCTION NUMBERS
	AH = D0h
	AL = 06h-7Fh
Note:	these functions are reserved for future use
--------G-2FD0-------------------------------
INT 2F - MDEBUG display driver - USER DEFINED FUNCTION NUMBERS
	AH = D0h
	AL = 80h-FFh
Note:	these functions numbers are reserved for user defined features (e.g.
	  communication between the transient und resident parts of the driver)
--------G-2FD100-----------------------------
INT 2F C - MDEBUG command driver - GET STATUS
	AX = D100h
	BX = version of MDEBUG (BH = major, BL = minor)
	CX = command driver counter
---v1.60+---
	DS:SI -> MDEBUG identification table (see #03076)
	ES = segment of display memory used by MDEBUG
	DI = size of video mode used by MDEBUG
	    (high byte = lines, low byte = columns)
Return: DL = FFh
	BX = version number of the driver if it is less than the version in BX,
	      else unchanged
	CX incremented
Program: MDEBUG is a shareware memory-resident debugging tool by Bernd
	  Schemmer, including a memory monitor, an interpreter, and a
	  disassembler
Range:	AH=C0h to AH=FFh, selected by switch or programmatically
Notes:	called by MDEBUG at start of popup session; if the version number
	  returned in BX is less than 1.52 (1.60 for MDEBUG v1.70), MDEBUG will
	  not call any of the other functions during this popup session
	MDEBUG can use any two consecutive multiplex numbers between C0h and
	  FFh; the default is D0h for the display driver and D1h for the
	  command driver (call INT 60/AH=00h"MDEBUG" for the multiplex numbers
	  actually used)
	this function must end with a far call to the old INT 2F handler after
	  changing the registers
	this function MUST be reentrant
	command drivers must also declare the following data at the given
	  offsets in the code segment
		100h  3 BYTEs	JMP-command in .COM-files
		103h	BYTE	NOP-command (90h)
		104h 26 BYTEs	signature "Kommandotreiber fÅr MDEBUG"
		11Eh 12 BYTEs	name of driver, e.g. "MDHISDRV.COM"
				each driver must have a unique name
	MDEBUG will pass every key and command to the command driver(s) before
	  checking for a valid internal command
SeeAlso: AX=D000h,AX=D101h

Format of MDEBUG identification table:
Offset	Size	Description	(Table 03076)
 -2	WORD	entry offset
 00h	WORD	CS of MDEBUG
 02h	DWORD	old INT 08h vector
 06h	DWORD	old INT 09h vector
 0Ah	DWORD	address INT 16h routine used by MDEBUG
 0Eh	BYTE	length of version string
 0Fh  N BYTEs	version string
--------G-2FD101-----------------------------
INT 2F - MDEBUG command driver - INITIALIZE DRIVER
	AX = D101h
	CX = command driver counter
Return: DL = status
	    FFh if successful
		CX incremented
	    else error: all registers unchanged
Note:	this function must end with a  far call to the old INT 2F handler after
	  changing the registers
	this function must be reentrant
--------G-2FD102-----------------------------
INT 2F - MDEBUG command driver - EXECUTE INTERPRETER COMMAND
	AX = D102h
	BL = first character of the interpreter command
	BH = last character of the interpreter command (or blank)
	DS:SI -> parameter for the interpreter command as ASCIZ string
	DS:DI -> MDEBUG data structure (see #03078)
Return: AL = FFh
	CF set on error
	    AH = error number (see #03077)
	    DS:SI -> ASCIZ error message (max 30 characters) if AH=0Ch
	CF clear if successful
	    AH = return code
		00h continue processing the command line
		01h leave MDEBUG popup session
		02h leave MDEBUG popup session and automatically popup again
		      if the InDOS flag is zero
		03h not used (same as 00h)
		04h not used (same as 00h)
		05h put new command line into the input buffer,
		    DS:SI -> new command line (ASCIZ string, max 66 chars)
		06h process new command line
		    DS:SI -> new command line (ASCIZ string, max 66 chars)
	       else unknown status, but continue processing commmand line
Note:	this function must end with a far call to the old INT 2F handler (with
	  registers unchanged) if the driver does not support the interpreter
	  command in BX.  Otherwise, the driver must not chain to the old
	  INT 2F.

(Table 03077)
Values for MDEBUG error number:
 01h	syntax error
 02h	first shell of the command.com is activ
 03h	Esc pressed
 04h	break pressed
 05h	DOS is busy
 06h	command ended
 07h	division by zero
 08h	invalid display driver
 09h	invalid command driver
 0Ah	error 8 and 9
 0Bh	unknown error
 0Ch	new error
 else	unknown error

Format of MDEBUG data structure:
Offset	Size	Description	(Table 03078)
 00h	WORD	register SE
 02h	WORD	register OF
 04h	WORD	register FS
 06h	WORD	register FO
 08h	WORD	register AX
 0Ah	WORD	register BX
 0Ch	WORD	register CX
 0Eh	WORD	register DX
 10h	WORD	register SI
 12h	WORD	register DI
 14h	WORD	register DS
 16h	WORD	register ES
 18h	WORD	register BP
 1Ah	WORD	register SS
 1Ch	WORD	register SP
 1Eh	WORD	register FL (flags)
 20h	WORD	register R0
 22h	WORD	register R1
 24h	WORD	register R2
 26h	WORD	register R3
 28h	WORD	register R4
 2Ah	WORD	register R5
 2Ch	WORD	register R6
 2Eh	WORD	register R7
 30h	WORD	register R8
 32h	WORD	register CS, return-address
 34h	WORD	register IP, return-address
 36h	DWORD	saved pointer to data for key <F6> (v1.60)
		saved monitor address (v1.70)
 3Ah 12 WORDs	saved register values on last popup entry (for <F8> key)
		(original register values at popup entry of MDEBUG)
		AX, BX, CX, DX, SI, DI, DS, ES, BP, SS, SP, flags
 52h 12 WORDs	saved register values on last popup exit (for <SHIFT-F8> key)
		AX, BX, CX, DX, SI, DI, DS, ES, BP, SS, SP, flags
 6Ah	DWORD	address of the DOS-invars-table
 6Eh	DWORD	address of the InDOS flag
 72h	WORD	offset of the register which is used for the segment of the
		  first monitor window
 74h	WORD	offset of the register which is used for the offset of the
		  first monitor window
 76h	WORD	name of the register which is used for the segment of the
		  first monitor segment
 78h	WORD	name of the register which is used for the offset of the first
		  monitor window
 7Ah	WORD	pseudo register 1
 7Ch	WORD	pseudo register 2
--------G-2FD103-----------------------------
INT 2F - MDEBUG command driver - EXECUTE KEY IN THE MONITOR
	AX = D103h
	BX = key code (like result of an interrupt 16h call)
	CX = cursor position
	    0000h in the ASCII column of the monitor
	    0001h in one of the hex fields of the monitor
	DS:SI -> MDEBUG data structure (see #03078)
	ES:DI -> actual byte in the monitor
Return: AL = FFh
	AH = return code
	    00h key processed, read next key
	    01h leave MDEBUG popup session
	    02h leave MDEBUG popup session and automatically popup again if DOS
		  is not busy
	    03h signal an error (beep)
	    04h driver has redefined the key, proceed with the new key
		BX = new key code
		MDEBUG will not pass the new key to the command driver(s)
	   else treat like code 00h
Note:	this function must end with a far call to the old INT 2F handler (with
	  registers unchanged) if the driver does not support the key in BX.
	  Otherwise, the driver must not chain to the old INT 2F.
SeeAlso: AX=D104h
--------G-2FD104-----------------------------
INT 2F - MDEBUG command driver - EXECUTE KEY IN THE INTERPRETER
	AX = D104h
	DS:SI -> MDEBUG data structure (see #03078)
Return: AL = FFh
	AH = return code
	    00h key processed, read next key
	    01h leave MDEBUG popup session
	    02h leave MDEBUG popup session and automactically popup again if
		  DOS is not busy
	    03h signal an error (beep)
	    04h driver has redefined the key, proceed with the new key
		BX = new key code
		MDEBUG won't pass the new key to the command driver(s)
	    05h put new command line into the input buffer
		DS:SI -> new command line (ASCIZ string, max 66 chars)
	    06h process new command line
		DS:SI -> new command line (ASCIZ string, max 66 chars)
	   else treat like code 00h
Note:	this function must end with a far call to the old INT 2F handler if the
	  driver does not support the key in BX.  Otherwise, the driver must
	  not chain to the old INT 2F.
SeeAlso: AX=D103h
--------G-2FD1-------------------------------
INT 2F - MDEBUG command driver - RESERVED FUNCTIONS
	AH = D1h
	AL = 05h-0Ah
Note:	these functions are reserved for future use
--------G-2FD110-----------------------------
INT 2F - MDEBUG command driver - GET ADDRESS OF THE OLD INT 2F
	AX = D110h
Return: DL = FFh
	ES:BX -> next program in the chain for INT 2F
	CX = code segment of this driver
	DI = offset of driver identification table (see #03079) (v1.60+)
Notes:	only called by the transient part of the driver
	must be reentrant and the driver must not chain this function to the
	  old INT 2F

Format of the MDEBUG driver identification table:
Offset	Size	Description	(Table 03079)
 00h  26 BYTEs	 signature "Kommandotreiber fÅr MDEBUG"
					     ^- Note: ASCII 129,German U-umlaut
 27h  12 BYTEs	 name of driver, e.g. "MDHISDRV.COM"
		 each driver must have a unique name
--------G-2FD111-----------------------------
INT 2F - MDEBUG command driver - START DRIVER
	AX = D111h
Return: DL = FFh
Notes:	only called by the transient part of the driver to inform the resident
	  part that it is installed
	the function must be reentrant and the driver mustn't chain this
	  function to the old INT 2F
SeeAlso: AX=D101h,AX=D112h
--------G-2FD112-----------------------------
INT 2F - MDEBUG command driver - END DRIVER
	AX = D112h
Return: DL = FFh
Notes:	only called by the transient part of the driver to inform the resident
	  part that it will be released after this function
	the function must be reentrant and the driver mustn't chain this
	  function to the old INT 2F
SeeAlso: AX=D101h,AX=D111h
--------G-2FD1-------------------------------
INT 2F - MDEBUG command driver - RESERVED FUNCTIONS
	AH = D1h
	AL = 13h-7Fh
Note:	these functions are reserved for future use
--------G-2FD1-------------------------------
INT 2F - MDEBUG command driver - USER DEFINED FUNCTIONS
	AH = D1h
	AL = 80h-FFh
Note:	these functions are reserved for user defined features (e.g.
	  communication between the transient und resident parts of the driver)
--------U-2FD200-----------------------------
INT 2F - PCL-838.EXE - INSTALLATION CHECK
	AX = D200h
Return: AL = FFh if installed??? (documented as AX = return value)
Program: PCL-838 is a resident utility for controlling a stepmotor adapter
	  board by Advantec
SeeAlso: AX=D201h"PCL-838",AX=D202h"PCL-838"
--------Q-2FD200BX5144-----------------------
INT 2F - Quarterdeck RPCI - INSTALLATION CHECK
	AX = D200h
	BX = 5144h ("QD")
	CX = 4D45h ("ME")
	DX = 4D30h ("M0")
Return: AL = FFh installed
	if BX,CX,DX registers were as specified on entry:
	    BX = 4D45h ("ME")
	    CX = 4D44h ("MD")
	    DX = 5652h ("VR")
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
Notes:	the Quarterdeck RPCI (Resident Program Communication Interface) is
	  supported by QEMM v5.0+, QRAM, MANIFEST, VIDRAM, etc.
	for AL <> 0, if the BX/CX/DX values don't match the identifier of a
	  Quarterdeck product, it just chains to the previous INT 2F handler
SeeAlso: AX=D201h/BX=4849h,AX=D201h/BX=4D41h,AX=D201h/BX=4D45h
SeeAlso: AX=D201h/BX=5145h,AX=D201h/BX=5649h
--------U-2FD201-----------------------------
INT 2F - PCL-838.EXE - UNINSTALL
	AX = D201h
Return: AX = return value
SeeAlso: AX=D200h"PCL-838",AX=D202h"PCL-838"
--------m-2FD201BX4849-----------------------
INT 2F - Quarterdeck RPCI - GET QD HIMEM PRESENCE
	AX = D201h
	BX = 4849h ("HI")
	CX = 4D45h ("ME")
	DX = 4D51h ("MQ")
Return: BX = 4F4Bh ("OK")
	ES:DI -> HIMEM entry point
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
SeeAlso: AX=D200h,AX=D201h/BX=5145h
--------m-2FD201BX4849-----------------------
INT 2F - Quarterdeck RPCI - QEMM/QRAM v5.0+ - GET HIRAM MEMORY CHAIN
	AX = D201h
	BX = 4849h ("HI")
	CX = 5241h ("RA")
	DX = 4D30h ("M0")
Return: BX = 4F4Bh ("OK")
	CX = segment of start of HIRAM chain
	DX = reserved block owner (QEMM/QRAM code segment)
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
Note:	the HIRAM memory chain has the same format as the regular DOS 4.0
	  memory chain (see #01628 at INT 21/AH=52h), except that XMS Upper
	  Memory Blocks have the block header program name field set to
	  "UMB"; blocks whose "owner" field is set to the reserved segment
	  returned in DX are locked-out regions such as video memory and ROMs.
SeeAlso: AX=12FFh/BX=0006h,AX=D200h
--------G-2FD201BX4D41-----------------------
INT 2F U - Quarterdeck RPCI - MANIFEST v1.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 4D41h ("MA")
	CX = 4E49h ("NI")
	DX = 4645h ("FE")
Return: BX = 5354h ("ST") if installed
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
SeeAlso: AX=D200h
--------E-2FD201BX4D45-----------------------
INT 2F U - Quarterdeck RPCI - DVDOS4GX.DVR - ???
	AX = D201h
	BX = 4D45h ("ME")
	CX = 5155h ("QU")
	DX = 5044h ("PD")
Return: AL = FFh
	BX = 4F4Bh ("OK")
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
Note:	this function is called by QEMM 6.03
	performs a variety of actions before setting return registers
SeeAlso: AX=D200h
--------m-2FD201BX5145-----------------------
INT 2F - Quarterdeck RPCI - QEMM v5.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 5145h ("QE")
	CX = 4D4Dh ("MM")
	DX = 3432h ("42")
Return: BX = 4F4Bh ("OK")
	ES:DI -> QEMM API entry point (see INT 67/AH=3Fh)
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
Note:	this call is not available under QEMM v6.00 unless Windows3 support
	  has been disabled with the NW3 switch to QEMM386.SYS
SeeAlso: AX=D200h,AX=D201h/BX=4849h,INT 67/AH=3Fh
--------V-2FD201BX5649-----------------------
INT 2F u - Quarterdeck RPCI - VIDRAM v5.0+ - INSTALLATION CHECK
	AX = D201h
	BX = 5649h ("VI")
	CX = 4452h ("DR")
	DX = 414Dh ("AM")
Return: BX = 4F4Bh ("OK")
	ES:DI -> VIDRAM entry point (see #03080)
Range:	AH=C0h to AH=FFh, selected by scanning AH=D2h-FFh, then AH=C0h-D1h
SeeAlso: AX=D200h

(Table 03080)
Call VIDRAM entry point with:
	AH = 00h get status
		Return: AL = VIDRAM state (see #03081)
			BL = extra RAM status (see #03082)
			BH = feature flags (see #03083)
			CL = current monitor (01h = mono, 80h = color)
			SI = current top of memory (paragraph)
			DI = segment of start of HiRAM chain
	AH = 01h setup
		AL = VIDRAM state (see #03081)
		BL = extra RAM status (see #03082)
		BH = feature flags (see #03083)
		CL = monitor (01h = monochrome, 80h = color)
		SI = new top of memory (paragraph)
		DI = segment of start of HiRAM chain
	AH = 02h get end address of VIDRAM code
		Return: ES:DI -> VIDRAM partial map context (see #03084,#03085)
Return: CF set on error
	CF clear if successful

(Table 03081)
Values for VIDRAM state:
 00h	off
 01h	no EGA graphics
 02h	no graphics at all

(Table 03082)
Values for VIDRAM extra RAM status:
 00h	VIDRAM does not use extra RAM
 01h	VIDRAM uses EMS as extra RAM
 02h	VIDRAM uses EGA as extra RAM

Bitfields for VIDRAM feature flags:
Bit(s)	Description	(Table 03083)
 0	override enabled
 1	mapped memory detected in A000h-B000h range
 2	top of memory not at 640K
 3	MDA detected
 4	high RAM exists in video area
 5	mapped memory detected in video area
 6-7	reserved???

Format of VIDRAM partial map context (EMS 3.2):
Offset	Size	Description	(Table 03084)
 00h	BYTE	EMS version ID (32h)
 01h	WORD	EMM handle for this entry
 03h	BYTE	number of frames
 04h	BYTE	first page frame
 05h	WORD	offset from ES to previously saved map

Format of VIDRAM partial map context (EMS 4.0):
Offset	Size	Description	(Table 03085)
 00h	BYTE	EMS version ID (40h)
 01h	WORD	mappable segment count
 03h  N WORD	mappable segments
	WORD	offset to previously saved map???
--------U-2FD202-----------------------------
INT 2F - PCL-838.EXE - EXECUTE PCL838 COMMANDS
	AX = D202h
	CX:BX -> parameter table
Return: AX = return value
SeeAlso: AX=D200h"PCL-838",AX=D201h"PCL-838"
--------R-2FD300BX4562-----------------------
INT 2F U - TeleReplica - INSTALLATION CHECK
	AX = D300h
	BX = 4562h
	CX = 2745h
	DX = serial port I/O base address??? (03F8h for v3.9)
Return: SI = segment of resident code
	AX = 251Dh
	BX = DF21h
	CX = F321h
	DX = ???
--------R-2FD3CB-----------------------------
INT 2F U - LapLink Quick Connect v6 - API
	AX = D3CBh
	CX = function
	    0002h get ???
		Return: BX:AX -> ???
			CL = ???
			CH = ???
			DX = ???
			DI = COM1 I/O port???
			SI = COM2 I/O port???
	    0003h initialization???
	    0004h ???
	    0005h initialization???
	    0006h reset/clear ???
		Return: AX = 0000h
			ES:DI -> next byte after ??? cleared by this call
	    0007h initialization???
	    0008h uninstall
		Return: BX = status
			    0000h successful
			    FFFFh incomplete, stub remains in memory
Return: CX = 534Bh (except function 0002h)
Index:	uninstall;LapLink Quick Connect
--------K-2FD3D3BH00-------------------------
INT 2F - KDRIVE v2.x - INSTALLATION CHECK
	AX = D3D3h
	BH = 00h
Return: BX = 3D3Dh if installed
	CF clear if installed
	    AX = driver ID??? (returns 0087h for KDRIVE.EXE and 0880h for
		  KDRIVOS2.EXE in one examined version)
Program: KDRIVE is a shareware extended German keyboard driver by Martin
	  Austermeier, originally based on K3 by Martin Gerdes as published
	  in c't magazine 7/1988
--------l-2FD44D-----------------------------
INT 2F - 4DOS.COM v2.1+ - API
	AX = D44Dh
	BH = function
	    00h installation check
		Return: AX = 44DDh
			BL = major version number
			BH = minor version number
			CX = PSP segment address for current invocation
			DL = 4DOS shell number (0 for the first (root) shell,
			      updated each time a new copy is loaded)
	    01h (internal, v2.1-3.03) terminate current copy of 4DOS
		Return: nothing
		(internal, v4.0+) ???
		Return: AX = 44DDh
			ES:BX -> data area (see #03086)
	    02h ???
		DX = ???
		Note:	v5.52 signals "unrecoverable error" and then terminates
			  with INT 21/AH=4Ch or enters a deliberate infinite
			  loop if ???
	---v2.1-3.03 only---
	    03h EXEC program
		CX:DX -> EXEC record (see #03087)
	    FEh deallocate shell number (passed through to root shell)
		???
	    FFh allocate shell number (passed through to root shell)
	---v5.52---
	    03h get ???
		BL = ??? (00h/01h)
		Return: DX = current value of ???
	    04h set ???
		BL = ??? (00h/01h)
		DX = new value for ???
Note:	a bug in v3.00 will crash the system if unrecognized value in BH
SeeAlso: AX=D44Eh,AX=D44Fh/BX=0000h,AX=E44Dh,INT 21/AX=4403h"DOS"
SeeAlso: INT 14/AX=7000h
Index:	installation check;4DOS|installation check;NDOS

Format of 4DOS v4.0 data area:
Offset	Size	Description	(Table 03086)
 00h  2 BYTEs	???
 06h	WORD	XMS handle for swapping
	???
SeeAlso: #03087

Format of 4DOS EXEC v2.1-v3.03 record:
Offset	Size	Description	(Table 03087)
 00h	WORD	offset of ASCIZ program name in same segment as EXEC record
 02h	WORD	offset of DOS commandline in same segment as EXEC record
 04h	WORD	segment of environment for child process (see INT 21/AH=26h)
SeeAlso: #03086
--------l-2FD44E-----------------------------
INT 2F C - 4DOS v3.0+ - AWAITING USER INPUT
	AX = D44Eh
---4DOS v3.01+---
	BX = condition
	    0000h 4DOS is ready to display prompt
	    0001h 4DOS has displayed the prompt, about to accept user input
Return: the handler must preserve SI, DI, BP, SP, DS, ES, and SS
Note:	v3.00 only makes the call corresponding to BX=0001h, does not set BX
SeeAlso: AX=D44Dh
--------K-2FD44FBX0000-----------------------
INT 2F - 4DOS v4.0+ - KSTACK.COM - INSTALLATION CHECK
	AX = D44Fh
	BX = 0000h
Return: AX = 44DDh if installed
Note:	this function is also supported by ANSIPLUS v3.01+ and K3PLUS v6.20+,
	  which emulate the 4DOS and NDOS keystack
SeeAlso: AX=D44Dh,AX=D44Fh/BX=0001h,AX=E44Fh/BX=0000h
--------K-2FD44FBX0001-----------------------
INT 2F - 4DOS v4.0+ - KSTACK.COM - PLACE KEYSTROKES INTO KEYSTACK
	AX = D44Fh
	BX = 0001h
	CX = number of keystrokes (01h-FFh)
	DS:DX -> keystroke list (one word per keystroke)
Return: AX = status
	    0000h successful
	    nonzero failed
	BX,CX,DX destroyed
Notes:	the keystrokes are the exact values to return from subsequent calls to
	  INT 16 with AH=00h,01h,10h, or 11h, with the following exceptions:
		0000h causes subfunctions 01h and 11h to indicate an empty
		      keyboard buffer
		FFFFh is followed by a word indicating the number of clock
		      ticks to delay before the next faked keystroke
	v4.00 KSTACK overwrites any unread keystrokes from the previous
	  invocation, and does not range-check CX; it will overwrite memory
	  following the resident portion if CX is greater than 100h.
	this function is also supported by ANSIPLUS v3.01+ and K3PLUS v6.20+,
	  which emulate the 4DOS and NDOS keystack
SeeAlso: AX=D44Dh,AX=D44Fh/BX=0000h,INT 16/AH=00h,INT 21/AX=4403h"DOS"
--------G-2FD600-----------------------------
INT 2F - HEART.COM - INSTALLATION CHECK
	AX = D600h
Return: AX = 0303h (two hearts) if installed
	    ES:DI -> buffer (see #03088)
Program: HEART.COM is a CPU lock-up/critical indicator utility by Mitch Davis.
Notes:	Once the host program has identified the address of the data area, it
	  can change this to indicate safe/critical, alternate colours, etc.
	The entries for the color table are in char/attrib form.  Every two
	  entries form a pair which is alternated between 68 times a minute.
	  The first half of the table is for color videos, the second mono.
	  Within each half, the first half is for the safe chars, and the
	  second for the critical chars.

Format of HEART.COM buffer:
Offset	Size	Description	(Table 03088)
 00h  8 WORDs	table of colors/attributes (refer to notes above)
 10h	BYTE	flags
		bit 0: program is in critical section, so flash double
		      exclamation mark
		bit 1: program is in safe code, so flash the heart character
 11h	WORD	position of heartbeat on screen, normally 009Eh (last column
		of second line)
--------T-2FD600-----------------------------
INT 2F U - VEDIT VSWAP - INSTALLATION CHECK
	AX = D600h
Return: AL = D6h if installed
Program: VSWAP is the resident portion of VEDIT's "swapper" capability; VEDIT
	  is a programmer's text editor by Greenview Data.
SeeAlso: AX=D601h,AX=D602h
--------T-2FD601-----------------------------
INT 2F U - VEDIT VSWAP - ???
	AX = D601h
	BL = subfunction number???
Return: BL = return code ???
	ES = resident portion's data??? segment
	DX = resident portion's code segment
SeeAlso: AX=D600h"VSWAP"
--------T-2FD602-----------------------------
INT 2F U - VEDIT VSWAP - EXEC PROGRAM WITH SWAP
	AX = D602h
	other registers set as for INT 21/AX=4B00h
Return: CF set on error
	    AL = error code
		82h = failure due to ???
	CF clear on success
SeeAlso: AX=D600h"VSWAP",INT 21/AH=4Bh"EXEC"
--------N-2FD701BX0000-----------------------
INT 2F - Banyan VINES v4+ - GET BANV INTERRUPT NUMBER
	AX = D701h
	BX = 0000h
Return: AX = 0000h if installed
	    BX = interrupt number (60h to 66h)
	   nonzero not present
Note:	if AX is nonzero, VINES 3.x or earlier may be installed, thus it is
	  necessary to examine the four bytes preceding the handlers for
	  INT 60 through INT 66 for the string "BANV"
SeeAlso: AX=D702h,AX=D703h,AX=D704h
--------N-2FD702-----------------------------
INT 2F U - Banyan VINES v4+ - PCPRINT interface
	AX = D702h
	BX = function
	???
Return: ???
SeeAlso: AX=D701h,AX=D703h,INT 61/AX=0005h"Banyan"
--------N-2FD703-----------------------------
INT 2F U - Banyan VINES v4+ - MAIL interface
	AX = D703h
	BX = function
	???
Return: ???
SeeAlso: AX=D702h,AX=D704h
--------N-2FD704-----------------------------
INT 2F U - Banyan VINES v4+ - Streettalk Directory Assistance interface
	AX = D704h
	BX = function
	???
Return: ???
SeeAlso: AX=D703h,INT 61/AX=0007h/BX=0002h"Banyan",INT 61/AX=0007h/BX=0008h
--------N-2FD800-----------------------------
INT 2F U - Novell NetWare Lite - CLIENT.EXE - INSTALLATION CHECK
	AX = D800h
Return: AL = FFh if installed
	    DX = version number (0100h for v1.0, 0101h for v1.1)
	    BX = data segment of resident copy
	    ES:DI -> private API entry point (see #03089)
	    SI = segment of resident code
Note:	Microsoft assigned multiplex number D8h to Novell on 1991/05/21
SeeAlso: AX=7A00h,AX=D880h

(Table 03089)
Call CLIENT API entry point with:
	BX = function
	    0000h get ???
		Return: DX = CLIENT version??? (0101h for v1.1)
			ES:BX -> ??? data
	    0001h ???
	    0002h ???
	    0003h ???
	    0004h ???
	    0005h ???
		DL = ???
		???
		Return: ???
	    0006h get module name???
		ES:DI -> 16-byte buffer
		Return: CX = ???
			ES:DI filled with "NWLITE_CLIENT" 00h 00h 00h
	    0007h ???
		DX:CX = ???
		???
		Return: ???
	    0008h ???
	    0009h ???
		DL = ???
		ES:DI -> 16-byte buffer for ???
		Return: CF clear if successful
			    AX = 0000h
			    CX = 0000h
			    SI,DI destroyed
			CF set on error
			    AX = error code 4903h
	    000Ah ???
		AH = subfunction
		    00h get ???
		    01h clear/set ??? flag
			AL = new state (00h cleared, 01h set)
		    02h set ???
			DX = new value of ???
		Return: DX = old value of ???
	    000Bh ???
		AX = ???
		???
		Return: ???
	    000Ch ???
		AX = ???
		???
		Return: ???
	    000Dh ???
		AX = ???
		???
		Return: ???
	    000Eh get original INT 17
		Return: CF clear
			ES:BX -> original INT 17
	    000Fh ???
	    0010h ???
		AX = ???
		???
		Return: ???
	    0011h get ???
		Return: CF clear
			DL = ???
	    0012h get ???
		AL = index of ???
		ES:DI -> 10-byte buffer for ???
		Return: CF clear if successful
			    ES:DI buffer filled
			    AX,CX destroyed
			CF set on error
			    AX = error code (4907h if AL out of range)
	    0013h get ???
		Return: CF clear
			DH = ???
			DL = ???
	    0014h ???
		DL = ???
		???
		Return: CF clear if successful
			    ???
			CF set on error
			    AX = error code 8056h
	    0015h ???
		DX = ???
		Return: ES:DI -> ???
	    other
		Return: CF set
			AX = 0001h (invalid function)
--------N-2FD856-----------------------------
INT 2F U - Novell NetWare Lite v1.1 - SERVER - "VNWLSERV_INIT" - GET ???
	AX = D856h
Return: AX = 0001h if supported???
	BX = ??? (0004h for v1.1)
	CX = ??? (0F20h for v1.1)
	DS = segment of resident code
	ES = data segment of resident copy
Note:	this function is also supported by Personal NetWare SERVER, bundled
	  with Novell DOS 7
--------N-2FD880-----------------------------
INT 2F U - Novell NetWare Lite v1.0+ - SERVER - INSTALLATION CHECK
	AX = D880h
Return: AL = FFh if installed
	    DX = version number (binary, DH = major, DL = minor)
	    BX = data segment of resident copy
	    CL = current state (00h SERVER is disabled, 01h SERVER is active)
	    ES:DI -> private API entry point (see #03090)
	    SI = ??? (offset of configuration info?)
	    AH may be destroyed
Note:	this function is also supported by Personal NetWare SERVER, but DI is
	  not set; instead, ES:SI points at the API entry point
SeeAlso: AX=7A00h,AX=D800h,INT 2A/AX=D852h

(Table 03090)
Call SERVER API entry point with:
	BX = function
	    0000h shut down server
		???
		Return: ???
		Note: closes open files by calling INT 21/AH=3Eh
	    0001h get connection information
		DX = connection number (0001h-max connections)
		ES:DI -> 28-byte buffer for connection information
		Return: CF clear if successful
			    ES:DI buffer filled
			CF set on error
			    AX = FFFFh
	---Personal NetWare only---
	    0002h ???
	    0003h ???
	    0004h ???
	    0005h ???
	    0006h get server info table
		  CX = size of buffer
		  ES:DI -> buffer
		  AL = mode (02h = get current status)
	    0007h ???
	    other
		Return: CF set
			AX = 0001h (invalid function)
--------d-2FD8C0-----------------------------
INT 2F U - Novell NLCACHE,NWCACHE - INSTALLATION CHECK
	AX = D8C0h
Return: AL = FFh if installed
	    CL = memory type (01h NLCACHEC, 02h NLCACHEX, 03h NLCACHEM)
	    DH = major version (01h for v1.1)
	    DL = minor version (01h for v1.1)
	    ES:DI -> private API entry point (see #03091)
Program: NWCACHE is the disk cache included with Personal NetWare,
	    Novell DOS 7, Caldera OpenDOS 7.01, DR-OpenDOS 7.02, DR-DOS 7.02,
	    and Caldera Thin Clients/Lineo DR-DOS 7.03.
Note:	This function is called by the NetWare Lite and Personal NetWare
	  SERVER.  It may also be called by future (post DR-DOS 7.03)
	  COMMAND.COM before it returns to the prompt.
BUG:	Some pre-BETA 17 (1993/09/28) versions of NWCACHE returned -1,0,1
	  instead of 1,2,3 for the memory type in CL.
SeeAlso: AX=D800h,AX=D880h

(Table 03091)
Call NLCACHE/NWCACHE "sideband function" API entry point with:
	BX = function
	    0000h flush request from server
		Return: CF clear if successful at flushing deferred writes
			    AX = 0000h
			CF set on error
			    AX = error code
	    0001h (NWCACHE only) get cache statistics
		ES:DI -> buffer for statistics (see #04122)
		Return: CF clear if successful
			AX = 0000h
			ES:DI buffer filled
	    other
		Return: CF set
			AX = 0001h (invalid function)

Format of NWCACHE cache statistics:
Offset	Size	Description	(Table 04122)
 00h	WORD	version
 02h	BYTE	memory type
 03h	WORD	initial cache size in KB
 05h	WORD	current cache size in KB
 07h	DWORD	number of read requests
 0Bh	DWORD	number of physical reads performed
 0Fh	DWORD	number of write requests
 13h	DWORD	number of physical writes performed
 17h	BYTE	delay ticks for deferred write (0 if no deferral)
 18h	WORD	maximum number of sectors in lookahead buffer
 1Ah	WORD	number of disk errors
 1Ch	WORD	number of cache memory errors
SeeAlso: #03091
--------!---Section--------------------------
