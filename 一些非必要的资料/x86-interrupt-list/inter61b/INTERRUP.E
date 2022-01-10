Interrupt List, part 5 of 18
Copyright (c) 1989-1999,2000 Ralf Brown
--------X-1AB101-----------------------------
INT 1A - PCI BIOS v2.0c+ - INSTALLATION CHECK
	AX = B101h
	EDI = 00000000h
Return: AH = 00h if installed
	    CF clear
	    EDX = 20494350h (' ICP')
	    EDI = physical address of protected-mode entry point (see #00731)
	    AL = PCI hardware characteristics (see #00730)
	    BH = PCI interface level major version (BCD)
	    BL = PCI interface level minor version (BCD)
	    CL = number of last PCI bus in system
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	some BIOSes do not change EDI, so applications looking for the
	  protected-mode entry point should set EDI to 00000000h before
	  calling this function
SeeAlso: AX=B181h

(Table 00729)
Values for PCI BIOS v2.0c+ status codes:
 00h	successful
 81h	unsupported function
 83h	bad vendor ID
 86h	device not found
 87h	bad PCI register number

Bitfields for PCI hardware characteristics:
Bit(s)	Description	(Table 00730)
 0	configuration space access mechanism 1 supported
 1	configuration space access mechanism 2 supported
 2-3	reserved
 4	Special Cycle generation mechanism 1 supported
 5	Special Cycle generation mechanism 2 supported
 6-7	reserved

(Table 00731)
Call protected-mode entry point with:
	registers as for real/V86-mode INT call
	CS = ring 0 descriptor with access to full address space
Return: as for real/V86-mode call
--------X-1AB102-----------------------------
INT 1A - PCI BIOS v2.0c+ - FIND PCI DEVICE
	AX = B102h
	CX = device ID (see #00735,#00742,#00743,#00873,#00875)
	DX = vendor ID (see #00732)
	SI = device index (0-n)
Return: CF clear if successful
	CF set on error
	AH = status (00h,83h,86h) (see #00729)
	    00h successful
		BH = bus number
		BL = device/function number (bits 7-3 device, bits 2-0 func)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	device ID FFFFh may be reserved as a wildcard in future implementations
	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
	all devices sharing a single vendor ID and device ID may be enumerated
	  by incrementing SI from 0 until error 86h is returned
SeeAlso: AX=B182h

(Table 00732)
Values for PCI vendor ID:
 001Ah	Ascend Communications, Inc.
 003Dh	Martin-Marietta Corporation
 0E11h	Compaq (see #00733)
 1000h	Symbios Logic Inc (formerly NCR) (see #00734)
 1002h	ATI (see #00735)
 1003h	ULSI Systems (see #00736)
 1004h	VLSI Technologies (see #00737)
 1005h	Avance Logics (ADL) (see #00738)
 1006h	Reply Group
 1007h	Netframe Systems Inc.
 1008h	Epson
 100Ah	Phoenix Technologies
 100Bh	National Semiconductor (see #00739)
 100Ch	Tseng Labs (see #00740) (also ID 10BEh)
 100Dh	AST Research
 100Eh	Weitek (see #00741)
 1010h	Video Logic Ltd
 1011h	DEC (see #00742)
 1012h	Micronics Computers
 1013h	Cirrus Logic (see #00743,#00029)
 1014h	IBM (see #00744)
 1015h	LSI Logic Corp. of Canada
 1016h	ICL Personal Systems
 1017h	SPEA Software AG
 1018h	Unisys
 1019h	EliteGroup Computer Sys
 101Ah	NCR/AT&T GIS
 101Bh	Vitesse Semiconductor
 101Ch	Western Digital (see #00745)
 101Eh	AMI (see #00746)
 101Fh	Picturetel
 1020h	Hitachi Computer Electronics
 1021h	Oki Electric Industry
 1022h	Advanced Micro Devices (see #00747)
 1023h	Trident Microsystems (see #00748)
 1024h	Zenith Data Systems
 1025h	Acer
 1028h	Dell Computer Corporation
 1029h	Siemens Nixdorf
 102Ah	LSI Logic, Headland Division (see #00749)
 102Bh	Matrox (see #00750)
 102Ch	Chips & Technologies (see #00751)
 102Dh	Wyse Technologies
 102Eh	Olivetti Advanced Technology
 102Fh	Toshiba America (see #00752)
 1030h	TMC Research
 1031h	Miro Computer Products AG (see #00753)
 1032h	Compaq
 1033h	NEC Corporation (see #00754)
 1034h	Burndy Corporation
 1035h	Computers and Communications Research Lab
 1036h	Future Domain (see #00755)
 1037h	Hitachi Micro Systems
 1038h	AMP Incorporated
 1039h	Silicon Integrated System (SIS) (see #00756)
 103Ah	Seiko Epson Corporation
 103Bh	Tatung Corp. of America
 103Ch	Hewlett-Packard (see #00757)
 103Eh	Solliday
 103Fh	Logic Modeling
 1040h	Kubota Pacific
 1041h	Computrend
 1042h	PC Technology (see #00758,#00928) (see also PORT 03F0h"PCTech")
 1043h	Asustek
 1044h	Distributed Processing Technology (DPT) (see #00759)
 1045h	OPTi (see #00760)
 1046h	IPC Corporation, Ltd.
 1047h	Genoa Systems Corp.
 1048h	Elsa GmbH
 1049h	Fountain Technology
 104Ah	SGS Thomson Microelectric (see #00761)
 104Bh	BusLogic (see #00762)
 104Ch	Texas Instruments (see #00763)
 104Dh	Sony Corporation
 104Eh	Oak Technology (see #00764)
 104Fh	Co-Time Computer Ltd.
 1050h	Winbond (see #00765)
 1051h	Anigma Corp.
 1052h	Young Micro Systems
 1054h	Hitachi, Ltd. (see #00766)
 1055h	EFAR Microsystems (see #00767)
 1056h	ICL
 1057h	Motorola (see #00768)
 1058h	Electronics and Telecommunications Research
 1059h	Teknor Microsystems
 105Ah	Promise Technology (see #00769)
 105Bh	Foxconn International
 105Ch	Wipro Infotech Ltd.
 105Dh	Number 9 Computer Company (see #00770)
 105Eh	VTech Engineering Canada, Ltd.
 105Fh	Infotronic America, Inc.
 1060h	United Microelectronics (UMC) (see #00771)
 1061h	8x8 (X Tech) (see #00772)
 1062h	Maspar Computer Copr.
 1063h	Ocean Office Automation
 1064h	Alcatel Cit
 1065h	Texas Microsystems
 1066h	PicoPower Technology (see #00773)
 1067h	Mitsubishi Electronics
 1068h	Diversified Technology
 1069h	Mylex Corporation (see #00774)
 106Ah	Aten Research
 106Bh	Apple Computer
 106Ch	Hyundai Electronics America
 106Dh	Sequent
 106Eh	DFI Inc.
 106Fh	City Gate Development, Ltd.
 1070h	Daewoo Telecom Ltd.
 1071h	Mitac
 1072h	GIT Co., Ltd.
 1073h	Yamaha Corporation (see #00775)
 1074h	NexGen Microsystems (see #00776)
 1075h	Advanced Integration Research
 1076h	Chaintech Computer Co. Ltd.
 1077h	Q Logic (see #00777)
 1078h	Cyrix Corporation
 1079h	I-Bus
 107Ah	Networth
 107Bh	Gateway 2000
 107Ch	Goldstar Co. Ltd.
 107Dh	Leadtek Research (see #00778)
 107Eh	Interphase Corporation (see #00779)
 107Fh	Data Technology Corporation (DTC) (see #00780)
 1080h	Contaq Microsystems (see #00781)
 1081h	Supermac Technology
 1082h	EFA Corporation of America
 1083h	Forex Computer Corporation (see #00782)
 1084h	Parador
 1085h	Tulip Computers Int'l BV
 1086h	J. Bond Computer Systems
 1087h	Cache Computer
 1088h	Microcomputer Systems (M) Son
 1089h	Data General Corporation
 108Ah	Bit3 Computer (see #00783)
 108Ch	Elonex PLC (Oakleigh Systems, Inc)
 108Dh	Olicom (see #00784)
 108Eh	Sun Microsystems
 108Fh	Systemsoft Corporation
 1090h	Encore Computer Corporation
 1091h	Intergraph Corporation (see #00785)
 1092h	Diamond Computer Systems
 1093h	National Instruments (see #00786)
 1094h	First International Computers (FIC)
 1095h	CMD Technology, Inc. (see #00787)
 1096h	Alacron
 1097h	Appian Technology (see #00788)
 1098h	Vision / Quantum Designs Ltd (see #00789)
 1099h	Samsung Electronics Co. Ltd.
 109Ah	Packard Bell
 109Bh	Gemlight Computer Ltd.
 109Ch	Megachips Corporation
 109Dh	Zida Technologies
 109Eh	Brooktree Corporation (see #00790)
 109Fh	Trigem Computer Inc.
 10A0h	Meidensha Corporation
 10A1h	Juko Electronics Inc. Ltd.
 10A2h	Quantum Corporation
 10A3h	Everex Systems Inc.
 10A4h	Globe Manufacturing Sales
 10A5h	Racal Interlan
 10A6h	Informtech Industrial Ltd.
 10A7h	Benchmarq Microelectronics
 10A8h	Sierra Semiconductor (see #00791)
 10A9h	Silicon Graphics
 10AAh	ACC Microelectronics (see #00792)
 10ABh	Digicom
 10ACh	Honeywell IASD
 10ADh	Symphony Labs (see #00793)
 10AEh	Cornerstone Technology
 10AFh	Microcomputer Systems
 10B0h	CardExpert Technology
 10B1h	Cabletron Systems, Inc.
 10B2h	Raytheon Company
 10B3h	Databook Inc
 10B4h	STB Systems
 10B5h	PLX Technology (see #00794)
 10B6h	Madge Networks (see #00795)
 10B7h	3com Corporation (see #00796)
 10B8h	Standard Microsystems Corporation (SMC) (see #00797)
 10B9h	Acer Labs Inc. (see #00798)
 10BAh	Mitsubishi Electronics Corp.
 10BBh	Dapha Electronics Corporation
 10BCh	Advanced Logic Research Inc. (ALR)
 10BDh	Surecom Technology (see #00799)
 10BEh	Tseng Labs International Corp. (see #00740)
 10BFh	Most Inc.
 10C0h	Boca Research Inc.
 10C1h	ICM Corp. Ltd.
 10C2h	Auspex Systems Inc.
 10C3h	Samsung Semiconductors
 10C4h	Award Software International Inc.
 10C5h	Xerox Corporation
 10C6h	Rambus Inc.
 10C7h	Media Vision
 10C8h	Neomagic Corporation (see #00800)
 10C9h	DataExpert Corporation
 10CAh	Fujitsu
 10CBh	Omron Corporation
 10CCh	Mentor Arc Inc.
 10CDh	Advanced System Products (see #00801)
 10CEh	Radius Inc.
 10CFh	Citicorp TTI (see #00802)
 10D0h	Fujitsu Limited
 10D1h	Future+ Systems
 10D2h	Molex Incorporated
 10D3h	Jabil Circuit Inc.
 10D4h	Hualon Microelectronics
 10D5h	Autologic Inc.
 10D6h	Cetia
 10D7h	BCM Advanced Research
 10D8h	Advanced Peripherals Labs
 10D9h	Macronix International Co. Ltd
 10DAh	Thomas-Conrad Corporation
 10DBh	Rohm Research
 10DCh	CERN/ECP/EDU (see #00803)
 10DDh	Evans & Sutherland (see #00804)
 10DEh	NVIDIA Corporation
 10DFh	Emulex Corporation (see #00805)
 10E0h	Integrated Micro Solutions (IMS) (see #00806)
 10E1h	TekRAM Technology Corporation Ltd. (see #00807)
 10E2h	Aptix Corporation
 10E3h	Newbridge Microsystems (see #00808)
 10E4h	Tandem Computers
 10E5h	Micro Industries
 10E6h	Gainbery Computer Products Inc.
 10E7h	Vadem
 10E8h	Applied Micro Circuits Corp. (see #00809)
 10E9h	Alps Electronic Corp. Ltd.
 10EAh	Integraphics Systems (see #00810)
 10EBh	Artist Graphics (see #00811)
 10ECh	Realtek Semiconductor (see #00812)
 10EDh	ASCII Corporation (see #00813)
 10EEh	Xilinx Corporation
 10EFh	Racore Computer Products
 10F0h	Peritek Corporation
 10F1h	Tyan Computer
 10F2h	Achme Computer Inc.
 10F3h	Alaris Inc.
 10F4h	S-MOS Systems
 10F5h	NKK Corporation (see #00814)
 10F6h	Creative Electronic Systems SA
 10F7h	Matsushita Electric Industrial Corp. Ltd.
 10F8h	Altos India Ltd.
 10F9h	PC Direct
 10FAh	Truevision (see #00815)
 10FBh	Thesys Ges. fr Microelektronik mbH
 10FCh	I/O Data Device Inc.
 10FDh	Soyo Technology Corp. Ltd.
 10FEh	Fast Electronic GmbH
 10FFh	N-Cube
 1100h	Jazz Multimedia
 1101h	Initio Corporation (see #00816)
 1102h	Creative Labs
 1103h	Triones Technologies Inc.
 1104h	Rasterops
 1105h	Sigma Designs, Inc.
 1106h	VIA Technologies (see #00817)
 1107h	Stratus Computer
 1108h	Proteon Inc. (see #00818)
 1109h	Cogent Data Technologies (see #00819)
 110Ah	Siemens AG / Siemens Nixdorf AG (see #00820)
 110Bh	Xenon Microsystems / Chromatic Research, Inc.
 110Ch	Mini-Max Technology Inc.
 110Dh	ZNyX Corporation
 110Eh	CPU Technology
 110Fh	Ross Technology
 1110h	Powerhouse Systems
 1111h	Santa Cruz Operation (SCO)
 1112h	Rockwell / RNS division of Meret Communications Inc. (see #00821)
 1113h	Accton Technology Corporation
 1114h	Atmel Corporation
 1115h	DuPont Pixel Systems
 1116h	Data Translation / Media 100, Inc.
 1117h	Datacube Inc. (see #00822)
 1118h	Berg Electronics
 1119h	Vortex Computersysteme GmbH (see #00823)
 111Ah	Efficient Networks, Inc. (see #00824)
 111Bh	Teledyne Electronic Systems
 111Ch	Tricord Systems, Inc.
 111Dh	Integrated Device Technology
 111Eh	Eldec Corporation
 111Fh	Precision Digital Images
 1120h	EMC Corporation
 1121h	Zilog
 1122h	Multi-tech Systems, Inc.
 1123h	Excellent Design, Inc.
 1124h	Leutron Vision AG
 1125h	Eurocore
 1126h	Vigra
 1127h	FORE Systems (see #00825)
 1128h	???
 1129h	Firmworks
 112Ah	Hermes Electronics Co.
 112Bh	Linotype - Hell AG
 112Dh	Ravicad
 112Eh	Infomedia MicroElectronics Inc (see #00826)
 112Fh	Imaging Technology (see #00827)
 1130h	Computervision
 1131h	Philips Semiconductors
 1132h	Mitel Corp
 1133h	Eicon Technology Corporation
 1134h	Mercury Computer Systems Inc (see #00828)
 1135h	Fuji Xerox Co Ltd (see #00829)
 1136h	Momentum Data Systems
 1137h	Cisco Systems Inc
 1138h	Ziatech Corporation (see #00830)
 1139h	Dynamic Pictures Inc (see #00831)
 113Ah	FWB Inc
 113Ch	Cyclone Microsystems (PLX) (see #00832)
 113Dh	Leading Edge Products Inc
 113Eh	Sanyo Electric Co. - Computer Engineering Dept.
 113Fh	Equinox Systems
 1140h	Intervoice Inc
 1141h	Crest Microsystem Inc (see #00833)
 1142h	Alliance Semiconductor Corp (see #00834)
 1143h	Netpower, Inc.
 1144h	Cincinnati Milacron / Vickers Inc. Electronic Systems (see #00835)
 1145h	Workbit Corp
 1146h	Force Computers
 1147h	Interface Corp.
 1148h	Schneider & Koch Co. / Syskonnect (see #00836)
 1149h	Win System Corporation
 114Ah	VMIC (see #00837)
 114Bh	Canopus Co.
 114Ch	Annabooks
 114Dh	IC Corporation
 114Eh	Nikon Systems Inc
 114Fh	Digi International / Stargate (see #00838)
 1150h	Thinking Machines Corp.
 1151h	JAE Electronics Inc.
 1152h	Megatek
 1153h	Land Win Electronic Corp.
 1154h	Melco Inc.
 1155h	Pine Technology Ltd.
 1156h	Periscope Engineering
 1157h	Avsys Corporation
 1158h	Voarx R&D Inc. (see #00839)
 1159h	MuTech (see #00840)
 115Ah	Harleguin Ltd.
 115Bh	Parallax Graphics
 115Ch	Photron, Ltd.
 115Dh	Xircom
 115Eh	Peer Protocols Inc.
 115Fh	???
 1160h	Megasoft Inc.
 1161h	PFU Ltd. (see #00841)
 1162h	OA Laboratory Co Ltd.
 1163h	Creative Labs / Rendition (see #00842)
 1164h	Advanced Peripherals Tech
 1165h	Imagraph Corporation (see #00843)
 1166h	Pequr Technology Inc. / Relience Computer
 1167h	Mutoh Industries, Inc.
 1168h	Thine Electronics Inc
 1169h	Centre for Development of Advanced Computing
 116Ah	Polaris Communications
 116Bh	Connectware Inc
 116Ch	???
 116Dh	???
 116Eh	???
 116Fh	Workstation Technology
 1170h	Inventec Corporation
 1171h	Loughborough Sound Images
 1172h	Altera Corporation
 1173h	Adobe Systems
 1174h	Bridgeport Machines
 1175h	Mitron Computer Inc.
 1176h	SBE
 1177h	Silicon Engineering
 1178h	Alfa Inc (see #00844)
 1179h	Toshiba America Info Systems
 117Ah	A-Trend Technology
 117Bh	LG Electronics Inc.
 117Ch	Atto Technology
 117Dh	???
 117Eh	T/R Systems
 117Fh	???
 1180h	Ricoh Co Ltd
 1181h	Telmatics International
 1182h	???
 1183h	Fujikura Ltd
 1184h	Forks Inc
 1185h	Dataworld
 1186h	D-Link System Inc
 1187h	Advanced Technology Laboratories
 1188h	Shima Seiki Manufacturing Ltd.
 1189h	Matsushita Electronics (see #00845)
 118Ah	Hilevel Technology
 118Bh	???
 118Ch	Corollary Inc (see #00846)
 118Dh	BitFlow Inc (see #00847)
 118Eh	Hermstedt GmbH
 118Fh	???
 1190h	???
 1191h	Artop Electric / Acard Technology Corp. (see #00848)
 1192h	Densan Co. Ltd
 1193h	Zeitnet Inc. (see #00849)
 1194h	Toucan Technology
 1195h	Ratoc System Inc
 1196h	Hytec Electronics Ltd
 1197h	Gage Applied Sciences Inc.
 1198h	Lambda Systems Inc
 1199h	Digital Communications Associates Inc,
 119Ah	Mind Share Inc.
 119Bh	Omega Micro Inc.
 119Ch	Information Technology Inst.
 119Dh	Bug Sapporo Japan
 119Eh	Fujitsu
 119Fh	Bull Hn Information Systems
 11A0h	Convex Computer Corporation
 11A1h	Hamamatsu Photonics K.K.
 11A2h	Sierra Research and Technology
 11A3h	Deuretzbacher GmbH & Co. Eng. KG
 11A4h	Barco
 11A5h	MicroUnity Systems Engineering, Inc.
 11A6h	Pure Data
 11A7h	Power Computing Corp.
 11A9h	InnoSys Inc. (see #00850)
 11AAh	Actel
 11ABh	Galileo Technology Ltd. (see #00851)
 11ACh	Canon Information Systems
 11ADh	Lite-On Communications Inc
 11AEh	Scitex Corporation Ltd
 11AFh	Pro-Log Corporation / Avid Technology Corp.
 11B0h	V3 Semiconductor Inc. (see #00852)
 11B1h	Apricot Computers
 11B2h	Eastman Kodak
 11B3h	Barr Systems Inc.
 11B4h	Leitch Technology International
 11B5h	Radstone Technology Plc
 11B6h	United Video Corp
 11B7h	Motorola
 11B8h	Xpoint Technologies Inc
 11B9h	Pathlight Technology Inc. (see #00853)
 11BAh	Videotron Corp
 11BBh	Pyramid Technology
 11BCh	Network Peripherals Inc
 11BDh	Pinnacle Systems Inc.
 11BEh	International Microcircuits Inc
 11BFh	Astrodesign, Inc.
 11C3h	NEC Corporation
 11C4h	Document Technologies Ind.
 11C5h	Shiva Corporatin
 11C6h	Dainippon Screen Mfg. Co., Ltd.
 11C7h	D.C.M. Data Systems
 11C8h	Dolphin Interconnect Solutions (see #00854)
 11C9h	MAGMA
 11CAh	LSI Systems Inc
 11CBh	Specialix International, Ltd. (see #00855)
 11CCh	Michels & Kleberhoff Computer GmbH
 11CDh	HAL Computer Systems Inc.
 11CEh	Netaccess
 11D0h	Lockheed Martin Federal	Systems-Manassas
 11D2h	Intercom, Inc.
 11D4h	Analog Devices
 11D5h	Ikon Corp.
 11D9h	TEC Corp.
 11DAh	Novell
 11DBh	Sega Enterprises, Ltd.
 11DEh	Zoran Corporation
 11DFh	New Wave PDG
 11E0h	???
 11E1h	GEC Plessey Semi Inc.
 11E2h	Samsung Information Systems Americ
 11E3h	Quicklogic Corporation
 11E4h	Second Wave Inc.
 11E5h	IIX Consulting
 11E6h	Mitsui-Zosen System Research
 11E7h	???
 11E8h	Digital Processing Systems Inc.
 11E9h	???
 11EAh	Elsag Bailey
 11EBh	Formation Inc.
 11ECh	Coreco Inc.
 11EDh	Mediamatics
 11EEh	Dome Imaging Systems Inc.
 11EFh	Nicolet Technologies B.V.
 11F0h	Compu-Shack GmbH
 11F1h	Symbios Logic Inc.
 11F2h	Picture Tel Japan K.K.
 11F3h	Keithley Metrabyte
 11F4h	Kinetic Systems Corporation
 11F5h	Computing Devices International
 11F6h	Powermatic Data Systems Ltd.
 11F6h	Compex USA, Inc. (see #00856)
 11F7h	Scientific Atlanta
 11F8h	PMC-Sierra Inc. (see #00857)
 11F9h	I-Cube, Inc.
 11FEh	RP ??? (see #00858)
 1201h	Vista Controls Corp.
 1203h	Bayer Corp., AGFA division
 1204h	Lattice	Semiconductor Corp.
 1205h	Array Corp.
 1206h	Amdahl Corp.
 120Eh	Cyclades (see #00859)
 1216h	PURUP Eskofot A/S
 1217h	O2Micro, Inc.
 121Ah	3DFX Interactive, Inc.
 121Bh	Advanced Telecomm Modules
 1220h	Ariel Corporation (see #00860)
 1221h	Contec Co., Ltd.
 1222h	Ancor Communications, Inc.
 1223h	Heurikon/Computer Products
 1224h	Interactive Images
 1225h	Power I/O, Inc.
 1226h	???
 1227h	Tech-Source
 1228h	Norsk Elektro Optikk A/S
 1229h	Data Kinesis Inc.
 122Ah	Integrated Telecom
 122Bh	LG Industrial Systems Co. Ltd.
 122Ch	Sican GmbH
 122Dh	Aztech Systems Ltd
 122Eh	Xyratex
 122Fh	Andrew Corporation
 1230h	Fishcamp Engineering
 1231h	Woodward McCoach, Inc.
 1232h	GPT Limited
 1233h	Bus-Tech, Inc.
 1234h	Technical Corp.
 1235h	Risq Modular Systems, Inc. / Smart Modular Technologies, Inc.
 1236h	Sigma Designs Corporation
 1237h	Alta Technology Corporation
 1238h	Adtran
 1239h	The 3DO Company
 123Ah	Visicom Laboratories, Inc.
 123Bh	Seeq Technology, Inc.
 123Ch	Century Systems, Inc.
 123Dh	Engineering Design Team, Inc.
 123Eh	Sumutech, Inc.
 123Fh	C-Cube Microsystems
 1240h	Marathon Technologies Corp.
 1241h	DSC Communications
 1242h	(unknown vendor)
 1243h	Delphax
 1244h	AVM Audiovisuelles Mktg & Computer GmbH
 1245h	A.P.D., S.A.
 1246h	Dipix Technologies, Inc.
 1247h	Xylon Research, Inc.
 1248h	Central Data Corporation
 1249h	Samsung Electronics Co., Ltd.
 124Ah	AEG Electrocom GmbH
 124Bh	SBS/Greenspring Modular I/O
 124Ch	Solitron Technologies, Inc.
 124Dh	Stallion Technologies
 124Eh	Cylink
 124Fh	Infortrend Technology, Inc.
 1250h	Hitachi Microcomputer System, Ltd.
 1251h	VLSI Solution Oy
 1252h	???
 1253h	Guzik Technical Enterprises
 1254h	Linear Systems Ltd.
 1255h	Optibase Ltd.
 1256h	Perceptive Solutions, Inc.
 1257h	Vertex Networks, Inc.
 1258h	Gilbarco, Inc.
 1259h	Allied telesyn International
 125Ah	ABB Power Systems
 125Bh	Asix Electronics Corporation
 125Ch	Aurora Technologies, Inc.
 125Dh	ESS Technology
 125Eh	SpecialVideo Engineering SRL
 125Fh	Concurrent Technologies, Inc.
 1260h	Harris Semiconductor (see #00861)
 1261h	Matsushita-Kotobuki Electronics Industries
 1262h	ES Computer Company, Ltd.
 1263h	Sonic Solutions
 1264h	Aval Nagasaki Corporation
 1265h	Casio Computer Co., Ltd.
 1266h	Microdyne Corporation
 1267h	S.A. Telecommunications
 1268h	Tektronix
 1269h	Thomson-CSF/TTM
 126Ah	Lexmark International, Inc.
 126Bh	Adax, Inc.
 126Ch	Northern Telecom
 126Dh	Splash Technology, Inc.
 126Eh	Sumitomo Metal Industries, Ltd.
 126Fh	Silicon Motion, Inc.
 1270h	Olympus Optical Co., Ltd.
 1271h	GW Instruments
 1272h	Telematics International
 1273h	Hughes Network Systems
 1274h	Ensoniq (see #00862)
 1275h	Network Appliance Corporation
 1276h	Switched Network Tecnologies, Inc.
 1277h	Comstream
 1278h	Transtech Parallel Systems Ltd.
 1279h	Transmeta Corporation
 127Ah	Rockwell Semiconductor Systems
 127Bh	Pixera Corporation
 127Ch	Crosspoint Solutions, Inc.
 127Dh	Vela Research
 127Eh	Winnov, L.P.
 127Fh	Fujifilm
 1280h	Photoscript Group Ltd.
 1281h	Yokogawa Electric Corporation
 1282h	Davicom Semiconductor, Inc.
 1283h	Integrated Technology Express, Inc.
 1284h	Sahara Networks, Inc.
 1285h	Platform Technologies, Inc.
 1286h	Mazet GmbH
 1287h	M-Pact, Inc. / Luxsonor, Inc.
 1288h	Timestep Corporation
 1289h	AVC Technology, Inc.
 128Ah	Asante Technologies, Inc.
 128Bh	Transwitch Corporation
 128Ch	Retix Corporation / Sonoma Systems, Inc.
 128Dh	G2 Networks, Inc.
 128Ch	Retix Corp
 128Dh	???
 128Eh	Samho Multi Tech Ltd. / Hoon Tech Co., Ltd.
 128Fh	Tateno Dennou, Inc.
 1290h	Sord Computer Corporation
 1291h	NCS Computer Italia
 1292h	Tritech Microelectronics, Inc.
 1293h	Media Reality Technology
 1294h	Rhetorex, Inc.
 1295h	Imagenation Corporation
 1296h	Kofax Image Products
 1297h	Holco Ent Co, Ltd / Shuttle Computer
 1298h	Spellcaster Telecommunications Inc.
 1299h	Knowledge Technology Lab.
 129Ah	VMetro, Inc.
 129Bh	Image Access
 129Ch	Jaycor / Xantel Corporation
 129Dh	Compcore Multimedia, Inc.
 129Eh	Victor Company of Japan, Ltd.
 129Fh	OEC Medical Systems, Inc.
 12A0h	Allen-Bradley Company
 12A1h	Simpact Associates, Inc.
 12A2h	Newgen Systems Corporation
 12A3h	Lucent Technologies
 12A4h	NTT Electronics Technology Company
 12A5h	Vision Dynamics Ltd.
 12A6h	Scalable Networks, Inc.
 12A7h	AMO GmbH
 12A8h	News Datacom
 12A9h	Xiotech Corporation
 12AAh	SDL Communications, Inc.
 12ABh	Yuan Yuan Enterprise Co., Ltd.
 12ACh	MeasureX Corporation
 12ADh	Multidata GmbH
 12AEh	Alteon Networks, inc.
 12AFh	TDK USA Corporation
 12B0h	Jorge Scientific Corporation
 12B1h	GammaLink
 12B2h	General Signal Networks
 12B3h	Inter-Face Co. Ltd.
 12B4h	FutureTel Inc.
 12B5h	Granite Systems Inc.
 12B6h	Natural Microsystems
 12B7h	Acumen
 12B8h	Korg
 12B9h	US Robotics / 3com Corporation
 12BAh	PMC Sierra
 12BBh	Nippon Unisoft Corporation
 12BCh	Array Microsystems
 12BDh	Computerm Corp.
 12BEh	Anchor Chips
 12BFh	Fujifilm Microdevices
 12C0h	InfiMed
 12C1h	GMM Research Corp.
 12C2h	Mentec Limited
 12C3h	Holtek Microelectronics Inc.
 12C4h	Connect Tech Inc.
 12C5h	Picture Elements, Inc. (see #00863)
 12C6h	Mitani Corporation
 12C7h	Dialogic Corporation
 12C8h	G Force Co, Ltd.
 12C9h	Gigi Operations
 12CAh	Integrated Computing Engines
 12CBh	Antex Electronics Corporation
 12CCh	Pluto Technologies International
 12CDh	Aims Lab
 12CEh	Netspeed, Inc.
 12CFh	Prophet Systems, Inc.
 12D0h	GDE Systems, Inc.
 12D1h	Psitech
 12D2h	NVIDIA / SGS Thomson
 12D3h	Vingmed Sound A/S
 12D4h	DGM&S
 12D5h	Equator Technologies
 12D6h	Analogic Corporation
 12D7h	Biotronic SRL
 12D8h	Pericom Semiconductor
 12D9h	Aculab PLC
 12DAh	True Time
 12DBh	Annapolis Micro Systems, Inc.
 12DCh	Symicron Computer Communication Ltd.
 12DDh	Management Graphics
 12DEh	Rainbow Technologies
 12DFh	SBS Technologies Inc.
 12E0h	Chase Research
 12E1h	Nintendo Co, Ltd.
 12E2h	Datum Inc, Bancomm-Timing Division
 12E3h	Imation Corp - Medical Imaging Systems
 12E4h	Brooktrout Technology Inc.
 12E5h	Apex Inc / XCD Inc.
 12E6h	Cirel Systems
 12E7h	Sunsgroup Corporation / Sebring Systems
 12E8h	CRISC Corporation
 12E9h	GE Spacenet
 12EAh	Zuken / Real Vision, Inc.
 12EBh	Aureal Semiconductor
 12ECh	3A International, Inc.
 12EDh	Optivision Inc.
 12EEh	Orange Micro
 12EFh	Vienna Systems
 12F0h	Pentek
 12F1h	Sorenson Vision Inc.
 12F2h	GammaGraphx, Inc.
 12F3h	XING, Inc.
 12F4h	Megatel
 12F5h	Forks
 12F6h	Dawson France
 12F7h	Cognex
 12F8h	Electronic-Design GmbH
 12F9h	FourFold Technologies
 12FBh	Spectrum Signal Processing
 12FCh	Capital Equipment Corp.
 12FDh	i2S
 12FEh	ESD Electronic System Design GmbH
 12FFh	Lexicon
 1300h	Harman International Industries, Inc.
 1302h	Computer Sciences Corp.
 1303h	Innovative Integration
 1304h	Juniper Networks
 1305h	NetPhone, Inc.
 1306h	Duet Technologies
 1307h	Computer Boards
 1308h	Jato Technologies, Inc.
 1309h	AB Semicon, Ltd.
 130Ah	Mitsubishi Electric MicroComputer
 130Bh	Colorgraphic Communications Corp.
 130Ch	AMBEX Technologies, Inc.
 130Dh	Accelerix, Inc.
 130Eh	Yamatake-Honeywell Co., Ltd.
 130Fh	Advanet, Inc.
 1310h	GESPAC
 1311h	VideoServer, Inc.
 1312h	Acuity Imaging, Inc.
 1313h	Yaskawa Electric Co.
 1316h	Teradyne, Inc.
 1317h	Bridgecom, Inc.
 1318h	Packet Engines, Inc.
 1319h	ForteMedia, Inc.
 131Ah	Finisar Corp.
 131Ch	Nippon Electro-Sensory Devices Corp.
 131Dh	Sysmic, Inc.
 131Eh	Xinex Networks, Inc.
 131Fh	SIIG, Inc.
 1320h	Crypto AG
 1321h	Arcobel Graphics BV
 1322h	MTT Co., Ltd.
 1323h	DOME, Inc.
 1324h	Sphere Communications
 1325h	Salix Technologies, Inc.
 1326h	SeaChange International
 1327h	Voss Scientific
 1328h	Quadrant International
 1329h	Productivity Enhancement
 132Ah	Microcom, Inc.
 132Bh	BroadBand Technologies
 132Ch	Micrel, Inc.
 132Dh	Integrated Silicon Solution, Inc.
 1330h	MMC Networks
 1331h	RadiSys Corporation
 1332h	Micro Memory
 1333h	???
 1334h	Redcreek Communications, Inc.
 1335h	Videomail, Inc.
 1336h	???
 1337h	Third Planet Publishing
 1338h	BT Electronics
 133Ah	VTEL Corp.
 133Bh	Softcom Microsystems
 133Ch	Holontech Corp.
 133Dh	S S Technologies
 133Eh	Virtual Computer Corp.
 133Fh	SCM Microsystems
 1340h	Atalla Corp.
 1341h	Kyoto Microcomputer Co.
 1342h	Promax Systems Inc.
 1343h	Phylon Communications, Inc.
 1344h	Crucial Technology
 1345h	Arescom, Inc.
 1346h	???
 1347h	Odetics
 1348h	???
 1349h	Sumitomo Electric Industries, Ltd.
 134Ah	DTC Technology Corp.
 134Bh	Ark Research Corp.
 134Ch	Chori Joho System Co., Ltd.
 134Dh	Pctel, Inc.
 134Eh	CSTI
 134Fh	Algo System Co., Ltd.
 1350h	Systec Co., Ltd.
 1351h	Sonix, Inc.
 1353h	Dassault A.T.
 1354h	dWave System, Inc.
 1355h	Kratos Analytical, Ltd.
 1356h	The Logical Co.
 1359h	Prisa Networks
 135Ah	Brain Boxes
 135Bh	Giganet, Inc.
 135Ch	Quatech, Inc.
 135Dh	ABB Network Partner AB
 135Eh	Sealevel Systems, Inc.
 135Fh	I-Data International A-S
 1360h	Meinberg Funkuhren
 1361h	Soliton Systems K.K.
 1362h	Fujifacom Corp.
 1363h	Phoenix Technology, Ltd.
 1364h	ATM Communications, Inc.
 1365h	Hypercope Corp.
 1366h	Teijin Seiki Co., Ltd.
 1367h	Hitachi Zosen Corp.
 1368h	Skyware Corp.
 1369h	Digigram
 136Ah	High Soft Tech
 136Bh	Kawasaki Steel Corp.
 136Ch	Adtek System Science Co., Ltd.
 136Dh	Gigalabs, Ltd.
 136Fh	Applied Magic, Inc.
 1370h	ATL Products
 1371h	CNET Technology, Inc.
 1373h	Silicon Vision, Inc.
 1374h	Silicom, Ltd.
 1375h	Argosystems, Inc.
 1376h	LMC
 1377h	Electronic Equipment Production
 1378h	Telemann Co., Ltd.
 1379h	Asahi Kasei Microsystems Co., Ltd.
 137Ah	Mark Of The Unicorn, Inc.
 137Bh	PPT Vision
 137Ch	Iwatsu Electric Co., Ltd.
 137Dh	Dynachip Corp.
 137Eh	Patriot Scientific Corp.
 137Fh	Japan Satellite Systems, Inc.
 1380h	Sanritz Automation Co., Ltd.
 1381h	Brains Co., Ltd.
 1382h	Marian - Electronic & Software
 1383h	Controlnet, Inc.
 1384h	Reality Simulation Systems, Inc.
 1385h	Netgear
 1386h	Video Domain Technologies
 1387h	Systran Corp.
 1388h	Hitachi Information Technology Co., Ltd.
 1389h	Applicom International
 138Ah	Fusion Micromedia Corp.
 138Bh	Tokimec, Inc.
 138Ch	Silicon Reality
 138Dh	Future Techno Designs Pte., Ltd.
 138Eh	Basler GmbH
 138Fh	Patapsco Designs, Inc.
 1390h	Concept Development, Inc.
 1391h	Development Concepts, Inc.
 1392h	Medialight, Inc.
 1394h	Level One Communications
 1395h	Ambicom, Inc.
 1396h	Cipher Systems, Inc.
 1397h	Cologne Chip Designs GmbH
 1398h	Clarion Co., Ltd.
 1399h	Rios Systems Co., Ltd.
 139Ah	Alacritech, Inc.
 139Bh	Mediasonic Multimedia Systems, Ltd.
 139Ch	Quantum 3D, Inc.
 139Dh	EPL, Ltd.
 139Eh	Media4
 139Fh	Aethra S.R.L.
 13A0h	Crystal Group, Inc.
 13A1h	Kawasaki Heavy Industries, Ltd.
 13A2h	Ositech Communications, Inc.
 13A3h	HI-FN
 13A4h	Rascom, Inc.
 13A5h	Audio Digital Imaging, Inc.
 13A6h	Videonics, Inc.
 13A7h	Teles AG
 13A8h	Exar Corp.
 13A9h	Ultrasound Group
 13AAh	Broadband Networks, Inc.
 13ABh	Arcom Control Systems, Ltd.
 13ACh	Motion Media Technology, Ltd.
 13ADh	Nexus, Inc.
 13AEh	ALD Technology, Ltd.
 13AFh	T.Sqware
 13B0h	Maxspeed Corp.
 13B1h	Tamura Corp.
 13B2h	Techno Chips Co., Ltd.
 13B3h	Lanart Corp.
 13B4h	Wellbean Co, Inc.
 13B5h	ARM
 13B6h	DLoG GmbH
 13B7h	LOGIC Devices, Inc.
 13B8h	Nokia Telecommunications Oy
 13B9h	Elecom Co., Ltd.
 13BAh	Oxford Instruments
 13BBh	Sanyo Technosound Co., Ltd.
 13BCh	Bitran Corp.
 13BDh	Sharp Corp.
 13BEh	Miroku Jyoho Service Co., Ltd.
 13BFh	Sharewave., Inc.
 13C0h	Microgate Corp.
 13C1h	3ware Inc.
 13C2h	Technotrend Systemtechnik GmbH
 13C3h	Janz Computer AG
 13C4h	Phase Metrics
 13C5h	Alphi Technology Corp.
 13C6h	Condor Engineering, Inc.
 13C7h	Blue Chip Technology, Ltd.
 13C8h	Apptech, Inc.
 13C9h	Eaton Corp.
 13CAh	IOMEGA Corp.
 13CBh	Yano Electric Co., Ltd.
 13CCh	Metheus Corp.
 13CDh	Compatible Systems Corp.
 13CEh	Cocom A/S
 13CFh	Studio Audio & Video, Ltd.
 13D0h	Techsan Electronics Co., Ltd.
 13D1h	Abocom Systems, Inc.
 13D2h	Shark Multimedia, Inc.
 13D3h	IMC Networks
 13D4h	Graphics Microsystems, Inc.
 13D5h	Media 100, Inc.
 13D6h	K.I. Technology Co., Inc.
 13D7h	Toshiba Engineering Corp.
 13D8h	Phobos Corp.
 13D9h	Apex PC Solutions, Inc.
 13DAh	Intresource Systems Pte., Ltd.
 13DBh	Janich & Klass Computertechnik GmbH
 13DCh	Netboost Corp.
 13DDh	Multimedia Bundle, Inc.
 13DEh	ABB Robotics Products AB
 13DFh	E-Tech, Inc.
 13E0h	GVC Corp.
 13E1h	Silicom Multimedia Systems, Inc.
 13E2h	Dynamics Research Corp.
 13E3h	Nest, Inc.
 13E4h	Calculex, Inc.
 13E5h	Telesoft Design, Ltd.
 13E6h	Argosy Research, Inc.
 13E7h	NAC, Inc.
 13E8h	Chip Express Corp.
 13E9h	Intraserver Technology, Inc.
 13EAh	Dallas Semiconductor
 13EBh	Hauppauge Computer Works, Inc.
 13ECh	Zydacron, Inc.
 13EDh	Raytheion E-Systems
 13EEh	Hayes Microcomputer Products, Inc.
 13F0h	Sundance Technology, Inc.
 13F1h	Oce' - Technologies B.V.
 13F2h	Ford Microelectronics, Inc.
 13F3h	McData Corp.
 13F4h	Troika Design, Inc.
 13F5h	Kansai Electric Co., Ltd.
 13F6h	C-Media Electronics, Inc.
 13F7h	Wildfire Communications
 13F8h	Ad Lib Multimedia, Inc.
 13F9h	NTT Advanced Technology Corp.
 13FAh	Pentland Systems, Ltd.
 13FBh	Aydin Corp.
 13FCh	Computer Peripherals International
 13FDh	Micro Science, Inc.
 13FEh	Advantech Co., Ltd.
 13FFh	Silicon Spice, Inc.
 1400h	ARTX, Inc.
 1401h	CR-Systems A/S
 1402h	Meilhaus Electronic GmbH
 1403h	Ascor, Inc.
 1404h	Fundamental Software, Inc.
 1405h	Excalibur Systems, Inc.
 1406h	Oce' Printing Systems GmbH
 1407h	Lava Computer Mfg., Inc.
 1408h	Aloka Co., Ltd.
 1409h	Timedia Technology Co., Ltd.
 140Ah	DSP Research, Inc.
 140Bh	Ramix, Inc.
 140Ch	Elmic Systems, Inc.
 140Dh	Matsushita Electrics Works, Ltd.
 140Eh	Goepel Electronic GmbH
 140Fh	Salient Systems Corp.
 1410h	Midas Lab, Inc.
 1411h	Ikos Systems, Inc.
 1412h	IC Ensemble, Inc.
 1413h	Addonics
 1414h	Microsoft
 1415h	Oxford Semiconductor, Ltd.
 1416h	Multiwave Innovation Pte, Ltd.
 1417h	Convergenet Technologies, Inc.
 1418h	Kyushu Electronics Systems, Inc.
 1419h	Excel Switching Corp.
 141Ah	Apache Micro Peripherals, Inc.
 141Bh	Zoom Telephonics, Inc.
 141Dh	Digitan Systems, Inc.
 141Eh	Fanuc, Ltd.
 141Fh	Visiontech, Ltd.
 1420h	Psion Dacom PLC
 1421h	ADS Technologies, Inc.
 1422h	Ygrec Systems Co., Ltd.
 1423h	Custom Technology Corp.
 1424h	Vidoeserver Connections
 1425h	ASIC Designers, Inc.
 1426h	Storage Technology Corp.
 1427h	Better On-line Solutions
 1428h	EDEC Co., Ltd.
 1429h	UNEX Technology Corp.
 142Ah	Kingmax Technology, Inc.
 142Bh	RadioLAN
 142Ch	Minton Optic Industry Co., Ltd.
 142Dh	Pix Stream, Inc.
 142Eh	Vitec Multimedia
 142Fh	Radicom Research, Inc.
 1430h	ITT Aerospace/Communications Division
 1431h	Gilat Satellite Networks
 1432h	Edimax Computer Co.
 1433h	Eltec Elektronik GmbH
 1435h	Real Time Devices US, Inc.
 1436h	CIS Technology, Inc.
 1437h	Nissin Co Inc
 1438h	Atmel-Dream
 1439h	Outsource Engineering & Mfg. Inc
 143Ah	Stargate Solutions Inc
 143Bh	Canon Research Center, America
 143Ch	Amlogic Inc
 143Dh	Tamarack Microelectronics Inc
 143Fh	Lightwell Co Ltd - Zax Division
 1440h	Algol Corp
 1441h	AGIE LTD
 1442h	Phoenix Contact Co GmbH
 1443h	Unibrain S.A.
 1444h	TRW
 1445h	Logical do Ltd
 1447h	AIM GmbH
 1448h	Alesis Studio
 1449h	TUT Systems Inc
 144Ah	Adlink Technology
 144Bh	Loronix Information Systems Inc
 144Ch	Catalina Research Inc
 144Eh	Olitec
 144Fh	Askey Computer Corp
 1450h	Nexus Systems Inc
 1451h	SP3D Chip Design GmbH
 1453h	Mycom Inc
 1454h	Altiga Networks
 1455h	Logic Plus Plus Inc
 1456h	Advanced Hardware
 1457h	Nuera Communications Inc
 1458h	Giga-Byte Technology
 1459h	Dooin Electronics
 145Ah	Escalate Networks Inc
 145Bh	Praim SRL
 145Ch	Cryptek
 145Dh	Gallant Computer Inc
 145Eh	Aashima Technology B.V.
 145Fh	Baldor Electric Company
 1460h	Dynarc Inc
 1461h	Avermedia Technologies Inc
 1462h	Micro-Star International Co Ltd
 1463h	Fast Corp
 1464h	Interactive Circuits & Systems Ltd
 1465h	GN Nettest Telecom Div.
 1466h	Designpro Inc
 1467h	Digicom SPA
 1468h	Ambit microsystem Corp
 1469h	Cleveland Motion Controls
 146Ah	IFR Ltd
 146Bh	Parascan Technologies Ltd
 146Ch	Ruby Tech Corp
 146Dh	Tachyon Inc
 146Eh	Williams Electronic Games Inc
 146Fh	Multi Dimensional Consulting Inc
 1470h	Bay Networks
 1471h	Integrated Telecom Express Inc
 1472h	Daikin Indistries Ltd
 1473h	Zapex Technologies Inc
 1474h	Doug Carson & Associates
 1475h	Picazo Communications
 1476h	Mortara Instrument Inc
 1477h	Net Insight
 1478h	Diatrend Corp
 1479h	Toray Industries Inc
 147Ah	Formosa Industrial Computing
 147Bh	Abit Computer Corp
 147Ch	Aware Inc
 147Dh	Interworks Computer Products
 147Eh	Matsushita Graphic Communication Systems Inc
 147Fh	Nihon Unisys Ltd
 1480h	SCII Telecom
 1481h	Biopac Systems Inc
 1482h	ISYTEC
 1483h	Labway Corp
 1668h	Action Tec Electronics, Inc.
 1A08h	Sierra Semiconductor
 1B13h	Jaton Corp.
 1C1Ch	Symphony (see #00864)
 1D44h	DPT
 1DE1h	TekRAM (see #00865)
 21C3h	21st Century Computer Corp.
 2348h	Racore 
 270Bh	Xantel Corp.
 270Fh	Chaintech Computer Co., Ltd.
 3000h	Hansol Electronics Inc.
 3142h	Post Impression Systems
 3388h	Hint Corp.
 3D3Dh	3DLabs (see #00866)
 4005h	Avance Logic, Inc. (see #00867)
 4444h	Internext Compression, Inc.
 4468h	BRIDGEPORT MACHINES
 4594h	Cogetec Informatique Inc.
 4680h	UMAX Computer Corp.
 4843h	Hercules Computer Technology, Inc.
 4942h	???
 4943h	Growth Networks
 4978h	Axil Computer, Inc.
 4A14h	NetVin
 4B10h	Buslogic Inc. (see #00869)
 4C48h	Lung Hwa Electronics
 4D51h	Mediaq Inc
 4DDCh	ILC data Device Corp.
 5053h	Voyetra Technologies
 5143h	Qualcomm, Inc.
 5333h	S3 (see also #00870)
 5455h	Technische Universit„t Berlin
 5519h	Cnet Technologies, Inc.
 5555h	Genroco Inc
 5700h	Netpower
 6356h	UltraStor
 6374h	c't Magazin fuer Computertechnik (see #00871)
 6409h	Logitec Corp
 6666h	Decision Computer International Co.
 7604h	O.N. Electric Co Ltd
 8008h	Quancom Electronic GmbH (see #00872)
 8086h	Intel (see also #00873)
 8800h	Trigem Computer (see #00874)
 8866h	T-Square Design Inc
 8888h	Silicon Magic
 8E0Eh	Computone Corporation
 8E2Eh	KTI
 9004h	Adaptec (see #00875)
 9005h	Adaptec
 907Fh	Atronics (see #00876)
 9412h	Holtek
 A200h	NEC Corp. (see #00754)
 A259h	Hewlett Packard (see #00757)
 A25Bh	Hewlett Packard GmbH PL24-MKT (see #00757)
 A304h	Sony
 A727h	3com Corp. (see #00796)
 AA42h	Scitex Digital Video
 B1B3h	Shiva Europe, Ltd.
 C001h	TSI Telsys
 C0A9h	Micron/Crucial Technology
 C0DEh	Motorola (see #00768)
 C0FEh	Motion Engineering, Inc.
 CAFEh	Chrysalis-ITS
 D4D4h	DY4 Systems Inc.
 E159h	Tiger Jet Network Inc.
 E000h	Winbond
 E159h	Tiger Jet Network Inc.
 ECC0h	Echo Corp.
 EDD8h	Ark Logic Inc (see #00877)
 FEDAh	Epigram Inc
Note:	this list, as well as the following per-vendor tables, tends to be
	  rather out-of-date.  The current version of the listing can be found
	  in PCICFG.DAT, part of the PCICFG program distributed in RBPCIxxx.ZIP
	  (available at http://www.pobox.com/~ralf/files.html).
SeeAlso: #00878

(Table 00733)
Values for Compaq PCI device code:
 0001h	EISA Bridge
 0002h	ISA Bridge
 1000h	Triflex/PCI CPU Bridge
 2000h	Triflex/PCI CPU Bridge
 3032h	QVision
 3033h	QVision 1280/p
 3034h	QVision 1280
 4000h	Triflex/PCI CPU Bridge
 AE32h	Netelligent 10/100 TX
 AE34h	Netelligent 10 T
 AE35h	Integrated NetFlex 3/P
 AE40h	Dual-port Netelligent 10/100 TX
 AE43h	ProLiant Integrated Netelligent 10/100
 B011h	Dual-port Netelligent 10/100 TX
 F130h	ThunderLAN
 F150h	NetFlex 3/P with BNC
SeeAlso: #00732

(Table 00734)
Values for Symbios Logic (formerly NCR) PCI device code:
 0001h	PCI revision ID:
	00-0Fh 53C810 (fast SCSI)
	10-1Fh 53C810A (fast SCSI)
	20-2Fh 53C810ALV (fast SCSI)
 0002h	53C820 (fast wide SCSI)
 0003h	PCI revision ID:
	00-0Fh 53C825 (fast wide SCSI)
	10-1Fh 53C825A (Ultra wide SCSI)
 0004h	53C815 (fast SCSI)
 0005h	53C810AP (fast SCSI)
 0006h	PCI revision ID:
	00-0Fh 53C860 (Ultra SCSI)
	10-1Fh 53C860LV (Ultra SCSI)
 000Fh	53C875 (Ultra wide SCSI)
 1000h	63c815 Fast-SCSI
SeeAlso: #00732

(Table 00735)
Values for ATI PCI device code:
 4158h	68800AX (Mach32)
 4354h	215CT222
 4358h	210888CX
 4758h	210888GX (Mach64)
 5654h	215VT222 Video Expression
SeeAlso: #00732

(Table 00736)
Values for ULSI Systems PCI device code:
 0201h	 US201 Graphics Controller
SeeAlso: #00732

(Table 00737)
Values for VLSI Technologies PCI device code:
 0005h	82C592 CPU Bridge
 0006h	82C593 ISA Bridge
 0007h	82C594 Wildcat System Ctrlr
 0008h	VL82C597 Wildcat ISA Bridge
 0009h	82C597
 000Ch	82C541
 000Dh	82C543
 0101h	82C532
 0102h	82C534
 0104h	82C535
 0105h	82C147
 0200h	82C975 RISC GUI Accelerator
 0280h	82C925 RISC GUI Accelerator
SeeAlso: #00732

(Table 00738)
Values for Avance Logic, Inc. (Avance Logics) PCI device code:
 2301h	ALG2301 GUI accelerator
 2302h	ALG2302 GUI accelerator
SeeAlso: #00732,INT 10/AX=4F70h

(Table 00739)
Values for National Semiconductor PCI device code:
 0001h	DP83810 Ethernet
 0002h	PC87415 IDE DMA-Master Mode controller (see #00922)
 D001h	NS87410 EIDE controller (see #00921)
SeeAlso: #00732,#00773

(Table 00740)
Values for Tseng Labs PCI device code:
 3202h	ET4000/W32p-2
 3205h	ET4000/W32p-B
 3206h	ET4000/W32p-C
 3207h	ET4000/W32p-D
 3208h	ET6000
SeeAlso: #00732

(Table 00741)
Values for Weitek PCI device code:
 9000h	Power9000???
 9001h	Power9001
 9100h	Power9100
SeeAlso: #00732

(Table 00742)
Values for DEC PCI device code:
 0001h	DC21050	DEC BRD PCI-PCI bridge
 0002h	DC21040	Tulip
 0004h	DecChip 21030
 0009h	DC21140	Tulip Fast (see #00923)
 000Ah	21230	Video Codec
 000Fh	DEFPA	FDDI
 0014h	DC21041	Tulip Plus (see #00923)
 0016h	DGLPB	ATM
 0019h	DC21143 PCI/Cardbus Ethernet
 0021h	21052	PCI-PCI Bridge (see #00924)
 0022h	21150	PCI-PCI Bridge
 0024h	21152	PCI-PCI Bridge
 0025h	21153	PCI-PCI Bridge
 0026h	21154	PCI-PCI Bridge
 0045h	21553	PCI-PCI Bridge
 0046h	21554	PCI-PCI Bridge
 1050h??? 21340 Managed Port Switch
SeeAlso: #00732

(Table 00743)
Values for Cirrus Logic PCI device code:
 0038h	CL-GD7548 Video Controller
 004Ch	CL-GD7556 64-bit Video/Graphics LCD/CRT Ctrlr
 00A0h	Cirrus 5430
 00A4h	Cirrus 5434-4
 00A8h	Cirrus 5434-8
 00ACh	Cirrus 5436
 00B8h	Cirrus GD5446
 00BCh	CL-GD5480 64-bit SGRAM GUI accelerator
 1100h	Cirrus 6729 PCMCIA Controller
 1110h	Cirrus 6832 PCMCIA/CardBus Ctrlr
 1200h	Cirrus 7542
 1202h	Cirrus 7543
 1204h	Cirrus 7541
 6001h	CS4610/4611 CrystalClear SoundFusion Audio Accelerator
SeeAlso: #00732

(Table 00744)
Values for IBM PCI device code:
 0002h	MCA Bridge
 0005h	Alta Lite CPU Bridge
 0007h	Alta MP CPU Bridge
 000Ah	ISA Bridge
 0017h	CPU Bridge
 0018h	Auto LANStreamer
 001Bh	GXT-150P Graphics Adapter
 001Dh	82G2675
 0020h	MCA Bridge
 0022h	PCI-PCI Bridge
 002Eh	??? RAID SCSI
 0036h	Miami/PCI  32-bit LocalBus Bridge
 0047h	???
 0048h	???
 004Ah	???
 004Bh	???
 004Ch	???
 004Dh	???
 004Eh	???
 004Fh	???
 0050h	???
 0051h	???
 0052h	???
 0053h	??? 25 MBit ATM controller
 0055h	???
 0059h	???
 005Ah	???
 005Bh	???
SeeAlso: #00732

(Table 00745)
Values for Western Digital PCI device code:
 0193h	WD33C193A 8-bit SCSI
 0196h	SCSI Bridge
 0197h	WD33C197A 16-bit SCSI
 0296h	WD33C296A 16-bit SCSI
 3193h	WD7193 Fast SCSI-II
 3197h	WD7197 Fast-Wide SCSI-II
 3296h	WD7197
 4296h	WD33C296 Wide Fast-20 Bridge
 C24Ah	90C?
SeeAlso: #00732

(Table 00746)
Values for AMI PCI device code:
 9010h	MegaRAID
 9030h	??? IDE Controller
 9031h	??? IDE Controller
 9032h	??? IDE/SCSI Controller
 9033h	??? SCSI Controller
 9040h	??? Multimedia card
SeeAlso: #00732

(Table 00747)
Values for Advanced Micro Devices (AMD) PCI device code:
 2000h	Am79C970 (Lance)
	Am79C970A (PCnet-PCI II, PCI revision ID is 1xh)
	Am79C971 (PCnet-FAST, PCI revision ID is 2xh)
 2020h	Am53c974 SCSI (see #00925)
 2040h	Am79C974 Ethernet/SCSI
SeeAlso: #00732

(Table 00748)
Values for Trident PCI device code:
 9320h	??? 32-bit GUI accelerator
 9350h	??? 32-bit GUI accelerator
 9360h	??? Flat-Panel controller
 9420h	Trident 9420
 9440h	Trident 9440
 9460h	Trident 9460
 9660h	Trident 9660
 9682h	??? Multimedia accelerator
SeeAlso: #00732

(Table 00749)
Values for LSI Logic PCI device code:
 0000h	Hydra (Pentium chipset)
 0010h	Aspen (486 chipset)
SeeAlso: #00732

(Table 00750)
Values for Matrox PCI device code:
 0518h	MGA-II (Ultima)
 0519h	Millenium (2064W)
 0D10h	MGA-I (Impression)
SeeAlso: #00732

(Table 00751)
Values for Chips & Technologies PCI device code:
 00B8h	64310 GUI Accelerator
 00D0h	65545 Flat Panel/CRT VGA
 00D8h	F65545
 00DCh	F65548
 00E0h	65550 Flat Panel/CRT GUI Accelerator
 00E4h	65554 display
 00E5h	65555 HiQVPro LCD/CRT GUI Controller
 00F4h	68554 HiQVision LCD/CRT GUI Controller
SeeAlso: #00732

(Table 00752)
Values for Toshiba America PCI device code:
 0009h	r4x00 Bridge
SeeAlso: #00732

(Table 00753)
Values for Miro Computer Products AG PCI device code:
 5601h	36050
 5607h	video in/out w/ MPEG
SeeAlso: #00732

(Table 00754)
Values for NEC Corporation PCI device code:
 0001h	PCI-to-486 Bridge
 0002h	PCI-to-VL98 Bridge
 0003h	ATM LAN controller
 0004h	r4000PCI Bridge
 0005h	PCI-to-486 Bridge
 0006h	GUI Accelerator
 0007h	PCI-to-UXbus Bridge
 0008h	GUI Accelerator
 0009h	PC-98 Graphics Controller
SeeAlso: #00732

(Table 00755)
Values for Future Domain PCI device code:
 0000h	TMC-36C70 / TMC-18C30 (fast SCSI)
SeeAlso: #00732

(Table 00756)
Values for Silicon Integrated System (SIS) PCI device code:
 0001h	SiS6201
 0002h	SiS6202
 0006h	SI 85C501/2
 0008h	SI 85C503/5513
 0205h	SiS6205
 0406h	SiS501
 0496h	SiS496
 0596h	Pentium chipset
 0601h	SiS601
 3602h	IDE controller
 5401h	486 chipset
 5511h	SiS5511 Pentium chipset
 5513h	SiS5513 EIDE controller
 5581h	Pentium chipset
 5582h	ISA Bridge
 5596h	Pentium chipset
 6204h	video decoder/MPEG
 6205h	PCI VGA controller
SeeAlso: #00732

(Table 00757)
Values for Hewlett-Packard PCI device code:
 1030h	J2585A DeskDirect 10/100 PCI NIC
 1040h	J2973A DeskDirect 10BaseT PCI NIC
 1041h	J2585B DeskDirect 10/100 PCI NIC
 1042h	J2970A DeskDirect 10BaseT/2 PCI NIC
 2910h	E2910A PCI-bus exerciser
 2925h	E2925A PCI-bus exerciser
SeeAlso: #00732

(Table 00758)
Values for PC Technology PCI device code:
 1000h	RZ1000
 1001h	RZ1001
SeeAlso: #00732

(Table 00759)
Values for Distributed Processing Technology (DPT) PCI device code:
 A400h	2124A/9X EATA SmartCache/RAID SCSI
SeeAlso: #00732

(Table 00760)
Values for OPTi PCI device code:
 A0F8h	82C750 (Vendetta) USB controller
 C557h	82C557
 C558h	82C558
 C567h	82C750 (Vendetta, device 0)
 C568h	82C750 (Vendetta, device 1)
 C621h	82C621 IDE controller / 82C750 Vendetta IDE controller
 C822h	82C822
 C824h	82C824 FireFox PC-Card controller
 C825h	82C825 FireBridge II
 C861h	82C861/82C871 FireLink/FireBlast PCI-to-USB Bridge (see #00965)
 D568h	82C750 Vendetta IDE controller
 D768h	82C750 Vendetta IDE controller (ultra DMA)
SeeAlso: #00732

(Table 00761)
Values for SGS Thomson Microelectronics PCI device code:
 0008h	SGS 2000
 0009h	SGS 1764
SeeAlso: #00732

(Table 00762)
Values for BusLogic PCI device code:
 0140h	MultiMaster NC
 1040h	MultiMaster
 8130h	FlashPoint
SeeAlso: #00732

(Table 00763)
Values for Texas Instruments PCI device code:
 0500h	100 Mbit LAN controller
 0508h	tms380c2x
 1000h	TI PCI Eagle i/f
 3D04h	TVP4010	 3D Graphics Processor	 !!!ti\slas155.pdf p.26
 A001h	TDC1570	 64-bit ATM sar
 A100h	TDC1561	 32-bit ATM sar
 AC10h	PCI1050	 PCCard controller
 AC11h	PCI1053	 PCCard controller
 AC12h	PCI1130	 PCCard controller
SeeAlso: #00732

(Table 00764)
Values for Oak Technology PCI device code:
 0107h	OTI-0107 (Spitfire)
SeeAlso: #00732

(Table 00765)
Values for Winbond PCI device code:
 0000h	??? Ethernet controller
 0001h	83769
 0105h	82C105
SeeAlso: #00732

(Table 00766)
Values for Hitachi Ltd. PCI device code:
 0001h	PCI Bridge
 0002h	PCI-bus controller
SeeAlso: #00732

(Table 00767)
Values for EFAR Microsystems PCI device code:
 0810h	486 Bridge
 0922h	Pentium/P54C Bridge
 0926h	ISA Bridge
SeeAlso: #00732

(Table 00768)
Values for Motorola PCI device code:
 0001h	MPC105 PowerPC chipset
SeeAlso: #00732

(Table 00769)
Values for Promise Technology PCI device code:
 5300h	Promise 5300
SeeAlso: #00732

(Table 00770)
Values for Number 9 Computer Company PCI device code:
 2309h	Imagine 128
 2339h	Imagine 128-2
SeeAlso: #00732

(Table 00771)
Values for United Microelectronics (UMC) PCI device code:
 0001h	UM82C881 (486 chipset)
 0002h	UM82C776 (ISA Bridge)
 0101h	UM8673F
 0881h	UM8881 (486 chipset)
 0886h	UM8886F (ISA Bridge)
 0891h	UM8891A
 1001h	UM886A (dual IDE controller)
 673Ah	UM8886BF
 8710h	UM8710 VGA controller
 886Ah	UM8886A
 8881h	UM8881F
 8886h	UM8886F
 8891h	UM8891 (Pentium chipset)
 9017h	UM9017F
 E881h	UM8881 (486 chipset)
 E886h	UM8886N
 E891h	UM8891N
SeeAlso: #00732

(Table 00772)
Values for 8x8 (X Tech) PCI device code:
 0001h	AGX-016
 0002h	IIT3204/3501 MPEG decoder
SeeAlso: #00732

(Table 00773)
Values for PicoPower PCI device code:
 0000h	PT80C826 VL Bridge
 0001h	Vesuvius V1-LS System Controller (see PORT 0024h"V1-LS")
	Revision ID field: 03h = Rev. AA, 04h = Rev. BB, 05h = Rev. CC
 0002h	Vesuvius V3-LS ISA Bridge (see #00971,PORT 0024h"V3-LS")
 0005h	National Semiconductor PC87550 PCI System Controller
 8002h	Vesuvius V3-LS ISA Bridge (secondary; Rev. BB and higher only)
SeeAlso: #00732,#00739

(Table 00774)
Values for Mylex Corporation PCI device code:
 0001h	DAC960P Wide SCSI + RAID
SeeAlso: #00732

(Table 00775)
Values for Yamaha Corporation PCI device code:
 0001h	?? 3D graphics controller
 0002h	YGV615	RPA3 3D graphics controller
SeeAlso: #00732

(Table 00776)
Values for NexGen Microsystems PCI device code:
 4E78h	NexGen 82C501
SeeAlso: #00732

(Table 00777)
Values for Q Logic PCI device code:
 1020h	ISP1020 Fast-Wide SCSI
 1022h	ISP1022 Fast-Wide SCSI
SeeAlso: #00732

(Table 00778)
Values for Leadtek Research PCI device code:
 0000h	LeadTek 805
SeeAlso: #00732

(Table 00779)
Values for Interphase PCI device code:
 0001h	ATM interface
 0002h	100 vg amylan controller
SeeAlso: #00732

(Table 00780)
Values for Data Technology Corporation (DTC) PCI device code:
 0802h	SL82C105  EIDE Controller
SeeAlso: #00732

(Table 00781)
Values for Contaq Microsystems PCI device code:
 0600h	Contaq 82C599
SeeAlso: #00732

(Table 00782)
Values for Forex Computer Corporation PCI device code:
 0001h	FR710  EIDE Controller
 0613h	??? Host Bridge
SeeAlso: #00732

(Table 00783)
Values for Bit3 Computer PCI device code:
 0001h	Model 617  PCI-VME Bus Adapter
SeeAlso: #00732

(Table 00784)
Values for Olicom PCI device code:
 0001h	??? Ethernet Controller
SeeAlso: #00732

(Table 00785)
Values for Intergraph Corporation PCI device code:
 0020h	3D graphics processor
 0021h	3D graphics processor w/texture
 0040h	3D graphics frame buffer
 0041h	3D graphics frame buffer
 0060h	proprietary bus bridge
 0720h	Motion JPEG codec
SeeAlso: #00732

(Table 00786)
Values for National Instruments PCI device code:
 C801h	PCI-GPIB
SeeAlso: #00732

(Table 00787)
Values for CMD Technology, Inc. PCI device code:
 0640h	CMD 640
 0642h	IDE controller with RAID-1
 0646h	CMD 646 EIDE
 0650h	PBC0650A Fast SCSI-II
SeeAlso: #00732

(Table 00788)
Values for Appian Technology:
 0038h	??? EIDE Controller
SeeAlso: #00732

(Table 00789)
Values for Vision / Quantum Designs Ltd. PCI device code:
 0001h	QD8500
 0002h	QD8580
SeeAlso: #00732

(Table 00790)
Values for Brooktree Corporation PCI device code:
 0350h	BT848  TV/PCI with DMA Push
 2115h	BtV 2115 Mediastream Controller
 2125h	BtV 2125 Mediastream Controller
 8230h	Bt8230 ATM Segment/Reassembly Ctrlr (SRC) (see #00981)
SeeAlso: #00732

(Table 00791)
Values for Sierra Semiconductor PCI device code:
 0000h	STB 64-bit GUI accelerator
SeeAlso: #00732

(Table 00792)
Values for ACC Microelectronics PCI device code:
 0000h	ACC 2056
SeeAlso: #00732

(Table 00793)
Values for Symphony Labs PCI device code:
 0001h	83769
 0103h	sl82c103 PCI-IDE Controller
 0105h	82C105 bus-master PCI-IDE controller
SeeAlso: #00732

(Table 00794)
Values for PLX Technology PCI device code:
 9036h	PCI9036 interface chip
 9060h	PCI9060xx interface chip
SeeAlso: #00732

(Table 00795)
Values for Madge Networks PCI device code:
 0001h	Smart 16/4 Ringnode
 1000h	Collage 25 ATM adapter
 1001h	Collage 155 ATM adapter
SeeAlso: #00732

(Table 00796)
Values for 3com Corporation PCI device code:
 5900h	3C590
 5950h	3C595TX
 5951h	3C595T4
 5952h	3C595MII
 8811h	token ring
 9000h	3C900-TPO Fast Etherlink
 9001h	3C900-COMBO Fast Etherlink
 9050h	3C905-TX Fast Etherlink 10/100
SeeAlso: #00732

(Table 00797)
Values for Standard Microsystems Corporation (SMC) PCI device code:
 1000h	37C665 floppy disk controller
 1001h	37C922 floppy disk controller
SeeAlso: #00732

(Table 00798)
Values for Acer Labs Inc. PCI device code:
 1435h	M1435 VL Bridge
 1445h	ALI M1445 VL bridge + EIDE
 1449h	ALI M1449 ISA bridge
 1451h	ALI M1451 Pentium chipset
 1461h	ALI M1461 P54C chipset
 1489h	ALI M1489
 1511h	ALI M1511
 1513h	ALI M1513
 3141h	M3141 GUI accelerator VRAM
 3143h	M3143 GUI accelerator VRAM/DAC
 3145h	M3145 GUI accelerator VRAM
 3147h	M3147 GUI accelerator VRAM/DAC
 3149h	M3149 GUI accelerator VRAM
 3151h	M3151 GUI accelerator VRAM
 5212h	M4803
 5215h	ALI MS4803 EIDE controller
 5217h	m5217 I/O
 5219h	m5219 I/O
 5235h	m5225 I/O
SeeAlso: #00732

(Table 00799)
Values for Surecom Technology PCI device code:
 5240h	IDE Controller
 5241h	PCMCIA Bridge
 5242h	general-purpose controller
 5243h	Bus controller
 5244h	Floppy-disk controller
SeeAlso: #00732

(Table 00800)
Values for Neomagic Corporation:
 0000h	graphics controller
SeeAlso: #00732

(Table 00801)
Values for Advanced System Products PCI device code:
 1100h	ABP940 revision A??? SCSI
 1200h	ABP940 revision B??? Fast SCSI-2
 1300h	Fast-Wide SCSI controller
SeeAlso: #00732

(Table 00802)
Values for Citicorp TTI PCI device code:
 2001h	mb86605 Wide SCSI-2
SeeAlso: #00732

(Table 00803)
Values for CENR/ECP/EDU PCI device code:
 0001h	SPSB PMC
 0002h	SPSB PCI
 10DCh	ATT 2C15-3 FPGA
SeeAlso: #00732

(Table 00804)
Values for Evans & Sutherland PCI device code:
 0001h	3D graphics processor
SeeAlso: #00732

(Table 00805)
Values for Emulex Corporation PCI device code:
 1AE5h	Fibre Channel Host Adapter
SeeAlso: #00732

(Table 00806)
Values for Integrated Micro Solutions PCI device code:
 5026h	IMS5026/27/28 VL Bridge
 5028h	ISA Bridge
 8849h	IMS 8849
 8853h	ATM network card
 9128h	IMS9129 GUI accelerator
SeeAlso: #00732

(Table 00807)
Values for TekRAM Technology Corporation Ltd. PCI device code:
 690Ch	TekRAM 690c
SeeAlso: #00732

(Table 00808)
Values for Newbridge Microsystems PCI device code:
 0000h	CA91C042 VMEbus Bridge
SeeAlso: #00732

(Table 00809)
Values for Applied Micro Circuits Corp. PCI device code:
 4750h	S5933 PCI controller
 8043h	MyriNet
SeeAlso: #00732

(Table 00810)
Values for Integraphics Systems PCI device code:
 1680h	1680
SeeAlso: #00732

(Table 00811)
Values for Artist Graphics PCI device code:
 0101h	3GA 64-bit graphics processor
SeeAlso: #00732

(Table 00812)
Values for Realtek Semiconductor PCI device code:
 8029h	Realtek 8029
SeeAlso: #00732

(Table 00813)
Values for ASCII Corporation PCI device code:
 7310h	V7310 VGA Video Overlay
SeeAlso: #00732

(Table 00814)
Values for NKK Corporation PCI device code:
 A001h	NDR4000	  NR4600 Bridge
SeeAlso: #00732

(Table 00815)
Values for Truevision PCI device code:
 0000h	??? GUI Accelerator
 0001h	??? GUI Accelerator
 0002h	??? GUI Accelerator
 0003h	??? GUI Accelerator
 0004h	??? GUI Accelerator
 0005h	??? GUI Accelerator
 0006h	??? GUI Accelerator
 0007h	??? GUI Accelerator
 0008h	??? GUI Accelerator
 0009h	??? GUI Accelerator
 0010h	??? GUI Accelerator
 0011h	??? GUI Accelerator
 0012h	??? GUI Accelerator
 0013h	??? GUI Accelerator
 0014h	??? GUI Accelerator
 0015h	??? GUI Accelerator
SeeAlso: #00732

(Table 00816)
Values for Initio Corporation PCI device code:
 9100h	320P
 9400h	Fast-Wide SCSI
 9700h	Fast-Wide SCSI
SeeAlso: #00732

(Table 00817)
Values for VIA Technologies PCI device code:
 0505h	VIA 82C505
 0561h	VIA 82C561
 0571h	AMD-645 Peripheral Bus Controller, function 1 (see #01034)
	VT82C586A/B PCI Integrated Peripheral Controller, function 1
 0576h	VIA 82C576
 0585h	VT82C585VPX Host Bus-PCI bridge (see #00982)
 0586h	AMD-645 Peripheral Bus Controller, function 0 (see #01011)
	VT82C586A/B PCI Integrated Peripheral Controller, function 0
 0595h	AMD-640 System Controller (see #00983)
	VT82C595
 0597h	VT82C597 / VT82C597AT
 1000h	82C570MV P54 Controller
 1106h	82C570MV ISA Bridge + IDE
 1571h	VIA 82C416
 3038h	AMD-645 Peripheral Bus Controller, function 2 (see #01046)
	VT82C586A/B PCI Integrated Peripheral Controller, function 2
 3040h	AMD-645 Peripheral Bus Controller, function 3 (see #01049)
	VT82C586B PCI Integrated Peripheral Controller, function 3
SeeAlso: #00732

(Table 00818)
Values for Proteon Inc. PCI device code:
 0100h	p1690plus-AA  Token Ring
 0101h	p1690plus-AB 2-port Token Ring
SeeAlso: #00732

(Table 00819)
Values for Cogent Data Technologies PCI device code:
 1400h	EM110TX PCI Fast Ethernet
SeeAlso: #00732

(Table 00820)
Values for Siemens Nixdorf PCI device code:
 6120h	SZB6120 Multimedia Adapter
SeeAlso: #00732

(Table 00821)
Values for Rockwell PCI device code:
 2200h	FDDI adapter
 2300h	Fast Ethernet adapter
 2340h	four-port Fast Ethernet
 2400h	ATM adapter
SeeAlso: #00732

(Table 00822)
Values for Datacube Inc. PCI device code:
 9500h	MAX-LC SuperVGA
 9501h	MAX-LC image processing
SeeAlso: #00732

(Table 00823)
Values for Vortex Computersysteme GmbH PCI device code:
 0000h	GDT60x0 SCSI RAID
 0001h	GDT6000B SCSI RAID
 0002h	GDT6x10 SCSI RAID
 0003h	GDT6x20 two-channel SCSI RAID
 0004h	GDT6530 three-channel SCSI RAID
 0005h	GDT6550 five-channel SCSI RAID
 0006h	GDT6x17
 0007h	GDT6x27
 0008h	GDT6537
 0009h	GDT6557
 000Ah	GDT6x15
 000Bh	GDT6x25
 000Ch	GDT6535
 000Dh	GDT6555
SeeAlso: #00732

(Table 00824)
Values for Efficient Networks, Inc. PCI device code:
 0000h	155P-MF1 ATM FPGA
 0002h	ATM ASIC
SeeAlso: #00732

(Table 00825)
Values for FORE Systems PCI device code:
 0210h	PCA200PC
 0300h	PCA200E
SeeAlso: #00732

(Table 00826)
Values for Infomedia MicroElectronics PCI device code:
 0000h	EIDE/HD and IDE/CD-ROM controller
 000Bh	EIDE/HD and IDE/CD-ROM controller
SeeAlso: #00732

(Table 00827)
Values for Imaging Technology PCI device code:
 0000h	ICPCI
 0001h	video frame grabber/processor
SeeAlso: #00732

(Table 00828)
Values for Mercury Computer Systems PCI device code:
 0001h	Raceway Bridge
SeeAlso: #00732

(Table 00829)
Values for Fuji Xerox Co Ltd. PCI device code:
 0001h	Printer Controller
SeeAlso: #00732

(Table 00830)
Values for Ziatech Corporation PCI device code:
 8905h	8905 STD-32 Bridge
SeeAlso: #00732

(Table 00831)
Values for Dynamic Pictures Inc. PCI device code:
 0001h	VGA-compatible 3D graphics
SeeAlso: #00732

(Table 00832)
Values for Cyclone Microsystems (PLX Technology???) PCI device code:
 0001h	PLX 9060
 0911h	PCI 911	 i960Jx Intelligent I/O
 0912h	PCI 912	 i960Cx Intelligent I/O
 0913h	PCI 913	 i960Hx Intelligent I/O
SeeAlso: #00732

(Table 00833)
Values for Crest Microsystem PCI device code:
 0001h	EIDE/ATAPI super adapter
SeeAlso: #00732

(Table 00834)
Values for Alliance Semiconductor Corp. PCI device code:
 3210h	Pro Motion 3210
 6410h	GUI Accelerator
 6412h	GUI Accelerator
 6420h	GUI Accelerator
 6422h	Pro Video
 6424h	GUI Accelerator
 6426h	GUI Accelerator
SeeAlso: #00732

(Table 00835)
Values for Cincinnati Milacron PCI device code:
 0001h	Noservo Controller
SeeAlso: #00732

(Table 00836)
Values for Schneider & Koch Co. PCI device code:
 4000h	FDDI adapter
SeeAlso: #00732

(Table 00837)
Values for VMIC PCI device code:
 7587h	VME
SeeAlso: #00732

(Table 00838)
Values for Digi International / Stargate PCI device code:
 0003h	RightSwitch
SeeAlso: #00732

(Table 00839)
Values for Voarx R&D Inc. PCI device code:
 3011h	Tokenet/vg 1001/10m anylan
 9050h	Lanfleet/Truevalue
SeeAlso: #00732

(Table 00840)
Values for MuTech PCI device code:
 0001h	MV1000
SeeAlso: #00732

(Table 00841)
Values for PFU Ltd. PCI device code:
 0001h	Host Bridge
SeeAlso: #00732

(Table 00842)
Values for Creative Labs (vendor ID 1163h) PCI device code:
 0001h	3D Blaster
SeeAlso: #00732

(Table 00843)
Values for Imagraph Corporation PCI device code:
 0001h	Motion JPEG record/play w/ audio
SeeAlso: #00732

(Table 00844)
Values for Alfa Inc. PCI device code:
 AFA1h	Fast Ethernet
SeeAlso: #00732

(Table 00845)
Values for Matsushita Electronics PCI device code:
 1592h	???
SeeAlso: #00732

(Table 00846)
Values for Corollary Inc. PCI device code:
 0014h	PCIB  C-bus II to PCI bridge chip
SeeAlso: #00732

(Table 00847)
Values for BitFlow Inc. PCI device code:
 0001h	Raptor-PCI frame grabber
SeeAlso: #00732

(Table 00848)
Values for Artop Electric PCI device code:
 0001h	IDE controller
 0002h	IDE controller
 0003h	SCSI-2 cache controller
 0004h	ATP8400 ASIC cache accelerator
 8001h	SCSI-2 cache controller
 8002h	SCSI-2 controller
SeeAlso: #00732

(Table 00849)
Values for Zeitnet Inc. PCI device code:
 0001h	Zeitnet 1221
 0002h	Zeitnet 1225
SeeAlso: #00732

(Table 00850)
Values for InnoSys Inc. PCI device code:
 4240h	AMCC S5933Q Intelligent Serial Card
SeeAlso: #00732

(Table 00851)
Values for Galileo Technology PCI device code:
 0146h	GT-64010 System Controller for R46xx CPU
 4801h	GT-48001 8-port switched Ethernet ctrlr
SeeAlso: #00732

(Table 00852)
Values for V3 Semiconductor Inc. PCI device code:
 0292h	V292PBC	 Am29030/40 Bridge
 0960h	V96xPBC	 i960 Bridge
 C960h	V96DPC	 i960 dual PCI Bridge
SeeAlso: #00732

(Table 00853)
Values for Pathlight Technology PCI device code:
 C0EDh	SSA Controller
SeeAlso: #00732

(Table 00854)
Values for Dolphin Interconnect Solutions PCI device code:
 0658h	PSB  PCI-SCI Bridge
SeeAlso: #00732

(Table 00855)
Values for Specialix Research Ltd. PCI device code:
 2000h	PCI-9050 Target Interface
 4000h	Specialix XIO (SUPI-1 Target Interface)
 8000h	Specialix RIO (T255 Bridge)
SeeAlso: #00732

(Table 00856)
Values for Compex USA, Inc. PCI device code:
 1401h	ReadyLINK RL2000 10MBit NIC
SeeAlso: #00732

(Table 00857)
Values for PMC-Sierra Inc. PCI device code:
 7375h	PM7375 LASAR-155 ATM SAR
SeeAlso: #00732

(Table 00858)
Values for RP PCI device code:
 0001h	RP8OCTA
 0002h	RP8INTF
 0003h	RP16INTF
 0004h	RP32INTF
SeeAlso: #00732

(Table 00859)
Values for Cyclades PCI device code:
 0100h	Cyclom Y Lo multiport serial card
 0101h	Cyclom Y Hi
 0200h	Cyclom Z Lo multiport serial card
 0201h	Cyclom Z Hi
SeeAlso: #00732

(Table 00860)
Values for Ariel Corporation PCI device code:
 1220h	AMCC 5933  TMS320C80 DSP/Imaging Board
SeeAlso: #00732

(Table 00861)
Values for Harris Semiconductor PCI device code:
 8130h	HMP8130 NTSC/PAL Video Decoder
 8131h	HMP8131 NTSC/PAL Video Decoder
SeeAlso: #00732

(Table 00862)
Values for Ensoniq PCI device code:
 1371h	AudioPCI-97 ES1371
 5000h	AudioPCI ES1370
SeeAlso: #00732

(Table 00863)
Values for Picture Elements PCI device code:
 0081h	PCIVST	PCI Thresholding Engine
SeeAlso: #00732

(Table 00864)
Values for Symphony PCI device code:
 0001h	Symphony 82C101 IDE controller
SeeAlso: #00732

(Table 00865)
Values for TekRAM PCI device code:
 DC29h	DC290 / DC290M EIDE controller
SeeAlso: #00732

(Table 00866)
Values for 3DLabs PCI device code:
 0004h	3C0SX GUI Accelerator
SeeAlso: #00732

(Table 00867)
Values for Avance Logic, Inc. PCI device code:
 2301h	AVL2301 GUI Accelerator
 2303h	AVG2302 GUI Accelerator
SeeAlso: #00732

(Table 00868)
Values for 4942h PCI device code:
 4C4Ch	??? (Ensoniq AudioPCI ES1370 subsystem)
SeeAlso: #00732

(Table 00869)
Values for BusLogic Inc. PCI device code:
 3080h	??? SCSI-ti
 4010h	??? Fast-Wide SCSI-2
SeeAlso: #00732

(Table 00870)
Values for S3 PCI device code:
 5631h	86C325 ViRGE 3D GUI Accelerator
 8800h	Vision 866
 8801h	Vision 964
 8810h	S3 Trio32
 8811h	S3 Trio64, or Trio64V+
 8812h	S3 Trio64UV+
 8813h	S3 Trio64? v3
 883Dh	S3 ViRGE/VX
 888xh	S3 868
 88Bxh	S3 928
 88C0h	S3 864-1
 88C1h	S3 864-2
 88C2h	S3 864-3
 88C3h	S3 864-4
 88D0h	S3 964-1
 88D1h	S3 964-2
 88D2h	S3 964-3
 88D3h	S3 964-4
 88F0h	S3 968
 88F1h	S3 968-2
 88F2h	S3 968-3
 88F3h	S3 968-3
 8900h	S3 Trio64 V2/DX GUI Accelerator
 8901h	S3 775 Trio64V2
 8902h	S3 PLATO/PX
 8A01h	S3 ViRGE/DX or ViRGE/GX
 8A10h	???
 8C00h	???
 8C01h	???
SeeAlso: #00732,#00873

(Table 00871)
Values for c't Magazin fr Computer PCI device code:
 6773h	GPPCI  PCI interface
SeeAlso: #00732

(Table 00872)
Values for Quancom Electronic PCI device code:
 0010h	PCI-WDOG1 Watchdog
 0011h	PWDOG2 Watchdog2/PCI
SeeAlso: #00732

(Table 00873)
Values for Intel PCI device code:
 0482h	82375EB/SB PCI-EISA Bridge (see #01054)
 0483h	82424 Cache Controller (see #01063)
 0484h	82378/82379 Bus Interface (Mercury/Saturn/Neptune chipsets) (see #01064)
 0486h	82425EX/82430
 04A3h	82434 LX (Mercury) / NX (Neptune) (see #01055)
 0960h	i960 RP Microprocessor/Bridge
 1221h	82092AA PCMCIA Bridge
 1222h	82092AA IDE Controller
 1223h	Intel SAA7116
 1226h	82596
 1227h	82865
 1228h	EtherExpress Pro/100 Smart
 1229h	82557 Fast Ethernet (see #01227)
 122Dh	82437FX (Triton)
 122Eh	82371FB ISA Bridge (Triton)
 1230h	82338 IDE controller / 82371FB IDE function (Triton)
 1234h	82371MX (see #01168)
 1235h	82437MX
 1237h	82441FX (see #01229)
 1239h	82371FB IDE Interface (Triton)
 123Ch	82380AB Mobile PCI-to-ISA Bridge (see #01090)
 124Bh	82380FB Mobile PCI-to-PCI Bridge (see #04069)
 1250h	82439HX (430HX chipset) (see #01098)
 1960h	80960RP i960RP Microprocessor
 7000h	82371SB ISA Bridge (see #01167)
 7010h	82371SB IDE controller (see #01214)
 7020h	82371SB (see #01215)
 7030h	82437VX (430VX chipset) (see #01108)
 7100h	82439TX (430TX chipset) (see #01099)
 7110h	82371AB PIIX4 ISA Bridge (see #01100)
 7111h	82371AB PIIX4 Ultra DMA IDE Controller (see #01103)
 7112h	82371AB PIIX4 USB Controller (see #01104)
 7113h	82371AB PIIX4 Power Management Controller (see #01105)
 7180h	82443LX/EX 440LX/EX Host-PCI Bridge (see #01129)
 7181h	82443LX/EX 440LX/EX AGP device (see #01130)
 7190h	82443BX 440BX PCI-Host Bridge (AGP Enabled) (see #01142)
 7191h	82443BX 440BX PCI-PCI Bridge (see #01143)
 7192h	82443BX 440BX PCI-Host Bridge (AGP Disabled) (see #01142)
 71A0h	82443GX Host Bridge/Controller (AGP enabled)
 71A1h	82443GX AGP Controller
 71A2h	82443GX Host Bridge/Controller (AGP disabled)
 84C4h	82450KX/GX PCI Bridge (Orion) (see #01240)
 84C5h	82450KX/GX Memory Ctrlr (Orion)
 84CAh	82451NX (450NX) Memory & I/O Controller (MIOC)
 84CBh	82454NX (450NX) PCI Expansion Bridge (PXB)
SeeAlso: #00732,#00870

(Table 00874)
Values for Trigem Computer PCI device code:
 2008h	video assistant
SeeAlso: #00732

(Table 00875)
Values for Adaptec PCI device code:
 1078h	AIC-7810C RAID Coprocessor
 5078h	x940 Fast-Wide SCSI-II Ctrlr
 5578h	AHA-2830P SCSI Controller
 7078h	AHA-294x/AIC-7870P Fast-Wide SCSI-II
 7178h	AHA-2940 Fast-Wide SCSI-II
 7278h	x940 two-channel Fast-Wide SCSI
 7378h	AHA-3985 4-channel RAID SCSI
 7478h	AHA-2944 SCSI
 7810h	AIC-7810 memory control IC
 7850h	AIC-7850 SCSI IC (see #01241)
 7855h	AHA-2930 SCSI
 7870h	AIC-7870 SCSI IC
 7871h	AHA-2940
 7872h	AHA-3940
 7873h	AHA-3980
 7874h	AHA-2944 Differential SCSI
 7880h	AIC-7880 Fast-20 SCSI
 8078h	Adaptec 7880
 8178h	Adaptec 2940UW
 8278h	AHA-3940U/UW
 8378h	Adaptec 7883
 8478h	Adaptec 7884
SeeAlso: #00732

(Table 00876)
Values for Atronics PCI device code:
 2015h	Atronics 2015
SeeAlso: #00732

(Table 00877)
Values for Ark Logic Inc. PCI device code:
 A091h	ARK 1000PV ??? Stingray
 A099h	ARK 2000PV ??? Stingray
 A0A1h	ark2000mt 64-bit GUI Accel w/DCI
SeeAlso: #00732
--------X-1AB103-----------------------------
INT 1A - PCI BIOS v2.0c+ - FIND PCI CLASS CODE
	AX = B103h
	ECX = class code (see also #F0085,#00878)
	    bits 31-24 unused
	    bits 23-16 class
	    bits 15-8  subclass
	    bits 7-0   programming interface
	SI = device index (0-n)
Return: CF clear if successful
	CF set on error
	AH = status (00h,86h) (see #00729)
	    00h successful
		BH = bus number
		BL = device/function number (bits 7-3 device, bits 2-0 func)
	    86h device not found
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
	all devices sharing the same Class Code may be enumerated by
	  incrementing SI from 0 until error 86h is returned
SeeAlso: AX=B183h
--------X-1AB106-----------------------------
INT 1A - PCI BIOS v2.0c+ - PCI BUS-SPECIFIC OPERATIONS
	AX = B106h
	BL = bus number
	EDX = Special Cycle data
Return: CF clear if successful
	CF set on error
	AH = status (00h,81h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Note:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
SeeAlso: AX=B186h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB108-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION BYTE
	AX = B108h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    CL = byte read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
BUG:	the Award BIOS 4.51PG (dated 05/24/96) incorrectly returns FFh for
	  register 00h if the PCI function number is nonzero
SeeAlso: AX=B109h,AX=B10Ah,AX=B188h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB109-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION WORD
	AX = B109h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh, must be multiple of 2) (see #00878)
Return: CF clear if successful
	    CX = word read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
BUG:	the Award BIOS 4.51PG (dated 05/24/96) incorrectly returns FFFFh for
	  register 00h if the PCI function number is nonzero
SeeAlso: AX=B108h,AX=B10Ah,AX=B189h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10A-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD
	AX = B10Ah
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh, must be multiple of 4) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
BUG:	the Award BIOS 4.51PG (dated 05/24/96) incorrectly returns FFFFFFFFh
	  for register 00h if the PCI function number is nonzero
SeeAlso: AX=B108h,AX=B109h,AX=B10Ah/SF=8086h,AX=B18Ah,INT 2F/AX=1684h/BX=304Ch

Format of PCI Configuration Data:
Offset	Size	Description	(Table 00878)
 00h	WORD	vendor ID (read-only) (see #00732 at AX=B102h)
		FFFFh returned if requested device non-existent
 02h	WORD	device ID (read-only)
 04h	WORD	command register (see #00879)
 06h	WORD	status register (see #00880)
 08h	BYTE	revision ID
 09h  3 BYTEs	class code
		bits 7-0: programming interface
		bits 15-8: sub-class
		bits 23-16: class code (see also #F0085)
 0Ch	BYTE	cache line size
 0Dh	BYTE	latency timer
 0Eh	BYTE	header type
		bits 6-0: header format
			00h other
			01h PCI-to-PCI bridge
			02h PCI-to-CardBus bridge
		bit 7: multi-function device
 0Fh	BYTE	Built-In Self-Test result (see #00881)
---header type 00h---
 10h	DWORD	base address 0 (see #00882)
		(OpenHCI) base address of host controller registers (see #00902)
 14h	DWORD	base address 1
 18h	DWORD	base address 2
 1Ch	DWORD	base address 3
 20h	DWORD	base address 4
 24h	DWORD	base address 5
 28h	DWORD	CardBus CIS pointer (read-only) (see #00889)
 2Ch	WORD	subsystem vendor ID or 0000h
 2Eh	WORD	subsystem ID or 0000h
 30h	DWORD	expansion ROM base address (see #00883)
 34h	BYTE	offset of capabilities list within configuration space (R/O)
		(only valid if status register bit 4 set) (see #00884)
 35h  3 BYTEs	reserved
 38h	DWORD	reserved
 3Ch	BYTE	interrupt line
		00h = none, 01h = IRQ1 to 0Fh = IRQ15
 3Dh	BYTE	interrupt pin (read-only)
		(00h = none, else indicates INTA# to INTD#)
 3Eh	BYTE	minimum time bus master needs PCI bus ownership, in 250ns units
		(read-only)
 3Fh	BYTE	maximum latency, in 250ns units (bus masters only) (read-only)
 40h 48 DWORDs	varies by device (see #00919,#00920,#01055,#01083)
---header type 01h---
 10h	DWORD	base address 0 (see #00882)
 14h	DWORD	base address 1
 18h	BYTE	primary bus number (for bus closer to host processor)
 19h	BYTE	secondary bus number (for bus further from host processor)
 1Ah	BYTE	subordinate bus number
 1Bh	BYTE	secondary latency timer
 1Ch	BYTE	I/O base (see #00899)
 1Dh	BYTE	I/O limit (see #00899)
 1Eh	WORD	secondary status
 20h	WORD	memory base (see #00900)
 22h	WORD	memory limit
 24h	WORD	prefetchable memory base
 26h	WORD	prefetchable memory limit
 28h	DWORD	prefetchable base, upper 32 bits
 2Ch	DWORD	prefetchable limit, upper 32 bits
 30h	WORD	I/O base, upper 16 bits
 32h	WORD	I/O limit, upper 16 bits
 34h	DWORD	reserved
 38h	DWORD	expansion ROM base address
 3Ch	BYTE	interrupt line
 3Dh	BYTE	interrupt pin (read-only)
 3Eh	WORD	bridge control (see #00901)
 40h 48 DWORDs	varies by device (see #00919,#00920,#01055,#01083)
---header type 02h---
 10h	DWORD	CardBus Socket/ExCa base address (see #00890)
		bits 31-12: start address of socket interface register block
			  in 4K blocks
		bits 11-0: reserved (0)
 14h	BYTE	offset of capabilities list within configuration space (R/O)
		(only valid if status register bit 4 set) (see #00884)
 15h	BYTE	reserved
 16h	WORD	secondary status
 18h	BYTE	PCI bus number
 19h	BYTE	CardBus bus number
 1Ah	BYTE	subordinate bus number
 1Bh	BYTE	CardBus latency timer
 1Ch	DWORD	memory base address 0
 20h	DWORD	memory limit 0
 24h	DWORD	memory base address 1
 28h	DWORD	memory limit 1
 2Ch	WORD	I/O base address 0
 2Eh	WORD	I/O base address 0 high word (optional)
 30h	WORD	I/O limit 0
 32h	WORD	I/O limit 0 high word (optional)
 34h	WORD	I/O base address 1
 36h	WORD	I/O base address 1 high word (optional)
 38h	WORD	I/O limit 1
 3Ah	WORD	I/O limit 1 high word (optional)
 3Ch	BYTE	interrupt line
 3Dh	BYTE	interrupt pin (read-only) (no interrupt used if 00h)
 3Eh	WORD	bridge control
 40h	WORD	subsystem vendor ID
 42h	WORD	subsystem device ID
 44h	DWORD	16-bit PC Card legacy mode base address (for accessing ExCa
		  registers)
 48h 14 DWORDs	reserved
 80h 32 DWORDs	varies by device (see #00919,#00920,#01055,#01083)

Bitfields for PCI Configuration Command Register:
Bit(s)	Description	(Table 00879)
 0	I/O access enabled
 1	memory access enabled
 2	bus master enable
 3	special cycle recognition enabled
 4	memory write and invalidate enabled
 5	VGA palette snoop enabled
 6	parity error response enabled
 7	wait cycles enabled
 8	system error (SERR# line) enabled
 9	fast back-to-back transactions enabled
 15-10	reserved
SeeAlso: #00878,#00880

Format of PCI Configuration Status Register:
Bit(s)	Description	(Table 00880)
 3-0	reserved (0)
 4	new capabilities list is present (first entry pointed at by byte at
	  34h or 14h)
 5	capable of running at 66 MHz
 6	UDF supported
 7	capable of fast back-to-back transactions
 8	data parity error reported
 10-9	device select timing
	00 fast
	01 medium
	10 slow
	11 reserved
 11	signaled target abort
 12	received target abort
 13	received master abort
 14	signaled system error (device is asserting SERR# line)
 15	detected parity error (set even if parity error reporting is disabled)
Note:	bits 12, 13 and 15 are cleared by writing a 1 into the corresponding
	  bit
SeeAlso: #00878,#00879

Bitfields for PCI Configuration Built-In Self-Test register:
Bit(s)	Description	(Table 00881)
 3-0	completion code (0000 = successful)
 5-4	reserved
 6	start BIST (set to one to start, cleared automatically on completion)
 7	BIST-capable
Notes:	this register is hardwired to 00h if no BIST capability
	software should timeout the BIST after two seconds
SeeAlso: #00878

Bitfields for PCI Configuration Base Address:
Bit(s)	Description	(Table 00882)
 0	address type (0 = memory space, 1 = I/O space)
---memory address---
 2-1	address type
	00 anywhere in first 4GB
	01 below 1MB
	10 anywhere in 64-bit address space
	11 reserved
 3	prefetchable
 31-4	bits 31-4 of base memory address if addressable in first 1MB or 4GB
 63-4	bits 63-4 of base memory address if addressable in 64-bit memory
	(bits 63-32 are stored in the following base address DWORD)
---I/O address---
 1	reserved
 31-2	bits 31-2 of base I/O port
SeeAlso: #00878,#00902

Bitfields for PCI Configuration Expansion ROM Address:
Bit(s)	Description	(Table 00883)
 0	address decode enable (ROM address is valid)
 10-1	reserved
 31-11	bits 31-11 of ROM's starting physical address
SeeAlso: #00878

Format of PCI Capabilities List:
Offset	Size	Description	(Table 00884)
 00h	BYTE	capability identifier
		01h PCI Power Managment
 01h	BYTE	offset of next item (within configuration space) or 00h
      N	BYTEs	varies by capability type
---PCI Power Management---
 02h	WORD	power managment capabilities (see #00885) (read-only)
 04h	WORD	power managment capabilities status register (see #00886)
 06h	BYTE	PMCSR bridge support extensions (see #00887)
 07h	BYTE	(optional) read-only data register (see #00888)
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #00878,#00880

Bitfields for PCI Power Management Capabilities:
Bit(s)	Description	(Table 00885)
 15	reserved (0)
 14-12	PME# support
	bit 12: PME# can be asserted from power state D0
	bit 13: PME# can be asserted from power state D1
	bit 14: PME# can be asserted from power state D2
 11	reserved (0)
 10	D2 power state supported
 9	D1 power state supported
 8	full-speed clock is required in state D0 for proper operation
	(if clear, device may be run at reduced clock except when actually
	  being accessed)
 7-6	dynamic clock control support
	00 not bridge, no dynamic clock control, or secondary bus' clock is
	      is tied to primary bus' clock
	01 bridge is capable of dynamic clock control
	10 reserved
	11 secondary bus has independent clock, but dynamic clock not supported
 5	device-specific initialization is required
 4	auxiliary power required for PME# generation
 3	PCI clock required for PME# generation
 2-0	specification version
	001 = v1.0; four bytes of power management registers
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #00884,#00886,#00887

Bitfields for PCI Power Management Capabilities Status Register:
Bit(s)	Description	(Table 00886)
 15	PME status: if set, PME# is (or would be) asserted
	writing a 1 to this bit clears it
 14-13	(read-only) scale factor to apply to contents of Data register
	00 unknown (or unimplemented data)
	01 x0.1
	10 x0.01
	11 x0.001
 12-9	(read-write) data select (see #00888)
 8	(read-write) enable PME# assertion
 7-5	reserved (0)
 4	(read-write) enable dynamic data reporting
	when set, PME# is asserted whenever the value in the Data register
	  changes significantly
 3-2	reserved (0)
 1-0	(read-write) current power state
	00 = D0
	...
	11 = D3
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #00884,#00885,#00887

Bitfields for PCI Power Management PMCSR bridge support extension:
Bit(s)	Description	(Table 00887)
 7	(read-only) Bus Power Control Enable
 6	(read-only) Bus Power State B3 supported
 5	(read-only) Bus Power State B2 supported
 4	dynamic clock control enable
 3-0	reserved (0)
Note:	this information is from the v0.93 draft of the specification and is
	  subject to change
SeeAlso: #00884,#00885,#00886

(Table 00888)
Values for PCI Power Management Data Select:
 00h	D0-state power consumed in watts (+20%/-10%)
 01h	D1-state power consumed in watts (+20%/-10%)
 02h	D2-state power consumed in watts (+20%/-10%)
 03h	D3-state power consumed in watts (+20%/-10%)
 04h	D0-state power dissipated into chassis in watts
 05h	D1-state power dissipated into chassis in watts
 06h	D2-state power dissipated into chassis in watts
 07h	D3-state power dissipated into chassis in watts
 08h-0Fh reserved
SeeAlso: #00886

Bitfields for PCI Configuration CardBus CIS Pointer:
Bit(s)	Description	(Table 00889)
 2-0	address space
	000 in device's device-specific configuration space
	001 in memory pointed to by base address register 0
	...
	110 in memory pointed to by base address register 5
	111 in device's expansion ROM
 27-3	offset within address space defined by bits 2-0
 31-28	ROM image number (when address space is expansion ROM)
SeeAlso: #00878

Format of CardBus Socket/ExCA socket interface register space:
Offset	Size	Description	(Table 00890)
 00h	DWORD	Socket Event Register (see #00892)
 04h	DWORD	Socket Mask Register (see #00893)
 08h	DWORD	Socket Present State Register (see #00894)
 0Ch	DWORD	Socket Force Event Register (see #00895)
 10h	DWORD	Socket Control Register (see #00896)
 14h  3 DWORDs	reserved
 20h	DWORD	Socket Power Management Register
 90h	BYTE	(TI PCI1130) Retry Status Register
 91h	BYTE	(TI PCI1130) Card Control Register (see #00897)
 92h	BYTE	(TI PCI1130) Device Control Register (see #00898)
 93h	BYTE	(TI PCI1130) Buffer Control Register
800h 64+ BYTEs	ExCa Socket Interface Registers (see #00891)

Format of ExCa memory-mapped registers:
Offset	Size	Description	(Table 00891)
 00h	BYTE	identification and revision register
 01h	BYTE	interface status register
 02h	BYTE	power control register
 03h	BYTE	interrupt and general control
 04h	BYTE	card status change
 05h	BYTE	card status change interrupt configuration
 06h	BYTE	address window enable
 07h	BYTE	I/O window control register
 08h	WORD	I/O window 0 start address
 0Ah	WORD	I/O window 0 end address
 0Ch	WORD	I/O window 1 start address
 0Eh	WORD	I/O window 1 end address
 10h	WORD	memory window 0 start address
 12h	WORD	memory window 0 end address
 14h	WORD	memory window 0 offset address
 16h  2 BYTEs	user-defined
 18h	WORD	memory window 1 start address
 1Ah	WORD	memory window 1 end address
 1Ch	WORD	memory window 1 offset address
 1Eh	BYTE	user-defined
 1Fh	BYTE	reserved
 20h	WORD	memory window 2 start address
 22h	WORD	memory window 2 end address
 24h	WORD	memory window 2 offset address
 26h  2 BYTEs	user-defined
 28h	WORD	memory window 3 start address
 2Ah	WORD	memory window 3 end address
 2Ch	WORD	memory window 3 offset address
 2Eh  2 BYTEs	user-defined
 30h	WORD	memory window 4 start address
 32h	WORD	memory window 4 end address
 34h	WORD	memory window 4 offset address
 36h 10 BYTEs	user-defined
---optional---
 40h	BYTE	memory window 0 start address high byte
 41h	BYTE	memory window 1 start address high byte
 42h	BYTE	memory window 2 start address high byte
 43h	BYTE	memory window 3 start address high byte
 44h	BYTE	memory window 4 start address high byte
 45h-7FFh	user-defined
SeeAlso: #00890

Bitfields for CardBus Socket Event Register:
Bit(s)	Description	(Table 00892)
 0	CSTSCHG pin asserted (status change)
 1	CCD1# (card detect 1) changed state
 2	CCD2# (card detect 2) changed state
 3	interface power cycle completed
31-4	reserved (0)
Note:	the bits in this register are set by the bridge, and cleared by writing
	  a one into the bits one wishes to clear
SeeAlso: #00890,#00893,#00895

Bitfields for CardBus Socket Event Mask Register:
Bit(s)	Description	(Table 00893)
 0	write-protect (enable status-change interrupt on WriteProtect switch)
 1	ready mask (allow status-change interrupt on Ready line change)
 3-2	battery condition (allow status-change int on battery-condition change)
 4	general wakeup enabled
 5	binary audio mode enabled on CAUDIO pin
 6	Pulse Width Modulation enabled on CAUDIO pin
	(CAUDIO state undefined if both bits 5 and 6 set)
 13-7	reserved (0)
 14	Wakeup mask (enable wakeup events via status-change pin)
 15	enable card interrupts via CINT# pin and wakeup events
 31-16	reserved
SeeAlso: #00890,#00892,#00894

Bitfields for CardBus Socket Present State Register:
Bit(s)	Description	(Table 00894)
 0	CSTSCHG pin asserted (status change)
 1	CCD1# (card detect 1) changed state
 2	CCD2# (card detect 2) changed state
 3	interface power cycle completed
 4	16-bit PC card inserted
 5	CardBus card inserted
 6	card's interrupt pin asserted
 7	card inserted but type can not be determined
 8	data may have been lost due to abrupt card removal
 9	attempted to apply Vcc voltage not supported by the card
 10	card can accept Vcc = 5.0 volts
 11	card can accept Vcc = 3.3 volts
 12	card can accept Vcc = X.X volts
 13	card can accept Vcc = Y.Y volts
 27-14	reserved (0)
 28	socket can accept Vcc = 5.0 volts
 29	socket can accept Vcc = 3.3 volts
 30	socket can accept Vcc = X.X volts
 31	socket can accept Vcc = Y.Y volts
Note:	bits 0-3 may be cleared by writing a 1 into the respective bits
SeeAlso: #00890,#00892,#00893,#00896

Bitfields for CardBus Socket Force Event Register:
Bit(s)	Description	(Table 00895)
 0	write-protect
 1	ready
 2	battery voltage detect 2
 3	battery voltage detect 1
 4	general wakeup
 14-5	reserved (0)
 15	enable card interrupts via CINT# pin
 31-16	reserved
Note:	this register can simulate events by forcing the values of some of the
	  bits in the Event Mask Register; any bit of this register which is
	  set to 1 forces the corresponding bit in the Mask Register to 1,
	  while bits set to 0 leave the corresponding bit unchanged
SeeAlso: #00890,#00892,#00896

Bitfields for CardBus Socket Control Register:
Bit(s)	Description	(Table 00896)
 2-0	Vpp control
	000 power off
	001 12.0 Volts
	010 5.0 Volts
	011 3.3 Volts
	100 reserved (X.X Volts)
	101 reserved (Y.Y Volts)
	110 reserved
	111 reserved
 3	reserved (0)
 6-4	Vcc control (as for Vpp, but 12.0V not supported)
 31-7	reserved (0)
SeeAlso: #00890,#00893,#00895

Bitfields for TI PCI1130 Card Control Register:
Bit(s)	Description	(Table 00897)
 0	interrupt pending
 1	speaker output enabled
 2	reserved
 3	enable status-change interrupt routing (to INTA# for socket A, INTB#
	  for socket B)
 4	function interrupt routed to corresponding PCI interrupt pin
 5	PCI interrupts enabled
 6	ZOOM video mode enabled
 7	Ring Indicator enabled on IRQ15/RI_OUT pin
SeeAlso: #00890,#00898

Bitfields for TI PCI1130 Device Control Register:
Bit(s)	Description	(Table 00898)
 0	reserved (0)
 2-1	interrupt mode enable
	00 no interrupt
	01 ISA mode (direct IRQ routing)
	10 serialized interrupt mode
	11 reserved
 4-3	reserved
 5	3volt Socket Capable force bit
 6	5volt Socket Capable force bit
 7	reserved
SeeAlso: #00890,#00897

Bitfields for PCI Configuration I/O base and limit:
Bit(s)	Description	(Table 00899)
 3-0	(read-only) address decoding type
	0000 16-bit
	0001 32-bit
	other reserved
 7-4	bits 15-12 of I/O address range
SeeAlso: #00878,#00900

Bitfields for PCI Configuration memory base and limit:
Bit(s)	Description	(Table 00900)
 3-0	address decode type
	0000 32-bit address decoder
	0001 64-bit address decoder
	other reserved
 15-4	bits 31-20 of memory address range
SeeAlso: #00878,#00899

Bitfields for PCI Configuration Bridge Control Register:
Bit(s)	Description	(Table 00901)
 7	enable fast back-to-back cycles on secondary bus
 6	reset secondary bus
 5	master abort mode on secondary bus
 4	reserved
 3	VGA enable (when set, forward VGA memory and I/O ranges to seconary
	  bus)
 2	ISA enable
 1	reserved
 0	enable parity error response
SeeAlso: #00878,#01131

Format of OpenHCI Host Controller memory-mapped registers:
Offset	Size	Description	(Table 00902)
 00h	DWORD	"HcRevision"		OpenHCI revision (see #00903)
 04h	DWORD	"HcControl"		HC operating modes (see #00904)
 08h	DWORD	"HcCommandStatus"	command/status (see #00905)
 0Ch	DWORD	"HcInterruptStatus"	interrupt status (see #00906)
 10h	DWORD	"HcInterruptEnable"	enable interrupts (see #00907)
 14h	DWORD	"HcInterruptDisable"	disable interrupts (see #00907)
 18h	DWORD	"HcHCCA"		HC Communications Area (see #00908)
 1Ch	DWORD	"HcPeriodCurrentED"	Endpoint Descriptor addr (see #00909)
 20h	DWORD	"HcControlHeadED"	Control Endpoint Descriptor (see #00910)
 24h	DWORD	"HcControlCurrentED"	Control Endpoint Descriptor (see #00910)
 28h	DWORD	"HcBulkHeadED"		Bulk Endpoint Descriptor (see #00911)
 2Ch	DWORD	"HcBulkCurrentED"	Bulk Endpoint Descriptor (see #00911)
 30h	DWORD	"HcDoneHead"		last completed Xfer Descr. (see #00912)
 34h	DWORD	"HcFmInterval"		Frame bit-time interval (see #00913)
 38h	DWORD	"HcFmRemaining"		bit time remaining in Frame (see #00914)
 3Ch	DWORD	"HcFmNumber"		Frame Number (bits 15-0)
 40h	DWORD	"HcPeriodicStart"	earliest time to start periodic list
					(bits 13-0)
 44h	DWORD	"HcLSThreshold"		threshold for Low Speed transaction
					(bits 11-0)
 48h	DWORD	"HcRhDescriptorA"	Root Hub Descriptor A (see #00915)
 4Ch	DWORD	"HcRhDescriptorB"	Root Hub Descriptor B (see #00916)
 50h	DWORD	"HcRhStatus"		Root Hub status (see #00917)
 54h  N DWORDs	"HCRhPortStatus[1-N]"	Root Hub port status N (see #00918)
Note:	OpenHCI reserves a full 4K page of the systems address space for its
	  memory-mapped registers
SeeAlso: #00878,#00882,#F0085,#00966

Bitfields for OpenHCI "HcRevision" register:
Bit(s)	Description	(Table 00903)
 31-8	reserved
 7-0	BCD OpenHCI specification number (10h = 1.0, 11h = 1.1)
Note:	this register is read-only
SeeAlso: #00902,#00904

Bitfields for OpenHCI "HcControl" register:
Bit(s)	Description	(Table 00904)
 31-11	reserved
 10	RWE	enable Remote Wakeup feature
 9	RWC	controller supports Remote Wakeup signalling
 8	IR	Interrupt Routing
		0 normal host bus interrupt
		1 System Managment Interrupt
 7-6	HCFS	USB Host Controller Functional State
		00 USBReset
		01 USBResume
		10 USBOperational
		11 USBSuspend
 5	BLE	enable Bulk List processing in next frame
 4	CLE	enable Control List processing in next frame
 3	IE	enable Isochronous ED processing
 2	PLE	enable processing of Periodic List in next frame
 1-0	CBSR	Control Bulk Service Ratio
		00  1:1 Control EDs:Bulk EDs served
		01  2:1
		10  3:1
		11  4:1
SeeAlso: #00902,#00903,#00905

Bitfields for OpenHCI "HcCommandStatus" register:
Bit(s)	Description	(Table 00905)
 31-18	reserved
 17-16	SOC	scheduling-overrun count
 15-4	reserved
 3	OCR	ownership change request is pending
 2	BLF	bulk list contains TDs
 1	CLF	control list contains TDs
 0	HCR	host controller software reset
Note:	writing a 1 bit sets the corresponding bit, while a 0 bit leaves the
	  corresponding bit unchanged
SeeAlso: #00902,#00903,#00906

Bitfields for OpenHCI "HcInterruptStatus" register:
Bit(s)	Description	(Table 00906)
 31	reserved (0)
 30	OC	ownership change
 29-7	reserved
 6	RHSC	Root Hub status changed
 5	FNO	frame number overflowed
 4	UE	unrecoverable error
 3	RD	resume detected
 2	SF	start of frame
 1	WDH	writeback done
 0	SO	scheduling overrun
Note:	writing a 1 bit clears the corresponding bit of the register
SeeAlso: #00902,#00903,#00905,#00907

Bitfields for OpenHCI "HcInterruptEnable" and "HcInterruptDisable" registers:
Bit(s)	Description	(Table 00907)
 31	MIE	master interrupt enable
 30	OC	ownership change
 29-7	reserved
 6	RHSC	Root Hub status change
 5	FNO	frame number overflow
 4	UE	unrecoverable error
 3	RD	Resume Detect
 2	SF	start of frame
 1	WDH	HcDoneHead writeback
 0	SO	scheduling overrun
Note:	writing a 1 bit to HcInterruptEnable enables the corresponding
	  interrupt, while writing a 1 bit to HcInterruptDisable disables it;
	  zero bits are ignored.  On reading, both registers return the
	  same value, which reflects the currently enabled interrupts
SeeAlso: #00902

Bitfields for OpenHCI "HcHCCA" register:
Bit(s)	Description	(Table 00908)
 31-8	physical address of Host Controller Communications Area (bits 31-8)
 7-0	reserved (0)
Note:	the required alignment for the HCCA may be determined by writing
	  FFFFFFFFh to this register and determining the number of low-order
	  zero bits
SeeAlso: #00902,#00909,#00910

Bitfields for OpenHCI "HcPeriodCurrentED" register:
Bit(s)	Description	(Table 00909)
 31-4	physical address of current Isochronous/Interrupt Endpoint Descriptor
	  (bits 31-4)
 3-0	reserved (0)
SeeAlso: #00902,#00908,#00910

Bitfields for OpenHCI "HcControlHeadED"/"HcControlCurrentED" register:
Bit(s)	Description	(Table 00910)
 31-4	physical address of first/current Endpoint Descriptor (bits 31-4)
 3-0	reserved (0)
Note:	HcControlCurrentED is set to 0000000h to indicate the end of the
	  Control list
SeeAlso: #00902,#00908,#00909

Bitfields for OpenHCI "HcBulkHeadED"/"HcBulkCurrentED" register:
Bit(s)	Description	(Table 00911)
 31-4	physical address of first/current Endpoint Descriptor in the Bulk
	  list (bits 31-4)
 3-0	reserved (0)
Note:	HcBulkCurrentED is set to 0000000h to indicate the end of the Bulk
	  list
SeeAlso: #00902,#00908,#00910

Bitfields for OpenHCI "HcDoneHead" register:
Bit(s)	Description	(Table 00912)
 31-4	physical address of most-recently completed Transfer Descriptor added
	  to the Done queue (bits 31-4)
 3-0	reserved (0)
SeeAlso: #00902,#00909,#00911

Bitfields for OpenHCI "HcFmInterval" register:
Bit(s)	Description	(Table 00913)
 31	"FIT"	toggled each time a new value is loaded into bits 13-0
 30-16	"FSMPS"	largest data packet in bits
 15-14	reserved
 13-0	"FI"	Frame Interval (between to consecutive SOFs)
SeeAlso: #00902,#00914

Bitfields for OpenHCI "HcFmRemaining" register:
Bit(s)	Description	(Table 00914)
 31	"FRT"	loaded from bit 31 of HcFmInterval whenever FR reaches 0
 30-14	reserved
 13-0	"FR"	FrameRemaining -- bits times left in current frame
SeeAlso: #00902,#00913

Bitfields for OpenHCI "HcRhDescriptorA" register:
Bit(s)	Description	(Table 00915)
 31-24	"POTPGT" power-on to power-good time in 2ms units
 23-13	reserved
 12	"NOCP"	no over-current protection supported
 11	"OCPM"	over-current status reported per-port
 10	"DT"	device type - is root hub compound device?
 9	"NPS"	NoPowerSwitching -- ports are always powered up
 8	"PSM"	power-switching mode -- if set, each port powered individually
 7-0	"NDP"	number of downstream ports
SeeAlso: #00902,#00916,#00917

Bitfields for OpenHCI "HcRhDescriptorB" register:
Bit(s)	Description	(Table 00916)
 31-16	"PPCM"	PortPowerControlMask -- bitmask of ports NOT affected by global
		  power control (bit 16 [port #0] is reserved)
 15-0	"DR"	DeviceRemovable -- bitmap of removable devices
SeeAlso: #00902,#00915,#00917

Bitfields for OpenHCI "HcRhStatus" register:
Bit(s)	Description	(Table 00917)
 31	"CRWE"	Clear Remote Wakeup Enable
		write 1 to disable remote wakeup (writes of 0 ignored)
 30-18	reserved
 17	"OCIC"	OverCurrent Indicator Change
		write 1 to clear
 16   R	"LPSC"	Local Power Status Change
      W		Set Global Power mode (write 1; writes of 0 ignored)
 15	"DRWE"	Device Remote Wakeup Enable
		write 1 to enable (writes of 0 ignored)
		read to get current status
 14-2	reserved
 1	"OCI"	OverCurrent Indicator
 0    R "LPS"	LocalPowerStatus (always 0 for Root Hub)
      W		write 1 to turn off power to all ports/ports with clear
		  PortPowerControlMask bits
SeeAlso: #00902,#00915,#00916,#00918

Bitfields for OpenHCI "HcRhPortStatusN" register:
Bit(s)	Description	(Table 00918)
 31-21	reserved
 20	"PRSC"	Port Reset Status Change (write '1' to clear)
 19	"OCIC"	Port OverCurrent Indiactor Change (write '1' to clear)
 18	"PSSC"	Port Suspend Status Change (write '1' to clear)
 17	"PESC"	Port Enable Status Change (write '1' to clear)
 16	"CSC"	Connect Status Change (write '1' to clear)
 15-10	reserved
 9    R	"LSDA"	Low Speed Device Attached
      W		clear port power by writing '1'
 8    R	"PPS"	Port Power Status
      W		set port power by writing '1'
 7-5	reserved
 4    R	"PRS"	Port Reset Status
      W		set port reset by writing '1'
 3    R	"POCI"	Port OverCurrent Indicator
      W		clear suspend status by writing '1'
 2    R	"PSS"	Port Suspend Status
      W		set port suspend by writing '1'
 1    R "PES"	Port Enable Status
      W		set port enable by writing '1'
 0    R "CCS"	current connect status
      W		clear port enable by writing '1'
SeeAlso: #00902,#00915,#00916,#00917
--------X-1AB10ASF1004-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (VLSI devices)
	AX = B10Ah subfn 1004h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=8086h

Format of PCI Configuration Data for VLSI VL82C591 Host/PCI bridge:
Offset	Size	Description	(Table 00919)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1004h, device ID 0005h)
 40h	BYTE	bus number
 41h	BYTE	subordinate bus number
 42h	WORD	reserved
 44h  4 DWORDs	reserved
 54h  2 BYTEs	device-specific configuration registers
 56h	WORD	reserved
 58h  2 BYTEs	device-specific configuration registers
 5Ah	WORD	reserved
 5Ch  5 BYTEs	device-specific configuration registers
	...
 FFh	BYTE	device-specific configuration register
SeeAlso: #00878,#00732,#00920

Format of PCI Configuration data for VLSI VL82C593 PCI/ISA bridge:
Offset	Size	Description	(Table 00920)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1004, device ID 0006h)
 40h  4 DWORDs	reserved
 50h 11 BYTEs	device-specific configuration registers
 5Bh	BYTE	reserved
 5Ch 25 BYTEs	device-specific configuration registers
 75h 138 BYTEs	reserved
 FFh	BYTE	device-specific configuration register
SeeAlso: #00878,#00919
--------X-1AB10ASF100B-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (National Semicond. device)
	AX = B10Ah subfn 100Bh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=8086h

Format of National Semiconductor PC87410 EIDE Controller configuration:
Offset	Size	Description	(Table 00921)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 100Bh, device ID D001h)
 10h	DWORD	I/O base address for channel 0 control ports (def: 01F0h)
 14h	DWORD	I/O base address for channel 0 status port (def: 03F6h)
 18h	DWORD	I/O base address for channel 1 control ports (def: 0170h)
 1Ch	DWORD	I/O base address for channel 1 status port (def: 0376h)
 40h	BYTE	IDE Channel 0 timing control
 41h	WORD	IDE Channel 0 read-ahead counter (write-only except bit 15)
 43h	BYTE	IDE Channel 0 function
 44h	BYTE	IDE Channel 1 timing control
 45h	WORD	IDE Channel 1 read-ahead counter (write-only except bit 15)
 47h	BYTE	IDE Channel 1 function
 48h	BYTE	PCI control
 49h  7 BYTEs	unused
 50h 176 BYTEs	??? (unused?)
!!!http://www.national.com/ds/PC/PC87410.pdf p.7
SeeAlso: #00739,#00922

Format of National Semiconductor PC87415 IDE DMA-Master configuration:
Offset	Size	Description	(Table 00922)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 100Bh, device ID 0002h)
 40h  3 BYTEs	control register
 43h	BYTE	write buffer status (read-only)
 44h	BYTE	Channel 1 master read timing
 45h	BYTE	Channel 1 master write timing
 48h	BYTE	Channel 1 slave read timing
 49h	BYTE	Channel 1 slave write timing
 4Ch	BYTE	Channel 2 master read timing
 4Dh	BYTE	Channel 2 master write timing
 50h	BYTE	Channel 2 slave read timing
 51h	BYTE	Channel 2 slave write timing
 54h	BYTE	command and control block timing
 55h	BYTE	sector size
!!!http://www.national.com/ds/PC/PC87415.pdf p.8
SeeAlso: #00739,#00921
--------X-1AB10ASF1011-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (DEC device)
	AX = B10Ah subfn 1011h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=8086h

Format of DEC DC21140/DC21040/DC21041 Tulip {Fast/Plus} Ethernet:
Offset	Size	Description	(Table 00923)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1011h, device ID 0014h)
 10h	DWORD	base I/O port for access to control/status registers
 14h	DWORD	base memory address for access to control/status registers
 40h	DWORD	configuration driver area
		bit 31: sleep mode   \ only one of bits 31,30 may be set
		bit 30: snooze mode  /
		bits 15-8: device driver's use
!!!digital\21041hm.pdf p.34   digital\21140ahm.pdf p.35
SeeAlso: #00742

Format of DEC 21052 PCI-PCI bridge PCI configuration data:
Offset	Size	Description	(Table 00924)
 00h 64 BYTEs	header, type 1 (see #00878)
		(vendor ID 1011h, device ID 0021h)
 40h	BYTE	chip control
 41h	BYTE	diagnostic control
 42h	BYTE	burst counter
 43h	BYTE	SErr disable
 44h	BYTE	primary target wait timer
 45h	BYTE	secondary target wait timer
 46h  2 BYTEs	reserved
 48h	DWORD	count of secondary write attempts
 4Ch	DWORD	count of primary write attempts
 50h 44 DWORDs	reserved
!!!digital\21052ds.pdf p.117
SeeAlso: #00742
--------X-1AB10ASF1022-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (AMD devices)
	AX = B10Ah subfn 1022h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=1042h,AX=B10Ah/SF=8086h

Format of AMD Am53C974A PC-SCSI PCI configuration data:
Offset	Size	Description	(Table 00925)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1022h, device ID 2020h)
 10h	DWORD	I/O base address (see PORT xxxxh"Am53C974A")
 40h 16 BYTEs	scratch registers
		(used by AMD's PC-SCSI drivers as follows:
		    40h/41h  SCSI configuration register 0 (see #00926,#00927)
		    ...
		    4Eh/4Fh  SCSI configuration register 7)
SeeAlso: #00747

Bitfields for AMD Am53C974A Target Device Configuration Register:
Bit(s)	Description	(Table 00926)
 15-14	reserved
 13	"FSCSI" Fast SCSI drive is present
 12-8	"SPD" synchronous period
 7-4	synchronous offset (0 = asynchronous transfers)
 3-1	SCSI bus status
 0	target device is present and active
	if 0, all other bits must be cleared to zero for target devices
SeeAlso: #00925,#00927

Bitfields for AMD Am53C974A Host Configuration Register:
Bit(s)	Description	(Table 00927)
 15-9	reserved
 8	SCSI bus has been reset
 7	starting BIOS number (bits 6-4) is valid
 6-4	starting BIOS number (000 = BIOS drive 80h, 001 = drive 81h, etc)
 3	this device is a SCSI host
 2	protected-mode driver initialized
 1	real-mode driver initialized
 0	target device present
	=0 indicates that this is a host if bit 3 is set
SeeAlso: #00925,#00926
--------X-1AB10ASF1042-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (PC Technology devices)
	AX = B10Ah subfn 1042h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=1022h,AX=B10Ah/SF=1045h,AX=B10Ah/SF=8086h

Format of PCI Configuration data for PC Technology RZ-1000 EIDE controller:
Offset	Size	Description	(Table 00928)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1042h, device ID 1000h)
 10h	DWORD	base address for controller I/O registers
		(set to 01F1h for primary controller, 0171h for secondary)
 14h	DWORD	base address for controller digital I/O port
		(set to 03F5h for primary, 0375h for secondary)
 40h	DWORD	???
		bits 7-1: ???
		bit 13: read-ahead mode enabled
			(Read-Ahead is buggy on original RZ-1000, and is
			  thus typically disabled by clearing this bit)
		bit 16: ???
 44h	DWORD	???
 48h  8 BYTEs	???
 50h 176 BYTEs	unused???
--------X-1AB10ASF1045-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (OPTi devices)
	AX = B10Ah subfn 1045h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=1042h,AX=B10Ah/SF=1066h

Format of PCI Configuration data for OPTi 82C750 Vendetta (device 0):
Offset	Size	Description	(Table 00929)
 00h 64	BYTEs	header (see #00878)
		(vendor ID 1045h, device ID C567h)
 40h	DWORD	memory control (see #00930)
 44h  6	BYTEs	data path control (see #00931)
 4Ah	WORD	reserved
 4Ch	BYTE	SDRAM SDRAS/SDCAS mux control (see #00932)
 4Dh	BYTE	SDRAM select (see #00933)
 4Eh	BYTE	ECC test / I2C control (see #00934)
 4Fh	BYTE	ECC test data
 50h	DWORD	ECC control (see #00935)
 54h	WORD	SDRAM select (see #00936)
 56h	BYTE	data path control / EDO X-2-2-2 writes (see #00937)
 57h	BYTE	reserved
 58h	DWORD	ECC reporting (see #00938)
 5Ch 164 BYTEs	reserved
SeeAlso: #00878,#00939,#00965

Bitfields for OPTi 82C750 Vendetta (device 0) memory control:
Bit(s)	Description	(Table 00930)
 31-30	reserved
 29	reserved (1)
 28-18	reserved
 17	reserved (1)
 16	HA drive-back during CPU memory access enable
 15-6	PCI video frame buffer write posting hole
 5-4	reserved
 3	PCI bus write post disable
 2	video frame buffer write post (posting enabled if bit 2 = bit 3)
 1	video memory write post(posting enabled if bit 1 = bit 3)
 0	I/O cycle write post enable
SeeAlso: #00929,#00931

Bitfields for OPTi 82C750 Vendetta (device 0) data path control:
Bit(s)	Description	(Table 00931)
 41-47	reserved
 40	DTY pin suspend enable
 39-38	reserved
 37	SDRAM refresh 0 sized bank RAS# disable
 36	SDRAM control signal stepping enable
 35	reserved
 34-32	SDRAM mode
	000 = normal
	001 = NOP enable
	010 = precharge all banks
	011 = mode register enable
	100 = CBR cycle enable
	101-111 = reserved
 31	SDRAM memory read access enable
 30	CPU-to-PCI FIFO clear enable
 29	PCI-to-DRAM FIFO clear enable
 28	CPU-to-DRAM FIFO clear enable
 27	82C750 register write disable
 26-15	reserved
 14	PCI master/ECC generate NMI disable
 13-12	reserved (1)
 11	memory parity checking enable
 10	reserved
 9	CPU DRAM write byte merge enable
 8	MD bus pull-up resistor disable
 7	PCI CPU write 6DW FIFO enable
 6	DRAM PCI read 24DW FIFO enable
 5	DRAM PCI write 24DW FIFO enable
 4	DRAM CPU write 8QW FIFO enable
 3	82C750 memory read access (0 = SDRAM, 1 = reserved)
 2-1	reserved
 0	82C750 memory read access (0 = FP mode, 1 = EDO/SDRAM)
SeeAlso: #00929

Bitfields for OPTi 82C750 Vendetta (device 0) SDRAM SDRAS/SDCAS mux control:
Bit(s)	Description	(Table 00932)
 7	MCACHE enable
 6	GWE#/BWE# (1)
 5	reserved (read-only)
 4	reserved (1)
 3	BOFF# CPU status latch enable
 2	reserved (1) (SDRAS# & SDCAS#)
 1	reserved (1) (BA1 & BA0)
 0	pin mux
	0 = RAS4# & RAS5#
	1 = SDRAS# & SDCAS#
SeeAlso: #00929

Bitfields for OPTi 82C750 Vendetta (device 0) SDRAM select:
Bit(s)	Description	(Table 00933)
 7-6	reserved
 5	bank 5 enable
 4	bank 4 enable
 3-0	reserved
SeeAlso: #00929

Bitfields for OPTi 82C750 Vendetta (device 0) ECC test / I2C control:
Bit(s)	Description	(Table 00934)
 7	ECC test mode enable
 6	reserved
 5	reserved (1 if SDRAM enabled)
 4	I2C data output read-back (read-only)
 3	I2C clock output read-back (read-only)
 2	I2C data output (refer to file I2C.LST for more details)
 1	I2C clock output
 0	I2C control enable
SeeAlso: #00929,I2C A0h,#00935

Bitfields for OPTi 82C750 Vendetta (device 0) ECC control:
Bit(s)	Description	(Table 00935)
 31-13	upper 19 bits of error address
 12-5	syndrome byte for reported error
 4	non-correctable error
 3	single-bit error
 2	nibble error
 1	ECC error report enable
 0	ECC data path enable
SeeAlso: #00929,#00934

Bitfields for OPTi 82C750 Vendetta (device 0) SDRAM select:
Bit(s)	Description	(Table 00936)
 15	SDWE# stepping enable
 14	reserved (1) (SDRAM)
 13-12	reserved
 11-6	bank 5-0 SDRAM technology
	0 = 16 Mb
	1 = 64 Mb
 5-0	bank 5-0 SDRAM timing
	0 = leadoff 7/6
	1 = leadoff 8/7
SeeAlso: #00929

Bitfields for OPTi 82C750 Vendetta (device 0) data path control / EDO X-2-2-2:
Bit(s)	Description	(Table 00937)
 7	CPU-to-DRAM FIFO enable
 6	1 CLK CAS enable
 5-0	RAS5#-RAS0# X-2-2-2 write enable
	(CPU-to-DRAM FIFO, DRAM write post, and cache readaround write must
	  be enabled)
SeeAlso: #00929

Bitfields for OPTi 82C750 Vendetta (device 0) ECC reporting:
Bit(s)	Description	(Table 00938)
 31-26	reserved
 25-16	single-bit error counter
 15	reserved
 14	delayed write enable
 13-4	single-bit error limit
 3	correctable error reporting (0 = NMI, 1 = SMI)
 2	single-bit error counter enable (disabling resets counter)
 1	error reporting method (0 = NMI, 1 = SMI)
 0	NMI/SMI generate disable
SeeAlso: #00929

Format of PCI Configuration data for OPTi 82C750 Vendetta (device 1):
Offset	Size	Description	(Table 00939)
 00h 64	BYTEs	header (see #00824)
		(vendor ID 1045h, device ID C568h)
 40h	WORD	keyboard control (see #00940)
 42h	WORD	interrupt control (see #00941)
 44h	BYTE	pin functionality 1 (see #00942)
 45h	BYTE	reserved
 46h	WORD	cycle control (see #00943)
 48h	WORD	pin functionality 2 (see #00944)
 4Ah	WORD	ROMCS# range control (see #00945)
 4Ch	BYTE	miscellaneous control 1 (see #00946)
 4Dh	BYTE	reserved
 4Eh	BYTE	miscellaneous control 2 (see #00947)
 4Fh	BYTE	miscellaneous control 3 (see #00948)
 50h	WORD	interrupt trigger control (see #00949)
 52h	WORD	interrupt multiplexing control (see #00950)
 54h	WORD	PCI master control (see #00951)
 56h	WORD	serial interrupt source (see #00952)
 58h	BYTE	serial interrupt mode control (see #00953)
 59h	BYTE	pin functionality 3 (see #00954)
 5Ah	WORD	distributed DMA master base address
 5Ch	BYTE	distributed DMA control (see #00955)
 5Dh  3	BYTEs	reserved
 60h	BYTE	USB interrupt control register (see #00956)
 61h	BYTE	PCI reset control (see #00957)
 62h	BYTE	emulation control (see #00958)
 63h	BYTE	PCI retry control (see #00959)
 64h 153 BYTEs	reserved
 FDh	BYTE	SMI control
 FEh	BYTE	stop grant cycle control
 FFh	BYTE	host memory parity error
SeeAlso: #00878,#00929,#00965

Bitfields for OPTi 82C750 Vendetta (device 1) keyboard control:
Bit(s)	Description	(Table 00940)
 15	keyboard port read (read-only)
 14	keyboard port write (read-only)
 13	keyboard RESET CPUINIT
	0 = generate immediately
	1 = wait for halt
 12	keyboard emulation disable
 11-9	PIRQ3# IRQ generation
	000 = use interrupt trigger control register (offset 50h)
	001 = IRQ5
	010-101 = IRQ9-IRQ12
	110-111 = IRQ14-IRQ15
 8-6	PIRQ2# IRQ generation
 5-3	PIRQ1# IRQ generation
 2-0	PIRQ0# IRQ generation
SeeAlso: #00939,#00941

Bitfields for OPTi 82C750 Vendetta (device 1) interrupt control:
Bit(s)	Description	(Table 00941)
 15	ISA IRQ14 blocking enable
 14	ISA IRQ15 blocking enable
 13	DMA/ISA master to preempt PCI master enable
 12	PCI priority is fixed instead of rotating
 11-10	back-to-back ISA I/O delay 
	00 = 3 ATCLKs
	01 = 12 ATCLKs
	10 = no delay
	11 = delay all by 12 ATCLKs
 9	PCI master ISA device access disable
 8	ISA bus control signals for memory access >16M and I/O access >64K
	  disable
 7-6	IRQ15-IRQ14 triggering (0 = edge, 1 = level)
 5-2	IRQ12-IRQ9 triggering (0 = edge, 1 = level)
 1	IRQ 5 triggering (0 = edge, 1 = level)
 0	pin AE16 functionality
	0 = DREQ6
	1 = EPMI0#
SeeAlso: #00939,#00940

Bitfields for OPTi 82C750 Vendetta (device 1) pin functionality 1:
Bit(s)	Description	(Table 00942)
 7-6	pin AC15 functionality
	00-01 = controlled by bits 1-0
	10 = DACK7#
	11 = reserved
 5-4	pin AE15 functionality
	00-01 = controlled by bits 1-0
	10 = DACK6#
	11 = reserved
 3-2	pin AF15 functionality
	00-01 = controlled by bits 1-0
	10 = DACK5#
	11 = reserved
 1-0	DACK group-wise programmable pin functionalities
	00 = DACK3#-DACK0#
	01 = DACK7#-DACK5#, DACK3#, DACK1#, DACK0#
	10 = reserved
	11 = EDACK2#-EDACK0#, EDACKEN#, PIRQ3#, PIRQ2#
SeeAlso: #00939

Bitfields for OPTi 82C750 Vendetta (device 1) cycle control:
Bit(s)	Description	(Table 00943)
 15	ISA bus ROM write enable
 14	hidden refresh enable
 13-12	ATCLK select
	00 = LCLK/4
	01 = LCLK/3
	10 = LCLK/2
	11 = LCLK
 11	CPU master to PCI slave write
	0 = 1 LCLK
	1 = 0 LCLK
 10-8	PCI master to PCI master preempt timer
	000 = no preempt
	001 = 260 LCLKs
	010 = 132 LCLKs
	011 = 68 LCLKs
	100 = 36 LCLKs
	101 = 20 LCLKs
	110 = 12 LCLKs
	111 = 5 LCLKs
 7	reserved
 6	XDIR achieve
	0 = accessing ROM, keyboard controller, RTC
	1 = accessing ROM, NVRAM
 5	PERR# to SERR# conversion enable
 4	address parity checking enable
 3	target abort SERR# generation enable
 2	fast back-to-back enable
 1	sample point decoding
	0 = slow
	1 = subtractive
 0	reserved
SeeAlso: #00939

Bitfields for OPTi 82C750 Vendetta (device 1) pin functionality 2:
Bit(s)	Description	(Table 00944)
 15	pin AF18 functionality (0 = IRQ15, 1 = reserved)
 14-13	pin AE19 functionality (00-01 = IRQ12, 10-11 = reserved)
 12	pin AD20 functionality (0 = IRQ10, 1 = MIRQ10/12)
 11	pin AE21 functionality (0 = IRQ6, 1 = reserved)
 10	pin AD22 functionality (0 = IRQ4, 1 = MIRQ4/6)
 9-8	pin AD16 functionality (00 = DREQ7, 01 = EPMI3#, 1x = reserved)
 7-6	pin AD17 functionality
	00 = DREQ3
	01 = DREQ3/7
	10 = DREQ7
	11 = reserved
 5-4	pin AD18 functionality
	00 = DREQ1
	01 = DREQ1/6
	10 = DREQ6
	11 = reserved
 3-2	pin AE18 functionality
	00 = DREQ0
	01 = DREQ0/5
	10 = DREQ5
	11 = reserved
 1-0	pin T23 functionality (0x = PREQ1#, 1x = reserved)
SeeAlso: #00939

Bitfields for OPTi 82C750 Vendetta (device 1) ROMCS# range control:
Bit(s)	Description	(Table 00945)
 15	FFFF8000h-FFFFFFFFh ROMCS# disable
 14	FFFF0000h-FFFF7FFFh ROMCS# disable
 13	FFFE8000h-FFFEFFFFh ROMCS# enable
 12	FFFE0000h-FFFE7FFFh ROMCS# enable
 11	FFFD8000h-FFFDFFFFh ROMCS# enable
 10	FFFD0000h-FFFD7FFFh ROMCS# enable
 9	FFFC8000h-FFFCFFFFh ROMCS# enable
 8	FFFC0000h-FFFC7FFFh ROMCS# enable
 7	F8000h-FFFFFh ROMCS# disable
 6	F0000h-F7FFFh ROMCS# disable
 5	E8000h-EFFFFh ROMCS# enable
 4	E0000h-E7FFFh ROMCS# enable
 3	D8000h-DFFFFh ROMCS# enable
 2	D0000h-D7FFFh ROMCS# enable
 1	C8000h-CFFFFh ROMCS# enable
 0	C0000h-C7FFFh ROMCS# enable
SeeAlso: #00939

Bitfields for OPTi 82C750 Vendetta (device 1) miscellaneous control 1:
Bit(s)	Description	(Table 00946)
 7-5	reserved
 4	game port/MPU-401 enable
 3	PREQ4#/PGNT4# mux (0 = SDA2/GP3, 1 = PREQ4#/PGNT4#)
 2	DACK5# 1-to-0 transition enable
 1-0	reserved
SeeAlso: #00939,#00947,#00948

Bitfields for OPTi 82C750 Vendetta (device 1) miscellaneous control 2:
Bit(s)	Description	(Table 00947)
 7-4	reserved
 3	pipeline byte merge enable
 2	EOP configuration (0 = output, 1 = input)
 1	byte merge enable
 0	ISA master data swap disable
SeeAlso: #00939,#00946,#00948

Bitfields for OPTi 82C750 Vendetta (device 1) miscellaneous control 3:
Bit(s)	Description	(Table 00948)
 7	pin AB15 functionality
	0 = DACK5#
	1 = PPWRL+PPWRL2
 6	IDE functionality support enable
 5	reserved (read-only)
 4	ISA bus AT command 1 wait state extension disable
 3-2	reserved
 1	pin AE14 functionality
	0 = controlled by offset 44h bits 1-0
	1 = GPCS2#
 0	reserved
SeeAlso: #00939,#00946,#00947

Bitfields for OPTi 82C750 Vendetta (device 1) interrupt trigger control:
Bit(s)	Description	(Table 00949)
 15	reserved (1)
 14	reserved
 13	pin AD15 functionality (0 = DACK2#, 1 = GPCS2#)
 12-11	reserved
 10	IRQ3 triggering (0 = edge, 1 = level)
 9	IRQ4 triggering (0 = edge, 1 = level)
 8	IRQ7 triggering (0 = edge, 1 = level)
 7-6	IRQ generation when PIRQ3# triggered
	00 = disable
	01 = IRQ3
	10 = IRQ4
	11 = IRQ7
 5-4	IRQ generation when PIRQ2# triggered
	00 = disable
	01 = IRQ3
	10 = IRQ4
	11 = IRQ7
 3-2	IRQ generation when PIRQ1# triggered
	00 = disable
	01 = IRQ3
	10 = IRQ4
	11 = IRQ7
 1-0	IRQ generation when PIRQ0# triggered
	00 = disable
	01 = IRQ3
	10 = IRQ4
	11 = IRQ7
SeeAlso: #00939,#00950

Bitfields for OPTi 82C750 Vendetta (device 1) interrupt multiplexing control:
Bit(s)	Description	(Table 00950)
 15	pin functionality
	0 = AE22:IRQ3, AF21:IRQ5, AE21:IRQ6, AD21:IRQ7, AE20:IRQ9, AF19:IRQ11
	1 = AE22:MIRQ3/5, AF21:MIRQ7/9, AE21:MIRQ11/15, 
	    AD21:EPMI1#, AE20:EPMI2#, AF19:GMIRQ
 14	pin R22 functionality (0 = PREQ2#, 1 = EPMI0#)
 13	IRQ1 latching enable
 12	IRQ12 latching enable
 11	DACKEN# status (0 = active low, 1 = active high)
 10	system bus owned by external device
 9	flash ROM locking enable
 8	reserved
 7	IRQ6 triggering (0 = edge, 1 = level)
 6-3	IRQ generation when GMIRQ triggered
	0000 = disabled
	0001-0010 = reserved
	0011-0111 = IRQ3-IRQ7
	1000 = reserved
	1001-1100 = IRQ9-IRQ12
	1101 = reserved
	1110-1111 = IRQ14-IRQ15
 2	reserved (1)
 1	priority scheme enable
 0	concurrent refresh and IDE cycle enable
SeeAlso: #00939,#00949

Bitfields for OPTi 82C750 Vendetta (device 1) PCI master control:
Bit(s)	Description	(Table 00951)
 15-12	reserved
 11	interrupt request register recover enable
 10	DMA address and counter (0 = current, 1 = base)
 9	CPU/PCI master access ISA cycle retry enable
 8	CPU-to-PCI cycle AHOLD signal use enable
	(used only when bit 4 = 1)
 7	PCI master X-1-1-1 write enable
 6	PCI master X-1-1-1 read enable
 5	concurrent PCI master/IDE enable
 4	new AHOLD protocol enable
 3	PCI master non-contiguous byte enable
 2	reserved
 1	simultaneous hardware PMU and IDE function operation enable
 0	ISA refresh disable
SeeAlso: #00939

Bitfields for OPTi 82C750 Vendetta (device 1) serial interrupt source:
Bit(s)	Description	(Table 00952)
 15-3	IRQ15-IRQ3 interrupt resource (0 = ISA, 1 = serial interrupt)
 2	SMI#, IOCHK#, PCIRQ3#-PCIRQ0# interrupt resource
	0 = ISA
	1 = serial interrupt
 1-0	IRQ1-IRQ0 interrupt resource (0 = ISA, 1 = serial interrupt)
SeeAlso: #00939,#00953

Bitfields for OPTi 82C750 Vendetta (device 1) serial interrupt mode control:
Bit(s)	Description	(Table 00953)
 7-6	serial interrupt control mode
	00 = continuous
	01 = idle
	1x = active
 5	reserved
 4	data frame slot support
	0 = 17 slots (IRQ15-IRQ3, IRQ1-IRQ0, SMI#, IOCHK#)
	1 = 21 slots (IRQ15-IRQ3, IRQ1-IRQ0, SMI#, IOCHK#, PCIRQ3#-PCIRQ0#)
 3-2	CPU access PCI priority
	00 = lowest
	01 = higher after 4 PCI master grants
	10 = higher after 2 PCI master grants
	11 = higher after 3 PCI master grants
 1-0	serial interrupt start frame pulse width in continuous/active mode
	00 = 4/3 CLK
	01 = 6/5 CLK
	10 = 8/7 CLK
	11 = reserved
SeeAlso: #00939,#00952

Bitfields for OPTi 82C750 Vendetta (device 1) pin functionality 3:
Bit(s)	Description	(Table 00954)
 7	PCI arbitration time-out mode enable
 6	0 wait state for CPU I/O access enable
 5	SMI output disable
 4	CPU request for PCI bus (0 = enabled, 1 = reserved)
 3	reserved
 2	refresh preemption disable
 1-0	reserved
SeeAlso: #00939

Bitfields for OPTi 82C750 Vendetta (device 1) distributed DMA control:
Bit(s)	Description	(Table 00955)
 7-5	channel 7-5 enable
 4-1	channel 3-0 enable
 0	DDMA enable
SeeAlso: #00939

Bitfields for OPTi 82C750 Vendetta (device 1) USB interrupt control register:
Bit(s)	Description	(Table 00956)
 7	reserved
 6-5	buffered DMA control
	00 = original DMA with old protocol
	01 = reserved
	10 = original DMA with PCI master capability
	11 = buffered DMA enable
 4	reserved
 3-0	IRQ generation when USBIRQ triggered
	0000 = disabled
	0001-0010 = reserved
	0011-0111 = IRQ3-IRQ7
	1000 = reserved
	1001-1100 = IRQ9-IRQ12
	1101 = reserved
	1110-1111 = IRQ14-IRQ15
SeeAlso: #00939

Bitfields for OPTi 82C750 Vendetta (device 1) PCI reset control:
Bit(s)	Description	(Table 00957)
 7	PCI soft reset generate enable
 6	PCI slave demand mode buffered DMA retry fix enable
 5	IORDY# PCI master delay fix enable
 4	ISA command deassertion IOCHRDY delay
	0 = <1 ATCLK
	1 = >=1 ATCLK
 3-2	buffered DMA fix (00 = disable, 11 = enable)
 1	reserved
 0	ISA master synchronization (1)
SeeAlso: #00939

Bitfields for OPTi 82C750 Vendetta (device 1) emulation control:
Bit(s)	Description	(Table 00958)
 7	PCIRST# disable
 6	SDA2 muxed with XDIR	(0 = XDIR, 1 = SDA2)
 5	SPKR muxed with MIDI1	(0 = MIDI1, 1 = SPKR)
 4	audio mux		(0 = MP7-MP0, DACK)
 3	audio module enable
 2	ATA-33 IDE pin mux scheme (0 = old, 1 = new)
 1	REFRESH priority	(0 = high, 1 = lowest)
 0	port 92h emulation disable
SeeAlso: #00939,PORT 0092h

Bitfields for OPTi 82C750 Vendetta (device 1) PCI retry control:
Bit(s)	Description	(Table 00959)
 7-2	reserved
 1	reserved (1)
 0	ISA slave PCI master retry
	0 = no change
	1 = generate BOFF#
SeeAlso: #00939

Format of PCI Configuration data for OPTi 82C750 Vendetta (IDE controller):
Offset	Size	Description	(Table 00960)
 00h 64	BYTEs	header (see #00824)
		(vendor ID 1045h, device ID C621h)
 40h	BYTE	IDE initialization control (see #00961)
 41h	BYTE	reserved
 42h	BYTE	IDE enhanced feature (see #00962)
 43h	BYTE	IDE enhanced mode (see #00963)
 44h	WORD	ultra DMA mode select (see #00964)
 46h 186 BYTEs	reserved

Bitfields for OPTi 82C750 Vendetta (IDE Controller) IDE initialization control:
Bit(s)	Description	(Table 00961)
 7-6	bus master IDE PCI bus request when FIFO filled with
	00 = 32 bytes (early request disabled)
	01 = 30 bytes
	10 = 28 bytes
	11 = 26 bytes
 5	reserved (1)
 4	reserved
 3	secondary IDE disable
 2	I/O addresses relocatable
 1-0	IDE device default cycle time
	00 = >=600ns (PIO mode 0)
	01 = >=383ns (PIO mode 2)
	10 = >=240ns (PIO mode 1)
	11 = >=180ns (PIO mode 3)
SeeAlso: #00960

Bitfields for OPTi 82C750 Vendetta (IDE Controller) IDE enhanced feature:
Bit(s)	Description	(Table 00962)
 7	reserved
 6	IDE write concurrency enable
 5	slave IDE FIFO to ISA bus preemption disable
 4	IDE arbiter PCI/IDE concurrency support enable
 3	PCI memory commands enable
 2	PCI master IDE and IDE cycle concurrency enable
 1	PCI master X-1-1-1 MIDE enable
 0	reserved
SeeAlso: #00960,#00963

Bitfields for OPTi 82C750 Vendetta (IDE Controller) IDE enhanced mode:
Bit(s)	Description	(Table 00963)
 7-6	secondary IDE drive 1 enhanced mode
	00 = disabled
	01 = command recovery in 1 LCLK
	10 = command recovery in 0 LCLK
	11 = reserved
 5-4	secondary IDE drive 0 enhanced mode
	00 = disabled
	01 = command recovery in 1 LCLK
	10 = command recovery in 0 LCLK
	11 = reserved
 3-2	primary IDE drive 1 enhanced mode
	00 = disabled
	01 = command recovery in 1 LCLK
	10 = command recovery in 0 LCLK
	11 = reserved
 1-0	primary IDE drive 0 enhanced mode
	00 = disabled
	01 = command recovery in 1 LCLK
	10 = command recovery in 0 LCLK
	11 = reserved
SeeAlso: #00960,#00963

Bitfields for OPTi 82C750 Vendetta (IDE Controller) ultra DMA mode select:
Bit(s)	Description	(Table 00964)
 15	primary IDE disable
 14-12	reserved
 11-10	secondary IDE drive 1 ultra DMA mode
	00 = mode 0
	01 = mode 1
	10 = mode 2
	11 = reserved
 9-8	secondary IDE drive 0 ultra DMA mode (same values as bits 11-10)
 7-6	primary IDE drive 1 ultra DMA mode (same values as bits 11-10)
 5-4	primary IDE drive 0 ultra DMA mode (same values as bits 11-10)
 3	secondary IDE drive 1 ultra DMA 33 enable
 2	secondary IDE drive 0 ultra DMA 33 enable
 1	primary IDE drive 1 ultra DMA 33 enable
 0	primary IDE drive 0 ultra DMA 33 enable
SeeAlso: #00960

Format of PCI Configuration data for OPTi 82C861/82C871 PCI-to-USB Bus Bridge:
Offset	Size	Description	(Table 00965)
 00h 64	BYTEs	header (see #00878)
		(vendor ID 1045h, device ID C861h)
 40h  4 BYTEs	reserved for testing
 44h 10 BYTEs	reserved
 4Eh	BYTE	I2C control
		bits 7-5: reserved
		bit 4: I2C data output read-back (read-only)
		bit 3: I2C clock output read-back (read-only)
		bit 2: I2C data output
		bit 1: I2C clock output
		bit 0: I2C control enable
 4Fh	BYTE	reserved
 50h	BYTE	PCI host feature control
		bits 7-4: reserved
		bit 3: subsystem vendor ID register write disable
		bit 2: CLKRUN# enable
		bit 1: port 2 output disable
		bit 0: port 1 output disable
 51h	BYTE	interrupt assignment
		bit 7: host controller type 
		    0 = Viper-N+ (send 1 data phase on IRQ driveback)
		    1 = FireStar (send 2 data phases on IRQ driveback)
		bit 6: IRQ driveback enable
		bit 5: reserved
		bits 4-0: interrupt assignment
		    00000 = disabled
		    00001 = PCIRQ0# (default) to 00100 = PCIRQ3#,
		    00101 = ACPI0 to 01111 = ACPI10
		    10000 = IRQ0 to 11111 = IRQ15
 52h  2 BYTEs	reserved
 54h	DWORD	IRQ driveback address
		bits 1-0: reserved to 00 (read-only)
 58h 20 BYTEs	reserved
 6Ch	DWORD	reserved (test mode enable)
SeeAlso: #00878,#00929,#00939

Format of OPTi FireLink/FireBlast Host Controller memory-mapped registers:
Offset	Size	Description	(Table 00966)
 00h 256 BYTES	standard OpenHCI registers (see #00902)
100h	DWORD	"HceControl"	emulation control (see #00967)
104h	DWORD	"HceInput"	legacy Input Buffer (see #00968)
108h	DWORD	"HceOutput"	legacy Output Buffer (see #00969)
10Ch	DWORD	"HceStatus"	legacy Status (see #00970)
SeeAlso: #00902,#00965

Bitfields for OPTi FireLink/FireBlast "HceControl" register:
Bit(s)	Description	(Table 00967)
 31-9	reserved
 8	A20 gate state
 7	IRQ12 active (write 1 to clear)
 6	IRQ1 active (write 1 to clear)
 5	A20 gate sequence
	1  D1h written to port 64h
	0  other than D1h written to port 64h
 4	external IRQ emulation enable
 3	IRQ enable
 2	character pending emulation enable
 1	(read-only) emulation interrupt condition
 0	emulation enable
SeeAlso: #00902,PORT 0064h

Bitfields for OPTi FireLink/FireBlast "HceInput" register:
Bit(s)	Description	(Table 00968)
 31-8	reserved
 7-0	data written to port 60h or 64h
SeeAlso: #00902,#00970,PORT 0060h,PORT 0064h

Bitfields for OPTi FireLink/FireBlast "HceOutput" register:
Bit(s)	Description	(Table 00969)
 31-8	reserved
 7-0	data to be returned on read of port 60h
SeeAlso: #00902,PORT 0060h

Bitfields for OPTi FireLink/FireBlast "HceStatus" register:
Bit(s)	Description	(Table 00970)
 31-8	reserved
 7	parity error
 6	time-out
 5	aux output full enable
 4	keyboard inhibit switch state
	0  inhibited
	1  not inhibited
 3	data written to port:
	0  port 60h
	1  port 64h
 2	warm/cold boot flag
 1	input full
 0	output full
SeeAlso: #00902,PORT 0060h,PORT 0064h
--------X-1AB10ASF1066-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (PicoPower devices)
	AX = B10Ah subfn 1066h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=8086h

Format of PicoPower Vesuvius V3-LS ISA Bridge configuration:
Offset	Size	Description	(Table 00971)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1066h, device ID 0002h or 8002h)
 40h	WORD	distributed DMA control register (see #00972)
 42h	BYTE	distributed DMA status register (see #00973)
 44h	DWORD	slave DMAC CH0 base register (see #00974)
 48h	DWORD	slave DMAC CH1 base register (see #00974)
 4Ch	DWORD	slave DMAC CH2 base register (see #00974)
 50h	DWORD	slave DMAC CH3 base register (see #00974)
 54h	DWORD	slave DMAC CH5 base register (see #00974)
 58h	DWORD	slave DMAC CH6 base register (see #00974)
 5Ch	DWORD	slave DMAC CH7 base register (see #00974)
 90h	DWORD	PCI-to-ISA bridge configuration register (see #00975)
 94h	DWORD	ISA memory address positive decode (see #00976)
 98h	DWORD	I/O address positive decode (see #00977)
 9Ch	WORD	I/O configuration address register (see #00978)
 A0h	DWORD	programmable ISA I/O address decoder (see #00979)
 A4h  6 DWORD	programmable ISA range decoder registers 1-6 (see #00980)
 C0h 64 BYTEs	reserved
SeeAlso: #00773

Bitfields for PicoPower Vesuvius V3-LS distributed DMA control register:
Bit(s)	Description	(Table 00972)
 15-6	reserved
 5	(revision BB & later) secondary slave floppy disk distributed access
	  enable (if bit 1 = 0)
 4	(revision BB & later) secondary slave hard disk distributed access
	  enable (if bit 1 = 0)
 3	slave floppy drive port distributed access enable (if bit 1 = 0)
 2	slave hard drive port distributed access enable (if bit 1 = 0)
 1	distributed DMA mode
	0 = master
	1 = slave
 0	distributed DMA function enable
SeeAlso: #00971

Bitfields for PicoPower Vesuvius V3-LS distributed DMA status register:
Bit(s)	Description	(Table 00973)
 7-1	reserved
 0	DDMA status (write 1 to clear)
SeeAlso: #00971

Bitfields for PicoPower Vesuvius V3-LS slave DMAC CH0-7 base register:
Bit(s)	Description	(Table 00974)
 31-16	reserved (0)
 15-7	channel base address
 6-4	channel base address (hardwired to channel number)
 3	extended address (0)
 2-1	size (00 for channel 0-3, 01 for channel 5-7)
 0	channel enable
SeeAlso: #00971

Bitfields for PicoPower Vesuvius V3-LS PCI-to-ISA bridge configuration:
Bit(s)	Description	(Table 00975)
 31-15	reserved
 14	AD/SD/SA bus staggering enable
 13	ISA bridge PCI positive decode enable
 12	ISA bridge PCI subtractive decode disable
 11-10	reserved
 9	retry enable
 8	lock input enable
 7	SERR#/NMI status flag (write 1 to clear)
 6	PERR#/NMI status flag (write 1 to clear)
 5	SERR# triggers NMI enable
 4	PERR# triggers NMI enable
 3	reserved
 2-0	(revision BB and later) system configuration setting
SeeAlso: #00971

Bitfields for PicoPower Vesuvius V3-LS ISA memory address positive decode:
Bit(s)	Description	(Table 00976)
 31-9	reserved
 8	ISA memory A0000h-AFFFFh and FFA0000h-FFFAFFFFh decode enable
 7	ISA memory B0000h-BFFFFh and FFB0000h-FFFBFFFFh decode enable
 6	ISA memory C0000h-C7FFFh and FFC0000h-FFFC7FFFh decode enable
 5	ISA memory C8000h-CFFFFh and FFC8000h-FFFCFFFFh decode enable
 4	ISA memory D0000h-D7FFFh and FFD0000h-FFFD7FFFh decode enable
 3	ISA memory D8000h-DFFFFh and FFD8000h-FFFDFFFFh decode enable
 2	ISA memory E0000h-E7FFFh and FFE0000h-FFFE7FFFh decode enable
 1	ISA memory E8000h-EFFFFh and FFE8000h-FFFEFFFFh decode enable
 0	ISA memory F0000h-FFFFFh and FFF0000h-FFFFFFFFh decode enable
SeeAlso: #00971

Bitfields for PicoPower Vesuvius V3-LS I/O address positive decode:
Bit(s)	Description	(Table 00977)
 31-24	reserved
 23	(revision BB and later) I/O read 377h decode enable
 22	(revision BB and later) I/O read 3F7h decode enable
 21	PC NET (360h-36Fh) decode enable
 20	audio 5 (388h-38Bh) decode enable
 19	audio 4 (250h-25Fh) decode enable
 18	audio 3 (240h-24Fh) decode enable
 17	audio 2 (230h-23Fh) decode enable
 16	audio 1 (220h-22Fh) decode enable
 15	audio 0 (201h) decode enable
 14	(revision BB and later) ISA secondary floppy (370h-375h, 377h write)
	  decode enable
 13	(revision BB and later) ISA primary floppy (3F0h-3F5h, 3F7h write)
	  decode enable
 12	(revision BB and later) ISA secondary IDE (170h-177h, 376h) decode
	  enable
 11	(revision BB and later) ISA primary IDE (1F0h-1F7h, 3F6h) decode enable
 10	ISA LPT3 (3BCh-3BFh, 7BCh-7BEh) decode enable
 9	ISA LPT2 (278h-27Fh, 678h-67Ah) decode enable
 8	ISA LPT1 (378h-37Fh, 778h-77Ah) decode enable
 7	ISA COM4 (2E8h-2EFh) decode enable
 6	ISA COM3 (3E8h-3EFh) decode enable
 5	ISA COM2 (2F8h-2FFh) decode enable
 4	ISA COM1 (3F8h-3FFh) decode enable
 3	ISA system I/O (00h-FFh) decode enable
 2	configuration (24h/26h) decode enable
 1-0	reserved
SeeAlso: #00971

Bitfields for PicoPower Vesuvius V3-LS I/O configuration address register:
Bit(s)	Description	(Table 00978)
 15-10	reserved
 9-1	configuration I/O address
 0	configuration address register enable
SeeAlso: #00971

Bitfields for PicoPower Vesuvius V3-LS programmable ISA I/O address decoder:
Bit(s)	Description	(Table 00979)
 31-18	reserved
 17	ISA range decoder 6 read enable
 16	ISA range decoder 6 write enable
 15	ISA range decoder 6 type
	0 = memory
	1 = I/O
 14	ISA range decoder 5 read enable
 13	ISA range decoder 5 write enable
 12	ISA range decoder 5 type (same values as bit 15)
 11	ISA range decoder 4 read enable
 10	ISA range decoder 4 write enable
 9	ISA range decoder 4 type (same values as bit 15)
 8	ISA range decoder 3 read enable
 7	ISA range decoder 3 write enable
 6	ISA range decoder 3 type (same values as bit 15)
 5	ISA range decoder 2 read enable
 4	ISA range decoder 2 write enable
 3	ISA range decoder 2 type (same values as bit 15)
 2	ISA range decoder 1 read enable
 1	ISA range decoder 1 write enable
 0	ISA range decoder 1 type (same values as bit 15)
SeeAlso: #00971

Bitfields for PicoPower Vesuvius V3-LS programmable ISA range decoder 1:
Bit(s)	Description	(Table 00980)
 31-16	ISA address compare
 15-0	ISA device address (memory address bits 23-8, I/O address bits 15-0)
SeeAlso: #00971
--------X-1AB10ASF1066-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (Brooktree devices)
	AX = B10Ah subfn 1066h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=8086h

Format of Brooktree Bt8230 ATM controller configuration:
Offset	Size	Description	(Table 00981)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 109Eh, device ID 8230h)
 10h	DWORD	address at which to map external memory (multiple of 16M)
		internal registers are mapped at offsets 0000h-01FFh; Bt8222
		  registers are mapped at 0200h-03FFh, and T1/E1 Framer
		  registers are mapped at 0800h-0FFFh.	Only 32-bit memory
		  accesses are used
 40h	BYTE	maximum burst length (00h not allowed, default = 10h)
 41h	BYTE	"SPECIAL_STATUS"
		bit 3: attempted to perform DMA on PCI while bus-mastering
			  disabled in PCI command word
		bit 2: PCI/DMA synchronization error occurred
		bit 1: PCI bus master encountered fatal error
		bit 0: direction of transaction which encountered error
			=0 write (refer to offset 48h)
			=1 read (refer to offset 44h)
		Note:	bits 3-1 are write-clear, bit 0 is read-only
 42h  2 BYTEs	unused
 44h	DWORD	current read target address for PCI bus master (read-only)
 48h	DWORD	current write target address for PCI bus master (read-only)
 4Ch 180 BYTEs	reserved
SeeAlso: #00790
--------X-1AB10ASF1106-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (VIA Technologies devices)
	AX = B10Ah subfn 1106h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=8086h


Format of Via Technologies' VT82C580VPX CPU-PCI bridge configuration:
Offset	Size	Description	(Table 00982)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1106h, device ID 0585h)
 40h 16 BYTEs	unused
 50h	BYTE	cache control 1
 51h	BYTE	cache control 2
 52h	BYTE	non-cacheable control
 53h	BYTE	system performance control
 54h	BYTE	non-cacheable region 1 (high)
 55h	BYTE	non-cacheable region 1 (low)
 56h	BYTE	non-cacheable region 2 (high)
 57h	BYTE	non-cacheable region 2 (low)
 58h	BYTE	DRAM configuration 1
 59h	BYTE	DRAM configuration 2
 5Ah  6	BYTEs	DRAM row N ending address (N=0-5)
 60h	BYTE	DRAM type
 61h	BYTE	shadow RAM control 1
 62h	BYTE	shadow RAM control 2
 63h	BYTE	shadow RAM control 3
 64h	BYTE	DRAM reference timing
 65h	BYTE	DRAM timing control 1 (see #00996)
 66h	BYTE	DRAM timing control 2 (see #00997)
 67h	BYTE	32-bit DRAM width (see #00998)
 68h	BYTE
 69h	BYTE	reserved ("do not program")
 6Ah	BYTE	refresh counter
 6Bh	BYTE	refresh control
 6Ch	BYTE	SDRAM control
 6Dh	BYTE	DRAM control drive strength
 6Eh  2 BYTEs	reserved
 70h	BYTE	PCI buffer control
 71h	BYTE	CPU-to-PCI flow control 1
 72h	BYTE	CPU-to-PCI flow control 2
 73h	BYTE	PCI master control 1
 74h	BYTE	PCI master control 2
 75h	BYTE	PCI arbitration 1
 76h	BYTE	PCI arbitration 2
 77h	BYTE	reserved for chip test
 78h 136 BYTEs	reserved
!!!via\580vpx.pdf
SeeAlso: #00817

Format of AMD-640 System Controller:
Offset	Size	Description	(Table 00983)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1106h, device ID 0595h)
 0Dh	BYTE	latency timer (bits 7-3)
		00h = 32*8 PCI clocks
		01h = 1*8 PCI clocks
		N = N*8 PCI clocks
 40h 16 BYTEs	unused???
 50h	BYTE	cache control 1 (see #00984)
 51h	BYTE	cache control 2 (see #00985)
 52h	BYTE	non-cacheable control (see #00986)
 53h	BYTE	system performance control (see #00987)
 54h	WORD	non-cacheable region 1 (see #00988)
 56h	WORD	non-cacheable region 2 (see #00988)
 58h	BYTE	DRAM configuration register 1 (see #00989)
 59h	BYTE	DRAM configuration register 2 (see #00990)
 5Ah  6	BYTEs	end of DRAM banks 0-5
		each register specifies bits 29-22 of the bank's ending address
 60h	BYTE	DRAM type (see #00991)
 61h	BYTE	shadow RAM control register 1 (see #00992)
 62h	BYTE	shadow RAM control register 2 (see #00993)
 63h	BYTE	shadow RAM control register 3 (see #00994)
 64h	BYTE	DRAM timing (see #00995)
 65h	BYTE	DRAM control register 1 (see #00996)
 66h	BYTE	DRAM control register 2 (see #00997)
 67h	BYTE	32-bit DRAM width control register (see #00998)
 68h  2 BYTEs	reserved
 6Ah	BYTE	DRAM refresh counter (in units of 16 CPU clocks)
 6Bh	BYTE	DRAM refresh control register (see #00999)
 6Ch	BYTE	SDRAM control register (see #01000)
 6Dh	BYTE	DRAM drive strength control register (see #01001)
 6Eh	BYTE	ECC control register (see #01002)
 6Fh	BYTE	ECC status register (see #01003)
 70h	BYTE	PCI buffer control (see #01004)
 71h	BYTE	CPU-to-PCI flow control 1 (see #01005)
 72h	BYTE	CPU-to-PCI flow control 2 (see #01006)
 73h	BYTE	PCI target control (see #01007)
 74h	BYTE	PCI initiator control (see #01008)
 75h	BYTE	PCI arbitration control 1 (see #01009)
 76h	BYTE	PCI arbitration control 2 (see #01010)
 77h 137 BYTEs	reserved
Note:	the AMD-640 uses PCI configuration mechanism #1; bus/device/function
	  are always 00h/00h/00h
SeeAlso: #00817,#01011

Bitfields for AMD-640 Cache Control Register 1:
Bit(s)	Description	(Table 00984)
 7-6	cache enable
	00 disabled
	01 initialization (BIOS fills L2 cache to known state)
	10 enabled (normal operation)
	11 reserved
 5	reserved (do not change)
 4-3	tag configuration
	00 eight tag bits, no "modify" bit
	01 seven tag bits, one modify bit
	10 ten tag bits, no modify bit
	11 nine tag bits, one modify bit
 2	reserved (0)
 1-0	type of cache RAM
	00 none
	01 reserved
	10 burst SRAM
	11 pipeline burst SRAM
SeeAlso: #00983,#00985

Bitfields for AMD-640 Cache Control Register 2:
Bit(s)	Description	(Table 00985)
 7-6	reserved (0)
 5	backoff processor until L2 cache filled
 4	reserved (0)
 3	two banks of SRAM instead of one
 2	reserved (0)
 1-0	L2 cache size
	00 = 256K
	01 = 512K
	10 = 1M
	11 = 2M
SeeAlso: #00983,#00984,#00986

Bitfields for AMD-640 Non-Cacheable Control Register:
Bit(s)	Description	(Table 00986)
 7	segment C000h-C7FFh cacheable and write-protected
 6	D000h-DFFFh cacheable and write-protected
 5	E000h-EFFFh cacheable and write-protected
 4	F000h-FFFFh cacheable and write-protected
 3	reserved (0)
 2	force L2 cache fill
 1	reserved (1)
 0	L2 write mode (0 = writeback, 1 = write-through)
SeeAlso: #00983,#00985,#00987

Bitfields for AMD-640 System Performance Control Register:
Bit(s)	Description	(Table 00987)
 7	enable read-around-write
 6	enable cache read pipeline cycle
 5	enable cache write pipeline cycle
 4	enable DRAM pipeline cycle
 3	enable PCI Peer Concurrence (PCI initiator can transfer to another
	  PCI device without blocking memory or CPU bus)
 2-0	reserved (0)
SeeAlso: #00983,#00986

Bitfields for AMD-640 Non-Cacheable Region register:
Bit(s)	Description	(Table 00988)
 15-11	bits 20-16 of region's base address
 10-8	size of non-cacheable area
	000 disabled
	001 = 64K
	010 = 128K
	...
	110 = 2M
	111 = 4M
 7-0	bits 28-21 of region's base address
SeeAlso: #00983,#00989

Bitfields for AMD-640 DRAM Configuration Register 1:
Bit(s)	Description	(Table 00989)
 7-5	type of address mapping for memory banks 0 and 1
	---EDO/FastPageMode---
	000 eight-bit column address
	001 nine-bit column address
	010 ten-bit column address
	011 eleven-bit column address
	100 twelve-bit column address
	other reserved
	---SDRAM---
	0xx = 16-Mbit SDRAM (see #00991)
	1xx = 64-Mbit SDRAM
 4	reserved (0)
 3-1	type of address mapping ofr memory banks 2 and 3
 0	reserved (0)
SeeAlso: #00983,#00990

Bitfields for AMD-640 DRAM Configuration Register 2:
Bit(s)	Description	(Table 00990)
 7-5	type of address mapping for memory banks 4 and 5 (see #00989)
 4-3	reserved (0)
 2-0	last populated memory bank
	000 - 101 = Bank0 - Bank5
	110,111 reserved
Note:	banks 2-4 are non-cacheable if tag RAM is ten bits + modified bit
SeeAlso: #00983,#00989

Bitfields for AMD-640 DRAM Type register:
Bit(s)	Description	(Table 00991)
 7-6	reserved
 5-4	type of DRAM in banks 4 and 5
	00 fast page mode (FPM)
	01 extended data out (EDO)
	10 reserved
	11 synchronous DRAM (SDRAM)
 3-2	type of DRAM in banks 2 and 3
 1-0	type of DRAM in banks 0 and 1
SeeAlso: #00983,#00989,#00990

Bitfields for AMD-640 Shadow RAM Control Register 1:
Bit(s)	Description	(Table 00992)
 7-6	segment CC00h-CFFFh shadow RAM control
	00 shadowing disabled
	01 write enabled
	10 read enabled
	11 both read and write enabled
 5-4	segment C800h-CBFFh shadow RAM control
 3-2	segment C400h-C7FFh shadow RAM control
 1-0	segment C000h-C3FFh shadow RAM control
SeeAlso: #00983,#00993,#00994

Bitfields for AMD-640 Shadow RAM Control Register 2:
Bit(s)	Description	(Table 00993)
 7-6	segment DC00h-DFFFh shadow RAM control
	00 shadowing disabled
	01 write enabled
	10 read enabled
	11 both read and write enabled
 5-4	segment D800h-DBFFh shadow RAM control
 3-2	segment D400h-D7FFh shadow RAM control
 1-0	segment D000h-D3FFh shadow RAM control
SeeAlso: #00983,#00992,#00994

Bitfields for AMD-640 Shadow RAM Control Register 3:
Bit(s)	Description	(Table 00994)
 7-6	segment E000h-EFFFh shadow RAM control
	00 shadowing disabled
	01 write enabled
	10 read enabled
	11 both read and write enabled
 5-4	segment F000h-FFFFh shadow RAM control
 3-2	ISA memory hole
	00 none
	01 = 512K-640K
	10 = 15M-16M
	11 = 14M-16M
 1	enable SMI redirection
	if set: 30000h-3FFFFh redirected to B0000h, 40000h-4FFFFh to A0000h
 0	redirect video RAM accesses (A0000h-BFFFFh) to system DRAM rather than
	  PCI bus (used to initialize SMRAM at B0000h)
SeeAlso: #00983,#00992,#00993

Bitfields for AMD-640 DRAM Timing register:
Bit(s)	Description	(Table 00995)
 7-6	RAS# precharge time
	00 = 2T (for 50ns DRAM) [T = HCLK period]
	01 = 3T (60ns)
	10 = 4T (70ns)
	11 = 6T
 5-4	RAS# pulse width
	00 = 3T (for 50ns DRAM)
	01 = 4T (60ns)
	10 = 5T (70ns)
	11 = 6T
 3-2	CAS# pulse width
	FPM: 00=1T, 01=2T, 10=3T, 11=4T
	EDO: 00=4T, 01=1T, 10=2T, 11=3T
 1	write pulse width (0 = 1T, 1 = 2T)
 0	delay from column address to CAS# (0 = 1T, 1 = 2T)
SeeAlso: #00983,#00994

Bitfields for AMD-640 DRAM Control Register 1:
Bit(s)	Description	(Table 00996)
 7-6	page mode control
	00 close page after access
	01 reserved
	10 keep page open until timeout or page miss
	11 close page if processor has not accessed DRAM for 8 CPU cycles
 5	enable fast DRAM decoding
 4	reduce EDO DRAM leadoff cycle from 6T to 5T
 3	delay DRAM data latch by 1/2 clock
 2	(AMD-640) reserved
	(VT82C580VPX) Pin88 function (0 = DB32, 1 = TA9)
 1	reserved (0)
 0	delay DRAM read cycle by 1T whenever write buffer contains data
	must be set if read-around-write is enabled (see #00987)
SeeAlso: #00983,#00997,#00982

Bitfields for AMD-640 DRAM Control Register 2:
Bit(s)	Description	(Table 00997)
 7	enable EDO test mode
	when set, EDO RAM contents will read correctly, FPM not
 6	reserved (0)
 5-3	(AMD-640) reserved (0)
 5	(VT82C580VPX) SDRAM CAS# latency (0 = latency 2, 1 = latency 3)
 4	(VT82C580VPX) reserved (0)
 3	(VT82C580VPX) enable Turbo EDO mode (0 = x-2-2-2, 1 = x-1-1-1 bursts)
 2	add one wait state for memory data-to-host data pop
 1	reduce RAS# precharge by 1T for SDRAM
 0	reduce RAS# to CAS# delay for SDRAM
Note:	bits 1 and 0 have no effect unless SDRAM has been selected via the
	  DRAM type register (see #00991)
SeeAlso: #00983,#00996,#00982

Bitfields for AMD-640 32-bit DRAM Width Control register:
Bit(s)	Description	(Table 00998)
 7	RAS# to Column Address delay (0 = 1T, 1 = 2T)
 6	delay NA# by 1T
 5-0	widths of banks 5 - 0
	AMD-640 documentation clains that all bits should be cleared
	for VT82C580VPX, settings are 0 = 64-bit, 1 = 32-bit (only applicable
	  when two banks of PBSRAM are installed)
SeeAlso: #00983,#00982,#00997,#00999

Bitfields for AMD-640 DRAM Refresh Control register:
Bit(s)	Description	(Table 00999)
 7	enable CAS#-before-RAS# refresh
 6	enable burst refresh (four rows every 60 us, not one every 15 us)
 5-0	reserved (0)
SeeAlso: #00983,#00998

Bitfields for AMD-640 SDRAM Control Register:
Bit(s)	Description	(Table 01000)
 7	enable 4-bank interleave for 64-Mbit SDRAMs (when bit 5 set)
 6	enable SDRAM burst write
 5	enable SDRAM bank interleave
	(when set, reduces 3-line burst from 8-1-1-1-3-1-1-1-3-1-1-1 to 8-1...)
 4	reserved (0)
 3	SDRAM CAS# latency (0 = latency 2, 1 = latency 3)
 2-0	SDRAM Operation Mode
	000 normal SDRAM
	001 enable NOP command
	010 convert CPU-to-DRAM cycles into All Banks Precharge command
	011 convert CPU-to-DRAM cycles into commands on MA[11:0]
	100 enable CAS#-before-RAS# cycles
	other reserved
SeeAlso: #00983,#00999

Bitfields for AMD-640 DRAM Drive Strength Control register:
Bit(s)	Description	(Table 01001)
 7	bank decoding test (1="for production test only. DO NOT SET.")
 6	strength of MA[1:0] drive (0 = 12ma, 1 = 24ma)
 5	function of N17 and M17 pins
	0 N17 is RAS5#, M17 is RAS4#
	1 N17 is MA1, M17 is MA0
 4	force SMM mode (when set, act as if SMIACT# is asserted)
 3	strength of SDRAM command lines (0 = 12ma, 1 = 24ma)
 2	strength of MA[13:2] and WEx# drive (0 = 12ma, 1 = 24ma)
 1	strength of CAS# drive (0 = 12ma, 1 = 24ma)
 0	strength of RAS# drive (0 = 12ma, 1 = 24ma)
SeeAlso: #00983,#00999

Bitfields for AMD-640 ECC Control Register:
Bit(s)	Description	(Table 01002)
 7	ECC mode select (0 = parity, 1 = ECC)
 6	reserved (0)
 5	assert SERR# for ECC multibit errors
 4	assert SERR# for ECC single-bit errors
 3	add 1T for SDRAM read cycles with ECC (required when ECC mode enabled)
 2	enable ECC for banks 5 and 4
 1	enable ECC for banks 3 and 2
 0	enable ECC for banks 1 and 0
SeeAlso: #00983,#01003

Bitfields for AMD-640 ECC Status Register:
Bit(s)	Description	(Table 01003)
 7	multi-bit error detected (write-clear)
 6-4	number of DRAM bank containing multi-bit error (write-clear)
 3	single-bit error detected (write-clear)
 2-0	number of DRAM bank containing single-bit error (write-clear)
SeeAlso: #00983,#01002

Bitfields for AMD-640 PCI Buffer Control register:
Bit(s)	Description	(Table 01004)
 7	enable CPU-to-PCI posted writes
 6	enable PCI-to-DRAM posted writes
 5	enable PCI-to-DRAM prefetch
 4-2	reserved (0)
 1	disable PCI retry for processor QuadWord access
 0	CPU-to-PCI buffer flushing
	0 flushing has priority over bus grants
	1 bus-grant to another PCI initiator has priority over flushing
SeeAlso: #00983

Bitfields for AMD-640 CPU-to-PCI Flow Control 1 register:
Bit(s)	Description	(Table 01005)
 7,3	PCI burst control
	00 no bursts, every write goes to write buffer
	01 burst writes placed in write buffer, non-burst writes sent to PCI
	      bus immediately after write buffers flushed
	1x all writes go to write buffer; bursting performed for burstable
	      transactions
 6	enable byte merge
 5	reserved (1)
 4	enable posted PCI I/O cycle writes
 2	eanble fast back-to-back PCI writes
 1	enable quick frame generation (FRAME# asserted one clock early)
 0	add one wait state to IRDY#
SeeAlso: #00983,#01006

Bitfields for AMD-640 CPU-to-PCI Flow Control 2 register:
Bit(s)	Description	(Table 01006)
 7	unsuccessful retry (16 or 64 times) has occurred (write-clear)
 6	retry timeout action
	0 retry continuously, recording status
	1 flush buffer; if reading, return FFFFFFFFh
 5-4	retry count and backoff
	00 retry twice, backoff processor
	01 retry 16 times, set bit 7 on failure
	10 retry four times, backoff processor
	11 retry 64 times, set bit 7 on failure
 3	discard failed data from write buffer when retry fails
 2	backoff processor if PCI read retry fails
 1	assert FRAME# one cycle earlier than indicated by offset 71h bit 1
 0	reduce TRDY#-to-BRDY# by one HCLK on processor reads of PCI target
SeeAlso: #00983,#01005,#01007

Bitfields for AMD-640 PCI Target Control register:
Bit(s)	Description	(Table 01007)
 7	slow memory decoding (must be set if fast back-to-back cycles enabled)
 6	add one wait state to TRDY# response on reads
 5	add one wait state to TRDY# response on writes
 4	reserved (0)
 3	assert STOP# after write timeout
 2	assert STOP# after read timeout
 1	enable sampling of PCI LOCK# pin
 0	force AMD-640 to initiate PCI arbitration if FRAM# not asserted within
	  16 PCI clocks of last GNT#
SeeAlso: #00983,#01006,#01008

Bitfields for AMD-640 PCI Initiator Control register:
Bit(s)	Description	(Table 01008)
 7	enable enhanced PCI commands (Memory Read Line, Memory Read Multiple,
	  and Memory Write and Invalidate)
 6	enable single-write byte merging
 5-0	reserved (0)
SeeAlso: #00983,#01007,#01008

Bitfields for AMD-640 PCI Arbitration Control 1 register:
Bit(s)	Description	(Table 01009)
 7	arbitration priority
	0 = fixed (high-to-low is REQ1#, REQ2#, REQ3#, REQ4#, PREQ#, and CPU)
	1 = fair (round-robin) arbitration
 6	arbitration mode
	0 arbitrate at end of REQ#
	1 arbitrate at end of each FRAME# (allows pre-emption by a
	  higher-priority initiator)
 5-4	reserved (0)
 3-0	number of idle time periods of 32 PCI clocks before arbitration is
	  forced (0000 disables timeout)
SeeAlso: #00983,#01008,#01010

Bitfields for AMD-640 PCI Arbitration Control 2 register:
Bit(s)	Description	(Table 01010)
 7	enable initiator priority rotation
	=0 use arbitration priority as set by offset 75h bit 7 (see #01009)
 6	reserved (0)
 5-4	initiator priority rotation control
	00 disabled (use offset 75h bit 7 setting)
	01 grant to processor after every PCI initiator grant
	10 grant to processor after every other PCI initiator grant
	11 grant to processor after every three PCI initiator grants
 3-0	reserved (0)
SeeAlso: #00983,#01009

Format of AMD-645 Peripheral Bus Controller, function 0 (PCI-ISA bridge) data:
Offset	Size	Description	(Table 01011)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1106h, device ID 0586h)
 40h	BYTE	ISA bus control (see #01012)
 41h	BYTE	ISA Test Mode (see #01013)
 42h	BYTE	ISA clock control (see #01014)
 43h	BYTE	ROM Decode Control (see #01015)
 44h	BYTE	keyboard controller control (see #01016)
 45h	BYTE	Type F DMA control (see #01017)
 46h	BYTE	Miscellaneous control 1 (see #01018)
 47h	BYTE	Miscellaneous control 2 (see #01019)
 48h	BYTE	Miscellaneous control 3 (see #01020)
 49h	BYTE	reserved
 4Ah	BYTE	IDE interrupt routing (see #01021)
 4Bh	BYTE	reserved
 4Ch	BYTE	PCI memory hole bottom, bits 23-16
 4Dh	BYTE	PCI memory hole top, bits 23-16
		(if top is <= bottom, hole is disabled)
 4Eh	WORD	DMA/Master memory access control 3 (see #01022)
 50h	BYTE	PnP DRQ Routing (see #01023)
 51h  3	BYTEs	reserved
 54h	BYTE	PCI IRQ Edge/Level selection (see #01024)
 55h	BYTE	PnP Routing for external MIRQ0/1 (see #01025)
 56h	BYTE	PnP Routing for PCI INTB/INTA (see #01027)
 57h	BYTE	PnP Routing for PCI INTD/INTC (see #01028)
 58h	BYTE	PnP Routing for external MIRQ2 (see #01029)
 59h	BYTE	MIRQ pin configuration (see #01030)
 5Ah	BYTE	XD Power-On Strap Options (see #01031)
 5Bh	BYTE	internal RTC test mode (see #01032)
 5Ch  4 BYTEs	reserved
 60h	WORD	distributed DMA, channel 0 base address/enable (see #01033)
 62h	WORD	distributed DMA, channel 1 base address/enable (see #01033)
 64h	WORD	distributed DMA, channel 2 base address/enable (see #01033)
 66h	WORD	distributed DMA, channel 3 base address/enable (see #01033)
 68h	WORD	reserved
 6Ah	WORD	distributed DMA, channel 5 base address/enable (see #01033)
 6Ch	WORD	distributed DMA, channel 6 base address/enable (see #01033)
 6Eh	WORD	distributed DMA, channel 7 base address/enable (see #01033)
 70h 144 BYTEs	reserved
SeeAlso: #00817,#00983,#01034,#01046

Bitfields for AMD-645 ISA Bus Control register:
Bit(s)	Description	(Table 01012)
 7	extra delay on ISA commands (default is disabled)
 6	enable extended ISA bus ready (default is disabled)
 5	ISA slave wait states (0=4 wait states [default], 1=5 wait states)
 4	chipset I/O wait states (0=2 wait states [default], 1=4 wait states)
 3	I/O recovery time enabled
 2	enable extended ALE
 1	no ROM wait states (default is clear, 1 wait state)
 0	enable ROM writes
SeeAlso: #01011

Bitfields for AMD-645 ISA Test Mode register:
Bit(s)	Description	(Table 01013)
 7-6	reserved (0)
 5	enable fast reset via PORT 0092h
 4	reserved (0)
 3	double DMA clock (=0 DMA at 1/2 ISA clock, =1 DMA at full ISA clock)
 2-0	reserved (0)
SeeAlso: #01011,#01012,#01014

Bitfields for AMD-645 ISA Clock Control register:
Bit(s)	Description	(Table 01014)
 7	disable "Latch IO16#"
 6-4	reserved (0)
 3	enable ISA Bus clock select via bits 2-0 (=0 use PCLK/4)
 2-0	ISA Bus clock select
	000 PCLK/3 (default)
	001 PCLK/2
	010 PCLK/4
	011 PCLK/6
	100 PCLK/5
	101 PCLK/10
	110 PCLK/12
	111 OSC/2
Note:	in order to safely change the ISA clock, bit 3 must first be cleared,
	  then bits 2-0 may be changed, and finally bit 3 can be set again
SeeAlso: #01011,#01013

Bitfields for AMD-645 ROM Decode Control register:
Bit(s)	Description	(Table 01015)
 7	enable 64K ROM at FFFE00000h-FFFEFFFFh
 6	enable 384K ROM at FFF80000h-FFFDFFFFh
 5	enable 32K ROM at E8000h-EFFFFh
 4	enable 32K ROM at E0000h-E7FFFh
 3	enable 32K ROM at D8000h-D8FFFh
 2	enable 32K ROM at D0000h-D7FFFh
 1	enable 32K ROM at C8000h-CFFFFh
 0	enable 32K ROM at C0000h-C7FFFh
SeeAlso: #01011

Bitfields for AMD-645 Keyboard Controller Control register:
Bit(s)	Description	(Table 01016)
 7-4	reserved (0)
 3	enable Mouse Lock
 2-0	reserved (0)
SeeAlso: #01011

Bitfields for AMD-645 Type-F DMA Control register:
Bit(s)	Description	(Table 01017)
 7	enable line buffer from ISA Master/DMA to PCI
 6-4	enable Type F timing on DMA Channels 7, 6, 5
 3-0	enable Type F timing on DMA Channels 3-0
SeeAlso: #01011

Bitfields for AMD-645 Miscellaneous Control 1 register:
Bit(s)	Description	(Table 01018)
 7-5	reserved (0)
 4	enable command register test mode
	(when set, PCI offset 04h bits 0-1 become writable and bit 3 read-only)
 3-2	reserved (0)
 1	disallow interruptions of PCI burst reads
 0	enable posted memory writes
SeeAlso: #01011,#01019,#01020

Bitfields for AMD-645 Miscellaneous Control 2 register:
Bit(s)	Description	(Table 01019)
 7	use INIT as CPU reset signal instead of CPURST
 6	enable PCI transaction delay
 5	enable ports 04D0h-04D1h (per EISA spec)
 4	enable interrupt controller shadow register
 3	reserved (0)
 2	enable write delay transaction time-out timer
 1	enable read delay transaction time-out timer
 0	software PCI reset -- set to cause a PCI reset via PCIRST pin
SeeAlso: #01011,#01018,#01020,PORT 04D0h

Bitfields for AMD-645 Miscellaneous Control 3 register:
Bit(s)	Description	(Table 01020)
 7-4	reserved (0)
 3	disable RTC PORT 0074h and PORT 0075h
 2	disable integrated USB controller
 1	disable integrated IDE controller
 0	add 512K to offset 4Eh bits 15-12 at top of PCI memory
SeeAlso: #01011,#01018,#01019,PORT 0074h"AMD-645"

Bitfields for AMD-645 IDE Interrupt Routing register:
Bit(s)	Description	(Table 01021)
 7	wait for PGNT before Grant to ISA Master/DMA
 6	port 00xxh bus select (0=access via SD bus, 1=access via XD bus)
 5-4	reserved (0)
 3-2	secondary IDE channel IRQ (same encoding as primary)
 1-0	primary IDE channel IRQ
	00 IRQ14 (default for primary)
	01 IRQ15 (default for secondary)
	10 IRQ10
	11 IRQ11
SeeAlso: #01011

Bitfields for AMD-645 DMA/Master Memory Access Control 3 register:
Bit(s)	Description	(Table 01022)
 15-12	top of PCI memory for ISA DMA/Master access, bits 23-20, less 1
 11	accesses to E0000h-EFFFFh forwarded to PCI
 10	accesses to A0000h-BFFFFh forwarded to PCI
 9	accesses to 80000h-9FFFFh forwarded to PCI
 8	accesses to 00000h-7FFFFh forwarded to PCI
 7	accesses to DC000h-DFFFFh forwarded to PCI
 6	accesses to D8000h-DBFFFh forwarded to PCI
 5	accesses to D4000h-D7FFFh forwarded to PCI
 4	accesses to D0000h-D3FFFh forwarded to PCI
 3	accesses to CC000h-CFFFFh forwarded to PCI
 2	accesses to C8000h-CBFFFh forwarded to PCI
 1	accesses to C4000h-C7FFFh forwarded to PCI
 0	accesses to C0000h-C3FFFh forwarded to PCI
SeeAlso: #01011

Bitfields for AMD-645 PnP DRQ Routing register:
Bit(s)	Description	(Table 01023)
 7-0	reserved (always read 04h)
SeeAlso: #01011,#01024

Bitfields for AMD-645 PCI IRQ Edge/Level Select register:
Bit(s)	Description	(Table 01024)
 7-4	reserved
 3	PIRQA# is edge-sensitive rather than level-sensitive
 2	PIRQB# is edge-sensitive
 1	PIRQC# is edge-sensitive
 0	PIRQD# is edge-sensitive
SeeAlso: #01011,#01023,#01025

Bitfields for AMD-645 PnP IRQ Routing 1 register:
Bit(s)	Description	(Table 01025)
 7-4	routing for MIRQ1 (see #01026)
 3-0	routing for MIRQ0 (see #01026)
SeeAlso: #01011,#01024

(Table 01026)
Values for AMD-645 IRQ routing:
 0000	disabled
 0001	IRQ1
 0010	reserved
 0011	IRQ3
 ...
 0111	IRQ7
 1000	reserved
 1001	IRQ9
 ...
 1100	IRQ12
 1101	reserved
 1110	IRQ14
 1111	IRQ15
SeeAlso: #01025,#01027,#01028,#01029

Bitfields for AMD-645 PnP IRQ Routing 2 register:
Bit(s)	Description	(Table 01027)
 7-4	routing for PIRQB# (see #01026)
 3-0	routing for PIRQA# (see #01026)
SeeAlso: #01025,#01028,#01029

Bitfields for AMD-645 PnP IRQ Routing 3 register:
Bit(s)	Description	(Table 01028)
 7-4	routing for PIRQD# (see #01026)
 3-0	routing for PIRQC# (see #01026)
SeeAlso: #01025,#01027,#01029

Bitfields for AMD-645 PnP IRQ Routing 4 register:
Bit(s)	Description	(Table 01029)
 7-4	reserved
 3-0	routing for MIRQ2# (see #01026)
SeeAlso: #01025,#01027,#01028

Bitfields for AMD-645 MIRQ Pin Configuration register:
Bit(s)	Description	(Table 01030)
 7-3	reserved (0)
 2	select MASTER# instead of MIRQ2
 1	select KEYLOCK instead of MIRQ1
 0	select APICCS# instead of MIRQ0
SeeAlso: #01011,#01029

Bitfields for AMD-645 XD Power-Up Strap Options register:
Bit(s)	Description	(Table 01031)
 7-4	Keyboard RP16-RP13
 3	reserved (0)
 2	enable internal RTC
 1	enable internal PS/2 mouse
 0	enable internal keyboard controller
Note:	the default value of this register is latched from external pins at
	  power-up
SeeAlso: #01011

Bitfields for AMD-645 Internal RTC Test Mode register:
Bit(s)	Description	(Table 01032)
 7-2	reserved (0)
 1	enable access to internal RTC's RAM when RTC is disabled
	  (see PORT 0074h"AMD-645")
 0	reserved (0)
SeeAlso: #01011

Bitfields for AMD-645 Distributed DMA Base/Enable register:
Bit(s)	Description	(Table 01033)
 15-4	base address bits 15-4 for Channel N
 3	enable DMA channel
 2-0	reserved (0)
SeeAlso: #01011

Format of AMD-645 Peripheral Bus Controller, function 1 (IDE Control) data:
Offset	Size	Description	(Table 01034)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1106h [VIA Technologies], device ID 0571h)
 09h	BYTE	programming interface
		bit 7: Master IDE capability
		bits 6-4: reserved (0)
		bit 3: secondary channel supports operating mode selection
		bit 2: use native PCI mode, not compatibility mode for sec. ch.
		bit 1: primary channel supports operating mode selection
		bit 0: use native PCI mode, not compatibility mode for pri. ch.
 10h	DWORD	primary data/command base address
 14h	DWORD	primary control/status base address
 18h	DWORD	secondary data/command base address
 1Ch	DWORD	secondary control/status base address
 20h	DWORD	bus master control base address (default 0000CC01h)
 40h	BYTE	chip enable (see #01035)
 41h	BYTE	IDE configuration (see #01036)
 42h	BYTE	reserved ("do not program")
 43h	BYTE	FIFO configuration (see #01037)
 44h	BYTE	miscellaneous control 1 (see #01038)
 45h	BYTE	miscellaneous control 2 (see #01039)
 46h	BYTE	miscellaneous control 3 (see #01040)
 47h	BYTE	unused???
 48h	DWORD	drive timing control (see #01041)
 4Ch	BYTE	address setup time (see #01042)
 4Dh	BYTE	reserved ("do not program")
 4Eh	BYTE	secondary non-01F0h port access timing (see #01043)
 4Fh	BYTE	primary non-01F0h port access timing (see #01043)
 50h	BYTE	UltraDMA/33 extended timing control, Sec. Drive 1 (see #01044)
 51h	BYTE	UltraDMA/33 extended timing control, Sec. Drive 0 (see #01044)
 52h	BYTE	UltraDMA/33 extended timing control, Pri. Drive 1 (see #01044)
 53h	BYTE	UltraDMA/33 extended timing control, Pri. Drive 0 (see #01044)
 54h  4 BYTEs	reserved
 58h	DWORD	"reserved"
		(appears to be an additional set of drive timing controls)
 5Ch  4 BYTEs	???
 60h	WORD	primary sector size (see #01045)
 62h  6 BYTEs	reserved
 68h	WORD	secondary sector size (see #01045)
 6Ah 150 BYTEs	reserved
Note:	the AMD-645 IDE controller is compatible with the SFF 8038i v1.0 spec
SeeAlso: #00817,#01011,#01046

Bitfields for AMD-645 IDE Chip Enable register:
Bit(s)	Description	(Table 01035)
 7-2	reserved (00001)
 1	enable primary IDE channel
 0	enable secondary IDE channel
SeeAlso: #01034,#01036

Bitfields for AMD-645 IDE Configuration register :
Bit(s)	Description	(Table 01036)
 7	enable primary IDE read-prefetch buffer
 6	enable primary IDE post write buffer
 5	enable secondary IDE read-prefetch buffer
 4	enable secondary IDE post write buffer
 3-0	reserved (0110)
SeeAlso: #01034,#01035,3813

Bitfields for AMD-645 IDE FIFO Configuration register:
Bit(s)	Description	(Table 01037)
 7	reserved (0)
 6-5	FIFO configuration
	00	primary channel = 16, secondary channel = 0
	01/10	primary channel = 8, secondary channel = 8
	11	primary channel = 0, secondary channel = 16
 4	reserved (1)
 3-2	primary channel FIFO threshold
	00 = completely full
	01 = 3/4 full
	10 = 1/2 full
	11 = 1/4 full
 1-0	secondary channel FIFO threshold (same settings as bits 3-2)
SeeAlso: #01034,#01036

Bitfields for AMD-645 IDE Miscellaneous Control 1 register:
Bit(s)	Description	(Table 01038)
 7	reserved (0)
 6	number of wait states on Master Read Cycle IRDY#
 5	number of wait states on Master Write Cycle IRDY#
 4	enable 1/2 clock advance on FIFO output
 3	enable bus-master IDE status register read retry
 2-0	reserved (0)
SeeAlso: #01034,#01039,#01040

Bitfields for AMD-645 IDE Miscellaneous Control 2 register:
Bit(s)	Description	(Table 01039)
 7	reserved (0)
 6	swap interrupts between the two IDE channels
 5-0	reserved (0)
SeeAlso: #01034,#01038,#01040

Bitfields for AMD-645 IDE Miscellaneous Control 3 register:
Bit(s)	Description	(Table 01040)
 7	enable FIFO flush for read DMA on primary channel interrupt
 6	enable FIFO flush for read DMA on secondary channel interrupt
 5	enable FIFO flush for each sector on primary channel
 4	enable FIFO flush for each sector on secondary channel
 3-2	reserved
 1-0	maximum DRDY# pulse width
	00 unlimited
	01 64 PCI clocks
	10 128 PCI clocks
	11 192 PCI clocks
SeeAlso: #01034,#01038,#01039

Bitfields for AMD-645 IDE Drive Timing Control register:
Bit(s)	Description	(Table 01041)
 31-28	primary drive 0 active DIOR#/DIOW# pulse width
 27-24	primary drive 0 DIOR#/DIOW# recovery time (PCI clocks, less 1)
 23-20	primary drive 1 active pulse width (PCI clocks, less 1)
 19-16	primary drive 1 recovery time
 15-12	secondary drive 0 active pulse width
 11-8	secondary drive 0 recovery time
 7-4	secondary drive 1 active pulse width
 3-0	secondary drive 1 recover time (PCI clocks, less 1)
SeeAlso: #01034,#01042

Bitfields for AMD-645 IDE Address Setup Time register:
Bit(s)	Description	(Table 01042)
 7-6	primary drive 0 address setup time
	00 = 1T
	01 = 2T
	10 = 3T
	11 = 4T
 5-4	primary drive 1 address setup time (same values as above)
 3-2	secondary drive 0 address setup time
 1-0	secondary drive 1 address setup time
SeeAlso: #01034,#01041

Bitfields for AMD-645 Non-01F0h Port Access Timing register:
Bit(s)	Description	(Table 01043)
 7-4	width of DIOR#/DIOW# active pulse in PCI clocks (less 1)
 3-0	DIOR#/DIOW# recovery time in PCI clocks (less 1)
SeeAlso: #01011

Bitfields for AMD-645 UltraDMA/33 Extended Timing Control register:
Bit(s)	Description	(Table 01044)
 7	method for enabling UltraDMA mode on drive
	0 using "Set Feature" command
	1 using bit 6 of this register
 6	enable UltraDMA mode for drive
 5	UltraDMA transfer mode
	0 UltraDMA DMA mode
	1 UltraDMA PIO mode
 4-2	reserved (0)
 1-0	drive cycle time
	00 = 2T
	...
	11 = 5T
SeeAlso: #01011

Bitfields for AMD-645 Sector Size register:
Bit(s)	Description	(Table 01045)
 15-12	reserved
 11-0	sector size in bytes (default 200h)
SeeAlso: #01011

Format of AMD-645 Peripheral Bus Controller, function 2 (USB Controller) data:
Offset	Size	Description	(Table 01046)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1106h, device ID 3038h)
 20h	DWORD	base address of USB I/O ports (see PORT xxxxh"AMD-645 - USB"
 40h	BYTE	miscellaneous control 1 (see #01047)
 41h	BYTE	miscellaneous control 2 (see #01048)
 42h  2 BYTEs	reserved
 44h  3 BYTEs	reserved ("do not program")
 47h	BYTE	reserved
 48h 24 BYTEs	reserved
 60h	BYTE	USB release number (read-only, 10h)
 61h 95 BYTEs	reserved
 C0h	WORD	USB legacy support (read-only, 2000h)
 C2h 62 BYTEs	reserved
SeeAlso: #00817,#00983,#01011,#01034,#01049

Bitfields for AMD-645 USB Miscellaneous Control 1 register:
Bit(s)	Description	(Table 01047)
 7	PCI memory commands
	0 support memory-read-line, memory-read-multiple, and
	  memory-write-and-invalidate
	1 memory read and memory write commands only
 6	do not disable port on EOF babble
 5	eanble PCI parity checking and PERR# generation
 4	reserved (0)
 3	USB data length
	0 allow TD length up to 1280 bytes
	1 limit to 1023
 2	enable USB power management
 1	DMA limited to 8-DW burst instead of 16-DW
 0	insert one PCI wait state
SeeAlso: #01046,#01048

Bitfields for AMD-645 USB Miscellaneous Control 2 register:
Bit(s)	Description	(Table 01048)
 7-3	reserved (0)
 2	only trap port 60h/64h bits when trap-enable bits are set
 1	do not pass A20GATE command sequence (from UHCI) through I/O port 64h
 0	reserved (0)
SeeAlso: #01046,#01047,PORT 0064h

Format of AMD-645 Peripheral Bus Controller, function 3 (Power Mgmt) data:
Offset	Size	Description	(Table 01049)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 1106h, device ID 3040h)
 20h	DWORD	base address for I/O ports (see PORT xxxxh"AMD-645")
 40h	BYTE	pin configuration (see #01050)
 41h	BYTE	general configuration (see #01051)
 42h	BYTE	SCI interrupt configuration (see #01052)
 43h	BYTE	reserved
 44h	WORD	primary interrupt channel
		bit 2 is reserved; setting any other bit N makes IRQN the
		  primary interrupt channel
 46h	WORD	secondary interrupt channel
		bit 2 is reserved; setting any other bit N makes IRQN the
		  secondary interrupt channel
 48h  8 BYTEs	unused???
 50h	DWORD	GP timer control (see #01053)
 54h 13	BYTEs	reserved
 61h	BYTE	programming interface read value (value to be returned by
		  configuration register 09h) (write-only)
 62h	BYTE	subclass read value (value to be returned by
		  configuration register 0Ah) (write-only)
 63h	BYTE	base class read value (value to be returned by configuration
		  register 0Bh) (write-only)
 64h 156 BYTEs	reserved
SeeAlso: #00817,#00983,#01011,#01034,#01046,#01049

Bitfields for AMD-645 PM Pin Configuration register:
Bit(s)	Description	(Table 01050)
 7	GPIO4 configuration (0 = Pin136 is GPO_WE, 1 = Pin136 is GPIO4)
 6	GPIO3 configuration (0 = Pin92 is GPI_RE#, 1 = Pin92 is GPIO3)
 5-0	reserved (0)
SeeAlso: #01049,#01051

Bitfields for AMD-645 PM General Configuration register:
Bit(s)	Description	(Table 01051)
 7	enable debounce of PWRBTN# input
 6	enable ACPI timer reset
 5-4	reserved ("do not program")
 3	select ACPI timer size (0 = 24 bits, 1 = 32 bits)
 2	enable PCI Frame Activation as Resume Event im power state C2
 1	clock-throttling cycle time
	0 = 32 usec clock, 512 usec cycle time (default)
	1 = 1 msec clock 16 msec cycle time
 0	reserved ("do not program")
SeeAlso: #01049,#01050,MEM xxxxh:xxx0h"ACPI"

Bitfields for AMD-645 PM SCI Interrupt Configuration register:
Bit(s)	Description	(Table 01052)
 7-4	reserved (0)
 3-0	interrupt assignment
	0000 disabled
	else IRQ number (except IRQ2 is reserved)
SeeAlso: #01049

Bitfields for AMD-645 PM GP Timer Control register:
Bit(s)	Description	(Table 01053)
 31-30	power-conservation mode timer
	00 = 1/16 sec
	01 = 1/8 sec
	10 = 1 sec
	11 = 1 minute
 29	(read) set when system is in power-conservation mode
 28	enable power-conservation mode
 27-26	secondary event timer
	00 = 2 msec
	01 = 64 msec
	10 = 1/2 sec
	11 = 0.25 msec after EOI
 25	secondary event occurred, secondary event timer is counting down
 24	enable secondary event timer
 23-16	GP1 Timer count (see bits 5-4)
 15-8	GP0 Timer count (see bits 1-0)
 7	start GP1 timer
 6	automatically reload GP1 timer after counting down to 0
 5-4	time base for GP1 timer
	00 disabled
	01 = 32 microseconds
	10 = 1 second
	11 = 1 minute
 3	start GP0 timer
 2	automatically reload GP0 timer after counting down to 0
 1-0	time base for GP0 timer
	00 disabled
	01 = 1/16 second
	10 = 1 second
	11 = 1 minute
SeeAlso: #01049
--------X-1AB10ASF8086-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (Intel devices)
	AX = B10Ah subfn 8086h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #00878)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=1106h,AX=B10Dh

Format of PCI Configuration data for Intel 82375 EISA Bridge:
Offset	Size	Description	(Table 01054)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 0482h)
		(revision numbers: 03h = 82375EB, 04h = 82375SB)
 40h	BYTE	PCI Control
!!!intel\29047704.pdf pg. 32
 41h	BYTE	PCI Arbiter Control
 42h	BYTE	PCI Arbiter Priority Control
 43h	BYTE	PCI Arbiter Priority Control Extension
 44h	BYTE	MEMCS# Control
 45h	BYTE	MEMCS# Bottom of Hole
 46h	BYTE	MEMCS# Top of Hole
 47h	BYTE	MEMCS# Top of Memory
 48h	WORD	EISA Address Decode Control 1
 4Ah  2 BYTEs	reserved
 4Ch	BYTE	ISA I/O Recovery Time Control
 4Dh  7 BYTEs	reserved
 54h	BYTE	MEMCS# Attribute Register #1
 55h	BYTE	MEMCS# Attribute Register #2
 56h	BYTE	MEMCS# Attribute Register #3
 57h	BYTE	reserved
 58h	BYTE	PCI Decode Control
 59h	BYTE	reserved
 5Ah	BYTE	EISA Address Decode Control 2
 5Bh	BYTE	reserved
 5Ch	BYTE	EISA-to-PCI Memory Region Attributes
 5Dh  3 BYTEs	reserved
 60h  4 DWORDs	EISA-to-PCI Memory Region Address registers 1-4
 70h  4 DWORDs	EISA-to-PCI I/O Region Address registers 1-4
 80h	WORD	BIOS Timer base address
 82h  2 BYTEs	reserved
 84h	BYTE	EISA Latency Timer Control Register
 85h  3 BYTEs	reserved
 88h	DWORD	PCEB Test Control Register ("DO NOT WRITE")
 8Ch 116 BYTEs	reserved
SeeAlso: #00878,#01055

Format of PCI Configuration data for Intel 82434LX/NX Cache/DRAM Controller:
Offset	Size	Description	(Table 01055)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 04A3h)
		(revision numbers: 01h/03h are 82434LX, 1xh are 82434NX)
		(command register only supports bits 8,6,2,1,0)
 40h 16 BYTEs	unused (hard-wired to 00h)
 44h	BYTE	??? (AMI BIOS writes 00h)
 45h	BYTE	??? (AMI BIOS writes 00h)
 50h	BYTE	Host CPU Selection (see #01056)
 51h	BYTE	deturbo frequency control register
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  by comparing it against a free-running 8-bit counter counting
		  at 1/8 the CPU clock speed
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
		  (only bits 7-6 writable, bits 5-0 hardwired to 0)
 52h	BYTE	Secondary Cache Control (see #01057)
 53h	BYTE	Host Read/Write Buffer Control (see #01058)
 54h	BYTE	PCI Read/Write Buffer Control
		bits 7-3: reserved
		bit 2: LBXs connected to TRDY#
		bit 1: enable PCI burst writes
		bit 0: enable PCI-to-memory posted writes
 55h  2 BYTEs	reserved
 57h	BYTE	DRAM Control (see #01059)
 58h	BYTE	DRAM Timing (see also #01117)
		bits 7-2: reserved
		bit 1: (NX only) RAS# Wait State
		bit 0: CAS# Wait State (one extra wait state before CAS#
			  within burst cycle)
 59h  7	BYTEs	Programmable Attribute Map registers 0-6 (see #01118)
 60h  8	BYTEs	DRAM Row Boundary registers 0-7
		(chip revisions numbered < 10h [LX] only support six rows of
		  DRAM)
		each register N indicates the amount of cumulative amount of
		  memory in SIMM banks 0-N, in multiples of 1M; offset 67h
		  (65h on 82434LX's) contains the total amount of memory
		  installed in the system; on the 82434NX, two additional
		  bits are concatenated to each row boundary from the DRAM Row
		  Boundary Extension registers to allow up to 1024M of memory
		  to be specified (though only 512M are supported)
 68h  4 BYTEs	(NX only) DRAM Row Boundary Extension registers
		each nybble is concatenated with the corresponding DRAM Row
		  Boundary register to form a 12-bit boundary value (of which
		  only the low 10 bits are actually used)
 6Ch	DWORD	reserved (hardwired to 00000000h)
 70h	BYTE	Error Command (see #01060)
 71h	BYTE	Error Status (see #01061)
 72h	BYTE	System Management RAM control (see also #01123)
		bits 7-6: reserved
		bit 5:	map SMM-mode memory (64K) into address space when bits
			2-0 = 010 (default 3000h:0000h; can be changed by
			first SMM event)
		bit 4: close SMRAM space (allows data accesses to be forwarded
			to PCI bus while execuding SMM code)
		bit 3: lock SMRAM space (can't be cleared by software)
		bits 2-0: SMRAM memory address (010 = Axxxxh, 011 = Bxxxxh)
 73h  5 BYTEs	reserved
 78h	WORD	Memory Space Gap
		bit 15: enable ISA hole
		bits 14-12: size of ISA hole in MB (less 1); must be power of 2
		bits 11-8: reserved
		bits 7-4: bottom of ISA memory hole in MB
			  (must be multiple of gap size)
		bits 3-0: reserved
 7Ah  2 BYTEs	reserved
 7Ch	DWORD	Frame Buffer Range (see #01062)
 80h 128 BYTEs	reserved
Note:	the 82434NX is part of the Intel Neptune chipset
SeeAlso: #01064,#01083

Bitfields for Intel 82434LX/NX Host CPU Selection:
Bit(s)	Description	(Table 01056)
 7-5	host CPU type
	LX: hardwired to 100 (Pentium)
	NX: "reserved" (101 on RB's system)
 4-3	reserved
 2	enable L1 cache
 1-0	Host Operating Frequency (set according to external bus speed)
	00: reserved
	01: 50 MHz
	10: 60 MHz
	11: 66 MHz
	(LX: bit 1 reserved, only 60/66 MHz supported)
SeeAlso: #01055,#01057

Bitfields for Intel 82434LX/NX Secondary Cache Control:
Bit(s)	Description	(Table 01057)
 7-6	secondary cache size
	00 none
	01 reserved
	10 256K
	11 512K
 5	SRAM type
	0 standard SRAMs
	1 burst SRAMs
 4	secondary cache allocation
	0 cache only CPU reads of memory with CACHE# asserted
	1 cache all CPU reads of cacheable memory
 3	Cache Byte Control
	0 use single write enable and per-byte select lines
	1 use per-byte write enables on the cache
 2	(NX only) SRAM connectivity
	0 disable CCS[1:0]# / CCS1# functionality
	1 enable CCS[1:0]# functionality to de-select async SRAMs, placing them
	  in a low-power standby mode
	1 enable CCS1# functionality for burst SRAMs, indicating the lack of an
	  external address latch
 1	(LX only) Secondary Cache Write Policy
	0 write-through
	1 write-back (NX is always in write-back mode)
 0	Secondary Cache Enable
SeeAlso: #01055,#01058

Bitfields for Intel 82434LX/NX Host Read/Write Buffer Control:
Bit(s)	Description	(Table 01058)
 7-4	reserved
 3	enable read-around-write
 2	reserved
 1	enable CPU-to-PCI posted writes
 0	(LX only) enable CPU-to-memory posted writes
	(NX always posts memory writes)
SeeAlso: #01055,#01057

Bitfields for Intel 82434LX/NX DRAM Control:
Bit(s)	Description	(Table 01059)
 7-6	(NX only) DRAM burst timing
	00  X-4-4-4 read/write (default)
	01  X-4-4-4 read, X-3-3-3 write
	10  reserved
	11  X-3-3-3 read/write
 5	parity error mask
 4	0-Active RAS# mode
 3	SMRAM enable (must be set to enable reg 72h)
 2	Burst-of-Four Refresh
 1	Refresh Type
	=0 RAS#-only
	=1 CAS#-before-RAS#
 0	DRAM Refresh Enable
SeeAlso: #01055

Bitfields for Intel 82434LX/NX Error Command register:
Bit(s)	Description	(Table 01060)
 7	assert SERR# on receiving target abort
 6	assert SERR# on PCI data-write parity error
 5	(NX only) assert SERR# on PCI data-read parity error
 4	(NX only) assert SERR# on PCI address parity error
 3	(NX only) assert PERR# on data parity error
 2	enable L2 cache parity
 1	enable SERR# on DRAM/L2 cache data parity error
 0	assert PEN# on data reads; allow CPU to signal parity error via PCHK#
Notes:	PCI command register bit 6 is master enable for bit 3;
	PCI cmd bits 6 and 8 are the master enable for bits 7-4 and 1
	bits 1-0 = 10 is not permitted
SeeAlso: #01055,#01061

Bitfields for Intel 82434LX/NX Error Status register:
Bit(s)	Description	(Table 01061)
 7	reserved
 6	PCI-write detected parity error
 5	(NX only) PCI-read detected parity error
 4	(NX only) PCI address parity error detected
 3	main memory data parity error
 2	L2 cache data parity error
 1	reserved
 0	Shutdown cycle detected
Note:	clear status bits by writing a 'one' bit to each bit to be cleared
SeeAlso: #01060,#01055

Bitfields for Intel 82434LX/NX Frame Buffer Range register:
Bit(s)	Description	(Table 01062)
 31-20	buffer offset (in 1MB increments; must be multiple of buffer set set
	  by bits 3-0)
 19-14	reserved
 13	enable byte merging
 12	128K VGA-range Attribute Enable
	when set, bits 13,9,7 also apply to VGA memory range (Axxxx-Bxxxx)
 11-10	reserved
 9	no lock requests
 8	reserved
 7	enable transparent bufer writes
 6-4	reserved
 3-0	buffer size in MB (less 1); must be power of 2
Note:	if bits 31-20=0, the frame buffer feature is disabled
SeeAlso: #01055

Format of PCI Configuration data for Intel 82424 Cache Controller:
Offset	Size	Description	(Table 01063)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 0483h)
 40h	BYTE	bus number
 41h	BYTE	subordinate bus number
 42h	BYTE	disconnect timer
 50h	BYTE	host CPU selection
 51h	BYTE	deturbo frequency control
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
 52h	BYTE	secondary cache control
 53h	BYTE	write buffer control
 54h	BYTE	PCI features control
 55h	BYTE	DRAM Operation Mode Select
 56h	BYTE	System Exception Handling
 57h	BYTE	SMM Control Register
 58h	BYTE	reserved
 59h  7	BYTEs	Programmable Attribute Map registers 0-6 (see also #01118)
 60h  4 BYTEs	DRAM Row Boundary registers 0-3
		each register N indicates amount of memory in rows 0-N (each
		  row is 64 bits wide)
		boundary register 3 (offset 63h) contains the total system
		  memory, which may not exceed 128M
 64h  4 BYTEs	unused???
 68h	WORD	Memory Hole-0
 6Ah	WORD	Memory Hole-1
Note:	the above field names are those given by EduWARE's PCI Configuration
	  Manager v1.2
SeeAlso: #01055,#01083,#01108

Format of PCI Configuration data for Intel 82378 and 82379 ISA Bridges:
Offset	Size	Description	(Table 01064)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 0484h)
		(revision ID:
		    bits 7-4: reserved
		    bits 3-0: revision
			0011 82378ZB A0-step
			1000 82379AB A0-step)
 40h	BYTE	PCI Control (see #01065)
 41h	BYTE	PCI Arbiter Control (see #01066)
 42h	BYTE	PCI Arbiter Priority Control (see #01067)
 43h	BYTE	(82378ZB) PCI Arbiter Priority Control Extension Register
		bit 0: bank 3 fixed priority mode select (see also #01067)
		    =0 REQ2# has higher priority
		    =1 REQ3# has higher priority
 44h	BYTE	MEMCS# Control (see #01068)
 45h	BYTE	MEMCS# Bottom of Hole (address bits 23-16)
 46h	BYTE	MEMCS# Top of Hole (address bits 23-16)
 47h	BYTE	MEMCS# Top of Memory
		(address bits 28-21 == size in 2M increments, less 1)
 48h	BYTE	ISA Address Decoder Control (see #01069)
 49h	BYTE	ISA Address Decoder ROM Block Enable (see #01070)
 4Ah	BYTE	ISA Address Decoder Bottom of Hole (address bits 23-16)
 4Bh	BYTE	ISA Address Decoder Top of Hole (address bits 23-16)
 4Ch	BYTE	ISA Controller Recovery Time (see #01087)
 4Dh	BYTE	ISA Clock Divisor (see #01071)
 4Eh	BYTE	Utility Bus Chip Select Enable A (see #01072)
 4Fh	BYTE	Utility Bus Chip Select Enable B (see #01073)
 50h  4 BYTEs	reserved
 54h	BYTE	MEMCS# Attribute Register #1 (see #01074)
		attributes for 16K blocks from C0000h-CFFFFh
 55h	BYTE	MEMCS# Attribute Register #2 (see #01074)
		attributes for 16K blocks from D0000h-DFFFFh
 56h	BYTE	MEMCS# Attribute Register #3 (see #01074)
		attributes for 16K blocks from E0000h-EFFFFh
 57h	BYTE	(82378) Scatter/Gather Relocation Base Adress (see #01075)
		(82379AB) reserved
 58h  8 BYTEs	reserved
 60h	BYTE	(82378ZB) IRQ0# Route Control (see #01076)
 61h	BYTE	(82378ZB) IRQ1# Route Control (see #01076)
 62h	BYTE	(82378ZB) IRQ2# Route Control (see #01076)
 63h	BYTE	(82378ZB) IRQ3# Route Control (see #01076)
 64h 12 BYTEs	reserved
 70h	BYTE	(82378) reserved
		(82379AB, write-only) PIC/APIC Configuration Control
			  (see #01077)
 71h	BYTE	(82378) reserved
		(82379AB, write-only) APIC Base Address Relocation
		  (see #01078,MEM FEC00000h)
 72h 14 BYTEs	reserved
 80h	WORD	BIOS timer base address (see PORT 0078h)
		bits 15-2 are bits 15-2 of BIOS timer port address
		bit 1: reserved (0)
		bit 0: timer enabled (if disabled, other bits ignored)
 82h 30 BYTEs	unused???
 A0h	BYTE	SMI Control (see #01079)
 A1h	BYTE	reserved
 A2h	WORD	SMI Enable (see #01080)
 A4h	DWORD	System Event Enable (SEE) (see #01081)
 A8h	BYTE	Fast-Off Timer (in minutes)
 A9h	BYTE	reserved
 AAh	WORD	active SMI Requests (see #01082)
 ACh	BYTE	(82378ZB) Clock Throttle STPCLK# Low Timer
		duration of STPCLK# low period in 32 microsecond units
 ADh	BYTE	reserved
 AEh	BYTE	(82378ZB) Clock Throttle STPCLK# High Timer
		duration of STPCLK# high period in 32 microsecond units
 AFh 81 BYTEs	reserved
SeeAlso: #01055,#01167,PORT 040Ah"82378ZB"

Bitfields for Intel 82378/82379 PCI Control:
Bit(s)	Description	(Table 01065)
 7	reserved (0)
 6	DMA Reserved Page Register Aliasing Control
	=0 alias PORT 80h-8Fh to PORT 90h-9Fh
 5	Interrupt Acknowledge Enable
	=0 ignore INTA cycles on the PCI bus, but still allow 8259 register
	  access and poll-mode functions
 4-3	Subtractive Decoding Sample Point
	00 slow sample point
	01 typical
	10 fast sample point
	11 reserved
 2	PCI Posted Write Buffer Enable
 1	ISA Master Line Buffer Configuration
	=0 single-transaction mode
	=1 eight-byte mode for ISA bus master transfers
 0	DMA Line Buffer Configuration
	=0 single-transaction mode
	=1 eight-byte mode
SeeAlso: #01064,#01066

Bitfields for Intel 82378/82379 PCI Arbiter Control:
Bit(s)	Description	(Table 01066)
 7-5	reserveed (0)
 4-3	Master Retry Timer
	00 disabled (retries never masked)
	01 retries unmasked after 16 PCICLKs
	10 retries unmasked after 32 PCICLKs
	11 retries unmasked after 64 PCICLKs
 2	Bus Park
	=1 park CPUREQ# on PCI bus when 82378 detects PCI bus idle
 1	Bus Lock
	=0 resource lock
	=1 Bus lock
 0	Guaranteed Access Time
	=1 ISA bus masters are guaranteed 2.5 microsecond CHRDY time-out
SeeAlso: #01064,#01065

Bitfields for Intel 82378/82379 PCI Arbiter Priority Control:
Bit(s)	Description	(Table 01067)
 7	bank 3 rotate control
 6	bank 2 rotate control
 5	bank 1 rotate control
 4	bank 0 rotate control
 3	bank 2 fixed priority mode select B
 2	bank 2 fixed priority mode select A
 1	bank 1 fixed priority mode select
 0	bank 0 fixed priority mode select
Note:	if both 'rotate' and 'fixed' bits are set for a given bank,
	  that bank will be in rotating-priority mode
SeeAlso: #01064,#01066

Bitfields for Intel 82378/82379 MEMCS# Control Register:
Bit(s)	Description	(Table 01068)
 7-5	reserved (0)
 4	MEMCS# Master Enable
 3	write enable for 0F0000h-0FFFFFh
 2	read enable for 0F0000h-0FFFFFh
 1	write enable for 080000h-09FFFFh
 0	read enable for 080000h-09FFFFh
SeeAlso: #01064

Bitfields for Intel 82378/82379 ISA Address Decoder Control Register:
Bit(s)	Description	(Table 01069)
 7-4	ISA memory cycle forwarding to PCI
	0000-1111 = 1M-16M top of ISA memory; any accesses above programmed
		  limit are forwarded to PCI bus
 3-0	ISA/DMA memory cycle to PCI bus enables
	bit 3: 896K-960K (E000h-EFFFh)
	bit 2: 640K-768K (A000h-BFFFh)
	bit 1: 512K-640K (8000h-9FFFh)
	bit 0: 0K-512K	 (0000h-7FFFh)
SeeAlso: #01064,#01070

Bitfields for Intel 82378/82379 ISA Address Decoder ROM Block Enable:
Bit(s)	Description	(Table 01070)
 7	enable 880K-896K (EC00h-EFFFh)
 6	enable 864K-880K (E800h-EBFFh)
 5	enable 848K-864K (E400h-E7FFh)
 4	enable 832K-848K (E000h-E3FFh)
 3	enable 816K-832K (DC00h-DFFFh)
 2	enabel 800K-816K (D800h-DBFFh)
 1	enable 784K-800K (D400h-D7FFh)
 0	enable 768K-784K (D000h-D3FFh)
Note:	ISA accesses within any enabled ranges are forwarded to the PCI bus
SeeAlso: #01064,#01069

Bitfields for Intel 82378/82379 ISA Clock Divisor Register:
Bit(s)	Description	(Table 01071)
 7	reserved (0)
 6	enable positive decode of upper 64K BIOS at 000F0000h-000FFFFFh,
	  FFEF0000h-FFEFFFFFh, and FFFF0000h-FFFFFFFFh
 5	coprocessor error enable
	=1 FERR# is driven onto IRQ13
 4	IRQ12/Mouse Function Enable
	=0 standard IRQ12
	=1 mouse
 3	RSTDRV enable
	=1 assert RSTDRV until this bit cleared (for use in changing ISA bus
	  speed)
 2-0	PCICLK-to-ISA SYSCLK divisor
	000	4
	001	3
	other	reserved
SeeAlso: #01064,#01069

Bitfields for Intel 82378/82379 Utility Bus Chip Select A Register:
Bit(s)	Description	(Table 01072)
 7	extended BIOS enable (decode accesses to FFF80000h-FFFDFFFFh)
 6	lower BIOS enable (decode accesses to E0000h-EFFFFh,
	  FFEE0000h-FFEEFFFFh, and FFFE0000h-FFFEFFFFh)
 5	(82378ZB) floppy disk primary/secondary address select
	=1 use secondary address range
 4	(82378ZB) IDE Decode enable
 3,2	floppy disk address locations enable
 1	keyboard controller address location enable
	enables I/O addresses 60h,62h,64h,66h (82378ZB) or 60h/64h (82379AB)
 0	RTC address location enabled
	=1 enable decode of I/O ports 70h-77h
SeeAlso: #01064,#01089,#01073

Bitfields for Intel 82378ZB/82379 Utility Bus Chip Select B Register:
Bit(s)	Description	(Table 01073)
 7	configuration RAM decode enable
	=1 permit write accesses to I/O port 0C00h and r/w to ports 08xxh
 6	enable PORT 0092h
 5-4	parallel port enable
	00 LPT1 (ports 03BCh-03BFh)
	01 LPT2 (ports 0378h-037Fh)
	10 LPT3 (ports 0278h-027Fh)
	11 disabled
 3-2	serial port B enable
	00 COM1 (03F8h-03FFh)
	01 COM2 (02F8h-02FFh)
	10 reserved
	11 port B disabled
 1-0	serial port A enable
	00 COM1 (03F8h-03FFh)
	01 COM2 (02F8h-02FFh)
	10 reserved
	11 port A disabled
Note:	if both serial ports are set to the same address, port B is disabled
SeeAlso: #01064,#01072,PORT 0092h

Bitfields for Intel 82378/82379 MEMCS# Attribute Register 1/2/3:
Bit(s)	Description	(Table 01074)
 7	write-enable xC000h-xFFFFh expansion ROM
 6	read-enable xC000h-xFFFFh expansion ROM
 5	write-enable x8000h-xBFFFh expansion ROM
 4	read-enable x8000h-xBFFFh expansion ROM
 3	write-enable x4000h-x7FFFh expansion ROM
 2	read-enable x4000h-x7FFFh expansion ROM
 1	write-enable x0000h-x3FFFh expansion ROM
 0	read-enable x0000h-x3FFFh expansion ROM
Note:	x = C/D/E depending on the attribute register
SeeAlso: #01064

Bitfields for Intel 82378ZB Scatter Gather Relocation Base Address:
Bit(s)	Description	(Table 01075)
 7-0	bits 15-8 of base address for scatter/gather I/O ports
	(default 04h; low 8 bits of address are always 10h-3Fh)
SeeAlso: #01064,#01074,#01076,PORT 040Ah"82378ZB",#P0039

Bitfields for Intel 82371/82378/82379 PCI IRQ Route Control Register:
Bit(s)	Description	(Table 01076)
 7	disable IRQ routing
 6-4	reserved (0)
 3-0	ISA IRQ number to which to route the PCI IRQ
Note:	IRQs 0-2, 8, and 13 are reserved
SeeAlso: #01064,#01167,#01100

Bitfields for Intel 82379AB PIC/APIC Configuration Control Register:
Bit(s)	Description	(Table 01077)
 7-2	reserved
 1	SMI Routing Control
	=1 SMI via APIC
	=0 SMI via SMI# signal
 0	INT Routing Control
	=1 INT disabled (requires that APIC be enabled)
	=0 INT enabled
SeeAlso: #01064,#01078

Bitfields for Intel 82379AB/82371 APIC Base Address Relocation:
Bit(s)	Description	(Table 01078)
 7	reserved
 6	(82379AB) reserved
 6	(82371) A12 mask
	=1 ignore address bit 12 in APIC address
 5-0	bits 15-10 of APIC memory address (ORed with FEC00000h to form base
	  address)
SeeAlso: #01064,#01167,#01077,MEM FEC00000h

Bitfields for Intel 82378/82379 SMI Control Register:
Bit(s)	Description	(Table 01079)
 7	reserved
 6	(82378) reserved
	(82379) require Stop Grant bus cycle before asserting STPCLK#
 5-4	reserved
 3	Fast-Off Timer freeze
 2	STPCLK# scaling enable
	=1 enable Clock Throttle bytes in PCI configuration space
 1	STPCLK# signal enable
	=1 assert STPCLK# on read from PORT 00B2h
 0	SMI# Gate
	=1 enable SMI# on system management interrupt
Notes:	bit 1 is cleared either with an explicit write of 0 here, or by any
	  write to PORT 00B2h
	bit 0 does not affect the recording of SMI events, so a pending SMI
	  will cause an immediate SMI# when the bit is set
SeeAlso: #01064,#01080,#01081,#01222,PORT 00B2h

Bitfields for Intel 82371/82378/82379 SMI Enable Register:
Bit(s)	Description	(Table 01080)
 15-9	reserved
 8	(82371SB only) Legacy USB SMI enable
 7	APMC Write SMI enable
	=1 generate SMI on write to PORT 00B2h
 6	EXTSMI# SMI enable
 5	Fast-Off Timer SMI enable
 4	IRQ12 (PS/2 mouse) SMI enable
 3	IRQ8 (RTC alarm) SMI enable
 2	IRQ4 (COM1/COM3) SMI enable
 1	IRQ3 (COM2/COM4) SMI enable
 0	IRQ1 (keyboard) SMI enable
SeeAlso: #01064,#01079,#01081,#01167,PORT 00B2h

Bitfields for Intel 82371/82378/82379 System Event Enable Register:
Bit(s)	Description	(Table 01081)
 31	Fast-Off SMI enable (system and break events)
 30	(82379 only) Fast-Off Interrupt Enable (break events only)
 30	(82371 only) INTR enable (break events only)
 29	Fast-Off NMI enable (system and break events)
 28	(82371SB only) Fast-Off APIC enable (break events only)
 27	(82379 only) Fast-Off COM enable (system events only)
 26	(82379 only) Fast-Off LPT enable (system events only)
 25	(82379 only) Fast-Off Drive enable (system events only)
 24	(82379 only) Fast-Off DMA enable (system events only)
 23-16	reserved
 15-3	Fast-Off IRQ (15-3) enable (system and break events)
 2	reserved
 1-0	Fast-Off IRQ (1-0) enable (system and break events)
Note:	any enabled system event restarts the Fast-Off Timer, thus preventing
	  a Fast-Off powerdown; any enabled break event awakens the system from
	  powerdown
SeeAlso: #01064,#01079,#01080,#01082,#01167

Bitfields for Intel 82371/82378/82379 SMI Request Register:
Bit(s)	Description	(Table 01082)
 15-9	reserved
 8	(82371SB only) Legacy USB SMI status
 7	APM SMI Status (write to PORT 00B2h triggered SMI)
 6	EXTSMI# SMI Status (EXTSMI# line triggered SMI)
 5	Fast-Off Timer expired
 4	IRQ12 triggered SMI
 3	IRQ8 triggered SMI
 2	IRQ4 triggered SMI
 1	IRQ3 triggered SMI
 0	IRQ1 triggered SMI
Note:	software must explicitly reset the appropriate bits
SeeAlso: #01064,#01081,#01167

Format of PCI Configuration data for Intel 82425EX PSC:
Offset	Size	Description	(Table 01083)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 0486h)
 40h	BYTE	PCI control register (see #01084)
 41h  3 BYTEs	???
 44h	BYTE	host device control register (see #01085)
 45h  3 BYTEs	???
 48h	WORD	PCI local-bus IDE control register (see #01086)
 4Ah  2 BYTEs	???
 4Ch	BYTE	ISA I/O recovery timer register (see #01087)
 4Dh	BYTE	part revision register (see #01088)
 4Eh	BYTE	X-bus Chip Select A register (see #01089)
 4Fh	BYTE	X-bus Chip Select B register??? (see also #01102)
 50h	BYTE	host select register
 51h	BYTE	deturbo frequency control register
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
 52h	WORD	secondary (L2) cache control register
 54h  2 BYTEs	???
 56h	WORD	DRAM control register
 58h	BYTE	???
 59h  7 BYTEs	Programmable Attribute Map (PAM) registers 0-6 (see also #01118)
 60h  5 BYTEs	DRAM row boundary registers 0-4
		each register N indicates amount of memory in rows 0-N (each
		  row is 64 bits wide); the fifth row of memory (if
		  implemented) must contain either 8M or 16M, depending on
		  system configuration
		boundary register 4 (offset 64h) contains the total system
		  memory, which may not exceed 128M
 65h	BYTE	???
 66h	BYTE	PIRQ route control register 0
 67h	BYTE	PIRQ route control register 1
 68h	BYTE	DRAM memory hole register
 69h	BYTE	top of memory
 6Ah  6 BYTEs	???
 70h	BYTE	SMRAM control register
 71h 47 BYTEs	unused???
 A0h	BYTE	SMI control register
 A1h	BYTE	???
 A2h	WORD	SMI enable register
 A4h	DWORD	system event enable
 A8h	BYTE	fast off timer register
 A9h	BYTE	???
 AAh	WORD	SMI request register
 ACh	BYTE	clock throttle STPCLK# low timer
 ADh	BYTE	unused???
 AEh	BYTE	clock throttle STPCLK# high timer
 AFh	BYTE	???
 B0h 80 BYTEs	unused???
SeeAlso: #00878,#01063,#01055,#01108,#01167

Bitfields for Intel 82425EX PCI control register:
Bit(s)	Description	(Table 01084)
 0	CPU-to-PCI byte merging
 1	CPU-to-PCI bursting enable
 2	PCI posted-write buffer enable
 4-3	subtractive decode sampling point
	00 slow
	01 typical
	10 fast
	11 reserved
 5	DRAM parity error enable
 6	target abort error enable
 7	reserved
SeeAlso: #01083,#01085,#01086,#01087

Bitfields for Intel 82425EX host device control register:
Bit(s)	Description	(Table 01085)
 0	HRDY# maximum signal sampling point
	0 slow timing
	1 fast timing
 1	HDEV# signal sampling point
	0 slow timing
	1 fast timing
 2	host device present
 7-3	reserved
SeeAlso: #01083,#01084

Bitfields for Intel 82425EX local-bus IDE control register:
Bit(s)	Description	(Table 01086)
 1-0	primary/secondary PCI IDE enable
	00 IDE disabled
	01 primary (ports 01F0h-01F7h,03F6,03F7h)
	10 secondary (ports 0170h-017Fh,0376h,0377h)
	11 reserved
 3-2	fast timing bank drive select 1
	bit 2 = drive 0 enabled
	bit 3 = drive 1 enabled
 5-4	IORDY sample point Enable Drive Select
	bit 4 = drive 0 enabled
	bit 5 = drive 1 enabled
 7-6	reserved
 9-8	IORDY sample point
	00 6 clocks
	01 5 clocks
	10 4 clocks
	11 3 clocks
 12-10	recover time (000 = 8 PCI clocks, 001 = 7, ..., 101 = 3, 110/111 = 3)
 15-13	reserved
SeeAlso: #01083,#01084

Bitfields for Intel chipset ISA I/O recovery timer register:
Bit(s)	Description	(Table 01087)
 7	(82425EX/82371) DMA reserved page register aliasing disable
	=0 ports 0090h-009Fh alias ports 0080h-008Fh
	=1 ports 0090h-009Fh forwarded to ISA bus
 6	8-bit I/O recovery enable
 5-3	8-bit I/O recovery time
	000 = 8 SYSCLKs
	001-110 = 1-7 SYSCLKs
 2	16-bit I/O recovery enable
 1-0	16-bit I/O recovery time
	00 = 4 SYSCLKs
	01-11 = 1-3 SYSCLKs
SeeAlso: #01064,#01083,#01084,#01167,#01170

Bitfields for Intel 82425EX part revision register:
Bit(s)	Description	(Table 01088)
 7-5	fabrication house identifier (read-only)
 4	E0000h-EFFFFh ISA-to-main-memory forwarding enabled
 3-0	revision ID (read-only)
SeeAlso: #01083,#01089

Bitfields for Intel 82425EX/82371 X-bus Chip Select A register:
Bit(s)	Description	(Table 01089)
 7	extended BIOS enabled at FFF80000h-FFFDFFFFh
 6	lower (E000h) BIOS enabled
 5	trigger IRQ13 on FERR#
 4	IRQ12 mouse function enabled
 3	(82371AB only) alias accesses to PORTs 63h/65h/67h to 61h
	(else) reserved (0)
 2	BIOS memory write protect
 1	keyboard controller addresses (60h,62h,64h,66h) enabled
 0	RTC addresses (70h-77h) enabled
SeeAlso: #01083,#01167,#01088,#01102

Format of PCI Configuration Data for Intel 82380AB PCI-ISA Bridge:
Offset	Size	Description	(Table 01090)
 00h 64 BYTEs	header (see #00878)
		(vender ID 8086h, device ID 123Ch)
 40h	BYTE	I/O Recovery Register (see #01091)
 41h	BYTE	reserved
 42h	BYTE	MISA Error Status (see #01092)
 43h 189 BYTEs	reserved
SeeAlso: #00873,#01093

Bitfields for Intel 82380AB I/O Recovery Register:
Bit(s)	Description	(Table 01091)
 7	SYSCLK select
	0 SYSCLK = PCICLK/4
	1 SYSCLK = PCICLK/3
 6	enable 8-bit I/O recovery
 5-3	additional recovery time for 8-bit I/O cycles, in SYSCLKs
 2	enable 16-bit I/O recovery
 1-0	additional recovery time for 16-bit I/O cycles, in SYSCLKs
SeeAlso: #01090

Bitfields for Intel 82380AB MISA error status:
Bit(s)	Description	(Table 01092)
 7-3	reserved
 2	IOCHK# asserted
 1	reserved
 0	illegal byte lane combination for PCI I/O detected
SeeAlso: #01090

Format of PCI Configuration data for Intel 82380FB PCI-PCI Bridge (MPCI2):
Offset	Size	Description	(Table 01093)
 00h 64 BYTEs	header type 1 [bridge] (see #00878)
		(vendor ID 8086h, device ID 124Bh)
 40h	BYTE	Connector Control (see #01094)
 41h	BYTE	Connector Event (see #01095)
 42h  2 BYTEs	reserved
 44h	WORD	Serial Bus Interface/Burst Enable (see #01096)
 46h	BYTE	MPCI2 Miscellaneous Status (see #01097)
 47h  5 BYTEs	reserved
 4Ch	WORD	Special Message Encode
		encoded message portion of Special Cycle forwarded by MPCI2
 4Eh 178 BYTEs	reserved
SeeAlso: #00873,#01090

Bitfields for Intel 82380FB Connector Control register:
Bit(s)	Description	(Table 01094)
 7-4	reserved
 3	QEN2 output signal
 2	QEN1 output signal
 1-0	reserved
SeeAlso: #01093

Bitfields for Intel 82380FB Connector Event register:
Bit(s)	Description	(Table 01095)
 7	reserved (1)
 6	activate power-no suspend
 5	(read-only) inverted state of MISAEN pin
 4	(read-only) inverted state of DSTYP pin
 3	undocking permit
	software should set this bit for at least 32 microseconds; when this
	  bit is then cleared, the MPCI2 pulses the OPENACK signal for 256 us
	  to tell external hardware to "eject" the notebook
 2	reserved (1)
 1	system is docked
 0	open requested
SeeAlso: #01093

Bitfields for Intel 82380FB Serial Interface/Burst Enable register:
Bit(s)	Description	(Table 01096)
 15-13	reserved
 12	enable SERR# on discarding of posted write data
 11	reserved
 10	SDATA signal direction (0 = output, 1 = input)
 9	enable write posting
 8	enable read bursting
 7	enable upstream blind prefetching
 6	reserved
 5	SDATA signal state (read when bit 10 set, write when bit 10 clear)
 4	SDIN signal state
 3	do not pulse P_SERR# when S_PERR# is asserted
 2	cascade/frame determination delay (0 = 20 P_CLKs, 1 = 10 P_CLKs)
 1	serial EEPROM chip select
 0	serial EEPROM clock
SeeAlso: #01093

Bitfields for Intel 82380FB MPCI2 Miscellaneous Status register:
Bit(s)	Description	(Table 01097)
 7-1	reserved
 0	(write-clear) P_SERR# was asserted due to invalidation of posted write
SeeAlso: #01093

Format of PCI Configuration Data for Intel 82439HX:
Offset	Size	Description	(Table 01098)
 00h 64 BYTEs	header (see #00878)
		(vender ID 8086h, device ID 1250h)
		(revision ID 00h = A0 stepping)
 40h 16 BYTEs	reserved
 50h	BYTE	PCI Control (see #01110)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #01112)
 53h  3 BYTEs	reserved
 56h	BYTE	DRAM extended control (see #01115)
 57h	BYTE	DRAM control (see #01116)
 58h	BYTE	DRAM timing (see #01117)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #01118)
 60h  8 BYTEs	DRAM Row Boundary registers 0-7
		each register N indicates cumulative amount of memory in rows
		  0-N (each 64 bits wide), in 4M units
 68h	BYTE	DRAM Row Type (see #01119)
		bits 0-7 indicate whether each row 0-7 contains EDO DRAM
		  instead of page-mode DRAM
 69h	BYTE	???
 6Ah  8 BYTEs	reserved
 72h	BYTE	System Management RAM control (see #01123)
 73h 29 BYTEs	reserved
 90h	BYTE	Error Command (see #01126)
 91h	BYTE	Error Status (see #01127) (read-only)
 92h	BYTE	Error Syndrome (read-only)
		latest non-zero ECC error syndrome
 93h 109 BYTEs	reserved
SeeAlso: #01108,#01229

Format of PCI Configuration Data for Intel 82439TX "MTXC":
Offset	Size	Description	(Table 01099)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 7100h)
		(revision ID 00h = A0 stepping)
 40h 15 BYTEs	reserved
 4Fh	BYTE	Arbitration Control register (see #01109)
 50h	BYTE	PCI Control register (see #01110)
 51h	BYTE	reserved
 52h	BYTE	Cache Control register (see #01112)
 53h	BYTE	Extended Cache Control register (see #01113)
 54h	WORD	SDRAM Control Register (see #01114)
 56h	BYTE	DRAM Extended Control register (see #01115)
 57h	BYTE	DRAM Control register (see #01116)
 58h	BYTE	DRAM Timing register (see #01117)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #01118)
 60h  6 BYTEs	DRAM Row Boundary registers 0-5
		each register N indicates cumulative amount of memory in rows
		  0-N (each 64 bits wide), in 4M units
 66h	BYTE	reserved
 67h	BYTE	DRAM Row Type High register (see #01213)
 68h	BYTE	DRAM Row Type Low register (see #01119)
 69h  7 BYTEs	reserved
 70h	BYTE	Multi-Transaction Timer register
		number of PCLKs guaranteed to the current agent before the
		  82439TX will grant the bus to another PCI agent on request
 71h	BYTE	Extended System Management RAM Control register (see #01149)
 72h	BYTE	System Management RAM Control register (see #01123)
 73h  6 BYTEs	reserved
 79h	BYTE	Miscellaneous Control register (see #01128)
 7Ah 134 BYTEs	reserved
Note:	The Intel 82439TX chipset uses PCI configuration mechanism #1
SeeAlso:  #00873,PORT 0CF8h

Format of PCI Configuration Data for Intel 82371AB (PIIX4), ISA Bridge:
Offset	Size	Description	(Table 01100)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 7110h)
 40h 12 BYTEs	reserved
 4Ch	BYTE	ISA I/O recovery timer (see #01101)
 4Dh	BYTE	reserved
 4Eh	WORD	X-Bus Chip Select (see #01089,#01102)
 50h 16 BYTEs	reserved
 60h	BYTE	PIRQA route control (see #01076)
 61h	BYTE	PIRQB route control (see #01076)
 62h	BYTE	PIRQC route control (see #01076)
 63h	BYTE	PIRQD route control (see #01076)
!!!intel\29056201.pdf p.59
 64h	BYTE	serial IRQ control
 65h  4 BYTEs	reserved???
 69h	BYTE	top of memory
 6Ah	WORD	miscellaneous status
 6Ch 10 BYTEs	reserved???
 76h	BYTE	motherboard device DMA control 0
 77h	BYTE	motherboard device DMA control 1
 78h  9 BYTEs	reserved???
 80h	BYTE	APIC base address relocation
 81h	BYTE	reserved???
 82h	BYTE	deterministic latency control
 83h 13 BYTEs	reserved???
 90h	WORD	PCI DMA configuration
 92h	WORD	distributed DMA (channels 0-3) slave base pointer
 94h	WORD	distributed DMA (channels 5-7) slave base pointer
 96h 26 BYTEs	reserved???
 B0h	DWORD	general configuration
 B4h 23 BYTEs	reserved???
 CBh	BYTE	real-time clock configuration
 CCh 52 BYTEs	reserved
SeeAlso: #00873,#01103,#01104,#01105

Bitfields for Intel PIIX4 ISA I/O recovery timer:
Bit(s)	Description	(Table 01101)
 7	disable aliasing PORTs 90h-9Fh into 80h-8Fh (except PORT 0092h)
 6	enable 8-bit I/O recover timer in bits 5-3
 5-3	additional 8-bit I/O recovery time (added to 3.5 SYSCLK minimum)
	000 = 8 SYSCLKs, else N SYSCLKs
 2	enable 16-bit I/O recovery timer in bits 1-0
 1-0	additional 16-bit I/O recovery time (added to 3.5 SYSCLK minimum)
	00 = 3 SYSCLKs
	01 = 1 SYSCLK
	10 = 2 SYSCLKs
	11 = 4 SYSCLKs
SeeAlso: #01100

Bitfields for Intel 82371 X-Bus Chip Select Enable (high byte):
Bit(s)	Description	(Table 01102)
 7-3	reserved
 2	(82371AB) enable positive PCI decode for Micro Controller at PORTs 62h
	  and 66h
 1	(82371AB) enable one-megabyte extended BIOS (FFF00000h-FFF7FFFFh are
	  forwarded to ISA bus, aliased to top of 16M region)
 0	enable I/O APIC
SeeAlso: #01089

Format of PCI Configuration Data for Intel 82371AB (PIIX4), IDE Controller:
Offset	Size	Description	(Table 01103)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 7111h)
 20h	DWORD	I/O base address (for 16 contiguous PORTs)
!!!intel\29056201.pdf p.89
 40h	WORD	primary channel timing register
 42h	WORD	secondary channel timing register
 44h	BYTE	slave IDE timing
 45h  3 BYTEs	reserved???
 48h	BYTE	Ultra DMA/33 control
 49h	BYTE	reserved???
 4Ah	WORD	Ultra DMA/33 timing
 4Ch 180 BYTEs	reserved
SeeAlso: #00873,#01100,#01104,#01105

Format of PCI Configuration Data for Intel 82371AB (PIIX4), USB Controller:
Offset	Size	Description	(Table 01104)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 7112h)
 20h	DWORD	I/O base address (for 32 contiguous PORTs)
!!!intel\29056201.pdf p.102
 40h 32 BYTEs	reserved
 60h	BYTE	USB specification release number
		00h pre-release 1.0
		10h release 1.0
 61h 95 BYTEs	reserved
 C0h	WORD	legacy support
 C2h 61 BYTEs	reserved
 FFh	BYTE	miscellaneous support
SeeAlso: #00873,#01100,#01103,#01105

Format of PCI Configuration Data for Intel 82371AB (PIIX4), Power Management:
Offset	Size	Description	(Table 01105)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 7113h)
 40h	DWORD	base address of power-management I/O ports
		(same format as PCI base addresses; low bit hardwired to 1)
 44h	DWORD	initial counts of device 0-11 idle timers
 48h	DWORD	!!!intel\29056201.pdf p.117
 4Ch	DWORD	general-purpose input control
 50h  3 BYTEs	"device resource D"
 53h	BYTE	unused???
 54h	DWORD	device activity event selection A
 58h	DWORD	device activity event selection B
 5Ch	DWORD	"device resource A"
 60h	DWORD	"device resource B"
 64h	DWORD	"device resource C"
 68h  3 BYTEs	"device resource E"
 6Bh  5 BYTEs	unused???
 70h  3 BYTEs	"device resource G"
 73h	BYTE	unused???
 74h	DWORD	"device resource H"
 78h	DWORD	"device resource I"
 7Ch	DWORD	"device resource J"
 80h	BYTE	miscellaneous power management
 81h 15 BYTEs	unused???
 90h	DWORD	base address for SMBus I/O ports
		(same format as PCI base addresses; low bit hardwired to 1)
 94h	...
 D2h	BYTE	SMBus host configuration
 D3h	BYTE	SMBus slave command
 D4h	BYTE	SMBus slave shadow port 1 address
 D5h	BYTE	SMBus slave shadow port 2 address
 D6h	BYTE	SMBus revision
 D7h
SeeAlso: #00873,#01100,#01103,#01104

Format of PCI Configuration Data for Intel 82437MX:
Offset	Size	Description	(Table 01106)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 1235h)
 40h 16 BYTEs	reserved
 50h	BYTE	PCI Control (see #01111)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #01112)
 53h  4 BYTEs	reserved
 57h	BYTE	DRAM Control (see #01116)
 58h	BYTE	DRAM timing (see #01117)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #01118)
 60h  4 BYTEs	DRAM Row Boundary Registers 0-3
		each register N indicates cumulative amount of memory in rows
		  0-N, in 4M units (each row is 64 bits wide)
 64h  4 BYTEs	reserved
 68h	BYTE	DRAM Row Type (see #01121)
 69h  9 BYTEs	reserved
 72h	BYTE	System Management RAM control (see #01123)
 73h 141 BYTEs	reserved
SeeAlso: #01108,#01107

Format of PCI Configuration Data for Intel 82437FX:
Offset	Size	Description	(Table 01107)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 122Dh) (see #00873)
 40h 16 BYTEs	reserved
 50h	BYTE	PCI Control (see #01111)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #01112)
 53h  4 BYTEs	reserved
 57h	BYTE	DRAM Control (see #01116)
 58h	BYTE	DRAM timing (see #01117)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #01118)
 60h  5 BYTEs	DRAM Row Boundary Registers 0-4
		each register N indicates cumulative amount of memory in rows
		  0-N, in 4M units (each row is 64 bits wide)
 65h  3 BYTEs	reserved
 68h	BYTE	DRAM Row Type (see #01121)
 69h  9 BYTEs	reserved
 72h	BYTE	System Management RAM control (see #01123)
 73h 141 BYTEs	reserved
SeeAlso: #01106,#01108

Format of PCI Configuration Data for Intel 82437VX:
Offset	Size	Description	(Table 01108)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 7030h)
		(revision ID 00h = A0 stepping)
 40h 15 BYTEs	reserved
 4Fh	BYTE	arbitration control (see #01109)
 50h	BYTE	PCI Control (see #01110)
 51h	BYTE	reserved
 52h	BYTE	cache control (see #01112)
 53h	BYTE	cache control extensions (see #01113)
 54h	WORD	SDRAM control (see #01114)
 55h	BYTE	reserved
 56h	BYTE	DRAM extended control (see #01115)
 57h	BYTE	DRAM control (see #01116)
 58h	BYTE	DRAM timing (see #01117)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #01118)
 60h  5 BYTEs	DRAM Row Boundary registers 0-4
		each register N indicates amount of memory in rows 0-N in 4M
		  units (each row is 64 bits wide); the fifth row of memory (if
		  implemented) must contain either 8M or 16M, depending on
		  system configuration
		boundary register 4 (offset 64h) contains the total system
		  memory, which may not exceed 128M
 65h  2 BYTEs	reserved
 67h	BYTE	DRAM Row Type (high)
		defines memory type in DRAM row 4 in bits 4,0 (see #01119)
 68h	BYTE	DRAM Row Type (low) (see #01119)
 69h	BYTE	PCI TRDY timer (see #01122)
 6Ah  6 BYTEs	reserved
 70h	BYTE	Multi-Transaction Timer
		number of PCLKs guaranteed to the current agent before the
		  82437 will grant the bus to another PCI agent on request
 71h	BYTE	reserved
 72h	BYTE	System Management RAM control (see #01123)
 73h	BYTE	shared memory buffer control (see #01124)
 74h	BYTE	shared memory buffer start address, in 0.5MB units
		end address is top-of-memory at offset 64h or start of an
		  enabled PCI memory hole when top-of-memory is 16M
 76h  2 BYTEs	reserved
 78h	BYTE	graphics controller latency timers (see #01125)
 79h 135 BYTEs	reserved
SeeAlso: #00873,#01063,#01083,#01098,#01106

Bitfields for Intel 82437VX,82439TX Arbitration Control register:
Bit(s)	Description	(Table 01109)
 7	extended CPU-to-PIIX PHLDA# signalling enabled
 6-0	(82439TX) reserved
 6-4	reserved
 3	(82437VX) CPU priority enable
	=1 CPU gets PCI bus after two PCI slots
	=0 CPU gets PCI bus after three PCI slots
 2-0	reserved
SeeAlso: #01099,#01108,#01110

Bitfields for Intel 82437VX,82439HX/TX PCI Control register:
Bit(s)	Description	(Table 01110)
 7-4	reserved (82437VX,82439TX)
 7	DRAM ECC/Parity Select (82439HX)
	=1 ECC
	=0 parity
 6	ECC TEST enable (82439HX)
 5	shutdown to port 92h (82439HX)
	=1 send 01h to PORT 0092h on Shutdown special cycle on host bus
 4	dual-processor NA# enable (82439HX)
 3	PCI Concurrency Enable
	=1 CPU can access DRAM/L2 during non-PIIX PCI master cycles
	=0 CPU kept off PCI bus during all PCI bus-master cycles
 2-0	reserved (82437VX,82439TX)
 2	SERR# Output Type (82439HX only)
	=1 SERR# is actively driven high when negated
	=0 SERR# is PCI-compatible open-drain output
 1	reserved
 0	Global TXC Enable (82439HX only)
	=1 enable new 82439HX features
SeeAlso: #01099,#01108,#01098,#01112,#01111

Bitfields for Intel 82437FX/82437MX PCI Control register:
Bit(s)	Description	(Table 01111)
 7-5	CPU inactivity timer (in PCI Clocks less 1)
 4	reserved
 3	enable PCI Peer Concurrency
	=1 CPU can access DRAM/L2 during non-PIIX PCI master cycles
	=0 CPU kept off PCI bus during all PCI bus-master cycles
 2	disable PCI Bursting
 1	disable PCI Streaming
 0	disable Bus Concurrency
SeeAlso: #01106,#01107,#01110

Bitfields for Intel 82437,82439HX/TX cache control register:
Bit(s)	Description	(Table 01112)
 7-6	secondary cache size
	00 none
	01 256K
	10 512K
	11 reserved
 5-4	L2 RAM type
	00 pipelined burst SRAM/DRAM
	01 reserved
	10 asynchronous SRAM (82437FX/MX/VX,82439TX only)
	11 two banks of pipelined burst cache
 3	NA disable
	=1 never assert NA# pin
 2	reserved (82437FX/MX/VX,82439TX)
 2	Extended Cacheability Enable (82439HX)
	=1 cache up to 512M
	=0 cache only first 64M
 1	Secondary Cache Force Miss or Invalidate
	=1 force all memory accesses to bypass L2 cache
 0	First Level Cache Enable
	=1 all memory accesses made non-cacheable by CPU L1 cache
SeeAlso: #01099,#01108,#01098,#01110,#01113,#01114,#01106

Bitfields for Intel 82437VX,82439TX cache control extensions register:
Bit(s)	Description	(Table 01113)
 7-6	reserved
 5	DRAM cache detected (read-only)
 4-0	DRAM cache refresh timer
	number of HCLKs 82437VX,82439TX remains idle during DRAM cache refresh
SeeAlso: #01099,#01108,#01112

Bitfields for Intel 82437VX,82439TX SDRAM control register:
Bit(s)	Description	(Table 01114)
 15-9	reserved
 8-6	Special SDRAM Mode Select
	000 normal mode (default)
	001 enable NOP command
	010 enable All Banks Precharge command
	011 enable Mode Register Command
	100 enable CBR Cycle
	101 reserved
	11x reserved
 5	(82437VX) reserved
 5	(82439TX) RAS# to CAS# Override
	=1 and CAS# latency=0, RAS# to CAS# is delayed 2 HCLKs
	=0 RAS# to CAS# delay determined solely by CAS# latency setting
 4	CAS# latency
	=1 latency is 2 for all SDRAM cycles
	=0 latency is 3
 3	RAS# precharge and refresh timing
	=0 slower
	=1 faster
 2	reserved
 1	(82437VX) reserved
 1	(82439TX) 64-Mbit Technology Enable
	=1 supports 64M-bit SDRAM devices
	=0 supports 64M-bit EDO/FPM devices only
 0	reserved
SeeAlso: #01099,#01108,#01112

Bitfields for Intel 82437VX,82439HX/TX DRAM extended control register:
Bit(s)	Description	(Table 01115)
 7	reserved
 6	(VX/TX) refresh RAS# assertion length (0=4 clocks, 1=5 clocks)
 5	(VX/TX) Fast EDO Path Select
 4	Speculative Leadoff Disable
 3	(82439HX) Turn-Around Insertion Enable
	=1 insert one extra clock of turnaround time after asserting MWE#
 2-1	Memory Address Drive Strength
	82437VX:	     82439HX:		       82439TX:
	  00 reserved	       00 8mA			 00 10mA/10mA (MA/MWE#)
	  01 10mA (default)    01 8mA/12mA (MAA/MWE#)	 01 10mA/16mA (MA/MWE#)
	  10 16mA	       10 12mA/8mA (MAA/MWE#)	 10 16mA/10mA (MA/MWE#)
	  11 reserved	       11 12mA			 11 16mA/16mA (MA/MWE#)
 0	(82437VX) DRAM Symmetry Detect Mode
	(used to force some memory address lines to fixed value for detecting
	  DRAM symmetry row-by-row)
 0	(82439HX) 64MBit Mode Enable
	=1 enable support for 64M SIMMs
 0	(82439TX) reserved
SeeAlso: #01099,#01108,#01098,#01116

Bitfields for Intel 82437,82439HX/TX DRAM control register:
Bit(s)	Description	(Table 01116)
 7-6	DRAM Hole Enable
	00 none
	01 512K-640K
	10 15M-16M (82437FX/MX/VX only)
	11 14M-16M (82437VX,82439TX only)
 5	reserved
 4	(82437MX only) refresh type during Suspend
	=1 self-refreshing DRAMs in system
	=0 CAS-before-RAS refresh
	(82439TX only) Enhanced Paging disabled
 3	EDO Detect Mode enable
	(used to detect whether memory is EDO bank-by-bank)
 2-0	DRAM refresh rate
	     FX/VX/HX	 MX	     TX
	000  disabled	 15.6 us     disabled
	001  50 MHz	 31.2 us     15.6 us
	010  60 MHz	 62.4 us     31.2 us
	011  66 MHz	 125 us	     64.4 us
	100  reserved	 250 us	     125 us
	101  reserved	 reserved    256 us
	1xx  reserved	 reserved    reserved
SeeAlso: #01099,#01108,#01098,#01115,#01106

Bitfields for Intel 82437FX/MX/VX,82439HX/TX DRAM timing register:
Bit(s)	Description	(Table 01117)
 7	(82437FX,82439TX) reserved
 7	(82437MX) MA[11:2] buffer strength
	=0 8mA
	=1 12mA
 7	(82437VX) MA-to-RAS# Delay
	=1 one clock
	=0 two clocks
 7	(82439HX) Turbo Read Leadoff
	=1 bypass first register in DRAM data pipeline, saving one clock
	(may only be set in a cacheless configuration)
 6-5	DRAM Read Burst Timing
	00 x444 (EDO and Standard Page Mode)
	01 x333 (EDO), x444 (SPM)
	10 x222 (EDO), x333 (SPM)
	11 x322 (EDO), x333 (SPM) (82437VX only)
	11 reserved (other)
 4-3	DRAM Write Burst Timing
	00 x444
	01 x333
	10 x222
	11 reserved
 2	(82439TX) reserved
 2	RAS-to-CAS Delay
	=1 two clocks
	=0 three clocks
 1-0	DRAM Leadoff Timing
	82437FX/MX  Read Leadoff  Write Leadoff	 RAS# Precharge
	  00		8	    6		   3
	  01		7	    5		   3
	  10		8	    6		   4
	  11		7	    5		   4
	82437VX,82439TX	 Read  Write Leadoff  RAS# Precharge
	  00	       11	    7		   3
	  01	       10	    6		   3
	  10	       11	    7		   4
	  11	       10	    6		   4
	82439HX	 Read Leadoff  Write Leadoff  RAS# Precharge
	  00		7	    6		   3
	  01		6	    5		   3
	  10		7	    6		   4
	  11		6	    5		   4
SeeAlso: #01099,#01108,#01116,#01106,#01107

Bitfields for Intel 8243x/8244x Programmable Attribute Map Register:
Bit(s)	Description	(Table 01118)
 7	reserved
 6	cache enable (region 1)
 5	write enable (region 1)
 4	read enable (region 1)
 3	reserved
 2	cache enable (region 0)
 1	write enable (region 0)
 0	read enable (region 0)
Notes:	each programmable attribute map register controls two memory
	  regions at the top of the first megabyte of memory
	for the Intel 82441FX and 82443BX/LX, bits 6 and 2 are reserved, as
	  cacheability is set using the Pentium Pro/II/Celeron's MTRR registers
	  (see MSR 000000FEh)
	Intel 82434,82437FX/MX/VX,82439HX,82441FX,82443EX/LX PAM
	  registers/regions:
		PAM0 low: reserved [*]
		PAM0 hi:  segment F000-FFFF
		PAM1 low: segment C000-C3FF
		PAM1 hi:  segment C400-C7FF
		PAM2 low: segment C800-CBFF
		PAM2 hi:  segment CC00-CFFF
		PAM3 low: segment D000-D3FF
		PAM3 hi:  segment D400-D7FF
		PAM4 low: segment D800-DBFF
		PAM4 hi:  segment DC00-DFFF
		PAM5 low: segment E000-E3FF
		PAM5 hi:  segment E400-E7FF
		PAM6 low: segment E800-EBFF
		PAM6 hi:  segment EC00-EFFF
	[*] on the 82434 (and possibly other Intel chipsets), the low nybble of
	  PAM0 controls segment 8000-9FFF
SeeAlso: #01055,#01108,#01098,#01099,#01229,#01106,#01107,#01142,#01129

Bitfields for Intel 82437VX,82439TX DRAM Row Type register:
Bit(s)	Description	(Table 01119)
 7,3	row 3 type
 6,2	row 2 type
 5,1	row 1 type
 4,0	row 0 type
	00 SPM DRAM
	01 EDO DRAM
	10 SDRAM
	11 reserved
SeeAlso: #01099,#01108,#01118,#01213

Bitfields for Intel 82439TX DRAM Row Type high register:
Bit(s)	Description	(Table 01213)
 7	Host Frequency detection
	=1 66MHz Bus
	=0 60MHz bus
 5,1	DRAM Row 5 type
 4,0	DRAM ROW 4 type
	00 SPM
	01 EDO
	10 SDRAM
	11 reserved
 6,3	reserved
 2	Memory Address select Enabled
SeeAlso: #01099,#01119

Bitfields for Intel 82437FX/82437MX DRAM Row Type register:
Bit(s)	Description	(Table 01121)
 7-4	reserved
 3-0	DRAM Row N is EDO instead of page-mode DRAM
SeeAlso: #01106,#01107

Bitfields for Intel 82437VX PCI TRDY timer:
Bit(s)	Description	(Table 01122)
 7-3	reserved
 2-0	TRDY timeout value
	000 2 PCICLKs
	001 4 PCICLKs
	010 6 PCICLKs
	011 8 PCICLKs
	1xx reserved
SeeAlso: #01108,#01123

Bitfields for Intel 82437,82439HX/TX,82443BX/EX/LX SMRAM control register:
Bit(s)	Description	(Table 01123)
 7	reserved
 6	SMM Space Open
	=1 make SMM DRAM visible even when not in SMM if bit 4 =0
 5	SMM Space Closed
	=1 no data references permitted to SMM DRAM even in SMM
 4	SMM Space Locked
	=1 force bits 4 and 6 to become read-only; and clear bit 6
 3	SMRAM Enable
	=1 128K DRAM are accessible for use at A000 while in SMM
 2-0	SMM Space Base Segment
	010 segment A000-BFFF
	100 segment C000-CFFF (82437MX,82443EX only)
	other reserved
Note:	bits 5 and 6 must never both be set at the same time
SeeAlso: #01099,#01108,#01098,#01124,#01106,#01107,#01142,#01129

Bitfields for Intel 82437VX Shared Memory Buffer control register:
Bit(s)	Description	(Table 01124)
 7-2	reserved
 1	enable shared memory buffer
 0	redirect shared memory buffer access
	=0 treat SMB area as a hole in system DRAM
SeeAlso: #01108,#01123,#01125

Bitfields for Intel 82437VX Graphics Controller Latency Timer:
Bit(s)	Description	(Table 01125)
 7-6	reserved
 5-3	GC latency for PCI reads (in 4 HCLK multiples) (default=100)
 2-0	GC latency for CPU and PCI writes (in 4 HCLK multiples) (default=011)
SeeAlso: #01108,#01124

Bitfields for Intel 82439HX Error Command register:
Bit(s)	Description	(Table 01126)
 7	SERR# duration
	=0 one PCI clock
	=1 until error flags are cleared
 6-3	reserved
 2	force bad parity on multiple-bit uncorrectable error
 1	assert SERR# on multiple-bit uncorrectable error
 0	assert SERR# on single-bit correctable error
SeeAlso: #01098,#01127

Bitfields for Intel 82439HX Error Status register:
Bit(s)	Description	(Table 01127)
 7-5	DRAM row associated with multi-bit error
 4	multi-bit uncorrectable error occurred (write 1 bit to clear)
 3-1	DRAM row associated with single-bit correctable error
 0	single-bit correctable error occurred (write 1 bit to clear)
SeeAlso: #01098,#01126

Bitfields for Intel 82439TX miscellaneous control register:
Bit(s)	Description	(Table 01128)
 7	reserved
 6	ACPI control register enable
 5	Suspend refresh type (EDO/FPM DRAM only)
	=1 Self refresh (Always for SDRAM)
	=0 CBR refresh
 4	Normal refresh enable
	When set to 1, 82439TX switches from suspend refresh to normal refresh
 3	reserved
 2	Internal clock control disable
	=1 disable
	=0 enable  Disables 82439TX internal clocks during suspend, reducing
	  power consumption.
 1-0	reserved
SeeAlso: #01099

Format of PCI configuration for Intel 82443EX/LX Device 0 (Host-PCI):
Offset	Size	Description	(Table 01129)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 7180h)
		chipset is 82443EX if revision >= 03h
 40h 16 BYTEs	reserved
 50h	WORD	PAC Configuration register (See #01131)
 52h	BYTE	reserved
 53h	BYTE	Data Buffer Control register (see #01132)
 54h	BYTE	reserved
 55h	WORD	DRAM Row Type register (see #01133)
 57h	BYTE	DRAM Control register (see #01134)
 58h	BYTE	DRAM Timing register (see #01135)
 59h  7 BYTEs	PAM Configuration registers 0-6 (See #01118)
 60h  8 BYTEs	DRAM Row Boundary registers 0-7
		each register indicates top of memory for a particular row, in
		  8MB units; DIMMs use two rows each, with single-sided DIMMs
		  leaving the odd-numbered rows unpopulated
 68h	BYTE	Fixed DRAM Hole Control register (see #01147)
 69h	BYTE	reserved
 6Ah	WORD	DRAM Extended Mode Select register (see #01136)
 6Ch	DWORD	Memory Buffer Strength Control register (see #01137)
 70h	BYTE	Multi-Transaction Timer register (see #01140)
 71h	BYTE	reserved
 72h	BYTE	System Management RAM Control register (see #01123)
 73h 29 BYTEs	reserved
 90h	BYTE	Error Command register (see #01156)
 91h	BYTE	Error Status 0 register (see #01138)
 92h	BYTE	Error Status 1 register (see #01139)
 93h	BYTE	Reset Control Register (see #01239)
 94h 12 BYTEs	reserved
 A0h	DWORD	AGP Capability register (see #01158)
 A4h	DWORD	AGP Status register (see #01159)
 A8h	DWORD	AGP Command register (see #01160)
 ACh  4 BYTEs	reserved
 B0h	DWORD	AGP Control register (see #01161)
 B4h	BYTE	Arpeture Size Control register (see #01162)
 B5h  3 BYTEs	reserved
 B8h	DWORD	Arpeture Translation Table Base register (see #01163)
 BCh	BYTE	AGP MTT Control register (see #01140)
 BDh	BYTE	AGP Low Priority Transaction timer register (see #01141)
 BCh 67 BYTEs	reserved
Notes:	The 82443EX is virtually identical to the 82443LX, except that it does
	  not support ECC type DRAM.
	The Intel 82443EX/LX chipsets use PCI configuration mechanism #1
SeeAlso: #01130,#01142,PORT 0CF8h

Format of PCI configuration for Intel 82443EX/LX Device 1 (PCI-PCI):
Offset	Size	Description	(Table 01130)
 00h 64 BYTEs	header, type 1 [bridge] (see #00878)
		(vendor ID 8086h, device ID 7181h)
		chipset is 82443EX if revision >= 03h
 40h 192 BYTEs	reserved
Note:	The Intel 82443LX chipset uses PCI configuration mechanism #1
SeeAlso: #01129,#01143,PORT 0CF8h

Bitfields for Intel 82443EX/LX (Device 0) PAC Configuration register:
Bit(s)	Description	(Table 01131)
 15	WSC# Handshake Disable
 14	(82443LX) Host Frequency (read-only)
	=1 60MHz
	=0 66MHz
 14	(82443EX) reserved
 13-12	reserved
 11	??? (Not documented by Intel!)
 10	PCI Agent to Arperture Access Disable
 9	Aperture Access Global Enable
 8-6	(82443EX) reserved
 8-7	(82443LX) DRAM Data Integrety Mode
	00  Non-ECC (no check, no correct)
	01  EC-only (do check, no correct)
	10  reserved
	11 ECC (do check, do correct)
 6	(82443LX) ECC-Test Diagnostic Mode Enabled
 5	MDA Present
	Note:	Controls routing of Monochrome Display Adaptor I/O and memory
		  range accesses. Works in conjunction with the VGA-bit in
		  Bridge Control register of device 1 (see #00901):
		    VGA MDA
		    0	0	MDA and VGA routed to PCI bus
		    0	1	reserved
		    1	0	MDA and VGA routed to AGP bus
		    1	1	VGA routed to AGP bus, MDA routed to PCI bus
 4-0	reserved
SeeAlso: #00901,#01129

Bitfields for Intel 82443EX/LX (Device 0) Data Buffer Control register:
Bit(s)	Description	(Table 01132)
 7	reserved
 6	CPU-to-PCI posting enabled
 5	Write post during I/O Bridge access enabled
 4-0	reserved
SeeAlso: #01129

Bitfields for Intel 82443EX/LX (Device 0) DRAM Row Type register:
Bit(s)	Description	(Table 01133)
 15-14	row 7 type
	0 0  EDO	(Same values for each row)
	0 1  reserved
	1 0  SDRAM
	1 1  empty row
 13-12	row 6 type
 11-10	row 5 type
 9-8	row 4 type
 7-6	row 3 type
 5-4	row 2 type
 3-2	row 1 type
 1-0	row 0 type
SeeAlso: #01129,#01134

Bitfields for Intel 82443EX/LX (Device 0) DRAM Control register:
Bit(s)	Description	(Table 01134)
 7-6	reserved
 5	DRAM EDO Auto-Detect mode enabled
 4	SDRAM power management enabled
 3	reserved
 2-0	DRAM Refresh rate
	000 = Refresh disabled
	001 = Normal (Based on PAC Configuration bit 14)
	010-111 = reserved
SeeAlso: #01129,#01133,#01135

Bitfields for Intel 82443EX/LX (Device 0) DRAM Timing register:
Bit(s)	Description	(Table 01135)
 7	SDRAM RAS to CAS Delay	(1 = 2 clocks, 0 = 3 clocks)
 6	SDRAM CAS Latency	(1 = 2 clocks, 0 = 3 clocks)
 5	SDRAM RAS Precharge Time (1 = 2 clocks, 0 = 3 clocks)
 4	EDO DRAM Read Burst timing
	=1 Read rate is x222
	=0 Read rate is x333
 3	EDO DRAM Write Burst timing
	=1 Write rate is x222
	=0 write rate is x333
 2	EDO RAS Precharge Time	(1 = 3 clocks, 0 = 4 clocks)
 1	EDO RAS to CAS Delay	(1 = 2 clocks, 0 = 3 clocks)
 0	MA Wait State
	=1 Fast (0 wait states for SDRAM, clocks run normally for EDO)
	=0 Slow (1 wait state for SDRAM, add one clock to all EDO timings)
SeeAlso: #01129,#01134

Bitfields for Intel 82443EX/LX DRAM Extended Mode Select register:
Bit(s)	Description	(Table 01136)
 15-8	reserved
 7-5	Operating Mode
	000	Normal operating mode
	001	NOP command enabled
	010	All banks precharge enable
	011	Mode register set command enable
	100	CBR cycle enable
	101-11x reserved
 4	reserved
 3-2	Page timeout select
	00    16 clocks
	01-11 reserved
 1-0	Close both banks control
	00    close both banks on page misses
	01-11 reserved
SeeAlso: #01129

Bitfields for Intel 82443EX/LX Memory Buffer Strength Control register:
Bit(s)	Description	(Table 01137)
 31-30	MAA[1-0] buffer strength
	00  48mA (same values for bits 25-12,5-0)
	01  42mA
	10  22mA
	11  reserved
 29-28	(82443LX only) MECC[7-0] buffer strength
	00  42mA (same values for bits 27-26,11-6)
	01  38mA
	10  33mA
	11  reserved
 27-26	MD[63-0] buffer strength
 25-24	RCSA[0]# & RCSB[0]#/MAB[6] buffer strength
 23-22	(82443LX only) MAB[1-0] buffer strength
 21-20	MAA[13:2] buffer strength
 19-18	RCSA[1]# & RCSB[1]#/MAB[7] buffer strength
 17-16	RCSA[2]# & RCSB[2]#/MAB[8] buffer strength
 15-14	RCSA[3]# & RCSB[3]#/MAB[9] buffer strength
 13-12	(82443LX only) RCSA[4]# & RCSB[4]#/MAB[10] buffer strength
 11-10	(82443LX only) CQDB[5,1]# buffer strength
 9-8	CQDA[5,1]# buffer strength
 7-6	CQDA[7-6,4-2,0]# buffer strength
---82443LX---
 5-4	RCSA[5]# & RCSB[5]#/MAB[11] buffer strength
 3-2	RCSA[6]#/MAB[2] & RCSB[6]#/MAB[12] buffer strength
 1-0	RCSA[7]#/MAB[3] & RCSB[7]#/MAB[13] buffer strength
---82443EX---
 5-0	reserved
SeeAlso: #01129

Bitfields for Intel 82443EX/LX Error Status 0 register:
Bit(s)	Description	(Table 01138)
---82443LX---
 7-5	Multi-bit first error (read-only) Indicates which DRAM row had the
	  multi-bit error
 4	Multiple-bit ECC Error occurred flag
 3-1	Single-bit first row error (read-only) Indicates which DRAM row had the
	  single-bit error
 0	Single-bit ECC error occurred flag
---82443EX---
 7-0	reserved
Note:	Write a 1 to bits 4 & 0 to clear the flags
SeeAlso: #01129,#01139

Bitfields for Intel 82443EX/LX Error Status 1 register:
Bit(s)	Description	(Table 01139)
 7-3	reserved
 2	AGP non-snoopable access outside of graphics arperture
 1	AGP non-snoopable access outside of main DRAM ranges and arperture
 0	access to invalid graphics arperture translation table entry
Note:	Write a 1 to these bit(s) to clear
SeeAlso: #01129,#01138

Bitfields for Intel 82443EX/LX Multi-Transaction Timer register:
Bit(s)	Description	(Table 01140)
 7-3	Multi-transaction timer count value
 2-0	reserved
SeeAlso: #01129,#01141

Bitfields for Intel 82443EX/LX Low Priority Transaction Timer register:
Bit(s)	Description	(Table 01141)
 7-3	Low priority transaction timer count value
 2-0	reserved
SeeAlso: #01129,#01140

Format of PCI Configuration for Intel 82443BX Device 0 (Host-PCI):
Offset	Size	Description	(Table 01142)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 7190h/7192h)
 10h	DWORD	graphics aperture base address
 2Ch	WORD	subsystem vendor identification (write-once)
 2Eh	WORD	subsystem device identification (write-once)
 40h 16 BYTEs	reserved (0)
 50h	DWORD	440BX Configuration (see #01144)
 54h  3 BYTEs	reserved (0)
 57h	BYTE	DRAM Control (see #01145)
 58h	BYTE	DRAM Timing (see #01146)
 59h  7 BYTEs	Programmable Attribute Map register 0-6 (see #01118)
 60h  8 BYTEs	DRAM Row Boundary registers 0-7
		each register indicates top of memory for a particular row, in
		  8MB units; DIMMs use two rows each, with single-sided DIMMs
		  leaving the odd-numbered rows unpopulated
 68h	BYTE	Fixed DRAM Hole Control (see #01147)
 69h  6 BYTEs	Memory Buffer Strength Control (see #01148)
 6Fh  2 BYTEs	reserved (0)
 71h	BYTE	Intel Reserved (1Fh)
 72h	BYTE	SMRAM Control (see #01123)
 73h	BYTE	Extended SMRAM Control (see #01149)
 74h	WORD	SDRAM Row Page Size (see #01150)
 76h	WORD	SDRAM Control Register (see #01151)
 78h	WORD	Paging Policy Register (see #01152)
 7Ah	BYTE	Power Management Control (see #01153)
 7Bh	WORD	Suspend CBR Refresh Rate Register (see #01154)
 7Dh  3 BYTEs	reserved (0)
 80h	DWORD	Error Address Pointer (see #01155)
 84h 12 BYTEs	reserved (0)
 90h	BYTE	Error Command Register (see #01156)
 91h	WORD	Error Status Register (see #01157)
 93h	BYTE	reserved (0)
 94h	DWORD	Intel Reserved (00006104h)
 98h	WORD	Intel Reserved (0500h)
 9Ah	BYTE	Intel Reserved (0)
 9Bh  5 BYTEs	reserved (0)
 A0h	DWORD	AGP Capability Identifier (see #01158)
 A4h	DWORD	AGP Status Register (read-only) (see #01159)
 A8h	DWORD	AGP Command Register (see #01160)
 ACh  4 BYTEs	reserved (0)
 B0h	DWORD	AGP Control Register (see #01161)
 B4h	BYTE	Aperture Size Control (see #01162)
 B5h  3 BYTEs	reserved (0)
 B8h	DWORD	Aperture Translation Table (see #01163)
 BCh  2 BYTEs	reserved
 BEh	WORD	reserved (0)
 C0h	DWORD	Intel Reserved (0)
 C4h	DWORD	Intel Reserved (0)
 C8h	BYTE	Intel Reserved (18h)
 C9h	BYTE	Intel Reserved (0Ch)
 CAh  3 BYTEs	Memory Buffer Frequency Select (see #01164)
 CDh  3 BYTEs	reserved (0)
 D0h  8 BYTEs	BIOS scratch pad (read-write, init to 0 on reset)
 D8h  8 BYTEs	Intel Reserved (0)
 E0h  2	DWORDs	DRAM Write Thermal Throttling Control (see #01165)
 E8h  8 BYTEs	DRAM Read Therman Throttling Control (see #01165)
 F0h	WORD	Buffer Control Register (see #01166)
 F2h  2 BYTEs	Intel Reserved (0000h)
 F4h	DWORD	Intel Reserved (0000F800h)
		bits 30-29 are "Abort Disable Test Mode" configuration bits
			and should always be set (according to Intel
			Specification Update)
 F8h	DWORD	Intel Reserved (00000F20h)
 FCh	DWORD	Intel Reserved (0)
SeeAlso: #00873,#01143,PORT 0022h"82443BX"
!!!intel\29063301.pdf p.34

Format of PCI Configuration for Intel 82443BX Device 1 (PCI-AGP):
Offset	Size	Description	(Table 01143)
 00h 64 BYTEs	header, type 1 [bridge] (see #00878)
		(vendor ID 8086h, device ID 7191h)
 40h 192 BYTEs	reserved
SeeAlso: #00873,#01142,#01130
!!!intel\29063301.pdf p.80

Bitfields for Intel 82443BX (Device 0) NBX Configuration Register:
Bit(s)	Description	(Table 01144)
 31-24	SDRAM rows without ECC; each set bit indicates a row in the SDRAM array
	  with does NOT have error correction (bit 24 = row 0; note that double-
	  sided DIMMs use two rows, one for the front and one for the back)
 23-19	reserved
 18	DRAM data asserted on host bus on the same clock on which the snoop
	  result is sampled, instead of one clock later
 17	ECC signals are always driven for EDO memory
 16	IDSEL redirection
	=0 allocate IDSEL1/AD12 to bridge, never assert external AD12
	=1 allocate IDSEL7/AD18 to bridge, never assert external AD18; PCI
	  configuration cycles for Bus0/Device7 are redirected to Bus0/Device1
 15	disable WSC# handshake (uni-processor mode)
 14	Intel Reserved
 13:12	Host/DRAM frequency
	00  100 MHz
	01  reserved
	10  66 MHz
	11  reserved
 11	enable AGP-to-PCI access (note: AGP-to-PCI traffic is not allowed to
	  target ISA-bus devices)
 10	disable PCI agent access to graphis aperture (ignored if bit 9 clear)
 9	global enable graphics aperture access
 8:7	DRAM Data Integrity Mode
	00 non-ECC
	01 error checking only (e.g. parity)
	10 ECC mode
	11 ECC mdoe with hardware scrubbing
 6	enable ECC diagnostics mode (when set, ECC lines are forced to zero on
	  writes and compared to internally-generated ECC on reads)
 5	monochrome video adapter present on PCI/ISA bus (with primary adapter
	  on AGP bus)
	if register 3Eh bit 3 is clear, all VGA cycles are sent to PCI
	  regardless of this bit
	otherwise: if clear, all VGA cycles are sent to AGP; if set, all VGA
	  cycles except MDA ranges (memory B0000h-B7FFFh and ports 03B4h,03B5h,
	  03B8h,03B9h,03BAh,03BFh) are sent to AGP
 4	reserved
 3	enable posting of host USWC (U??? Speculative Write Combine) writes to
	  PCI memory
 2	In-Order Queue Depth
	=1 maximum (PPro supports up to 8, but 82443BX only supports depth 4)
	=0 depth forced to 1 (no pipelining on processor bus)
 1:0	reserved
SeeAlso: #01142

Bitfields for 82443BX DRAM Control:
Bit(s)	Description	(Table 01145)
 7-6	reserved
 5	module mode configuration (read-only)
	=0 self-refresh entry is staggered; if "SDRAMPWR" (offset 76h bit 4) is
	  set, 3 DIMMs are supported, CKE[5:0] is driven, and dynamic SDRAM
	  power-down is available; if "SDRAMPWR" is clear, 4 DIMMs are
	  supported but power-down is not available
	=1 self-refresh entry is not staggered; 3 DIMMs are supported, only
	  CKE0 is driven, and dynamic power-down is not available
 4:3	DRAM type
	00 EDO
	01 SDRAM
	10 registered SDRAM
	11 reserved
 2:0	DRAM refresh rate
	000 disabled
	001 15.6 microseconds
	010 31.2 microseconds
	011 62.4
	100 124.8
	101 249.6
	else reserved
SeeAlso: #01142

Bitfields for Intel 82443BX DRAM Timing:
Bit(s)	Description	(Table 01146)
 7-2	reserved
 1	add one EDO RASx# wait state for row misses (two tASR instead of one)
 0	add one wait state to first EDO CASx# assertion for page hits
	(2 Tasc instead of 1 Tasc)
SeeAlso: #01142

Bitfields for Intel 82443BX/EX/LX Fixed DRAM Hole Control:
Bit(s)	Description	(Table 01147)
 7-6	Hole Enable
	00 none
	01 512K-640K
	10 15M-16M
	11 reserved
 5-0	reserved (0)
SeeAlso: #01142,#01129

Bitfields for Intel 82443BX Memory Buffer Strength Control:
Bit(s)	Description	(Table 01148)
 47-40	reserved (0)
 39-38	strengths of MAA[13:0], WEA#, SRASA#, SCASA# (settings same as below)
 37-36	strengths of MAB[12:11,9:0], MAB[13,10], WEB#, SRASB#, SCASB#
	00 = 1x (at both 66 and 100 MHz)
	01 reserved
	10 = 2x (at both 66 and 100 MHz)
	11 = 3x (at both 66 and 100 MHz)
 35-34	MD[63:0] buffer strength control 2
	4 DIMM FET config: strength for MD[63:0] path connected to DIMMs 2&3
	3/4 DIMM non-FET config: program to same value as buffer str. ctrl 1
 33-32	MD[63:0] buffer strength control 1
	4 DIMM FET config: strength for MD[63:0] path connected to DIMMs 0&1
	3/4 DIMM non-FET config: programmable based on total load detected on
	  all DIMM connectors
	00 = 1x (at both 66 and 100 MHz)
	01 reserved
	10 = 2x (at both 66 and 100 MHz)
	11 = 3x (at 100 MHz only)
 31-30	MECC[7:0] buffer strength control 2
	4 DIMM FET config: strength for MECC[7:0] path connected to DIMMs 2&3
	3/4 DIMM non-FET config: program to same value as buffer str. ctrl 1
 29-28	MECC[7:0] buffer strength control 1
	4 DIMM FET config: strength for MD[63:0] path connected to DIMMs 0&1
	3/4 DIMM non-FET config: programmable based on total load detected on
	  all DIMM connectors
	(values same as for MD[63:0] buffer strength)
 27-26	CSB7#/CKE5 buffer strength (same values as bits 37-36)
 25-24	CSA7#/CKE3 buffer strength (same values as bits 37-36)
 23-22	CSB6#/CKE4 buffer strength (same values as bits 37-36)
 21-20	CSA6#/CKE2 buffer strength (same values as bits 37-36)
 19	CSA5#/RASA5#, CSB5#/RASB5# buffer strength
	0 = 1x (at both 66 and 100 MHz)
	1 = 2x (at both 66 and 100 MHz)
 18	CSA4#/RASA4#, CSB4#/RASB4# buffer strength (same values as bit 19)
 17	CSA3#/RASA3#, CSB3#/RASB3# buffer strength (same values as bit 19)
 16	CSA2#/RASA2#, CSB2#/RASB2# buffer strength (same values as bit 19)
 15	CSA1#/RASA1#, CSB1#/RASB1# buffer strength (same values as bit 19)
 14	CSA0#/RASA0#, CSB0#/RASB0# buffer strength (same values as bit 19)
 13-12	DQMA5/CASA5# buffer strength
	00 = 1x (at both 66 and 100 MHz)
	01 reserved
	10 = 2x (at both 66 and 100 MHz)
	11 = 3x (at 66 MHz only)
 11-10	DQMA1/CASA1# buffer strength (same values as bits 37-36)
 9-8	DQMB5/CASB5# buffer strength (same values as bits 13-12)
 7-6	DQMB1/CASB1# buffer strength (same values as bits 13-12)
 5-4	DQMA[7:6,4:2,0]/CASA[7:6,4:2,0]#  buffer strength (as for bits 37-36)
 3-2	CKE1/GCKE buffer strength (same values as bits 37-36)
 1-0	CKE0/FENA buffer strength (same values as bits 37-36)
SeeAlso: #01142

Bitfields for Intel 82439TX/82443BX Extended SMRAM Control register:
Bit(s)	Description	(Table 01149)
 7	SMRAM location
	=0 compatible SMRAM space at segment A000h
	=1 high SMRAM space at addreses 100A0000h to 100FFFFFh (accessing
	  physical DRAM addresses A0000h to FFFFFh)
 6	(write-clear) access to extended SMRAM memory range when SMRAM space
	  is not open and not in SMM
 5	enable write-through caching of SMRAM
	(forced to 1 by 82443BX, to 0 by 82439TX)
 4	enable L1 caching of SMRAM (forced to 1 by 82443BX)
 3	enable L2 caching of SMRAM (forced to 1 by 82443BX)
 2-1	TSEG size (read-only once SMRAM locked) (see #01123)
	00 128K
	01 256K
	10 512K
	11 1M
 0	enable TSEG (read-only once SMRAM locked) (see #01123)
	when both SMRAM and TSEG are enabled, the top N kilobytes of physical
	  DRAM are no longer claimed by the memory controller, and instead
	  appear as extended SMRAM at an address 256M higher than the physical
	  address
SeeAlso: #01142,#01123,#01099

Bitfields for Intel 82443BX SDRAM Row Page Size:
Bit(s)	Description	(Table 01150)
 15-14	page size for row 7 (back of DIMM4)
	00 two KB
	01 four KB
	10 eight KB
	11 reserved
 13-12	page size for row 6 (front of DIMM4)
 ...
 3-2	page size for row 1 (back of DIMM1)
 1-0	page size for row 0 (front of DIMM1) 
SeeAlso: #01142

Bitfields for Intel 82443BX SDRAM Control Register:
Bit(s)	Description	(Table 01151)
 15-10	reserved (0)
 9-8	add one-clock delay to idle/pipeline DRAM leadoff when =01 (all other
	  values are illegal)
 7-5	SDRAM mode select
	000 normal operation
	001 issue NOP command on all CPU-to-SDRAM cycles
	010 issue All-Banks-Precharge command on all CPU-to-SDRAM cycles
	011 issue mode register set command on CPU-to-SDRAM cycles
		(command is driven on memory address lines, so the proper
		address must be calculated for each row of memory to drive
		the correct command; MAx[2:0] must be driven to 010 for
		burst-of-4 mode, MAx3 to 1 for interleave wrap type,
		MAx4 to the value of the CAS# latency bit, MAx[6:5] to 01,
		and MAx[12:7] to 0000000
	100 issue CBR cycles on all CPU-to-SDRAM cycles
	else reserved
 4	"SDRAMPWR" specifies how CKE signals are driven for various DRAM
	  configurations; refer to #01145 bit 5
 3	Leadoff Command Timing
	=0 four CS# clocks (100 MHz or 66 MHz desktop if MAA/MAB load > 9)
	=1 three CS# clocks (66 MHz mobile platforms, or desktop w/ load <= 9)
 2	CAS# latency
	=0 three DCLKs
	=1 two DCLKs
 1	SDRAM RAS# to CAS# delay
	=0 three clocks
	=1 two clocks
 0	SDRAM RAS# precharge
	=0 three clocks
	=1 two clocks
SeeAlso: #01142

Bitfields for Intel 82443BX Paging Policy Register:
Bit(s)	Description	(Table 01152)
 15-8	banks per row (bit 7 is row 0, bit 15 is row 7)
	=0 two banks
	=1 four banks
 7-5	reserved
 4	Intel Reserved
 3-0	DRAM Idle Timer ("DIT")
	number of clocks in idle state before all pages are precharged
	0000 no clocks
	0001 2 clocks
	0010 4 clocks
	0011 8 clocks
	0100 10 clocks
	0101 12 clocks
	0110 16 clocks
	0111 32 clocks
	1xxx never (pages are not closed on idle)
SeeAlso: #01142

Bitfields for Intel 82443BX Power Management Control Register:
Bit(s)	Description	(Table 01153)
 7	enable SDRAM power-down for idle rows
 6	enable ACPI control register at PORT 0022h
 5	suspend refresh type
	=0 self-refresh
	=1 CBR mode
 4	enable normal refresh (must be set before accessing RAM after a reset)
 3	quick-start mode enabled (read-only)
 2	enable dynamic clock gating on AGPset "IDLE" condition (all buses in
	  idle state)
 1	AGP disabled (read-only)
 0	enable CPU reset without PCIRST enable
SeeAlso: #01142

Bitfields for Intel 82443BX Suspend CBR Refresh Rate:
Bit(s)	Description	(Table 01154)
 15-13	reserved (0)
 12	enable automatic Suspend CBR Refresh Rate adjustment (based on number
	  of OSCCLKs in a given time); if clear, the below field must be
	  programmed to guarantee minimum refresh rates in the worst case
 11-0	Suspend CBR Refresh Rate (number of OSCCLKs between refresh requests)
SeeAlso: #01142

Bitfields for Intel 82443BX Error Address Pointer:
Bit(s)	Description	(Table 01155)
 31-12	(read-only) bits 31-12 of address in which first parity/ECC error
	  occurred
 11-2	reserved
 1	(write-clear) multi-bit error occurred
 0	(write-clear) single-bit error occurred
SeeAlso: #01156,#01142

Bitfields for Intel 82443BX/EX/LX Error Command Register:
Bit(s)	Description	(Table 01156)
 7	enable SERR# on AGP non-snoopable access outside graphics aperture
 6	enable SERR# on invalid AGP DRAM access (82443BX)
	enable SERR# on AGP Non-snoopable access to location outside main DRAM
	  and arpeture rangles (82443EX/LX)
 5	enable SERR# on access to invalid Graphics Aperture Translation Table
 4	enable SERR# on receiving Target Abort
 3	enable SERR# when Thermal DRAM Throttling detected (82443BX)
	enable SERR# on PCI Parity Error (82443EX/LX)
---82443BX---
 2	SERR# mode
	=0 asserted for one PCI clock
	=1 level mode signal (for systems that connect SERR# to EXTSMI#)
 1	enable SERR# on receiving multi-bit Parity/ECC error
 0	enable SERR# on receiving single-bit (corrected) ECC error
---82443EX/LX---
 2-0	reserved
Note:	bits 1 and 0 must be clear on systems not supporting ECC
SeeAlso: #01155,#01157,#01142,#01129

Bitfields for Intel 82443BX Error Status Register:
Bit(s)	Description	(Table 01157)
 15-13	reserved (0)
 12	(write-clear) DRAM Read thermal throttling condition occurred
 11	(write-clear) DRAM Write thermal throttling condition occurred
 10	(write-clear) AGP non-snoopable access outside Graphics Aperture
 9	(write-clear) invalid AGP non-snoopable DRAM read access
 8	(write-clear) invalid Graphics Aperture Translation Table entry
 7-5	(read-only) number of DRAM row containing first multi-bit error
 4	(write-clear) multi-bit (uncorrectable) error occurred
 3-1	(read-only) number of DRAM row containing first single-bit error
 0	(write-clear) single-bit (correctable) error occurred
SeeAlso: #01156,#01142

Bitfields for Intel AGP Capability Identifier:
Bit(s)	Description	(Table 01158)
 31-24	reserved
 23-20	major version of supported AGP revision
 19-16	minor version of supported AGP revision
 15-8	offset of next capability (0 = none)
 7-0	PCI capability ID (2 = AGP, 0 = disabled)
SeeAlso: #01142,#01159,#01129

Bitfields for Intel 82443BX/EX/LX AGP Status Register:
Bit(s)	Description	(Table 01159)
 31-24	maximum AGP request queue depth (read-only)
 23-10	reserved
 9	AGP side band addressing is supported (read-only)
 8-2	reserved
 1-0	supported AGP data transfer type(s)
	bit 0: 1x data transfer mode
	bit 1: 2x data transfer mode
Note:	bits 0 and 1 may not both be clear
SeeAlso: #01160,#01142,#01158,#01129

Bitfields for Intel 82443BX/EX/LX AGP Command Register:
Bit(s)	Description	(Table 01160)
 31-10	reserved
 9	enable AGP sideband addressing
 8	enable AGP
 7-2	reserved
 1-0	selected AGP transfer rate
	00 = default
	01 = 1x
	10 = 2x
	11 illegal
SeeAlso: #01159,#01142,#01161,#01129

Bitfields for Intel 82443BX/EX/LX AGP Control Register:
Bit(s)	Description	(Table 01161)
 31-16	reserved (0)
 15	disable forced ordering of snoopable writes and AGP reads (82443BX)
	(82443EX/LX) reserved
 14	reserved (0)
 13	enable Graphics Aperture Write-AGP Read synchronization
 12-10	reserved (0)
 9-8	reserved (0) (82443BX)
	expedite transaction throttle timer (82443EX/LX)
	00 no throttling
	01 reserved
	10 192 clocks on, 64 clocks off
	11 reserved
 7	enable Graphics Translation Lookaside Buffer (and GTLB Flush Control)
 6-0	reserved (0)
SeeAlso: #01160,#01142,#01129

Bitfields for Intel 82443BX/EX/LX Graphics Aperture Size Control:
Bit(s)	Description	(Table 01162)
 7-6	reserved
 5-0	aperture size
	000000 256M
	100000 128M
	110000 64M
	111000 32M
	111100 16M
	111110 8M
	111111 4M
	other illegal
SeeAlso: #01142,#01163,#01129

Bitfields for Intel 82443BX/EX/LX Graphics Aperture Trans. Table Base Register:
Bit(s)	Description	(Table 01163)
 31-12	bits 31-12 of aperture translation table base address 
 11-0	reserved (0)
SeeAlso: #01162,#01142,#01129

Bitfields for Intel 82443BX Memory Buffer Frequency Select:
Bit(s)	Description	(Table 01164)
 23	reserved
 22	MAA[13:0], WEA#, SRASA#, SCASA# buffer select
	=0 66 MHz buffers
	=1 100 MHz buffers
 21	MAB[12:11,9:0]#, MAB[13,10], WEB#, SRASB#, SCASB# buffer select
	(as for bit 22)
 20	MD[63:0] (control 2) buffer select
 19	MD[63:0] (control 1) buffer select
 18	MECC[7:0] (control 2) buffer select
 17	MECC[7:0] (control 1) buffer select
 16	CSB7#/CKE5 buffer select
 15	CSA7#/CKE3 buffer select
 14	CSB6#/CKE4 buffer select
 13	CSA6#/CKE2 buffer select
 12	CSA5#/RASA5#, CSB5#/RASB5# buffer select
 11	CSA4#/RASA4#, CSB4#/RASB4# buffer select
 10	CSA3#/RASA3#, CSB3#/RASB3# buffer select
 9	CSA2#/RASA2#, CSB2#/RASB2# buffer select
 8	CAS1#/RASA1#, CSB1#/RASB1# buffer select
 7	CSA0#/RASA0#, CSB0#/RASB0# buffer select
 6	DQMA5/CASA5# buffer select
 5	DQMA1/CASA1# buffer select
 4	DQMB5/CASB5# buffer select
 3	DQMB1/CASB1# buffer select
 2	DQMA[7:6,4:2,0]/CASA[7:6,4:2,0]# buffer select
 1	CKE1/GCKE buffer select
 0	CKE0/FENA buffer select
SeeAlso: #01142,#01166

Bitfields for Intel 82443BX DRAM Read/Write Thermal Throttling Control:
Bit(s)	Description	(Table 01165)
 63	lock all read and write throttle control register bits (exists in Write
	  Throttling control register only)
 62-46	reserved
 45-38	global DRAM sampling window (in four-millisecond units)
 37-26	global QWORD threshold (documented as units of 215, but may be typo and
	  actually be units of 2^15 = 32768)
	thermal throttling will be invoked if the number of QWORD accesses
	  during the sampling window exceeds the threshold count
 25-20	throttle time in multiples of the sampling window
 19-13	throttle monitoring window in 16 DRAM-clock units
 12-3	throttle QWORD maximum count -- while throttling is enabled, at most
	  this many QWORD accesses are permitted during each throttle
	  monitoring window
 2-0	DRAM Throttle Mode
	100 normal operation
	else Intel Reserved
SeeAlso: #01142

Bitfields for Intel 82443BX Buffer Control Register:
Bit(s)	Description	(Table 01166)
 15-10	reserved
 9-6	AGP Jam Latch strength
	bit 9: enable strong pull-up
	bit 8: enable weak pull-up
	bit 7: enable strong pull-down
	bit 6: enable weak pull-down
 5-0	Intel Reserved
SeeAlso: #01142,#01164

Format of PCI Configuration for Intel 82371FB/82371SB Function 0 (ISA Bridge):
Offset	Size	Description	(Table 01167)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 122Eh/7000h)
		(revision ID 00h = 82371SB step A-1)
		(revision ID 01h = 82371SB step B-0)
 40h 12 BYTEs	reserved
 4Ch	BYTE	ISA I/O Controller Recovery Timer (see #01087)
 4Dh	BYTE	reserved
 4Eh	BYTE	X-Bus Chip Select Enable (see #01089)
 4Fh	BYTE	(82371SB) X-Bus Chip Select Enable High (see #01102)
		bit 0: I/O APIC enabled
 4Fh	BYTE	(82371FB) reserved
 50h 16 BYTEs	reserved
 60h  4 BYTEs	PCI IRQ Route Control (see #01076)
 64h  5 BYTEs	reserved
 69h	BYTE	top of memory (see #01216)
 6Ah	WORD	miscellaneous status (see #01217)
 6Ch  4 BYTEs	reserved
 70h	BYTE	motherboard IRQ Route Control 0 (see #01218)
 71h	BYTE	(82371FB) motherboard IRQ Route Control 1 (see #01218)
 72h  4 BYTEs	reserved
 76h  2 BYTEs	motherboard DMA control (see #01219)
 78h	WORD	programmable chip select control (see #01220)
 7Ah  6 BYTEs	reserved
 80h	BYTE	(82371SB) APIC Base Address Relocation (see #01078)
 81h	BYTE	reserved
 82h	BYTE	(82371SB) Deterministic Latency Control (see #01221)
 83h 29 BYTEs	reserved
 A0h	BYTE	SMI Control (see #01222)
 A1h	BYTE	reserved
 A2h	WORD	SMI Enable (see #01080)
 A4h	DWORD	System Event Enable (SEE) (see #01081)
 A8h	BYTE	Fast-Off Timer (in minutes, PCICLKs, or milliseconds)
		value is count less one; timer must be stopped before
		  changing its value
 A9h	BYTE	reserved
 AAh	WORD	SMI Request (see #01082)
 ACh	BYTE	Clock Scale STPCLK# Low Timer
		STPCLK# stays low for 1+1056*(value+1) PCICLKs
 ADh	BYTE	reserved
 AEh	BYTE	Clock Scale STPCLK# High Timer
		STPCLK# stays high for 1+1056*(value+1) PCICLKs
 AFh 81 BYTEs	reserved
SeeAlso: #00873,#01214,#01215,#01064,#01083,#01108,#01098

Format of PCI configuration for Intel 82371MX MPIIX:
Offset	Size	Description	(Table 01168)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 1234h)
 40h  9 BYTEs	reserved
 49h	BYTE	serial and parallel port enable (see #01169)
 4Ah  2 BYTEs	reserved
 4Ch	BYTE	Extended I/O Controller Recovery Timer (see #01170)
 4Dh	BYTE	reserved
 4Eh	BYTE	BIOS enable (see #01171)
 4Fh	BYTE	FDC enable (see #01172)
 50h 16 BYTEs	reserved
 60h	BYTE	PIRQA# Route Control (see #01076)
 61h	BYTE	PIRQB# Route Control (see #01076)
 62h  8 BYTEs	reserved
 6Ah	WORD	Miscellaneous Status (see #01173)
 6Ch	WORD	IDE timing modes (see #01223)
 6Eh  2 BYTEs	reserved
 70h	BYTE	Motherboard IRQ Route Control (see #01223)
 71h  5 BYTEs	reserved
 76h  3 BYTEs	Motherboard DMA Route Control (see #01219)
 79h  5 BYTEs	reserved
 7Eh	BYTE	Audio enable (see #01174)
 7Fh	BYTE	DMA channel 5-7 address size (see #01175)
 80h	BYTE	PCI DMA enable (see #01176)
 81h  7 BYTEs	reserved
 88h	BYTE	PCI DMA/PCI DMA expansion A (see #01177)
 89h	BYTE	PCI DMA/PCI DMA expansion B (see #01177)
 8Ah	WORD	Programmable Memory Address Control 0 (see #01178)
 8Ch	WORD	Programmable Memory Address Control 1 (see #01178)
 8Eh	WORD	Programmable Memory Address Mask (see #01179)
 90h	BYTE	Programmable Address Range Enable (see #01180)
 91h	BYTE	reserved
 92h	WORD	Programmable Chip Select Control (see #01181)
 94h	WORD	Programmable Address Control 1 (see #01182)
 96h	WORD	Programmable Address Control 2 (see #01182)
 98h	WORD	Programmable Address Control 3 (see #01182)
 9Ah	BYTE	Programmable Address Mask A (see #01183)
 9Bh	BYTE	Programmable Address Mask B (see #01184)
 9Ch	WORD	I/O configuration address (see #01185)
 9Eh  2 BYTEs	reserved
 A0h	WORD	Programmable Address Control 4 (see #01182)
 A2h	WORD	Programmable Address Control 5 (see #01182)
 A4h	BYTE	Programmable Address Mask C (see #01186)
 A5h	BYTE	Peripheral Access Detect Enable 0 (see #01187)
 A6h	BYTE	Peripheral Access Detect Enable 1 (see #01188)
 A7h	BYTE	Peripheral Access Detect Enable 2 (see #01189)
 A8h	WORD	Local Trap Address for Device 3 (see #01190)
 AAh	BYTE	Local Trap Mask for Device 3 (see #01191)
 ABh	BYTE	Local Trap SMI Enable (see #01192)
 ACh  2 BYTEs	reserved
 AEh	BYTE	Local Trap SMI Status (see #01192)
 AFh	BYTE	reserved
 B0h	BYTE	Local Standby SMI Enable (see #01193)
 B1h	BYTE	Local Standby Timer Reload Enable (see #01194)
 B2h	BYTE	Local Standby SMI Status (see #01193)
 B3h	BYTE	reserved
 B4h	BYTE	Local Standby Timer IDE Idle (see #01195)
 B5h	BYTE	Local Standby Timer Audio Idle	(see #01195)
 B6h	BYTE	Local Standby Timer COM Idle (see #01195)
 B7h	BYTE	reserved
 B8h	BYTE	Local Standby Timer Device 1 Idle (see #01195)
 B9h	BYTE	Local Standby Timer Device 2 Idle (see #01195)
 BAh	BYTE	Local Standby Timer Device 3 Idle (see #01195)
 BBh	BYTE	reserved
 BCh	BYTE	Software/EXTSMI# SMI Delay Timer (see #01195)
 BDh	BYTE	Suspend SMI Delay Timer (see #01195)
 BEh	BYTE	Global Standby Timer (see #01195)
 BFh	BYTE	Clock Throttle Standby Timer (see #01195)
 C0h	BYTE	System Management Control (see #01196)
 C1h	BYTE	System SMI Enable (see #01197)
 C2h	BYTE	Miscellaneous SMI Enable (see #01198)
 C3h	BYTE	Global SMI Enable (see #01200)
 C4h  2 BYTEs	reserved
 C6h	BYTE	System SMI Status (see #01197)
 C7h	BYTE	Miscellaneous SMI Status (see #01199)
 C8h	BYTE	Global SMI Status (see #01201)
 C9h  3 BYTEs	reserved
 CCh	BYTE	Suspend/Resume Control 1 (see #01202)
 CDh	BYTE	Suspend/Resume Control 2 (see #01203)
 CEh	BYTE	SMOUT Control (see #01204)
 CFh	BYTE	reserved
 D0h	BYTE	System Event Enable 0 (see #01207)
 D1h	BYTE	System Event Enable 1 (see #01208)
 D2h	BYTE	System Event Enable 2 (see #01209)
 D3h	BYTE	Burst Count Timer (see #01195)
 D4h	BYTE	Clock Control (see #01205)
 D5h	BYTE	reserved
 D6h	BYTE	STPCLK# Low Timer (see #01195)
 D7h	BYTE	STPCLK# High Timer (see #01195)
 D8h	BYTE	Stop Break Event Enable 0 (see #01207)
 D9h	BYTE	Stop Break Event Enable 1 (see #01208)
 DAh	BYTE	Stop Break Event Enable 2 (see #01209)
 DBh  5 BYTEs	reserved
 E0h	BYTE	Shadow Register (see #01206)
 E1h  3 BYTEs	reserved
 E4h	BYTE	Burst Clock Event Enable 0 (see #01207)
 E5h	BYTE	Burst Clock Event Enable 1 (see #01208)
 E6h	BYTE	Burst Clock Event Enable 2 (see #01209)
 E7h	BYTE	Burst Clock Event Enable 3 (see #01210)
 E8h	BYTE	Burst Clock Event Enable 4 (see #01211)
 E9h	BYTE	Burst Clock Event Enable 5 (see #01212)
 EAh	BYTE	Burst Clock Event Enable 6 (see #01213)
 EBh	BYTE	reserved
 ECH	BYTE	Clock Throttle Break Event Enable 0 (see #01207)
 EDh	BYTE	Clock Throttle Break Event Enable 1 (see #01208)
 EEh	BYTE	Clock Throttle Break Event Enable 2 (see #01209)
 EFh	BYTE	Clock Throttle Break Event Enable 3 (see #01210)
 F0h	BYTE	Clock Throttle Break Event Enable 4 (see #01211)
 F1h	BYTE	Clock Throttle Break Event Enable 5 (see #01212)
 F2h	BYTE	Clock Throttle Break Event Enable 6 (see #01213)
 F3h 13 BYTES	reserved
SeeAlso: #00873,#01076

Bitfields for Intel 82371MX serial and parallel port enable register:
Bit(s)	Description	(Table 01169)
 7	reserved
 6	LPT3 enabled
 5	LPT2 enabled
 4	LPT1 enabled
 3	COM4 enabled
 2	COM3 enabled
 1	COM2 enabled
 0	COM1 enabled
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Extended I/O Controller Recovery Timer register:
Bit(s)	Description	(Table 01170)
 7	reserved
 6	8-Bit I/O Recovery Enable
	=1 Enable value programmed into bits 5-3
 5-3	8-Bit I/O Recovery Times
	000 = 8 SYSCLK
	001 = 1 SYSCLK (default)
	010 = 2 SYSCLK
	011 = 3 SYSCLK
	100 = 4 SYSCLK
	101 = 5 SYSCLK
	110 = 6 SYSCLK
	111 = 7 SYSCLK
 2-0	Reserved (0)
SeeAlso: #01168,#01087,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX BIOS enable register:
Bit(s)	Description	(Table 01171)
 7	Extended BIOS Enable
 6	Lower BIOS Enable 1
 5	Lower BIOS Enable 0
 4	Lower BIOS CS# Enable 0
 3	F Segment BIOS Enable
 2	BIOSCS# Write Protect
 1-0	reserved
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX FDC Enable register:
Bit(s)	Description	(Table 01172)
 7	Coprocessor Error fuction Enable
 6	IRQ12/M Mouse Function Enable
 5	System Management Output 5/Disk Output Enable
 4	System Management Output 4/RTCALE Enable
 3	Motherboad DMA 2 Disable
 2	reserved
 1	Floppy Secondary Addess Enable
 0	Floppy Primary Address Enable
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Miscellaneous Status register:
Bit(s)	Description	(Table 01173)
 15-3	reserved
 2-1	reserved (0)
 0	ISA Clock Divisor Status
	=1 Divisor=3 (PCICLK=25MHz) default
	=0 Divisor=4 (PCICLK=33MHz)
Note:	This is a read-only register that reports on chipset jumper settings.
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Audio enable register:
Bit(s)	Description	(Table 01174)
 7	Audio enabled
 6-4	Reserved
 3-2	Audio I/O Address
	00	0220h
	01	0230h
	10	0240h
	11	0250h
 1-0	reserved
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX DMA channel 5-7 address size register:
Bit(s)	Description	(Table 01175)
 7	Channel 7 16/8-Bit Count by Word/Byte
	=1 16-bit, count by word
	=0 8-bit, count by byte
 6	Channel 6 16/8-Bit Count by Word/Byte (same values as bit 7)
 5	Channel 5 16/8-Bit Count by Word/Byte (same values as bit 7)
4-3	reserved (0)
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX PCI DMA Enable register:
Bit(s)	Description	(Table 01176)
 7	DMA CH7 is on PCI Bus
 6	DMA CH6 is on PCI Bus
 5	DMA CH5 is on PCI Bus
 4	reserved
 3	DMA CH3 is on PCI Bus
 2	DMA CH2 is on PCI Bus
 1	DMA CH1 is on PCI Bus
 0	DMA CH0 is on PCI Bus
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX PCI DMA/PCI DMA expansion registers:
Bit(s)	Description	(Table 01177)
 7-4	reserved
 3	Expansion enabled
 2-0	DMA channel
Note:	The PCI DMA Expansion request lines (REQ[A,B]#/GNT[A,B]#) provide PCI
	  DMA and PCI DMA expansion support.
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Programmable Memory Address Control registers:
Bit(s)	Description	(Table 01178)
 15-0	Memory Access Control
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Programmable Memory Address Mask register:
Bit(s)	Description	(Table 01179)
 7-0	Memory Address Mask
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Programmable Address Range Enable register:
Bit(s)	Description	(Table 01180)
 7	PCS# Enabled for Programmable Address Range 2
 6	PCS# Enabled for Programmable Address Range 1
 5	Programmable Address range 5 Enabled
 4	Programmable Address range 4 Enabled
 3	Programmable Address range 5 Enabled
 2	Programmable Address range 3 Enabled
 1	Programmable Address range 1 Enabled
 5	PCS# Address range Enabled
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Programmable Chip Select Control register:
Bit(s)	Description	(Table 01181)
 15-0	PCS# Address
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Programmable Address Control registers:
Bit(s)	Description	(Table 01182)
 15-0	Programmable Address Control
Note:	This register selects a 16-bit I/O address range to be forwarded to
	  the Extended I/O Bus, if enabled in the Programmable Address Range
	  register.
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Programmable Address Mask A register:
Bit(s)	Description	(Table 01183)
 7-4	Programmable Address Control 1 Mask
 3-0	Programmable Chip Select Mask
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Programmable Address Mask B register:
Bit(s)	Description	(Table 01184)
 7-4	Programmable Address Control 3 Mask
 3-0	Programmable Address Control 2 Mask
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX I/O configuration address register:
Bit(s)	Description	(Table 01185)
 15-10	reserved
 9-1	I/O Configuration Address
 0	I/O Configuration Address Enabled
Note:	This register provides an I/O address range to be forwarded to the
	  Extended I/O Bus for accesses to the configuration space of an
	  integrated I/O device. PCI address bits 9-1 are compared to bits
	  9-1 of this register. Address bits 31-10 must be 0.
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Programmable Address Mask C register:
Bit(s)	Description	(Table 01186)
 7-4	Programmable Address Control 5 Mask
 3-0	Programmable Address Control 4 Mask
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Peripheral Access Detect Enable 0 register:
Bit(s)	Description	(Table 01187)
 7	Enable Audio-E
 6	Enable Audio-D
 5	Enable Audio-C
 4	Enable Audio-B
 3	Enable Audio-A
 2	Enable Parallel 3
 1	Enable Parallel 2
 0	Enable Parallel 1
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Peripheral Access Detect Enable 1 register:
Bit(s)	Description	(Table 01188)
 7	Enable COM4
 6	Enable COM3
 5	Enable COM3
 4	Enable COM1
 3	Enable Secondary FDC
 2	Enable Primary FDC
 1	Enable Secondary IDE
 0	Enable Promary IDE
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Peripheral Access Detect Enable 2 register:
Bit(s)	Description	(Table 01189)
 7	Enable PMAC1
 6	Enable PMAC0
 5	Enable PAC5
 4	Enable PAC4
 3	Enable PAC3
 2	Enable PAC2
 1	Enable PAC1
 0	Enable PCSC
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Local Trap Address for Device 3 register:
Bit(s)	Description	(Table 01190)
 15-0	Local Trap Address base for Device 3
Note:	Is compared with bits 15-0 of PCI I/O Addresses. Address bits 31-16
	  must be 0.
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Local Trap Mask for Device 3 register:
Bit(s)	Description	(Table 01191)
 7-4	Local Trap COM Port Select
	=1000	COM4 02E8h-02EFh
	=0100	COM3 03E8h-83EFh
	=0010	COM2 02F8h-02FFh
	=0001	COM1 03F8h-03FFh
Note:	These bits when set cause an SMI# when access to the corresponding I/O
	  port range is made.
 3-0	Local Trap Mask
Note:	This field selects the range of trappable addresses (in bytes).
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Local Trap SMI Enable/Status registers:
Bit(s)	Description	(Table 01192)
 7-6	reserved
 5	IDE
 4	Audio
 3	COM
 2	DEV3
 1	DEV2
 0	DEV1
Note:	a set bit indicates in the Enable register turns generation of SMI# on
	  I/O accesses to the address region used by the selected device;
	  a set bit in the Status register indicates which trap caused an SMI#
	  interrupt.
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Local Standby SMI Enable/Status registers:
Bit(s)	Description	(Table 01193)
 7-6	reserved
 5	IDE
 4	Audio
 3	COM
 2	DEV3
 1	DEV2
 0	DEV1
Note:	each bit in the Enable register turns on the associated SMI Timer; a
	  set bit in the Status register indicates which local standby timer
	  caused the SMI interrupt
SeeAlso: #01168,#01194,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Local Standby Timer Reload Enable register:
Bit(s)	Description	(Table 01194)
 7	IDE
 6	Audio
 5	COM
 4	DEV3
 3	DEV2
 2	DEV1
 1	Audio MDAK2
 0	Audio MDAK1
Note:	This register enables local standby timer reloading. When the
	  associated I/O address range is accessed, the standby timer is
	  reloaded with it's default value. Also note the different bit-order
	  for this register only.
SeeAlso: #01168,#01193,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Count Value registers:
Bit(s)	Description	(Table 01195)
 7-0	Count value
Note:	This field contains the initial count value for various time-out
	  events. 00 is an illegal programmed value. The programmed value is
	  decremented by certain events or system clocks, and the event is
	  triggered when the count reaches 0.
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX System Management Control register:
Bit(s)	Description	(Table 01196)
 7-3	reserved
 2	Freeze (but not reset) all Power Management timers
 1	=0 disable all Power Management functions
 0	=0 disable SMI
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX System SMI Enable/Status registers:
Bit(s)	Description	(Table 01197)
 7	reserved
 6	Write to APMC Port (software SMI)
 5	EXTSMI#
 4	IRQ12
 3	IRQ8
 2	IRQ4
 1	IRQ3
 0	IRQ1
Note:	each set bit in the Enable register turns on SMI# generation for the
	  associated hardware event; a set bit in the Status register indicates
	  which event caused the SMI interrupt
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Miscellaneous SMI Enable register:
Bit(s)	Description	(Table 01198)
 7-4	reserved
 3	Write to APMC Port
 2	SRBTN#
 1	BATLOW#
 0	reserved
Note:	Enables SMI# generation for the above hardware events
SeeAlso: #01168,#01199,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Miscellaneous SMI Status register:
Bit(s)	Description	(Table 01199)
 7-4	reserved
 3	=1 indicates system is in global standby mode
 2	SRBTN# caused SMI
 1	BATLOW# caused SMI
 0	reserved
SeeAlso: #01168,#01198,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Global SMI Enable register:
Bit(s)	Description	(Table 01200)
 7	System Events Enabled
 6	Software SMI#'s (generated by bit 0 of this register) Enabled
 5	reserved
 4	Local Traps Enabled
 3	Local Standby Timers Enabled
 2	Global Standby Timer Enabled
 1	SRBTN# and BATLOW# Enabled
Note:	Enables SMI# generation for the above hardware events
SeeAlso: #01168,#01201,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Global SMI Status register:
Bit(s)	Description	(Table 01201)
 7	One of the System Events caused SMI
 6	Software SMI or EXTSMI# caused SMI
 5	Write to APMC caused SMI
 4	Access to one of the Local Traps caused SMI
 3	One of the local Standby timers caused SMI
 2	Global Standby Timer caused SMI
 1	SRBTN# or BATLOW# caused SMI
 0	reserved
SeeAlso: #01168,#01200,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Suspend/Resume Control 1 register:
Bit(s)	Description	(Table 01202)
 7	BATLOW# bypasses Suspend delay timer and activates SMI# immediately
 6	IRQ8 will NOT cause a resume
 5	COM RI (Ring) will NOT cause a resume ("Wake on Ring" function)
 4	BATLOW# will not prevent a resume
 3	is set by power management software at the end of a suspend routine
 2	can be set by power management software at the end of a suspend routine
 1-0	Set suspend mode
	00	Suspend Disabled
	01	reserved
	10	Suspend-to-DRAM
	11	Suspend-to-Disk
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Suspend/Resume Control 2 register:
Bit(s)	Description	(Table 01203)
 7-1	reserved
 0	EXTSMI# will NOT cause a resume event
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX SMOUT Control register:
Bit(s)	Description	(Table 01204)
 7-6	reserved
 5-0	Writing to any bits sets the state of the 6 SMOUTx pins.
	SMOUT5 is not effected if it is configured for DOE# function
	SMOUT4 is not effected if it is configured for RTCALE function
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Clock Control register:
Bit(s)	Description	(Table 01205)
 7	Clock Throttle standy by timer frequency
	=1 32ms
	=0 4ms
Note:	Sets the granularity of the Clock Throttle Standby Timer
 6-5	reserved
 4	Enable Auto Clock Throttle
 3-2	STPCLK# Mode
	00 Disable STPCLK# Function
	01 Enable stop grant mode
	10 Enable stop clock mode
	11 reserved
 1	Enable clock throttling
 0	Enable "PCI Clock can be stopped"
SeeAlso: #01168,PORT xxxxh"Intel 82371"

(Table 01206)
Values for Intel 82371MX Shadow Register
Value	AT Port	Description
 00h	00h	Channel 0 Base Address Register (low byte)
 01h	00h	Channel 0 Base Address Register (high byte)
 02h	01h	Channel 0 Base Word Count Register (low byte)
 03h	01h	Channel 0 Base Word Count Register (high byte)
 04h	02h	Channel 1 Base Address Register (low byte)
 05h	02h	Channel 1 Base Address Register (high byte)
 06h	03h	Channel 1 Base Word Count Register (low byte)
 07h	03h	Channel 1 Base Word Count Register (high byte)
 08h	04h	Channel 2 Base Address Register (low byte)
 09h	04h	Channel 2 Base Address Register (high byte)
 0Ah	05h	Channel 2 Base Word Count Register (low byte)
 0Bh	05h	Channel 2 Base Word Count Register (high byte)
 0Ch	06h	Channel 3 Base Address Register (low byte)
 0Dh	06h	Channel 3 Base Address Register (high byte)
 0Eh	07h	Channel 3 Base Word Count Register (low byte)
 0Fh	07h	Channel 3 Base Word Count Register (high byte)
 10h	08h	DMA1 Command Register
 11h	0Bh	Channel 0 Mode Register
 12h	0Bh	Channel 1 Mode Register
 13h	0Bh	Channel 2 Mode Register
 14h	0Bh	Channel 3 Mode Register
 15h	0Fh	DMA1 Mask Register
 16h	C4h	Channel 5 Base Address Register (low byte)
 17h	C4h	Channel 5 Base Address Register (high byte)
 18h	C6h	Channel 5 Base Word Count Register (low byte)
 19h	C6h	Channel 5 Base Word Count Register (high byte)
 1Ah	C8h	Channel 6 Base Address Register (low byte)
 1Bh	C8h	Channel 6 Base Address Register (high byte)
 1Ch	CAh	Channel 6 Base Word Count Register (low byte)
 1Dh	CAh	Channel 6 Base Word Count Register (high byte)
 1Eh	CCh	Channel 7 Base Address Register (low byte)
 1Fh	CCh	Channel 7 Base Address Register (high byte)
 20h	CDh	Channel 7 Base Word Count Register (low byte)
 21h	CDh	Channel 7 Base Word Count Register (high byte)
 22h	D0h	DMA2 Command Register
 23h	D6h	Channel 5 Mode Register
 24h	D6h	Channel 6 Mode Register
 25h	D6h	Channel 7 Mode Register
 26h	DEh	DMA2 Mask Register
 27h	20h	PIC1 ICW1
 28h	21h	PIC1 ICW2
 29h	21h	PIC1 ICW3
 2Ah	21h	PIC1 ICW4
 2Bh	20h	PIC1 OCW2
 2Ch	A0h	PIC2 ICW1
 2Dh	A1h	PIC2 ICW2
 2Eh	A1h	PIC2 ICW3
 2Fh	A1h	PIC2 ICW4
 30h	A0h	PIC2 OCW2
 31h	70h	NMI mask / RTC address
 32h	03FAh	COM1 FIFO Enable Register (only bits 0,3,6 & 7 valid)
 33h	02FAh	COM2 FIFO Enable Register (only bits 0,3,6 & 7 valid)
 34h	03EAh	COM3 FIFO Enable Register (only bits 0,3,6 & 7 valid)
 35h	02EAh	COM4 FIFO Enable Register (only bits 0,3,6 & 7 valid)
 36h	40h	TIMER 0 Count Register (low byte)
 37h	40h	TIMER 0 Count Register (high byte)
 38h	20h	Master PIC OCW3 Register (bits 0,2 & 5 only valid)
 39h	A0h	Slave PIC OCW3 Register (bits 0,2 & 5 only valid)
Desc:	This register is used to read the current programmed value of certain
	  AT compatable I/O ports which are traditionally write-only.
Note:	To read a given register, write the value from the table to the shadow
	  register, then immediately re-read the shadow register. The returned
	  value is the current value of the I/O port.
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Burst Clock/Clock Throttle Break Enable 0 register:
Bit(s)	Description	(Table 01207)
 7	Enable IRQ7
 6	Enable IRQ6
 5	Enable IRQ7
 4	Enable IRQ4
 3	Enable IRQ3
 2	reserved
 1	Enable IRQ1
 0	Enable IRQ0
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Event Enable 1 register:
Bit(s)	Description	(Table 01208)
 7	Enable IRQ15
 6	Enable IRQ14
 5	reserved
 4	Enable IRQ12
 3	Enable IRQ11
 2	Enable IRQ10
 1	Enable IRQ9
 0	Enable IRQ8
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Event Enable 2 register:
Bit(s)	Description	(Table 01209)
 7	(Clock Throttle Break Event,Burst Clock Event)
	  reserved
	(System Event,Stop Break Event,Clock Throttle Break Event)
	  Enable BATLOW# & SRBTN#
 6	Enable EXTSMI#
 5	Enable SMI#
 4	(System Event,Stop Break Event,Clock Throttle Break Event)
	  Enable NMI
	(Burst Clock Event)
	  reserved
 3	(System Event,Stop Break Event,Clock Throttle Break Event)
	  Enable INTR
	(Burst Clock Event)
	  reserved
 2	reserved
 1	Enable COMRI#
 0	Enable events of selected type
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Event Enable 3 register:
Bit(s)	Description	(Table 01210)
 7-2	reserved
 1	Enable EXTEVNT#
 0	Enable PHLDA#
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Event Enable 4 register:
Bit(s)	Description	(Table 01211)
 7	Enable PMAC1
 6	Enable PMAC0
 5	Enable PAC5
 4	Enable PAC4
 3	Enable PAC3
 2	Enable PAC2
 1	Enable PAC1
 0	Enable PCSC
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Event Enable 5 register:
Bit(s)	Description	(Table 01212)
 7	Enable COM4
 6	Enable COM3
 5	Enable COM3
 4	Enable COM1
 3	Enable Secondary FDC
 2	Enable Primary FDC
 1	Enable Secondary IDE
 0	Enable Promary IDE
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Bitfields for Intel 82371MX Event Enable 6 register:
Bit(s)	Description	(Table 01213)
 7	Enable Audio-E
 6	Enable Audio-D
 5	Enable Audio-C
 4	Enable Audio-B
 3	Enable Audio-A
 2	Enable Parallel 3
 1	Enable Parallel 2
 0	Enable Parallel 1
SeeAlso: #01168,PORT xxxxh"Intel 82371"

Format of PCI Configuration for Intel 82371FB/82371SB Function 1 (IDE):
Offset	Size	Description	(Table 01214)
 00h 64 BYTEs	header (see #00878)
		(vender ID 8086h, device ID 1230h/7010h)
 20h	DWORD	Bus Master Interface Base Address
		(see PORT xxxxh"Intel 82371SB")
 40h	WORD	IDE timing modes, primary channel (see #01223)
 42h	WORD	IDE timing modes, secondary channel (see #01223)
 44h	BYTE	(82371SB) slave IDE timing register (see #01224)
 45h 187 BYTEs	reserved
SeeAlso: #01167,#01215,PORT xxxxh"Intel 82371SB"

Format of PCI Configuration data for Intel 82371SB Function 2 (USB):
Offset	Size	Description	(Table 01215)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 7020h)
 20h	DWORD	I/O space base address
		(see PORT xxxxh"Intel 82371SB")
 40h 32 BYTEs	reserved
 60h	BYTE	Serial Bus Specification release number
		00h pre-release 1.0
		10h Release 1.0
 61h  9 BYTEs	reserved
 6Ah	WORD	miscellaneous status (see #01225)
 6Ch 84 BYTEs	reserved
 C0h	WORD	legacy support (see #01226)
 C2h 62 BYTEs	reserved
SeeAlso: #01167,#01214,PORT xxxxh"Intel 82371SB"

Bitfields for Intel 82371FB/82371SB top of memory register:
Bit(s)	Description	(Table 01216)
 7-4	top of ISA memory (in megabytes, less 1; i.e. 0001 = 2M)
 3	ISA/DMA lower BIOS forwarding enable
 2	(82371SB) enable A000/B000 segment forwarding to PCI bus
 1	enable forwarding ISA/DMA 512K-640K region to PCI bus
 0	reserved
SeeAlso: #01167,#01217

Bitfields for Intel 82371FB/82371SB miscellaneous status register:
Bit(s)	Description	(Table 01217)
 15	(82371SB) enable SERR# on delayed transaction
	write 1 to clear this bit
 14-8	reserved
 7	(82371SB) NB Retry Enable
 6	(82371SB) EXTSMI# Mode Enable
	allow special SERR# protocol between PCI bridge and 82371
 5	reserved
 4	(82371SB) enable USB
	disable USB's master enable and I/O decode enable prior to
	 clearing this bit!
 3	reserved
 2	(82371FB) PCI Header Type Bit enable
	=1 report multifunction device in PCI configuration header
 1	(82371FB) internal ISA DMA/external DMA Mode status (read-only)
	=0 normal DMA operation
 0	(82371FB) ISA Clock Divisor status (read-only)
	(82371SB) ISA Clock Divisor (read-write)
	=1 SYSCLK clock divisor is 3
	=0 SYSCLK clock divisor is 4
SeeAlso: #01167,#01216

Bitfields for Intel 82371FB/82371SB/82371MX motherboard IRQ Route Control:
Bit(s)	Description	(Table 01218)
 7	disable IRQ routing
 6	enable MIRQx/IRQx sharing
 5	(82371SB only) enable IRQ0 output
 4	reserved (0)
 3-0	ISA IRQ number to which to route the PCI IRQ
Notes:	IRQs 0-2, 8, and 13 are reserved
	interrupt sharing should only be enabled when the device connected to
	  the MIRQ line and the device connected to the IRQ line both produce
	  active high, level triggered interrupts.
SeeAlso: #01167,#01168,#01216,#01219

Bitfields for Intel 82371FB/82371SB/82371MX motherboard DMA control:
Bit(s)	Description	(Table 01219)
 7	type F DMA buffer enable
 6-4	reserved
 3	(82371FB only) disable motherboadr DMA channel
	(SB/MX) reserved (0)
 2-0	DMA channel number (100 = disabled [default])
	(82371FB) Type F and Motherboard DMA
	(82371SB/MX) Type F DMA
SeeAlso: #01167,#01168,#01218

Bitfields for Intel 82371FB/83271SB programmable chip select control register:
Bit(s)	Description	(Table 01220)
 15-2	I/O address which will assert PCS# signal
 1-0	PCS address mask
	00 four bytes
	01 eight contiguous bytes
	10 disabled
	11 sixteen contiguous bytes
SeeAlso: #01167,#01219,#01221

Bitfields for Intel 82371SB Deterministic Latency Control register:
Bit(s)	Description	(Table 01221)
 7-4	reserved
 3	enable SERR# on delayed transaction timeout
 2	enable USB passive release
 1	enable passive release
 0	enable delayed transactions
SeeAlso: #01167,#01220

Bitfields for Intel 82371FB/82371SB SMI Control Register:
Bit(s)	Description	(Table 01222)
 7-5	reserved
 4-3	Fast-Off Timer freeze/granularity selection
	00 one minute granularity (assuming 33 MHz PCICLK)
	01 disabled (frozen)
	10 one PCICLK
	11 one millisecond
 2	STPCLK# scaling enable
	=1 enable Clock Scale bytes in PCI configuration space
 1	STPCLK# signal enable
	=1 assert STPCLK# on read from PORT 00B2h
 0	SMI# Gate
	=1 enable SMI# on system management interrupt
Notes:	bit 1 is cleared either with an explicit write of 0 here, or by any
	  write to PORT 00B2h
	bit 0 does not affect the recording of SMI events, so a pending SMI
	  will cause an immediate SMI# when the bit is set
SeeAlso: #01167,#01079

Bitfields for Intel 82371FB/82371SB/82371MX IDE timing modes:
Bit(s)	Description	(Table 01223)
 15	IDE decode enable
 14	(82371SB) slave IDE timing register enable (see #01224)
	(82371MX) primary/secondary address decode (=0 primary, =1 secondary)
 13-12	IORDY# sample point
	00 five clocks after DIOx# assertion
	01 four clocks
	10 three clocks
	11 two clocks
 11-10	reserved
 9-8	recovery time between IORDY# sample point and DIOx#
	00 four clocks
	01 three clocks
	10 two clocks
	11 one clock
 7	(FB/SB) DMA timing enable only, drive 1
	(MX) reserved
 6	prefetch and posting enable, drive 1
 5	IORDY# sample point enable drive select 1
 4	fast timing bank drive select 1
 3	(FB/SB) DMA timing enable only, drive 0
	(MX) reserved
 2	prefetch and posting enable, drive 0
 1	IORDY# sample point enable drive select 0
 0	fast timing bank drive select 0
SeeAlso: #01214,#01168

Bitfields for Intel 82371SB slave IDE timing register:
Bit(s)	Description	(Table 01224)
 7-6	secondary drive 1 IORDY# sample point
	00 five clocks after DIOx# assertion
	01 four clocks
	10 three clocks
	11 two clocks
 5-4	secondary drive 1 recovery time
	00 four clocks
	01 three clocks
	10 two clocks
	11 one clock
 3-2	primary drive 1 IORDY# sample point
 1-0	primary drive 1 recovery time
SeeAlso: #01223

Bitfields for Intel 82371SB miscellaneous status:
Bit(s)	Description	(Table 01225)
 15-1	reserved
 0	USB clock selection
	=1 48 MHz
	=0 24 MHz
SeeAlso: #01215,#01226

Bitfields for Intel 82371SB legacy support register:
Bit(s)	Description	(Table 01226)
 15	A20GATE pass-through sequence ended
	write 1 to clear this bit
 14	reserved
 13	USB PIRQ enabled
 12	USR IRQ status (read-only)
 11	trap caused by write to PORT 0064h
	write 1 to clear this bit
 10	trap caused by read from PORT 0064h
	write 1 to clear this bit
 9	trap caused by write to PORT 0060h
	write 1 to clear this bit
 8	trap caused by read from PORT 0060h
	write 1 to clear this bit
 7	enable SMI at end of A20GATE Pass-Through
 6	A20GATE pass-through sequence in progress (read-only)
 5	enable A20GATE pass-through sequence
	(write PORT 64h,D1h; write 60h,xxh; read 64h; write 64h,FFh)
 4	enable trap/SMI on USB IRQ
 3	enable trap/SMI on PORT 0064h write
 2	enable trap/SMI on PORT 0064h read
 1	enable trap/SMI on PORT 0060h write
 0	enable trap/SMI on PORT 0060h read
SeeAlso: #01215,#01225

Format of PCI Configuration Data for Intel 82557:
Offset	Size	Description	(Table 01227)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 1229h) (see #00873)
 10h	DWORD	base address of memory-mapped Control/Status Registers (4K)
		(see #01228)
 14h	DWORD	base address of I/O-mapped Control/Status Registers (32 ports)
 18h	DWORD	base address of Flash memory (1M)
 40h 192 BYTEs	unused
SeeAlso: #01098

Format of Intel 82557 Control/Status Registers:
Offset	Size	Description	(Table 01228)
 00h	WORD	SCB status word
 02h	WORD	SCB command word
 04h	DWORD	SCB general pointer
 08h	DWORD	PORT
 0Ch	WORD	Flash control register
 0Eh	WORD	EEPROM control register
 10h	DWORD	MDI control register
 14h	DWORD	Early RCV Interrupt Rx byte count (RXBC) register
Note:	see www.intel.com/design/network/datashts/64434604.pdf for additional
	  details
SeeAlso: #01228

Format of PCI Configuration Data for Intel 82441FX:
Offset	Size	Description	(Table 01229)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 1237h) (see #00873)
 40h 16 BYTEs	reserved
 50h	WORD	PMC Configuration (see #01230)
 52h	BYTE	deturbo counter control
		when deturbo mode is selected (see PORT 0CF9h), the chipset
		  places a hold on the memory bus for a fraction of the
		  time inversely proportional to the value in this register
		  (i.e. C0h = 1/4, 80h = 1/2, 40h = 3/4, 20h = 7/8, etc.)
 53h	BYTE	DBX buffer control (see #01231)
 54h	BYTE	auxiliary control (see #01232)
 55h	WORD	DRAM Row Type (see #01233)
 57h	BYTE	DRAM Control (see #01234)
 58h	BYTE	DRAM Timing (see #01235)
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #01118)
 60h  8 BYTEs	DRAM Row Buondary registers 0-7
		each register N indicates cumulative amount of memory in rows
		  0-N (each 64 bits wide), in 8M units
 68h	BYTE	Fixed DRAM Hole Control
 69h  7 BYTEs	reserved
 70h	BYTE	Multi-Transaction Timer
		number of PCLKs guaranteed to the current agent before the
		  82441 will grant the bus to another PCI agent on request
 71h	BYTE	CPU Latency Timer (see #01236)
 72h	BYTE	System Management RAM control (see #01123)
 73h 29 BYTEs	reserved
 90h	BYTE	Error Command (see #01237)
 91h	BYTE	Error Status (see #01238)
 92h	BYTE	reserved
 93h	BYTE	Turbo Reset Control (see #01239)
 94h 108 BYTEs	reserved
SeeAlso: #01098,#01108

Bitfields for Intel 82441FX PMC Configuration Register:
Bit(s)	Description	(Table 01230)
 15	WSC Protocol Enable
 14	Row Select/Extra Copy select (read-only)
	=1 pins on PMC configured as two additional row selects (6/7)
	=0 extra copy of two lowest memory address bits enabled
 13-10	reserved
 9-8	host frequence select
	00 reserved
	01 60 MHz
	10 66 MHz
	11 reserved
 7	reserved
 6	ECC/Parity TEST enable
 5-4	DRAM Data Integrity Mode
	00 no parity/ECC
	01 parity generated and checked
	10 ECC generated and checked, correction disabled
	10 ECC generated and checked, correction enabled
 3	reserved
 2	In-Order Queue size (0=one, 1=four)
 1-0	reserved
SeeAlso: #01229,#01231

Bitfields for Intel 82441FX DBX buffer control register:
Bit(s)	Description	(Table 01231)
 7	enable delayed transactions
 6	enable CPU-to-PCI IDE posting
 5	enable USWC Write Post during I/O Bridge access
 4	disable PCI Delayed Transaction timer
 3	enable CPU-to-PCI Write Post
 2	enable PCI-to-DRAM pipeline
 1	enable PCI Burst Write Combining
 0	enable Read-Around-Write
SeeAlso: #01229,#01230

Bitfields for Intel 82441FX auxiliary control register:
Bit(s)	Description	(Table 01232)
 7	enable RAS precharge
 6-2	reserved
 1	Lower Memory Address Buffer Set A
	=0 8mA
	=1 12mA
 0	reserved
SeeAlso: #01229

Bitfields for Intel 82441FX DRAM Row Type register:
Bit(s)	Description	(Table 01233)
 15-14	row 7 DRAM type
 13-12	row 6 DRAM type
 11-10	row 5 DRAM type
 9-8	row 4 DRAM type
 7-6	row 3 DRAM type
 5-4	row 2 DRAM type
 3-2	row 1 DRAM type
 1-0	row 0 DRAM type
	00 fast page-mode DRAM
	01 EDO DRAM
	10 BEDO DRAM
	11 empty row
SeeAlso: #01229,#01234

Bitfields for Intel 82441FX DRAM Control register:
Bit(s)	Description	(Table 01234)
 7	reserved
 6	enable DRAM Refresh Queue
 5	enable DRAM EDO Auto-Detect Mode
 4	DRAM Refresh Type
	=0 CAS before RAS
	=1 RAS only
 3	reserved
 2-0	DRAM refresh rate
	000 disabled
	001 normal (as set by PMCCFG register)
	01x reserved
	1xx reserved
	111 fast refresh (every 32 host clocks)
SeeAlso: #01229,#01233,#01235

Bitfields for Intel 82441FX DRAM Timing register:
Bit(s)	Description	(Table 01235)
 7	reserved
 6	enable WCBR Mode
 5-4	DRAM Read Burst Timing
		BEDO	EDO	FPM
	00	x333	x444	x444
	01	x222	x333	x444
	10	x222	x222	x333
	11	res.	res.	res.
 3-2	DRAM Write Burst Timing
		(B)EDO	FPM
	00	x444	x444
	01	x333	x444
	10	x333	x333
	11	x222	x333
 1	RAS-to-CAS delay
	=1 one clock
	=0 zero clocks
 0	insert one MA Wait State
SeeAlso: #01229,#01234

Bitfields for Intel 82441FX CPU Latency Timer register:
Bit(s)	Description	(Table 01236)
 7-5	reserved
 4-0	snoop stall count value
SeeAlso: #01229

Bitfields for Intel 82441FX Error Command register:
Bit(s)	Description	(Table 01237)
 7-5	reserved
 4	enable SERR# on receiving Target Abort
 3	enable SERR# on PCI Parity Error (PERR#)
 2	reserved
 1	enable SERR# on receiving multiple-bit ECC/Parity error
 0	enable SERR# on receiving single-bit ECC error
SeeAlso: #01229,#01238

Bitfields for Intel 82441FX Error Status register:
Bit(s)	Description	(Table 01238)
 7-5	DRAM row causing first multi-bit error (read-only)
 4	multiple-bit uncorrectable error detected
	write 1 to this bit to clear it
 3-1	DRAM row causing first single-bit error (read-only)
 0	single-bit correctable ECC error detected
	write 1 to this bit to clear it
SeeAlso: #01229,#01237

Bitfields for Intel 82441FX,82443EX/LX Turbo Reset Control register:
Bit(s)	Description	(Table 01239)
 7-4	reserved
 3	enable BIST on hard reset
 2	reset CPU
 1	reset mode (0 = soft reset, 1 = hard reset)
 0	deturbo mode (82441FX)
	reserved (82443EX/LX)
Note:	BIST should not be enabled during a soft reset
SeeAlso: #01229,#01129,PORT 0CF9h

Format of PCI Configuration data for Intel 82454KX/GX:
Offset	Size	Description	(Table 01240)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 8086h, device ID 84C4h)
!!!intel\29052301.pdf pg. 40
 40h	DWORD	top of system memory
 44h  4 BYTEs	reserved
 48h	BYTE	PCI decode mode
 49h	BYTE	bridge device number
 4Ah	BYTE	PCI bus number
 4Bh	BYTE	PCI subordinate bus number
 4Ch	BYTE	PB configuration
 4Dh  4 BYTEs	reserved
 51h	BYTE	deturbo counter control
 52h	BYTE	reserved
 53h	BYTE	CPU read/write control
 54h	WORD	PCI read/write control
 56h	BYTE	reserved
 57h	BYTE	SMM Enable
 58h	BYTE	video buffer area enable
 59h  7 BYTEs	Programmable Attribute Map registers 0-6 (see #01118)
 60h 16 BYTEs	reserved
 70h	BYTE	Error Command
 71h	BYTE	Error Status
 72h  6 BYTEs	reserved
 78h	WORD	memory gap range
 7Ah	WORD	memory gap upper address
 7Ch	DWORD	PCI frame buffer
 80h  8 BYTEs	reserved
 88h	DWORD	high memory gap start address
 8Ch	DWORD	high memory gap end address
 90h  8 BYTEs	reserved
 98h	DWORD	(GX only) I/O Space Range #1
 9Ch	BYTE	PCI reset
 9Dh  3 BYTEs	reserved
 A0h	DWORD	(GX only) I/O Space Range #2
 A4h	DWORD	I/O APIC range
 A8h  8 BYTEs	reserved
 B0h	WORD	configuration values driven on reset
 B2h  2 BYTEs	reserved
 B4h	WORD	captured system configuration values (read-only)
 B6h  2 BYTEs	reserved
 B8h	DWORD	SMM range
 BCh	BYTE	high BIOS register
 BDh  3 BYTEs	reserved
 C0h	DWORD	PB Extended Error Reporting Command
 C4h	DWORD	PB Extended Error Reporting Status
 C8h	DWORD	PB Retry Timers
 CCh 52 BYTEs	reserved
SeeAlso: #00878
--------X-1AB10ASF9004-----------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (Adaptec devices)
	AX = B10Ah subfn 9004h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh) (see #01241)
Return: CF clear if successful
	    ECX = dword read
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Ah/SF=8086h

Format of PCI Configuration Data for AIC-78xx PCI SCSI controllers:
Offset	Size	Description	(Table 01241)
 00h 64 BYTEs	header (see #00878)
		(vendor ID 9004h) (see #00875 for device ID)
 40h	WORD	device configuration register (DEVCONFIG) (see #01242)
SeeAlso: #00734,PORT xxxxh"Adaptec AIC-78xx"

Bitfields for AIC-78xx device configuration register (DEVCONFIG):
Bit(s)	Description	(Table 01242)
 15-11	reserved
 10	(AIC-787x+) multi-port mode (MPORTMODE)
 9	(AIC-787x+) external SRAM present? (RAMPSM)
 8	"VOLSENSE"
 7	SCB RAM select (SCBRAMSEL)
 6	"MRDCEN"
 5	(AIC-787x+) external SCB SRAM access time  (EXTSCBTIME)
 4	(AIC-787x+) external SCB SRAM parity enable (EXTSCBPEN)
 3	"BERREN"
 2	"DACEN"
 1	SCSI terminator power level (STPWLEVEL)
 0	(AIC-787x+) differential active negation enable (DIFACTNEGEN)
Note:	clearing bit 7 allows access to the external SCB SRAM
SeeAlso: #01241
--------X-1AB10B-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION BYTE
	AX = B10Bh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
	CL = byte to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h,AX=B10Ch,AX=B10Dh,AX=B18Bh,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10C-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION WORD
	AX = B10Ch
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 2 less than 0100h)
	CX = word to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B109h,AX=B10Bh,AX=B10Dh,AX=B18Ch,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10D-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION DWORD
	AX = B10Dh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 4 less than 0100h)
	ECX = dword to write
Return: CF clear if successful
	CF set on error
	AH = status (00h,87h) (see #00729)
	EAX, EBX, ECX, and EDX may be modified
	all other flags (except IF) may be modified
Notes:	this function may require up to 1024 byte of stack; it will not enable
	  interrupts if they were disabled before making the call
	the meanings of BL and BH on entry were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B10Bh,AX=B10Ch,AX=B18Dh,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10EBX0000-----------------------
INT 1A - PCI BIOS v2.1+ - GET IRQ ROUTING INFORMATION
	AX = B10Eh
	BX = 0000h
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
	ES:(E)DI -> IRQ routing table header (see #01259 at AX=B406h)
Return: CF clear if successful
	    AH = 00h
	    BX = bit map of IRQ channels permanently dedicated to PCI
	    WORD ES:[DI] = size of returned data
	CF set on error
	    AH = error code (59h) (see #01243)
	    WORD ES:[DI] = required size of buffer
SeeAlso: AX=B10Fh,AX=B406h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB10F-----------------------------
INT 1A - PCI BIOS v2.1+ - SET PCI IRQ
	AX = B10Fh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	CH = number of IRQ to connect
	CL = number of interrupt pin (0Ah=INTA# to 0Dh=INTD#) to reprogram
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (59h) (see #01243)
Note:	assumes that the calling application has determined the IRQ routing
	  topology (see AX=B10Eh), has ensured that the selected IRQ will not
	  cause a conflict, and will update the interrupt line configuration
	  register on all devices which currently use the IRQ line
SeeAlso: AX=B10Eh
--------X-1AB181-----------------------------
INT 1A - PCI BIOS v2.0c+ - INSTALLATION CHECK (32-bit)
	AX = B181h
Return: as for AX=B101h
SeeAlso: AX=B101h
--------X-1AB182-----------------------------
INT 1A - PCI BIOS v2.0c+ - FIND PCI DEVICE (32-bit)
	AX = B182h
	CX = device ID (see #00735,#00742,#00743,#00873,#00875)
	DX = vendor ID (see #00732 at AX=B102h)
	SI = device index (0-n)
Return: as for AX=B102h
SeeAlso: AX=B102h
--------X-1AB183-----------------------------
INT 1A - PCI BIOS v2.0c+ - FIND PCI CLASS CODE (32-bit)
	AX = B183h
	ECX = class code (bits 23-0)
	SI = device index (0-n)
Return: as for AX=B103h
SeeAlso: AX=B103h
--------X-1AB186-----------------------------
INT 1A - PCI BIOS v2.0c+ - PCI BUS-SPECIFIC OPERATIONS (32-bit)
	AX = B186h
	BH = bus number
	EDX = Special Cycle data
Return: as for AX=B106h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B106h
--------X-1AB188-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION BYTE (32-bit)
	AX = B188h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B108h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B108h,AX=B189h,AX=B18Ah
--------X-1AB189-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION WORD (32-bit)
	AX = B189h
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B109h
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B109h,AX=B188h,AX=B18Ah
--------X-1AB18A-----------------------------
INT 1A - PCI BIOS v2.0c+ - READ CONFIGURATION DWORD (32-bit)
	AX = B18Ah
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
Return: as for AX=B10Ah
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ah,AX=B188h,AX=B189h
--------X-1AB18B-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION BYTE (32-bit)
	AX = B18Bh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (0000h-00FFh)
	CL = byte to write
Return: as for AX=B10Bh
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Bh,AX=B18Ch,AX=B18Dh
--------X-1AB18C-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION WORD (32-bit)
	AX = B18Ch
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 2 less than 0100h)
	CX = word to write
Return: as for AX=B10Ch
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Ch,AX=B18Bh,AX=B18Dh
--------X-1AB18D-----------------------------
INT 1A - PCI BIOS v2.0c+ - WRITE CONFIGURATION DWORD (32-bit)
	AX = B18Dh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	DI = register number (multiple of 4 less than 0100h)
	ECX = dword to write
Return: as for AX=B10Dh
Note:	the meanings of BL and BH on return were exchanged between the initial
	  drafts of the specification and final implementation
SeeAlso: AX=B10Dh,AX=B18Bh,AX=B18Ch
--------X-1AB18EBX0000-----------------------
INT 1A - PCI BIOS v2.1+ - GET IRQ ROUTING INFORMATION (32-bit)
	AX = B18Eh
	BX = 0000h
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
	ES:(E)DI -> IRQ routing table header (see #01259 at AX=B406h)
Return: CF clear if successful
	    AH = 00h
	    BX = bit map of IRQ channels permanently dedicated to PCI
	    WORD ES:[DI] = size of returned data
	CF set on error
	    AH = error code (59h) (see #01243)
	    WORD ES:[DI] = required size of buffer
SeeAlso: AX=B10Fh,AX=B406h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB18F-----------------------------
INT 1A - PCI BIOS v2.1+ - SET PCI IRQ (32-bit)
	AX = B18Fh
	BH = bus number
	BL = device/function number (bits 7-3 device, bits 2-0 function)
	CH = number of IRQ to connect
	CL = number of interrupt pin (0Ah=INTA# to 0Dh=INTD#) to reprogram
	DS = segment/selector for PCI BIOS data
	    (real mode: F000h; 16-bit PM: physical 000F0000h; 32-bit PM: as
	    specified by BIOS32 services directory)
Return: CF clear if successful
	    AH = 00h
	CF set on error
	    AH = error code (59h) (see #01243)
Note:	assumes that the calling application has determined the IRQ routing
	  topology (see AX=B10Eh), has ensured that the selected IRQ will not
	  cause a conflict, and will update the interrupt line configuration
	  register on all devices which currently use the IRQ line
SeeAlso: AX=B10Eh
--------X-1AB2-------------------------------
INT 1A - Reserved For PCI
	AH = B2h
--------X-1AB3-------------------------------
INT 1A - Reserved For PCI
	AH = B3h
--------X-1AB400-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - INSTALLATION CHECK
	AX = B400h
Return: CF clear if installed
	AX = 0000h if installed
	    BH = ACFG major version (02h)
	    BL = ACFG minor version (08h)
	    CX = ??? (0002h)
	    EDX = 47464341h ('GFCA', which is byte-swapped 'ACFG')
	    SI = ??? (001Fh)
SeeAlso: AX=B401h,AX=B402h,AX=B403h,AX=B404h,AX=B405h,AX=B406h,AX=B407h
SeeAlso: @xxxxh:xxxxh"Plug-and-Play"

(Table 01243)
Values for Intel Plug-and-Play AUTO-CONFIGURATION error codes:
 0000h	successful
 0001h	specified action could not be completed
 0051h	???
 0055h	unable to read/write configuration table from/to nonvolatile storage
 0056h	not a valid configuration table or wrong table version
 0059h	buffer too small
 0081h	unsupported function
 FFFFh	???
SeeAlso: #F0081
--------X-1AB401-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET DEFAULT CONFIG TABLE
	AX = B401h
Return: CF clear if successful
	    AX = 0000h
	    BX = maximum size of configuration table in bytes
	    CX = required configuration buffer size
		(includes scratch space used by ACFG code)
	    EDI = linear/physical address of ESCD table (see #01244)
	CF set on error
	    AX = error code (see #01243)
SeeAlso: AX=B400h,AX=B402h,@xxxxh:xxxxh"Plug-and-Play"

Format of Intel Plug-and-Play Extended System Configuration Data table:
Offset	Size	Description	(Table 01244)
 00h	WORD	total length of this table
 02h  4 BYTEs	signature "ACFG"
 06h	BYTE	minor version number
 07h	BYTE	major version number (currently 02h)
 08h	BYTE	number of boards listed in the configuration data
 09h  3 BYTEs	reserved (00h)
 0Ch	var	board data
	WORD	checksum
Notes:	this table contains information about the standard devices in the
	  system, such as serial ports, parallel ports, etc.  For each device,
	  it includes at least the I/O port address (03F8h,02F8h,0378h,etc).
	the sum of all words in the table, including the checksum field (with
	  implied zero padding if the length is odd), must equal 0000h
SeeAlso: #01245

Format of Extended System Configuration Data Board Header:
Offset	Size	Description	(Table 01245)
 00h	WORD	length of this header in bytes
 02h	BYTE	slot number
		00h motherboard
		01h-0Fh ISA/EISA
		10h-40h	PCI
 03h	BYTE	reserved (00h)
SeeAlso: #01244,#01246

Format of Extended System Configuration Data Freeform Board Header:
Offset	Size	Description	(Table 01246)
 00h  4 BYTEs	signature "ACFG"
 04h	BYTE	minor version number
 05h	BYTE	major version number (currently 02h)
 06h	BYTE	board type
		01h ISA
		02h EISA
		04h PCI
		08h PCMCIA
		10h PnPISA
		20h MCA
 07h	BYTE	reserved (00h)
 08h	WORD	disabled functions (bit N set = function N disabled)
 0Ah	WORD	configuration error functions
 0Ch	WORD	reconfigurable functions (bit N set = function N reconfig'able)
 0Eh  2 BYTEs	reserved (00h)
SeeAlso: #01249,#01250

Format of Extended System Configuration Data Freeform PCI Device Data:
Offset	Size	Description	(Table 01247)
 00h	BYTE	PCI bus number
 01h	BYTE	PCI device and function number
 02h	WORD	PCI device identifier
 04h	WORD	PCI vendor ID (see #00732 at INT 1A/AX=B102h)
 06h  2 BYTEs	reserved (00h)
SeeAlso: #01247,#01250

Format of Extended System Configuration Data Freeform PnP ISA Board ID:
Offset	Size	Description	(Table 01248)
 00h	DWORD	vendor ID (EISA device identifier)
 04h	DWORD	serial number
SeeAlso: #01248,#01249

Format of Extended System Configuration Data PnP ISA ECD Extension Function:
Offset	Size	Description	(Table 01249)
 00h	WORD	001Eh (length of this structure)
 02h	BYTE	01h (selection size)
 03h	BYTE	00h (selection data)
 04h	BYTE	C0h (function information byte) (see #01252)
 05h	BYTE	18h (size of following free-format data)
 06h 16 BYTEs	freeform board header (see #01246)
 16h  8 BYTEs	Plug-and-Play board ID (see #01248)
Note:	ECD = Extended Configuration Data; this structure must be the last
	  "function" for a particular ISA Plug-and-Play board
SeeAlso: #01250

Format of Extended System Configuration Data PCI ECD Extension Function:
Offset	Size	Description	(Table 01250)
 00h	WORD	length of this structure (at least 001Eh, up to 0056h)
 02h	BYTE	01h (selection size)
 03h	BYTE	00h (selection data)
 04h	BYTE	C0h (function information byte) (see #01252)
 05h	BYTE	size of following free-format data (at least 18h, max 50h)
 06h 16 BYTEs	freeform board header (see #01246)
 16h 8N BYTEs	PCI board ID (see #01247) for one to eight boards
Notes:	ECD = Extended Configuration Data; this structure must be the last
	  "function" for a particular PCI board
	AMI BIOS v1.00.05.AX1 sets the length field to 001Ch for entries with
	  a single board ID, apparently treating the field as the length of
	  the remainder of the structure instead of the full structure's length
SeeAlso: #01249

Bitfields for EISA ID and Slot Information:
Bit(s)	Description	(Table 01251)
 3-0	selector among duplicate configuration file names (0000 if no dups)
 5-4	slot type
	00 expansion slot
	01 embedded
	10 virtual slot
	11 reserved
 6	ID is readable
 7	duplicate IDs present
 8	board can be disabled
 9	IOCHKERR supported
 10	board or entries locked
 13-11	reserved
 14	board does not have or need configuration file
 15	configuration not complete
SeeAlso: #01252

Bitfields for EISA Function Information:
Bit(s)	Description	(Table 01252)
 0	subtype data
 1	memory information (see #01253)
 2	IRQ information (see #01255)
 3	DMA information (see #01256)
 4	port range information (see #01257)
 5	port initialization data (see #01258)
 6	free form data
 7	function disabled
SeeAlso: #01249,#01250,#01251

Format of EISA Memory Information:
Offset	Size	Description	(Table 01253)
 00h	WORD	memory information flags (see #01254)
 02h  3 BYTEs	high 24 bits of memory start address (LSB first)
 05h	WORD	memory size in K (0000h = 65536K)
SeeAlso: #01252

Bitfields for EISA Memory Information Flags:
Bit(s)	Description	(Table 01254)
 0	writable (RAM rather than ROM)
 1	cached
 2	write-back cache rather than write-through
 4-3	memory type
	00 system
	01 expantion
	10 virtual
	11 other
 5	shared
 6	reserved (0)
 7	more entries follow
 9-8	memory width
	00 byte
	01 word
	10 dword
	11 reserved
 11-10	decoded address lines
	00 = 20
	01 = 24
	10 = 32
	11 reserved
 15-12	reserved (0)
SeeAlso: #01253

Bitfields for EISA IRQ Information:
Bit(s)	Description	(Table 01255)
 3-0	IRQ number
 4	reserved (0)
 5	IRQ triggering (0 = edge, 1 = level)
 6	IRQ is shareable
 7	more entries follow
 15-8	reserved (0)
SeeAlso: #01252

Bitfields for EISA DMA Information:
Bit(s)	Description	(Table 01256)
 2-0	DMA channel number
 5-3	reserved (0)
 6	shareable
 7	more entries follow
 9-8	reserved
 11-10	DMA transfer size
	00 byte
	01 word
	10 dword
	11 word, but count in bytes
 13-12	DMA timing
	00 ISA-compatible
	01 EISA type "A"
	10 EISA type "B"
	11 EISA type "C"/"F" (burst)
 15-14	reserved (0)
SeeAlso: #01252

Format of EISA Port Range Information:
Offset	Size	Description	(Table 01257)
 00h	BYTE	port description
		bits 4-0: number of sequential ports
		bit 5 reserved (0)
		bit 6: shareable
		bit 7: more entries follow
 01h	WORD	I/O port address
SeeAlso: #01252,#01258

Format of EISA Port Initialization Data:
Offset	Size	Description	(Table 01258)
 00h	BYTE	flags
		bits 1-0: port size
			00 byte
			01 word
			10 dword
			11 reserved
		bit 2: masked write
		bits 6-3 reserved (0)
		bit 7: more entries follow
 01h	???
SeeAlso: #01252,#01257
--------X-1AB402-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - COPY AND VERIFY CONFIG TABLE
	AX = B402h
	DS:SI -> configuration table (see #01244)
	ES:DI -> buffer for copy of configuration table
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (0055h,0056h) (see #01243)
Note:	the buffer pointed at by ES:DI must be at least as large as the
	  maximum configuration table size reported by AX=B401h
SeeAlso: AX=B400h,AX=B401h,AX=B403h
--------X-1AB403-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - STORE ESCD TABLE IN NVRAM
	AX = B403h
	DS:SI -> configuration table (see #01244)
Return: CF clear if successful
	    AX = 0000h
	CF set on error
	    AX = error code (0055h) (see #01243)
Note:	sets the configuration table's checksum field, then copies the table
	  into nonvolatile storage (i.e. FlashROM)
SeeAlso: AX=B400h,AX=B402h
--------X-1AB404-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET AVAILABLE IRQs???
	AX = B404h
	BX = bitmap of IRQs being used???
Return: CF clear if successful
	    AX = 0000h
	    BX = available for ISA??? (not(BXin) & A127h)
	    CX = available for on-board I/O??? (not(BXin) & 40D8h)
	    DX = available for PCI??? (either not(BXin) & 0E00h or 0000h)
	CF set on error
	    AX = error code (0051h) (see #01243)
Note:	the various vector types have also been called "shareable",
	  "unshareable", and "avoidable"
SeeAlso: AX=B400h,INT 2F/AX=1684h/BX=304Ch
--------X-1AB405-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET ???
	AX = B405h
Return: AX = ??? (0008h)
SeeAlso: AX=B400h
--------X-1AB406-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - GET PCI IRQ ROUTING TABLE
	AX = B406h
	ES:DI -> IRQ routing table header (see #01259)
Return: CF clear if successful
	    AX = 0000h
	    WORD ES:[DI] = size of returned data
	CF set on error
	    AX = error code (0059h) (see #01243)
	    WORD ES:[DI] = required size of buffer
SeeAlso: AX=B400h,AX=B404h,AX=B10Eh,INT 2F/AX=1684h/BX=304Ch

Format of Intel Plug-and-Play AUTO-CONFIGURATION PCI IRQ routing header:
Offset	Size	Description	(Table 01259)
 00h	WORD	length of IRQ routing table buffer
 02h	DWORD	-> IRQ routing table array buffer (see #01260)

Format of Intel Plug-and-Play ACFG PCI IRQ routing table entry [array]:
Offset	Size	Description	(Table 01260)
 00h	BYTE	PCI bus number
 01h	BYTE	PCI device number (bits 7-3)
 02h	BYTE	link value for INTA#
		(if non-zero, wire-ORed together with any other PCI interrupts
		  with same link value)
 03h	WORD	IRQ connectivity bit map for INTA#
		(standard AT IRQs to which PCI interrupt can be routed)
 05h	BYTE	link value for INTB#
 06h	WORD	IRQ connectivity bit map for INTB#
 08h	BYTE	link value for INTC#
 09h	WORD	IRQ connectivity bit map for INTC#
 0Bh	BYTE	link value for INTD#
 0Ch	WORD	IRQ connectivity bit map for INTD#
 0Eh	BYTE	(PCI BIOS v2.1+) device slot number (00h = motherboard)
 0Fh	BYTE	reserved
Note:	each item in the routing table corresponds to a motherboard PCI
	  device or PCI slot
SeeAlso: #01259,#M0091
--------X-1AB407-----------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - ???
	AX = B407h
	EDX = length of ???
	EDI = physical address of ???
Return: CF clear if successful
	    AX = 0000h
	    EDX = ???
	    EDI = ???
	CF set on error
	    AX = error code (FFFFh) (see #01243)
Notes:	returns error if EDI < 000C0000h or EDI+EDX > 00100000h
	seems to force EDI and EDX to align to 16K boundaries
SeeAlso: AX=B400h
--------X-1AB4-------------------------------
INT 1A - Intel Plug-and-Play AUTO-CONFIGURATION - 32-BIT API
	AH = B4h
	AL = function (80h-87h)
	further details not yet available
Note:	these functions are 32-bit versions of functions 00h-07h
--------c-1AC0-------------------------------
INT 1A U - Disk Spool II v2.07+ - ALTERNATE INSTALLATION CHECK
	AH = C0h
Return: (see AH=A0h)
Notes:	this call is identical to AH=A0h
	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=ABh,AH=D0h
--------U-1ACCCCBXCCCC-----------------------
INT 1A U - DATEFIX - INSTALLATION CHECK
	AX = CCCCh
	BX = CCCCh
	CX = 0000h
Return: CX = CCCCh if installed
	    ES:BX -> original interrupt handler
Program: DATEFIX is a public-domain TSR to correct the date on AT&T 6300
	  machines, where the realtime clock's calendar wraps after 1991
SeeAlso: AH=FEh,AH=FFh"AT&T"
--------c-1AD0-------------------------------
INT 1A U - Disk Spool II v2.07+ - FUNCTION CALLS
	AH = D0h
	AL = function code
	    01h enable spooler and despooler
	    02h enable spooler only
	    03h enable despooler at beginning of file
	    04h disable the despooler
	    05h disable the despooler and spooler
	    06h clear the spool file
	    08h inhibit the popup menu
	    09h enable the popup menu
	    0Ah ??? (called by Disk Spool's INT 21 handler)
	    0Bh disable the spooler
	    0Ch start despooler after last successfully printed document
	    0Dh start despooler at the exact point where it last left off
	    0Eh pop up the menu
	    0Fh ???
	    11h start new spool file??? (called by Disk Spool's INT 21 handler
			when a program terminates)
	    14h ???
	    15h delete despool file and reset ???
	    16h ??? (writes something to unknown file)
	    17h ??? (writes something to despool file, then reads something
			else and ???)
	    18h ??? (reads something from despool file, and then ???)
	    19h ??? (creates/truncates spool file)
	    20h clear file pointed to by the despooler
	    21h ??? (writes something to unknown file)
	    22h ??? (writes something to spool file if spooler/despooler using
			same file)
	    23h ??? (opens/creates unknown file, then ???)
	    30h ???
	    31h ???
	    32h beep
	    33h append CRLF to spool file???
	    34h ???
	    35h ???
	    36h ???
	    37h append CRLF to spool file and start a new spool file???
	    38h ???
	    40h ??? (v4.05)
	    41h ??? (v4.05)
	    51h ??? (called by Disk Spool's INT 21 handler)
	    52h ??? (called by Disk Spool's INT 21 handler)
	    57h ???
	    5Ah ??? (v4.05)
	    5Bh ??? (v4.05)
	    5Ch ??? (v4.05)
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=ADh
--------c-1AE0-------------------------------
INT 1A - Disk Spool II v4.0x - ENABLE/DISABLE
	AH = E0h
	AL = subfunction
	    01h enable spooler
	    02h disable spooler
	    03h enable despooler
	    04h disable despooler
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    F0h printer port not managed by Disk Spool II
	    FFH failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=E1h,AX=E301h,AX=E401h
--------c-1AE1-------------------------------
INT 1A - Disk Spool II v4.0x - GET STATUS
	AH = E1h
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
		CL = despooler state (00h disabled, 41h enabled)
		CH = spooler state (00h disabled, 41h enabled)
		DL = despooler activity (00h standing by, 41h printing)
		ES:BX -> ASCIZ name of current spool file (or next if AutoSpool
			or AutoDespool enabled)
		ES:SI -> ASCIZ name of current despool file
		ES:DI -> 3-byte file extension used by Disk Spool II
	    F0h printer port not managed by Disk Spool II
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=A0h,AH=E0h,AH=E2h
--------U-1AE11B-----------------------------
INT 1A - TheGrab v4.60 - ???
	AX = E11Bh
	???
Return: ??? (may destroy all registers)
SeeAlso: AX=E11Dh
--------U-1AE11D-----------------------------
INT 1A - TheGrab v4.60 - INSTALLATION CHECK
	AX = E11Dh
Return: ES:DI -> signature block (see #01261) if installed
	    CX = length of signature block (000Fh)
Program: TheGrab is a resident ANSI screen grabber bundled with TheDraw
SeeAlso: AX=E11Bh

Format of TheGrab signature block:
Offset	Size	Description	(Table 01261)
 00h	BYTE	08h
 01h  8 BYTEs	ASCIZ "THEGRAB"
 09h  6 BYTEs	??? (zeros)
--------c-1AE2-------------------------------
INT 1A - Disk Spool II v4.0x - GET SPOOL FILES
	AH = E2h
	AL = which
	    01h first
	    02h next (can only call after "first")
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
		ES:BX -> ASCIZ filename
	    F0h no (more) spool files
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AH=E1h
--------c-1AE301-----------------------------
INT 1A - Disk Spool II v4.0x - GET SPOOL FILE STATUS
	AX = E301h
	ES:BX -> ASCIZ filename (max 32 chars)
Return: AH = status
	    00h successful
		ES:SI -> spool file status record (see #01262)
	    F0h not a spool file
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AX=E302h,AX=E401h

Format of Disk Spool II spool file status record:
Offset	Size	Description	(Table 01262)
 00h	BYTE	hour of creation or last update
 01h	BYTE	minute of creation or last update
 02h	BYTE	year-1980 of creation or last update
 03h	BYTE	month of creation or last update
 04h	BYTE	day of creation or last update
 05h	BYTE	total number of copies to print
 06h	BYTE	number of copies already printed
 07h	BYTE	printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
 08h	BYTE	save status (00h delete after printing, 01h save)
 09h	BYTE	file status
		01h done printing, but being saved
		02h on hold
		03h queued for printing
		04h being spooled
		05h being despooled (i.e. printed)
 0Ah 16 BYTEs	ASCIZ description
 1Ah  2 WORDs	file size in bytes (high,low)
 1Eh  2 WORDs	bytes left to print (high,low)
--------c-1AE302-----------------------------
INT 1A - Disk Spool II v4.0x - UPDATE SPOOL FILE
	AX = E302h
	ES:BX -> ASCIZ filename (max 32 chars)
	ES:SI -> spool file status record (see #01262)
Return: AH = status
	    00h successful
	    F0h not a spool file
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E0h,AX=E301h,AX=E401h
--------c-1AE401-----------------------------
INT 1A - Disk Spool II v4.0x - SPOOL EXISTING FILE
	AX = E401h
	ES:BX -> ASCIZ filename (max 32 chars)
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h,AX=E302h,AX=E402h
--------c-1AE402-----------------------------
INT 1A U - Disk Spool II v4.0x - SPOOL EXISTING FILE???
	AX = E402h
	ES:BX -> ASCIZ filename (max 32 chars)
	CL = printer port (01h COM1, 02h COM2, 05h LPT1, 06h LPT2)
Return: AH = status
	    00h successful
	    FFh failed
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h,AX=E302h,AX=E401h
--------c-1AE5-------------------------------
INT 1A U - Emulaser ELSPL.COM - ???
	AH = E5h
	???
Return: ???
Program: ELSPL.COM is a licensed version of Disk Spool II which is distributed
	  as part of Vertisoft's Emulaser PostScript emulator
SeeAlso: AH=A0h,INT 17/AH=03h
--------c-1AEE-------------------------------
INT 1A U - Disk Spool II v4.05 - ???
	AH = EEh
	AL = printer port???
	???
Return: ???
Note:	this function is also supported by Vertisoft's Emulaser utility ELSPL,
	  as that is a licensed version of Disk Spool II
SeeAlso: AH=E1h
--------U-1AF7-------------------------------
INT 1A - RighTime v1.1 - TEMPORARILY DISABLE
	AH = F7h
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the
	  system time to correct for clock drift
Note:	any AH value from F0h-F7h or F9h-FEh will perform this function in
	  version 1.1, but F7h is the function called by transient portion
SeeAlso: AH=F8h,AH=FFh"RighTime"
--------U-1AF8-------------------------------
INT 1A - RighTime v1.1 - ENABLE
	AH = F8h
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the
	  system time to correct for clock drift
Note:	RighTime is TeSseRact-compatible (see INT 2F/AX=5453h) and modifies its
	  TeSseRact program identifier based on its current state: "RighTime"
	  when enabled, "RighTim"F7h when disabled.
SeeAlso: AH=F7h,AH=FFh"RighTime"
--------b-1AFE-------------------------------
INT 1A - AT&T 6300 - READ TIME AND DATE
	AH = FEh
Return: BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
SeeAlso: AX=CCCCh/BX=CCCCh,AH=FFh"AT&T",INT 21/AH=2Ah,INT 21/AH=2Ch
--------b-1AFF-------------------------------
INT 1A - AT&T 6300 - SET TIME AND DATE
	AH = FFh
	BX = day count (0 = Jan 1, 1984)
	CH = hour
	CL = minute
	DH = second
	DL = hundredths
Return: ???
SeeAlso: AX=CCCCh/BX=CCCCh,AH=FEh,INT 21/AH=2Bh"DATE",INT 21/AH=2Dh
--------U-1AFF-------------------------------
INT 1A - RighTime v1.1 - PERMANENTLY DISABLE
	AH = FFh
Program: RighTime is a TSR by G.T. Becker which continuously adjusts the
	  system time to correct for clock drift
Note:	upon being permanently disabled, RighTime closes the file handle
	  referencing its executable (which is updated with time correction
	  information every two minutes while RighTime is enabled).
--------s-1AFF00-----------------------------
INT 1A - SND - INSTALLATION CHECK???
	AX = FF00h
Return: AL = version??? (02h)
	AH = busy flag (00h if not in a SND call, 01h if SND currently active)
Note:	the SND API is also supported by IC (Internal Commands) v2.0, a
	  shareware TSR by Geoff Friesen which extends COMMAND.COM's internal
	  command set
SeeAlso: AX=FF01h,AX=FF02h,AX=FF04h,AX=FF05h
--------s-1AFF01-----------------------------
INT 1A - SND - PAUSE
	AX = FF01h
	DX = number of clock ticks to delay
Return: AH = status
	    00h successful
	    01h SND busy
Notes:	if successful, execution returns to the caller after the delay expires;
	  if SND is busy, execution returns immediately
	the IC v2.0 implementation of this API makes no special allowance for
	  time rollover at midnight, which can cause the delay to be over one
	  hour if this function is called just before the BIOS time count
	  rolls over and the delay extends into the next day
SeeAlso: AX=FF00h,INT 15/AH=86h,INT 62/AX=0096h,INT 7F/AH=E8h,INT 80/BX=0009h
SeeAlso: INT E0/CL=BDh
--------s-1AFF02-----------------------------
INT 1A - SND - START SOUND
	AX = FF02h
	DX = frequency in Hertz (14h-FFFFh)
Return: AH = status
	    00h successful
	    01h SND busy
SeeAlso: AX=FF00h,AX=FF01h,AX=FF03h
--------s-1AFF03-----------------------------
INT 1A - SND - STOP SOUND
	AX = FF03h
Return: AH = status
	    00h successful
	    01h busy
Note:	turns off any sound currently being emitted by the PC's speaker unless
	  SND is currently busy processing an API call (this includes
	  background music).  Use AX=FF05h to stop the sound even if an API
	  call is in progress.
SeeAlso: AX=FF00h,AX=FF02h,AX=FF05h
--------s-1AFF04-----------------------------
INT 1A - SND - PLAY MUSIC STRING IN BACKGROUND
	AX = FF04h
	DS:DX -> ASCIZ music string
Return: AH = status
	    00h successful (music begins playing in background)
	    01h busy
Note:	the music string accepted by SND is not the same as that accepted by
	  BASIC and other programs which process music strings
SeeAlso: AX=FF00h,AX=FF05h,INT 80/BX=0006h
--------s-1AFF05-----------------------------
INT 1A - SND - UNCONDITIONALLY STOP SOUND
	AX = FF05h
Return: AH = 00h (successful)
Note:	this function is the same as AX=FF03h, but will stop the sound even if
	  SND is currently busy, such as playing background music
SeeAlso: AX=FF00h,AX=FF03h,INT 80/BX=0007h
--------B-1B---------------------------------
INT 1B C - KEYBOARD - CONTROL-BREAK HANDLER
Desc:	this interrupt is automatically called when INT 09 determines that
	  Control-Break has been pressed
Note:	normally points to a short routine in DOS which sets the Ctrl-C flag,
	  thus invoking INT 23h the next time DOS checks for Ctrl-C.
SeeAlso: INT 23,MEM 0040h:0071h
--------B-1C---------------------------------
INT 1C - TIME - SYSTEM TIMER TICK
Desc:	this interrupt is automatically called on each clock tick by the INT 08
	  handler
Notes:	this is the preferred interrupt to chain when a program needs to be
	  invoked regularly
	not available on NEC 9800-series PCs
SeeAlso: INT 08,INT E2"PC Cluster"
--------B-1D---------------------------------
INT 1D - SYSTEM DATA - VIDEO PARAMETER TABLES
Notes:	the default parameter table (see #01263) is located at F000h:F0A4h for
	  100% compatible BIOSes
	Under PhysTechSoft's PTS ROM-DOS this table is fictitious.
SeeAlso: INT 10/AH=00h

Format of video parameters:
Offset	Size	Description	(Table 01263)
 00h 16 BYTEs	6845 register values for modes 00h and 01h
 10h 16 BYTEs	6845 register values for modes 02h and 03h
 20h 16 BYTEs	6845 register values for modes 04h and 05h
 30h 16 BYTEs	6845 register values for modes 06h and 07h
 40h	WORD	bytes in video buffer for modes 00h and 01h (0800h)
 42h	WORD	bytes in video buffer for modes 02h and 03h (1000h)
 44h	WORD	bytes in video buffer for modes 04h and 05h (4000h)
 46h	WORD	bytes in video buffer for mode 06h (4000h)
 48h  8 BYTEs	columns on screen for each of modes 00h through 07h
 50h  8 BYTEs	CRT controller mode bytes for each of modes 00h through 07h
Note:	QEMM v7.5 Stealth appears to copy only the first 40h bytes of this
	  table into always-accessible memory
--------B-1E---------------------------------
INT 1E - SYSTEM DATA - DISKETTE PARAMETERS
Notes:	the default parameter table (see #01264) is located at F000h:EFC7h for
	  100% compatible BIOSes
	if the table is changed, INT 13/AH=00h should be called to ensure that
	  the floppy-disk controller is appropriately reprogrammed
	before rebooting the machine, this pointer should be restored to point
	  to the original position of the floppy parameters in the ROM BIOS.
	  The DOS boot sector takes care of this and in the case of a bootstrap
	  error, resets the vector. It also passes the original pointer to the
	  IO.SYS/IBMDOS.COM file for possible later restoration.
	under PhysTechSoft's PTS ROM-DOS this table is fictitious.
	the DR-DOS multi-OS LOADER (at least 1.04 up to including DR-DOS 7.03)
	  does not alter the INT 1Eh vector when launching IBMBIO.COM files
	  via its boot methods "S" or "D".  Although this allows booting
	  (uncompressed) IBMBIO.COM files bigger than 29 KB, it may
	  occasionally cause the floppy parameters to get trashed due to a 
	  bug in the DR-DOS 7.03 IBMBIO.COM startup code.
BUG:	The 2nd level decompressor of the DR-DOS 7.03 IBMBIO.COM (1998/08/11 to
	  1999/07) start-up code erroneously assumes that the floppy parameters
	  reside at 0000h:7C00h (normally set up there by the boot sector)
	  instead of relying on the INT 1Eh vector to point at their location.
	  Since the "assumed" floppy parameters get moved around and INT 1Eh
	  gets updated to point to their new location, this may cause the
	  contents of the floppy params to get trashed, if they weren't
	  actually copied to 0000h:7C00h by the bootstrap loader (that is the
	  boot sector or the LOADER utility).
SeeAlso: INT 13/AH=0Fh,INT 41"HARD DISK 0",INT 4D/AH=0Ah

Format of diskette parameter table:
Offset	Size	Description	(Table 01264)
 00h	BYTE	first specify byte
		bits 7-4: step rate (Fh=2ms,Eh=4ms,Dh=6ms,etc.)
		bits 3-0: head unload time (0Fh = 240 ms)
 01h	BYTE	second specify byte
		bits 7-1: head load time (01h = 4 ms)
		bit    0: non-DMA mode (always 0)
		Note:	The DOS boot sector sets the head load time to 15ms,
			  however, one should retry the operation on failure
 02h	BYTE	delay until motor turned off (in clock ticks)
 03h	BYTE	bytes per sector (00h = 128, 01h = 256, 02h = 512, 03h = 1024)
 04h	BYTE	sectors per track (maximum if different for different tracks)
 05h	BYTE	length of gap between sectors (2Ah for 5.25", 1Bh for 3.5")
 06h	BYTE	data length (ignored if bytes-per-sector field nonzero)
 07h	BYTE	gap length when formatting (50h for 5.25", 6Ch for 3.5")
 08h	BYTE	format filler byte (default F6h)
 09h	BYTE	head settle time in milliseconds
 0Ah	BYTE	motor start time in 1/8 seconds
---IBM SurePath BIOS---
 0Bh	BYTE	maximum track number
 0Ch	BYTE	data transfer rate
 0Dh	BYTE	drive type in CMOS
SeeAlso: #03226 at INT 4D/AH=09h
--------B-1F---------------------------------
INT 1F - SYSTEM DATA - 8x8 GRAPHICS FONT
Desc:	this vector points at 1024 bytes of graphics data, 8 bytes for each
	  character 80h-FFh
Notes:	graphics data for characters 00h-7Fh stored at F000h:FA6Eh in 100%
	  compatible BIOSes
	Under PhysTechSoft's PTS ROM-DOS this table is fictitious.
SeeAlso: INT 10/AX=5000h,INT 43
--------b-1F12-------------------------------
INT 1F U - C&T "SuperState" BIOS - POWER OFF
	AH = 12h
Return: none
Note:	POWER OFF
--------b-1F17-------------------------------
INT 1F U - C&T "SuperState" BIOS - EXECUTE FAR PROC ROUTINE ON SuperState
	AH = 17h
	ES:DI -> far procedure
Return: all registers except AH,ES,DI
Note:	You can change the BIOS area (F000h:0000h - F000h:FFFFh) only through
	  this function
--------b-1F19-------------------------------
INT 1F U - C&T "SuperState" BIOS - ENABLE AUTO WAKEUP AND SET TIME AND DATE
	AH = 19h
	AL = hour in BCD
	BH = minutes in BCD
	BL = seconds in BCD
	CH = year century in BCD (must be 19h)
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
Return: CF clear
--------b-1F1C-------------------------------
INT 1F U - C&T "SuperState" BIOS - SET SUSPEND TIMEOUT
	AH = 1Ch
	BX = sec until suspend starts
Return: None
--------b-1F1D-------------------------------
INT 1F U - C&T "SuperState" BIOS - SET SLEEP TIMEOUT
	AH = 1Dh
	BX = sec until sleep starts
Return: None
--------J-1F90-------------------------------
INT 1F - NEC PC-9801 - COPY EXTENDED MEMORY
	AH = 90h
	ES:BX -> global descriptor table (see #00499 at INT 15/AH=87h)
	CX = number of bytes to copy
	SI = 0000h
	DI = 0000h
Return: CF clear if successful
	CF set on error
	???
SeeAlso: INT 15/AH=87h
--------b-1FF5--BLFA-------------------------
INT 1F U - C&T "SuperState" BIOS - REQUEST PASSWORD INPUT
	AH = F5h
	BL = FAh
Return: none
Note:	this function will not return until the correct password is entered
SeeAlso: AH=F5h/BL=FDh,AH=F5h/BL=FEh
--------b-1FF5--BLFD-------------------------
INT 1F U - C&T "SuperState" BIOS - ENCRYPT PASSWORD
	AH = F5h
	BL = FDh
	CX:SI = input string
	DX:DI = encrypted string
	BH = length of input string
Return: CF set on error
SeeAlso: AH=F5h/BL=FAh,AH=F5h/BL=FEh
--------b-1FF5--BLFE-------------------------
INT 1F U - C&T "SuperState" BIOS - SET PASSWORD
	AH = F5h
	BL = FEh
	CX:SI -> input string
	BH = length of input string (if BH = 00h, clear password)
Return: CF set on error
Note:	the input string must be encrypted by INT 1Fh/AH=F5h/BL=FDh
SeeAlso: AH=F5h/BL=FDh,AH=F5h/BL=FFh
--------b-1FF5--BLFF-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ENCRYPTED PASSWORD
	AH = F5h
	BL = FFh
	DX:DI = string buffer
Return: CF set on error
	CF clear if successful
	    BH = length of input string (if BH = 00h, password is not valid)
	    DX:DI -> encrypted password string
SeeAlso: AH=F5h/BL=FDh,AH=F5h/BL=FEh
--------b-1FFB-------------------------------
INT 1F U - C&T "SuperState" BIOS - GET/SET CPU SPEED
	AH = FBh
	BL = function
	    00h get CPU speed
		Return: AL = current CPU speed (00h = fast, 01h = slow)
	    01h set CPU speed
		AL = new CPU speed (00h = fast, 01h = slow)
SeeAlso: AH=FCh/BL=00h
--------b-1FFC--BL00-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM STATUS
	AH = FCh
	BL = 00h
Return: AL = current alarm state (00h = disabled, 01h = enabled)
SeeAlso: AH=FCh/BL=01h,AH=FCh/BL=02h
--------b-1FFC--BL01-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM STATUS
	AH = FCh
	BL = 01h
	AL = new alarm state (00h = disabled, 01h = enabled)
SeeAlso: AH=FCh/BL=00h,AH=FCh/BL=03h
--------b-1FFC--BL02-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM TIME
	AH = FCh
	BL = 02h
Return: CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
SeeAlso: AH=FCh/BL=00h,AH=FCh/BL=03h,AH=FCh/BL=04h
--------b-1FFC--BL03-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM TIME
	AH = FCh
	BL = 03h
	CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
Return: CF set on error (incorrect time format or Alarm is not enable)
SeeAlso: AH=FCh/BL=01h,AH=FCh/BL=02h,AH=FCh/BL=05h
--------b-1FFC--BL04-------------------------
INT 1F U - C&T "SuperState" BIOS - GET ALARM DATE
	AH = FCh
	BL = 04h
Return: CH = year century by BCD
	CL = year low by BCD
	DH = month by BCD
	DL = date by BCD
SeeAlso: AH=FCh/BL=02h,AH=FCh/BL=05h
--------b-1FFC--BL05-------------------------
INT 1F U - C&T "SuperState" BIOS - SET ALARM DATE
	AH = FCh
	BL = 05h
	CH = year century by BCD
	CL = year low by BCD
	DH = month by BCD
	DL = date by BCD
Return: CF set on error (incorrect date format or Alarm is not enable)
SeeAlso: AH=FCh/BL=03h,AH=FCh/BL=04h
--------b-1FFD--BL00-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP STATUS
	AH = FDh
	BL = 00h
Return: AL = current wake-up state (00h = disabled, 01h = enabled)
SeeAlso: AH=FDh/BL=01h,AH=FDh/BL=02h
--------b-1FFD--BL01-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP STATUS
	AH = FDh
	BL = 01h
	AL = new wake-up state (00h = disabled, 01h = enabled)
SeeAlso: AH=FDh/BL=00h,AH=FDh/BL=03h
--------b-1FFD--BL02-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP TIME
	AH = FDh
	BL = 02h
Return: CH = hour by BCD
	CL = min by BCD
	DH = sec by BCD
SeeAlso: AH=FDh/BL=00h,AH=FDh/BL=03h
--------b-1FFD--BL03-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP TIME
       AH = FDh
       BL = 03h
       CH = hour by BCD
       CL = min by BCD
       DH = sec by BCD
Return: CF set on error (incorrect Time format or Auto Wake up is not enable)
SeeAlso: AH=FDh/BL=01h,AH=FDh/BL=02h
--------b-1FFD--BL04-------------------------
INT 1F U - C&T "SuperState" BIOS - GET AUTO WAKE UP DATE
	AH = FDh
	BL = 04h
Return: CH = year century in BCD
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
SeeAlso: AH=FDh/BL=02h,AH=FDh/BL=05h
--------b-1FFD--BL05-------------------------
INT 1F U - C&T "SuperState" BIOS - SET AUTO WAKE UP DATE
	AH = FDh
	BL = 05h
	CH = year century in BCD
	CL = year low in BCD
	DH = month in BCD
	DL = date in BCD
Return: CF set on error (incorrect date format or Auto Wake up is not enable)
SeeAlso: AH=FDh/BL=03h"C&T",AH=FDh/BL=04h"C&T"
--------!---Section--------------------------
