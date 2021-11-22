Ports List, part 3 of 3
Copyright (c) 1989-1999,2000 Ralf Brown
----------P0AD60AD7--------------------------
PORT 0AD6-0AD7 - Chips & Technologies PC Video (82C9001A) - CONTROL REGISTERS
Range:	Address determined by status of CS# input at RESET. If CS# input is
	  low on falling edge of RESET, then address is fixed at 0AD6-0AD7h;
	  otherwise, the programmable address is used.
Note:	register FFh is write-only and all other registers are disabled if
	  register FFh bit 0 is cleared.
SeeAlso: PORT 03D4h

0AD6  -W  index for accesses to data port (see #P0924)
0AD7  RW  data port

(Table P0924)
Values for Chips & Technologies PC Video (82C9001A) control registers:
 00h	I/O Address Register (see #P0925)
 01h	Memory Access Register (see #P0926)
 06h	Linear Memory Base Address Register (see #P0927)
 07h	Luminance Data Mask Register (enabled by register 01h bit 4)
	(0 prevents data modification during video data acquisition
	  in corresponding bit position)
 08h	Chrominance Data Mask Register (enabled by register 01h bit 4)
	(0 prevents data modification during video data acquisition
	  in corresponding bit position)
 09h	Interupt Mask/Polling Register (see #P0928)
 10h	General Purpose I/O Register 0
 11h	General Purpose I/O Register 1
 12h	General Purpose I/O Register 2
 13h	General Purpose I/O Register 3
 18h	General Purpose I/O Control Register (see #P0929)
 20h	Video Acquisition Mode Register (see #P0930)
 21h	Acquisition Window Control Register (see #P0931)
 22h	Acquisition Window X-Start Low Byte Register
	(X-Start is measured in input pixel clocks, referenced to trailing
	  edge of video Hsync)
 23h	Acquisition Window X-Start High Byte Register (two high order bits)
 24h	Acquisition Window Y-Start Low Byte Register
	(Y-Start is measured in input lines, referenced to trailing edge of
	  video Vsync + V Start Adjust (register 30h))
 25h	Acquisition Window Y-Start High Byte Register (two high order bits)
 26h	Acquisition Window X-End Low Byte Register
	(X-End is measured in input pixel clocks, referenced to trailing edge
	  of video Hsync)
 27h	Acquisition Window X-End High Byte Register (two high order bits)
 28h	Acquisition Window Y-End Low Byte Register
	(measured in input lines, referenced to trailing edge of
	  video Vsync + V Start Adjust (register 30h))
 29h	Acquisition Window Y-End High Byte Register (two high order bits)
 2Ah	Acquisition Write Address Low Register
	(points to frame memory location where video acquisition starts;
	  at end of video line reset to beginning and offset of 1024 bytes
	  is added for start address of next line)
 2Bh	Acquisition Write Address Middle Register
 2Ch	Acquisition Write Address High Register (4 high order bits)
 2Dh	Acquisition Horizontal-Scaling Register (see #P0932)
 2Eh	Acquisition Vertical-Scaling Register (see #P0933)
 2Fh	Scaling Field Adjust Register (see #P0934)
 30h	Input Video Start Adjust (see #P0935)
 38h	Scaling Control Register (see #P0936)
 40h	Display Area Control Register (see #P0937)
 41h	Display Window X-Start Low Byte Register
	(defines start of horizontal display window; measured in VGA pixel
	  clocks, referenced to trailing edge of VGA Hsync)
 42h	Display Window X-Start High Byte Register (three high order bits)
 43h	Display Window Y-Start Low Byte Register
	(defines start of vertical display window; measured in VGA lines,
	  referenced to trailing edge of VGA Vsync)
 44h	Display Window Y-Start High Byte Register (two high order bits)
 45h	Display Window X-End Low Byte Register
	(defines end of horizontal display window; measured in VGA pixel
	  clocks, referenced to trailing edge of VGA Hsync)
 46h	Display Window X-End High Byte Register (three high order bits)
 47h	Display Window Y-End Low Byte Register
	(defines start of vertical display window; measured in VGA lines,
	  referenced to trailing edge of VGA Vsync)
 48h	Display Window Y-End High Byte Register (two high order bits)
 49h	Display Window X-Panning Low Register
	(defines display buffer column address times 2, loaded during data
	  transfer cycle in VRAMs; for 4:1:1 encoding bit 0 should be set to 0)
 4Ah	Display Window Y-Panning Low Register
	  (defines display buffer row, loaded for first active display line)
 4Bh	Display Window X/Y-Panning High Register (see #P0938)
 4Ch	Shift Clock Start Register (7 bits)
	  (defines end of display blank relative to VGA Hsync trailing edge)
 4Dh	Sync Polarity/Zoom Register (see #P0939)
 4Eh	VGA Color Compare Register (see #P0940)
 4Fh	VGA Color Mask Register (see #P0941)
 50h	Display Window Interlace Control (see #P0942)
 FFh	Version/Global Enable Register (see #P0943)

Bitfields for Chips & Technologies PC Video (82C9001A) I/O Address Register:
Bit(s)	Description	(Table P0925)
 7-1	I/O address bits 7-1
	(These bits are compared with address inputs (A7-1) to detect
	  valid I/O address. If CS# is low on RESET, this register is
	  initialized to D6h. If CS# is high on RESET, this register is
	  loaded with value present on data inputs (D7-1) during first
	  I/O on the chip (IOWR# = 0 and CS# = 0).)
 0	reserved
SeeAlso: #P0924,#P0926,#P0927

Bitfields for Chips & Technologies PC Video (82C9001A) Memory Access Register:
Bit(s)	Description	(Table P0926)
 7-5	reserved
 4	VRAM write mask enable (enables registers 07h and 08h)
 3-0	reserved
SeeAlso: #P0924,#P0925,#P0927,#P0928

Bitfields for Chips & Technologies PC Video (82C9001A) Linear Memory Base:
Bit(s)	Description	(Table P0927)
 7-5	reserved
 4	reserved (1)
 3-0	linear memory space starting address (in 1MB units)
SeeAlso: #P0924,#P0925

Bitfields for Chips & Technologies PC Video (82C9001A) Interupt Mask/Polling:
Bit(s)	Description	(Table P0928)
 7-6	reserved
 5	VGA Hsync status
 4	VGA Vsync status
 3	video field status
	0 = even
	1 = odd
 2	video Vsync status
 1	video odd Vsync interrupt enable
 0	video even Vsync interrupt enable
SeeAlso: #P0924,#P0221

Bitfields for Chips & Technologies PC Video (82C9001A) General Purpose I/O:
Bit(s)	Description	(Table P0929)
 7	general purpose I/O 3
	0 = output decode of register 13h on GPIO3
	1 = reserved
 6	general purpose I/O 2
	0 = output decode of register 12h on GPIO2
	1 = reserved
 5	general purpose I/O 1
	0 = output "PLLHREF" on GPIO1
	1 = output decode of register 11h on GPIO1
 4	general purpose I/O 0
	0 = output decode of register 10h on GPIO0
	1 = reserved
 3	reserved
 2	I2C bus read back
	  (status of I2CI pin when I2CK pin goes from 0 to 1)
 1	I2C bus data (refer to I2C.LST for more details on the I2C bus)
 0	I2C bus clock
SeeAlso: #P0924

Bitfields for Chips & Technologies PC Video (82C9001A) Video Acquisition Mode:
Bit(s)	Description	(Table P0930)
 7	video input is non-interlace
 6	reserved
 5	video input Vsync polarity is active high
 4	video input Hsync polarity is active high
 3	video input even/odd acquire
	0 = even (first) field
	1 = odd (second) field
 2	video acquire field/frame
	0 = frame
	1 = field (interlaced mode only)
 1	video acquisition single/continuous
	0 = continuous
	1 = single (bit 0 cleared at the end)
 0	video acquisition start/stop
	0 = stop (allows CPU access to frame buffer)
	1 = start
SeeAlso: #P0924

Bitfields for Chips & Technologies PC Video (82C9001A) Window Control:
Bit(s)	Description	(Table P0931)
 7	invert field polarity
 6	select external field
	0 = internal field (field detected 1 XCLK after trailing edge of
	  XVSYNC input bit)
	1 = field bit input through XFLD pin and reclocked by XCLK before
	  XFLD use (XFLD input transition after trailing edge of XVSYNC; 
	  0 on XFLD = even field, 1 on XFLD = odd field)
 5	multiplexing ratio for luminance and chrominance input data
	  (active if bit 4 = 0)
	0 = 4:1:1 / 2:1:1
	1 = 4:2:2
 4	video input data multiplexing
	0 = multiplexed (YUV)
	1 = non-multiplexed (RGB)
 3	video input vertical scaling enable
 2	video input horizontal scaling enable
 1	video capture
	0 = inside cropping window
	1 = outside cropping window
 0	video input cropping enable
SeeAlso: #P0924,#P0935,#P0937

Bitfields for Chips & Technologies PC Video (82C9001A) Horizontal Scaling:
Bit(s)	Description	(Table P0932)
 7-6	reserved
 5-0	number of pixels written per 64 input pixels
	(valid values are 1-63; enabled by register 21h bit 2)
SeeAlso: #P0924,#P0933,#P0934

Bitfields for Chips & Technologies PC Video (82C9001A) Vertical Scaling:
Bit(s)	Description	(Table P0933)
 7	reserved
 6-0	number of pixels written per 64 input pixels
	(valid values are 1-63; enabled by register 21h bit 3)
SeeAlso: #P0924,#P0932,#P0934

Bitfields for Chips & Technologies PC Video (82C9001A) Scaling Field Adjust:
Bit(s)	Description	(Table P0934)
 7	reserved
 6-0	modify scaling value for odd field during acquisition
	(diagnostic register, set to same value as register 2Eh for normal
	  operation)
SeeAlso: #P0924,#P0932,#P0936

Bitfields for Chips & Technologies PC Video (82C9001A) Input Video Start:
Bit(s)	Description	(Table P0935)
 7-6	reserved
 5-0	number of scan lines from trailing edge of video Vsync to start of
	  active video frame
	(should always be programmed with non-zero value)
SeeAlso: #P0924,#P0931

Bitfields for Chips & Technologies PC Video (82C9001A) Scaling Control:
Bit(s)	Description	(Table P0936)
 7	fast write enable
 6-5	reserved (0 for normal operation)
 4	Y-max enable
	(prevents wrap around of memory Y-address; should be enabled for
	  PAL video data)
 3	X-max enable (prevents wrap around of memory X-address)
 2	Y-over-write mode
	(should be set to 1 when vertical scaling less than 1/2 to reduce
	  motion artifacts)
	0 = normal scaling
	1 = modified scaling
 1-0	chrominance multiplex adjust bits
	(adjust to maintain luminance/chrominance alignment)
SeeAlso: #P0924,#P0934

Bitfields for Chips & Technologies PC Video (82C9001A) Display Area Control:
Bit(s)	Description	(Table P0937)
 7-6	skew between VGA data input and multiplexer control output
	00 = 2 VGA clock delay
	01 = 3 VGA clock delay
	10 = 4 VGA clock delay
	11 = 5 VGA clock delay
 5	both X-Y window and color key area (function 3)
	(does not exist if bit 0 = 0 or bit 1 = 0)
	0 = display VGA
	1 = display frame buffer data
 4	color key only area (function 2)
	(does not exist if bit 1 = 0)
	0 = display VGA
	1 = display frame buffer data
 3	X-Y window only area (function 1)
	(does not exist if bit 0 = 0)
	0 = display VGA
	1 = display frame buffer data
 2	non-color key or X-Y window area (function 0)
	0 = display VGA
	1 = display frame buffer data
 1	overlay window using color keying enable
 0	overlay window using X-Y window enable
SeeAlso: #P0924,#P0931

Bitfields for Chips & Technologies PC Video (82C9001A) X/Y-Panning High:
Bit(s)	Description	(Table P0938)
 7-5	reserved
 4	high bit of row offset (register 4Ah)
 3-1	reserved
 0	high bit of column offset (register 49h)
SeeAlso: #P0924

Bitfields for Chips & Technologies PC Video (82C9001A) Sync Polarity/Zoom:
Bit(s)	Description	(Table P0939)
 7-6	reserved
 5	VGA Vsync polarity is active high
 4	VGA Hsync polarity is active high
 3-2	vertical zoom
	00 = no zoom
	01 = 2x
	10 = 4x
	11 = 8x
 1-0	horizontal zoom (same values as vertical zoom)
SeeAlso: #P0924

Bitfields for Chips & Technologies PC Video (82C9001A) VGA Color Compare:
Bit(s)	Description	(Table P0940)
 7-0	defines values VGA data must have for color match
	0 = VGA data must be 0
	1 = VGA data must be 1
SeeAlso: #P0924,#P0941

Bitfields for Chips & Technologies PC Video (82C9001A) VGA Color Mask Register:
Bit(s)	Description	(Table P0941)
 7-0	defines bit position where VGA and color value must match
	0 = VGA data must match color value
	1 = don't care
SeeAlso: #P0924,#P0940

Bitfields for Chips & Technologies PC Video (82C9001A) Interlace Control:
Bit(s)	Description	(Table P0942)
 7-5	reserved
 4	replicate odd/even field (if bit 3 = 1)
	0 = odd
	1 = even
 3	replicate field
	0 = do not replicate
	1 = replicate even/odd (depending on bit 4)
 2	invert display window field signal polarity (if bit 0 = 1)
	0 = do not modify
	1 = invert
 1	select external display window field signal (if bit 0 = 1)
	0 = internal
	1 = VFLD input
 0	display window is interlaced
SeeAlso: #P0924

Bitfields for Chips & Technologies PC Video (82C9001A) Version/Global Enable:
Bit(s)	Description	(Table P0943)
 7-4	PC Video version number
 3	reserved
 2	IOWR# delay (write-only)
	0 = IOWR# input delayed inside chip by 2 XCLK cycles
	1 = IOWR# input not delayed
 1	enable memory (write-only)
 0	PC Video global enable (write-only)
	0 = index register and register FFh are write only and all other
	  registers are disabled
	1 = all registers are read/write
SeeAlso: #P0924
----------P0AE20AE3--------------------------
PORT 0AE2-0AE3 - cluster (adapter 2)
----------P0AE8------------------------------
PORT 0AE8 - S3 86C928 video controller (ELSA Winner 1000)
----------P0AE80AEF--------------------------
PORT 0AE8-0AEF - 8514/A and compatible (e.g. ATI Graphics Ultra) - HSYNC START

0AE8w -W  CRT control: horizontal sync start
----------P0B900B93--------------------------
PORT 0B90-0B93 - cluster (adapter 2)
----------P0C00------------------------------
PORT 0C00 - EISA??? - PAGE REGISTER

0C00  RW  page register to write to SRAM or I/O
--------X-P0C000CFF--------------------------
PORT 0C00-0CFF - reserved for EISA system motherboard
----------P0C7C------------------------------
PORT 0C7C		bit 7-4 (Compaq)
--------X-P0C800C83--------------------------
PORT 0C80-0C83 - EISA system board ID registers

0C80  R-  bit 7: unused (0)
	  bits 6-2: manufacturer ID, first compressed ASCII char
	  bits 1-0: manufacturer ID, second compressed ASCII char (high)
0C81  R-  bits 7-5: manufacturer ID, second compressed ASCII char (low)
	  bits 4-0: manufacturer ID, third compressed ASCII char
0C82  R-  reserved for manufacturer's use
0C83  R-  bits 7-3: reserved for manufacturer's use
	  bits 2-0: EISA bus version
--------X-P0CF80CFF--------------------------
PORT 0CF8-0CFF - PCI Configuration Mechanism 1 - Configuration Registers
SeeAlso: PORT 0CF8h"Mechanism 2"

0CF8d -W  configuration address port (see #P0944)
0CFCd RW  configuration data port (when PORT 0CF8h bit 31 is set)

Bitfields for PCI configuration address port:
Bit(s)	Description	(Table P0944)
 1-0	reserved (00)
 7-2	configuration register number (see #00878)
 10-8	function
 15-11	device number
 23-16	bus number
 30-24	reserved (0)
 31	enable configuration space mapping
Note:	configuration registers are considered DWORDs, so the number in bits
	  7-2 is the configuration space address shifted right two bits
SeeAlso: #P0945
--------X-P0CF80CFA--------------------------
PORT 0CF8-0CFA - PCI Configuration Mechanism 2 - Configuration Registers
Notes:	this configuration mechanism is deprecated as of PCI version 2.1;
	  only mechanism 1 should be used for new systems
	to access the configuration space, write the target bus number to
	  the Forward Register, then write to the Configuration Space
	  Enable register, and finally read or write the appropriate I/O
	  port(s) in the range C000h to CFFFh (where Cxrrh accesses location
	  'rr' in physical device 'x's configuration data)
	the Intel "Saturn" and "Neptune" chipsets use configuration mechanism 2
SeeAlso: PORT 0CF8h"Mechanism 1",PORT C000h"PCI Configuration",PORT 0CFBh

0CF8  RW  Configuration Space Enable (CSE) (see #P0945)
0CFA  RW  Forward Register (selects target bus number)

Bitfields for PCI Configuration Space Enable:
Bit(s)	Description	(Table P0945)
 0	Special Cycle Enable (SCE)
 3-1	target function number (PCI logical device within physical device)
 7-4	key (non-zero to allow configuration)
SeeAlso: #P0944
----------P0CF9------------------------------
PORT 0CF9 - Intel chipsets - TURBO/RESET CONTROL REGISTER
Notes:	this port can only be accessed via 8-bit IN or OUT instructions by
	  the CPU
	supported by the Intel "Saturn" and "Neptune" (82434NX) chipsets,
	  the Intel 82454KX/GX (450GX chipset), Intel 82420EX chipset, etc.
SeeAlso: PORT C051h,#01055,#01239

0CF9  RW  reboot system, optionally selecting de-turbo mode (see #P0946)

Bitfields for Intel 82420EX turbo/reset control register:
Bit(s)	Description	(Table P0946)
 7-4	reserved (0)
 3	(450KX/GX only) enable CPU BIST on reset
 2	reset CPU
 1	reset mode
	0 soft reset
	1 hard reset
 0	deturbo mode
Note:	when resetting the CPU, two writes are required: the first sets the
	  state of bit 1 while keeping bit 2 cleared, and the second sets
	  bit 2; the reset occurs on bit 2's transition from 0 to 1.
SeeAlso: PORT C051h
----------P0CFB------------------------------
PORT 0CFB - Intel 82434NX (Neptune) - PCI MECHANISM CONTROL REGISTER
Note:	not present on the 82434LX (Mercury), which supports only mechanism #2
SeeAlso: PORT 0CF8h

0CFB  RW  specify which PCI access mechanism is to be enabled

Bitfields for Intel 82434NX PCI mechanism control register:
Bit(s)	Description	(Table P0947)
 7-1	reserved
 0	PCI Configuration Access Mechanism Select
	=0 use PCI configuration access mechanism #2 (0CF8/0CFA) (default)
	=1 use PCI configuration access mechanism #1 (0CF8/0CFC)
--------s-P0E800E83--------------------------
PORT 0E80-0E83 - Gravis Ultra Sound Daughter Card by Advanced Gravis
Range:	dipswitch selectable from PORT 0530h-0533h, PORT 0604h-0607h,
	  PORT 0E80h-0E83h, and PORT 0F40h-0F43h
--------s-P0E800E87--------------------------
PORT 0E80-0E87 - Windows Sound System
Range:	PORT 0530h-0537h,PORT 0604h-060Bh,PORT 0E80h-0E87h,PORT 0F40h-0F47h
SeeAlso: PORT 0530h"Sound System"
--------V-P0EE8------------------------------
PORT 0EE8 - S3 86C928 video controller (ELSA Winner 1000)
--------V-P0EE80EEF--------------------------
PORT 0EE8-0EEF - 8514/A and compatible (e.g. ATI Graphics Ultra) - HSYNC WIDTH

0EE8w -W  CRT control: horizontal sync width
--------s-P0F400F43--------------------------
PORT 0F40-0F43 - Gravis Ultra Sound Daughter Card by Advanced Gravis
Range:	dipswitch selectable from PORT 0530h-0533h, PORT 0604h-0607h,
	  PORT 0E80h-0E83h, and PORT 0F40h-0F43h
--------s-P0F400F47--------------------------
PORT 0F40-0F47 - Windows Sound System
Range:	PORT 0530h-0537h,PORT 0604h-060Bh,PORT 0E80h-0E87h,PORT 0F40h-0F47h
SeeAlso: PORT 0530h"Sound System"
--------s-P0F8D------------------------------
PORT 0F8D - OPTi 82C750 (Vendetta) - AUDIO MODULE BASE ADDRESS REGISTER
SeeAlso: PORT 0F8Eh,PORT 0530h"Vendetta"

0F8D  RW  "MCBase" base register (see #P0948)

Bitfields for OPTi "Vendetta" (82C750) audio module base register:
Bit(s)	Description	(Table P0948)
 7	index/data port access protection disable
 6-5	reserved
 4-0	index/data port address bits 8-4
	  (bits 15-9 = 0000111; bits 3-0 = 1110 for index port, data port +1)
SeeAlso: #P0949
----------P0F8E0F8F--------------------------
PORT 0F8E-0F8F - OPTi "Vendetta" (82C750) CHIPSET - Audio Module Data Registers
Range:	The I/O address range is selectable using port 0F8Dh from among
	  0ExE-0ExF and 0FxE-0FxF
SeeAlso: PORT 0F8Dh,PORT 0530h"Vendetta"

0F8E  RW  "MCIdx" index register (see #P0949)
0F8F  RW  "MCData" data register

(Table P0949)
Values for OPTi "Vendetta" (82C750) Audio Module configuration registers:
 00h	disable
 01h	base/type configuration register (see #P0950)
 02h	reserved
 03h	Sound Blaster/Windows Sound System configuration register (see #P0951)
 04h	user programmable general purpose register (see #P0952)
 05h	option register (see #P0953)
 06h	MIDI interface register (write-only) (see #P0954)
 07h	semaphore software register
 08h	reserved
 09h	test control register 1 (see #P0955)
 0Ah	test control register 2 (see #P0956)
 0Bh	status register (read-only) (see #P0957)
 0Ch	test register (see #P0958)
 0Dh	PNP status register (read-only) (see #P0959)
 0Eh	PNP card select number register (read-only)
 0Fh	PNP read port address register (read-only)
 10h	volume control register (see #P0960)
 11h	reserved (serial EEPROM)
 12h	CONFIG status register (see #P0961)
 13h	FM control register (see #P0962)
 14h	reserved (GPIO control)
 15h	serial audio control register 0 (see #P0963)
 16h	serial audio control register 1 (see #P0964)
 17h	reserved

Bitfields for OPTi "Vendetta" Audio Module base/type configuration register:
Bit(s)	Description	(Table P0950)
 7	Sound Blaster base I/O address
	0 = 220h
	1 = 240h
 6	reserved
 5-4	Windows Sound System base I/O address
	00 = 530h
	01 = E80h
	10 = F40h
	11 = 640h
 3-1	reserved
 0	game port enable
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module SB/WSS configuration register:
Bit(s)	Description	(Table P0951)
 7	reserved
 6	reserved (0 for normal WSS operation)
 5-3	digital audio processor IRQ
	000 = disable
	001 = IRQ7
	010-100 = IRQ9-IRQ11
	101 = IRQ5
	110-111 = reserved
 2-0	digital audio processor DMA
	000 = disable
	001-010 = QRQ0-DRQ1
	011 = DRQ3
	100 = disable, DRQ1 (if dual channel DMA mode)
	101 = DRQ0, DRQ1 (if dual channel DMA mode)
	110 = DRQ1, DRQ0 (if dual channel DMA mode)
	111 = DRQ3, DRQ0 (if dual channel DMA mode)
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module user programmable general purpose:
Bit(s)	Description	(Table P0952)
 7-6	playback FIFO flow
	00 = empty
	01 = full-2
	10 = full-4
	11 = not full
 5-4	OPL select
	00 = OPL2
	01 = OPL3
	10 = OPL4
	11 = OPL5
 3	D/A controller zero
	0 = hold
	1 = clear
 2	audio enable
 1-0	Sound Blaster version
	00 = 2.1
	01 = 1.5
	10 = 3.2
	11 = 4.4
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module option register:
Bit(s)	Description	(Table P0953)
 7-6	reserved
 5	codec expanded mode enable
	  (must be set to access expanded mode codec indirect registers
	  10h-1Fh)
 4	Sound Blaster ADPCM enable
 3	Sound Blaster command FIFO enable
 2	Sound Blaster Pro mixer voice volume emulation volume effect enable
 1	DMA watchdog timer enable
 0	reserved
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module MIDI interface register:
Bit(s)	Description	(Table P0954)
 7	MPU-401 enable
 6-5	MPU-401 base address
	00 = 330h
	01 = 320h
	10 = 310h
	11 = 300h
 4-3	MPU-401 IRQ
	00 = IRQ9
	01 = IRQ10
	10 = IRQ5
	11 = IRQ7
 2	reserved
 1	Windows Sound System mode enable
 0	Sound Blaster mode enable
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module test control register 1:
Bit(s)	Description	(Table P0955)
 7	digital power-down
 6	analog power-down
 5-2	reserved
 1	software reset enable
 0	reserved
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module test control register 2:
Bit(s)	Description	(Table P0956)
 7	playback reset
 6	capture reset
 3	PNP test
 2-0	reserved
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module status register:
Bit(s)	Description	(Table P0957)
 7	playback DMA pending
 6	capture DMA pending
 5	MPU interrupt pending
 4	reserved
 3	capture interrupt pending
 2	playback interrupt pending
 1	playback FIFO empty
 0	capture FIFO empty
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module test register:
Bit(s)	Description	(Table P0958)
 7-5	reserved
 4	digital test output high/low byte (write-only)
 3-0	digital test output select (write-only)
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module PNP status register:
Bit(s)	Description	(Table P0959)
 7	CSN not 0, active high
	1 = CSN assigned by PNP configuration manager
 6-5	reserved
 4	audio module logical device enable
 3	1 = audio module PNP logic in CONFIG mode
 2	1 = audio module PNP logic in ISOLATE mode
 1	1 = audio module PNP logic in SLEEP mode
 0	1 = audio module PNP logic in WAIT4KEY mode
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module volume control register:
Bit(s)	Description	(Table P0960)
 7-4	reserved
 3	master volume mute
 2-0	reserved
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module CONFIG status register:
Bit(s)	Description	(Table P0961)
 7	reserved
 6	ASIO enable
 5-4	reserved
 3-0	chip revision ID (read-only)
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module FM control register:
Bit(s)	Description	(Table P0962)
 7-3	reserved
 2	mega bass enable
 1	enhanced FM feature OPTi mode enable
 0	external FM enable
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module serial audio control register 0:
Bit(s)	Description	(Table P0963)
 7-6	FDAC clock controller
	00 = reserved
	01 = internal FM
	10 = reserved
	11 = external serial audio
 5-2	reserved
 1	FDAC data
	0 = internal FM
	1 = external serial audio
 0	reserved
SeeAlso: #P0949

Bitfields for OPTi "Vendetta" Audio Module serial audio control register 1:
Bit(s)	Description	(Table P0964)
 7	ASIO reset
 6	ASIO test
 5-4	reserved
 3	SCLK polarity
	0 = reverse
	1 = no change
 2	FSYNC polarity
	0 = reverse
	1 = no change
 1-0	reserved
SeeAlso: #P0949
----------P0xx00xxF--------------------------
PORT 0xx0-0xxF - Intel 82595TX - ISA/PCMCIA Ethernet Controller
Range:	at any multiple of 16 in first 1024 I/O addresses

+000  RW  command register (see #P0965)
--- I/O bank 0 ---
+001  RW  status register (see #P0966)
+002  RW  id register (see #P0967)
+003  RW  mask register (see #P0968)
+004  RW  RCV CAR/BAR low
+005  RW  RCV CAR/BAR high
+006  RW  RCV STOP REG low
+007  RW  RCV STOP REG high
+008  RW  RCV copy treshold REG
+009  RW  reserved
+00A  RW  XMT CAR/BAR low
+00B  RW  XMT CAR/BAR high
+00C  RW  host address reg/32-bit I/O (byte 0) low
+00D  RW  host address reg/32-bit I/O (byte 1) high
+00E  RW  local memory/32-bit I/O (byte 2) IO port low
+00F  RW  local memory/32-bit I/O (byte 3) IO port high
--- I/O bank 1 ---
+001  RW  bank 1 register 1 (see #P0969)
+002  RW  int select register (see #P0970)
+003  RW  I/O mapping register (see #P0971)
+004  RW  reserved
+005  RW  reserved
+006  RW  reserved
+007  RW  RCV BOF treshold reg
+008  RW  RCV lower limit reg high byte
+009  RW  RCV upper limit reg high byte
+00A  RW  XMT lower limit reg high byte
+00B  RW  XMT upper limit reg high byte
+00C  RW  FLASH control register (see #P0972)
+00D  RW  bank 1 register 13 (see #P0973)
+00E  RW  reserved
+00F  RW  reserved
--- I/O bank 2 ---
+001  RW  bank 2 register 1 (see #P0974)
+002  RW  bank 2 register 2 (see #P0975)
+003  RW  bank 2 register 3 (see #P0976)
+004  RW  individual address register 0
+005  RW  individual address register 1
+006  RW  individual address register 2
+007  RW  individual address register 3
+008  RW  individual address register 4
+009  RW  individual address register 5
+00A  RW  bank 2 register 10 (see #P0977)
+00B  RW  RCV NO resource counter
+00C  RW  IAPROM IO port
+00D  RW  reserved
+00E  RW  reserved
+00F  RW  reserved
------

Bitfields for Intel 82595TX command register:
Bit(s)	Description	(Table P0965)
 7-6	bank pointer (if switch bank command written; ignored for other
	  commands)
	00 = bank 0
	01 = bank 1
	10 = bank 2
 5	command (other than transmit) aborted (read-only; should be written 0)
 4-0	(write) command OP code
	00h = switch bank/nop
	03h = MC-setup
	04h = transmit
	05h = TDR
	06h = dump
	07h = diagnose
	08h = RCV enable
	0Ah = RCV disable
	0Bh = RCV stop
	0Dh = abort
	0Eh = reset
	14h = XMT no CRC/SA
	15h = cont XMT test
	16h = set tristate
	17h = reset tristate
	18h = power down
	1Ch = resume XMT list
	1Eh = sel reset
	(read) execution event (MC done, init done, TDR done, DIAG done)
	  (if bank 0 register 1 bit 3 = 1)
SeeAlso: #P0966,#P0968

Bitfields for Intel 82595TX status register:
Bit(s)	Description	(Table P0966)
 7-6	RCV states
 5-4	EXEC states
 3	EXEC INT
 2	TX INT
 1	RX INT
 0	RX STP INT
SeeAlso: #P0965,#P0967,#P0968

Bitfields for Intel 82595TX id register:
Bit(s)	Description	(Table P0967)
 7-6	counter
 5	reserved (1)
 4	auto enable
 3-2	reserved (01)
 1-0	reserved (0)
SeeAlso: #P0965,#P0966,#P0968

Bitfields for Intel 82595TX mask register:
Bit(s)	Description	(Table P0968)
 7-6	reserved
 5	cur/base
 4	32IO/HAR
 3	EXEC mask
 2	TX mask
 1	RX mask
 0	RX STP mask
SeeAlso: #P0965,#P0966,#P0969

Bitfields for Intel 82595TX bank 1 register 1:
Bit(s)	Description	(Table P0969)
 7	tri-st INT
 6	alt RDY tm
 5-2	reserved
 1	host bus wd
 0	reserved
SeeAlso: #P0965,#P0967,#P0970

Bitfields for Intel 82595TX int select register:
Bit(s)	Description	(Table P0970)
 7	FL/BT detect
 6-4	boot EPROM/FLASH decode window
 3	reserved
 2-0	INT select

Bitfields for Intel 82595TX I/O mapping register:
Bit(s)	Description	(Table P0971)
 7-6	reserved
 5-0	I/O mapping window

Bitfields for Intel 82595TX FLASH control register:
Bit(s)	Description	(Table P0972)
 7-6	FLASH page select high
 5-4	FLASH write enable
 3-0	FLASH page select

Bitfields for Intel 82595TX bank 1 register 13:
Bit(s)	Description	(Table P0973)
 7-3	reserved
 2	SMOUT out en
 1	AL RDY test
 0	AL RDY PAS/FL

Bitfields for Intel 82595TX bank 2 register 1:
Bit(s)	Description	(Table P0974)
 7	disc bad fr
 6	TX chn ErStp
 5	TX chn int md
 4	PCMCIA/ISA
 3-1	reserved
 0	TX con proc en

Bitfields for Intel 82595TX bank 2 register 2:
Bit(s)	Description	(Table P0975)
 7-6	loopback
 5	multi IA
 4	no SA ins
 3	length enable
 2	RX CRC InMem
 1	BC DIS
 0	PRMSC mode

Bitfields for Intel 82595TX bank 2 register 3:
Bit(s)	Description	(Table P0976)
 7	test 1
 6	test 2
 5	BNC/TPE
 4	APORT
 3	jabber disable
 2	TPE/AUI
 1	pol/corr
 0	lnk in disable

Bitfields for Intel 82595TX bank 2 register 10:
Bit(s)	Description	(Table P0977)
 7-5	stepping
 4	trnoff enable
 3	EEDO
 2	EEDI
 1	EECS
 0	EESK
--------X-P100010FF--------------------------
PORT 1000-10FF - available for EISA slot 1
----------P1010------------------------------
PORT 1010 - Wang PC - SCREEN 1 CONFIGURATION PORT
SeeAlso: PORT 1020h,PORT 1030h,PORT 1040h,MEM F000h:0000h"Wang"

1010  ?W  write 01h to map screen buffer 1 into memory at F000h:0000h
	  write 00h to unmap the screen buffer
----------P1020------------------------------
PORT 1020 - Wang PC - SCREEN 2 CONFIGURATION PORT
SeeAlso: PORT 1010h,PORT 1030h,PORT 1040h,MEM F000h:0000h"Wang"

1020  ?W  write 01h to map screen buffer 2 into memory at F000h:0000h
	  write 00h to unmap the screen buffer
----------P1030------------------------------
PORT 1030 - Wang PC - SCREEN 3 CONFIGURATION PORT
SeeAlso: PORT 1010h,PORT 1020h,PORT 1040h,MEM F000h:0000h"Wang"

1030  ?W  write 01h to map screen buffer 3 into memory at F000h:0000h
	  write 00h to unmap the screen buffer
----------P1040------------------------------
PORT 1040 - Wang PC - SCREEN 4 CONFIGURATION PORT
SeeAlso: PORT 1010h,PORT 1020h,PORT 1030h,MEM F000h:0000h"Wang"

1040  ?W  write 01h to map screen buffer 4 into memory at F000h:0000h
	  write 00h to unmap the screen buffer
----------P12E812EF--------------------------
PORT 12E8-12EF - 8514/A and compatible (e.g. ATI Graphics Ultra) - VERT TOTAL

12E8w -W  CRT control: vertical total
--------V-P12EE------------------------------
PORT 12EE - ATI Mach32 - CONFIGURATION STATUS 0
SeeAlso: PORT 16EEh"Mach32",PORT 42EEh"Mach32",PORT 52EEh"Mach32"
----------P13901393--------------------------
PORT 1390-1393 - cluster (adapter 3)
----------P13C6------------------------------
PORT 13C6 - Compaq - VIDEO STATUS???
Note:	this port is read by the Compaq MS-DOS 4.0/5.0 CHARSET utility

13C6  R?  Compaq video status??? (see #P0978)

Bitfields for Compaq video status???:
Bit(s)	Description	(Table P0978)
 7	???
 6	flag
 5-3	???
 2-0	status of display???
	(in the context of video mode detection on mono/color systems)
--------X-P140014FF--------------------------
PORT 1400-14FF - available for EISA slot 1
----------P16E816EF--------------------------
PORT 16E8-16EF - 8514/A and compatible (e.g. ATI Graphics Ultra) - VERT DISPLYD

16E8w -W  CRT control: vertical displayed
--------V-P16EE------------------------------
PORT 16EE - ATI Mach32 - CONFIGURATION STATUS 1
SeeAlso: PORT 12EEh"Mach32",PORT 42EEh"Mach32",PORT 52EEh"Mach32"
--------X-P180018FF--------------------------
PORT 1800-18FF - available for EISA slot 1
----------P1AE81AEF--------------------------
PORT 1AE8-1AEF - 8514/A and compatible (e.g. ATI Graphics Ultra) - VSYNC START

1AE8w -W  CRT control: vertical sync start
--------X-P1C001CFF--------------------------
PORT 1C00-1CFF - available for EISA slot 1
--------d-P1C001CBF--------------------------
PORT 1C00-1CBF -  Adaptec AIC-777x EISA SCSI controller in EISA slot 1
Notes:	Adaptec AIC-777x SCSI controllers have on-board PhaseEngine SCSI
	  sequence processor which executes its instructions from the 2-Kbyte
	  sequencer RAM; it treats all of the CPU-addressable registers as its
	  data memory
	AIC-777x SCSI controllers have special on-board RAM and queue registers
	  for queueing the requests sent from the drivers and BIOS to the
	  PhaseEngine processor
	Adaptec AHA-284x is a VLB SCSI controller based on AIC-7770; it has
	  a serial EEPROM (93C46) for storing various configuration settings
SeeAlso: PORT 0340h-035Fh"Adaptec AHA-152x",PORT xxxxh"Adaptec AIC-78xx"

+000  RW  SCSI sequence control register (SCSISEQ) (see #P0600)
+001  RW  SCSI transfer control register 0 (SXFRCTL0) (see #P0979)
+002  RW  SCSI transfer control register 1 (SXFRCTL1) (see #P0980)
+003  R-  SCSI control signal read  register (SCSISIGI) (see #P0603)
+003  -W  SCSI control signal write register (SCSISIGO) (see #P0604)
+004  RW  SCSI rate control register (SCSIRATE) (see #P0981)
+005  RW  SCSI ID register (SCSIID) (see #P0982)
+006  RW  SCSI latched data low register (SCSIDATL)
	  read/write causes -ACK to pulse
+007  RW  (Wide SCSI) SCSI latched data high register (SCSIDATH)
	  read/write causes -ACK to pulse
+008  RW  SCSI transfer count register (STCNT) (3 bytes long)
+00B  R-  SCSI status register 0 (SSTAT0) (see #P0607)
+00B  -W  clear SCSI interrupt register 0 (CLRSINT0) (see #P0983)
+00C  R-  SCSI status register 1 (SSTAT1) (see #P0609)
+00C  -W  clear SCSI interrupt register 1 (CLRSINT1) (see #P0610)
+00D  R-  SCSI status register 2 (SSTAT2) (see #P0984)
+00E  R-  SCSI status register 3 (SSTAT3) (see #P0612)
+00F  RW  SCSI test control register (SCSITEST) (see #P0985)
+010  RW  SCSI interrupt mode register 0 (SIMODE0) (see #P0616)
+011  RW  SCSI interrupt mode register 1 (SIMODE1) (see #P0617)
+012  RW  SCSI data bus low register (SCSIBUSL)
+013  RW  (Wide SCSI) SCSI data bus high register (SCSIBUSH)
+014d R-  SCSI/host address register (SHADDR)
+018  RW  selection timeout timer  register (SELTIMER) (see #P0986)
+019  RW  selection/reselection ID register (SELID) (see #P0987)
+01F  RW  SCSI block control register (SBLKCTL) (see #P0988)
+020  RW  scratch RAM (64 bytes) (see #P1002)
+060  RW  sequencer control  register (SEQCTL)	(see #P0989)
+061  RW  sequencer RAM data register (SEQRAM)
+062w RW  sequencer address  register (SEQADDR) (see #P0990)
+064  RW  accumulator  register (ACCUM)
+065  RW  source index register (SINDEX)
+066  RW  destination index register (DINDEX)
+069  R-  all ones register (ALLONES)
	  always reads as FFh
+06A  R-  all zeros register (ALLZEROS)
	  always reads as 00h
+06B  R-  flags register (FLAGS) (see #P0991)
	  PhaseEngine processor's flags
+06C  R-  source indirect register (SINDIR)
+06D  -W  destination indirect register (DINDIR)
+06E  RW  function 1 register (FUNCTION1)
+06F  R-  "STACK"
+084  RW  board control register (BCTL) (see #P0992)
+085  RW  bus on/off time register (BUSTIME) (see #P0993)
+086  RW  bus speed register (BUSSPD) (see #P0994)
+087  RW  host control register (HCNTRL) (see #P0995)
+088d RW  host address register (HADDR)
+08C  RW  host counter register (HCNT) (3 bytes long)
+090  RW  sequence control block (SCB) pointer register (SCBPTR)
+091  RW  interrupt status register (INTSTAT) (see #P0996)
+092  R-  hard error register (ERROR) (see #P0997)
+092  -W  clear interrupt status register (CLRINT) (see #P0998)
+093  RW  DMA FIFO control register (DFCNTRL)  (see #P0999)
+094  R-  DMA FIFO status  register (DFSTATUS) (see #P1000)
+099  RW  DMA FIFO data register (DFDAT)
+09A  RW  SCB auto-increment register (SCBCNT) (see #P1001)
+09B  RW  queue in FIFO register (QINFIFO)
	  write places the value into the FIFO, read removes
+09C  R-  queue in count register (QINCNT)
	  number of the SCBs in the queue in
+09D  R-  queue out FIFO register (QOUTFIFO)
	  read removes the value from the FIFO
+09E  R-  queue out count register (QOUTCNT)
	  number of the SCBs in the queue out
+0A0  RW  SCB array (32 bytes) (see #P1003)
+0C0  RW  (AHA-284x) serial EEPROM control register (SEECTL) (see #P1005)
+0C1  RW  (AHA-284x) "STATUS" (see #P1006)
Notes:	the SCSI latched data registers are used to transfer data on the SCSI
	  bus during automatic or manual PIO mode
	in a twin channel configuration the separate register set with the
	  addresses 00h-1Eh exists for each channel
	the SCSI/host address register (SHADDR) holds the host address for the
	  byte about to be transfered on the SCSI bus; it is counted up in the
	  same manner as SCSI transfer count register (STCNT) is counted down
	  and should always be used to determine the address of the last byte
	  transfered since the host address register (HADDR) can be skewed by
	  read ahead
	the source/destination index registers (SINDEX/DINDEX) are used by the
	  PhaseEngine processor to indirectly address the data memory (i.e. the
	  CPU-addressable registers); the data byte addressed can be accessed
	  through the source/destination indirect registers (SINDIR/DINDIR)
	  respectively; the source index register (SINDEX) is auto-incremented
	  on each read from the source indirect register (SINDIR), while the
	  destination index register (DINDEX) is auto-incremented on each write
	  to the destination indirect register (DINDIR)
	the function 1 register (FUNCTION1) is used to convert the SCSI target
	  number to the corresponding bit mask; first, bits 6-4 are written
	  with a number N (other bits seems to be "don't care"), then the
	  register is read back, giving the bit mask having bit N set and all
	  other bits cleared
	the host address register (HADDR) and the host counter register (HCNT)
	  are used for the DMA transfers from/to the host memory
	the SCB pointer register (SCBPTR) selects the 32-byte area of the SCB
	  RAM to be mapped at addresses A0h-BFh
	the queue in/out FIFO registers (QINFIO/QOUTFIFO) hold the queue of
	  the SCB pointer register's (SCBPTR) values for addressing the SCBs
	  sent by CPU to the PhaseEngine processor and returned to CPU (when
	  the associated SCSI command completes) respectively; CPU selects
	  the SCB RAM area via the SCB pointer register (SCBPTR), downloads
	  prepared SCB to addresses A0h-BFh (this requeires the PhaseEngine
	  processor to be paused), then places the SCB pointer value to the
	  queue in FIFO by writing it to the respective register, from which
	  the SCB pointers can be read (and removed) in the FIFO order; the
	  PhaseEngine processor places the SCB pointer of the completed CCB
	  to the queue out FIFO by writing the respective register, and CPU
	  can remove it from the FIFO by reading the register

Bitfields for SCSI transfer control register 0 (SXFRCTL0):
Bit(s)	Description	(Table P0979)
 7	DMA FIFO on? (DFON)
 6	"DFPEXP"
 5	(Ultra SCSI) Ultra SCSI enable (ULTRAEN)
 4	clear SCSI transfer counter (CLRSTCNT)
 3	SCSI PIO enable (SPIOEN)
 2	SCAM enable (SCAMEN)
 1	clear channel (CLRCHN)
 0	reserved
SeeAlso: #P0607,#P0618,#P0620,#P0980,#P0984

Bitfields for SCSI transfer control register 1 (SXFRCTL1):
Bit(s)	Description	(Table P0980)
 7	bit bucket (BITBUCKET)
 6	SCSI counter wrap enable (SWRAPEN)
 5	enable SCSI parity check (ENSPCHK)
 4-3	selection time-out select (STIMESEL)
	00 256 ms
	01 128 ms
	10 64  ms
	11 32  ms
 2	enable selection timer (ENSTIMER)
 1	active negation enable (ACTNEGEN)
 0	SCSI terminator power enable? (STPWEN)
SeeAlso: #P0600,#P0979,#P0986

Bitfields for SCSI rate control register (SCSIRATE):
Bit(s)	Description	(Table P0981)
 7	(Wide SCSI) wide transfer control (WIDEXFER)
 6-4	synchronous transfer rate (SXFR)
 3-0	synchronous offset (SOFS)
SeeAlso: #P0605,#P0984

Bitfields for SCSI ID register (SCSIID):
Bit(s)	Description	(Table P0982)
 7-4	target ID (TID)
 3-0	our ID (OID)
SeeAlso: #P0606,#P0987,#P1012

Bitfields for clear SCSI interrupt register 0 (CLRSINT0):
Bit(s)	Description	(Table P0983)
 7	reserved?
 6	clear selection out done (CLRSELDO)
 5	clear selection in  done (CLRSELDI)
 4	clear selection in progress (CLRSELINGO)
 3	clear SCSI counter wrap (CLRSWRAP)
 2	reserved
 1	clear SCSI PIO ready (CLRSPIORDY)
 0	reserved
SeeAlso: #P0600,#P0601,#P0607,#P0608,#P0616

Bitfields for SCSI status register 2 (SSTAT2):
Bit(s)	Description	(Table P0984)
 7	"OVERRUN"
 6-5	reserved
 4-0	SCSI FIFO count? (SFCNT)
SeeAlso: #P0979,#P0981

Bitfields for SCSI test control register (SCSITEST):
Bit(s)	Description	(Table P0985)
 7-3	reserved
 2	"RQAKCNT"
 1	"CNTRTEST"
 0	"CMODE"
SeeAlso: #P0988

Bitfields for selection timeout timer register (SELTIMER):
Bit(s)	Description	(Table P0986)
 7-6	reserved
 5	"STAGE6"
 4	"STAGE5"
 3	"STAGE4"
 2	"STAGE3"
 1	"STAGE2"
 0	"STAGE1"
SeeAlso: #P0980

Bitfields for selection/reselection ID register (SELID):
Bit(s)	Description	(Table P0987)
 7-4	selecting device ID (SELID)
 3	one bit (ONEBIT)
 2-0	reserved
Note:	bit 3 is set when the selecting/reselecting device did not set its own
	  ID on the SCSI bus
SeeAlso: #P0600,#P0607,#P0982


Bitfields for SCSI block control register (SBLKCTL):
Bit(s)	Description	(Table P0988)
 7-6	reserved
 5	auto-flush disable (AUTOFLUSHDIS)
 4	reserved
 3	select bus (SELBUS)
	=0 select bus A
	=1 select bus B (SELBUSB)
 2	reserved
 1	"SELWIDE"
 0	reserved
Notes:	bit 1 allows for the coexistence of 8-bit and 16-bit devices on a Wide
	  SCSI bus
	in a twin channel configuration addresses 00h-1Eh are gated to the
	  appropriate channel based on the value of bit 3
	bit 5 is read only on the AIC-7770 revisions prior to E

Bitfields for sequencer control register (SEQCTL):
Bit(s)	Description	(Table P0989)
 7	parity error disable (PERRORDIS)
 6	pause disable (PAUSEDIS)
 5	"FAILDIS"
 4	fast mode (FASTMODE)
 3	break address interrupt enable (BRKADRINTEN)
 2	"STEP"
 1	sequencer reset (SEQRESET)
 0	load sequencer RAM (LOADRAM)
Notes:	setting bit 1 causes the sequencer to be paused; the sequencer address
	  register is reset to 0
	bit 7 should be reset while loading the sequencer RAM; after loading
	  is complete, bit 0 should be cleared before changing the sequencer
	  address register (SEQADDR) to avoid sequencer RAM parity errors
SeeAlso: #P0990,#P0996,#P0997,#P0998,#P1014

Bitfields for sequencer address register (SEQADDR):
Bit(s)	Description	(Table P0990)
 15-9	reserved
 8-0	sequencer RAM address
Notes:	bits 8-0 contain the address of a DWORD in the sequencer RAM; it points
	  to the next instruction to be execute or load into RAM
	setting bit 1 in the sequencer control register (SEQCTL) resets this
	  address to 0
	when the PhaseEngine processor is paused, the sequencer address can be
	  altered and a sequencer program can be loaded by writing it, byte by
	  byte, to the sequencer RAM data register (SEQRAM); the address is
	  auto-incremented after the high BYTE of each DWORD is loaded
SeeAlso: #P0989,#P1014

Bitfields for flags register (FLAGS):
Bit(s)	Description	(Table P0991)
 7-2	reserved
 1	zero  flag (ZERO)
 0	carry flag (CARRY)
SeeAlso: #P1014

Bitfields for board control register (BCTL):
Bit(s)	Description	(Table P0992)
 7-4	reserved
 3	"ACE"
 2-1	reserved
 0	enable board (ENABLE)
Note:	bit 3 is somehow related to the support for the external processors

Bitfields for bus on/off time register (BUSTIME):
Bit(s)	Description	(Table P0993)
 7-4	bus off time (BOFF)
	in 4 BCLK cycle units?
 3-0	bus on	time (BON)
SeeAlso: #P0994,#P1002

Bitfields for bus speed register (BUSSPD):
Bit(s)	Description	(Table P0994)
 7-6	DMA FIFO threshold (DFTHRSH)
	11 100?
 5-3	"STBOFF"
 2-0	"STBON"
SeeAlso: #P0993,#P0999,#P1000,#P1002

Bitfields for host control register (HCNTRL):
Bit(s)	Description	(Table P0995)
 7	reserved
 6	power down (POWRDN)
 5	reserved
 4	software interrupt (SWINT)
 3	IRQ mode select (IRQMS)
	=0 level-sensitive
	=1 edge-triggered
 2	pause sequencer (PAUSE)
 1	interrupt enable (INTEN)
 0	chip reset (CHIPRST)
Notes:	bit 0 is self-clearing (though on some AIC-7771 based boards it stucks
	  set, and must be manually cleared)
	set bit 2 to pause the sequencer, then poll the register until this bit
	  reads as 1 indicating that the sequencer has actually stopped; the
	  sequencer can disable pausing for critical sections through bit 6 of
	  the sequencer control register (SEQCTL)
SeeAlso: #P0989,#P1014

Bitfields for interrupt status register (INTSTAT):
Bit(s)	Description	(Table P0996)
 7-4	sequencer status
	0000 unknown SCSI bus phase (BAD_PHASE)
	0001 sending MESSAGE REJECT (SEND_REJECT)
	0010 no IDENTIFY after reconnect (NO_IDENT)
	0011 no command match for reconnect (NO_MATCH)
	0100 SYNCRONOUS DATA TRANSFER REQUEST (SDTR) message received (SDTR_MSG)
	0101 WIDE DATA TRANSFER REQUEST (WDTR) message received (WDTR_MSG)
	0110 MESSAGE REJECT received (REJECT_MSG)
	0111 bad status from target (BAD_STATUS)
	1000 residual byte count non-zero (RESIDUAL)
	1001 sent ABORT TAG message (ABORT_TAG)
	1010 awaiting message
	1011 immediate command completed (IMMEDDONE)
	1100 message buffer busy (MSG_BUFFER_BUSY)
	1101 MESSAGE IN phase mismatch (MSGIN_PHASEMIS)
	1110 data overrun (DATA_OVERRUN)
 3	break address interrupt (BRKADRINT)
 2	SCSI interrupt (SCSIINT)
 1	command complete interrupt (CMDCMPLT)
 0	sequencer interrupt (SEQINT)
Notes:	the PhaseEngine processor can set bit 0 to interrupt the CPU requesting
	  some service from it; an interrupt reason is passed in bits 7-4
	the PhaseEngine processor sets bit 1 after placing a completed SCB into
	  the queue out FIFO
	setting bit 0 pauses the PhaseEngine processor; it needs unpausing via
	  resetting bit 2 of the host control register (HCNTRL)
SeeAlso: #P0986,#P0993,#P0995,#P1014

Bitfields for hard error register (ERROR):
Bit(s)	Description	(Table P0997)
 7-4	reserved
 3	sequencer RAM parity error (PARERR)
 2	illegal opcode in sequencer program (ILLOPCODE)
 1	illegal sequencer address referenced (ILLSADDR)
 0	illegal host access (ILLHADDR)
Note:	usually a full board reset is required after detecting a hard error
SeeAlso: #P1014

Bitfields for clear interrupt status register (CLRINT):
Bit(s)	Description	(Table P0998)
 7-4	reserved
 3	clear break address interrupt (CLRBRKADRINT)
 2	clear SCSI interrupt (CLRSCSIINT)
 1	clear command complete interrupt (CLRCMDINT)
 0	clear sequencer interrupt (CLRSEQINT)
SeeAlso: #P0986,#P0991,#P1014

Bitfields for DMA FIFO control register (DFCNTRL):
Bit(s)	Description	(Table P0999)
 7	reserved
 6	"WIDEODD"
 5	SCSI enable (SCSIEN)
 4	SCSI DMA enable? (SDMAEN)
 3	host DMA enable? (HDMAEN)
 2	"DIRECTION"
	=0 SCSI to host
	=1 host to SCSI
 1	FIFO flush (FIFOFLUSH)
 0	FIFO reset (FIFORESET)
Notes:	this register allows the PhaseEngine processor to control DMA transfers
	  from/to host memory
	bits 3 and 4 clear automatically when host and SCSI DMA is complete
	  respectively
SeeAlso: #P0994,#P1000

Bitfields for DMA FIFO status register (DFSTATUS):
Bit(s)	Description	(Table P1000)
 7-6	reserved
 5	"DWORDEMP"
 4	"MREQPEND"
 3	host DMA done (HDONE)
 2	DMA FIFO threshold? (DFTHRESH)
 1	FIFO full  (FIFOFULL)
 0	FIFO empty (FIFOEMP)
SeeAlso: #P0994,#P0999

Bitfields for SCB auto-increment register (SCBCNT):
Bit(s)	Description	(Table P1001)
 7	SCB auto-increment (SCBAUTO)
 6-5	reserved
 4-0	SCB counter (SCBCNT)
Note:	this register allows CPU to quickly upload/download the SCBs to/from
	  the SCB RAM; if bit 7 is set any reference to addresses A0h-BFh post-
	  increments bits 4-0 of this register containing the offset into the
	  SCB array which is to be accessed next; on the AHA-284x only 8-bit
	  transfers can be used
SeeAlso: #P1003

Format of the scratch RAM:
Offset	Size	Description	(Table P1002)
 00h 16 BYTEs	target scratch (TARG_SCRATCH) (see #9025)
 10h	WORD	channel A Ultra SCSI enable (ULTRA_ENB_A)
		bit N if set means Ultra SCSI transfers are enabled for the
		  target ID N
 10h	BYTE	rejected byte (REJBYTE)
 11h	BYTE	channel B Ultra SCSI enable (ULTRA_ENB_B)
		bit N if set means Ultra SCSI transfers are enabled for the
		  target ID N
 11h	BYTE	rejected byte extended (REJBYTE_EXT)
 11h	BYTE	rejected byte (REJBYTE)
 12h	BYTE	channel A disable disconnect (DISC_DSB_A)
 13h	BYTE	channel B disable disconnect (DISC_DSB_B)
 14h	BYTE	length of pending message (MSG_LEN)
 15h  8 BYTEs	outgoing message (MSG0-MSG7)
 15h	BYTE	pending	 message flag (MSG_FLAGS)
 16h	BYTE	length of pending message (MSG_LEN)
 17h  ? BYTEs	outgoing message body (MSG_START)
 1Dh	BYTE	parameters for DMA logic (DMAPARAMS) (see #P0999)
 1Dh	BYTE	last phase (LASTPHASE)
 1Eh	BYTE	"SEQ_FLAGS"
		bit 7: "RESELECTED"
		bit 6: "IDENTIFY_SEEN"
		bit 5: "TAGGED_SCB"
		bit 4: data phase seen (DPHASE)
		bit 3: reserved
		bit 2: page SCBs (PAGESCBS)
		bit 1: "WIDE_BUS"
		bit 0: "TWIN_BUS"
 1Eh	BYTE	"ARG_1"
		bit 0: "MAXOFFSET"
 1Fh	BYTE	saved target/channel/LUN (SAVED_TCL)
		bits 7-4: target ID
		bit 3: channel (0=A, 1=B)
		bits 2-0: LUN
 1Fh	BYTE	"RETURN_1"
		00h do nothing
		10h SCB paged in (SCB_PAGEDIN)
		20h send MESSAGE REJECT message (SEND_REJ)
		40h send REQUEST SENSE	command (SEND_SENSE)
		60h send SYNCHRONOUS DATA TRANSFER REQUEST message (SEND_SDTR)
		80h send WIDE DATA TRANSFER REQUEST message (SEND_WDTR)
 20h	BYTE	scatter/gather count (SG_COUNT)
 20h	BYTE	"SIGSTATE"
 21h	DWORD	scatter/gather next segment pointer (SG_NEXT)
 21h	BYTE	parameters for DMA logic (DMAPARAMS) (see #P0999)
 22h	BYTE	scatter/gather count (SG_COUNT)
 23h	DWORD	scatter/gather next segment pointer (SG_NEXT)
 25h	BYTE	waiting SCB list head (WAITING_SCBH)
 26h	BYTE	saved link pointer (SAVED_LINKPTR)
 27h	BYTE	saved SCB pointer (SAVED_SCBPTR)
 27h	BYTE	SCB count (SCBCOUNT)
		number of SCBs supported in hardware
 28h	BYTE	last phase (LASTPHASE) (see #9003)
		bit 7: -C/D input (CDI)
		bit 6: -I/O input (IOI)
		bit 5: -MSG input (MSGI)
		bits 4-0: reserved
 28h	BYTE	negative SCB count (COMP_SCBCOUNT)
 29h	BYTE	extended message length (MSGIN_EXT_LEN)
 29h	BYTE	queue count mask (QCNTMASK)
		works around a bug in AIC-7850
 2Ah	BYTE	extended message opcode (MSGIN_EXT_OPCODE)
 2Ah	BYTE	"FLAGS"
		bit 7: "RESELECTED"
		bit 6: IDENTIFY message seen (IDENTIFY_SEEN)
		bit 5: "SELECTED"
		bit 4: data phase seen (DPHASE)
		bit 3: reserved
		bit 2: page SCBs (PAGESCBS)
		bit 1: wide bus	 (WIDE_BUS)
		bit 0: twin bus	 (TWIN_BUS)
 2Bh  3	BYTEs	extended message tail bytes (MSGIN_EXT_BYTES)
 2Bh	BYTE	saved target/channel/LUN (SAVED_TCL)
		bits 7-4: target ID
		bit 3: channel (0=A, 1=B)
		bits 2-0: LUN
 2Ch	WORD	channel A active targets (ACTIVE_A)
		bit N is set if there's untagged SCSI command currently active
		  on the target ID N
 2Ch	BYTE	"ARG_1" or "RETURN_1"
 2Dh	BYTE	channel B active targets (ACTIVE_B)
		bit N is set if there's untagged SCSI command currently active
		  on the target ID N
 2Dh	BYTE	"ARG_2"
 2Eh	BYTE	disconnected SCB list head (DISCONNECTED_SCBH)
 2Eh	BYTE	waiting SCB list head (WAITING_SCBH)
 2Eh	BYTE	signal state (SIGSTATE)
 2Fh	BYTE	free SCB list head (FREE_SCBH)
		disconnected SCB list head (DISCONNECTED_SCBH)
 2Fh	BYTE	"NEEDSDTR"
		bit N if set means that the synchronous data transfer needs to
		  be negotiated with the target ID N
 30h	DWORD	"HSCB_ADDR"
 30h	BYTE	saved link pointer (SAVED_LINKPTR)
 31h	BYTE	saved SCB  pointer (SAVED_SCBPTR)
 32h	WORD	channel A Ultra enable (ULTRA_ENB)
		bit N if set means Ultra SCSI transfers are enabled for the
		  target ID N
 33h	BYTE	channel B Ultra enable (ULTRA_ENB_B)
		bit N if set means Ultra SCSI transfers are enabled for the
		  target ID N
 34h	BYTE	"CUR_SCBID"
 35h	BYTE	"CMDOUTCNT"
		count of commands placed in the out FIFO
 36h	BYTE	SCB count (SCBCOUNT)
		number of SCBs supported in hardware
 36h	BYTE	"ARG_1" or "RETURN_1"
		bit 7: "SEND_MSG"
		bit 6: "SEND_SENSE"
		bit 5: "SEND_REJ"
		bits 4-0: reserved
 37h	WORD	channel A active targets (ACTIVE_A)
		bit N is set if there's untagged SCSI command currently active
		  on the target ID N
 39h	BYTE	reserved
 3Ah	WORD	SCSI configuration (SCSICONF)
		bits 15-12: reserved?
		bits 11-8: (Wide SCSI) our ID (see #P0982)
		bit 7: (AIC-777x) enable SCSI low byte termination (see #P1011)
		bit 6: enable SCSI bus reset at power up (RESET_SCSI)
			 (see #P1011)
		bit 5: enable SCSI parity check (ENSPCHK) (see #P0980)
		bits 4-3: selection time-out select (STIMESEL) (see #P0980)
		bits 2-0: our ID (see #P0982)
 3Bh	BYTE	channel B SCSI configuration
		see bits 7-0 above
 3Ch	BYTE	"INTDEF"
		bits 7-4: reserved?
		bits 3-0: IRQ number (IRQ9..IRQ12, IRQ14, and IRQ15 are valid)
 3Dh	BYTE	host configuration (HOSTCONF)
		bits 7-6: DMA FIFO threshold (DFTHRSH) (see #9038)
		bits 5-2: bus off time (BOFF) (see #9037)
		bits 1-0: reserved?
 3Eh	BYTE	reserved
 3Fh	BYTE	(AIC-7771) BIOS control (BIOSCTRL)
		bits 5-4: BIOS mode (BIOSMODE)
			  11 BIOS disabled (BIOSDISABLED)
		bit 3: channel B is primary (CHANNEL_B_PRIMARY)
Notes:	the scratch RAM is used for passing information between the driver and
	  BIOS and the code running on the PhaseEngine processor; it serves as
	  a working memory for the PhaseEngine processor as well
	location definitions overlap due to various sources giving different
	  scratch RAM layouts
	the PhaseEngine processor uses "ARG_1" and "ARG_2" to pass parameters
	  to the drivers and BIOS during sequencer interrupts; "RETURN_1" is used
	  to return results from the drivers and BIOS to the PhaseEngine code
	the PhaseEngine processor uses SCB pointer register's (SCBPTR) values
	  to link SCB in the lists, with value FFh indicating the end of list
SeeAlso: #9047,#9048

Format of the SCB array:
Offset	Size	Description	(Table P1003)
 00h	BYTE	"SCB_CONTROL"
		bit 7: need WDTR message (NEEDWDTR) or
		       "MK_MESSAGE"
		bit 6: disconnect enable (DISCENB)
		bit 5: tagging enable (TAG_ENB)
		bit 4: need SDTR message (NEEDSDTR) or
		       "MUST_DMAUP_SCB"
		bit 3: "ABORT_SCB"
		bit 2: "DISCONNECTED"
		bits 1-0: command tag type (SCB_TAG_TYPE)
 01h	BYTE	target/channel/LUN (SCB_TCL)
		bits 7-4: target ID
		bit 3: channel (0=A, 1=B)
		bits 2-0: LUN
 02h	BYTE	target status (SCB_TARGET_STATUS)
		SCSI status byte
 03h	BYTE	scatter/gather count (SCB_SGCOUNT)
 04h	DWORD	scatter/gather pointer (SCB_SGPTR)
 08h	BYTE	residual scatter/gather count (SCB_RESID_SGCNT)
 09h  3 BYTEs	residual data count (SCB_RESID_DCNT)
 0Ch	DWORD	data pointer (SCB_DATAPTR)
 10h  3 BYTEs	data count (SCB_DATACNT)
 13h	BYTE	next linked SCB index (SCB_LINKED_NEXT)
 14h	DWORD	command pointer (SCB_CMDPTR)
 18h	BYTE	command length (SCB_CMDLEN)
 19h	BYTE	command tag (SCB_TAG)
 1Ah	BYTE	next SCB index (SCB_NEXT)
 1Bh	BYTE	previous SCB index (SCB_PREV)
 1Ch  2	WORDs	busy targets (SCB_BUSYTARGETS)
		bit N is set if there's untagged SCSI command currently active
		  on the target ID N
SeeAlso: #P1004,#P1014

Format of the scatter/gather segment:
Offset	Size	Description	(Table P1004)
 00h	DWORD	physical address
 04h	DWORD	length
SeeAlso: #P1003,#P1014

Bitfields for AHA-284x serial EEPROM control register (SEECTL):
Bit(s)	Description	(Table P1005)
 7-3	reserved
 2	chip select (CS)
 1	clock (CK)
 0	data out (DO)
Notes:	93C46 serial EEPROM chips have 1024 bits organized into 64 16-bit
	  words and use 6 bits to address each word
	only the first 32 words of serial EEPROM are used by the Adaptec BIOS
	bits 2-0 are connected to the chip select, clock, and data out pins of
	  the serial EEPROM respectively
	bit 1 must be pulled high and then low for a minimum of 750 and 250 ns
	  to provide clocking for the EEPROM chip
	bit 1 going from low to high causes the EEPROM chip to sample the data
	  out pin and initiates the next bit to be sent through the data in pin
	bit 2 must be set for a minimum of 1 mcs with the bit 1 goig high and
	  then low for the EEPROM chip to be selected; then the instruction can
	  be sent to the EEPROM chip
	instruction can be terminated by taking the EEPROM chip select pin low,
	  with the bit 1 going high and low
SeeAlso: #P1006,#P1007,#P1008

Bitfields for AHA-284x "STATUS" register:
Bit(s)	Description	(Table P1006)
 7	EEPROM timer fired? (EEPROM_TF)
 6-5	"BIOS_SEL"
 4-1	"ADSEL"
 0	data in (DI)
Notes:	bit 0 is connected to the data in pin of the serial EEPROM; it can be
	  read after the clock pin goes from high to low
	bit 7 is cleared after a read from the serial EEPROM control register
	  (SEECTL) and goes high 800 ns later
SeeAlso: #P1005,#P1007,#P1008

(Table P1007)
Values for the 93C46 serial EEPROM instructions:
Opcode	   Function  Parameter	Description
0000xxxxb  EWDS	     -		disable all programming instructions
0001xxxxb  WRAL	     D15..D0	write to all registers
0010xxxxb  ERAL	     -		erase all registers
0011xxxxb  EWEN	     -		write enable
				must precede all programming modes
01AAAAAAb  WRITE     D15..D0	write register with address A5..A0
10AAAAAAb  READ	     -		read registers starting with address A5..A0
11AAAAAAb  ERASE     -		erase register with address A5..A0
Notes:	while the chip select pin remains high an instuction and the optional
	  parameter word can be clocked in MSB first, beginning with the start
	  bit of 1
	16-bit parameter and data words are transferred MSB first, beginning
	  with the start bit of 0
SeeAlso: #P1005,#P1006

Format of the AHA-284x serial EEPROM:
Address	Size	Description	(Table P1008)
 00h  16 WORDs	SCSI ID configuration (see #P1009)
 10h	WORD	BIOS control (see #P1011)
 11h	WORD	host adapter control (see #P1012)
 12h	WORD	bus release time / host adapter ID (see #P1013)
 13h	WORD	maximum targets (see #P1014)
 14h  11 WORDs	reserved
 1Fh	WORD	checksum
SeeAlso: #P1005,#P1006

Bitfields for the serial EEPROM SCSI ID configuration word:
Bit(s)	Description	(Table P1009)
 15-11	reserved
 10	report even if not found (CFRNFOUND)
 9	include in BIOS scan (CFINCBIOS)
 8	send START UNIT SCSI command (CFSTART)
 7-6	reserved
 5	(Wide SCSI) wide bus device (CFWIDEB)
 4	enable disconnection (CFDISC)
 3	enable synchronous transfer (CFSYNCH)
 2-0	synchronous transfer rate (CFXFER)
SeeAlso: #P0605,#P1008

Bitfields for the serial EEPROM BIOS control word:
Bit(s)	Description	(Table P1011)
 15-6	reserved
 5	extended translation (CFEXTEND)
 4	support more than 2 drives (CFSM2DRV)
 3	reserved
 2	BIOS enabled (CFBIOSEN)
 1	support removable drives for boot only (CFSUPREMB)
 0	support all removable drives (CFSUPREM)
SeeAlso: #P1008

Bitfields for the serial EEPROM host adapter control word:
Bit(s)	Description	(Table P1011)
 15-7	reserved
 6	reset SCSI bus at IC initialization (CFRESETB)
 5	SCSI low byte termination (CFSTERM)
	=0 disable
	=1 enable
 4	SCSI parity (CFSPARITY)
	=0 disable
	=1 enable
 3-2	FIFO threshold (CFFIFO)
 1-0	selection timeout (CFSELTO)
SeeAlso: #P0600,#P0980,#P0994,#P1008

Bitfields for the serial EEPROM bus release time / host adapter ID word:
Bit(s)	Description	(Table P1012)
 15-8	bus release time (CFBRTIME)
 7-4	reserved
 3-0	host adapter SCSI ID (CFSCSIID)
SeeAlso: #P0982,#P0989,#P1007

Bitfields for the serial EEPROM maximum targets word:
Bit(s)	Description	(Table P1013)
 15-8	reserved
 7-0	maximum targets (CFMAXTARG)
SeeAlso: #P1007

Bitfields for the PhaseEngine SCSI sequence processor instruction:
Bit(s)	Description	(Table P1014)
 31-29	reserved (0)
 28-25	opcode
	0000 OR	 dest,imm[,src] [RET]
	     MVI dest,imm [RET]
	0001 AND dest,imm[,src] [RET]
	     MOV dest,src [RET]
	     CLR dest [RET]
	     NOP [RET]
	     RET
	0010 XOR dest,imm[,src] [RET]
	     NOT dest [RET]
	0011 ADD dest,imm[,src] [RET]
	     INC dest[,src] [RET]
	     DEC dest[,src] [RET]
	     CLC [dest[,imm]] [RET]
	     STC dest [RET]
	0100 ADC dest,imm[,src] [RET]
	0101 SHL/SHR/ROL/ROR dest,[src,]imm [RET]
	1000 OR	 src,imm JMP addr
	     MOV src JMP addr
	     MVI imm JMP addr
	     JMP addr
	1001 OR	 src,imm JC addr
	     MOV src JC addr
	     MVI imm JC addr
	     JC addr
	1010 OR	 src,imm JNC addr
	     MOV src JNC addr
	     MVI imm JNC addr
	     JNC addr
	1011 OR	 src,imm CALL addr
	     MOV src CALL addr
	     MVI imm CALL addr
	     CALL addr
	1100 CMP  src,imm JNE addr
	1101 TEST src,imm JNZ addr
	1110 CMP  src,imm JE  addr
	1111 TEST src,imm JZ  addr
	others reserved
 24-16	(jump instructions) instruction address
 24	(non-jump instructions) return flag
 23-16	(non-jump instructions) destination register address
 15-8	source register address
 7-0	(shift instructions) shift control (see #P1015)
	(other instructions) immediate data
	if 0 accumulator register (ACCUM) is used instead
Notes:	the jump instructions with the OR/MOV/MVI prefixes implicitly use the
	  source index register (SINDEX) as destination
SeeAlso: #P0989,#P0990,#P0991,#P0995,#P0996,#P0997,#9042

Bitfields for the PhaseEngine shift control:
Bit(s)	Description	(Table P1015)
 7	clear all bits?
 6-4	number of bits to shift the AND mask (FFh)
 3	=0 shift the AND mask left
	=1 shift the AND mask right
 2-0	number of bits to rotate the source left
Notes:	the 8-bit source seems to be rotated left and then AND'ed with the mask
	  (FFh) which is shifted left or right prior to AND'ing in order to
	  perform all kinds of the shift/rotate instructions
	bit 7 is set (and bits 6-4 equal 7) if the shift count is greater than
	  7 specified for the SHL/SHR instructions
----------P1C65------------------------------
PORT 1C65 - Compaq Contura Aero
SeeAlso: PORT 2065h

1C65  R?  bit 6: operating on battery power
--------X-P1C801C8F--------------------------
PORT 1C80-1C8F - VESA XGA Video in EISA slot 1

1C80-1C83  RW	EISA Video ID
1C84  RW	EISA Video expansion board control (see #P1016)
1C85  RW	EISA Setup control
1C88  RW	EISA Video Programmable Option Select 0
1C89-1C8F  RW	EISA Video Programmable Option Select 1-7
--------X-P1C801C83--------------------------
PORT 1C80-1C83 - EISA board product ID (board in slot 1)

1C80  R?  bit 7: unused (0)
	  bits 6-2: manufacturer ID, first compressed ASCII char
	  bits 1-0: manufacturer ID, second compressed ASCII char (high)
1C81  R?  bits 7-5: manufacturer ID, second compressed ASCII char (low)
	  bits 4-0: manufacturer ID, third compressed ASCII char
1C82  R?  bits 7-4: first hex digit of product type
	  bits 3-0: second hex digit of product type
1C83  R?  bits 7-4: third hex digit of product type
	  bits 3-0: product revision number (hex digit)
--------X-P1C84------------------------------
PORT 1C84 - EISA CONFIGURATION FLAGS (board in slot 1)

1C84  RW  configuration flags (see #P1016)

Bitfields for EISA Add-in Card configuration flags:
Bit(s)	Description	(Table P1016)
 0	enable
 1	IOCHKERR (read-only) card is generating CHCHK#, causing an NMI
 2	IOCHKRST reset card
 7-3	card-specific
--------X-P1C85------------------------------
PORT 1C85 - EISA SETUP CONTROL (board in slot 1)
--------V-P1C85------------------------------
PORT 1C85 - Compaq Qvision EISA - Virtual Controller ID
--------X-P1C881C8F--------------------------
PORT 1C88-1C8F - EISA PROGRAMMABLE OPTION SELECT (board in slot 1)
--------V-P1EE81EEF--------------------------
PORT 1EE8-1EEF - 8514/A and compatible (e.g. ATI Graphics Ultra) - VSYNC WIDTH

1EE8w -W  CRT control: vertical sync width
--------V-P1EEC------------------------------
PORT 1EEC - Mach64 - ???

1EEC  RW  display power and other controls
	bits 3-2: DPMS power mode
		00 normal
		01 standby
		10 suspend
		11 off
--------X-P200020FF--------------------------
PORT 2000-20FF - available for EISA slot 2
----------P2065------------------------------
PORT 2065 - Compaq Contura Aero
SeeAlso: PORT 1C65h"Compaq",PORT 2465h"Compaq"

2065  -W  ??? (84h seen)
--------V-P2100------------------------------
PORT 2100 - XGA Video Operating Mode Register
Note:	this port is for the first XGA in the system; 2110-2170 are used for
	  the second through eighth XGAs
--------V-P2101------------------------------
PORT 2101 - XGA Video Aperture Control
Note:	this port is for the first XGA in the system; 2111-2171 are used for
	  the second through eighth XGAs
--------V-P21022103--------------------------
PORT 2102-2103 - XGA ???
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2104------------------------------
PORT 2104 - XGA Video Interrupt Enable
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2105------------------------------
PORT 2105 - XGA Video Interrupt Status
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2106------------------------------
PORT 2106 - XGA Video Virtual Memory Control
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2107------------------------------
PORT 2107 - XGA Video Virtual Memory Interrupt Status
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2108------------------------------
PORT 2108 - XGA Video Aperture Index
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P2109------------------------------
PORT 2109 - XGA Video Memory Access Mode
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P210A------------------------------
PORT 210A - XGA Video Index for Data
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P210B------------------------------
PORT 210B - XGA Video Data (byte)
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs
--------V-P210C210F--------------------------
PORT 210C-210F - XGA Video Data (word/dword)
Note:	this port is for the first XGA in the system; 211x-217x are used for
	  the second through eighth XGAs

210C  RW  byte data
210Cw RW  word data
210Cd RW  dword data
--------V-P2110211F--------------------------
PORT 2110-211F - IBM XGA (eXtended Graphics Adapter  8514/A) (second installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2120212F--------------------------
PORT 2120-212F - IBM XGA (eXtended Graphics Adapter  8514/A) (third installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2130213F--------------------------
PORT 2130-213F - IBM XGA (eXtended Graphics Adapter  8514/A) (fourth installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2140214F--------------------------
PORT 2140-214F - IBM XGA (eXtended Graphics Adapter  8514/A) (fifth installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2150215F--------------------------
PORT 2150-215F - IBM XGA (eXtended Graphics Adapter  8514/A) (sixth installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2160216F--------------------------
PORT 2160-216F - IBM XGA (eXtended Graphics Adapter 8514/A) (seventh installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P2170217F--------------------------
PORT 2170-217F - IBM XGA (eXtended Graphics Adapter 8514/A) (eighth installed)
Notes:	see individual 210x entries above
	c't says default instance number is 6, i.e. addresses 216x
--------V-P217A217B--------------------------
PORT 217A-217B - ET4000/W32 CRTC-B/Sprite
Note:	Alternative addresses may depend on adapter manufacturer,
	  Tseng claims 21xA with x=three address bits, selected by IOD2..0
	  during power up reset.

21xA  RW  ET4000/W32(i) CRTC-B/Sprite index register
	bit7-0: index
21xB  RW  ET4000/W32(i) CRTC-B/Sprite data register (see #P1017)

(Table P1017)
Values for ET4000/W32(i) CRTC-B/Sprite data register index:
 E0h	CRTC-B / Sprite Horizontal Pixel Position, Low
	   bit7-0: horizontal pixel position bit7-0
 E1h	CRTC-B / Sprite Horizontal Pixel Position, High
	   bit7-4: reserved
	   bit3-0: horizontal pixel position bit11-8
 E2h	CRTC-B Width Low / Sprite Horizontal Preset
	   bit7-0: width of CRTC-B bit7-0
	   bit5-0: horizontal preset for sprite
 E3h	CRTC-B Width High / Sprite Horizontal Preset
	   bit7-4: reserved
	   bit3-0: width of CRTC-B bit11-8
 E4h	CRTC-B / Sprite Vertical Pixel Position, Low
	   bit7-0: vertical pixel position bit7-0
 E5h	CRTC-B / Sprite Vertical Pixel Position, High
	   bit7-4: reserved
	   bit3-0: vertical pixel position bit11-8
 E6h	CRTC-B Height Low / Sprite Vertical Preset
	   bit7-0: height of CRTC-B bit7-0
	   bit5-0: vertical preset for sprite
 E7h	CRTC-B Height High / Sprite Vertical Preset
	   bit7-4: reserved
	   bit3-0: height of CRTC-B bit11-8
 E8h	CRTC-B / Sprite Starting Address Low
	   pointer to CRTC-B / sprite image in display memory.
	   (maximum size of sprites 64x64x4=1KB with 4 colors:
	    00b=color-0, 01b=color-255, 10b=transparent, 11b=reserved)
	   bit7-0: startaddress bit7-0
 E9h	CRTC-B / Sprite Starting Address Middle
	   bit7-0: startaddress bit15-8
 EAh	CRTC-B / Sprite Starting Address High
	   bit7-4: reserved
	   bit3-0: startaddress bit19-16
 EBh	CRTC-B / Sprite Row Offset Low
	   bit7-0: offset bit7-0
 ECh	CRTC-B / Sprite Row Offset High
	   bit7-4: revision ID (any ET4000/W32)
		    0000b=W32	     0100b-1111b reserved
		    0001b=W32i
		    0010b=W32p
		    0011b=W32i, new
	   bit3-0: offset bit11-8
 EDh	CRTC-B Pixel Panning
	   bit7-3: reserved
	   bit2-0: CRTC-B pixel panning
 EEh	CRTC-B Color-Depth-Register / Hardware-Zoom
	   bit7-4: reserved (concerning databook ET4000/W32)
	   bit7-6: vertical zoom (undocumented)
		   (original ET4000/W32 ok, doesn't work properly
		    with some ET4000/W32i)
		    00b=zoomx1	   10b=zoomx3
		    01b=zoomx2	   11b=zoomx4
	   bit5-4: horizontal zoom (undocumented)
		   (original ET4000/W32 ok, doesn't work properly
		    with some ET4000/W32i)
		    00b=zoomx1	   10b=zoomx3
		    01b=zoomx2	   11b=zoomx4
	   bit3-0: bit/pixel
		    0000b=1	   0011b=8
		    0001b=2	   0100b=16
		    0010b=4
 EFh	CRTC-B / Sprite Control
	   bit7-2: reserved
	   bit1	 : 1=2nd CRTC-B image overlays main CRTC-A image
		   0=CRTC-B image at pin SP1/0
	   bit0	 : 1=enable CRTC-B
		   0=enable sprite (see F7h)
 F7h	Image Port Control
	   bit7	 : 1=CRTC-B or sprite active
		   0=CRTC-B and sprite not active
	   bit6-0: reserved
----------P22E822EF--------------------------
PORT 22E8-22EF - 8514/A and compatible (e.g. ATI Graphics Ultra) - DISPLAY CTRL

22E8w -W  CRT control: display control
----------P2315------------------------------
PORT 2315 - QUAD EMS+ - "QEMS_BOARD1" - ???
SeeAlso: PORT 05FBh"QUAD",PORT 2316h,PORT 2717h
----------P2316------------------------------
PORT 2316 - QUAD EMS+ - "QEMS_BOARD2" - ???
SeeAlso: PORT 05FBh"QUAD",PORT 2315h,PORT 2317h,PORT 2717h
----------P2317------------------------------
PORT 2317 - QUAD EMS+ - "QEMS_BOARD3" - ???
SeeAlso: PORT 05FBh"QUAD",PORT 2316h,PORT 2714h,PORT 2717h
----------P23902393--------------------------
PORT 2390-2393 - cluster (adapter 4)
--------V-P23C023CF--------------------------
PORT 23C0-23CF - Compaq QVision - BitBLT engine
--------X-P240024FF--------------------------
PORT 2400-24FF - available for EISA slot 2
----------P2465------------------------------
PORT 2465 - Compaq Contura Aero
SeeAlso: PORT 1C65h"Compaq",PORT 2065h"Compaq"

2465  R-  current battery power level
		(166 fully-charged, 130 = LowBat1)
----------P2714------------------------------
PORT 2714 - QUAD EMS+ - "QEMS_BOARD4" - ???
SeeAlso: PORT 05FBh"QUAD",PORT 2315h,PORT 2715h
----------P2715------------------------------
PORT 2715 - QUAD EMS+ - "QEMS_BOARD5" - ???
SeeAlso: PORT 05FBh"QUAD",PORT 2315h,PORT 2714h,PORT 2716h
----------P2716------------------------------
PORT 2716 - QUAD EMS+ - "QEMS_BOARD6" - ???
SeeAlso: PORT 05FBh"QUAD",PORT 2315h,PORT 2715h,PORT 2717h
----------P2717------------------------------
PORT 2717 - QUAD EMS+ - "QEMS_BOARD7" - ???
SeeAlso: PORT 05FBh"QUAD",PORT 2315h,PORT 2716h
----------P27C6------------------------------
PORT 27C6 - Compaq LTE Lite - LCD TIMEOUT

27C6  RW  LCD timeout in minutes
--------X-P280028FF--------------------------
PORT 2800-28FF - available for EISA slot 2
--------V-P28E9------------------------------
PORT 28E9 - 8514/A - WD Escape Functions
--------d-P2C002CBF--------------------------
PORT 2C00-2CBF -  Adaptec AIC-777x EISA SCSI controller in EISA slot 2
SeeAlso: PORT 0340h-035Fh"Adaptec AHA-154x",PORT xxxxh"Adaptec AIC-78xx"
--------V-P2C802C8F--------------------------
PORT 2C80-2C8F - VESA XGA Video in EISA slot 2
SeeAlso: PORT 1C80h-1C83h,PORT 1C88h-1C8Fh
--------X-P2C802C83--------------------------
PORT 2C80-2C83 - EISA board product ID (board in slot 2)
SeeAlso: PORT 1C80h-1C83h
--------X-P2C84------------------------------
PORT 2C84 - EISA CONFIGURATION FLAGS (board in slot 2)

2C84  RW  configuration flags (see #P1016)
--------X-P300030FF--------------------------
PORT 3000-30FF - available for EISA slot 3
--------S-P32203227--------------------------
PORT 3220-3227 - serial port 3, description same as 03F8
--------S-P3228322F--------------------------
PORT 3228-322F - serial port 4, description same as 03F8
--------V-P33C033CF--------------------------
PORT 33C0-33CF - Compaq QVision - BitBLT engine
--------X-P340034FF--------------------------
PORT 3400-34FF - available for EISA slot 3
--------d-P35103513--------------------------
PORT 3510-3513 - ESDI primary harddisk controller
Range:	PORT 3510h-3513h (primary) or PORT 3518h-351Bh (secondary)
SeeAlso: PORT 3518h,PORT 01F0h-01F7h

3510w R-  status word
3510w -W  command word
3512  R-  basic status
3512  -W  basic control
3513  R-  interrupt status
3513  -W  attention
--------d-P3518351B--------------------------
PORT 3518-351B - ESDI secondary harddisk controller
Range:	PORT 3510h-3513h (primary) or PORT 3518h-351Bh (secondary)
SeeAlso: PORT 3510h,PORT 01F0h-01F7h

3518w R-  status word
3518w -W  command word
351A  R-  basis status
351A  -W  basic control
351B  R-  interrupt status
351B  -W  attention
--------d-P3540354F--------------------------
PORT 3540-354F - IBM SCSI (Small Computer System Interface) adapter
--------d-P3550355F--------------------------
PORT 3550-355F - IBM SCSI (Small Computer System Interface) adapter
--------d-P3560356F--------------------------
PORT 3560-356F - IBM SCSI (Small Computer System Interface) adapter
--------d-P3570357F--------------------------
PORT 3570-357F - IBM SCSI (Small Computer System Interface) adapter
--------V-P36EE------------------------------
PORT 36EE - ATI Mach8/Mach32 - FIFO OPTION
SeeAlso: PORT 6AEEh,PORT 6EEEh,PORT 72EEh,PORT 76EEh,PORT 7AEEh,PORT 8EEEh

36EE  -W  FIFO option
		bit 0: generate wait states if FIFO >= half full
			(0=only when FIFO full)
		bit 1: force 8-bit host data I/O
--------X-P380038FF--------------------------
PORT 3800-38FF - available for EISA slot 3
--------X-P3C003CFF--------------------------
PORT 3C00-3CFF - available for EISA slot 3
--------d-P3C003CBF--------------------------
PORT 3C00-3CBF -  Adaptec AIC-777x EISA SCSI controller in EISA slot 3
SeeAlso: PORT 0340h-035Fh"Adaptec AHA-154x",PORT xxxxh"Adaptec AIC-78xx"
--------V-P3C803C8F--------------------------
PORT 3C80-3C8F - VESA XGA Video in EISA slot 3

3C80-3C83  RW	EISA Video ID
3C84  RW	EISA Video expansion board control
3C85  RW	EISA Setup control
3C88  RW	EISA Video Programmable Option Select 0
3C89-3C8F  RW	EISA Video Programmable Option Select 1-7

SeeAlso: PORT 1C80h-1C8Fh"XGA",PORT 2C80h-2C8Fh"XGA",PORT 7C80h-7C8Fh"XGA"
--------X-P3C803C83--------------------------
PORT 3C80-3C83 - EISA board product ID (board in slot 3)
SeeAlso: PORT 1C80h-1C83h
--------X-P3C84------------------------------
PORT 3C84 - EISA CONFIGURATION FLAGS (board in slot 3)

3C84  RW  configuration flags (see #P1016)
--------X-P400040FF--------------------------
PORT 4000-40FF - available for EISA slot 4
----------P42204227--------------------------
PORT 4220-4227 - serial port, description same as 03F8
----------P4228422F--------------------------
PORT 4228-422F - serial port, description same as 03F8
----------P42E042EF--------------------------
PORT 42E0-42EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

42E1  RW  GPIB (adapter 2)
--------V-P42E8------------------------------
PORT 42E8 - 8514/A and hardware-compatible video cards
Note:	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set

42E8w R-  Misc. control: Subsystem Status (see #P1018)
42E8w -W  Misc. control: Subsystem Control (see #P1019)

Bitfields for 8514/A Subsystem Status register:
Bit(s)	Description	(Table P1018)
 15-8	(8514/A) reserved
 13	(S3) ???
 12-8	(S3) ???
 7	pixel length (0 = four bits, 1 = eight bits)
 6-4	reserved
 3	FIFO empty (interrupt generated if enabled)
 2	FIFO overflow (interrupt generated if enabled)
 1	Graphics Engine busy (interrupt generated if enabled)
 0	vertical sync (interrupt generated if enabled)
SeeAlso: #P1019

Bitfields for 8514/A Subsystem Control Register:
Bit(s)	Description	(Table P1019)
 15-14	GP_RESET
      W	00 no change
	01 normal operation
	10 reset graphics processor and FIFO
	11 reserved
 13-12	reserved
 11   W	enable interrupt when graphics processor idle
 10   W	enable interrupt on invalid I/O (FIFO overlow)
 9    W	enable interrupt if inside scissors region
 8    W	enable vertical blanking interval interrupt
 6-4 R	monitor ID (8514/A)
 7-4	reserved (S3)
 3	acknowledge idle interrupt (and clear)
 2	acknowledge invalid I/O interrupt (and clear)
 1	acknowledge inside-scissors interrupt (and clear)
 0	acknowledge vertical blanking interrupt (and clear)
SeeAlso: #P1018
--------V-P42EC------------------------------
PORT 42EC - ATI Mach64 - ???
SeeAlso: PORT 42EDh"Mach64"

42EC  RW  ???
	bits 1-0: ???
--------V-P42ED------------------------------
PORT 42ED - ATI Mach64 - ???
SeeAlso: PORT 42ECh"Mach64",PORT 42EFh

42ED  R?  ???
--------V-P42EE42EF--------------------------
PORT 42EE-42EF - ATI Mach32 - MEMORY BOUNDARY REGISTER
SeeAlso: PORT 5EEEh"Mach32"

42EEw RW  memory boundary
	bits 3-0: VGA/8514 boundary in 256K units (VGA only below, 8514 above)
	bit 4: partition enable: VGA and 8514 drawing engines may only write
	      within their respective partitions
	bits 15-5: reserved
--------V-P42EF------------------------------
PORT 42EF - ATI Mach64 - ???
SeeAlso: PORT 42EDh"Mach64"

42EF  R?  ???
--------X-P440044FF--------------------------
PORT 4400-44FF - available for EISA slot 4
----------P4F15------------------------------
PORT 4F15 - Tseng Labs ET6000 - Read EDID through Display Data Channel
--------V-P46E8------------------------------
PORT 46E8 - VGA - VIDEO ADAPTER ENABLE
Note:	IBM uses this port for adapter-card VGAs only, and PORT 03C3h for
	  motherboard VGA only (see 03C3 for details)
SeeAlso: PORT 03C3h,PORT 46E8h"8514/A",#P0748

46E8  rW  Misc. control: enable flags / select ROM page (8514/A) (see #P1020)

Bitfields for VGA miscellaneous control register:
Bit(s)	Description	(Table P1020)
 7-5	unused or vendor-specific
 4	setup for POS registers (MCA)
 3	enable video I/O ports and video buffer
 2-0	unused or vendor-specific
--------V-P46E8------------------------------
PORT 46E8 - 8514/A and compatible (e.g. ATI Graphics Ultra) - ROM PAGE SELECT
Note:	this register is readable on the C&T 82c480 chipset
SeeAlso: PORT 46E8h"VGA"

46E8w -W  ROM page select (see #P1021)

Bitfields for 8514/A ROM page select register:
Bit(s)	Description	(Table P1021)
 2-0	select which 4K page of 32K ROM to map at segment C700h
 3	enable VGA
 4	select VGA setup mode
 15-5	reserved (0)
--------V-P46EE------------------------------
PORT 46EE - ATI Mach32 - ???

46EEw RW  ???
--------V-P46EF------------------------------
PORT 46EF - ATI Mach64 - ???
Note:	the Mach64 BIOS reads the value of this port and multiplies it by 100
SeeAlso: PORT 66ECh"Mach64"
--------X-P480048FF--------------------------
PORT 4800-48FF - available for EISA slot 4
--------V-P4AE84AE9--------------------------
PORT 4AE8-4AE9 - 8514/A and compatible - CRT CONTROL
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: #P0749

4AE8w -W  CRT control: Advanced function control (see also #P1022)
	(02h = VGA mode, 03h = 480-line mode, 07h = 768-line mode)

Bitfields for S3 8514/A-compatible Advanced Function Control register:
Bit(s)	Description	(Table P1022)
 15-7	reserved
 6	(928 only) enable Write Posting
 5	(928+) enable memory-mapped I/O
 4	(928+) enable linear addressing (see also #P0741)
 3	reserved
 2	(911-928) screen size (1 = 800x600 or 1024x768, 0=640x480)
	(Trio32/Trio64) enhanced modes pixel length (0 = 8+ bpp, 1 = 4 bpp)
 1	reserved (1)
 0	enable enhanced functions
Note:	bit 4 is ORed with CR58 bit 4; bit 5 is ORed with CR53 bit 4
--------V-P4AEE------------------------------
PORT 4AEE - ATI Mach32 - ???

4AEEw RW  ???
--------X-P4C004CFF--------------------------
PORT 4C00-4CFF - available for EISA slot 4
--------d-P4C004CBF--------------------------
PORT 4C00-4CBF -  Adaptec AIC-777x EISA SCSI controller in EISA slot 4
SeeAlso: PORT 0340h-035Fh"Adaptec AHA-154x",PORT xxxxh"Adaptec AIC-78xx"
--------X-P4C804C83--------------------------
PORT 4C80-4C83	EISA board product ID (board in slot 4)
SeeAlso: PORT 1C80h-1C83h
--------V-P4C804C8F--------------------------
PORT 4C80-4C8F - VESA XGA Video in EISA slot 4 (see 3C80-3C8F)
SeeAlso: PORT 1C80h-1C8Fh,PORT 6C80h-6C8Fh
--------X-P4C84------------------------------
PORT 4C84 - EISA CONFIGURATION FLAGS (board in slot 4)

4C84  RW  configuration flags (see #P1016)
--------X-P500050FF--------------------------
PORT 5000-50FF - available for EISA slot 5
--------S-P52205227--------------------------
PORT 5220-5227 - serial port, description same as 03F8
--------S-P5228522F--------------------------
PORT 5228-522F - serial port, description same as 03F8
--------V-P52E852E9--------------------------
PORT 52E8-52E9 - C&T 82c480 - EXTENDED CONFIGURATION REGISTER 0
Note:	the 82c480 is an 8514/A-compatible video chipset
SeeAlso: PORT 56E8h"C&T",PORT 5AE8h"C&T",PORT 5EE8h"C&T"

52E8w RW  Extended Configuration Register 0
--------V-P52EE52EF--------------------------
PORT 52EE-52EF - ATI Mach32 - SCRATCH REGISTER 0 (USED FOR ROM LOCATION)
Note:	ATI video BIOS sets this port according to the segment address of the
	  BIOS if >= C000h, as ((seg-C000h) shr 7)
SeeAlso: PORT 56EEh"Mach32"

52EEw RW  scratch register 0: Video ROM address
--------X-P540054FF--------------------------
PORT 5400-54FF - available for EISA slot 5
--------V-P56E856E9--------------------------
PORT 56E8-56E9 - C&T 82c480 - EXTENDED CONFIGURATION REGISTER 1
Note:	the 82c480 is an 8514/A-compatible video chipset
SeeAlso: PORT 52E8h"C&T",PORT 5AE8h"C&T",PORT 5EE8h"C&T"

56E8w RW  Extended Configuration Register 1
--------V-P56EE56EF--------------------------
PORT 56EE-56EF - ATI Mach32 - SCRATCH REGISTER 1
SeeAlso: PORT 52EEh"Mach32"

56EEw RW  scratchpad
--------X-P580058FF--------------------------
PORT 5800-58FF - available for EISA slot 5
--------V-P5AE85AE9--------------------------
PORT 5AE8-5AE9 - C&T 82c480 - EXTENDED CONFIGURATION REGISTER 2
Note:	the 82c480 is an 8514/A-compatible video chipset
SeeAlso: PORT 52E8h"C&T",PORT 56E8h"C&T",PORT 5EE8h"C&T"

5AE8w RW  Extended Configuration Register 2
--------V-P5AEE------------------------------
PORT 5AEE - ATI Mach32 - ???

5AEE  RW  ???
--------X-P5C005CFF--------------------------
PORT 5C00-5CFF - available for EISA slot 5
--------d-P5C005CBF--------------------------
PORT 5C00-5CBF -  Adaptec AIC-777x EISA SCSI controller in EISA slot 5
SeeAlso: PORT 0340h-035Fh"Adaptec AHA-154x",PORT xxxxh"Adaptec AIC-78xx"
--------V-P5C805C8F--------------------------
PORT 5C80-5C8F - VESA XGA Video in EISA slot 5
SeeAlso: PORT 2C80h-2C8Fh,PORT 4C80h-4C8Fh,PORT 6C80h-6C8Fh

5C80d RW  EISA Video ID
5C84  RW  EISA Video expansion board control
5C85  RW  EISA Setup control
5C88  RW  EISA Video Programmable Option Select 0
5C89  RW  EISA Video Programmable Option Select 1
5C8A  RW  EISA Video Programmable Option Select 2
5C8B  RW  EISA Video Programmable Option Select 3
5C8C  RW  EISA Video Programmable Option Select 4
5C8D  RW  EISA Video Programmable Option Select 5
5C8E  RW  EISA Video Programmable Option Select 6
5C8F  RW  EISA Video Programmable Option Select 7
--------X-P5C805C83--------------------------
PORT 5C80-5C83	EISA board product ID (board in slot 5)
SeeAlso: PORT 1C80h-1C83h
--------X-P5C84------------------------------
PORT 5C84 - EISA CONFIGURATION FLAGS (board in slot 5)

5C84  RW  configuration flags (see #P1016)
--------V-P5EE85EE9--------------------------
PORT 5EE8-5EE9 - C&T 82c480 - EXTENDED CONFIGURATION REGISTER 3
Note:	the 82c480 is an 8514/A-compatible video chipset
SeeAlso: PORT 52E8h"C&T",PORT 56E8h"C&T",PORT 5AE8h"C&T"

5EE8w RW  Extended Configuration Register 3
----------P5EEE------------------------------
PORT 5EEE - ATI Mach32 - MEMORY APERTURE CONFIGURATION REGISTER
SeeAlso: PORT 42EEh"Mach32"

5EEEw RW  Memory Aperture Configuration (see #P1023)

Bitfields for ATI Mach32 Memory Aperture Configuration Register:
Bit(s)	Description	(Table P1023)
 1-0	direct memory interface mapping
	00 disabled
	01 1M aperture (not on PCI)
	10 4M aperture
	11 reserved
 3-2	1M page select (not on PCI)
	00 page 0
	01 page 1
	10 page 2
	11 page 3
 11-8	(ISA) memory aperture location, 0-15 MB
 13-8	(EISA) memory aperture location, 0-63 MB
 14-8	(VLB) memory aperture location, 0-127 MB [*]
 15-4	(PCI) memory aperture location, 0-4095 MB
 13-8	(MCA 16-bit) memory aperture location, 0-63 MB
 14-8	(MCA 32-bit) memory aperture location, 0-127 MB
Note:	[*] if PORT 16EEh bit 3 is set and PORT FAEEh is non-zero, bits 15-4
	  are used to specify an address from 0-4095 MB
--------X-P600060FF--------------------------
PORT 6000-60FF - available for EISA slot 6
----------P62E062EF--------------------------
PORT 62E0-62EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

62E1  RW  GPIB (adapter 3)
--------V-P63C063CF--------------------------
PORT 63C0-63CF - Compaq QVision - BitBLT engine
--------X-P640064FF--------------------------
PORT 6400-64FF - available for EISA slot 6
--------V-P66EC------------------------------
PORT 66EC - ATI Mach64 - ???
SeeAlso: PORT 6AECh"Mach64"
--------X-P680068FF--------------------------
PORT 6800-68FF - available for EISA slot 6
--------V-P6AEC6AED--------------------------
PORT 6AEC-6AED - ATI Mach64 - ???
SeeAlso: PORT 66ECh"Mach64"
--------V-P6AEE------------------------------
PORT 6AEE - ATI Mach8/Mach32 - MAXIMUM WAIT STATES
SeeAlso: PORT 36EEh,PORT 6EEEh,PORT 76EEh,PORT 7AEEh,PORT 8EEEh

6AEE  RW  maximum wait states (see #P1024)

Bitfields for ATI Mach8/Mach32 wait state configuration:
Bit(s)	Description	(Table P1024)
 10	leave alone ("PASSTHROUGH_OVERRIDE")
 9	enable for 16-bit I/O
 8	0=horizontal degree-mode line draws
--------X-P6C006CFF--------------------------
PORT 6C00-6CFF - available for EISA slot 6
--------d-P6C006CBF--------------------------
PORT 6C00-6CBF -  Adaptec AIC-777x EISA SCSI controller in EISA slot 6
SeeAlso: PORT 0340h-035Fh"Adaptec AHA-154x",PORT xxxxh"Adaptec AIC-78xx"
--------X-P6C806C83--------------------------
PORT 6C80-6C83 - EISA board product ID (board in slot 6)
SeeAlso: PORT 1C80h-1C83h
--------V-P6C806C8F--------------------------
PORT 6C80-6C8F - VESA XGA Video in EISA slot 1
SeeAlso: PORT 1C80h-1C8Fh"XGA",PORT 2C80h-2C8Fh"XGA",PORT 5C80h-5C8Fh"XGA"

6C80d RW  EISA Video ID (see PORT 1C80h-1C83h)
6C84  RW  EISA Video expansion board control
6C85  RW  EISA Setup control
6C88  RW  EISA Video Programmable Option Select 0
6C89  RW  EISA Video Programmable Option Select 1
6C8A  RW  EISA Video Programmable Option Select 2
6C8B  RW  EISA Video Programmable Option Select 3
6C8C  RW  EISA Video Programmable Option Select 4
6C8D  RW  EISA Video Programmable Option Select 5
6C8E  RW  EISA Video Programmable Option Select 6
6C8F  RW  EISA Video Programmable Option Select 7
--------X-P6C84------------------------------
PORT 6C84 - EISA CONFIGURATION FLAGS (board in slot 6)

6C84  RW  configuration flags (see #P1016)
--------V-P6EEC------------------------------
PORT 6EEC - ATI Mach64 - ???
SeeAlso: PORT 6AECh"Mach64"
--------V-P6EEE------------------------------
PORT 6EEE - ATI Mach8/Mach32 - ENGINE VIDEO BUFFER OFFSET LOW
SeeAlso: PORT 72EEh

6AEEw -W  low 16 bits of video buffer starting offset
--------X-P700070FF--------------------------
PORT 7000-70FF - available for EISA slot 7
--------V-P72EC------------------------------
PORT 72EC - ATI Mach64 - ???
SeeAlso: PORT 66ECh"Mach64",PORT 72EFh"Mach64"
--------V-P72EE------------------------------
PORT 72EE - ATI Mach8/Mach32 - ENGINE VIDEO BUFFER OFFSET HIGH
SeeAlso: PORT 6EEEh

72EE  -W  high bits of video buffer starting offset
		bits 1-0 for Mach-8
		bits 3-0 for Mach-32
--------V-P72EE------------------------------
PORT 72EE - ATI Mach8/Mach32 - BOUNDS ACCUMULATOR (LEFT)
SeeAlso: PORT 76EEh"BOUNDS",PORT 7AEEh"BOUNDS",PORT 7EEEh"BOUNDS"

72EEw R-  left edge of bounding box for points written via Line Draw register
--------V-P72EF------------------------------
PORT 72EF - ATI Mach64 - ???
SeeAlso: PORT 66ECh"Mach64",PORT 72ECh"Mach64"
--------X-P740074FF--------------------------
PORT 7400-74FF - available for EISA slot 7
--------V-P76EE------------------------------
PORT 76EE - ATI Mach8/Mach32 - ENGINE DISPLAY PITCH
SeeAlso: PORT 6AEEh,PORT 7AEEh

76EE  -W  display pitch
--------V-P76EE------------------------------
PORT 76EE - ATI Mach8/Mach32 - BOUNDS ACCUMULATOR (TOP)
SeeAlso: PORT 72EEh"BOUNDS",PORT 7AEEh"BOUNDS",PORT 7EEEh"BOUNDS"

76EEw R-  top edge of bounding box for points written via Line Draw register
--------X-P780078FF--------------------------
PORT 7800-78FF - available for EISA slot 7
--------V-P7AEE------------------------------
PORT 7AEE - ATI Mach8/Mach32 - EXTENDED GRAPHICS ENGINE CONGIFURATION
SeeAlso: PORT 8EEEh

7AEEw -W  extended graphics engine configuration (see #P1025)

Bitfields for Mach8/Mach32 extended graphics engine configuration:
Bit(s)	Description	(Table P1025)
 15	drawing pixel size to be written next (68800-6 only)
 14	enable 8-bit DAC (Mach-32 only)
 13-12	DAC address inputs RS(3:2) control (Mach-32 only)
 11	display pixel size to be written next (68800-6 only)
 10	24-bit color order (Mach-32 only)
	0 = RGB
	1 = BGR
 9	24-bit color configuration: pixels use 4 bytes instead of three
 8	DAC processes four pixels in parallel (Mach-32 only)
 7-6	16-bits-per-color word format (Mach-32 only)
	00 RGB(5,5,5)
	01 RGB(5,6,5)
	10 RGB(6,5,5)
	11 RGB(6,6,4)
 5-4	number of bits per pixel (Mach-32 only)
	00 four
	01 eight
	10 sixteen
	11 twenty-four
 3	report monitor alias instead of actual monitor
 2-0	alternate monitor ID (alias)
--------V-P7AEE------------------------------
PORT 7AEE - ATI Mach8/Mach32 - BOUNDS ACCUMULATOR (RIGHT)
SeeAlso: PORT 72EEh"BOUNDS",PORT 76EEh"BOUNDS",PORT 7EEEh"BOUNDS"

7AEEw R-  right edge of bounding box for points written via Line Draw register
--------X-P7C007CFF--------------------------
PORT 7C00-7CFF - available for EISA slot 7
--------d-P7C007CBF--------------------------
PORT 7C00-7CBF -  Adaptec AIC-777x EISA SCSI controller in EISA slot 7
SeeAlso: PORT 0340h-035Fh"Adaptec AHA-154x",PORT xxxxh"Adaptec AIC-78xx"
--------X-P7C807C83--------------------------
PORT 7C80-7C83 - EISA board product ID (board in slot 7)
SeeAlso: PORT 1C80h-1C83h
--------V-P7C807C8F--------------------------
PORT 7C80-7C8F - VESA XGA Video in EISA slot 7
SeeAlso: PORT 1C80h-1C8Fh,PORT 6C80h-6C8Fh

7C80-7C83  RW	EISA Video ID
7C84  RW	EISA Video expansion board control
7C85  RW	EISA Setup control
7C88  RW	EISA Video Programmable Option Select 0
7C89-7C8F  RW	EISA Video Programmable Option Select 1-7
--------X-P7C84------------------------------
PORT 7C84 - EISA CONFIGURATION FLAGS (board in slot 7)

7C84  RW  configuration flags (see #P1016)
--------V-P7EEE------------------------------
PORT 7EEE - ATI Mach8/Mach32 - BOUNDS ACCUMULATOR (RIGHT)
SeeAlso: PORT 72EEh"BOUNDS",PORT 76EEh"BOUNDS",PORT 7AEEh"BOUNDS"

7EEEw R-  right edge of bounding box for points written via Line Draw register
--------X-P800080FF--------------------------
PORT 8000-80FF - available for EISA slot 8
----------P82E082EF--------------------------
PORT 82E0-82EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

82E1  RW  GPIB (adapter 4)
--------V-P82E882E9--------------------------
PORT 82E8-82E9 - 8514/A and compatible - CURRENT Y POSITION
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT 86E8h,PORT 82EAh

82E8w -W  drawing control: current Y position
--------V-P82EA82EB--------------------------
PORT 82EA-82EB - S3 Trio64 - CURRENT Y POSITION 2
SeeAlso: PORT 82E8h

82EAw	  drawing control: current Y position 2
--------S-P82F882FF--------------------------
PORT 82F8-82FF - serial port, description same as 03F8
--------V-P83C083CF--------------------------
PORT 83C0-83CF - Compaq QVision - Line Draw Engine
--------V-P83C4------------------------------
PORT 83C4 - Compaq Qvision EISA - Virtual Controller Select
--------V-P83C683C9--------------------------
PORT 83C6-83C9 - Compaq Qvision EISA - DAC color registers
SeeAlso: PORT 03C6h
--------V-P83C683C9--------------------------
PORT 83C6-83C9 - Chips&Technologies 64200 (Wingine) - DAC color registers
SeeAlso: PORT 03C6h

83C6  RW  color palette pixel mask
83C7  R-  color palette state
83C7  -W  color palette read-mode index
83C8  RW  color palette write-mode index
83C9  RW  color palette data (three bytes)
----------P83D09FD3--------------------------
PORT 83D0-9FD3 - Chips&Techs 64310 - 32-BIT EXTENSION REGS - BitBLT
Notes:	All ports are word or dword accessible.
	These registers are also accessible in the upper 2 MB of the 4 MB
	  linear memory frame buffer (address specified in PCI configuration
	  registers).
SeeAlso: PORT 03D6h"Chips",PORT A3D0h"Chips"

83D0d RW  "DR00"  BitBlt offset register (see #P1026)
87D0d RW  "DR01"  BitBlt pattern ROP register (see #P1027)
8BD0d RW  "DR02"  BitBlt background color register (see #P1028)
8FD0d RW  "DR03"  BitBlt foreground color register (see #P1029)
93D0d RW  "DR04"  BitBlt control register (see #P1030)
97D0d RW  "DR05"  BitBlt source register (see #P1031)
9BD0d RW  "DR06"  BitBlt destination register (see #P1032)
9FD0d RW  "DR07"  BitBlt command register (see #P1033)

Bitfields for Chips&Technologies 64310 "DR00" BitBlt offset register:
Bit(s)	Description	(Table P1026)
 31-28	reserved (0)
 27-16	destination offset
 15-12	reserved (0)
 11-0	source offset

Bitfields for Chips&Technologies 64310 "DR01" BitBlt pattern ROP register:
Bit(s)	Description	(Table P1027)
 31-21	reserved (0)
 20-0	pattern pointer (must be pattern size aligned)
Note:	Do not read this register while BitBlt is active.

Bitfields for Chips&Technologies 64310 "DR02" BitBlt background color register:
Bit(s)	Description	(Table P1028)
 31-16	reserved (contents of bits 15-0 on read)
 15-0	background color for opaque mono-color expansions
	(all bits must be used; use same data in bits 15-8 and 7-0 for 8BPP)

Bitfields for Chips&Technologies 64310 "DR03" BitBlt foreground color register:
Bit(s)	Description	(Table P1029)
 31-16	reserved (contents of bits 15-0 on read)
 15-0	foreground color for mono-color expansions/color for solid paint
	  operations
	(all bits must be used; use same data in bits 15-8 and 7-0 for 8BPP)

Bitfields for Chips&Technologies 64310 "DR04" BitBlt control register:
Bit(s)	Description	(Table P1030)
 31-28	reserved (0)
 27-24	buffer status (number of dwords that can be written to the chip)
 23-21	reserved (0)
 20	BitBlt status (read-only)
	0 = idle
	1 = active (do not write BitBlt registers)
 19	0 = bitmap pattern
	1 = solid pattern (brush)
 18-16	pattern starting row
 15-14	BitBlt source (destination always video frame buffer)
	00 = video frame buffer
	01 = system memory
	1x = reserved
 13	background for monochrome pattern and font expansion
	0 = opaque (color in DR02)
	1 = transparent (unchanged)
 12	pattern depth
	0 = color
	1 = monochrome
 11	source depth
	0 = color
	1 = monochrome (font expansion only if bit 9 = 1)
 10	source data
	0 = selected by bit 14
	1 = foreground color reg (DR03)
 9	X direction (use when source and destination areas overlap)
	0 = decrement (right to left)
	1 = increment (left to right)
 8	Y direction (use when source and destination areas overlap)
	0 = decrement (bottom to top)
	1 = increment (top to bottom)
 7-0	raster operation (as defined by Windows)
SeeAlso: #P1031,#P1033

Bitfields for Chips&Technologies 64310 "DR05" BitBlt source register:
Bit(s)	Description	(Table P1031)
 31-21	reserved (0)
 20-0	source block address (must be byte aligned)
Note:	Do not read this register while BitBlt is active.
SeeAlso: #P1030,#P1032

Bitfields for Chips&Technologies 64310 "DR06" BitBlt destination register:
Bit(s)	Description	(Table P1032)
 31-21	reserved (0)
 20-0	destination block address (must be byte aligned)
Note:	Do not read this register while BitBlt is active.
SeeAlso: #P1031,#P1033

Bitfields for Chips&Technologies 64310 "DR07" BitBlt command register:
Bit(s)	Description	(Table P1033)
 31-28	reserved (0)
 27-16	lines per block
 15-12	reserved (0)
 11-0	bytes per line
SeeAlso: #P1031,#P1032
--------S-P83F883FF--------------------------
PORT 83F8-83FF - serial port, description same as 03F8
--------X-P840084FF--------------------------
PORT 8400-84FF - available for EISA slot 8
--------V-P86E886E9--------------------------
PORT 86E8-86E9 - 8514/A and compatible - CURRENT X POSITION
Desc:	define the column at which the first pixel of a line, rectangle, etc.
	  will be drawn; (Trio64) define the column at which the first of two
	  edges for a polygon or trapezoid will begin
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT 82E8h,PORT 8AE8h,86EAh

86E8w -W  drawing control: current X position (bits 11-0)
--------V-P86EA86EB--------------------------
PORT 86EA-86EB - S3 Trio64 - CURRENT X POSITION 2
Desc:	define the column at which the second of two edges for a polygon or
	  trapezoid will begin
SeeAlso: PORT 86E8h

86EAw RW  drawing control: current X position 2 (bits 11-0)
--------X-P880088FF--------------------------
PORT 8800-88FF - available for EISA slot 8
--------V-P8AE88AE9--------------------------
PORT 8AE8-8AE9 - 8514/A and compatible - DESTINATION Y POSITION
Desc:	define the top row of the destination for a BLT, the axial step
	  constant for a line, or the ending row of a line segment in a
	  polyline; (Trio64) define the ending row of the first edge drawn
	  for a polygon or trapezoid
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT 82E8h,PORT 86E8h

8AE8w -W  drawing control: destination Y position / axial step constant
	  (see #P1034)
Note:	this port may be read on S3 chipsets

Bitfields for 8514/A destination Y position / axial step constant register:
Bit(s)	Description	(Table P1034)
 11-0	destination Y position
 13-0	axial step constant for line drawing
 15-14	reserved
--------V-P8AEA8AEB--------------------------
PORT 8AEA-8AEB - S3 Trio64 - DESTINATION Y COORD 2 / AXIAL STEP CONSTANT 2
Desc:	define the row at which the second of two edges for a polygon or
	  trapezoid will end, or the axial step constant for the second of
	  two edges for a Bresenham trapezoid
SeeAlso: PORT 8AE8h

8AEAw RW  drawing control: destination Y position 2 / axial step constant 2
	  (see #P1034)
--------X-P8C008CFF--------------------------
PORT 8C00-8CFF - available for EISA slot 8
--------X-P8C808C83--------------------------
PORT 8C80-8C83 - EISA board product ID (board in slot 8)
SeeAlso: PORT 1C80h-1C83h
--------X-P8C84------------------------------
PORT 8C84 - EISA CONFIGURATION FLAGS (board in slot 8)

8C84  RW  configuration flags (see #P1016)
--------V-P8EE88EE9--------------------------
PORT 8EE8-8EE9 - 8514/A and compatible - DESTINATION X POSITION
Desc:	define the left column of the destination for a BLT, the diagonal step
	  constant for a line, or the ending column of a line segment in a
	  polyline; (Trio64) define the ending column of the first edge drawn
	  for a polygon or trapezoid
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT DAEEh"Mach32",PORT 8EEAh

8EE8w -W  drawing control: destination X position / axial step constant
	  (see #P1034)
--------V-P8EEA8EEB--------------------------
PORT 8EEA-8EEB - S3 Trio64 - DESTINATION X COORD 2 / AXIAL STEP CONSTANT 2
Desc:	define the column at which the second of two edges for a polygon or
	  trapezoid will end, or the axial step constant for the second of
	  two edges for a Bresenham trapezoid
SeeAlso: PORT 8EE8h

8EEAw RW  drawing control: destination X position 2 / diagonal step constant 2
	  (see #P1034)
--------V-P8EEE------------------------------
PORT 8EEE - ATI Mach32 - READ EXTENDED GRAPHICS CONFIGURATION
SeeAlso: PORT 72EEh

8EEE  R-  read extended graphics configuration (see #P1025)
--------X-P900090FF--------------------------
PORT 9000-90FF - available for EISA slot 9
--------V-P92E892E9--------------------------
PORT 92E8-92E9 - 8514/A and compatible - BRESENHAM ERROR TERM
Desc:	specify the initial error term for drawing a line using the Bresenham
	  algorithm
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
	the error term is 2*min(|dx|,|dy|) - max(|dx|,|dy|) - 1 [startX < endX]
	or 2*min(|dx|,|dy|) - max(|dx|,|dy|) [startX >= endX]
SeeAlso: PORT 92EAh

92E8w -W  drawing control: Bresenham error term (bits 13-0)
--------V-P92EA92EB--------------------------
PORT 92EA-92EB - S3 Trio64 - LINE ERROR TERM 2
Desc:	specify the initial error term for the second edge of a Bresenham
	  trapezoid
SeeAlso: PORT 92E8h

92EAw RW  drawing control: Bresenham error term 2 (bits 13-0)
--------X-P940094FF--------------------------
PORT 9400-94FF - available for EISA slot 9
--------V-P96E896E9--------------------------
PORT 96E8-96E9 - 8514/A and compatible - MAJOR AXIS PIXEL COUNT
Desc:	specify the pixel length of the longest axis of a line, or the width
	  of a rectangle, BLT, or image transfer; (Trio64) specify the major
	  axis length of the first edge of a Bresenham trapezoid
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
	the value programmed into this register is one less than the desired
	  width or major-axis length
SeeAlso: PORT 96EAh

96E8w R-  enter WD Enhanced Mode
96E8w -W  drawing control: major axis pixel count (bits 11-0)
--------V-P96EA96EB--------------------------
PORT 96EA-96EB - S3 Trio64 - MAJOR AXIS PIXEL COUNT 2
Desc:	specify the major axis length of the second edge for a Bresenham
	  trapezoid
Note:	the value programmed into this register is one less than the desired
	  width or major-axis length
SeeAlso: PORT 96E8h

96EAw RW  drawing control: major axis pixel count 2 (bits 11-0)
--------X-P980098FF--------------------------
PORT 9800-98FF - available for EISA slot 9
--------V-P9AE89AE9--------------------------
PORT 9AE8-9AE9 - 8514/A and compatible - GRAPHICS PROCESSOR STATUS / COMMAND
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT 9AEAh

9AE8w R-  drawing control: graphic processor status (see #P1035)
9AE8w -W  drawing control: command register (see #P1036)

Bitfields for 8514/A graphic processor status:
Bit(s)	Description	(Table P1035)
 15-10	(8514/A) reserved
 15	(S3 Trio64 only) queue status flags 9
 14-11	(S3 Trio64 only) queue status flags 10-13
 10	(S3 Trio64 only) all FIFO slots are empty
 9	hardware busy
 8	(8514/A) data ready
	(S3 Trio64) reserved
 7	queue status flag 1
 6-0	queue status flags 2-8 (0=empty, 1=filled)
	(each bit represents a position in queue)
Note:	queue status flag N is cleared whenever at least N slots are available
	  in the FIFO; at any given time, the CPU may write only as many values
	  to the FIFO as there are slots available
SeeAlso: #P1036

Bitfields for 8514/A command register :
Bit(s)	Description	(Table P1036)
 15-13	command (see #P1037)
 12	byte sequence (0=high byte first, 1=low byte first)
 11-10	(8514/A) reserved
 11	(S3 Trio) high bit of command (see #P1037)
 10	(S3 Trio) enable 32-bit write access
 9	enable 16-bit write access (16BIT)
 8	0=use 8514/A data, 1=pixel data trans reg (PCDATA) (see PORT E2E8h)
 7	0=draw vector above, 1=draw vector below (INC_Y)
 6	0=x is maj. axis, 1=y is maj. axis (YMAJAXIS)
 5	0=draw vector left, 1=draw vector right (INC_X)
	(bits 7-5 are the drawing direction in 45-degree increments
	  counterclockwise from the X axis when bit 3 is set)
 4	0=move only, 1=draw and move (DRAW)
 3	0=Bresenham line, 1=direct vector (LINETYPE)
 2	0=draw last pixel, 1=don't draw last pixel (LASTPIX)
 1	0=single pixel, 1=4pixel (PLANAR)
 0	0=read data, 1=write data (RD/WR) (must be 1 on S3 Trio)
SeeAlso: #P1035,#P1038

(Table P1037)
Values for 8514/A command:
 000	no operation (used to force synchronization with graphics processor,
	  or to set up short stroke vector drawing without writing any pixels)
 001	draw vector
 010	fast rectangle fill
 011	(8514/A) rectangle fill vertical #1
	(S3 Trio64) polygon fill solid
 100	(8514/A) rectangle fill vertical #2 (4 pixels)
	(S3 Trio64) 4-point trapezoid fill solid
 101	(8514/A) draw vector, 1 pixel/scanline
	(S3 Trio64) Bresenham trapezoid fill solid
 110	copy rectangle
 111	(8514/A) reserved
	(S3 Trio64) patterned BLT
---S3 Trio64---
 1001	polyline / 2-point line
 1011	polygon fill pattern
 1100	4-point trapezoid fill pattern
 1101	Bresenham trapezoid fill pattern
SeeAlso: #P1036
--------V-P9AEA9AEB--------------------------
PORT 9AEA-9AEB - S3 Trio64 - DRAWING COMMAND 2
Desc:	specify the drawing direction for the second edge of a Bresenham
	  trapezoid
SeeAlso: PORT 9AE8h

9AEAw -W  drawing command 2 (see #P1038)

Bitfields for S3 Trio64 Drawing Command 2 register:
Bit(s)	Description	(Table P1038)
 15-8	reserved
 7-5	drawing direction
	 7	0=draw vector above, 1=draw vector below (INC_Y)
	 6	0=x is maj. axis, 1=y is maj. axis (YMAJAXIS)
	 5	0=draw vector left, 1=draw vector right (INC_X)
 4-0	reserved
SeeAlso: #P1036
--------V-P9AEE------------------------------
PORT 9AEE - ATI Mach8/Mach32 - LINEDRAW INDEX REGISTER
SeeAlso: PORT FEEEh

9AEE  -W  linedraw index register (specifies interpretation of PORT FEEEh)
	  (see #P1039)

(Table P1039)
Values for ATI Mach8/Mach32 Linedraw Index Register:
 00h	set current X
 01h	set current Y
 02h	set Line End X
 03h	set Line End Y, draw line, and reset register to 02h
 04h	set current X (perform moves instead of draws)
 05h	set current Y and reset register to 04h
--------X-P9C009CFF--------------------------
PORT 9C00-9CFF - available for EISA slot 9
--------X-P9C809C83--------------------------
PORT 9C80-9C83 - EISA board product ID (board in slot 9)
SeeAlso: PORT 1C80h-1C83h
--------X-P9C84------------------------------
PORT 9C84 - EISA CONFIGURATION FLAGS (board in slot 9)

9C84  RW  configuration flags (see #P1016)
--------V-P9EE89EE9--------------------------
PORT 9EE8-9EE9 - 8514/A and compatible - SHORT STROKE VECTORS
Desc:	specify two short-stroke vectors to be drawn one after the other
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
	bit 12 of the command register (see PORT 9AE8h,#P1036) specifies which
	  vector is drawn first

9EE8w -W  short line vector transfer (see #P1040)

Bitfields for 8514/A short-stroke vector:
Bit(s)	Description	(Table P1040)
 15-13	second vector: drawing direction
 12	second vector: draw/move
 11-0	second vector: length in pixels (less 1)
 7-5	first vector: drawing direction
	000  zero degrees = right
	001  45 degress = up and right
	010  90 degrees = up
	...
	111 315 degrees = down and right
 4	first vector: draw/move (=0 move only, =1 draw and move)
 3-0	first vector: length in pixels (less 1)
--------S-PA220------------------------------
PORT A220 - soundblaster support in AMI Hi-Flex BIOS  ????
----------PA2E0A2EF--------------------------
PORT A2E0-A2EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

A2E1  RW  GPIB (adapter 5)
--------V-PA2E8A2EB--------------------------
PORT A2E8-A2EB - 8514/A and compatible - BACKGROUND COLOR
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT A6E8h

A2E8w -W  drawing control: background color
A2E8d RW  (S3) drawing control: 32bpp background color
--------V-PA2EEA2EF--------------------------
PORT A2EE-A2EF - ATI Mach8/Mach32 - LINE DRAW OPTIONS
SeeAlso: PORT 8EEEh,PORT CEEEh

A2EEw RW  line drawing options (see #P1041)

Bitfields for ATI Mach8/Mach32 line drawing options:
Bit(s)	Description	(Table P1041)
 10-9	clipping mode
	00 disable clip exception
	01 stroked plain lines
	10 polygon boundary lines
	11 patterned lines
 8	reset all Bounds Accumulator registers
 7-5	OCTANT: direction for BitBlts or lines
 3	direction specification
	0 = Bresenham/Octant
		bit 7: increment Y
		bit 6: Y is major axis instead of X
		bit 5: increment X
	1 = line-length and degrees
		OCTANT field species N*45 degrees
 2	do NOT draw last pixel of a line
 1	polyline draw
----------PA3D0BFD3--------------------------
PORT A3D0-BFD3 - Chips&Techs 64310 - 32-BIT EXTENSION REGS - CURSOR CONTROL
Notes:	All ports are word or dword accessible.
	These registers are also accessible in the upper 2 MB of the 4 MB
	  linear memory frame buffer (address specified in PCI configuration
	  registers).
SeeAlso: PORT 03D6h"Chips",PORT 83D0h"Chips"

A3D0d RW  "DR08"  cursor control register (see #P1042)
A7D0d RW  "DR09"  cursor color register (see #P1043)
ABD0d --  "DR0A"  reserved
AFD0d RW  "DR0B"  cursor position register (see #P1044)
B3D0d RW  "DR0C"  cursor base address (see #P1045)
B7D0d --  "DR0D"  reserved
BBD0d --  "DR0E"  reserved
BFD0d --  "DR0F"  reserved

Bitfields for Chips&Technologies 64310 "DR08" cursor control register:
Bit(s)	Description	(Table P1042)
 31-8	reserved (0)
 7-6	test (must be 0)
 5	upper left corner (ULC) select
	(all x, y positioning is relative to selected ULC)
	0 = active display (BLANK#) (cursor can be positioned in overscan
	  area)
	1 = display enable (cursor cannot be positioned to overscan area)
 4-2	reserved (must be 0)
 1-0	hardware cursor enable
	00 = disable
	01 = 32x32 cursor enable
	10 = 64x64 cursor enable
	11 = illegal/reserved

Bitfields for Chips&Technologies 64310 "DR09" cursor color register:
Bit(s)	Description	(Table P1043)
 31-27	cursor color 1 red
 26-21	cursor color 1 green
 20-16	cursor color 1 blue
 15-11	cursor color 0 red
 10-5	cursor color 0 green
 4-0	cursor color 0 blue
SeeAlso: #P1044,#P1045

Bitfields for Chips&Technologies 64310 "DR0B" cursor position register:
Bit(s)	Description	(Table P1044)
 31	Y sign
 30-27	reserved (0)
 26-16	cursor position Y offset from ULC (DR08 bit 5)
 15	X sign
 14-11	reserved (0) (ignored)
 10-0	cursor position X offset from ULC (DR08 bit 5)
SeeAlso: #P1043,#P1045

Bitfields for Chips&Technologies 64310 "DR0C" cursor base address:
Bit(s)	Description	(Table P1045)
 31-21	reserved (0)
 20-10	base address for cursor data in display memory
	(cursor data must be at 1K boundary in off-screen memory)
 9-0	reserved (0)
SeeAlso: #P1043,#P1044
--------V-PA6E8A6EB--------------------------
PORT A6E8-A6EB - 8514/A and compatible - FOREGROUND COLOR
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT A2E8h,PORT AAE8h,PORT AEE8h

A6E8w -W  drawing control: foreground color
A6E8d RW  (S3) drawing control: foreground color for 32bpp modes
--------V-PAAE8AAEB--------------------------
PORT AAE8-AAEB - 8514/A and compatible - WRITE MASK
Desc:	specify which bit planes are updates when a pixel is written
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT A6E8h,PORT AEE8h

AAE8w -W  drawing control: write mask
AAE8d RW  (S3) drawing control: write mask for 32bpp modes
--------V-PAEE8AEEB--------------------------
PORT AEE8-AEEB - 8514/A and compatible - READ MASK
Desc:	specify which bit planes are used as a data source
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT AAE8h,PORT B2E8h

AEE8w -W  drawing control: read mask
AEE8d RW  (S3) drawing control: read mask for 32bpp modes
--------V-PAFFF------------------------------
PORT AFFF - VIDEO REGISTER

AFFF  RW  plane 0-3 system latch (video register)
--------S-PB220B227--------------------------
PORT B220-B227 - serial port, description same as 03F8
--------S-PB228B22F--------------------------
PORT B228-B22F - serial port, description same as 03F8
--------V-PB2E8B2EB--------------------------
PORT B2E8-B2EB - 8514/A and compatible - COLOR COMPARE
Notes:	supported by ATI Graphics Ultra
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT B6E8h,PORT BAE8h,PORT BEE8h

B2E8w -W  drawing control: color compare
B2E8d RW  (S3) drawing control: color compare for 32bpp modes
--------V-PB2EE------------------------------
PORT B2EE - ATI Mach32 - ???

B2EEw RW  ???
--------V-PB6E8B6E9--------------------------
PORT B6E8-B6E9 - 8514/A and compatible - BACKGROUND MIX
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT BAE8h,PORT BEE8h,PORT B2E8h

B6E8w -W  drawing control: background mix (see #P1046)
Note:	this register may be read on S3 chipsets
--------V-PB6EE------------------------------
PORT B6EE - ATI Mach32 - ???

B6EEw RW  ???
--------V-PBAE8BAE9--------------------------
PORT BAE8-BAE9 - 8514/A and compatible - FOREGROUND MIX
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
SeeAlso: PORT B6E8h

BAE8w -W  drawing control: foreground mix (see #P1046)
Note:	this register may be read on S3 chipsets

Bitfields for 8514/A color mix register:
Bit(s)	Description	(Table P1046)
 15-7	reserved
 6-5	color source
	00 background color
	01 foreground color
	10 CPU data
	11 display memory
 4	reserved
 3-0	mix type
	0000 negate current color
	0001 logical zero
	0010 logical one
	0011 leave unchanged
	0100 negate new color
	0101 current XOR new
	0110 negate (current XOR new)
	0111 new color
	1000 (NOT current) OR (NOT new)
	1001 current OR (NOT new)
	1010 (NOT current) OR new
	1011 current OR new
	1100 current AND new
	1101 (NOT current) AND new
	1110 current AND (NOT new)
	1111 (NOT current) AND (NOT new)
--------V-PBAEE------------------------------
PORT BAEE - ATI Mach32 - ???

BAEEw RW  ???
--------V-PBEE8BEE9--------------------------
PORT BEE8-BEE9 - 8514/A and compatible - MULTIFUNCTION CONTROL
Notes:	supported by ATI Mach8 and Mach32 chipsets
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set
	writes to the registers accessed via this port are pipelined; a NOP
	  command (see PORT 9AE8h) is required to ensure correct read-back
	  immediately after a write

BEE8w -W  drawing control: multi-function control (see #P1048)
BEE8w R-  (S3) value of register specified by current value of multi-function
	  read select register (index 0Fh bits 3-0) (see #P1048)

(Table P1047)
Values for index into 8514/A multi-function drawing control registers:
 00h RW minor axis pixel count
 01h RW top scissors
 02h RW left scissors
 03h RW bottom scissors
 04h RW right scissors
 05h -W memory control register
 08h -W fixed pattern low
 09h -W fixed pattern high
 0Ah RW data manipulation control
---S3 chipsets---
 0Dh RW (S3 864/964) miscellaneous 2
 0Eh RW (S3 801+) miscellaneous
 0Fh -W (S3 801/805/928) read register select (see #P1049)
SeeAlso: #P1048

Bitfields for 8514/A Multi-Function Control registers:
Bit(s)	Description	(Table P1048)
 15-12	register index (see #P1047)
---register 00h: minor axis pixel count---
 11-0	rectangle height - 1
---register 01h: top scissors---
 11-0	top edge of clipping box
---register 02h: left scissors---
 11-0	left edge of clipping box
---register 03h: bottom scissors---
 11-0	bottom edge of clipping box
---register 04h: right scissors---
 11-0	right edge of clipping box
---register 05h: memory control---
 ???
---register 08h: fixed pattern low---
 11-8	(S3 Trio32/64) reserved
 7-6	mix register
	00 always select Foreground Mix register
	01 reserved
	10 mix register selected by CPU data
	11 mix register selected by display memory value
 5-0	(S3 Trio32/64) reserved
---register 09h: fixed pattern high---
 ???
---register 0Ah: data manipulation control---
 ???
---register 0Dh: miscellaneous 2---
 11-7	reserved
 6-4	source base address
	000 in first meg of display memory
	001 in second meg
	010 in third meg
	011 in fourth meg
 3	reserved
 2-0	destination base address (settings as for bits 6-4)
---register 0Eh: miscellaneous---
 11-10	reserved (0)
 9	select 32-bit command registers; disable byte and word writes to regs
	(see PORT A2E8h,PORT A6E8h,PORT AAE8h,PORT B2E8h)
 8	enable color comparison
 7	don't update bitmap if source color differs from Color Compare register
	  (see PORT B2E8h)
 6	slow Graphics Engine read/modify/write cycle (adds one wait state)
 5	clipping direction
	=0 draw only inside clip rectangle
	=1 draw only outside clip rectangle
 4	select upper 16 bits of 32-bit registers in 32 bpp graphics mode
 3-2	source base address, bits 21-20
 1-0	destination base address, bits 21-20
	Note:	these base addresses are ignored if the corresponding base
		  address in register 0Dh is nonzero
---register 0Fh: multifunction read select---
 11-4	reserved
 3-0	(S3)	read select (see #P1049)
 2-0	(8514/A) read select (see #P1049)

(Table P1049)
Values for S3 multifunction read select register:
 00h	PORT BEE8h register 00h
 01h	PORT BEE8h register 01h
 02h	PORT BEE8h register 02h
 03h	PORT BEE8h register 03h
 04h	PORT BEE8h register 04h
 05h	PORT BEE8h register 0Ah
 06h	PORT BEE8h register 0Eh
 07h	PORT 9AE8h (bits 11-0 only)
---S3 864/964 only---
 08h	PORT 42E8h (bits 11-0 only)
 09h	PORT 46E8h
 0Ah	PORT BEE8h register 0Dh
SeeAlso: #P1047,#P1048
--------X-PC000CFFF--------------------------
PORT C000-CFFF - PCI Configuration Mechanism 2 - CONFIGURATION SPACE
Note:	to access the configuration space, write the target bus number to
	  PORT 0CFAh, then write to the Configuration Space Enable register
	  (PORT 0CF8h), and finally read or write the appropriate I/O
	  port(s) in the range C000h to CFFFh (where Cxrrh accesses location
	  'rr' in physical device 'x's configuration data)
SeeAlso: PORT 0CF8h"Mechanism 2",PORT 0CFAh"Mechanism 2"
SeeAlso: #00878 at INT 1A/AX=B10Ah
--------d-PC100C1FF--------------------------
PORT C100-C1FF - Intel Pentium mboard - PCTech RZ1000 EIDE controller
Desc:	the PCI configuration registers for the EIDE controller are visible
	  on these ports when the PCI configuration space has been opened via
	  ports 0CF8h and 0CFAh
SeeAlso: PORT 03F0h"RZ1000",PORT 0CF8h,#00878 at INT 1A/AX=B10Ah
----------PC200C204--------------------------
PORT C200-C204 - Intel Pentium mboard ("Neptune" chipset)
Desc:	the PCI configuration registers for the motherboard chipset are visible
	  on these ports when the PCI configuration space has been opened via
	  ports 0CF8h and 0CFAh
SeeAlso: #00878 at INT 1A/AX=B10Ah
--------S-PC220C227--------------------------
PORT C220-C227 - serial port, description same as 03F8
--------S-PC228C22F--------------------------
PORT C228-C22F - serial port, description same as 03F8
----------PC244------------------------------
PORT C244 - Intel Pentium mboard ("Neptune" chipset)
----------PC2E0C2EF--------------------------
PORT C2E0-C2EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

C2E1  RW  GPIB (adapter 6)
--------V-PC2EE------------------------------
PORT C2EE - ATI Mach32 - ???

C2EEw RW  ???
--------V-PC6EE------------------------------
PORT C6EE - ATI Mach32 - SHORT-STROKE VECTOR

C6EEw -W  short-stroke vector
--------V-PCAEE------------------------------
PORT CAEE - ATI Mach32 - ???

CAEEw RW  ???
----------PCEEE------------------------------
PORT CEEE - ATI Mach8/Mach32 - DATAPATH CONFIGURATION
SeeAlso: PORT 8EEEh

CEEEw -W  datapath configuration (see #P1050)

Bitfields for ATI Mach8/Mach32 datapath configuration:
Bit(s)	Description	(Table P1050)
 15-13	foreground color source
	000 background color reg
	001 foreground color reg
	010 pixel transfer reg
	011 VRAM BitBlt source
	101 color pattern shift register
 12	least-significant byte first
 9	data width is 16 bits instead of 8 bits
 8-7	background color source
	00 background color reg
	01 foreground color reg
	10 pixel transfer reg
	11 VRAM BitBlt source
 6-5	monochrome data source
	00 always one
	01 mono pattern register
	10 pixel transfer register
	11 VRAM BitBlt source
 4	enable drawing
 2	read color data instead of monochrome data
 1	enable polygon fill BitBlt
 0	write data to drawing trajectory instead of reading from trajectory
--------S-PD220D227--------------------------
PORT D220-D227 - serial port, description same as 03F8
SeeAlso: PORT 03F8h,PORT D228h
--------S-PD228D22F--------------------------
PORT D228-D22F - serial port, description same as 03F8
SeeAlso: PORT 03F8h,PORT D220h
--------V-PD2EE------------------------------
PORT D2EE - ATI Mach32 - ???

D2EEw RW  ???
--------V-PDAEEDAEF--------------------------
PORT DAEE-DAEF - ATI Mach8/Mach32 - SCISSORS REGION (LEFT)
SeeAlso: PORT 8EE8h,PORT DEEEh"SCISSORS",PORT E2EEh"SCISSORS"
SeeAlso: PORT E6EEh"SCISSORS"

DAEEw -W  left edge of "scissors" drawing area (bits 11-0)
--------V-PDEEEDEEF--------------------------
PORT DEEE-DEEF - ATI Mach8/Mach32 - SCISSORS REGION (TOP)
SeeAlso: PORT DAEEh"SCISSORS",PORT E2EEh"SCISSORS",PORT E6EEh"SCISSORS"

DEEEw -W  top edge of "scissors" drawing area (bits 11-0)
----------PE2E0E2EF--------------------------
PORT E2E0-E2EF - GPIB (General Purpose Interface Bus, IEEE 488 interface)

E2E1  RW  GPIB (adapter 7)
--------V-PE2E8E2E9--------------------------
PORT E2E8-E2E9 - 8514/A and compatible - PIXEL DATA TRANSFER
Desc:	all graphics data to be processed by the Graphics Engine is sent
	  through this port
Notes:	supported by ATI Graphics Ultra
	supported by S3 chipsets when PORT 03D4h register 40h bit 0 is set

E2E8w -W  drawing control: pixel data transfer
E2EAw rW  drawing control: pixel data transfer (S3 801+) for 32-bit transfers
--------V-PE2EEE2EF--------------------------
PORT E2EE-E2EF - ATI Mach8/Mach32 - SCISSORS REGION (BOTTOM)
SeeAlso: PORT DAEEh"SCISSORS",PORT DEEEh"SCISSORS",PORT E6EEh"SCISSORS"

E2EEw -W  bottom edge of "scissors" drawing area (bits 11-0)
--------V-PE6EEE6EF--------------------------
PORT E6EE-E6EF - ATI Mach8/Mach32 - SCISSORS REGION (RIGHT)
SeeAlso: PORT DAEEh"SCISSORS",PORT DEEEh"SCISSORS",PORT E2EEh"SCISSORS"

E6EEw -W  right edge of "scissors" drawing area (bits 11-0)
--------V-PEAE8EAEB--------------------------
PORT EAE8-EAEB - S3 Trio64 - PATTERN
Desc:	define the position of the top-left corner of an 8x8 pixel pattern
	  stored in off-screen memory which is to be used for patterned fill
	  commands (trapezoid, polygon, etc.)

EAE8w RW  pattern Y coordinate (bits 11-0)
EAEAw RW  pattern X coordinate (bits 11-0)
----------PEDC0EDC1--------------------------
PORT EDC0-EDC1 - DR DOS BATTERYMAX - DYNAMIC IDLE DETECTION
Note:	These ports are emulated by the IDLE386 dynamic idle detection of the
	  DR DOS BatteryMAX component. The actual definition of the bits is up
	  to the OEMs

EDC0  R-  emulated I/O address for video/serial activity status check
	  bit 6: screen RAM updated since last query
	  bit 1: COM2??? activity detected since last query
	  bit 0: COM1??? activity detected since last query
	  Note: Reading resets the IDLE386 video/serial internal setting
EDC1  -W  emulated I/O address for idle port
	  sets wakeup alarm on specified hardware event
	  bit 1: keyboard INT 09h
	  bit 0: timer INT 08h
--------V-PFAEE------------------------------
PORT FAEE - ATI Mach32 - CHIP IDENTIFICATION REGISTER
SeeAlso: PORT 56EEh"Mach32",PORT 5EEEh"Mach32"
--------V-PFEEEFEEF--------------------------
PORT FEEE-FEEF - ATI Mach8/Mach32 - DIRECT LINE DRAW REGISTER
SeeAlso: PORT 9AEEh

FEEEw -W  direct line-draw register
--------d-Pxxxx------------------------------
PORT xxxx - Future Domain TMC-3260 PCI SCSI adapter
Range:	anywhere on 8 byte boundary???
Note:	Future Domain TMC-3260 PCI SCSI adapter is based upon Future Domain
	  TMC-36C70 SCSI controller which is a PCI version of the TMC-18C30
	  ISA SCSI controller
SeeAlso: PORT 0140h-014Fh"Future Domain TMC-16x0"
--------d-Pxxxx------------------------------
PORT xxxx - AMD Am53C974A PC-SCSI II SCSI adapter
Range:	anywhere, on a 128-port boundary
SeeAlso: #00925

+000  R-  current transfer count register (low)
+000  -W  start transfer count register (low)
+004  R-  current transfer count register (middle)
+004  -W  start transfer count register (middle)
+008  RW  SCSI FIFO register
+00C  RW  SCSI command register
+010  R-  SCSI status register
+010  -W  destination ID
+014  R-  interrupt status
+014  -W  SCSI timeout
+018  R-  internal state
+018  -W  synchronous transfer period
+01C  R-  current FIFO/internal state
+01C  -W  synchronous offset
+020  RW  control register 1
+024  -W  clock factor
+028  -W  reserved
+02C  RW  control register 2
+030  RW  control register 3
+034  RW  control register 4
+038  R-  current transfer count register (high) / ID code
+038  -W  start current transfer count (high)
+03C	  reserved
+040  RW  DMA command
+044d RW  DMA starting transfer count (bits 23-0)
+048d RW  DMA starting physical address
+04C  R	  DMA working byte counter
+050d R	  DMA working address counter
+054  R	  DMA status register
+058d RW  DMA starting memory descriptor list address
+05Cd R	  DMA working memory descriptor list counter
+070d Rw  SCSI bus and control (bits 25-24 and 21-0)
Notes:	the SCSI registers are mapped on DWORD boundaries, even though for most
	  only the least-significant byte is used
	see "Am53C974A PCscsi(tm) II Technical Manual, Revision 1.0"
	  (file 19113A.PDF) for further details, as well as (file 19084A.PDF)
--------d-Pxxxx------------------------------
PORT xxxx - Adaptec AHA-2920 PCI SCSI adapter
Range:	anywhere on 8 byte boundary???
Note:	Adaptec AHA-2920 PCI SCSI adapter is based upon Future Domain TMC-36C70
	  SCSI controller which is a PCI version of Future Domain TMC-18C30 ISA
	  SCSI controller
SeeAlso: PORT 0140h-014Fh"Future Domain TMC-16x0"
--------d-Pxxxx------------------------------
PORT xxxx -  Adaptec AIC-78xx PCI SCSI controller
Range:	anywhere on 256-byte boundary
Note:	Adaptec AIC-78xx SCSI controllers are basically compatible with the
	  AIC-777x SCSI controllers
SeeAlso: PORT 0340h-035Fh"Adaptec AHA-152x",PORT 1C00h-1CBFh"Adaptec AIC-777x"

+000  RW  SCSI sequence control register (SCSISEQ) (see #P0600)
+001  RW  SCSI transfer control register 0 (SXFRCTL0) (see #P0979)
+002  RW  SCSI transfer control register 1 (SXFRCTL1) (see #P0980)
+003  R-  SCSI control signal read  register (SCSISIGI) (see #P0603)
+003  -W  SCSI control signal write register (SCSISIGO) (see #P0604)
+004  RW  SCSI rate control register (SCSIRATE) (see #P0981)
+005  RW  SCSI ID register (SCSIID) (see #P0982)
+006  RW  SCSI latched data low register (SCSIDATL)
	  read/write causes -ACK to pulse
+007  RW  (Wide SCSI) SCSI latched data high register (SCSIDATH)
	  read/write causes -ACK to pulse
+008  RW  SCSI transfer count register (STCNT) (3 bytes long)
+00B  R-  SCSI status register 0 (SSTAT0) (see #P0607)
+00B  -W  clear SCSI interrupt register 0 (CLRSINT0) (see #P0983)
+00C  R-  SCSI status register 1 (SSTAT1) (see #P0609)
+00C  -W  clear SCSI interrupt register 1 (CLRSINT1) (see #P0610)
+00D  R-  SCSI status register 2 (SSTAT2) (see #P0984)
+00E  R-  SCSI status register 3 (SSTAT3) (see #P0612)
+00F  RW  SCSI test control register (SCSITEST) (see #P0985)
+010  RW  SCSI interrupt mode register 0 (SIMODE0) (see #P0616)
+011  RW  SCSI interrupt mode register 1 (SIMODE1) (see #P0617)
+012  RW  SCSI data bus low register (SCSIBUSL)
+013  RW  (Wide SCSI) SCSI data bus high register (SCSIBUSH)
+014d R-  SCSI/host address register (SHADDR)
+018  RW  selection timeout timer  register (SELTIMER) (see #P0986)
+019  RW  selection/reselection ID register (SELID)  (see #P0987)
+01D  ??  (AIC-7870) board control register (BRDCTL) (see #P1051)
+01E  RW  (AIC-787x/788x) serial EEPROM control register (SEECTL) (see #P1052)
+01F  RW  SCSI block control register (SBLKCTL) (see #P1053)
+020  RW  scratch RAM (64 bytes) (see #P1002)
+060  RW  sequencer control  register (SEQCTL)	(see #P0989)
+061  RW  sequencer RAM data register (SEQRAM)
+062w RW  sequencer address  register (SEQADDR) (see #P0990)
+064  RW  accumulator  register (ACCUM)
+065  RW  source index register (SINDEX)
+066  RW  destination index register (DINDEX)
+069  R-  all ones register (ALLONES)
	  always reads as FFh
+06A  R-  all zeros register (ALLZEROS)
	  always reads as 00h
+06B  R-  flags register (FLAGS) (see #P0991)
	  PhaseEngine processor's flags
+06C  R-  source indirect register (SINDIR)
+06D  -W  destination indirect register (DINDIR)
+06E  RW  function 1 register (FUNCTION1)
+06F  R-  "STACK"
+084  RW  DSCommand register (DSCOMMAND) (see #P1054)
+085  RW  bus on/off time register (BUSTIME) (see #P0993)
+086  RW  (AIC-7870) "DSPCISTATUS"
+087  RW  host control register (HCNTRL) (see #P0995)
+088d RW  host address register (HADDR)
+08C  RW  host counter register (HCNT) (3 bytes long)
+090  RW  sequence control block (SCB) pointer register (SCBPTR)
+091  RW  interrupt status register (INTSTAT) (see #P0996)
+092  R-  hard error register (ERROR) (see #P0997)
+092  -W  clear interrupt status register (CLRINT) (see #P0998)
+093  RW  DMA FIFO control register (DFCNTRL)  (see #P0999)
+094  R-  DMA FIFO status  register (DFSTATUS) (see #P1000)
+099  RW  DMA FIFO data register (DFDAT)
+09A  RW  SCB auto-increment register (SCBCNT) (see #P1001)
+09B  RW  queue in FIFO register (QINFIFO)
	  write places the value into the FIFO, read removes
+09C  R-  queue in count register (QINCNT)
	  number of the SCBs in the queue in
+09D  -W  queue out FIFO register (QOUTFIFO)
	  read removes the value from the FIFO
+09E  R-  queue out count register (QOUTCNT)
	  number of the SCBs in the queue out
+0A0  RW  SCB array (32 bytes) (see #P1003)
Note:	AIC-7850 SCSI controllers sporatically get garbage in the MSBs of the
	  queue in/out count registers (QINCNT/QOUTCNT)

Bitfields for AIC-7870 board control register (BRDCTL):
Bit(s)	Description	(Table P1051)
 7	"BRDDAT7"
	(read) (ROM bank 0) internal 68-pin connector (INT68)
	=0 present
	=1 absent
	(read) (ROM bank 1) EPROM present (EPROMPS)
 6	"BRDDAT6"
	(read) (ROM bank 0) internal 50-pin connector (INT50)
	(read) (ROM bank 1) external 68-pin connector (EXT68)
	=0 present
	=1 absent
	(write) wide termination enable
 5	(write) "BRDDAT5"
	ROM bank setting
	=0 select bank 0
	=1 select bank 1
 4	strobe (BRDSTB)
 3	chip select (BRDCS)
 2	"BRDRW"
	=0 write
	=1 read
 1	"BRDCTL1"
 0	"BRDCTL0"
Notes:	accessing this register requires prior setting of bits 3 and 5 of the
	  serial EEPROM control register (SEECTL)
	bit 3 must be set to read/write bits 7-5, and reset afterwards
	bit 4 must be set along with bit 3 for writes, then value must be set
	  into the bits 7-5, and then bit 4 must be reset
	to read from bits 7-6 first perform a write operation of bit 5 in order
	  to select the ROM bank 0, then bit 2 must be set along with bit 3,
	  and then the data can be read
SeeAlso: #P1052

Bitfields for AIC-787x/788x serial EEPROM control register (SEECTL):
Bit(s)	Description	(Table P1052)
 7	"EXTARBACK"
 6	"EXTARBREQ"
 5	serial EEPROM memory port select? (SEEMS)
 4	serial EEPROM ready (SEERDY)
 3	serial EEPROM chip select (SEECS)
 2	serial EEPROM clock (SEECK)
 1	serial EEPROM data out (SEEDO)
 0	serial EEPROM data in  (SEEDI)
Notes:	AIC-7873/7883 use 93C56/93C66 serial EEPROM chips, others use 93C46;
	  93C46 serial EEPROM chips have 1024 bits organized into 64 16-bit
	  words and use 6 bits to address each word, while 93C56/93C66 chips
	  have 2048 bits organized into 128 16-bit words and use 8 bits to
	  address each word
	only the first 32 words of serial EEPROM are used by the Adaptec BIOS
	bits 3-0 are connected to the chip select, clock, data out, and data in
	  pins of the serial EEPROM respectively
	data in pin of the serial EEPROM can be read through the bit 0 of this
	  register after the clock pin goes from high to low
	bit 2 must be pulled high and then low for a minimum of 750 and 250 ns
	  to provide clocking for the EEPROM chip
	bit 2 going from low to high causes the EEPROM chip to sample the data
	  out pin and initiates the next bit to be sent through the data in pin
	bit 3 must be set for a minimum of 1 mcs with the bit 2 goig high and
	  then low for the EEPROM chip to be selected; then the instruction can
	  be sent to the EEPROM chip
	instruction can be terminated by taking the EEPROM chip select pin low,
	  with the bit 2 going high and low
	bit 5 requests access to the memory port; when access is granted, bit 4
	  will be set; during the EEPROM access bit 4 is cleared after writing
	  this register and goes high 800 ns later
SeeAlso: #P1007,#P1051,#P1055,#P1056

Bitfields for SCSI block control register (SBLKCTL):
Bit(s)	Description	(Table P1053)
 7	diagnostic LED enable (DIAGLEDEN)
 6	diagnostic LED on (DIAGLEDON)
 5	auto flush disable (AUTOFLUSHDIS)
 4	reserved
 3	select bus (SELBUS)
	=0 select bus A
	=1 select bus B (SELBUSB)
 2	reserved
 1	"SELWIDE"
 0	reserved
Note:	clearing bits 7-6 will take the card out of diagnostic mode and make
	  the host adapter LED follow bus activity
SeeAlso: #P0988

Bitfields for DSCommand register (DSCOMMAND):
Bit(s)	Description	(Table P1054)
 7	cache threshold enable (CACHETHEN)
 6	data   parity check enable (DPARCKEN)
 5	memory parity check enable (MPARCKEN)
 4	external request lock (EXTREQLCK)
 3-0	reserved

(Table P1055)
Values for the 93C56/93C66 serial EEPROM instructions:
Opcode	     Function  Parameter  Description
0000xxxxxxb  EWDS      -	  disable all programming instructions
0001xxxxxxb  WRAL      D15..D0	  write to all registers
0010xxxxxxb  ERAL      -	  erase all registers
0011xxxxxxb  EWEN      -	  write enable
				  must precede all programming modes
01AAAAAAAAb  WRITE     D15..D0	  write register with address A7..A0
10AAAAAAAAb  READ      -	  read registers starting with address A7..A0
11AAAAAAAAb  ERASE     -	  erase register with address A7..A0
SeeAlso: #P1007,#P1052

Format of the serial EEPROM:
Address	Size	Description	(Table P1056)
 00h  16 WORDs	SCSI ID configuration (see #P1009)
 10h	WORD	BIOS control (see #P1057)
 11h	WORD	host adapter control (see #P1058)
 12h	WORD	bus release time / host adapter ID (see #P1013)
 13h	WORD	maximum targets (see #P1014)
 14h  11 WORDs	reserved
 1Fh	WORD	checksum
SeeAlso: #P1052

Bitfields for the serial EEPROM BIOS control word:
Bit(s)	Description	(Table P1057)
 15-8	reserved
 7	extended translation enabled (CFEXTEND)
 6-5	reserved
 4	support more than 2 drives (CFSM2DRV)
 3	reserved
 2	BIOS enabled (CFBIOSEN)
 1	support removable drives for boot only (CFSUPREMB)
 0	support all removable drives (CFSUPREM)
SeeAlso: #P1056

Bitfields for the serial EEPROM host adapter control word:
Bit(s)	Description	(Table P1058)
 15-7	reserved
 6	reset SCSI bus at IC initialization (CFRESETB)
 5	reserved
 4	SCSI parity (CFSPARITY)
 3	SCSI high byte termination (CFWSTERM)
 2	SCSI low  byte termination (CFSTERM)
 1	(Ultra SCSI) Ultra SCSI speed enable (CFULTRAEN)
 0	reserved
SeeAlso: #P0600,#P0979,#P0980,#P0994,#P1056
--------p-Pxxxx------------------------------
PORT xxxx - AMD-645 - Power Management Registers
Range:	on any 256-byte boundary
SeeAlso: #01049

+000w RC  power management status (see #P1059)
+002w RW  power management enable (see #P1060)
+004w RW  power management control (see #P1061)
+006	  unused???
+008d RW  power management timer (24 or 32 bits)
+00C	  unused???
+010d RW  processor power management control (see #P1062)
+014  R-  "P_LVL2" processor level 2 -- reading switches to C2 power state
+015  R-  "P_LVL3" processor level 3 -- reading switches to C3 power state
+016	  unused???
+020w RC  general purpose status (see #P1063)
+022w RW  general purpose SCI enable (see #P1064)
+024w RW  general purpose SMI enable (see #P1065)
+026w RW  power supply control (see #P1066)
+028w RC  global power management status (see #P1067)
+02Aw RW  global power management enable (see #P1068)
+02Cw RW  global power management control (see #P1069)
+02E	  unused???
+02F  RW  SMI command
	writing this port sets the SW_SMI_STS bit (see #P1067,#P1068)
+030d RC  primary activity detection status (see #P1070)
+034d RW  primary activity detection enable (see #P1071)
+038d RW  general purpose timer reload enable (see #P1072)
+03C	  unused???
+040  RW  control of general-purpose I/O direction (see #P1073)
+041	  ???
+042  RW  output value for GPIO port (see #P1074)
+043  RW  ???
+044  RW  input value for GPIO port (see #P1075)
+045  RW  ???
+046w RW  output value for general-purpose output port
+048w RW  input value for general-purpose input port

Bitfields for AMD-645 Power Management Control Status:
Bit(s)	Description	(Table P1059)
 15	wakeup request -- system will transition from suspend to normal working
 14-12	reserved (0)
 11	power button override (set when PWRBTN# asserted for more than 4 sec)
	system will transition into "soft off" power state
 10	RTC alarm occurred
 9	reserved (0)
 8	"PB_STS" power button -- PWRBTN# asserted (but for less than 4 sec)
 7-6	reserved (0)
 5	"GBL_STS" Global Status
	set by hardware when "BIOS_RLS" set; "BIOS_RLS" cleared by hardware
	  when this bit cleared
 4	system bus requested by any bus master
 3-1	reserved (0)
 0	ACPI timer carried into highest bit
Note:	all bits are write-clear: write a 1 bit to acknowledge the
	  status and clear that bit
SeeAlso: #P1060,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 Power Management Enable register:
Bit(s)	Description	(Table P1060)
 15-11	reserved (0)
 10	enable SCI/SMI on RTC alarm
 9	reserved (0)
 8	enable SCI/SMI when PB_STS set (see #P1059 bit 8)
 7-6	reserved
 5	enable SCI/SMI when GBL_STS set (see #P1059 bit 5)
 4-1	reserved
 0	enable SCI/SMI when ACPI timer carries
SeeAlso: #P1059,#P1061,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 Power Management Control register:
Bit(s)	Description	(Table P1061)
 15-14	reserved (0)
 13	(write) force transition into sleep state (bits 12-10) when set
	(read) always 0
 12-10	sleep type
	000 "soft off" (suspend-to-disk)
	010 power-on suspend
	0x1 reserved
	1xx reserved
 9-3	reserved
 2	"GLB_RLS" release SCI/SMI lock
	when set, BIOS_STS bit set by hardware; when BIOS_STS cleared,
	  hardware clears this bit
 1	enable transition from suspend to normal working state on bus master
	  request
 0	power management event interrupt type
	0 generate SMI
	1 generate SCI
SeeAlso: #P1059,#P1060

Bitfields for AMD-645 Processor Power Management Control register:
Bit(s)	Description	(Table P1062)
 31-5	reserved (0)
 4	enable clock throttling
	0 = suspend processor on reading P_LVL2 port at offset 14h
	1 = throttle clock by modulating STPCLK# on reading P_LVL2
 3-1	throttling duty cycle (proportion of time STPCLK# is asserted)
	000 reserved
	001 0 - 1/8
	010 1/8 - 2/8
	...
	111 6/8 - 7/8
 0	reserved (0)
SeeAlso: #P1061,#P1062

Bitfields for AMD-645 General Purpose Status register:
Bit(s)	Description	(Table P1063)
 15-10	reserved (0)
 9	"USB_STS"	USB peripheral generated resume event
 8	"RI_STS"	ring detected (RI# asserted)
 7	"EXT7_STS"	EXTSMI7# pin toggled
 6-0	"EXT?_STS"	EXTSMI6# - EXTSMI0# pins toggled
SeeAlso: #P1061,#P1064

Bitfields for AMD-645 General Purpose SCI Enable register:
Bit(s)	Description	(Table P1064)
 15-10	reserved (0)
 9	enable SCI when USB_STS bit becomes set
 8	enable SCI when RI_STS bit becomes set
 7-0	enable SCI when EXT?_STS bit becomes set
SeeAlso: #P1063,#P1065

Bitfields for AMD-645 General Purpose SMI Enable register:
Bit(s)	Description	(Table P1065)
 15-10	reserved (0)
 9	enable SMI when USB_STS bit becomes set
 8	enable SMI when RI_STS bit becomes set
 7-0	enable SMI when EXT?_STS bit becomes set
SeeAlso: #P1063,#P1064,#P1066

Bitfields for AMD-645 Power Supply Control register:
Bit(s)	Description	(Table P1066)
 15-11	reserved (0)
 10	enable setting of RI_STS bit to turn on power
 9	set PB_STS bit to resume from suspend
 8	set RTC_STS bit to resume from suspend on RTC alarm
 7-1	reserved (0)
 0	enable setting of EXT0_STS bit to resume from suspend
SeeAlso: #P1063,#P1067,#P1068

Bitfields for AMD-645 PM Global Status register:
Bit(s)	Description	(Table P1067)
 15-7	reserved (0)
 6	"SW_SMI_STS" SMI_CMD port has been written
 5	"BIOS_STS" set whenever GLB_RLS bit is set; GLB_RLS is cleared when
	  this bit is cleared
 4	legacy USB event occurred
 3	GP1 timer timed out
 2	GP0 timer timed out
 1	secondary event timer timed out
 0	"PACT_STS" an enabled primary system activity has occurred (see #P1071)
Note:	this register is write-clear: writing a 1 to a bit clears that bit
SeeAlso: #P1066

Bitfields for AMD-645 PM Global Enable register:
Bit(s)	Description	(Table P1068)
 15-7	reserved (0)
 6	enable SMI when SMI_CMD port is written
 5	enable SMI when BIOS_STS bit set (see #P1067)
 4	enable SMI on legacy USB events
 3	enable SMI when GP1 timer times out
 2	enable SMI when GP0 timer times out
 1	enable SMI when secondary event timer times out
 0	enable SMI on occurrence of any primary activity
SeeAlso: #P1066,#P1067,#P1069

Bitfields for AMD-645 PM Global Control ("GLB_CTL") register:
Bit(s)	Description	(Table P1069)
 15-9	reserved
 8	SMI is active
 7-5	reserved
 4	SMI lock enabled (write-clear)
	(must be cleared before bit 8 can be cleared and the next SMI allowed)
 3	reserved
 2	type of power button triggering
	0 generate SCI/SMI on PWRBTN# asserted
	1 generate SCI/SMI when PWRBTN# becomes deasserted
	(must be clear to comply with ACPI v0.9, but setting it avoids the
	  situation where holding the power button for four seconds first wakes
	  the system and then puts it into the soft-off state)
 1	"BIOS_RLS" used by legacy software to release the SCI/SMI lock; when
	  set, the GBL_STS bit is set by hardware; when GBL_STS is cleared,
	  this bit is cleared by hardware
 0	enable SMI generation
SeeAlso: #P1066,#P1067,#P1068,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 PM Primary Activity Detect Status register:
Bit(s)	Description	(Table P1070)
 31-8	reserved (0)
 7	keyboard controller accessed via PORT 0060h
 6	serial port accessed (via PORT 03F8h-03FFh, 02F8h-02FFh, 03E8h-03EFh,
	  or PORT 02E8h-02EFh)
 5	parallel port accessed (via PORT 0278h-027Fh or PORT 0378h-037Fh)
 4	video controller accessed
 3	IDE or Floppy controller accessed
 2	reserved (0)
 1	a primary interrupt occurred (see #01049 [offset 44h])
 0	ISA busmaster or DMA activity occurred
Note:	this register is write-clear: write a 1 to a bit to clear it
SeeAlso: #P1071,#P1069

Bitfields for AMD-645 PM Primary Activity Detect Enable register:
Bit(s)	Description	(Table P1071)
 31-8	reserved (0)
---set PACT_STS (see #P1067) whenever:
 7	keyboard controller is accessed via PORT 0060h
 6	serial port is accessed (via PORT 03F8h-03FFh, 02F8h-02FFh,
	  PORT 03E8h-03EFh, or PORT 02E8h-02EFh)
 5	parallel port is accessed (via PORT 0278h-027Fh or PORT 0378h-037Fh)
 4	video controller is accessed
 3	IDE or Floppy controller is accessed
 2	reserved (0)
 1	a primary interrupt occurrs (see #01049 [offset 44h])
 0	ISA busmaster or DMA activity occurrs
SeeAlso: #P1070,#P1069

Bitfields for AMD-645 GP Timer Reload Enable register:
Bit(s)	Description	(Table P1072)
 31-8	reserved (0)
 7	reload GP1 whenever keyboard controller is accessed
 6	reload GP1 whenever a serial port is accessed
 5	reserved (0)
 4	reload GP1 whenever video controller is accessed
 3	reload GP1 whenever IDE or floppy controller is accessed
 2-1	reserved (0)
 0	reload GP0 whenever a primary activity is detected
SeeAlso: #P1071,#P1070

Bitfields for AMD-645 GPIO Direction Control register:
Bit(s)	Description	(Table P1073)
 7-5	reserved (0)
 4	direction of GPIO4 (0 = input, 1 = output)
	this bit sets Pin136, which is always output if configured as GPO_WE#
 3	direction of GPIO3 (0 = input, 1 = output)
	this bit sets Pin92, which is always an output if configured as GPI_RE#
 2	direction of GPIO2/I2CD1 (0 = input, 1 = output)
 1	direction of GPIO1/I2CD2 (0 = input, 1 = output)
 0	direction of GPIO0 (0 = input, 1 = output)
SeeAlso: #P1071,#P1074

Bitfields for AMD-645 GPIO Port Output Value register:
Bit(s)	Description	(Table P1074)
 7-5	reserved
 4	value for GPIO4 pin (ignored if pin configured as GPO_WE#)
 3	value for GPIO3 pin (ignored if pin configured as GPI_RE#)
 2	value for GPIO2/I2CD1 pin
 1	value for GPIO1/I2CD2 pin
 0	value for GPIO0 pin
Note:	while these bits can be read back, they only indicate the values which
	  are driven onto the pins if configured for output; to read the actual
	  input values, use the "input value" register at offset 44h
	  (see #P1075)
SeeAlso: #P1075

Bitfields for GPIO Port Input Value (EXTSMI_VAL) register:
Bit(s)	Description	(Table P1075)
 7	(if GPIO3 set to input) current EXTSMI7# on XD7 (Pin122)
 6	(if GPIO3 set to input) current EXTSMI6# on XD6 (Pin121)
 5	(if GPIO3 set to input) current EXTSMI5# on XD5 (Pin119)
 4	(if GPIO4 set to input) current EXTSMI4# on XD4 (Pin118)
	(if GPIO4 set to output) current EXTSMI4# on GPIO4 (Pin136)
 3	(if GPIO3 set to input) current EXTSMI3# on XD3 (Pin117)
	(if GPIO3 set to output) current EXTSMI3# on GPIO3 (Pin92)
 2	GPIO2 input value
 1	GPIO1 input value
 0	GPIO0 input value
SeeAlso: #P1074
--------X-Pxxxx------------------------------
PORT xxxx - AMD-645 - USB
SeeAlso: #01046 at INT 1A/AX=B10Ah/SF=1106h
Note:	further details are supposedly in the UHCI v1.1 standard

+000w ?W  USB command
+002w R?  USB status
+004w ?W  USB interrupt enable
+006w ??  frame number
+008d ??  frame list base address
+00C  ??  Start of Frame Modify
+00D	unused???
+010w RW  Port 1 Status/Control
+012w RW  Port 2 Status/Control
----------Pxxxx------------------------------
PORT xxxx - Ensoniq AudioPCI ES1370 - CONTROL REGISTERS
Range:	anywhere on 64 byte boundary

+000d RW  interrupt/chip select control register (see #P1076)
+004d R-  interrupt/chip select status register (see #P1077)
+008  RW  UART data register (MIDI data)
+009  -W  UART control register (see #P1078)
+009  R-  UART status register (see #P1079)
+00A  RW  UART reserved register (see #P1080)
+00Cd RW  memory page register (see #P1081)
+010d -W  CODEC write register (see #P1082)
+020d RW  serial interface control register (see #P1083)
+024d RW  DAC1 channel sample count register (see #P1084)
+028d RW  DAC2 channel sample count register (see #P1084)
+02Cd RW  ADC channel sample count register (see #P1084)
+030d RW  internal memory 1 (see #P1085)
+034d RW  internal memory 2 (see #P1086)
+038d RW  internal memory 3 (see #P1087)
+03Cd RW  internal memory 4 (see #P1088)

Bitfields for Ensoniq ES1370/ES1371 interrupt/chip select control register:
Bit(s)	Description	(Table P1076)
---AudioPCI ES1370---
 31	record buffer transfer disable (ADC stop)
 30	(bit 0 = 0) general purpose output
	(bit 0 = 1) external IRQ output
 29	reserved
 28-16	programmable clock divide ratio (DAC2)
---AudioPCI-97 ES1371---
 31-26	reserved
 25-24	joystick base I/O address
	00 = 200h
	01 = 208h
	10 = 210h
	11 = 218h
 23-20	GPIO pin 3-0 (read-only)
 19-16	GPIO pin 3-0 output
------
 15	MPEG data format
	0 = Sony (lrclk high = left channel; data left justified)
	1 = I2S (lrclk low = left channel; data 1 bit clock delayed)
---AudioPCI ES1370---
 14	CODEC DAC (DAC2) source
	0 = programmable clock generator
	1 = MPEG clocks
 13-12	fixed frequency clock generator frequency (DAC1)
	00 = 5.512 KHz
	01 = 11.025 KHz
	10 = 22.05 KHz
	11 = 44.1 KHz
 11	CODEC DACs synchronous with fixed frequency clock generator
---AudioPCI-97 ES1371---
 14	AC97 warm reset
 13	CCB record transfer disable
 12	power management level change interrupt enable
 11	record channel source
	0 = CODEC ADC
	1 = I2S
------
 10	CCB voice interrupts enable
---AudioPCI ES1370---
 9	record channel source in serial module
	0 = CODEC ADC
	1 = MPEG
 8	general purpose output
---AudioPCI-97 ES1371---
 9-8	current power down level
	00-11 = D0-D3
------
 7	memory bus request enable (disables memory access) (test purposes only)
 6	DAC1 (CODEC FM DAC) playback channel enable
 5	DAC2 (CODEC DAC) playback channel enable
 4	CODEC ADC record channel enable
 3	UART enable
 2	joystick enable
---AudioPCI ES1370---
 1	CODEC interface enable
 0	PCI serr signal disable
---AudioPCI-97 ES1371---
 1	crystal clock input disable
 0	PCI clock input disable
------
Note:	this register is addressable as byte, word and dword

Bitfields for Ensoniq ES1370/ES1371 interrupt/chip select status register:
Bit(s)	Description	(Table P1077)
---AudioPCI ES1370---
 31	DAC1, DAC2, ADC, UART or CCB interrupt occurred
 30-11	reserved
 10	CODEC busy or register write in progress
 9	CODEC busy
 8	CODEC register write in progress
 7	reserved
 6-5	CCB voice code (if bit 4 = 1)
	00 = DAC1
	01 = DAC2
	10 = ADC
	11 = reserved
---AudioPCI-97 ES1371---
 31	DAC1, DAC2, ADC, UART, CCB or power management interrupt occurred
 30-9	reserved
 8	CODEC synchronization error
 7-6	CCB voice code (if bit 4 = 1)
	00 = DAC1
	01 = DAC2
	10 = ADC
	11 = reserved
 5	power level interrupt status
------
 4	CCB interrupt status
 3	UART interrupt status
 2	DAC1 playback channel interrupt status
 1	DAC2 playback channel interrupt status
 0	ADC record channel interrupt status

Bitfields for Ensoniq ES1370/ES1371 UART control register:
Bit(s)	Description	(Table P1078)
 7	UART receiver interrupt enable
 6-5	UART transmitter operation
	01 = Txrdy interrupts enabled
 4-2	reserved
 1-0	UART control
	11 = software reset

Bitfields for Ensoniq ES1370/ES1371 UART status register:
Bit(s)	Description	(Table P1079)
 7	UART receiver interrupt status
 6-3	reserved
 2	UART transmitter interrupt status
 1	UART transmitter ready
 0	UART receiver ready

Bitfields for Ensoniq ES1370/ES1371 UART reserved register:
Bit(s)	Description	(Table P1080)
 7-1	reserved
 0	UART test mode enable (UART clock switched to PCI bus clock)

Bitfields for Ensoniq ES1370/ES1371 memory page register:
Bit(s)	Description	(Table P1081)
 31-4	reserved
 3-0	memory page select (accessed in registers 30h-3Fh)
	0000 = DAC1 sample bytes 15-0 (lower half buffer)
	0001 = DAC1 sample bytes 31-16
	0010 = DAC1 sample bytes 47-32 (upper half buffer)
	0011 = DAC1 sample bytes 63-48
	0100 = DAC2 sample bytes 15-0 (lower half buffer)
	0101 = DAC2 sample bytes 31-16
	0110 = DAC2 sample bytes 47-32 (upper half buffer)
	0111 = DAC2 sample bytes 63-48
	1000 = ADC sample bytes 15-0 (lower half buffer)
	1001 = ADC sample bytes 31-16
	1010 = ADC sample bytes 47-32 (upper half buffer)
	1011 = ADC sample bytes 63-48
	1100 = DAC1/DAC2 frame information
	1101 = ADC frame information
	1110 = UART FIFO
	1111 = UART FIFO
Note:	this register is addressable as byte, word and dword

Bitfields for Ensoniq ES1370/ES1371 CODEC write register:
Bit(s)	Description	(Table P1082)
---AudioPCI ES1370---
 31-16	reserved
 15-8	CODEC register index
---AudioPCI-97 ES1371---
 31-24	reserved
 23	AC97 CODEC read/write
	0 = write
	1 = read
 22-16	AC97 CODEC register index
------
 7-0	CODEC register data
---index 16h---
 1	0 = CODEC power down
------
Note:	(AudioPCI ES1370) this register is addressable as word and dword

Bitfields for Ensoniq ES1370/ES1371 serial interface control register:
Bit(s)	Description	(Table P1083)
 31-22	reserved
 22	(ES1371) DAC test mode enable (selects I2S lrclk input as  source for
	  playback and record channels)
 21-19	sample address counter loop binary offset
 18-16	sample address counter channel start/restart binary offset
 15	ADC channel action when sample count reaches zero
	0 = loop (interrupt set, keep recording)
	1 = stop (inteerupt set, stop recording)
 14	DAC2 channel action when sample count reaches zero
	0 = loop (interrupt set, keep playing)
	1 = stop (inteerupt set, play last sample)
 13	DAC1 channel action when sample count reaches zero (same values as
	  bit 14)
 12	DAC2 channel playback pause
 11	DAC1 channel playback pause
 10	ADC interrupt enable
 9	DAC2 interrupt enable
 8	DAC1 interrupt enable
 7	DAC1 sample counter reload
 6	DAC2 sample counter reload
 5-4	ADC channel data format
	00 = 8-bit mono
	01 = 8-bit stereo
	10 = 16-bit mono
	11 = 16-bit stereo
 3-2	DAC2 channel data format (same values as bits 5-4)
 1-0	DAC1 channel data format (same values as bits 5-4)
Note:	this register is addressable as byte, word and dword

Bitfields for Ensoniq ES1370/ES1371 DAC1/2/ADC channel sample count register:
Bit(s)	Description	(Table P1084)
 31-16	sample counter current value (read-only)
 15-0	sample counter (samples - 1)
Note:	these registers are addressable as word and dword

Bitfields for Ensoniq ES1370/ES1371 internal memory 1:
Bit(s)	Description	(Table P1085)
---register +00Ch bits 3-0 = 0000---
 31-0	DAC1 sample bytes 3-0
---register +00Ch bits 3-0 = 0001---
 31-0	DAC1 sample bytes 19-16
---register +00Ch bits 3-0 = 0010---
 31-0	DAC1 sample bytes 35-32
---register +00Ch bits 3-0 = 0011---
 31-0	DAC1 sample bytes 51-48
---register +00Ch bits 3-0 = 0100---
 31-0	DAC2 sample bytes 3-0
---register +00Ch bits 3-0 = 0101---
 31-0	DAC2 sample bytes 19-16
---register +00Ch bits 3-0 = 0110---
 31-0	DAC2 sample bytes 35-32
---register +00Ch bits 3-0 = 0111---
 31-0	DAC2 sample bytes 51-48
---register +00Ch bits 3-0 = 1000---
 31-0	ADC sample bytes 3-0
---register +00Ch bits 3-0 = 1001---
 31-0	ADC sample bytes 19-16
---register +00Ch bits 3-0 = 1010---
 31-0	ADC sample bytes 35-32
---register +00Ch bits 3-0 = 1011---
 31-0	ADC sample bytes 51-48
---register +00Ch bits 3-0 = 1100---
 31-0	DAC1 sample buffer memory address
---register +00Ch bits 3-0 = 1101---
 31-0	ADC sample buffer memory address
---register +00Ch bits 3-0 = 1110---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
---register +00Ch bits 3-0 = 1111---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
------
SeeAlso: #P1086

Bitfields for Ensoniq ES1370/ES1371 internal memory 2:
Bit(s)	Description	(Table P1086)
---register +00Ch bits 3-0 = 0000---
 31-0	DAC1 sample bytes 7-4
---register +00Ch bits 3-0 = 0001---
 31-0	DAC1 sample bytes 23-20
---register +00Ch bits 3-0 = 0010---
 31-0	DAC1 sample bytes 39-36
---register +00Ch bits 3-0 = 0011---
 31-0	DAC1 sample bytes 55-52
---register +00Ch bits 3-0 = 0100---
 31-0	DAC2 sample bytes 7-4
---register +00Ch bits 3-0 = 0101---
 31-0	DAC2 sample bytes 23-20
---register +00Ch bits 3-0 = 0110---
 31-0	DAC2 sample bytes 39-36
---register +00Ch bits 3-0 = 0111---
 31-0	DAC2 sample bytes 55-52
---register +00Ch bits 3-0 = 1000---
 31-0	ADC sample bytes 7-4
---register +00Ch bits 3-0 = 1001---
 31-0	ADC sample bytes 23-20
---register +00Ch bits 3-0 = 1010---
 31-0	ADC sample bytes 39-36
---register +00Ch bits 3-0 = 1011---
 31-0	ADC sample bytes 55-52
---register +00Ch bits 3-0 = 1100---
 31-16	DAC1 dwords transferred
 15-0	DAC1 dwords in buffer - 1
---register +00Ch bits 3-0 = 1101---
 31-16	ADC dwords transferred
 15-0	ADC dwords in buffer - 1
---register +00Ch bits 3-0 = 1110---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
---register +00Ch bits 3-0 = 1111---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
------
SeeAlso: #P1085,#P1087

Bitfields for Ensoniq ES1370/ES1371 internal memory 3:
Bit(s)	Description	(Table P1087)
---register +00Ch bits 3-0 = 0000---
 31-0	DAC1 sample bytes 11-8
---register +00Ch bits 3-0 = 0001---
 31-0	DAC1 sample bytes 27-24
---register +00Ch bits 3-0 = 0010---
 31-0	DAC1 sample bytes 43-40
---register +00Ch bits 3-0 = 0011---
 31-0	DAC1 sample bytes 59-56
---register +00Ch bits 3-0 = 0100---
 31-0	DAC2 sample bytes 11-8
---register +00Ch bits 3-0 = 0101---
 31-0	DAC2 sample bytes 27-24
---register +00Ch bits 3-0 = 0110---
 31-0	DAC2 sample bytes 43-40
---register +00Ch bits 3-0 = 0111---
 31-0	DAC2 sample bytes 59-56
---register +00Ch bits 3-0 = 1000---
 31-0	ADC sample bytes 11-8
---register +00Ch bits 3-0 = 1001---
 31-0	ADC sample bytes 27-24
---register +00Ch bits 3-0 = 1010---
 31-0	ADC sample bytes 43-40
---register +00Ch bits 3-0 = 1011---
 31-0	ADC sample bytes 59-56
---register +00Ch bits 3-0 = 1100---
 31-0	DAC2 sample buffer memory address
---register +00Ch bits 3-0 = 1101---
 31-0	reserved
---register +00Ch bits 3-0 = 1110---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
---register +00Ch bits 3-0 = 1111---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
------
SeeAlso: #P1086,#P1088

Bitfields for Ensoniq ES1370/ES1371 internal memory 4:
Bit(s)	Description	(Table P1088)
---register +00Ch bits 3-0 = 0000---
 31-0	DAC1 sample bytes 15-12
---register +00Ch bits 3-0 = 0001---
 31-0	DAC1 sample bytes 31-28
---register +00Ch bits 3-0 = 0010---
 31-0	DAC1 sample bytes 47-44
---register +00Ch bits 3-0 = 0011---
 31-0	DAC1 sample bytes 63-60
---register +00Ch bits 3-0 = 0100---
 31-0	DAC2 sample bytes 15-12
---register +00Ch bits 3-0 = 0101---
 31-0	DAC2 sample bytes 31-28
---register +00Ch bits 3-0 = 0110---
 31-0	DAC2 sample bytes 47-44
---register +00Ch bits 3-0 = 0111---
 31-0	DAC2 sample bytes 63-60
---register +00Ch bits 3-0 = 1100---
 31-16	DAC2 dwords transferred
 15-0	DAC2 dwords in buffer - 1
---register +00Ch bits 3-0 = 1101---
 31-0	reserved
---register +00Ch bits 3-0 = 1110---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
---register +00Ch bits 3-0 = 1111---
 31-9	reserved
 8	UART data valid
 7-0	UART data received through MIDI interface
------
SeeAlso: #P1087
----------Pxxxx------------------------------
PORT xxxx - Ensoniq AudioPCI-97 ES1371 - CONTROL REGISTERS
Range:	anywhere on 64 byte boundary

+000d RW  interrupt/chip select control register (see #P1076)
+004d R-  interrupt/chip select status register (see #P1077)
+008  RW  UART data register (MIDI data)
+009  -W  UART control register (see #P1078)
+009  R-  UART status register (see #P1079)
+00A  RW  UART reserved register (see #P1080)
+00Cd RW  memory page register (see #P1081)
+010d RW  sample rate converter interface register (see #P1089)
+014d -W  CODEC write register (see #P1082)
+014d R-  CODEC read register (see #P1090)
+018d RW  legacy control/status register (see #P1091)
+020d RW  serial interface control register (see #P1083)
+024d RW  DAC1 channel sample count register (see #P1084)
+028d RW  DAC2 channel sample count register (see #P1084)
+02Cd RW  ADC channel sample count register (see #P1084)
+030d RW  internal memory 1 (see #P1085)
+034d RW  internal memory 2 (see #P1086)
+038d RW  internal memory 3 (see #P1087)
+03Cd RW  internal memory 4 (see #P1088)

Bitfields for Ensoniq AudioPCI-97 ES1371 sample rate converter interface:
Bit(s)	Description	(Table P1089)
 31-25	sample rate converter RAM address
 24	sample rate converter read/write control
 23	sample rate converter busy (read-only)
 22	sample rate converter disable
 21	playback channel 1 accumulator update disable
 20	playback channel 2 accumulator update disable
 19	record channel accumulator update disable
 18-16	reserved
 15-0	sample rate converter RAM data

Bitfields for Ensoniq AudioPCI-97 ES1371 CODEC read register:
Bit(s)	Description	(Table P1090)
 31	AC97 CODEC data ready
 30	AC97 CODEC register access in progress
 29-24	reserved
 23	AC97 CODEC read/write
	0 = write
	1 = read
 22-16	AC97 CODEC register index
 7-0	AC97 CODEC register data

Bitfields for Ensoniq AudioPCI-97 ES1371 legacy control/status register:
Bit(s)	Description	(Table P1091)
 31	joystick timing
	0 = ISA
	1 = fast
 30	host interrupt blocking enable ???
 29	Sound Blaster capture address range
	0 = 220h-22Fh
	1 = 240h-24Fh
 28-27	SoundScape base register capture address range
	00 = 320h-327h
	01 = 330h-337h
	10 = 340h-347h
	11 = 350h-357h
 26-25	CODEC capture address range
	00 = 530h-537h
	01 = reserved
	10 = E80h-E87h
	11 = F40h-F47h
 24	force interrupt
 23	slave DMA controller event capture enable (address range C0h-DFh)
 22	slave interrupt controller event capture enable (address range A0h-A1h)
 21	master DMA controller event capture enable (address range 0h-Fh)
 20	master interrupt controller event capture enable (address range
	  20h-21h)
 19	AdLib register event capture enable (address range 388h-38Bh)
 18	Sound Blaster register event capture enable (address range selected by
	  bit 29)
 17	CODEC event capture enable (address range selected by bits 26-25)
 16	SoundScape base address register event capture enable (address range
	  selected by bits 28-27)
 15-11	reserved
 10-8	captured event (read-only)
	000 = SoundScape base address
	001 = CODEC
	010 = Sound Blaster register
	011 = AdLib register
	100 = master interrupt controller
	101 = master DMA controller
	110 = slave interrupt controller
	111 = slave DMA controller
 7-3	captured event I/O address bits 4-0 (read-only)
 2	captured event read/write (read-only)
	0 = read
	1 = write
 1	reserved
 0	interrupt flag (write to reset)
	0 = interrupt occurred
	0 = interrupt not occurred
Note:	this register is addressable as byte, word and dword
--------d-Pxxxx------------------------------
PORT xxxx - Intel 82371, OPTi "Vendetta" (82C750) - Bus Master IDE Registers

+000  RW  command register, primary channel (see #P1092)
+002  Rw  status register, primary channel (see #P1093)
+004d RW  IDE descriptor table pointer, primary channel (see #P1094)
+008  RW  command register, secondary channel (see #P1092)
+00A  Rw  status register, secondary channel (see #P1093)
+00Cd RW  IDE descriptor table pointer, secondary channel (see #P1094)

Bitfields for Intel 82371 Bus Master IDE command register:
Bit(s)	Description	(Table P1092)
 7-4	reserved
 3	bus master read/write control
	=0 read
	=1 write
 2-1	reserved
 0	start/stop bus master
	=1 start
	=0 stop
SeeAlso: #P1093,#P1094

Bitfields for Bus Master IDE status register:
Bit(s)	Description	(Table P1093)
 7	(Intel) reserved (0)
	(OPTI "Vendetta") both channels operable at same time (read-only)
 6	drive 1 is DMA-capable
 5	drive 0 is DMA_capable
 4-3	reserved
 2	IDE interrupt pending
	write 1 to this bit to clear it
 1	IDE DMA error
	write 1 to this bit to clear it
 0	bus master IDE active (read-only)
SeeAlso: #P1092,#P1094

Bitfields for Bus Master IDE descriptor table pointer register:
Bit(s)	Description	(Table P1094)
 31-2	descriptor table base address bits 31-2
 1-0	reserved (0)
Notes:	(Intel 82371) the descriptor table must not cross a 4K boundary
	(OPTi "Vendetta") the descriptor table must not cross a 64K boundary
SeeAlso: #P1092,#P1093
----------Pxxxx------------------------------
PORT xxxx - Intel 82371SB - USB Host I/O Registers
InstallCheck: see #01215 at INT 1A/AX=B10Ah
SeeAlso: #01215

+000w RW  USB command register (see #P1095)
+002w Rw  USB status (see #P1096)
+004w RW  USB interrupt enable (see #P1097)
+006w RW  Frame Number (see #P1098)
+008d RW  Frame List Base Address
	   (bits 11-0 must be written as zeros)
+00C  RW  Start of Frame Modify (see #P1099)
+010w RW  port 1 status/control (see #P1100)
+012w RW  port 2 status/control (see #P1100)

Bitfields for Intel 82371SB USB command register:
Bit(s)	Description	(Table P1095)
 15-8	reserved
 7	maximum packet size (0=32 bytes, 1=64 bytes)
 6	Host Controller has been configured (set by software)
 5	software debug mode
 4	force global resume
 3	enter global suspend mode
 2	global reset
 1	host controller reset
 0	run/stop schedule (0=stop, 1=run)
SeeAlso: #P1096

Bitfields for Intel 82371SB USB status register:
Bit(s)	Description	(Table P1096)
 15-6	reserved
 5	host controller halted
 4	host controller process error
 3	PCI bus error
 2	resume received
 1	USB error interrupt
 0	USB interrupt
Note:	to clear a bit in this register, write a 1 to it
SeeAlso: #P1095

Bitfields for Intel 82371SB USB interrupt enable register:
Bit(s)	Description	(Table P1097)
 15-4	reserved
 3	enable short packet interrupts
 2	enable Interrupt On Complete
 1	enable Resume
 0	enable Timeout/CRC
SeeAlso: #P1096,#P1098

Bitfields for Intel 82371SB Frame Number register:
Bit(s)	Description	(Table P1098)
 15-11	reserved
 10-0	Frame List Current Index/Frame Number
	incremented at end of each time frame (~1ms)
Note:	only WORD writes are allowed to this register
SeeAlso: #P1095,#P1097

Bitfields for Intel 82371SB Start of Frame Modify register:
Bit(s)	Description	(Table P1099)
 7	reserved
 6-0	SOF timing value (default 64)
Note:	SOF cycle time equals 11936+timing value
SeeAlso: #P1095

Bitfields for Intel 82371SB Port 1/2 status/control register:
Bit(s)	Description	(Table P1100)
 15-13	reserved (0)
 12	suspend port
 11-10	reserved
 9	port in Reset State
 8	low-speed device is attached (read-only)
 7	reserved (1)
 6	resume detected (read-only)
 5-4	line status (read-only)
	bit 4: D+ signal line
	bit 5: D- signal line
 3	port enabled/disabled status has changed
	write 1 to this bit to clear it
 2	port is enabled
 1	connect status has changed
	write 1 to this bit to clear it
 0	current connect status (read-only)
Note:	only WORD writes are permitted to this register
SeeAlso: #P1095
--------!---CREDITS--------------------------
Wim Osterholt		<wim@djo.wtm.tudelft.nl>		Original File
Chuck Proctor		<71534.2302@CompuServe.COM>
Richard W. Watson	<73042.1420@CompuServe.COM>
Matthias Paul		<matthias.paul@post.rwth-aachen.de>	lots....
Serguei Shtyliov	<serge.fido@coudert.msk.ru>		Xirlink XL-22x
Serguei Shtyliov	<serge.fido@coudert.msk.ru>		TMC-16x0 SCSI
Serguei Shtyliov	<serge.fido@coudert.msk.ru>		AHA-154x SCSI
								MPU-401 MIDI

Some of the information in this list was extracted from Frank van Gilluwe's
_The_Undocumented_PC_, a must-have book for anyone programming down to the
"bare metal" of a PC.

Some of the information in this list from the shareware version of Dave
Williams' DOSREF, v3.0.

8514/A hardware ports found in FractInt v18.0 source file FR8514A.ASM

Compaq QVision info from the _COMPAQ_QVision_Graphics_System_Technical_
_Reference_Guide_, second edition (October 1993).  Compaq part number
073A/0693.  Much more to come!

AMI keyboard controller PORT 0064h commands from the American Megatrends, Inc.
_Version_KF_and_KH_Keyboard_Controller_BIOS_Reference_, available on the
AMI BBS and american.megatrends.com as KFKHMAN.ZIP.

Various chipset infos from "Het BIOS Boekje" 2nd edition, by Alle Metzlar,
ISBN 90-72260-59-7 (1995).

ATA-3 info from "AT Attachment-3 Interface (ATA-3) Revision 1", dated
April 21, 1995.

Some additional EISA info from _EISA_System_Architecture_ (second edition),
by MindShare, Inc. (Addison-Wesley 1995, ISBN 0-201-40995-X).

AMI BIOS diagnostics codes (port 0080h) from file CHECKPTS on AMI BBS.

Some S3 and additional ATI Mach8/Mach32 info from Richard F. Ferraro's
_Programmer's_Guide_to_the_EGA,_VGA,_and_Super_VGA_Cards_, third edition.

PCnet-ISA info from _Am79C960_PCnet-ISA(tm)_Technical_Manual_, May 1992,
available from www.amd.com as 16850B.PDF; additional details from file
16907B.PDF.

PCnet-SCSI info from _Am79C974 PCnet(tm)-SCSI_Combination_Ethernet_and_SCSI_
_Controller_for_PCI_Systems_, available from www.amd.com as 18681B.PDF.

PCnet-FAST info from _Am79C971 PCnet(tm)-FAST_Single-Chip_Full-Duplex_10/100_
_Mbps_Ethernet_Controller_for_PCI_Local_Bus_, available from www.amd.com as
20550B.PDF.

S.M.A.R.T. information from _Self-Monitoring,_Analysis,_and_Reporting_
_Technology_(S.M.A.R.T.)_(SFF-8035i)_, Revision 2.0, April 1, 1996.
Available as 8035r2_0.PDF from fission.dt.wdc.com/pub/standards/SFF/.

A variety of ports from Frank van Giluwe's _The_Undocumented_PC_, second
edition.

[many more sources listed in BIBLIO.LST]
--------!---Admin----------------------------
Highest Table Number = P1017
--------!---FILELIST-------------------------
Please redistribute all of the files comprising the interrupt list (listed at
the beginning of the list and in INTERRUP.1ST) unmodified as a group, in a
quartet of archives named INTER61A through INTER61D (preferably the original
authenticated PKZIP archives), and the utility and hypertext programs in a pair
of additional archives called INTER61E.ZIP and INTER61F.ZIP.

Copyright (c) 1989-1999,2000 Ralf Brown
--------!---CONTACT_INFO---------------------
E-mail: ralf@pobox.com (currently forwards to ralf@telerama.lm.com)
