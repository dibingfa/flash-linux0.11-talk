Ports List, part 2 of 3
Copyright (c) 1989-1999,2000 Ralf Brown
----------P0140014F--------------------------
PORT 0140-014F - SCSI (alternate Small Computer System Interface) adapter
Note:	first adapter is at 0340-034F
----------P0140014F--------------------------
PORT 0140-014F - Xirlink/Relialogic XL-220/221 SCSI adapter
Range:	alternate address at 0150, 0160, 0170
Notes:	XL-220/221 are based on LOGIC Devices L53C80JC4 SCSI controller which
	  is compatible with Symbios Logic (formaerly NCR) 53C80
	each SCSI data pin is inverted and compared with correcponding bit
	  in the ID select register; if any matches are found while a bus free
	  condition exists and SEL is active, SCSI controller will genarate an
	  interrupt to indicate a selection or reselection
	pseudo-DMA register is provided by some on-card PLM, and decodes any
	  address in the range 01x8-01xF; it should be accessed with 16-bit
	  I/O instructions only causing 2 SCSI REQ/ACK hanshakes (8-bit I/O
	  is treated as 16-bit, and second byte is lost); delayed assertion of
	  the REQ signal or bus free condition on the SCSI bus causes the
	  pseudo-DMA register to prolong ISA I/O cycle not asserting IOCHRDY
	  signal (SCSI phase mismatch doesn't), and so may cause ISA bus to
	  hang in not ready state!
	SCSI BIOS is an 8K ROM located at C8000-CBFFF if I/O port range
	  0140-014F is selected, at CC000-CFFFF if I/O port range 0150-015F
	  is selected, at D8000-DBFFF if I/O port range 0160-016F is selected,
	  and at DC000-DFFFF if I/O port range 0170-017F is selected

0140  R-  current SCSI data bus register
0140  -W  output data register
0141  RW  initiator command register (see #P0496)
0142  RW  mode register (see #P0497)
0143  RW  target command register (see #P0498)
0144  R-  current SCSI control register (see #P0499)
0144  -W  ID select register
0145  R-  DMA status register (see #P0500)
0145  -W  start DMA send register
	  any write starts DMA send
0146  R-  input data register
	  temporarily holds data byte received from the SCSI bus in DMA mode
0146  -W  start DMA target receive register
	  any write starts target mode DMA receive
0147  R-  reset error/interrupt register
	  any read resets the interrupt request latch and the error latches
0147  -W  start DMA initiator mode receive register
	  any write starts initiator mode DMA receive
0148w RW  pseudo-DMA register

Bitfields for initiator command register:
Bit(s)	Description	(Table P0496)
 7	assert RST
 6	(read) arbitration in progress
	(write) test mode
 5	(read) lost arbitration
 4	assert ACK
 3	assert BSY
 2	assert SEL
 1	assert ATN
 0	assert data bus
SeeAlso: #P0497,#P0498,#P0499,#P0500

Bitfields for mode register:
Bit(s)	Description	(Table P0497)
 7	block mode
 6	target mode
 5	enable parity check
 4	enable parity interrupt
 3	enable end of DMA interrupt
 2	monitor BSY
 1	DMA mode
 0	arbitrate
SeeAlso: #P0496

Bitfields for target command register:
Bit(s)	Description	(Table P0498)
 7	(read) last byte sent
 6-4	reserved
 3	assert REQ
 2	assert MSG
 1	assert C/D
 0	assert I/O
SeeAlso: #P0496

Bitfields for current SCSI control register:
Bit(s)	Description	(Table P0499)
 7	RST
 6	BSY
 5	REQ
 4	MSG
 3	C/D
 2	I/O
 1	SEL
 0	parity
SeeAlso: #P0496

Bitfields for DMA status register:
Bit(s)	Description	(Table P0500)
 7	end of DMA
 6	DMA request
 5	parity error
 4	interrupt request
 3	phase match
 2	BSY error
 1	ATN
 0	ACK
SeeAlso: #P0496
----------P0140014F--------------------------
PORT 0140-014F - Future Domain TMC-16x0 SCSI adapter
Range:	alternate address at 0150, 0160, 0170
Notes:	TMC-1650/1670 have a 25-pin external connector, whereas the 1660 and
	  1680 have a SCSI-2 50-pin high-density external connector
	TMC-1670/1680 have floppy disk controller built in
	BIOS versions prior to 3.2 assigned SCSI ID 6 to SCSI adapter,
	  versions 3.2 and greater use SCSI ID 7
	the drive ordering implemented in BIOS versions 3.4 and 3.5 is the
	  opposite of the order (currently) used by the rest of the SCSI
	  industry--for example, under DOS SCSI ID 0 will be D: and SCSI ID 1
	  will be C:
	Future Domain TMC-16x0 SCSI adapter series are based upon Future Domain
	  TMC-1800/18C50/18C30 SCSI controllers
	TMC-1800/18C50/18C30 are ISA SCSI controllers, TMC-36C70 is a PCI
	  version of TMC-18C30
	TMC-1800/18C50 have 8K FIFO, TMC-18C30/36C70 have 2K FIFO
	Future Domain TMC-1650/1660/1670/1680/1610M/1610MER/1610MEX SCSI
	  adapters are based on TMC-1800/18C50/18C30
	Quantum ISA-200S/250MG SCSI adapters are based on TMC-18C50 (?)
	Future Domain TMC-3260 and Adaptec AHA-2920 PCI SCSI adapters are
	  based on TMC-36C70

0140  R-  read SCSI data register
0140  -W  write SCSI data register
0141  R-  SCSI status register (see #P0501)
0141  -W  SCSI control register (see #P0502)
0142  R-  TMC status register (see #P0503)
0142  -W  interrupt control register (see #P0504)
0143  R-  FIFO status register, TMC-18C50/18C30/36C70 chips only
0143  -W  SCSI mode control register (see #P0505)
0144  R-  interrupt condition register, TMC-18C50/18C30/36C70 only (see #P0506)
0144  -W  TMC control register (see #P0507)
0145  R-  ID code LSB register
	  27h for TMC-1800 chip
	  E9h for TMC-18C50/18C30/36C70 chips
0145  -W  memory control register, TMC-18C50/18C30/36C70 only
0146  R-  ID code MSB register
	  60h for TMC-18C50/18C30 chips
	  61h for TMC-1800 chip
0147  R-  read loopback register
0147  -W  write loopback register
0148  RW  SCSI data no ACK register
0149  R-  interrupt status register (see #P0508)
014A  R-  configuration register 1 (see #P0509)
014B  R-  configuration register 2, TMC-18C50/18C30/36C70 only (see #P0510)
014B  -W  I/O control register, TMC-18C30/36C70 only (see #P0511)
014Cw R-  read FIFO data register
014Cw -W  write FIFO data register
014Ew R-  FIFO data count register
Notes:	any value written into the write loopback register can be read back
	  from the read loopback register unchanged (this is used by the BIOS
	  to test the controller)
	reading from read SCSI data register and writing to write SCSI data
	  register causes REQ/ACK handshake to occur automatically, reading
	  and writing the SCSI data no ACK register doesn't
	SCSI FIFO may be used only for DATA IN / DATA OUT phase transfers on
	  TMC-1800; on TMC-18C50/18C30 it may also be used for COMMAND phase
	  transfers

Bitfields for SCSI status register:
Bit(s)	Description	(Table P0501)
 7	not BSY
 6	not MSG
 5	not I/O
 4	not C/D
 3	not REQ
 2	not SEL
 1	parity error???
 0	not ATN
SeeAlso: #P0502,#P0511

Bitfields for SCSI control register:
Bit(s)	Description	(Table P0502)
 7	RST
 6	SEL
 5	BSY
 4	ATN
 3	I/O
 2	C/D
 1	MSG
 0	bus enable
SeeAlso: #P0501,#P0503,#P0504

Bitfields for TMC status register:
Bit(s)	Description	(Table P0503)
 7	bus enabled
 6	parity enabled
 5	FIFO enabled
 4	=1 data are expected to flow out from FIFO to SCSI bus
	=0 data are expected to flow from SCSI bus into FIFO
 3	SCSI reset
 2	???
 1	arbitration complete
 0	interrupt request
SeeAlso: #P0502

Bitfields for interrupt control register:
Bit(s)	Description	(Table P0504)
 7	enable interrupt on REQ
 6	enable interrupt on SEL
 5	enable arbitration interrupt
 4	enable interrupt on ???
 0-3	FIFO threshold (how many 512 byte blocks in FIFO should be
	  full/empty for interrupt to be generated)
SeeAlso: #P0502

Bitfields for SCSI mode control register:
Bit(s)	Description	(Table P0505)
 7	synchronous mode
 6	fast SCSI
 5-4	reserved?
 3-0	synchronous transfer period in 25 ns units
SeeAlso: #P0502

Bitfields for interrupt condition register:
Bit(s)	Description	(Table P0506)
 7	FIFO error interrupt
 6	forced interrupt???
 5	interrupt on RST
 4	arbitration interrupt
 3	interrupt on SEL
 2	interrupt on REQ
 1	interrupt on ???
 0	???
SeeAlso: #P0502

Bitfields for TMC control register:
Bit(s)	Description	(Table P0507)
 7	enable FIFO
 6	=1 data are expected to flow out from FIFO to SCSI bus
	=0 data are expected to flow from SCSI bus into FIFO
 5	clear forced interrupt, TMC-18C50/18C30/36C70 only
 4	enable interrupt
 3	enable parity
 2	arbitrate
 1	force interrupt???
 0	clear SCSI reset flag???
SeeAlso: #P0502
Note:	on the TMC-1800 the FIFO must be enabled and bit 6 must be set
	  according to the expected data direction before a data phase will
	  occur (the TMC-1800 probably doesn't generate interrupts on REQ in
	  DATA IN / DATA OUT phases); on the TMC-18C50/18C30 it may be done
	  when the interrupt on REQ occurs and the SCSI phase is
	  DATA IN, DATA OUT or COMMAND

Bitfields for interrupt status register:
Bit(s)	Description	(Table P0508)
 7	interrupt on REQ enabled
 6	interrupt on SEL enabled
 5	arbitration interrupt enabled
 4	interrupt on ??? enabled
 3	interrupt enabled
 2	???
 1	always set???
 0	???
SeeAlso: #P0502

Bitfields for configuration register 1:
Bit(s)	Description	(Table P0509)
 7-6	BIOS address range
	00 C8000h-C9FFFh
	01 CA000h-CBFFFh
	10 CE000h-CFFFFh
	11 DE000h-DFFFFh
 5-4	I/O address range
	00 140h-14Fh
	01 150h-15Fh
	10 160h-16Fh
	11 170h-17Fh
 3-1	interrupt select
	000 IRQ3
	001 IRQ5
	010 IRQ10
	011 IRQ11
	100 IRQ12
	101 IRQ14
	110 IRQ15
	111 no IRQ
 0	reserved???
Note:	the seven on-board configuration jumpers are read through this register
SeeAlso: #P0502,#P0510

Bitfields for configuration register 2:
Bit(s)	Description	(Table P0510)
 7	32-bit mode enabled (TMC-18C30/36C70 only???)
 6-2	???
 1	RAM disabled (TMC-18C30/36C70 only???)
 0	???
Note:	256 byte on-chip RAM is mapped at offset 1F00h within the BIOS segment
SeeAlso: #P0502,#P0509

Bitfields for TMC control register:
Bit(s)	Description	(Table P0511)
 7	enable 32-bit mode
 6-0	???
SeeAlso: #P0502
--------d-P0140014F--------------------------
PORT 0140-014F - Quantum ISA-200S/250MG SCSI adapter
Range:	alternate address at 0150, 0160, 0170
Note:	Quantum ISA-200S/250MG SCSI adapters are based upon Future Domain
	  TMC-18C50 SCSI controller (???)
SeeAlso: PORT 0140h-014Fh"Future Domain TMC-16x0"
----------P01400157--------------------------
PORT 0140-0157 - RTC (alternate Real Time Clock for XT)	 (1st at 0340-0357)
--------d-P0140015F--------------------------
PORT 0140-015F -  Adaptec AHA-152x SCSI adapter
Range:	alternate address at 0340
----------P0150015F--------------------------
PORT 0150-015F - Xirlink/Relialogic XL-220/221 SCSI adapter
Range:	alternate address at 0140, 0160, 0170
----------P0150015F--------------------------
PORT 0150-015F - Future Domain TMC-16x0 SCSI adapter
Range:	alternate address at 0140, 0160, 0170
--------d-P0150015F--------------------------
PORT 0150-015F - Quantum ISA-200S/250MG SCSI adapter
Range:	alternate address at 0140, 0160, 0170
Note:	Quantum ISA-200S/250MG SCSI adapters are based upon Future Domain
	  TMC-18C50 SCSI controller (???)
SeeAlso: PORT 0140h-014Fh"Future Domain TMC-16x0"
----------P015C015D--------------------------
PORT 015C-015D - Dell Enhanced Parallel Port
SeeAlso: PORT 002Eh,PORT 026Eh,PORT 0398h

015C  -W  index for data port
015D  RW  EPP command data
----------P015F------------------------------
PORT 015F - ARTEC Handyscanner A400Z.  alternate address at 35F.
----------P0160016F--------------------------
PORT 0160-016F - Xirlink/Relialogic XL-220/221 SCSI adapter
Range:	alternate address at 0140, 0150, 0170
----------P0160016F--------------------------
PORT 0160-016F - Future Domain TMC-16x0 SCSI adapter
Range:	alternate address at 0140, 0150, 0170
--------d-P0160016F--------------------------
PORT 0160-016F - Quantum ISA-200S/250MG SCSI adapter
Range:	alternate address at 0140, 0150, 0170
Note:	Quantum ISA-200S/250MG SCSI adapters are based upon Future Domain
	  TMC-18C50 SCSI controller (???)
SeeAlso: PORT 0140h-014Fh"Future Domain TMC-16x0"
----------P0168016F--------------------------
PORT 0168-016F - 4th (Quaternary) EIDE Controller
Range:	01F0-01F7 for primary controller, 0170-0177 for secondary controller
SeeAlso: PORT 0170h-0177h,PORT 01E8h-01EFh,PORT 01F0h-01F7h
----------P01700176--------------------------
PORT 0170-0176 - OPTi "Vendetta" (82C750) CHIPSET - SECONDARY IDE CONTROLLER
Note:	to unlock access to these ports, you must perform two immediately
	  successive 16-bit INs from PORT 0171h, followed by 8-bit OUT of 03h
	  to PORT 172h
SeeAlso: PORT 01F0h"Vendetta"

0170  RW  read cycle timing register (see #P0536)
0171  RW  write cycle timing register (see #P0537)
0172  RW  internal ID register (see #P0538)
0173  RW  control register (see #P0539)
0175  RW  strap register (see #P0540)
0176  RW  miscellaneous register (see #P0541)
----------P01700177--------------------------
PORT 0170-0177 - HDC 2	(2nd Fixed Disk Controller) (ISA, EISA)
Range:	01F0-01F7 for primary controller, 0170-0177 for secondary controller
SeeAlso: PORT 0168h-016Fh,PORT 01E8h-01EFh,PORT 01F0h-01F7h
----------P0170017F--------------------------
PORT 0170-017F - Xirlink/Relialogic XL-220/221 SCSI adapter
Range:	alternate address at 0140, 0150, 0160
----------P0170017F--------------------------
PORT 0170-017F - Future Domain TMC-16x0 SCSI adapter
Range:	alternate address at 0140, 0150, 0160
--------d-P0170017F--------------------------
PORT 0170-017F - Quantum ISA-200S/250MG SCSI adapter
Range:	alternate address at 0140, 0150, 0160
Note:	Quantum ISA-200S/250MG SCSI adapters are based upon Future Domain
	  TMC-18C50 SCSI controller (???)
SeeAlso: PORT 0140h-014Fh"Future Domain TMC-16x0"
----------P01780179--------------------------
PORT 0178-0179 - Power Management
SeeAlso: PORT 0026h,#P0377

0178  -W  index selection for data port
0179  RW  power management data
----------P0178017F--------------------------
PORT 0178-017F - PC radio by CoZet Info Systems
Range:	The I/O address range is dipswitch selectable from:
	   038-03F and 0B0-0BF
	   078-07F and 0F0-0FF
	   138-13F and 1B0-1BF
	   178-17F and 1F0-1FF
	   238-23F and 2B0-2BF
	   278-27F and 2F0-2FF
	   338-33F and 3B0-3BF
	   378-37F and 3F0-3FF
Notes:	All of these addresses show a readout of FFh in initial state.
	Once started, all of the addresses show	FBh, whatever might happen.
----------P01CE01CF--------------------------
PORT 01CE-01CF - ATI Mach32 video chipset - ???

01CE  -W  index register
01CF  RW  data register
----------P01E801EF--------------------------
PORT 01E8-01EF - Headland HL21 & Acer M5105 chipsets - SYSTEM CONTROL

01ED  RW  select internal register. Data to/from 01EF
01EE  R-  ???
01EF  RW  register value
	05h  = 1000xxxx for low CPU clock speed (4MHz on Morse/Mitac)
	     = 0xxxxxxx for high CPU clock speed (16MHz on Morse/Mitac)
	10h memory size
	   bits 2-0 = size
		   (undefined,512K,640K,1024K,2560K,2048K,4096K,undef.)
	14h ???
	   bit 2: 384K RAM of first 1024K relocated to top of memory
----------P01E801EF--------------------------
PORT 01E8-01EF - 3rd (Tertiary) EIDE Controller
Range:	01F0-01F7 for primary controller, 0170-0177 for secondary controller
SeeAlso: PORT 0168h-016Fh,PORT 0170h-0177h,PORT 01F0h-01F7h
----------P01F001F7--------------------------
PORT 01F0-01F7 - HDC 1	(1st Fixed Disk Controller) (ISA, EISA)
Range:	01F0-01F7 for primary controller, 0170-0177 for secondary controller
SeeAlso: PORT 0170h-0177h,PORT 3510h-3513h

01F0  RW  data register
01F1  R-  error register (see #P0512)
01F1  -W  WPC/4	 (Write Precompensation Cylinder divided by 4)
01F2  RW  sector count
01F3  RW  sector number (CHS mode)
	  logical block address, bits 0-7 (LBA mode)
01F4  RW  cylinder low (CHS mode)
	  logical block address, bits 15-8 (LBA mode)
01F5  RW  cylinder high (CHS mode)
	  logical block address, bits 23-16 (LBA mode)
01F6  RW  drive/head (see #P0513)
01F7  R-  status register (see #P0514)
01F7  -W  command register (see #P0515)

Bitfields for Hard Disk Controller error register:
Bit(s)	Description	(Table P0512)
---diagnostic mode errors---
 7	which drive failed (0 = master, 1 = slave)
 6-3	reserved
 2-0	error code
	001	no error detected
	010	formatter device error
	011	sector buffer error
	100	ECC circuitry error
	101	controlling microprocessor error
---operation mode---
 7	bad block detected
 6	uncorrectable ECC error
 5	reserved
 4	ID found
 3	reserved
 2	command aborted prematurely
 1	track 000 not found
 0	DAM not found (always 0 for CP-3022)
SeeAlso: #P0513,#P0514

Bitfields for hard disk controller drive/head specifier:
Bit(s)	Description	(Table P0513)
 7	=1
 6	LBA mode enabled, rather than default CHS mode
 5	=1
 4	drive select (0 = drive 0, 1 = drive 1)
 3-0	head select bits (CHS mode)
	logical block address, bits 27-24 (LBA mode)
SeeAlso: #P0512,#P0514

Bitfields for hard disk controller status register:
Bit(s)	Description	(Table P0514)
 7	controller is executing a command
 6	drive is ready
 5	write fault
 4	seek complete
 3	sector buffer requires servicing
 2	disk data read successfully corrected
 1	index - set to 1 each disk revolution
 0	previous command ended in an error
SeeAlso: #P0512,#P0515

(Table P0515)
Values for hard disk controller command codes:
Command	 Spec	Type	Proto	Description			class:
 00h		opt	nondata	NOP
 08h				device reset
 1xh		opt	nondata	recalibrate			  1
 20h		req	PIOin	read sectors with retry		  1
 21h		req	PIOin	read sectors without retry	  1
 22h		req	PIOin	read long with retry		  1
 23h		req	PIOin	read long without retry		  1
 30h		req	PIOout	write sectors with retry	  2
 31h		req	PIOout	write sectors without retry	  2
 32h		req	PIOout	write long with retry		  2
 33h		req	PIOout	write long without retry	  2
 3Ch	 IDE	opt	PIOout	write verify			  3
 40h		req	nondata	read verify sectors with retry	  1
 41h		req	nondata	read verify sectors without retry 1
 50h		req	vend	format track			  2
 7xh		req	nondata	seek				  1
 8xh	 IDE	vendor	vend	vendor unique 3
 90h		req	nondata	execute drive diagnostics	  1
 91h		req	nondata	initialize drive parameters	  1
 92h		opt	PIOout	download microcode
 94h E0h IDE	opt	nondata	standby immediate		  1
 95h E1h IDE	opt	nondata	idle immediate			  1
 96h E2h IDE	opt	nondata	standby				  1
 97h E3h IDE	opt	nondata	idle				  1
 98h E5h IDE	opt	nondata	check power mode		  1
 99h E6h IDE	opt	nondata	set sleep mode			  1
 9Ah	 IDE	vendor	vend	vendor unique 1
 A0h	 ATAPI			packet command
 A1h	 ATAPI	opt	PIOin	ATAPI Identify			(see #P0524)
 B0h	 SMART	opt		Self Mon., Analysis, Rept. Tech. (see #P0527)
 C0h-C3h IDE	vendor	vend	vendor unique 2
 C4h	 IDE	opt	PIOin	read multiple			  1
 C5h	 IDE	opt	PIOout	write multiple			  3
 C6h	 IDE	opt	nondata	set multiple mode		  1
 C7h	 ATA-4			Read DMA O/Q
 C8h	 IDE	opt	DMA	read DMA with retry		  1
 C9h	 IDE	opt	DMA	read DMA without retry		  1
 CAh	 IDE	opt	DMA	write DMA with retry		  3
 CBh	 IDE	opt	DMA	write DMA w/out retry		  3
 CCh	 ATA-4			Write DMA O/Q
 DAh				get media status
 DBh	 ATA-2	opt	vend	acknowledge media chng		[Removable]
 DCh	 ATA-2	opt	vend	Boot / Post-Boot		[Removable]
 DDh	 ATA-2	opt	vend	Boot / Pre-Boot	(ATA-2)		[Removable]
 DEh	 ATA-2	opt	vend	door lock			[Removable]
 DFh	 ATA-2	opt	vend	door unlock			[Removable]
 E0h-E3h			(second half of commands 94h-96h)
 E4h	 IDE	opt	PIOin	read buffer			  1
 E5h-E6h			(second half of commands 98h-99h)
 E8h	 IDE	opt	PIOout	write buffer			  2
 E9h	 IDE	opt	PIOout	write same			  3
 EAh	 ATA-3	opt		Secure Disable			[Security Mode]
 EAh	 ATA-3	opt		Secure Lock			[Security Mode]
 EAh	 ATA-3	opt		Secure State			[Security Mode]
 EAh	 ATA-3	opt		Secure Enable WriteProt		[Security Mode]
 EBh	 ATA-3	opt		Secure Enable			[Security Mode]
 EBh	 ATA-3	opt		Secure Unlock			[Security Mode]
 ECh	 IDE	req	PIOin	identify drive			  1 (see #P0516)
 EDh	 ATA-2	opt	nondata	media eject			[Removable]
 EEh	 ATA-3	opt		identify device DMA		    (see #P0516)
 EFh	 IDE	opt	nondata	set features			  1 (see #P0535)
 F0h-F4h IDE		vend	EATA standard
 F1h				Security Set Password
 F2h				Security Unlock
 F3h				Security Erase Prepare
 F4h				Security Erase Unit
 F5h-FFh IDE	vendor	vend	vendor unique 4
 F5h				Security Freeze Lock
 F6h				Security Disable Password
SeeAlso: #P0512,#P0514

Format of IDE/ATA Identify Drive information:
Offset	Size	Description	(Table P0516)
 00h	WORD	general configuration (see #P0517)
 02h	WORD	number of logical cylinders
 04h	WORD	reserved
 06h	WORD	number of logical heads
 08h	WORD	vendor-specific (obsolete: unformatted bytes per track)
 0Ah	WORD	vendor-specific (obsolete: unformatted bytes per sector)
 0Ch	WORD	number of logical sectors
 0Eh	WORD	vendor-specific
 10h	WORD	vendor-specific
 12h	WORD	vendor-specific
 14h 10 WORDs	serial number
		no serial number if first word is 0000h
		else blank-padded ASCII serial number
 28h	WORD	vendor-specific
		[buffer type: 01h single-sector, 02h multisector,
		  03h multisector with read cache]
 2Ah	WORD	controller buffer size in 512-byte sectors
		0000h = unspecified
 2Ch	WORD	number of vendor-specific (usually ECC) bytes on
		  Read/Write Long; 0000h = unspecified
 2Eh  4	WORDs	firmware revision
		no revision number if first word is 0000h
		else blank-padded ASCII revision number
 36h 20	WORDs	model number
		no model number if first word is 0000h
		else blank-padded ASCII model string
 5Eh	WORD	read/write multiple support
		bits 7-0: maximum number of sectors per block supported
			00h if read/write multiple not supported
		bits 15-8: vendor-specified
 60h	WORD	able to do doubleword transfers if nonzero
 62h	WORD	capabilities (see #P0518)
 64h	WORD	security mode
		bit 15: security-mode feature set supported
		bits 14-8: maximum number of passwords supported
 66h	WORD	PIO data transfer cycle timing
 68h	WORD	single-word DMA data transfer cycle timing
 6Ah	WORD	field validity
		bit 0: offsets 6Ch-75h valid
		bit 1: offsets 80h-8Dh valid
 6Ch	WORD	logical cylinders in current translation mode
 6Eh	WORD	logical heads in current translation mode
 70h	WORD	logical sectors per track in current translation mode
 72h	DWORD	current capacity in sectors (excluding device-specific uses)
 76h	WORD	multiple-sector support
		bits 7-0: count for read/write multiple command
		bit 8:	multiple-sector setting is valid
 78h	DWORD	total number of user-addressable sectors (LBA mode)
		00000000h if LBA mode not supported
 7Ch	WORD	single-word DMA transfer modes
		low byte is bitmap of supported modes (bit 0 = mode 0, etc.)
		high bytes is bitmap of active mode (bit 8 = mode 0, etc.)
 7Eh	WORD	multiword DMA transfer
		low byte is bitmap of supported modes (bit 0 = mode 0, etc.)
		high byte is bitmap of active mode (bit 8 = mode 0, etc.)
 80h	WORD	supported flow control PIO transfer modes
 82h	WORD	minimum multiword DMA transfer cycle time in ns
 84h	WORD	recommended multiword DMA cycle time in ns
 86h	WORD	minimum non-flow-control PIO transfer cycle time in ns
 88h	WORD	minimum PIO transfer cycle time with IORDY in ns
 8Ah  2 WORDs	reserved for future PIO modes (0)
 8Eh  2 WORDs	reserved (0)
 92h	WORD	command queueing/overlapped operation (see #P0523)
 94h  6 WORDs	reserved (0)
 A0h	WORD	major revision number of specification to which device conforms
		01h = ATA-1, 02h = ATA-2, etc.	0000h/FFFFh = not reported
 A2h	WORD	minor revision number of specification to which device conforms
		0000h/FFFFh = not reported
 A4h	WORD	feature set support 1 (see #P0519)
		(only valid if revision reported in A0h/A2h)
 A6h	WORD	feature set support 2 (see #P0520)
		(only valid if revision reported in A0h/A2h)
 A8h	WORD	(ATA/ATAPI-4) feature set support extension (see #P0521)
 AAh	WORD	feature set enabled 1 (see #P0522)
		(only valid if revision reported in A0h/A2h)
 ACh	WORD	feature set enabled 2 (see #P0520)
		(only valid if revision reported in A0h/A2h)
 AEh	WORD	(ATA/ATAPI-4) feature set enabled extension (see #P0521)
 B0h 42 WORDs	reserved (0)
100h 32 WORDs	vendor-specific
100h	WORD	security status
140h 96 WORDs	reserved (0)
SeeAlso: #P0524,#00267

Bitfields for IDE general configuration:
Bit(s)	Description	(Table P0517)
 15	device class
	=0 ATA device
	=1 ATAPI device
 14	requires format speed tolerance gap
 13	supports track offset option
 12	supports data strobe offset
 11	disk rotational sped tolerance > 0.5%
 10-8	disk transfer rate
	001 <= 5Mbit/sec
	010 5-10 Mbit/sec
	100 > 10Mbit/sec
 7-6	drive type
	01 fixed media
	10 removable media
 5	synchronized drive motor option enabled
 4	head-switching time > 15 microseconds
 3	encoding
	=0 MFM
 2-1	sector type
	01 hard-sectored
	10 soft-sectored
 0	unused (0)
SeeAlso: #P0516

Bitfields for IDE capabilities:
Bit(s)	Description	(Table P0518)
 13	Standby Timer values used according to ATA standard
 11	IORDY supported
 10	device can disable use of IORDY
 9	LBA mode supported
 8	DMA supported
SeeAlso: #P0516

Bitfields for ATA feature set support 1:
Bit(s)	Description	(Table P0519)
 15	Identify Device DMA command is supported
 14	NOP (00h) command is supported
 13	Read Buffer command is supported
 12	Write Buffer command is supported
 11	Write Verify command is supported
 10	host protected area feature set is supported
 9	Device Reset (08h) command is supported
 8	Service interrupt is supported
 7	release interrupt is supported
 6	device supports look-ahead
 5	device supports write cache
 4	PACKET command feature set is supported
 3	power management is supported
 2	removable-media feature set is supported
 1	security feature set is supported
 0	SMART feature set is supported
Note:	values of 0000h and FFFFh indicate that this field is not supported
SeeAlso: #P0516,#P0520,#P0521

Bitfields for ATA feature set support/enabled 2:
Bit(s)	Description	(Table P0520)
 15	must be 0 if this field is supported
 14	must be 1 if this field is supported
 13-2	reserved
 1	Read DMA O/Q (C7h) and Write DMA O/Q (CCh) commands supported/enabled
 0	Download Microcode (92h) command is supported/enabled
SeeAlso: #P0516,#P0522,#P0519,#P0521

Bitfields for ATA feature set support extension:
Bit(s)	Description	(Table P0521)
 15	must be 0 if this field is supported
 14	must be 1 if this field is supported
 13-0	reserved
SeeAlso: #P0516,#P0519,#P0520

Bitfields for ATA feature set enabled 1:
Bit(s)	Description	(Table P0522)
 15	Identify Device DMA command is supported
 14	NOP (00h) command is supported
 13	Read Buffer command is supported
 12	Write Buffer command is supported
 11	Write Verify command is supported
 10	host protected area feature set is supported
 9	Device Reset (08h) command is supported
 8	Service interrupt is enabled
 7	release interrupt is enabled
 6	look-ahead is enabled
 5	write cache is enabled
 4	PACKET command feature set is enabled
 3	power management is enabled
 2	removable-media feature set is enabled
 1	security feature set is enabled
 0	SMART feature set is enabled
SeeAlso: #P0516,#P0520

Bitfields for ATA/ATAPI-4 command queueing/overlapped operation support:
Bit(s)	Description	(Table P0523)
 15	reserved
 14	device supports command queueing
 13	device supports overlapped operation
 12-5	reserved
 4-0	maximum depth of queued commands supported (0 if bit 14 clear)
SeeAlso: #P0516

Format of ATAPI Identify Information:
Offset	Size	Description	(Table P0524)
 00h	WORD	general configuration (see #P0525)
 02h  9 WORDs	???
 14h 10 WORDs	serial number
		no serial number if first word is 0000h
		else blank-padded ASCII serial number
 28h  3 WORDs	vendor-specific
 2Eh  4	WORDs	firmware revision
		no revision number if first word is 0000h
		else blank-padded ASCII revision number
 36h 20	WORDs	model number
		no model number if first word is 0000h
		else blank-padded ASCII model string
 5Eh	WORD	vendor-specific
 60h	WORD	reserved (0)
 62h	WORD	capabilities (see #P0518)
 64h	WORD	security mode???
 66h	WORD	PIO data transfer cycle timing
 68h	WORD	single-word DMA data transfer cycle timing
 6Ah	WORD	field validity
		bit 0: offsets 6Ch-73h valid
		bit 1: offsets 80h-8Dh valid
 6Ch	WORD	??? logical cylinders in current translation mode
 6Eh	WORD	??? logical heads in current translation mode
 70h	WORD	??? logical sectors per track in current translation mode
 72h  2	WORDs	??? current capacity in sectors
 76h	WORD	??? multiple-sector count for read/write multiple command
 78h  2	WORDs	??? total number of user-addressable sectors (LBA mode)
 7Ch	WORD	single-word DMA transfer modes
		low byte is bitmap of supported modes (bit 0 = mode 0, etc.)
		high bytes is bitmap of active mode (bit 8 = mode 0, etc.)
 7Eh	WORD	multiword DMA transfer
		low byte is bitmap of supported modes (bit 0 = mode 0, etc.)
		high bytes is bitmap of active mode (bit 8 = mode 0, etc.)
 80h	WORD	supported flow control PIO transfer modes
 82h	WORD	minimum multiword DMA transfer cycle time
 84h	WORD	recommended multiword DMA cycle time
 86h	WORD	minimum non-flow-control PIO transfer cycle time
 88h	WORD	minimum PIO transfer cycle time with IORDY
 8Ah  2 WORDs	reserved for future PIO modes (0)
 8Eh	WORD	typical time for release when processing overlapped CMD in
		  microseconds
 90h	WORD	???
 92h	WORD	major ATAPI version number
 94h	WORD	minor ATAPI version number
 96h 54 WORDs	reserved (0)
100h 32 WORDs	vendor-specific
140h 96 WORDs	reserved (0)
SeeAlso: #P0516

Bitfields for ATAPI General Configuration:
Bit(s)	Description	(Table P0525)
 15-14	device type
	0x not ATAPI
	10 ATAPI
	11 reserved
 13	reserved
 12	device present (non-ATAPI)
 12-8	ATAPI device type (see #P0526)
 7	device is removable
 6-5	CMD DMA Request type
	00 microprocessor DRQ
	01 interrupt DRQ
	10 accelerated DRQ
	11 reserved
 4-2	reserved
 1-0	CMD packet size (00 = 12 bytes, 01 = 16 bytes)
SeeAlso: #P0524

(Table P0526)
Values for ATAPI device type:
 00h	direct-access device (i.e. disk drive)
 01h	sequential-access device (i.e. tape drive)
 02h	printer
 03h	processor
 04h	write-once device
 05h	CD-ROM
 06h	scanner
 07h	optical memory
 08h	medium changer
 09h	communications device
 0Ah	reserved for ACS IT8
 0Bh	reserved for ACS IT8
 0Ch	array controller device (i.e. RAID)
 0Dh-1Eh reserved
 1Fh	unknown type or no device
SeeAlso: #P0525

(Table P0527)
Values for Self-Monitoring, Analysis, Reporting Technology (SMART) subcommand:
 D0h	Read Attribute Values (optional) (see #P0529)
	results returned in 512-byte sector read from controller
 D1h	Read Attribute Thresholds (optional) (see #P0528)
	results returned in 512-byte sector read from controller
 D2h	Disable Attribute Autosave (optional)
	sector-count register set to 0000h
 D2h	Enable Attribute Autosave
	sector-count register set to 00F1h
 D3h	Save Attribute Values (optional)
 D4h	execute off-line tests immediately (optional)
 D5h-D6h reserved
 D7h	vendor-specific
 D8h	Enable SMART Operations
 D9h	Disable SMART Operations
 DAh	Return SMART Status
	if any threshold(s) exceeded, CylinderLow set to F4h and CylinderHigh
	  set to 2Ch
 DBh	Enable/Disable Automatic Off-Line Data Collection
	sector-count register set to 0000h to disable, 00F8h to enable
 DCh-DFh reserved
 E0h-EFh vendor-specific
Note:	to access SMART commands, the Cylinder Low register must be set to
	  004Fh and the Cylinder High register must be set to 00C2h before
	  invoking the SMART command with the SMART command number in the
	  Features register
SeeAlso: #P0515

Format of S.M.A.R.T. attribute thresholds sector:
Offset	Size	Description	(Table P0528)
 00h	WORD	data structure revision number (0005h for SMART Revision 2.0)
 02h 12 BYTEs	attribute threshold data 1 (see #P0531)
 ...
14Eh 12 BYTEs	attribute threshold data 30 (see #P0531)
16Ah 18 BYTEs	reserved (0)
17Ch 131 BYTEs	vendor-specific
1FFh	BYTE	checksum (two's complement of eight-bit sum of first 511 bytes)
Note:	if the drive provides fewer than 30 attributes, all remaining attribute
	  records are filled with NUL (00h) bytes
SeeAlso: #P0527,#P0529

Format of S.M.A.R.T. attribute values sector:
Offset	Size	Description	(Table P0529)
 00h	WORD
 02h 12 BYTEs	attribute value data 1 (see #P0532)
 ...
14Eh 12 BYTEs	attribute value data 30 (see #P0532)
16Ah	BYTE	off-line data collection status (see #P0533)
16Bh	BYTE	vendor-specific
16Ch	WORD	time to complete off-line data collection, in seconds
		0001h-FFFFh
16Eh	BYTE	vendor-sepcific
16Fh	BYTE	off-line data collection capability (see #P0534)
170h	WORD	S.M.A.R.T. capabilities (see #P0530)
172h 16 BYTEs	reserved (0)
182h 125 BYTEs	vendor-specific
1FFh	BYTE	checksum (two's complement of eight-bit sum of first 511 bytes)
Note:	if the drive provides fewer than 30 attributes, all remaining attribute
	  records are filled with NUL (00h) bytes
SeeAlso: #P0527,#P0528

Bitfields for S.M.A.R.T capabilities:
Bit(s)	Description	(Table P0530)
 0	attributes saved on going into power-saving mode
 1	Enable/Disable Attribute Autosave subcommands are supported
 2-15	reserved
SeeAlso: #P0529

Format of S.M.A.R.T. attribute threshold:
Offset	Size	Description	(Table P0531)
 00h	BYTE	attribute ID (01h-FFh)
 01h	BYTE	attribute threshold
		00h always passing
		01h minimum threshold value
		FDh maximum threshold value
		FEh invalid (do not use)
		FFh always failing (for testing)
 02h 10 BYTEs	reserved (0)
Note:	the attribute ID and actual threshold values are vendor-specific
SeeAlso: #P0528,#P0532

Format of S.M.A.R.T attribute value:
Offset	Size	Description	(Table P0532)
 00h	BYTE	attribute ID (01h-FFh)
 01h	WORD	status flags
		bit 0: pre-failure/advisory
			=0 value < threshold indicates usage/age exceeding
				  design life
			=1 value < threshold indicates pre-failure condition
		bit 1: on-line data collection
		bits 2-5 vendor-specific
		bits 6-15 reserved
 03h	BYTE	attribute value (01h-FDh)
		initial value prior to data collection is 64h
 04h  8 BYTEs	vendor-specific
SeeAlso: #P0529,#P0531

(Table P0533)
Values for S.M.A.R.T. off-line data collection status:
 00h	off-line collection never started
 01h	reserved
 02h	off-line data collection completed successfully
 03h	reserved
 04h	off-line data collection suspended by command from host
 05h	off-line data collection aborted by command from host
 06h	off-line data collection aborted due to fatal error
 07h-3Fh reserved
 40h-7Fh vendor-specific
 80h	off-line collection never started (auto-offline feature enabled)
 81h	reserved
 82h	off-line data collection completed successfully (auto-offline feature
	  enabled)
 83h	reserved
 84h	off-line data collection suspended by command from host (auto-offline
	  feature enabled)
 85h	off-line data collection aborted by command from host (auto-offline
	  feature enabled)
 86h	off-line data collection aborted due to fatal error (auto-offline
	  feature enabled)
 87h-BFh reserved
 C0h-FFh vendor-specific
SeeAlso: #P0529,#P0534

Bitfields for S.M.A.R.T. off-line data collection capabilities:
Bit(s)	Description	(Table P0534)
 0	Execute Off-Line Immediate (D4h) subcommand is implemented
 1	Enable/Disable Automatic Off-Line subcommand is implemented
 2	abort/resume on interrupting command
	=0 off-line resumes automatically after an interrupting command
	=1 off-line collection is aborted by an interrupting command
 3-7	reserved
SeeAlso: #P0527

(Table P0535)
Values for Feature Code:
 01h	[opt] 8-bit instead of 16-bit data transfers
 02h	[opt] enable write cache
 03h	      set transfer mode as specified by Sector Count register
 04h	[opt] enable all automatic defect reassignment
 22h	[opt] Write Same, user-specified area
 33h	[opt] disable retries
 44h	      specify length of ECC bytes used by Read Long and Write Long
 54h	[opt] set cache segments (value in Sector Count register)
 55h	      disable look-ahead
 66h	      disable reverting to power-on defaults
 77h	[opt] disable ECC
 81h	[opt] 16-bit instead of 8-bit data transfers
 82h	[opt] disable write cache
 84h	[opt] disable all automatic defect reassignment
 88h	[opt] enable ECC
 99h	[opt] enable retries
 9Ah	[opt] set device maximum average current
 AAh	      enable look-ahead
 ABh	[opt] set maximum prefecth (value in Sector Count register)
 BBh	      use four bytes of ECC on Read Long and Write Long (for compat.)
 CCh	      enable reverting to power-on defaults
 DDh	[opt] Write Same, entire disk
SeeAlso: #00266
----------P01F001F6--------------------------
PORT 01F0-01F6 - OPTi "Vendetta" (82C750) CHIPSET - PRIMARY IDE CONTROLLER
Note:	to unlock access to these ports, you must perform two immediately
	  successive 16-bit INs from PORT 01F1h, followed by 8-bit OUT of 03h
	  to PORT 1F2h
SeeAlso: PORT 0170h"Vendetta",PORT 01F0h"HDC 1"

01F0  RW  read cycle timing register (see #P0536)
01F1  RW  write cycle timing register (see #P0537)
01F2  RW  internal ID register (see #P0538)
01F3  RW  control register (see #P0539)
01F5  RW  strap register (see #P0540)
01F6  RW  miscellaneous register (see #P0541)

Bitfields for OPTi "Vendetta" IDE controller read cycle timing register:
Bit(s)	Description	(Table P0536)
 7-4	DRD# pulse width - 1 LCLKs on 16-bit IDE data register read
 3-0	recovery time between DRD# and DA2-0/DCSx# - 2 LCLKs after 16-bit IDE
	  data register read
Notes:	if register 1F6h/176h bit 0 = 0, controls drive selected by
	  register 1F3h/173h bits 3-2
	if register 1F6h/176h bit 0 = 1, controls drive not selected by
	  register 1F3h/173h bits 3-2, if register 1F3h/173h bit 7 = 1
SeeAlso: #P0537,#P0538,#P0539

Bitfields for OPTi "Vendetta" IDE controller write cycle timing register:
Bit(s)	Description	(Table P0537)
 7-4	DWR# pulse width - 1 LCLKs on 16-bit IDE data register write
 3-0	recovery time between DWR# and DA2-0/DCSx# - 2 LCLKs after 16-bit IDE
	  data register write
Notes:	if register 1F6h/176h bit 0 = 0, controls drive selected by
	  register 1F3h/173h bits 3-2
	if register 1F6h/176h bit 0 = 1, controls drive not selected by
	  register 1F3h/173h bits 3-2, if register 1F3h/173h bit 7 = 1
SeeAlso: #P0536,#P0539

Bitfields for OPTi "Vendetta" IDE controller internal ID register:
Bit(s)	Description	(Table P0538)
 7	controller register access disable (write-only)
 6	controller register access disable until power-down or reset
	  (write-only)
 5-2	reserved (read-only)
 1-0	reserved (11, otherwise all controller register writes blocked)
SeeAlso: #P0540

Bitfields for OPTi "Vendetta" IDE controller control register:
Bit(s)	Description	(Table P0539)
 7	enable 1F0h-1F1h/170h-171h and 1F6h/176h bits 5-1 cycle timing
	  set for drive not selected by 1F3h/173h bits 3-2
 6-5	reserved (read-only)
 4	(primary IDE controller) minimum read wait states
	0 = 2 wait states
	1 = 1 wait states
	(secondary IDE controller) reserved
 3	enable 1F0h-1F1h/170h-171h cycle timing set for drive 1
 2	enable 1F0h-1F1h/170h-171h cycle timing set for drive 0
 1	reserved
 0	reserved (1) (read-only)
SeeAlso: #P0540,#P0541

Bitfields for OPTi "Vendetta" IDE controller strap register:
Bit(s)	Description	(Table P0540)
 7	reserved (1) (read-only)
 6-5	revision number (read-only)
	11 = chip revision in PCI configuration register 08h (see #00878)
	  (see #00931)
 4	(primary IDE controller) DINTR state (read-only)
	(secondary IDE controller) SDINTR state (read-only)
 3-2	(primary IDE controller only) IDE device cycle time (read-only)
	value determined by PCI config register 40h bits 1-0 (see #00931)
 1	reserved (1) (read-only)
 0	(primary IDE controller only) PCI CLK
	0 = 33 MHz
	1 = 25 MHz
SeeAlso: #P0539,#P0541,#P0538

Bitfields for OPTi "Vendetta" IDE controller miscellaneous register:
Bit(s)	Description	(Table P0541)
 7	reserved
 6	read prefetch enable
 5-4	address setup time between DRD#/DWR# active and
	  DA2-0/DCS3#/DCS1# - 1 LCLKs
 3-1	minimum number of LCLKs between DRDY# high and DRD#/DRW# inactive - 2
 0	cycle timing register switch (1F0h/170h and 1F1h/171h)
SeeAlso: #P0539,#P0540
----------P01F8------------------------------
PORT 01F8 - ???

01F8  RW  ???
		bit 0: A20 gate control (set = A20 enabled, clear = disabled)
----------P01F901FF--------------------------
PORT 01F9-01FF - PC radio by CoZet Info Systems
Range:	The I/O address range is dipswitch selectable from:
	   038-03F and 0B0-0BF
	   078-07F and 0F0-0FF
	   138-13F and 1B0-1BF
	   178-17F and 1F0-1FF
	   238-23F and 2B0-2BF
	   278-27F and 2F0-2FF
	   338-33F and 3B0-3BF
	   378-37F and 3F0-3FF
Notes:	All of these addresses show a readout of FFh in initial state.
	Once started, all of the addresses show	FBh, whatever might happen.
--------d-P0200------------------------------
PORT 0200 - Digidesign 'Session 8' HARD-DISK RECORDING SYSTEM
SeeAlso: PORT 0300h"Digidesign"
----------P0200020F--------------------------
PORT 0200-020F - Game port reserved I/O address space
0200-0207 - Game port, eight identical addresses on some boards

0201  R-  read joystick position and status (see #P0542)
0201  -W  fire joystick's four one-shots
0201  RW  gameport on mc-soundmachine, mc 03-04/1992: Adlib-compatible,
		Covox 'voice master' & 'speech thing' compatible soundcard.
		(enabled if bit1=1 in PORT 038Fh. Because it is disabled on
		power-on, it cannot be found by BIOS) (see PORT 0388h-038Fh)

Bitfields for joystick position and status:
Bit(s)	Description	(Table P0542)
 7	status B joystick button 2 / D paddle button
 6	status B joystick button 1 / C paddle button
 5	status A joystick button 2 / B paddle button
 4	status A joystick button 1 / A paddle button
 3	B joystick Y coordinate	   / D paddle coordinate
 2	B joystick X coordinate	   / C paddle coordinate
 1	A joystick Y coordinate	   / B paddle coordinate
 0	A joystick X coordinate	   / A paddle coordinate
----------P020002FF--------------------------
PORT 0200-02FF - Sunshine uPW48, programmer for EPROM version CPU's 8748/8749
Range:	4 bit DIP switch installable in the range 20x-2Fx

0200-0203	addresses of the 8255 on the uPW48
0208-020B	addresses of ??? on the uPW48 (all showing zeros)
----------P02080209--------------------------
PORT 0208-0209 - Intel 82C212B "Neat" chipset - EMS emulation control
Range:	may be set to 0208, 0218, 0258, 0268, 02A8, 02B8, 02E8
----------P0208020A--------------------------
PORT 0208-020A - Chips&Technologies 82C235 "SCAT" chipset - EMS PAGE REGISTERS
Range:	PORT 0208h or PORT 0218h, depending on configuration register 4Fh
	  (see #P0067)
SeeAlso: PORT 0022h"82C235"

0208  RW  EMS page register
0209  RW  EMS page register
020A  RW  EMS page register
----------P020C020F--------------------------
PORT 020C-020F - AIMS LAB PC Radio
Range:	configurable to PORT 020Ch or PORT 030Ch
Notes:	writing a value with bit 3 set to one of these ports turns on the
	  radio; writing a value with bit 3 clear turns it off
	PORT 020Eh bits 1 indicates status of some kind
----------P02100217--------------------------
PORT 0210-0217 - Expansion unit (XT)

0210  -W  latch expansion bus data
0210  R-  verify expansion bus data
0211  -W  clear wait, test latch
0211  R-  High byte data address
0212  R-  Low byte data address
0213  -W  0=enable,  1=disable expansion unit
0214  -W  latch data  (receiver card port)
0214  R-  read data   (receiver card port)
0215  R-  High byte of address, then Low byte	(receiver card port)
----------P02100211--------------------------
PORT 0210-0211 - Game Blaster
Range:	PORT 02x0h-02x1h, x=1,2,...

0210  -W  register index
0211  ?W  register data
----------P02180219--------------------------
PORT 0218-0219 - Intel 82C212B "Neat" chipset - EMS emulation control
Range:	base address may be set to 0208, 0218, 0258, 0268, 02A8, 02B8, or 02E8
----------P0218021A--------------------------
PORT 0218-021A - Chips&Technologies 82C235 "SCAT" chipset - EMS PAGE REGISTERS
Range:	PORT 0208h or PORT 0218h, depending on configuration register 4Fh
	  (see #P0067)
SeeAlso: PORT 0022h"82C235"

0218  RW  EMS page register
0219  RW  EMS page register
021A  RW  EMS page register
----------P02200223--------------------------
PORT 0220-0223 - Sound Blaster / Adlib port (Stereo)
SeeAlso: PORT 0388h-0389h

0220  R-  Left speaker -- Status port
0220  -W  Left speaker -- Address port
0221  -W  Left speaker -- Data port
0222  R-  Right speaker -- Status port
0222  -W  Right speaker -- Address port
0223  -W  Right speaker -- Data port
----------P02200227--------------------------
PORT 0220-0227 - Soundblaster PRO and SSB 16 ASP
----------P02200228--------------------------
PORT 0220-0228 - C&T 82C570 CHIPSlink '3270' Protocol Controller
!!!chips\82c570.pdf p.7
----------P0220022F--------------------------
PORT 0220-022F - Soundblaster PRO 2.0
----------P0220022F--------------------------
PORT 0220-022F - Soundblaster PRO 4.0
Note:	the FM music is accessible on 0388/0389 for compatibility.

0220  R-  left FM status port
0220  -W  left FM music register address port (index)
0221  RW  left FM music data port
0222  R-  right FM status port
0222  -W  right FM music register address port (index)
0223  RW  right FM music data port
0224  -W  mixer register address port (index) (see #P0543)
0225  RW  mixer data port
0226  -W  DSP reset
0228  R-  FM music status port
0228  -W  FM music register address port (index)
0229  -W  FM music data port
022A  R-  DSP read data (voice I/O and Midi)
022C  -W  DSP write data / write command
022C  R-  DSP write buffer status (bit 7)
022E  R-  DSP data available status (bit 7)

(Table P0543)
Values for SB Mixer register index:
 Index	Description		PORT 0225h data
 00h	reset			00h = zero all mixer controls
 04h	voice select		high nybble = left, low nybble = right
 0Ah	microphone gain		bits 2-0 = gain
 22h	master gain		high nybble = left, low nybble = right
 26h	MIDI gain		high nybble = left, low nybble = right
 28h	CD gain			high nybble = left, low nybble = right
 2Eh	Line In			high nybble = left, low nybble = right
 30h	Master Left		bits 7-3 = volume
 31h	Master Right		bits 7-3 = volume
 32h	Voice Left		bits 7-3 = volume
 33h	Voice Right		bits 7-3 = volume
 34h	MIDI Left		bits 7-3 = volume
 35h	MIDI Right		bits 7-3 = volume
 36h	CD Left			bits 7-3 = volume
 37h	CD Right		bits 7-3 = volume
 38h	LineIn Left		bits 7-3 = volume
 39h	LineIn Right		bits 7-3 = volume
 3Ah	Microphone		bits 7-3 = gain
 3Bh	PC speaker		bits 7-3 = volume
 3Ch	Sound Output		highest set bit is enabled source (see #P0544)
 3Dh	Sound Source (left)	highest set bit is enabled source (see #P0544)
 3Eh	Sound Source (right)	highest set bit is enabled source (see #P0544)
 40h	In gain			bits 7-6 = gain
				   (00 = x1, 01 = x2, 10 = x4, 11 = x8)
 41h	Out gain (left)		bits 7-6 = gain (as for In)
 42h	Out gain (right)	bits 7-6 = gain (as for In)
 43h	Automatic Gain Control	bit 0 = enable
 44h	Treble (left)		bits 7-3 = volume
 45h	Treble (right)		bits 7-3 = volume
 46h	Bass (left)		bits 7-3 = volume
 47h	Bass (right)		bits 7-3 = volume

Bitfields for SB Mixer sound source:
Bit(s)	Description	(Table P0544)
 7	PC speaker???
 6	MIDI left
 5	MIDI right
 4	LineIn left
 3	LineIn right
 2	CD left
 1	CD right
 0	microphone		
Note:	bits 7-5 are ignored for Sound Output register
SeeAlso: #P0543
----------P022B------------------------------
PORT 022B - GI1904 Scanner Interface Adapter
Range:	PORT 026Bh, PORT 02ABh (default), PORT 02EBh, PORT 032Bh, PORT 036Bh
Range:	PORT 03ABh, PORT 03EBh
----------P022C------------------------------
PORT 022C - GS-IF Scanner Interface adapter
Range:	PORT 022Ch, PORT 026Ch, PORT 02ACh, PORT 02ECh (default),
	  PORT 032Ch, PORT 036Ch, PORT 03ACh, PORT 03ECh
Note:	many SPI 400dpi/800dpi gray / H/T handy scanner by Marstek, Mustek and
	  others use this interface
----------P022F------------------------------
PORT 022F - mc-soundmachine, mc 03-04/1992 - SPEECH I/O
Note:	An Adlib-compatible Covox 'voice master' & 'speech thing' compatible
	  soundcard
SeeAlso: PORT 0378h"Covox",PORT 0388h-038Fh"soundmachine"

022F  RW  Covox compatible speech I/O  (via internal A/D converter,
		each read access starts a new conversion cycle)
		register enabled if bit7=1 in PORT 038Fh
----------P02300233--------------------------
PORT 0230-0233 - Adaptec 154xB/154xC SCSI adapter.
Range:	four ports at any of 0130, 0134, 0230, 0234, 0330 (default) or 0334
----------P02340237--------------------------
PORT 0234-0237 - Adaptec 154xB/154xC SCSI adapter.
Range:	four ports at any of 0130, 0134, 0230, 0234, 0330 (default) or 0334
----------P0238023F--------------------------
PORT 0238-023F - COM port addresses on UniRAM card by German magazine c't
		selectable from 238, 2E8, 2F8, 338, 3E0, 3E8, 3F8
----------P0238023B--------------------------
PORT 0238-023B - Bus Mouse Port (secondary address)
InstallCheck: read the ID Port twice; if installed, the first byte
	  returned will be DEh, and the second will vary by card
	  (revision number???)
Note:	secondary address for bus mice from MS and Logitech, and the ATI
	  video adapter mouse
SeeAlso: PORT 023Ch"Mouse"

0238  ?W  Command port
0239  ?W  Data port
023A  R?  ID Port 
----------P023C023F--------------------------
PORT 023C-023F - Bus Mouse Port (primary address)
InstallCheck: read the ID Port twice; if installed, the first byte
	  returned will be DEh, and the second will vary by card
	  (revision number???)
Note:	primary address for bus mice from MS and Logitech, the ATI video
	  adapter mouse, and the Commodore PC30III bus mouse
SeeAlso: PORT 0238h"Mouse"

023C  ?W  Command port
023D  ?W  Data port
023E  R?  ID Port 
----------P0240024F--------------------------
PORT 0240-024F - Gravis Ultra Sound by Advanced Gravis
Range:	The I/O address range is dipswitch selectable from:
	   0200-020F and 0300-030F
	   0210-021F and 0310-031F
	   0220-022F and 0320-032F
	   0230-023F and 0330-033F
	   0240-024F and 0340-034F
	   0250-025F and 0350-035F
	   0260-026F and 0360-036F
	   0270-027F and 0370-037F
SeeAlso: PORT 0340h-034Fh,PORT 0746h

0240  -W  Mix Control register (see #P0545)
0241  R-  Read Data
0241  -W  Trigger Timer
0246  R-  IRQ Status Register (see #P0546)
0248  RW  Timer Control Reg
	  Same as ADLIB Board (see PORT 0200h)
0249  -W  Timer Data (see #P0547)
024B  -W  IRQ Control Register (0240 bit 6 = 1) (see #P0548)
024B  -W  DMA Control Register (0240 bit 6 = 0) (see #P0549)
024F  RW  Register Controls (rev 3.4+)

Bitfields for Gravis Ultra Sound mix control register:
Bit(s)	Description	(Table P0545)
 6	   Control Register Select (see 024B)
 5	   Enable MIDI Loopback
 4	   Combine GF1 IRQ with MIDI IRQ
 3	   Enable Latches
 2	   Enable MIC IN
 1	   Disable LINE OUT
 0	   Disable LINE IN
SeeAlso: #P0546

Bitfields for Gravis Ultra Sound IRQ status register:
Bit(s)	Description	(Table P0546)
 7	   DMA TC IRQ
 6	   Volume Ramp IRQ
 5	   WaveTable IRQ
 3	   Timer 2 IRQ
 2	   Timer 1 IRQ
 1	   MIDI Receive IRQ
 0	   MIDI Transmit IRQ
SeeAlso: #P0545,#P0548,#P0549

Bitfields for Gravis Ultra Sound timer data:
Bit(s)	Description	(Table P0547)
 7	   Reset Timr IRQ
 6	   Mask Timer 1
 5	   Mask Timer 2
 1	   Timer 2 Start
 0	   Timer 1 Start
SeeAlso: #P0546,#P0548

Bitfields for Gravis Ultra Sound IRQ control register:
Bit(s)	Description	(Table P0548)
 6	Combine Both IRQ
 5-3	MIDI IRQ Selector
	000  No IRQ
	001  IRQ 2
	010  IRQ 5
	011  IRQ 3
	100  IRQ 7
	101  IRQ 11
	110  IRQ 12
	111  IRQ 15
 2-0	GF1 IRQ Selector
	000  No IRQ
	001  IRQ 2
	010  IRQ 5
	011  IRQ 3
	100  IRQ 7
	101  IRQ 11
	110  IRQ 12
	111  IRQ 15
SeeAlso: #P0546,#P0549

Bitfields for Gravis Ultra Sound DMA Control Register:
Bit(s)	Description	(Table P0549)
 6	Combine Both DMA
 5-3	DMA Select Register 2
	000  No DMA
	001  DMA 1
	010  DMA 3
	011  DMA 5
	100  DMA 6
	101  DMA 7
 2-0	DMA Select Register 1
	000  No DMA
	001  DMA 1
	010  DMA 3
	011  DMA 5
	100  DMA 6
	101  DMA 7
SeeAlso: #P0546,#P0548,#P0591
----------P02400257--------------------------
PORT 0240-0257 - RTC (alternate Real Time Clock for XT)	 (1st at 0340-0357)
		(used by TIMER.COM v1.2 which is the 'standard' timer program)
----------P02580259--------------------------
PORT 0258-0259 - Intel 82C212B "Neat" chipset - EMS emulation control
Range:	base address may be set to 0208, 0218, 0258, 0268, 02A8, 02B8, or 02E8
----------P02580259--------------------------
PORT 0258-0259 - AT RAMBANK Memory Expansion Board - EXT MEMORY AND EMS-SUPPORT
Range:	base address may be set to 0218h, 0228h, 0238h, 0258h, 0268h, 0298h,
	  or 02A8h
----------P0258025F--------------------------
PORT 0258-025F - Intel Above Board
----------P02600268--------------------------
PORT 0260-0268	-  LPT port address on the UniRAM card by German magazine c't
		selectable from 260, 2E0, 2E8, 2F0, 3E0, 3E8.
----------P02680269--------------------------
PORT 0268-0269 - Intel 82C212B "Neat" chipset - EMS emulation control
Range:	base address may be set to 0208, 0218, 0258, 0268, 02A8, 02B8, or 02E8
----------P026B------------------------------
PORT 026B - GI1904 Scanner Interface Adapter
Range:	PORT 022Bh, PORT 02ABh (default), PORT 02EBh, PORT 032Bh, PORT 036Bh
Range:	PORT 03ABh, PORT 03EBh
----------P026C------------------------------
PORT 026C - GS-IF Scanner Interface adapter
Range:	PORT 022Ch, PORT 026Ch, PORT 02ACh, PORT 02ECh (default),
	  PORT 032Ch, PORT 036Ch, PORT 03ACh, PORT 03ECh
Note:	many SPI 400dpi/800dpi gray / H/T handy scanner by Marstek, Mustek and
	  others use this interface
----------P026E026F--------------------------
PORT 026E-026F - Dell Enhanced Parallel Port
SeeAlso: PORT 002Eh,PORT 015Ch,PORT 0398h

026E  -W  index for data port
026F  RW  EPP command data
----------P026E026F--------------------------
PORT 026E-026F - Intel 82091AA Advanced Integrated Peripheral
Range:	PORT 0022h (X-Bus), PORT 0024h (X-Bus), PORT 026Eh (ISA), or
	  PORT 0398h (ISA)
SeeAlso: PORT 0022h"82091AA",PORT 0024h"82091AA",PORT 0398h"82091AA"

026E  ?W  configuration register index
026F  RW  configuration register data
----------P0278------------------------------
PORT 0278 - Covox 'Speech Thing' COMPATIBLES
SeeAlso: PORT 022Fh"Covox",PORT 0388h-038Fh"soundmachine"

0278  -W  speech data output via printer data port
		(with mc-soundmachine, enabled if bit5=1 in 38F)
----------P0278027A--------------------------
PORT 0278-027A - PARALLEL PRINTER PORT (usually LPT1, sometimes LPT2)
Range:	usually PORT 03BCh, PORT 0278h, or PORT 0378h
SeeAlso: PORT 0278h"EPP",MEM 0040h:0008h,INT 17/AH=00h

0278  -W  data port
0279  R-  status port (see #P0658 at PORT 03BCh)
027A  RW  control port (see #P0659 at PORT 03BCh)
----------P0278027F--------------------------
PORT 0278-027F - Intel 82360SL/82091AA - EPP-mode PARALLEL PORT
Range:	PORT 0278h or PORT 0378h
SeeAlso: PORT 0278h"LPT1",PORT 0678h"ECP"

0278-027A	as for standard parallel port
027B  RW  address strobe
027C  RW  data strobe 0
027D  RW  data strobe 1
027E  RW  data strobe 2
027F  RW  data strobe 3
----------P0279------------------------------
PORT 0279 - Plug-and-Play - CONFIGURATION REGISTER
SeeAlso: PORT 0A79h

0279  -W  index into Plug-and-Play register set for Read Data Port and
	  Write Data Port I/O (see #P0550,#P0551)

(Table P0550)
Values for Plug-and-Play Card-Level Registers:
 00h	set Read Port address
	bits 9-2 of Read Data port address (bits 15-10 are always 0, bits 1-0
	  are always 11); valid Read Port addresses are 0203h-03FFh
 01h	serial isolation
 02h	configuration control
 03h	Wake command
	(specifies which card is accessed through configuration registers)
 04h	resource data
 05h	status
 06h	Card Select Number (CSN)
 07h	logical device number
	(selects which logical device on card is accessed at locations 30h-FFh)
	(see #P0551)
 08h-1Fh reserved
 20h-2Fh vendor-specific
Note:	there is one set of these registers per installed card
SeeAlso: #P0551

(Table P0551)
Values for Plug-and-Play Logical Device Registers:
 30h	activate
	bit 0: device is active on ISA bus
	bits 7-1: reserved (0)
 31h	I/O range check
	bit 0: I/O Read Pattern select (if bit 1 set, then I/O reads return
		55h if this bit is set, AAh if this bit is clear)
	bit 1: I/O Range Check Enable: if set, all reads from device I/O
		  registers return 55h or AAh, depending on bit 0
	bits 7-2: reserved (0)
 32h-37h reserved
 38h-3Fh vendor-specific
 40h-44h 24-bit ISA memory descriptor 0
 45h-47h reserved
 48h-4Ch 24-bit ISA memory descriptor 1
 4Dh-4Fh reserved
 50h-54h 24-bit ISA memory descriptor 2
 55h-57h reserved
 58h-5Ch 24-bit ISA memory descriptor 3
 5Dh-5Fh reserved
 60h-6Fh I/O configuration registers 0-7
 70h-71h IRQ channel select 0
 72h-73h IRQ channel select 1
 74h-75h DMA configuration registers 0-1
 76h-7Eh 32-bit memory range configuration register 0
 7Fh	 reserved
 80h-88h 32-bit memory range configuration register 1
 89h-8Fh reserved
 90h-98h 32-bit memory range configuration register 2
 99h-9Fh reserved
 A0h-A8h 32-bit memory range configuration register 3
 A9h-EFh reserved for logical device configuration
 F0h-FEh vendor-specific
 FFh	reserved
Note:	there is one set of these registers per logical device
SeeAlso: #P0550
----------P0280------------------------------
PORT 0280 - LCD display on Wyse 2108 PC
----------P02800288--------------------------
PORT 0280-0288	- non-standard COM port addresses (V20-XT by German magazine c't)
		selectable from 0280, 0288, 0290, 0298, 6A0, 6A8
--------s-P02800283--------------------------
PORT 0280-0283 - Pro Audio Spectrum 16 (PAS16)
Range:	PORT 0280h, PORT 0284h, PORT 0288h, PORT 028Ch, PORT 384h,
	  PORT 0388h (default), or PORT 038Ch
----------P0288028F--------------------------
PORT 0288-028F	- non-standard COM port addresses (V20-XT by German magazine c't)
0280-0288	selectable from 0280, 0288, 0290, 0298, 06A0, 06A8
0290-0298
0298-029F
--------s-P02840287--------------------------
PORT 0284-0287 - Pro Audio Spectrum 16 (PAS16)
Range:	PORT 0280h, PORT 0284h, PORT 0288h, PORT 028Ch, PORT 384h,
	  PORT 0388h (default), or PORT 038Ch
--------s-P0288028F--------------------------
PORT 0288-028F - Pro Audio Spectrum 16 (PAS16)
Range:	PORT 0280h, PORT 0284h, PORT 0288h, PORT 028Ch, PORT 384h,
	  PORT 0388h (default), or PORT 038Ch
--------s-P028C028F--------------------------
PORT 028C-028F - Pro Audio Spectrum 16 (PAS16)
Range:	PORT 0280h, PORT 0284h, PORT 0288h, PORT 028Ch, PORT 384h,
	  PORT 0388h (default), or PORT 038Ch
----------P02A002A7--------------------------
PORT 02A0-02A7 - Sunshine EW-901BN, EW-904BN
		EPROM writer card (release 1986) for EPROMs up to 27512
02A0-02A3	addresses of the 8255 on the EW-90xBN
----------P02A202A3--------------------------
PORT 02A2-02A3 - MSM58321RS clock
----------P02A802A9--------------------------
PORT 02A8-02A9 - Intel 82C212B "Neat" chipset - EMS emulation control
Range:	base address may be set to 0208, 0218, 0258, 0268, 02A8, 02B8, or 02E8
----------P02AB------------------------------
PORT 02AB - GI1904 Scanner Interface Adapter (default)
Range:	PORT 022Bh, PORT 026Bh, PORT 02EBh, PORT 032Bh, PORT 036Bh
Range:	PORT 03ABh, PORT 03EBh
Note:	the GI1904 is used by many SPI 400/800dpi gray/halftone/color handy
	  scanners by Marstek, Mustek, Conrad, V”lkner and others
----------P02AC------------------------------
PORT 02AC - GS-IF Scanner Interface adapter
Range:	PORT 022Ch, PORT 026Ch, PORT 02ACh, PORT 02ECh (default),
	  PORT 032Ch, PORT 036Ch, PORT 03ACh, PORT 03ECh
Note:	many SPI 400dpi/800dpi gray / H/T handy scanner by Marstek, Mustek and
	  others use this interface
----------P02B002BF--------------------------
PORT 02B0-02BF - Trantor SCSI adapter
----------P02B002DF--------------------------
PORT 02B0-02DF - alternate EGA,	primary EGA at 03C0
----------P02B802B9--------------------------
PORT 02B8-02B9 - Intel 82C212B "Neat" chipset - EMS emulation control
Range: base address may be set to 0208, 0218, 0258, 0268, 02A8, 02B8, or 02E8
----------P02C002Cx--------------------------
PORT 02C0-02Cx - AST-clock
----------P02C002DF--------------------------
PORT 02C0-02DF - XT-Real Time Clock 2 (default jumpered address)
----------P02C002CF--------------------------
PORT 02C0-02CF - EGA (2nd adapter)
SeeAlso: PORT 03C0h
--------V-P02C602C9--------------------------
PORT 02C6-02C9 - VGA/MCGA - DAC REGISTERS (alternate address)
Range:	PORT 03C6h or PORT 02C6h (alternate)
SeeAlso: PORT 03C6h
----------P02D002DA--------------------------
PORT 02D0-02DA - C&T 82C570 CHIPSlink '3270' Protocol Controller
!!!chips\82c570.pdf p.12
----------P02E002E8--------------------------
PORT 02E0-02E8 - LPT port address on the UniRAM card by German magazine c't
Range:	base address selectable from 0260, 02E0, 02E8, 02F0, 03E0, and 03E8.
----------P02E002EF--------------------------
PORT 02E0-02EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)
		(GAB 0 on XT)
02E1  ??  GPIB (adapter 0)
02E2
02E3
----------P02E002EF--------------------------
PORT 02E0-02EF - data aquisition	 (AT)

02E2  ??  data aquisition (adapter 0)
02E3  ??  data aquisition (adapter 0)
----------P02E8------------------------------
PORT 02E8 - S3 86C928 video controller (ELSA Winner 1000)
----------P02E802E9--------------------------
PORT 02E8-02E9 - Intel 82C212B "Neat" chipset - EMS emulation control
Range:	base address may be set to 0208, 0218, 0258, 0268, 02A8, 02B8, or 02E8
----------P02E802EF--------------------------
PORT 02E8-02EF - serial port, same as 02F8, 03E8 and 03F8 (COM4)
----------P02E802EF--------------------------
PORT 02E8-02EF - 8514/A and compatible (e.g. ATI Graphics Ultra)

02E8  R-  display status
02E8  -W  horizontal total
02EA  RW  Lookup: DAC mask
02EB  -W  Lookup: DAC read index
02EC  -W  Lookup: DAC write index
02ED  RW  Lookup: DAC data
----------P02EA------------------------------
PORT 02EA - S3 86C928 video controller (ELSA Winner 1000)
----------P02EB------------------------------
PORT 02EB - GI1904 Scanner Interface Adapter
Range:	PORT 022Bh, PORT 026Bh, PORT 02ABh (default), PORT 032Bh, PORT 036Bh,
	  PORT 03ABh, PORT 03EBh
----------P02EC------------------------------
PORT 02EC - GS-IF Scanner Interface adapter
Range:	PORT 022Ch, PORT 026Ch, PORT 02ACh, PORT 02ECh (default),
	  PORT 032Ch, PORT 036Ch, PORT 03ACh, PORT 03ECh
Note:	many SPI 400dpi/800dpi gray / H/T handy scanner by Marstek, Mustek and
	  others use this interface
----------P02F002F8--------------------------
PORT 02F0-02F8 - LPT port address on the UniRAM card by German magazine c't
		selectable from 260, 2E0, 2E8, 2F0, 3E0, 3E8.
----------P02F802FF--------------------------
PORT 02F8-02FF - serial port, same as 02E8, 03E8 and 03F8 (COM2)

02F8  -W  transmitter holding register
02F8  R-  receiver buffer register
02F8  RW  divisor latch, low byte	when DLAB=1
02F9  RW  divisor latch, high byte	when DLAB=1
02F9  RW  interrupt enable register when DLAB=0
02FA  R-  interrupt identification register
02FB  RW  line control register
02FC  RW  modem control register
02FD  R-  line status register
02FF  RW  scratch register
----------P0300------------------------------
PORT 0300 - Award POST Diagnostic
SeeAlso: PORT 0080h
--------d-P0300------------------------------
PORT 0300 - Digidesign 'Session 8' HARD-DISK RECORDING SYSTEM
SeeAlso: PORT 0200h"Digidesign"
--------s-P03000301--------------------------
PORT 0300-0301 - MPU-401 MIDI UART
Range:	alternate address at PORT 0330h, occasionally at PORT 0310h or
	  PORT 0320h
----------P03000301--------------------------
PORT 0300-0301 - Soundblaster 16 ASP MPU-Midi EMULATION
----------P0300????--------------------------
PORT 0300-???? - HP IEC/HP-IB adapter (e.g. for use with tape streamer HP9142)
----------P03000303--------------------------
PORT 0300-0303 - Panasonic 52x CD-ROM SCSI Miniport
Range:	PORT 0300h-0303h,PORT 0320h-0323h,PORT 0340h-0343h,PORT 0360h-0363h,
	  and PORT 0380h-0383h
----------P0300030F--------------------------
PORT 0300-030F - Philips CD-ROM player CM50
----------P0300030F--------------------------
PORT 0300-030F - CompaQ Tape drive adapter. alternate address at 0100
--------N-P0300031F--------------------------
PORT 0300-031F - 3com Ethernet adapters (default address)
--------N-P0300031F--------------------------
PORT 0300-031F - NE2000 compatible Ethernet adapters
Range:	may be placed at 0300h, 0320h, 0340h, or 0360h
SeeAlso: PORT 0300h"PCnet"
--------N-P0300031F--------------------------
PORT 0300-031F - AMD PCnet - NE2100-compatible Ethernet adapters
Range:	may be placed at 0300h, 0320h, 0340h, or 0360h, with the card's ROM
	  appearing at segment C800h, CC00h, D000h, or D400h, respectively
Note:	for the PCnet-FAST chip, the I/O address may be read from the PCI
	  configuration space at offset 10h (see #00878 at INT 1A/AX=B10Ah)
SeeAlso: PORT 0300h"NE2000",#00878

0300-030F  R-  address PROM (used to store Ethernet address, etc.)
0310w RW  Register Data Port (RDP) (see #P0552,#P0553)
0312w ?W  Register Access Port (RAP) (selects register index for RDP and IDP)
	  (see #P0570)
0314w ?W  Reset
0316w RW  ISA Bus Data Port (IDP)
0318w	  reserved for vendor-specific use
031A-031F      reserved

(Table P0552)
Values for AMD PCnet-ISA Register Data Port index:
 00h	"CSR0" status and control flags (see #P0554)
 01h	"CSR1" low half of IADR (appears at PORT 0316h)
 02h	"CSR2" high half of IADR (appears at PORT 0317h)
 03h	"CSR3" interrupt masks (see #P0555)
 04h	"CSR4" interrupt masks and status bits (see #P0556)
 08h-0Bh logical address filter
 0Ch-0Eh physical address register
 0Fh	"CSR15" mode (see #P0560)
 4Ch	"CSR76" receive descriptor ring length
 4Eh	"CSR78" transmit descriptor ring length
 50h	"CSR80" FIFO threshold / DMA burst control (see #P0564)
 52h	"CSR82" DMA bus timer
 58h	"CSR88" chip ID
 70h	"CSR112" number of missed packets
 72h	"CSR114" number of receive collisions
 7Ch	"CSR124" BMU test register
		bit 4: accept runt packets
SeeAlso: #P0570,#P0553

(Table P0553)
Values for AMD PCnet-SCSI/PCnet-FAST Register Data Port index:
 00h	"CSR0" status and control flags (see #P0554)
 01h	"CSR1" low half of IADR (appears at PORT 0316h)
 02h	"CSR2" high half of IADR (appears at PORT 0317h)
 03h	"CSR3" interrupt masks (see #P0555)
 04h	"CSR4" interrupt masks and status bits (see #P0556)
 05h	"CSR5" (PCnet-FAST) extended control and interrupt 1 (see #P0557)
 06h	"CSR6" receive/transmit descriptor table lengths (see #P0558)
 07h	"CSR7" (PCnet-FAST) extended control and interrupt 2 (see #P0559)
 08h-0Bh logical address filter
 0Ch-0Eh physical address register
 0Fh	"CSR15" mode (see #P0560)
 10h	"CSR16"	alias of CSR1
 11h	"CSR17"	alias of CSR2
 12h	"CSR18" low half of current receive buffer address
 13h	"CSR19" high half of current receive buffer address
 14h	"CSR20" low half of current transmit buffer address
 15h	"CSR21" high half of current transmit buffer address
 16h	"CSR22" low half of next receive buffer address
 17h	"CSR23" high half of next receive buffer address
 18h	"CSR24" low half of receive-ring base address
 19h	"CSR25" high half of receive-ring base address
 1Ah	"CSR26" low half of next receive descriptor address
 1Bh	"CSR27" high half of next receive descriptor address
 1Ch	"CSR28" low half of current receive descriptor address
 1Dh	"CSR29" high half of current receive descriptor address
 1Eh	"CSR30" low half of transmit ring base address
 1Fh	"CSR31" high half of transmit ring base address
 20h	"CSR32" low half of next transmit descriptor address
 21h	"CSR33" high half of next transmit descriptor address
 22h	"CSR34" low half of current transmit descriptor address
 23h	"CSR35" high half of current transmit descriptor address
 24h	"CSR36" low half of next next receive descriptor address
 25h	"CSR37" high half of next next receive descriptor address
 26h	"CSR38" low half of next next transmit descriptor address
 27h	"CSR39" high half of next next transmit descriptor address
 28h	"CSR40" current receive byte count (see #P0561)
 29h	"CSR41" current receive status
 2Ah	"CSR42" current transmit byte count (see #P0562)
 2Bh	"CSR43" current transmit status
 2Ch	"CSR44" next receive byte count (bits 11-0; bits 15-12=0)
 2Dh	"CSR45" next receive status
 2Eh	"CSR46" transmit poll time counter
 2Fh	"CSR47" transmit polling interval
 30h	"CSR48" receive poll time counter
 31h	"CSR49" receive polling interval
 32h-39h reserved
 3Ah	"CSR58" software style (see #P0563)
 3Bh	reserved
 3Ch	"CSR60" previous transmit descriptor address (low)
 3Dh	"CSR61" previous transmit descriptor address (high)
 3Eh	"CSR62" previous transmit byte count (bits 11-0; bits 15-12=0)
 3Fh	"CSR63" previous transmit status
 40h	"CSR64" next transmit buffer address (low)
 41h	"CSR65" next transmit buffer address (high)
 42h	"CSR66" next transmit byte count (bits 11-0; bits 15-12=0)
 43h	"CSR67" next transmit status
 44h-47h reserved
 48h	"CSR72" receive ring counter
 49h	reserved
 4Ah	"CSR74" transmit ring counter
 4Bh	reserved
 4Ch	"CSR76" receive descriptor ring length
 4Dh	reserved
 4Eh	"CSR78" transmit descriptor ring length
 4Fh	reserved
 50h	"CSR80" FIFO threshold / DMA burst control (see #P0564)
 51h	reserved
 52h	"CSR82" (PCnet-SCSI) DMA bus timer
		(PCnet-FAST) transmit descriptor address (low)
 53h	reserved
 54h	"CSR84" DMA address register (low)
 55h	"CSR85" DMA address register (high)
 56h	"CSR86" buffer byte counter (bits 11-0; bits 15-12=0)
 57h	reserved
 58h	"CSR88" chip ID (low 16 bits) (see #P0565)
 59h	"CSR89" chip ID (high 16 bits) (see #P0565)
 5Ah	"CSR90" (PCnet-SCSI)
 5Bh	reserved
 5Ch	"CSR92" ring length conversion
 5Dh	reserved
 5Eh	"CSR94" (PCnet-SCSI)
 5Fh-63h reserved
 64h	"CSR100" bus timeout
 65h-6Fh reserved
 70h	"CSR112" number of missed packets
 71h	reserved
 72h	"CSR114" number of receive collisions
 73h-79h reserved
 7Ah	"CSR122" advanced feature control (see #P0566)
 7Bh	reserved
 7Ch	"CSR124" BMU test register (see #P0567)
 7Dh	"CSR125" (PCnet-FAST) MAC Enhanced Configuration Control (see #P0568)
 7Eh-7Fh reserved
SeeAlso: #P0552,#P0594

Bitfields for AMD PCnet CSR0 status and control flags:
Bit(s)	Description	(Table P0554)
 15	"ERR"	error; set if BABL, CERR, MISS, or MESS set
 14	"BABL"	network babbling control
 13	"CERR"	collision error
 12	"MISS"	missed frame
 11	"MERR"	memory error
 10	"RINT"	receive interrupt
 9	"TINT"	transmit interrupt
 8	"IDON"	initialization done
 7	"INTR"	interrupt flag
 6	"IENA"	interrupt enable
 5	"RXON"	recieve ON
 4	"TXON"	transmit ON
 3	"TDMD"	transmit demand
 2	"STOP"	stop -- disable all external activity
 1	"STRT"	start -- enable extrnal activity
 0	"INIT"	begin initialization procedure
SeeAlso: #P0552,#P0555

Bitfields for AMD PCnet CSR3 interrupt masks:
Bit(s)	Description	(Table P0555)
 15	reserved
 14	"BABLM"	disable babble interrupt
 13	reserved
 12	"MISSM" disable missed-frame interrupt
 11	"MERM"	disable memory-error interrupt
 10	"RINTM"	disable receive interrupt
 9	"TINTM" disable transmit interrupt
 8	"IDONM" disable initialization-done interrupt
 7-5	reserved
 4	"DXMT2PD" disable Transmit Two Part Deferral
 3	"EMBA"	enable modified back-off algorithm
 2-0	reserved
Note:	other bits are reserved
SeeAlso: #P0552,#P0554,#P0556

Bitfields for AMD PCnet CSR4 interrupt masks and status bits:
Bit(s)	Description	(Table P0556)
 15	"ENTST"	   enable Test Mode / CSR124 access
 14	"DMAPLUS"  disable CSR80 burst transaction counter
 13	"TIMER"	   enable Bus Timer register
 12	"DPOLL"	   disable transmit polling
 11	"APADXMT"  Auto-Pad Transmit
 10	"ASTRPRCV" enable automatic pad stripping
 9	"MFCO"	   missed frame counter has overflowed
 8	"MFCOM"	   disable interrupt on MFCO
 7	"UINTCMD"  (PCnet-FAST) user interrupt command
 6	"UINT"	   (PCnet-FAST) user interrupt pending
			write 1 to clear
 5	"RCVCCO"   receive collision counter has overflowed
 4	"RCVCCOM"  disable interrupt on RCVCCO
 3	"TXSTRT"   Transmit Start
 2	"TXSTRTM"  disable interrupt on TXSTRT
 1	"JAB"	   Jabber error
 0	"JABM"	   disable interrupt on JAB
SeeAlso: #P0552,#P0555,#P0553

Bitfields for AMD PCnet-FAST CSR5 extended control and interrupt 1:
Bit(s)	Description	(Table P0557)
 31-16	reserved
 15	"TOKINTD"  disable Transmit OK interrupt
 14	"LTINTEN"  enable Last Transmit interrupt
 13-12	reserved
 11	"SINT"	   System Interrupt (write 1 to clear)
 10	"SINTE"	   enable System Interrupt
 9	"SLPINT"   Sleep Interrupt (write 1 to clear)
 8	"SLPINTE"  enable Sleep Interrupt
 7	"EXDINT"   Excessive Deferral Interrupt (write 1 to clear)
 6	"EXDINTE"  enable Excessive Deferral Interrupt
 5	"MPPLBA"   Magic Packet Physical Logical Broadcast Accept
 4	"MPINT"	   Magic Packet Interrupt (write 1 to clear)
 3	"MPINTE"   enable Magic Packet Interrupt
 2	"MPEN"	   enable Magic Packet mode
 1	"MPMODE"   Magic Packet mode active
 0	"SPND"	   Suspend
SeeAlso: #P0553,#P0556,#P0559

Bitfields for AMD PCnet CSR6 Descriptor Table Length register:
Bit(s)	Description	(Table P0558)
 15-12	transmit encoded ring length
 11-8	receive encoded ring length
 7-0	reserved
SeeAlso: #P0553,#P0557

Bitfields for AMD PCnet CSR7 Extended Control and Interrupt 2:
Bit(s)	Description	(Table P0559)
 15	"FASTSPNDE"  enable Fast Suspend
 14	"RXFRTG"     Receive Frame Tag
 13	"RDMD"	     Receive Demand
 12	"RXDPOL"     disable receive polling
 11	"STINT"	     Software Timer Interrupt (write 1 to clear)
 10	"STINTE"     enable Software Timer Interrupt
 9	"MREINT"     MII Management Read Error Interrupt (write 1 to clear)
 8	"MREINTE"    enable MII Management Read Error Interrupt
 7	"MAPINT"     MII Management Auto-Poll Interrupt (write 1 to clear)
 6	"MAPINTE"    enable MII Management Auto-Poll Interrupt
 5	"MCCINT"     MII Management Command Complete Interrupt (write 1 to clr)
 4	"MCCINTE"    enable MII Management Command Complete Interrupt
 3	"MCCIINT"    MII Management Command Complete Internal Interrupt
			(write 1 to clear)
 2	"MCCIINTE"   enable MII Manamagement Command Complete Internal Int.
 1	"MIIPDTINT"  MII PHY Detect Transition Interrupt (write 1 to clear)
 0	"MIIPDTINTE" enable MII PHY Detect Transition Interrupt
SeeAlso: #P0553,#P0557

Bitfields for AMD PCnet CSR15 mode flags:
Bit(s)	Description	(Table P0560)
 15	"PROM"	   promiscuous mode
 14	"DRCVBC"   disable Receive Broadcast
 13	"DRCVPA"   disable Receive Physical Address
 12	"DLNKTST"  disable Link Status
 11	"DAPC"	   disable Automatic Polarity Correction
 10	"MENDECL"  MENDEC loopback mode
 9	"LRT/TSEL" Low Receive Threshold
 8-7	"PORTSEL"  Port Select
		00  AUI
		01  10Base-T
		10  GPSI
		11  reserved
 6	"INTL"	   internal loopback
 5	"DRTY"	   disable retry
 4	"FCOLL"	   force collision
 3	"DXMTFCS"  disable Transmit CRC
 2	"LOOP"	   enable Loopback
 1	"DTX"	   disable transmitter
 0	"DRX"	   disable receiver
SeeAlso: #P0552,#P0556,#P0564

Bitfields for AMD PCnet CSR40 Current Receive Byte Count register:
Bit(s)	Description	(Table P0561)
 15-12	reserved (0)
 11-0	current receive byte count (copy of BCNT field of current receive
	  descriptor's RMD1)
SeeAlso: #P0553,#P0562

Bitfields for AMD PCnet CSR42 Current Transmit Byte Count register:
Bit(s)	Description	(Table P0562)
 15-12	reserved (0)
 11-0	current transmit byte count (copy of BCNT field of current receive
	  descriptor's TMD1)
SeeAlso: #P0553,#P0561

Bitfields for AMD PCnet CSR58 Software Style register:
Bit(s)	Description	(Table P0563)
 15-11	reserved (undefined)
 10	"APERREN"	enabled advanced parity error handling
 9	"CSRPCNET"	PCnet-ISA compatibility (read-only)
 8	"SSIZE32"	32-bit software structures for data blocks
 7-0	"SWSTYLE"	software style
		00h LANCE/PCnet-ISA (16-bit software structures)
		01h reserved
		02h PCnet-PCI (32-bit software)
		03h PCnet-PCI (32-bit software)
SeeAlso: #P0553

Bitfields for AMD PCnet CSR80 FIFO threshold and DMA burst control:
Bit(s)	Description	(Table P0564)
 15-14	reserved
 13-12	receive FIFO high-water mark; request DMA when N byte available
	00 = 16 bytes
	01 = 32 bytes
	10 = 64 bytes
 11-10	transmit starting point; start transmission after N bytes written
	00 = 4 bytes
	01 = 16 bytes
	10 = 64 bytes
	11 = 112 bytes
 9-8	transmit FIFO low-water mark; start DMA when room for N bytes
	00 = 8 bytes
	01 = 16 bytes
	10 = 32 bytes
 7-0	DMA burst register
SeeAlso: #P0552,#P0560

Bitfields for AMD PCnet Chip ID register (read-only):
Bit(s)	Description	(Table P0565)
 31-28	hardware version
 27-12	part number
	2623h = Am79C971
 11-1	manufacturer ID (0001h = AMD)
 0	reserved (1)
SeeAlso: #P0553

Bitfields for AMD PCnet CSR122 Advanced Feature Control register:
Bit(s)	Description	(Table P0566)
 15-1	reserved
 0	"RCVALGN"	DWORD-align received packets
SeeAlso: #P0553,#P0567

Bitfields for AMD PCnet CSR124 Test Register 1:
Bit(s)	Description	(Table P0567)
 15-5	reserved
 4	(PCnet-SCSI) accept runt packets
 3	(PCnet-FAST) accept runt packets
 2-0	reserved
SeeAlso: #P0553,#P0566

Bitfields for AMD PCnet-FAST CSR125 MAC Enhanced Configuration Control reg:
Bit(s)	Description	(Table P0568)
 15-8	inter-packet gap (reducing from default 96 can disrupt network)
 7-0	inter-frame spacing, part 1
SeeAlso: #P0553

(Table P0569)
Values for AMD PCnet-ISA ISA Bus Configuration Register index:
 00h	"MSRDA" width of DMA read signal
 01h	"MSWRA" width of DMA write signal
 02h	"MC"	ISA bus configuration (see #P0572)
 05h	"LED1"	LED1 signal control (see #P0573)
 06h	"LED2"	LED2 signal control (see #P0573)
 07h	"LED3"	LED3 signal control (see #P0573)
SeeAlso: #P0552,#P0594,#P0570

(Table P0570)
Values for AMD PCnet-SCSI Bus Configuration Register index:
 00h	"MSRDA" width of DMA read signal (reserved)
 01h	"MSWRA" width of DMA write signal (reserved)
 02h	"MC"	miscellaneous configuration (see #P0572)
 03h	reserved
 04h	"LINKST" link status
 05h	"LED1"	LED1 signal control (see #P0573) -- receive status
 06h	"LED2"	LED2 signal control (see #P0573)
 07h	"LED3"	LED3 signal control (see #P0573) -- transmit status
 08h-0Fh reserved
 10h	"IOBASEL"
 11h	"IOBASEU"
 12h	"BSBC"	burst size and bus control
 13h	"EECAS" EEPROM Control and Status
 14h	"SWS"	software style
 15h	"INTCON" reserved
SeeAlso: #P0553,#P0569,#P0571

(Table P0571)
Values for AMD PCnet-FAST Bus Configuration Register index:
 00h	"MSRDA"		width of DMA read signal (reserved)
 01h	"MSWRA"		width of DMA write signal (reserved)
 02h	"MC"		miscellaneous configuration (see #P0572)
 03h	reserved	!!!p.154
 04h	"LED0"	LED0 status
 05h	"LED1"	LED1 signal control (see #P0573) -- receive status
 06h	"LED2"	LED2 signal control (see #P0573)
 07h	"LED3"	LED3 signal control (see #P0573) -- transmit status
 08h	reserved
 09h	"FDC"		full-duplex control
 0Ah-0Fh reserved
 10h	"IOBASEL"	I/O base select (lo) -- reserved
 11h	"IOBASEU"	I/O base select (hi) -- reserved
 12h	"BSBC"		burst size and bus control
 13h	"EECAS"		EEPROM Control and Status
 14h	"SWS"		software style
 15h	"INTCON"	reserved
 16h	"PCILAT"	PCI-bus latency
 17h	"PCISID"	PCI subsystem ID
 18h	"PCISVID"	PCI subsystem vendor ID
 19h	"SRAMSIZ"	SRAM size
 1Ah	"SRAMB"		SRAM boundary
 1Bh	"SRAMIC"	SRAM interface control
 1Ch	"EBADDRL"	expansion bus address (low)
 1Dh	"EBADDRU"	expansion bus address (high)
 1Eh	"EBD"		expansion bus data port
 1Fh	"STVAL"		software timer value
 20h	"MIICAS"	MII control and status
 21h	"MIIADDR"	MII address
 22h	"MIIMDR"	MII management data
 23h	"PCIVID"	PCI vendor ID
SeeAlso: #P0553,#P0569,#P0570

Bitfields for AMD PCnet ISA bus configuration:
Bit(s)	Description	(Table P0572)
 3	EADISEL
 2	AWAKE
 1	ASEL
 0	XMAUSEL
SeeAlso: #P0570,#P0573

Bitfields for AMD PCnet LEDn signal control:
Bit(s)	Description	(Table P0573)
 15	LEDOUT
 14-8	reserved
 7	PSE
 6-5	reserved
 4	XMTE
 3	RVPE
 2	RCVE
 1	JABE
 0	COLE
SeeAlso: #P0570
----------P0300031F--------------------------
PORT 0300-031F - prototype cards
		Periscope hardware debugger
----------P030C030F--------------------------
PORT 030C-030F - AIMS LAB PC Radio
Range:	configurable to PORT 020Ch or PORT 030Ch
Notes:	writing a value with bit 3 set to one of these ports turns on the
	  radio; writing a value with bit 3 clear turns it off
	PORT 020Eh bits 1 indicates status of some kind
--------s-P03100311--------------------------
PORT 0310-0311 - MPU-401 MIDI UART
Range:	alternate address at PORT 0300h or PORT 0330h, occasionally at
	  PORT 0320h
----------P0310031F--------------------------
PORT 0310-031F - Philips CD-ROM player CM50
--------s-P03200321--------------------------
PORT 0320-0321 - MPU-401 MIDI UART
Range:	alternate address at PORT 0300h or PORT 0330h, occasionally at
	  PORT 0310h
----------P03200323--------------------------
PORT 0320-0323 - XT HDC 1   (Hard Disk Controller)
SeeAlso: PORT 01F0h-01F7h

0320  RW  data register
0321  -W  reset controller
0321  R-  read controller hardware status (see #P0574)
0322  R-  read DIPswitch setting on XT controller card
0322  -W  generate controller-select pulse
0323  -W  write pattern to DMA and INT mask register

Bitfields for XT hard disk controller hardware status:
Bit(s)	Description	(Table P0574)
 7-6	always 0
 5	logical unit number
 4-2	always 0
 1	error occurred
 0	always 0
----------P03240327--------------------------
PORT 0324-0327 - XT HDC 2   (Hard Disk Controller)
----------P0328032B--------------------------
PORT 0328-032B - XT HDC 3   (Hard Disk Controller)
----------P032B------------------------------
PORT 032B - GI1904 Scanner Interface Adapter
Range:	PORT 022Bh, PORT 026Bh, PORT 02ABh (default), PORT 02EBh, PORT 036Bh,
	  PORT 03ABh, PORT 03EBh
----------P032C------------------------------
PORT 032C - GS-IF Scanner Interface adapter
Range:	PORT 022Ch, PORT 026Ch, PORT 02ACh, PORT 02ECh (default),
	  PORT 032Ch, PORT 036Ch, PORT 03ACh, PORT 03ECh
Note:	many SPI 400dpi/800dpi gray / H/T handy scanner by Marstek, Mustek and
	  others use this interface
----------P032C032F--------------------------
PORT 032C-032F - XT HDC 4   (Hard Disk Controller)
----------P032C032F--------------------------
PORT 032C-032F - AMD InterWave
----------P03300331--------------------------
PORT 0330-0331 - MPU-401 MIDI UART
Range:	alternate address at PORT 0300h, occasionally at PORT 0310h or
	  PORT 0320h

0330  RW  data register
0331  R-  status register (see #P0575)
0331  -W  command register (see #P0576)
Note:	MPU-401 genarates an interrupt when MIDI code is ready; by reading
	  MIDI code from the data register this interrupt is cleared

Bitfields for MPU-401 status register:
Bit(s)	Description	(Table P0575)
 7	input ready
	=1 no data is available for reading
	=0 data is available for reading
 6	output ready
	=1 not ready to receive command/data byte
	=0 ready to receive command/data byte
 5-0	reserved
Note:	pending input seems to block the output
SeeAlso: #P0576

(Table P0576)
Values for MPU-401 commands (data go to/from PORT 0330h):
Command	Description		 Results  Parameter
 01h	send MIDI stop		   ACK	      -
 02h	send MIDI start		   ACK	      -
 03h	send MIDI continue	   ACK	      -
 15h	stop all (recording,	   ACK	      -
	  playback and MIDI)
 34h	return timing bytes	   ACK	      -
	  in stop mode
 35h	enable mode messages	   ACK	      -
	  to PC
 38h	enable system common	   ACK	      -
	  messages to PC
 39h	enable real time	   ACK	      -
	  messages to PC
 3Ch	use CLS sync		   ACK	      -
 3Dh	use SMPTE sync		   ACK	      -
 3Fh	enter UART mode		   ACK	      -
 80h	use MIDI sync		   ACK	      -
 81h	use FSK sync		   ACK	      -
 82h	use MIDI sync		   ACK	      -
 83h	enable metronome	   ACK	      -
 84h	disable metronome	   ACK	      -
 87h	enable pitch and	   ACK	      -
	  controller
 8Ah	disable data in stopped	   ACK	      -
	  mode
 8Bh	enable data in stop mode   ACK	      -
 8Ch	disable measure end	   ACK	      -
	  messages to host
 91h	enable ext MIDI control	   ACK	      -
 94h	disable clock to host	   ACK	      -
 95h	enable clock to host	   ACK	      -
 97h	enable system exclusive	   ACK	      -
	  messages to PC
 ACh	get MIDI version	 ACK,VER      -
 ADh	get revision		 ACK,REV      -
 Cxh	set timebase to x*24	   ACK	      -
	  ppqn (x>1)
 D0h	???			   ACK	      -
 DFh	???			   ACK	      -
 E0h	set tempo		   ACK	     BPS
 E4h	set clocks per click	   ACK	     CPC
 E6h	set beats per measure	   ACK	     BPM
 E7h	send all clocks to host	   ACK	    1 byte
					  (04h is sent)
 FFh	reset			   ACK	      -
Notes:	after receiving a command byte MPU-401 must reply with command
	  acknowledge byte FEh in data register
	command parameters are sent, and response bytes are received through
	  the data register
	no commands (except reset) can be issued in UART mode, and MPU-401
	  must be reset to leave UART mode
	Key:
		ACK	command acknowledge byte (FEh)
		VER	MIDI version number
			bits 7-4: major version
			bits 0-3: minor version
		REV	revision number
		BPS	beats per second (8..250)
		CPC	clocks per click
		BPM	beats per measure
SeeAlso: #P0576
----------P03300333--------------------------
PORT 0330-0333 - Adaptec 154xB/154xC SCSI adapter (default address)
Range:	four ports at any of 0130, 0134, 0230, 0234, 0330 (default) or 0334
Notes:	Adaptec AHA-154x adapters use ISA bus-mastering mechanism, and so
	  require the DMA channel to be programmed to the cascaded mode
	the original AHA-1540 only supported asynchronous SCSI data transfers,
	  and did not support scatter/gather operation
	AHA-154xA+ supports the target mode implementing the SCSI-2 processor
	  device model; it executes INQUIRY, TEST UNIT READY, and REQUEST SENSE
	  commands received from the initiators without CPU intervention; the
	  CPU is required to provide information only for the SEND/RECEIVE
	  commands; other commands are treated by the host adapter as invalid
	AHA-154xCF supports Fast SCSI data transfer; AHA-154xCP additionally
	  supports SCSI Configured AutoMagically (SCAM) protocol
	AHA-174x EISA SCSI adapters in "standard" mode "look like" AHA-154x
	there was also an AHA-1640, an MCA version of the AHA-154x
	BusLogic BT-545S and DTC 3290 seem to be "almost" compatible with
	  the Adaptec AHA-154x

0330  R-  status register (see #P0577)
0330  -W  control register (see #P0578)
0331  R-  data in register
0331  -W  command / data out register (see #P0580)
0332  R-  interrupt status register (see #P0579)
0333  R-  (AHA-154xC+) diagnostic register
	  cycles thru bytes 41h,44h,41h,50h when read ("ADAP")

Bitfields for AHA-154x status register:
Bit(s)	Description	(Table P0577)
 7	self-test in progress (STST)
 6	diagnostic failure (DIAGF)
 5	mailbox initialization required (INIT)
 4	adapter idle (IDLE)
 3	command register full (CDF)
 2	data register full (DF)
 1	reserved
 0	invalid command (INVDCMD)
Notes:	bit 0 is only valid from the time the host adapter command complete
	  interrupt is set (bit 2 in the interrupt flag register) until it is
	  reset
	the data in register should only be read if bit 2 is set; reading the
	  data in register resets this bit
	command / data out register should only be written if bit 3 is zero;
	  the host adapter usually clears this bit within 100 mcs after CPU
	  writes to the command / data out register
	bit 4 indicates that the host adapter has no outstanding adapter or
	  SCSI commands
	bit 5 indicates that the mailbox initialization command (01h) required
	bit 7 is asserted after a power-on or hard reset (bit 7 in the control
	  register); when diagnostics is complete, this bit is reset and bit 5
	  or bit 6 is set to indicate seccessful or unsuccessful completion;
	  if the bit remain set, then initialization/diagnostic could not be
	  completed
	if bit 6 is set indication failed diagnostics, only the hard reset
	  (bit 7 in the control register) will clear it
SeeAlso: #P0578,#P0579,#P0580

Bitfields for AHA-154x control register:
Bit(s)	Description	(Table P0578)
 7	hardware reset (HRST)
 6	software reset (SRST)
 5	interrupt reset (IRST)
 4	SCSI bus reset (SCRST)
 0-3	reserved
Notes:	setting bit 4 causes the host adapter to assert the RST signal on the
	  SCSI bus for 25 microseconds (reset hold time); the reset is
	  managed as a SCSI soft reset, and will allow partially completed
	  operations to continue; use bit 7 to force a SCSI hard reset
	setting bit 5 clears all bits in the interrupt flag register and resets
	  the interrupt
	setting bit 6 clears all ongoing SCSI and host adapter commands
	setting bit 7 forces the host adapter into a state identical to a
	  normal power on state: diagnostic functions are executed and all
	  status for ongoing SCSI operations is lost, a reset condition is
	  generated on the SCSI bus; while the reset is being processed, bit 7
	  on the status register is set
	when soft/hard reset is complete, bits 4 and 5 of the status register
	  are set
SeeAlso: #P0577

Bitfields for AHA-154x interrupt status register:
Bit(s)	Description	(Table P0579)
 7	any interrupt (ANYINTR)
 4-6	reserved
 3	SCSI reset detected (SCRD)
 2	host adapter command complete (HACC)
 1	mailbox out available (MBOA)
 0	mailbox in full (MBIF)
Notes:	bit 0 indicates that an entry has been placed by the host adapter in
	  the mailbox in; this interrupt should be reset as soon as possible
	bit 1 indicates that an outbound mailbox entry is now available for use
	bit 2 indicates that an adapter command has been completed; bit 0 of
	  the status register will indicate success or failure; during the
	  parameter transfers to/from the host adapter, this bit should be
	  examined to verify that the command has not been ended abnormally
	bit 3 indicates that a SCSI reset has been received on the SCSI bus;
	  CPU can convert the SCSI soft reset to the SCSI hard reset by setting
	  bit 6 of the control register upon the detection of the SCSI reset
	  interrupt; it is not set for the CPU-initiated SCSI reset (via bit
	  4 of the control register)
	if the host adapter command complete and SCSI reset detected interrupts
	  are present, the mailbox in full and mailbox out available interrupts
	  are not presented until the former are cleared
	if bit 7 of this register or bit 2 of the status register is set, host
	  adapter command complete and SCSI reset detected interrupts will not
	  be presented until the interrupts already present are cleared
SeeAlso: #P0577,#P0581

(Table P0580)
Values for AHA-154x host adapter commands:
Command	Description		   Parameters		Results
 00h	no operation		   -			-
 01h	mailbox initialization	   MBC,MBA0..MBA2	-
 02h	start SCSI command	   -			-
 03h	start PC/AT BIOS command   BFN,TRG,CH,CLHH,	-
				   HL,SN,SC,BA0..BA2
 04h	adapter inquiry		   -			BID,SOID,FWR0,FWR1
 05h	enable mailbox out	   E/D			-
	  interrupt
 06h	set selection time-out	   E/D,00h,TO0,TO1	-
 07h	set bus on time		   BON			-
 08h	set bus off time	   BOFF			-
 09h	set AT bus transfer speed  ATBS			-
 0Ah	return installed devices   -			TC0..TC7
 0Bh	return configuration data  -			DAP,IC,SID
 0Ch	enable target mode	   E/D,LUM		-
	  (not AHA-1540/W1542A)
 0Dh	return setup data	   DIL			SPS,ATBS,BON,BOFF,
							MBC,MBA0..MBA2,
							STA0..STA7,DS
							(see #P9001)
 10h	intialize SCSI subsystem   ???			???
	  (AHA-174x in std mode)
 11h	return formware checksum   -			CS0,CS1
	  (AHA-174x in std mode)
 1Ah	write adapter channel 2	   BA0..BA2		-
	  buffer
 1Bh	read  adapter channel 2	   BA0..BA2		-
	  buffer
 1Ch	write adapter FIFO buffer  BA0..BA2		-
 1Dh	read  adapter FIFO buffer  BA0..BA2		-
 1Fh	echo command data	   EV			EV
 20h	run adapter diagnostics	   -			-
	  (AHA-1542B+)
 21h	set adapter options	   ESG,DS		-
 21h	set adapter options	   NOB, adapter opts	-
	  (AHA-1542B+)			(see #P9005)
 22h	program EEPROM		   00h,NED,SEA,
	  (AHA-1542C+)		   EEPROM data		-
				   (see #P9002)
 23h	return EEPROM data	   D/C,NED,EA		EEPROM data bytes
	  (AHA-1542C+)					(see #P9002)
 24h	set shadow RAM parameters  SRP			-
	  (AHA-1542C+)
 25h	BIOS mailbox initializa-   MBC,MBA0..MBA2	-
	  tion (since AHA-1540B
	  rev. 1.4?)
 26h	set BIOS bank 1		   -			-
	  (AHA-1542C+)
 27h	set BIOS bank 2		   -			-
	  (AHA-1542C+)
 28h	return extended BIOS	   -			F,MBLT
	  information (since
	  AHA-1540B rev. 1.4?)
 29h	enable mailbox interface   MBU,MBLT		-
	  (since AHA-1540B
	  rev. 1.4?)
 2Ah	??? (AHA-154xC)		   -			-
 2Ch	detect termination
	  setting??? (AHA-1542CP)  -			TS
 2Dh	detect SCAM devices???	   -			IDA,???
	  (AHA-1542CP)
 34h	set SCSI ID configuration  SID,IDC		-
	  (AHA-154xCF+)
 41h	AMI inquiry (AMI-4448)	   SL			C0..C3,M0..M5,
							S0..S5,V0..V5
							(see #P9003)
 82h	start BIOS SCSI command	   -			-
	  (since AHA-1540B
	  rev. 1.4?)
 8Dh	exteded setup information  DIL?			???
	  (since AHA-1540B
	  rev. 1.4?)
Note:	ATBS	   AT bus transfer speed (see #P9004)
		   00h,AAh 5.0	MB/s
		   01h,99h 6.7	Mb/s
		   02h	   8.0	Mb/s
		   03h,88h 10.0 Mb/s
		   04h	   5.7	Mb/s
		   BBh	   4.0	Mb/s?
		   CCh	   3.3	Mb/s?
		   DDh	   2.9	Mb/s?
		   EEh	   2.5	Mb/s?
		   FFh	   2.2	Mb/s?
	BA0..BA2   MSB..LSB of the physical address of the data buffer
	BFN	   BIOS function number (00h-04h,08h,09h,0Ch-11h,14h,15h)
	BID	   board ID
		   00h AHA-1540 (16-head BIOS)
		   20h BusLogic BT-545S
		   30h AHA-1540 (64-head BIOS)
		   31h AHA-1540
		   41h AHA-154xA/154xB (64-head BIOS)
		   42h AHA-1640 (64-head BIOS)
		   43h AHA-174x
		   44h AHA-1542C
		   45h AHA-1542CF
	BOFF	   bus off time (in microseconds)
		   time the adapter stays off the AT bus when transferring data
		     1..64 mcs, default 4 mcs
	BON	   bus on time (in microseconds)
		   time the adapter stays on the AT bus when transferring data
		     2..15 mcs, default 11 mcs
	CH	   bits 7-4: reserved
		   bits 3-0: bits 9-6 of cylinder number
	CLHH	   bits 7-2: bits 5-0 of cylinder number
		   bits 1-0: bits 5-4 of head number
	CS0,CS1	   checksum of the standard mode microcode
	D/C	   default/current EEPROM data (00h default, 01h current)
	DAP	   DRQ arbitration priority
		   bit 7: channel 7
		   bit 6: channel 6
		   bit 5: channel 5
		   bits 4-1: reserved (0)
		   bit 0: channel 0
	DIL	   data in length
		   number of bytes to return (0 means 256 bytes)
	DS	   (AHA-154xB+?) disconnect status
		   bit N is set if target ID N is unable to disconnect?
	E/D	   enable/diable parameter
		   00h disable
		   01h enable
	EA	   EEPROM address to read data from
	ESG	   01h: enable scatter/gather
	EV	   echo value (to be echoed back)
	F	   flags
		   bits 7-4: reserved??? (0)
		   bit 3: extended BIOS translation (255 heads / 63 sectors)
		   bits 2-0: reserved??? (0)
	FWR0,FWR1  firmware revision (alphanumeric)
	GS	   global setting byte
		   bits 7-6: reserved (0)
		   bit 5: enable parity check
		   bit 4: reserved (0)
		   bit 3: enable synchronous transfer
		   bit 2: enable disconnection
		   bits 1-0: reserved (0)
	HL	   bits 7-4: reserved
		   bits 3-0: bits 3-0 of head number
	IDA	   SCAM IDs assigned
		   bit N is set if a target ID N was assigned to a SCAM device
	IDC	   SCSI ID configuration (see #P9006)
	IRQ	   interrupt channel
		   bit 7: reserved (0)
		   bit 6: IRQ15
		   bit 5: IRQ14
		   bit 4: reserved (0)
		   bit 3: IRQ12
		   bit 2: IRQ11
		   bit 1: IRQ10
		   bit 0: IRQ9
	LUM	   logical unit mask
		   bit N is set if LUN N is to respond in target mode
	MBA0..MBA2 MSB..LSB of the physical address of the mailbox area
		     (see #P0581)
	MBC	   mailboxes count (nonzero), max. 1 for BIOS mailboxes
	MBLT	   mailbox lock type
		   01h translation  lock (for extended BIOS)
		   02h dynamic scan lock
		   others reserved
	MBU	   00h: mailbox unlock
	NED	   number of EEPROM data bytes to read/write
	NOB	   number of adapter option bytes
	SC	   sector count
	SEA	   starting EEPROM address
	SID	   SCSI ID
		   bits 7-3: reserved (0)
		   bits 2-0: binary value of SCSI ID
	SL	   string length
	SN	   sector number - 1
	SOID	   special options ID
		   30h ???
		   41h standard model
	SPS	   SDT and parity status
		   bits 7-2: reserved (0)
		   bit 1: SCSI parity check enabled
		   bit 0: synchronous negotiation initiated
	SRP	   shadow RAM parameters
	STA0..STA7 synchronous transfer agreements for target ID 0..7
		   bit 7: synchronous transfer negotiated
		   bits 6-4: value defining synchronous transfer period
			     period in ns can be calculated as 200+50*value
		   bits 3-0: negotiated offset value
	TC0..TC7   target 0..7 configuration
		   bit M in byte N is set if SCSI ID N LUN M is installed
	TO0,TO1	   MSB, LSB of the time-out value (in ms)
		   default 250 ms
	TRG	   bits 7-5: target ID
		   bits 4-0: reserved
	TS	   termination setting (see #P9004)
Notes:	all commands except 02h, 05h, 82h should only be issued if the host
	  adapter is idle (bit 4 in the status register set)
	command 02h can be issued even if the command / data out register is
	  full (bit 3 in the status register may be set)
	command 02h causes host adapter to scan both its SCSI and BIOS mailbox
	  areas; command 82h causes host adapter to scan only BIOS mailbox area
	all commands except 02h and 05h cause host adapter command complete
	  interrupt (bit 2 in the interrupt flag register) after completetion;
	  command 05h will still generate the interrupt if its parameter was
	  invalid
	return installed devices command (0Ah) results in the host adapter
	  issuing the TEST UNIT READY command to each target/LUN combination
	return setup data command (0Dh) returns the number of bytes requested
	  with DIL parameter
	for read/write channel 2 buffer commands (1Bh/1Ah) data buffer must be
	  64 bytes long; for read/write FIFO buffer commands (1Dh/1Ch) it must
	  be 54 bytes long
	set adapter options command (21h) takes the number of option bytes
	  specified with NOB parameter
	BusLogic BT-545S gets the adapter inquiry command (04h) wrong returning
	  only one byte instead of four; DTC 3290 gets this command wrong too
	AMI inquiry command (41h) returns the number of bytes requested
	  with SL parameter
SeeAlso: #P0577,#P0579

(Table P9000)
Values for AHA-154x AT bus transfer speed:
 00h	5.0 MB/s
 01h	6.7 MB/s
 02h	8.0 MB/s
 03h	10.0 MB/s
 04h	5.7 MB/s
 88h	10.0 MB/s
 99h	6.7 MB/s
 AAh	5.0 MB/s
 BBh	4.0 MB/s???
 CCh	3.3 MB/s???
 DDh	2.9 MB/s???
 EEh	2.5 MB/s???
 FFh	2.2 or 3.3 MB/s???
SeeAlso: #P0580

Format of AHA-154x setup data:
Offset	Size	Description	(Table P9001)
 00h	BYTE	SDT and parity status
		bits 7-2: reserved (0)
		bit 1: SCSI parity check enabled
		bit 0: synchronous negotiation initiated
 01h	BYTE	AT bus transfer speed (see #P9000)
 02h	BYTE	bus on	time (in mcs)
 03h	BYTE	bus off time (in mcs)
 04h	BYTE	number of mailboxes (00h = the mailbox initialization command
		  has not yet been successfully completed)
 05h  3 BYTEs	big-endian physical address of the mailbox area (see #P0581)
 08h  8 BYTEs	synchronous transfer agreements for target ID 0-7
		bit 7: synchronous transfer negotiated
		bits 6-4: value defining synchronous transfer period
			    period (in ns) can be calculated as 200+50*value
		bits 3-0: negotiated offset value
 10h	BYTE	(AHA-154xB+?) disconnect status
		bit N is set if target ID N is unable to disconnect?
 11h 20 BYTEs	reserved (0)
 25h	BYTE	???
 26h	BYTE	???
 27h	WORD	??? (big-endian)
 29h 3 BYTEs	big-endian physical address of the BIOS mailbox (see #P0581)
SeeAlso: #P9002,#P9005,#P0580

Format of AHA-154xC+ EEPROM data:
Offset	Size	Description	(Table P9002)
 00h	BYTE	bit 7: (AHA-154xCF) floppy controller I/O port
			 (0 = 3F0h, 1 = 370h)
		bit 6: ???
		bit 5: EDD support enabled
		bit 4: ???
		bit 3: ???
		bits 2-0: host adapter SCSI ID
 01h	BYTE	bit 7: ???
		bits 6-4: DMA priority (0 and 5-7 are valid)
		bit 3: ???
		bits 2-0: interrupt channel (IRQ) (IRQ - 9; 7/4 invalid)
			  000 IRQ9
			  001 IRQ10
			  010 IRQ11
			  011 IRQ12
			  100 reserved
			  101 IRQ14
			  110 IRQ15
			  111 reserved
 02h	BYTE	BIOS features
		bit 7: extended BIOS translation for drives >1G enabled
		bit 6: ???
		bit 5: immediate return on seek command enabled
		bit 4: BIOS support for more than 2 drives enabled
		bit 3: dynamically scan SCSI bus for BIOS devices
		bit 2: system boot (INT 19h) controlled by host adapter BIOS
		bit 1: host adapter BIOS (configuration utility reserved BIOS
			 space) enabled
		bit 0: support removable disks under BIOS as fixed disks
 03h	BYTE	DMA transfer rate (see #9001)
 04h	BYTE	bit 7: BIOS support for the floptical drives enabled
		bit 6: don't display <Ctrl-A> message during BIOS initialization
		bits 5-4: ???
		bits 3-0: bus on  time
 05h	BYTE	bit 7: ???
		bits 6-0: bus off time
 06h	BYTE	bit 7: (AHA-154xCP) somehow related to SCSI termination???
		bit 6: (AHA-154xCP) somehow related to SCAM???
		bit 5: ???
		bits 4-3: reserved??? (0)
		bit 2: reset SCSI bus at power-on
		bit 1: host adapter SCSI termination enabled
		bit 0: SCSI parity checking enabled
 07h  7 BYTEs	???
 0Eh  8 BYTEs	SCSI ID 0-7 configuration (see #P9006)
 16h  8 BYTEs	reserved??? (0)
 1Eh	BYTE	??? (41h)
 1Fh	BYTE	??? (06h)
SeeAlso: #P9001,#P0580

Format of AHA-154xC+ SCSI ID configuration:
Offset	Size	Description	(Table P9006)
 7-5:	???
 4	ignore	in BIOS scan
 3	send START UNIT command
 2	enable Fast SCSI
 1	enable disconnection
 0	enable synchronous negotation
SeeAlso: #P9002

Format of AMI ID string:
Offset	Size	Description	(Table P9003)
 00h  4 BYTEs	ASCIZ company string ("AMI")
 04h  6 BYTEs	ASCIZ model string
 0Ah  6 BYTEs	ASCIZ series string ("48")
 10h  6 BYTEs	ASCIZ version string ("1.00")
SeeAlso: #P0580

Format of AHA-154xCP termination setting byte:
Offset	Size	Description	(Table P9004)
 7-6	detection result
	00 fewer than 2 terminators
	01 2 terminators
	10 unable to detect
	11 more than 2 terminators
 5-4	???
 3-0	???
Note:	if bits 7-6 are zero and bits 5-4 are not, ASPI4DOS.SYS complains that
	  fewer than 2 terminators detected
SeeAlso: #P0580

Format of AHA-154xB+ adapter options:
Offset	Size	Description	(Table P9005)
 00h	BYTE	disconnect status
		bit N is set if target ID N is unable to disconnect?
 01h	BYTE	(AHA-154xC) ???
Note:	byte at offset 01h is the same as at offset 25h in the setup data
SeeAlso: #P9004

Format of AHA-154x mailbox array:
Offset	Size	Description	(Table P0581)
 00h  N*4 BYTEs	array of N "out" mailboxes (MBO) (see #P0582)
 N*4  N*4 BYTEs	array of N "in" mailboxes (MBI) (see #P0584)
Notes:	the MBO entries are scanned by the host adapter in a round-robin
	  fashion, i.e. the host adapter first looks into an MBO which follows
	  the one least recently used (and wraps around if it was the last one)
	the MBI entries are filled in a round-robin fashion, so the CPU should
	  check the next MBI entry after the last one that was found when a new
	  mailbox in full (bit 0 in the interrupt flag register) interrupt; CPU
	  should also check the next MBI entries to determine if more than one
	  MBI is ready
	MBI entries are absent in case of BIOS mailboxes; in this case MBI
	  status code is returned in the command linking ID field of the
	  command control block (CCB)
	target mode CCB may be posted to the host adapter in anticipation of
	  the SCSI command reception, with the direction bits indicating the
	  expected transfer directiin (i.e. SEND or RECEIVE command); if a SCSI
	  command is received by the host adapter before the CCB is prepared,
	  it requests a CCB from the host through the MBI
SeeAlso: #P0577,#P0579,#P0583,#P0585,#P0587

Format of AHA-154x mailbox-out (MBO) entry:
Offset	Size	Description	(Table P0582)
 00h	BYTE	mailbox command/status code (see #P0583,#P0585)
 01h  3 BYTEs	address of the command control block (CCB) (see #P0586)
		physical address in big-endian format
SeeAlso: #P0577,#P0581,#P0584

(Table P0583)
Values for mailbox out command codes:
 00h	mailbox/CCB is free
 01h	start CCB
 02h	abort CCB
SeeAlso: #P0577,#P0581,#P0585

Format of mailbox-in (MBI) entry:
Offset	Size	Description	(Table P0584)
 00h	BYTE	MBI status code (see #0584)
---MBI status code 10h---
 01h	BYTE	initiator and LUN
		bits 7-5: SCSI initiator ID
		bit 4: RECEIVE command received
		bit 3: SEND command received
		bits 2-0: LUN
 02h	WORD	data length
		2 high bytes of the data length in SCSI SEND/RECEIVE command
		in big-endian format
---other MBI status codes---
 01h  3 BYTEs	CCB pointer
		physical address in big-endian format
SeeAlso: #P0582,#P0577,#P0581,#P0587

(Table P0585)
Values for mailbox in status codes:
 00h	command in progress
 01h	CCB completed
 02h	CCB aborted
 03h	CCB abort failed
 04h	CCB completed with error
SeeAlso: #P0584,#P0581,#P0583

Format of AHA-154x command control block (CCB):
Offset	Size	Description	(Table P0586)
 00h	BYTE	CCB operation code (see #P0587)
---operation code 00h---
 01h	BYTE	address and control (see #P0601)
 02h	BYTE	SCSI command length
 03h	BYTE	request sense allocation length
		00h request 14 bytes of sense data
		01h disable auto-sense
		02h-07h reserved
		08h-FFh sense data length
 04h  3 BYTEs	data length
		in big-endian format
 07h  3 BYTEs	data pointer
		physical address in big-endian format
 0Ah  3 BYTEs	link pointer (link to the next CCB for the linked commands)
		physical address in big-endian format
 0Dh	BYTE	command linking ID (for the linked commands)
		(return) MBI status code if this CCB is in a BIOS mailbox
		  (see #P0585)
 0Eh	BYTE	(return) host adapter status (HASTAT) (see #P0589)
 0Fh	BYTE	(return) target device status (TARSTAT)
		SCSI status byte
 10h  2 BYTEs	reserved
 12h  N BYTEs	SCSI command descriptor block (CDB)
 12h+N M BYTEs	allocated for sense data
		(return) sense data (if requested)
---operation code 01h---
 01h	BYTE	address and control
		bits 7-5: initiator ID
		bits 4-3: transfer direction
			  01 SEND command
			  10 RECEIVE command
			  00,11 illegal combination
		bits 2-0: LUN
 02h	BYTE	SCSI command length
 03h	BYTE	request sense allocation length
 04h  3 BYTEs	data length
 07h  3 BYTEs	data pointer
 0Ah  4 BYTEs	reserved
 0Eh	BYTE	(return) host adapter status (see #P0589)
 0Fh	BYTE	(return) target device status
 10h  2 BYTEs	reserved
 12h  N BYTEs	(return) SCSI CDB
 12h+N M BYTEs	allocated for sense data
		(return) sense data (to be sent to the initiator)
---operation code 02h---
 01h	BYTE	address and control (see #P0601)
 02h	BYTE	SCSI command length
 03h	BYTE	request sense allocation length
 04h  3 BYTEs	data segment list length (in bytes)
		in big-endian format
 07h  3 BYTEs	data segment list pointer
		physical address in big-endian format
 0Ah  3 BYTEs	link pointer
 0Dh	BYTE	command linking ID
		(return) MBI status code if this CCB is in a BIOS mailbox
		  (see #P0585)
 0Eh	BYTE	(return) host adapter status (see #P0589)
 0Fh	BYTE	(return) target device status
 10h  2 BYTEs	reserved
 12h  N BYTEs	SCSI CDB
 12h+N M BYTEs	allocated for sense data
		(return) sense data (if requested)
---operation code 03h---
 01h	BYTE	address and control (see #P0601)
 02h	BYTE	SCSI command length
 03h	BYTE	request sense allocation length
 04h  3 BYTEs	data length
		(return) residual length
 07h  3 BYTEs	data pointer
 0Ah  3 BYTEs	link pointer
 0Dh	BYTE	command linking ID
		(return) MBI status code if this CCB is in a BIOS mailbox
		  (see #P0585)
 0Eh	BYTE	(return) host adapter status (see #P0589)
 0Fh	BYTE	(return) target device status
 10h  2 BYTEs	reserved
 12h  N BYTEs	SCSI CDB
 12h+N M BYTEs	allocated for sense data
		(return) sense data (if requested)
---operation code 04h---
 01h	BYTE	address and control (see #P0601)
 02h	BYTE	SCSI command length
 03h	BYTE	request sense allocation length
 04h  3 BYTEs	data segment list length (in bytes)
		(return) residual length
 07h  3 BYTEs	data segment list pointer
 0Ah  3 BYTEs	link pointer
 0Dh	BYTE	command linking ID
		(return) MBI status code if this CCB is in a BIOS mailbox
		  (see #P0583)
 0Eh	BYTE	(return) host adapter status (see #P0589)
 0Fh	BYTE	(return) target device status
 10h  2 BYTEs	reserved
 12h  N BYTEs	SCSI CDB
 12h+N M BYTEs	allocated for sense data
		(return) sense data (if requested)
---operation code 81h---
 01h	BYTE	address and control
		bits 7-5: target ID
		bits 4-0: reserved
Note:	if a SCSI command completes with the BUSY status, the host adapter
	  periodically restarts it until it completes with other status
	if a SCSI command completes with the CHECK CONDITION status, the host
	  adapter automatically issues a REQUEST SENSE command with the data
	  length specified by request sense allocation length field; the actual
	  bytes returned are placed in the area allocated for sense data; but
	  if the request sense allocation length was 01h, no REQUEST SENSE
	  command is issued
	if the host adapter completes a SCSI command with the CHECK CONDITION
	  status while it is operating in the target mode, the same sense data
	  that will later be received by the initiator is also placed in the
	  area allocated for sense data
	command linking is not supported in target mode
	for a target mode CCB target device status field is used to indicate
	  to the host what status the host adapter returned to the initiator;
	  SCSI CDB field is used to return the CDB from the initiator
SeeAlso: #P0577,#P0582,#P0584

(Table P0587)
Values for CCB type:
 00h	initiator CCB
 01h	target CCB (not on AHA-1540/W1542A)
 02h	initiator CCB with scatter/gather (see #P0590) (not on AHA-1540)
 03h	initiator CCB with residual length (AHA-154xB or higher)
 04h	initiator CCB with scatter/gather and residual length (see #P0590)
	(AHA-154xB or higher)
 81h	bus device reset CCB
Note:	residual length is returned in the data length field of CCB
	initiator CCB with scatter/gather cannot have a zero data length or
	  contain more than 16 entries
SeeAlso: #P0577,#P0586

Bitfields for the initiator mode address and control CCB field:
Bit(s)	Description	(Table P0601)
 7-5	target ID
 4-3	transfer direction
	00 determined by the SCSI command
	01 inbound data	 transfer, length is checked
	10 outbound data transfer, length is checked
	11 no data transfer (suppress inbound data transfer)
 2-0	LUN
SeeAlso: #P0586,#P0589

(Table P0589)
Values for host adapter status:
 00h	command complete
 0Ah	linked command complete (linked CCBs only)
 0Bh	linked command complete with flag (linked CCBs only)
 11h	selection time out
 12h	data overrun/underrun
 13h	unexpected bus free
 14h	target bus phase sequence failure
 15h	invalid mailbox out command
 16h	invalid CCB operation code
 17h	linked CCB does not have the same LUN
 18h	(not AHA-1540/W1542A) invalid target direction received from host
	  (target mode)
 19h	(not AHA-1540/W1542A) duplicate CCB received (target mode)
 1Ah	invalid CCB or segment list parameter
Notes:	in the initiator mode, if the target attempted to transfer more data
	  than was allocated by the data length field or the sum of the data
	  segment length fields, and the length checking was enabled via bits
	  4-3 of the address and control field, the CCB will be returned with a
	  host status of 12h; if the length checking was not enabled, command
	  will be completed without error
	in the target mode, if the transfer length specified by the SEND/
	  RECEIVE command is not equal to that specified in the target mode CCB
	  the host adapter will notify the CPU, setting the incorrect length
	  indication bit (ILI), bit 5 of byte 2 in the area allocated for sense
	  data; also, bytes 3..6 in this area will contain the residue of the
	  length requested in the SSCI command and the data length in the CCB
	  (MSB first); if it is negative the GOOD status will be returned to
	  the initiator, else the CHECK CONDITION status will be returned (with
	  subsequent REQUEST SENSE returning ILI in byte 2 and residue in bytes
	  3..6 of the sense data); the CCB will be returned with a host status
	  of 12h in both cases
	  will be completed without error
	in case of target bus sequence failure host adapter will generate a
	  SCSI reset condition setting bit 3 in the interrupt flag register and
	  generating an interrupt
	in target mode one CCB may be presented for each unique combination of
	  LUN, Initiator, and direction; if a second CCB to the same LUN and
	  initiator with the same direction bit is sent to the host adapter,
	  the CCB will be returned with a host status of 19h
	if a segment list with a zero length segment or invalid segment list
	  boundaries was received or a CCB parameter was invalid, the CCB will
	  be returned with a host status of 1Ah
SeeAlso: #P0577,#P0586,#P0601

Format of AHA-154x scatter/gather segment:
Offset	Size	Description	(Table P0590)
 00h  3 BYTEs	data length
		in big-endian format
 03h  3 BYTEs	data pointer
		physical address in big-endian format
Note:	if the segment ends at odd/even bondary, the next segment must begin
	  on the same boundary
SeeAlso: #P0577
----------P0330033F--------------------------
PORT 0330-033F - CompaQ SCSI adapter. alternate address at 0130
--------d-P0330033F--------------------------
PORT 0330-033F - Philips CD-ROM player CM50
--------d-P03340337--------------------------
PORT 0334-0337 - Adaptec 154xB/154xC SCSI adapter.
Range:	four ports at any of 0130, 0134, 0230, 0234, 0330 (default) or 0334
--------s-P0338------------------------------
PORT 0338 - AdLib soundblaster card
--------S-P0338033F--------------------------
PORT 0338-033F - COM port addresses on UniRAM card by German magazine c't
Range:	selectable from 0238, 02E8, 02F8, 0338, 03E0, 03E8, 03F8
----------P0340034F--------------------------
PORT 0340-034F - Philips CD-ROM player CM50
----------P0340034F--------------------------
PORT 0340-034F - SCSI (1st Small Computer System Interface) adapter
Range:	alternate address at 0140-014F
--------s-P0340------------------------------
PORT 0340 - Crystal Semiconductor CDB4922 evaluation board
Desc:	the CDB4922 is an evaluation board for the CS4922 MPEG audio
	  decoder (see I2C xxh"CS4922")
--------s-P0340034F--------------------------
PORT 0340-034F - Gravis Ultra Sound by Advanced Gravis
Range: The I/O address range is dipswitch selectable from:
	   0200-020F and 0300-030F
	   0210-021F and 0310-031F
	   0220-022F and 0320-032F
	   0230-023F and 0330-033F
	   0240-024F and 0340-034F
	   0250-025F and 0350-035F
	   0260-026F and 0360-036F
	   0270-027F and 0370-037F
Note:	the AMD InterWave chip provides a superset of the UltraSound's
	  functionality, including these ports
SeeAlso: PORT 0240h-024Fh,PORT 0746h

0340  -W  MIDI Control (see #P0591)
0340  R-  MIDI Status (see #P0592)
0341  -W  MIDI Transmit Data
0341  R-  MIDI Receive Data
0342  RW  GF1 Page Register / Voice Select
0343  RW  GF1/Global Register Select (see #P0593)
0344  RW  GF1/Global Data Low Byte (16 bits)
0345  RW  GF1/Global Data High Byte (8 bits)
0346  -W  Mixer Data Port
0347  RW  GF1 DRAM
		 Direct Read Write at Loction pointed with regs 43 and 44

Bitfields for Gravis Ultra Sound MIDI control register:
Bit(s)	Description	(Table P0591)
 7	   Receive IRQ (1 = enabled)
 5-6   Xmit IRQ
 0-1   Master Reset (1 = enabled)
SeeAlso: #P0546,#P0548,#P0592

Bitfields for Gravis Ultra Sound MIDI status register:
Bit(s)	Description	(Table P0592)
 7	Interrupt pending
 5	Overrun Error
 4	Framing Error
 1	Transmit Register Empty
 0	Receive Register Empty
SeeAlso: #P0591,#P0593

(Table P0593)
Values for Gravis Ultra Sound GF1/Global Registers:
---Voice specific registers---
 00h  w	    Voice Control (see #P0595)
 01h  w	    Frequency Control
	     bit 15-10	 Integer Portion
	     bit 9-1	 Fractional Portion
 02h  w	    Start Address HIGH
	     bit 12-0	 Address Lines 19-7
 03h  w	    Start Address LOW
	     bit 15-9	 Address Lines 6-0
	     bit 8-5	 Fractional Part of Start Address
 04h  w	    End Address HIGH
	     bit 12-0	 Address Lines 19-7
 05h  w	    End Address LOW
	     bit 15-9	 Address Lines 6-0
	     bit 8-5	 Fractional Part of End Address
 06h  w	    Volume Ramp Rate
	     bit 5-0	 Amount added
	     bit 7-6	 Rate
 07h  w	    Volume Ramp Start
	     bit 7-4	 Exponent
	     bit 3-0	 Mantissa
 08h  w	    Volume Ramp End
	     bit 7-4	 Exponent
	     bit 3-0	 Mantissa
 09h  w	    Current Volume
	     bit 15-12	 Exponent
	     bit 11-4	 Mantissa
 0Ah  w	    Current Address HIGH
	     bit 12-0	 Address Lines 19-7
 0Bh  w	    Current Address LOW
	     bit 15-9	 Address Lines 6-0
	     bit 8-0	 Fractional Position
 0Ch  w	    Pan Position
	     bit 3-0	 Pan Postion
 0Dh  w	    Volume Control (see #P0596)
 0Eh  w	    Active Voices
	     bit 5-0	 #Voices -1  (allowed 13 - 31)
 0Fh  w	    IRQ Source Register (see #P0597)
---NOT voice specific---
 41h  r/w   DRAM DMA Control (see #P0598)
 42h  w	    DMA Start Address
	     bits 15-0	 DMA Address Lines 19-4
 43h  w	    DRAM I/O Address LOW
 44h  w	    DRAM I/O Address HIGH
	     bits 0-3	 Upper 4 Address Lines
 45h  r/w   Timer Control
	     bit 3	 Enable Timer 2
	     bit 2	 Enable Timer 1
 46h  w	    Timer 1 Count (granularity of 80 micro sec)
 47h  w	    Timer 2 Count (granulatity of 320 micro sec)
 48h  w	    Sampling Frequency
	     rate = 9878400 / (16 * (FREQ + 2))
 49h  r/w   Sampling Control (see #P0599)
 4Bh  w	    Joystick Trim DAC
 4Ch  r/w   RESET
	     bit 2	 GF1 Master IRQ Enable
	     bit 1	 DAC Enable
	     bit 0	 Master Reset
---Voice specific registers---
 80h  r	    Voice Control (see 00h)
 81h  r	    Frequency Control (see 01h)
 82h  r	    Start Address HIGH (see 02h)
 83h  r	    Start Address LOW (see 03h)
 84h  r	    End Address HIGH (see 04h)
 85h  r	    End Address LOW (see 05h)
 86h  r	    Volume Ramp Rate (see 06h)
 87h  r	    Volume Ramp Start (see 07h)
 88h  r	    Volume Ramp End (see 08h)
 89h  r	    Current Volume (see 09h)
 8Ah  r	    Current Address HIGH (see 0Ah)
 8Bh  r	    Current Address LOW (see 0Bh)
 8Ch  r	    Pan Position (see 0Ch)
 8Dh  r	    Volume Control (see 0Dh)
 8Eh  r	    Active Voices (see 0Eh)
 8Fh  r	    IRQ Status (see 0Fh)
SeeAlso: #P0592,#P0594

(Table P0594)
Values for InterWave synthesizer registers:
---voice-specific registers---
 10h  w	    synthesizer	 upper address
 11h  w	    synthesizer effects address high (16 bits)
 12h  w	    synthesizer effects address low (16 bits)
 13h  w	    synthesizer left offset (16 bits)
 14h  w	    synthesizer effects output accumulator select
 15h  w	    synthesizer mode select
 16h  w	    synthesizer effects volume (16 bits)
 17h  w	    synthesizer frequency LFO
 18h  w	    synthesizer volume LFO
---NOT voice-specific---
 19h  w	    synthesizer global mode
 1Ah  w	    synthesizer LFO base address (16 bits)
---voice-specific registers---
 1Bh  w	    synthesizer right offset (16 bits)
 1Ch  w	    synthesizer left offset (16 bits)
 1Dh  w	    synthesizer effect volume final (16 bits)
---NOT voice-specific---
 41h  r/w   local memory control: DMA control
 42h  r/w   local memory control: DMA start address bits 19-4 (16 bits)
 43h  w	    local memory control: I/O address low (16 bits)
 44h  w	    local memory control: I/O address high (16 bits)
 45h  r/w   AdLib/SoundBlaster control
 46h  r/w   AdLib timer 1
 47h  r/w   AdLib timer 2
 49h  r/w   ADC sample control
 4Bh  r/w   joystick trim
 4Ch  w	    GUS reset
 50h  r/w   local memory control: DMA start address bits 23-20/3-0 (16 bits)
 51h  r/w   local memory control: 16-bit access
 52h  r/w   local memory control: configuration
 53h  r/w   local memory control: control
 54h  r/w   local memory control: record FIFO base address bits 23-8 (16-bit)
 55h  r/w   local memory control: playback FIFO base address bits 23-8 (16-bit)
 56h  r/w   local memory control: FIFO size (16-bit)
 57h  r/w   local memory control: DMA interleave control (16-bit)
 58h  r/w   local memory control: DMA interleaev base address bits 23-8
 59h  r/w   compatibility control
 5Ah  r/w   decode control
 5Bh  r/w   version number
 5Ch  r/w   MPU-401 emulation control A
 5Dh  r/w   MPU-401 emulation control B
 5Eh  w	    MIDI receive FIFO access
 5Fh  -	    reserved
 60h  r/w   emulation IRQ
---voice-specific registers---
 90h  r	    synthesizer	 upper address
 91h  r	    synthesizer effects address high (16 bits)
 92h  r	    synthesizer effects address low (16 bits)
 93h  r	    synthesizer left offset (16 bits)
 94h  r	    synthesizer effects output accumulator select
 95h  r	    synthesizer mode select
 96h  r	    synthesizer effects volume (16 bits)
 97h  r	    synthesizer frequency LFO
 98h  r	    synthesizer volume LFO
---NOT voice-specific---
 99h  r	    synthesizer global mode
 9Ah  r	    synthesizer LFO base address (16 bits)
---voice-specific registers---
 9Bh  r	    synthesizer right offset (16 bits)
 9Ch  r	    synthesizer left offset (16 bits)
 9Dh  r	    synthesizer effect volume final (16 bits)
---NOT voice-specific---
 9Fh  r	    synthesizer voices IRQ
Note:	these registers are *in*addition* to the Gravis UltraSound registers
SeeAlso: #P0593

Bitfields for Gravis Ultra Sound voice control global register:
Bit(s)	Description	(Table P0595)
 7	 IRQ pending
 6	 Direction
 5	 Enable WAVE IRQ
 4	 Enable bi-directional Looping
 3	 Enable Looping
 2	 Size data (8/16 bits)
 1	 Stop Voice
 0	 Voice Stopped
SeeAlso: #P0593,#P0596

Bitfields for Gravis Ultra Sound volume control global register:
Bit(s)	Description	(Table P0596)
 7	 IRQ Pending
 6	 Direction
 5	 Enable Volume Ramp IRQ
 4	 Enable bi-directional Looping
 3	 Enable Looping
 2	 Rollover Condition
 1	 Stop Ramp
 0	 Ramp Stopped
SeeAlso: #P0593,#P0595

Bitfields for Gravis Ultra Sound IRQ source register:
Bit(s)	Description	(Table P0597)
 7	 WaveTable IRQ pending
 6	 Volume Ramp IRQ pending
 4-0	 Voice Number
SeeAlso: #P0593,#P0595,#P0598

Bitfields for Gravis Ultra Sound DRAM DMA control register:
Bit(s)	Description	(Table P0598)
 7	 Invert MSB
 6	 Data Size (8/16 bits)
 5	 DMA Pending
 3-4	 DMA Rate Divider
 2	 DMA Channel Width (8/16 bits)
 1	 DMA Direction (1 = read)
 0	 DMA Enable
SeeAlso: #P0593,#P0597

Bitfields for Gravis Ultra Sound sampling control register:
Bit(s)	Description	(Table P0599)
 7	 Invert MSB
 6	 DMA IRQ pending
 5	 DMA IRQ enable
 2	 DMA width (8/16 bits)
 1	 Mode (mone/stereo)
 0	 Start Sampling
SeeAlso: #P0593
----------P03400357--------------------------
PORT 0340-0357 - RTC (1st Real Time Clock for XT)
		(used by TIMER.COM v1.2 which is the 'standard' timer program)
Range:	alternate at 0240-0257
SeeAlso:  PORT 0240h-0257h

0340  RW  0.001 seconds		0-99
0341  RW  0.1 and 0.01 seconds	0-99
0342  RW  seconds		0-59
0343  RW  minutes		0-59
0343  RW  hours			0-23
0345  RW  day of week		1-7
0346  RW  day of month		1-31
0347  RW  month			1-12
0348  RW  RAM (upper nybble only)
0349  RW  year			0-99
034A  RW  RAM last month storage
034B  RW  RAM year storage (-80)
034C  RW  RAM reserved
034D  RW  RAM not used
034E  RW  RAM not used
034F  RW  RAM not used
0350  R-  interrupt status register
0351  -W  interrupt control register
0352  -W  counter reset
0353  -W  RAM reset
0354  R-  status bit
0355  -W  GO command
0356  ??  standby interrupt
0357  ??  test mode
--------d-P0340035F--------------------------
PORT 0340-035F -  Adaptec AHA-152x SCSI adapter
Range:	alternate address at 0140
Note:	Adaptec AHA-152x SCSI adapter series are based upon Adaptec
	  AIC-6260/6360/6370 SCSI controllers
SeeAlso: PORT xxxxh"Adaptec AIC-78xx"

+000  RW  SCSI sequence control register (SCSISEQ) (see #P0600)
+001  RW  SCSI transfer control register 0 (SXFRCTL0) (see #P0601)
+002  RW  SCSI transfer control register 1 (SXFRCTL1) (see #P0602)
+003  R-  SCSI control signal read  register (SCSISIGI) (see #P0603)
+003  -W  SCSI control signal write register (SCSISIGO) (see #P0604)
+004  RW  SCSI rate control register (SCSIRATE) (see #P0605)
+005  RW  SCSI ID register (SCSIID) (see #P0606)
+006  RW  SCSI latched data register (SCSIDAT)
	  read/write causes -ACK to pulse
+007  R?  SCSI data bus register (SCSIBUS)
+008  RW  SCSI transfer count register (STCNT) (3 bytes long)
+00B  R-  SCSI status register 0 (SSTAT0) (see #P0607)
+00B  -W  clear SCSI interrupt register 0 (CLRSINT0) (see #P0608)
+00C  R-  SCSI status register 1 (SSTAT1) (see #P0609)
+00C  -W  clear SCSI interrupt register 1 (CLRSINT1) (see #P0610)
+00D  R-  SCSI status register 2 (SSTAT2) (see #P0611)
+00E  R-  SCSI status register 3 (SSTAT3) (see #P0612)
+00E  ?W  SCSI test control register (SCSITEST) (see #P0613)
+00F  R-  SCSI status register 4 (SSTAT4) (see #P0614)
+00F  -W  clear SCSI interrupt register 4 (CLRSINT4) (see #P0615)
+010  RW  SCSI interrupt mode register 0 (SIMODE0) (see #P0616)
+011  RW  SCSI interrupt mode register 1 (SIMODE1) (see #P0617)
+012  RW  DMA control register 0 (DMACNTRL0) (see #P0618)
+013  RW  DMA control register 1 (DMACNTRL1) (see #P0619)
+014  RW  DMA status register (DMASTAT) (see #P0620)
+015  RW  FIFO status register (FIFOSTAT)
+016w RW  data port register (DATAPORT)
+018  RW  burst control register (BRSTCNTRL) (see #P0621)
+01A  RW  port A register (PORTA) (see #P0622)
+01B  RW  port B register (PORTB) (see #P0623)
+01C  RW  revision register (REV)
+01D  RW  stack register (STACK)
+01E  RW  test register (TEST) (see #P0624)
+01F  R?  (AIC-6360+) ID register (ID)
	  32-byte ID string can be read here
Notes:	the SCSI latched data register is used to transfer data on the SCSI bus
	  during automatic or manual PIO mode
	the SCSI data bus register reflects the state of SCSI data bus lines
	  directly

Bitfields for SCSI sequence control register (SCSISEQ):
Bit(s)	Description	(Table P0600)
 7	enable target mode (TEMODEO)
 6	enable selection out (ENSELO)
 5	enable selection in  (ENSELI)
 4	enable reselection in (ENRESELI)
 3	"ENAUTOATNO"
 2	"ENAUTOATNI"
 1	enable auto -ATN on parity error (ENAUTOATNP)
 0	SCSI reset out (SCSIRSTO)
Note:	each bit when set starts a specific SCSI sequence on the bus
SeeAlso: #P0602,#P0607,#P0608,#P0616

Bitfields for SCSI transfer control register 0 (SXFRCTL0):
Bit(s)	Description	(Table P0601)
 7	SCSI FIFO enable (SCSIEN)
 6	DMA  FIFO enable (DMAEN)
 5	channel enable (CHEN)
 4	clear SCSI transfer counter (CLRSTCNT)
 3	SCSI PIO enable (SPIOEN)
 2	SCAM enable (SCAMEN)
 1	clear channel (CLRCH)
 0	reserved
SeeAlso: #P0602,#P0607,#P0611,#P0618,#P0620

Bitfields for SCSI transfer control register 1 (SXFRCTL1):
Bit(s)	Description	(Table P0602)
 7	bit bucket (BITBUCKET)
 6	SCSI counter wrap enable (SWRAPEN)
 5	enable SCSI parity check (ENSPCHK)
 4-3	selection time-out select (STIMESEL)
	00 256 ms
	01 128 ms
	10 64  ms
	11 32  ms
 2	enable selection timer (ENSTIMER)
 1	byte align (BYTEALIGN)
 0	reserved
SeeAlso: #P0600,#P0601

Bitfields for SCSI control signal read register (SCSISIGI):
Bit(s)	Description	(Table P0603)
 7	-C/D input (CDI)
 6	-I/O input (IOI)
 5	-MSG input (MSGI)
 4	-ATN input (ATNI)
 3	-SEL input (SELI)
 2	-BSY input (BSYI)
 1	-REQ input (REQI)
 0	-ACK input (ACKI)
Note:	this register reflects the actual state of the SCSI bus control lines
SeeAlso: #P0604

Bitfields for SCSI control signal write register (SCSISIGO):
Bit(s)	Description	(Table P0604)
 7	-C/D output (CDO)
 6	-I/O output (IOO)
 5	-MSG output (MSGO)
 4	-ATN output (ATNO)
 3	-SEL output (SELO)
 2	-BSY output (BSYO)
 1	-REQ output (REQO)
 0	-ACK output (ACKO)
Notes:	writing to this register modifies the control signals on the bus; only
	  those signals that are allowed in the current mode (initiator/target)
	  are asserted
	bits 7-5 in initiator mode represent the expected SCSI bus phase and
	  can be used to trigger phase mismatch and phase change interrupts
SeeAlso: #P0603

Bitfields for SCSI rate control register (SCSIRATE):
Bit(s)	Description	(Table P0605)
 7	reserved
 6-4	synchronous transfer rate (SXFR)
	rate = 100 + SXFR * 25 (ns)
 3-0	synchronous offset (SOFS)
Note:	contents of this register determine the synchronous SCSI data transfer
	  rate and the maximum synchronous -REQ/-ACK offset; an offset of 0 in
	  the bits 3-0 disables synchronous data transfers, any offset value
	  greater than 0 enables snchronous transfers
SeeAlso: #P0611

Bitfields for SCSI ID register (SCSIID):
Bit(s)	Description	(Table P0606)
 7	reserved
 6-4	our ID (OID)
 3	reserved
 2-0	target ID (TID)
Note:	this register contains the SCSI ID of the board and the current target
	  on the selected channel
SeeAlso: #P0982

Bitfields for SCSI status register 0 (SSTAT0):
Bit(s)	Description	(Table P0607)
 7	target mode (TARGET)
 6	selection out done (SELDO)
 5	selection in  done (SELDI)
 4	selection in progress (SELINGO)
 3	SCSI counter wrap (SWRAP)
 2	SCSI PIO done  (SDONE)
 1	SCSI PIO ready (SPIORDY)
 0	DMA done (DMADONE)
Note:	bits 1-0 and 6-4 are self-clearing
	bit 2 is set when the SCSI transfer count register decrements to 0
SeeAlso: #P0600,#P0601,#P0608,#P0616

Bitfields for clear SCSI interrupt register 0 (CLRSINT0):
Bit(s)	Description	(Table P0608)
 7	set SCSI PIO done? (SETSDONE)
 6	clear selection out done (CLRSELDO)
 5	clear selection in  done (CLRSELDI)
 4	clear selection in progress (CLRSELINGO)
 3	clear SCSI counter wrap (CLRSWRAP)
 2	clear SCSI PIO done (CLRSDONE)
 1	clear SCSI PIO ready (CLRSPIORDY)
 0	reserved
Note:	writing 1 to a bit clears the associated SCSI interrupt; writing 1 to
	  the bits 3-2 also clears the asscoiated bits in SSTAT0
SeeAlso: #P0600,#P0601,#P0607,#P0616

Bitfields for SCSI status register 1 (SSTAT1):
Bit(s)	Description	(Table P0609)
 7	selection time-out (SELTO)
 6	(target) "ATNTARG"
 5	SCSI reset in (SCSIRSTI)
 4	phase mismatch (PHASEMIS)
 3	bus free (BUSFREE)
 2	SCSI parity error (SCSIPERR)
 1	phase changed (PHASECHG)
 0	-REQ asserted (REQINIT)
Notes:	bit 0 can be cleared by setting bit 0 in the clear SCSI interrupt 1
	  register (CLRSINT1), and by asserting -ACK as well
	bit 4 is self-clearing
SeeAlso: #P0602,#P0603,#P0604,#P0610,#P0617

Bitfields for clear SCSI interrupt register 1 (CLRSINT1):
Bit(s)	Description	(Table P0610)
 7	clear selection time-out (CLRSELTIMEO)
 6	clear -ATN output (CLRATNO)
 5	clear SCSI reset in (CLRSCSIRSTI)
 4	reserved
 3	clear bus free (CLRBUSFREE)
 2	clear SCSI parity error (CLRSCSIPERR)
 1	clear phase changed (CLRPHASECHG)
 0	clear -REQ asserted (CLRREQINIT)
Note:	writing 1 to a bit clears the associated SCSI interrupt; writing 1 to
	  the bits 3-0, 5, and 7 also clears the associated bits in SSTAT1
SeeAlso: #P0603,#P0604,#P0609,#P0617

Bitfields for SCSI status register 2 (SSTAT2):
Bit(s)	Description	(Table P0611)
 7-6	reserved
 5	"SOFFSET"
 4	SCSI FIFO empty (SEMPTY)
 3	SCSI FIFO full	(SFULL)
 2-0	SCSI FIFO count (SFCNT)
Note:	the SCSI FIFO is 8 bytes long; bit 3 is set when all the 8 bytes are
	  full (bits 2-0 are clear)
SeeAlso: #P0601,#P0605,#P0614,#P0615

Bitfields for SCSI status register 3 (SSTAT3):
Bit(s)	Description	(Table P0612)
 7-4	"SCSICNT"
 3-0	"OFFCNT"
SeeAlso: #P0605,#P0611

Bitfields for SCSI test control register (SCSITEST):
Bit(s)	Description	(Table P0613)
 7-4	reserved
 3	"SCTESTU"
 2	"SCTESTD"
 1	reserved
 0	"STCTEST"
SeeAlso: #P0624

Bitfields for SCSI status register 4 (SSTAT4):
Bit(s)	Description	(Table P0614)
 7-3	reserved
 2	"SYNCERR"
 1	FIFO write error? (FWERR)
 0	FIFO read  error? (FRERR)
SeeAlso: #P0611,#P0615

Bitfields for clear SCSI interrupt register 4 (CLRSINT4):
Bit(s)	Description	(Table P0615)
 7-3	reserved
 2	"CLRSYNCERR"
 1	clear FIFO write error? (CLRFWERR)
 0	clear FIFO read	 error? (CLRFRERR)
SeeAlso: #P0611,#P0614

Bitfields for SCSI interrupt mode register 0 (SIMODE0):
Bit(s)	Description	(Table P0616)
 7	reserved
 6	enable selection out done (ENSELDO)
 5	enable selection in  done (ENSELDI)
 4	enable selection in progress (ENSELINGO)
 3	enable SCSI counter wrap (ENSWRAP)
 2	enable SCSI PIO done  (ENSDONE)
 1	enable SCSI PIO ready (ENSPIORDY)
 0	enable DMA done (ENDMADONE)
Note:	setting any bit will enable the corresponding function to interrupt
	  via the IRQ pin
SeeAlso: #P0607,#P0608,#P0617,#P0618

Bitfields for SCSI interrupt mode register 1 (SIMODE1):
Bit(s)	Description	(Table P0617)
 7	enable selection time-out (ENSELTIMO)
 6	(target) "ENATNTARG"
 5	enable SCSI reset (ENSCSIRST)
 4	enable phase mismatch (ENPHASEMIS)
 3	enable bus free (ENBUSFREE)
 2	enable SCSI parity error (ENSCSIPERR)
 1	enable phase changed (ENPHASECHG)
 0	enable -REQ asserted (ENREQINIT)
Note:	setting a bit enables the corresponding function to interrupt via the
	  IRQ pin
SeeAlso: #P0609,#P0610,#P0616

Bitfields for DMA control register 0 (DMACNTRL0):
Bit(s)	Description	(Table P0618)
 7	enable DMA (ENDMA)
 6	=0 16-bit mode
	=1 8-bit mode (8BIT)
 5	=0 PIO mode
	=1 DMA mode
 4	double word PIO (DWORDPIO)
 3	=0 read
	=1 write
 2	interrupt enable (INTEN)
 1	reset FIFO (RSTFIFO)
 0	software interrupt (SWINT)
Note:	write to this register takes the controller from the power down mode
SeeAlso: #P0601

Bitfields for DMA control register 1 (DMACNTRL1):
Bit(s)	Description	(Table P0619)
 7	power down (PWRDWN)
 6	"ENSTK32"
 5	reserved
 4-0	stack pointer? (STK)

Bitfields for DMA status register (DMASTAT):
Bit(s)	Description	(Table P0620)
 7	"ATDONE"
 6	word ready (WORDRDY)
 5	interrupt status (INTSTAT)
 4	DMA FIFO full  (DFIFOFULL)
 3	DMA FIFO empty (DFIFOEMP)
 2	(AIC-6360+?) DMA FIFO half-full? (DFIFOHF)
 1	(AIC-6360+?) double word ready (DWORDRDY)
 0	reserved
SeeAlso: #P0601,#P0618

Bitfields for burst control register (BRSTCNTRL):
Bit(s)	Description	(Table P0621)
 7-4	bus on	time (BON)
 3-0	bus off time (BOFF)
Note:	the bus on/off times are in microseconds
SeeAlso: #P0624

Bitfields for port A register (PORTA):
Bit(s)	Description	(Table P0622)
 7	transfer mode
	=0 PIO
	=1 DMA
 6	boot enabled (BOOT)
 5-4	message classes (MSGCLASSES)
	00 #4
	01 #0, #1, #2, #3, #4
	10 #0, #3, #4
	11 #0, #4
 3	initial synchronous negotiation enabled (SYNCNEG)
 2	target disconnect enabled (TARDISC)
 1-0	reserved
SeeAlso: #P0623

Bitfields for port B register (PORTB):
Bit(s)	Description	(Table P0623)
 7	SCSI parity enabled (PARITY)
 6-5	DMA channel (DMACHAN)
	00 DMA channel 0
	01 DMA channel 5
	10 DMA channel 6
	11 DMA channel 7
 4-3	"IRQ"
	00,11 IRQ12
	01 IRQ10
	10 IRQ11
 2-0	SCSI ID
SeeAlso: #P0622

Bitfields for test register (TEST):
Bit(s)	Description	(Table P0624)
 7	reserved
 6	bus off timer test (BOFFTMR)
 5	bus on	timer test (BONTMR)
 4	SCSI transfer count register high   byte test (STCNTH)
 3	SCSI transfer count register middle byte test (STCNTM)
 2	SCSI transfer count register low    byte test (STCNTL)
 1	SCSI block test (SCSIBLK)
 0	DMA  block test (DMABLK)
SeeAlso: #P0613,#P0621
----------P03480357--------------------------
PORT 0348-0357 - DCA 3278
----------P034C034F--------------------------
PORT 034C-034F - Gravis UltraMax by Advanced Gravis
Range:	The I/O address range is dipswitch selectable from:
	   0200-020F and 0300-030F
	   0210-021F and 0310-031F
	   0220-022F and 0320-032F
	   0230-023F and 0330-033F
	   0240-024F and 0340-034F
	   0250-025F and 0350-035F
	   0260-026F and 0360-036F
	   0270-027F and 0370-037F
----------P0352------------------------------
PORT 0352 - PC104 - WATCHDOG TIMER RESET
Desc:	any write to this port resets the watchdog timer; if the timer is not
	  periodically re-armed, it generates a system reset
----------P035A035B--------------------------
PORT 035A-035B - Adaptec AH1520 jumper settings

035A  R	  I/O channel setup (see #P0625)
035B  R	  transfer mode setup (see #P0626)

Bitfields for Adaptec AH1520 channel setup jumper settings:
Bit(s)	Description	(Table P0625)
 7	SCSI parity disabled
 6-5	DMA channel (00 = channel 0, 01 = 5, 10 = 6, 11 = 7)
 4-3	IRQ number (00 = IRQ9, 01 = IRQ10, 10 = IRQ11, 11 = IRQ12)
 2-0	SCSI ID
SeeAlso: #P0626

Bitfields for Adaptec AH1520 transfer mode setup jumper settings:
Bit(s)	Description	(Table P0626)
 7	DMA transfer mode (clear for PIO)
 6	boot enabled
 5-4	boot type
	00 ???
	01 boot from floppy
	10 print configured options
	11 boot from hard disk
 3	enable sync negotiation
 2	enable target disconnection
 1-0	unused???
SeeAlso: #P0625
----------P035F------------------------------
PORT 035F - ARTEC Handyscanner A400Z.  alternate address at 15F.
----------P03600367--------------------------
PORT 0360-0367 - PC network (XT only)
----------P0360036F--------------------------
PORT 0360-036F - PC network (AT)
----------P0360036F--------------------------
PORT 0360-036F - National Semiconductor DP8390(1)C/NS3249C network chipset
Note:	cards based on this IEEE 802.3 networking chipset can use any range
	  of 16 consecutive addresses, and provide a total of four pages of
	  sixteen registers (see #P0627,#P0628,#P0629,#P0759)

(Table P0627)
Values for NS DP8390C/NS3249C network chipset Page 0 registers:
Number	Read Register				Write Register
 00h	Command reg. (see #P0631)	CR	Command reg.		CR
 01h	current local DMA address 0	CLDA0	page start reg.		PSTART
 02h	current local DMA address 1	CLDA1	page stop reg.		PSTOP
 03h	boundary pointer		BNRY	boundary pointer	BNRY
 04h	transmit status reg.		TSR	Tx page start address	TPSR
 05h	number of collisions reg.	NCR	Tx byte count reg.0	TBCR0
 06h	FIFO					Tx byte count reg.1	TBCR1
 07h	interrupt status reg.		ISR	interrupt status reg.	ISR
 08h	current remote DMA address 0	CRDA0	remote start addr.reg.0 RSAR0
 09h	current remote DMA address 1	CRDA1	remote start addr.reg.1 RSAR1
 0Ah	reserved				remote byte count reg.0 RBCR0
 0Bh	reserved				remote byte count reg.1 RBCR1
 0Ch	receive status reg.		RSR	Rx configuration reg.	RCR
 0Dh	tally counter 0 (frame errors)	CNTR0	Tx configuration reg.	TCR
 0Eh	tally counter 1 (CRC errors)	CNTR1	data configuration reg. DCR
 0Fh	tally counter 2 (missed pkt)	CNTR2	interrupt mask reg.	IMR
SeeAlso: #P0628,#P0629,#P0630

(Table P0628)
Values for NS DP8390C/NS3249C network chipset Page 1 registers:
Number	Read/Write
 00h	Command			CR (see #P0631)
 01h	physical address reg.0	PAR0
 02h	physical address reg.1	PAR1
 03h	physical address reg.2	PAR2
 04h	physical address reg.3	PAR3
 05h	physical address reg.4	PAR4
 06h	physical address reg.5	PAR5
 07h	current page reg.	CURR
 08h	multicast address reg.0 MAR0
 09h	multicast address reg.1 MAR1
 0Ah	multicast address reg.2 MAR2
 0Bh	multicast address reg.3 MAR3
 0Ch	multicast address reg.4 MAR4
 0Dh	multicast address reg.5 MAR5
 0Eh	multicast address reg.6 MAR6
 0Fh	multicast address reg.7 MAR7
SeeAlso: #P0627,#P0629,#P0630

(Table P0629)
Values for NS DP8390C/NS3249C network chipset Page 2 registers:
Number	Read Register				Write Register
 00h	Command				CR	Command			 CR
 01h	page start reg.			PSTART	current local DMA addr.0 CLDA0
 02h	page stop reg.			BPSTOP	current local DMA addr.1 CLDA1
 03h	remote next packet pointer		remote next packet pointer
 04h	Tx page start address		TPSR	reserved
 05h	local next packet pointer		local next packet pointer
 06h	address counter (upper)			address counter (upper)
 07h	address counter (lower)			address counter (lower)
 08h	reserved				reserved
 09h	reserved				reserved
 0Ah	reserved				reserved
 0Bh	reserved				reserved
 0Ch	Rx configuration reg.		RCR	reserved
 0Dh	Tx configuration reg.		TCR	reserved
 0Eh	data configuration reg.		DCR	reserved
 0Fh	interrupt mask reg.		IMR	reserved
Note:	this is a diagnostics page, and should never be modfied under normal
	  operation.
SeeAlso: #P0627,#P0628,#P0630

(Table P0630)
Values for NS DP8390C/NS3249C network chipset Page 3 registers:
Number	Read Register				Write Register
 00h	Command CR (see #P0631)			Command CR
Note:	Test Page - should never be modified!
SeeAlso: #P0627,#P0628,#P0629

Bitfields for NS DP8390C/NS3249C network chipset command register (00h):
Bit(s)	Description	(Table P0631)
 0	software reset command (1=offline, 0=online)
 1	do not activate NIC after reset command
 2	start transmision of a packet
 3-5	remote DMA command
	000 not allowed
	001 remote read
	010 remote write
	011 send packet
	1xx abort/complete rmote DMA
 6-7	page select
	00 register page 0
	01 register page 1
	10 register page 2
	11 register page 3
SeeAlso: #P0630
----------P036B------------------------------
PORT 036B - GI1904 Scanner Interface Adapter
Range:	PORT 022Bh, PORT 026Bh, PORT 02ABh (default), PORT 02EBh, PORT 032Bh,
	  PORT 03ABh, PORT 03EBh
----------P036C------------------------------
PORT 036C - GS-IF Scanner Interface adapter
Range:	PORT 022Ch, PORT 026Ch, PORT 02ACh, PORT 02ECh (default),
	  PORT 032Ch, PORT 036Ch, PORT 03ACh, PORT 03ECh
Note:	many SPI 400dpi/800dpi gray / H/T handy scanner by Marstek, Mustek and
	  others use this interface
----------P03700377--------------------------
PORT 0370-0377 - FDC 2	(2nd Floppy Disk Controller)	first FDC at 03F0
Note:	floppy disk controller is usually an 8272, 8272A, NEC765 (or
	  compatible), or an 82072 or 82077AA for perpendicular recording at
	  2.88M
SeeAlso: PORT 03F0h-03F7h

0370  R-  diskette Extra High Density controller board jumpers (AT)
0370  R-  diskette controller status A (PS/2, PS/2 model 30)
0371  R-  diskette controller status B (PS/2, PS/2 model 30)
0372  -W  diskette controller DOR (Digital Output Register)
0374  R-  diskette controller main status register
0374  -W  diskette controller datarate select register
0375  RW  diskette controller command/data register
0376  RW  (2nd FIXED disk controller status/data register)
0377  RW  (2nd FIXED disk controller drive address register)
0377  R-  diskette controller DIR (Digital Input Register)
0377  -W  select register for diskette data transfer rate
----------P0378------------------------------
PORT 0378 - Covox 'Speech Thing' COMPATIBLE SPEECH OUTPUT
SeeAlso: PORT 022Fh"mc-soundmachine",PORT 0388h-038Fh"soundmachine"

0378  -W  speech output via printer port
	  (with mc-soundmachine, enabled if bit4=1 in 38F)
----------P0378037A--------------------------
PORT 0378-037A - PARALLEL PRINTER PORT (usually LPT2, sometimes LPT3)
Range:	usually PORT 03BCh, PORT 0278h, or PORT 0378h
SeeAlso: MEM 0040h:000Ah,INT 17/AH=00h

0378  -W  data port
0379  R-  status port (see #P0658 at PORT 03BCh)
037A  RW  control port (see #P0659 at PORT 03BCh)

037B  ??  bit 7: shadow RAM on/off (UniRAM adapter,according to c't 7/90)
----------P0378037F--------------------------
PORT 0378-037F - Intel 82360SL/82091AA - EPP-mode PARALLEL PORT
Range:	PORT 0278h or PORT 0378h
SeeAlso: PORT 0278h"LPT1",PORT 0778h"ECP"

0378-037A	as for standard parallel port
037B  RW  address strobe
037C  RW  data strobe 0
037D  RW  data strobe 1
037E  RW  data strobe 2
037F  RW  data strobe 3
----------P037C037F--------------------------
PORT 037C-037F - C&T F87000 Multi-Mode Peripheral Chip - OUTPUT PORTS

037C  -W  outputs driven to keyboard outputs COL7-COL0
037C  R-  inputs driven by keyboard pins ROW7-ROW0
037D  -W  outputs driven to keyboard outputs COL15-COL8
037E  -W  outputs driven to pins P2[7-1]; bit 0 enables UART clock when low
037F  -W  external output port
----------P0380038F--------------------------
PORT 0380-038F - 2nd BSC (Binary Synchronous Communication) adapter
SeeAlso:  PORT 03A0h"BSC"
----------P0380038C--------------------------
PORT 0380-038C - 2nd SDLC (Synchronous Data Link Control) adapter
Notes:	Initialization of the SDLC adapter is performed in a typical
	  sequence like this: Setup 8255 port A-C configuration by writing
	  98h to 383h, followed by initializing 8255 port C by writing 0Dh
	  to 382h. Reset 8273 internal registers by pulsing 8255 port B4.
	  After this the 8253 has to be programmed to the desired values
	  (counter 0 in mode 3). Now the 8273 is ready to be configured for
	  the operating mode that defines the communication environment in
	  which it will be used.
	Note on 8273: Each 8273 protocol controllers internal register is
	  programmed by individual set/reset commands (via 388h) in
	  conjunction with a parameter (via 389h) that give an OR/AND mask
	  to the internal register value.
	  Although the 8273 is a full duplex device, there is only one
	  command register. Thus, the command register must be used for
	  only one command sequence at a time and the transmitter and
	  receiver may never be simultaneously in a command phase.
	  The system software starts the command phase by writing a command
	  byte into the command register. If further information is required
	  by the 8273 prior to execution of the command, the system software
	  must write the list of parameters into the parameter register.
SeeAlso: PORT 03A0h"SDLC"

0380  R-   on adapter 8255(A5) port A: internal/external sensing (see #P0632)
0381  -W   on adapter 8255(A5) port B: external modem interface (see #P0633)
0382  RW   on adapter 8255(A5) port C: internal control (see #P0634)
0383  ?W   on adapter 8255(A5) mode initialization
0384  RW   on adapter 8253 (programmable counter) counter 0:
		LSB / MSB square wave generator (input for timer 2, connected
		  to 8255 bitC5)
0385  RW   on adapter 8253 counter 1: LSB / MSB inactivity time-outs
		(connected to 8255 bitA7, IRQ4 level)
0386  RW   on adapter 8253 counter 2: LSB / MSB inactivity time-outs
		(connected to 8255 bitA6, IRQ4 level)
0387  ?W   on adapter 8253 mode register (see #P0635)
0388  R-   on adapter 8273 status register (see #P0636)
0388  -W   on adapter 8273 command register (see #P0637)
0389  R-   on adapter 8273 (immediate) result register (see #P0644)
0389  -W   on adapter 8273 parameter register
	    Commands issued via PORT 0388h may need additional parameters,
	      which have to be passed through this port (see table).
038A  R-   on adapter 8273 transmit INT status (DMA/INT)
038A  -W   on adapter 8274 reset
038B  R-   on adapter 8273 receive INT status (DMA/INT)
038C  -W   on adapter 8273 data: direct program control (DPC)
	  scratch-pad

Bitfields for SDLC 8255 port A:
Bit(s)	Description	(Table P0632)
 7	=1 timer 1 output active
 6	=1 timer 2 output active
 5	=1 modem status changed
 4	receive clock active (if pulsing)
 3	=0 clear to send is on from interface
 2	transmit clock active (if pulsing)
 1	=0 data carrier detect is on from interface
 0	=0 ring indicator is on from interface
SeeAlso: #P0633,#P0634

Bitfields for SDLC 8255 port B:
Bit(s)	Description	(Table P0633)
 7	enable IRQ 4 level interrupt
 6	=1 gate timer 1
 5	=1 gate timer 2
 4	=1 reset 8273
 3	=1 reset modem status changed logic
 2	=0 turn on test
 1	=0 turn on select standby at modem interface
 0	=0 turn on data signal rate select at modem interface
SeeAlso: #P0632,#P0634

Bitfields for SDLC 8255 port C:
Bit(s)	Description	(Table P0634)
 7 R-	=? not used (detection: =1 SDLC, =0 may be SDLC or BSC??)
 6 R-	=0 test indicate active
 5 R-	timer 0 output (if pulsing)
 4 R-	receive data (if pulsing)
 3 -W	=0 gate interrupts 3 and 4
 2 -W	=1 electronic wrap
 1 -W	=1 gate external clock
 0 -W	=1 gate internal clock
SeeAlso: #P0632,#P0633

Bitfields for SDLC 8253 mode register:
Bit(s)	Description	(Table P0635)
 7-6	SC1-SC0	 00, 01, 10= select counter 0,1,2; 11=illegal
 5-4	RL1-RL0	 00= couner latching operation
		 01= read/load most significant byte (MSB)
		 10= read/load least significant byte (LSB)
		 11= read/load LSB first, then MSB
 3-1	M2-M0	 000= mode 0
		 001= mode 1
		 x10= mode 2
		 x11= mode 3
		 100= mode 4
		 101= mode 5
 0	BCD	 0= binary counter 16bits
		 1= BCD counter 4 decades

Bitfields for SDLC 8273 status register:
Bit(s)	Description	(Table P0636)
 7	=1 command busy (CBSY)
 6	=1 command buffer full (CBF)
 5	=1 command parameter buffer full (CPBF)
 4	=1 command result buffer full (CRBF)
 3	=1 Rx interupt (RxINT)
 2	=1 Tx interupt (TxINT)
 1	=1 RxINT result available (RxIRA)
 0	=1 TxINT result available (TxIRA)
SeeAlso: #P0637

(Table P0637)
Values for SDCL 8273 command register:
 commands:		   parameters:	results:   result port: int:
  A4: set one-bit delay	    set mask	 -	       -	no
  64: reset one-bit delay   reset mask	 -	       -	no
  97: set data transfer	    set mask	 -	       -	no
  57: reset data transfer   reset mask	 -	       -	no
  91: set operating mode    set mask	 -	       -	no
  51: reset operating mode  reset mask	 -	       -	no
  A0: set serial I/O mode   set mask	 -	       -	no
  60: reset serial I/O mode reset mask	 -	       -	no
  C0: general receive	    B0,B1	 RIC,R0,R1,A,C RXI/R   yes
  C1: selective receive	    B0,B1,A1,A2	 RIC,RD,R1,A,C RXI/R   yes
  C5: receive disable	    -		 -	       -	no
  C8: transmit frame	    L0, L1, A, C TIC	       TXI/R   yes
  C9: transmit transparent  L0, L1	 TIC	       TXI/R   yes
  CC: abort transmit frame  -		 TIC	       TXI/R   yes
  CD: abort transmit	    -		 TIC	       TXI/R   yes
  22: read 8273 port A	    -		 port value    result	no
  23: read 8273 port B	    -		 port value    result	no
  A3: set 8273 port A bit   set mask	 -	       -	no
  63: set 8273 port B bit   reset mask	 -	       -	no
Notes:	B0/B1 LSB/MSB of the receiver buffer length
	L0/L1 LSB/MSB of the Tx buffer length
	A1/A2 receive frame address match field one/two
	A     address fieldof received frame. In non-buffered mode, this
	      result is not provided.
	C     control field of received frame. In non-buffered mode, this
	      result is not provided.
	RXI/R TXI/R receive/transmit interrupt result register
	R0/R1 LBS/MSB of the length of the frame received
	RIC/TIC receiver/transmitter interrupt result code
SeeAlso: #P0638,#P0639,#P0640,#P0641,#P0642,#P0643

Bitfields for SDLC 8273 interal port A: Modem Control Input Port:
Bit(s)	Description	(Table P0638)
 7-5	not used
 4	DSR change (PA4)
 3	CTS change (PA3)
 2	Data Set Ready (PA2)
 1	Carrier Detect (PA1)
 0	Clear to Send (PA0)
SeeAlso: #P0637

Bitfields for SDLC 8273 interal port B: Modem Control Output Port:
Bit(s)	Description	(Table P0639)
 7-6	not used
 5	Flag Detect (PB5)
 4-3	reserved
 2	Data Terminal Ready (PB2)
 1	reserved (PB1)
 0	Request to Send (PB0)
SeeAlso: #P0637

Bitfields for SDLC 8273 internal: Operating Mode Register:
Bit(s)	Description	(Table P0640)
 7-6	not used
 5	=1 HDLC abort enable
 4	=1 EOP interrupt enable
 3	=1 enable early Tx interrupt
 2	=1 Buffered Mode
 1	=1 Two Preframe Sync Characters
 0	=1 Flag Stream Mode
SeeAlso: #P0637

Bitfields for SDLC 8273 internal: Serial I/O Register:
Bit(s)	Description	(Table P0641)
 7-3	not used
 2	=1 Data Loopback
 1	=1 Clock Loopback
 0	=1 NRZI Mode
SeeAlso: #P0637

Bitfields for SDLC 8273 internal: Data Transfer Mode Register:
Bit(s)	Description	(Table P0642)
 7-1	not used
 0	=1 Interrupt Data Transfers
SeeAlso: #P0637

Bitfields for SDLC 8273 internal: One-Bit Delay Mode Register:
Bit(s)	Description	(Table P0643)
 7 =1	One-Bit Delay Enable
 6-0	not used
SeeAlso: #P0637

(Table P0644)
Values for SDLC 8273 result register:
 transmit result codes:		 status after interrupt:
  0C: early transmit interrupt	  transmitter active
  0D: frame transmit complete	  idle or flags
  0E: DMA underrun		  abort
  0F: clear to send error	  abort
  10: abort complete		  idle or flags
 receive result codes:
  X0: A1 match / general receive  active
  X1: A2 match			  active
  03: CRC error			  active
  04: abort detected		  active
  05: idle detected		  disabled
  06: EOP detected		  disabled
  07: frame less than 32 bits	  active
  08: DMA overrun		  disabled
  09: memory buffer overflow	  disabled
  0A: carrier detect failure	  disabled
  0B: receiver interrupt overrun  disabled
 X bits received inlast byte:
   E: all eight bits of last byte (bit7-0)
   0: bit0 only
   8: bit1-0
   4: bit2-0
   C: bit3-0
   2: bit4-0
   A: bit5-0
   6: bit6-0
--------s-P03840387--------------------------
PORT 0384-0387 - Pro Audio Spectrum 16 (PAS16)
Range:	PORT 0280h, PORT 0284h, PORT 0288h, PORT 028Ch, PORT 384h,
	  PORT 0388h (default), or PORT 038Ch
----------P03880389--------------------------
PORT 0388-0389 - AdLib - MONO SOUND OUTPUT
Note:	also supported by SoundBlaster and compatibles
SeeAlso: PORT 0220h-0223h,PORT 0388h-038Fh"soundmachine"

0388  R-  both speakers -- Status
	    bit7  : interrupt request (IRQ)
	    bit6  : timer 1 overflow
	    bit5  : timer 2 overflow
	    bit4-0: reserved
0388  -W  both speakers -- Address port (see #P0645)
	index in OPL2 (YMF3812), OPL3 (YMF262), OPL4 (YF278-F)
0389  -W  data port
Note:	the AdLib requires a delay of 3.3 microseconds between writing to
	  PORT 0388h and writing to PORT 0389h, and a delay of 23 microseconds
	  after a write to PORT 0389h before any other operation is allowed

(Table P0645)
Values for AdLib address port index:
 01h	Enable waveform control
	bit 7-6: (OPL4, OPL3 in OPL2 mode only) lsi test
	bit 5: (OPL2 only) wave select enable (WS)
	       (OPL4, OPL3) lsi test
	bit 4-0: lsi test
 02h	Timer #1 data (OPL2 and OPL3 in OPL2 mode only)
 03h	Timer #2 data (OPL2 and OPL3 in OPL2 mode only)
 04h	Timer control flags (OPL2 and OPL3 in OPL2 mode only)
	bit 7  : reset interrupt (RST)
	bit 6  : timer 1 mask (MASK1)
	bit 5  : timer 2 mask (MASK2)
	bit 4-2: reserved
	bit 1  : start timer 2 (ST2)
	bit 0  : start timer 1 (ST1)
 04h	(OPL3 in OPL3 mode only) connection select
	bit 7-6: reserved
	bit 5-0: connection selection
 05h	(OPL3) compatibility register
	bit 7-1: reserved
	bit 0: enable OPL3 mode (NEW), default disabled
 08h	Speech synthesis mode
	bit 7: (OPL2 only) speech synthesis or FM music mode (CSM)
	bit 6: select keyboard split point (SEL/NTS)
	bit 5-0: reserved
 20h-35h Amplitude Modulation / Vibrato
	bit 7: AM modulation (AM)
	bit 6: vibrato (VIB)
	bit 5: sustain (EG)
	bit 4: keyboard scaling rate (KSR)
	bit 3-0: multi (MF)
 40h-55h Level key scaling / Total level
	bit 7-6: key scale level (KSL)
	bit 5-0: total level (TL)
 60h-75h Attack / Decay rate
	bit 7-4: attack rate
	bit 3-0: decay rate
 80h-95h Sustain / Release rate
	bit 7-4: sustain level
	bit 3-0: release rate
 A0h-A8h Octave / Frequency (LSB)
 A9h-AFh ???
 B0h-B8h Octave / Frequency Number
	bit 7-6: reserved
	bit 5  : key on, mute
	bit 4-2: block, octave
	bit 1-0: f-number (MSB)
 BDh	percussion, vibrato, AM	(OPL2, OPL3 in OPL2 mode only)
	bit 7: amplitude modulation (AM)
	bit 6: vibrato (VIB)
	bit 5: ryhthm, percussion on/off (R)
	bit 4: bass drum on/off (BD)
	bit 3: snare drum on/off (SD)
	bit 2: tom-tom on/off (TOM)
	bit 1: top cymbal on/off (TC)
	bit 0: hi hat on/off (HH)
 C0h-C8h Feedback / Algorithm
	bit 7-4: OPL3: channel D-A
	bit 3-1: feedback
	bit 0: connection
 E0h-F5h Waveform Selection
	bit 7-3: reserved
	bit 2  : (OPL3) waveform bit2
	bit 1-0: waveform
SeeAlso: #P0646

(Table P0646)
Values for Sound Blaster registers inside groups:
Offset
 +00..+02: operators 1-3    modulator channel 1-3
 +03..+05: operators 4-6    carrier channel 1-3
 +08..+0A: operators 7-9    modulator channel 4-6
 +0B..+0D: operators 10-12  carrier channel 4-6
 +10..+12: operators 13-15  modulator channel 7-9
 +13..+15: operators 16-18  carrier channel 7-9
 +06, +07, +0E, +0F: reserved
SeeAlso: #P0645
----------P03880389--------------------------
PORT 0388-0389 - Soundblaster PRO FM-Chip
----------P0388038B--------------------------
PORT 0388-038B - Soundblaster 16 ASP FM-Chip
--------s-P0388038B--------------------------
PORT 0388-038B - Pro Audio Spectrum 16 (PAS16)
Range:	PORT 0280h, PORT 0284h, PORT 0288h, PORT 028Ch, PORT 384h,
	  PORT 0388h (default), or PORT 038Ch
----------P0388038F--------------------------
PORT 0388-038F - mc-soundmachine, mc 03-04/1992 - SPEECH I/O
Note:	Adlib-compatible, Covox 'voice master' & 'speech thing' compatible
	  soundcard
SeeAlso: PORT 022Fh"soundmachine",PORT 0278h"Covox"

0388  -W  Covox 'speech thing' compatible speech output via printer port?
	    enabled if bit 6 set in PORT 038Fh
0388  RW  Adlib compatible (YM3812), enabled if bit 0 set in PORT 038Fh
	    (see PORT 0388h-0389h"Sound Blaster")
0389  -W  Adlib compatible (YM3812), enabled if bit 0 set in PORT 038Fh
	    (see PORT 0388h-0389h"Sound Blaster")
038A  -W  IýC control for TDA7302 NF-MUX and X24C04 EEPROM
	    bit 7: IýC bus SDA out (data),  enabled if bit2=1 in PORT 038Fh
	    bit 0: IýC bus SCL out (clock), enabled if bit2=1 in PORT 038Fh
038B  R-  IýC status for TDA7302 NF-MUX and X24C04 EEPROM
	    bit 7: IýC bus SDA in (data),  enabled if bit2=1 in PORT 038Fh
	    bit 0: IýC bus SCL in (clock), enabled if bit2=1 in PORT 038Fh
038F  RW  configuration port (power on default=0, all features disabled)
	(see #P0647)

Bitfields for mc-soundmachine configuration port:
Bit(s)	Description	(Table P0647)
 7	Covox 'voice master' enabled at PORT 022Fh
 6	 ""   'speech thing' enabled at PORT 03BCh
 5	 ""		     enabled at PORT 0278h
 4	 ""		     enabled at PORT 0378h
 3	not used (0388???)
 2	IýC bus enabled (see PORT 038Ah,PORT 038Bh)
 1	gameport enabled (see PORT 0201h)
 0	AdLib registers (see PORT 0388h,PORT 0389h) enabled
--------s-P038C038F--------------------------
PORT 038C-038F - Pro Audio Spectrum 16 (PAS16)
Range:	PORT 0280h, PORT 0284h, PORT 0288h, PORT 028Ch, PORT 384h,
	  PORT 0388h (default), or PORT 038Ch
----------P03900397--------------------------
PORT 0390-0397 - Sunshine EW-901B, EW-904B
		EPROM writer card for EPROMs up to 27512
0390-0393  ??  addresses of the 8255 on the EW-90xB
----------P0390039F--------------------------
PORT 0390-039F - Cluster adapter (AT)

0390  ??  (adapter 0)	(XT)
0391  ??  (adapter 0)	(XT)
0392  ??  (adapter 0)	(XT)
0393  ??  (adapter 0)	(XT)
----------P03980399--------------------------
PORT 0398-0399 - Dell Enhanced Parallel Port
SeeAlso: PORT 002Eh,PORT 015Ch,PORT 026Eh

0398  -W  index for data port
0399  RW  EPP command data
----------P03980399--------------------------
PORT 0398-0399 - Intel 82091AA Advanced Integrated Peripheral
Range:	PORT 0022h (X-Bus), PORT 0024h (X-Bus), PORT 026Eh (ISA), or
	  PORT 0398h (ISA)
SeeAlso: PORT 0022h"82091AA",PORT 0024h"82091AA",PORT 026Eh"82091AA"

0398  ?W  configuration register index
0399  RW  configuration register data
----------P03A003AC--------------------------
PORT 03A0-03AC - 1st SDLC (Binary Synchronous Data Link Control adapter)
SeeAlso: PORT 0380h"SDLC"
----------P03A003AF--------------------------
PORT 03A0-03AF - 1st BSC (Binary Synchronous Communication) adapter
Notes:	Initialization of the BSC adapter is performed in a typical
	  sequence like this: Setup 8255 port A-C configuration by writing
	  98h to 383h, followed by initializing 8255 port C by writing 0Dh
	  to 382h. Reset 8251A internal registers by pulsing 8255 port B4.
	  After this the 8253 has to be programmed to the desired values
	  (counter 0 not used, counters 1 and 2 to mode 0). Now, the 8251A
	  is ready to be loaded with a set of control words that define the
	  communication environment.
	8251A: The control words are split into two formats, mode
	  instruction and command instruction. The mode instruction must
	  be inserted immediately after a reset operation (via 8255 port B4
	  or setting command instruction bit6 to 'internal reset').
	  The required synchronization characters are next loaded into the
	  8251A (usually 32h for BSC). All control words written to the
	  8251A after this will load the command instruction.
	     reset -> mode instruction
		      SYNC character 1
		      SYNC character 2
		      command instruction
		      data ...
		      command instruction
		      data ...
		      command instruction
		      ...
SeeAlso: PORT 0380h"BSC"

03A0  R-   on adapter 8255(A5) port A: internal/external sensing (see #P0648)
03A1  -W   on adapter 8255(A5) port B: external modem interface (see #P0649)
03A2  RW   on adapter 8255(A5) port C: internal control (see #P0650)
03A3  ?W   on adapter 8255(A5) mode initialization
03A4  RW   on adapter 8253 (programmable counter) counter 0:
		LSB / MSB square wave generator (unused in sync mode)
03A5  RW   on adapter 8253 counter 1: LSB / MSB inactivity time-outs
		(connected to 8255 bitA7, IRQ4 level)
03A6  RW   on adapter 8253 counter 2: LSB / MSB inactivity time-outs
		(connected to 8255 bitA6, IRQ4 level)
03A7  ?W   on adapter 8253 mode register (see #P0651)
03A8  RW   on adapter 8251: data (see #P0652)
03A9  R-   on adapter 8251: command/mode/USART status register (see #P0653)

Bitfields for BSC 8255 port A:
Bit(s)	Description	(Table P0648)
 7	=1 timer 1 output active
 6	=1 timer 2 output active
 5	=1 TxRDY active
 4	receive clock active (if pulsing)
 3	=0 clear to send is on from interface
 2	transmit clock active (if pulsing)
 1	=0 data carrier detect is on from interface
 0	=0 ring indicator is on from interface
SeeAlso: #P0649

Bitfields for BSC 8255 port B:
Bit(s)	Description	(Table P0649)
 7	=1 enable IRQ 4 level interrupt (timer 1 and 2)
 6	=1 gate timer 1
 5	=1 gate timer 2
 4	=1 reset 8251A
 3	=1 not used
 2	=0 turn on test
 1	=0 turn on select standby
 0	=0 turn on data signal rate select
SeeAlso: #P0648,#P0650

Bitfields for BSC 8255 port C:
Bit(s)	Description	(Table P0650)
 7 R-	=0 BSC adapter (=1 may be used to detect SDLC??)
 6 R-	=0 test indicate active
 5 R-	timer 0 output (if pulsing)
 4 R-	receive data (if pulsing)
 3 -W	=0 enable timer 1 and 2 IRQ4 and receive IRQ 4
 2 -W	=1 electronic wrap
 1 -W	=1 gate external clock
 0 -W	=1 gate internal clock
SeeAlso: #P0648,#P0649

Bitfields for BSC 8253 mode register:
Bit(s)	Description	(Table P0651)
 7-6	SC1-SC0	 00, 01, 10= select counter 0,1,2; 11=illegal
 5-4	RL1-RL0	 00= couner latching operation
		 01= read/load most significant byte (MSB)
		 10= read/load least significant byte (LSB)
		 11= read/load LSB first, then MSB
 3-1	M2-M0	 000= mode 0 (for counter 1 and 2)
		 001= mode 1 (not used for BSC)
		 x10= mode 2 (not used for BSC)
		 x11= mode 3 (not used for BSC)
		 100= mode 4 (not used for BSC)
		 101= mode 5 (not used for BSC)
 0	BCD	   0= binary counter 16bits
		   1= BCD counter 4 decades

Bitfields for BSC 8251 data:
Bit(s)	Description	(Table P0652)
---mode instruction (W)---
 7	=0 Double SYNC Character
 6	=1 SYNDET is an Input
 5	=1 Even Parity
 4	=1 Parity Enable
 3-2	Character Length 00=5bits, 01=6bits, 10=7bits, 11=8bits
 1-0	not used (always 0)
---SYNC character 1/2 (W)---
 string of two characters to be sync'ed at (in hunt mode).
---command instruction (W)---
 7	Enter Hunt Mode
 6	Internal Reset
 5	Request to Send
 4	Error Reset
 3	Send Break Character
 2	Receive Enable
 1	Data Terminal Ready
 0	Transmit Enable
---data (RW)---
	any data
SeeAlso: #P0651,#P0653

Bitfields for BSC 8251 command/mode/USART status:
Bit(s)	Description	(Table P0653)
 7	Data Set Ready (indicated that DSR is at 0 level)
 6	SYNDET
 5	Framing Error (not used for synchronous communications)
 4	Overrun Error (OE flag on when Overrun Error occurs)
 3	Parity Error (PE flag on when a parity error occurs)
 2	TxEmpty
 1	RxRDY (causing IRQ 3 level)
 0	TxRDY (has not the same meaning as 8251A TxRDY output pin).
	  THIS one is NOT conditioned by CTS and TxEnable (causing IRQ 4 level)
SeeAlso: #P0652
----------P03AB------------------------------
PORT 03AB - GI1904 Scanner Interface Adapter
Range:	PORT 022Bh, PORT 026Bh, PORT 02ABh (default), PORT 02EBh, PORT 032Bh,
	  PORT 036Bh, PORT 03ABh, PORT 03EBh
----------P03AC------------------------------
PORT 03AC - GS-IF Scanner Interface adapter
Range:	PORT 022Ch, PORT 026Ch, PORT 02ACh, PORT 02ECh (default),
	  PORT 032Ch, PORT 036Ch, PORT 03ACh, PORT 03ECh
Note:	many SPI 400dpi/800dpi gray / H/T handy scanner by Marstek, Mustek and
	  others use this interface
--------V-P03B003BF--------------------------
PORT 03B0-03BF - MDA  (Monochrome Display Adapter based on 6845)

03B0  -W  same as 03B4
03B1  RW  same as 03B5
03B2  -W  same as 03B4
03B3  RW  same as 03B5
03B4  -W  MDA CRT index register	 (MDA/mono EGA/mono VGA)
		selects which register (0-11h) is to be accessed through 03B5h
		Note: this port is read/write on some VGAs
		bit7-6: (VGA) reserved (0)
		bit5  : (VGA) reserved for testing (0)
		bit4-0: selects which register is to be accessed through 03B5h
03B5  RW  MDA CRT data register	 (MDA/mono EGA/mono VGA) (see #P0654,#P0708)
		selected by PORT 03B4h. registers 0C-0F may be read
		Color adapters are at 3D4/3D5, but are mentioned here for
		  better overview.
		There are differences in names and some bits functionality
		  on EGA, VGA in their native modes, but clones in their
		  emulation modes emulate the original 6845 at bit level. The
		  default values are for MDA, HGC, CGA only, if not otherwise
		  mentioned.
03B6  -W  same as 03B4h
03B7  RW  same as 03B5h
03B8  rW  MDA mode control register (see #P0655)
03B9  ?W  reserved for color select register on color adapter
03B9  -W  MDA/HGC: set lightpen flipflop (value written is ignored)
		cannot be found on native mono EGA, mono VGA (without
		  translation ROM)
03BA  R-  CRT status register (see #P0656)
	    (EGA/VGA) input status 1 register
03BA  -W  (mono EGA/mono VGA) feature control register
	    (see PORT 03DAh-W for details; VGA, see PORT 03CAh-R)
03BB  -W  light pen strobe reset (on any value)

(Table P0654)
Values for mono video adapter CRT data register index:
				  defaults:    MDA/HGC	HGC   CGA   CGA	  CGA
						 text  graph text1 text2 graph
						   7  720x348  1     3	  5,6
 00h	horizontal total			  61h	35h   38h   71h	  38h
	      ET4000: in VGA mode scanlines-5
		      in EGA mode scanlines-2
 01h	horizontal displayed			  50h	2Dh   28h   50h	  28h
	      horizontal display end-1 (EGA,VGA)
 02h	horizontal sync position		  52h	2Eh   2Dh 5Ah/5Ch 2Dh
 03h	sync pulse width			  0Fh 07h/0Fh 0Ah   0Ah	  0Ah
	       bit7-4 vsync, bit3-0 hsync
	      end horizontal blanking (EGA,VGA)
	       VGA    : bit7=1	  : enable read access to regs
				    10h, 11h (otherwise VGA clones
				    may show lightpen values)
	       EGA,VGA: bit6-5=0-3: display enable skew control
			bit4-0	  : end blanking
 04h	vertical total (vcycle-1)		  19h	5Bh   1Fh   1Fh	  7Fh
	       bit7 only used on MCGA
	      start horizontal retrace (EGA, VGA)
	      Genoa SuperEGA only???:
	       bit7  : start at odd memory address
	       bit6-5: horizontal sync skew
	       bit4-0: start retrace+ retrace width
 05h	vertical total adjust			  06h	02h   06h   06h	  06h
	       bit7-5 only used on MCGA
	      end horizontal retrace (EGA, VGA)
	       bit7  : (EGA) start at odd memory address
		       (VGA) bit5 of end horizontal retrace
	       bit6-5: horizontal sync skew
	       bit4-0: end horizontal retrace
 06h	vertical displayed			  19h	57h   19h   19h	  64h
	       bit7 only used on MCGA
	      (EGA) vertical total-1
	      (VGA) vertical total-2
 07h	vertical sync pulse width-1		  19h	57h   1Ch   1Ch 70h/66h
	       bit7  only used on MCGA
	      controller overflow (EGA,VGA)
	       bit7: (VGA) bit9 of start vertical retrace (10h)
	       bit6: (VGA) bit9 of vertical display end (12h)
	       bit5: (VGA) bit9 of vertical total (06h)
		     (EGA) bit5 of cursor-position (0Ah)
	       bit4: bit8 of line compare (18h)
	       bit3: bit8 of start vertical blanking (15h)
	       bit2: bit8 of vertical retrace start (10h)
	       bit1: bit8 of vertical display end (12h)
	       bit0: bit8 of vertical total (06h)
 08h	interlace mode (not MCGA)		  02h	02h   02h   02h	  02h
	       bit7-2: reserved
	       bit1  : delay
	       bit0=1: interlace on
	      preset row scan (EGA, VGA)
	       bit7  : reserved
	       bit6-5: (VGA) byte panning (low-order bits of display start addr
		  in odd/even and quad modes
	       bit4-0: start row scan after retrace
 09h	maximum scan lines			  0Dh	03h   07h   07h	  01h
	       bit7  : (VGA) double scan active
	       bit6  : (VGA) bit9 of line compare (18h)
	       bit5  : (VGA) bit9 of start vertical blanking (15h)
	       bit4-0: maximum scan line 00..31 (height-1)
 0Ah	cursor start				  0Bh	00h   06h   06h 06h/00h
	       bit7  : reserved
	       bit6-5: original 6845: cursor on/off, blink interval
		       (not on all adapters, as original MDA, CGA have
		       extra circuitrity to avoid this!!)
	       bit6-5: native EGA: not used
	       bit6  : (VGA) not used
	       bit5=0: (VGA) cursor on
	       bit4-0: first cursor scanline
 0Bh	cursor end				  0Ch	00h   07h   07h 07h/00h
	       bit7  : reserved
	       bit6-5: EGA, VGA: cursor skew control
	       bit4-0: end cursor row
 0Ch RW	start address high			  00h	00h   00h   00h	  00h
	       bit7-6 not used by original 6845 (MDA,HGC,CGA)
 0Dh RW	start address low			  00h	00h   00h   00h	  00h
 0Eh RW	cursor location high			  00h	00h   00h   00h	  00h
	       bit7-4 not used by original 6845 (MDA,HGC,CGA)
	       bit5-4 reserved on MCGA
 0Fh RW cursor location low			  00h	00h   00h   00h	  00h
 10h R-	light pen high (MDA/CGA/EGA only, some HGC, few VGA
	       clones in emulation, not with ET4000)
 10h R- MCGA at 3D5h only: mode control status register (see #P0711)
 11h R- light pen low (MDA/CGA/EGA only, some HGC, few VGA
	       clones in emulation, not with ET4000)
 14h -W HGC+,InColor: xMode register
 15h -W HGC+,InColor: underscore register
 16h -W HGC+,InColor: overstrike register
 17h -W	InColor: exception register
 18h -W	InColor: plane mask register
 19h -W	InColor: read/write control register
 1Ah -W	InColor: read/write color register
 1Bh -W	InColor: Latch Protect register
 1Ch RW	InColor: palette register
Notes:	registers 10h and 11h have varying uses on VGA (see #P0708) and
	  MCGA (see #P0710)
	MDA, HGC, CGA: 6845 registers 00h-0Dh are write only, 0Eh, 0Fh
	       are r/w, and 10h-11h are read only.
	       The alternative initial defaults may be used
	       sometimes on modern adapters.
	HGC+(RamFont): as with HGC, but 3 additional registers for font control
	emulations   : more registers may be r/w, but most often it's the
	       same as with native 6845.
	MCGA (CGA+)  : Though this is a mixture of CGA and VGA, most
	       registers are same as with CGA, but with some
	       enhancements and incompatibilities to EGA, VGA.
	native EGA   : registers 00h-0Bh are write only, 0Ch-0Fh are
	       r/w, 10h-11h are read/write, 12h-18h are write
	       only. More regs may be r/w on enhanced clones.
	GenoaSuperEGA: adapter with chips SEQCRT GN006001 and GRAT
	       GN006002, e.g. c't Super-EGA adapter. Is EGA
	       clone with up to 800x600 and full 6845 emulation.
	native VGA   : all registers 00-18h are r/w, but 00h-07h are
	       write-locked if bit7 in 11h is set.
	ET4000	     : same as VGA, but with additional r/w registers
	       32h-37h, protected by 'key' except 33h, 35h
	       (see 3BFh for details). 35h is protected by
	       bit7 in 11h. The 'key' must be issued at least
	       after each power on or synchronous reset.
SeeAlso: #P0708,#P0710,#P0655,#P0656,#P0710

Bitfields for mono video adapter mode control register:
Bit(s)	Description	(Table P0655)
 7 not used by MDA, page number on HGC
 6	not used
 6  R-O	(mono ET4000 only) report status of bit 1 (enable 2nd page) of
	  Hercules compatibility register (PORT 03BFh)
 5	enable blink (0 = intense background, 1 = blink)
 4	not used
 3	video enable
 2	not used
 1	(MDA) not used
	(HGC) graphics enable
	the 6845 has to be reprogrammed completely, if this bit is
	  changed, otherwise the TTL-monitor may be damaged by wrong
	  sync impulses!
 0	high resolution mode (always set on MDA)
---mono ET4000 only, W-O ---
 7-0	=A0h: second part of 'key', see Hercules compatibility register
	  (PORT 03BFh) for details
Note:	this port might be completely or partially readable on very few MDA,
	  HGC clones or emulations (e.g. Genoa SuperEGA), but not with the
	  majority of original and clone chips.	 It cannot be found on
	  native mono EGA, mono VGA, but on most clones, where it is usually
	  R/W.
SeeAlso: #P0654,#P0656

Bitfields for mono video adapter CRT status register:
Bit(s)	Description	(Table P0656)
 7	HGC: vertical sync pulse in progress
 6-4	adapter identification
	(MSD says) if bit 7 changes within 8000h reads then
	    =000 adapter is Hercules or compatible
	    =001 adapter is Hercules+
	    =101 adapter is Hercules InColor
	    else: adapter is unknown
 6-4	=111 on MDA and some HGC clones
 5-4	(mono EGA, mono ET4000) diagnose video display feedback
	select from color plane enable
 3	(MDA,HGC) pixel stream (0=currently black, 1=currently white)
	(mono EGA, mono VGA) vertical retrace in progress
 2-1	(MDA) reserved
 2	(HGC, mono EGA) lightpen flipflop set
	(mono ET4000) reserved (0)
 1	(HGC) lightpen input stream (if set, current value to get from
	  PORT 03B5h registers 10h-11h)
	(mono ET4000) reserved (0)
 0	horizontal drive enabled
SeeAlso: #P0654,#P0655

Bitfields for EGA,VGA mode control register:
Bit(s)	Description	(Table P0657)
 7	0=CRTC reset and stop, 1=resume reset
 6	0=word-mode, 1=byte-mode (VGA: see 14h, bit6)
 5	0=14bit, 1=16bit address wrap
 4	(native VGA only) reserved (0)
 4	(EGA and most VGA clones) output control
	0: video driver active
	1: video driver not active
 3	linear address counter clock (0 = standard, 1 = clock/2)
	(VGA: see register 14h, bit 5)
 2	horizontal retrace clock (0 = standard, 1 = clock/2)
 1	row scan counter
	0: address bit 14 = scan bit 1
	1: address bit 14 not altered
 0	6845 compatibility mode
	0: address bit 13 = scan bit 0 (as with 6845)
	1: address bit 13 not altered
SeeAlso: #P0654
--------P-P03BC03BF--------------------------
PORT 03BC-03BF - PARALLEL PRINTER PORT (MDA's LPT1)
Range:	PORT 0278h, PORT 0378h, or PORT 03BCh
SeeAlso: MEM 0040h:0008h

03BC  -W  data port
03BC  R-  bidirectional port: input from connector
	  unidirectional port: last value written to port
03BD  R-  status port (see #P0658)
03BE  RW  control port (see #P0659)

Bitfields for parallel interface status port:
Bit(s)	Description	(Table P0658)
 7	busy
 6	NOT acknowledge (approx. 5us low pulse)
 5	out of paper
 4	printer is selected
 3	*no* error
 2	IRQ has *not* occurred
	(PS/2) printer returned -ACK
 1-0	reserved
Note:	if bit 2 is clear (i.e. an interrupt has occurred), it is set again on
	  reading the status register
SeeAlso: #P0659

Bitfields for parallel interface control port:
Bit(s)	Description	(Table P0659)
 7-6	reserved
 7	(see PORT 037Bh bit 7)
 5	(PS/2) enable bidirectional port
	(also requires enabling via PORT 0102h)
 4	enable IRQ (via -ACK)
 3	select printer (SLCT IN line)
 2	=0 initialize printer (-RESET line)
 1	automatic line feed
 0	strobe (must be set for minimum of 5 microseconds)
SeeAlso: #P0658
--------V-P03BF------------------------------
PORT 03BF - Hercules configuration switch register
Note:	can also be found on EGA and VGA clones in Hercules emulation

03BF  -W  configuration switch register (see #P0660)
03BF  -W  (ET4000) Hercules compatibility register (see #P0661)
03BF  RW  (Genoa SuperEGA) miscellaneous register
	Note: only available in MDA, HGC, and CGA emulation; should be
	  compatible with Hercules configuration register, but may contain
	  additional features

Bitfields for Hercules configuration switch register:
Bit(s)	Description	(Table P0660)
 7-2	reserved
 1	=0  disables upper 32K of graphics mode buffer
	=1  enables upper 32K of graphics mode buffer
 0	=0  prevents graphics mode
	=1  allows graphics mode
SeeAlso: #P0661

Bitfields for ET4000 compatibility register:
Bit(s)	Description	(Table P0661)
 1	=0 disables upper 32K of graphics mode buffer
	=1 enables upper 32K of graphics mode buffer
 0	reserved (not needed for HGC graphics)
 7-0	=03h: first part of 'key' for access to some extra
	     ET4000 regs. To issue the 'key', the following
	     code must be executed:
	      MOV DX, 3BFh
	      MOV AL, 3
	      OUT DX, AL
	      MOV DX, 3D8h  (3B8h in mono mode)
	      MOV AL, 0A0h
	      OUT DX, AL
SeeAlso: #P0660
--------V-P03C003C1--------------------------
PORT 03C0-03C1 - EGA/VGA - ATTRIBUTE CONTROLLER
Range:	PORT 03C0h or PORT 02C0h (alternate EGA)
SeeAlso: PORT 03C2h,PORT 03D0h,#P0718

03C0  rW  ATC index/data register
		Every write access to this register will toggle an internal
		  index/data selection flipflop, so that consecutive writes to
		  index & data is possible through this port. To get a defined
		  start condition, each read access to the input status register
		  #1 (3BAh in mono / 3DAh in color) resets the flipflop to load
		  index. If values are changed during the vertical retrace
		  period only no flicker will occur.

		index register (flipflop reset to 'index'): (default 20h)
		  bit7-6: reserved
		  bit5	: 0=CPU access (screen dark),
			  1=video access to registers
		  bit4-0: index in ATC (0..31)

		indexed registers in ATC (flipflop set to 'data'): (see #P0662)
03C1  R-  (VGA)	ATC index/data read register

(Table P0662)
Values for EGA/VGA indexed registers in ATC:
 00h-0Fh 16 palette registers (see #P0663)
 10h	mode control register (see #P0664)
 11h	(EGA) overscan color register (see #P0665) (default: 00h)
 11h	(VGA) overscan color register (see #P0666) (default: 00h)
 12h	color enable register (see #P0667)
 13h	horizontal pixel panning register
	bit7-4: reserved
	bit3-0: horizontal pixel panning
 14h	(VGA) color select register (default: 00h)
	bit7-4: reserved
	bit3  : s-color 7
	bit2  : s-color 6
	bit1  : s-color 5 (only with 16 pages   16 regs)
	bit0  : s-color 4 (only with 16 pages   16 regs)
 16h	ET3000, ET4000 only: ATC miscellanenous
	(at least on ET4000 'key' protected)
	This register is also supported by ET3000, but the
	  description is proved for ET4000 only.
	bit7  : bypass the internal palette
		(e.g. for HiColor modes with Sierra RAMDACs)
	bit6  : reserved
	bit5-4: select high resolution / color mode
	bit3-0: reserved
SeeAlso: #P0670,#P0700

Bitfields for EGA/VGA indexed ATC palette register:
Bit(s)	Description	(Table P0663)
 7-6	reserved
 5	secondary red video
 4	secondary green/intensity video
 3	secondary blue/mono video
 2	primary red video
 1	primary green video
 0	primary blue video
SeeAlso: #P0662

Bitfields for EGA/VGA ATC mode control register:
Bit(s)	Description	(Table P0664)
 7	(VGA) SB/SG select (0=4 pages of 64 regs, 1=16 pages of 16 regs)
 6	(VGA) PELCLK/2 (0=4bit color, 1=8bit color)
 5	(VGA) enable pixel panning (0=all, 1=up to line compare register value)
 4	reserved
 3	background intensity (0=16 colors, 1=blink)
 2	line graphics enable (0=background, 1=line 8=9)
 1	1=mono, 0=color select
 0	1=graphics, 0=text select
SeeAlso: #P0662

Bitfields for EGA overscan color register:
Bit(s)	Description	(Table P0665)
 7-6	reserved
 5	secondary red (SR)
 4	secondary green (SR) / intensity
 3	secondary blue (SB)
 2	primary red (PR)
 1	primary green (PG)
 0	primary blue (PB)
SeeAlso: #P0662,#P0666

Bitfields for VGA overscan color register:
Bit(s)	Description	(Table P0666)
 7	secondary intensity border color (SI)
 6	secondary red (SR)
 5	secondary green (SG)
 4	secondary blue (SB)
 3	intensity border color (PI)
 2	primary red (PR)
 1	primary green (PG)
 0	primary blue (PB)
SeeAlso: #P0662,#P0665

Bitfields for EGA/VGA color enable register:
Bit(s)	Description	(Table P0667)
 7-6	reserved
 5-4	diagnose / video status select
	EGA:		VGA, ET4000:
	00b = PR/PB	   PR/PB
	01b = SB/PG	   SG/SB
	10b = SR/SG	   PI/PG
	11b = reserved	   SI/SR
 3	enable plane 3
 2	enable plane 2
 1	enable plane 1
 0	enable plane 0
SeeAlso: #P0662
----------P03C003C7--------------------------
PORT 03C0-03C7 - Sunshine EW-901, EW-901A, EW-904, EW-904A
Desc:	EPROM writer card for EPROMs up to 27512

03C0-03C3	addresses of the 8255 on the EW-90x
--------V-P03C203CF--------------------------
PORT 03C2-03CF - EGA/VGA - MISCELLANEOUS REGISTERS
Range:	PORT 03C2h or PORT 02C2h (alternate EGA)
SeeAlso: PORT 03C0h,PORT 03C4h,PORT 03C6h,PORT 03D0h

03C2  R-  input status 0 register (see #P0668)
03C2  -W  miscellaneous output register (see #P0669)
03C3  RW  (VGA)	video subsystem enable (see also PORT 46E8h)
		for IBM, motherboard VGA only
			 bit7-4=0: reserved
			 bit3	 : select video subsystem (address 46E8h)
			 bit2-1	 : reserved
			 bit0	 : select video subsystem (address 03C3h)

Bitfields for EGA/VGA input status 0 register:
Bit(s)	Description	(Table P0668)
 7	(VGA) vertical retrace interrupt is pending
	(EGA) =0 vertical retrace in progress
 6-5	(VGA) reserved (0)
 6	(EGA and ET4000) feature control 1 (pin17)
 5	(EGA and ET4000) feature control 0 (pin19)
 4	(VGA) monitor sense signal is asserted
 4	(EGA, Genoa SuperEGA) DIP switch sense
	0=closed, 1=open/switches readable
 3-0	reserved (0)

Bitfields for EGA/VGA miscellaneous output register:
Bit(s)	Description	(Table P0669)
---Genoa SuperEGA in all emulation modes---
 7-6: vertical resolution
	00 (EGA) 200 lines
	01 (VGA) 400 lines
	10 (EGA/VGA) 350 lines
	11 (VGA) 480 lines
------
 7	vertical sync polarity (0=positive, 1=negative)
 6	horizontal sync polarity (0=positive, 1=negative)
 5	odd/even pagebit (=1 select second 64K memory page)
 4	EGA: 0=video driver on,
	     1=video driver off (feature connector used)
 3-2	pixelclock
	00 14/25.175 MHz (EGA/VGA)
	01 16/28.322 Mhz (EGA/VGA)
	10 (EGA/VGA) external clock (EGA)
	10 (Genoa SuperEGA) 39Mhz
	11 (EGA/VGA) reserved
	11 (Genoa SuperEGA) 26.824Mhz
	11 (S3 Trio32/Trio64) enable clock programming via sequencer registers
		  12h and 13h
 1	enable CPU RAM access
 0	CRTC port address
	0=3B4h mono
	1=3D4h color
	   (color EGA: enable feature control at 3DAh,status reg 1 at 3D2h)
----------P03C403C5--------------------------
PORT 03C4-03C5 - EGA/VGA - SEQUENCER REGISTERS
Range:	PORT 03C4h or PORT 02C4h (alternate EGA)
SeeAlso: PORT 03C0h,PORT 03C2h,PORT 03C4h"Cirrus",PORT 03C4h"S3"
SeeAlso: PORT 03C4h"Tseng",PORT 03C6h,PORT 03D0h

03C4  -W  EGA	TS index register
		bit7-3 : reserved (VGA only)
		bit2-0 : current TS index
03C4  RW  VGA	sequencer register index (see #P0670)
03C5  -W  EGA	TS data register
03C5  RW  VGA	sequencer register data

(Table P0670)
Values for EGA/VGA indexed TS (sequencer) registers:
 00h	reset register
	bit7-2 : reserved
	bit1 =0: synchronous reset (EGA/VGA)
	bit0 =0: asynchronous reset (EGA, ET4000)
		 synchronous reset, also (VGA)
 01h	clocking mode register / TS mode (see #P0671)
 02h	map mask register (see #P0672)
 03h	character map select register / font select (see #P0673)
 04h	memory mode register (see #P0674)
 07h	(undoc VGA) reset horizontal character counter
	any write to this register holds horizontal character counter at 00h
	  until any other sequencer register is written
Note:	register 07h is documented in the C&T Wingine documentation
SeeAlso: #P0675,#P0696,#P0685

Bitfields for EGA/VGA sequencer clocking mode register:
Bit(s)	Description	(Table P0671)
 7-6	reserved
 5	(VGA) =1: screen refresh off
 4	(VGA) shift load (0=4x8, 1=1x32)
 3	internal character clock (0=normal, 1=dotclock/2)
 2	serial shift video load (0=4x8, 1=2x16)
 1	(EGA) CRTC bandwidth (0=4/5, 1=2/5)
 0	dot clocks per character (0=9, 1=8) (ET4000: see 06h)
SeeAlso: #P0670

Bitfields for EGA/VGA sequencer map mask register:
Bit(s)	Description	(Table P0672)
 7-4	reserved
 4	Genoa SuperEGA only: plane4 ???
 3	write enable display memory plane 3
 2	write enable display memory plane 2
 1	write enable display memory plane 1
 0	write enable display memory plane 0
SeeAlso: #P0670

Bitfields for EGA/VGA sequencer character map select register:
Bit(s)	Description	(Table P0673)
 7-6	reserved
 5	(VGA) bit3 for second text-font
 4	(VGA) bit3 for first text-font
 3-2	second text-font (attr bit3=1)
 1-0	first text-font (attr bit3=0)
	offset in font memory (4-7: VGA only)
	   0 00b =  0KB
	   0 01b = 16KB
	   0 10b = 32KB
	   0 11b = 48KB
	   1 00b =  8KB
	   1 01b = 24KB
	   1 10b = 40KB
	   1 11b = 56KB
SeeAlso: #P0670

Bitfields for EGA/VGA sequencer memory mode register:
Bit(s)	Description	(Table P0674)
 7-4	reserved
 3	=1 (VGA) enable chain 4 linear graphics mode
	(when set, low two bits of CPU address select the plane)
 2	addressing mode
	0 odd/even mode (even addresses access planes 0/2, odd planes 1/3)
	1 sequential mode
 1	=1 extended memory (0=64KB, 1=more)
 0	(EGA) 1=textmode, 0=graphics mode
SeeAlso: #P0670
----------P03C403C5--------------------------
PORT 03C4-03C5 - Cirrus Logic GRAPHICS - EXTENDED SEQUENCER REGISTERS
SeeAlso: PORT 03C4h"EGA",PORT 03C4h"S3",PORT 03C4h"Tseng"

03C4  RW  sequencer register index (see #P0696)
03C5  RW  sequencer register data

(Table P0675)
Values for Cirrus CL-GD7556 extended sequencer registers:
 00h-04h same as EGA/VGA (see #P0670) 
 06h	"SR6" key register -- enable access to extension registers
	set to xxx1x010 to unlock extended sequencer and CRTC registers
 07h	"SR7" extended sequencer mode (see #P0676)
 08h	"SR8" DDC2B control (see #P0677)
 09h	"SR9" scratch pad #0
 0Ah	"SRA" scratch pad #1
 0Bh	"SRB" VCLK0 numerator  !!!gd7556hrm.pdf p.239
 0Ch	"SRC" VCLK1 numerator
 0Dh	"SRD" VCLK2 numerator
 0Eh	"SRE" VCLK3 numerator
 0Fh	"SRF" display memory control (see #P0678)
 10h	"SR10" hardware cursor/icon coarse horizontal position
 11h	"SR11" hardware cursor/icon coarse vertical position
 12h	"SR12" hardware cursor attributes
 13h	"SR13" hardware cursor pattern address
 14h	"SR14" scratch pad #2
 15h	"SR15" scratch pad #3
 17h	"SR17" BitBLT memory map I/O address
 18h	"SR18" signature generator control
 19h	"SR19" signature generator result (low)
 1Ah	"SR1A" signature generator result (high)
 1Bh	"SR1B" VLK0 denominator/post scaler
 1Ch	"SR1C" VLK1 denominator/post scaler
 1Dh	"SR1D" VLK2 denominator/post scaler
 1Eh	"SR1E" VLK3 denominator/post scaler
 1Fh	"SR1F" MCLK frequency / VCLK source select
 20h	"SR20" miscellaneous control 2
 21h	"SR21" test bus control
 22h	"SR22" hardware configuration read 1
 23h	"SR23" software configuration 1
 24h	"SR24" flat panel type switches enable
 25h	"SR25" FasText(tm) mode control
 26h	"SR26" shader signature (low)
 27h	"SR27" shader signature (high)
 28h	"SR28" scratch pad #4
 29h	"SR29" scratch pad #5
 2Ah	"SR2A" hardware icon #0 control
 2Bh	"SR2B" hardware icon #1 control
 2Ch	"SR2C" hardware icon #2 control / byte-swap enable
 2Dh	"SR2D" hardware icon #3 control / cursor memory access
 2Eh	"SR2E" hardware cursor horizontal position extension
 2Fh	"SR2F" half-frame accel. FIFO threshold for surrounding graphics
 32h	"SR32" half-frame accel. FIFO threshold in video window
 33h	"SR33" spare register
 34h	"SR34" Host CPU cycle stop control
Note:	the scratch pad registers are reserved for use by the VGA BIOS
SeeAlso: #P0670,#P0685,#P0696

Bitfields for Cirrus CL-GD7556 extended sequencer mode register:
Bit(s)	Description	(Table P0676)
 7-4	display memory segment
 3-1	CRT Controller character clock divisor
 0	select high-resolution packed-pixel mode
!!!gd7556hrm.pdf p.234
SeeAlso: #P0675

Bitfields for Cirrus CL-GD7556 DDC2B Control register:
Bit(s)	Description	(Table P0677)
 7	DDCD output status (read-only)
 6-3	reserved
 2	DDCC output status (read-only)
 1	DDCD (I2C SDA) output control
 0	DDCC (I2C SCL) output control
Notes:	bits 1 and 0 are used to drive the I2C bus used for DDC communications;
	  bits 7 and 2 are used to read back the current state of the bus lines
	SR24 bit 7 must be cleared to enable access to the bus
SeeAlso: #P0675,#M0079,I2C A0h"DDC"

Bitfields for Cirrus CL-GD7556 Display Memory Control register:
Bit(s)	Description	(Table P0678)
 7	bank select for display memory
 6	!!!gd7556hrm.pdf p.241
 5	reserved
 4-3	display memory data width
 2	RAS# cycle select for display memory
 1	display memory configuration symmetry
 0	multiple-CAS# / multiple-WE# select for display memory
SeeAlso: #P0823
----------P03C403C5--------------------------
PORT 03C4-03C5 - NVIDIA - EXTENDED SEQUENCER REGISTERS
SeeAlso: PORT 03C4h"EGA",PORT 03C4h"S3",PORT 03C4h"Tseng"

03C4  RW  sequencer register index (see #P0679)
03C5  RW  sequencer register data

(Table P0679)
Values for NVIDIA NV3/RIVA128 extended sequencer registers:
 06h	key register (enable access to extended registers when set to 57h,
	  disable access when set to any other value)
 19h	extended start address and offset
	bits 7-5: offset bits 10-8
	bits 4-0: address bits 20-16
 1Ah	flags (see #P0680)
 1Bh	refresh FIFO control (see #P0681)
 20h	FIFO watermark (see #P0682)
 25h	miscellaneous extension bits (see #P0683)
 28h	framebuffer format
 2Dh	extended horizontal bits (see #P0684)
 30h	graphics cursor control 0
 31h	graphics cursor control 1
 ???

Bitfields for NVIDIA NV3 flags:
Bit(s)	Description	(Table P0680)
 !!!nv3ref.h
SeeAlso: #P0679

Bitfields for NVIDIA NV3 refresh FIFO control:
Bit(s)	Description	(Table P0681)
 7	underflow warning
 2-0	burst length
	000 eight
	001 32
	010 64
	011 128
	100 256
SeeAlso: #P0679,#P0682

Bitfields for NVIDIA NV3 FIFO watermark:
Bit(s)	Description	(Table P0682)
 7	reset FIFO
 5-0	watermark, in eight-byte units (refresh FIFO will start refilling
	  when occupancy falls below twice this value)
SeeAlso: #P0679,#P0681

Bitfields for NVIDIA NV3 miscellaneous extension bits:
Bit(s)	Description	(Table P0683)
 5	offset bit 11
 4	horizontal blanking end, bit 6
 3	vertical blanking start, bit 10
 2	vertical retrace start, bit 10
 1	vertical display end, bit 10
 0	vertical total, bit 10
SeeAlso: #P0679,#P0684

Bitfields for NVIDIA NV3 extended horizontal bits:
Bit(s)	Description	(Table P0684)
 4	"inter_half_start" bit 8
 3	horizontal retrace start, bit 8
 2	horizontal blanking start, bit 8
 1	display end, bit 8
 0	display total, bit 8
SeeAlso: #P0679,#P0683
----------P03C403C5--------------------------
PORT 03C4-03C5 - S3 GRAPHICS - EXTENDED SEQUENCER REGISTERS
SeeAlso: PORT 03C4h"EGA",PORT 03C4h"Cirrus",PORT 03C4h"Tseng",PORT 03C4"NVIDIA"

03C4  RW  sequencer register index (see #P0685)
03C5  RW  sequencer register data

(Table P0685)
Values for S3 extended sequencer registers:
 00h-04h same as EGA/VGA (see #P0670) 
 08h	S3 864/964/765 (Trio64V): key register -- enable access to S3 extended
	  registers when set to x6h
---S3 Trio32/Trio64/Trio64V+ ---
 09h	"SR9" MMIO-Only
	bit 7: disable port I/O when memory-mapped I/O is enabled
	bits 6-0: reserved
	bit 1: ??? (set by Stealth64 Video 2001)
 0Ah	"SRA" external bus request control register (see #P0686)
 0Bh	"SRB" miscellaneous extended sequencer register (see #P0687)
 0Dh	"SRD" VSYNC/HSYNC control (see #P0689)
 10h	"SR10" MCLK value (low) (see #P0690)
 11h	"SR11" MCLK value (high) (see #P0691)
 12h	"SR12" DCLK value (low) (see #P0690)
 13h	"SR13" DCLK value (high) (see #P0691)
 14h	"SR14" CLKSYN control 1 (see #P0692)
 15h	"SR15" CLKSYN control 2 (see #P0693)
 16h	"SR16" CLKSYN Test (high) (reserved for testing of clock synth)
 17h	"SR17" CLKSYN Test (low) (reserved for testing of clock synth)
 18h	"SR18" RAMDAC/CLKSYN Control (see #P0694)
---S3 Trio64V+ ---
 1Ch	"SR1C" signal select (see #P0695)
SeeAlso: #P0670,#P0675,#P0696

Bitfields for S3 Trio32/64/64V+ "SRA" external bus request control register:
Bit(s)	Description	(Table P0686)
 7	fast CPU writes
	when set and MCLK is less than 57 MHz, CPU writes take 2 MCLKs instead
	  of 3 MCLKs (for MCLKs of 55-57 MHz, SR15 bit 7 should also be set)
 6	(Trio64) Pin50 function select
	=0 (CR36 bit 2=1) Pin50 outputs a second -OE0 signal
	=1 (CR36 bit 2=1) Pin50 outputs -RAS1
 5	=0 tri-state pixel-data lines (reduces power consumption)
 4-0	maximum 2*MCLKs that secondary memory controllers are granted access to
	  Trio's memory bus
Note:	bit 6 must be set for 4M fast page-mode memory; it has no effect if
	  EDO memory is selected via CR36 bit 2
SeeAlso: #P0685

Bitfields for S3 Trio32/64/64V+ "SRB" misc extended sequencer register:
Bit(s)	Description	(Table P0687)
 7-4	alternate color mode (for feature connector input) (see #P0688)
 3	(Trio32 only) enable packed 24 bpp (mode 12); also requires CR67 bits
		  7-4=0000
 2	reserved
 1	VAFC clocking
	=0 latch pixel data from pass-through feature connector on VCLK
	=1 latch pixel data from VAFC on VCLKI
 0	dot clock select (testing only)
	=0 use internal dot clock
	=1 use VCLKI
SeeAlso: #P0685,#P0751

(Table P0688)
Values for S3 Trio32/Trio64 color mode:
0000	mode 0 = 8-bit, 1 pixel/VCLK
0001	mode 8 = 8-bit, 2 pixels/VCLK
0011	mode 9 = 15-bit, 1 pixel/VCLK
0101	mode 10 = 16-bit, 1 pixel/VCLK
0111	mode 12 = 640x480x24-bit (packed), 1 pixel/3 DCLKs (Trio32 only)
1101	mode 13 = 24-bit, 1 pixel/VCLK
else	reserved
Note:	mode 8 also requires SR18 bit 7=1 and either SR15 bit 4=1 or
	  SR15 bit 6=1
SeeAlso: #P0687,#P0751

Bitfields for S3 "SRD" Trio32/Trio64 VSYNC/HSYNC control:
Bit(s)	Description	(Table P0689)
 7-6	vertical sync control
	00 normal operation
	01 force to 0
	10 force to 1
	11 reserved
 5-0	horizontal sync control (settings as for vsync)
 3-1	reserved
 1	(Trio64V+) feature connector type
	=0 Trio64-compatible
	=1 new LPB type
 0	enable feature connector
Note:	bits 7-4 are used to select the DPMS power mode as follows:
	    0000 On
	    0001 Standby
	    0100 Suspend
	    0101 Off
SeeAlso: #P0685

Bitfields for S3 Trio32/Trio64 "SR10"/"SR12" MCLK/DCLK value (low):
Bit(s)	Description	(Table P0690)
 7	reserved
 6-5	PLL R value
 4-0	PLL N-divider value
SeeAlso: #P0691,#P0685

Bitfields for S3 Trio32/Trio64 "SR11"/"SR13" MCLK/DCLK value (high):
Bit(s)	Description	(Table P0691)
 7	reserved
 6-0	PLL M-divider value
SeeAlso: #P0690,#P0685

Bitfields for S3 Trio32/Trio64 "SR14" CLKSYN control 1:
Bit(s)	Description	(Table P0692)
 7	select external DCLK (testing only; also requires external strapping)
 6	select external MCLK (testing only)
 5	select Pin146 function
	=0 use as -STRD
	=1 tri-state output; use as input (required to enable bit 6)
 4	clear clock synthesizer counters (testing only)
 3	"M TEST" MCLK test
	=0 test DCLK
	=1 test MCLK
 2	enable clock synthesizer counters (testing only)
 1	power down MCLK PLL (testing only)
 0	power down DCLK PLL (testing only)
SeeAlso: #P0693,#P0685

Bitfields for S3 Trio32/Trio64 "SR15" CLKSYN control 2:
Bit(s)	Description	(Table P0693)
 7	enable fast memory writes (2 MCLKs instead of 3 MCLKs) by bypassing
	  VGA lienar addressing logic (requires SRA bit 7 set)
 6	invert DCLK
 5	load MCLK and DCLK immediately on transition from 1 to 0
 4	divide DCLK by 2
 3	VLCK direction
	=0 Pin148 always outputs internal VCLK
	=1 -EVCLK signal determines VLCK direction
 2	MCLK output (testing only)
	=0 Pin147 acts as STWR strobe
	=1 Pin147 outputs internal MCLK
 1	enable new DCLK frequency load (asynchronous)
 0	enable new MCLK frequency load
Notes:	bits 1 and 5 also require that PORT 03C2h bits 3-2=11
	bit 5 must never be left set; it should only be pulsed to cause the
	  MCLK/DCLK load
	bit 0 should be cleared after loading the new MCLK value to avoid
	  repeated loading
	either bit 4 or 6 must be set for clock-doubled RAMDAC operation
	  (see #P0686)
SeeAlso: #P0692,#P0694,#P0685

Bitfields for S3 Trio32/Trio64 "SR18" RAMDAC/CLKSYN control:
Bit(s)	Description	(Table P0694)
 7	enable clock-doubled mode (see also #393)
 6	fast LUT write cycle (1 DCLK instead of default 2 DCLKs)
 5	power down RAMDAC (RAMDAC memory is retained even when powered down)
 4	(testing only) place blue data on internal data bus
 3	(testing only) place green data on internal data bus
 2	(testing only) place red data on internal data bus
 1	(testing only) reset RAMDAC test counter
 0	(testing only) enable test counter
SeeAlso: #P0693

Bitfields for S3 Trio64V+ "SR1C" signal select:
Bit(s)	Description	(Table P0695)
 7-2	reserved
 1-0	signal select
	VL-Bus:
	    00 Pin151 is ENFEAT#, Pin153 is ROMCS# (default)
	    01 Pin151 is GPIOSTR#, Pin153 is ROMCS#
	    10 Pin151 is GOP0, Pin153 is ROMCS#
	    11 Pin151 is GOP0, Pin153 is GOP1
	PCI:
	    00 Pin151 is ENFEAT#, Pin190 is STWR#, Pin153 is ROMEN# (default)
	    01 Pin151 is reserved, Pin190 is STWR#, Pin153 is ROMEN#
	    1x Pin151 is GOP0, Pin190 is GOP1, Pin153 is ROMEN#
SeeAlso: #P0073
----------P03C403C5--------------------------
PORT 03C4-03C5 - Tseng Labs GRAPHICS - EXTENDED SEQUENCER REGISTERS
SeeAlso: PORT 03C4h"EGA",PORT 03C4h"Cirrus",PORT 03C4h"S3"

03C4  RW  sequencer register index (see #P0696)
03C5  RW  sequencer register data

(Table P0696)
Values for Tseng Labs extended sequencer registers:
 00h-04h same as EGA/VGA (see #P0670)
 06h	ET3000 only: Zoom control register
 06h	ET4000 only: TS state control (protected by 'key')
	bit7-3 : reserved
	bit2-1 : timing sequencer state bit2-1
		   (bit0 is bit0 TS mode register)
		   00 0b=  9 dots
		   00 1b=  8 dots
		   01 0b= 10	  (10-16 are ET4000 only)
		   01 1b= 11
		   10 0b= 12
		   11 1b= 16
	bit0	: reserved
 07h	ET3000/ET4000 only: TS auxiliary mode (see #P0697)
SeeAlso: #P0670,#P0675,#P0685

Bitfields for ET3000/ET4000 sequencer auxiliary mode:
Bit(s)	Description	(Table P0697)
 7	compatibility mode (1=VGA, 0=EGA)
 6	select MCLK/2 (with bit0=0)
 5	BIOS ROM address map 2
 4	reserved
 3	BIOS ROM address map 1
 2	reserved (1)
 1	select SCLK input from MCLK
 0	select MCLK/4 (with bit6=1)
 5+3	ROM address
	00 C0000-C3FFF
	01 disabled
	10 C0000-C5FFF, C6800-C7FFF
	11 C0000-C7FFF (default)
Notes:	at least on the ET4000, this register is protected by a 'key'
	this register is also supported by ET3000, but the above description
	  is based on the ET4000
SeeAlso: #P0670
--------V-P03C603C9--------------------------
PORT 03C6-03C9 - EGA/VGA/MCGA - DAC REGISTERS
Range:	PORT 03C6h or PORT 02C6h (alternate)
SeeAlso: PORT 03C0h,PORT 03C2h,PORT 03C4h,PORT 03CAh,PORT 03CEh"EGA",PORT 03D0h
SeeAlso: PORT 83C6h"Wingine"

03C6  RW  (VGA, MCGA) PEL mask register (default FFh)
		 VGA:	AND mask for color-register address.
		 MCGA:	Never change from the default FFh.
03C6  RW  HiColor ET4000 (Sierra RAMDACs e.g. SC11486, SC11481, SC11488):
		 Enable HiColor feature: beside other assignments,
		 consequtive read 3C6h 4 times and write magic value 80h to it.
03C7  -W  (VGA,MCGA,CEG-VGA) PEL address register (read mode)
		 Sets DAC in read mode and assign start of color register
		 index (0..255) for following read accesses to 3C9h.
		 Don't write to 3C9h while in read mode. Next access to
		 03C8h will stop pending mode immediatly.
03C7  -W  (CEG-Color VGA w/ Edsun Labs RAMDACs)
		 Enable and set Countinous Edge Graphics Mode:
		 Consecutive writely the following three key sequences in read
		 mode (!) to 3C9h register DEh : 'CEG', 'EDS', 'UNx' (x see
		 below). Current CEG mode can be read from palette register
		 BFh 'blue', write access to that register will disable CEG
		 features.
		 In CEG modes by combining old with new colors and dynamically
		 changing palette values, the effective colors displayable
		 are enhanced dramatically (in EDP modes up to virtually 32bit
		 truecolor) on standard 16/256 color VGA. Also, effective
		 resolution enhancement takes effect by anti-aliasing.
		 Necessary EDP escape sequences should be moved to image
		 border or single colored areas, if possible.

		 REP-mode: if pixel are doubled in current video mode
		 EDP-mode: pseudo-truecolor with Edsun dynamic palette
		 (see #P0698,#P0699)

		 Palette-color-register single-byte-format (each 3 times):
		  Mode A:		  Mode C:
		   bit7-4: mix code	   bit3	 : 0=color, 1=code
		   bit3-0: color code	   bit2-0: color / mix code
		  Mode B:		  Mode D:
		   bit7-5: mix code	   bit7-0: see mix code table
		   bit4	 : 0=new, 1=old	  Non-CEG modes:
		   bit3-0: color code	   bit7-0: as usual

		 In EDP modes, video-memory-palette-changing escape-sequences:
		  Mode A:     Mode B:	  Mode C:     Mode D:
		   7/escape    7/escape	   7/escape    0BFh
		   red	       red	   red7-4      red
		   green       green	   red3-0      green
		   blue	       blue	   green7-4    blue
		   address     address	   green3-0    address
					   blue7-4
					   blue3-0
					   address
03C7  R-  VGA	DAC state register
		bit7-2 reserved
		bit1-0: 00b write palette cycle (write mode)
			01h reserved
			10b reserved
			11b read palette cycle (read mode)
03C8  RW  (VGA,MCGA) PEL address register (write mode)
		 Sets DAC in write mode and assign start of color register
		 index (0..255) for following write accesses to 3C9h.
		 Don't read from 3C9h while in write mode. Next access to
		 03C8h will stop pending mode immediatly.
03C8  RW  (Genoa SuperEGA) SuperEGA control register (all emulation modes)
		  bit7-2: reserved
		  bit1	: 0=EGA mode, 1=backward compatibility mode
		  bit0	: not used
03C8  R?  (S3 Trio32/64) General Input Port (see #P0738)
03C9  RW  (VGA,MCGA) PEL data register
		 Three consequtive reads (in read mode) or writes (in write
		 mode) in the order: red, green, blue. The internal DAC index
		 is incremented each 3rd access.
		  bit7-6: HiColor VGA DACs only: color-value bit7-6
		  bit5-0:			 color-value bit5-0

(Table P0698)
Values for EDSUN CEG (Continuous Edge Graphics) modes::
 x:  mode:	 colors:  mix:	pixel depth:  effective colors:
 0 = disabled	   256	   -	     8		    256
 1 = A		    16	  16	     8		   1920
 2 = A+REP	    16	  16	  8 dblscn	   1920
 3 = A+EDP	    15	  16			truecolor
 4 = reserved	     -	   -	     -		     -
 5 = B		    16	   8	     8		    960
 6 = B+REP	    16	   8	  8 dblscn	    960
 7 = B+EDP	    15	   8			truecolor
 8 = reserved	     -	   -	     -		     -
 9 = C		     8	   8	     4		    224
 10 = C+REP	     8	   8	  4 dblscn	    224
 11 = C+EDP	     7	   8			truecolor
 12 = reserved	     -	   -	     -		     -
 13 = D		   223	  32	     8		 792096
 14 = D+REP	   223	  32	  8 dblscn	 792096
 15 = D+EDP	   223	  32			truecolor
SeeAlso: #P0699

(Table P0699)
Values for EDSUN CEG mixing codes:
 Mode A:	       |  Mode C:
 mix: new:	old:   |   mix: new:   old:   colorcode:
   0 = 32/32	0/32   |    0 =	  -	 -     0
   1 = 30/32	2/32   |    1 =	  -	 -     1
   2 = 28/32	4/32   |    2 =	  -	 -     2
   3 = 26/32	6/32   |    3 =	  -	 -     3
   4 = 24/32	8/32   |    4 =	  -	 -     4
   5 = 22/32   10/32   |    5 =	  -	 -     5
   6 = 20/32   12/32   |    6 =	  -	 -     6
   7 = 18/32   14/32   |    7 =	  -	 -     7/EDP
   8 = 16/32   16/32   |    8 = 30/32	2/32   -
   9 = 14/32   18/32   |    9 = 28/32	4/32   -
  10 = 12/32   20/32   |   10 = 26/32	6/32   -
  11 = 10/32   22/32   |   11 = 24/32	8/32   -
  12 =	8/32   24/32   |   12 = 22/32  10/32   -
  13 =	6/32   26/32   |   13 = 20/32  12/32   -
  14 =	4/32   28/32   |   14 = 18/32  14/32   -
  15 =	2/32   30/32   |   15 = 16/32  16/32   -
---Mode B:	       |  Mode D:
 mix: new:	old:   |   mix:	      new:   old:  description:
   0 = 30/32	2/32   |   00h..BEh =	-      -   normal color
   1 = 26/32	6/32   |   BFh	    =	-      -   EDP
   2 = 22/32   10/32   |   C0h	    = 32/32   0/32
   3 = 18/32   14/32   |   C1h	    = 31/32   1/32
   4 = 14/32   18/32   |   C2h	    = 30/32   2/32
   5 = 10/32   22/32   |   ...	    =  ...    ...
   6 =	6/32   26/32   |   DFh	    =  0/32  32/32
   7 =	2/32   30/32   |   E0h-FFh  =	-      -   normal color
SeeAlso: #P0698
--------V-P03CA03CD--------------------------
PORT 03CA-03CD - EGA/VGA/MCGA - GRAPHICS POSITION
Range:	PORT 03C0h or PORT 02C0h (alternate)
SeeAlso: PORT 03C0h,PORT 03C2h,PORT 03C4h,PORT 03C6h,PORT 03CEh"EGA",PORT 03D0h

03CA  -W  EGA	graphics 2 position register
03CA  R-  VGA	feature control register (see PORT 03BAh,PORT 03DAh-W)
03CB  RW  (ET4000/W32) GDC segment select register 2 ('key' protected?)
		The existence of this r/w register 0..255 is often
		 used to decide between ET4000 and ET4000/W32.
		 bit7-6: reserved, but existent
		 bit5-4: bits 5-4 of read segment pointer
		 bit3-2: reserved, but existent
		 bit1-0: bits 5-4 of write segment pointer
03CC  -W  EGA	graphics 1 position register
03CC  R-  VGA	miscellaneous output register (see PORT 03C2h-W,#P0669,#P0820)
03CD  RW  (ET3000, ET4000, ET4000/W32) GDC segment select ('key' protected)
		The existence of this r/w register is often used as
		detection of ET3000, ET4000 and ET4000/W32 chips.
		 bit7-4: read segment pointer for mapping to A0000h
		 bit3-0: write segment pointer for mapping to A0000h
--------V-P03CE03CF--------------------------
PORT 03CE-03CF - EGA/VGA/MCGA - GRAPHICS CONTROLLER REGISTERS
Range:	PORT 03CEh or PORT 02CEh (alternate EGA)
SeeAlso: PORT 03C0h,PORT 03C2h,PORT 03C4h,PORT 03C6h,PORT 03D0h
SeeAlso: PORT 03CEh"Chips&Technologies"

03CE  -W  EGA	GDC index register
03CE  RW  VGA	graphics address register / GDC index
		      bit7-4: reserved
		      bit3-0: index
03CF  -W  EGA	GDC data register (see #P0700)
03CF  RW  VGA	other graphics register (see #P0700)

(Table P0700)
Values for EGA/VGA indexed registers in GDC:
 00h	set/reset register (default 00h)
	functionality depending on write mode (register 05h) (see #P0704)
	bit7-4: reserved
	bit3  : 0=write 00h, 1=write FFh in plane 3
	bit2  : 0=write 00h, 1=write FFh in plane 2
	bit1  : 0=write 00h, 1=write FFh in plane 1
	bit0  : 0=write 00h, 1=write FFh in plane 0
 01h	enable set/reset register (default 00h) (see #P0701)
 02h	color compare register (default 00h) (see #P0702)
 03h	data rotate register (default 00h) (see #P0703)
 04h	read map select register (default 00h)
	bit7-3: reserved
	bit2  : EGA?? & Genoa SuperEGA: map select bit2
	bit1-0: map select (0..3)
 05h	mode register (see #P0704)
 06h	miscellaneous register (see #P0705)
 07h	color don't care register
	bit7-4: reserved
	bit3=1: color plane 3 don't care (ignore bit3)
	bit2=1: color plane 2 don't care (ignore bit2)
	bit1=1: color plane 1 don't care (ignore bit1)
	bit0=1: color plane 0 don't care (ignore bit0)
 08h	bit mask register (default FFh)
	bit7-0: bitmask for latch/databyte
	      (bit set=change allowed)
---Paradise SuperVGA---
 0Fh	lock register
	The ability to write and reread 00h..07h to this register
	is often used as detection of Paradise chips.
	bit7-0 = 01h lock/hide Paradise specific registers
	       = 05h unlock Paradise specific registers
	bit7-3: reserved
	bit2-0: flipflops, reserved
SeeAlso: #P0706

Bitfields for EGA/VGA GDC enable set/reset register:
Bit(s)	Description	(Table P0701)
 7-4	reserved (used on Genoa SuperEGA???)
 3	enable set/reset plane 3
 2	enable set/reset plane 2
 1	enable set/reset plane 1
 0	enable set/reset plane 0
 3-0	0=CPU access, 1=set/reset access to plane
SeeAlso: #P0700

Bitfields for EGA/VGA GDC color compare register:
Bit(s)	Description	(Table P0702)
 7-4	reserved
 3	color compare 3
 2	color compare 2
 1	color compare 1
 0	color compare 0
 3-0	(color number)
SeeAlso: #P0700

Bitfields for EGA/VGA data rotate register (GR3):
Bit(s)	Description	(Table P0703)
 7-5	reserved
 4-3	logical function select
	00 CPU-data overwrites
	01 CPU-data AND with latch-register
	10 CPU-data OR with latch-register
	11 CPU-data XOR with latch-register
 2-0	rotate count
SeeAlso: #P0700

Bitfields for EGA/VGA GDC mode register:
Bit(s)	Description	(Table P0704)
 7	reserved
 6	(VGA) 0=standard, 1=enable 256 colors
 5	shift register mode, 0=standard, 1=CGA-graphics
	  (not used on Genoa SuperEGA???)
 4=1	enable odd/even address mode
 3	read mode, 0=mode0, 1=mode1
 2	(EGA) test condition, 0=standard, 1=output tristate
 1-0	write mode
	00 mode0, plane source is CPU or set/reset
	01 mode1, plane source is latch-register
	10 mode2, plane source is CPU as set/reset
	11 (VGA) mode3, CPU as set/reset AND bitmask
SeeAlso: #P0700

Bitfields for EGA/VGA GDC miscellaneous register:
Bit(s)	Description	(Table P0705)
 7-4	reserved (=0)
 3-2	memory map
	00b = A0000..BFFFF (128KB)
	01b = A0000..AFFFF (64KB)
	10b = B0000..B7FFF (32KB)
	11b = B8000..BFFFF (32KB)
 1	chain odd maps to even, 1=subst addess bit0
 0	0=textmode, 1=graphics mode
SeeAlso: #P0700
--------V-P03CE03CF--------------------------
PORT 03CE-03CF - Chips&Technologies - GRAPHICS CONTROLLER EXTENDED REGISTERS
SeeAlso: PORT 03CE"EGA"

03CE  RW  graphics address register / GDC index
03CF  RW  other graphics register (see #P0706)

(Table P0706)
Values for Cirrus CL-GD7556 extended GDC registers:
 00h-08h same as EGA/VGA (see #P0700)
 09h	"GR9" display memory offset 0
 0Ah	"GRA" display memory offset 1
 0Bh	"GRB" graphics controller mode extensions
 0Ch	"GRC" color key compare value / chroma key Y minimum
 0Dh	"GRD" color key compare mask / chroma key Y maximum
 0Eh	"GRE" DPMS control
 10h	"GR10" background color expansion 1
 11h	"GR11" foreground color expansion 1
 13h	"GR13" foreground color expansion 2
 16h	"GR16" scanline counter readback (low)
 17h	"GR17" scanline counter readback (high)
 18h	"GR18" EDO RAM control
 1Ah	"GR1A" scratch pad #6
 1Bh	"GR1B" scratch pad #7
 1Ch	"GR1C" chroma-key U minimum
 1Dh	"GR1D" chroma-key U maximum
 1Eh	"GR1E" chroma-key V minimum
 1Fh	"GR1F" chroma-key V maximum
 20h	"GR20" BitBLT width (low)
 21h	"GR21" BitBLT width (high)
 22h	"GR22" BitBLT height (low)
 23h	"GR23" BitBLT height (high)
 24h	"GR24" BitBLT destination pitch (low)
 25h	"GR25" BitBLT destination pitch (high)
 26h	"GR26" BitBLT source pitch (low)
 27h	"GR27" BitBLT source pitch (high)
 28h	"GR28" BitBLT destination address (low)
 29h	"GR29" BitBLT destination address (middle)
 2Ah	"GR2A" BitBLT destination address (high)
 2Ch	"GR2C" BitBLT source address (low)
 2Dh	"GR2D" BitBLT source address (middle)
 2Eh	"GR2E" BitBLT source address (high)
 2Fh	"GR2F" BitBLT destination write mask
 30h	"GR30" BitBLT mode
 31h	"GR31" BitBLT start/status
 32h	"GR32" BitBLT raster operation
 33h	"GR33" BitBLT mode extensions
!!! (details to be added)
Note:	the scratch pad registers are reserved for use by the VGA BIOS
SeeAlso: #P0700
--------V-P03CE03CF--------------------------
PORT 03CE-03CF - Compaq Qvision - Functionality Level

03CE  -W  graphics address register (index for next port) (see #P0707)
03CF  RW  other graphics register

(Table P0707)
Values for Compaq QVision graphics register index:
 0Ch  RO    controller version
		2Fh Advanced VGA
		37h early QVision 1024
		71h QVision 1280 or later QVision 1024
 0Dh	    extended controller version
 0Eh	    extended controller capabilities
 0Fh	    environment info
 54h	    available memory
 55h	    phase-locked-loop clock
 56h-57h    controller capabilities
--------V-P03D003D3--------------------------
PORT 03D0-03D3 - CGA (Color Graphics Adapter) - MIRRORS OF 03D4/03D5

03D0  -W  same as PORT 03D4h
03D1  RW  same as PORT 03D5h
03D2  -W  same as PORT 03D4h
03D3  RW  same as PORT 03D5h
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - COLOR VIDEO - CRT CONTROL REGISTERS

03D4  rW  CRT (6845) register index   (CGA/MCGA/color EGA/color VGA)
	selects which register (0-11h) is to be accessed through 03D5
	this port is r/w on some VGA, e.g. ET4000
	    bit 7-6 =0: (VGA) reserved
	    bit 5   =0: (VGA) reserved for testage
	    bit 4-0   : selects which register is to be accessed through 03D5
03D5  -W  CRT (6845) data register   (CGA/MCGA/color EGA/color VGA) (see #P0708)
	selected by PORT 03D4h. registers 0C-0F may be read
	  (see also PORT 03B5h)
	MCGA, native EGA and VGA use very different defaults from those
	  mentioned for the other adapters; for additional notes and
	  registers 00h-0Fh and EGA/VGA registers 10h-18h and ET4000
	  registers 32h-37h see PORT 03B5h (see #P0654)
	registers 10h-11h on CGA, EGA, VGA and 12h-14h on EGA, VGA are
	  conflictive with MCGA (see #P0710)

(Table P0708)
Values for EGA/VGA+ CRT Controller register index:
 00h-0Fh	same as MDA/CGA (see #P0654)
 10h R-	native VGA with bit7=1 in end horizontal blanking (03h) and ET4000:
	       start vertical retrace
 10h -W start vertical retrace
 11h R- native VGA with bit7=1 in end horizontal blanking (03h):
	       end vertical retrace
 11h -W end vertical retrace
	       bit7  : VGA: protection bit
			    =0 enable write access to 00h-07h
			    =1 read only regs 00h-07h with the exception
			       of bit4 in 07h. ET4000: protect 35h also.
	       bit6  : VGA: =0 three, =1 five refreshcycles/line
		       ET4000: reserved
	       bit5=0: (MCGA also) enable vertical interrupt
	       bit4=0: (MCGA also) clear vertical interrupt
		   =1:		   no effect
	       bit3-0: (MCGA also) vertical retrace end
 12h	vertical display end register
 13h	row offset register
	       logical screen line width in
		byte mode : bytes/(line/2)
		word mode : bytes/(line/4)
		dword mode: bytes/(line/8)
 14h	underline location register
	       bit7: reserved (0)
	       bit6: (VGA) 0=word-mode, 1=dword-mode (see 17h, bit6)
	       bit5: (VGA) 0=standard address counter clock
			   1=address counter clock/4 (see 17h, bit3)
	       bit4-0: horizontal underline row scan
 15h	(EGA,VGA) start vertical blanking-1
 16h	(EGA,VGA) end vertical blanking register
	       bit7-5 : EGA: reserved, but used on original EGA???
	       bit4-0 : end vertical blanking
 17h	(EGA,VGA) "CR17" mode control register (see #P0657)
 18h	(EGA,VGA) "CR18" line compare register
 19h	Genoa SuperEGA only: double scan control
	       at 3B5h only in MDA, HGC emulation, but at 3D5h even in
	       mono EGA modes.
	       bit7-5 : reserved
	       bit4   : HR/VR width adjust flag for double scan mode
	       bit3-1 : 1=test, 0=normal
	       bit0   : double scan enable
 1Dh	Elsa Victory Erazor only: video page select for writing
		bits 7-1 = offset into video memory in 64K units
		bit 0: ???
 1Eh	Elsa Victory Erazor only: video page select for reading
		bits 7-1 = offset into video memory in 64K units
		bit 0: ???
 22h	(VGA) "CR22" CPU Latch Data Register (read-only)
 24h	(VGA) "CR24" Attribute Controller Toggle register (R-O) (see #P0709)
 3xh	(VGA)  !!!chips\64200.pdf p.57
Notes:	registers 10h-14h on the MCGA have conflicting uses (see #P0710)
	registers 22h,24h, and 3xh exist on the standard IBM VGA but were not
	  documented
SeeAlso: #P0756,#P0716,#P0717

Bitfields for VGA "CR24" Attribute Controller Toggle register:
Bit(s)	Description	(Table P0709)
 7-3	current attribute controller index
 2	palette address source
 1	reserved
 0	state of attribute-controller flip-flop (0 = index, 1 = data)
Note:	this register was not documented for the original IBM VGA; this
	   description is from the C&T Wingine documentation
SeeAlso: #P0708,#P0718

(Table P0710)
Values for MCGA (only) CRT Controller register index:
 00h-0Fh	same as MDA/CGA (see #P0654)
 10h -W mode control register (defaults 18h, 1Ah, 19h) (see #P0711)
 10h R-	mode control status register (see #P0712)
 11h -W	interrupt control register (default 30h) (see #P0713)
 12h RW	character generator/sync polarity register (see #P0714)
 12h R-	display sense register (int. control reg [11h] bit7=1)
	bit 7-2	 : not used
	bit 1-0	 : pins 11 & 12 in monitor cable
		00b = reserved
		01b = analogue monochrom monitor
		10b = analogue color graphics monitor
		11b = no monitor
 13h -W character font pointer register (see #P0710)
	only 00h, 10h, 20h, 30h (default 00h) are allowed here
	  for textmode fonts at A0000, A2000, A4000, A6000
 14h -W	number of characters to load during vert. retrace period (default FFh)
Note:	registers 10h-14h can appear at PORT 03D5h only, not at 03B5h
SeeAlso: #P0654,#P0708,#P0756,#P0715

Bitfields for MCGA (only) CRT mode control register:
Bit(s)	Description	(Table P0711)
 7	suppress hsync/vsync
 6	reserved (0)
 5	reserved
 4	dot clock rate
 3	refresh calculations in 80x25 modes
 2	reserved
 1	videomode 11h active
 0	videomode 13h active
SeeAlso: #P0710,#P0712

Bitfields for MCGA (only) CRT mode control status register:
Bit(s)	Description	(Table P0712)
 7	status bit0 CGA mode control register
 6	reserved
 5	clockrate 640 pixel, =0: clockrate/2 320 pixel
 4	clock rate is 25,175Mhz
 3	currently in textmode
 2	double-scan activated
 1	videomode 11h active
 0	videomode 13h active
SeeAlso: #P0710,#P0711

Bitfields for MCGA (only) CRT interrupt control register:
Bit(s)	Description	(Table P0713)
 7	set output driver to tristate
	=0: for reading of character generator reg (12h)
	=1: for reading of display sense register (12h)
 6   R	intr generated by memory controller
 5	=0 requested intr ok to handle
 4	=0 free interrupt latch register
 3-0	reserved
SeeAlso: #P0710

Bitfields for MCGA (only) CRT character generator/sync polarity register:
Bit(s)	Description	(Table P0714)
 7	character generator active
 6	=1 load codepage during display
	=0 load codepage during retrace
 5	codepage number (0,1)
 4	512 characters active
 3	reserved (0)
 2	enable hsync/vsync
 1	positive vsync polarity
 0	positive hsync polarity
Note:	default 46h in all modes, except 04h in mode 11h)
SeeAlso: #P0710
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - Chips&Technologies VIDEO CHIPS - EXTENDED CRT CONTROL REGISTERS
SeeAlso: PORT 03D4h"COLOR VIDEO",PORT 03D4h"Tseng"

03D4  RW  CRT control register index (see #P0715)
03D5  RW  CRT control register value

(Table P0715)
Values for Chips&Technologies CRT Controller register index:
 00h-18h same as EGA/VGA (see #P0708)
 22h	same as VGA (see #P0708)
 24h	same as VGA (see #P0708)
---C&T 82C4xx---
 D3h RW "RD3" 82C426: gray-level control 1 !!!chips\82c426.pdf p.16
 D4h RW "RD4" 82C426: gray-level control 2
 D5h RW "RD5" 82C426: general purpose
 D6h RW "RD6" 82C426: sleep
 D7h RW "RD7" 82C426: panel size
 D8h RW "RD8" 82C426: panel configuration
 D9h RW "RD9" AC control   !!!chips\82c425.pdf p.27
 DAh RW "RDA" threshold
 DBh RW "RDB" shift parameter
 DCh RW "RDC" horizontal sync width
 DDh RW "RDD" vertical sync width / blink control
 DEh RW "RDE" timing control
 DFh RW "RDF" function control
SeeAlso: #P0654,#P0710,#P0756,#P0716
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - Cirrus Logic VIDEO CHIPS - EXTENDED CRT CONTROL REGISTERS
SeeAlso: PORT 03D4h"COLOR VIDEO",PORT 03D4h"Tseng"

03D4  RW  CRT control register index (see #P0716)
03D5  RW  CRT control register value

(Table P0716)
Values for Cirrus Logic CRT Controller register index:
 00h-18h same as EGA/VGA (see #P0708)
---Cirrus CL-GD7556---
 19h	"CR19" Interlace End
 1Ah	"CR1A" miscellaneous control
 1Bh	"CR1B" extended display control
 1Ch	"CR1C" horizontal total and sync
 1Dh	"CR1D" color key compare type
 22h	same as VGA (see #P0708)
 24h	same as VGA (see #P0708)
 25h	"CR25" revision
 26h	"CR26" attribute controller index readback
 27h	"CR27" device identification
 30h	"CR30" TV-OUT control
 31h	"CR31" Video Window horizontal upscaling coefficient
 32h	"CR32" Video Window vertical upscaling coefficient
 33h	"CR33" Video Window horizontal start (high)
 34h	"CR34" Video Window horizontal start (low)
 35h	"CR35" Video Window brightness
 36h	"CR36" Video Window vertical position extension
 37h	"CR37" Video Window vertical start
 38h	"CR38" Video Window vertical height
 ...
 42h	"CR42" Video Window FIFO threshold / chroma-key mode
 50h	"CR50" V-Port hardware configuration
 ...
 5Fh	"CR5F" V-Port capture window start address (low)
 80h	"CR80" power management control
 ...
 91h	"CR91" shading map offset
 A0h	"CRA0" CRT horizontal 8-dot character clock
 ...
 BFh	"CRBF" CRT vertical back porch
!!! details to be added
SeeAlso: #P0654,#P0756,#P0717
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - S3 VIDEO CHIPS - EXTENDED CRT CONTROL REGISTERS
SeeAlso: PORT 03D4h"COLOR VIDEO",PORT 03D4h"Tseng"

03D4  RW  CRT control register index (see #P0717)
03D5  RW  CRT control register value

(Table P0717)
Values for S3, Inc. CRT Controller register index:
 00h-18h same as EGA/VGA (see #P0708)
 22h	same as VGA (see #P0708)
 24h	"CR24" attribute controller index/data status
 26h R- "CR24" (duplicate of 24h)
 2Dh R- "CR2D" new Chip ID (high) (same as high byte of PCI device ID)
 2Eh R- "CR2E" new chip ID (low) (same as low byte of PCI device ID)
		10h Trio32
		11h Trio64
 2Fh R- "CR2F" S3 7xx/866/x68: chipset revision
		chip ID 8811h is Trio64/64V+; revision 4xh or 5xh is Trio64V+
 30h RW	"CR30" chip ID/revision (see #P0719)
 31h RW	"CR31" memory configuration (see #P0720)
 32h RW "CR32" backward compatibility 1 (see #P0721)
 33h RW "CR33" backward compatibility 2 (see #P0722)
 34h RW "CR34" backward compatibility 3 (see #P0723)
 35h RW "CR35" CRT register lock (see #P0724)
 36h R	"CR36" Reset State read 1 (see #P0725)
 37h R	"CR37" Reset State read 2 (see #P0726)
 38h RW	"CR38" S3 Register lock 1
	set reg 38h to 48h and reg 39h to A5h to unlock other S3 registers
 39h RW	"CR39" S3 Register lock 2
 3Ah RW "CR3A" S3 Miscellaneous 1 (see #P0727)
	bit 4: ???
 3Bh RW "CR3B" Data Transfer Execute position (see #P0728)
 3Ch RW "CR3C" Interlace Retrace start position (see also #P0730)
 40h RW "CR40" System Configuration (see #P0729)
 41h	"CR41" BIOS Flag register (used by S3 BIOS)
 42h RW "CR42" mode control (see #P0730)
 43h RW "CR43" extended mode (see #P0731)
 45h RW "CR45" hardware graphics cursor mode (see #P0732)
 46h RW "CR46" hardware cursor origin X (hi), bits 2-0 only
 47h RW "CR47" hardware cursor origin X (lo)
	testing that register 47h can be read and written once the S3 registers
	  are unlocked is used as an S3 installation check
 48h RW	"CR48" hardware cursor origin Y (hi), bits 2-0 only
	the cursor X/Y position is latched on writing the high byte of Y
 49h RW "CR49" hardware cursor origin Y (lo)
 4Ah RW "CR4A" hardware graphics cursor foreground stack
	read register 45h, then write 2 or 3 color bytes (16/24-bit color)
	  to specify foreground color of hardware cursor
 4Bh RW "CR4B" hardware graphics cursor background stack
	read register 45h, then write 2 or 3 color bytes (16/24-bit color)
	  to specify background color of hardware cursor
 4Ch RW "CR4C" hardware graphics cursor map start address (hi), bits 3-0 only
 4Dh RW "CR4D" hardware graphics cursor map start address (lo)
 4Eh RW "CR4E" hardware cursor pattern start X (bits 5-0 only)
 4Fh RW "CR4F" hardware cursor pattern start Y (bits 5-0 only)
 50h RW "CR50" S3 801+: Extended System Control 1 (see #P0733)
 51h RW "CR51" S3 801+: Extended System Control 2 (see #P0734)
 52h RW "CR52" S3 801+: Extended BIOS Flag 1
		bits 7-6 are sync polarities (see #P0669) for Diamond cards
 53h RW "CR53" S3 801+: Extended Memory Control 1 (see #P0735)
 54h RW "CR54" S3 801+: Extended Memory Control 2 (see #P0736,#P0737)
 55h RW "CR55" S3 801+: Extended Video DAC Control (see #P0738)
 56h RW "CR56" S3 801+: External Sync Control 1 (see #P0739)
 57h RW "CR57" S3 801+: External Sync Control 2 (see #P0740)
 58h RW "CR58" S3 801+: Linear Address Window Control (see #P0741)
 59h RW "CR59" S3 801+: Linear Address Window Position (bits 31-24)
 5Ah RW "CR5A" S3 801+: Linear Address Window Position (bits 23-16)
	Notes:	the address is forced to be a multiple of the memory window
		  size (see #P0741) by ignoring the lowest bits
		for Trio64 new memory-mapped I/O, the LAW must be on a 64M
		  boundary
 5Bh RW "CR5B" S3 801+: Extended BIOS Flag 2
 5Ch RW "CR5C" S3 801+: General Output Port (see #P0742)
 5Dh RW "CR5D" S3 801+: Extended Horizontal Overflow (see #P0743)
 5Eh RW "CR5E" S3 801+: Extended Vertical Overflow (see #P0744)
 5Fh RW "CR5F" S3 928/964: Bus Grant Termination Position
 60h RW "CR60" S3 864/964: extended memory control 3 (see #P0745)
 61h RW "CR61" S3 864/964/Trio: extended memory control 4 (see #P0746)
 62h RW "CR62" S3 864/964: extended memory control 5
 63h RW "CR63" S3 864/964: external sync delay adjustment (high) (see #P0747)
 64h RW "CR64" S3 864/964: genlocking adjustment
 65h RW "CR65" S3 864/964: extended miscellaneous control (see #P0748)
 66h RW "CR66" S3 864/964: extended miscellaneous control 1 (see #P0749)
 67h RW "CR67" S3 864/964: extended miscellaneous control 2 (see #P0750)
 67h RW "CR67" S3 Trio32/64: extended miscellaneous control 2 (see #P0751)
 68h RW "CR68" S3 864/964: configuration 3 (see #P0752)
 69h RW "CR69" S3 864/964: extended system control 3 (see #P0753)
 6Ah RW "CR6A" S3 864/964: extended system control 4
		(bits 5-0 = offset of 64K bank)
 6Bh RW "CR6B" S3 864/964: extended BIOS flag 3
 6Ch RW "CR6C" S3 864/964: extended BIOS flag 4
 6Dh RW "CR6D" S3 864/964: extended miscellaneous control
 6Dh RW "CR6D" S3 Trio64V+: extended BIOS flag 5 (reserved for BIOS)
 6Eh RW "CR6E" S3 Trio64V+: extended BIOS flag 6 (reserved for BIOS)
 6Fh RW "CR6F" S3 Trio64V+: configuration 4 (see #P0755)
SeeAlso: #P0654,#P0710,#P0756,#P0716,#P0715

Bitfields for S3 "CR24" Attribute Index register:
Bit(s)	Description	(Table P0718)
 7	inverse of current state of internal address flip-flop
 6	reserved (0)
 5	video display is enabled (mirror of PORT 03C0h bit 5)
 4-0	current attribute contorller index (from PORT 03C0h)
SeeAlso: #P0708,#P0709,PORT 03C0h

(Table P0719)
Values for S3 chip ID/Revision register "CR30":
 81h	86c911
 82h	86c911A/924
 90h	86c928 (original)
 ...
 A0h	86c801/805 A-step or B-step
 ...
 B0h	86c928 PCI
 C0h	Vision864
 C1h	Vision864P
 D0h	Vision964
 D1h	Vision964P
 Exh	Trio32/64, 86c866, 86c868, 86c968; actual ID and revision stored in
	  PORT 03B5h registers 2Dh, 2Eh, and 2Fh
SeeAlso: #P0720

Bitfields for S3 "CR31" memory configuration register:
Bit(s)	Description	(Table P0720)
 7	(except 864/964) enable BIOS ROM address space C6800h-C7FFFh
	(Trio64V+) reserved
 6	enable page-mode memory access for text-mode font access
 5-4	display start address, bits 17&16.  See also registers 51h and 69h
 3	video memory above 256K accessible
 2	VGA 16-bit memory bus (clear for 8-bit memory bus)
 1	two-page screen image (enables 2048-pixel wide screen)
 0	enable base-address offset (turn on bank-switched operation)
SeeAlso: #P0708,#P0719,#P0721

Bitfields for S3 "CR32" Backwards Compatibility 1 register:
Bit(s)	Description	(Table P0721)
 7	(928,964) tri-state serial output pins SC, SOE0, and SXNR
 6	fix VGA screen page using display start address bits 16&17 (see #P0720)
	(Trio64V+) force wrap on 256K boundary even when display start address
	  changed
 5	???
 4	enable hardware interrupts
 3	backward-compatible modes (set for MDA/CGA/EGA/HGC)
 2	force full character clock for horizontal timing (CGA/HGC emulation),
	  rather than 1/2 dot clock rate
 1-0	character clock period
	00 IBM-compatible, 8 or 9 dots
	01 7 dots
	10 9 dits
Note:	on the Trio64V+, bits 7, 5, and 3-0 are reserved
SeeAlso: #P0720,#P0722,#M0076

Bitfields for S3 "CR33" Backwards Compatibility 2 register:
Bit(s)	Description	(Table P0722)
 7	override CGA "enable video" at PORT 03D8h bit 3
 6	lock palette/overscan registers
 5	blank signal does not include border area, is same as display enable
 4	disable writes to RamDAC
 3	VCLK is internal DCLK rather than inverted DCLK/2 or external VCLK
 2	reserved (Trio32/64)
 1	disable VDE protection (PORT 03D4h register 11h bit 7 will not act
	  on PORT 03D4h register 7h bits 1 and 6)
 0	reserved (Trio32/64)
Note:	on the Trio64V+, bits 7, 2, and 0 are reserved
SeeAlso: #P0708,#P0721,#P0723

Bitfields for S3 "CR34" Backwards Compatibility 3 register:
Bit(s)	Description	(Table P0723)
 7-5	(Trio32/64/64V+) reserved
 7	lock PORT 03C2h bits 2,3
 5	lock SR1 bit 5
 4	enable Start Display FIFO Fetch register (CR3B) (see #398)
 3	(Trio32/64/64V+) reserved
 2	PCI retries not handled during DAC cycles (requires bit 0 clear)
 1	do not handle PCI master aborts during DAC cycles (requires bit 0 clear)
 0	disable PCI master aborts/retries during DAC cycles
SeeAlso: #P0722,#P0724

Bitfields for S3 "CR35" Register Lock register:
Bit(s)	Description	(Table P0724)
 7-6	(Trio32/Trio64) reserved
 5	lock horizontal timing registers
 4	lock vertical timing registers
 3-0	CPU base address (in 64K units), bits 17-14
SeeAlso: #P0708,#P0723,#P0725

Bitfields for S3 "CR36" Configuration 1 register:
Bit(s)	Description	(Table P0725)
 7-5	video memory size
	111 less than 1M
	110 one meg
	100 two megs
	010 three megs
	000 four megs
	101 six megs
	011 eight megs
 4	(Trio32/64, VL-Bus only) enable video BIOS accesses
 3-2	(Trio32/64) memory type
	00 reserved
	01 reserved
	10 EDO
	11 fast page mode
 1-0	(Trio32/64) system bus type
	00 reserved
	01 VESA local bus
	10 PCI
	11 reserved
Note:	the default value of this register is latched from external pins at
	  power-up; bits 1-0 are read-only
SeeAlso: #P0708,#P0724,#P0726

Bitfields for S3 "CR37" Configuration 2 register:
Bit(s)	Description	(Table P0726)
 7-5	monitor type
 7-5	(Trio64V+) reserved
 4	(VL-Bus) enable RAMDAC write snooping
 3	use internal DCLK/MCLK (clear this bit for testing only)
 2	(VL-Bus) video BIOS ROM size (=0 64K, =1 32K)
 1	test mode select (=0 tri-state all outputs, =1 normal operation)
 1	(Trio64V+) reserved
 0	(VL-Bus) enable Trio chip (if 0, disabled except for video BIOS access)
Notes:	the default value of this register is latched from external pins at
	  power-up
	the description of this register is based on the Trio32/Trio64/Trio64V+
	  documentation and may vary somewhat for other S3 chips
SeeAlso: #P0708,#P0725

Bitfields for S3 "CR3A" Miscellaneous 1 register:
Bit(s)	Description	(Table P0727)
 7	disable PCI burst read cycles
	(must set CR66 bit 7 before setting this bit)
 6	reserved
 5	enable high-speed text font writes (only required for DCLK > 40MHz)
 4	enable >= 8 bpp color enhanced modes
 3	enable top-of-memory access (simultaneous VGA text and enhanced mode)
 2	enable alternate refresh count control (bits 1-0)
	when enabled, bits 1-0 override CR11 bit 6
 1-0	alternate refresh count: number of refresh cycles per scan line
Note:	the description of this register is based on the Trio32/Trio64/Trio64V+
	  documentation and may vary somewhat for other S3 chips
SeeAlso: #P0708

Bitfields for S3 "CR3B" Start Display FIFO Register:
Bit(s)	Description	(Table P0728)
 7-0	bits 7-0 of time in characters clocks from start of active display
	  until FIFO data fetching restarts after start of horizontal blanking
	  (bit 8 is in CR5D bit 6)
Note:	the value for this register is typically CR0 less 5, and helps ensure
	  adequate time for RAM refresh, etc. taht require control of display
	  memory
SeeAlso: #P0708

Bitfields for S3 "CR40" System Configuration register:
Bit(s)	Description	(Table P0729)
 7-6	reserved (0)
 5	reserved ("WDL_DELAY") (1)
 4	(VL-Bus) Ready Control
	=0 zero wait-states from -SADS to -SRDY
	=1 minimum one wait state (controlled by CR58 bit 3)
 3-1	reserved (0)
 0	enable enhanced (8514/A superset) register access at PORT x2E8h
SeeAlso: #P0708

Bitfields for S3 "CR42" Mode Control register:
Bit(s)	Description	(Table P0730)
 7-6	reserved (0)
 5	interlaced video
 4-0	reserved
Note:	bit 5 also enables CR3C
SeeAlso: #P0708,#P0731

Bitfields for S3 "CR43" Extended Mode register:
Bit(s)	Description	(Table P0731)
 7	double horizontal CRT parameters (CRTC registers 00h, etc.)
 6-3	reserved (0)
 3	(Trio64V+) ??? used by BIOS, officially reserved
 2	logical screen width (CR13), bit 8
 1-0	reserved (0)
Note:	bit 2 is disabled unless CR51 bits 5-4=00
SeeAlso: #P0708,#P0730

Bitfields for S3 "CR45" Hardware Graphics Cursor Mode register:
Bit(s)	Description	(Table P0732)
 7-5	reserved (0)
 4	enable Hardware Cursor Right Storage (last 256 bytes of 1K line, or
	  last 512 bytes of 2K line)
 3-1	reserved (0)
 0	enable hardware graphics cursor in Enhanced (8514/A) mode
SeeAlso: #P0708

Bitfields for S3 "CR50" Extended System Control 1 register:
Bit(s)	Description	(Table P0733)
 7-6	Graphics Engine screen width
	(note: bit 0 below is MSB for the following)
	000 = 1024 (2048 if CR31 bit 1 set)
	001 = 640
	010 = 800 (1600x1200x4 if PORT 4AE8h bit 2 set)
	011 = 1280
	100 = 1152
	101 reserved
	110 = 1600
	111 reserved
 5-4	pixel length for command execution through Graphics Engine (8514/A)
	00 one byte (4 or 8 bits/pixel)
	01 two bytes (16 bpp)
	10 reserved
	11 four bytes (32 bpp)
 3	reserved (0)
 2	enable -BREQ/-BGNT functions (reserved on Trio64V+)
 1	reserved (0)
 0	bit 2 of Graphics Engine screen width (refer to bits 7-6 above)
SeeAlso: #P0708,#P0735,#P0734

Bitfields for S3 "CR51" Extended System Control 2 register:
Bit(s)	Description	(Table P0734)
 7-6	reserved (0)
 5-4	logical screen width, bits 9-8
 3-2	CPU base address, bits 19-18
 1-0	display start address, bits 19-18
Notes:	if the upper four bits of the display start address have been set via
	  CR69 bits 3-0, then bits 1-0 and CR31 bits 5-4 are ignored
	if the upper 6 base address bits have been set via CR6A bits 5-0, then
	  bits 3-2 and CR35 bits 3-0 are ignored
SeeAlso: #P0708,#P0733

Bitfields for S3 "CR53" Extended Memory Control 1 register:
Bit(s)	Description	(Table P0735)
 7	reserved
 6	(Trio32/64/64V+) swap nybbles in each byte of video memory read or
	  written
 5	(801/805) memory interleaving
	(928) pixel multiplexing
	(Trio64V+) enable memory-mapped I/O at B8000h-BFFFFh instead of
	  A0000h-AFFFFh (only takes effect if bits 4-3=10)
 4	enable memory-mapped I/O (Trio32, Trio64 and Trio64V+)
 3	enable new memory-mapped I/O (Trio64V+)
 2-1	(Trio64V+) byte swapping for linear addressing
	00 none (default)
	01 swap bytes of word
	10 swap all bytes of doublewords
	11 reserved
	(used for big-endian addressing)
 0	(Trio32/64) enable write per bit
	(Trio64V+) reserved
SeeAlso: #P0708,#P0736

Bitfields for S3 Trio32/64 "CR54" Extended Memory Control 2 register:
Bit(s)	Description	(Table P0736)
 7-3	"M" number of 8-byte memory cycles not dedicated to filling display
	  FIFO (less one)
 2-0	reserved (0)
SeeAlso: #P0737,#P0708,#P0735

Bitfields for S3 Trio64V+ "CR54" Extended Memory Control 2 register:
Bit(s)	Description	(Table P0737)
 2,7-3	"M" maximum number of 8-byte memory cycles before LPB/CPU/Graphics
	  Engine must yield the memory bus
 1-0	big-endian byte-swapping (except for linear addressing/image writes)
	00 none (default)
	01 swap bytes within a word
	10 swap all bytes within a doubleword
	11 swap according to bus' byte-enable lines
		BE#[3:0]=0000 swap all bytes
		BE#[3:0]=0011 or 1100 swap bytes within selected word
		else no swapping
SeeAlso: #P0708,#P0736 

Bitfields for S3 "CR55" Extended RAMDAC Control register:
Bit(s)	Description	(Table P0738)
 7	tri-state VCLK output
 6-5	reserved (0)
 4	hardware cursor mode
	=0 MS-Windows
	=1 X11
 3	reserved (0)
 2	enable General Input Port read (at PORT 03C8h)
 1-0	reserved (0)
SeeAlso: #P0708

Bitfields for S3 "CR56" External Sync Control 1 register:
Bit(s)	Description	(Table P0739)
 7-5	reserved (0)
 4	preset frame select
	=0 start with odd frame after V-counter reset
	=1 start with even frame
 3	reset only vertical counter on falling edge of VSYNC input when
	  genlocking
 2	tri-state VSYNC output
 1	tri-state HSYNC output
 0	enable VSYNC input for genlocking
Note:	bits 4-3 are reserved on the Trio64V+
SeeAlso: #P0708,#P0740

Bitfields for S3 "CR57" External Sync Control 2 register:
Bit(s)	Description	(Table P0740)
 7-0	delay in scan lines from falling edge of VSYNC to reset of V-counter
Note:	this register must NOT be 00h when genlocking is enabled (CR56 bit 0)
SeeAlso: #P0708,#P0739

Bitfields for S3 "CR58" Linear Addressing Control register:
Bit(s)	Description	(Table P0741)
 7	RAS Pre-Charge time adjust
	=0 CR68 bit 3 defines pre-charge time
	=1 decrease pre-charge time by 0.5 MCLKs, increase RAS time by 0.5 MCLKs
 6-5	reserved
 4	enable linear addressing (see also #P1022)
 3	(VL-Bus) addresses latched in T1 cycle, instead of delaying one clock
	  until T2 cycle; only in effect when CR40 bit 4 is set
 2	reserved
 1-0	linear address window size
	00 = 64K (not available when new MMIO enabled)
	01 = 1M
	10 = 2M
	11 = 4M (Trio64/64V+, not Trio32)
Note:	this description is based on the Trio32/Trio64 documenation; the
	  bits may vary slightly for other S3 chips
SeeAlso: #P0723

Bitfields for S3 "CR5C" General Output Port:
Bit(s)	Description	(Table P0742)
 7-0	system-specific
---Diamond---
 0	???
 1	???
---STB Pegasus---
 7	map video memory with bits 31-26 = 011111
SeeAlso: #P0708

Bitfields for S3 "CR5D" Extended Horizontal Overflow register:
Bit(s)	Description	(Table P0743)
 7	bit 8 of Bus-Grant Terminate Position (CR5F)
	(Trio64V+) reserved
 6	bit 8 of Start FIFO Fetch (CR3B)
 5	extend horizontal sync pulse by 32 DCLKs
 4	bit 8 of Start Horizontal Sync Position (CR4)
 3	extend horizontal blank pulse by 64 DCLKs
 2	bit 8 of Start Horizontal Blank (CR2)
 1	bit 8 of Horizontal Display End (CR1)
 0	bit 8 of Horizontal Total (CR0)
SeeAlso: #P0708,#P0744

Bitfields for S3 "CR5E" Extended Vertical Overflow register:
Bit(s)	Description	(Table P0744)
 7	reserved (0)
 6	line compare position (CR18), bit 10
 5	reserved (0)
 4	vertical retrace start (CR10), bit 10
 3	reserved (0)
 2	start of vertical blank (CR15), bit 10
 1	vertical display end (CR12), bit 10
 0	vertical total (CR6), bit 10
SeeAlso: #P0708,#P0743

Bitfields for S3 Trio32/64 "CR60" Extended Memory Control 3 register:
Bit(s)	Description	(Table P0745)
 7-0	"N" maximum number of 4-byte (1M video memory) or 8-byte (2M/4M) units
	  written to display FIFO in an uninterruptible burst
SeeAlso: #P0708,#P0746

Bitfields for S3 Trio64V+ "CR61" Extended Memory Control 4 register:
Bit(s)	Description	(Table P0746)
 7	reserved
 6-5	byte-swapping for image writes
	00 none (default)
	01 swap bytes within each word
	10 swap all bytes within a doubleword
	11 reserved
 4-0	reserved
SeeAlso: #P0708,#P0745

Bitfields for S3 Trio32/64 "CR63" External Sync Control 3 register:
Bit(s)	Description	(Table P0747)
 7-4	character clock reset delay
 3-0	HSYNC reset adjustment, in character clocks
Notes:	these two values are used to align the external and internally-generated
	  video during genlocking
	this register is not documented for the Trio64V+, and may not exist
SeeAlso: #P0708

Bitfields for S3 Trio32/64/64V+ "CR65" Extended Miscellaneous Control register:
Bit(s)	Description	(Table P0748)
 7-5	reserved (0)
 4-3	(Trio32/64V+) delay -BLANK by N DCLKs
	a two-DCLK delay is required for color mode 12
 2	video subsystem setup address
	(Trio64V+) reserved
	=0 PORT 46E8h
	=1 PORT 03C3h
 1-0	reserved (0)
SeeAlso: #P0708,#P0749

Bitfields for S3 Trio32/64/64V+ "CR66" Extended Miscellaneous Control 1 reg:
Bit(s)	Description	(Table P0749)
 7	enable PCI bus disconnect on misaligned burst memory accesses
 6	tri-state pixel address bus
---Trio32/64---
 5-0	reserved (0)
---Trio64V+ ---
 5	??? (officially reservd, but set by BIOS)
 4	reserved
 3	generate PCI bus disconnect when trying to write to a full FIFO or read
	  from an empty FIFO
	(bit 7 must also be set to enable this feature)
 2	reserved
 1	software reset graphics engine
 0	enable enhanced functions (this is a mirror of
	  PORT 4AE8h bit 0)
SeeAlso: #P0708,#P0748,PORT 4AE8h

Bitfields for S3 864/964 "CR67" Extended Miscellaneous Control 2 register:
Bit(s)	Description	(Table P0750)
 7-4	color mode???
	(values of 0000/0010/0101/0111 indicate a 16-bit pixel port)
 3-2	???
SeeAlso: #P0708,#P0723,#P0751

Bitfields for S3 Trio32/64/64V+ "CR67" Extended Miscellaneous Control 2 reg:
Bit(s)	Description	(Table P0751)
 7-4	color mode (see #P0688)
 3-2	(Trio32/Trio64) reserved (0)
 3-2	(Trio64V+) streams mode
	00 disable Streams Processor
	01 overlay secondary stream on VGA-mode background
	10 reserved
	11 full Streams Processor operation
 1	reserved (0)
 0	VCLK phase (=0 VCLK is inverted DCLK; =1 VCLK in phase with DCLK)
Note:	the streams mode should only be changed during vertical sync
	  (PORT 03DAh bit 3)
SeeAlso: #P0708,#P0750,#P0687

Bitfields for S3 Trio32/64/64V+ "CR68" Configuration 3 register:
Bit(s)	Description	(Table P0752)
 7	(Trio32/64 VL-Bus) Upper Address Decode
	=0 decode all 32 bits of system address bus
	=1 SAUP input used to decode upper address lines
 7	(Trio64V+) memory data bus size
	=0 32 bits
	=1 64 bits (if >= 2M of memory)
 6-4	monitor information (used by S3 bios)
 3	RAS precharge timing (0 = 3.5 MCLKs, 1 = 2.5 MCLKs)
 2	RAS low timing (0 = 4.5 MCLKs, 1 = 3.5 MCLKs)
 1-0	-CAS and -OE stretch, -WE delay
	00 = 6.5ns stretch, 2 units delay
	01 = 5ns stretch, 1 unit delay
	10 = 3.5ns stretch, no delay
	11 = no stretch, no delay
Note:	the default value of this register is latched from external pins at
	  power-up
SeeAlso: #P0708

Bitfields for S3 Trio32/Trio64 "CR69" Extended System Control 3 register:
Bit(s)	Description	(Table P0753)
 7-4	reserved (0)
 3-0	display start address, bits 19-16
SeeAlso: #P0708,#P0754

Bitfields for S3 Trio32/Trio64 "CR6A" Extended System Control 4 register:
Bit(s)	Description	(Table P0754)
 7-6	reserved
 5-0	bits 19-14 of CPU base address
Note:	CR31 bit 0 must be set to enable this register
SeeAlso: #P0708,#P0753

Bitfields for S3 Trio64V+ "CR6F" Configuration 4 register:
Bit(s)	Description	(Table P0755)
 7-5	reserved
 4-3	WE# delay (on both rising and falling edges)
	00 three units
	01 two units
	10 one unit
	11 no delay
 2	disable I/O PORT mirror of serial port (MMIO FF20h)
	=0 allow access via either MMIO FF20h or port selected by bit 1
 1	serial port address select (only has effect if bit 2 clear)
	=0 mirror MMIO FF20h at PORT 00E8h
	=1 mirror MMIO FF20h at PORT 00E2h
 0	configure for Trio64-compatible mode instead of LPB mode
 !!! p.19-16
SeeAlso: #P0708,MEM A000h:FF00h"S3"
--------V-P03D403D5--------------------------
PORT 03D4-03D5 - Tseng Labs VIDEO CHIPS - EXTENDED CRT CONTROL REGISTERS
SeeAlso: PORT 03D4h"COLOR VIDEO",PORT 03D4h"S3",PORT 03D4h"Cirrus"

03D4  RW  CRT control register index (see #P0756)
03D5  RW  CRT control register value

(Table P0756)
Values for Tseng Labs ET3000/ET4000 CRT Controller register index:
 00h-18h same as EGA/VGA (see #P0708)
---ET3000 only---
 1Bh	x-zoom start register
	The existence of this register is often used to decide between ET3000
	  and ET4000, as the ET4000 does not offer hardware-zoom features.
 1Ch	x-zoom end register
 1Dh	y-zoom start register low
 1Eh	y-zoom end register low
 1Fh	y-zoom start & end high register
 20h	zoom start address register low
 21h	zoom start address register medium
 23h	extended start address (see register 33h)
 24h	compatibility register (see register 34h)
 25h	overflow high register (see registers 35h, 07h)
---ET4000---
 32h	RAS/CAS configuration ('key' protected) (see #P0757)
 33h	extended start address
	      This register is often used to decide between ET4000
	      and ET3000, when bit3-0 can be reread after write.
	       bit7-4 : reserved
	       bit3-2 : cursor address bit 17-16
	       bit1-0 : linear start address bits 17-16
 34h	6845 compatibility control register ('key' protected)
	  (see #P0758)
 35h	overflow high register (protected by 11h, bit7) (see #P0759)
 36h	video system configuration 1 ('key' protected) (see #P0760)
 37h	video system configuration 2 ('key' protected) (see #P0761)
SeeAlso: #P0654,#P0716,#P0717

Bitfields for ET4000 RAS/CAS configuration register:
Bit(s)	Description	(Table P0757)
 7	static column memory
	ET4000/W32i: interleave mode
 6	RAL RAS&CAS column setup time
 5	RCD RAS & CAS time
 4-3	RSP, RAS pre-charge time
 2	CPS, CAS pre-charge time
 1-0	CSW, CAS low pulse width
SeeAlso: #P0708,#P0758

Bitfields for ET4000 compatibility control register:
Bit(s)	Description	(Table P0758)
 7	6845 compatibility enabled
 6	ENBA enable double scan/underline in AT&T mode
 5	ENXL enable translation ROM on writing
 4	ENXR enable translation ROM on reading
 3	ENVS VSE register port address
 2	TRIS tristate ET4000 output pins
 1	CS2 MCLCK clock select 2
 0	EMCK enable translation of CS0 bit
SeeAlso: #P0708,#P0757,#P0759

Bitfields for ET4000 overflow high register:
Bit(s)	Description	(Table P0759)
 7	vertical interlace mode
 6	alternate RMW control
 5	external sync reset (gen-lock) the line/chr counter
 4	line compare bit10
 3	vertical sync start bit10
 2	vertical display end bit10
 1	vertical total bit10
 0	vertical blank start bit10
SeeAlso: #P0708,#P0758,#P0760

Bitfields for ET4000 video system configuration 1 register:
Bit(s)	Description	(Table P0760)
 7	enable 16bit I/O read/write
 6	enable 16bit display memory read/write
 5	addressing mode (0=IBM, 1=TLI)
 4	0=segment / 1=linear system configuration
 3	font width control (1=up to 16bit, 0=8bit)
 2-0	refresh count per line-1
SeeAlso: #P0708,#P0759,#P0761

Bitfields for ET4000 video system configuration 2 register:
Bit(s)	Description	(Table P0761)
 7	DRAM display memory type (1=VRAM, 0=DRAM)
 6	test (1=TLI interal test mode)
 5	priority threshold control (0=more mem BW)
 4	disable block read-ahead
 3	display memory data depth
 2	bus read data latch control
 1-0	display memory data bus width
SeeAlso: #P0708,#P0760
----------P03D603D7--------------------------
PORT 03D6-03D7 - CGA (Color Graphics Adapter) - MIRRORS OF 03D4/03D5

03D6  -W  same as 03D4
	(under OS/2, reads return 0 if full-screen DOS session,
	  nonzero if windowed DOS session)
03D7  RW  same as 03D5
----------P03D603D7--------------------------
PORT 03D6-03D7 - Chips&Technologies VGA - EXTENSION REGISTERS

03D6  -W  extension register index (see #P0762,#P0763)
03D7  RW  extension register data

(Table P0762)
Values for Chips&Technologies 64200 extension register index:
 00h	"XR00"	chip version (see #P0764)
 01h	"XR01"	configuration (see #P0765)
 02h	"XR02"	CPU interface control (see #P0767)
 03h	"XR03"	master control (see #P0768)
 04h	"XR04"	memory control (see #P0770)
 05h	"XR05"	clock control (see #P0771)
 06h	"XR06"	color palette control / DRAM interface
 07h	"XR07"	reserved
 08h	"XR08"	general purpose output select B
 09h	"XR09"	general purpose output select A
 0Ah	"XR0A"	cursor address top
 0Bh	"XR0B"	CPU paging (see #P0777)
 0Ch	"XR0C"	start address top (see #P0778)
 0Dh	"XR0D"	auxiliary offset (see #P0780)
 0Eh	"XR0E"	text mode control (see #P0781)
 0Fh	"XR0F"	configuration register 2
 10h	"XR10"	single/low map register (see #P0782)
 11h	"XR11"	high map register (see #P0783)
 14h	"XR14"	emulation mode (see #P0784)
 15h	"XR15"	write protect (see #P0785)
 16h	"XR16"	trap enable
 17h	"XR17"	trap status
 18h	"XR18"	alternate horizontal display end
 19h	"XR19"	alternate horizontal sync start / half-line
 1Ah	"XR1A"	alternate horizontal sync end (see #P0789)
 1Bh	"XR1B"	alternate horizontal total
 1Ch	"XR1C"	alternate horizontal blank start / horizontal panel size
 1Dh	"XR1D"	alternate horizontal blank end (see #P0790)
 1Eh	"XR1E"	alternate offset
 1Fh	"XR1F"	virtual EGA switch (see #P0791)
 20h	"XR20"	453 Interface ID
 21h	"XR21"	Sliding Hold A
 22h	"XR22"	Sliding Hold B
 23h	"XR23"	SHC / WBM Control
 24h	"XR24"	Flat-Panel Alternate Max Scanline / SHD / WBM Pattern
 25h	"XR25"	Flat-Panel "AltGrHVirtPanelSize" / 453 Pin Definition
 26h	"XR26"	453 Configuration
 27h	"XR27"	reserved
 28h	"XR28"	video interface (see #P0792)
 29h	"XR29"	function control
 2Ah	"XR2A"	frame interrupt count
 2Bh	"XR2B"	default video color (to be displayed when screen blanked)
 2Ch	"XR2C"	Flat-Panel VSync (FLM) Delay / force H high
 2Dh	"XR2D"	Flat-Panel HSync (LP) delay / force H low
 2Eh	"XR2E"	Flat-Panel HSync (LP) delay / force V high
 2Fh	"XR2F"	Flat-Panel HSync (LP) width / force V low
 30h	"XR30"	graphics cursor start address (high)
 31h	"XR31"	graphics cursor start address (low)
 32h	"XR32"	graphics cursor end address
 33h	"XR33"	graphics cursor X (high)
 34h	"XR34"	graphics cursor X (low)
 35h	"XR35"	graphics cursor Y (high)
 36h	"XR36"	graphics cursor Y (low)
 37h	"XR37"	graphics cursor mode
 38h	"XR38"	graphics cursor mask
 39h	"XR39"	graphics cursor color 0
 3Ah	"XR3A"	graphics cursor color 1
 3Bh	"XR3B"	reserved
 3Ch	"XR3C"	serial / row count (see #P0799)
 3Dh	"XR3D"	multiplexor mode (see #P0801)
 41h	"XR41"	virtual EGA switch register (82C453)
 44h	"XR44"	software flag register 1
 45h	"XR45"	software flag register 2 / foreground color
 50h	"XR50"	panel format
 51h	"XR51"	display type
 52h	"XR52"	power-down control / panel size
 53h	"XR53"	line graphics override
 54h	"XR54"	flat-panel interface / alternate miscellaneous output
 55h	"XR55"	horizontal compensation / text 350_A compensation
 56h	"XR56"	horizontal centering / text 350_B compensation
 57h	"XR57"	vertical compensation / text 400 compensation
 58h	"XR58"	vertical centering / graphics 350 compensation
 59h	"XR59"	vertical line insertion / graphics 400 compensation
 5Ah	"XR5A"	vertical line replication / FP vertical display start 400
 5Bh	"XR5B"	flat-panel vertical display end 400 
 5Ch	"XR5C"	weight control clock A
 5Dh	"XR5D"	weight control clock B
 5Eh	"XR5E"	ACDCLK control
 5Fh	"XR5F"	power-down mode refresh
 60h	"XR60"	blink rate control
 61h	"XR61"	SmartMap(tm) control
 62h	"XR62"	SmartMap(tm) shift parameter
 63h	"XR63"	SmartMap(tm) color mapping control
 64h	"XR64"	flat-panel alternate vertical total
 65h	"XR65"	flat-panel alternate overflow
 66h	"XR66"	flat-panel alternate vertical sync start
 67h	"XR67"	flat-panel alternate vertical sync end
 68h	"XR68"	flat-panel vertical panel size / alternate vertical DE end
 69h	"XR69"	flat-panel vertical display start 350
 6Ah	"XR6A"	flat-panel vertical display end 350
 6Bh	"XR6B"	flat-panel vertical overflow 2
 6Ch	"XR6C"	weight control clock C
 6Dh	"XR6D"	FRC control
 6Eh	"XR6E"	polynomial FRC control
 6Fh	"XR6F"	frame buffer control
 70h	"XR70"	setup/disable control (see #P0807)
 71h-7Ch	reserved
 7Dh	"XR7D"	flat-panel compensation diagnostic
 7Eh	"XR7E"	CGA/Hercules color selection (see #P0815)
 7Fh	"XR7F"	diagnostics (see #P0816)
!!! chips\64200.pdf p.28, p.72
Note:	not all C&T chips support all of the above registers; see the tables
	  for the individual registers for a list of supporting chipsets
SeeAlso: #P0763

(Table P0763)
Values for Chips&Technologies 64310 extension register index:
 00h	"XR00"	chip version (see #P0764)
 01h	"XR01"	configuration (see #P0766)
 02h	"XR02"	CPU interface control (see #P0767)
 03h	"XR03"	CPU interface control 2 (see #P0769)
 04h	"XR04"	memory control (see #P0770)
 05h	"XR05"	memory control 2 (see #P0772)
 06h	"XR06"	color palette control / DRAM interface (see #P0773)
 07h	"XR07"	DRxx I/O base ???
 08h	"XR08"	linear frame buffer base address low register (see #P0774)
 09h	"XR09"	linear frame buffer base address high register (see #P0775)
 0Ah	"XR0A"	XRAM mode register (see #P0776)
 0Bh	"XR0B"	CPU paging (see #P0777)
 0Ch	"XR0C"	start address top (see #P0779)
 0Dh	"XR0D"	auxiliary offset (see #P0780)
 0Eh	"XR0E"	text mode control (see #P0781)
 0Fh	"XR0F"	software flag register 0 (reserved for BIOS/driver use)
 10h	"XR10"	single/low map register (see #P0782)
 11h	"XR11"	high map register (see #P0783)
 12h-13h	reserved
 14h	"XR14"	emulation mode (see #P0784)
 15h	"XR15"	write protect (see #P0785)
 16h	"XR16"	vertical overflow register (see #P0786)
 17h	"XR17"	horizontal overflow register (see #P0787)
 18h	"XR18"	reserved
 19h	"XR19"	alternate horizontal sync start / half-line (see #P0788)
 1Ah-1Bh	reserved
 1Ch	"XR1C"	alternate horizontal blank start / horizontal panel size
 1Dh-27h	reserved
 28h	"XR28"	video interface (see #P0792)
 29h-2Ah	reserved
 2Bh	"XR2B"	software flag register 1 (used by device drivers)
 2Ch-2Fh	reserved
 30h	"XR30"	clock divide control register (see #P0793)
 31h	"XR31"	clock M-divisor register (see #P0794)
 32h	"XR32"	clock N-divisor register (see #P0795)
 33h	"XR33"	clock control register (see #P0796)
 34h-39h	reserved
 3Ah	"XR3A"	color key compare data 0 (see #P0797)
 3Bh	"XR3B"	color key compare data 1 (see #P0798)
 3Ch	"XR3C"	color key compare data 2 (see #P0800)
 3Dh	"XR3D"	color key compare mask 0 (see #P0802)
 3Eh	"XR3E"	color key compare mask 1 (see #P0803)
 3Fh	"XR3F"	color key compare mask 2 (see #P0804)
 40h	"XR40"	BitBlt config register (see #P0805)
 41h	"XR41"	reserved
 42h-43h	reserved
 44h	"XR44"	software flag register 2 (reserved for BIOS/driver use)
 45h	"XR45"	reserved
 46h-4Fh	reserved
 50h-51h	reserved
 52h	"XR52"	refresh control register (see #P0806)
 53h-5Fh	reserved
 60h	"XR60"	blink rate control
 61h-6Fh	reserved
 70h	"XR70"	setup/disable control (see #P0807)
 71h	"XR71"	GPIO control register (see #P0808)
 72h	"XR72"	GPIO data register (see #P0809)
 73h	"XR73"	misc control register (see #P0810)
 74h	"XR74"	configuration register 2 (see #P0811)
 75h	"XR75"	software flag register 3 (reserved for BIOS/driver use)
 76h-79h	reserved
 7Ah	"XR7A"	test index register (see #P0812)
 7Bh	"XR7B"	test control register (see #P0813)
 7Ch	"XR7C"	test data register (see #P0814)
 7Dh	"XR7D"	diagnostic register (reserved; should not be read or written)
 7Eh	"XR7E"	reserved
 7Fh	"XR7F"	diagnostic register (reserved; should not be read or written)
SeeAlso: #P0762

Bitfields for Chips&Technologies "XR00" chip version:
Bit(s)	Description	(Table P0764)
 7-4	chip type
	0000 = 82C451
	0001 = 82C452
	0010 = 82C455
	0011 = 82C453
	0100 = 82C450
	0101 = 82C456
	0110 = 82C457
	0111 = 65520
	1000 = 65530 / 65525
	1001 = 65510 Flat-Panel Controller
	1010 = 64200 Wingine
	1011 = 64300/301 Wingine DGX (if bit 3 clear)
	1011 = 64310 Wingine DGX-PCI (if bit 3 set)
 3-0	chip revision (0000 = first silicon)
Note:	this register is read-only
SeeAlso: #P0762,#P0765

Bitfields for Chips&Technologies 64200 "XR01" configuration:
Bit(s)	Description	(Table P0765)
 7-4	configuration bits 7-4 (latched from pins on falling edge of RESET)
 3	memory configuration
	0 video memory pins always drive
	1 video memory pins only driven when XR03 bit 0 is clear (VGA mode)
 2	source of pixel clock
	0 oscillator (CLK0-CLK3 are pixel-clock inputs, which are selected by
	  MSR bits 3-2)
	1 clock chip (CLK0 is pixel clock input, CLK1-CLK3 are CSELx outputs)
 1-0	bus type
	00 PCI
	01 Microchannel
	10 local bus
	11 ISA
Note:	this register is read-only
SeeAlso: #P0762,#P0764,#P0767,#P0766

Bitfields for Chips&Technologies 64300/64310 "XR01" configuration:
Bit(s)	Description	(Table P0766)
 7-6	(64310) reserved (0)
 7	(64300) VL-Bus CPU speed???
 6	(64300) VL-Bus zero wait state???
 5	(64310) OSC source
	0 = external
	1 = internal
 4	(64310) clock source
	0 = external (82C404C)
	1 = internal
 3	(64310) chip (bus interface and RAMDAC) enable
 2	(64310) 64310 isolate
	0 = 64310 cannot be disabled
	1 = 64310 can be disabled using port 106h in setup mode
	(64310 may also be disabled using PCI configuration registers)
 1-0	(64310) bus type
	00 reserved
	01 32-bit PCI
	10 reserved
	11 32-bit local bus
SeeAlso: #P0763,#P0765

Bitfields for Chips&Technologies "XR02" CPU interface register:
Bit(s)	Description	(Table P0767)
 7	status of attribute flip-flop (read-only) (0 = index, 1 = data)
 6	(64200) palette address decoding
	0 access only at PORT 03C6h-03C9h
	1 also access at PORT 83C6h-83C9h (for RAMDACs with 8 registers)
	(64310) reserved (0)
 5	I/O address decoding
	0 decode all 16 bits of address
	1 only decode low ten bits of address for 3B4h,3B5h,3B8h,3BAh,3BFh,
	  3C0h-3C2h,3C4h,3C5h,3CEh,3CFh,3D4h,3D5h,3D8h-3DAh
 4-3	mapping of Attribute Controller
	00 VGA mapping - write index and data at 03C0h (8-bit only)
	01 16-bit mapping - write index at 03C0h, data at 03C1h
	10 (64200 only) EGA mapping - write index at 03C0h, data at 03C0h or
		  03C1h (8-bit)
	11 reserved
 2-0	reserved (0)
SeeAlso: #P0762,#P0765,PORT 83C6h

Bitfields for Chips&Technologies "XR03" Master Control register:
Bit(s)	Description	(Table P0768)
 7	XREQ# direction (=0 input, =1 output)
 6	XREQ# divide (=0 DispEnable for all lines, =1 even-numbered lines)
 5	XREQ# mode (=0 DispEnable only, =1 split-buffer VRAM transfer timing)
	(see #P0799"XR3C",#P0801"XR3D")
 4	alternate VGA address
	=1 map at PORT 02C6h-02C9h instead of 03C6h-03C9h
 3-2	reserved
 1	alternate palette address
	=1 map at PORT 02Bxh or PORT 02Dxh instead of 03Bxh/03Dxh
 0	Wingine/VGA select
	=0 VGA
	=1 Wingine (memory pins are tri-stated)
Note:	a write-only copy of this register may be accessed at PORT 0022h
	  (index E0h) and PORT 0023h; a read-write copy exists in systems with
	  built-in Wingine support
SeeAlso: #P0762,#P0767,#P0770,#P0769

Bitfields for Chips&Technologies 64310 "XR03" CPU interface register 2:
Bit(s)	Description	(Table P0769)
 7-2	reserved (0)
 1	DRxx register access enable (I/O port defined in XR07 ???)
 0	palette write shadow
SeeAlso: #P0763,#P0768

Bitfields for Chips&Technologies "XR04" Memory Control register:
Bit(s)	Description	(Table P0770)
 7-6	(64200) reserved (0)
 7	(64310) FIFO depth
	0 = bus FIFO is 8 deep
	1 = bus FIFO is 4 deep
 6	(64310) PCI burst enable
 5	(64200) enable CPU memory write buffer
	(64310) CPU bus FIFO enable
 4-3	reserved (0)
 2	memory wraparound
	=1 enable bit 17 of CRTC address counter
 1-0	(64310) memory configuration
	   data path  chips   config   total
	00    16-bit	  4  256Kx4   1/2 MB
			  1  256Kx16  1/2 MB
	01    32-bit	  8  256Kx4	1 MB
			  2  256Kx16	1 MB
	10    32-bit	 16  256Kx4	2 MB
			  4  256Kx16	2 MB
	11  reserved
 1	(64200) reserved (0)
 0	(64200) memory configuration
	=0 8-bit data, two DRAM chips of 256Kx4
	=1 16-bit data, four DRAM chips of 256Kx4
SeeAlso: #P0762,#P0768,#P0763

Bitfields for Chips&Technologies "XR05" Clock Control register:
Bit(s)	Description	(Table P0771)
 !!!
SeeAlso: #P0762

Bitfields for Chips&Technologies 64310 "XR05" Memory Control register 2:
Bit(s)	Description	(Table P0772)
 7	VAFC PCLK/2
	0 = DCLK=PCLK
	1 = DCLK=PCLK/2
 6	VAFC enable (XR71 bits 5, 3 and 2 must be 0)
 5	reserved (0)
 4	256Kx16 access format
	0 = 2 CAS / 1 WE
	1 = 2 WE / 1 CAS
 3-0	reserved
SeeAlso: #P0763

Bitfields for Chips&Technologies "XR06" color palette control / DRAM interface:
Bit(s)	Description	(Table P0773)
 7-5	(64310) reserved (0)
 4	(64310) video overlay on color key enable
 3-2	(64310) display mode color depth
	00 = 4BPP / 8BPP
	01 = 15BPP (5-5-5) Sierra compatible
	10 = 24BPP
	11 = 16BPP (5-6-5) XGA compatible
 1	(64310) internal DAC disable
 0	(64310) enable external pixel data
	0 = VID15-0 and KEY inputs for live video overlay
	1 = P7-0 and BLANK# outputs for external feature connector/external
	  color keying (XR73 bit 5 must be set)
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR08" linear frame buffer base low:
Bit(s)	Description	(Table P0774)
 7-6	linear frame buffer base address low (VL-Bus only)
	(bits 23-22 of linear frame buffer base address)
	(LFB is 4 MB boundary within 4 GB address space. Upper 2 MB is used
	  for memory mapped I/O.)
 5-0	reserved (0)
SeeAlso: #P0763,#P0775

Bitfields for Chips&Technologies 64310 "XR09" linear frame buffer base high:
Bit(s)	Description	(Table P0775)
 7-0	linear frame buffer base address high (VL-Bus only)
	(bits 23-22 of linear frame buffer base address)
	(LFB is 4 MB boundary within 4 GB address space. Upper 2 MB is used
	  for memory mapped I/O.)
SeeAlso: #P0763,#P0774

Bitfields for Chips&Technologies 64310 "XR0A" XRAM mode register:
Bit(s)	Description	(Table P0776)
 7	reserved (0)
 6	disable upper XRAM in 2MB modes
	0 = upper XRAM not enabled
	1 = upper XRAM enabled
	(used in systems with 2MB frame buffer but only single 256Kx4 XRAM)
 5	XRAM diagnostic 64 (0)
 4	synchronous XRAM enable
 3	asynchronous XRAM enable
 2-1	BitBlt update
	00 = no update during BitBlt
	11 = BitBlt update enabled
 0	XRAM test enable
	0 = XRAM normal mode
	1 = XRAM read/write
SeeAlso: #P0763

Bitfields for Chips&Technologies "XR0B" CPU Paging register:
Bit(s)	Description	(Table P0777)
 7-3	(64200) reserved (0)
 7	(64310) big-endian byte swap (32 bpp swap)
	0 = no swap
	1 = swap bytes 0-3 and 1-2
 6	(64310) big-endian byte swap (16 bpp swap)
	0 = no swap
	1 = swap bytes 0-1 and 2-3
 4	(64310) linear addressing enable
 3	(64310) reserved (0)
 2	divide CPU addresses by 4 (chain-4 mode)
 1	use two maps for CPU to access extended video memory (see #P0782,#P0783)
 0	memory-mapping mode
	=0 VGA-compatible
	=1 extended mapping for >= 512K video memory
SeeAlso: #P0762,#P0778,#P0763

Bitfields for Chips&Technologies 64200 "XR0C" Start Address Top register:
Bit(s)	Description	(Table P0778)
 7-1	reserved (0)
 0	high-order bit of display start address when 512K display memory used
SeeAlso: #P0762,#P0777,#P0779

Bitfields for Chips&Technologies 64310 "XR0C" Start Address Top register:
Bit(s)	Description	(Table P0779)
 7	reserved
 6	high map bit 8
 4	low map bit 8
 3-0	high-order bits of display start address
SeeAlso: #P0763,#P0778

Bitfields for Chips&Technologies "XR0D" Auxiliary Offset register:
Bit(s)	Description	(Table P0780)
 7-3	reserved (0)
 2	(64200) reserved (0)
	(64310) msb of row offset register (CRT controller register 13h)
 1-0	(64310) reserved (0)
 1	(64200) LSB of memory offset (CR13) in Chain and Chain-4 modes
 0	(64200) LSB of alternate memory offset (XR1E) in Chain/Chain-4 modes
SeeAlso: #P0762

Bitfields for Chips&Technologies "XR0E" Text Mode Control register:
Bit(s)	Description	(Table P0781)
 7-4	reserved (0)
 3	cursor style (0 = replace, 1 = XOR)
 2	disable cursor blink
 1	reserved (0)
 0	(64200) reserved (0)
	(64310) extended text mode font scrambling in plane 2 enable
SeeAlso: #P0762,#P0763

Bitfields for Chips&Technologies "XR10" Single/Low Map register:
Bit(s)	Description	(Table P0782)
 7-0	(64310) single/low map base address bits 17-10
	(single map mode base address if XR0B bit 1 = 0, dual map mode lower
	  map base address if XR0B bit 1 = 1)
!!!chips\64200.pdf p.80
SeeAlso: #P0762,#P0783,#P0763

Bitfields for Chips&Technologies "XR11" High Map register:
Bit(s)	Description	(Table P0783)
 7-0	(64310) dual map mode high map base address bits 17-10
	  (if XR0B bit 1 = 1)
SeeAlso: #P0762,#P0782

Bitfields for Chips&Technologies "XR14" Emulation Mode register:
Bit(s)	Description	(Table P0784)
 7	enable interrupt output function (=0 tri-state IRQ# line)
 6	(64200) enable VSync status bit at PORT 03BAh/03DAh
	(64310) reserved (0)
 5	vertical retrace status
	=0 PORT 03BAh/03DAh bit 3 is vertical retrace (CGA/EGA/VGA)
	=1 PORT 03BAh/03DAh bit 3 is video active (MDA/Herc)
 4-0	(64310) reserved (0)
 4	(64200) display enable status
	=0 PORT 03BAh/03DAh bit 0 is display enable (CGA/EGA/VGA)
	=1 PORT 03BAh/03DAh bit 0 is HSync (MDA/Herc)
 3-2	(64200) (read-only) Hercules configuration register readback
	  (see PORT 03BFh)
 1-0	(64200) emulation mode
	00 VGA
	01 CGA
	10 MDA/Hercules
	11 EGA
SeeAlso: #P0762,#P0763

Bitfields for Chips&Technologies "XR15" Write Protect register:
Bit(s)	Description	(Table P0785)
 7	write protect AR11 (both bits 7 and 0 must be clear to write AR11)
 6
 5
 4
 3
 2
 1
 0	!!!chips\64200.pdf p.82
SeeAlso: #P0762

Bitfields for Chips&Technologies 64310 "XR16" vertical overflow register:
Bit(s)	Description	(Table P0786)
 7	resrved (0)
 6	line compare bit 10
 5	resrved (0)
 4	vertical blank start bit 10
 3	resrved (0)
 2	vertical sync start bit 10
 1	vertical display enable end bit 10
 0	vertical total bit 10
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR17" horizontal overflow register:
Bit(s)	Description	(Table P0787)
 7	half line compare bit 8 (bits 7-0 in XR19)
 6	overflow end bits (XR17 bits 5 and 3) enable
 5	horizontal blank end bit 6
 4	horizontal blank start bit 8
 3	horizontal sync end bit 5
 2	horizontal sync start bit 8
 1	horizontal display enable end bit 8
 0	horizontal total bit 8
SeeAlso: #P0763

Bitfields for Chips&Technologies "XR19" alt. horizontal sync start/half-line:
Bit(s)	Description	(Table P0788)
 7-0	(64310) CRT half-line value
SeeAlso: #P0763

Bitfields for Chips&Technologies "XR1A" Alternate Horizontal Sync End register:
Bit(s)	Description	(Table P0789)
 7
 6-5
 4-0
SeeAlso: #P0762,#P0790

Bitfields for Chips&Technologies "XR1D" Alternate Horizontal Blank End reg:
Bit(s)	Description	(Table P0790)
 7
 6-5
 4-0
SeeAlso: #P0762,#P0789

Bitfields for Chips&Technologies "XR1F" Virtual EGA Switch register:
Bit(s)	Description	(Table P0791)
 7
 6-4	reserved (0)
 3-0	virtual EGA switches
SeeAlso: #P0762

Bitfields for Chips&Technologies "XR28" Video Interface register:
Bit(s)	Description	(Table P0792)
 7	reserved
 6	(64310) wide video pixel panning (if bit 4 = 1 and port 3C0h
	  register 10h bit 6 = 1)
	0 = pixel panning controlled by port 3C0h register 13h bits 2-1
	1 = pixel panning controlled by port 3C0h register 13h bits 2-0
 5	interlaced video
 4	(64310) wide video path (doubles values in all horizontal CRTC
	  registers)
	0 = 4-bit video data path
	1 = 8-bit video data path (horizontal pixel panning controlled by
	  bit 6; port 3CEh register 5h bit 5 must be 0)
 3	reserved (0)
 2	shut off video
 1	(64310) BLANK#/display enable select
	0 = BLANK# pin outputs BLANK#
	1 = BLANK# pin outputs display enable
 0	(64310) BLANK#/display enable polarity
	0 = negative polarity
	1 = positive polarity
SeeAlso: #P0762,#P0763

Bitfields for Chips&Technologies 64310 "XR30" clock divide control register:
Bit(s)	Description	(Table P0793)
 7-4	reserved (0)
 3-1	post divisor select
	000 = divide by 1
	001 = divide by 2
	010 = divide by 4
	011 = divide by 8
	100 = divide by 16
	101 = divide by 32
	110-111 = reserved
 0	reference divisor select
	0 = divide by 4
	1 = divide by 1
Note:	Registers XR30-32 are used to program either memory clock or video
	  clock VCO, selected by XR33 bit 5. Data must be written in sequence
	  to all three registers, after which they are transferred to VCO
	  simultaneously.
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR31" clock M-divisor register:
Bit(s)	Description	(Table P0794)
 7	reserved (0)
 6-0	VCO M-divisor (program value - 2)
Note:	Registers XR30-32 are used to program either memory clock or video
	  clock VCO, selected by XR33 bit 5. Data must be written in sequence
	  to all three registers, after which they are transferred to VCO
	  simultaneously.
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR32" clock N-divisor register:
Bit(s)	Description	(Table P0795)
 7	reserved (0)
 6-0	VCO N-divisor (program value - 2)
Note:	Registers XR30-32 are used to program either memory clock or video
	  clock VCO, selected by XR33 bit 5. Data must be written in sequence
	  to all three registers, after which they are transferred to VCO
	  simultaneously.
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR33" clock control register:
Bit(s)	Description	(Table P0796)
 7-6	reserved (0)
 5	clock register program pointer
	0 = VCLK VCO
	1 = MCLK VCO
 4	PCLK equals MCLK instead of VCLK
 3	reserved (0)
 2	OSC enable (if XR01 bit 5 = 1)
 1	MCLK VCO enable (if XR01 bit 4 = 1)
 0	VCLK VCO enable (if XR01 bit 4 = 1)
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR3A" color key compare data 0:
Bit(s)	Description	(Table P0797)
 7-0	color compare data 0
	(Compared to lowest 8 bits of 64310 memory data, masked with XR3D. If
	  match occurs and XR06 bit 4 = 1, external video is sent to screen.
	  Color comparison occurs before RAMDAC. Palette LUT index is used in
	  4BPP and 8BPP modes.)
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR3B" color key compare data 1:
Bit(s)	Description	(Table P0798)
 7-0	color compare data 1
	(Compared to bits 15-8 of 64310 memory data, masked with XR3E. If
	  match occurs and XR06 bit 4 = 1, external video is sent to screen.
	  This register should be masked in 4BPP and 8BPP modes by setting
	  XR3E to FFh.)
SeeAlso: #P0763

Bitfields for Chips&Technologies 64200 "XR3C" Serial/Row Count register:
Bit(s)	Description	(Table P0799)
 7-6	reserved (0)
 5-3	row count (number of transfer cycles)
	000 = 64
	001 = 128
	010 = 256
	011 = 512
	1x0 = 1024
	1x1 = 2048
 2-0	serial count (same as for bits 5-3, but in units of serial clocks)
SeeAlso: #P0762,#P0801,#P0768

Bitfields for Chips&Technologies 64310 "XR3C" color key compare data 2:
Bit(s)	Description	(Table P0800)
 7-0	color compare data 2
	(Compared to bits 23-16 of 64310 memory data, masked with XR3F. If
	  match occurs and XR06 bit 4 = 1, external video is sent to screen.
	  This register should only be used in 24BPP modes, and masked in
	  other modes by setting XR3F to FFh.)
SeeAlso: #P0763,#P0802

Bitfields for Chips&Technologies 64200 "XR3D" Multiplexer Mode register:
Bit(s)	Description	(Table P0801)
 7-5	reserved
 4
 3
 2-0	multiplexer mode
SeeAlso: #P0762,#P0799,#P0768

Bitfields for Chips&Technologies 64310 "XR3D" color key compare mask 0:
Bit(s)	Description	(Table P0802)
 7-0	color compare mask 0 (masks XR3A)
	0 = bit compared
	1 = bit masked from comparison
SeeAlso: #P0763,#P0800,#P0803

Bitfields for Chips&Technologies 64310 "XR3E" color key compare mask 1:
Bit(s)	Description	(Table P0803)
 7-0	color compare mask 1 (masks XR3B)
	0 = bit compared
	1 = bit masked from comparison
SeeAlso: #P0763,#P0802,#P0804

Bitfields for Chips&Technologies 64310 "XR3F" color key compare mask 2:
Bit(s)	Description	(Table P0804)
 7-0	color compare mask 2 (masks XR3C)
	0 = bit compared
	1 = bit masked from comparison
SeeAlso: #P0763,#P0802,#P0803

Bitfields for Chips&Technologies 64310 "XR40" BitBlt config register:
Bit(s)	Description	(Table P0805)
 7-2	reserved (0)
 1-0	BitBlt draw mode
	00 = reserved
	01 = 8bpp
	10 = 16bpp
	11 = reserved
	(24bpp handled in 8bpp mode; no nibble mode for 4bpp)
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR52" refresh control register:
Bit(s)	Description	(Table P0806)
 7-3	reserved (0)
 2-0	VGA refresh cycles per scan line
	000 = default
	001-101 = 1-5 refresh cycles
	110-111 = illegal
SeeAlso: #P0763

Bitfields for Chips&Technologies "XR70" Setup/Disable Control register:
Bit(s)	Description	(Table P0807)
 7
 6-0	reserved (0)
SeeAlso: #P0762

Bitfields for Chips&Technologies 64310 "XR71" GPIO control register:
Bit(s)	Description	(Table P0808)
 7-5	GPOE
	0 = respective GPIO pin is input
	1 = respective GPIO pin is output
	(if standard feature connector is enabled (XR73 bit 5 = 1), GPIO pin 5
	  becomes an alternate fixed function input (ECLK#) and bit 5 must be
	  set to 0)
	(if external clock is selected (XR01 bit 4 = 0), bits 7-6 have no
	  effect and GPIO pins 7-6 become CLKSEL1-0 and output contents of
	  port 3CCh bits 3-2)
 4	reserved (0)
 3-2	GPOE
	0 = respective GPIO pin is input
	1 = respective GPIO pin is output
	(if standard feature connector is enabled (XR73 bit 5 = 1), GPIO pins
	  3 and 2 become alternate fixed function inputs (EVIDEO#, ESYNC#) and
	  bits 3-2 must be set to 0)
 1-0	reserved (0)
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR72" GPIO data register:
Bit(s)	Description	(Table P0809)
 7-5	GPIO (input from/output to respective GPIO pin)
	(if standard feature connector is enabled (XR73 bit 5 = 1), GPIO pin 5
	  becomes an alternate fixed function input (ECLK#))
	(if external clock is selected (XR01 bit 4 = 0), GPIO pins 7-6 become
	  CLKSEL1-0 and output contents of port 3CCh bits 3-2)
 4	reserved (0)
 3-2	GPIO (input from/output to respective GPIO pin)
	(if standard feature connector is enabled (XR73 bit 5 = 1), GPIO pins
	  3 and 2 become alternate fixed function inputs (EVIDEO#, ESYNC#))
 1-0	reserved (0)
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR73" misc control register:
Bit(s)	Description	(Table P0810)
 7	ROMCS# write access enable
 6	external color key enable
 5	standard feature connector enable (must be set before XR06 bit 0)
 4	reserved (0)
 3	VSYNC control
	0 = CRTC VSYNC is output on VSYNC pin 126
	1 = bit 2 is output on VSYNC pin 126
 2	VSYNC data (if bit 3 = 1, this bit will be output on VSYNC pin)
 1	HSYNC control
	0 = CRTC HSYNC is output on HSYNC pin 125
	1 = bit 0 is output on HSYNC pin 125
 0	HSYNC data (if bit 1 = 1, this bit will be output on HSYNC pin)
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR74" configuration register 2:
Bit(s)	Description	(Table P0811)
 7-0	(64300) ???
	(64310) reserved (0)
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR7A" test index register:
Bit(s)	Description	(Table P0812)
 7-0	test index (select XR7B function)
	00h = reserved
	01h = CRC signature analysis
	02h-FFh = reserved
SeeAlso: #P0763

Bitfields for Chips&Technologies 64310 "XR7B" test control register:
Bit(s)	Description	(Table P0813)
---XR7A = 01h---
 7	CRC status (read-only)
	0 = CRC ARM=0 or CRC data is being generated (CRC data should not be
	  read)
	1 = CRC ARM=1 and CRC data is ready
 6	CRC arm
	1 = arm CRC generation to start after the next VSYNC and stop after the
	  VSYNC following that (should not be set to 0 until entire CRC value
	  is read)
 5-4	CRC data select (select data to be read from XR7C)
	00 = CRC bit 7-0
	01 = CRC bits 15-8
	10 = 0 and CRC bits 22-16
	11 = 00h
 3-2	CRC qualification
	00 = take all data
	01 = take data when not blank (DE + overscan)
	10 = take data when DE is active
	11 = take data in PC Video window only
 1-0	video data select
	00 = red video data before DAC output
	01 = green video data before DAC output
	10 = blue video data before DAC output
	11 = control data (VSYNC, HSYNC, blank, internal display enable,
	  0, 0, 0, 0)
SeeAlso: #P0763,#P0812

Bitfields for Chips&Technologies 64310 "XR7C" test data register:
Bit(s)	Description	(Table P0814)
---XR7A = 01h---
 7-0	CRC data (read-only)
SeeAlso: #P0763,#P0812

Bitfields for Chips&Technologies "XR7E" CGA Color Select register:
Bit(s)	Description	(Table P0815)
 7-6	reserved
 5
 4
 3-0
Note:	this is a mirror of the register accessed via PORT 03D9h, which is
	  always visible, while PORT 03D9h is only visible in CGA emulation
SeeAlso: #P0762,PORT 03D9h

Bitfields for Chips&Technologies "XR7F" Diagnostic register:
Bit(s)	Description	(Table P0816)
 7	special test function (should remain cleared)
 6	enable test function in bits 5-2
 5-2	test function
 1	tri-state output pins: !!!
 0	tri-state output pins: !!! chips\64200.pdf p.90
SeeAlso: #P0762
----------P03D803DF--------------------------
PORT 03D8-03DF - COLOR VIDEO - CRT MODE AND STATUS REGISTERS

03D8  RW  CGA mode control register  (except PCjr) (see #P0817)
	cannot be found on native color EGA, color VGA, but on most clones
03D9  RW  CGA palette register (see #P0819)
	(MCGA) CGA border control register
	Cannot be found on native EGA, VGA (without translation ROM) but
	  only most clones. Read access on Genoa SuperEGA is 'reset'???
03DA  R-  CGA status register (see #P0818)
	color EGA/VGA: input status 1 register
03DA  -W  color EGA/color VGA feature control register (see #P0820)
	(at PORT 03BAh w in mono mode, VGA: 3CAh r)
03DA  -W  HZ309 (MDA/HGC/CGA clone) card from in Heath/Zenith HZ150 PC
	bit7-1=0: unknown, zero is default and known to function
		   properly at least in CGA modes.
	bit 0 = 1 override 3x8h bit3 control register that switches
		   CRT beam off if bit3 is cleared. So screens always
		   stays on.
	bit 0 = 0 3x8h bit3 indicates if CRT beam is on or off.
		   No more info available. Might conflict with EGA/VGA.
03DB  rW  clear light pen latch	(not MCGA)
		  (R/W only with Genoa SuperEGA)
03DC  RW  (not MCGA) preset light pen latch
03DC  -W  (CGA) set light pen latch
03DD  -W  (MCGA)  Extended mode control register
	  (Plantronics & Genoa SuperEGA: Plantronics ColorPlus control,
		      compatible with MCGA???)
	(default is 00h, in mode 13h: 04h)
	bit7 =1: DAC active, cannot be read
	     =0: DAC not active, read allowed
	bit6-5 : reserved
	bit4   : AST_PLANTRONICS
	bit3   : reserved
	bit2 =1: videomode 13h with 256 colors active
	bit1	: reserved
	bit0 =0: reserved
     	Note:	Apparently on the AST "ColorGraphPlus", its Enhanced mode can
		  be activated with 90h and reset with 00h; on this card the
		  Plantronics mode can be enabled with 10h.
03DE  --  (MCGA) reserved
03DE  -W  (AT&T & color ET4000 in AT&T compatibility mode & C&T 82C426)
	  AT&T mode control register (see #P0821)
	(register enabled in ET4000, if bit7=1 in CRTC 3D4h/34h.)
03DF  --  (MCGA) reserved
03DF  ?W  CRT/CPU page register	 (PCjr only)

Bitfields for CGA/Hercules mode control register:
Bit(s)	Description	(Table P0817)
 7-0	=A0h color ET4000: second part of 'key', see Hercules compatibility
	  register (see PORT 03BFh) for details. For resetting the key, e.g.
	  write 01h to PORT 03BFh and 29h to PORT 03D8h.
 7	(Hercules) page select
	=0 B0000h
	=1 B8000h
 6	color ET4000 only, read-only: report status of bit 1 (enable 2nd page)
	  of hercules compatibility register (see PORT 03BFh)
 5	=1  blink enabled instead of foreground high-int.
 4	=1  640*200 graphics mode (CGA)
 3	=1  video enabled (HZ309, see PORT 03DAh bit 0)
 2	=1  monochrome signal
		(MCGA) in mode 6 and 11h color comes from palette
		  regs 00 (black) and 07 (white), and can be changed there.
 1	=0  text mode
	=1  320*200 graphics mode
 0	text columns (0 = 40*25 text mode, 1 = 80*25 text mode)
SeeAlso: #P0818

Bitfields for CGA status register:
Bit(s)	Description	(Table P0818)
 7-6	not used
 7	(C&T Wingine) vertical sync in progress (if enabled by XR14)
 5-4	color EGA, color ET4000, C&T: diagnose video display feedback, select
	  from color plane enable
 3	in vertical retrace
	(C&T Wingine) video active (retrace/video selected by XR14)
 2	(CGA,color EGA) light pen switch is off
	(MCGA,color ET4000) reserved (0)
	(VGA) reserved (1)
 1	(CGA,color EGA) positive edge from light pen has set trigger
	(VGA,MCGA,color ET4000) reserved (0)
 0	horizontal retrace in progress
	=0  do not use memory
	=1  memory access without interfering with display
	    (VGA,Genoa SuperEGA) horizontal or vertical retrace
	(C&T Wingine) display enabled (retrace/DE selected by XR14)
SeeAlso: #P0817,#P0819,#P0762

Bitfields for CGA palette register:
Bit(s)	Description	(Table P0819)
 7-6	not used
 5	=0 active 320x200x4 color set: red, green brown
	=1 active 320x200x4 color set: cyan, magenta, white
 4	intense colors in graphics, background colors text
 3	intense border in 40*25, intense background in 320*200, intense
	  foreground in 640*200
 2	red border in 40*25, red background in 320*200,	red foreground in
	  640*200
 1	green border in 40*25, green background in 320*200, green foreground
	  in 640*200
 0	blue border in 40*25, blue background in 320*200, blue foreground in
	   640*200
SeeAlso: #P0817,#P0818

Bitfields for color EGA/VGA feature control register:
Bit(s)	Description	(Table P0820)
 7	ET4000 only: enable NMI generation ('key' protected)
 6-4	not used
 3	(VGA) 0 = normal vsync, 1 = vsync OR display enable
 2	reserved (0)
	(C&T Wingine) disable 16-bit operations
 1	(EGA,ET4000,Wingine) FEAT1 control bit1 (pin17 feature connector)
	(VGA) reserved (0)
 0	(EGA,ET4000,Wingine) FEAT0 control bit0 (pin19 feature connector)
	(VGA) reserved (0)
SeeAlso: #P0818

Bitfields for AT&T mode control register:
Bit(s)	Description	(Table P0821)
 7	reserved
 6	underline color attribute enable
	ET4000: enabled, if bit6=1 in CRTC 3D4h/34h.
 5	reserved
 4	reserved
 3	alternate page select (=1: 2nd 16KB page, with bit0=0)
 2	alternate font select (0=default font block)
 1	reserved
 0	double scan line mode (0=IBM 200, 1=AT&T 400 line graphics)
	(ET4000) enabled, if bit7-6=11b in CRTC 3D4h/34h.
----------P03E003E1--------------------------
PORT 03E0-03E1 - OPTi 82C824 - CardBus Bridge registers
Range:	PORT 03E0h or PORT 03E2h
SeeAlso: PORT 03E2h"CardBus"

03E0  ?W  index for data register
03E1  RW  CardBus registers
--------X-P03E003E1--------------------------
PORT 03E0-03E1 - Cirrus Logic CL-PD6710/6722/6729 - PC-CARD HOST ADAPTER
Notes:	the CL-PD6729 has compatible registers, but the port address
	  is set via the PCI configuration space (two consecutive ports
	  starting at Base Address 0)
	the CL-PD6832 supports a superset of this register set
SeeAlso: PORT 03E0h"CardBus"

03E0  ?W  index for data register (see #P0822)
03E1  RW  register data

Bitfields for Cirrus Logic CL-PD6710/6722 index register:
Bit(s)	Description	(Table P0822)
 7	device number (when dual CL-PD67xx's are used)
	(CL-PD6729) reserved
 6	socket number (CL-PD6722 dual-socket adapter only)
 5-0	register index (see #P0823)

(Table P0823)
Values for Cirrus Logic CL-PD6710/6722 register number:
 00h	chip revision (affects both sockets) (see #P0824)
 01h	interface status (see #P0825)
 02h	power control (see #P0826)
 03h	interrupt and general control (see #P0827)
 04h	card status change (see #P0828)
 05h	management interrupt configuration (see #P0829)
 06h	mapping enable (see #P0830)
 07h	I/O window control (see #P0831)
 08h	system I/O map 0 start address low
 09h	system I/O map 0 start address high
 0Ah	system I/O map 0 end address low
 0Bh	system I/O map 0 end address high
 0Ch	system I/O map 1 start address low
 0Dh	system I/O map 1 start address high
 0Eh	system I/O map 1 end address low
 0Fh	system I/O map 1 end address high
 10h	system memory map 0 start address low (address bits 19-12)
 11h	system memory map 0 start address high (see #P0832)
 12h	system memory map 0 end address low (address bits 19-12)
 13h	system memory map 0 end address high (see #P0833)
 14h	card memory map 0 offset address low (address bits 19-12)
 15h	card memory map 0 offset address high (see #P0834)
 16h	misc control 1 (see #P0835)
 17h	FIFO control (see #P0836)
 18h	system memory map 1 start address low (address bits 19-12)
 19h	system memory map 1 start address high (see #P0832)
 1Ah	system memory map 1 end address low (address bits 19-12)
 1Bh	system memory map 1 end address high (see #P0833)
 1Ch	card memory map 1 offset address low (address bits 19-12)
 1Dh	card memory map 1 offset address high (see #P0834)
 1Eh	misc control 2 (affects both sockets) (see #P0837)
 1Fh	chip information (affects both sockets) (see #P0838)
 20h	system memory map 2 start address low (address bits 19-12)
 21h	system memory map 2 start address high (see #P0832)
 22h	system memory map 2 end address low (address bits 19-12)
 23h	system memory map 2 end address high (see #P0833)
 24h	card memory map 2 offset address low (address bits 19-12)
 25h	card memory map 2 offset address high (see #P0834)
 26h	ATA control (see #P0839)
 27h	scratchpad
 28h	system memory map 3 start address low (address bits 19-12)
 29h	system memory map 3 start address high (see #P0832)
 2Ah	system memory map 3 end address low (address bits 19-12)
 2Bh	system memory map 3 end address high (see #P0833)
 2Ch	card memory map 3 offset address low (address bits 19-12)
 2Dh	card memory map 3 offset address high (see #P0834)
 2Eh	(CL-PD6722/6729) extended index for extended data register (see #P0842)
 2Fh	extended data
 30h	system memory map 4 start address low (address bits 19-12)
 31h	system memory map 4 start address high (see #P0832)
 32h	system memory map 4 end address low (address bits 19-12)
 33h	system memory map 4 end address high (see #P0833)
 34h	card memory map 4 offset address low (address bits 19-12)
 35h	card memory map 4 offset address high (see #P0834)
 36h	card I/O map 0 offset address low (see #P0840)
 37h	card I/O map 0 offset address high (address bits 15-8)
 38h	card I/O map 1 offset address low (see #P0840)
 39h	card I/O map 1 offset address high (address bits 15-8)
 3Ah	setup timing 0 (see #P0841)
 3Bh	command timing 0 (see #P0841)
 3Ch	recovery timing 0 (see #P0841)
 3Dh	setup timing 1 (see #P0841)
 3Eh	command timing 1 (see #P0841)
 3Fh	recovery timing 1 (see #P0841)
SeeAlso: #P0822

Bitfields for Cirrus Logic CL-PD6710/6722/6729 chip revision:
Bit(s)	Description	(Table P0824)
 7-6	interface ID (read-only)
	00 = I/O only
	01 = memory only
	10 = I/O and memory
	11 = reserved
 5-4	reserved (read-only)
 3-0	revision (read-only)
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 interface status:
Bit(s)	Description	(Table P0825)
 7	-VPP_VALID pin status
	0 = -VPP_VALID high
	1 = -VPP_VALID low (asserted)
	(CL-PD6729) reserved (1)
 6	card power on
 5	(memory card) ready
 4	(memory card) write protect
 3-2	card detect status
	00 = no card or card not fully inserted
	01 = card not fully inserted
	10 = card not fully inserted
	11 = card fully inserted
 1-0	(memory card) battery voltage
	00 = card data lost
	01 = battery low warning
	10 = card data lost
	11 = battery/data ok
	(I/O card) status change (ignore bit 1)
Note:	this register is read-only
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 power control:
Bit(s)	Description	(Table P0826)
 7	card enable (if card present (register 01h bits 3-2 = 11) and power
	  supplied (bit 4 = 1))
 6	reserved (82365SL compatibility)
 5	auto-power enable
 4	Vcc power on (if bit 5 = 0, or bit 5 = 1 and register 01h
	  bits 3-2 = 11) (voltage selected by register 16h bit 1)
 3-2	reserved (82365SL compatibility)
 1-0	Vpp1 power
	00 = zero V
	01 = selected card Vcc
	10 = +12V
	11 = zero V
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 interrupt and general control:
Bit(s)	Description	(Table P0827)
 7	(I/O card) ring indicate enable
 6	card reset signal
	0 = active
	1 = inactive
 5	card interface mode
	0 = memory card
	1 = I/O card
 4	management interrupt
	0 = selected by register 05h bits 7-4
	1 = redirected to -INTR line
	    (CL-PD6729) reserved
 3-0	card IRQ select
	0000 = IRQ disabled
	0001-0010 = reserved
	0011-0101 = IRQ3-IRQ5 (INTA#-INTC# on CL-PD6729)
	0110 = reserved
	0111 = IRQ7 (INTD# on CL-PD6729)
	1000 = reserved
	1001 = IRQ9 (may be used as ISA bus DACK on CL-PD6722)
	1010 = IRQ10 (may be used as ISA bus DRQ on CL-PD6722)
	1011 = IRQ11
	1100 = IRQ12 (may be used for LED on CL-PD6710/6722)
	1101 = reserved
	1110 = IRQ14 (may be used as external clock input on CL-PD6729)
	1111 = IRQ15 (may be used as ring indicate output)
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 card status change:
Bit(s)	Description	(Table P0828)
 7-4	reserved (0)
 3	card detect change
 2	ready change (always 0 for I/O card)
 1	battery warning change (ignore on I/O card)
 0	(memory card) battery dead change
	(I/O card) status change
Note:	reading this read-only register resets all bits to 0
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 management interrupt config:
Bit(s)	Description	(Table P0829)
 7-4	management IRQ
	0000 = IRQ disabled
	0001-0010 = reserved
	0011-0101 = IRQ3-IRQ5 (INTA#-INTC# on CL-PD6729)
	0110 = reserved
	0111 = IRQ7 (INTD# on CL-PD6729)
	1000 = reserved
	1001 = IRQ9 (on CL-PD6722 may be used as ISA bus DACK)
	1010 = IRQ10 (on CL-PD6722 may be used as ISA bus DRQ)
	1011 = IRQ11
	1100 = IRQ12 (on CL-PD6710/6722 may be used for LED)
	1101 = reserved
	1110 = IRQ14 (on CL-PD6729 may be used as external clock input)
	1111 = IRQ15 (may be used as ring indicate output)
 3	management interrupt on card detect change enable
 2	management interrupt on ready change enable
 1	management interrupt on battery warning change enable (ignored on
	  I/O card)
 0	(memory card) management interrupt on battery dead change enable
	(I/O card) management interrupt on status change enable
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 mapping enable:
Bit(s)	Description	(Table P0830)
 7	I/O map 1 enable
 6	I/O map 0 enable
 5	reserved (82365SL compatibility: MEMCS16 full decode)
 4	memory map 4 enable
 3	memory map 3 enable
 2	memory map 2 enable
 1	memory map 1 enable
 0	memory map 0 enable
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 I/O window control:
Bit(s)	Description	(Table P0831)
 7	timing register select 1
	0 = accesses made with timings specified in timer set 0
	1 = accesses made with timings specified in timer set 1
 6	reserved (82365SL compatibility)
 5	I/O window 1 auto-size enable (size determined by -IOIS16 signal) (set
	  for proper ATA operation)
 4	I/O window 1 size (if bit 5 = 0)
	0 = 8-bit data path
	1 = 16-bit data path
 3	timing register select 0 (same values as bit 7)
 2	reserved (82365SL compatibility)
 1	I/O window 0 auto-size enable (size determined by -IOIS16 signal)
 0	I/O window 0 size (if bit 1 = 0) (same values as bit 4)
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 system memory map start high:
Bit(s)	Description	(Table P0832)
 7	window data size
	0 = 8-bit
	1 = 16-bit
 6	reserved (82365SL compatibility)
 5-4	scratchpad
 3-0	start address bits 23-20
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 system memory map end high:
Bit(s)	Description	(Table P0833)
 7-6	card timer
	00 = timer set 0
	01-11 = timer set 1
 5-4	scratchpad
 3-0	end address bits 23-20
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 card memory map offset high:
Bit(s)	Description	(Table P0834)
 7	window write protect enable
 6	-REG active for window accesses
 5-0	offset address bits 25-20
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 misc control 1:
Bit(s)	Description	(Table P0835)
 7	INPACK enable (no effect on CL-PD6729)
 6-5	scratchpad
 4	speaker enable
 3	system IRQ triggering
	0 = level
	1 = pulse
 2	management interrupt triggering (as for bit 3)
 1	Vcc voltage
	0 = 5V
	1 = 3.3V
 0	(CL-PD6710) voltage detect
	0 = 3.3V card detected
	0 = old or 5V card detected
	(CL-PD6722) reserved (A_GPSTB/B_GPSTB level read on some versions)
	(CL-PD6729) multimedia enable (tri-state socket address lines A25-4)
	  (register 2Fh extended index 25h bit 7 must be 1)
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 FIFO control:
Bit(s)	Description	(Table P0836)
 7	(read) FIFO status
	0 = data in FIFO
	1 = FIFO empty
	(write) FIFO flush
	0 = no operation
	1 = flush FIFO
 6-0	scratchpad
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 misc control 2:
Bit(s)	Description	(Table P0837)
 7	IRQ15 connected to ring indicate pin
 6	(CL-PD6710/6729) reserved
	(CL-PD6722) DMA system enable
 5	floppy change bit compatibility enable (tri-state bit 7 of socket I/O
	  at addresses 3F7h and 377h)
	(CL-PD6729) reserved
 4	drive LED enable (should be set to 0 in memory card interface mode)
	(CL-PD6729) reserved
 3	core voltage
	0 = 3.3V
	1 = 5V
 2	suspend mode enable
 1	low-power dynamic mode
	0 = clock always runs
	1 = stop clock when possible (normal operation)
 0	frequency synthesizer bypass
	0 = internal clock = CLK input * 7/4 (normal operation)
	1 = internal clock = CLK input
	(CL-PD6729) external clock enable
	0 = internal clock = PCI_CLK input / 2
	1 = internal clock = IRQ14/EXT_CLK / 2
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 chip information:
Bit(s)	Description	(Table P0838)
 7-6	Cirrus Logic host-adapter identification (read-only)
	00 = second read after I/O write to this register
	11 = first read after I/O write to this register
 5-0	(CL-PD6729) CL-PD6729 revision (read-only)
	21h = register 2Fh extended indexes 34h-3Bh indicate chip revision and
	  features
 5	(CL-PD6710/6722) CL-PD67xx sockets (read-only)
	0 = single (CL-PD6710)
	1 = dual (CL-PD6722)
 4-1	(CL-PD6710/6722) CL-PD67xx revision (read-only)
 0	(CL-PD6710) reserved (0) (read-only)
	(CL-PD6722) reserved (1) (read-only)
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 ATA control:
Bit(s)	Description	(Table P0839)
 7	(ATA mode) A25 / CSEL pin value (vendor specific)
 6	(ATA mode) A24 / M/S pin value (vendor specific)
 5	(ATA mode) A23 / VU pin value (vendor specific)
 4	(ATA mode) A22 pin value (vendor specific)
 3	(ATA mode) A21 pin value (vendor specific)
 2	scratchpad
 1	speaker is LED input (if register 1Eh bit 4 = 1) (should be set to 0
	  in memory card interface mode)
	(CL-PD6729) speaker is LED input (if register 2Fh extended index 03h
	  bit 4 = 1) (should be set to 0 in memory card interface mode)
 0	ATA mode enable
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 card I/O map offset address low:
Bit(s)	Description	(Table P0840)
 7-1	offset address bits 7-1
 0	reserved (must be 0)
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6710/6722/6729 setup/command/recovery timing:
Bit(s)	Description	(Table P0841)
 7-6	prescaler
	00 = 1
	01 = 16
	10 = 256
	11 = (CL-PD6710/6722) 8192
	     (CL-PD6729) 4096
 5-0	multiplier value
Notes:	internal clock cycles = (prescalar * multiplier) + 1
	changes take effect immediately and should only be changed when FIFO
	  is empty (register 17h bit 7 = 1)
SeeAlso: #P0823

(Table P0842)
Values for Cirrus Logic CL-PD6722/6729 extended index:
 00h	scratchpad
 01h	(CL-PD6722) data mask 0 (see #P0843)
	(CL-PD6729) reserved
 02h	(CL-PD6722) data mask 1 (see #P0843)
	(CL-PD6729) reserved
 03h	extension control 1 (see #P0844)
 04h	(CL-PD6722) maximum DMA acknowledge delay (see #P0845)
	(CL-PD6729) reserved
 05h-09h (CL-PD6722) reserved
 05h	(CL-PD6729) system memory map 0 upper address (start/end address
	  bits 31-24)
 06h	(CL-PD6729) system memory map 1 upper address (start/end address
	  bits 31-24)
 07h	(CL-PD6729) system memory map 2 upper address (start/end address
	  bits 31-24)
 08h	(CL-PD6729) system memory map 3 upper address (start/end address
	  bits 31-24)
 09h	(CL-PD6729) system memory map 4 upper address (start/end address
	  bits 31-24)
 0Ah	(CL-PD6722) external data (see #P0846)
	(CL-PD6729 socket B) external data (see #P0847)
 0Bh	(CL-PD6722) extension control 2 (see #P0848)
 25h	(CL-PD6729) misc. control 3 (see #P0849)
---CL-PD6729 socket A---
 34h	mask revision byte (read-only)
 35h	product ID byte (read-only) (see #P0850)
 36h	device capability byte A (read-only) (see #P0851)
 37h	device capability byte B (read-only) (see #P0852)
 38h	device implementation byte A (see #P0853)
 39h	device implementation byte B (see #P0854)
 3Ah	device implementation byte C (see #P0855)
 3Bh	device implementation byte D (see #P0856)
SeeAlso: #P0823

Bitfields for Cirrus Logic CL-PD6722 data mask:
Bit(s)	Description	(Table P0843)
 7-0	data mask for corresponding I/O map
	0 = no mask
	1 = mask corresponding bit from data
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6722/6729 extension control 1:
Bit(s)	Description	(Table P0844)
 7-6	(CL-PD6722) DMA mode
	00 = disabled
	01 = enabled, INPACK used as active-low DREQ input
	10 = enabled, WP/IOIS16 used as active-low DREQ input
	11 = enabled, BVD2/SPKR used as active-low DREQ input
	(CL-PD6729) reserved
 5	pull-ups disable
 4-3	(CL-PD6722) reserved
 4	(CL-PD6729) management IRQ output invert
	0 = management IRQ is active-high
	1 = management IRQ is active-low and open-drain
 3	(CL-PD6729) card IRQ output invert
	0 = card IRQ is active-high
	1 = card IRQ is active-low and open-drain
 2	LED activity enable
 1	auto power clear disable (register 02h bit 4 is not cleared when card
	  is removed)
 0	Vcc power bit (register 02h bit 4) lock enable
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6722 maximum DMA acknowledge delay:
Bit(s)	Description	(Table P0845)
 7-0	maximum DMA acknowledge delay
	10h = 14 clocks
	20h = 10 clocks
	30h = 18 clocks
	40h = 8 clocks
	50h = 16 clocks
	60h = 12 clocks
	80h = 7 clocks
	90h = 15 clocks
	A0h = 11 clocks
	B0h = 19 clocks
	C0h = 9 clocks
	D0h = 17 clocks
	E0h = 13 clocks
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6722 external data (socket A):
Bit(s)	Description	(Table P0846)
--- register 2Fh extended index 0Bh bits 4-3 = 00 ---
 7-0	(socket A) scratchpad
 7-4	(socket B) scratchpad
 3	(socket B) socket B VS2# input level (read-only)
 2	(socket B) socket B VS1# input level (read-only)
 1	(socket B) socket A VS2# input level (read-only)
 0	(socket B) socket A VS1# input level (read-only)
--- register 2Fh extended index 0Bh bits 4-3 = 01 ---
 7-0	external read port
--- register 2Fh extended index 0Bh bits 4-3 = 10 ---
 7-0	external write port (read returns value written)
--- register 2Fh extended index 0Bh bits 4-3 = 10 ---
 7-0	reserved
------
Note:	for software compatibility this register should only be used as write
	  port, and bits 7-4 should be ignored
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6729 external data:
Bit(s)	Description	(Table P0847)
 7-4	reserved
 3	socket B VS2# input level (read-only)
 2	socket B VS1# input level (read-only)
 1	socket A VS2# input level (read-only)
 0	socket A VS1# input level (read-only)
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6722 extension control 2:
Bit(s)	Description	(Table P0848)
 7-6	reserved (0)
 5	GPSTB output
	0 = active-low
	1 = active-high
 4	GPSTB on IOW
	0 = A_GPSTB used as voltage sense
	1 = A_GPSTB used to strobe I/O writes on SD15-8
 3	GPSTB on IOR
	0 = B_GPSTB used as voltage sense
	1 = B_GPSTB used to strobe I/O writes on SD15-8
 2	totem-pole GPSTB
	0 = GPSTB outputs are open-collector
	1 = GPSTB outputs are totem-pole (high level driven to +5V pin level
	  instead of high-impedance)
 1-0	reserved (0)
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6729 misc. control 3:
Bit(s)	Description	(Table P0849)
 7	multimedia arm enable
 6	multimedia expand enable (allows 24-bit video)
 5-0	reserved
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6729 product ID byte:
Bit(s)	Description	(Table P0850)
 7-4	family code (read-only)
	2h = CL-PD6729 family
 3-0	product code (read-only)
--- family code = 2h ---
	0h = CL-PD6729 PCI/PCMCIA controller, dual isolated sockets, 208 pin
	1h-Fh = reserved
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6729 device capability byte A:
Bit(s)	Description	(Table P0851)
 7	output LEDs (read-only)
	0 = single LED
	1 = LED per socket
 6	reserved (read-only)
 5	general purpose strobe (GPSTB) capable (read-only)
 4	reserved (read-only)
 3	DMA slave (read-only)
 2	IDE interface (read-only)
 1-0	number of sockets (read-only)
	00 = two
Note:	CL-PD6729 does not support GPSTB even if bit 5 = 1
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6729 device capability byte B:
Bit(s)	Description	(Table P0852)
 7	extended definitions (read-only)
	0 = not available (device capability and implementation definitions
	  stop to extended register 3Bh)
 6-3	reserved (read-only)
 2	CLKRUN support (read-only)
 1	LOCK# support (read-only)
 0	CardBus transfer cycle support (read-only)
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6729 device implementation byte A:
Bit(s)	Description	(Table P0853)
 7	RI_OUT wired to ring indicate circuitry
 6	hardware suspend wired to power management circuitry
 5	GBSTB B wired
 4	GBSTB A wired
 3	VS1/VS2 wired
 2	slave DMA wired
 1	sockets present 1
 0	sockets present 0
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6729 device implementation byte B:
Bit(s)	Description	(Table P0854)
 7	reserved
 6	radio frequency rated sockets
 5	VPP_VCC 1A capable
 4	VPP 12V support
 3	x.xV capable
 2	y.yV capable
 1	5.0V capable
 0	3.3V capable
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6729 device implementation byte C:
Bit(s)	Description	(Table P0855)
 7-5	reserved
 4	socket B wired for ZV operation
 3	socket A wired for ZV operation
 2	speaker wired to SPKR_OUT
 1	separate status LED for each socket
 0	status LED wired to LED_OUT#
SeeAlso: #P0842

Bitfields for Cirrus Logic CL-PD6729 device implementation byte D:
Bit(s)	Description	(Table P0856)
 7	reserved
 6	external clock wired to EXT_CLK
 5-2	reserved
 1	LOCK# wired
 0	CLKRUN wired
SeeAlso: #P0842
----------P03E003E7--------------------------
PORT 03E0-03E7	- LPT port address on the UniRAM card by German magazine c't
Range:	selectable from PORT 0260h, PORT 02E0h, PORT 02E8h, PORT 02F0h,
	  PORT 03E0h, or PORT 03E8h.
SeeAlso: PORT 03E8h"UniRAM"
----------P03E003E7--------------------------
PORT 03E0-03E7 - COM port addresses on UniRAM card by German magazine c't
Range:	selectable from PORT 0238h, PORT 02E8h, PORT 02F8h, PORT 0338h,
	  PORT 03E0h, PORT 03E8h, or PORT 03F8h
SeeAlso: PORT 03E0h"UniRAM"
----------P03E203E3--------------------------
PORT 03E2-03E3 - OPTi 82C824 - CardBus Bridge registers
Range:	PORT 03E0h or PORT 03E2h
SeeAlso: PORT 03E0h"CardBus"

03E2  ?W  index for data register
03E3  RW  CardBus registers
----------P03E803EF--------------------------
PORT 03E8-03EF - serial port, same as 02E8, 02F8 and 03F8 (COM3)
SeeAlso: PORT 03F8h-03FFh
----------P03E803EF--------------------------
PORT 03E8-03EF - COM port addresses on UniRAM card by German magazine c't
Range:	selectable from PORT 0238h, PORT 02E8h, PORT 02F8h, PORT 0338h,
	  PORT 03E0h, PORT 03E8h, or PORT 03F8h
SeeAlso: PORT 03E0h"UniRAM"
----------P03E803EF--------------------------
PORT 03E8-03EF - LPT port address on the UniRAM card by German magazine c't
Range:	selectable from PORT 0260h, PORT 02E0h, PORT 02E8h, PORT 02F0h,
	  PORT 03E0h, or PORT 03E8h.
SeeAlso: PORT 03E8h"UniRAM"
----------P03EB------------------------------
PORT 03EB - GI1904 Scanner Interface Adapter
Range:	PORT 022Bh, PORT 026Bh, PORT 02ABh (default), PORT 02EBh, PORT 032Bh,
	  PORT 036Bh, PORT 03ABh
----------P03EC------------------------------
PORT 03EC - GS-IF Scanner Interface adapter
Range:	PORT 022Ch, PORT 026Ch, PORT 02ACh, PORT 02ECh (default),
	  PORT 032Ch, PORT 036Ch, PORT 03ACh, PORT 03ECh
Note:	many SPI 400dpi/800dpi gray / H/T handy scanner by Marstek, Mustek and
	  others use this interface
----------P03F003F7--------------------------
PORT 03F0-03F7 - FDC 1	(1st Floppy Disk Controller)	second FDC at 0370
Note:	floppy disk controller is usually an 8272, 8272A, NEC765 (or
	  compatible), or an 82072 or 82077AA for perpendicular recording at
	  2.88M
SeeAlso: PORT 0370h-0377h

03F0  R-  diskette controller status A (PS/2) (see #P0857)
03F0  R-  diskette controller status A (PS/2 model 30) (see #P0858)
03F0  R-  diskette EHD controller board jumper settings (82072AA) (see #P0859)
03F1  R-  diskette controller status B (PS/2) (see #P0860)
03F1  R-  diskette controller status B (PS/2 model 30) (see #P0861)
03F2  -W  diskette controller DOR (Digital Output Register) (see #P0862)
03F3  ?W  tape drive register (on the 82077AA)
	bit 7-2	 reserved, tri-state
	bit 1-0	 tape select
		=00  none, drive 0 cannot be a tape drive.
		=01  drive1
		=10  drive2
		=11  drive3
03F4  R-  diskette controller main status register (see #P0865)
	Note:	in non-DMA mode, all data transfers occur through
		  PORT 03F5h and the status registers (bit 5 here
		  indicates data read/write rather than than
		  command/status read/write)
03F4  -W  diskette controller data rate select register (see #P0866)
03F5  R-  diskette command/data register 0 (ST0) (see #P0867)
	status register 1 (ST1) (see #P0868)
	status register 2 (ST2) (see #P0869)
	status register 3 (ST3) (see #P0870)
03F5  -W  diskette command register.  The commands summarized here are
	  mostly multibyte commands. This is for brief recognition only.
	  (see #P0873)
03F6  --  reserved on FDC
03F6  rW  FIXED disk controller data register (see #P0871)
03F7  RW  harddisk controller (see #P0872)
03F7  R-  diskette controller DIR (Digital Input Register, PC/AT mode)
		 bit 7 = 1 diskette change
		 bit 6-0   tri-state on FDC
03F7  R-  diskette controller DIR (Digital Input Register, PS/2 mode)
	  (see #P0863)
03F7  R-  diskette controller DIR (Digital Input Register, PS/2 model 30)
	  (see #P0864)
03F7  -W  configuration control register (PC/AT, PS/2)
		 bit 7-2       reserved, tri-state
		 bit 1-0 = 00  500 Kb/S mode (MFM)
			 = 01  300 Kb/S mode (MFM)
			 = 10  250 Kb/S mode (MFM)
			 = 11  1   Mb/S mode (MFM) (on 82072/82077AA)
	conflict bit 0	   FIXED DISK drive 0 select
03F7  -W  configuration control register (PS/2 model 30)
		 bit 7-3       reserved, tri-state
		 bit 2	       NOPREC (has no function. set to 0 by hardreset)
		 bit 1-0 = 00  500 Kb/S mode (MFM)
			 = 01  300 Kb/S mode (MFM)
			 = 10  250 Kb/S mode (MFM)
			 = 11  1   Mb/S mode (MFM) (on 82072/82077AA)
	conflict bit 0	   FIXED DISK drive 0 select

Bitfields for diskette controller status A (PS/2):
Bit(s)	Description	(Table P0857)
 7	interrupt pending
 6	-DRV2	second drive installed
 5	step
 4	-track 0
 3	head 1 select
 2	-index
 1	-write protect
 0	+direction
SeeAlso: #P0858,#P0860

Bitfields for diskette controller status A (PS/2 model 30):
Bit(s)	Description	(Table P0858)
 7	interrupt pending
 6	DRQ
 5	step F/F
 4	-track 0
 3	head 1 select
 2	+index
 1	+write protect
 0	-direction
SeeAlso: #P0857,#P0859,#P0861

Bitfields for diskette EHD controller board jumper settings:
Bit(s)	Description	(Table P0859)
 7-6	drive 3
 5-4	drive 2
 3-2	drive 1
 1-0	drive 0
	 00  1.2Mb
	 01  720Kb
	 10  2.8Mb
	 11  1.4Mb
SeeAlso: #P0857

Bitfields for diskette controller status B (PS/2):
Bit(s)	Description	(Table P0860)
 7-6	reserved (1)
 5	drive select (0=A:, 1=B:)
 4	write data
 3	read data
 2	write enable
 1	motor enable 1
 0	motor enable 0
SeeAlso: #P0857,#P0861

Bitfields for diskette controller status B (PS/2 model 30):
Bit(s)	Description	(Table P0861)
 7	-DRV2 second drive installed
 6	-DS1
 5	-DS0
 4	write data F/F
 3	read data F/F
 2	write enable F/F
 1	-DS3
 0	-DS2
SeeAlso: #P0858,#P0860

Bitfields for diskette controller Digital Output Register (DOR):
Bit(s)	Description	(Table P0862)
 7-6	reserved on PS/2
 7	drive 3 motor enable
 6	drive 2 motor enable
 5	drive 1 motor enable
 4	drive 0 motor enable
 3	diskette DMA enable (reserved PS/2)
 2	=1  FDC enable	(controller reset)
	=0  hold FDC at reset
 1-0	drive select (0=A 1=B ..)
SeeAlso: #P0857,#P0865,#P0866,#P0863

Bitfields for diskette controller Digital Input Register (PS/2 mode):
Bit(s)	Description	(Table P0863)
 7	= 1 diskette change
 6-3	= 1
 2	datarate select1
 1	datarate select0
 0	= 0 high density select (500Kb/s, 1Mb/s)
 0	(conflict) FIXED DISK drive 0 select
SeeAlso: #P0864,#P0862

Bitfields for diskette controller Digital Input Register (PS/2 model 30):
Bit(s)	Description	(Table P0864)
 7	= 0 diskette change
 6-4	= 0
 3	-DMA gate (value from DOR register)
 2	NOPREC (value from CCR register)
 1	datarate select1
 0	datarate select0
 0	(conflict) FIXED DISK drive 0 select
SeeAlso: #P0863

Bitfields for diskette controller main status register:
Bit(s)	Description	(Table P0865)
 7	=1  RQM	 data register is ready
	=0  no access is permitted
 6	=1  transfer is from controller to system
	=0  transfer is from system to controller
 5	non-DMA mode
 4	diskette controller is busy
 3	drive 3 busy (reserved on PS/2)
 2	drive 2 busy (reserved on PS/2)
 1	drive 1 busy (= drive is in seek mode)
 0	drive 0 busy (= drive is in seek mode)
SeeAlso: #P0862

Bitfields for diskette controller data rate select register:
Bit(s)	Description	(Table P0866)
 7-2	reserved on 8272
 7	software reset (self clearing)	82072/82077AA
 6	power down			82072/82077AA
 5	(8272/82077AA) reserved (0)
	(82072) PLL select bit
 4-2	write precompensation value, 000 default
 1-0	data rate select
	=00  500 Kb/S MFM	250 Kb/S FM
	=01  300 Kb/S MFM	150 Kb/S FM
	=10  250 Kb/S MFM	125 Kb/S FM
	=11  1Mb/S	MFM	illegal	 FM on 8207x
SeeAlso: #P0862

Bitfields for diskette command/data register 0 (ST0):
Bit(s)	Description	(Table P0867)
 7-6	last command status
	00  command terminated successfully
	01  command terminated abnormally
	10  invalid command
	11  terminated abnormally by change in ready signal
 5	seek completed
 4	equipment check occurred after error
 3	not ready
 2	head number at interrupt
 1-0	unit select (0=A 1=B .. ) (on PS/2: 01=A  10=B)
SeeAlso: #P0868,#P0869,#P0870

Bitfields for diskette status register 1 (ST1):
Bit(s)	Description	(Table P0868)
 7	end of cylinder; sector# greater then sectors/track
 6	=0
 5	CRC error in ID or data field
 4	overrun
 3	=0
 2	sector ID not found
 1	write protect detected during write
 0	ID address mark not found
SeeAlso: #P0867,#P0869,#P0870

Bitfields for diskette status register 2 (ST2):
Bit(s)	Description	(Table P0869)
 7	=0
 6	deleted Data Address Mark detected
 5	CRC error in data
 4	wrong cylinder detected
 3	scan command equal condition satisfied
 2	scan command failed, sector not found
 1	bad cylinder, ID not found
 0	missing Data Address Mark
SeeAlso: #P0867,#P0868,#P0870

Bitfields for diskette status register 3 (ST3):
Bit(s)	Description	(Table P0870)
 7	fault status signal
 6	write protect status
 5	ready status
 4	track zero status
 3	two sided status signal
 2	side select (head select)
 1-0	unit select (0=A 1=B .. )
SeeAlso: #P0867,#P0868,#P0869

Bitfields for fixed disk controller data register:
Bit(s)	Description	(Table P0871)
 7-4	reserved
 3	=0  reduce write current
	=1  head select 3 enable
 2	disk reset enable
 1	disk initialization disable
 0	reserved
SeeAlso: #P0862,#P0872

Bitfields for hard disk controller:
Bit(s)	Description	(Table P0872)
 6	FIXED DISK write gate
 5	FIXED DISK head select 3 / reduced write current
 4	FIXED DISK head select 2
 3	FIXED DISK head select 1
 2	FIXED DISK head select 0
 1	FIXED DISK drive 1 select
 0	FIXED DISK drive 0 select
SeeAlso: #P0871

(Table P0873)
Values for diskette commands:
	MFM = MFM mode selected, opposite of MF mode
	HDS = head select
	DS  = drive select
	MT  = multi track operation
	SK  = skip deleted data address mark
   Command	     # bytes	D7  6	5   4	3   2	1   0
 read track		9	0  MFM	0   0	0   0	1   0
				0   0	0   0	0 HDS DS1 DS0
 specify		3	0   0	0   O	O   O	1   1
 sense drive status	2	0   0	0   0	0   1	0   0
				0   0	0   0	0 HDS DS1 DS0
 write data		9	MT MFM	0   0	0   1	0   1
				0   0	0   0	0 HDS DS1 DS0
 read data		9	MT MFM SK   0	0   1	1   0
				0   0	0   0	0 HDS DS1 DS0
 recalibrate		2	0   0	0   0	0   1	1   1
				0   0	0   0	0   0 DS1 DS0
 sense interrupt status 1	0   0	0   0	1   0	0   0
 write deleted data	9	MT MFM	0   0	1   0	0   1
				0   0	0   0	0 HDS DS1 DS0
 read ID		2	0  MFM	0   0	1   0	1   0
				0   0	0   0	0 HDS DS1 DS0
 read deleted data	9	MT MFM SK   0	1   1	0   0
				0   0	0   0	0 HDS DS1 DS0
 format track		10	0  MFM	0   0	1   1	0   1
				0   0	0   0	0 HDS DS1 DS0
 dumpreg **		1	0   0	0   0	1   1	1   0
 seek			3	0   0	0   0	1   1	1   1
				0   0	0   0	0 HDS DS1 DS0
 version** (see #P0874) 1	0   0	0   1	0   0	0   0
 scan equal *		9	MT MFM SK   1	0   0	0   1
				0   0	0   0	0 HDS DS1 DS0
 perpendicular mode **	2	0   0	0   1	0   0	1   0
				0   0	0   0	0   0 WGATE GAP
 configure **		4	0   0	0   1	0   0	1   1
				0   0	0   0	0   0	0   0
 unlock FIFO **		1	0   0	0   1	0   1	0   0
 verify			9	MT MFM SK   1	0   1	1   0
				EC  0	0   0	0 HDS DS1 DS0
 partid ** (see #P0874) 1	0   0	0   1	1   0	0   0
 scan low or equal *	9	MT MFM SK   1	1   0	0   1
				0   0	0   0	0 HDS DS1 DS0
 scan high or equal *	9	MT MFM SK   1	1   1	0   1
				0   0	0   0	0 HDS DS1 DS0
 exit standby mode ***	1	0   0	1   1	0   1	0   0
 enter standby mode ***	1	0   0	1   1	0   1	0   1
 hard reset ***		1	0   0	1   1	0   1	1   0
 lock FIFO **		1	1   0	0   1	0   1	0   0
 relative seek **	3	1  DIR	0   0	1   1	1   1
				0   0	0   0	0 HDS DS1 DS0
BEWARE: not every invalid command is treated as invalid!
 *   Note: the scan commands aren't mentioned for the 82077AA.
 **  Note: EHD controller commands.
 *** Note: Supported by NEC72065B only.

(Table P0874)
Values for FDC Controller chip type identification:
  version lFIFO partid Chip type
    80h	   80h	  -    NEC D765, Intel 8272A or compatible
    80h	   00h	  -    Intel 82072
    81h	    -	  -    Very Early Intel 82077 or compatible
    90h	   80h	  -    Old Intel 82077, no FIFO
    90h	    ?	  ?    NEC 72065B
    90h	   00h	 80h   New Intel 82077 (82077AA if port 3x3h bits 1-0 are R/W)
    90h	   00h	 41h   Intel 82078
    90h	   00h	 73h   National Semiconductor PC87306
    90h	   00h	other  Intel 82078 compatible
    A0h	    -	  -    SMC FDC37c65C+
Note:	Before issuing the partid command, one must first issue an unlock
	  FIFO, immediately followed by a lock FIFO instruction. The status
	  byte returned by the lock FIFO instruction is used in the table above
SeeAlso: #P0873
----------P03F003F1--------------------------
PORT 03F0-03F1 - PCTech RZ1000 IDE controller
Note:	to unlock access to these ports instead of the standard floppy
	  controller status ports at these two addresses, you must perform
	  two immediately successive 8-bit OUTs of 55h to PORT 03F0h (there
	  is a fairly small time limit between the two accesses, so there
	  should be no other instructions between the two OUTs); after
	  that, values written to PORT 03F0h select the data accessed through
	  PORT 03F1h until an AAh is written to 03F0h
SeeAlso: #00732

03F0  ?W  index port (see #P0875)
03F1  RW  data port

(Table P0875)
Values for RZ1000 IDE controller registers:
 00h	???
	bit 7:
	bit 1:
	bit 0:
 01h	???
 02h	???
 03h	???
 04h	???
 05h	???
	bit 1:
 AAh	lock control port
----------P03F803FF--------------------------
PORT 03F8-03FF - Serial port (8250,8250A,8251,16450,16550,16550A,etc.) COM1
Range:	PORT 02E8h-02EFh (COM2), PORT 02F8h-02FFh (typical non-PS/2 COM3), and
	  PORT 03E8h-03EFh (typical non-PS/2 COM4)
Note:	chips overview:
	 8250  original PC, specified up to 56Kbd, but mostly runs
	       only 9600Bd, no scratchregister, bug: sometimes shots
	       ints without reasons
	 8250A, 16450, 16C451: ATs, most chips run up to 115KBd,
	       no bug: shots no causeless ints
	 8250B: PC,XT,AT, pseudo bug: shots one causeless int for
		compatibility with 8250, runs up to 56KBd
	 16550, 16550N, 16550V: early PS/2, FIFO bugs
	 16550A,16550AF,16550AFN,16550C,16C551,16C552: PS/2, FIFO ok
	 82510: laptops & industry, multi emulation mode
		(default=16450), special-FIFO.
	 8251: completely different synchronous SIO chip, not compatible!
SeeAlso: INT 14/AH=00h"SERIAL"

03F8  -W  serial port, transmitter holding register (THR), which contains the
	  character to be sent. Bit 0 is sent first.
		bit 7-0	  data bits when DLAB=0 (Divisor Latch Access Bit)
03F8  R-  receiver buffer register (RBR), which contains the received
	  character. Bit 0 is received first
		 bit 7-0   data bits when DLAB=0 (Divisor Latch Access Bit)
03F8  RW  divisor latch low byte (DLL) when DLAB=1 (see #P0876)
03F9  RW  divisor latch high byte (DLM) when DLAB=1 (see #P0876)
03F9  RW  interrupt enable register (IER) when DLAB=0 (see #P0877)
03FA  R-  interrupt identification register (see #P0878)
	Information about a pending interrupt is stored here. When the ID
	  register is addressed, thehighest priority interrupt is held, and
	  no other interrupts are acknowledged until the CPU services that
	  interrupt.
03FA  -W  16650 FIFO Control Register (FCR) (see #P0879)
03FB  RW  line control register (LCR) (see #P0880)
03FC  RW  modem control register (see #P0881)
03FD  R-  line status register (LSR) (see #P0882)
03FE  R-  modem status register (MSR) (see #P0883)
03FF  RW  scratch register (SCR)
	(not used for serial I/O; available to any application using 16450,
	  16550) (not present on original 8250)

(Table P0876)
Values for serial port divisor latch registers:
 Some baudrates (using standard 1.8432 Mhz clock):
       baudrate	   divisor	 DLM  DLL
	    50	   2304		  09h 00h
	    75	   1536		  06h 00h
	   110	   1047		  04h 17h
	   134,5    857		  03h 59h
	   150	    768		  03h 00h
	   300	    384		  01h 80h
	   600	    192		  00h C0h
	  1200	     96		  00h 60h
	  1800	     64		  00h 40h
	  2000	     58		  00h 3Ah
	  2400	     48		  00h 30h
	  3600	     32		  00h 20h
	  4800	     24		  00h 18h
	  7200	     16		  00h 10h
	  9600	     12		  00h 0Ch
	 19200	      6		  00h 06h
	 38400	      3		  00h 03h
	 57600	      2		  00h 02h
	115200	      1		  00h 01h
Note:	MIDI baudrate 32250Bd with 4Mhz quarz for c't MIDI interface
	  following c't 01/1991:   '14400'	  00h 08h

Bitfields for serial port interrupt enable register (IER):
Bit(s)	Description	(Table P0877)
 7-6	reserved (0)
 5	(82510) "timer"
	(other) reserved (0)
 4	(82510) "transmit machine"
	(other) reserved (0)
 3	modem-status interrupt enable
 2	receiver-line-status interrupt enable
 1	transmitter-holding-register empty interrupt enable
 0	received-data-available interrupt enable
	  (also 16550(A) timeout interrupt)
Note:	16550(A) will interrupt with a timeout if data exists in the FIFO
	  and isn't read within the time it takes to receive four bytes or if
	  no data is received within the time it takes to receive four bytes
SeeAlso: #P0878

Bitfields for serial port interrupt identification register (IIR):
Bit(s)	Description	(Table P0878)
 7-6	=00  reserved on 8250, 8251, 16450
	=01  if FIFO queues enabled but unusable (16550 only)
	=11  if FIFO queues are enabled (16550A only) (see also #P0879)
 6-5	used by 82510 for bank select (00 = default bank0)
 5-4	reserved (0)
 3-1	identify pending interrupt with the highest priority
	110	(16550,82510) timeout interrupt pending
	101	(82510) timer interrupt (see #P0877)
	100	(82510) transmit machine (see #P0877)
	011	receiver line status interrupt. priority=highest
	010	received data available register interrupt. pr.=second
	001	transmitter holding register empty interrupt. pr.=third
	000	modem status interrupt. priority=fourth
 0	=0 interrupt pending. contents of register can be used as a pointer
	  to the appropriate interrupt service routine
	=1 no interrupt pending
Notes:	interrupt pending flag uses reverse logic, 0=pending, 1=none
	interrupt will occur if any of the line status bits are set
	THRE bit is set when THRE register is emptied into the TSR
SeeAlso: #P0877

Bitfields for serial port FIFO control register (FCR):
Bit(s)	Description	(Table P0879)
 7-6	received data available interrupt trigger level (16550)
	00  1 byte
	01  4 bytes
	10  8 bytes
	11 14 bytes
 6-5	=00  (used to enable 4 byte Rx/Tx FIFOs on 82510???)
	=10 ???
 5-4	reserved (00)
 3	change RXRDY  TXRDY pins from mode 0 to mode 1
 2	clear XMIT FIFO
 1	clear RCVR FIFO
 0	enable clear XMIT and RCVR FIFO queues
 4-0	(other purpose on 82510???)
Notes:	bit 0 must be set in order to write to other FCR bits
	bit 1 when set	the RCVR FIFO is cleared and this bit is reset
	  the receiver shift register is not cleared
	bit 2 when set	the XMIT FIFO is cleared and this bit is reset
	  the transmit shift register is not cleared
	due to a hardware bug, 16550 FIFOs don't work correctly (this
	  was fixed in the 16550A)
SeeAlso: #P0878

Bitfields for serial port Line Control Register (LCR):
Bit(s)	Description	(Table P0880)
 7	=1  divisor latch access bit (DLAB)
	=0  receiver buffer, transmitter holding, or interrupt enable register
	  access
 6	set break enable. serial ouput is forced to spacing state and remains
	  there.
 5-3	PM2 PM1 PM0
	 x   x	 0 = no parity
	 0   0	 1 = odd parity
	 0   1	 1 = even parity
	 1   0	 1 = high parity (sticky)
	 1   1	 1 = low parity (sticky)
	 x   x	 1 = software parity
 2	stop bit length (STB/SBL)
	0  one stop bit
	1  2 stop bits with (word length 6, 7, 8)
	   1.5 stop bits with word length 5
 1-0	(WLS1-0, CL1-0)
	00 word length is 5 bits
	01 word length is 6 bits
	10 word length is 7 bits
	11 word length is 8 bits
SeeAlso: #P0881,#P0882,#P0883

Bitfields for serial port Modem Control Register (MCR):
Bit(s)	Description	(Table P0881)
 7-6	reserved (0)
 5	(82510 only) state of OUT0 pin
 4	loopback mode for diagnostic testing of serial port
	output of transmitter shift register is looped back to receiver
	  shift register input. In this mode, transmitted data is received
	  immediately so that the CPU can verify the transmit data/receive
	  data serial port paths.
	If OUT2 is disabled, there is no official way to generate an IRQ
	  during loopback mode.
 3	auxiliary user-designated output 2 (OUT2)
	because of external circuity OUT2 must be 1 to master-intr-enableing.
	BUG: Some Toshiba Laptops utilize this bit vice versa, newer Toshiba
	  machines allow assignment of the bit's polarity in system setup.
	82050: This bit is only effective, if the chip is being used with an
	  externally-generated clock.
 2	=1/0  auxiliary user-designated output 1 (OUT1)
	should generally be cleared!!
	Some external hardware, e.g. c't MIDI interface (and compatibles) use
	  this bit to change the 8250 input clock from 1,8432 MHz to 4Mhz
	  (enabling MIDI-conformant baudrates) and switching to
	  MIDI-compatible current loop connectors.
 1	force request-to-send active (RTS)
 0	force data-terminal-ready active (DTR)
SeeAlso: #P0880,#P0882,#P0883

Bitfields for serial port Line Status Register (LSR):
Bit(s)	Description	(Table P0882)
 7	=0  reserved
	=1  on some chips produced by UMC
 6	transmitter shift and holding registers empty
 5	transmitter holding register empty (THRE)
	Controller is ready to accept a new character to send.
 4	break interrupt. the received data input is held in the zero bit
	  state longer than the time of start bit + data bits + parity bit +
	  stop bits.
 3	framing error (FE). the stop bit that follows the last parity or data
	  bit is a zero bit
 2	parity error (PE). Character has wrong parity
 1	overrun error (OE). a character was sent to the receiver buffer
	  before the previous character in the buffer could be read. This
	  destroys the previous character.
 0	data ready. a complete incoming character has been received and sent
	  to the receiver buffer register.
SeeAlso: #P0880,#P0881,#P0883

Bitfields for serial port Modem Status Register (MSR):
Bit(s)	Description	(Table P0883)
 7	data carrier detect (-DCD)
 6	ring indicator (-RI)
 5	data set ready (-DSR)
 4	clear to send (-CTS)
 3	delta data carrier detect (DDCD)
 2	trailing edge ring indicator (TERI)
 1	delta data set ready (DDSR)
 0	delta clear to send (DCTS)
Notes:	bits 0-3 are reset when the CPU reads the MSR
	bit 4 is the Modem Control Register RTS during loopback test
	bit 5 is the Modem Control Register DTR during loopback test
	bit 6 is the Modem Control Register OUT1 during loopback test
	bit 7 is the Modem Control Register OUT2 during loopback test
SeeAlso: #P0880,#P0881,#P0882
--------!---Note-----------------------------
Note:	Addresses above 03FF generally apply to EISA and PCI machines only !
	EISA port assignments:
	    1000-1FFF	slot 1 EISA
	    2000-2FFF	slot 2 EISA
	    3000-3FFF	slot 3 EISA
	    4000-4FFF	slot 4 EISA
	    5000-5FFF	slot 5 EISA
	    6000-6FFF	slot 6 EISA
	    7000-7FFF	slot 7 EISA
----------P0401040B--------------------------
PORT 0401-040B - EISA DMA Controller
SeeAlso: PORT 0481h-048Bh"EISA",PORT 04D4h-04D6h"EISA"

0401  RW  DMA channel 0 word count byte 2 (high)
0403  RW  DMA channel 1 word count byte 2 (high)
0405  RW  DMA channel 2 word count byte 2 (high)
0407  RW  DMA channel 3 word count byte 2 (high)
040A  -W  extended DMA chaining mode register, channels 0-3 (see #P0884)
040A  R-  channel interrupt (IRQ13) status register (see #P0885)
040B  -W  DMA extended mode register for channels 0-3 (see #P0886)
	(bit settings same as PORT 04D6h)

Bitfields for EISA extended DMA chaining mode register (channels 0-3):
Bit(s)	Description	(Table P0884)
 7-5	reserved
 4	=0  generate IRQ13
	=1  generate terminal count
 3	=0  do not start chaining
	=1  programming complete
 2	=0  disable buffer chaining mode (default)
	=1  enable buffer chaining mode
 1-0	DMA channel select
SeeAlso: #P0885,#P0886,#P0893

Bitfields for EISA channel interrupt (IRQ13) status register:
Bit(s)	Description	(Table P0885)
 7-5  interrupt on channels 7-5
 4	  reserved
 3-0  interrupt on channels 3-0
SeeAlso: #P0884

Bitfields for EISA DMA extended mode register (channels 0-3):
Bit(s)	Description	(Table P0886)
 7	=0 enable stop register
 6	=0 terminal count is an output for this channel	(default)
 5-4	DMA cycle timing
	00 ISA-compatible (default)
	01 type A timing mode
	10 type B timing mode
	11 burst DMA mode
 3-2	Address mode
	00 8-bit I/O, count by bytes (default)
	01 16-bit I/O, count by words, address shifted
	10 32-bit I/O, count by bytes
	11 16-bit I/O, count by bytes
 1-0	DMA channel select
SeeAlso: #P0884,#P0894
----------P040A043F--------------------------
PORT 040A-043F - Intel 82378ZB embedded DMA controller
Range:	relocatable via Relocation Base Address register (see #01075)
SeeAlso: PORT 0401h"EISA",#01064,#01075

040A  R-  scatter/gather interrupt status (see #P0887)
040B  -W  DMA1 extended mode
0410  -W  CH0 scatter/gather command (see #P0888)
0411  -W  CH1 scatter/gather command
0412  -W  CH2 scatter/gather command
0413  -W  CH3 scatter/gather command
0414  -W  CH4 scatter/gather command
0415  -W  CH5 scatter/gather command
0416  -W  CH6 scatter/gather command
0417  -W  CH7 scatter/gather command (see #P0888)
0418  R-  CH0 scatter/gather status (see #P0889)
0419  R-  CH1 scatter/gather status
041A  R-  CH2 scatter/gather status
041B  R-  CH3 scatter/gather status
041C  R-  CH4 scatter/gather status
041D  R-  CH5 scatter/gather status
041E  R-  CH6 scatter/gather status
041F  R-  CH7 scatter/gather status (see #P0889)
0420d RW  CH0 scatter/gather descriptor table address
0424d RW  CH1 scatter/gather descriptor table address
0428d RW  CH2 scatter/gather descriptor table address
042Cd RW  CH3 scatter/gather descriptor table address
0430d RW  CH4 scatter/gather descriptor table address
0434d RW  CH5 scatter/gather descriptor table address
0438d RW  CH6 scatter/gather descriptor table address
043Cd RW  CH7 scatter/gather descriptor table address

(Table P0887)
Call Intel 82378ZB Scatter/Gather Interrupt Status Register with:
 7	channel 7 has interrupt due to S/G transfer
 ...
 0	channel 0 has interrupt due to S/G transfer
SeeAlso: #P0888,#P0889

Bitfields for Intel 82378ZB Scatter/Gather Command Register:
Bit(s)	Description	(Table P0888)
  7	select last-buffer termination type
	=0 assert IRQ13 on completion
	=1 assert EOP on completion
 6	enable bit 7 termination-type selection
 5-2	reserved (0)
 1-0	scatter-gather command
	00 none
	01 start S/G command
	10 stop S/G command
	11 reserved
SeeAlso: #P0887,#P0889,#01075

Bitfields for Intel 82378ZB Scatter/Gather Status Register:
Bit(s)	Description	(Table P0889)
 7	no next link
 6	reserved
 5	issue IRQ13 instead of EOP at end of last buffer
 4	reserved
 3	scatter/gather Base Register status
	=1 buffer link has been loaded
	=0 empty
 2	scatter/gather Current Register status
	=1 buffer link has been loaded
	=0 empty
 1	reserved
 0	scatter/gather is active
SeeAlso: #P0888
--------X-P040D040F--------------------------
PORT 040D-040F - EISA - Intel 82357

040D  R-  chip stepping level
040E  RW  test register 1
040F  RW  test register 2
----------P04610462--------------------------
PORT 0461-0462 - EISA NMI CONTROL

0461  RW  Extended NMI status/control register (see #P0890)
0462  -W  Software NMI register. writing to this register causes an NMI	if
	  NMIs are enabled
	bit 7 = 1  generates an NMI

Bitfields for EISA extended NMI status control register:
Bit(s)	Description	(Table P0890)
 7  R-	NMI pending from fail-safe (watchdog) timer
 6  R-	NMI pending from bus timeout NMI status
 5  R-	NMI pending from I/O port status
 4  R-	busmaster preemption timeout if bit 6 set
 3  RW	bus timeout NMI enable
 2  RW	fail-safe (watchdog) NMI enable
 1  RW	NMI I/O port enable
 0  RW	RSTDRV. bus reset
	=0  NORMAL bus reset operation
	=1  reset bus asserted
--------X-P04640465--------------------------
PORT 0464-0465 - EISA BUS MASTER STATUS

0464w R	  bus master status latch register (slots 1-16)
	identifies the last bus master that had control of the bus (bit N =0 if
	  slot N+1 had control last)
----------P0481048B--------------------------
PORT 0481-048B - EISA DMA page registers
Note:	these registers are also supported on many non-EISA machines, e.g. by
	  most machines using Intel PCI chipsets
SeeAlso: PORT 0401h-040Bh"EISA",PORT 04C6h-04CFh"EISA"

0481  RW  DMA channel 2 address byte 3 (high)
0482  RW  DMA channel 3 address byte 3 (high)
0483  RW  DMA channel 1 address byte 3 (high)
0487  RW  DMA channel 0 address byte 3 (high)
0489  RW  DMA channel 6 address byte 3 (high)
048A  RW  DMA channel 7 address byte 3 (high)
048B  RW  DMA channel 5 address byte 3 (high)
----------P04C604CF--------------------------
PORT 04C6-04CF - EISA DMA count registers
SeeAlso: PORT 0401h-040Bh"EISA",PORT 0481h-048Bh"EISA",PORT 04E0h-04FFh"EISA"

04C6  RW  DMA channel 5 word count byte 2 (high)
04CA  RW  DMA channel 6 word count byte 2 (high)
04CE  RW  DMA channel 7 word count byte 2 (high)
--------X-P04D004D1--------------------------
PORT 04D0-04D1 - EISA IRQ control
Note:	these registers are also supported on many non-EISA machines, e.g. by
	  most machines using Intel PCI chipsets
SeeAlso: PORT 04D4h-040Bh"EISA"

04D0  -W  IRQ 0-7 interrupt edge/level registers (see #P0891)
04D1  -W  IRQ 8-15 interrupt edge/level registers (see #P0892)

Bitfields for EISA IRQ 0-7 interrupt edge/level register:
Bit(s)	Description	(Table P0891)
 7	IRQ 7 is level sensitive
 6	IRQ 6 is level sensitive
 5	IRQ 5 is level sensitive
 4	IRQ 4 is level sensitive
 3	IRQ 3 is level sensitive
 2-0	reserved
SeeAlso: #P0892

Bitfields for EISA IRQ 8-15 interrupt edge/level register:
Bit(s)	Description	(Table P0892)
 7	IRQ 15 is level sensitive
 6	IRQ 14 is level sensitive
 5	reserved (1)
 4	IRQ 12 is level sensitive
 3	IRQ 11 is level sensitive
 2	IRQ 10 is level sensitive
 1	IRQ 9  is level sensitive
 0	reserved
SeeAlso: #P0891
----------P04D404D6--------------------------
PORT 04D4-04D6 - EISA DMA control
Note:	PORT 04D6h is also supported by the Intel 82378ZB System I/O controller
SeeAlso: PORT 0401h-040Bh"EISA",PORT 04D0h-04D1h"EISA"

04D4  R-  DMA chaining status
04D4  -W  extended DMA chaining mode register, channels 4-7 (see #P0893)
04D6  -W  DMA extended mode register for channels 4-7 (see #P0894)
	bit settings same as PORT 040Bh

Bitfields for EISA extended DMA chaining mode register (channels 4-7):
Bit(s)	Description	(Table P0893)
 7-5	reserved (0)
 4	=0  generate IRQ 13
	=1  generate terminal count
 3	=0  do not start chaining
	=1  programming complete
 2	=0  disable buffer chaining mode (default)
	=1  enable buffer chaining mode
 1-0	DMA channel select
SeeAlso: #P0884,#P0894

Bitfields for EISA DMA extended mode register (channels 4-7):
Bit(s)	Description	(Table P0894)
 7	=0  enable stop register
 6	=0  terminal count is an output for this channel (default)
 5-4	DMA cycle timing
	00 ISA-compatible (default)
	01 type A timing mode
	10 type B timing mode
	11 burst DMA mode
 3-2	Address mode
	00 8-bit I/O, count by bytes (default)
	01 16-bit I/O, count by words, address shifted
	10 32-bit I/O, count by bytes
	11 16-bit I/O, count by bytes
 1-0	DMA channel select
SeeAlso: #P0886,#P0893
----------P04E004FF--------------------------
PORT 04E0-04FF - EISA DMA stop registers
SeeAlso: PORT 0481h-048Bh"EISA"

04E0-04E2  RW	channel 0 stops if DMA transfer reaches specified address
04E4-04E6  RW	channel 1
04E8-04EA  RW	channel 2
04EC-04EE  RW	channel 3
04F4-04F6  RW	channel 5
04F8-04FA  RW	channel 6
04FC-04FE  RW	channel 7
----------P05300533--------------------------
PORT 0530-0533 - Gravis Ultra Sound Daughter Card by Advanced Gravis
Range:	dipswitch selectable from PORT 0530h-0533h, PORT 0604h-0607h,
	  PORT 0E80h-0E83h, and PORT 0F40h-0F43h
SeeAlso: PORT 0530h"Windows Sound System"

0530  RW  address select (see #P0895)
0531  RW  data (selected by PORT 0530h)
0532  RW  status
0533  RW  PIO data
----------P05300537--------------------------
PORT 0530-0537 - Windows Sound System ("WSS") (default address)
Range:	dipswitch selectable among PORT 0530h-0537h,PORT 0604h-060Bh,
	  PORT 0E80h-0E87h, and PORT 0F40h-0F47h
Notes:	the Sound Galaxy NX16 sound cards contains a Crystal CS4231, and thus
	  support the CODEC portion of the WSS on ports 0534h-0537h
	  (or 0608h-060Bh, etc.)
	the AMD InterWave chip supports a superset of the WSS CS4231 Codec,
	  though by default it is not placed at any of the addresses used by
	  the WSS
SeeAlso: PORT 032Ch"InterWave",PORT 0340h"Gravis",PORT 0530h"Vendetta"

0534  ?W  register select (index) (see #P0895)
0535  RW  data register (selected by PORT 0534h)
0536  R?  (CS4231A) status register
0537  RW  (CS4231A) PIO data register

(Table P0895)
Values for Windows Sound System CS4231 Codec register number:
 00h	Mixer: ADC volume (left)
 01h	Mixer: ADC volume (right)
 02h	Mixer: Line In volume (right) (see #P0896)
 03h	Mixer: Line In volume (left) (see #P0896)
 04h	Mixer: FM volume (right) (see #P0896)
 05h	Mixer: FM volume (left) (see #P0896)
 06h	Mixer: playback DAC volume (left)
 07h	Mixer: playback DAC volume (right)
 08h	playback data format
 09h	configuration register 1
 0Ah	external control
 0Bh	Codec status register 2
 0Ch	mode select
	bit 6: ???
 0Dh	loopback control
	(Sound Galaxy) microphone input enabled by bit 0 ???
 0Eh	playback count (high)
 0Fh	playback count (low)
 10h	configuration register 2
 11h	configuration register 3
 12h	Mixer: CD volume (right) (see #P0896)
 13h	Mixer: CD volume (left) (see #P0896)
 14h	timer (low)
 15h	timer (high)
 16h	Mixer: microphone input control (left)
 17h	Mixer: microphone input control (right)
 18h	Codec status register 3
 19h	Mixer: output attenuation (left)
 1Ah	mono input/output control
	(Sound Galaxy) SB volume (see #P0897)
 1Bh	Mixer: output attenuation (right)
 1Ch	record data format
 1Dh	playback variable frequency
 1Eh	record count (high)
 1Fh	record count (low)
 48h	(Sound Galaxy) ???
Notes:	to enable the microphone input on the Sound Galaxy, ALL of the
	  following registers must be set: 00h set to 80h, 01h set to 80h,
	  07h to 00h, 0Dh to 01h, and 48h to 4Bh
	on the Sound Galaxy NX16, only bits 0-4 of the register number are
	  fully decoded, so most registers above 1Fh are aliases of the
	  first 32 registers

Bitfields for WSS mixer volume:
Bit(s)	Description	(Table P0896)
 7	disable input source
 6-5	reserved???
 4-0	volume (00h = highest, 1Fh = lowest)
SeeAlso: #P0895,#P0897
Note:	the GW2000 GWBVOL.EXE only permits the setting of volume levels
	  08h (reported as 16) to 18h (reported as 0, and sets bit 7 as well)

Bitfields for WSS mixer volume (SoundBlaster):
Bit(s)	Description	(Table P0897)
 7	disable input source
 6-4	reserved???
 3-0	volume (00h = highest, 0Fh = lowest)
SeeAlso: #P0895,#P0896
----------P05300537--------------------------
PORT 0530-0537 - OPTi "Vendetta" Windows Sound System emulation (default addr)
SeeAlso: PORT 0530h"WSS",PORT 0F8Dh"Vendetta",PORT 0F8Eh"Vendetta"

0530  -W  (OPTi "Vendetta") WSS configuration register (see #P0898)
0530  R-  (OPTi "Vendetta") WSS version register (see #P0899)
0534  RW  (OPTi "Vendetta") codec index address register (see #P0900)
0535  RW  (OPTi "Vendetta") codec indexed data register
0536  RW  (OPTi "Vendetta") codec status register (see #P0901)
0537  R-  (OPTi "Vendetta") codec direct data register - capture mode
0537  -W  (OPTi "Vendetta") codec direct data register - playback mode

Bitfields for OPTi "Vendetta" WSS configuration register:
Bit(s)	Description	(Table P0898)
 7	reserved
 6	IRQ sense source
	0 = normal
	1 = interrupt auto-selection
 5-3	WSS IRQ
	000 = disable
	001 = IRQ7
	010-100 = IRQ9-IRQ11
	101 = IRQ5
	110-111 = reserved
 2-0	WSS DRQ
	      playback	capture
	000 = disable	disable
	001 = DRQ0	disable
	010 = DRQ1	disable
	011 = DRQ3	disable
	100 = disable	DRQ1
	101 = DRQ0	DRQ1
	110 = DRQ1	DRQ0
	111 = DRQ3	DRQ0
SeeAlso: PORT 0530-0537

Bitfields for OPTi "Vendetta" WSS version register:
Bit(s)	Description	(Table P0899)
 7	available channel
	0 = DRQ0/1/3 and IRQ7/9/10/11 available
	1 = DRQ1/3 and IRQ7/9 available
 6	IRQ sense
	0 = no interrupt
	1 = WSS interrupt active
 5-0	version (04h)
SeeAlso: PORT 0530-0537

Bitfields for OPTi "Vendetta" codec index address register:
Bit(s)	Description	(Table P0900)
 7	initialization
	1 = codec cannot respond to parallel bus cycles
 6	mode change enable
 5	transfer request
	0 = transfers enabled during interrupt
	1 = transfers disabled by interrupt
 4-0	index address (see #P0902)
	  (audio module control register 5 bit 5 must be set in order
	  to access indexes 10h-1Fh)
SeeAlso: PORT 0530-0537

Bitfields for OPTi "Vendetta" codec status register:
Bit(s)	Description	(Table P0901)
 7	PIO capture data ready (read-only)
	0 = lower byte
	1 = upper byte (or 8-bit)
 6	PIO capture data ready (read-only)
	0 = right
	1 = left (or mono)
 5	PIO capture data register data ready (read-only)
	0 = stale ADC data (do not re-read)
	1 = fresh ADC data (ready for host data read)
 4	sample ADC capture overrun/DAC playback underrun occurred (read-only)
 3	PIO playback data needed (read-only)
	0 = lower byte
	1 = upper byte (or 8-bit)
 2	PIO playback data needed (read-only)
	0 = right
	1 = left (or mono)
 1	PIO playback data register ready for data (read-only)
	0 = valid DAC data (do not overwrite)
	1 = stale DAC data (ready for host data write)
 0	interrupt enable
SeeAlso: PORT 0530-0537

(Table P0902)
Values for OPTi "Vendetta" (82C750) codec indirect registers:
 00h	MIXOUTL output control register (see #P0903)
 01h	MIXOUTR output control register (see #P0903)
 02h	CDL input control register (see #P0904)
 03h	CDR input control register (see #P0904)
 04h	FML input control register (see #P0904)
 05h	FMR input control register (see #P0904)
 06h	DACL input control register (see #P0905)
 07h	DACR input control register (see #P0905)
 08h	frequency synthesizer and playback data format register (see #P0906)
 09h	interface configuration register (see #P0907)
 0Ah	pin control register (see #P0908)
 0Bh	error status and initialization register (read-only) (see #P0909)
 0Ch	ID register (see #P0910)
 0Dh	reserved
 0Eh	playback upper base count register
	  (used for playback and capture in SB mode)
 0Fh	playback lower base count register
	  (used for playback and capture in SB mode)
 10h	AUXL input control register (see #P0904)
 11h	AUXR input control register (see #P0904)
 12h	LINEL input control register (see #P0904)
 13h	LINER input control register (see #P0904)
 14h	MICL input control register (see #P0911)
 15h	MICR input control register (see #P0912)
 16h	OUTL output control register (see #P0913)
 17h	OUTR output control register (see #P0913)
 18h-1Bh reserved
 1Ch	capture data format register (see #P0906)
 1Dh	reserved
 1Eh	capture upper base count register
 1Fh	capture lower base count register
Note:	To access expanded mode registers (10h-1Fh), audio module control
	  register 5 bit 5 must be set.
SeeAlso: #P0900

Bitfields for OPTi "Vendetta" MIXOUTL/R output control register:
Bit(s)	Description	(Table P0903)
 7-6	source select
	00 = LINE
	01 = CD
	10 = MIC
	11 = MIXER
 5	MIC +20dB gain enable
 4	reserved
 3-0	gain select for MIXOUTL/R
	0000-1111 = 0dB to +22.5dB in 1.5dB steps
SeeAlso: #P0902

Bitfields for OPTi "Vendetta" CD/FM/AUX/LINE L/R input control register:
Bit(s)	Description	(Table P0904)
 7	mute enable
 6-5	reserved
 4-1	gain select for CD/FM/AUX/LINE L/R
	0000-1111 = +12dB to -33dB in 3dB steps
 0	reserved
SeeAlso: #P0902

Bitfields for OPTi "Vendetta" DACL/R input control register:
Bit(s)	Description	(Table P0905)
 7	mute enable
 6-5	reserved
 4-0	gain select for DACL/R
	00000-11111 = 0dB to -46.5dB in 1.5dB steps
SeeAlso: #P0902

Bitfields for OPTi "Vendetta" frequency synth and playback/capture data format:
Bit(s)	Description	(Table P0906)
 7-5	audio data format
	000 = linear, 8-bit unsigned
	001 = æ-law, 8-bit companded
	010 = linear, 16-bit two's complement, little endian
	011 = A-law, 8-bit companded
	100 = reserved
	101 = ADPCM, 4-bit, IMA compatible
	110 = linear, 16-bit two's complement, big endian
	111 = reserved
	  (bit 7 forced to 0 in mode 1)
 4	0 = mono
	1 = stereo
 3-0	(playback) clock frequency divide/audio sample rate frequency
	0000 = 8.0kHz
	0001 = 5.5125kHz
	0010 = 16.0kHz
	0011 = 11.025kHz
	0100 = 27.42857kHz
	0101 = 18.9kHz
	0110 = 32.0kHz
	0111 = 22.05kHz
	1000 = reserved
	1001 = 37.8kHz
	1010 = reserved
	1011 = 44.1kHz
	1100 = 48.0kHz
	1101 = 33.075kHz
	1110 = 9.6kHz
	1111 = 6.615kHz
	(capture) reserved
Note:	the contents of these registers can be changed only if mode change bit
	  is set (see #P0900).
SeeAlso: #P0902

Bitfields for OPTi "Vendetta" interface configuration register:
Bit(s)	Description	(Table P0907)
 7	capture data transfer method (0 = DMA, 1 = PIO)
 6	playback data transfer method (0 = DMA, 1 = PIO)
 5-4	reserved
 3	autocalibration enable
 2	DMA channel mode (0 = dual, 1 = single)
 1	capture data in selected format enable
 0	playback data in selected format enable
SeeAlso: #P0902

Bitfields for OPTi "Vendetta" pin control register:
Bit(s)	Description	(Table P0908)
 7-2	reserved
 1	interrupt pin enable
	  (goes active high on reaching the number of samples in base count
	  register)
 0	reserved
SeeAlso: #P0902

Bitfields for OPTi "Vendetta" error status and initialization register:
Bit(s)	Description	(Table P0909)
 7	capture overrun
 6	playback underrun
 5	autocalibration state
	0 = in progress
	1 = not in progress
 4	current PDRQ/CDRQ status
	0 = inactive (low)
	1 = active (high)
 3-2	under/over range on right input channel
	00 = less than -1dB under range
	01 = between -1dB and 0dB under range
	10 = between 0dB and +1dB over range
	11 = greater than +1dB over range
 3-2	under/over range on left input channel
	00 = less than -1dB under range
	01 = between -1dB and 0dB under range
	10 = between 0dB and +1dB over range
	11 = greater than +1dB over range
SeeAlso: #P0902

Bitfields for OPTi "Vendetta" ID register:
Bit(s)	Description	(Table P0910)
 7-4	reserved
 3-0	codec revision ID (read-only)
SeeAlso: #P0902

Bitfields for OPTi "Vendetta" MICL input control register:
Bit(s)	Description	(Table P0911)
 7	mute enable
 6	MICR mix into OUTL enable
 5	reserved
 4-1	gain select for MICL
	0000-1111 = +12dB to -33dB in 3dB steps
 0	reserved
SeeAlso: #P0902

Bitfields for OPTi "Vendetta" MICR input control register:
Bit(s)	Description	(Table P0912)
 7	mute enable
 6	MICL mix into OUTR enable
 5	reserved
 4-1	gain select for MICR
	0000-1111 = +12dB to -33dB in 3dB steps
 0	reserved
SeeAlso: #P0902,#P0913

Bitfields for OPTi "Vendetta" OUTL/R output control register:
Bit(s)	Description	(Table P0913)
 7	mute enable
 6	reserved
 5-1	gain select for OUTL/R
	00000-11111 = 0dB to -93dB in 3dB steps
 0	reserved
SeeAlso: #P0902,#P0913
----------P05FB------------------------------
PORT 05FB - QUAD EMS+ - "QEMS_RESET" - RESET EMS???
SeeAlso: PORT 07FBh"QUAD",PORT 2315h
----------P0601------------------------------
PORT 0601 - Headland HL21, Acer M5105 chipsets - SYSTEM CONTROL

0601  -W  system control (see #P0914)
0601  R-  status (see #P0915)

Bitfields for Headland HL21/Acer M5105 system control register:
Bit(s)	Description	(Table P0914)
 7	=1  power LED on
 6	=1  LCD backlight off
 5	???
 4	???
 3	???
 2	=1  video chips disabled, screen blanked.
 1	???
 0	=1  will lock up your machine!
SeeAlso: #P0915

Bitfields for Headland HL21/Acer M5105 status register:
Bit(s)	Description	(Table P0915)
 7	=0  if screen enabled always these values
 6	=0
 5	=0
 4	=0
 3	=0
 2	=1  (=0 at low power)
 1	=0  power OK
 0	=0
SeeAlso: #P0914
----------P06040607--------------------------
PORT 0604-0607 - Gravis Ultra Sound Daughter Card by Advanced Gravis
Range:	dipswitch selectable from PORT 0530h-0533h, PORT 0604h-0607h,
	  PORT 0E80h-0E83h, and PORT 0F40h-0F43h
----------P0604060B--------------------------
PORT 0604-060B - Windows Sound System
Range:	PORT 0530h-0537h,PORT 0604h-060Bh,PORT 0E80h-0E87h,PORT 0F40h-0F47h
SeeAlso: PORT 0530h"Sound System"
----------P06200627--------------------------
PORT 0620-0627 - PC network (adapter 1)
0628-062F - PC network (adapter 2)
----------P063E063F--------------------------
PORT 063E-063F - WINTEL.VXD - API
Note:	the WinTel remote-control program uses these two virtualized ports
	  as an API between it main application HOST.EXE and the WINTEL.VXD
	  driver
Index:	installation check;WinTel

063E  R-  always reads 42h if WinTel.VXD is loaded (installation check)
063E  -W  simulate keystroke to current Windows VM (scan code as it would
		  be read from keyboard, including make/break in bit 7)
		  (see also INT 09)
063F  RW  watchdog/scratchpad (see #P0916)

Bitfields for WimTel watchdog/scratchpad byte:
Bit(s)	Description	(Table P0916)
 7-4	scratchpad; HOST.EXE uses as follows:
	bit 7: physical connection is active
	bit 6: sending file
	bit 5: receiving file
	bit 4: session is active
 1	retrigger watchdog (write 03h to PORT 063Fh to avoid reboot)
 0	enable watchdog (PC is rebooted if watchdog not retriggered every 20s)
----------P0678067A--------------------------
PORT 0678-067A - Intel 82091AA - ECP-mode PARALLEL PORT
Range:	PORT 0678h or PORT 0378h, depending on the base address of the parallel
	  port (0278h or 0378h)
SeeAlso: PORT 0278h,PORT 0778h,PORT 07BCh

0278  RW  (when ECR bits 7-5=011) ECP Address/RLE FIFO (see #P0917)
	(this is the same address normally used for parallel port data)
0678  RW  (when ECR bits 7-5=010) standard parallel port data FIFO (see #P0918)
0678  RW  (when ECR bits 7-5=011) ECP data FIFO (see #P0919)
0678  RW  (when ECR bits 7-5=110) test FIFO (see #P0920)
0678  RW  (when ECR bits 7-5=111) ECP configuration A (see #P0921)
0679  RW  (when ECR bits 7-5=111) ECP configuration B (see #P0922)
067A  RW  extended control register (ECR) (see #P0923)

Bitfields for ECP Address/RLE FIFO:
Bit(s)	Description	(Table P0917)
 7	address/RLE-count select
	=0 RLE count
	=1 channel address
 6-0	channel address (bit 7 set)
	RLE count, less 1 (bit 7 clear)
Notes:	when using hardware RLE decompression, the associated data is written
	  to the data FIFO (see #P0919) after the count is set here
	an RLE count of 1 (two identical bytes) will cause unnecessary
	  expansions
	the peripheral device performs the interpretation of this byte as
	  address or RLE count; writing to this port simply causes the AUTOFD#
	  line to be asserted to tell the peripheral that the byte is not data
SeeAlso: #P0923,#P0918

Bitfields for ECP Standard Parallel Port data FIFO:
Bit(s)	Description	(Table P0918)
 7-0	standard parallel port data
Notes:	data written or DMAed to this port are buffered in the FIFO and
	  transmitted to the peripheral using a standard ISA-compatible
	  hardware handshake
	PORT 027Ah bit 5 must be clear to enable the forward transfer direction
SeeAlso: #P0917,#P0918,#P0923

Bitfields for ECP data FIFO:
Bit(s)	Description	(Table P0919)
 7-0	ECP-mode data
Notes:	data written or DMAed to this port are buffered in the FIFO and
	  transmitted to the peripheral using an ECP hardware handshake;
	  PORT 027Ah bit 5 must be clear to enable the forward transfer
	  direction
	when PORT 027Ah bit 5 is set (reverse transfer), data is read from the
	  peripheral and placed in the FIFO, from which it may be read by
	  reading this port
SeeAlso: #P0917,#P0923,#P0920

Bitfields for ECP test FIFO:
Bit(s)	Description	(Table P0920)
 7-0	test FIFO data
Notes:	writes to this port write to the FIFO, reads from this port read from
	  the FIFO, without actually transferring any data out the parallel
	  port; FIFO overruns and underruns are ignored, simply reading/writing
	  over the same slots again and again
	the ECR "full" and "empty" bits always keep track of the current state
	  of the FIFO; the write threshold can be determined by filling the
	  FIFO and then reading a byte at a time until a service interrupt is
	  set in the ECR.  Similarly, the read threshold can be determined by
	  emptying the FIFO, setting the direction bit in PORT 027Ah, and
	  writing a byte at a time until a service interrupt is set.
SeeAlso: #P0917,#P0923,#P0919

Bitfields for ECP configuration A:
Bit(s)	Description	(Table P0921)
 7-4	(read-only) implementation identification
	bit 7: ISA-style interrupt
	bit 4: eight-bit implementation
 3-0	reserved
Note:	this register can only be accessed when the Extended Control
	  Register bits 7-5 are set to 111
SeeAlso: #P0923,#P0922,#P0917,#P0919,#P0920

Bitfields for ECP configuration B:
Bit(s)	Description	(Table P0922)
 7	reserved (0)
 6	IRQ status (reflects actual value driven onto either IRQ5 or IRQ7; used
	  to check for interrupt conflicts)
 5-0	reserved (0)
Notes:	this register can only be accessed when the Extended Control
	  Register bits 7-5 are set to 111
	bit 4 of the parallel control port (027Ah/037Ah) must be cleared before
	  bit 6 will show the interrupt status
SeeAlso: #P0923,#P0921

Bitfields for ECP Extended Control Register (ECR):
Bit(s)	Description	(Table P0923)
 7-5	ECP mode
	000 ISA-compatible
	001 PS/2-compatible (bidirectional port)
	010 ISA-compatible FIFO
	011 ECP
	100 reserved
	101 reserved
	110 test
	111 configuration
 4	disable ERROR interrupts
 3	enable DMA
	when bit 3 set and bit 2 clear, an interrupt is generated on the DMA
	  terminal-count condition; this bit must be cleared to reset the TC
	  interrupt
 2	disable FIFO/TerminalCount service interrupts
 1	(read-only) FIFO is full
 0	(read-only) FIFO is empty
Notes:	if the port is currently in modes 000 or 001, it may be switched into
	  any other mode; if it is in a mode other than 000 or 001, it must
	  first be switched into either mode 000 or 001 before selecting a mode
	  other than one of those two
	if currently in an extended forward mode (010-111 and direction bit
	  clear), software should wait for the FIFO to clear before switching
	  back to modes 000 or 001
	if a FIFO overrun or underrun occurs, BOTH bits 1 and 0 are set; to
	  clear the FIFO error condition, switch the port to mode 000 or 001
SeeAlso: #P0921,#P0922,#P0919
----------P06800681--------------------------
PORT 0680-0681 - Microchannel POST Diagnostic (write only)

0680  -W  Microchannel POST Diagnostic
0681  -W  secondary MCA POST diagnostic
----------P06A006A8--------------------------
PORT 06A0-06A8 - non-standard COM port addresses
Range:	selectable from 0280, 0288, 0290, 0298, 06A0, 06A8
Note:	V20-XT by German magazine c't
----------P06A806AF--------------------------
PORT 06A8-06AF - non-standard COM port addresses
Range:	selectable from 0280, 0288, 0290, 0298, 06A0, 06A8
Note:	V20-XT by German magazine c't
----------P06E206E3--------------------------
PORT 06E2-06E3 - data aquisition (adapter 1)
----------P06E8------------------------------
PORT 06E8 - S3 86C928 video controller (ELSA Winner 1000)
----------P06E806EF--------------------------
PORT 06E8-06EF - 8514/A and compatible (e.g. ATI Graphics Ultra) - HORZ DISPLYD
SeeAlso: PORT 02E8h-02EFh,PORT 0AE8h,PORT 96E8h,PORT 9AE8h

06E8w -W  CRT control: horizontal displayed
----------P0746------------------------------
PORT 0746 - Gravis Ultra Sound by Advanced Gravis - BOARD VERSION / MIXER
SeeAlso: PORT 0240h-024Fh,PORT 0340h-034Fh

0746  R-  board version (rev 3.7+)
		FFh	  Pre 3.6 boards, ICS mixer NOT present
		05h	  Rev 3.7 with ICS Mixer. Some R/L: flip problems.
		06h-09h	  Revision 3.7 and above. ICS Mixer present
		0Ah-	  UltraMax. CS4231 present, no ICS mixer
0746  -W  Mixer Control Port
----------P0778077A--------------------------
PORT 0778-077A - Intel 82091AA - ECP-mode PARALLEL PORT
Range:	PORT 0678h or PORT 0378h, depending on the base address of the parallel
	  port (0278h or 0378h)
SeeAlso: PORT 0378h,PORT 0678h,PORT 07BCh

0378  RW  (when ECR bits 7-5=011) ECP Address/RLE FIFO (see #P0917)
	(this is the same address normally used for parallel port data)
0778  RW  (when ECR bits 7-5=010) standard parallel port data FIFO (see #P0918)
0778  RW  (when ECR bits 7-5=011) ECP data FIFO (see #P0919)
0778  RW  (when ECR bits 7-5=110) test FIFO (see #P0920)
0778  RW  (when ECR bits 7-5=111) ECP configuration A (see #P0921)
0779  RW  (when ECR bits 7-5=111) ECP configuration B (see #P0922)
077A  RW  extended control register (ECR) (see #P0923)
----------P07900793--------------------------
PORT 0790-0793 - cluster (adapter 1)
----------P07BC07BE--------------------------
PORT 07BC-07BE - Intel 82091AA - ECP-mode PARALLEL PORT
SeeAlso: PORT 03BCh,PORT 0678h,PORT 0778h

03BC  RW  (when ECR bits 7-5=011) ECP Address/RLE FIFO (see #P0917)
	(this is the same address normally used for parallel port data)
07BC  RW  (when ECR bits 7-5=010) standard parallel port data FIFO (see #P0918)
07BC  RW  (when ECR bits 7-5=011) ECP data FIFO (see #P0919)
07BC  RW  (when ECR bits 7-5=110) test FIFO (see #P0920)
07BC  RW  (when ECR bits 7-5=111) ECP configuration A (see #P0921)
07BD  RW  (when ECR bits 7-5=111) ECP configuration B (see #P0922)
07BE  RW  extended control register (ECR) (see #P0923)
----------P07FB------------------------------
PORT 07FB - QUAD EMS+ - "QEMS_INCR" - ???
SeeAlso: PORT 05FBh"QUAD",PORT 2315h
----------P080008FF--------------------------
PORT 0800-08FF - I/O port access registers for extended CMOS RAM or SRAM
		(256 bytes at a time)
Note:	sometimes plain text can be seen here
--------X-P080008FF--------------------------
PORT 0800-08FF - reserved for EISA system motherboard
----------P0A200A23--------------------------
PORT 0A20-0A23 - Token Ring (adapter 1)
0A24-0A27 - Token Ring (adapter 2)
----------P0A79------------------------------
PORT 0A79 - Plug-and-Play - WRITE DATA PORT
Desc:	all data written to the Plug-and-Play configuration registers is
	  written to this port, including the configuration byte which
	  indicates the I/O port from which data is to be read when reading
	  the configuration registers
SeeAlso: PORT 0279h

0A79  -W  Plug-and-Play data writes
---------------------------------------------
