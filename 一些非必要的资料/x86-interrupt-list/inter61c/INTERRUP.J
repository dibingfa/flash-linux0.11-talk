Interrupt List, part 10 of 18
Copyright (c) 1989-1999,2000 Ralf Brown
--------N-21F2-------------------------------
INT 21 u - Novell NetWare v3.01+ shell interface - MULTIPLEXOR
	AH = F2h
	AL = function (see #02095)
	    (subfunction stored in various places in the request packet,
	    depending on function number; see individual entries)
	CX = length of request buffer
	DX = length of reply buffer (0000h if no reply packet)
	DS:SI -> request buffer
	ES:DI -> reply buffer (ignored if DX=0000h)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled as appropriate for function
Note:	this is a multiplexor providing a "raw" interface to the underlying
	  NetWare Core Protocol.  Many functions which were accessed via a
	  separate AH function in older versions can also be accessed here,
	  but some NetWare 3.x calls appear to be available only here.
SeeAlso: AX=F244h,AX=F268h/SF=3Dh,#02875

(Table 02095)
Values for NetWare Core Protocol functions:
Fnc/Subfn	Description
01h	File Set Lock
02h	File Release Lock
03h	Log File (old)					(see AX=F203h)
04h	Lock File Set (old)				(see AX=F204h)
05h	Release File				(see AH=CCh,AH=ECh"NetWare")
06h	Release File Set				(see AH=CDh"NetWare")
07h	Clear File					(see AH=CEh,AX=F207h)
08h	Clear File Set					(see AX=F208h)
09h	Log Logical Record (old)			(see AH=D0h"NetWare")
0Ah	Lock Logical Record Set (old)			(see AX=F20Ah)
0Bh	Clear Logical Record				(see AX=F20Bh)
0Ch	Release Logical Record				(see AH=D2h"NetWare")
0Dh	Release Logical Record Set			(see AH=D3h"NetWare")
0Eh	Clear Logical Record Set			(see AX=F20Eh)
0Fh	Allocate Resource				(see AH=D8h"NetWare")
10h	Deallocate Resource				(see AH=D9h"NetWare")
11h/xxh	print spooling					(see AH=E0h"NetWare")
11h/06h Get Printer Status
11h/0Ah	Get Printer Queue
12h	Get Volume Info with Number			(see AH=DAh"NetWare")
13h	Get Station Number				(see AH=DCh"NetWare")
14h	Get File Server Date and Time (NW v2.2+)	(see AH=E7h"NetWare")
15h/01h Get Broadcast Message (old)			(see AX=F215h/SF=01h)
15h/02h Disable Broadcasts				(see AX=F215h/SF=02h)
15h/03h Enable Broadcasts				(see AX=F215h/SF=03h)
15h/08h Check Pipe Status		(see AH=E1h/SF=08h,AX=F215h/SF=08h)
15h/09h Broadcast to Console		(see AH=E1h/SF=09h,AX=F215h/SF=09h)
15h/0Bh Get Broadcast Message				(see AX=F215h/SF=0Bh)
16h/00h Set Directory Handle				(see AX=F216h/SF=00h)
16h/01h Get Directory Path				(see AX=F216h/SF=01h)
16h/02h Scan Directory Information			(see AX=F216h/SF=02h)
16h/03h	Get Effective Directory Rights (old)		(see AX=F216h/SF=03h)
16h/04h Modify Maximum Rights Mask			(see AX=F216h/SF=04h)
16h/05h Get Volume Number				(see AX=F216h/SF=05h)
16h/06h Get Volume Name					(see AX=F216h/SF=06h)
16h/0Ah Create Directory				(see AX=F216h/SF=0Ah)
16h/0Bh Delete Directory				(see AX=F216h/SF=0Bh)
16h/0Ch Scan Directory for Trustees			(see AX=F216h/SF=0Ch)
16h/0Dh Add Trustee to Directory			(see AX=F216h/SF=0Dh)
16h/0Eh Delete Trustee from Directory			(see AX=F216h/SF=0Eh)
16h/0Fh	Rename Directory				(see AX=F216h/SF=0Fh)
16h/10h Purge Erased Files (old)			(see AX=F216h/SF=10h)
16h/11h Recover Erased File (old)			(see AX=F216h/SF=11h)
16h/12h Alloc Permanent Directory Handle		(see AX=F216h/SF=12h)
16h/13h Alloc Temporary Directory Handle		(see AX=F216h/SF=13h)
16h/14h Deallocate Directory Handle			(see AX=F216h/SF=14h)
16h/15h Get Volume Info with Handle			(see AX=F216h/SF=15h)
16h/16h Alloc Special Temporary Directory Handle	(see AX=F216h/SF=16h)
16h/19h Set Directory Information			(see AX=F216h/SF=19h)
16h/1Ah Get Path Name of Volume-Directory Number Pair	(see AX=F216h/SF=1Ah)
16h/1Bh	Scan Salvageable Files (old)			(see AX=F216h/SF=1Bh)
16h/1Ch	Recover Salvageable File (old)			(see AX=F216h/SF=1Ch)
16h/1Dh	Purge Salvageable File (old)			(see AX=F216h/SF=1Dh)
16h/1Eh	Scan a Directory				(see AX=F216h/SF=1Eh)
16h/1Fh	Get Directory Entry				(see AX=F216h/SF=1Fh)
16h/20h	Scan Volume's User Disk Restrictions		(see AX=F216h/SF=20h)
16h/21h	Add User Disk Space Restriction			(see AX=F216h/SF=21h)
16h/22h	Remove User Disk Space Restrictions		(see AX=F216h/SF=22h)
16h/23h	Scan Directory Space Restrictions		(see AX=F216h/SF=23h)
16h/24h	Set Directory Disk Space Restriction		(see AX=F216h/SF=24h)
16h/25h	Set Directory File Information			(see AX=F216h/SF=25h)
16h/26h	Scan File or Directory For Extended Trustees	(see AX=F216h/SF=26h)
16h/27h	Add Extended Trustee to Directory or File	(see AX=F216h/SF=27h)
16h/28h	Scan Directory Disk Space			(see AX=F216h/SF=28h)
16h/29h	Get Object Disk Usage and Restrictions		(see AX=F216h/SF=29h)
16h/2Ah	Get Effective Rights				(see AX=F216h/SF=2Ah)
16h/2Bh	Remove Extended Trustee from Dir or File	(see AX=F216h/SF=2Bh)
16h/2Ch	Get Volume Usage				(see AX=F216h/SF=2Ch)
16h/2Dh	Get Directory Information			(see AX=F216h/SF=2Dh)
16h/2Eh	Rename or Move					(see AX=F216h/SF=2Eh)
16h/2Fh	Get Name Space Information			(see AX=F216h/SF=2Fh)
16h/30h	Get Name Space Directory Entry			(see AX=F216h/SF=30h)
16h/31h	Open Data Stream				(see AX=F216h/SF=31h)
16h/32h	Get Object Effective Rights			(see AX=F216h/SF=32h)
16h/33h	Get Extended Volume Info			(see AX=F216h/SF=33h)
17h/01h Change User Password (old)			(see AX=F217h/SF=01h)
17h/02h Get User Connection List (old)			(see AX=F217h/SF=02h)
17h/0Ch Verify Serialization				(see AX=F217h/SF=0Ch)
17h/0Eh Get Disk Utilization				(see AX=F217h/SF=0Eh)
17h/0Fh Scan File Information				(see AX=F217h/SF=0Fh)
17h/10h Set File Information				(see AX=F217h/SF=10h)
17h/11h Get File Server Information			(see AX=F217h/SF=11h)
17h/12h Get Network Serial Number			(see AX=F217h/SF=12h)
17h/13h Get Internet Address (old)			(see AX=F217h/SF=13h)
17h/14h Login Object					(see AX=F217h/SF=14h)
17h/15h Get Object Connection List (old)		(see AX=F217h/SF=15h)
17h/16h	Get Connection Information (old)		(see AX=F217h/SF=1Ch)
17h/17h	Get Encryption Key				(see AX=F217h/SF=17h)
17h/18h	Login Object Encrypted				(see AX=F217h/SF=18h)
17h/1Ah Get Internet Address				(see AX=F217h/SF=1Ah)
17h/1Bh Get Object Connection List			(see AX=F217h/SF=1Bh)
17h/1Ch	Get Connection Information			(see AX=F217h/SF=1Ch)
17h/1Fh	Get Connection List from Object			(see AX=F217h/SF=1Fh)
17h/32h Create Bindery Object				(see AX=F217h/SF=32h)
17h/33h Delete Bindery Object				(see AX=F217h/SF=33h)
17h/34h Rename Bindery Object				(see AX=F217h/SF=34h)
17h/35h Get Bindery Object ID				(see AX=F217h/SF=35h)
17h/36h Get Bindery Object Name				(see AX=F217h/SF=36h)
17h/37h Scan Bindery Object				(see AX=F217h/SF=37h)
17h/38h Change Bindery Object Security			(see AX=F217h/SF=38h)
17h/39h Create Property					(see AX=F217h/SF=39h)
17h/3Ah Delete Property					(see AX=F217h/SF=3Ah)
17h/3Bh Change Property Security			(see AX=F217h/SF=3Bh)
17h/3Ch Scan Property					(see AX=F217h/SF=3Ch)
17h/3Dh Read Property Value				(see AX=F217h/SF=3Dh)
17h/3Eh Write Property Value				(see AX=F217h/SF=3Eh)
17h/3Fh Verify Bindery Object Password			(see AX=F217h/SF=3Fh)
17h/40h Change Bindery Object Password			(see AX=F217h/SF=40h)
17h/41h Add Bindery Object to Set			(see AX=F217h/SF=41h)
17h/42h Delete Bindery Object from Set			(see AX=F217h/SF=42h)
17h/43h Is Bindery Object in Set			(see AX=F217h/SF=43h)
17h/44h Close Bindery					(see AX=F217h/SF=44h)
17h/45h Open Bindery					(see AX=F217h/SF=45h)
17h/46h Get Bindery Access Level			(see AX=F217h/SF=46h)
17h/47h Scan Bindery Object Trustee Paths		(see AX=F217h/SF=47h)
17h/48h	Get Bindery Object Access Level			(see AX=F217h/SF=48h)
17h/49h	Is Station a Manager?				(see AX=F217h/SF=49h)
17h/4Ah	Keyed Verify Bindery Object Password		(see AX=F217h/SF=4Ah)
17h/4Bh	Keyed Change Bindery Object Password		(see AX=F217h/SF=4Bh)
17h/4Ch	List Relations of an Object			(see AX=F217h/SF=4Ch)
17h/64h Create Queue					(see AX=F217h/SF=64h)
17h/65h Destroy Queue					(see AX=F217h/SF=65h)
17h/66h Read Queue Current Status (old)			(see AX=F217h/SF=66h)
17h/67h Set Queue Current Status (old)			(see AX=F217h/SF=67h)
17h/68h Create Queue Job and File (old)			(see AX=F217h/SF=68h)
17h/69h Close File and Start Queue Job (old)		(see AX=F217h/SF=69h)
17h/6Ah Remove Job From Queue (old)			(see AX=F217h/SF=6Ah)
17h/6Bh Get Queue Job List (old)			(see AX=F217h/SF=6Bh)
17h/6Ch Read Queue Job Entry (old)			(see AX=F217h/SF=6Ch)
17h/6Dh Change Queue Job Entry (old)			(see AX=F217h/SF=6Dh)
17h/6Eh Change Queue Job Position			(see AX=F217h/SF=6Eh)
17h/6Fh Attach Queue Server to Queue			(see AX=F217h/SF=6Fh)
17h/70h Detach Queue Server from Queue			(see AX=F217h/SF=70h)
17h/72h Finish Servicing Queue Job (old)		(see AX=F217h/SF=72h)
17h/74h Change to Client Rights (old)			(see AX=F217h/SF=74h)
17h/75h Restore Queue Server Rights			(see AX=F217h/SF=75h)
17h/76h Read Queue Server Current Status (old)		(see AX=F217h/SF=76h)
17h/77h Set Queue Server Current Status			(see AX=F217h/SF=77h)
17h/78h Get Queue Job File Size (old)			(see AX=F217h/SF=78h)
17h/79h Create Queue Job and File			(see AX=F217h/SF=79h)
17h/7Ah Read Queue Job Entry				(see AX=F217h/SF=7Ah)
17h/7Bh Change Queue Job Entry				(see AX=F217h/SF=7Bh)
17h/7Dh Read Queue Current Status			(see AX=F217h/SF=7Dh)
17h/7Eh Set Queue Current Status			(see AX=F217h/SF=7Eh)
17h/7Fh Close File and Start Queue Job			(see AX=F217h/SF=7Fh)
17h/80h Remove Job From Queue				(see AX=F217h/SF=80h)
17h/81h Get Queue Job List				(see AX=F217h/SF=81h)
17h/82h Change Job Priority				(see AX=F217h/SF=82h)
17h/83h Finish Servicing Queue Job			(see AX=F217h/SF=83h)
17h/85h Change to Client Rights				(see AX=F217h/SF=85h)
17h/86h Read Queue Server Current Status		(see AX=F217h/SF=86h)
17h/87h Get Queue Job File Size				(see AX=F217h/SF=87h)
17h/96h Get Account Status				(see AX=F217h/SF=96h)
17h/97h Submit Account Charge				(see AX=F217h/SF=97h)
17h/98h Submit Account Hold				(see AX=F217h/SF=98h)
17h/99h Submit Account Note				(see AX=F217h/SF=99h)
17h/C8h Check Console Privileges			(see AX=F217h/SF=C8h)
17h/C9h Get File Server Description Strings		(see AX=F217h/SF=C9h)
17h/CAh Set File Server Date and Time			(see AX=F217h/SF=CAh)
17h/CBh Disable File Server Login			(see AX=F217h/SF=CBh)
17h/CCh Enable File Server Login			(see AX=F217h/SF=CCh)
17h/CDh Get File Server Login Status			(see AX=F217h/SF=CDh)
17h/CEh Purge All Erased Files				(see AX=F217h/SF=CEh)
17h/CFh Disable Transaction Tracking			(see AX=F217h/SF=CFh)
17h/D0h Enable Transaction Tracking			(see AX=F217h/SF=D0h)
17h/D2h Clear Connection Number (Logout Station)	(see AX=F217h/SF=D2h)
17h/D3h Down File Server				(see AX=F217h/SF=D3h)
17h/D4h Get File System Statistics			(see AX=F217h/SF=D4h)
17h/D5h Get Transaction Tracking Statistics		(see AX=F217h/SF=D5h)
17h/D6h Get Disk Cache Statistics			(see AX=F217h/SF=D6h)
17h/D7h Get Drive Mapping Table				(see AX=F217h/SF=D7h)
17h/D8h Get Physical Disk Statistics			(see AX=F217h/SF=D8h)
17h/D9h Get Disk Channel Statistics			(see AX=F217h/SF=D9h)
17h/DAh Get Connection's Task Information (NW v2.2)	(see AX=F217h/SF=DAh)
17h/DBh Get Connection's Open Files (old) (NW v2.2)	(see AX=F217h/SF=DBh)
17h/DCh Get Connections Using a File (NW v2.2)		(see AX=F217h/SF=DCh)
17h/DDh Get Physical Record Locks by Connection and File (old)
17h/DEh	Get Physical Record Locks by File (old)		(see AX=F217h/SF=DEh)
17h/DFh Get Logical Records by Connection (old)		(see AX=F217h/SF=DFh)
17h/E0h Get Logical Record Information (old)		(see AX=F217h/SF=E0h)
17h/E1h Get Connection's Semaphores (old)		(see AX=F217h/SF=E1h)
17h/E2h Get Semaphore Information (old)			(see AX=F217h/SF=E2h)
17h/E3h Get LAN Driver's Configuration Information	(see AX=F217h/SF=E3h)
17h/E5h Get Connection's Usage Statistics (NW v2.2)	(see AX=F217h/SF=E5h)
17h/E6h Get Object's Remaining Disk Space		(see AX=F217h/SF=E6h)
17h/E7h Get File Server LAN I/O Statistics		(see AX=F217h/SF=E7h)
17h/E8h Get File Server Misc Information		(see AX=F217h/SF=E8h)
17h/E9h Get Volume Information				(see AX=F217h/SF=E9h)
17h/EAh Get Connection's Task Information (NW v3.11+)	(see AX=F217h/SF=EAh)
17h/EBh	Get Connection's Open Files (NW v3.11+)		(see AX=F217h/SF=EBh)
17h/ECh	Get Connections Using a File (NW v3.11+)	(see AX=F217h/SF=ECh)
17h/EDh Get Physical Record Locks by Connection and File (see AX=F217h/SF=EDh)
17h/EEh	Get Physical Record Locks by File		(see AX=F217h/SF=EEh)
17h/EFh Get Logical Records by Connection		(see AX=F217h/SF=EFh)
17h/F0h Get Logical Record Information			(see AX=F217h/SF=F0h)
17h/F1h Get Connection's Semaphores			(see AX=F217h/SF=F1h)
17h/F2h Get Semaphore Information			(see AX=F217h/SF=F2h)
17h/F3h Map Directory Number to Path			(see AX=F217h/SF=F3h)
17h/F4h	Convert Path to Directory Entry			(see AX=F217h/SF=F4h)
17h/F5h Get File Server Extended Misc Information	(see AX=F217h/SF=F5h)
17h/F6h Get Volume Extended Information			(see AX=F217h/SF=F6h)
17h/FEh Clear Connection Number Greater than 250	(see AX=F217h/SF=FEh)
18h	End of Job					(see AH=D6h"NetWare")
19h	Logout (old)					(see AH=D7h"NetWare")
1Ah	Log Physical Record (old)			(see AH=BCh"NetWare")
1Bh	Lock Physical Record Set (old)			(see AX=F21Bh)
1Ch	Release Physical Record				(see AH=BDh"NetWare")
1Dh	Release Physical Record Set			(see AH=C3h"NetWare")
1Eh	Clear Physical Record				(see AX=F21Eh)
1Fh	Clear Physical Record Set			(see AX=F21Fh)
20h/xxh	semaphore services				(see AX=C501h"NetWare")
20h/00h Open Semaphore (old)				(see AX=C500h"NetWare")
20h/01h Examine Semaphore (old)				(see AX=C501h"NetWare")
20h/02h Wait on Semaphore (old)				(see AX=C502h"NetWare")
20h/03h Signal Semaphore (old)				(see AX=C503h"NetWare")
20h/04h Close Semaphore (old)				(see AX=C504h"NetWare")
21h	Negotiate Buffer Size
22h/00h	TTS Is Available				(see AX=C702h"NetWare")
22h/01h	TTS Begin Transaction				(see AX=C700h"NetWare")
22h/02h	TTS End Transaction				(see AX=C701h"NetWare")
22h/03h	TTS Abort Transaction				(see AX=C703h"NetWare")
22h/04h	TTS Transaction Status				(see AX=C704h"NetWare")
22h/05h	TTS Get Application Thresholds			(see AX=C705h"NetWare")
22h/06h	TTS Set Application Thresholds			(see AX=C706h"NetWare")
22h/07h	TTS Get Workstation Thresholds			(see AX=C707h"NetWare")
22h/08h	TTS Set Workstation Thresholds			(see AX=C708h"NetWare")
22h/09h	TTS Get Control Flags
22h/0Ah	TTS Set Control Flags
23h/01h	AFP Create Directory				(see AX=F223h/SF=01h)
23h/02h	AFP Create File					(see AX=F223h/SF=02h)
23h/03h	AFP Delete					(see AX=F223h/SF=03h)
23h/04h	AFP Get Entry ID From Name			(see AX=F223h/SF=04h)
23h/05h	AFP Get File Information			(see AX=F223h/SF=05h)
23h/06h	AFP Get Entry ID From NetWare Handle		(see AX=F223h/SF=06h)
23h/07h	AFP Rename					(see AX=F223h/SF=07h)
23h/08h	AFP Open File Fork				(see AX=F223h/SF=08h)
23h/09h	AFP Set File Information			(see AX=F223h/SF=09h)
23h/0Ah	AFP Scan File Information			(see AX=F223h/SF=0Ah)
23h/0Bh	AFP Alloc Temporary Dir Handle			(see AX=F223h/SF=0Bh)
23h/0Ch	AFP Get Entry ID From Path Name			(see AX=F223h/SF=0Ch)
23h/0Dh AFP 2.0 Create Directory			(see AX=F223h/SF=0Dh)
23h/0Eh AFP 2.0 Create File				(see AX=F223h/SF=0Eh)
23h/10h AFP 2.0 Set File Information			(see AX=F223h/SF=10h)
23h/11h AFP 2.0 Scan File Information			(see AX=F223h/SF=11h)
23h/12h AFP Get DOS Name from Entry ID			(see AX=F223h/SF=12h)
23h/13h AFP Get Macintosh Info on Deleted File		(see AX=F223h/SF=13h)
3Dh	Commit File
3Eh	File Search Initialize (FindFirst)		(see AX=F23Eh)
3Fh	File Search Continue (FindNext)			(see AX=F23Fh)
40h	Search File
42h	Close File					(see AX=F242h)
43h	File Create					(see AX=F243h)
44h	File Erase					(see AX=F244h)
45h	File Rename
46h	Set File Attributes
47h	Get File Size					(see AX=F247h)
48h	File Read
49h	File Write
4Ah	File Server Copy				(see AX=F24Ah)
4Bh	Set File Time and Date
4Ch	File Open
4Dh	Create New File					(see AX=F24Dh)
4Eh	Allow Task Access to File			(see AX=F24Eh)
4Fh	Set Extended File Attributes			(see AH=B6h"NetWare")
54h	Open Create File				(see also AX=6C00h)
55h	Get Sparse File Data Block Bit Map
56h/xx	extended attribute services (OS/2)
56h/01h	Close Extended Attribute Handle			(see AX=F256h/SF=01h)
56h/02h	Write Extended Attribute			(see AX=F256h/SF=02h)
56h/03h	Read Extended Attribute				(see AX=F256h/SF=03h)
56h/04h	Enumerate Extended Attributes			(see AX=F256h/SF=04h)
56h/05h	Duplicate Extended Attributes			(see AX=F256h/SF=05h)
57h/01h	Open/Create File or Subdirectory		(see AX=F257h/SF=01h)
57h/02h	Initialize Search, continue with 57h/03h	(see AX=F257h/SF=02h)
57h/03h	Scan NS Entry Info				(see AX=F257h/SF=03h)
57h/04h	Rename or Move File or Subdirectory		(see AX=F257h/SF=04h)
57h/05h	Scan File or Subdirectory for Trustees		(see AX=F257h/SF=05h)
57h/06h	Obtain File or Subdirectory Information		(see AX=F257h/SF=06h)
57h/07h	Modify File or Subdirectory DOS Information	(see AX=F257h/SF=07h)
57h/08h	Delete File/Directory				(see AX=F257h/SF=08h)
57h/09h	Set Short Directory Handle			(see AX=F257h/SF=09h)
57h/0Ah	Add Trustee Set					(see AX=F257h/SF=0Ah)
57h/0Bh	Delete Trustee					(see AX=F257h/SF=0Bh)
57h/0Ch	Allocate Short Directory Handle			(see AX=F257h/SF=0Ch)
57h/10h Scan Salvageable Files				(see AX=F257h/SF=10h)
57h/11h Recover Salvageable File			(see AX=F257h/SF=11h)
57h/12h Purge Salvageable File				(see AX=F257h/SF=12h)
57h/13h	Get NS Information				(see AX=F257h/SF=13h)
57h/15h	Get Path String from Short Directory Handle	(see AX=F257h/SF=15h)
57h/16h	Generate Directory Base and Volume Number	(see AX=F257h/SF=16h)
57h/17h	Get Name Space Info				(see AX=F257h/SF=17h)
57h/18h Get Name Spaces Loaded				(see AX=F257h/SF=18h)
57h/19h	Write Name Space Info				(see AX=F257h/SF=19h)
57h/1Ah	Read Extended Name Space Info			(see AX=F257h/SF=1Ah)
57h/1Bh	Write Extended Name Space Info			(see AX=F257h/SF=1Bh)
57h/1Ch	Get NS Full Path String				(see AX=F257h/SF=1Ch)
57h/1Dh	Get Effective Directory Rights			(see AX=F257h/SF=1Dh)
58h/01h	Get Volume Audit Statistics			(see AX=F258h/SF=01h)
58h/02h	Add Audit Property				(see AX=F258h/SF=02h)
58h/03h	Login as Volume Auditor				(see AX=F258h/SF=03h)
58h/04h Change Auditor Password				(see AX=F258h/SF=04h)
58h/05h Check Audit Access				(see AX=F258h/SF=05h)
58h/06h	Remove Audit Property				(see AX=F258h/SF=06h)
58h/07h	Disable Auditing on Volume			(see AX=F258h/SF=07h)
58h/08h	Enable Auditing on Volume			(see AX=F258h/SF=08h)
58h/09h	Is User Audited?				(see AX=F258h/SF=09h)
58h/0Ah	Read Auditing Bit Map				(see AX=F258h/SF=0Ah)
58h/0Bh	Read Audit Config Header			(see AX=F258h/SF=0Bh)
58h/0Dh	Logout as Volume Auditor			(see AX=F258h/SF=0Dh)
58h/0Eh	Reset Auditing File				(see AX=F258h/SF=0Eh)
58h/0Fh	Reset Audit History File			(see AX=F258h/SF=0Fh)
58h/10h	Write Auditing Bit Map				(see AX=F258h/SF=10h)
58h/11h	Write Audit Config Header			(see AX=F258h/SF=11h)
58h/13h	Get Auditing Flags				(see AX=F258h/SF=13h)
58h/14h	Close Old Auditing File				(see AX=F258h/SF=14h)
58h/15h	Delete Old Auditing File			(see AX=F258h/SF=15h)
58h/16h	Check Audit Level Two Access			(see AX=F258h/SF=16h)
5Ah/01h	Get DM (Data Migration) Info			(see AX=F25Ah/SF=01h)
5Ah/80h Move File Data to DM				(see AX=F25Ah/SF=80h)
5Ah/81h DM File Information				(see AX=F25Ah/SF=81h)
5Ah/82h Volume DM Status				(see AX=F25Ah/SF=82h)
5Ah/83h Get Migration or Status Information		(see AX=F25Ah/SF=83h)
5Ah/84h DM Support Module Information			(see AX=F25Ah/SF=84h)
5Ah/85h Move File Data from DM				(see AX=F25Ah/SF=85h)
5Ah/86h Get or Set Default Support Module		(see AX=F25Ah/SF=86h)
61h	Negotiate LIP Buffer, packet signing, and IPX checksums
65h	Packet Burst Connection
68h/xxh NetWare 4.x directory services (subfn at DS:[SI+11h])
68h/01h NDS resolve name				(see AX=F268h/SF=01h)
68h/03h	NDS read property
68h/04h NDS Get Bindery Context				(see AX=F268h/SF=04h)
68h/05h NDS Monitor Connection				(see AX=F268h/SF=05h)
68h/16h NDS List Partitions				(see AX=F268h/SF=16h)
68h/35h NDS get server address				(see AX=F268h/SF=35h)
68h/36h NDS set keys
68h/39h NDS begin login
68h/3Ah NDS finish login
68h/3Bh NDS begin authenticate
68h/3Ch NDS finish authenticate
68h/3Dh NDS Logout					(see AX=F268h/SF=3Dh)
68h/C8h Get DS Auditing Statistics			(see AX=F268h/SF=C8h)
69h	Log File					(see AX=F269h)
6Ah	Lock File Set					(see AX=F26Ah)
6Bh	Log Logical Record	!!!APIREF09 line 1430
6Ch	Lock Logical Record Set				(see AX=F26Ch)
6Dh	Log Physical Record
6Eh	Lock Physical Record Set			(see AX=F26Eh)
6Fh/00h Open Semaphore					(see AX=F26Fh/SF=00h)
6Fh/01h Close Semaphore					(see AX=F26Fh/SF=01h)
6Fh/02h Wait on Semaphore				(see AX=F26Fh/SF=02h)
6Fh/03h Signal Semaphore				(see AX=F26Fh/SF=03h)
6Fh/04h Examine Semaphore				(see AX=F26Fh/SF=04h)
72h	NetWare 4.x Time Services			(see AX=F272h)
7Bh/01h	Get Cache Information				(see AX=F27Bh/SF=01h)
7Bh/02h	Get File Server Information			(see AX=F27Bh/SF=02h)
7Bh/03h	Get NetWare File Systems Information
7Bh/04h	Get User Information				(see AX=F27Bh/SF=04h)
7Bh/05h	Get Packet Burst Information
7Bh/06h	Get IPX/SPX Information				(see AX=F27Bh/SF=06h)
7Bh/07h	Get Garbage Collection Information
7Bh/08h	Get CPU Information				(see AX=F27Bh/SF=08h)
7Bh/09h	Get Volume Switch Information			(see AX=F27Bh/SF=09h)
7Bh/0Ah	Get NLM Loaded List				(see AX=F27Bh/SF=0Ah)
7Bh/0Bh	Get NLM Information				(see AX=F27Bh/SF=0Bh)
7Bh/0Ch	Get Directory Cache Information
7Bh/0Dh	Get OS Version Information			(see AX=F27Bh/SF=0Dh)
7Bh/0Eh	Get Active Connection List by Type
7Bh/0Fh	Get NLM's Resource Tag List
7Bh/14h	Get Active LAN Board List			(see AX=F27Bh/SF=14h)
7Bh/15h	Get LAN Configuration Information		(see AX=F27Bh/SF=15h)
7Bh/16h	Get LAN Common Counters Information		(see AX=F27Bh/SF=16h)
7Bh/17h	Get LAN Custom Counters Information
7Bh/18h	Get LAN Config Strings
7Bh/19h	Get LSL Information
7Bh/1Ah	Get LSL Logical Board Statistics
7Bh/1Eh	Get Media Manager Object Information
7Bh/1Fh	Get Media Manager Object List
7Bh/20h	Get Media Manager Object Children List
7Bh/21h	Get Volume Segment List
7Bh/28h	Get Active Protocol Stacks
7Bh/29h	Get Protocol Stack Configuration Information	(see AX=F27Bh/SF=29h)
7Bh/2Ah	Get Protocol Stack Statistics Information
7Bh/2Bh	Get Protocol Stack Custom Information
7Bh/2Ch	Get Protocol Stack Numbers By Media Number
7Bh/2Dh	Get Protocol Stack Numbers By LAN Board Number
7Bh/2Eh	Get Media Name by Media Number
7Bh/2Fh	Get Loaded Media Number List
7Bh/32h	Get General Router and SAP Information
7Bh/33h	Get Network Router Information			(see AX=F27Bh/SF=33h)
7Bh/34h	Get Network Routers Information
7Bh/35h	Get Known Networks Information			(see AX=F27Bh/SF=35h)
7Bh/36h	Get Server Information
7Bh/38h	Get Known Servers Information			(see AX=F27Bh/SF=38h)
7Bh/3Ch	Get Server Set Commands Information		(see AX=F27Bh/SF=3Ch)
7Bh/3Dh	Get Server Set Categories			(see AX=F27Bh/SF=3Dh)
Note:	the subfunction is stored at DS:SI for AL=56h,57h, DS:SI+2 for
	  AL=15h-17h,23h
--------T-21F2-------------------------------
INT 21 - DoubleDOS - SEND CHARACTER TO KEYBOARD BUFFER OF OTHER JOB
	AH = F2h
	AL = character
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	    00h successful
	    01h buffer full (128 characters)
SeeAlso: AH=E2h"DoubleDOS",AH=F1h"DoubleDOS",AH=F3h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
--------N-21F203-----------------------------
INT 21 - Novell NetWare - LOG FILE (OLD)
	AX = F203h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02477 at AX=F269h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F204h,AX=F269h,AH=EBh"NetWare"
--------N-21F204-----------------------------
INT 21 - Novell NetWare - LOCK FILE SET (OLD)
	AX = F204h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02096)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F203h,AX=F26Ah,AH=CBh"NetWare"

Format of NetWare "Lock File Set (old)" request packet:
Offset	Size	Description	(Table 02096)
 00h	WORD	lock timeout in clock ticks (0000h = don't wait)
--------N-21F207-----------------------------
INT 21 - Novell NetWare - CLEAR FILE
	AX = F207h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02097)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=CEh,AH=EDh"NetWare",AH=F2h"NetWare",AX=F208h

Format of NetWare "Clear File" request packet:
Offset	Size	Description	(Table 02097)
 00h	BYTE	directory handle
 01h	BYTE	length of filename
 02h  N BYTEs	filename
SeeAlso: #02098
--------N-21F208-----------------------------
INT 21 - Novell NetWare - CLEAR FILE SET
	AX = F208h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02098)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=CFh"NetWare",AH=F2h"NetWare",AX=F207h

Format of NetWare "Clear File Set" request packet:
Offset	Size	Description	(Table 02098)
 00h	BYTE	lock flag (nonzero to lock)
SeeAlso: #02097
--------N-21F20A-----------------------------
INT 21 - Novell NetWare - LOCK LOGICAL RECORD SET (OLD)
	AX = F20Ah
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02479 at AX=F26Ch)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F204h,AX=F26Ch,AH=D1h"NetWare"
--------N-21F20B-----------------------------
INT 21 - Novell NetWare - CLEAR LOGICAL RECORD
	AX = F20Bh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02099)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=D4h"NetWare",AH=F2h"NetWare",AX=F207h,AX=F20Eh

Format of NetWare "Clear Logical Record" request packet:
Offset	Size	Description	(Table 02099)
 00h	BYTE	length of record name (max 128)
 01h  N BYTEs	logical record name
SeeAlso: #02100
--------N-21F20E-----------------------------
INT 21 - Novell NetWare - CLEAR LOGICAL RECORD SET
	AX = F20Eh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02100)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=D5h"NetWare",AH=F2h"NetWare",AX=F207h,AX=F20Bh

Format of NetWare "Clear Logical Record Set" request packet:
Offset	Size	Description	(Table 02100)
 00h	BYTE	lock flag
SeeAlso: #02099
--------N-21F211SF06-------------------------
INT 21 - Novell NetWare - GET PRINTER STATUS
	AX = F211h subfn 06h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02101)
	ES:DI -> reply buffer (see #02102)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=E0h"NetWare",AH=F2h"Novell",AX=F211h/SF=0Ah

Format of NetWare "Get Printer Status" request packet:
Offset	Size	Description	(Table 02101)
 00h	WORD	length of following data
 02h	BYTE	06h (subfunction "Get Printer Status")
 03h	BYTE	target printer number (00h-04h)
SeeAlso: #02102,#01814

Format of NetWare "Get Printer Status" reply packet:
Offset	Size	Description	(Table 02102)
 00h	BYTE	flag: printer halted if FFh
 01h	BYTE	flag: printer off-line if FFh
 02h	BYTE	current form type
 03h	BYTE	redirected printer number
SeeAlso: #02101
--------N-21F211SF0A-------------------------
INT 21 - Novell NetWare - GET PRINTER QUEUE
	AX = F211h subfn 0Ah
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02103)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F211h/SF=06h

Format of NetWare "Get Printer Queue" request packet:
Offset	Size	Description	(Table 02103)
 00h	WORD	length of following data
 02h	BYTE	0Ah (subfunction "Get Printer Queue")
	???
--------N-21F212-----------------------------
INT 21 - Novell NetWare - GET VOLUME INFO WITH NUMBER
	AX = F212h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02104)
	ES:DI -> reply buffer (see #02105)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=15h,AX=F217h/SF=E9h

Format of NetWare "Get Volume Info with Number" request packet:
Offset	Size	Description	(Table 02104)
 00h	BYTE	volume number
SeeAlso: #02105

Format of NetWare "Get Volume Info with Number" reply packet:
Offset	Size	Description	(Table 02105)
 00h	WORD	sectors per cluster
 02h	WORD	total clusters in volume
 04h	WORD	free clusters
 06h	WORD	total directory entries for volume (FFFFh if not relevant)
 08h	WORD	available directory entries (FFFFh if not relevant)
 0Ah 16 BYTEs	volume name
 1Ah	WORD	removability
		0000h fixed media
		FFFFh removable
SeeAlso: #02104
--------N-21F214CX0000-----------------------
INT 21 - Novell NetWare - GET FILE SERVER DATE AND TIME
	AX = F214h
	CX = 0000h (no request packet)
	DX = length of reply packet in bytes
	ES:DI -> buffer for reply packet (see #02106)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"NetWare",AH=E3h/SF=CAh,AH=E7h"NetWare"

Format of NetWare "Get File Server Date and Time" reply packet:
Offset	Size	Description	(Table 02106)
 00h	BYTE	year-1900 (80-179)
 01h	BYTE	month (1-12)
 02h	BYTE	day (1-31)
 03h	BYTE	hour
 04h	BYTE	minute
 05h	BYTE	second
 06h	BYTE	day of week
SeeAlso: #02012 at AH=E3h/SF=CAh,#02087 at AH=E7h
--------N-21F215SF01-------------------------
INT 21 - Novell NetWare - GET BROADCAST MESSAGE (OLD)
	AX = F215h subfn 01h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #01822 at AH=E1h/SF=01h)
	ES:DI -> reply buffer (see #02107)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=01h,AX=F215h/SF=02h,AX=F215h/SF=0Bh

Format of NetWare "Get Broadcast Message (Old)" reply packet:
Offset	Size	Description	(Table 02107)
 00h	BYTE	length of message (00h-37h)
		00h if no broadcast messages pending
 01h  N BYTEs	message (no control characters or characters > 7Eh)
SeeAlso: #01821,#01822
--------N-21F215SF02-------------------------
INT 21 - Novell NetWare - DISABLE BROADCASTS
	AX = F215h subfn 02h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01823 at AH=E1h/SF=02h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=02h,AX=F215h/SF=01h,AX=F215h/SF=03h
--------N-21F215SF03-------------------------
INT 21 - Novell NetWare - ENABLE BROADCASTS
	AX = F215h subfn 03h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01824 at AH=E1h/SF=03h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=03h,AX=F215h/SF=01h,AX=F215h/SF=02h
--------N-21F215SF08-------------------------
INT 21 - Novell NetWare - CHECK PIPE STATUS
	AX = F215h subfn 08h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #01835 at AH=E1h/SF=08h)
	ES:DI -> reply buffer (see #02108)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=08h,AX=F215h/SF=09h

Format of NetWare "Check Pipe Status" reply packet:
Offset	Size	Description	(Table 02108)
 00h	BYTE	number of connections
 01h  N BYTEs	list of pipe statuses
		00h open
		FEh incomplete
		FFh closed
SeeAlso: #01835,#01836
--------N-21F215SF09-------------------------
INT 21 - Novell NetWare - BROADCAST TO CONSOLE
	AX = F215h subfn 09h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01837 at AH=E1h/SF=09h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Note:	requires Access Control rights to the target directory or its parent
SeeAlso: AH=E1h/SF=09h,AH=F2h"NetWare",AX=F215h/SF=08h
--------N-21F215SF0B-------------------------
INT 21 - Novell NetWare - GET BROADCAST MESSAGE
	AX = F215h subfn 0Bh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02109)
	ES:DI -> reply buffer (see #02110)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E1h/SF=01h,AX=F215h/SF=01h

Format of NetWare "Get Broadcast Message" request packet:
Offset	Size	Description	(Table 02109)
 00h	WORD	length of following data
 02h	BYTE	0Bh (subfunction "Get Broadcast Message")
SeeAlso: #02110,#01821

Format of NetWare "Get Broadcast Message" reply packet:
Offset	Size	Description	(Table 02110)
 00h	BYTE	length of message
 01h  N BYTEs	message
SeeAlso: #02109,#01822
--------N-21F216SF00-------------------------
INT 21 - Novell NetWare - SET DIRECTORY HANDLE
	AX = F216h subfn 00h
	CX = length of request buffer in bytes
	DX = 0000h (no reply buffer)
	DS:SI -> request buffer (see #01840 at AH=E2h/SF=00h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=00h,AX=F216h/SF=01h
--------N-21F216SF01-------------------------
INT 21 - Novell NetWare - GET DIRECTORY PATH
	AX = F216h subfn 01h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #01842 at AH=E2h/SF=01h)
	ES:DI -> reply buffer (see #01843)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=01h,AX=F216h/SF=00h
--------N-21F216SF02-------------------------
INT 21 - Novell NetWare - SCAN DIRECTORY INFORMATION
	AX = F216h subfn 02h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #01844 at AH=E2h/SF=02h)
	ES:DI -> reply buffer (see #02111)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=02h,AX=F216h/SF=01h,AX=F216h/SF=03h

Format of NetWare "Scan Directory Information" reply packet:
Offset	Size	Description	(Table 02111)
 00h 16 BYTEs	subdirectory name
 10h	DWORD	(big-endian) date and time of creation (see #01846)
 14h	DWORD	(big-endian) object ID of owner
 18h	BYTE	maximum directory rights (see #01849)
 19h	BYTE	unused
 1Ah	WORD	(big-endian) subdirectory number
SeeAlso: #01844,#01845 at AH=E2h/SF=02h
--------N-21F216SF03-------------------------
INT 21 - Novell NetWare - GET EFFECTIVE DIRECTORY RIGHTS (OLD)
	AX = F216h subfn 03h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #01847 at AH=E2h/SF=03h)
	ES:DI -> reply buffer (see #02112)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=E2h/SF=03h,AX=F216h/SF=02h,AX=F216h/SF=04h,AX=F257h/SF=1Dh

Format of NetWare "Get Effective Directory Rights (old)" reply buffer:
Offset	Size	Description	(Table 02112)
 00h	BYTE	effective directory rights (see #01849 at AH=E2h/SF=03h)
SeeAlso: #01847,#01848 at AH=E2h/SF=03h
--------N-21F216SF04-------------------------
INT 21 - Novell NetWare - MODIFY MAXIMUM RIGHTS MASK
	AX = F216h subfn 04h
	CX = length of request buffer in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01850 at AH=E2h/SF=04h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=04h,AX=F216h/SF=03h,AX=F216h/SF=05h
--------N-21F216SF05-------------------------
INT 21 - Novell NetWare - GET VOLUME NUMBER
	AX = F216h subfn 05h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #01852 at AH=E2h/SF=05h)
	ES:DI -> reply buffer (see #02113)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=05h,AX=F216h/SF=02h,AX=F216h/SF=06h

Format of NetWare "Get Volume Number" reply packet:
Offset	Size	Description	(Table 02113)
 00h	BYTE	volume number
SeeAlso: #01852 at AH=E2h/SF=05h
--------N-21F216SF06-------------------------
INT 21 - Novell NetWare - GET VOLUME NAME
	AX = F216h subfn 06h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #01854 at AH=E2h/SF=06h)
	ES:DI -> reply buffer (see #02114)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=06h,AX=F216h/SF=05h,AX=F216h/SF=0Ah

Format of NetWare "Get Volume Name" reply packet:
Offset	Size	Description	(Table 02114)
SeeAlso: #01854,#01855 at AH=E2h/SF=06h
--------N-21F216SF0A-------------------------
INT 21 - Novell NetWare - CREATE DIRECTORY
	AX = F216h subfn 0Ah
	CX = length of request buffer in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01856 at AH=E2h/SF=0Ah)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=39h,AH=F2h"Novell",AH=E2h/SF=0Ah,AX=F216h/SF=0Bh
--------N-21F216SF0B-------------------------
INT 21 - Novell NetWare - DELETE DIRECTORY
	AX = F216h subfn 0Bh
	CX = length of request buffer in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01858 at AH=E2h/SF=0Bh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=3Ah,AH=F2h"Novell",AH=E2h/SF=0Bh,AX=F216h/SF=0Ah
--------N-21F216SF0C-------------------------
INT 21 - Novell NetWare - SCAN DIRECTORY FOR TRUSTEES
	AX = F216h subfn 0Ch
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #01859 at AH=E2h/SF=0Ch)
	ES:DI -> reply buffer (see #02115)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=0Ch,AX=F216h/SF=0Dh

Format of NetWare "Scan Directory For Trustees" reply packet:
Offset	Size	Description	(Table 02115)
 02h 16 BYTEs	directory name
 12h  4 BYTEs	date and time of creation
 16h	DWORD	(big-endian) object ID of owner
 1Ah  5 DWORDs	(big-endian) object IDs of Trustees 0 through 4
		00000000h = end of group
 2Eh  5 BYTEs	directory rights for Trustees 0 through 4 (see #01849)
SeeAlso: #01859 at AH=E2h/SF=0Ch
--------N-21F216SF0D-------------------------
INT 21 - Novell NetWare - ADD TRUSTEE TO DIRECTORY
	AX = F216h subfn 0Dh
	CX = length of request buffer in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01861 at AH=E2h/SF=0Dh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Note:	requires Access Control rights to the target directory or its parent
SeeAlso: AH=F2h"NetWare",AH=E2h/SF=0Dh,AX=F216h/SF=0Ch,AX=F216h/SF=0Eh
--------N-21F216SF0E-------------------------
INT 21 - Novell NetWare - DELETE TRUSTEE FROM DIRECTORY
	AX = F216h subfn 0Eh
	CX = length of request buffer in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01862 at AH=E2h/SF=0Eh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=0Eh,AX=F216h/SF=0Ch,AX=F216h/SF=0Dh
--------N-21F216SF0F-------------------------
INT 21 - Novell NetWare - RENAME DIRECTORY
	AX = F216h subfn 0Fh
	CX = length of request buffer in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01864 at AH=E2h/SF=0Fh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=0Fh,AX=F216h/SF=0Ah
--------N-21F216SF10-------------------------
INT 21 - Novell NetWare - PURGE ERASED FILES (OLD)
	AX = F216h subfn 10h
	CX = length of request buffer in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01865 at AH=E2h/SF=10h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=10h,AX=F216h/SF=11h
--------N-21F216SF11-------------------------
INT 21 - Novell NetWare - RECOVER ERASED FILE (OLD)
	AX = F216h subfn 11h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01867 at AH=E2h/SF=11h)
	ES:DI -> reply buffer (see #02116)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=11h,AX=F216h/SF=10h

Format of NetWare "Recover Erased File (Old)" reply packet:
Offset	Size	Description	(Table 02116)
 02h 15 BYTEs	ASCIZ name of erased file
 11h 15 BYTEs	ASCIZ name under which file was restored
SeeAlso: #01867,#01868 at AH=E2h/SF=11h
--------N-21F216SF12-------------------------
INT 21 - Novell NetWare - ALLOCATE PERMANENT DIRECTORY HANDLE
	AX = F216h subfn 12h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01869 at AH=E2h/SF=12h)
	ES:DI -> reply buffer (see #02118)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=16h,AH=E2h/SF=12h

Format of NetWare IPX fragment list entry:
Offset	Size	Description	(Table 02117)
 00h	DWORD	-> fragment data
 04h	WORD	size of fragment in bytes

Format of NetWare "Allocate Permanent Directory Handle" reply packet:
Offset	Size	Description	(Table 02118)
 00h	BYTE	new directory handle
 01h	BYTE	access rights
SeeAlso: #01869,#01873,#02117
--------N-21F216SF13-------------------------
INT 21 - Novell NetWare - ALLOCATE TEMPORARY DIRECTORY HANDLE
	AX = F216h subfn 13h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01871 at AH=E2h/SF=13h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=12h,AX=F216h/SF=16h,AH=E2h/SF=13h
--------N-21F216SF14-------------------------
INT 21 - Novell NetWare - DEALLOCATE DIRECTORY HANDLE
	AX = F216h subfn 14h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01872 at AH=E2h/SF=14h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=14h,AX=F216h/SF=13h,AX=F216h/SF=16h
--------N-21F216SF15-------------------------
INT 21 - Novell NetWare - GET VOLUME INFO WITH HANDLE
	AX = F216h subfn 15h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01874 at AH=E2h/SF=15h)
	ES:DI -> reply buffer (see #02119)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=15h,AX=F212h,AX=F216h/SF=13h

Format of NetWare "Get Volume Info With Handle" reply packet:
Offset	Size	Description	(Table 02119)
 00h	WORD	(big-endian) sectors per block
 02h	WORD	(big-endian) total blocks on volume
 04h	WORD	(big-endian) blocks available on volume
 06h	WORD	(big-endian) total directory slots
 08h	WORD	(big-endian) directory slots available
 0Ah 16 BYTEs	NUL-padded volume name
 1Ah	WORD	(big-endian) flag: volume removable if nonzero
SeeAlso: #01874 at AH=E2h/SF=15h
--------N-21F216SF16-------------------------
INT 21 - Novell NetWare v2+ - ALLOCATE SPECIAL TEMPORARY DIRECTORY HANDLE
	AX = F216h subfn 16h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01876 at AH=E2h/SF=16h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=12h,AX=F216h/SF=13h,AH=E2h/SF=16h
--------N-21F216SF17-------------------------
INT 21 - Novell NetWare - SAVE DIRECTORY HANDLE
	AX = F216h subfn 17h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01877 at AH=E2h/SF=17h)
	ES:DI -> reply buffer (see #02120)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=17h,AX=F216h/SF=18h

Format of NetWare "Save Directory Handle" reply packet:
Offset	Size	Description	(Table 02120)
 00h 16 BYTEs	save buffer
SeeAlso: #01877,#01878,#02121
--------N-21F216SF18-------------------------
INT 21 - Novell NetWare - RESTORE DIRECTORY HANDLE
	AX = F216h subfn 18h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01879 at AH=E2h/SF=18h)
	ES:DI -> reply buffer (see #02121)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=18h,AX=F216h/SF=17h

Format of NetWare "Restore Directory Handle" reply packet:
Offset	Size	Description	(Table 02121)
 00h	BYTE	new directory handle
 01h	BYTE	effective rights (see #01849)
SeeAlso: #01880,#02120
--------N-21F216SF19-------------------------
INT 21 - Novell NetWare - SET DIRECTORY INFORMATION
	AX = F216h subfn 19h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01881 at AH=E2h/SF=19h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=19h,AX=F216h/SF=17h
--------N-21F216SF1A-------------------------
INT 21 - Novell NetWare - GET PATH NAME OF VOLUME-DIRECTORY NUMBER PAIR
	AX = F216h subfn 1Ah
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01883 at AH=E2h/SF=1Ah)
	ES:DI -> reply buffer (see #02122)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=1Ah,AX=F216h/SF=0Eh

Format of NetWare "Get Path Name Of Volume-Dir Number Pair" reply packet:
Offset	Size	Description	(Table 02122)
 00h 256 BYTEs	path
SeeAlso: #01883,#01884 at AH=E2h/SF=1Ah
--------N-21F216SF1B-------------------------
INT 21 - Novell NetWare - SCAN SALVAGEABLE FILES (OLD)
	AX = F216h subfn 1Bh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02123)
	ES:DI -> reply buffer (see #02124)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Ch,AX=F216h/SF=1Dh,AX=F257h/SF=10h

Format of NetWare "Scan Salvageable Files (Old)" request packet:
Offset	Size	Description	(Table 02123)
 00h	WORD	length of following data
 02h	BYTE	1Bh (subfunction "Scan Salvageable Files (Old)")
 03h	BYTE	directory handle
 04h	DWORD	last sequence number (set to FFFFFFFFh before first call)
SeeAlso: #02124,#02399

Format of NetWare "Scan Salvageable Files (Old)" reply packet:
Offset	Size	Description	(Table 02124)
 00h	DWORD	next sequence number
 04h	WORD	subdirectory
 06h	DWORD	attributes
 0Ah	BYTE	unique ID
 0Bh	BYTE	flags
 0Ch	BYTE	name space
 0Dh	BYTE	length of filename
 0Eh 14 BYTEs	filename
 1Ah	DWORD	creation date and time
 1Eh	DWORD	owner ID
 22h	DWORD	last-backup date and time
 26h	DWORD	last-backup ID
 2Ah	DWORD	last-modified date and time
 2Eh	WORD	???
 30h	DWORD	last-modified ID
 34h	DWORD	file size
 38h 44 BYTEs	reserved
 62h	WORD	inherited rights mask
 64h	WORD	last-access date
 66h	DWORD	deleted file's time
 6Ah	DWORD	deletion date and time
 6Eh	DWORD	ID of deletor
 72h 16 BYTEs	reserved
SeeAlso: #02123,#02400
--------N-21F216SF1C-------------------------
INT 21 - Novell NetWare - RECOVER SALVAGEABLE FILE (OLD)
	AX = F216h subfn 1Ch
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02125)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Bh,AX=F216h/SF=1Dh,AX=F257h/SF=11h

Format of NetWare "Recover Salvageable File (Old)" request packet:
Offset	Size	Description	(Table 02125)
 00h	WORD	length of following data
 02h	BYTE	1Ch (subfunction "Recover Salvageable File (Old)")
 03h	BYTE	directory handle
 04h	DWORD	sequence number (set to ? before first call)
 08h	BYTE	length of filename
 09h  N BYTEs	filename in DOS format
	BYTE	length of new name for recovered file
      N BYTEs	recovered filename in NetWare VOLUME:DIRECTORY/.../FILE format
SeeAlso: #02401
--------N-21F216SF1D-------------------------
INT 21 - Novell NetWare - PURGE SALVAGEABLE FILE (OLD)
	AX = F216h subfn 1Dh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02126)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Bh,AX=F216h/SF=1Ch,AX=F257h/SF=12h

Format of NetWare "Purge Salvageable File (old)" request packet:
Offset	Size	Description	(Table 02126)
 00h	WORD	length of following data
 02h	BYTE	1Dh (subfunction "Purge Salvageable File (Old)")
 03h	BYTE	directory handle
 04h	DWORD	directory entry
 08h	DWORD	sequence number from Scan Salvageable Files
--------N-21F216SF1E-------------------------
INT 21 - Novell NetWare - SCAN A DIRECTORY
	AX = F216h subfn 1Eh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02127)
	ES:DI -> reply buffer (see #02128)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E2h/SF=02h,AX=F216h/SF=1Fh

Format of NetWare "Scan A Directory" request packet:
Offset	Size	Description	(Table 02127)
 00h	WORD	length of following data
 02h	BYTE	1Eh (subfunction "Scan A Directory")
 03h	BYTE	directory handle
 04h	BYTE	search attributes
 05h	DWORD	sequence number
 09h	BYTE	length of search filespec
 0Ah  N BYTEs	search filespec
SeeAlso: #02128

Format of NetWare "Scan A Directory" reply packet:
Offset	Size	Description	(Table 02128)
 00h	DWORD	sequence number (copy into next request packet)
 04h	DWORD	subdirectory
 08h	DWORD	attributes
 0Ch	BYTE	unique ID
 0Dh	BYTE	flags
 0Eh	BYTE	name space
 0Fh	BYTE	length of filename
---DOS file---
 10h 12 BYTEs	DOS filename
 1Ch	DWORD	creation date and time
 20h	DWORD	owner ID
 24h	DWORD	last-archived date and time
 28h	DWORD	last-archived ID
 2Ch	DWORD	last-updated date and time
 30h	DWORD	last-updated ID
 34h	DWORD	file size
 38h 44 BYTEs	reserved
 64h	WORD	inherited rights mask
 66h	WORD	last-accessed date
 68h 28 BYTEs	reserved
---DOS subdirectory---
 10h 12 BYTEs	DOS directory name
 1Ch	DWORD	creation date and time
 20h	DWORD	owner ID
 24h	DWORD	last-archived date and time
 28h	DWORD	last-archived ID
 2Ch	DWORD	last-updated date and time
 30h	DWORD	next trustee entry
 34h 48 BYTEs	reserved
 64h	DWORD	maximum space
 68h	WORD	inherited rights mask
 6Ah 26 BYTEs	unused
SeeAlso: #02127
--------N-21F216SF1F-------------------------
INT 21 - Novell NetWare - GET DIRECTORY ENTRY
	AX = F216h subfn 1Fh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02129)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Eh

Format of NetWare "Get Directory Entry" request packet:
Offset	Size	Description	(Table 02129)
 00h	WORD	length of following data
 02h	BYTE	1Fh (subfunction "Get Directory Entry")
	???
--------N-21F216SF20-------------------------
INT 21 - Novell NetWare - SCAN VOLUME'S USER DISK RESTRICTIONS
	AX = F216h subfn 20h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02130)
	ES:DI -> reply buffer (see #02131)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=23h,AX=F216h/SF=29h

Format of NetWare "Scan Volume's User Disk Restrictions" request packet:
Offset	Size	Description	(Table 02130)
 00h	WORD	length of following data
 02h	BYTE	20h (subfunction "Scan Volume's User Disk Restrictions")
 03h	BYTE	volume number
 04h	DWORD	sequence number (set to 00000000h before first call)
SeeAlso: #02131

Format of NetWare "Scan Volume's User Disk Restrictions" reply packet:
Offset	Size	Description	(Table 02131)
 00h	BYTE	number of entries returned (max 12)
 01h 2N DWORDs	restriction entries [array]
		Offset	Size	Description
		 00h	DWORD	object ID
		 04h	DWORD	maximum usage allowed (in 4K blocks)
SeeAlso: #02130
--------N-21F216SF21-------------------------
INT 21 - Novell NetWare v3+ - ADD USER DISK SPACE RESTRICTION
	AX = F216h subfn 21h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02132)
	ES:DI -> reply buffer (ignored)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=F216h/SF=20h,AX=F216h/SF=22h,AX=F216h/SF=24h

Format of NetWare "Add User Disk Space Restriction" request buffer:
Offset	Size	Description	(Table 02132)
 00h	WORD	000Ah (length of following data)
 02h	BYTE	21h (subfunction "Add User Disk Space Restriction")
 03h	BYTE	volume number
 04h	DWORD	(big-endian) object ID
 08h	DWORD	(big-endian) disk space limit in 4K blocks
		00000000h to 40000000h
--------N-21F216SF22-------------------------
INT 21 - Novell NetWare - REMOVE USER DISK SPACE RESTRICTIONS
	AX = F216h subfn 22h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02133)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=20h,AX=F216h/SF=21h,AX=F216h/SF=23h

Format of NetWare "Remove User Disk Space Restrictions" request packet:
Offset	Size	Description	(Table 02133)
 00h	WORD	length of following data
 02h	BYTE	22h (subfunction "Remove User Disk Space Restrictions")
	???
--------N-21F216SF23-------------------------
INT 21 - Novell NetWare - SCAN DIRECTORY SPACE RESTRICTIONS
	AX = F216h subfn 23h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02134)
	ES:DI -> reply buffer (see #02135)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=20h,AX=F216h/SF=21h,AX=F216h/SF=22h

Format of NetWare "Scan Directory Space Restrictions" request packet:
Offset	Size	Description	(Table 02134)
 00h	WORD	length of following data
 02h	BYTE	23h (subfunction "Scan Directory Space Restrictions")
 03h	BYTE	directory handle
SeeAlso: #02135

Format of NetWare "Scan Directory Space Restrictions" reply packet:
Offset	Size	Description	(Table 02135)
 00h	BYTE	number of entries returned
 01h 10N BYTEs	restrictions [array]
		Offset	Size	Description
		 00h	WORD	depth of directory from root
		 02h	DWORD	maximum space allowed for files in directory
		 04h	DWORD	current space used by files in directory
SeeAlso: #02134
--------N-21F216SF24-------------------------
INT 21 - Novell NetWare v3+ - SET DIRECTORY DISK SPACE RESTRICTION
	AX = F216h subfn 24h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02136)
	ES:DI -> reply buffer (ignored)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=F216h/SF=21h,AX=F216h/SF=22h,AX=F216h/SF=23h,AX=F216h/SF=25h

Format of NetWare "Set Directory Disk Space Restriction" request buffer:
Offset	Size	Description	(Table 02136)
 00h	WORD	0006h (length of following data)
 02h	BYTE	24h (subfunction "Set Directory Disk Space Restriction")
 03h	BYTE	directory handle
 04h	DWORD	(big-endian) disk space limit in 4K blocks
		00000000h to remove restriction, negative to set to 0 blocks
--------N-21F216SF25-------------------------
INT 21 - Novell NetWare - SET DIRECTORY/FILE INFORMATION
	AX = F216h subfn 25h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02137)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=02h

Format of NetWare "Set Directory/File Information" request packet:
Offset	Size	Description	(Table 02137)
 00h	WORD	length of following data
 02h	BYTE	25h (subfunction "Set Directory/File Information")
 03h	BYTE	directory handle
 04h	BYTE	search attributes
 05h	DWORD	sequence number
 09h	DWORD	change bits
 0Dh	DWORD	directory number
 11h	DWORD	attributes
 15h	BYTE	unique ID
 16h	BYTE	flags
 17h	BYTE	name space (see #02387)
 18h	BYTE	length of directory/file name
 19h 12 BYTEs	directory/file name
 25h	DWORD	creation date and time
 29h	DWORD	(big-endian) owner ID
 2Dh	DWORD	last-backup date and time
 31h	DWORD	(big-endian) last-backup ID
 35h	DWORD	last-modification date and time
 39h	DWORD	(big-endian) last-modification ID
 3Dh	DWORD	file size
 41h	DWORD	data fork first FAT
 45h	DWORD	next trustee entry
 49h 36 BYTEs	reserved
 6Dh	WORD	inherited rights mask
 6Fh	WORD	last-access date
 71h 20 BYTEs	reserved
 85h	DWORD	primary entry
 89h	DWORD	name list
--------N-21F216SF26-------------------------
INT 21 - Novell NetWare v3+ - SCAN FILE OR DIRECTORY FOR EXTENDED TRUSTEES
	AX = F216h subfn 26h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02138)
	ES:DI -> reply buffer (see #02139)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Desc:	get up to 20 extended trustee entries per call for a file or directory

Format of NetWare "Scan File/Directory for Extended Trustees" request buffer:
Offset	Size	Description	(Table 02138)
 00h	WORD	length of following data
 02h	BYTE	26h (subfunc "Scan File or Directory For Extended Trustees")
 03h	BYTE	directory handle
 04h	BYTE	sequence number
		00h for first call, increment by number of returned entries
 05h	BYTE	length of path
 06h  N BYTEs	pathname
SeeAlso: #02138

Format of NetWare "Scan File/Directory for Extended Trustees" reply buffer:
Offset	Size	Description	(Table 02139)
 00h	BYTE	number of entries returned (max 20)
 01h 20 DWORDs	(big-endian) list of object IDs
 51h 20 WORDs	list of associated trustee rights
SeeAlso: #02139
--------N-21F216SF27-------------------------
INT 21 - Novell NetWare v3+ - ADD EXTENDED TRUSTEE TO DIRECTORY OR FILE
	AX = F216h subfn 27h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02140)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)

Format of NetWare "Add Extended Trustee to Directory or File" request buffer:
Offset	Size	Description	(Table 02140)
 00h	WORD	length of following data
 02h	BYTE	27h (subfunction "Add Extended Trustee to Directory or File")
 03h	BYTE	directory handle
 04h	DWORD	(big-endian) object ID
 08h	WORD	trustee rights (see #02141)
 0Ah	BYTE	path length
 0Bh  N BYTEs	path name

Bitfields for NetWare trustee rights:
Bit(s)	Description	(Table 02141)
 0	read
 1	write
 3	create
 4	delete
 5	access
 6	file
 7	modify
 8	supervisor
--------N-21F216SF28-------------------------
INT 21 - Novell NetWare - SCAN DIRECTORY DISK SPACE
	AX = F216h subfn 28h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02142)
	ES:DI -> reply buffer (see #02143)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=02h,AX=F216h/SF=20h

Format of NetWare "Scan Directory Disk Space" request packet:
Offset	Size	Description	(Table 02142)
 00h	WORD	length of following data
 02h	BYTE	28h (subfunction "Scan Directory Disk Space")
 03h	BYTE	directory handle
 04h	BYTE	search attributes
 05h	DWORD	sequence number (set to FFFFFFFFh before first call)
 09h	BYTE	length of filespec
 0Ah  N BYTEs	search filespec
SeeAlso: #02143

Format of NetWare "Scan Directory Disk Space" reply packet:
Offset	Size	Description	(Table 02143)
 00h	DWORD	next sequence number
 04h	DWORD	(big-endian) subdirectory number
 08h	DWORD	(big-endian) attributes
 0Ch	BYTE	unique ID
 0Dh	BYTE	flags
 0Eh	BYTE	name space (see #02387)
 0Fh	BYTE	length of name
 10h 12 BYTEs	name
 1Ch	DWORD	creation date and time
 20h	DWORD	owner ID
 24h	DWORD	date and time last backed up
 28h	DWORD	last-backup ID
 2Ch	DWORD	date and time last modified
 30h	DWORD	last-modification ID
 34h	DWORD	data fork size
 38h	DWORD	data fork first FAT
 3Ch	DWORD	next trustee entry
 40h 36 BYTEs	reserved
 64h	WORD	inherited rights mask
 66h	WORD	last-access date
 68h	DWORD	deleted file date and time
 6Ch	DWORD	date and time file was deleted
 70h	DWORD	deleted ID
 74h  8 BYTEs	undefined
 7Ch	DWORD	primary entry
 80h	DWORD	name list
 84h	DWORD	other file fork size
SeeAlso: #02142
--------N-21F216SF29-------------------------
INT 21 - Novell NetWare v3+ - GET OBJECT DISK USAGE AND RESTRICTIONS
	AX = F216h subfn 29h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02144)
	ES:DI -> reply buffer (see #02145)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
Note:	this function returns successfully, showing no restriction, if an
	  invalid object ID is specified
SeeAlso: AX=F216h/SF=24h,AX=F216h/SF=33h

Format of NetWare "Get Object Disk Restrictions" request buffer:
Offset	Size	Description	(Table 02144)
 00h	WORD	0006h (length of following data)
 02h	BYTE	21h (subfunction "Get Object Disk Restrictions")
 03h	BYTE	volume number
 04h	DWORD	(big-endian) object ID
SeeAlso: #02145

Format of NetWare "Get Object Disk Restrictions" reply buffer:
Offset	Size	Description	(Table 02145)
 00h	DWORD	disk space limit
 04h	DWORD	disk space currently in use by object
SeeAlso: #02144
--------N-21F216SF2A-------------------------
INT 21 - Novell NetWare - GET EFFECTIVE RIGHTS
	AX = F216h subfn 2Ah
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02146)
	ES:DI -> reply buffer (see #02147)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=32h

Format of NetWare "Get Effective Rights" request packet:
Offset	Size	Description	(Table 02146)
 00h	WORD	length of following data
 02h	BYTE	2Ah (subfunction "Get Effective Rights")
	???
--------N-21F216SF2B-------------------------
INT 21 - Novell NetWare - REMOVE EXTENDED TRUSTEE FROM DIR OR FILE
	AX = F216h subfn 2Bh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02117,#02147)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=26h,AX=F216h/SF=27h

Format of NetWare "Remove Extended Trustee From Dir Or File" request packet:
Offset	Size	Description	(Table 02147)
 00h	WORD	length of following data
 02h	BYTE	2Bh (subfunction "Remove Extended Trustee From Dir Or File")
 03h	BYTE	directory handle
 04h	DWORD	trustee's object ID
 08h	BYTE	unused
 09h	BYTE	length of pathname
 0Ah  N BYTEs	directory path in form VOLUME:DIRECTORY/.../DIRECTORY
--------N-21F216SF2C-------------------------
INT 21 - Novell NetWare - GET VOLUME USAGE
	AX = F216h subfn 2Ch
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02148)
	ES:DI -> reply buffer (see #02149)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=20h,AX=F216h/SF=29h

Format of NetWare "Get Volume Usage" request packet:
Offset	Size	Description	(Table 02148)
 00h	WORD	length of following data
 02h	BYTE	2Ch (subfunction "Get Volume Usage")
	???
--------N-21F216SF2D-------------------------
INT 21 - Novell NetWare - GET DIRECTORY INFORMATION
	AX = F216h subfn 2Dh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02149)
	ES:DI -> reply buffer (see #02150)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=2Ch,AX=F216h/SF=2Eh

Format of NetWare "Get Directory Information" request packet:
Offset	Size	Description	(Table 02149)
 00h	WORD	length of following data
 02h	BYTE	2Dh (subfunction "Get Directory Information")
 03h	BYTE	directory handle
SeeAlso: #02150

Format of NetWare "Get Directory Information" reply packet:
Offset	Size	Description	(Table 02150)
 00h	DWORD	total blocks
 04h	DWORD	available blocks
 08h	DWORD	total number of directory entries
 0Ch	DWORD	number of available directory entries
 10h  4 BYTEs	reserved
 14h	BYTE	sectors per block
 15h	BYTE	length of volume name
 16h  N BYTEs	volume name
SeeAlso: #02149
--------N-21F216SF2E-------------------------
INT 21 - Novell NetWare - RENAME OR MOVE
	AX = F216h subfn 2Eh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02151)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=34h,AX=F223h/SF=07h,AX=F244h

Format of NetWare "Rename Or Move" request packet:
Offset	Size	Description	(Table 02151)
 00h	WORD	length of following data
 02h	BYTE	2Eh (subfunction "Rename Or Move")
 03h	BYTE	source directory handle
 04h	BYTE	search attributes
 05h	BYTE	source path component count
 06h  N BYTEs	source path
	BYTE	destination directory handle
	BYTE	destination path component count
      N BYTEs	destination path
--------N-21F216SF2F-------------------------
INT 21 - Novell NetWare - GET NAME SPACE INFORMATION
	AX = F216h subfn 2Fh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02152)
	ES:DI -> reply buffer (see #02153)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=30h,AX=F257h/SF=18h

Format of NetWare "Get Name Space Information" request packet:
Offset	Size	Description	(Table 02152)
 00h	WORD	length of following data
 02h	BYTE	2Fh (subfunction "Get Name Space Information")
 03h	BYTE	volume number
SeeAlso: #02153

Format of NetWare "Get Name Space Information" request packet:
Offset	Size	Description	(Table 02153)
 00h	BYTE	length of namespace name
 01h  N BYTEs	name of namespace
	BYTE	number of data streams
	var	data stream information [one entry per data stream]
		Offset	Size	Description
		 00h	BYTE	associated name space
		 01h	BYTE	length of data stream name
		 02h  N BYTEs	data stream name
	BYTE	number of loaded name spaces
	BYTE	bitmap of loaded name spaces
      N BYTEs	list of name spaces being used
	BYTE	index number
SeeAlso: #02152
--------N-21F216SF30-------------------------
INT 21 - Novell NetWare - GET NAME SPACE DIRECTORY ENTRY
	AX = F216h subfn 30h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02154)
	ES:DI -> reply buffer (see #02155)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=2Fh

Format of NetWare "Get Name Space Directory Entry" request packet:
Offset	Size	Description	(Table 02154)
 00h	WORD	length of following data
 02h	BYTE	30h (subfunction "Get Name Space Directory Entry")
 03h	BYTE	volume number
 04h	DWORD	sequence number (set to 00000000h before first call)
 08h	BYTE	name space (see #02387)
SeeAlso: #02155

Format of NetWare "Get Name Space Directory Entry" request packet:
Offset	Size	Description	(Table 02155)
 00h	DWORD	next sequence number
 04h	DWORD	subdirectory
 08h	DWORD	attributes
 0Ch	BYTE	unique ID
 0Dh	BYTE	flags
 0Eh	BYTE	name space (see #02387)
 0Fh	BYTE	length of name
 10h 12 BYTEs	filename
 1Ch	DWORD	creation date and time
 20h	DWORD	(big-endian) owner ID
 24h	DWORD	last-backup date and time
 28h	DWORD	(big-endian) last-backup ID
 2Ch	DWORD	last-modification date and time
---DOS file---
 30h	DWORD	(big-endian) last-modification ID
 34h	DWORD	file size
 38h 44 BYTEs	reserved
 64h	WORD	inherited rights mask
 66h	WORD	last-access date
 68h 28 BYTEs	reserved
---DOS subdirectory---
 30h	DWORD	next trustee entry
 34h 48 BYTEs	reserved
 64h	WORD	maximum space
 66h	WORD	inherited rights mask
 68h 26 BYTEs	reserved
---Macintosh subdirectory---
 10h 32 BYTEs	Mac filename
 30h	DWORD	resource fork
 34h	DWORD	resource fork size
 38h 32 BYTEs	Finder information
 58h  6 BYTEs	ProDOS information
 5Eh 38 BYTEs	reserved
SeeAlso: #02154
--------N-21F216SF31-------------------------
INT 21 - Novell NetWare - OPEN DATA STREAM
	AX = F216h subfn 31h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02156)
	ES:DI -> reply buffer (see #02157)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=30h

Format of NetWare "Open Data Stream" request packet:
Offset	Size	Description	(Table 02156)
 00h	WORD	length of following data
 02h	BYTE	31h (subfunction "Open Data Stream")
 03h	BYTE	data stream
 04h	BYTE	directory handle
 05h	BYTE	file attributes
 06h	BYTE	open rights
 07h	BYTE	length of filename
 08h  N BYTEs	filename (8.3)
SeeAlso: #02157

Format of NetWare "Open Data Stream" reply packet:
Offset	Size	Description	(Table 02157)
 00h	DWORD	file handle
SeeAlso: #02156
--------N-21F216SF32-------------------------
INT 21 - Novell NetWare v2.2+ - GET OBJECT EFFECTIVE RIGHTS
	AX = F216h subfn 32h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02158)
	ES:DI -> reply buffer (see #02159)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F216h/SF=29h

Format of NetWare "Get Object Effective Rights" request buffer:
Offset	Size	Description	(Table 02158)
 00h	WORD	length of following data
 02h	BYTE	32h (subfunction "Get Object Effective Rights")
 03h	DWORD	object ID
 07h	BYTE	directory handle
 08h	var	counted path string
SeeAlso: #02159

Format of NetWare "Get Object Effective Rights" reply buffer:
Offset	Size	Description	(Table 02159)
 00h	WORD	object's effective rights
 02h  6 BYTEs	reserved
SeeAlso: #02158
--------N-21F216SF33-------------------------
INT 21 - Novell NetWare v2.2+ - GET EXTENDED VOLUME INFORMATION
	AX = F216h subfn 33h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02160)
	ES:DI -> reply buffer (see #02161)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F216h/SF=29h

Format of NetWare "Get Extended Volume Information" request buffer:
Offset	Size	Description	(Table 02160)
 00h	WORD	length of following data
 02h	BYTE	33h (subfunction "Get Extended Volume Information")
---v2.2---
 03h	BYTE	volume ID
---v4.x---
 03h	DWORD	volume number
SeeAlso: #02161

Format of NetWare "Get Extended Volume Information" reply buffer:
Offset	Size	Description	(Table 02161)
 00h	WORD	length of returned data
 02h	DWORD	volume type
 06h	DWORD	status flag bits
		bit 0: suballocation
		bit 1: compressoin
		bit 2: migration
		bit 3: auditing
 0Ah	DWORD	sector size
 0Eh	DWORD	sectors per cluster
 12h	DWORD	total clusters in volume
 16h	DWORD	free clusters
 1Ah	DWORD	freeable suballocated clusters
 1Eh	DWORD	freeable in-limbo sectors
 22h	DWORD	non-freeable in-limbo sectors
 26h	DWORD	non-freeable available suballocated sectors
 2Ah	DWORD	unuable suballocated sectors
 2Eh	DWORD	total suballocated clusters
 32h	DWORD	number of data streams
 36h	DWORD	number of in-limbo data streams
 3Ah	DWORD	age of oldest deleted file in clock ticks
 3Eh	DWORD	number of compressed data streams
 42h	DWORD	number of compressed in-limbo data streams
 46h	DWORD	number of uncompressable data streams
 4Ah	DWORD	number of precompressed sectors
 4Eh	DWORD	number of compressed sectors
 52h	DWORD	number of migrated files
 56h	DWORD	number of migrated sectors
 5Ah	DWORD	number of clusters used by FAT
 5Eh	DWORD	number of clusters used by directories
 62h	DWORD	number of clusters used by extended directories
 66h	DWORD	total number of directory entries
 6Ah	DWORD	number of unused directory entries
 6Eh	DWORD	total number of extended directory extants
 72h	DWORD	number of unused extended directory extants
 76h	DWORD	number of extended attributes defined (see AX=F256h/SF=04h)
 7Ah	DWORD	number of extended-attribute extants used
 7Eh	DWORD	object ID for Directory Services
 82h	DWORD	date and time volume last modified
 86h	var	counted volume name string
SeeAlso: #02160
--------N-21F217SF01-------------------------
INT 21 - Novell NetWare - CHANGE USER PASSWORD (OLD)
	AX = F217h subfn 01h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01891 at AH=E3h/SF=01h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Note:	this function requires an object of type USER, unlike the newer
	  password changing function AX=F217h/SF=40h
SeeAlso: AH=F2h"Novell",AH=E3h/SF=01h,AX=F217h/SF=02h,AX=F217h/SF=40h
--------N-21F217SF02-------------------------
INT 21 - Novell NetWare - GET USER CONNECTION LIST (OLD)
	AX = F217h subfn 02h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01892 at AH=E3h/SF=02h)
	ES:DI -> reply buffer (see #02162)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=02h,AX=F217h/SF=01h,AX=F217h/SF=0Ch

Format of NetWare "Get User Connection List (old)" reply packet:
Offset	Size	Description	(Table 02162)
 00h	BYTE	length of connection list
 01h	BYTE	number of bytes in connection list
 02h  N BYTEs	list of connection numbers in use by user
SeeAlso: #01892
--------N-21F217SF0C-------------------------
INT 21 - Novell NetWare - VERIFY SERIALIZATION
	AX = F217h subfn 0Ch
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01896 at AH=E3h/SF=0Ch)
	ES:DI -> reply buffer (see #02163)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=0Ch,AX=F217h/SF=12h

Format of NetWare "Verify Serialization" reply packet:
Offset	Size	Description	(Table 02163)
 00h	WORD	server application number
SeeAlso: #01896
--------N-21F217SF0E-------------------------
INT 21 - Novell NetWare - GET DISK UTILIZATION
	AX = F217h subfn 0Eh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01900 at AH=E3h/SF=0Eh)
	ES:DI -> reply buffer (see #02164)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=0Eh,AX=F217h/SF=D6h

Format of NetWare "Get Disk Utilization" reply packet:
Offset	Size	Description	(Table 02164)
 00h	BYTE	volume number (00h-1Fh)
 01h	DWORD	(big-endian) object ID
 05h	WORD	(big-endian) directories used by object
 07h	WORD	(big-endian) files created by object
 09h	WORD	(big-endian) disk blocks used by object-created files
SeeAlso: #01900 at AH=E3h/SF=0Eh
--------N-21F217SF0F-------------------------
INT 21 - Novell NetWare - SCAN FILE INFORMATION
	AX = F217h subfn 0Fh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01903 at AH=E3h/SF=0Fh)
	ES:DI -> reply buffer (see #02165)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=0Fh,AX=F217h/SF=10h

Format of NetWare "Scan File Information" reply packet:
Offset	Size	Description	(Table 02165)
 00h	WORD	next sequence number (place in request buffer for next call)
 02h 14 BYTEs	ASCIZ filename
 10h	BYTE	file attributes (see #01420 at AX=4301h)
 11h	BYTE	extended file attributes (see #01804 at AH=B6h)
 12h	DWORD	(big-endian) file size in bytes
 16h	WORD	(big-endian) file's creation date (see #01666 at AX=5700h)
 18h	WORD	(big-endian) date of last access (see #01665 at AX=5700h)
 1Ah	DWORD	(big-endian) date and time of last update (see #01846)
 1Eh	DWORD	(big-endian) object ID of owner
 22h	DWORD	(big-endian) date and time last archived (see #01846)
 26h 55 BYTEs	reserved
SeeAlso: #01903 at AH=E3h/SF=0Fh
--------N-21F217SF10-------------------------
INT 21 - Novell NetWare - SET FILE INFORMATION
	AX = F217h subfn 10h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01905 at AH=E3h/SF=10h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=10h,AX=F217h/SF=0Fh
--------N-21F217SF11-------------------------
INT 21 - Novell NetWare - GET FILE SERVER INFORMATION
	AX = F217h subfn 11h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01907 at AH=E3h/SF=11h)
	ES:DI -> reply buffer (see #02166)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=11h,AX=F217h/SF=F1h

Format of NetWare "Get File Server Information" reply packet:
Offset	Size	Description	(Table 02166)
 00h 48 BYTEs	server's name
 30h	BYTE	NetWare version
 31h	BYTE	NetWare subversion (0-99)
 32h	WORD	(big-endian) number of connections supported
		NetWare 4.01 reportedly returns maximum simulataneously-used
		  connections
 34h	WORD	(big-endian) number of connections in use
 36h	WORD	(big-endian) maximum connected volumes
---Advanced NetWare 2.1+ ---
 38h	BYTE	operating system revision number
 39h	BYTE	fault tolerance (SFT) level
 3Ah	BYTE	TTS level
 3Bh	WORD	(big-endian) maximum simultaneously-used connections
		NetWare 4.01 reportedly returns number of connections in use
 3Dh	BYTE	accounting version
 3Eh	BYTE	VAP version
 3Fh	BYTE	queueing version
 40h	BYTE	print server version
 41h	BYTE	virtual console version
 42h	BYTE	security restrictions level
 43h	BYTE	internetwork bridge version
 44h 60 BYTEs	reserved
SeeAlso: #01907
--------N-21F217SF12-------------------------
INT 21 - Novell NetWare - GET NETWORK SERIAL NUMBER
	AX = F217h subfn 12h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01909 at AH=E3h/SF=12h)
	ES:DI -> reply buffer (see #02167)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=12h,AX=F217h/SF=0Ch

Format of NetWare "Get Network Serial Number" reply packet:
Offset	Size	Description	(Table 02167)
 00h   4 BYTEs	(big-endian) NetWare server serial number
 04h   2 BYTEs	(big-endian) NetWare application serial number
SeeAlso: #01909 at AH=E3h/SF=12h
--------N-21F217SF13-------------------------
INT 21 - Novell NetWare - GET INTERNET ADDRESS (OLD)
	AX = F217h subfn 13h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01911 at AH=E3h/SF=13h)
	ES:DI -> reply buffer (see #02168)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=13h,AX=F217h/SF=1Ah

Format of NetWare "Get Internet Address (old)" reply packet:
Offset	Size	Description	(Table 02168)
 00h  4 BYTEs	network number
 04h  6 BYTEs	physical node address
 0Ah  2 BYTEs	socket number
SeeAlso: #01911 at AH=E3h/SF=13h,#02174
--------N-21F217SF14-------------------------
INT 21 - Novell NetWare - LOGIN OBJECT
	AX = F217h subfn 14h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01913 at AH=E3h/SF=14h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=14h,AX=F216h/SF=18h,AX=F217h/SF=CCh
SeeAlso: AX=F258h/SF=03h,AX=F268h/SF=3Dh
--------N-21F217SF15-------------------------
INT 21 - Novell NetWare - GET OBJECT CONNECTION LIST (OLD)
	AX = F217h subfn 15h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01915 at AH=E3h/SF=15h)
	ES:DI -> reply buffer (see #02169)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=15h,AX=F217h/SF=1Bh

Format of NetWare "Get Object Connection List (old)" reply packet:
Offset	Size	Description	(Table 02169)
 00h	BYTE	number of connections
 01h  N BYTEs	connection list
SeeAlso: #01915
--------N-21F217SF16-------------------------
INT 21 - Novell NetWare - GET CONNECTION INFORMATION (OLD)
	AX = F217h subfn 16h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02170)
	ES:DI -> reply buffer (see #02171)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=1Ch,AX=F217h/SF=1Fh

Format of NetWare "Get Connection Information (old)" request packet:
Offset	Size	Description	(Table 02170)
 00h	WORD	0002h (length of following data)
 02h	BYTE	16h (subfunction "Get Connection Information (old)")
 03h	BYTE	target connection number
Note:	connection numbers greater than the maximum supported by the server
	  can cause ABENDs
SeeAlso: #02171

Format of NetWare "Get Connection Information (old)" reply packet:
Offset	Size	Description	(Table 02171)
 00h	DWORD	(big-endian) unique user ID, 00000000h if no one logged in
 04h	WORD	(big-endian) user type
 06h 48 BYTEs	user name
 36h  7 BYTEs	login time (see #02087)
 3Dh	BYTE	reserved
SeeAlso: #02170
--------N-21F217SF17-------------------------
INT 21 - Novell NetWare - GET ENCRYPTION KEY
	AX = F217h subfn 17h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02172)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=18h,AX=F217h/SF=4Ah,AX=F217h/SF=4Bh

Format of NetWare "Get Encryption Key" request packet:
Offset	Size	Description	(Table 02172)
 00h	WORD	length of following data
 02h	BYTE	17h (subfunction "Get Encryption Key")
	???
--------N-21F217SF18-------------------------
INT 21 - Novell NetWare - LOGIN OBJECT ENCRYPTED
	AX = F217h subfn 18h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02173)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=14h,AX=F217h/SF=17h

Format of NetWare "Login Object Encrypted" request packet:
Offset	Size	Description	(Table 02173)
 00h	WORD	length of following data
 02h	BYTE	18h (subfunction "Login Object Encrypted")
	???
--------N-21F217SF1A-------------------------
INT 21 - Novell NetWare - GET INTERNET ADDRESS
	AX = F217h subfn 1Ah
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02174)
	ES:DI -> reply buffer (see #02175)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=13h

Format of NetWare "Get Internet Address" request packet:
Offset	Size	Description	(Table 02174)
 00h	WORD	length of following data
 02h	BYTE	1Ah (subfunction "Get Internet Address")
 03h	DWORD	target connection ID
SeeAlso: #02175

Format of NetWare "Get Internet Address" reply packet:
Offset	Size	Description	(Table 02175)
 00h  4 BYTEs	network number
 04h  6 BYTEs	physical node address
 0Ah  2 BYTEs	socket number
 0Ch	BYTE	connection type
		00h not in use
		02h NCP
		03h AFP
SeeAlso: #02174
--------N-21F217SF1B-------------------------
INT 21 - Novell NetWare - GET OBJECT CONNECTION LIST
	AX = F217h subfn 1Bh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02176)
	ES:DI -> reply buffer (see #02177)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=15h

Format of NetWare "Get Object Connection List" request packet:
Offset	Size	Description	(Table 02176)
 00h	WORD	length of following data
 02h	BYTE	1Bh (subfunction "Get Object Connection List")
 03h	DWORD	search connection number
		set to highest connection number returned by previous call, or
		  00000000h before first call
 07h	WORD	object type
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object name
SeeAlso: #02177

Format of NetWare "Get Object Connection List" reply packet:
Offset	Size	Description	(Table 02177)
 00h	BYTE	length of connection number list
 01h  N WORDs	array of server connection numbers
SeeAlso: #02176
--------N-21F217SF1C-------------------------
INT 21 - Novell NetWare v3+ - GET CONNECTION INFORMATION
	AX = F217h subfn 1Ch
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02178)
	ES:DI -> reply buffer (see #02179)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=16h,AX=F217h/SF=1Fh

Format of NetWare "Get Connection Information" request packet:
Offset	Size	Description	(Table 02178)
 00h	WORD	0005h (length of following data)
 02h	BYTE	1Ch (subfunction "Get Connection Information")
 03h	DWORD	target connection number
Note:	connection numbers greater than the maximum supported by the server
	  can cause ABENDs
SeeAlso: #02179,#02170

Format of NetWare "Get Connection Information" reply packet:
Offset	Size	Description	(Table 02179)
 00h	DWORD	(big-endian) unique user ID, 00000000h if no one logged in
 04h	WORD	(big-endian) user type
 06h 48 BYTEs	user name
 36h  7 BYTEs	login time (see #02087)
 3Dh	BYTE	reserved
SeeAlso: #02178,#02171
--------N-21F217SF1D-------------------------
INT 21 - Novell NetWare v4 - CHANGE CONNECTION STATE
	AX = F217h subfn 1Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02180)
	ES:DI -> reply buffer
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Change Connection State" requst buffer:
Offset	Size	Description	(Table 02180)
 00h	WORD	length of following data
 02h	BYTE	1Dh (subfunction "Change Connection State")
 03h	DWORD	new state
--------N-21F217SF1E-------------------------
INT 21 - Novell NetWare v4 - SET WATCHDOG DELAY INTERVAL
	AX = F217h subfn 1Eh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02181)
	ES:DI -> reply buffer
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Set Watchdog Delay Interval" request buffer:
Offset	Size	Description	(Table 02181)
 00h	WORD	length of following data
 02h	BYTE	1Eh (subfunction "Set Watchdog Delay Interval")
 03h	DWORD	interval in minutes
--------N-21F217SF1F-------------------------
INT 21 - Novell NetWare v4 - GET CONNECTION LIST
	AX = F217h subfn 1Fh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02182)
	ES:DI -> reply buffer (see #02183)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Connection List" request buffer:
Offset	Size	Description	(Table 02182)
 00h	WORD	length of following data
 02h	BYTE	1Fh (subfunction "Get Connection List")
 03h	DWORD	object ID
 07h	DWORD	??? (initialize to FFFFFFFFh before first call)
SeeAlso: #02183

Format of NetWare "Get Connection List" reply buffer:
Offset	Size	Description	(Table 02183)
 00h	WORD	number of connections following (max 50)
 02h 50 DWORDs	connection numbers
SeeAlso: #02182
--------N-21F217SF32-------------------------
INT 21 - Novell NetWare - CREATE BINDERY OBJECT
	AX = F217h subfn 32h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01921 at AH=E3h/SF=32h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=32h,AX=F217h/SF=33h,AX=F217h/SF=34h
--------N-21F217SF33-------------------------
INT 21 - Novell NetWare - DELETE BINDERY OBJECT
	AX = F217h subfn 33h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01923 at AH=E3h/SF=33h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=33h,AX=F217h/SF=32h,AX=F217h/SF=34h
--------N-21F217SF34-------------------------
INT 21 - Novell NetWare - RENAME BINDERY OBJECT
	AX = F217h subfn 34h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01924 at AH=E3h/SF=34h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=34h,AX=F217h/SF=32h,AX=F217h/SF=33h
--------N-21F217SF35-------------------------
INT 21 - Novell NetWare - GET BINDERY OBJECT ID
	AX = F217h subfn 35h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01925 at AH=E3h/SF=35h)
	ES:DI -> reply buffer (see #02184)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=35h,AX=F217h/SF=36h,AX=F217h/SF=45h

Format of NetWare "Get Bindery Object ID" reply packet:
Offset	Size	Description	(Table 02184)
 00h	DWORD	(big-endian) object ID
 04h	WORD	(big-endian) type of object
 06h 48 BYTEs	object name
SeeAlso: #01925 at AH=E3h/SF=35h
--------N-21F217SF36-------------------------
INT 21 - Novell NetWare - GET BINDERY OBJECT NAME
	AX = F217h subfn 36h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01928 at AH=E3h/SF=36h)
	ES:DI -> reply buffer (see #02185)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=36h,AX=F217h/SF=35h,AX=F217h/SF=37h

Format of NetWare "Get Bindery Object Name" reply packet:
Offset	Size	Description	(Table 02185)
 00h	DWORD	(big-endian) object ID
 04h	WORD	(big-endian) type of object
 06h 48 BYTEs	object name
SeeAlso: #01928 at AH=E3h/SF=36h
--------N-21F217SF37-------------------------
INT 21 - Novell NetWare - SCAN BINDERY OBJECT
	AX = F217h subfn 37h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01930 at AH=E3h/SF=37h)
	ES:DI -> reply buffer (see #02186)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=37h,AX=F217h/SF=3Ch

Format of NetWare "Scan Bindery Object" reply packet:
Offset	Size	Description	(Table 02186)
 00h
SeeAlso: #01930
--------N-21F217SF38-------------------------
INT 21 - Novell NetWare - CHANGE BINDERY OBJECT SECURITY
	AX = F217h subfn 38h
	CX = length of request packet in bytes
	DX = 0000h (no reply buffer)
	DS:SI -> request packet	(see #01932 at AH=E3h/SF=38h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=38h,AX=F217h/SF=32h
--------N-21F217SF39-------------------------
INT 21 - Novell NetWare - CREATE PROPERTY
	AX = F217h subfn 39h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01934 at AH=E3h/SF=39h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=39h,AX=F217h/SF=3Ah
--------N-21F217SF3A-------------------------
INT 21 - Novell NetWare - DELETE PROPERTY
	AX = F217h subfn 3Ah
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01936 at AH=E3h/SF=3Ah)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Ah,AX=F217h/SF=39h,AX=F217h/SF=3Bh
--------N-21F217SF3B-------------------------
INT 21 - Novell NetWare - CHANGE PROPERTY SECURITY
	AX = F217h subfn 3Bh
	CX = length of request packet in bytes
	DX = 0000h (no reply buffer)
	DS:SI -> request packet	(see #01938 at AH=E3h/SF=3Bh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Bh
--------N-21F217SF3C-------------------------
INT 21 - Novell NetWare - SCAN PROPERTY
	AX = F217h subfn 3Ch
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01939 at AH=E3h/SF=3Ch)
	ES:DI -> reply buffer (see #02187)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Ch,AX=F217h/SF=39h,AX=F217h/SF=3Dh

Format of NetWare "Scan Property" reply packet:
Offset	Size	Description	(Table 02187)
 00h
SeeAlso: #01939
--------N-21F217SF3D-------------------------
INT 21 - Novell NetWare - READ PROPERTY VALUE
	AX = F217h subfn 3Dh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01942 at AH=E3h/SF=3Dh)
	ES:DI -> reply buffer (see #02188)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Dh,AX=F217h/SF=39h,AX=F217h/SF=3Eh

Format of NetWare "Read Property Value" request packet:
Offset	Size	Description	(Table 02188)
 00h
SeeAlso: #01942
--------N-21F217SF3E-------------------------
INT 21 - Novell NetWare - WRITE PROPERTY VALUE
	AX = F217h subfn 3Eh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01944 at AH=E3h/SF=3Eh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Eh,AX=F217h/SF=39h,AX=F217h/SF=3Dh
--------N-21F217SF3F-------------------------
INT 21 - Novell NetWare - VERIFY BINDERY OBJECT PASSWORD
	AX = F217h subfn 3Fh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01947 at AH=E3h/SF=3Fh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=3Fh,AX=F217h/SF=40h
--------N-21F217SF40-------------------------
INT 21 - Novell NetWare - CHANGE BINDERY OBJECT PASSWORD
	AX = F217h subfn 40h
	CX = length of request packet in bytes
	DX = 0000h (no reply buffer)
	DS:SI -> request packet (see #01948 at AH=E3h/SF=40h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=40h,AX=F217h/SF=3Fh
--------N-21F217SF41-------------------------
INT 21 - Novell NetWare v2.2+ - ADD OBJECT TO SET
	AX = F217h subfn 41h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01951 at AH=E3h/SF=41h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Desc:	add a member to an object's group property
SeeAlso: AH=F2h"Novell",AH=E3h/SF=41h,AX=F217h/SF=42h,AX=F217h/SF=43h
--------N-21F217SF42-------------------------
INT 21 - Novell NetWare - DELETE BINDERY OBJECT FROM SET
	AX = F217h subfn 42h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01952 at AH=E3h/SF=42h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=42h,AX=F217h/SF=41h,AX=F217h/SF=43h
--------N-21F217SF43-------------------------
INT 21 - Novell NetWare - IS BINDERY OBJECT IN SET?
	AX = F217h subfn 43h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01954 at AH=E3h/SF=43h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=43h,AX=F217h/SF=41h,AX=F217h/SF=42h
--------N-21F217SF44-------------------------
INT 21 - Novell NetWare - CLOSE BINDERY
	AX = F217h subfn 44h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01955 at AH=E3h/SF=44h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=44h,AX=F217h/SF=45h
--------N-21F217SF45-------------------------
INT 21 - Novell NetWare - OPEN BINDERY
	AX = F217h subfn 45h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet	(see #01956 at AH=E3h/SF=45h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=45h,AX=F217h/SF=44h
--------N-21F217SF46-------------------------
INT 21 - Novell NetWare - GET BINDERY ACCESS LEVEL
	AX = F217h subfn 46h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01957 at AH=E3h/SF=46h)
	ES:DI -> reply buffer (see #02189)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=46h,AX=F217h/SF=45h

Format of NetWare "Get Bindery Access Level" reply packet:
Offset	Size	Description	(Table 02189)
 00h	BYTE	security levels
 01h	DWORD	(big-endian) object ID
SeeAlso: #01957,#01958 at AH=E3h/SF=46h
--------N-21F217SF47-------------------------
INT 21 - Novell NetWare - SCAN BINDERY OBJECT TRUSTEE PATHS
	AX = F217h subfn 47h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01959 at AH=E3h/SF=47h)
	ES:DI -> reply buffer (see #02190)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=47h,AX=F216h/SF=0Ch,AX=F217h/SF=48h

Format of NetWare "Scan Bindery Object Trustee Paths" reply packet:
Offset	Size	Description	(Table 02190)
 00h	WORD	(big-endian) next sequence number
 02h	DWORD	(big-endian) object ID
 06h	BYTE	trustee directory rights (see #01849 at AH=E2h/SF=03h)
 07h	BYTE	length of trustee path
 08h  N BYTEs	trustee path
SeeAlso: #01959,#01960 at AH=E3h/SF=47h
--------N-21F217SF48-------------------------
INT 21 - Novell NetWare - GET BINDERY OBJECT ACCESS LEVEL
	AX = F217h subfn 48h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02191)
	ES:DI -> reply buffer (see #02192)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=45h,AX=F217h/SF=46h

Format of NetWare "Get Bindery Object Access Level" request packet:
Offset	Size	Description	(Table 02191)
 00h	WORD	length of following data (max ABh)
 02h	BYTE	48h (subfunction "Get Bindery Object Access Level")
 03h	DWORD	object ID
SeeAlso: #02192

Format of NetWare "Get Bindery Object Access Level" reply packet:
Offset	Size	Description	(Table 02192)
 00h	BYTE	object access level
SeeAlso: #02191
--------N-21F217SF49-------------------------
INT 21 - Novell NetWare - IS STATION A MANAGER?
	AX = F217h subfn 49h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02193)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=43h

Format of NetWare "Is Station A Manager?" request packet:
Offset	Size	Description	(Table 02193)
 00h	WORD	length of following data
 02h	BYTE	49h (subfunction "Is Station A Manager?")
 03h	DWORD	object ID
--------N-21F217SF4A-------------------------
INT 21 - Novell NetWare - KEYED VERIFY BINDERY OBJECT PASSWORD
	AX = F217h subfn 4Ah
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02194)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=4Bh

Format of NetWare "Keyed Verify Bindery Object Password" request packet:
Offset	Size	Description	(Table 02194)
 00h	WORD	length of following data
 02h	BYTE	4Ah (subfunction "Keyed Verify Bindery Object Password")
 03h  8 BYTEs	key
 0Bh	WORD	type
 0Dh	BYTE	length of object's name
 0Eh  N BYTEs	object name
SeeAlso: #02195
--------N-21F217SF4B-------------------------
INT 21 - Novell NetWare - KEYED CHANGE BINDERY OBJECT PASSWORD
	AX = F217h subfn 4Bh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02195)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=4Ah

Format of NetWare "Keyed Change Bindery Object Password" request packet:
Offset	Size	Description	(Table 02195)
 00h	WORD	length of following data
 02h	BYTE	4Bh (subfunction "Keyed Change Bindery Object Password")
 03h  8 BYTEs	key
 0Bh	WORD	type
 0Dh	BYTE	length of object name
 0Eh  N BYTEs	object name
	BYTE	length of new password
      N BYTEs	new password
SeeAlso: #01948
--------N-21F217SF4C-------------------------
INT 21 - Novell NetWare - LIST RELATIONS OF AN OBJECT
	AX = F217h subfn 4Ch
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02196)
	ES:DI -> reply buffer (see #02197)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=39h

Format of NetWare "List Relations Of An Object" request packet:
Offset	Size	Description	(Table 02196)
 00h	WORD	length of following data
 02h	BYTE	4Ch (subfunction "List Relations Of An Object")
 03h	DWORD	last bindery ID seen (set to FFFFFFFFh on first call)
 07h	WORD	object type
 09h	BYTE	length of object's name
 0Ah  N BYTEs	object's name
	BYTE	length of property name
      N BYTEs	property name
SeeAlso: #02197

Format of NetWare "List Relations Of An Object" reply packet:
Offset	Size	Description	(Table 02197)
 00h	WORD	number of relations returned
 02h	var	relations
SeeAlso: #02196
--------N-21F217SF64-------------------------
INT 21 - Novell NetWare v2.1+ - CREATE QUEUE
	AX = F217h subfn 64h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01962 at AH=E3h/SF=64h)
	ES:DI -> reply buffer (see #02198)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=64h,AX=F217h/SF=65h,AX=F217h/SF=66h

Format of NetWare "Create Queue" reply packet:
Offset	Size	Description	(Table 02198)
 00h	DWORD	(big-endian) object ID of queue
SeeAlso: #01962,#01963
--------N-21F217SF65-------------------------
INT 21 - Novell NetWare v2.1+ - DESTROY QUEUE
	AX = F217h subfn 65h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01964 at AH=E3h/SF=65h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=65h,AX=F217h/SF=64h,AX=F217h/SF=66h
--------N-21F217SF66-------------------------
INT 21 - Novell NetWare v2.1+ - READ QUEUE CURRENT STATUS (OLD)
	AX = F217h subfn 66h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01965 at AH=E3h/SF=64h)
	ES:DI -> reply buffer (see #02199)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=66h,AX=F217h/SF=64h,AX=F217h/SF=67h

Format of NetWare "Read Queue Current Status (Old)" reply packet:
Offset	Size	Description	(Table 02199)
 00h	DWORD	(big-endian) object ID of queue
 04h	BYTE	status of queue (see #01967)
 05h	BYTE	number of jobs in queue (00h-FAh)
 06h	BYTE	number of servers attached to queue (00h-19h)
 07h 25 DWORDs	list of object IDs of attached servers
 6Bh 25 BYTEs	list of attached servers' stations
 84h	BYTE	(call) maximum number of servers to return
SeeAlso: #01965,#01966 at AH=E3h/SF=66h
--------N-21F217SF67-------------------------
INT 21 - Novell NetWare v2.1+ - SET QUEUE CURRENT STATUS (OLD)
	AX = F217h subfn 67h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01968 at AH=E3h/SF=67h)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=67h,AX=F217h/SF=66h,AX=F217h/SF=68h
--------N-21F217SF68-------------------------
INT 21 - Novell NetWare v2.1+ - CREATE QUEUE JOB AND FILE (OLD)
	AX = F217h subfn 68h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01970 at AH=E3h/SF=68h)
	ES:DI -> reply buffer (see #02200)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=68h,AX=F217h/SF=67h,AX=F217h/SF=69h

Format of NetWare "Create Queue Job And File (Old)" reply packet:
Offset	Size	Description	(Table 02200)
 00h	BYTE	client station
 01h	BYTE	client task number
 02h	DWORD	(big-endian) object ID of client
 06h	DWORD	(big-endian) object ID of target server
 0Ah  6 BYTEs	target execution time (year,month,day,hour,minute,second)
 10h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 16h	WORD	(big-endian) job number
 18h	WORD	(big-endian) job type
 1Ah	BYTE	job position
 1Bh	BYTE	job control flags (see #01980)
 1Ch 14 BYTEs	ASCIZ job file name
 2Ah  6 BYTEs	job file handle
 30h	BYTE	server station
 31h	BYTE	server task number
 32h	DWORD	(big-endian) object ID of server or 00000000h
SeeAlso: #01970,#01972
--------N-21F217SF69-------------------------
INT 21 - Novell NetWare v2.1+ - CLOSE FILE AND START QUEUE JOB (OLD)
	AX = F217h subfn 69h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01973 at AH=E3h/SF=69h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=69h,AX=F217h/SF=6Ah,AX=F217h/SF=7Fh
--------N-21F217SF6A-------------------------
INT 21 - Novell NetWare v2.1+ - REMOVE JOB FROM QUEUE (OLD)
	AX = F217h subfn 6Ah
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01975 at AH=E3h/SF=6Ah)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=6Ah,AX=F217h/SF=68h,AX=F217h/SF=69h
--------N-21F217SF6B-------------------------
INT 21 - Novell NetWare v2.1+ - GET QUEUE JOB LIST (OLD)
	AX = F217h subfn 6Bh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01976 at AH=E3h/SF=6Bh)
	ES:DI -> reply buffer (see #02201)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=6Bh,AX=F217h/SF=6Ah,AX=F217h/SF=6Ch
SeeAlso: AX=F217h/SF=81h

Format of NetWare "Get Queue Job List (old)" reply packet:
Offset	Size	Description	(Table 02201)
 00h	WORD	(big-endian) job count
 02h  N WORDs	(big-endian) list of job numbers by position in queue
SeeAlso: #01976,#01977 at AH=E3h/SF=6Bh
--------N-21F217SF6C-------------------------
INT 21 - Novell NetWare v2.1+ - READ QUEUE JOB ENTRY (OLD)
	AX = F217h subfn 6Ch
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01978 at AH=E3h/SF=6Ch)
	ES:DI -> reply buffer (see #02202)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=6Ch,AX=F217h/SF=6Bh,AX=F217h/SF=6Dh

Format of NetWare "Read Queue Job Entry (old)" reply packet:
Offset	Size	Description	(Table 02202)
 00h	BYTE	client station number
 01h	BYTE	client task number
 02h	DWORD	object ID of client
 06h	DWORD	(big-endian) object ID of target server
		FFFFFFFFh if any server acceptable
 0Ah  6 BYTEs	target execution time (year,month,day,hour,minute,second)
		FFFFFFFFFFFFh if serviced as soon as possible
 10h  6 BYTEs	job entry time (year,month,day,hour,minute,second)
 16h	WORD	(big-endian) job number
 18h	WORD	(big-endian) job type
 1Ah	BYTE	job position
 1Bh	BYTE	job control flags (see #01980)
 1Ch 14 BYTEs	ASCIZ job filename
 2Ah  6 BYTEs	job file handle
 30h	BYTE	server station
 31h	BYTE	server task number
 32h	DWORD	object ID of server
 36h 50 BYTEs	ASCIZ job description string
 68h 152 BYTEs	client record area
SeeAlso: #01978,#01979
--------N-21F217SF6D-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE QUEUE JOB ENTRY (OLD)
	AX = F217h subfn 6Dh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01981 at AH=E3h/SF=6Dh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=7Bh,AH=E3h/SF=6Dh,AX=F217h/SF=6Ch
--------N-21F217SF6E-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE QUEUE JOB POSITION
	AX = F217h subfn 6Eh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01982 at AH=E3h/SF=6Eh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=F217h/SF=6Dh,AH=E3h/SF=6Eh
--------N-21F217SF6F-------------------------
INT 21 - Novell NetWare v2.1+ - ATTACH QUEUE SERVER TO QUEUE
	AX = F217h subfn 6Fh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01984 at AH=E3h/SF=6Fh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=6Fh,AX=F217h/SF=D2h
--------N-21F217SF70-------------------------
INT 21 - Novell NetWare v2.1+ - DETACH QUEUE SERVER FROM QUEUE
	AX = F217h subfn 70h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01985 at AH=E3h/SF=70h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=70h,AX=F217h/SF=6Fh
--------N-21F217SF71-------------------------
INT 21 - Novell NetWare v2.1+ - SERVICE QUEUE JOB AND OPEN FILE
	AX = F217h subfn 71h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01986 at AH=E3h/SF=71h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Notes:	the caller must be on a workstation which is security-equivalent to a
	  member of the queue's Q_USERS, Q_OPERATORS, or Q_SERVERS properties
SeeAlso: AH=E3h/SF=71h,AX=F217h/SF=70h,AX=F217h/SF=72h
--------N-21F217SF72-------------------------
INT 21 - Novell NetWare v2.1+ - FINISH SERVICING QUEUE JOB (OLD)
	AX = F217h subfn 72h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01987 at AH=E3h/SF=72h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=72h,AX=F217h/SF=71h,AX=F217h/SF=73h
SeeAlso: AX=F217h/SF=83h
--------N-21F217SF73-------------------------
INT 21 - Novell NetWare v2.1+ - ABORT SERVICING QUEUE JOB (OLD)
	AX = F217h subfn 73h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01988 at AH=E3h/SF=73h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=73h,AX=F217h/SF=72h,AX=F217h/SF=84h
--------N-21F217SF74-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE TO CLIENT RIGHTS (OLD)
	AX = F217h subfn 74h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01990 at AH=E3h/SF=74h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Desc:	temporarily assume the login identity of the client submitting the
	  job being serviced
SeeAlso: AH=F2h"NetWare",AH=E3h/SF=74h,AX=F217h/SF=85h
--------N-21F217SF75-------------------------
INT 21 - Novell NetWare v2.1+ - RESTORE QUEUE SERVER RIGHTS
	AX = F217h subfn 75h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01991 at AH=E3h/SF=75h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=75h,AX=F217h/SF=74h
--------N-21F217SF76-------------------------
INT 21 - Novell NetWare - READ QUEUE SERVER CURRENT STATUS (OLD)
	AX = F217h subfn 76h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01992 at AH=E3h/SF=76h)
	ES:DI -> reply buffer (see #02203)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=76h,AX=F217h/SF=74h,AX=F217h/SF=77h

Format of NetWare "Read Queue Server Current Status (old)" reply packet:
Offset	Size	Description	(Table 02203)
 00h 64 BYTEs	server status record (format depends on server)
		first four bytes should contain estimated "price" for an
		  average job
SeeAlso: #01992,#01993 at AH=E3h/SF=76h
--------N-21F217SF77-------------------------
INT 21 - Novell NetWare - SET QUEUE SERVER CURRENT STATUS
	AX = F217h subfn 77h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01994 at AH=E3h/SF=77h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=77h,AX=F217h/SF=76h
--------N-21F217SF78-------------------------
INT 21 - Novell NetWare - GET QUEUE JOB FILE SIZE (OLD)
	AX = F217h subfn 78h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #01996 at AH=E3h/SF=78h)
	ES:DI -> reply buffer (see #02204)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=78h,AX=F217h/SF=71h,AX=F217h/SF=79h

Format of NetWare "Get Queue Job File Size (old)" reply packet:
Offset	Size	Description	(Table 02204)
 00h	DWORD	(big-endian) object ID of queue
 04h	WORD	(big-endian) job number
 06h	DWORD	(big-endian) size of job file in bytes
SeeAlso: #01996,#01997 at AH=E3h/SF=78h
--------N-21F217SF79-------------------------
INT 21 - Novell NetWare - CREATE QUEUE JOB AND FILE
	AX = F217h subfn 79h
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02205)
	ES:DI -> reply buffer (see #02206)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=7Ah,AX=F217h/SF=7Bh

Format of NetWare "Create Queue Job And File" request packet:
Offset	Size	Description	(Table 02205)
 00h	WORD	length of following data
 02h	BYTE	79h (subfunction "Create Queue Job And File")
 03h	DWORD	queue ID
 07h 280 BYTEs	queue job structure (see #02210)
SeeAlso: #02206,#02207,#02209

Format of NetWare "Create Queue Job And File" reply packet:
Offset	Size	Description	(Table 02206)
 00h 10 BYTEs	reserved for future use
 0Ah	DWORD	client station
 0Eh	DWORD	client task
 12h	DWORD	client ID
 16h	DWORD	target server ID
 1Ah  6 BYTEs	target execution time year,month,day,hour,minute,second
		(FFFFFFFFFFFFh = first opportunity)
 20h  6 BYTEs	job entry time
		(set by queue manager)
 26h	DWORD	job number (1-999) assigned by queue manager
 2Ah	WORD	job type
 2Ch	WORD	position of job in queue (0001h = first, etc.)
 2Eh	WORD	job control flags (see #01980 at AH=E3h/SF=6Ch)
 30h 14 BYTEs	ASCIZ job file name
 3Eh	DWORD	job file handle	(set by queue manager)
 42h	DWORD	server station (set by queue manager)
 46h	DWORD	server task number (set by queue manager)
 4Ah	DWORD	server object ID (set by queue manager)
SeeAlso: #02205,#02210
--------N-21F217SF7A-------------------------
INT 21 - Novell NetWare - READ QUEUE JOB ENTRY
	AX = F217h subfn 7Ah
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02207)
	ES:DI -> reply buffer (see #02208)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=79h,AX=F217h/SF=7Bh

Format of NetWare "Read Queue Job Entry" request packet:
Offset	Size	Description	(Table 02207)
 00h	WORD	length of following data
 02h	BYTE	7Ah (subfunction "Read Queue Job Entry")
 03h	DWORD	queue ID
 07h	DWORD	job entry number
SeeAlso: #02208,#02205,#02209

Format of NetWare "Read Queue Job Entry" reply packet:
Offset	Size	Description	(Table 02208)
 00h 280 BYTEs	job structure (see #02210)
SeeAlso: #02207
--------N-21F217SF7B-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE QUEUE JOB ENTRY
	AX = F217h subfn 7Bh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02209)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=6Dh,AX=F217h/SF=79h,AX=F217h/SF=7Dh

Format of NetWare "Change Queue Job Entry" request packet:
Offset	Size	Description	(Table 02209)
 00h	WORD	length of following data
 02h	BYTE	7Bh (subfunction "Change Queue Job Entry")
 03h	DWORD	queue ID
 07h 280 BYTEs	job structure (see #02210)
SeeAlso: #02205,#02207

Format of NetWare v3.11+ job structure:
Offset	Size	Description	(Table 02210)
 00h	WORD	record-in-use flag
 02h	DWORD	-> previous record
 06h	DWORD	-> next record
 0Ah	DWORD	client station connection number
 0Eh	DWORD	client task number
		(set by queue manager)
 12h	DWORD	client object ID
 16h	DWORD	target server object ID
 1Ah  6 BYTEs	target execution time year,month,day,hour,minute,second
		(FFFFFFFFFFFFh = first opportunity)
 20h  6 BYTEs	job entry time
		(set by queue manager)
 26h	DWORD	job number (1-999) assigned by queue manager
 2Ah	WORD	job type
 2Ch	WORD	position of job in queue (0001h = first, etc.)
 2Eh	WORD	job control flags (see #01980 at AH=E3h/SF=6Ch)
 30h 14 BYTEs	ASCIZ job file name
 3Eh	DWORD	job file handle	(set by queue manager)
 42h	DWORD	server station (set by queue manager)
 46h	DWORD	server task number (set by queue manager)
 4Ah	DWORD	server object ID (set by queue manager)
 4Eh 50 BYTEs	ASCIZ job description string
 80h 152 BYTEs	client record area
SeeAlso: #02209,#01971
--------N-21F217SF7D-------------------------
INT 21 - Novell NetWare - READ QUEUE CURRENT STATUS
	AX = F217h subfn 7Dh
	CX = length of request packet in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request packet (see #02211)
	ES:DI -> reply buffer (see #02212)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=66h,AX=F217h/SF=79h,AX=F217h/SF=7Bh
SeeAlso: AX=F217h/SF=7Eh

Format of NetWare "Read Queue Current Status" request packet:
Offset	Size	Description	(Table 02211)
 00h	WORD	length of following data
 02h	BYTE	7Dh (subfunction "Read Queue Current Status")
 03h	DWORD	(big-endian) object ID of queue
SeeAlso: #02212,#02213

Format of NetWare "Read Queue Current Status" reply packet:
Offset	Size	Description	(Table 02212)
 00h	DWORD	queue ID
 04h	DWORD	queue status
		bit 0: no more jobs can be added
		bit 1: no more queue servers can be attached
		bit 2: attached queu servers can not service queue jobs
 08h	DWORD	current number of jobs in queue
 0Ch	DWORD	number of servers attached to queue
 10h  N DWORDs	attached server IDs
SeeAlso: #02211,#01966 at AH=E3h/SF=66h
--------N-21F217SF7E-------------------------
INT 21 - Novell NetWare - SET QUEUE CURRENT STATUS
	AX = F217h subfn 7Eh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02213)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=7Dh

Format of NetWare "Set Queue Current Status" request packet:
Offset	Size	Description	(Table 02213)
 00h	WORD	length of following data
 02h	BYTE	7Eh (subfunction "Set Queue Current Status")
 03h	DWORD	queue ID
 07h	DWORD	queue status
		bit 0: no more jobs can be added
		bit 1: no more queue servers can be attached
		bit 2: attached queu servers can not service queue jobs
SeeAlso: #02211
--------N-21F217SF7F-------------------------
INT 21 - Novell NetWare - CLOSE FILE AND START QUEUE JOB
	AX = F217h subfn 7Fh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02214)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=69h,AX=F217h/SF=80h,AX=F217h/SF=81h

Format of NetWare "Close File And Start Queue Job" request packet:
Offset	Size	Description	(Table 02214)
 00h	WORD	length of following data
 02h	BYTE	7Fh (subfunction "Close File And Start Queue Job")
 03h	DWORD	queue ID
 07h	DWORD	job number
--------N-21F217SF80-------------------------
INT 21 - Novell NetWare - REMOVE JOB FROM QUEUE
	AX = F217h subfn 80h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02215)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=6Ah,AX=F217h/SF=7Fh

Format of NetWare "Remove Job From Queue" request packet:
Offset	Size	Description	(Table 02215)
 00h	WORD	length of following data
 02h	BYTE	80h (subfunction "Remove Job From Queue")
 03h	DWORD	queue ID
 07h	DWORD	job number (returned when job was added to queue)
--------N-21F217SF81-------------------------
INT 21 - Novell NetWare - GET QUEUE JOB LIST
	AX = F217h subfn 81h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02216)
	ES:DI -> reply buffer (see #02217)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=6Bh

Format of NetWare "Get Queue Job List" request packet:
Offset	Size	Description	(Table 02216)
 00h	WORD	length of following data
 02h	BYTE	81h (subfunction "Get Queue Job List")
 03h	DWORD	queue ID
 07h	DWORD	address of next job in queue
SeeAlso: #02217

Format of NetWare "Get Queue Job List" reply packet:
Offset	Size	Description	(Table 02217)
 00h	DWORD	total jobs in queue
 04h	DWORD	length of job number list (max 125)
 08h  N DWORDs	list of job numbers in queue
SeeAlso: #02216
--------N-21F217SF82-------------------------
INT 21 - Novell NetWare v2.1+ - CHANGE JOB PRIORITY
	AX = F217h subfn 82h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02218)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell"

Format of NetWare "Change Job Priority" request packet:
Offset	Size	Description	(Table 02218)
 00h	WORD	length of following data
 02h	BYTE	82h (subfunction "Change Job Priority")
 03h	DWORD	queue ID
 07h	DWORD	job number
 0Bh	DWORD	priority
--------N-21F217SF83-------------------------
INT 21 - Novell NetWare v3.1+ - FINISH SERVICING QUEUE JOB
	AX = F217h subfn 83h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #01998 at AH=E3h/SF=83h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=83h,AX=F217h/SF=72h,AX=F217h/SF=84h
--------N-21F217SF84-------------------------
INT 21 - Novell NetWare v3.1+ - ABORT SERVICING QUEUE JOB
	AX = F217h subfn 84h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02000 at AH=E3h/SF=84h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Desc:	inform the Queue Management System (QMS) that the queue server is
	  unable to service a previously-accepted job
SeeAlso: AH=F2h"Novell",AH=E3h/SF=84h,AX=F217h/SF=73h,AX=F217h/SF=83h
--------N-21F217SF85-------------------------
INT 21 - Novell NetWare v3.1+ - CHANGE TO CLIENT RIGHTS
	AX = F217h subfn 85h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02219)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Desc:	temporarily assume the login identity of the client submitting the
	  job being serviced
SeeAlso: AH=F2h"NetWare",AH=E3h/SF=74h,AX=F217h/SF=74h

Format of NetWare "Change to Client Rights" request packet:
Offset	Size	Description	(Table 02219)
 00h	WORD	length of following data
 02h	BYTE	85h (subfunction "Change to Client Rights")
 03h	DWORD	queue object ID
 07h	DWORD	job number
SeeAlso: #01990
--------N-21F217SF86-------------------------
INT 21 - Novell NetWare v3.1+ - READ QUEUE SERVER CURRENT STATUS
	AX = F217h subfn 86h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02220)
	ES:DI -> reply buffer (see #02221)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=76h,AX=F217h/SF=77h,AX=F217h/SF=7Dh

Format of NetWare "Read Queue Server Current Status" request packet:
Offset	Size	Description	(Table 02220)
 00h	WORD	length of following data
 02h	BYTE	86h (subfunction "Read Queue Server Current Status")
 03h	DWORD	queue ID
 07h	DWORD	server ID
 0Bh	DWORD	connection ID
SeeAlso: #02221

Format of NetWare "Read Queue Server Current Status" request packet:
Offset	Size	Description	(Table 02221)
 00h 64 BYTEs	server status record
SeeAlso: #02220
--------N-21F217SF87-------------------------
INT 21 - Novell NetWare v3.1+ - GET QUEUE JOB FILE SIZE
	AX = F217h subfn 87h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02222)
	ES:DI -> reply buffer (see #02223)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=78h

Format of NetWare "Get Queue Job File Size" request packet:
Offset	Size	Description	(Table 02222)
 00h	WORD	length of following data
 02h	BYTE	87h (subfunction "Get Queue Job File Size")
	???
SeeAlso: #02223

Format of NetWare "Get Queue Job File Size" request packet:
Offset	Size	Description	(Table 02223)
 00h	???
SeeAlso: #02222
--------N-21F217SF96-------------------------
INT 21 - Novell NetWare - GET ACCOUNT STATUS
	AX = F217h subfn 96h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02003 at AH=E3h/SF=96h)
	ES:DI -> reply buffer (see #02224)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=96h,AX=F217h/SF=97h,AX=F217h/SF=98h

Format of NetWare "Get Account Status" reply packet:
Offset	Size	Description	(Table 02224)
 00h	DWORD	(big-endian) account balance
 04h	DWORD	(big-endian) credit limit
		signed number indicating lowest allowable account balance
 06h 120 BYTEs	reserved
 80h	DWORD	(big-endian) object ID, server 1
 84h	DWORD	(big-endian) hold amount, server 1
	...
 F6h	DWORD	(big-endian) object ID, server 16
 FAh	DWORD	(big-endian) hold amount, server 16
Note:	the reply buffer lists the servers which have placed holds on a portion
	  of the account balance, and the amount reserved by each
SeeAlso: #02003,#02004 at AH=E3h/SF=96h
--------N-21F217SF97-------------------------
INT 21 - Novell NetWare - SUBMIT ACCOUNT CHARGE
	AX = F217h subfn 97h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02005 at AH=E3h/SF=97h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=97h,AX=F217h/SF=96h,AX=F217h/SF=98h
--------N-21F217SF98-------------------------
INT 21 - Novell NetWare - SUBMIT ACCOUNT HOLD
	AX = F217h subfn 98h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02006 at AH=E3h/SF=98h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=98h,AX=F217h/SF=97h,AX=F217h/SF=99h
--------N-21F217SF99-------------------------
INT 21 - Novell NetWare - SUBMIT ACCOUNT NOTE
	AX = F217h subfn 99h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02008 at AH=E3h/SF=99h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=99h,AX=F217h/SF=96h,AX=F217h/SF=98h
--------N-21F217SFC8-------------------------
INT 21 - Novell NetWare - CHECK CONSOLE PRIVILEGES
	AX = F217h subfn C8h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02009 at AH=E3h/SF=C8h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=C8h,AX=F217h/SF=C9h,AX=F217h/SF=D1h
--------N-21F217SFC9-------------------------
INT 21 - Novell NetWare - GET FILE SERVER DESCRIPTION STRINGS
	AX = F217h subfn C9h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02010 at AH=E3h/SF=C9h)
	ES:DI -> reply buffer (see #02225)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=C9h,AX=F217h/SF=C8h,AX=F217h/SF=CAh

Format of NetWare "Get File Server Description Strings" reply packet:
Offset	Size	Description	(Table 02225)
 00h	var	ASCIZ name of company distributing this copy of NetWare
	var	ASCIZ version and revision
      9 BYTEs	ASCIZ revision date (mm/dd/yy)
	var	ASCIZ copyright notice
SeeAlso: #02010,#02011 at AH=E3h/SF=C9h
--------N-21F217SFCA-------------------------
INT 21 - Novell NetWare - SET FILE SERVER DATE AND TIME
	AX = F217h subfn CAh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02012 at AH=E3h/SF=CAh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CAh,AX=F217h/SF=C8h,AX=F217h/SF=CBh
--------N-21F217SFCB-------------------------
INT 21 - Novell NetWare - DISABLE FILE SERVER LOGIN
	AX = F217h subfn CBh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02013 at AH=E3h/SF=CBh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CBh,AX=F217h/SF=C8h,AX=F217h/SF=CCh
--------N-21F217SFCC-------------------------
INT 21 - Novell NetWare - ENABLE FILE SERVER LOGIN
	AX = F217h subfn CCh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02015 at AH=E3h/SF=CCh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CCh,AX=F217h/SF=C8h,AX=F217h/SF=CBh
--------N-21F217SFCD-------------------------
INT 21 - Novell NetWare - GET FILE SERVER LOGIN STATUS
	AX = F217h subfn CDh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02016 at AH=E3h/SF=CDh)
	ES:DI -> reply buffer (see #02226)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CDh,AX=F217h/SF=CBh,AX=F217h/SF=CCh

Format of NetWare "Get File Server Login Status" reply packet:
Offset	Size	Description	(Table 02226)
 00h	BYTE	login state (00h disabled, 01h enabled)
SeeAlso: #02016,#02017 at AH=E3h/SF=CDh
--------N-21F217SFCE-------------------------
INT 21 - Novell NetWare - PURGE ALL ERASED FILES
	AX = F217h subfn CEh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02018 at AH=E3h/SF=CEh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CEh,AX=F244h
--------N-21F217SFCF-------------------------
INT 21 - Novell NetWare - DISABLE TRANSACTION TRACKING
	AX = F217h subfn CFh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02019 at AH=E3h/SF=CFh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=CFh,AX=F217h/SF=D0h
--------N-21F217SFD0-------------------------
INT 21 - Novell NetWare - ENABLE TRANSACTION TRACKING
	AX = F217h subfn D0h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02021 at AH=E3h/SF=D0h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D0h,AX=F217h/SF=CFh
--------N-21F217SFD1-------------------------
INT 21 - Novell NetWare - SEND CONSOLE BROADCAST
	AX = F217h subfn D1h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02022 at AH=E3h/SF=D1h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D1h,AX=F217h/SF=D2h
--------N-21F217SFD2-------------------------
INT 21 - Novell NetWare v3+ - CLEAR CONNECTION NUMBER (LOGOUT STATION)
	AX = F217h subfn D2h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02023 at AH=E3h/SF=D2h)
	ES:DI ignored
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D2h,AX=F217h/SF=D1h,AX=F217h/SF=FEh
--------N-21F217SFD3-------------------------
INT 21 - Novell NetWare - DOWN FILE SERVER
	AX = F217h subfn D3h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02026 at AH=E3h/SF=D3h)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D3h,AX=F217h/SF=D2h
--------N-21F217SFD4-------------------------
INT 21 - Novell NetWare - GET FILE SYSTEM STATISTICS
	AX = F217h subfn D4h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02027 at AH=E3h/SF=D4h)
	ES:DI -> reply buffer (see #02227)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D4h,AX=F217h/SF=D6h,AX=F217h/SF=D9h

Format of NetWare "Get File System Statistics" reply packet:
Offset	Size	Description	(Table 02227)
 00h	DWORD	clock ticks since system started
 04h	WORD	maximum open files set by configuration
 06h	WORD	maximum files open concurrently
 08h	WORD	current number of open files
 0Ah	DWORD	total files opened
 0Eh	DWORD	total file read requests
 12h	DWORD	total file write requests
 16h	WORD	current changed FATs
 18h	WORD	total changed FATs
 1Ah	WORD	number of FAT write errors
 1Ch	WORD	number of fatal FAT write errors
 1Eh	WORD	number of FAT scan errors
 20h	WORD	maximum concurrently-indexed files
 22h	WORD	current number of indexed files
 24h	WORD	number of attached indexed files
 26h	WORD	number of indexed files available
Note:	all fields are big-endian
SeeAlso: #02027,#02028 at AH=E3h/SF=D4h
--------N-21F217SFD5-------------------------
INT 21 - Novell NetWare - GET TRANSACTION TRACKING STATISTICS
	AX = F217h subfn D5h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02029 at AH=E3h/SF=D5h)
	ES:DI -> reply buffer (see #02228)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D5h,AX=F217h/SF=D0h

Format of NetWare "Get Transaction Tracking Statistics" reply packet:
Offset	Size	Description	(Table 02228)
 00h	DWORD	(big-endian) clock ticks since system started
 04h	BYTE	transaction tracking supported if nonzero
		(all following fields are invalid if zero)
 05h	BYTE	transaction tracking enabled
 06h	WORD	(big-endian) transaction volume number
 08h	WORD	(big-endian) maximum simultaneous transactions configured
 0Ah	WORD	(big-endian) maximum simultaneous transactions since startup
 0Ch	WORD	(big-endian) current transactions in progress
 0Eh	DWORD	(big-endian) total transactions performed
 12h	DWORD	(big-endian) total write transactions
 16h	DWORD	(big-endian) total transactions backed out
 1Ah	WORD	(big-endian) number of unfilled backout requests
 1Ch	WORD	(big-endian) disk blocks used for transaction tracking
 1Eh	DWORD	(big-endian) blocks allocated for tracked-file FATs
 22h	DWORD	(big-endian) number of file size changes during a transaction
 26h	DWORD	(big-endian) number of file truncations during a transaction
 2Ah	BYTE	number of records following
 2Bh	Active Transaction Records [array]
	Offset	Size	Description
	 00h	BYTE	logical connection number
	 01h	BYTE	task number
SeeAlso: #02029,#02030 at AH=E3h/SF=D5h
--------N-21F217SFD6-------------------------
INT 21 - Novell NetWare - GET DISK CACHE STATISTICS
	AX = F217h subfn D6h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02031 at AH=E3h/SF=D6h)
	ES:DI -> reply buffer (see #02229)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D6h,AX=F217h/SF=D5h,AX=F217h/SF=D8h

Format of NetWare "Get Disk Cache Statistics" reply packet:
Offset	Size	Description	(Table 02229)
 00h	DWORD	clock ticks since system started
 04h	WORD	number of cache buffers
 06h	WORD	size of cache buffer in bytes
 08h	WORD	number of dirty cache buffers
 0Ah	DWORD	number of cache read requests
 0Eh	DWORD	number of cache write requests
 12h	DWORD	number of cache hits
 16h	DWORD	number of cache misses
 1Ah	DWORD	number of physical read requests
 1Eh	DWORD	number of physical write requests
 22h	WORD	number of physical read errors
 24h	WORD	number of physical write errors
 26h	DWORD	cache get requests
 2Ah	DWORD	cache full write requests
 2Eh	DWORD	cache partial write requests
 32h	DWORD	background dirty writes
 36h	DWORD	background aged writes
 3Ah	DWORD	total cache writes
 3Eh	DWORD	number of cache allocations
 42h	WORD	thrashing count
 44h	WORD	number of times LRU block was dirty
 46h	WORD	number of reads on cache blocks not yet filled by writes
 48h	WORD	number of times a fragmented write occurred
 4Ah	WORD	number of cache hits on unavailable block
 4Ch	WORD	number of times a cache block was scrapped
Note:	all fields are big-endian
SeeAlso: #02031,#02032 at AH=E3h/SF=D6h
--------N-21F217SFD7-------------------------
INT 21 - Novell NetWare - GET DRIVE MAPPING TABLE
	AX = F217h subfn D7h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02033 at AH=E3h/SF=D7h)
	ES:DI -> reply buffer (see #02230)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=EF00h,AX=EF01h,AX=EF02h,AH=F2h"Novell",AH=E3h/SF=D7h

Format of NetWare "Get Drive Mapping Table" reply packet:
Offset	Size	Description	(Table 02230)
 00h	DWORD	(big-endian) clock tick elapsed since system started
 04h	BYTE	fault tolerance (SFT) level
 05h	BYTE	number of logical drives attached to server
 06h	BYTE	number of physical drives attached to server
 07h  5 BYTEs	disk channel types (00h none, 01h XT, 02h AT, 03h SCSI,
		  04h disk coprocessor drive, 32h-FFh value-added drive types)
 0Ch	WORD	(big-endian) number of outstanding controller commands
 0Eh 32 BYTEs	drive mapping table (FFh = no such drive)
 2Eh 32 BYTEs	drive mirror table (secondary physical drive, FFh = none)
 4Eh 32 BYTEs	dead mirror table (last drive mapped to, FFh if never mirrored)
 6Eh	BYTE	physical drive being remirrored (FFh = none)
 6Fh	BYTE	reserved
 70h	DWORD	(big-endian) remirrored block
 74h 60 BYTEs	SFT error table (internal error counters)
SeeAlso: #02033,#02034 at AH=E3h/SF=D7h
--------N-21F217SFD8-------------------------
INT 21 - Novell NetWare - GET PHYSICAL DISK STATISTICS
	AX = F217h subfn D8h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02035 at AH=E3h/SF=D8h)
	ES:DI -> reply buffer (see #02231)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D8h,AX=F217h/SF=D9h

Format of NetWare "Get Physical Disk Statistics" request packet:
Offset	Size	Description	(Table 02231)
 00h	DWORD	(big-endian) clock ticks since system started
 04h	BYTE	physical disk channel
 05h	BYTE	flag: drive removable if nonzero
 06h	BYTE	physical drive type
 07h	BYTE	drive number within controller
 08h	BYTE	controller number
 09h	BYTE	controller type
 0Ah	DWORD	(big-endian) size of drive in 4K disk blocks
 0Eh	WORD	(big-endian) number of cylinders on drive
 10h	BYTE	number of heads
 11h	BYTE	number of sectors per track
 12h 64 BYTEs	ASCIZ drive make and model
 52h	WORD	(big-endian) number of I/O errors
 56h	DWORD	(big-endian) start of Hot Fix table
 58h	WORD	(big-endian) size of Hot Fix table
 5Ah	WORD	(big-endian) number of Hot Fix blocks available
 5Ch	BYTE	flag: Hot Fix disabled if nonzero
SeeAlso: #02035,#02036 at AH=E3h/SF=D8h
--------N-21F217SFD9-------------------------
INT 21 - Novell NetWare - GET DISK CHANNEL STATISTICS
	AX = F217h subfn D9h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02037 at AH=E3h/SF=D9h)
	ES:DI -> reply buffer (see #02232)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=D9h,AX=F217h/SF=D8h

Format of NetWare "Get Disk Channel Statistics" reply packet:
Offset	Size	Description	(Table 02232)
 00h	DWORD	(big-endian) clock ticks since system started
 04h	WORD	(big-endian) channel run state (see #02039)
 06h	WORD	(big-endian) channel synchronization state (see #02040)
 08h	BYTE	driver type
 09h	BYTE	major version of driver
 0Ah	BYTE	minor version of driver
 0Bh 65 BYTEs	ASCIZ driver description
 4Ch	WORD	(big-endian) first I/O address used
 4Eh	WORD	(big-endian) length of first I/O address
 50h	WORD	(big-endian) second I/O address used
 52h	WORD	(big-endian) length of second I/O address
 54h  3 BYTEs	first shared memory address
 57h  2 BYTEs	length of first shared memory address
 59h  3 BYTEs	second shared memory address
 5Ch  2 BYTEs	length of second shared memory address
 5Eh	BYTE	first interrupt number in-use flag
 5Fh	BYTE	first interrupt number used
 60h	BYTE	second interrupt number in-use flag
 61h	BYTE	second interrupt number used
 62h	BYTE	first DMA channel in-use flag
 63h	BYTE	first DMA channel used
 64h	BYTE	second DMA channel in-use flag
 65h	BYTE	second DMA channel used
 66h	BYTE	flags
 67h	BYTE	reserved
 68h 80 BYTEs	ASCIZ configuration description
SeeAlso: #02037,#02038 at AH=E3h/SF=D9h
--------N-21F217SFDA-------------------------
INT 21 - Novell NetWare v2.2+ - GET CONNECTION'S TASK INFORMATION
	AX = F217h subfn DAh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02041 at AH=E3h/SF=DAh)
	ES:DI -> reply buffer (see #02233)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DAh,AX=F217h/SF=EAh

Format of NetWare "Get Connection's Task Information" reply packet:
Offset	Size	Description	(Table 02233)
 00h	BYTE	lock status of connection (see #02043)
 01h	var	Lock Status Information (see #02044)
 N	BYTE	number of records following
 N+1	Active Task Information Records [array]
	Offset	Size	Description
	 00h	BYTE	task number (01h-FFh)
	 01h	BYTE	task state
			00h normal task
			01h in TTS explicit transaction
			02h in TTS implicit transaction
			04h shared fileset lock active
SeeAlso: #02248,#02041,#02042 at AH=E3h/SF=DAh
--------N-21F217SFDB-------------------------
INT 21 - Novell NetWare v2.2+ - GET CONNECTION'S OPEN FILES (OLD)
	AX = F217h subfn DBh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02045 at AH=E3h/SF=DBh)
	ES:DI -> reply buffer (see #02234)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DBh,AX=F217h/SF=EBh

Format of NetWare "Get Connection's Open Files (old)" reply packet:
Offset	Size	Description	(Table 02234)
 00h	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 02h	BYTE	number of records following
 03h	var	array of File Information Records (see #02047 at AH=E3h/SF=DBh)
SeeAlso: #02045,#02046 at AH=E3h/SF=DBh
--------N-21F217SFDC-------------------------
INT 21 - Novell NetWare v2.2+ - GET CONNECTIONS USING A FILE (OLD)
	AX = F217h subfn DCh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02050 at AH=E3h/SF=DCh)
	ES:DI -> reply buffer (see #02235)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DCh,AX=F217h/SF=ECh

Format of NetWare "Get Connections Using A File (old)" reply packet:
Offset	Size	Description	(Table 02235)
 00h	WORD	(big-endian) count of tasks which have opened or logged file
 02h	WORD	(big-endian) count of tasks which have opened file
 04h	WORD	(big-endian) count of opens for reading
 06h	WORD	(big-endian) count of opens for writing
 08h	WORD	(big-endian) deny read count
 0Ah	WORD	(big-endian) deny write count
 0Ch	WORD	next request record (place in "last record" field on next call)
		0000h if no more records
 0Eh	BYTE	locked flag
		00h not locked exclusively
		else locked exclusively
 0Fh	BYTE	number of records following
 10h	var	array of File Usage Information Records
		  (see #02052 at AH=E3h/SF=DCh)
SeeAlso: #02050,#02051 at AH=E3h/SF=DCh
--------N-21F217SFDD-------------------------
INT 21 - Novell NetWare - GET PHYSICAL RECORD LOCKS BY CONNECTN AND FILE (OLD)
	AX = F217h subfn DDh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02054 at AH=E3h/SF=DDh)
	ES:DI -> reply buffer (see #02236)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DDh,AX=F217h/SF=DEh,AX=F217h/SF=EDh

Format of NetWare "Get Phys Record Locks By Conn & File (old)" reply packet:
Offset	Size	Description	(Table 02236)
 00h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 02h	BYTE	number of physical record locks
 03h	BYTE	number of records following
 04h	var	array of Physical Record Lock Info records
		  (see #02056 at AH=E3h/SF=DDh)
SeeAlso: #02054,#02055 at AH=E3h/SF=DDh
--------N-21F217SFDE-------------------------
INT 21 - Novell NetWare - GET PHYSICAL RECORD LOCKS BY FILE (OLD)
	AX = F217h subfn DEh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02058 at AH=E3h/SF=DEh)
	ES:DI -> reply buffer (see #02237)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DEh,AX=F217h/SF=EEh

Format of NetWare "Get Physical Record Locks By File (old)" reply packet:
Offset	Size	Description	(Table 02237)
 00h	WORD	next request record (place in "last record" on next call)
		0000h if no more records
 02h	BYTE	number of physical record locks
 03h	BYTE	number of records following
 04h	var	array of Physical Record Lock Info records (see #02060)
SeeAlso: #02058,#02059 at AH=E3h/SF=DEh
--------N-21F217SFDF-------------------------
INT 21 - Novell NetWare - GET LOGICAL RECORDS BY CONNECTION (OLD)
	AX = F217h subfn DFh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02061 at AH=E3h/SF=DFh)
	ES:DI -> reply buffer (see #02238)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=DFh,AX=F217h/SF=EFh

Format of NetWare "Get Logical Records By Connection (old)" reply packet:
Offset	Size	Description	(Table 02238)
 00h	WORD	next request record (place in "last record" field on next call)
		0000h if no more locked records
 02h	BYTE	number of records following
 03h	var	array of Logical Lock Information Records
		  (see #02063 at AH=E3h/SF=DFh)
SeeAlso: #02061,#02062 at AH=E3h/SF=DFh
--------N-21F217SFE0-------------------------
INT 21 - Novell NetWare - GET LOGICAL RECORD INFORMATION (OLD)
	AX = F217h subfn E0h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02064 at AH=E3h/SF=E0h)
	ES:DI -> reply buffer (see #02239)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E0h,AX=F217h/SF=F0h

Format of NetWare "Get Logical Record Information (Old)" reply packet:
Offset	Size	Description	(Table 02239)
 00h	WORD	(big-endian) number of logical connections logging the record
 02h	WORD	(big-endian) number of logical connections with shareable lock
 04h	WORD	(big-endian) next request record (place in "last record" field
		  on next call)
 06h	BYTE	locked exclusively if nonzero
 07h	BYTE	number of records following
 08h	var	array of Task Information Records (see #02066 at AH=E3h/SF=E0h)
SeeAlso: #02064,#02065 at AH=E3h/SF=E0h
--------N-21F217SFE1-------------------------
INT 21 - Novell NetWare - GET CONNECTION'S SEMAPHORES (OLD)
	AX = F217h subfn E1h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02067 at AH=E3h/SF=E1h)
	ES:DI -> reply buffer (see #02240)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E1h,AX=F217h/SF=F1h

Format of NetWare "Get Connection's Semaphores (old)" reply packet:
Offset	Size	Description	(Table 02240)
 00h	WORD	next request record (place in "last record" field on next call)
 02h	BYTE	number of records following
 03h	var	array of Semaphore Information Records
		  (see #02069 at AH=E3h/SF=E1h)
SeeAlso: #02067,#02068 at AH=E3h/SF=E1h
--------N-21F217SFE2-------------------------
INT 21 - Novell NetWare - GET SEMAPHORE INFORMATION (OLD)
	AX = F217h subfn E2h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02070 at AH=E3h/SF=E2h)
	ES:DI -> reply buffer (see #02241)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E2h,AX=F217h/SF=F2h

Format of NetWare "Get Semaphore Information (old)" reply packet:
Offset	Size	Description	(Table 02241)
 00h	WORD	next request record (place in "last record" on next call)
		0000h if no more
 02h	WORD	(big-endian) number of logical connections opening semaphore
 04h	BYTE	semaphore value (-127 to 128)
 05h	BYTE	number of records following
 06h	var	array of Semaphore Information records (see #02072)
SeeAlso: #02070,#02071 at AH=E3h/SF=E2h
--------N-21F217SFE3-------------------------
INT 21 - Novell NetWare - GET LAN DRIVER'S CONFIGURATION INFORMATION
	AX = F217h subfn E3h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02073 at AH=E3h/SF=E3h)
	ES:DI -> reply buffer (see #02242)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E3h,AX=F217h/SF=E7h,AX=F217h/SF=E8h

Format of NetWare "Get Lan Driver's Configuration Information" reply packet:
Offset	Size	Description	(Table 02242)
 00h  4 BYTEs	network number
 04h  6 BYTEs	node number
 0Ah	BYTE	LAN driver installed (00h no--remaining fields invalid)
 0Bh	BYTE	option number selected at configuration time
 0Ch 160 BYTEs	configuration text
		ASCIZ hardware type
		ASCIZ hardware settings
SeeAlso: #02073,#02074 at AH=E3h/SF=E3h
--------N-21F217SFE5-------------------------
INT 21 - Novell NetWare - GET CONNECTION'S USAGE STATISTICS
	AX = F217h subfn E5h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02075 at AH=E3h/SF=E5h)
	ES:DI -> reply buffer (see #02243)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E5h,AX=F217h/SF=EAh

Format of NetWare "Get Connection's Usage Statistics" reply packet:
Offset	Size	Description	(Table 02243)
 00h	DWORD	(big-endian) clock ticks since server started
 04h  6 BYTEs	bytes read
 0Ah  6 BYTEs	bytes written
 10h	DWORD	(big-endian) total request packets
SeeAlso: #02075,#02076 at AH=E3h/SF=E5h
--------N-21F217SFE6-------------------------
INT 21 - Novell NetWare - GET OBJECT'S REMAINING DISK SPACE
	AX = F217h subfn E6h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02077 at AH=E3h/SF=E6h)
	ES:DI -> reply buffer (see #02244)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E6h,AX=F216h/SF=20h,AX=F216h/SF=23h

Format of NetWare "Get Object's Remaining Disk Space" reply packet:
Offset	Size	Description	(Table 02244)
 00h	DWORD	(big-endian) clock ticks elapsed since server started
 04h	DWORD	(big-endian) object ID
 08h	DWORD	(big-endian) 4K disk blocks available to user
 0Ch	BYTE	restrictions (00h enforced, FFh not enforced)
SeeAlso: #02077,#02078 at AH=E3h/SF=E6h
--------N-21F217SFE7-------------------------
INT 21 - Novell NetWare - GET FILE SERVER LAN I/O STATISTICS
	AX = F217h subfn E7h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02079 at AH=E3h/SF=E7h)
	ES:DI -> reply buffer (see #02245)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E7h,AX=F217h/SF=11h,AX=F217h/SF=F5h

Format of NetWare "Get File Server Lan I/O Statistics" reply packet:
Offset	Size	Description	(Table 02245)
 00h	DWORD	clock ticks since system started
 04h	WORD	total routing buffers
 06h	WORD	maximum routing buffers used
 08h	WORD	current routing buffers used
 0Ah	DWORD	total file service packets
 0Eh	WORD	number of file service packets buffered
 10h	WORD	number of invalid connection packets
 12h	WORD	packets with bad logical connection numbers
 14h	WORD	number of packets received during processing
 16h	WORD	number of requests reprocessed
 18h	WORD	packets with bad sequence numbers
 1Ah	WORD	number of duplicate replies sent
 1Ch	WORD	number of acknowledgements sent
 1Eh	WORD	number of packets with bad request types
 20h	WORD	requests to attach to ws for which a request is being processed
 22h	WORD	requests to attach from ws which is already attaching
 24h	WORD	number of forged detach requests
 26h	WORD	detach requests with bad connection number
 28h	WORD	requests to detach from ws for which requests pending
 2Ah	WORD	number of cancelled replies
 2Ch	WORD	packets discarded due to excessive hop count
 2Eh	WORD	packets discarded due to unknown net
 30h	WORD	incoming packets discarded for lack of DGroup buffer
 32h	WORD	outgoing packets discarded due to lack of buffer
 34h	WORD	received packets destined for B,C, or D side drivers
 36h	DWORD	number of NetBIOS packets propagated through net
 3Ah	DWORD	total number of non-file-service packets
 3Eh	DWORD	total number of routed packets
Note:	all fields are big-endian
SeeAlso: #02079,#02080 at AH=E3h/SF=E7h
--------N-21F217SFE8-------------------------
INT 21 - Novell NetWare - GET FILE SERVER MISC INFORMATION
	AX = F217h subfn E8h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02081 at AH=E3h/SF=E8h)
	ES:DI -> reply buffer (see #02246)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E8h,AX=F217h/SF=11h,AX=F217h/SF=F5h

Format of NetWare "Get File Server Misc Information" reply packet:
Offset	Size	Description	(Table 02246)
 00h	DWORD	(big-endian) clock ticks since system started
 04h	BYTE	CPU type
		00h Motorola 68000
		01h Intel 8086, 8088, or V20
		02h Intel 80286+
 05h	BYTE	reserved
 06h	BYTE	number of service processes in server
 07h	BYTE	server utilization in percent
 08h	WORD	(big-endian) maximum bindery objects set by configuration
		0000h = unlimited
 0Ah	WORD	(big-endian) maximum number of bindery objects used
 0Ch	WORD	(big-endian) current number of bindery objects in use
 0Eh	WORD	(big-endian) total server memory in KB
 10h	WORD	(big-endian) wasted server memory in KB
		normally 0000h
 12h	WORD	number of records following (01h-03h)
 14h	var	array of Dynamic Memory Information records (see #02083)
SeeAlso: #02081,#02082 at AH=E3h/SF=E8h
--------N-21F217SFE9-------------------------
INT 21 - Novell NetWare - GET VOLUME INFORMATION
	AX = F217h subfn E9h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02084 at AH=E3h/SF=E9h)
	ES:DI -> reply buffer (see #02247)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AH=E3h/SF=E9h,AX=F212h,AX=F216h/SF=15h

Format of NetWare "Get Volume Information" reply packet:
Offset	Size	Description	(Table 02247)
 00h	DWORD	(big-endian) elapsed system time
 04h	BYTE	volume number
 05h	BYTE	logical drive number
 06h	WORD	(big-endian) sectors per block
 08h	WORD	(big-endian) starting block
 0Ah	WORD	(big-endian) total blocks on volume
 0Ch	WORD	(big-endian) blocks available on volume
 0Eh	WORD	(big-endian) total directory slots
 10h	WORD	(big-endian) directory slots available
 12h	WORD	(big-endian) maximum directory entries actually used
 14h	BYTE	flag: volume hashed if nonzero
 15h	BYTE	flag: volume cached if nonzero
 16h	BYTE	flag: volume removable if nonzero
 17h	BYTE	flag: volume mounted if nonzero
 18h 16 BYTEs	NUL-padded volume name
SeeAlso: #02084,#02085 at AH=E3h/SF=E9h
--------N-21F217SFEA-------------------------
INT 21 - Novell NetWare v3.11+ - GET CONNECTION'S TASK INFORMATION
	AX = F217h subfn EAh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02248)
	ES:DI -> reply buffer (see #02233)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DAh

Format of NetWare "Get Connection's Task Information" request packet:
Offset	Size	Description	(Table 02248)
 00h	WORD	length of following data
 02h	BYTE	EAh (subfunction "Get Connection's Task Information")
 03h	WORD	connection number
SeeAlso: #02233,#02041 at AH=E3h/SF=DAh
--------N-21F217SFEB-------------------------
INT 21 - Novell NetWare v3+ - GET CONNECTION'S OPEN FILES
	AX = F217h subfn EBh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02249)
	ES:DI -> reply buffer (see #02250)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DBh

Format of NetWare "Get Connection's Open Files" request buffer:
Offset	Size	Description	(Table 02249)
 00h	WORD	0005h (length of following data)
 02h	BYTE	EBh (subfunction "Get Connection's Open Files")
 03h	WORD	target connection number
 05h	WORD	last record seen (set to 0000h for first call)
Note:	connection numbers greater than the maximum supported by the server
	  can cause ABENDs
SeeAlso: #02250

Format of NetWare "Get Connection's Open Files" reply buffer:
Offset	Size	Description	(Table 02250)
 00h	WORD	next request record
 02h	WORD	number of records returned (max 28)
 04h 29N BYTEs	array of connection records (see #02251)
SeeAlso: #02249

Format of NetWare connection record:
Offset	Size	Description	(Table 02251)
 00h	WORD	task number
 02h	BYTE	lock type
 03h	BYTE	access control
 04h	BYTE	lock flag
 05h	BYTE	volume number
 06h	DWORD	parent directory entry number
 0Ah	DWORD	directory entry number
 0Eh	BYTE	fork count
 0Fh	BYTE	data stream type / name space (see #02387)
 10h	BYTE	file name length
 11h 12 BYTEs	file name
SeeAlso: #02250
--------N-21F217SFEC-------------------------
INT 21 - Novell NetWare v3+ - GET CONNECTIONS USING A FILE
	AX = F217h subfn ECh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02252)
	ES:DI -> reply buffer (see #02253)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DCh

Format of NetWare "Get Connections Using a File" request buffer:
Offset	Size	Description	(Table 02252)
 00h	WORD	0009h (length of following data)
 02h	BYTE	ECh (subfunction "Get Connections Using a File")
 03h	BYTE	data stream type
 04h	BYTE	volume number
 05h	DWORD	directory entry number
 09h	WORD	last record seen (0000h for first call)
SeeAlso: #02253

Format of NetWare "Get Connections Using a File" reply buffer:
Offset	Size	Description	(Table 02253)
 00h	WORD	next request record
 02h	WORD	use count
 04h	WORD	open count
 06h	WORD	number of times open for reading
 08h	WORD	number of times open for writing
 0Ah	WORD	Deny Read count
 0Ch	WORD	Deny Write count
 0Eh	BYTE	flag: locked
 0Fh	BYTE	fork count
 10h	WORD	number of records returned (max 70)
 12h 7N BYTEs	returned records (see #02254)
SeeAlso: #02252

Format of returned record:
Offset	Size	Description	(Table 02254)
 00h	WORD	connection number
 02h	WORD	task number
 04h	BYTE	lock type
 05h	BYTE	access flag
 06h	BYTE	lock flag
SeeAlso: #02253
--------N-21F217SFED-------------------------
INT 21 - Novell NetWare v3+ - GET PHYSICAL RECORD LOCKS BY CONNECTION AND FILE
	AX = F217h subfn EDh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02255)
	ES:DI -> reply buffer (see #02256)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DDh,AX=F217h/SF=EEh

Format of NetWare "Get Phys Record Locks By Conn And File" request packet:
Offset	Size	Description	(Table 02255)
 00h	WORD	length of following data
 02h	BYTE	EDh (subfunction "Get Physical Record Locks By Connection
		  And File")
 03h	WORD	target connection number
 05h	BYTE	last record seen (set to 00h before first call)
 06h	BYTE	volume number
 07h	DWORD	directory entry number
 0Bh  N BYTEs	filename
SeeAlso: #02256

Format of NetWare "Get Physical Record Locks By Connect And File" reply packet:
Offset	Size	Description	(Table 02256)
 00h	WORD	next record (place in last-seen field on next call)
 02h	WORD	number of locks returned
 04h 11N BYTEs	lock records
		Offset	Size	Description
		 00h	WORD	(big-endian) task number
		 02h	BYTE	lock status
		 03h	DWORD	(big-endian) record start offset
		 07h	DWORD	(big-endian) record end offset
SeeAlso: #02255
--------N-21F217SFEE-------------------------
INT 21 - Novell NetWare v3+ - GET PHYSICAL RECORD LOCKS BY FILE
	AX = F217h subfn EEh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02257)
	ES:DI -> reply buffer (see #02258)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DEh

Format of NetWare "Get Physical Record Locks by File" request buffer:
Offset	Size	Description	(Table 02257)
 00h	WORD	0009h (length of following data)
 02h	BYTE	EEh (subfunction "Get Physical Record Locks by File")
 03h	BYTE	data stream number
 04h	BYTE	volume number
 05h	DWORD	directory entry number
 09h	WORD	last record seen (0000h for first call)
SeeAlso: #02258

Format of NetWare "Get Physical Record Locks by File" reply buffer:
Offset	Size	Description	(Table 02258)
 00h	WORD	next request record
 02h	WORD	number of locks
 04h 17N BYTEs	array of lock records, one per lock (see #02259)
SeeAlso: #02257

Format of NetWare lock record:
Offset	Size	Description	(Table 02259)
 00h	WORD	logged count
 02h	WORD	number of shareable locks
 04h	DWORD	start offset of record
 08h	DWORD	end offset of record
 0Ch	WORD	logical connection number
 0Eh	WORD	task number
 10h	BYTE	lock type
SeeAlso: #02258
--------N-21F217SFEF-------------------------
INT 21 - Novell NetWare v3+ - GET LOGICAL RECORDS BY CONNECTION
	AX = F217h subfn EFh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02260)
	ES:DI -> reply buffer (see #02261)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=DFh

Format of NetWare "Get Logical Records By Connection" request packet:
Offset	Size	Description	(Table 02260)
 00h	WORD	length of following data
 02h	BYTE	EFh (subfunction "Get Logical Records By Connection")
 03h	WORD	target connection number
 05h	WORD	last record seen (set to 0000h before first call)
SeeAlso: #02261

Format of NetWare "Get Logical Records By Connection" request packet:
Offset	Size	Description	(Table 02261)
 00h	WORD	next record (place in last-seen field on next call)
 02h	WORD	number of records returned
 04h		Logical Lock Information records (see #02063 at AH=E3h/SF=DFh)
SeeAlso: #02260
--------N-21F217SFF0-------------------------
INT 21 - Novell NetWare v3+ - GET LOGICAL RECORD INFORMATION
	AX = F217h subfn F0h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02262)
	ES:DI -> reply buffer (see #02263)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=E0h,AX=F217h/SF=EFh

Format of NetWare "Get Logical Record Information" request packet:
Offset	Size	Description	(Table 02262)
 00h	WORD	length of following data
 02h	BYTE	F0h (subfunction "Get Logical Record Information")
 03h	WORD	last record seen
 05h	BYTE	length of logical record name
 06h  N BYTEs	logical record name (case-sensitive)
SeeAlso: #02263

Format of NetWare "Get Logical Record Information" request packet:
Offset	Size	Description	(Table 02263)
 00h	WORD	number of connections logging record
 02h	WORD	number of shareable locks
 04h	BYTE	flag: locked exclusively if nonzero
 05h	WORD	next request record (place in last-seen field on next call)
 07h	BYTE	number of records returned
 08h		logical record information records [array]
		Offset	Size	Description
		 00h	WORD	connection number
		 02h	BYTE	task number
		 03h	BYTE	lock status
SeeAlso: #02262
--------N-21F217SFF1-------------------------
INT 21 - Novell NetWare v3+ - GET CONNECTION'S SEMAPHORES
	AX = F217h subfn F1h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02264)
	ES:DI -> reply buffer (see #02265)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=E1h

Format of NetWare "Get Connection's Semaphores" request packet:
Offset	Size	Description	(Table 02264)
 00h	WORD	length of following data
 02h	BYTE	F1h (subfunction "Get Connection's Semaphores")
 03h	WORD	connection number
 05h	WORD	last record seen (set to 0000h before first call)
SeeAlso: #02265

Format of NetWare "Get Connection's Semaphores" reply packet:
Offset	Size	Description	(Table 02265)
 00h	WORD	next record (place in last-seen field on next call)
 02h	WORD	number of semaphores returned
 04h	BYTEs	semaphore information records [packed array] (see #02266)
SeeAlso: #02264

Format of NetWare semaphore information record:
Offset	Size	Description	(Table 02266)
 00h	WORD	semaphore's current value
 02h	WORD	number of connections using semaphore
 04h	WORD	task number
 06h	BYTE	length of semaphore's name
 07h  N BYTEs	semaphore name
SeeAlso: #02265
--------N-21F217SFF2-------------------------
INT 21 - Novell NetWare v3+ - GET SEMAPHORE INFORMATION
	AX = F217h subfn F2h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02267)
	ES:DI -> reply buffer (see #02268)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F217h/SF=E2h

Format of NetWare "Get Semaphore Information" request buffer:
Offset	Size	Description	(Table 02267)
 00h	WORD	length of following data (max 84h)
 02h	BYTE	F2h (subfunction "Get Semaphore Information")
 03h	WORD	last record seen (0000h on first call)
 05h	BYTE	length of semaphore name (max 128)
 06h  N BYTEs	semaphore name
SeeAlso: #02268

Format of NetWare "Get Semaphore Information" reply buffer:
Offset	Size	Description	(Table 02268)
 00h	WORD	next request record
 02h	WORD	open count
 04h	BYTE	value of semaphore
 05h	WORD	number of records returned
 07h 2N WORDs	list of logical connection number/task number pairs
SeeAlso: #02267
--------N-21F217SFF3-------------------------
INT 21 - Novell NetWare v3+ - MAP DIRECTORY NUMBER TO PATH
	AX = F217h subfn F3h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02269)
	ES:DI -> reply buffer (see #02270)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F217h/SF=F4h

Format of NetWare "Map Directory Number to Path" request buffer:
Offset	Size	Description	(Table 02269)
 00h	WORD	0007h (length of following data)
 02h	BYTE	F3h (subfunction "Map Directory Number to Path")
 03h	BYTE	volume number
 04h	DWORD	directory entry number
 08h	BYTE	name space type
SeeAlso: #02270

Format of NetWare "Map Directory Number to Path" reply buffer:
Offset	Size	Description	(Table 02270)
 00h	BYTE	directory path length
 01h  N BYTEs	directory path (NetWare style, separated by length descriptors
		  rather than slashes or backslashes)
SeeAlso: #02269
--------N-21F217SFF4-------------------------
INT 21 - Novell NetWare v3+ - CONVERT PATH TO DIRECTORY ENTRY
	AX = F217h subfn F4h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02271)
	ES:DI -> reply buffer (see #02272)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F217h/SF=F3h

Format of NetWare "Convert Path to Directory Entry" request packet:
Offset	Size	Description	(Table 02271)
 00h	WORD	length of following data
 02h	BYTE	F4h (subfunction "Convert Path to Directory Entry")
 03h	BYTE	directory handle or 00h for none
 04h	BYTE	length of directory path
 05h  N BYTEs	directory path (must be fully qualified if no handle specified)
SeeAlso: #02272

Format of NetWare "Convert Path to Directory Entry" reply packet:
Offset	Size	Description	(Table 02272)
 00h	BYTE	volume number
 01h	DWORD	directory entry number
SeeAlso: #02271
--------N-21F217SFF5-------------------------
INT 21 - Novell NetWare - GET FILE SERVER EXTENDED MISC INFORMATION
	AX = F217h subfn F5h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02273)
	ES:DI -> reply buffer (see #02274)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=11h,AX=F217h/SF=C9h,AX=F217h/SF=E8h

Format of NetWare "Get File Server Extended Misc Information" request packet:
Offset	Size	Description	(Table 02273)
 00h	WORD	length of following data
 02h	BYTE	F5h (subfunction "Get File Server Extended Misc Information")
 03h	BYTE	length of reply buffer
SeeAlso: #02274

Format of NetWare "Get File Server Extended Misc Information" reply packet:
Offset	Size	Description	(Table 02274)
 00h	DWORD	system interval marker
		(up-time in clock ticks, wraps to 0 on reaching FFFFFFFFh)
 04h	BYTE	processor type
		00h Motorola 680x0
		01h Intel 8088/8086
		02h 80286
 05h	BYTE	reserved for future use
 06h	BYTE	number of service processes
 07h	BYTE	server utilization percentage
 08h	WORD	maximum bindery objects set by configuration
 0Ah	WORD	actual maximum bindery objects
 0Ch	WORD	current number of bindery objects
 0Eh	WORD	(big-endian) total server memory
 10h	WORD	(big-endian) wasted server memory
 12h	WORD	(big-endian) number of dynamic memory areas
 14h	DWORD	(big-endian) total space in dynamic memory area
 18h	DWORD	maximum dynamic space used
 1Ch	DWORD	dynamic space currently used
SeeAlso: #02273
--------N-21F217SFF6-------------------------
INT 21 - Novell NetWare - GET VOLUME EXTENDED INFORMATION
	AX = F217h subfn F6h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02275)
	ES:DI -> reply buffer (see #02276)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=E8h

Format of NetWare "Get Volume Extended Information" request packet:
Offset	Size	Description	(Table 02275)
 00h	WORD	length of following data
 02h	BYTE	F6h (subfunction "Get Volume Extended Information")
 03h	BYTE	volume number
 04h	BYTE	size of reply buffer
SeeAlso: #02276

Format of NetWare "Get Volume Extended Information" reply packet:
Offset	Size	Description	(Table 02276)
 00h	DWORD	system interval
		(up-time in clock ticks, wraps to 0 on reaching FFFFFFFFh)
 04h	BYTE	volume number
 05h	BYTE	logical drive number
 06h	WORD	number of 512-byte sectors per disk block
 08h	DWORD	starting block number of volume
 0Ch	WORD	total number of disk blocks
 0Eh	WORD	number of free disk blocks
 10h	WORD	total number of directory entries
 12h	WORD	number of available directory entries
 14h	WORD	maximum directory entries ever used
 16h	BYTE	flag: volume is hashed in memory if nonzero
 17h	BYTE	flag: volume is cached if nonzero
 18h	BYTE	flag: volume is removable if nonzero
 19h	BYTE	flag: volume is mounted if nonzero
 1Ah 16 BYTEs	volume name (null-padded)
SeeAlso: #02275
--------N-21F217SFFE-------------------------
INT 21 - Novell NetWare v4 - CLEAR CONNECTION NUMBER GREATER THAN 250
	AX = F217h subfn FEh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02277)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=E3h/SF=D2h,AX=F217h/SF=D2h

Format of NetWare "Clear Connection Number" request buffer:
Offset	Size	Description	(Table 02277)
 00h	WORD	length of following data
 02h	BYTE	FEh (subfunction "Clear Connection Number")
 03h	DWORD	connection number
SeeAlso: #02023
--------N-21F21B-----------------------------
INT 21 - Novell NetWare - LOCK PHYSICAL RECORD SET (OLD)
	AX = F21Bh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02480 at AX=F26Eh)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Eh,AH=C2h"NetWare"
--------N-21F21E-----------------------------
INT 21 - Novell NetWare - CLEAR PHYSICAL RECORD
	AX = F21Eh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02278)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=5Ch,AH=BEh"NetWare",AH=F2h"Novell",AX=F20Bh,AX=F21Fh

Format of NetWare "Clear Physical Record" request packet:
Offset	Size	Description	(Table 02278)
 00h	BYTE	reserved for future use
 01h  6 BYTEs	NetWare file handle
 07h	DWORD	starting offset of locked region
 0Bh	DWORD	length of locked region
SeeAlso: #02279
--------N-21F21F-----------------------------
INT 21 - Novell NetWare - CLEAR PHYSICAL RECORD SET
	AX = F21Fh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02279)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=5Ch,AH=C4h"NetWare",AH=F2h"Novell",AX=F20Eh,AX=F21Eh

Format of NetWare "Clear Physical Record Set" request packet:
Offset	Size	Description	(Table 02279)
 00h	BYTE	lock flag (00h = not locked)
SeeAlso: #02278
--------N-21F220SF00-------------------------
INT 21 - Novell NetWare - OPEN SEMAPHORE (OLD)
	AX = F220h subfn 00h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02280)
	ES:DI -> reply buffer (see #02281)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C500h,AX=F220h/SF=01h,AX=F220h/SF=03h

Format of NetWare "Open Semaphore (old)" request packet:
Offset	Size	Description	(Table 02280)
 00h	BYTE	00h (subfunction "Open Semaphore (old)")
 01h	BYTE	initial value of semaphore ( >= 0)
 02h	BYTE	length of semaphore's name (max 512)
 03h  N BYTEs	semaphore name
SeeAlso: #02281,#02282

Format of NetWare "Open Semaphore (old)" reply packet:
Offset	Size	Description	(Table 02281)
 00h	DWORD	semaphore handle
 04h	BYTE	number of processes using semaphore (including caller)
SeeAlso: #02280,#02283
--------N-21F220SF01-------------------------
INT 21 - Novell NetWare - EXAMINE SEMAPHORE (OLD)
	AX = F220h subfn 01h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02282)
	ES:DI -> reply buffer (see #02283)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C501h,AX=F220h/SF=00h,AX=F220h/SF=03h

Format of NetWare "Close Semaphore (old)" request packet:
Offset	Size	Description	(Table 02282)
 00h	BYTE	01h (subfunction "Examine Semaphore (old)")
 01h	DWORD	semaphore handle
SeeAlso: #02283,#02280

Format of NetWare "Close Semaphore (old)" request packet:
Offset	Size	Description	(Table 02283)
 00h	BYTE	current semaphore value
 01h	BYTE	number of processes using semaphore (including caller)
SeeAlso: #02282,#02281
--------N-21F220SF02-------------------------
INT 21 - Novell NetWare - WAIT ON SEMAPHORE (OLD)
	AX = F220h subfn 02h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02284)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C502h,AX=F220h/SF=00h,AX=F220h/SF=03h

Format of NetWare "Wait on Semaphore (old)" request packet:
Offset	Size	Description	(Table 02284)
 00h	BYTE	02h (subfunction "Wait on Semaphore (old)")
 01h	DWORD	semaphore handle
 05h	WORD	timeout in 1/18s (0000h = return immediately)
SeeAlso: #02282,#02285
--------N-21F220SF03-------------------------
INT 21 - Novell NetWare - SIGNAL SEMAPHORE (OLD)
	AX = F220h subfn 03h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02285)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C503h,AX=F220h/SF=02h,AX=F220h/SF=04h

Format of NetWare "Signal Semaphore (old)" request packet:
Offset	Size	Description	(Table 02285)
 00h	BYTE	03h (subfunction "Signal Semaphore (old)")
 01h	DWORD	semaphore handle
SeeAlso: #02284,#02286
--------N-21F220SF04-------------------------
INT 21 - Novell NetWare - CLOSE SEMAPHORE (OLD)
	AX = F220h subfn 04h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02286)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C504h,AX=F220h/SF=00h,AX=F220h/SF=01h
SeeAlso: AX=F26Fh/SF=01h

Format of NetWare "Close Semaphore (old)" request packet:
Offset	Size	Description	(Table 02286)
 00h	BYTE	04h (subfunction "Close Semaphore (old)")
 01h	DWORD	semaphore handle
SeeAlso: #02285,#02483
--------N-21F222SF00-------------------------
INT 21 - Novell NetWare - TTS IS AVAILABLE
	AX = F222h subfn 00h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02287)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C702h,AX=F222h/SF=01h,AX=F222h/SF=05h

Format of NetWare "TTS Is Available" request packet:
Offset	Size	Description	(Table 02287)
 00h	BYTE	00h (subfunction "TTS Is Available")
--------N-21F222SF01-------------------------
INT 21 - Novell NetWare - TTS BEGIN TRANSACTION
	AX = F222h subfn 01h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02288)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C700h,AX=F222h/SF=02h,AX=F222h/SF=03h

Format of NetWare "TTS Begin Transaction" request packet:
Offset	Size	Description	(Table 02288)
 00h	BYTE	01h (subfunction "TTS Begin Transaction")
SeeAlso: #02289,#02291
--------N-21F222SF02-------------------------
INT 21 - Novell NetWare - TTS END TRANSACTION
	AX = F222h subfn 02h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02289)
	ES:DI -> reply buffer (see #02290)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C701h,AX=F222h/SF=01h,AX=F222h/SF=04h

Format of NetWare "TTS End Transaction" request packet:
Offset	Size	Description	(Table 02289)
 00h	BYTE	02h (subfunction "TTS End Transaction")
SeeAlso: #02290,#02288

Format of NetWare "TTS End Transaction" reply packet:
Offset	Size	Description	(Table 02290)
 00h	DWORD	transaction number
SeeAlso: #02289,#02292
--------N-21F222SF03-------------------------
INT 21 - Novell NetWare - TTS ABORT TRANSACTION
	AX = F222h subfn 03h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02291)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C703h,AX=F222h/SF=01h,AX=F222h/SF=02h
SeeAlso: AX=F220h/SF=04h

Format of NetWare "TTS Abort Transaction" request packet:
Offset	Size	Description	(Table 02291)
 00h	BYTE	03h (subfunction "TTS Abort Transaction")
SeeAlso: #02288,#02289
--------N-21F222SF04-------------------------
INT 21 - Novell NetWare - TTS TRANSACTION STATUS
	AX = F222h subfn 04h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02292)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C704h,AX=F222h/SF=02h,AX=F222h/SF=03h

Format of NetWare "TTS Transaction Status" request packet:
Offset	Size	Description	(Table 02292)
 00h	BYTE	04h (subfunction "TTS Transaction Status")
 01h	DWORD	transaction number
SeeAlso: #02289,#02290
--------N-21F222SF05-------------------------
INT 21 - Novell NetWare - TTS GET APPLICATION THRESHOLDS
	AX = F222h subfn 05h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02293)
	ES:DI -> reply buffer (see #02294)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C705h,AX=F222h/SF=06h,AX=F222h/SF=07h

Format of NetWare "TTS Get Application Thresholds" request packet:
Offset	Size	Description	(Table 02293)
 00h	BYTE	05h (subfunction "TTS Get Application Thresholds")
SeeAlso: #02294,#02295

Format of NetWare "TTS Get Application Thresholds" request packet:
Offset	Size	Description	(Table 02294)
 00h	BYTE	logical lock threshold
 01h	BYTE	physical lock threshold
SeeAlso: #02293,#02295
--------N-21F222SF06-------------------------
INT 21 - Novell NetWare - TTS SET APPLICATION THRESHOLDS
	AX = F222h subfn 06h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02295)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C706h,AX=F222h/SF=05h,AX=F222h/SF=08h

Format of NetWare "TTS Set Application Thresholds" request packet:
Offset	Size	Description	(Table 02295)
 00h	BYTE	06h (subfunction "TTS Set Application Thresholds")
 01h	BYTE	logical lock threshold before implicit transaction started
 02h	BYTE	physical lock threshold before implicit transaction started
SeeAlso: #02294,#02298
--------N-21F222SF07-------------------------
INT 21 - Novell NetWare - TTS GET WORKSTATION THRESHOLDS
	AX = F222h subfn 07h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02296)
	ES:DI -> reply buffer (see #02297)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C707h,AX=F222h/SF=05h,AX=F222h/SF=08h

Format of NetWare "TTS Get Workstation Thresholds" request packet:
Offset	Size	Description	(Table 02296)
 00h	BYTE	07h (subfunction "TTS Get Workstation Thresholds")
SeeAlso: #02297

Format of NetWare "TTS Get Workstation Thresholds" reply packet:
Offset	Size	Description	(Table 02297)
 00h	BYTE	logical lock threshold
 01h	BYTE	physical lock threshold
SeeAlso: #02296
--------N-21F222SF08-------------------------
INT 21 - Novell NetWare - TTS SET WORKSTATION THRESHOLDS
	AX = F222h subfn 08h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02298)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C708h,AX=F222h/SF=06h,AX=F222h/SF=07h

Format of NetWare "TTS Set Workstation Thresholds" request packet:
Offset	Size	Description	(Table 02298)
 00h	BYTE	08h (subfunction "TTS Set Workstation Thresholds")
 01h	BYTE	logical lock threshold before implicit transaction started
 02h	BYTE	physical lock threshold before implicit transaction started
SeeAlso: #02295
--------N-21F222SF09-------------------------
INT 21 - Novell NetWare - TTS GET CONTROL FLAGS
	AX = F222h subfn 09h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02299)
	ES:DI -> reply buffer (see #02300)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C702h,AX=F222h/SF=07h,AX=F222h/SF=0Ah

Format of NetWare "TTS Get Transaction Bits" request packet:
Offset	Size	Description	(Table 02299)
 00h	BYTE	09h (subfunction "TTS Get Transaction Bits")
SeeAlso: #02300

Format of NetWare "TTS Get Transaction Bits" reply packet:
Offset	Size	Description	(Table 02300)
 00h	BYTE	TTS control flags
		bit 0: forced (automatic) record locking enabled
		bits 1-7: reserved
SeeAlso: #02299
--------N-21F222SF0A-------------------------
INT 21 - Novell NetWare - TTS SET CONTROL FLAGS
	AX = F222h subfn 0Ah
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02301)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=C702h,AX=F222h/SF=08h,AX=F222h/SF=09h

Format of NetWare "TTS Set Transaction Bits" request packet:
Offset	Size	Description	(Table 02301)
 00h	BYTE	0Ah (subfunction "TTS Set Transaction Bits")
 01h	BYTE	TTS control flags
		bit 0: forced (automatic) record locking enabled
		bits 1-7: reserved
--------N-21F223SF01-------------------------
INT 21 - Novell NetWare v2+ - AFP CREATE DIRECTORY
	AX = F223h subfn 01h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02302)
	ES:DI -> reply buffer (see #02303)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=02h,AX=F223h/SF=0Dh

Format of NetWare "AFP Create Directory" request packet:
Offset	Size	Description	(Table 02302)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	01h (subfunction "AFP Create Directory")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	reserved for future use
 09h 32 BYTEs	Finder information
 29h	BYTE	path length
 2Ah  N BYTEs	AFP-style directory pathname (relative to AFP entry ID)
SeeAlso: #02303,#02304,#02330

Format of NetWare "AFP Create Directory" reply packet:
Offset	Size	Description	(Table 02303)
 00h	DWORD	new directory ID
SeeAlso: #02302,#02331
--------N-21F223SF02-------------------------
INT 21 - Novell NetWare v2+ - AFP CREATE FILE
	AX = F223h subfn 02h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02304)
	ES:DI -> reply buffer (see #02305)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=02h,AX=F223h/SF=03h,AX=F223h/SF=0Dh

Format of NetWare "AFP Create File" request packet:
Offset	Size	Description	(Table 02304)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	01h (subfunction "AFP Create Directory")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	flag: delete existing file? (00h no, 01h yes)
 09h 32 BYTEs	Finder information
 29h	BYTE	path length
 2Ah  N BYTEs	AFP-style directory pathname (relative to AFP entry ID)
SeeAlso: #02302,#02305,#02306,#02332

Format of NetWare "AFP Create File" reply packet:
Offset	Size	Description	(Table 02305)
 00h	DWORD	new file's AFP entry ID
SeeAlso: #02304,#02333
--------N-21F223SF03-------------------------
INT 21 - Novell NetWare v2+ - AFP DELETE FILE
	AX = F223h subfn 03h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02306)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Note:	directories may be deleted if they are empty
SeeAlso: AH=F2h"Novell",AX=F223h/SF=02h,AX=F223h/SF=0Dh

Format of NetWare "AFP Delete File" request packet:
Offset	Size	Description	(Table 02306)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	03h (subfunction "AFP Delete File")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	path length
 09h  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #02304
--------N-21F223SF04-------------------------
INT 21 - Novell NetWare v2+ - AFP GET ENTRY ID FROM FILENAME
	AX = F223h subfn 04h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02307)
	ES:DI -> reply buffer (see #02308)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=06h,AX=F223h/SF=0Ch,AX=F223h/SF=12h

Format of NetWare "AFP Get Entry ID from Name" request packet:
Offset	Size	Description	(Table 02307)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	04h (subfunction "AFP Get Entry ID from Name")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	path length
 09h  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #02308,#02314

Format of NetWare "AFP Get Entry ID from Name" reply packet:
Offset	Size	Description	(Table 02308)
 00h	DWORD	AFP entry ID corresponding to specified file/directory
SeeAlso: #02307,#02315
--------N-21F223SF05-------------------------
INT 21 - Novell NetWare v2+ - AFP GET FILE INFORMATION
	AX = F223h subfn 05h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02309)
	ES:DI -> reply buffer (see #02311)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=09h,AX=F223h/SF=13h

Format of NetWare "AFP Get File Information" request packet:
Offset	Size	Description	(Table 02309)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	05h (subfunction "AFP Get File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	WORD	request bitmap
 0Ah	BYTE	path length
 0Bh  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #02311

Bitfields for NetWare AFP request bitmap:
Bit(s)	Description	(Table 02310)
 0	return AFP entry ID
 1	return data fork length
 2	return resource fork length
 3	return number of contained files/subdirectories
 4	return owner ID
 5	return short name
 6	return access rights
 7	??? (unused?)
 8	return attributes
 9	return parent directory ID
 10	return creation date
 11	return last-access date
 12	return last-modified date and time
 13	return last-backup date and time
 14	return Finder information
 15	return long name
SeeAlso: #02309,#02336,#02337

Format of NetWare "AFP Get File Information" reply packet:
Offset	Size	Description	(Table 02311)
 00h	DWORD	AFP entry ID for specified file
 04h	DWORD	AFP entry ID for specified file's parent directory
 08h	WORD	directory/file attributes (see #02312)
 0Ah	DWORD	length of data fork
 0Eh	DWORD	length of resource fork
 12h	WORD	total files and subdirectories contained within entry
		always 0000h if entry is a file
 14h	WORD	creation date in AFP format
 16h	WORD	last-access date in AFP format
 18h	WORD	last-modified date in AFP format
 1Ah	WORD	last-modified time in AFP format
 1Ch	WORD	last-backup date in AFP format
 1Eh	WORD	last-backup time in AFP format
 20h 32 BYTEs	Finder information
 40h 32 BYTEs	long filename
 60h	DWORD	NetWare object ID of owner
 64h 12 BYTEs	short filename (MS-DOS 8.3 format)
 70h	WORD	access privileges (see #02313)
SeeAlso: #02309,#02338

Bitfields for NetWare AFP file/directory attributes:
Bit(s)	Description	(Table 02312)
 0	search mode
 1	search mode
 2	search mode
 3	(undefined)
 4	transaction
 5	index
 6	read audit
 7	write audit
 8	read-only
 9	hidden
 10	system
 11	execute-only
 12	subdirectory
 13	archive
 14	(undefined)
 15	shareable file
SeeAlso: #02311,#02322,#02337

Bitfields for NetWare AFP access privileges:
Bit(s)	Description	(Table 02313)
 8	read (files)
 9	write (files)
 10	open (files)
 11	create (files)
 12	delete (files)
 13	parental (directories): create/delete/rename subdirectories
 14	search (directories)
 15	modify file status flags
SeeAlso: #02311,#02337,#02327
--------N-21F223SF06-------------------------
INT 21 - Novell NetWare v2+ - AFP GET ENTRY ID FROM NETWARE HANDLE
	AX = F223h subfn 06h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02314)
	ES:DI -> reply buffer (see #02315)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=0Ch,AX=F223h/SF=12h

Format of NetWare "AFP Get Entry ID from NetWare Handle" request packet:
Offset	Size	Description	(Table 02314)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	06h (subfunction "AFP Get Entry ID from NetWare Handle")
 03h  6 BYTEs	NetWare file handle
SeeAlso: #02315,#02307

Format of NetWare "AFP Get Entry ID from NetWare Handle" reply packet:
Offset	Size	Description	(Table 02315)
 00h	BYTE	volume number
 01h	DWORD	AFP entry ID corresponding to same file as NetWare handle
 05h	BYTE	fork indicator (00h data fork, 01h resource fork)
SeeAlso: #02314,#02308
--------N-21F223SF07-------------------------
INT 21 - Novell NetWare v2+ - AFP RENAME
	AX = F223h subfn 07h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02316)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=01h,AX=F223h/SF=03h,AX=F223h/SF=08h

Format of NetWare "AFP Rename" request packet:
Offset	Size	Description	(Table 02316)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	07h (subfunction "AFP Rename")
 03h	BYTE	volume number
 04h	DWORD	source AFP entry ID
 08h	DWORD	destination AFP entry ID
 0Ch	BYTE	source path length
 0Dh  N BYTEs	AFP-style source path (relative to source AFP entry ID)
	BYTE	destination path length
      N BYTEs	AFP-style destination path (relative to destination entry ID)
Note:	the file may be moved from one directory to another without being
	  renamed by setting the destination path to the empty string
--------N-21F223SF08-------------------------
INT 21 - Novell NetWare v2+ - AFP OPEN FILE FORK
	AX = F223h subfn 08h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02317)
	ES:DI -> reply buffer (see #02318)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=01h,AX=F223h/SF=05h,AX=F223h/SF=09h

Format of NetWare "AFP Open File Fork" request packet:
Offset	Size	Description	(Table 02317)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	08h (subfunction "AFP Open File Fork")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	fork indicator (00h = data fork, 01h = resource fork)
 09h	BYTE	access mode
		bit 0: read
		bit 1: write
		bit 2: deny read access to others
		bit 3: deny write access to others
		bit 4: compatibility mode (should be set)
 0Ah	BYTE	path length
 0Bh  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #02318

Format of NetWare "AFP Open File Fork" reply packet:
Offset	Size	Description	(Table 02318)
 00h	DWORD	AFP entry ID for newly-opened file fork
 04h	DWORD	length of opened fork
 08h  6 BYTEs	NetWare file handle
SeeAlso: #02317
--------N-21F223SF09-------------------------
INT 21 - Novell NetWare v2+ - AFP SET FILE INFORMATION
	AX = F223h subfn 09h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02319)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=05h,AX=F223h/SF=0Ah,AX=F223h/SF=13h

Format of NetWare "AFP Set File Information" request packet:
Offset	Size	Description	(Table 02319)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	09h (subfunction "AFP Set File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	WORD	request bitmap (see #02320)
 0Ah	WORD	directory/file attributes (see #02335)
 0Ch	WORD	creation date in AFP format
 0Eh	WORD	last-access date in AFP format
 10h	WORD	last-modified date in AFP format
 12h	WORD	last-modified time in AFP format
 14h	WORD	last-backup date in AFP format
 16h	WORD	last-backup time in AFP format
 18h 32 BYTEs	Finder information
 38h	BYTE	path length
 39h  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #02334

Bitfields for NetWare AFP request bitmap:
Bit(s)	Description	(Table 02320)
 8	set attributes
 10	set creation date
 11	set last-access date
 12	set last-modified date
 13	set last-backup date
 14	set Finder information
SeeAlso: #02319,#02334
--------N-21F223SF0A-------------------------
INT 21 - Novell NetWare v2+ - AFP SCAN FILE INFORMATION
	AX = F223h subfn 0Ah
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02321)
	ES:DI -> reply buffer (see #02323)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=01h,AX=F223h/SF=03h,AX=F223h/SF=08h

Format of NetWare "AFP Scan File Information" request packet:
Offset	Size	Description	(Table 02321)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Ah (subfunction "AFP Scan File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	DWORD	AFP last-seen ID (from previous call)
		FFFFFFFFh on first call
 0Ch	WORD	number of entries to return (max. 4)
 0Eh	WORD	search bitmap (see #02322)
 10h	WORD	request bitmap (see #02310)
 12h	BYTE	path length
 13h  N BYTEs	AFS-style directory path (relative to AFP entry ID)
SeeAlso: #02323,#02336

Bitfields for NetWare AFP search bitmap:
Bit(s)	Description	(Table 02322)
 8	hidden files and directories
 9	system files and directories
 10	subdirectories
 11	files
SeeAlso: #02321,#02336,#02310,#02312

Format of NetWare "AFP Scan File Information" reply packet:
Offset	Size	Description	(Table 02323)
 00h	WORD	number of entries returned
 02h 120N BYTEs	file information records (see #02324)
SeeAlso: #02321

Format of NetWare AFP file information:
Offset	Size	Description	(Table 02324)
 00h	DWORD	AFP entry ID
 04h	DWORD	parent directory's AFP entry ID
 08h	WORD	directory/file attributes (see #02312)
 0Ah	DWORD	length of data fork
 0Eh	DWORD	length of resource fork
 12h	WORD	total files and subdirectories contained within entry
		always 0000h if entry is a file
 14h	WORD	creation date in AFP format
 16h	WORD	last-access date in AFP format
 18h	WORD	last-modified date in AFP format
 1Ah	WORD	last-modified time in AFP format
 1Ch	WORD	last-backup date in AFP format
 1Eh	WORD	last-backup time in AFP format
 20h 32 BYTEs	Finder information
 40h 32 BYTEs	long filename
 60h	DWORD	NetWare object ID of owner
 64h 12 BYTEs	short filename (MS-DOS 8.3 format)
 70h	WORD	access privileges (see #02313)
SeeAlso: #02323
--------N-21F223SF0B-------------------------
INT 21 - Novell NetWare v2+ - AFP ALLOCATE TEMPORARY DIRECTORY HANDLE
	AX = F223h subfn 0Bh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02325)
	ES:DI -> reply buffer (see #02326)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=0Dh

Format of NetWare "AFP Alloc Temporary Directory Handle" request packet:
Offset	Size	Description	(Table 02325)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Bh (subfunction "AFT Alloc Temporary Directory Handle")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	path length
 09h  N BYTEs	AFP-style pathname
SeeAlso: #02326

Format of NetWare "AFP Alloc Temporary Directory Handle" request packet:
Offset	Size	Description	(Table 02326)
 00h	BYTE	directory handle
 01h	BYTE	NetWare access rights (see #02327)
SeeAlso: #02325

Bitfields for NetWare AFP access rights:
Bit(s)	Description	(Table 02327)
 0	read
 1	write
 2	open
 3	create
 4	delete
 5	parental: create/delete/rename subdirectories
 6	search
 7	modify file status flags
SeeAlso: #02326,#02313
--------N-21F223SF0C-------------------------
INT 21 - Novell NetWare v2+ - AFP GET ENTRY ID FROM PATHNAME
	AX = F223h subfn 0Ch
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02328)
	ES:DI -> reply buffer (see #02329)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=06h,AX=F223h/SF=12h

Format of NetWare "AFP Get Entry ID from Path Name" request packet:
Offset	Size	Description	(Table 02328)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Ch (subfunction "AFP Get Entry ID from Path Name")
 03h	BYTE	NetWare directory handle
 04h	BYTE	path length
 05h  N BYTEs	pathname
SeeAlso: #02329

Format of NetWare "AFP Get Entry ID from Path Name" reply packet:
Offset	Size	Description	(Table 02329)
 00h	DWORD	AFP entry ID corresponding to specified file
SeeAlso: #02328
--------N-21F223SF0D-------------------------
INT 21 - Novell NetWare v2+ - AFP 2.0 CREATE DIRECTORY
	AX = F223h subfn 0Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02330)
	ES:DI -> reply buffer (see #02331)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=01h,AX=F223h/SF=0Eh

Format of NetWare "AFP 2.0 Create Directory" request buffer:
Offset	Size	Description	(Table 02330)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Dh (subfunction "AFP 2.0 Create Directory")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	reserved for future use
 09h 32	BYTEs	Finder information
 29h  6 BYTEs	ProDOS information
 2Fh	BYTE	path length
 30h	var	AFS-style directory path (relative to AFP entry)
SeeAlso: #02331,#02302

Format of NetWare "AFP 2.0 Create Directory" reply buffer:
Offset	Size	Description	(Table 02331)
 00h	DWORD	new directory ID
SeeAlso: #02330,#02303
--------N-21F223SF0E-------------------------
INT 21 - Novell NetWare v2+ - AFP 2.0 CREATE FILE
	AX = F223h subfn 0Eh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02332)
	ES:DI -> reply buffer (see #02333)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=0Dh

Format of NetWare "AFP 2.0 Create File" request packet:
Offset	Size	Description	(Table 02332)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	0Eh (function "AFP 2.0 Create File")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	BYTE	flag: delete existing file? (00h no, 01h yes)
 09h 32 BYTEs	Finder information
 29h  6 BYTEs	ProDOS information
 2Fh	BYTE	path length
 30h	var	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #02333,#02304

Format of NetWare "AFP 2.0 Create File" reply packet:
Offset	Size	Description	(Table 02333)
 00h	DWORD	new file ID
SeeAlso: #02332,#02305
--------N-21F223SF10-------------------------
INT 21 - Novell NetWare v2+ - AFP 2.0 SET FILE INFORMATION
	AX = F223h subfn 10h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02334)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=09h,AX=F223h/SF=11h

Format of NetWare "AFP 2.0 Set File Information" request packet:
Offset	Size	Description	(Table 02334)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	10h (subfunction "AFS 2.0 Set File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	WORD	request bitmap (see #02320)
 0Ah	WORD	directory/file attributes (see #02335)
 0Ch	WORD	creation date in AFP format
 0Eh	WORD	last-access date in AFP format
 10h	WORD	last-modified date in AFP format
 12h	WORD	last-modified time in AFP format
 14h	WORD	last-backup date in AFP format
 16h	WORD	last-backup time in AFP format
 18h 32 BYTEs	Finder information
 38h  6 BYTEs	ProDOS information
 3Eh	BYTE	path length
 3Fh  N BYTEs	AFP-style pathname (relative to AFP entry ID)
SeeAlso: #02319

Bitfields for NetWare AFP directory/file attributes:
Bit(s)	Description	(Table 02335)
 0	read-only
 1	hidden
 2	system
 3	execute-only
 4	subdirectory
 5	archive
 7	shareable file
SeeAlso: #02334
--------N-21F223SF11-------------------------
INT 21 - Novell NetWare v2+ - AFP 2.0 SCAN FILE INFORMATION
	AX = F223h subfn 11h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02336)
	ES:DI -> reply buffer (see #02337)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=0Dh,AX=F223h/SF=10h

Format of NetWare "AFP 2.0 Scan File Information" request packet:
Offset	Size	Description	(Table 02336)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	11h (subfunction "AFP 2.0 Scan File Information")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
 08h	DWORD	AFP last-seen ID (from previous call)
		FFFFFFFFh on first call
 0Ch	WORD	number of entries to return (max. 4)
 0Eh	WORD	search bitmap (see #02322)
 10h	WORD	request bitmap (see #02310)
 12h	BYTE	path length
 13h  N BYTEs	AFS-style directory path (relative to AFP entry ID)
SeeAlso: #02337

Format of NetWare "AFP 2.0 Scan File Information" reply packet:
Offset	Size	Description	(Table 02337)
 00h	WORD	number of entries returned
 02h 120N BYTEs	file information records (see #02338)
SeeAlso: #02336

Format of NetWare AFP 2.0 file information:
Offset	Size	Description	(Table 02338)
 00h	DWORD	AFP entry ID
 04h	DWORD	parent directory's AFP entry ID
 08h	WORD	directory/file attributes (see #02312)
 0Ah	DWORD	length of data fork
 0Eh	DWORD	length of resource fork
 12h	WORD	total files and subdirectories contained within entry
		always 0000h if entry is a file
 14h	WORD	creation date in AFP format
 16h	WORD	last-access date in AFP format
 18h	WORD	last-modified date in AFP format
 1Ah	WORD	last-modified time in AFP format
 1Ch	WORD	last-backup date in AFP format
 1Eh	WORD	last-backup time in AFP format
 20h 32 BYTEs	Finder information
 40h 32 BYTEs	long filename
 60h	DWORD	NetWare object ID of owner
 64h 12 BYTEs	short filename (MS-DOS 8.3 format)
 70h	WORD	access privileges (see #02313)
 72h  6 BYTEs	ProDOS information
SeeAlso: #02337,#02310,#02311
--------N-21F223SF12-------------------------
INT 21 - Novell NetWare v2+ - AFP GET DOS FILENAME FROM ENTRY ID
	AX = F223h subfn 12h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02339)
	ES:DI -> reply buffer (see #02340)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=06h

Format of NetWare "AFP Get DOS Name from Entry ID" request packet:
Offset	Size	Description	(Table 02339)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	12h (subfunction "AFP Get DOS Name From Entry ID")
 03h	BYTE	volume number
 04h	DWORD	AFP entry ID
SeeAlso: #02340

Format of NetWare "AFP Get DOS Name from Entry ID" reply packet:
Offset	Size	Description	(Table 02340)
 00h	BYTE	length of DOS pathname
 01h  N BYTEs	pathname corresponding to AFP entry ID
SeeAlso: #02339
--------N-21F223SF13-------------------------
INT 21 - Novell NetWare v2+ - AFP GET MACINTOSH INFORMATION ON DELETED FILE
	AX = F223h subfn 13h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02341)
	ES:DI -> reply buffer (see #02342)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=05h,AX=F223h/SF=09h

Format of NetWare "AFP Get Macintosh Info on Deleted File" request packet:
Offset	Size	Description	(Table 02341)
 00h	WORD	(big-endian) length of following data
 02h	BYTE	13h (subfunction "AFP Get Macintosh Info on Deleted File")
 03h	BYTE	volume number
 04h	DWORD	server's DOS directory entry index
SeeAlso: #02342

Format of NetWare "AFP Get Macintosh Info on Deleted File" reply packet:
Offset	Size	Description	(Table 02342)
 00h 32 BYTEs	Finder information
 20h  6 BYTEs	ProDOS information
 26h	DWORD	size of resource fork
 2Ah	BYTE	length of filename
 2Bh  N BYTEs	filename
SeeAlso: #02341
--------N-21F23D-----------------------------
INT 21 - Novell NetWare - COMMIT FILE
	AX = F23Dh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02347)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=3Eh,AH=F2h"Novell",AX=F23Eh,AX=F243h
--------N-21F23E-----------------------------
INT 21 - Novell NetWare - FILE SEARCH INITIALIZE (FindFirst)
	AX = F23Eh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02343)
	ES:DI -> reply buffer (see #02344)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=4Eh,AH=F2h"Novell",AX=F23Fh,AX=F242h

Format of NetWare "File Search Initialize" request packet:
Offset	Size	Description	(Table 02343)
 00h	BYTE	directory handle
 01h	BYTE	length of directory path
 02h  N BYTEs	path of directory to search, in VOLUME:DIRECTORY/... format
SeeAlso: #02344,#02345

Format of NetWare "File Search Initialize" reply packet:
Offset	Size	Description	(Table 02344)
 00h	BYTE	volume number
 01h	WORD	directory ID
 03h	WORD	search sequence number
 05h	BYTE	directory access rights
SeeAlso: #02343,#02346
--------N-21F23F-----------------------------
INT 21 - Novell NetWare - FILE SEARCH CONTINUE (FindNext)
	AX = F23Fh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02345)
	ES:DI -> reply buffer (see #02346)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=4Eh,AH=F2h"Novell",AX=F23Eh,AX=F242h

Format of NetWare "File Search Continue" request packet:
Offset	Size	Description	(Table 02345)
 00h	BYTE	volume number
 02h	WORD	directory ID from File Search Initialize
 04h	WORD	search sequence (set to FFFFh before first call)
 06h	BYTE	search attributes
 07h	BYTE	length of search directory path
 08h  N BYTEs	name of search directory in VOLUME:DIRECTORY/.../DIR format
SeeAlso: #02346

Format of NetWare "File Search Continue" reply packet:
Offset	Size	Description	(Table 02346)
 00h	WORD	next search sequence
 02h	WORD	directory ID from File Search Initialize
 04h	WORD	reserved for future use
 06h 14 BYTEs	filename
 14h	BYTE	file attributes
 15h	BYTE	file mode
 16h	DWORD	file length
 2Ah	WORD	creation date
 2Ch	WORD	last-access date
 2Eh	WORD	last-modification date
 30h	WORD	last-modification time
SeeAlso: #02345
--------N-21F242-----------------------------
INT 21 - Novell NetWare - CLOSE FILE
	AX = F242h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02347)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=3Eh,AH=F2h"Novell",AX=F23Eh,AX=F243h,AX=F24Ah

Format of NetWare "Commit/Close File" request packet:
Offset	Size	Description	(Table 02347)
 00h	BYTE	reserved (0)
 01h  6 BYTEs	NetWare file handle
--------N-21F243-----------------------------
INT 21 - Novell NetWare - CREATE FILE
	AX = F243h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02348)
	ES:DI -> reply buffer (see #02349)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=3Ch,AH=F2h"Novell",AX=F23Eh,AX=F242h,AX=F24Ah,AX=F24Dh

Format of NetWare "Create File" request packet:
Offset	Size	Description	(Table 02348)
 00h	BYTE	directory handle
 01h	BYTE	file attributes
 02h	BYTE	length of filename
 03h  N BYTEs	filename in DOS format
SeeAlso: #02349

Format of NetWare "Create File" reply packet:
Offset	Size	Description	(Table 02349)
 00h  6 BYTEs	NetWare file handle
 06h	WORD	reserved
 08h 14 BYTEs	DOS-format filename
 16h	BYTE	file attributes
 17h	BYTE	file execute type
 18h	DWORD	file length
 1Ch	WORD	creation date
 1Eh	WORD	last-access date
 20h	WORD	last-modification date
 22h	WORD	last-modification time
SeeAlso: #02348
--------N-21F244-----------------------------
INT 21 - Novell NetWare - FILE SERVICES - ERASE FILE
	AX = F244h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02351)
	ES:DI ignored
Return: AL = status (see #02350)
Note:	this function only marks the file for deletion; use AH=E2h/SF=CEh to
	  actually delete all marked files
SeeAlso: AH=13h,AH=41h,AH=E2h/SF=0Bh,AH=E3h/SF=CEh

(Table 02350)
Values for NetWare function status:
 00h	successful
 98h	nonexistent volume
 9Bh	invaid directory handle
 9Ch	invalid path
 FFh	no files found
SeeAlso: #02094,#02860 at INT 2F/AX=7A20h/BX=0000h

Format of NetWare "Erase Files" request packet:
Offset	Size	Description	(Table 02351)
 00h	BYTE	directory handle
 01h	BYTE	search attributes (see #01420 at AX=4301h)
 02h	BYTE	length of filespec
 03h  N BYTEs	ASCIZ filespec (may include wildcards)
--------N-21F247-----------------------------
INT 21 - Novell NetWare - GET CURRENT FILE SIZE
	AX = F247h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02352)
	ES:DI -> reply buffer (see #02353)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=42h,AH=F2h"Novell",AX=F23Eh,AX=F242h,AX=F24Ah,AX=F24Dh

Format of NetWare "Get Current Size of File" request packet:
Offset	Size	Description	(Table 02352)
 00h	BYTE	reserved for future use
 01h  6 BYTEs	NetWare file handle
SeeAlso: #02353

Format of NetWare "Get Current Size of File" reply packet:
Offset	Size	Description	(Table 02353)
 00h	DWORD	current size of file
SeeAlso: #02352
--------N-21F24A-----------------------------
INT 21 - Novell NetWare - COPY FROM ONE FILE TO ANOTHER
	AX = F24Ah
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02354)
	ES:DI -> reply buffer (see #02355)
Return: AX = status (see #02350)
Note:	this function only marks the file for deletion; use AH=E2h/SF=CEh to
	  actually delete all marked files
SeeAlso: AH=F2h"Novell",AX=F243h,AX=F247h,AH=F3h"NetWare"

Format of NetWare "Copy from One File to Another" request packet:
Offset	Size	Description	(Table 02354)
 00h	BYTE	reserved for future use
 01h  6 BYTEs	source NetWare file handle
 07h  6 BYTEs	destination NetWare file handle
 0Dh	DWORD	source file offset
 11h	DWORD	destination file offset
 15h	DWORD	number of bytes to copy
SeeAlso: #02355

Format of NetWare "Copy from One File to Another" reply packet:
Offset	Size	Description	(Table 02355)
 00h	DWORD	number of bytes actually copied
SeeAlso: #02354
--------N-21F24D-----------------------------
INT 21 - Novell NetWare - CREATE NEW FILE
	AX = F24Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02356)
	ES:DI -> reply buffer (see #02357)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=6C00h,AH=F2h"Novell",AX=F23Eh,AX=F242h,AX=F243h

Format of NetWare "Create New File" request packet:
Offset	Size	Description	(Table 02356)
 00h	BYTE	directory handle
 01h	BYTE	file attributes
 02h	BYTE	length of filename
 03h  N BYTEs	filename in DOS format
SeeAlso: #02357

Format of NetWare "Create New File" reply packet:
Offset	Size	Description	(Table 02357)
 00h  6 BYTEs	NetWare file handle
 06h	WORD	reserved
 08h 14 BYTEs	DOS-format filename
 16h	BYTE	file attributes
 17h	BYTE	file execute type
 18h	DWORD	file length
 1Ch	WORD	creation date
 1Eh	WORD	last-access date
 20h	WORD	last-modification date
 22h	WORD	last-modification time
SeeAlso: #02356
--------N-21F24E-----------------------------
INT 21 - Novell NetWare v2+ - ALLOW TASK ACCESS TO FILE
	AX = F24Eh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02358)
	ES:DI -> reply buffer (see #02359)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
Desc:	allow calling task to gain access to an already-open file belonging
	  to another task of the same client
Note:	the caller receives the same access rights as the owning task, and
	  must use the returned new handle to access the file
SeeAlso: AH=F2h"NetWare",AX=F244h

Format of NetWare "Allow Task Access to File" request packet:
Offset	Size	Description	(Table 02358)
 00h	BYTE	reserved for future use
 01h  6 BYTEs	NetWare file handle
SeeAlso: #02359

Format of NetWare "Allow Task Access to File" reply packet:
Offset	Size	Description	(Table 02359)
 00h  6 BYTEs	new file handle
SeeAlso: #02358
--------N-21F256SF01-------------------------
INT 21 - Novell NetWare - CLOSE EXTENDED ATTRIBUTE HANDLE
	AX = F256h subfn 01h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02360)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=02h,AX=F256h/SF=04h,AX=F256h/SF=05h

Format of NetWare "Close Extended Attribute Handle" request packet:
Offset	Size	Description	(Table 02360)
 00h	BYTE	01h (subfunction "Close Extended Attribute Handle")
 01h	WORD	reserved for future use
 03h	DWORD	extended attribute handle
--------N-21F256SF02-------------------------
INT 21 - Novell NetWare - WRITE EXTENDED ATTRIBUTE
	AX = F256h subfn 02h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02361)
	ES:DI -> reply buffer (see #02362)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=01h,AX=F256h/SF=03h,AX=F256h/SF=05h

Format of NetWare "Write Extended Attribute" request packet:
Offset	Size	Description	(Table 02361)
 00h	BYTE	02h (subfunction "Write Extended Attribute")
 01h	WORD	flags (see #02372)
 03h  8 BYTEs	extended attribute handle structure (see #02373)
 0Bh	DWORD	write size
 0Fh	DWORD	write position
 13h	DWORD	access flag
 17h	WORD	length of value
 19h	WORD	key length
 1Bh  N BYTEs	key
      N BYTEs	value
SeeAlso: #02361,#02363

Format of NetWare "Write Extended Attribute" reply packet:
Offset	Size	Description	(Table 02362)
 00h	DWORD	error code
 04h	DWORD	number of bytes written
 08h	DWORD	new extended attribute handle
SeeAlso: #02361
--------N-21F256SF03-------------------------
INT 21 - Novell NetWare - READ EXTENDED ATTRIBUTE
	AX = F256h subfn 03h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02363)
	ES:DI -> reply buffer (see #02364)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=01h,AX=F256h/SF=04h,AX=F256h/SF=05h

Format of NetWare "Read Extended Attribute" request packet:
Offset	Size	Description	(Table 02363)
 00h	BYTE	03h (subfunction "Read Extended Attribute")
 01h	WORD	flags (see #02372)
 03h  8 BYTEs	extended attribute handle structure (see #02373)
 0Bh	DWORD	read position
 0Fh	DWORD	inspect size
 13h	WORD	key length
 15h  N BYTEs	key
SeeAlso: #02364,#02361

Format of NetWare "Read Extended Attribute" reply packet:
Offset	Size	Description	(Table 02364)
 00h	DWORD	error code
 04h	DWORD	total extended attribute value length
 08h	DWORD	new extended attribute handle
 0Ch	DWORD	access flag
 10h	WORD	value length
 12h  N BYTEs	EA value
SeeAlso: #02363
--------N-21F256SF04-------------------------
INT 21 - Novell NetWare - ENUMERATE EXTENDED ATTRIBUTES
	AX = F256h subfn 04h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02365)
	ES:DI -> reply buffer (see #02366)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=01h,AX=F256h/SF=02h,AX=F256h/SF=05h

Format of NetWare "Enumerate Extended Attributes" request packet:
Offset	Size	Description	(Table 02365)
 00h	BYTE	04h (subfunction "Enumerate Extended Attributes")
 01h	WORD	flags (see #02372)
 03h  8 BYTEs	extended attribute handle structure (see #02373)
 0Bh	DWORD	inspect size
 0Fh	WORD	enumeration sequence
 11h	WORD	key length
 13h  N BYTEs	key
SeeAlso: #02366

Format of NetWare "Enumerate Extended Attributes" reply packet:
Offset	Size	Description	(Table 02366)
 00h	DWORD	error code
 04h	DWORD	total extended attributes
 08h	DWORD	total extended attribute data size
 0Ch	DWORD	total extended attribute key size
 10h	DWORD	new extended attribute handle
---information level 0---
 14h  2 WORDs	reserved
---information level 1---
 14h	WORD	number of enumerated extended attribute structures
 16h	var	EA structure level 1
---information level 6---
 14h	WORD	reserved
 16h	var	EA structure level 6
---information level 7---
 14h	WORD	number of enumerated extended attribute structures
 16h	var	EA structure level 7
SeeAlso: #02365

Format of NetWare Extended Attribute structure level 1:
Offset	Size	Description	(Table 02367)
 00h	DWORD	length of EA value
 04h	WORD	length of EA key
 06h	DWORD	access flag
 0Ah  N BYTEs	key
SeeAlso: #02366,#02368,#02369

Format of NetWare Extended Attribute structure level 6:
Offset	Size	Description	(Table 02368)
 00h	DWORD	length of EA value
 04h	WORD	length of EA key
 06h	DWORD	access flag
 0Ah	DWORD	key extents
 0Eh	DWORD	value extents
 12h  N BYTEs	key
SeeAlso: #02366,#02367,#02369

Format of NetWare Extended Attribute structure level 7:
Offset	Size	Description	(Table 02369)
 00h	BYTE	key length
 01h  N BYTEs	key
	BYTE	00h
SeeAlso: #02366,#02367,#02368
--------N-21F256SF05-------------------------
INT 21 - Novell NetWare - DUPLICATE EXTENDED ATTRIBUTES
	AX = F256h subfn 05h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02370)
	ES:DI -> reply buffer (see #02371)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F256h/SF=01h,AX=F256h/SF=02h,AX=F256h/SF=04h

Format of NetWare "Duplicate Extended Attributes" request packet:
Offset	Size	Description	(Table 02370)
 00h	BYTE	05h (subfunction "Duplicate Extended Attributes")
 01h	WORD	source flags (see #02372)
 03h	WORD	destination flags (see #02372)
 05h  8 BYTEs	source extended attribute structure (see #02373)
 0Dh  8 BYTEs	destination extended attribute structure (see #02373)
SeeAlso: #02371

Format of NetWare "Duplicate Extended Attributes" reply packet:
Offset	Size	Description	(Table 02371)
 00h	DWORD	number duplicated
 04h	DWORD	data size duplicated
 08h	DWORD	key size duplicated
SeeAlso: #02370

Bitfields for NetWare extended attribute flags:
Bit(s)	Description	(Table 02372)
 1-0	extended attribute handle structure type
	00 volume number and directory entry number
	01 NetWare file handle
	10 extended attribute handle
	11 not used
 2	close handle on error
 6-4	information level (0,1,6,7)
 7	not used
SeeAlso: #02370,#02373

Format of NetWare extended attribute structure:
Offset	Size	Description	(Table 02373)
---type 0---
 00h	DWORD	volume number
 04h	DWORD	directory entry number
---type 1---
 00h	DWORD	NetWare file handle
 04h  4 BYTEs	unused
---type 2---
 00h	DWORD	extended attribute handle
 04h  4 BYTEs	unused
SeeAlso: #02372
--------N-21F257SF01-------------------------
INT 21 - Novell NetWare - OPEN/CREATE FILE OR SUBDIRECTORY
	AX = F257h subfn 01h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02374)
	ES:DI -> reply buffer (see #02375)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=6C00h,AX=F257h/SF=02h,AX=F257h/SF=04h

Format of NetWare "Open/Create File or Subdirectory" request packet:
Offset	Size	Description	(Table 02374)
 00h	BYTE	01h (subfunction "Open/Create File or Subdirectory")
 01h	BYTE	name space (see #02387)
 02h	BYTE	open/create mode
 03h	WORD	search attributes
 05h	DWORD	return information mask
 09h	DWORD	create attributes
 0Dh	WORD	desired access rights (see #02377)
 0Fh		NetWare handle/path structure
SeeAlso: #02375

Format of NetWare "Open/Create File or Subdirectory" reply packet:
Offset	Size	Description	(Table 02375)
 00h	DWORD	file handle
 04h	BYTE	open/create action
		00h open
		01h replace
		03h create
 05h	BYTE	reserved
SeeAlso: #02374

Format of NetWare Handle/Path structure:
Offset	Size	Description	(Table 02376)
 00h	BYTE	volume number
 01h	DWORD	directory base or short handle
 05h	BYTE	handle flag
		00h short directory handle
		01h directory base
		FFh no handle
 06h	BYTE	path component count
 07h  N BYTEs	path component

Bitfields for NetWare desired access rights:
Bit(s)	Description	(Table 02377)
 0	read-only mode
 1	write-only
 2	deny read
 3	deny write
 4	compatibility mode
 6	write-through mode
SeeAlso: #02374
--------N-21F257SF02-------------------------
INT 21 - Novell NetWare - INITIALIZE SEARCH
	AX = F257h subfn 02h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02378)
	ES:DI -> reply buffer (see #02379)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=4Eh,AH=F2h"Novell",AX=F257h/SF=01h,AX=F257h/SF=03h

Format of NetWare "Initialize Search" request packet:
Offset	Size	Description	(Table 02378)
 00h	BYTE	02h (subfunction "Initialize Search")
 01h	BYTE	name space (see #02387)
 02h	BYTE	reserved for future use
 03h		NetWare Handle/Path structure (see #02376)
SeeAlso: #02379

Format of NetWare "Initialize Search" reply packet:
Offset	Size	Description	(Table 02379)
 00h  9 BYTEs	search sequence
		BYTE	volume number
		DWORD	directory number
		DWORD	current directory number
SeeAlso: #02378
--------N-21F257SF03-------------------------
INT 21 - Novell NetWare - SCAN NAMESPACE ENTRY INFO
	AX = F257h subfn 03h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02380)
	ES:DI -> reply buffer (see #02381)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=04h,AX=F257h/SF=05h

Format of NetWare "Search for File or Subdirectory" request packet:
Offset	Size	Description	(Table 02380)
 00h	BYTE	03h (subfunction "Search for File or Subdirectory")
	???
SeeAlso: #02381

Format of NetWare "Search for File or Subdirectory" reply packet:
Offset	Size	Description	(Table 02381)
 00h	???
SeeAlso: #02380
--------N-21F257SF04-------------------------
INT 21 - Novell NetWare - RENAME OR MOVE FILE OR SUBDIRECTORY
	AX = F257h subfn 04h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02382)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=56h,AH=F2h"Novell",AX=F257h/SF=02h,AX=F257h/SF=03h,AX=F257h/SF=05h

Format of NetWare "Rename or Move File or Subdirectory" request packet:
Offset	Size	Description	(Table 02382)
 00h	BYTE	04h (subfunction "Rename or Move File or Subdirectory")
 01h	BYTE	name space (see #02387)
 02h	BYTE	rename flags
		bit 0: rename successful
		bit 1: compatibility mode
 03h	WORD	search attributes
 05h		source NetWare Handle Path
		destination NetWare Handle Path
--------N-21F257SF05-------------------------
INT 21 - Novell NetWare - SCAN FILE OR SUBDIRECTORY FOR TRUSTEES
	AX = F257h subfn 05h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02383)
	ES:DI -> reply buffer (see #02384)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=04h,AX=F257h/SF=06h

Format of NetWare "Scan File or Subdirectory for Trustees" request packet:
Offset	Size	Description	(Table 02383)
 00h	BYTE	05h (subfunction "Scan File or Subdirectory for Trustees")
 01h	BYTE	name space (see #02387)
 02h	BYTE	reserved for future use
 03h	DWORD	scan sequence (set to 00000000h before first call)
 07h		NetWare Handle/Path structure (see #02376)
SeeAlso: #02384

Format of NetWare "Scan File or Subdirectory for Trustees" reply packet:
Offset	Size	Description	(Table 02384)
 00h	DWORD	next scan sequence or FFFFFFFFh if no more
 04h	WORD	number of trustee object IDs returned
 06h		trustee structure
SeeAlso: #02383
--------N-21F257SF06-------------------------
INT 21 - Novell NetWare v3+ - GET INFORMATION ABOUT FILE OR DIRECTORY
	AX = F257h subfn 06h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02385)
	ES:DI -> reply buffer (see #02388)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AH=F2h"Novell",AX=F257h/SF=02h,AX=F257h/SF=05h,AX=F257h/SF=07h

Format of NetWare "Get NS Entry Info" request buffer:
Offset	Size	Description	(Table 02385)
 00h	BYTE	06h (subfunction "Get NS Entry Info")
 01h	BYTE	name space (see #02387)
 02h	BYTE	destination name space
 03h	WORD	search attributes
 05h	DWORD	return information mask (see #02386)
 09h	BYTE	volume number
 0Ah	DWORD	directory base
 0Eh	BYTE	handle flag
		00h first byte of dir base is dir handle; ignore volume number
		01h dir base = unique ID, volume number set
		FFh volume number and dir base ignored, volume part of path
 0Fh	BYTE	number of path components
 10h  N BYTEs	list of path components (each a counted string)
SeeAlso: #02388

Bitfields for return information mask:
Bit(s)	Description	(Table 02386)
 0	include filename
 1	data stream space allocated info
 2	attributes info
 3	data stream size info
 4	total space allocated for all data streams
 5	extended attributes info
 6	archive info
 7	modify info
 8	create info
 9	name space info
 10	directory info
 11	rights info

(Table 02387)
Values for NetWare name space:
 00h	DOS
 01h	Macintosh
 02h	NFS
 03h	FTAM
 04h	OS/2
SeeAlso: #02385,#02393

Format of NetWare "Get NS Entry Info" reply buffer:
Offset	Size	Description	(Table 02388)
 00h 72 BYTEs	reserved
 48h	DWORD	creator's name space number
 4Ch 257 BYTEs	reserved
SeeAlso: #02385
--------N-21F257SF07-------------------------
INT 21 - Novell NetWare - MODIFY FILE OR SUBDIRECTORY DOS INFORMATION
	AX = F257h subfn 07h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02389)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=04h,AX=F257h/SF=08h

Format of NetWare "Modify File or Subdirectory DOS Information" request packet:
Offset	Size	Description	(Table 02389)
 00h	BYTE	07h (subfunction "Modify File or Subdirectory DOS Information")
 01h	BYTE	name space (see #02387)
 02h	BYTE	reserved for future use
 03h	WORD	search attributes
 05h	DWORD	modify DOS mask
 09h		Modify DOS information structure
--------N-21F257SF08-------------------------
INT 21 - Novell NetWare - DELETE FILE/DIRECTORY
	AX = F257h subfn 08h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02390)
	ES:DI -> reply buffer (see #02391)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=01h,AX=F257h/SF=07h

Format of NetWare "Delete File/Directory" request packet:
Offset	Size	Description	(Table 02390)
 00h	BYTE	08h (subfunction "Delete File/Directory")
	???
SeeAlso: #02391

Format of NetWare "Delete File/Directory" reply packet:
Offset	Size	Description	(Table 02391)
 00h	???
SeeAlso: #02390
--------N-21F257SF09-------------------------
INT 21 - Novell NetWare - SET SHORT DIRECTORY HANDLE
	AX = F257h subfn 09h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02392)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=0Ch

Format of NetWare "Set Short Directory Handle" request packet:
Offset	Size	Description	(Table 02392)
 00h	BYTE	09h (subfunction "Set Short Directory Handle")
 01h	BYTE	name space (see #02387)
 02h	BYTE	data stream
 03h	BYTE	destination directory handle
 04h	BYTE	reserved for future use
 05h		NetWare Handle/Path structure (see #02376)
--------N-21F257SF0A-------------------------
INT 21 - Novell NetWare v3+ - ADD TRUSTEE SET TO FILE OR SUBDIRECTORY
	AX = F257h subfn 0Ah
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02393)
	ES:DI ignored
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F257h/SF=0Bh

Format of NetWare "Add Trustee Set" request packet:
Offset	Size	Description	(Table 02393)
 00h	BYTE	0Ah (subfunction "Add Trustee Set to File or Subdirectory")
 01h	BYTE	name space (see #02387)
 02h  2 BYTEs	reserved
 04h	WORD	trustee rights (see #02141)
 06h	WORD	object ID count
 08h		NetWare Handle/Path structure (see #02376)
      6 BYTEs	trustee structure (see #02394)

Format of NetWare trustee structure:
Offset	Size	Description	(Table 02394)
 00h	DWORD	object ID
 04h	WORD	trustee rights
SeeAlso: #02393
--------N-21F257SF0B-------------------------
INT 21 - Novell NetWare - DELETE TRUSTEE
	AX = F257h subfn 0Bh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02395)
	ES:DI -> reply buffer (see #02396)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=0Ah

Format of NetWare "Delete Trustee" request packet:
Offset	Size	Description	(Table 02395)
 00h	BYTE	0Bh (subfunction "Delete Trustee")
	???
SeeAlso: #02396

Format of NetWare "Delete Trustee" reply packet:
Offset	Size	Description	(Table 02396)
 00h	???
SeeAlso: #02395
--------N-21F257SF0C-------------------------
INT 21 - Novell NetWare v2+ - ALLOCATE SHORT DIRECTORY HANDLE
	AX = F257h subfn 0Ch
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02397)
	ES:DI -> reply buffer (see #02398)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Note:	unlike "Alloc Permanent Directory Handle", this function does not
	  automatically map a drive
SeeAlso: AH=F2h"Novell",AX=F223h/SF=04h,AX=F223h/SF=05h,AX=F223h/SF=09h

Format of NetWare "Allocate Short Directory Handle" request packet:
Offset	Size	Description	(Table 02397)
 00h	BYTE	0Ch (subfunction "Allocate Short Directory Handle")
 01h	BYTE	name space (see #02387)
 02h  2 BYTEs	reserved for future use
 04h	WORD	allocation mode
		bits 1-0: 00 permanent handle
			  01 temporary handle
			  10 special temporary handle
			  11 reserved
 06h		NetWare Handle/Path structure (see #02376)
SeeAlso: #02398

Format of NetWare "Allocate Short Directory Handle" reply packet:
Offset	Size	Description	(Table 02398)
 00h	BYTE	new directory handle
 01h	BYTE	volume number
 02h	DWORD	reserved for future use
SeeAlso: #02397
--------N-21F257SF10-------------------------
INT 21 - Novell NetWare - SCAN SALVAGEABLE FILES
	AX = F257h subfn 10h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02399)
	ES:DI -> reply buffer (see #02400)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Bh,AX=F257h/SF=11h,AX=F257h/SF=12h

Format of NetWare "Scan Salvageable Files" request packet:
Offset	Size	Description	(Table 02399)
 00h	BYTE	10h (subfunction "Scan Salvageable Files")
 01h	BYTE	name space
 02h	BYTE	data stream
 03h	DWORD	return information mask
 07h	DWORD	last sequence (set to FFFFFFFFh before first call)
 0Bh		NetWare Handle/Path structure (see #02376)
SeeAlso: #02400,#02123

Format of NetWare "Scan Salvageable Files" reply packet:
Offset	Size	Description	(Table 02400)
 00h	DWORD	next sequence number
 04h	WORD	deletion time
 06h	WORD	deletion date
 08h	DWORD	ID of deletor
 0Ch	DWORD	volume number
 10h	DWORD	directory entry number
 14h		NetWare Information Structure
SeeAlso: #02399,#02124
--------N-21F257SF11-------------------------
INT 21 - Novell NetWare - RECOVER SALVAGEABLE FILE
	AX = F257h subfn 11h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02401)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Ch,AX=F257h/SF=10h,AX=F257h/SF=12h

Format of NetWare "Recover Salvageable File" request packet:
Offset	Size	Description	(Table 02401)
 00h	BYTE	11h (subfunction "Recover Salvageable File")
 01h	BYTE	name space
 02h	BYTE	reserved for future use
 03h	DWORD	sequence number
 07h	DWORD	volume number
 0Bh	DWORD	scan directory base
 0Fh	BYTE	new file name length
 10h  N BYTEs	new file name
SeeAlso: #02402,#02125
--------N-21F257SF12-------------------------
INT 21 - Novell NetWare - PURGE SALVAGEABLE FILE
	AX = F257h subfn 12h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02402)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F216h/SF=1Dh,AX=F257h/SF=10h,AX=F257h/SF=11h

Format of NetWare "Purge Salvageable File" request packet:
Offset	Size	Description	(Table 02402)
 00h	BYTE	12h (subfunction "Purge Salvageable File")
 01h	BYTE	name space
 02h	BYTE	reserved
 03h	DWORD	sequence number
 07h	DWORD	volume number
 0Bh	DWORD	directory entry number
SeeAlso: #02401
--------N-21F257SF13-------------------------
INT 21 - Novell NetWare - GET NAMESPACE INFORMATION
	AX = F257h subfn 13h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02403)
	ES:DI -> reply buffer (see #02404)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=12h,AX=F257h/SF=15h

Format of NetWare "Get Namespace Information" request packet:
Offset	Size	Description	(Table 02403)
 00h	BYTE	13h (subfunction "Get Namespace Information")
 01h	BYTE	source name space (see #02387)
 02h	BYTE	destination name space
 03h	BYTE	reserved for future use
 04h	BYTE	volume number
 05h	DWORD	directory base
 09h	DWORD	namespace information mask
SeeAlso: #02404

Format of NetWare "Get Namespace Information" reply packet:
Offset	Size	Description	(Table 02404)
 00h	var	namespace-specific information
SeeAlso: #02403
--------N-21F257SF15-------------------------
INT 21 - Novell NetWare - GET PATH STRING FROM SHORT DIRECTORY HANDLE
	AX = F257h subfn 15h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02405)
	ES:DI -> reply buffer (see #02406)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=13h,AX=F257h/SF=16h

Format of NetWare "Get Path String from Short Directory Handle" request packet:
Offset	Size	Description	(Table 02405)
 00h	BYTE	15h (subfunction "Get Path String from Short Directory Handle")
 01h	BYTE	name space (see #02387)
 02h	BYTE	short directory handle
SeeAlso: #02406

Format of NetWare "Get Path String from Short Directory Handle" reply packet:
Offset	Size	Description	(Table 02406)
 00h	BYTE	length of path
 01h  N BYTEs	full directory path
SeeAlso: #02405
--------N-21F257SF16-------------------------
INT 21 - Novell NetWare - GENERATE DIRECTORY BASE AND VOLUME NUMBER
	AX = F257h subfn 16h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02407)
	ES:DI -> reply buffer (see #02408)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=15h,AX=F257h/SF=17h

Format of NetWare "Generate Directory Base and Volume Number" request packet:
Offset	Size	Description	(Table 02407)
 00h	BYTE	16h (subfunction "Generate Directory Base and Volume Number")
 01h	BYTE	name space (#02802)
 02h  3 BYTEs	reserved for future use
 05h		NetWare Handle/Path structure (see #02376)
SeeAlso: #02408

Format of NetWare "Generate Directory Base and Volume Number" reply packet:
Offset	Size	Description	(Table 02408)
 00h	DWORD	namespace directory base
 04h	DWORD	DOS directory base
 08h	BYTE	volume number
SeeAlso: #02407
--------N-21F257SF17-------------------------
INT 21 - Novell NetWare - GET NAME SPACE INFORMATION FORMAT
	AX = F257h subfn 17h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02409)
	ES:DI -> reply buffer (see #02410)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=18h,AX=F257h/SF=19h

Format of NetWare "Get Name Space Information Format" request packet:
Offset	Size	Description	(Table 02409)
 00h	BYTE	17h (subfunction "Get Name Space Information Format")
 01h	BYTE	name space (see #02387)
 02h	BYTE	volume number
SeeAlso: #02410

Format of NetWare "Get Name Space Information Format" reply packet:
Offset	Size	Description	(Table 02410)
 00h	DWORD	fixed bitmask
 04h	DWORD	variable bitmask
 08h	DWORD	huge bitmask
 0Ch	WORD	fixed bits defined
 0Eh	WORD	variable bits defined
 10h	WORD	huge bits defined
 12h 128 BYTEs	field lengths
SeeAlso: #02409
--------N-21F257SF18-------------------------
INT 21 - Novell NetWare - GET NAME SPACES LOADED
	AX = F257h subfn 18h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02411)
	ES:DI -> reply buffer (see #02412)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=17h,AX=F257h/SF=19h,AX=F257h/SF=1Ah
SeeAlso: AX=F216h/SF=2Fh

Format of NetWare "Get Name Spaces Loaded" request packet:
Offset	Size	Description	(Table 02411)
 00h	BYTE	18h (subfunction "Get Name Spaces Loaded")
 01h  2 BYTEs	reserved for future use
 03h	BYTE	volume number
SeeAlso: #02412

Format of NetWare "Get Name Spaces Loaded" reply packet:
Offset	Size	Description	(Table 02412)
 00h	WORD	number of namespace elements
 02h	WORD	number of namespace elements loaded
 04h  N BYTEs	loaded name spaces (each byte contains number of one loaded
		  name space)
SeeAlso: #02411
--------N-21F257SF19-------------------------
INT 21 - Novell NetWare - WRITE NAME SPACE INFO
	AX = F257h subfn 19h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02413)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=17h,AX=F257h/SF=18h

Format of NetWare "Write Name Space Info" request packet:
Offset	Size	Description	(Table 02413)
 00h	BYTE	19h (subfunction "Write Name Space Info")
 01h	BYTE	source name space (see #02387)
 02h	BYTE	destination name space
 03h	BYTE	volume number
 04h	DWORD	directory entry number
 08h	DWORD	namespace information bitmask
 0Ch 512 BYTEs	namespace-specific informatin
--------N-21F257SF1A-------------------------
INT 21 - Novell NetWare - READ EXTENDED NAME SPACE INFO
	AX = F257h subfn 1Ah
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02414)
	ES:DI -> reply buffer (see #02415)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=18h,AX=F257h/SF=19h,AX=F257h/SF=1Bh

Format of NetWare "Read Extended Name Space Info" request packet:
Offset	Size	Description	(Table 02414)
 00h	BYTE	1Ah (subfunction "Read Extended Name Space Info")
 01h	BYTE	name space (see #02387)
 02h	BYTE	volume number
 03h	DWORD	directory base
 07h	DWORD	huge mask
 0Bh 16 BYTEs	huge state information
SeeAlso: #02415

Format of NetWare "Read Extended Name Space Info" reply packet:
Offset	Size	Description	(Table 02415)
 00h 16 BYTEs	next huge state information
 10h	DWORD	huge data length
 14h  N BYTEs	huge data
SeeAlso: #02414
--------N-21F257SF1B-------------------------
INT 21 - Novell NetWare - WRITE EXTENDED NAME SPACE INFO
	AX = F257h subfn 1Bh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02416)
	ES:DI -> reply buffer (see #02417)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=17h,AX=F257h/SF=18h,AX=F257h/SF=1Ah

Format of NetWare "Write Extended Name Space Info" request packet:
Offset	Size	Description	(Table 02416)
 00h	BYTE	1Bh (subfunction "Write Extended Name Space Info")
 01h	BYTE	name space (see #02387)
 02h	BYTE	volume number
 03h	DWORD	directory entry number
 07h	DWORD	huge mask
 0Bh 16 BYTEs	huge state information
 1Bh	DWORD	huge data length
 1Fh  N BYTEs	huge data
SeeAlso: #02417

Format of NetWare "Write Extended Name Space Info" request packet:
Offset	Size	Description	(Table 02417)
 00h 16 BYTEs	next huge state information
 10h	DWORD	huge data used
SeeAlso: #02416
--------N-21F257SF1C-------------------------
INT 21 - Novell NetWare - GET NS FULL PATH STRING
	AX = F257h subfn 1Ch
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02418)
	ES:DI -> reply buffer (see #02419)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
Note:	this call returns the path in reverse order (root directory last)
SeeAlso: AH=F2h"Novell",AX=F257h/SF=03h,AX=F257h/SF=15h

Format of NetWare "Get NS Full Path String" request packet:
Offset	Size	Description	(Table 02418)
 00h	BYTE	1Ch (subfunction "Get NS Full Path String")
 01h	BYTE	source name space
 02h	BYTE	destination name space
 03h 10	BYTEs	path cookie (see #02420)
 04h		NetWare Handle/Path structure (see #02376)
SeeAlso: #02419

Format of NetWare "Get NS Full Path String" reply packet:
Offset	Size	Description	(Table 02419)
 00h 10 BYTEs	next path cookie (see #02420)
 0Ah	WORD	size of path component(s) in packet
 0Ch	WORD	number of path components in packet
 0Eh		path components
SeeAlso: #02418

Format of NetWare path cookie:
Offset	Size	Description	(Table 02420)
 00h	WORD	flags
		bit 0: last component is a filename
 02h	DWORD	cookie1
 06h	DWORD	cookie2
Note:	"cookie1" and "cookie2" are to be set to FFFFFFFFh initially; if
	  "cookie2" is FFFFFFFFh on return, all path components have been
	  transferred
SeeAlso: #02418,#02419
--------N-21F257SF1D-------------------------
INT 21 - Novell NetWare - GET EFFECTIVE DIRECTORY RIGHTS
	AX = F257h subfn 1Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02421)
	ES:DI -> reply buffer (see #02422)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AX=F216h/SF=03h,AX=F257h/SF=06h,AX=F257h/SF=0Ch,AX=F257h/SF=15h

Format of NetWare "Get Effective Directory Rights" request packet:
Offset	Size	Description	(Table 02421)
 00h	BYTE	1Dh (subfunction "Get Effective Directory Rights")
 01h	BYTE	name space (see #02387)
 02h	BYTE	destination name space (see #02387)
 03h	WORD	search attributes
 05h	DWORD	return information mask
 09h		NetWare Handle/Path structure (see #02376)
SeeAlso: #02422

Format of NetWare "Get Effective Directory Rights" reply packet:
Offset	Size	Description	(Table 02422)
 00h	WORD	caller's effective rights
 02h		NetWare Information Structure
SeeAlso: #02421
--------N-21F258SF01-------------------------
INT 21 - Novell NetWare v4+ - GET VOLUME AUDITING STATISTICS
	AX = F258h subfn 01h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02423)
	ES:DI -> reply buffer (see #02424)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F268h/SF=C8h

Format of NetWare "Get Volume Auditing Statistics" request buffer:
Offset	Size	Description	(Table 02423)
 00h	BYTE	01h (function "Get Volume Auditing Statistics")
 01h	DWORD	volume
SeeAlso: #02424

Format of NetWare "Get Volume Auditing Statistics" reply buffer:
Offset	Size	Description	(Table 02424)
 00h	WORD	auditing version (date)
 02h	WORD	audit file version (date)
 04h	DWORD	auditing enabled flag
 08h	DWORD	audit file's size
 0Ch	DWORD	audit configuration file's size
 10h	DWORD	maximum audit file size
 14h	DWORD	audit file size threshold
 18h	DWORD	number of audit records
 1Ch	DWORD	number of history records
SeeAlso: #02423,#02476
--------N-21F258SF02-------------------------
INT 21 - Novell NetWare - ADD AUDIT PROPERTY
	AX = F258h subfn 02h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02425)
	ES:DI -> reply buffer (see #02426)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F217h/SF=39h,AX=F258h/SF=06h,AX=F258h/SF=08h

Format of NetWare "Add Audit Property" request packet:
Offset	Size	Description	(Table 02425)
 00h	BYTE	02h (subfunction "Add Audit Property")
	???
SeeAlso: #02426

Format of NetWare "Add Audit Property" reply packet:
Offset	Size	Description	(Table 02426)
 00h	???
SeeAlso: #02425
--------N-21F258SF03-------------------------
INT 21 - Novell NetWare - LOGIN AS VOLUME AUDITOR
	AX = F258h subfn 03h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02427)
	ES:DI -> reply buffer (see #02428)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=04h,AX=F258h/SF=0Dh

Format of NetWare "Login As Volume Auditor" request packet:
Offset	Size	Description	(Table 02427)
 00h	BYTE	03h (subfunction "Login As Volume Auditor")
	???
SeeAlso: #02428

Format of NetWare "Login As Volume Auditor" reply packet:
Offset	Size	Description	(Table 02428)
 00h	???
SeeAlso: #02427
--------N-21F258SF04-------------------------
INT 21 - Novell NetWare - CHANGE AUDITOR PASSWORD
	AX = F258h subfn 04h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02429)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=03h

Format of NetWare "Change Auditor Password" request packet:
Offset	Size	Description	(Table 02429)
 00h	BYTE	04h (subfunction "Change Auditor Password")
	???
--------N-21F258SF05-------------------------
INT 21 - Novell NetWare - CHECK AUDIT ACCESS
	AX = F258h subfn 05h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02430)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=02h,AX=F258h/SF=08h

Format of NetWare "Check Audit Access" request packet:
Offset	Size	Description	(Table 02430)
 00h	BYTE	05h (subfunction "Check Audit Access")
	???
--------N-21F258SF06-------------------------
INT 21 - Novell NetWare - REMOVE AUDIT PROPERTY
	AX = F258h subfn 06h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02431)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=02h,AX=F258h/SF=05h

Format of NetWare "Remove Audit Property" request packet:
Offset	Size	Description	(Table 02431)
 00h	BYTE	06h (subfunction "Remove Audit Property")
	???
--------N-21F258SF07-------------------------
INT 21 - Novell NetWare - DISABLE AUDITING ON VOLUME
	AX = F258h subfn 07h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02432)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=08h,AX=F258h/SF=09h

Format of NetWare "Disable Auditing on Volume" request packet:
Offset	Size	Description	(Table 02432)
 00h	BYTE	07h (subfunction "Disable Auditing on Volume")
	???
--------N-21F258SF08-------------------------
INT 21 - Novell NetWare - ENABLE AUDITING ON VOLUME
	AX = F258h subfn 08h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02433)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=07h,AX=F258h/SF=09h

Format of NetWare "Enable Auditing on Volume" request packet:
Offset	Size	Description	(Table 02433)
 00h	BYTE	08h (subfunction "Enable Auditing on Volume")
	???
--------N-21F258SF09-------------------------
INT 21 - Novell NetWare - IS USER AUDITED?
	AX = F258h subfn 09h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02434)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=07h,AX=F258h/SF=08h

Format of NetWare "Is User Audited?" request packet:
Offset	Size	Description	(Table 02434)
 00h	BYTE	09h (subfunction "Is User Audited?")
	???
--------N-21F258SF0A-------------------------
INT 21 - Novell NetWare - READ AUDITING BITMAP
	AX = F258h subfn 0Ah
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02435)
	ES:DI -> reply buffer (see #02436)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Bh,AX=F258h/SF=10h

Format of NetWare "Read Auditing Bitmap" request packet:
Offset	Size	Description	(Table 02435)
 00h	BYTE	0Ah (subfunction "Read Auditing Bitmap")
	???
SeeAlso: #02436,#02437

Format of NetWare "Read Auditing Bitmap" reply packet:
Offset	Size	Description	(Table 02436)
 00h	???
SeeAlso: #02435,#02438
--------N-21F258SF0B-------------------------
INT 21 - Novell NetWare - READ AUDIT CONFIG HEADER
	AX = F258h subfn 0Bh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02437)
	ES:DI -> reply buffer (see #02438)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Ah,AX=F258h/SF=11h

Format of NetWare "Read Audit Configuration Header" request packet:
Offset	Size	Description	(Table 02437)
 00h	BYTE	0Bh (subfunction "Read Audit Configuration Header")
	???
SeeAlso: #02438,#02435

Format of NetWare "Read Audit Configuration Header" reply packet:
Offset	Size	Description	(Table 02438)
 00h	???
SeeAlso: #02437,#02436
--------N-21F258SF0D-------------------------
INT 21 - Novell NetWare - LOGOUT AS VOLUME AUDITOR
	AX = F258h subfn 0Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02439)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=03h

Format of NetWare "Logout as Volume Auditor" request packet:
Offset	Size	Description	(Table 02439)
 00h	BYTE	0Dh (subfunction "Logout as Volume Auditor")
	???
--------N-21F258SF0E-------------------------
INT 21 - Novell NetWare - RESET AUDITING FILE
	AX = F258h subfn 0Eh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02440)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Ah,AX=F258h/SF=0Fh

Format of NetWare "Reset Auditing File" request packet:
Offset	Size	Description	(Table 02440)
 00h	BYTE	0Eh (subfunction "Reset Auditing File")
	???
--------N-21F258SF0F-------------------------
INT 21 - Novell NetWare - RESET AUDIT HISTORY FILE
	AX = F258h subfn 0Fh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02441)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Eh

Format of NetWare "Reset Audit History File" request packet:
Offset	Size	Description	(Table 02441)
 00h	BYTE	0Fh (subfunction "Reset Audit History File")
	???
--------N-21F258SF10-------------------------
INT 21 - Novell NetWare - WRITE AUDITING BITMAP
	AX = F258h subfn 10h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02442)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Ah,AX=F258h/SF=11h

Format of NetWare "Write Auditing Bitmap" request packet:
Offset	Size	Description	(Table 02442)
 00h	BYTE	10h (subfunction "Write Auditing Bitmap")
	???
SeeAlso: #02443
--------N-21F258SF11-------------------------
INT 21 - Novell NetWare - WRITE AUDIT CONFIG HEADER
	AX = F258h subfn 11h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02443)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=0Bh,AX=F258h/SF=10h

Format of NetWare "Write Audit Configuration Header" request packet:
Offset	Size	Description	(Table 02443)
 00h	BYTE	11h (subfunction "Write Audit Configuration Header")
	???
SeeAlso: #02442
--------N-21F258SF13-------------------------
INT 21 - Novell NetWare - GET AUDITING FLAGS
	AX = F258h subfn 13h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02444)
	ES:DI -> reply buffer (see #02445)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=05h

Format of NetWare "Get Auditing Flags" request packet:
Offset	Size	Description	(Table 02444)
 00h	BYTE	13h (subfunction "Get Auditing Flags")
	???
SeeAlso: #02445

Format of NetWare "Get Auditing Flags" reply packet:
Offset	Size	Description	(Table 02445)
 00h	???
SeeAlso: #02444
--------N-21F258SF14-------------------------
INT 21 - Novell NetWare - CLOSE OLD AUDITING FILE
	AX = F258h subfn 14h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02446)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=15h

Format of NetWare "Close Old Auditing File" request packet:
Offset	Size	Description	(Table 02446)
 00h	BYTE	14h (subfunction "Close Old Auditing File")
	???
SeeAlso: #02447
--------N-21F258SF15-------------------------
INT 21 - Novell NetWare - DELETE OLD AUDITING FILE
	AX = F258h subfn 15h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02447)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=14h

Format of NetWare "Delete Old Auditing File" request packet:
Offset	Size	Description	(Table 02447)
 00h	BYTE	15h (subfunction "Delete Old Auditing File")
	???
SeeAlso: #02446
--------N-21F258SF16-------------------------
INT 21 - Novell NetWare - CHECK AUDIT LEVEL TWO ACCESS
	AX = F258h subfn 16h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02448)
	ES:DI -> reply buffer
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F258h/SF=05h

Format of NetWare "Check Audit Level Two Access" request packet:
Offset	Size	Description	(Table 02448)
 00h	BYTE	16h (subfunction "Check Audit Level Two Access")
	???
--------N-21F25ASF01-------------------------
INT 21 - Novell NetWare - GET DATA MIGRATION INFO
	AX = F25Ah subfn 01h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02449)
	ES:DI -> reply buffer (see #02450)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=80h,AX=F25Ah/SF=86h

Format of NetWare "Get Data Migration Information" request packet:
Offset	Size	Description	(Table 02449)
 00h	WORD	length of following data
 02h	BYTE	01h (subfunction "Get Data Migration Information")
SeeAlso: #02450

Format of NetWare "Get Data Migration Information" reply packet:
Offset	Size	Description	(Table 02450)
 00h	???
SeeAlso: #02449
--------N-21F25ASF80-------------------------
INT 21 - Novell NetWare - MOVE FILE DATA TO DATA MIGRATION
	AX = F25Ah subfn 80h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02451)
	ES:DI -> reply buffer (see #02452)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=82h,AX=F25Ah/SF=85h

Format of NetWare "Move File Data to Data Migration" request packet:
Offset	Size	Description	(Table 02451)
 00h	WORD	length of following data
 02h	BYTE	80h (subfunction "Move File Data to Data Migration")
 03h	DWORD	volume number
 07h	DWORD	directory entry number
 0Bh	DWORD	name space (see #02387)
 0Fh	DWORD	support module ID
 13h	DWORD	save key flag
		00000010h to save key when file is demigrated
SeeAlso: #02452

Format of NetWare "Move File Data to Data Migration" reply packet:
Offset	Size	Description	(Table 02452)
 00h	DWORD	volume-unique ID
SeeAlso: #02451
--------N-21F25ASF81-------------------------
INT 21 - Novell NetWare - DATA MIGRATION FILE INFORMATION
	AX = F25Ah subfn 81h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02453)
	ES:DI -> reply buffer (see #02454)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=80h,AX=F25Ah/SF=82h,AX=F25Ah/SF=83h

Format of NetWare "Data Migration File Information" request packet:
Offset	Size	Description	(Table 02453)
 00h	WORD	length of following data
 02h	BYTE	81h (subfunction "Data Migration File Information")
 03h	DWORD	volume number
 07h	DWORD	directory entry number
 0Bh	DWORD	name space (see #02387)
SeeAlso: #02454

Format of NetWare "Data Migration File Information" reply packet:
Offset	Size	Description	(Table 02454)
 00h	DWORD	support module ID
 04h	DWORD	estimate restoration time
 08h	DWORD	bitmask of supported data streams
SeeAlso: #02453
--------N-21F25ASF82-------------------------
INT 21 - Novell NetWare - VOLUME DATA MIGRATION STATUS
	AX = F25Ah subfn 82h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02455)
	ES:DI -> reply buffer (see #02456)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=01h,AX=F25Ah/SF=83h,AX=F25Ah/SF=84h

Format of NetWare "Volume Data Migration Status" request packet:
Offset	Size	Description	(Table 02455)
 00h	WORD	length of following data
 02h	BYTE	82h (subfunction "Volume Data Migration Status")
 03h	DWORD	volume number
 07h	DWORD	support module ID
SeeAlso: #02456

Format of NetWare "Volume Data Migration Status" request packet:
Offset	Size	Description	(Table 02456)
 00h	DWORD	number of migrated files
 04h	DWORD	total size required to restore all migrated files
 08h	DWORD	total space used on migration device
 0Ch	DWORD	limbo space (demigrated files with save-key flag set)
 10h	DWORD	total space including limbo space
 14h	DWORD	number of files in limbo
SeeAlso: #02455
--------N-21F25ASF83-------------------------
INT 21 - Novell NetWare - GET MIGRATION OR STATUS INFORMATION
	AX = F25Ah subfn 83h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02457)
	ES:DI -> reply buffer (see #02458)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=82h,AX=F25Ah/SF=84h,AX=F25Ah/SF=85h

Format of NetWare "Get Migration or Status Information" request packet:
Offset	Size	Description	(Table 02457)
 00h	WORD	length of following data
 02h	BYTE	83h (subfunction "Get Migration or Status Information")
SeeAlso: #02458

Format of NetWare "Get Migration or Status Information" request packet:
Offset	Size	Description	(Table 02458)
 00h	DWORD	presence flag
		FFFFFFFFh if Data Migration NLM is loaded and running
 04h	DWORD	major version
 08h	DWORD	minor version
 0Ch	DWORD	flag: has support module registered with Data Migrator?
SeeAlso: #02457
--------N-21F25ASF84-------------------------
INT 21 - Novell NetWare - DATA MIGRATION SUPPORT MODULE INFORMATION
	AX = F25Ah subfn 84h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02459)
	ES:DI -> reply buffer (see #02460)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=82h,AX=F25Ah/SF=83h,AX=F25Ah/SF=86h

Format of NetWare "Data Migration Support Module Information" request packet:
Offset	Size	Description	(Table 02459)
 00h	WORD	length of following data
 02h	BYTE	84h (subfunction "Data Migration Support Module Information")
 03h	DWORD	information level
		0000h get data migration NLM info
		0001h get loaded support modules
		0002h get name of support module
 07h	DWORD	support module ID
SeeAlso: #02460

Format of NetWare "Data Migration Support Module Information" request packet:
Offset	Size	Description	(Table 02460)
---information level 0---
 00h	DWORD	read/write access status
 04h	DWORD	length of Specific Device Information block (max 384)
 08h	DWORD	space available on support module
 0Ch	DWORD	amount of space used
 10h	BYTE	length of support module's name
 11h 14 BYTEs	support module name
 1Fh 128 BYTEs	support module information
---information level 1---
 00h	DWORD	number of support modules
 04h 32 BYTEs	support module IDs
---information level 2---
 00h	BYTE	length of module name
 01h 32 BYTEs	support module name
SeeAlso: #02459
--------N-21F25ASF85-------------------------
INT 21 - Novell NetWare - MOVE FILE DATA FROM DATA MIGRATION
	AX = F25Ah subfn 85h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02461)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=80h,AX=F25Ah/SF=83h,AX=F25Ah/SF=86h

Format of NetWare "Move File Data From Data Migration" request packet:
Offset	Size	Description	(Table 02461)
 00h	WORD	length of following data
 02h	BYTE	85h (subfunction "Move File Data from Data Migration")
 03h	DWORD	volume number
 07h	DWORD	directory entry number
 0Bh	DWORD	name space (see #02387)
SeeAlso: #02452
--------N-21F25ASF86-------------------------
INT 21 - Novell NetWare - GET OR SET DEFAULT SUPPORT MODULE
	AX = F25Ah subfn 86h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02462)
	ES:DI -> reply buffer (see #02463)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F25Ah/SF=01h,AX=F25Ah/SF=80h,AX=F25Ah/SF=84h

Format of NetWare "Get or Set Default Support Module" request packet:
Offset	Size	Description	(Table 02462)
 00h	WORD	length of following data
 02h	BYTE	86h (subfunction "Get or Set Default Support Module")
 03h	DWORD	direction
		00h get default support module
		01h set default support module
 07h	DWORD	new module ID if setting
SeeAlso: #02463

Format of NetWare "Get or Set Default Support Module" request packet:
Offset	Size	Description	(Table 02463)
 00h	DWORD	support module ID
SeeAlso: #02462
--------N-21F268SF01-------------------------
INT 21 - Novell NetWare v4+ - GET TREE NAME
	AX = F268h subfn 01h
	CX = length of request buffer in bytes (0001h)
	DX = length of reply buffer in bytes (0064h)
	DS:SI -> request buffer (see #02464)
	ES:DI -> reply buffer (see #02465)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F268h/SF=04h

Format of NetWare "Get Tree Name" request buffer:
Offset	Size	Description	(Table 02464)
 00h	BYTE	01h (subfunction "Get Tree Name")

Format of NetWare "Get Tree Name" reply buffer:
Offset	Size	Description	(Table 02465)
 00h	DWORD	Ping version
 04h	DWORD	length of tree name
 08h 32 BYTEs	tree name, padded with underscores ('_')
 28h 60 BYTEs	???
--------N-21F268SF04-------------------------
INT 21 - Novell NetWare v4+ - GET BINDERY CONTEXT
	AX = F268h subfn 04h
	CX = length of request buffer in bytes (0001h)
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02466)
	ES:DI -> reply buffer (see #02467)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F268h/SF=01h,AX=F268h/SF=C8h

Format of NetWare "Get Bindery Context" request buffer:
Offset	Size	Description	(Table 02466)
 00h	BYTE	04h (subfunction "Get Bindery Context")

Format of NetWare "Get Bindery Context" reply buffer:
Offset	Size	Description	(Table 02467)
 00h	DWORD	length (max 200)
 04h  N WORDs	Unicode bindery context string
--------N-21F268SF05-------------------------
INT 21 - Novell NetWare v4+ - MONITOR NDS CONNECTION
	AX = F268h subfn 05h
	CX = length of request buffer in bytes (0001h)
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02468)
	ES:DI -> reply buffer (unused???)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)

Format of NetWare "Monitor NDS Connection" request buffer:
Offset	Size	Description	(Table 02468)
 00h	BYTE	05h (subfunction "Monitor NDS Connection"
--------N-21F268SF16-------------------------
INT 21 - Novell NetWare v4+ - NDS LIST PARTITIONS
	AX = F268h subfn 16h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02469)
	ES:DI -> reply buffer (see #02470)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
Note:	the length specified in CX must be exactly 13 bytes more than the
	  length field at offset 09h in the request buffer for this function
	  to be successful
SeeAlso: AX=F268h/SF=35h

Format of NetWare "NDS List Partitions" request buffer:
Offset	Size	Description	(Table 02469)
 00h	BYTE	02h
 01h	DWORD	??? (FFFFFFFFh)
 05h	DWORD	??? (00000202h)
 09h	DWORD	length (00000018h)
 0Dh	DWORD	??? (00000000h)
 11h	DWORD	function (00000016h) (subfunction "NDS List Partitions")
 15h	DWORD	??? (00000400h)
 19h	DWORD	API version (00000000h)
 1Dh	DWORD	??? (00000000h)
 21h	DWORD	iteration (FFFFFFFFh)
SeeAlso: #02470,#02471

Format of NetWare "NDS List Partitions" reply buffer:
Offset	Size	Description	(Table 02470)
 00h	DWORD	length
 04h	DWORD	???
 08h	DWORD	return code
 0Ch	DWORD	iteration
 10h 1000 BYTEs	returned data
SeeAlso: #02469
--------N-21F268SF35-------------------------
INT 21 - Novell NetWare v4+ - NDS GET SERVER NAME AND ADDRESS
	AX = F268h subfn 35h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02471)
	ES:DI -> reply buffer (see #02472)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
Note:	the length specified in CX must be exactly 13 bytes more than the
	  length field at offset 09h in the request buffer for this function
	  to be successful
SeeAlso: AX=F268h/SF=16h

Format of NetWare "NDS Get Server Name and Address" request buffer:
Offset	Size	Description	(Table 02471)
 00h	BYTE	02h
 01h	DWORD	??? (FFFFFFFFh)
 05h	DWORD	??? (00000202h)
 09h	DWORD	length (0000000Ch)
 0Dh	DWORD	??? (00000000h)
 11h	DWORD	function (00000035h) (subfunc "NDS Get Server Name and Addr")
 15h	DWORD	??? (00000400h)
SeeAlso: #02469,#02472

Format of NetWare "NDS Get Server Name and Address" reply buffer:
Offset	Size	Description	(Table 02472)
 00h	DWORD	length
 04h	DWORD	???
 08h	DWORD	return code
 0Ch	DWORD	length of name
 10h  N WORDs	Unicode server name string
	var	padding
	DWORD	??? (00000001h)
	DWORD	??? (00000000h)
	DWORD	??? (0000000Ch)
     12 BYTEs	server's IPX address
SeeAlso: #02471
--------N-21F268SF3D-------------------------
INT 21 - Novell NetWare v4+ - NDS LOGOUT
	AX = F268h subfn 3Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02473)
	ES:DI -> reply buffer (see #02474)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F217h/SF=14h

Format of NetWare "NDS Logout" request buffer:
Offset	Size	Description	(Table 02473)
 00h	BYTE	02h
 01h	DWORD	??? (FFFFFFFFh)
 05h	DWORD	??? (00000202h)
 09h	DWORD	length (0000000Ch)
 0Dh	DWORD	??? (00000000h)
 11h	DWORD	function (0000003Dh) (subfunction "NDS Logout")
 15h	DWORD	??? (00000000h)
SeeAlso: #02474

Format of NetWare "NDS Logout" reply buffer:
Offset	Size	Description	(Table 02474)
 00h	DWORD	length
 04h	DWORD	???
 08h	DWORD	return code
SeeAlso: #02473
--------N-21F268SFC8-------------------------
INT 21 - Novell NetWare v4+ - GET DS AUDITING STATISTICS
	AX = F268h subfn C8h
	CX = length of request buffer in bytes (0001h)
	DX = length of reply buffer in bytes (0020h)
	DS:SI -> request buffer (see #02475)
	ES:DI -> reply buffer (see #02476)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F258h/SF=01h,AX=F268h/SF=01h,AX=F268h/SF=04h

Format of NetWare "Get DS Auditing Statistics" request buffer:
Offset	Size	Description	(Table 02475)
 00h	BYTE	C8h (subfunction "Get DS Auditing Statistics")
SeeAlso: #02476

Format of NetWare "Get DS Auditing Statistics" reply buffer:
Offset	Size	Description	(Table 02476)
 00h	WORD	auditing version (date)
 02h	WORD	audit file version (date)
 04h	DWORD	auditing enabled flag
 08h	DWORD	audit file's size
 0Ch	DWORD	audit configuration file's size
 10h	DWORD	maximum audit file size
 14h	DWORD	audit file size threshold
 18h	DWORD	number of audit records
 1Ch	DWORD	number of history records
SeeAlso: #02424,#02475
--------N-21F269-----------------------------
INT 21 - Novell NetWare - LOG FILE
	AX = F269h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02477)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F203h,AX=F26Ah,AH=EBh"NetWare"

Format of NetWare "Log File" request packet:
Offset	Size	Description	(Table 02477)
 00h	BYTE	directory handle
 01h	BYTE	lock flag
		00h log only
		01h log and lock
 02h	WORD	lock timeout in clock ticks (0000h = don't wait)
 04h	BYTE	length of filename
 05h  N BYTEs	filename
--------N-21F26A-----------------------------
INT 21 - Novell NetWare - LOCK FILE SET
	AX = F26Ah
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02478)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F204h,AX=F269h,AH=CBh"NetWare"

Format of NetWare "Lock File Set" request packet:
Offset	Size	Description	(Table 02478)
 00h	WORD	lock timeout in clock ticks (0000h = don't wait)
--------N-21F26C-----------------------------
INT 21 - Novell NetWare - LOCK LOGICAL RECORD SET
	AX = F26Ch
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02479)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F20Ah,AX=F26Ah,AH=CBh"NetWare"

Format of NetWare "Lock Logical Record Set" request packet:
Offset	Size	Description	(Table 02479)
 00h	BYTE	lock flag
		00h shareable lock
		01h exclusive lock
 01h	WORD	lock timeout in clock ticks (0000h = don't wait)
--------N-21F26E-----------------------------
INT 21 - Novell NetWare - LOCK PHYSICAL RECORD SET
	AX = F26Eh
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02480)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F21Bh,AX=F26Ch,AH=C2h"NetWare"

Format of NetWare "Lock Physical Record Set" request packet:
Offset	Size	Description	(Table 02480)
 00h	BYTE	lock flag
		00h exclusive lock
		02h shareable lock
 01h	WORD	lock timeout in clock ticks (0000h = don't wait)
--------N-21F26FSF00-------------------------
INT 21 - Novell NetWare - OPEN SEMAPHORE
	AX = F26Fh subfn 00h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02481)
	ES:DI -> reply buffer (see #02482)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=01h,AX=F26Fh/SF=02h

Format of NetWare "Open Semaphore" request packet:
Offset	Size	Description	(Table 02481)
 00h	BYTE	00h (subfunction "Open Semaphore")
 01h	BYTE	initial semaphore value
 02h	BYTE	length of semaphore's name
 03h  N BYTEs	semaphore name
SeeAlso: #02482

Format of NetWare "Open Semaphore" request packet:
Offset	Size	Description	(Table 02482)
 00h	DWORD	semaphore handle
 04h	BYTE	number of clients using semaphore (including caller)
SeeAlso: #02481
--------N-21F26FSF01-------------------------
INT 21 - Novell NetWare - CLOSE SEMAPHORE
	AX = F26Fh subfn 01h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02483)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=00h,AX=F26Fh/SF=03h,AX=F220h/SF=04h

Format of NetWare "Close Semaphore" request packet:
Offset	Size	Description	(Table 02483)
 00h	BYTE	01h (subfunction "Close Semaphore")
 01h	DWORD	semaphore handle
SeeAlso: #02286
--------N-21F26FSF02-------------------------
INT 21 - Novell NetWare - WAIT ON SEMAPHORE
	AX = F26Fh subfn 02h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02484)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=00h,AX=F26Fh/SF=04h

Format of NetWare "Wait on Semaphore" request packet:
Offset	Size	Description	(Table 02484)
 00h	BYTE	02h (subfunction "Wait on Semaphore")
 01h	DWORD	semaphore handle
 05h	WORD	timeout in clock ticks (0000h = no wait)
--------N-21F26FSF03-------------------------
INT 21 - Novell NetWare - SIGNAL SEMAPHORE
	AX = F26Fh subfn 03h
	CX = length of request packet in bytes
	DX = 0000h (no reply packet)
	DS:SI -> request packet (see #02485)
	ES:DI ignored
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=02h,AX=F26Fh/SF=04h

Format of NetWare "Signal Semaphore" request packet:
Offset	Size	Description	(Table 02485)
 00h	BYTE	03h (subfunction "Signal Semaphore")
 01h	DWORD	semaphore handle
--------N-21F26FSF04-------------------------
INT 21 - Novell NetWare - EXAMINE SEMAPHORE
	AX = F26Fh subfn 04h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02486)
	ES:DI -> reply buffer (see #02487)
Return: AX = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
SeeAlso: AH=F2h"Novell",AX=F26Fh/SF=02h,AX=F26Fh/SF=03h

Format of NetWare "Examine Semaphore" request packet:
Offset	Size	Description	(Table 02486)
 00h	BYTE	04h (subfunction "Examine Semaphore")
 01h	DWORD	semaphore handle
SeeAlso: #02487

Format of NetWare "Examine Semaphore" reply packet:
Offset	Size	Description	(Table 02487)
 00h	BYTE	semaphore's current value
 01h	BYTE	number of clients using semaphore
SeeAlso: #02486
--------N-21F272-----------------------------
INT 21 - Novell NetWare v4+ - GET FILE SERVER UTC TIME
	AX = F272h
	CX = length of request buffer in bytes (0003h)
	DX = length of reply buffer in bytes (0064h)
	DS:SI -> request buffer (see #02488)
	ES:DI -> reply buffer (see #02489)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get File Server UTC Time" request buffer:
Offset	Size	Description	(Table 02488)
 00h	BYTE	??? (00h)
 01h	BYTE	??? (01h)
 02h	BYTE	??? (01h)
SeeAlso: #02489

Format of NetWare "Get File Server UTC Time" reply buffer:
Offset	Size	Description	(Table 02489)
 00h	DWORD	seconds
 04h	DWORD	???
 04h	DWORD	??? (00000204h)
 04h	DWORD	??? (00000000h)
 04h	DWORD	??? (00000000h)
 04h	DWORD	??? (FFFFFFFFh)
 04h	DWORD	??? (00000000h)
SeeAlso: #02488
--------N-21F27BSF01-------------------------
INT 21 - Novell NetWare v4+ - GET CACHE INFORMATION
	AX = F27Bh subfn 01h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02490)
	ES:DI -> reply buffer (see #02491)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=02h

Format of NetWare "Get Cache Information" request buffer:
Offset	Size	Description	(Table 02490)
 00h	WORD	0001h (length of following data)
 02h	BYTE	01h (subfunction "Get Cache Information")
SeeAlso: #02491

Format of NetWare "Get Cache Information" reply buffer:
Offset	Size	Description	(Table 02491)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	"readExistingBlockCount"
 0Ch	DWORD	"readExistingWriteWaitCount"
 10h	DWORD	"readExistingPartialReadCount"
 14h	DWORD	"readExistingReadErrorCount"
 18h	DWORD	"writeBlockCount"
 1Ch	DWORD	"writeEntireBlockCount"
 20h	DWORD	"getDiskCount"
 24h	DWORD	"getDiskNeedToAllocCount"
 28h	DWORD	"getDiskSomeoneBeatMeCount"
 2Ch	DWORD	"getDiskPartialReadCount"
 30h	DWORD	"getDiskReadErrorCount"
 34h	DWORD	"getAsyncDiskCount"
 38h	DWORD	"getAsyncDiskNeedToAlloc"
 3Ch	DWORD	"getAsyncDiskSomeoneBeatMe"
 40h	DWORD	"errorDoingAsyncReadCount"
 44h	DWORD	"getDiskNoReadCount"
 48h	DWORD	"getDiskNoReadAllocCount"
 4Ch	DWORD	"getDiskNoReadSomeoneBeatMeCount"
 50h	DWORD	"diskWriteCount"
 54h	DWORD	"diskWriteAllocCount"
 58h	DWORD	"diskWriteSomeoneBeatMeCount"
 5Ch	DWORD	"writeErrorCount"
 60h	DWORD	"waitOnSemaphoreCount"
 64h	DWORD	"allocBlockWaitForSomeoneCount"
 68h	DWORD	"allocBlockCount"
 6Ch	DWORD	"allocBlockWaitCount"
 70h	DWORD	original number of cache buffers
 74h	DWORD	current number of cache buffers
 78h	DWORD	cache dirty-block threshold
 7Ch	DWORD	"waitNodeCount"
 80h	DWORD	"waitNodeAllocFailureCount"
 84h	DWORD	"moveCacheNodeCount"
 88h	DWORD	"moveCacheNodeFromAvailCount"
 8Ch	DWORD	"accelerateCacheNodeWriteCount"
 90h	DWORD	"removeCacheNodeCount"
 94h	DWORD	"removeCacheNodeFromAvailCount"
 98h	DWORD	number of cache checks
 9Ch	DWORD	number of cache hits
 A0h	DWORD	number of dirty-cache checks
 A4h	DWORD	number of dirty-cache hits
 A8h	DWORD	"cacheUsedWhileChecking"
 ACh	DWORD	"waitForDirtyBlocksDecreaseCount"
 B0h	DWORD	"allocBlockFromAvailCount"
 B4h	DWORD	"allocBlockFromLRUCount"
 B8h	DWORD	"allocBlockAlreadyWaiting"
 BCh	DWORD	"LRUSittingTime"
 C0h	DWORD	maximum byte count
 C4h	DWORD	minimum number of cache buffers
 C8h	DWORD	minimum cache report threshold
 D0h	DWORD	"allocWaitingCount"
 D4h	DWORD	number of dirty cache blocks
 D8h	DWORD	"cacheDirtyWaitTime"
 DCh	DWORD	"maxDirtyTime"
 E0h	DWORD	number of directory cache buffers
 E4h	DWORD	"cacheByteToBlockShiftFactor"
SeeAlso: #02490
--------N-21F27BSF02-------------------------
INT 21 - Novell NetWare v4+ - GET SERVER INFORMATION
	AX = F27Bh subfn 02h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02492)
	ES:DI -> reply buffer (see #02493)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=01h

Format of NetWare "Get Server Information" request buffer:
Offset	Size	Description	(Table 02492)
 00h	WORD	0001h (length of following data)
 02h	BYTE	02h (subfunction "Get Server Information")
SeeAlso: #02493

Format of NetWare "Get Server Information" reply buffer:
Offset	Size	Description	(Table 02493)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	current NCP stations in use
 0Ch	DWORD	peak NCP stations in use
 10h	DWORD	total NCP requests
 14h	DWORD	server utilization
 18h	DWORD	number of cancelled replies
 1Ch	DWORD	"writeHeldOffCount"
 20h	DWORD	"writeHeldOffWithDuplicateRequest"
 24h	DWORD	number of invalid request types
 28h	DWORD	"beingAbortedCount"
 2Ch	DWORD	"alreadyDoingReallocCount"
 30h	DWORD	"deAllocInvalidSlotCount"
 34h	DWORD	"deAllocBeingProcessedCount"
 38h	DWORD	"deAllocForgedPacketCount"
 3Ch	DWORD	"startStationErrorCount"
 40h	DWORD	number of invalid slot numbers
 44h	DWORD	"beingProcessedCount"
 48h	DWORD	number of forged packets
 4Ch	DWORD	number still transmitting
 50h	DWORD	"reExecuteRequestCount"
 54h	DWORD	number of invalid sequence numbers
 58h	DWORD	"duplicateIsBeingSentAlreadyCnt"
 5Ch	DWORD	number of positive acknowledgements sent
 60h	DWORD	number of duplicate replies sent
 64h	DWORD	number of times out of memory for station control
 68h	DWORD	number of times out of available connections
 6Ch	DWORD	"reallocSlotCount"
 70h	DWORD	"reallocSlotCameTooSoonCount"
 74h	WORD	number of times maximum hop count exceeded
 76h	WORD	number of unknown networks
 78h	WORD	"NoSpaceForService"
 7Ah	WORD	number of times out of receive buffers
 7Ch	WORD	"notMyNetwork"
 7Eh	DWORD	number of NetBIOS packets propagated
 82h	DWORD	total number of packets serviced
 86h	DWORD	total number of packets routed
SeeAlso: #02492
--------N-21F27BSF04-------------------------
INT 21 - Novell NetWare v4+ - GET USER INFORMATION
	AX = F27Bh subfn 04h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02494)
	ES:DI -> reply buffer (see #02495)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get User Information" request buffer:
Offset	Size	Description	(Table 02494)
 00h	WORD	0005h (length of following data)
 02h	BYTE	04h (subfunction "Get User Information")
 03h	DWORD	connection number
SeeAlso: #02495

Format of NetWare "Get User Information" reply buffer:
Offset	Size	Description	(Table 02495)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	connection number
 0Ch	DWORD	use count
 10h	BYTE	connection service type
 11h  7 BYTEs	login time
 18h	DWORD	status
 1Ch	DWORD	expiration time
 20h	DWORD	object type
 24h	BYTE	transaction flag
 25h	BYTE	logical lock threshold
 26h	BYTE	record lock threshold
 27h	BYTE	file write flags
 28h	BYTE	file write state
 29h	BYTE	(filler)
 2Ah	WORD	file lock count
 2Ch	WORD	record lock count
 2Eh  6 BYTEs	total number of bytes read
 34h  6 BYTEs	total number of bytes written
 3Ah	DWORD	total requests
 3Eh	DWORD	held requests
 42h  6 BYTEs	held bytes read
 48h  6 BYTEs	held bytes written
 4Eh	BYTE	length of user name
 4Fh  N BYTEs	user name
SeeAlso: #02494
--------N-21F27BSF06-------------------------
INT 21 - Novell NetWare v4+ - GET IPX/SPX Information
	AX = F27Bh subfn 06h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02496)
	ES:DI -> reply buffer (see #02497)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get IPX/SPX Information" request buffer:
Offset	Size	Description	(Table 02496)
 00h	WORD	0001h (length of following data)
 02h	BYTE	06h (subfunction "Get IPX/SPX Information")
SeeAlso: #02497

Format of NetWare "Get IPX/SPX Information" reply buffer:
Offset	Size	Description	(Table 02497)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of IPX packets sent
 0Ch	WORD	number of malformed IPX packets
 0Eh	DWORD	number of IPX Get-ECB requests
 12h	DWORD	number of failed IPX Get-ECB requests
 16h	DWORD	number of IPX AES events
 1Ah	WORD	number of postponed IPX AES events
 1Ch	WORD	maximum number of sockets (from configuration)
 1Eh	WORD	maximum number of open sockets
 20h	WORD	number of failed IPX socket opens
 22h	DWORD	number of IPX "listen" ECBs
 24h	WORD	number of failed IPX EBC cancels
 26h	WORD	number of failed IPX Get-Local-Target requests
 28h	WORD	maximum number of SPX connections (from configuration)
 2Ah	WORD	maximum number of SPX connections used
 2Ch	WORD	number of SPX Establish-Connection requests
 2Eh	WORD	number of failed SPX Establish-Connection requests
 30h	WORD	total number of SPX "listen-connect" requests
 32h	WORD	number of failed SPX "listen-connect" requests
 34h	DWORD	number of SPX sends
 38h	DWORD	number of SPX "window-choke"s
 3Ch	WORD	number of bad SPX sends
 3Eh	WORD	number of failed SPX sends
 40h	WORD	number of aborted SPX connections
 42h	DWORD	number of SPX packet listens
 46h	WORD	number of bad SPX packet listens
 48h	DWORD	number of incoming SPX packets
 4Ch	WORD	number of bad incoming SPX packets
 4Eh	WORD	number of supressed SPX packets
 50h	WORD	"SPXNoSesListenECBCount"
 52h	WORD	"SPXWatchDogDestSesCount"
SeeAlso: #02496
--------N-21F27BSF08-------------------------
INT 21 - Novell NetWare v4+ - GET CPU INFORMATION
	AX = F27Bh subfn 08h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02498)
	ES:DI -> reply buffer (see #02499)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get CPU Information" request buffer:
Offset	Size	Description	(Table 02498)
 00h	WORD	0005h (length of following data)
 02h	BYTE	08h (subfunction "Get CPU Information")
 03h	DWORD	CPU number
SeeAlso: #02499

Format of NetWare "Get CPU Information" reply buffer:
Offset	Size	Description	(Table 02499)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of CPUs
 0Ch	DWORD	page table owner flag
 10h	DWORD	CPU type flag
 14h	DWORD	coprocessor flag
 18h	DWORD	bus type flag
 1Ch	DWORD	I/O engine flag
 20h	DWORD	filesystem engine flag
 24h	DWORD	non-dedicated flag
 28h 201 BYTEs	counted string: CPU string;number of coprocessors;bus string
SeeAlso: #02498
--------N-21F27BSF09-------------------------
INT 21 - Novell NetWare v4+ - GET VOLUME SWITCH INFORMATION
	AX = F27Bh subfn 09h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02500)
	ES:DI -> reply buffer (see #02501)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Volume Switch Information" request buffer:
Offset	Size	Description	(Table 02500)
 00h	WORD	0005h (length of following data)
 02h	BYTE	09h (subfunction "Get Volume Switch Information")
 03h	DWORD	starting item number
SeeAlso: #02501

Format of NetWare "Get Volume Switch Information" reply buffer:
Offset	Size	Description	(Table 02501)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	total LFS counters
 0Ch	DWORD	current LFS counters
 10h	DWORD	"readFile"
 14h	DWORD	"writeFile"
 18h	DWORD	"deleteFile"
 1Ch	DWORD	"renMove"
 20h	DWORD	"openFile"
 24h	DWORD	"createFile"
 28h	DWORD	"createAndOpenFile"
 2Ch	DWORD	"closeFile"
 30h	DWORD	"scanDeleteFile"
 34h	DWORD	"salvageFile"
 38h	DWORD	"purgeFile"
 3Ch	DWORD	"migrateFile"
 40h	DWORD	"deMigrateFile"
 44h	DWORD	"createDir"
 48h	DWORD	"deleteDir"
 4Ch	DWORD	"directoryScans"
 50h	DWORD	"mapPathToDirNum"
 54h	DWORD	"modifyDirEntry"
 58h	DWORD	"getAccessRights"
 5Ch	DWORD	"getAccessRightsFromIDs"
 60h	DWORD	"mapDirNumToPath"
 64h	DWORD	"getEntryFromPathStrBase"
 68h	DWORD	"getOtherNSEntry"
 6Ch	DWORD	"getExtDirInfo"
 70h	DWORD	"getParentDirNum"
 74h	DWORD	"addTrusteeR"
 78h	DWORD	"scanTrusteeR"
 7Ch	DWORD	"delTrusteeR"
 80h	DWORD	"purgeTrust"
 84h	DWORD	"findNextTrustRef"
 88h	DWORD	"scanUserRestNodes"
 8Ch	DWORD	"addUserRest"
 90h	DWORD	"deleteUserRest"
 94h	DWORD	"rtnDirSpaceRest"
 98h	DWORD	"getActualAvailDskSp"
 9Ch	DWORD	"cntOwnedFilesAndDirs"
 A0h	DWORD	"migFileInfo"
 A4h	DWORD	"volMigInfo"
 A8h	DWORD	"readMigFileData"
 ACh	DWORD	"getVolusageStats"
 B0h	DWORD	"getActualVolUsageStats"
 B4h	DWORD	"getDirUsageStats"
 B8h	DWORD	"NMFileReadsCount"
 BCh	DWORD	"NMFileWritesCount"
 C0h	DWORD	"mapPathToDirNumOrPhantom"
 C4h	DWORD	"stationsHasAccessRgtsGntedBelow"
 C8h	DWORD	"gtDataSteamLensFromPathStrBase"
 CCh	DWORD	"checkAndGetDirectoryEntry"
 D0h	DWORD	"getDeletedEntry"
 D4h	DWORD	"getOriginalNameSpace"
 D8h	DWORD	"getActualFileSize"
 DCh	DWORD	"verifyNameSpaceNumber"
 E0h	DWORD	"verifyDataStreamNumber"
 E4h	DWORD	"checkVolumeNumber"
 E8h	DWORD	"commitFile"
 ECh	DWORD	"VMGetDirectoryEntry"
 F0h	DWORD	"createDMFileEntry"
 F4h	DWORD	"renameNameSpaceEntry"
 F8h	DWORD	"logFile"
 FCh	DWORD	"releaseFile"
100h	DWORD	"clearFile"
104h	DWORD	"setVolumeFlag"
108h	DWORD	"clearVolumeFlag"
10Ch	DWORD	"getOriginalInfo"
110h	DWORD	"createMigratedDir"
114h	DWORD	"F3OpenCreate"
118h	DWORD	"F3InitFileSearch"
11Ch	DWORD	"F3ContinueFileSearch"
120h	DWORD	"F3RenameFile"
124h	DWORD	"F3ScanForTrustees"
128h	DWORD	"F3ObtainFileInfo"
12Ch	DWORD	"F3ModifyInfo"
130h	DWORD	"F3EraseFile"
134h	DWORD	"F3SetDirHandle"
138h	DWORD	"F3AddTrustees"
13Ch	DWORD	"F3DeleteTrustees"
140h	DWORD	"F3AllocDirHandle"
144h	DWORD	"F3ScanSalvagedFiles"
148h	DWORD	"F3RecoverSalvagedFiles"
14Ch	DWORD	"F3PurgeSalvageableFile"
150h	DWORD	"F3GetNSSpecificInfo"
154h	DWORD	"F3ModifyNSSpecificInfo"
158h	DWORD	"F3SearchSet"
15Ch	DWORD	"F3GetDirBase"
160h	DWORD	"F3QueryNameSpaceInfo"
164h	DWORD	"F3GetNameSpaceList"
168h	DWORD	"F3GetHugeInfo"
16Ch	DWORD	"F3SetHugeInfo"
170h	DWORD	"F3GetFullPathString"
174h	DWORD	"F3GetEffectiveDirectoryRights"
SeeAlso: #02500
--------N-21F27BSF0A-------------------------
INT 21 - Novell NetWare v4+ - GET LOADED NLMs
	AX = F27Bh subfn 0Ah
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02502)
	ES:DI -> reply buffer (see #02503)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get NLMs Loaded" request buffer:
Offset	Size	Description	(Table 02502)
 00h	WORD	0005h (length of following data)
 02h	BYTE	0Ah (subfunction "Get NLMs Loaded")
 03h	DWORD	first NLM number to report
SeeAlso: #02503

Format of NetWare "Get NLMs Loaded" reply buffer:
Offset	Size	Description	(Table 02503)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	total number of NLMs
 0Ch	DWORD	number of NLM numbers following (max 50)
 10h 50 DWORDs	NLM numbers
SeeAlso: #02502
--------N-21F27BSF0B-------------------------
INT 21 - Novell NetWare v4+ - GET NLM INFORMATION
	AX = F27Bh subfn 0Bh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02504)
	ES:DI -> reply buffer (see #02505)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get NLM Information" request buffer:
Offset	Size	Description	(Table 02504)
 00h	WORD	0005h (length of following data)
 02h	BYTE	0Bh (subfunction "Get NLM Information")
 03h	DWORD	NLM number
SeeAlso: #02505

Format of NetWare "Get NLM Information" reply buffer:
Offset	Size	Description	(Table 02505)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	identification number
 0Ch	DWORD	flags
 10h	DWORD	NLM type (see #02506)
 14h	DWORD	parent identifier
 18h	DWORD	major version
 1Ch	DWORD	minor version
 20h	DWORD	revision
 24h	DWORD	year
 28h	DWORD	month
 2Ch	DWORD	day
 30h	DWORD	bytes available for allocation
 34h	DWORD	"allocFreeCount"
 38h	DWORD	last garbage collection
 3Ch	DWORD	message language
 40h	DWORD	number of referenced public identifiers
 44h 200 BYTEs	NLM strings: filename, NLM name, copyright
SeeAlso: #02504

(Table 02506)
Values for NetWare NLM type:
 0001h	LAN
 0002h	DSK
 0003h	NAM
 0004h	utility NLM
 0005h	MSL
 0006h	operating system NLM
 0007h	paged NLM
 0008h	HAM
 0009h	CDM
 000Ah	file system NLM
 000Bh	real mode NLM
 000Ch	hidden NLM
SeeAlso: #02505
--------N-21F27BSF0D-------------------------
INT 21 - Novell NetWare v4+ - GET OS VERSION INFORMATION
	AX = F27Bh subfn 0Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02507)
	ES:DI -> reply buffer (see #02508)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get OS Version Information" request buffer:
Offset	Size	Description	(Table 02507)
 00h	WORD	0001h (length of following data)
 02h	BYTE	0Dh (subfunction "Get OS Version Information")
SeeAlso: #02508

Format of NetWare "Get OS Version Information" reply buffer:
Offset	Size	Description	(Table 02508)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	BYTE	operating system major version
 09h	BYTE	operating system minor version
 0Ah	BYTE	operating system revision number
 0Bh	BYTE	accounting version
 0Ch	BYTE	VAP version
 0Dh	BYTE	queueing version
 0Eh	BYTE	security restrictions level
 0Fh	BYTE	bridging support
 10h	DWORD	maximum number of volumes
 14h	DWORD	number of connection slots
 18h	DWORD	maximum number of logged-in connections
 1Ch	DWORD	maximum number of name spaces
 20h	DWORD	maximum number of LANs
 24h	DWORD	maximum number of media types
 28h	DWORD	maximum number of protocols
 2Ch	DWORD	maximum subdirectory tree depth
 30h	DWORD	maximum number of data streams
 34h	DWORD	maximum number of spooled printers
 38h	DWORD	serial number
 3Ch	WORD	application number
SeeAlso: #02507
--------N-21F27BSF14-------------------------
INT 21 - Novell NetWare v4+ - GET ACTIVE LAN BOARD LIST
	AX = F27Bh subfn 14h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02509)
	ES:DI -> reply buffer (see #02510)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Active LAN Board List" request buffer:
Offset	Size	Description	(Table 02509)
 00h	WORD	0005h (length of following data)
 02h	BYTE	14h (subfunction "Get Active LAN Board List")
 03h	DWORD	start number
SeeAlso: #02510

Format of NetWare "Get Active LAN Board List" reply buffer:
Offset	Size	Description	(Table 02510)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	maximum number of LANs
 0Ch	DWORD	number of LAN board numbers returned
 10h 50 DWORDs	board numbers
SeeAlso: #02509
--------N-21F27BSF15-------------------------
INT 21 - Novell NetWare v4+ - GET LAN CONFIGURATION
	AX = F27Bh subfn 15h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02511)
	ES:DI -> reply buffer (see #02512)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=16h

Format of NetWare "Get LAN Configuration" request buffer:
Offset	Size	Description	(Table 02511)
 00h	WORD	0005h (length of following data)
 02h	BYTE	15h (subfunction "Get LAN Configuration")
 03h	DWORD	LAN board number
SeeAlso: #02512

Format of NetWare "Get LAN Configuration" reply buffer:
Offset	Size	Description	(Table 02512)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	BYTE	driver configuration major version
 09h	BYTE	driver configuration minor version
 0Ah  6 BYTEs	driver node address
 10h	WORD	driver mode flags
 12h	WORD	driver board number
 14h	WORD	driver board instance
 16h	DWORD	driver maximum size
 1Ah	DWORD	driver maximum receive size
 1Eh	DWORD	driver receive size
 22h  3 DWORDs	reserved
 2Eh	WORD	driver card ID
 30h	WORD	driver transport time
 32h	DWORD	driver source routing
 36h	WORD	driver line speed
 38h	WORD	driver reserved
 3Ah	BYTE	driver major version
 3Bh	BYTE	driver minor version
 3Ch	WORD	driver flags
 3Eh	WORD	driver send retries
 40h	DWORD	driver link
 44h	WORD	driver sharing flags
 46h	WORD	driver slot
 48h  4 WORDs	driver I/O port and lengths
 50h	DWORD	driver memory decode 0
 54h	WORD	driver length 0
 56h	DWORD	driver memory decode 1
 5Ah	WORD	driver length 1
 5Ch  2 BYTEs	driver's interrupts
 5Eh  2 BYTEs	driver's DMA usage
 60h 18 BYTEs	driver's logical name
 72h 14 BYTEs	driver I/O reserved
 80h 128 BYTEs	driver card name
100h 40 BYTEs	driver media type
128h 180 BYTEs	driver custom variables
SeeAlso: #02511
--------N-21F27BSF16-------------------------
INT 21 - Novell NetWare v4+ - GET LAN COMMON COUNTERS
	AX = F27Bh subfn 16h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02513)
	ES:DI -> reply buffer (see #02514)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=15h

Format of NetWare "Get LAN Common Counters" request buffer:
Offset	Size	Description	(Table 02513)
 00h	WORD	0009h (length of following data)
 02h	BYTE	16h (subfunction "Get LAN Common Counters")
 03h	DWORD	LAN board number
 07h	DWORD	starting block number (set to 00000000h for first call)
SeeAlso: #02514

Format of NetWare "Get LAN Common Counters" reply buffer:
Offset	Size	Description	(Table 02514)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	BYTE	statistics major version
 09h	BYTE	statistics minor version
 0Ah	DWORD	number of generic counters
 0Eh	DWORD	number of counter blocks
 12h	DWORD	number of custom variables
 16h	DWORD	next counter block number
 1Ah	DWORD	"notSupportedMask"
 1Eh	DWORD	total number of packets tranmitted
 22h	DWORD	total number of packets received
 26h	DWORD	number of times no ECBs were available
 2Ah	DWORD	number of transmitted packets which were too large
 2Eh	DWORD	number of transmitted packets which were too small
 32h	DWORD	number of packet receive overflows
 36h	DWORD	number of received packets which were too large
 3Ah	DWORD	number of received packets which were too small
 3Eh	DWORD	number of miscellaneous transmitted-packet errors
 42h	DWORD	number of miscellaneous received-packet errors
 46h	DWORD	number of times transmission retried
 4Ah	DWORD	number of checksum errors
 4Eh	DWORD	number of hardware receive mismatches
 52h 50 BYTEs	reserved
SeeAlso: #02513
--------N-21F27BSF29-------------------------
INT 21 - Novell NetWare v4+ - GET PROTOCOL STACK BY BOARD
	AX = F27Bh subfn 29h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02515)
	ES:DI -> reply buffer (see #02516)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Protocol Stack by Board" request buffer:
Offset	Size	Description	(Table 02515)
 00h	WORD	0005h (length of following data)
 02h	BYTE	29h (subfunction "Get Protocol Stack by Board")
 03h	DWORD	LAN board number
SeeAlso: #02516

Format of NetWare "Get Protocol Stack by Board" reply buffer:
Offset	Size	Description	(Table 02516)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	WORD	number of stacks listed (max 50)
 0Ah 50 DWORDs	protocol identifiers
SeeAlso: #02515
--------N-21F27BSF33-------------------------
INT 21 - Novell NetWare v4+ - GET ROUTER INFO
	AX = F27Bh subfn 33h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02517)
	ES:DI -> reply buffer (see #02518)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=35h

Format of NetWare "Get Router Info" request buffer:
Offset	Size	Description	(Table 02517)
 00h	WORD	0005h (length of following data)
 02h	BYTE	33h (function "Get Router Info")
 03h	DWORD	network number
SeeAlso: #02518

Format of NetWare "Get Router Info" reply buffer:
Offset	Size	Description	(Table 02518)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	network number
 0Ch	WORD	hops to net
 0Eh	WORD	network status
 10h	WORD	time to net
SeeAlso: #02517,#02519
--------N-21F27BSF35-------------------------
INT 21 - Novell NetWare v4+ - GET KNOWN NETWORKS INFO
	AX = F27Bh subfn 35h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02519)
	ES:DI -> reply buffer (see #02520)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=33h,AX=F27Bh/SF=38h

Format of NetWare "Get Router Info" request buffer:
Offset	Size	Description	(Table 02519)
 00h	WORD	0005h (length of following data)
 02h	BYTE	35h (function "Get Known Networks Info")
 03h	DWORD	start number (00000000h)
SeeAlso: #02520

Format of NetWare "Get Router Info" reply buffer:
Offset	Size	Description	(Table 02520)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of records following (max 20)
 0Ch	var	array of network info records
		Offset	Size	Description
		 00h	WORD	network number
		 04h	WORD	hops to net
		 06h	WORD	network status
		 08h	WORD	time to net
SeeAlso: #02517,#02519
--------N-21F27BSF38-------------------------
INT 21 - Novell NetWare v4+ - GET KNOWN SERVERS INFO
	AX = F27Bh subfn 38h
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02521)
	ES:DI -> reply buffer (see #02522)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled
SeeAlso: AX=F27Bh/SF=35h

Format of NetWare "Get Known Servers" request buffer:
Offset	Size	Description	(Table 02521)
 00h	WORD	0009h (length of following data)
 02h	BYTE	38h (function "Get Known Servers")
 03h	DWORD	start number
 07h	DWORD	server type
SeeAlso: #02522

Format of NetWare "Get Known Servers" reply buffer:
Offset	Size	Description	(Table 02522)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of records following (max 20)
 0Ch	var	server record(s)
		Offset	Size	Description
		 00h	DWORD	network number
		 04h  6 BYTEs	node number
		 0Ah	WORD	socket number
		 0Ch	WORD	hops to server
		 0Eh 48 BYTEs	object name
SeeAlso: #02521
--------N-21F27BSF3C-------------------------
INT 21 - Novell NetWare v4+ - GET SERVER SET COMMANDS INFO
	AX = F27Bh subfn 3Ch
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02523)
	ES:DI -> reply buffer (see #02524)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Server Set Commands Info" request packet:
Offset	Size	Description	(Table 02523)
 00h	WORD	0005h (length of following data)
 02h	BYTE	3Ch (subfunction "Get Server Set Commands Info")
 03h	DWORD	start sequence number
SeeAlso: #02524

Format of NetWare "Get Server Set Commands Info" packet:
Offset	Size	Description	(Table 02524)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of set commands
 0Ch	DWORD	next sequence number
 10h	DWORD	set command type
 14h	DWORD	set command category
 18h	DWORD	set command flags
 1Ch	BYTE	length of set command name
 1Dh  N BYTEs	set command name
	BYTE	number of set command values
      N BYTEs	set command values
SeeAlso: #02523
--------N-21F27BSF3D-------------------------
INT 21 - Novell NetWare v4+ - GET SERVER SET CATEGORIES
	AX = F27Bh subfn 3Dh
	CX = length of request buffer in bytes
	DX = length of reply buffer in bytes
	DS:SI -> request buffer (see #02525)
	ES:DI -> reply buffer (see #02526)
Return: AL = status (see #02860 at INT 2F/AX=7A20h/BX=0000h)
	reply buffer filled

Format of NetWare "Get Server Set Categories" request packet:
Offset	Size	Description	(Table 02525)
 00h	WORD	0005h (length of following data)
 02h	BYTE	3Dh (subfunction "Get Server Set Categories")
 03h	DWORD	start sequence number
SeeAlso: #02526

Format of NetWare "Get Server Set Categories" reply packet:
Offset	Size	Description	(Table 02526)
 00h	DWORD	current server time
 04h	BYTE	vconsole version
 05h	BYTE	vconsole revision
 06h	WORD	reserved
 08h	DWORD	number of set categories
 0Ch	DWORD	next sequence number
 10h	BYTE	length of category name
 11h  N BYTEs	category name
SeeAlso: #02525
--------v-21F2AA-----------------------------
INT 21 - VIRUS - "PcVrsDs" - INSTALLATION CHECK
	AX = F2AAh
Return: AH = AAh if resident
SeeAlso: AH=F1h"VIRUS",AH=F3h"VIRUS"
--------N-21F3-------------------------------
INT 21 - Novell NetWare - FILE SERVICES - FILE SERVER FILE COPY
	AH = F3h
	ES:DI -> request buffer (see #02527)
Return: AL = status/error code
	CX:DX = number of bytes copied
Notes:	this function is supported by Advanced NetWare 2.0+
	both source and destination must be on the same file server
SeeAlso: AH=3Ch,AH=3Fh"DOS"

Format of NetWare "File Server File Copy" request buffer:
Offset	Size	Description	(Table 02527)
 00h	WORD	source file handle (as returned by AH=3Ch or AH=3Dh)
 02h	WORD	destination file handle
 04h	DWORD	starting offset in source
 08h	DWORD	starting offset in destination
 0Ch	DWORD	number of bytes to copy
--------T-21F3-------------------------------
INT 21 - DoubleDOS - ADD CHARACTER TO KEYBOARD BUFFER OF CURRENT JOB
	AH = F3h
	AL = character
Return: AL = 00h successful
	     01h buffer full (128 characters)
SeeAlso: AH=E3h"DoubleDOS",AH=F1h"DoubleDOS",AH=F2h"DoubleDOS"
SeeAlso: AH=F8h"DoubleDOS"
--------v-21F3-------------------------------
INT 21 - VIRUS - "Carfield" - INSTALLATION CHECK
	AH = F3h
Return: AX = 0400h if resident
SeeAlso: AH=D5h"Carfield",AX=F2AAh,AH=F7h"VIRUS"
--------T-21F400-----------------------------
INT 21 - DoubleDOS - INSTALLATION CHECK/PROGRAM STATUS
	AX = F400h
Return: AL = program status
	    00h if DoubleDOS not present
	    01h if running in visible DoubleDOS partition
	    02h if running in the invisible DoubleDOS partition
SeeAlso: AX=E400h,AH=F5h"DoubleDOS"
--------T-21F5-------------------------------
INT 21 - DoubleDOS - OTHER PROGRAM STATUS
	AH = F5h
Return: AL = program status
	    00h no program in other partition
	    01h program in other partition is running
	    02h program in other partition is suspended
SeeAlso: AH=E5h"DoubleDOS",AX=F400h"DoubleDOS"
--------v-21F7-------------------------------
INT 21 - VIRUS - "GP1" - INSTALLATION CHECK
	AH = F7h
Return: AX = 0300h if resident
SeeAlso: AH=F0h"VIRUS",AH=F9h"VIRUS"
--------D-21F8-------------------------------
INT 21 - DOS v2.11-2.13 - SET OEM INT 21 HANDLER
	AH = F8h
	DS:DX -> OEM INT 21 handler for functions F9h to FFh
		 FFFFh:FFFFh disables OEM handler
Notes:	this function is known to be supported by Toshiba T1000 ROM MS-DOS
	  v2.11, Sanyo MS-DOS v2.11, and TI Professional Computer DOS v2.13
	at least potentially this is still available with (OEM versions??? of)
	  MS-DOS 6.0.
	calls to AH=F9h through AH=FFH will return AL=00h if no handler set
	the user handler is called immediately on entry to the main DOS INT 21h
	  function dispatcher with interrupts disabled and all registers and
	  stack exactly as set by caller; it should exit with IRET
SeeAlso: AH=F9h"OEM"
--------T-21F8-------------------------------
INT 21 - DoubleDOS - SET/RESET KEYBOARD CONTROL FLAGS
	AH = F8h
	AL = program for which to set flags
	    00h this program
	    01h other program
	DX = keyboard control flags (see #02088 at AH=E8h"DoubleDOS")
Return: DX = previous flags
Notes:	disabling Ctrl-PrtSc will allow the program to intercept the keystroke;
	  disabling any of the other keystrokes disables them completely
	this function is identical to AH=E8h
SeeAlso: AH=E8h"DoubleDOS",AH=F1h"DoubleDOS",AH=F2h"DoubleDOS"
SeeAlso: AH=F3h"DoubleDOS"
--------D-21F9-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = F9h
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FAh"OEM"
--------T-21F9-------------------------------
INT 21 - DoubleDOS - SET TIMESHARING PRIORITY
	AH = F9h
	AL = priority
	    00h visible program gets 70%, invisible gets 30% (default)
	    01h visible program gets 50%, invisible gets 50%
	    02h visible program gets 30%, invisible gets 70%
	    03h Top program gets 70%, bottom program gets 30%
	    04h Top program gets 30%, bottom program gets 70%
	    05h get current priority
		Return: AL = priority setting
Note:	identical to AH=E9h
SeeAlso: AH=E9h"DoubleDOS",AH=FAh"DoubleDOS",AH=FBh"DoubleDOS"
--------v-21F9-------------------------------
INT 21 - VIRUS - "Satans-Bug" - INSTALLATION CHECK
	AH = F9h
Return: AX = AC0Ah if resident
SeeAlso: AH=F7h"VIRUS",AH=FBh"VIRUS",AX=FEDCh"VIRUS"
--------D-21FA-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FAh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=F9h"OEM",AH=FBh"OEM"
--------T-21FA-------------------------------
INT 21 - DoubleDOS - TURN OFF TASK SWITCHING
	AH = FAh
Return: task switching turned off
SeeAlso: AH=EAh"DoubleDOS",AH=F9h"DoubleDOS",AH=FBh"DoubleDOS"
SeeAlso: INT FA"DoubleDOS"
--------v-21FA-------------------------------
INT 21 - VIRUS - "Cinderella 2" - INSTALLATION CHECK
	AH = FAh
Return: AH = F9h if resident
SeeAlso: AH=F0h"VIRUS",AX=FBA0h"VIRUS"
--------v-21FA--DX5945-----------------------
INT 21 U - PC Tools v7+ VDEFEND, VSAFE, VWATCH - API
	AH = FAh
	DX = 5945h
	AL = function (00h-02h for VDEFEND, 00h-07h for VSAFE and VWATCH)
Return: varies by function
Note:	this API is identical to the API on INT 13/AH=FAh and INT 16/AH=FAh,
	  so it is listed in its entirety only under INT 16/AX=FA00h and
	  following
SeeAlso: INT 13/AX=FA00h,INT 16/AX=FA00h
--------k-21FAFF-----------------------------
INT 21 U - IBM PC-DOS - KEYBGK - SELECT KEYBOARD LAYOUT
	AX = FAFFh
	CL = keyboard layout
	    31h keyboard 319
	    32h keyboard 220
	BX = code page (869 or 813 decimal)
Return: AL = F1h if installed
	DX destroyed
--------D-21FB-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FBh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FAh"OEM",AH=FCh"OEM"
--------T-21FB-------------------------------
INT 21 - DoubleDOS - TURN ON TASK SWITCHING
	AH = FBh
Return: task switching turned on
SeeAlso: AH=EBh"DoubleDOS",AH=F9h"DoubleDOS",AH=FAh"DoubleDOS"
SeeAlso: INT FB"DoubleDOS"
--------v-21FB-------------------------------
INT 21 - VIRUS - "Cinderella" - INSTALLATION CHECK
	AH = FBh
Return: AH = 00h if resident
SeeAlso: AH=F9h"VIRUS",AH=FAh"VIRUS",AX=FB0Ah
--------v-21FB0A-----------------------------
INT 21 - VIRUS - "dBASE" - INSTALLATION CHECK
	AX = FB0Ah
Return: AX = 0AFBh if resident
SeeAlso: AH=FBh"VIRUS",AX=FBA0h"VIRUS",AH=FCh"VIRUS"
--------v-21FBA0-----------------------------
INT 21 - VIRUS - "Groove" - INSTALLATION CHECK
	AX = FBA0h
Return: AX = 0ABFh if resident
SeeAlso: AX=FB0Ah"VIRUS",AX=FBFBh"VIRUS"
--------v-21FBFB-----------------------------
INT 21 - VIRUS - "Dir.1367" - INSTALLATION CHECK
	AX = FBFBh
Return: AX = BFBFh if resident
SeeAlso: AX=FBA0h"VIRUS",AH=FCh"VIRUS"
--------D-21FC-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FCh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FBh"OEM",AH=FDh"OEM"
--------T-21FC-------------------------------
INT 21 - DoubleDOS - GET VIRTUAL SCREEN ADDRESS
	AH = FCh
Return: ES = segment of virtual screen
Desc:	Determine the address of the virtual screen to which the program
	  should write instead of the actual video memory, so that the
	  multitasked programs do not interfere with each other's output.
Notes:	screen address can change if task-switching is on!
	identical to AH=ECh
SeeAlso: AH=ECh"DoubleDOS",INT FC"DoubleDOS"
--------v-21FC-------------------------------
INT 21 - VIRUS - "Troi" - INSTALLATION CHECK
	AH = FCh
Return: AL = A5h if resident
SeeAlso: AX=FBA0h"VIRUS",AX=FC03h"VIRUS",AH=FDh"VIRUS"
--------v-21FC03-----------------------------
INT 21 - VIRUS - "Invisible" - INSTALLATION CHECK
	AX = FC03h
Return: AX = 03FCh if resident
SeeAlso: AH=FCh"VIRUS",AH=FDh"VIRUS"
--------D-21FD-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FDh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FCh"OEM",AH=FEh"OEM"
--------v-21FD-------------------------------
INT 21 - VIRUS - "Border" - INSTALLATION CHECK
	AH = FDh
Return: AH = 13h if resident
SeeAlso: AH=FCh"VIRUS",AX=FDACh"VIRUS",AH=FEh"VIRUS"
--------s-21FD12BX3457-----------------------
INT 21 - Gravis UltraSound - MegaEm/MEGA_EM - INSTALLATION CHECK
	AX = FD12h
	BX = 3457h
Return: AX = 5678h if installed
	BX = 1235h if v1.x or v2.x installed
	    CL = interrupt vector used by MegaEm (default 81h)
	BX = 1237h if v3.x installed
	    CL = interrupt vector used by MegaEm (default 81h)
	    DX = version number
Program: MegaEm is a protected-mode SoundBlaster, SoundCanvas, and MT-32
	  emulator for the Gravis UltraSound
SeeAlso: INT 2F/AX=CD00h/BX=464Fh,INT 7E/AX=00FEh"SBOS",INT 81/AX=0200h
--------v-21FDAC-----------------------------
INT 21 - VIRUS - "Delwin" - INSTALLATION CHECK
	AX = FDACh
Return: AX = 02E3h if resident
SeeAlso: AH=FDh"VIRUS",AH=FEh"VIRUS"
--------D-21FE-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FEh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FDh"OEM",AH=FFh"OEM"
--------T-21FE-------------------------------
INT 21 - DoubleDOS - GIVE AWAY TIME TO OTHER TASKS
	AH = FEh
	AL = number of 55ms time slices to give away
Return: returns after giving away time slices
SeeAlso: AH=EEh"DoubleDOS",INT FE"DoubleDOS"
--------v-21FE-------------------------------
INT 21 - VIRUS - "483" - INSTALLATION CHECK
	AH = FEh
Return: AH = 00h if resident
SeeAlso: AX=FDACh"VIRUS",AX=FE01h
--------v-21FE01-----------------------------
INT 21 - VIRUS - "Flip" - INSTALLATION CHECK
	AX = FE01h
Return: AX = 01FEh if resident
SeeAlso: AH=FEh"VIRUS",AX=FE02h
--------v-21FE02-----------------------------
INT 21 - VIRUS - "2468"/"Tequila" - INSTALLATION CHECK
	AX = FE02h
Return: AX = 01FDh if resident
SeeAlso: AX=FE01h,AX=FE03h,AX=FEDCh"VIRUS"
--------v-21FE03-----------------------------
INT 21 - VIRUS - "2468"/"Tequila" - DISPLAY VIRUS MESSAGE
	AX = FE03h
SeeAlso: AX=FE02h,AX=FEADh
--------v-21FEAD------------------------
INT 21 - VIRUS - "Shifting Objective" - INSTALLATION CHECK
	AX = FEADh
Return: AX = D00Dh if resident
SeeAlso: AX=FE03h,AX=FEDCh"VIRUS"
--------d-21FEDC-----------------------------
INT 21 - PCMag PCMANAGE/DCOMPRES - INSTALLATION CHECK
	AX = FEDCh
Return: AX = CDEFh if installed
Program: the PCMANAGE/DCOMPRES combination from PC Magazine permits
	  infrequently-used files to be compressed to save space and
	  transparently expanded when accessed
SeeAlso: AH=DCh,INT 2D/AL=10h"dLite"
--------v-21FEDC-----------------------------
INT 21 - VIRUS - "Black Monday" - INSTALLATION CHECK
	AX = FEDCh
Return: AL = DCh if resident
SeeAlso: AX=FE02h,AX=FEFEh
--------v-21FEFE-----------------------------
INT 21 - VIRUS - "CIDER" - INSTALLATION CHECK
	AX = FEFEh
Return: SI = 1994h if resident
SeeAlso: AX=FEDCh"VIRUS",AH=FFh"VIRUS"
--------D-21FF-------------------------------
INT 21 - DOS v2.11-2.13 - OEM FUNCTION
	AH = FFh
Return: AL = 00h if no OEM function handler installed (see AH=F8h"OEM")
SeeAlso: AH=F8h"OEM",AH=FEh"OEM"
--------K-21FF-------------------------------
INT 21 - CED (Command EDitor) - INSTALLABLE COMMANDS
	AH = FFh
	AL = subfunction
	    00h add installable command
		BL = mode
		    bit 0 = 1 callable from DOS prompt
		    bit 1 = 1 callable from application
		DS:SI -> CR-terminated command name
		ES:DI -> FAR routine entry point
	    01h remove installable command
		DS:SI -> CR-terminated command name
	    02h reserved, may be used to test for CED installation
Return: CF clear if successful
	CF set on error
	    AX = error code
		01h invalid function
		02h command not found (subfunction 01h only)
		08h insufficient memory (subfunction 00h only)
		0Eh bad data (subfunction 00h only)
	AH = FFh if CED not installed
Program: CED is a shareware DOS command-line enhancer by Christopher J. Dunford
SeeAlso: AX=0A00h
--------E-21FF-------------------------------
INT 21 - DJ GO32.EXE 80386+ DOS extender - DOS EXTENSIONS
	AH = FFh
	AL = function
	    01h create file
	    02h open file
	    03h get file statistics
	    04h get time of day
	    05h set time of day
	    06h stat
	    07h system
Program: GO32.EXE is a DOS extender included as part of the 80386 port of the
	  GNU C/C++ compiler by DJ Delorie and distributed as DJGPP
SeeAlso: INT 10/AH=FFh"GO32"
--------K-21FF-------------------------------
INT 21 - DOSED.COM - INSTALLATION CHECK
	AH = FFh
	DS:SI -> "DOSED"
	ES = 0000h
Return: ES:DI -> "DOSED" if installed
Program: DOSED is a free DOS commandline editor/history buffer by Sverre H.
	  Huseby
--------v-21FF-------------------------------
INT 21 - VIRUS - "Sunday", "Tumen 0.5", "Hero" - INSTALLATION CHECK
	AH = FFh
Return: AH = 00h if "Tumen 0.5" or "Hero" resident
	AX = 0400h if "Sunday" resident
SeeAlso: AX=FEDCh"VIRUS",AX=FF01h"VIRUS"
--------E-21FF-------------------------------
INT 21 UP - Rational Systems DOS/4GW - API
	AH = FFh
	DH = function (00h-17h) (also see separate entries below)
	DL = subfunction or argument
Return: CF clear if valid function number
	    AX = status???
	CF set if invalid function
SeeAlso: INT 15/AX=BFDCh
--------E-21FF--DH00-------------------------
INT 21 UP - Rational Systems DOS/4GW - GET VERSION???
	AH = FFh
	DH = 00h
	DL = ??? (78h seen)
Return: CF clear
	EAX = 4734FFFFh (high word is byte-swapped "4G") if DOS/4G installed
Note:	Quarterdeck's DESQview/X X Toolkit library uses this call to determine
	  whether the direct-mapped linear 4GB segment's selector is 34h or 38h
SeeAlso: INT 21/AH=FFh/DH=00h"DOS/4GW"
--------E-21FF--DH02-------------------------
INT 21 UP - Rational Systems DOS/4GW - SET ???
	AH = FFh
	DH = 02h
	DL = ???
Return: CF clear
--------E-21FF--DH05-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 05h
	BX = ???
Return: ???
--------E-21FF--DH06-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 06h
	BX = ???
Return: ???
--------E-21FF--DH07-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 07h
	BX = ???
Return: ???
--------E-21FF--DH08-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 08h
	BX = ???
	CX = ???
	ES = ???
Return: ???
--------E-21FF--DH09-------------------------
INT 21 UP - Rational Systems DOS/4GW - GET ???
	AH = FFh
	DH = 09h
Return: ES:BX -> ???
--------E-21FF--DH0A-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Ah
	AL = ???
	BX = ???
	CX = ???
Return: ES = ??? or 0000h
--------E-21FF--DH0B-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Bh
	AL = ???
	BX = ???
	CX = ???
Return: ???
--------E-21FF--DH0C-------------------------
INT 21 UP - Rational Systems DOS/4GW - GET/SET ???
	AH = FFh
	DH = 0Ch
	DL = ??? (00h or 01h)
Return: CF clear if successful
	    AL = previous value of ???
	CF set on error (DL out of range)
	    AX = FFFFh
--------E-21FF--DH0D-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Dh
	???
Return: ???
--------E-21FF--DH0E-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Eh
Return: DX:AX -> XBRK structure (see #00508 at INT 15/AX=BF02h)
	BX = ???
	CX = ???
SeeAlso: INT 15/AX=BF02h
--------E-21FF--DH0F-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 0Fh
	???
Return: ???
--------E-21FF--DH10-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 10h
	AL = ???
	BX = ???
	CX = ???
	DI = ???
	SI = ???
Return: ???
Note:	among other things, frees two memory blocks via INT 21/AH=49h
--------E-21FF--DH11-------------------------
INT 21 UP - Rational Systems DOS/4GW - NOP
	AH = FFh
	DH = 11h
--------E-21FF--DH12-------------------------
INT 21 UP - Rational Systems DOS/4GW - EXCHANGE ??? POINTERS
	AH = FFh
	DH = 12h
	DS:SI -> new ???
	ES:DI -> new ???
Return: DS:SI -> previous ???
	ES:DI -> previous ???
--------E-21FF--DH13-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 13h
	AL = ???
	ES = ???
Return: ???
--------E-21FF--DH14-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 14h
	BX = ???
	CX = ???
Return: CF clear
	    AX = ???
	    DX = ???
--------E-21FF--DH15-------------------------
INT 21 UP - Rational Systems DOS/4GW - GET ??? FUNCTIONS
	AH = FFh
	DH = 15h
Return: CF clear
	    DX:AX -> FAR function for ???
	    CX:BX -> FAR function for ???
	    SI:DI -> FAR function for ???
--------E-21FF--DH16-------------------------
INT 21 UP - Rational Systems DOS/4GW - GET ???
	AH = FFh
	DH = 16h
Return: AX = ???
--------E-21FF--DH17-------------------------
INT 21 UP - Rational Systems DOS/4GW - ???
	AH = FFh
	DH = 17h
	AL = ???
	DL = ???
Return: ???
--------N-21FF00-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET SYSTEM INFORMATION
	AX = FF00h
	CL = what to get
	    00h user information (see #02528)
	    01h drive mapping (see #02529)
	    02h printer server(s)
	    05h local DOS drive number
Return: ES:BX -> desired information
Program: TopWare Network Operating System is manufactured by Grand Computer
	  Company
Note:	this call is only supported on Workstations, not on the server
SeeAlso: AX=FF04h,INT 2F/AX=FF00h

Format of TopWare user information:
Offset	Size	Description	(Table 02528)
 00h	BYTE	node ID
 01h 15 BYTEs	user name
 10h	WORD	user number
 12h	BYTE	group number

Format of TopWare drive mapping [array]:
Offset	Size	Description	(Table 02529)
 00h	BYTE	bits 6-0: drive number (1=A:, etc.)
		bit 7: this is a server drive
 01h  3 BYTEs	mapping drive (for example, "C:\")
 04h 64 BYTEs	current directory
--------E-21FF00DX0078-----------------------
INT 21 - Rational Systems DOS/4G - INSTALLATION CHECK
	AX = FF00h
	DX = 0078h
Return: AL <> 00h if installed
	    GS = segment of kernel if nonzero
SeeAlso: INT 15/AX=BF02h
--------v-21FF01-----------------------------
INT 21 - VIRUS - "Drop" - INSTALLATION CHECK
	AX = FF01h
Return: AX = 01FFh if resident
SeeAlso: AH=FEh"VIRUS",AX=FF0Fh"FLU_SHOT"
--------N-21FF04-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET/SET DEFAULT FILE PROTECTION ATTRIBS
	AX = FF04h
	CL = function
	    00h get protections
		Return: BH = read attribute
			BL = write attribute
	    01h set protections
		BH = read attribute
		BL = write attribute
Note:	this function is supported only on Workstations, not on the server
SeeAlso: AX=FF00h"TopWare"
--------v-21FF0F-----------------------------
INT 21 - FLU_SHOT+ v1.83 - INSTALLATION CHECK
	AX = FF0Fh
Return: AX = 0101h if resident
Program: FLU_SHOT+ is an antivirus/antitrojan program by Ross M. Greenberg and
	  Software Concepts Design
Note:	the "PSQR/1720" virus calls this function to determine whether
	  FLU_SHOT+ is present
SeeAlso: AH=FFh"VIRUS",AX=FF10h"VIRUS"
--------v-21FF10-----------------------------
INT 21 - VIRUS - "Twins" - INSTALLATION CHECK
	AX = FF10h
Return: AL = 07h if resident
SeeAlso: AX=FF0Fh,AX=FFFEh
--------N-21FF80DHFF-------------------------
INT 21 - TopWare Network OS v5.10+ - SEND MESSAGE
	AX = FF80h
	DH = FFh
	DL = destination address (FFh for broadcast)
	CX = message length (max 2000)
	DS:SI -> message to be sent (see #02530)
Return: nothing
Program: TopWare Network Operating System is manufactured by Grand Computer
	  Company
Notes:	this function is supported on both Workstations and the server
	there is no guarantee that the message will be received correctly, or
	  at all, by the destination

Format of TopWare message:
Offset	Size	Description	(Table 02530)
 00h	BYTE	type code
		07h TopSend
		11h user application
		other reserved for TopWare
 01h	var	data
Note:	sending messages with a type code other than 11h will cause
	  unpredictable results
--------N-21FF82-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET STATION ADDRESS
	AX = FF82h
Return: AL = station address
Note:	this function is supported on both Workstations and the server
SeeAlso: AX=FF91h
--------N-21FF8C-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET STATUS OF TopShow/Emulated FUNCTION
	AX = FF8Ch
	BL = subfunction
	    00h get TopShow status
	    FFh get Emulated status
Return: AL = status
	    00h not installed
	    01h already installed
--------N-21FF8D-----------------------------
INT 21 - TopWare Network OS v5.10+ - CALL TopShow FUNCTION
	AX = FF8Dh
	CH = monochrome flag (01h monochrome, 00h not monochrome)
	CL = screen mode of station to be viewed (see #02531)
	BL = graphic page number for monochrome
Return: AL = status (00h successful, else failed)
SeeAlso: AX=FF8Eh,AX=FFCFh

(Table 02531)
Values for TopWare screen mode:
 00h	text mode
 01h	720x348
 02h	640x408
 03h	720x352
 04h	640x390
 05h	reserved
--------N-21FF8E-----------------------------
INT 21 - TopWare Network OS v5.10+ - CANCEL TopShow FUNCTION
	AX = FF8Eh
Return: AL = 00h (successful, TopShow removed)
SeeAlso: AX=FF8Dh
--------N-21FF91-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET FILE SERVER STATION NUMBER
	AX = FF91h
Return: AL = station number of file server
SeeAlso: AX=FF82h
--------N-21FF97-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET MAXIMUM STATION NUMBER (server only)
	AX = FF97h
Return: AL = maximum station number
SeeAlso: AX=FF98h
--------N-21FF98-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET MAXIMUM FILE NUMBER (server only)
	AX = FF98h
Return: AL = maximum file
SeeAlso: AX=FF97h
--------N-21FF9A-----------------------------
INT 21 - TopWare Network OS v5.10+ - RECEIVE OF USER-DEFINED PACKETS
	AX = FF9Ah
	ES:BX -> buffer for user-defined packet (see #02532)
Return: nothing

Format of TopWare user-defined packet:
Offset	Size	Description	(Table 02532)
 00h	BYTE	FFh
 01h	WORD	(call) length of data field plus 3
		(ret) length of received message (0000h if none received)
 03h	BYTE	destination ID (FFh for broadcast message)
 04h	BYTE	sending station ID
 05h	BYTE	type code (11h; all other codes reserved for TopWare)
 06h  N BYTEs	received message
--------N-21FF9F-----------------------------
INT 21 - TopWare Network OS v5.10+ - ENABLE/DISABLE TopTerm SERVICE
	AX = FF9Fh
	CL = new state (00h disable [disregard TopTerm packets], 01h enable)
Return: AL = status (00h successful, FFh failed)
Note:	this function is only supported by Workstations, not the server
--------N-21FFB0-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET SPOOLER PRINTING PRIORITY
	AX = FFB0h
Return: AL = priority status (see #02533)
SeeAlso: AX=FFB1h

Bitfields for TopWare printer priority status:
Bit(s)	Description	(Table 02533)
 2	LPT3 has high priority
 1	LPT2 has high priority
 0	LPT1 has high priority
--------N-21FFB1-----------------------------
INT 21 - TopWare Network OS v5.10+ - SET SPOOLER PRINTING PRIORITY
	AX = FFB1h
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	CH = new priority (00h normal, 01h high)
Return: nothing
SeeAlso: AX=FFB0h
--------N-21FFB3-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET DEFAULT START-OF-JOB FORMFEED STATUS
	AX = FFB3h
Return: AL = starting formfeed status (see #02534)
SeeAlso: AX=FFB4h,AX=FFC0h

Bitfields for TopWare printer start-of-job formfeed status:
Bit(s)	Description	(Table 02534)
 2	LPT3 has formfeed enabled
 1	LPT2 has formfeed enabled
 0	LPT1 has formfeed enabled
--------N-21FFB4-----------------------------
INT 21 - TopWare Network OS v5.10+ - SET DEFAULT START-OF-JOB FORMFEED STATUS
	AX = FFB4h
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	CH = new formfeed status (00h off, 01h on)
Return: nothing
SeeAlso: AX=FFB3h,AX=FFC1h
--------N-21FFBB-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET PRINTER SERVER STATION ADDRESS
	AX = FFBBh
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
Return: AL = current mapping printer server station number
	    00h if local
SeeAlso: AX=FFBCh
--------N-21FFBC-----------------------------
INT 21 - TopWare Network OS v5.10+ - CANCEL TopShow FUNCTION
	AX = FFBCh
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	CL = printer server station address or 00h for local printer
Return: AL = status (00h successful, else failed)
SeeAlso: AX=FFBBh
--------N-21FFBD-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET CURRENT AUTOPRINT TIME
	AX = FFBDh
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
Return: AX = current AutoPrint timeout in clock ticks
SeeAlso: AX=FFBEh
--------N-21FFBE-----------------------------
INT 21 - TopWare Network OS v5.10+ - SET AUTOPRINT TIME
	AX = FFBEh
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	BX = timeout in clock ticks
SeeAlso: AX=FFBDh
--------N-21FFBF-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET LOGON USER INFORMATION
	AX = FFBFh
	DX:BX -> buffer for logon information (see #02535)
Return: AL = status (00h successful, else failed)
	AH = number of logged-in stations

Format of TopWare logon information:
Offset	Size	Description	(Table 02535)
 00h	BYTE	station address
 01h 15 BYTEs	username
--------N-21FFC0-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET DEFAULT END-OF-JOB FORMFEED STATUS
	AX = FFC0h
Return: AL = ending formfeed status (see #02536)
SeeAlso: AX=FFB3h,AX=FFC1h

Bitfields for TopWare printer end-of-job formfeed status:
Bit(s)	Description	(Table 02536)
 2	LPT3 has formfeed enabled
 1	LPT2 has formfeed enabled
 0	LPT1 has formfeed enabled
--------N-21FFC1-----------------------------
INT 21 - TopWare Network OS v5.10+ - SET DEFAULT END-OF-JOB FORMFEED STATUS
	AX = FFC1h
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	CH = new formfeed status (00h off, 01h on)
Return: nothing
SeeAlso: AX=FFB4h,AX=FFC0h
--------N-21FFC2-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET DEFAULT COPIES OF SPOOLING FILE
	AX = FFC2h
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
Return: AL = default number of copies printed
SeeAlso: AX=FFC7h
--------N-21FFC3-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET SHARING STATUS OF PRINTER SERVER
	AX = FFC3h
Return: AL = sharing status of printers (see #02537)
	    FFh if not a printer server

Bitfields for TopWare printer sharing status:
Bit(s)	Description	(Table 02537)
 2	LPT3 is shared
 1	LPT2 is shared
 0	LPT1 is shared
--------N-21FFC4-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET/SET LPT PORT ON PRINT SERVER
	AX = FFC4h
	BL = subfunction
	    00h get
		Return: AL = mapped printer port on print server
	    01h set
		CL = network printer port (00h LPT1, 01h LPT2, 02h LPT3)
	CH = local printer (00h LPT1, 01h LPT2, 02h LPT3)
--------N-21FFC6-----------------------------
INT 21 - TopWare Network OS v5.10+ - SET DEFAULT PRINT FILE HEADER
	AX = FFC6h
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	CL = header state (00h off, 01h on)
SeeAlso: AX=FFC8h
--------N-21FFC7-----------------------------
INT 21 - TopWare Network OS v5.10+ - SET DEFAULT PRINT COPIES
	AX = FFC7h
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	CL = new default number of copies to print
SeeAlso: AX=FFC2h
--------N-21FFC8-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET DEFAULT PRINT FILE HEADER STATUS
	AX = FFC8h
Return: AL = header status for printers (see #02538)
SeeAlso: AX=FFC6h

Bitfields for TopWare print header status:
Bit(s)	Description	(Table 02538)
 2	LPT3 has headers enabled
 1	LPT2 has headers enabled
 0	LPT1 has headers enabled
--------N-21FFC9-----------------------------
INT 21 - TopWare Network OS v5.10+ - SET PRINTER SHARING
	AX = FFC9h
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	CL = new sharing state (00h off, 01h on)
Return: AL = status (00h successful, FFh not printer server)
--------N-21FFCA-----------------------------
INT 21 - TopWare Network OS v5.10+ - MOVE FILE FROM ONE PRINT SERVER TO ANOTHER
	AX = FFCAh
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	CL = original printer server station address
	BL = target printer server station address
	DS:DX -> filename (12 bytes)
Return: AL = status (00h successful, else failed)
SeeAlso: AX=FFCBh
--------N-21FFCB-----------------------------
INT 21 - TopWare Network OS v5.10+ - DELETE FILE FROM SPOOLING QUEUE
	AX = FFCBh
	CH = printer number (00h LPT1, 01h LPT2, 02h LPT3)
	CL = printer server station address
	DS:DX -> filename (12 bytes)
Return: AL = status (00h successful, else failed)
SeeAlso: AX=FFCAh
--------N-21FFCC-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET PRINT SERVER'S SPOOLING QUEUE STATUS
	AX = FFCCh
	CL = printer server station address
	BH = start item number of spooling file for print server
	BL = number of the item to be retrieved
	DS:DX -> buffer for queued file information (see #02539)
Return: AL = status
	    00h successful
		AH = number of spool files
		DS:DX buffer filled
	    nonzero failed

Format of TopWare queued file information buffer [16-item array, one element]:
Offset	Size	Description	(Table 02539)
 00h 12 BYTEs	filename
 0Ch	DWORD	size
 10h	WORD	date
 12h	WORD	time
 14h 15 BYTEs	username
 23h	BYTE	count
 24h	BYTE	flag: header
 25h	BYTE	print number
--------N-21FFCD-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET STATUS OF ALL PRINT SERVERS
	AX = FFCDh
	DS:DX -> buffer for server status (see #02540)
Return: AL = status
	    00h successful
		AH = number of print servers
	    nonzero failed

Format of TopWare server status:
Offset	Size	Description	(Table 02540)
 00h	BYTE	station address
 01h 15 BYTEs	username
 10h	BYTE	flag: 01h printer is shared, 00h sharing disabled
 11h	BYTE	number of files pending in queue
--------N-21FFCF-----------------------------
INT 21 - TopWare Network OS v5.10+ - CALL TopLook FUNCTION
	AX = FFCFh
	DH = page number (0-2, 2 is text mode)
	DL = type
	    00h look at specific screen
	    01h AutoLook on
	    FFh AutoLook off
	BH = station number wishing to look
	BL = station number to be looked at
	CH = monochrome flag (01h monochrome, 00h not monochrome)
	CL = screen mode (see #02531)
Return: AL = status (00h successful, nonzero failed)
SeeAlso: AX=FF8Dh
--------N-21FFD6-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET KEYCARD SERIAL NUMBER AND MAX USERS
	AX = FFD6h
	ES:BX -> 12-byte buffer for keycard serial number
Return: CX = maximum number of users
	ES:BX buffer filled
--------N-21FFD7-----------------------------
INT 21 - TopWare Network OS v5.10+ - GET NETWORK PROTECTION ATTRIBUTES STATUS
	AX = FFD7h
Return: AL = status (00h disabled, 01h enabled)
--------N-21FFE3DL00-------------------------
INT 21 - TopWare Network OS v5.10+ - INITIATE ACCESS TO SPECIFIC PACKET TYPE
	AX = FFE3h
	DL = 00h
	BX = packet type for Ethernet header (IP = 0800h, ARP = 0806h, etc.)
	ES:DI -> receive routine (see #02542)
Return: CF clear if successful
	    AX = handle number
	CF set on error
	    DH = error code (03h,05h,09h,0Ah,11h) (see #02541)
SeeAlso: AX=FFE3h/DL=01h

(Table 02541)
Values for TopWare error code:
 01h	invalid handle
 03h	no interfaces of the specified type found
 05h	bad packet type
 09h	insufficient space
 0Ah	type already being accessed
 0Ch	unable to send packet (usually hardware error)
 11h	invalid function

(Table 02542)
Values TopWare receive routine is called with:
	AX = function
	    0000h request packet buffer
		CX = packet size
		Return: ES:DI -> buffer or 0000h:0000h to discard packet
	    0001h packet copied
		CX = packet size
		DS:SI -> copied packet (same as returned ES:DI above)
--------N-21FFE3DL01-------------------------
INT 21 - TopWare Network OS v5.10+ - END ACCESS TO SPECIFIC PACKET TYPE
	AX = FFE3h
	DL = 01h
	BX = handle returned by AX=FFE3h/DL=00h
Return: CF clear if successful
	CF set on error
	    DH = error code (01h,11h) (see #02541)
Note:	the specified access handle will no longer be valid after this call
SeeAlso: AX=FFE3h/DL=00h
--------N-21FFE3DL02-------------------------
INT 21 - TopWare Network OS v5.10+ - SEND PACKET
	AX = FFE3h
	DL = 02h
	CX = length of data buffer
	DS:SI -> buffer containing data
Return: CF clear if successful
	CF set on error
	    DH = error code (0Ch,11h) (see #02541)
--------N-21FFE3DL03-------------------------
INT 21 - TopWare Network OS v5.10+ - GET LOCAL NETWORK INTERFACE ADDRESS
	AX = FFE3h
	DL = 03h
	ES:DI -> 6-byte buffer for address
SeeAlso: AX=FFE3h/DL=00h
--------v-21FFFE-----------------------------
INT 21 - VIRUS - "08/15"/"Many Fingers" - INSTALLATION CHECK
	AX = FFFEh
Return: AX = 0815h if resident
SeeAlso: AX=FF10h,AX=FFFEh/BX=0000h
--------v-21FFFEBX0000-----------------------
INT 21 - VIRUS - "Anti-Thunderbyte/LEMMING" - INSTALLATION CHECK
	AX = FFFEh
	BX = 0000h
Return: BX = FFFFh if resident
SeeAlso: AX=FFFEh,AX=FFFFh
--------v-21FFFF-----------------------------
INT 21 - VIRUS - "Ontario", "Year 1992"/"B1M92" - INSTALLATION CHECK
	AX = FFFFh
Return: AX = 0000h if "Ontario" resident
	AX = 1992h if "Year 1992"/"B1M92" resident
SeeAlso: AX=FF0Fh,AX=FFFFh/CX=0000h,INT 6B"VIRUS"
--------v-21FFFFCX0000-----------------------
INT 21 - VIRUS - "Revenge" - INSTALLATION CHECK
	AX = FFFFh
	CX = 0000h
Return: CX = 0006h if resident
SeeAlso: AX=FFFFh,INT 6B"VIRUS"
--------D-22---------------------------------
INT 22 - DOS 1+ - PROGRAM TERMINATION ADDRESS
Desc:	this vector specifies the address of the routine which is to be given
	  control after a program is terminated; it should never be called
	  directly, since it does not point at an interrupt handler
Notes:	this vector is restored from the DWORD at offset 0Ah in the PSP during
	  termination, and then a FAR JMP is performed to the address in INT 22
	normally points at the instruction immediately following INT 21/AH=4Bh
	  call which loaded the current program
SeeAlso: INT 20,INT 21/AH=00h,INT 21/AH=31h,INT 21/AH=4Ch
--------G-22---------------------------------
INT 22 - COMTROL HOSTESS i/ISA DEBUGGER - CHANGE FIRMWARE DEBUGGING PORT
	AL = new firmware debugging port
Return: ???
SeeAlso: INT 21"COMTROL",INT 23"COMTROL"
--------D-23---------------------------------
INT 23 - DOS 1+ - CONTROL-C/CONTROL-BREAK HANDLER
---DOS 1.x---
Return: AH = 00h abort program
	if all registers preserved, restart DOS call
---DOS 2+---
	CF clear
Return: all registers preserved
	return via RETF with CF set or (MS-DOS 1,DR DOS) RETF 2 with CF set
	    DOS will abort program with errorlevel 0
	else (RETF/RETF 2 with CF clear or IRET with CF ignored)
	    interrupted DOS call is restarted
Notes:	this interrupt is invoked whenever DOS detects a ^C or ^Break; it
	  should never be called directly
	MS-DOS 1.25 also invokes INT 23 on a divide overflow (INT 00)
	MS-DOS remembers the stack pointer before calling INT 23, and if it is
	  not the same on return, pops and discards the top word; this is what
	  permits a return with RETF as well as IRET or RETF 2
	MS-DOS 2.1+ ignores the returned CF if SP is the same on return as it
	  was when DOS called INT 23, so RETF 2 will not terminate the program
	Novell DOS 7 always pops a word if CF is set on return, so one should
	  not return with RETF 2 and CF set or IRET with the stored flags' CF
	  set
	any DOS call may safely be made within the INT 23 handler, although
	  the handler must check for a recursive invocation if it does
	  call DOS
SeeAlso: INT 1B,INT 21/AH=92h"PTS-DOS"
--------G-23---------------------------------
INT 23 - COMTROL HOSTESS i/ISA DEBUGGER - GET CONFIGURATION INFORMATION
	AL = query type
	    00h get old config map
		Return: AX = old config map
	    01h get dual-ported RAM map
		Return: BX:AX = dual-ported RAM map
	    02h get SCC port map
		Return: BX:AX = SCC port map
SeeAlso: INT 22"COMTROL",INT 26"COMTROL"
--------D-24---------------------------------
INT 24 C - DOS 1+ - CRITICAL ERROR HANDLER
Notes:	invoked when a critical (usually hardware) error is encountered by DOS
	  (see #02543); should never be called directly
	when DOS terminates a program, it copies the previous value of the
	  INT 24 vector out of the PSP (see #01378) and into the interrupt
	  vector table
SeeAlso: INT 21/AH=95h,INT 21/AH=59h/BX=0000h,INT 21/AH=92h"PTS-DOS"

(Table 02543)
Values critical error handler is called with:
	AH = type and processing flags (see #02544)
	AL = drive number if AH bit 7 clear
	BP:SI -> device driver header (see #01646 at INT 21/AH=52h)
		(BP:[SI+4] bit 15 set if character device)
	DI low byte contains error code if AH bit 7 set (see #02545)
	STACK:	DWORD	return address for INT 24 call
		WORD	flags pushed by INT 24
		WORD	original AX on entry to INT 21
		WORD	BX
		WORD	CX
		WORD	DX
		WORD	SI
		WORD	DI
		WORD	BP
		WORD	DS
		WORD	ES
		DWORD	return address for INT 21 call
		WORD	flags pushed by INT 21
Return: AL = action code (see #02546)
	SS,SP,DS,ES,BX,CX,DX preserved
Notes:	the only DOS calls the handler may make are INT 21/AH=01h-0Ch,30h,59h
	if the handler returns to the application by popping the stack, DOS
	  will be in an unstable state until the first call with AH > 0Ch
	for DOS 3.1+, IGNORE (AL=00h) is turned into FAIL (AL=03h) on network
	  critical errors
	if IGNORE specified but not allowed, it is turned into FAIL
	if RETRY specified but not allowed, it is turned into FAIL
	if FAIL specified but not allowed, it is turned into ABORT
	(DOS 3.0+) if a critical error occurs inside the critical error
	  handler, the DOS call is automatically failed (AL set to 03h and
	  the INT 24 call skipped)
	The initial critical error handler is located in the kernel and
	  always results in FAIL. However, by default it is replaced by
	  the critical error handler in the command interpreter when it
	  loads. This can be suppressed (e.g. for BBS systems) by loading
	  the primary DOS 3.00+ COMMAND.COM shell with the undocumented
	  option /F 'Fail'. This syntax is also supported with PTS/DOS 6.51+,
	  S/DOS 1.0+, and DR-OpenDOS 7.02+ (1997-11-13) COMMAND.COM, as well
	  as 4DOS.COM/NDOS.COM.	 OpenDOS 7.01+ COMMAND.COM (1997-03-21)
	  introduced this under /N, which is still supported by newer releases
	  (although it has a slightly different meaning now).
BUG:	DR DOS COMMAND.COM before 1998-05-07 caused incorrect error messages
	  to occur if the error code had a non-zero MSB (e.g. NWCDEX's
	  "IO error reading from device" instead of the correct
	  "not ready error").  This was fixed with the DR-OpenDOS 7.03
	  COMMAND.COM now passing the full error code to any critical error
	  handlers.

Bitfields for critical error type and processing flags:
Bit(s)	Description	(Table 02544)
 7	class
	=0  disk I/O error
	=1  -- if block device, bad FAT image in memory
	    -- if char device, error code in DI
 6	unused
 5	Ignore allowed (DOS 3.0+)
 4	Retry allowed (DOS 3.0+)
 3	Fail allowed (DOS 3.0+)
 2-1	disk area of error
	00 = DOS area	01 = FAT
	10 = root dir	11 = data area
 0	set if write, clear if read
Note:	Abort is always allowed
SeeAlso: #02545,#02546

(Table 02545)
Values for critical error code:
 00h   (0)  write-protection violation attempted
 01h   (1)  unknown unit for driver
 02h   (2)  drive not ready
 03h   (3)  unknown command given to driver
 04h   (4)  data error (bad CRC)
 05h   (5)  bad device driver request structure length
 06h   (6)  seek error
 07h   (7)  unknown media type (non-DOS disk)
 08h   (8)  sector not found
 09h   (9)  printer out of paper
 0Ah  (10)  write fault
 0Bh  (11)  read fault
 0Ch  (12)  general failure
 0Dh  (13)  (DOS 3.0+, "multitasking" DOS, PTS-DOS & S/DOS) sharing violation
 0Eh  (14)  (DOS 3.0+) lock violation
 0Fh  (15)  invalid disk change / wrong disk
 10h  (16)  (DOS 3.0+) FCB unavailable
 10h  (16)  uncertain media
 11h  (17)  (DOS 3.0+) sharing buffer overflow
 11h  (17)  character call interrupted
 12h  (18)  (DOS 4.0+) code page mismatch
 13h  (19)  (DOS 4.0+) out of input
 14h  (20)  (DOS 4.0+) insufficient disk space
Note:	Critical error codes 00h..0Ch are the traditional codes reported
	  through INT 24.  These code assignments are mapped to error codes
	  13h..1Fh reported by INT21/AH=59h (see #01680).  Similarly, the
	  DOS 3.x critical error codes 0Dh..11h are mapped to INT21/AH=59h
	  error codes 20h..24h, however, the DOS 4.0+ critical error codes are
	  not mapped.
BUG:	Paragon Technology Systems' S/DOS 1.0 sources (a stripped down issue
	  of PTS-DOS 6.51 with sources on CD) erroneously list DOS INT 24
	  error	codes 12h..14h as 11h..13h, however, since the sources do not
	  make use of these defines, this seems to be only a documentation
	  error.
SeeAlso: #02544,#02546,#01680

(Table 02546)
Values for critical error handler action code:
 00h	ignore error and continue processing request
 01h	retry operation
 02h	terminate program as though INT 21/AH=4Ch called (INT 20h for DOS 1.x)
 03h	fail system call in progress (DOS 3+)
SeeAlso: #02544,#02546
--------D-25---------------------------------
INT 25 - DOS 1+ - ABSOLUTE DISK READ (except partitions > 32M)
	AL = drive number (00h = A:, 01h = B:, etc)
	CX = number of sectors to read (not FFFFh)
	DX = starting logical sector number (0000h - highest sector on drive)
	DS:BX -> buffer for data
Return: CF clear if successful
	CF set on error
	    AH = status (see #02547)
	    AL = error code (same as passed to INT 24 in DI)
	    AX = 0207h if more than 64K sectors on drive -- use new-style call
	may destroy all other registers except segment registers
Notes:	original flags are left on stack, and must be popped by caller
	this call bypasses the DOS filesystem
	examination of CPWIN386.CPL indicates that if this call fails with
	  error 0408h on an old-style (<32M) call, one should retry the
	  call with the high bit of the drive number in AL set
	Novell DOS 7 decides whether the old-style or new-style (>32M) version
	  of INT 25 must be used solely on the basis of the partition's size,
	  thus forcing use of the new-style call even for data in the first
	  32M of the partition
	PC Tools MIRROR as shipped with MS-DOS 5.0+ checks several signatures
	  at the beginning of INT 25h and INT 26h before it starts to patch
	  these vectors. The signatures it looks for are 83h, F9h, FFh, 74h
	  (CMP CX,-01; JZ ????) at offset +1 from the INT 25h/26h entry points
	  and 2Eh, FFh, 2Eh (JMP DWORD PTR CS:[????]) at the location pointed
	  to by the JZ ????. If it finds these signatures it will use the
	  target address of the far jump for its sub-sequent checks, otherwise
	  it will just take the previous interrupt entry points when scanning
	  for FAh, 2Eh, 8Ch, 16h (CLI; MOV CS:????,SS) or FAh, 2Eh, 89h, 26h
	  (CLI; MOV CS:????,SP) right at the beginning. Hence, it seems the
	  first two checks are to trace through a specific INT 25h/26h
	  filter. However, the purpose of the whole patch is unknown.
	A method to detect the actual assignments of logical drive numbers
	 to physical BIOS drive units (for example to detect the boot drive),
	 is to temporarily mount an INT 13h handler recording the used DL
	 drive unit for any INT 13/AH=02h read operations and discarding any
	 attempts to access actual floppy drives.  Then call INT 25h for
	 all the appropriate DOS drives and watch the results recorded by
	 the INT 13h interceptor.
	Although all registers except segment registers may be destroyed
	 some software depends on some of the registers being preserved.
	 For example some Flash disk drivers requires that DX is not trashed.
	 DR-DOS 7.03 takes care of this.
BUGS:	DOS 3.1 through 3.3 set the word at ES:[BP+1Eh] to FFFFh if AL is an
	  invalid drive number
	DR DOS 3.41 will return with a jump instead of RETF, leaving the
	  wrong number of bytes on the stack; use the huge-partition version
	  (INT 25/CX=FFFFh) for all partition sizes under DR DOS 3.41
	DR DOS 6.0 original issues 05/1991 & 08/1991 reported wrong error
	  codes for "drive not ready" and "write protect". This was fixed
	  with the DR DOS BDOS patch "PAT321" (1992/02/19, XDIR /C: 947Bh),
	  and later "full" rebuilds (see INT 21/AX=4452h for details).
SeeAlso: INT 13/AH=02h,INT 25/CX=FFFFh,INT 26,INT 21/AX=7305h,INT 21/AH=90h"PTS"

(Table 02547)
Values for disk I/O status:
 80h	device failed to respond (timeout)
 40h	seek operation failed
 20h	controller failed
 10h	data error (bad CRC)
 08h	DMA failure
 04h	requested sector not found
 03h	write-protected disk (INT 26 only)
 02h	bad address mark
 01h	bad command
--------D-25----CXFFFF-----------------------
INT 25 - DOS 3.31+ - ABSOLUTE DISK READ (32M-2047M hard-disk partition)
	CX = FFFFh
	AL = drive number (0=A, 1=B, etc)
	DS:BX -> disk read packet (see #02548)
Return: CF clear if successful
	CF set on error
	    AH = status (see #02547)
	    AL = error code (same as passed to INT 24 in DI)
	    AX = 0207h for FAT32 drive -- use INT 21/AX=7305h
	may destroy all other registers except segment registers; Win9X always
	  sets SI to 0000h due to an apparent coding bug
Notes:	partition is potentially >32M (and requires this form of the call) if
	  bit 1 of the device attribute word in the device driver is set
	original flags are left on stack, and must be removed by caller
	this call bypasses the DOS filesystem
	for FAT32 drives (which may be up to 2TB in size), use INT 21/AX=7305h
SeeAlso: INT 13/AH=02h,INT 25,INT 26/CX=FFFFh,INT 21/AX=7305h

Format of disk read packet:
Offset	Size	Description	(Table 02548)
 00h	DWORD	sector number
 04h	WORD	number of sectors to read
 06h	DWORD	transfer address
SeeAlso: #02552
--------k-25CDCD-----------------------------
INT 25 - Stacker - GET DEVICE DRIVER ADDRESS
	AX = CDCDh
	DS:BX -> buffer for address (see #02549)
	CX = 0001h
	DX = 0000h
Return: AX = CDCDh if Stacker installed
	    DS:BX buffer filled
Note:	not supported by Stacker Anywhere; to obtain the Stacker device
	  driver address and to detect drives controlled by all versions
	  of Stacker, INT 21/AX=4404h"Stacker" or lookup via the CDS and DPB
	  should be preferred (see INT 21/AH=52h)
	Stacker Anywhere does not link its built-in device driver into
	  the standard device driver chain, but it can be found via CDS/DPB
SeeAlso: INT 21/AX=4404h"Stacker"

Format of Stacker v2+ driver address buffer:
Offset	Size	Description	(Table 02549)
 00h	WORD	signature CDCDh
 02h	WORD	??? 0001h
 04h	DWORD	pointer to Stacker signature at device driver offset 1Ah
		  (see #02550)

Format of Stacker v2+ device driver:
Offset	Size	Description	(Table 02550)
 00h	DWORD	pointer to next driver, offset=FFFFh if last driver
		FFFFh:FFFFh for Stacker Anywhere
 04h	WORD	device attributes (see #01647,#01648)
 06h	WORD	device strategy entry point
 08h	WORD	device interrupt entry point
 0Ah	BYTE	number of subunits (drives) supported by driver
		0 for Stacker Anywhere
 0Bh  7 BYTEs	signature "STAC-CD" for Stacker and Stacker Anywhere
 12h  7 BYTEs	???
 19h	BYTE	always = 01h ?? (Stacker Anywhere points here)
 1Ah	WORD	signature A55Ah (all other Stacker versions point here)
 1Ch	WORD	Stacker version * 64h
		0C8h = 200, 012Ch = 300, 0190h = 400 (also Stacker Anywhere)
 1Eh	WORD	offset of volume-specific information offset table
		(list of WORDs, one per drive, containing offsets to various
		  information)
 20h 56 BYTEs	n/a
 58h	BYTE	volume number, set after INT 21/AX=4404h, INT 21/AX=4408h
		(use to index into volume-specific info offset table,
		should be set to FFh before and tested for change after)
 59h 19 BYTEs	n/a
 6Ch  4 BYTEs	ASCII string "SWAP"
 70h 26 BYTEs	drive mapping table (one byte for each drive A: through Z:)
		(only used for drives swapped by SSWAP.COM; other drives
		compressed by Stacker can be found with the standard device
		driver header signature (see INT 21/AH=52h)
---Stacker 4, Stacker Anywhere---
 8Ah 40	BYTEs	???
 B2h  4 BYTEs	ASCII string "SWP2"
 B6h 26 BYTEs	drive table ???
 D0h 150 BYTEs	???
166h 60 BYTEs	LZSINFO structure (see #02808 at INT 2F/AX=4A12h)
SeeAlso: #02551,#01646 at INT 21/AH=52h

Format of Stacker boot record:
Offset	Size	Description	(Table 02551)
1F0h  8 BYTEs	Stacker signature (first byte is CDh)
1F8h	DWORD	pointer to start of Stacker device driver
1FCh	WORD	Stacker volume number
1FEh	WORD	???
SeeAlso: #02550
--------c-25--FFSI4358-----------------------
INT 25 - PC-CACHE.SYS - INSTALLATION CHECK
	AL = FFh
	SI = 4358h
Return: SI = 6378h if installed
	    CX = segment of device driver PC-CACHE.SYS
	    DX = version (major in DH, minor in DL)
Program: PC-CACHE.SYS is a small device driver used by PC-Cache v5.x to obtain
	  access to certain disk drivers for devices such as Bernoulli drives
SeeAlso: INT 13/AH=A0h
--------!---Section--------------------------
