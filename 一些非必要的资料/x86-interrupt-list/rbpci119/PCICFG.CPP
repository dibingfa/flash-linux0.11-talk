/************************************************************************/
/*									*/
/*  Version 1.19							*/
/*	 by Ralf Brown							*/
/*									*/
/*  File pcicfg.cpp	       PCI configuration data dumper		*/
/*  LastEdit: 10jan99							*/
/*									*/
/*  (c) Copyright 1995,1996,1997,1998,1999 Ralf Brown			*/
/*									*/
/*  This code may be freely redistributed in its entirety.  Excerpts    */
/*  may be incorporated into other programs provided that credit is     */
/*  given.								*/
/*									*/
/************************************************************************/

#include <ctype.h>
#include <dos.h>
#include <io.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VERSION "1.19"

#define lengthof(x) ((sizeof(x))/(sizeof(x[0])))

#ifdef __TURBOC__
# pragma option -a-  /* byte alignment */
#endif /* __TURBOC__ */

#ifndef FALSE
# define FALSE (0)
#endif /* FALSE */

#ifndef TRUE
# define TRUE (!FALSE)
#endif /* TRUE */

/************************************************************************/
/*	Manifest Constants						*/
/************************************************************************/

#define CAPLIST_BIT 0x0010		// does device have capabilities list?

#define MAX_LINE     512		// max length of a line in .PCI files
#define MAX_VENDOR_NAME 50		// max length of vendor's name
#define MAX_DEVICE_NAME 50		// max length of device name
#define MAX_VENDOR_DATA 16384		// maximum data per vendor

#define SIGNATURE "PCICFG"		// PCICFG.DAT signature at start of file
#define SIGNATURE_LENGTH (sizeof(SIGNATURE)-1)

/************************************************************************/
/*	Types								*/
/************************************************************************/

typedef unsigned char  BYTE ;
typedef unsigned short WORD ;
typedef unsigned long DWORD ;

//----------------------------------------------------------------------

struct PCIcfg
   {
   WORD	 vendorID ;
   WORD	 deviceID ;
   WORD	 command_reg ;
   WORD	 status_reg ;
   BYTE	 revisionID ;
   BYTE	 progIF ;
   BYTE	 subclass ;
   BYTE	 classcode ;
   BYTE	 cacheline_size ;
   BYTE	 latency ;
   BYTE	 header_type ;
   BYTE	 BIST ;
   union
      {
      struct
	 {
	 DWORD base_address0 ;
	 DWORD base_address1 ;
	 DWORD base_address2 ;
	 DWORD base_address3 ;
	 DWORD base_address4 ;
	 DWORD base_address5 ;
	 DWORD CardBus_CIS ;
	 WORD  subsystem_vendorID ;
	 WORD  subsystem_deviceID ;
	 DWORD expansion_ROM ;
	 BYTE  cap_ptr ;
	 BYTE  reserved1[3] ;
	 DWORD reserved2[1] ;
	 BYTE  interrupt_line ;
	 BYTE  interrupt_pin ;
	 BYTE  min_grant ;
	 BYTE  max_latency ;
	 DWORD device_specific[48] ;
	 } nonbridge ;
      struct
	 {
	 DWORD base_address0 ;
	 DWORD base_address1 ;
	 BYTE  primary_bus ;
	 BYTE  secondary_bus ;
	 BYTE  subordinate_bus ;
	 BYTE  secondary_latency ;
	 BYTE  IO_base_low ;
	 BYTE  IO_limit_low ;
	 WORD  secondary_status ;
	 WORD  memory_base_low ;
	 WORD  memory_limit_low ;
	 WORD  prefetch_base_low ;
	 WORD  prefetch_limit_low ;
	 DWORD prefetch_base_high ;
	 DWORD prefetch_limit_high ;
	 WORD  IO_base_high ;
	 WORD  IO_limit_high ;
	 DWORD reserved2[1] ;
	 DWORD expansion_ROM ;
	 BYTE  interrupt_line ;
	 BYTE  interrupt_pin ;
	 WORD  bridge_control ;
	 DWORD device_specific[48] ;
	 } bridge ;
      struct
	 {
	 DWORD ExCa_base ;
	 BYTE  cap_ptr ;
	 BYTE  reserved05 ;
	 WORD  secondary_status ;
	 BYTE  PCI_bus ;
	 BYTE  CardBus_bus ;
	 BYTE  subordinate_bus ;
	 BYTE  latency_timer ;
	 DWORD memory_base0 ;
	 DWORD memory_limit0 ;
	 DWORD memory_base1 ;
	 DWORD memory_limit1 ;
	 WORD  IObase_0low ;
	 WORD  IObase_0high ;
	 WORD  IOlimit_0low ;
	 WORD  IOlimit_0high ;
	 WORD  IObase_1low ;
	 WORD  IObase_1high ;
	 WORD  IOlimit_1low ;
	 WORD  IOlimit_1high ;
	 BYTE  interrupt_line ;
	 BYTE  interrupt_pin ;
	 WORD  bridge_control ;
	 WORD  subsystem_vendorID ;
	 WORD  subsystem_deviceID ;
	 DWORD legacy_baseaddr ;
	 DWORD cardbus_reserved[14] ;
	 DWORD vendor_specific[32] ;
	 } cardbus ;
      } ;
   } ;

struct subclass_info
   {
   int subclass_code ;
   const char *subclass_name ;
   } ;

/************************************************************************/
/*	Global Data							*/
/************************************************************************/

static const char * const class_names[] =
   {
    "reserved",		// 00
    "disk",		// 01
    "network",		// 02
    "display",		// 03
    "multimedia",	// 04
    "memory",		// 05
    "bridge",		// 06
    "communication",	// 07
    "system peripheral",// 08
    "input",		// 09
    "docking station",	// 0A
    "CPU",		// 0B
    "serial bus",	// 0C
   } ;

static const subclass_info subclass_info_01[] =
   {
     { 0x00, "SCSI" },
     { 0x01, "IDE" },
     { 0x02, "floppy" },
     { 0x03, "IPI"},
     { 0x04, "RAID" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_02[] =
   {
     { 0x00, "Ethernet" },
     { 0x01, "TokenRing" },
     { 0x02, "FDDI" },
     { 0x03, "ATM" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_03[] =
   {
     { 0x00, "VGA" },
     { 0x01, "SuperVGA" },
     { 0x02, "XGA" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_04[] =
   {
     { 0x00, "video" },
     { 0x01, "audio" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_05[] =
   {
     { 0x00, "RAM" },
     { 0x01, "Flash memory" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_06[] =
   {
     { 0x00, "CPU/PCI" },
     { 0x01, "PCI/ISA" },
     { 0x02, "PCI/EISA" },
     { 0x03, "PCI/MCA" },
     { 0x04, "PCI/PCI" },
     { 0x05, "PCI/PCMCIA" },
     { 0x06, "PCI/NuBus" },
     { 0x07, "PCI/CardBus" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_07[] =
   {
     { 0x00, "serial" },
     { 0x01, "parallel" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_08[] =
   {
     { 0x00, "PIC" },
     { 0x01, "DMAC" },
     { 0x02, "timer" },
     { 0x03, "RTC" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_09[] =
   {
     { 0x00, "keyboard" },
     { 0x01, "digitizer" },
     { 0x02, "mouse" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_0A[] =
   {
     { 0x00, "generic" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_0B[] =
   {
     { 0x00, "386" },
     { 0x01, "486" },
     { 0x02, "Pentium" },
     { 0x03, "P6" },
     { 0x10, "Alpha" },
     { 0x40, "coproc" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info subclass_info_0C[] =
   {
     { 0x00, "Firewire" },
     { 0x01, "ACCESS.bus" },
     { 0x02, "SSA" },
     { 0x03, "USB" },
     { 0x04, "Fiber Channel" },
     { 0x80, "other" },
     { -1, 0 },
   } ;

static const subclass_info *subclass_data[] =
   {
   0, subclass_info_01, subclass_info_02,
   subclass_info_03, subclass_info_04, subclass_info_05,
   subclass_info_06, subclass_info_07, subclass_info_08,
   subclass_info_09, subclass_info_0A, subclass_info_0B,
   subclass_info_0C,
   } ;

//----------------------------------------------------------------------

static const char *const command_bits[] =
   {
     "I/O-on",
     "mem-on",
     "busmstr",
     "spec-cyc",
     "invalidate",
     "VGAsnoop",
     "parity-err",
     "wait-cyc",
     "sys-err",                         // bit 8
     "fast-trns",			// bit 9
     0,					// bit 10
     0,					// bit 11
     0,					// bit 12
     0,					// bit 13
     0,					// bit 14
     0,					// bit 15
   } ;

static const char *const status_bits[] =
   {
     0,					// bit 0
     0,					// bit 1
     0,					// bit 2
     0,					// bit 3
     "CapList",                         // bit 4
     "66Mhz",				// bit 5
     "UDF",				// bit 6
     "fast-trns",			// bit 7
     "parity-err",			// bit 8
     0,					// bits 9-10 are select timing
     0,
     "sig-abort",			// bit 11
     "rcv-abort",			// bit 12
     "mst-abort",			// bit 13
     "sig-serr",			// bit 14
     "det-parity",			// bit 15
   } ;

static const char *const bctrl_bits[] =
   {
     "parity-resp",			// bit 0
     0,					// bit 1
     "ISA",				// bit 2
     "VGA",				// bit 3
     0,					// bit 4
     "mst-abort",			// bit 5
     "bus-reset",			// bit 6
     "fast-b2b",			// bit 7
   } ;

static const char *const select_timing[] =
   {
    "fast",
    "med",
    "slow",
    "???"
   } ;

static const char *const PMC_bits[] =
   {
     0, 				// bits 0-2: version (001)
     0,
     0,
     "PME-Clk",				// bit 3: PM Event Clock
     "aux-pwr-PME#",			// bit 4: need aux power for PME#
     "DevSpec Init",                    // bit 5
     0, 				// bits 6-7: DynClk
     0,
     "FullClk",
     "D1-supp",
     "D2-supp",
     "PME#-D0",                         // bit 11
     "PME#-D1",                         // bit 12
     "PME#-D2",                         // bit 13
     "PME#-D3hot",                      // bit 14
     "PME#-D3cold",                     // bit 15
   } ;

/************************************************************************/
/*    global variables							*/
/************************************************************************/

static int verbose = FALSE ;
static int terse = FALSE ;
static int first_device = TRUE ;
static int bypass_BIOS = FALSE ;
static int cfg_mech = 1 ;		// PCI access mechanism: 1 or 2

static char *exe_directory = "." ;

static char *device_ID_data = 0 ;
/* format of ID data once loaded:
          char*  -> next vendor or 0
	  WORD   vendor ID
	  ASCIZ	 vendor name
	  WORD   device ID
	  ASCIZ	 device name
	  ...
	  char*	 -> next vendor or 0
	  WORD   vendor ID
	  ASCIZ	 vendor name
	  .....
*/

/************************************************************************/
/*	Helper Functions						*/
/************************************************************************/

static void get_exe_directory(const char *argv0)
{
   char *pathname = (char*)malloc(strlen(argv0)+2) ;
   strcpy(pathname,argv0) ;
   // strip off any existing extension
   char *slash = strrchr(pathname,'/') ;
   char *backslash = strrchr(pathname,'\\') ;
   if (backslash && (!slash || backslash > slash))
      slash = backslash ;
   if (slash)
      *slash = '\0' ;
   else
      strcpy(pathname,".") ;
   exe_directory = pathname ;
}

//----------------------------------------------------------------------

static const char *skip_whitespace(const char *line)
{
   while (*line && isspace(*line))
      line++ ;
   return line ;
}

//----------------------------------------------------------------------

inline char *skip_whitespace(char *line)
{
   return (char*)skip_whitespace((const char *)line) ;
}

//----------------------------------------------------------------------

static int is_comment_line(const char *line,int pcicfg_format = 0)
{
   // if in Craig Hart's format, we want to skip the subsystem-vendor-ID
   //   lines (those starting with two tab characters) because PCICFG doesn't
   //   support them
   if (!pcicfg_format && line[0] == '\t' && line[1] == '\t')
      return TRUE ;
   line = skip_whitespace(line) ;
   // blank lines and lines whose first nonwhite character is a semicolon
   // can be skipped as comments
   if (*line == '\0' || *line == '\n' || *line == ';')
      return TRUE ;
   else
      return FALSE ;
}

//----------------------------------------------------------------------

static int read_nonblank_line(char *buf, int size, FILE *fp, int pcicfg_format)
{
   do {
      buf[0] = '\0' ;
      if (!fgets(buf,size,fp) || feof(fp))
	 return FALSE ;
      } while (is_comment_line(buf,pcicfg_format)) ;
   return TRUE ;
}

//----------------------------------------------------------------------

static WORD hextoint(const char *&digits)
{
   WORD hex = 0 ;
   while (isxdigit(*digits))
      {
      int digit = toupper(*digits++) - '0' ;
      if (digit > 9)
	 digit -= ('A'-'0'-10) ;
      hex = 16*hex + digit ;
      }
   return hex ;
}

//----------------------------------------------------------------------

static FILE *open_PCICFG_DAT(const char *fopen_mode)
{
   int dir_len = strlen(exe_directory) ;
   char *datafile = (char*)malloc(dir_len+15) ;
   if (!datafile)
      {
      fprintf(stderr,"Insufficient memory for PCICFG.DAT pathname\n") ;
      return FALSE ;
      }
   sprintf(datafile,"%s/PCICFG.DAT",exe_directory) ;
   FILE *fp = fopen(datafile,fopen_mode) ;
   free(datafile) ;
   if (!fp)
      fprintf(stderr,"Unable to open PCICFG.DAT in mode \"%s\"\n",fopen_mode) ;
   return fp ;
}

//----------------------------------------------------------------------

static int backup_PCICFG_DAT()
{
   int dir_len = strlen(exe_directory) ;
   char *datafile = (char*)malloc(dir_len+15) ;
   if (!datafile)
      {
      fprintf(stderr,"Insufficient memory for PCICFG.DAT pathname\n") ;
      return FALSE ;
      }
   sprintf(datafile,"%s/PCICFG.DAT",exe_directory) ;
   FILE *fp = fopen(datafile,"r") ;
   if (!fp)
      {
      free(datafile) ;
      return FALSE ;
      }
   strcpy(datafile+strlen(datafile)-4,".BAK") ;
   FILE *backup = fopen(datafile,"w") ;
   if (!backup)
      {
      free(datafile) ;
      return FALSE ;
      }
   char buffer[BUFSIZ] ;
   int count ;
   int success = TRUE ;
   while ((count = fread(buffer,sizeof(char),sizeof(buffer),fp)) > 0)
      {
      if (fwrite(buffer,sizeof(char),count,backup) < count)
	 success = FALSE ;
      }
   fclose(fp) ;
   fclose(backup) ;
   if (!success)
      {
      fprintf(stderr,"Backup of PCICFG.DAT failed!\n") ;
      unlink(datafile) ;
      }
   free(datafile) ;
   return success ;
}

/************************************************************************/
/************************************************************************/

#if defined(__WATCOMC__) && defined(__386__)
extern DWORD inpd(int portnum) ;
#pragma aux inpd = \
   "in eax,dx" \
   parm [edx] \
   value [eax] \
   modify exact [eax] ;

#else
static DWORD inpd(int portnum)
{
   static DWORD value ;
   asm mov dx,portnum ;
   asm lea bx,value ;
#if defined(__BORLANDC__)
   __emit__(0x66,0x50,			// push EAX
	    0x66,0xED,			// in EAX,DX
	    0x66,0x89,0x07,		// mov [BX],EAX
	    0x66,0x58) ;		// pop EAX
#else
   asm push eax
   asm in eax,dx ;
   asm mov [bx],eax ;
   asm pop eax
#endif
   return value ;
}
#endif /* __WATCOMC__ */

//----------------------------------------------------------------------

#if defined(__WATCOMC__) && defined(__386__)
extern void outpd(int portnum, DWORD value) ;
#pragma aux outpd = \
   "out dx,eax" \
   parm [edx][eax] \
   modify exact [] ;
   
#else
static void outpd(int portnum, DWORD val)
{
   static DWORD value = 0 ;

   value = val ;
   asm mov dx,portnum ;
   asm lea bx,value ;
#if defined(__BORLANDC__)
   __emit__(0x66,0x50,			// push EAX
	    0x66,0x8B,0x07,		// mov EAX,[BX]
	    0x66,0xEF,			// out DX,EAX
	    0x66,0x58) ;		// pop EAX
#else
   asm push eax
   asm mov eax,[bx] ;
   asm out dx,eax ;
   asm pop eax
#endif
   return ;
}
#endif /* __WATCOMC__ */

//----------------------------------------------------------------------

#if defined(__WATCOMC__)
extern void outp(short portnumber, BYTE value) ;
#pragma aux outp = \
   "out dx,al" \
   parm [dx][al] \
   modify exact [] ;

extern BYTE inp(short portnumber) ;
#pragma aux inp = \
   "in al,dx" \
  parm [dx] \
  value [al] \
  modify exact [al] ;
#endif /* __WATCOMC__ */


/************************************************************************/
/************************************************************************/

static int check_PCI_BIOS()
{
   union REGS regs ;
#if defined(__WATCOMC__) && defined(__386__)
   regs.w.ax = 0xB101 ;
   int386(0x1A,&regs,&regs) ;
#else
   regs.x.ax = 0xB101 ;
   int86(0x1A,&regs,&regs) ;
#endif /* __WATCOMC__ && __386__ */
   if (regs.h.ah == 0x00)
      return regs.h.cl ;		// last PCI bus in system
   else
      return -1 ;			// no PCI BIOS detected
}

//----------------------------------------------------------------------

static void determine_cfg_mech()
{
   union REGS regs ;
#if defined(__WATCOMC__) && defined(__386__)
   regs.w.ax = 0xB101 ;
   int386(0x1A,&regs,&regs) ;
#else
   regs.x.ax = 0xB101 ;
   int86(0x1A,&regs,&regs) ;
#endif /* __WATCOMC__ && __386__ */
   if (regs.h.ah == 0x00)
      {
      // we have a PCI BIOS, so check which configuration mechanism(s) it
      // supports
      int mechs = regs.h.al & 0x03 ;
      if (mechs & 0x01)
	 cfg_mech = 1 ;
      else if (mechs & 0x02)
	 cfg_mech = 2 ;
      else
	 cfg_mech = 1 ;			// default is to assume mechanism #1
      }
   return ;
}

//----------------------------------------------------------------------

static int read_DWORD_register(int bus, int device, int func, int reg,
			       WORD *lo, WORD *hi)
{
   if (bypass_BIOS)
      {
      DWORD value ;
      if (cfg_mech == 1)
	 {
	 DWORD addr = 0x80000000L | (((DWORD)(bus & 0xFF)) << 16) |
		      ((((unsigned)device) & 0x1F) << 11) |
		      ((((unsigned)func) & 0x07) << 8) | (reg & 0xFC) ;
	 DWORD orig = inp(0xCF8) ;	// get current state
	 outpd(0xCF8,addr) ;		// set up addressing to config data
	 value = inpd(0xCFC) ;		// get requested DWORD of config data
	 outpd(0xCF8,orig) ;		// restore configuration control
	 }
      else // cfg_mech == 2
	 {
	 if (device > 0x0F)		// mech#2 only supports 16 devices
	    {				//   per bus
	    *lo = 0xFFFF ;
	    *hi = 0xFFFF ;
	    return FALSE ;
	    }
	 BYTE oldenable = inp(0xCF8) ;	// store current state of config space
	 BYTE oldbus = inp(0xCFA) ;
	 outp(0xCFA,bus) ;
	 outp(0xCF8,0x80) ;		// enable configuration space
	 WORD addr = 0xC000 | ((device & 0x0F) << 8) | (reg & 0xFF) ;
	 value = inpd(addr) ;
	 outp(0xCFA,oldbus) ;		// restore configuration space
	 outp(0xCF8,oldenable) ;
	 }
      *hi = (WORD)(value >> 16) ;
      *lo = (WORD)(value & 0xFFFF) ;
      return TRUE ;
      }
   else // use BIOS
      {
      union REGS regs, outregs ;
      regs.h.bh = bus ;
      regs.h.bl = (device<<3) | (func & 0x07) ;
#if defined(__WATCOMC__) && defined(__386__)
      regs.w.ax = 0xB109 ;
      regs.w.di = reg ;
      int386(0x1A,&regs,&outregs) ;
      if (outregs.x.cflag != 0)
	 return FALSE ;
      *lo = outregs.w.cx ;
      regs.w.di += 2 ;
      int386(0x1A,&regs,&outregs) ;
      if (outregs.x.cflag != 0)
	 return FALSE ;
      *hi = outregs.w.cx ;
#else
      regs.x.ax = 0xB109 ;
      regs.x.di = reg ;
      int86(0x1A,&regs,&outregs) ;
      if (outregs.x.cflag != 0)
	 return FALSE ;
      *lo = outregs.x.cx ;
      regs.x.di += 2 ;
      int86(0x1A,&regs,&outregs) ;

      if (outregs.x.cflag != 0)
	 return FALSE ;
      *hi = outregs.x.cx ;
#endif /* __WATCOMC__ && __386__ */
      }
   return TRUE ;
}

//----------------------------------------------------------------------

static void write_DWORD_register(int bus,int device,int func,
				 int reg, WORD lo, WORD hi)
{
   if (bypass_BIOS)
      {
      DWORD value = ((DWORD)hi << 16) | lo ;
      if (cfg_mech == 1)
	 {
	 DWORD addr = 0x80000000L | ((DWORD)(bus & 0xFF) << 16) |
		      ((device & 0x1F) << 11) | ((func & 0x07) << 8) |
		      (reg & 0xFC) ;
	 DWORD orig = inpd(0xCF8) ;
	 outpd(0xCF8,addr) ;
	 outpd(0xCFC,value) ;
	 outpd(0xCF8,orig) ;
	 }
      else
	 {
	 if (device > 0x0F)
	    return ;
	 BYTE oldenable = inp(0xCF8) ;
	 BYTE oldbus = inp(0xCFA) ;
	 outp(0xCFA,bus) ;
	 outp(0xCF8,0x80) ;		// enable configuration space
	 WORD addr = 0xC000 | ((device & 0x0F) << 8) | reg ;
	 outpd(addr,value) ;
	 outp(0xCFA,oldbus) ;
	 outp(0xCF8,oldenable) ;
	 }
      }
   else
      {
      union REGS regs, outregs ;

      regs.h.bh = bus ;
      regs.h.bl = (device<<3) | (func & 0x07) ;
#if defined(__WATCOMC__) && defined(__386__)
      regs.w.ax = 0xB10D ;		// write configuration DWORD
      regs.w.di = reg ;
      regs.x.ecx = ((long)hi) << 16 | ((unsigned)lo) ;
      int386(0x1A,&regs,&outregs) ;
#else
      regs.x.ax = 0xB10C ;		// write configuration word
      regs.x.di = reg ;
      regs.x.cx = lo ;
      int86(0x1A,&regs,&outregs) ;
      regs.x.di += 2 ;
      regs.x.cx = hi ;
      int86(0x1A,&regs,&outregs) ;
#endif /* __WATCOMC__ && __386__ */
      }
   return ;
}

//----------------------------------------------------------------------

static PCIcfg *read_PCI_config(int bus, int device, int func)
{
   static PCIcfg cfg ;

   for (int i = 0 ; i < sizeof(cfg)/sizeof(DWORD) ; i++)
      {
      WORD hi, lo ;
      if (!read_DWORD_register(bus,device,func,i*sizeof(DWORD),&lo,&hi))
	 return 0 ;
      ((WORD*)&cfg)[2*i] = lo ;
      ((WORD*)&cfg)[2*i+1] = hi ;
      }
   return &cfg ;
}

//----------------------------------------------------------------------

static const char *get_subclass_name(int classcode, int subclass)
{
   if (classcode < 0 || classcode >= lengthof(subclass_data) ||
       subclass_data[classcode] == 0)
      return "???" ;
   const subclass_info *subinfo = subclass_data[classcode] ;
   while (subinfo->subclass_code != -1)
      {
      if (subinfo->subclass_code == subclass)
	 return subinfo->subclass_name ;
      subinfo++ ;
      }
   return "???" ;
}

//----------------------------------------------------------------------

static const char *get_vendor_name(WORD vendorID)
{
   if (vendorID == 0x0000 || vendorID == 0xFFFF)
      return "Not Present" ;
   char *next ;
   for (char *data = device_ID_data ; data ; data = next)
      {
      next = *((char**)data) ;
      data += sizeof(char*) ;
      data += sizeof(WORD) ;		// skip the length field
      WORD ID = *((WORD*)data) ;
      data += sizeof(WORD) ;
      if (ID == vendorID)
	 return data ;
      }
   // if we get here, there was no matching ID in the file,
   return "???" ;
}

//----------------------------------------------------------------------

static const char *get_device_name(WORD vendorID, WORD deviceID)
{
   if (vendorID == 0x0000 || vendorID == 0xFFFF || deviceID == 0xFFFF)
      return "Not Present" ;
   char *data = device_ID_data ;
   while (data)
      {
      char *next = *((char**)data) ;
      data += sizeof(char*) ;
      WORD length = *((WORD*)data) ;
      data += sizeof(WORD) ;
      char *end = data + length ;
      WORD ID = *((WORD*)data) ;
      data += sizeof(WORD) ;
      if (ID == vendorID)
	 {
	 // OK, we've found the vendor, now scan for the device
	 // 1. skip the vendor name
	 while (*data)
	    data++ ;
	 if (data < end)		// skip the NUL
	    data++ ;
	 // 2. check each device ID in turn
	 while (data < end)
	    {
	    ID = *((WORD*)data) ;
	    data += sizeof(WORD) ;
	    if (ID == deviceID)
	       return data ;
	    while (*data)
	       data++ ;
	    data++ ;			// skip the NUL
	    }
	 // if we get here, there was no match for the device ID
	 break ;
	 }
      data = next ;
      }
   // if we get here, there was no matching ID in the file,
   return "???" ;
}

//----------------------------------------------------------------------

static int load_device_info(FILE *fp, char * &format_string,
			    char const * &enum_list)
{
   if (!fp)
      return FALSE ;
   long int filesize = lseek(fileno(fp),0L,SEEK_END) ;
   fseek(fp,0L,SEEK_SET) ;		// back to beginning of file
   char line[MAX_LINE] ;
   // read until we find the actual beginning of the device definition
   do {
      line[0] = '\0' ;			// catch EOF or read error
      fgets(line,sizeof(line),fp) ;
      } while (!feof(fp) && strncmp(line,"!begin",6) != 0) ;
   int datasize = (int)(filesize - ftell(fp)) ;
   char *buffer = (char*)malloc(datasize+3) ;
   int readsize ;
   char *newline ;
   if (buffer && (readsize = fread(buffer,sizeof(char),datasize,fp)) > 0)
      {
      buffer[readsize] = '\0' ;		// ensure proper string termination
      format_string = buffer ;
      enum_list = format_string ;
      if (*enum_list == '\n')
	 enum_list++ ;
      // look forward to end of format string, then chop into two strings
      do {
	 newline = strchr(enum_list,'\n') ;
	 if (newline && strncmp(newline+1,"!end",4) == 0)
	    {
	    newline[1] = '\0' ;
	    newline = strchr(newline+2,'\n') ;
	    if (newline)
	       enum_list = newline ;
	    else
	       enum_list = newline+2 ;
	    break ;
	    }
	 if (newline)
	    enum_list = newline+1 ;
	 } while (newline) ;
      }
   else
      return FALSE ;
   // scan until we find the actual beginning of the 'enum' definition
   char *result = (char*)enum_list ;
   newline = (char*)enum_list ;
   do {
      newline = strchr(newline,'\n') ;
      if (newline)
	 {
	 newline++ ;
	 if (strncmp(newline,"!enum",5) == 0)
	    break ;
	 }
      } while (newline) ;
   if (newline)
      {
      newline++ ;
      // format of the enum:
      //    !enum enum_name
      //     enumvalue0
      //     enumvalue1
      //     ...
      //     enumvalueN
      //    !end
      do {
	 // extract the enum's name
	 //assert(strcmp(newline,"!enum",5) == 0) ;
	 newline = skip_whitespace(newline+5) ;
	 const char *end = strchr(newline,'\n') ;
	 if (!end)
	    break ;
	 memcpy(result,newline,end-newline+1) ;
	 result += (end-newline+1) ;
	 newline = (char*)end+1 ;
	 while (*newline && strncmp(newline,"!end",4) != 0)
	    {
	    newline = skip_whitespace(newline) ;
	    char *end = strchr(newline,'\n') ;
	    if (!end)
	       end = strchr(newline,'\0') ;
	    char *next = *end ? end+1 : end ;
	    while (end > newline && isspace(end[-1]))
	       end-- ;
	    memcpy(result,newline,end-newline) ;
	    result[end-newline] = '\n' ;
	    result += (end-newline+1) ;
	    newline = next ;
	    }
	 *result++ = '\0' ;
	 // one enum is done, so scan for the next (if any)
	 while ((newline = strchr(newline,'\n')) != 0)
	    {
	    newline++ ;
	    if (strncmp(newline,"!enum",5) == 0)
	       break ;
	    }
	 } while (newline && *newline) ;
      }
   *result++ = '\0' ;
   return TRUE ;
}

//----------------------------------------------------------------------

static int know_device(WORD vendor, WORD device,
		       char * &format_string, char const * &enum_list)
{
   if (vendor == 0x0000 || vendor == 0xFFFF || device == 0xFFFF)
      return FALSE ;
   // see if there's a data file for this device
   int dir_len = strlen(exe_directory) ;
   char *device_file = (char*)malloc(dir_len+14) ;
   if (device_file)
      {
      sprintf(device_file,"%s/%4.04X%4.04X.PCI",exe_directory,vendor,device) ;
      device_file[dir_len+13] = '\0' ;
      FILE *fp = fopen(device_file,"r") ;
      free(device_file) ;
      if (fp)
	 {
	 int success = load_device_info(fp,format_string,enum_list) ;
	 fclose(fp) ;
	 return success ;
	 }
      }
   return FALSE ;
}

//----------------------------------------------------------------------

static void write_bits(WORD bitflags, const char *const *flagnames, int numbits)
{
   for (int i = 0 ; i < numbits ; i++)
      {
      if ((bitflags & (1 << i)) != 0 && flagnames[i])
	 printf(" %s",flagnames[i]) ;
      }
}

#define WRITE_CMD_BITS(x) write_bits((x),command_bits,lengthof(command_bits))
#define WRITE_STAT_BITS(x) write_bits((x),status_bits,lengthof(status_bits))
#define WRITE_BCTRL_BITS(x) write_bits((x),bctrl_bits,lengthof(bctrl_bits))

//----------------------------------------------------------------------

static DWORD extract_field(const char *&s, const char *cfg)
{
   DWORD value = 0 ;
   int addr = 0 ;
   while (*s == '[' || *s == '|')
      {
      s++ ;
      int lowbit = 0 ;
      int highbit = 7 ;
      while (*s && isxdigit(*s))
	 {
	 int digit = *s - '0' ;
	 if (digit > 9)
	    digit -= ('A'-10-'0') ;
	 addr = 16*addr + digit ;
	 s++ ;
	 }
      addr &= 0x00FF ;
      if (*s == ':')
	 {
	 s++ ;
	 while (*s && isdigit(*s))
	    {
	    lowbit = 10*lowbit + (*s-'0') ;
	    s++ ;
	    }
	 if (*s == '-')
	    {
	    highbit = 0 ;
	    s++ ;
	    while (*s && isdigit(*s))
	       {
	       highbit = 10*highbit + (*s-'0') ;
	       s++ ;
	       }
	    }
	 else
	    highbit = lowbit ;
	 if (highbit < lowbit)
	    {
	    int tmp = lowbit ;
	    lowbit = highbit ;
	    highbit = tmp ;
	    }
	 if (highbit > 31)
	    {
	    if (highbit - lowbit >= 32)
	       highbit = 31 ;
	    }
	 if (lowbit/8)
	    {
	    int adj = lowbit/8 ;
	    addr += adj ;
	    adj *= 8 ;
	    lowbit -= adj ;
	    highbit -= adj ;
	    }
	 }
      DWORD prev_value = value << (highbit-lowbit+1) ;
      if (highbit > 16)
	 {
	 value = cfg[addr] + (cfg[addr+1] << 8) + ((DWORD)cfg[addr+2] << 16) +
		 ((DWORD)cfg[addr+3] << 24) ;
	 }
      else if (highbit > 8)
	 value = cfg[addr] + (cfg[addr+1] << 8) ;
      else
	 value = cfg[addr] ;
      DWORD mask = 0 ;
      for (int i = lowbit ; i <= highbit ; i++)
	 mask |= (1L << i-lowbit) ;
      while (lowbit-- > 0)
         value >>= 1 ;
      value &= mask ;
      if (*s == '<')
	 {
	 s++ ;
	 int shift = 0 ;
	 while (*s && isdigit(*s))
	    {
	    shift = 10*shift + (*s-'0') ;
	    s++ ;
	    }
	 while (shift-- > 0)
	    {
	    value <<= 1 ;
	    prev_value <<= 1 ;
	    }
	 }
      if (*s == '*')
	 {
	 s++ ;
	 unsigned mult = 0 ;
	 while (*s && isdigit(*s))
	    {
	    mult = 10*mult + (*s-'0') ;
	    s++ ;
	    }
	 if (mult == 0)
	    mult =1 ;
	 value *= mult ;
	 prev_value *= mult ;
	 }
      value |= prev_value ;
      if (*s == '+')
	 {
	 *s++ ;
	 int negative = 0 ;
	 if (*s == '-')
	    negative = 1 ;
	 long offset = 0 ;
	 while (*s && isdigit(*s))
	    {
	    offset = 10*offset + (*s-'0') ;
	    s++ ;
	    }
	 if (negative)
	    offset = -offset ;
	 value += offset ;
	 }
      if (*s == ']')
	 {
	 s++ ;
	 break ;
	 }
      }
   return value ;
}

//----------------------------------------------------------------------

static void format_number(FILE *out, DWORD val, int width, int base)
{
   char buf[38] ;			// enough for DWORD, plus fudge factor
   static char digits[] = "0123456789ABCDEF" ;
   int count = 0 ;
   do {
      int digit = (int)(val % base) ;
      val /= base ;
      buf[count++] = digits[digit] ;
      } while (val) ;
   buf[count] = '\0' ;
   for (int i = 0 ; i < count/2 ; i++)
      {
      char tmp = buf[count-i-1] ;
      buf[count-i-1] = buf[i] ;
      buf[i] = tmp ;
      }
   if (count < width)
      {
      for (int i = count ; i < width ; i++)
	 fputc(base == 10 ? ' ' : '0',out) ;
      }
   fputs(buf,out) ;
   return ;
}

//----------------------------------------------------------------------

static void format_enabled(FILE *out, DWORD value, int width)
{
   int w = value ? 6 : 7 ;
   for (int i = w ; i < width ; i++)
      fputc(' ',out) ;
   fputs(value ? "enable" : "disable",out) ;
}

//----------------------------------------------------------------------

static void format_flag(FILE *out, DWORD value, int width)
{
   for (int i = 1 ; i < width ; i++)
      fputc(' ',out) ;
   fputc(value ? 'û' : '-',out) ;
}


//----------------------------------------------------------------------

static void format_yesno(FILE *out, DWORD value, int width)
{
   for (int i = 1 ; i < width ; i++)
      fputc(' ',out) ;
   fputc(value ? 'Y' : 'N',out) ;
}

//----------------------------------------------------------------------

static void format_full_yesno(FILE *out, DWORD value, int width)
{
   if (width < 3)
      width = 3 ;
   for (int i = (value ? 3 : 2) ; i < width ; i++)
      fputc(' ',out) ;
   fputs(value ? "Yes" : "No",out) ;
}

//----------------------------------------------------------------------

static void format_charlist(FILE *out, DWORD value, int width,
			    const char *&chars)
{
   for (int i = 1 ; i < width ; i++)
      fputc(' ',out) ;
   int n = 0 ;
   chars++ ;				// skip opening brace
   const char *ch = chars ;
   while (*chars && *chars != '}')
      {
      n++ ;
      chars++ ;
      }
   if (value >= n)
      value = n-1 ;
   fputc(ch[(size_t)value],out) ;
}

//----------------------------------------------------------------------

static const char *find_enum(const char *name, const char *name_end,
			     const char *enums)
{
   const char *e = 0 ;
   if (name && enums)
      {
      size_t len = name_end - name ;
      const char *enum_list = enums ;
      while (*enums)
	 {
	 if (strncmp(name,enums,len) == 0 && enums[len] == '\n')
	    return enums ;
	 enums = strchr(enums,'\0') + 1 ;
	 }
      // OK, first pass didn't find any exact match, so try to find a prefix
      enums = enum_list ;
      while (*enums)
	 {
	 if (strncmp(name,enums,len) == 0)
	    return enums ;
	 enums = strchr(enums,'\0') + 1 ;
	 }
      }
   return e ;
}

//----------------------------------------------------------------------

static const char *format_enum(FILE *out, DWORD value, int width,
			       const char *name, const char *enums)
{
   if (!out || !enums)
      return name ;
   //asssert(*name == '(') ;
   name++ ;				// skip the open paren
   const char *end = name ;
   while (*end && *end != ')')
      end++ ;
   const char *e = find_enum(name,end,enums) ;
   if (e)
      {
      // format of string pointed at by 'e':
      //      name \n value0 \n value1 \n value2 \n ... \n valueN \0
      e = strchr(e,'\n') ;
      if (e) e++ ;
//      size_t orig_value = value ;
      while (value > 0)
	 {
	 const char *next = strchr(e,'\n') ;
	 if (!next)
#if 1
	    break ;
#else
	    {
	    fflush(stdout) ;
	    fprintf(stderr,"undefined value %d given for enum '%.4s'\n",
		    orig_value,name) ;
	    return end ;
	    }
#endif /* 0/1 */
	 e = next+1 ;
	 value-- ;
	 }
      // OK, we have the desired string, so output it
      size_t count = 0 ;
      while (*e && *e != '\n')
	 {
	 if (*e == '\\')
	    {
	    switch (*++e)
	       {
	       case '\n':
		  // do nothing, this was just a dummy to retain trailing
		  // white space
		  break ;
	       case 't':
		  width -= (count%8) ;
		  count = (8*((count+7)/8))-1 ;
		  // fall through to default case
	       default:
		  fputc(*e++,out) ;
	       }
	    }
	 else
	    {
	    fputc(*e++,out) ;
	    count++ ;
	    }
	 width-- ;
	 }
      }
   else
      {
      fputs("þenumþ",out) ;
      width-- ;
      }
   for (int i = 0 ; i < width ; i++)
      fputc(' ',out) ;
   return end ;
}

//----------------------------------------------------------------------

static const char *format_option(FILE *out, DWORD value, int width,
				 const char *option)
{
   if (!out || !option)
      return option ;
   char terminator = *option++ ;
   const char *end = strchr(option,terminator) ;
   if (!end)
      return option ;
   int len = end-option ;
   if (width == 0)
      width = len ;
   for (int i = len ; i < width ; i++)
      fputc(' ',out) ;
   if (value)
      fwrite(option,sizeof(char),len,out) ;
   else
      {
      while (len-- > 0)
	 fputc('-',out) ;
      }
   return end ;
}

//----------------------------------------------------------------------

static const char *format_alternative(FILE *out, DWORD value, int width,
				      const char *option)
{
   if (!out || !option)
      return option ;
   char terminator = *option++ ;
   const char *end = strchr(option,terminator) ;
   if (!end)
      return option ;
   const char *alternates[5] = { 0, 0, 0, 0, 0 } ;
   alternates[0] = option ;
   int num_alts = 1 ;
   for (const char *alt = option ; alt < end ; alt++)
      if (*alt == ';')
	 {
	 alternates[num_alts++] = alt+1 ;
	 if (num_alts >= lengthof(alternates)-1)
	    break ;
	 }
   alternates[num_alts] = end+1 ;
   if (value >= num_alts)
      value = num_alts-1 ;
   int len = (int)(alternates[(int)value+1] - alternates[(int)value]) - 1 ;
   if (width == 0)
      width = len ;
   for (int i = len ; i < width ; i++)
      fputc(' ',out) ;
   fwrite(alternates[(int)value],sizeof(char),len,out) ;
   return end ;
}

//----------------------------------------------------------------------

static int format(FILE *out, const char *cfg, const char *fmt,
		  const char *enums)
{
   if (!out || !cfg || !fmt)
      return FALSE ;
   for (const char *s = fmt ; *s ; fmt = s)
      {
      while (*s && *s != '%' && *s != '\\')
	 s++ ;
      if (s != fmt)
	 fwrite(fmt,sizeof(char),s-fmt,out) ;
      if (*s == '\\')
	 {
	 s++ ;				// consume the backslash
	 switch (*s)
	    {
	    case '\\':			// literal backslash
	       fputc('\\',out) ;
	       break ;
	    case 't':			// tab
	       fputc('\t',out) ;
	       break ;
	    default:			// don't know, so just print the char
	       fputc(*s,out) ;
	       break ;
	    }
	 s++ ;				// consume the char after backslash
	 }
      else if (*s == '%')
	 {
	 DWORD cfgval = 0 ;
	 fmt = s ;
	 s++ ;				// skip the percent sign
	 if (*s == '[')
	    cfgval = extract_field(s,cfg) ;
	 int width = 0 ;
	 while (isdigit(*s))
	    {
	    width = 10*width + (*s-'0') ;
	    s++ ;
	    }
	 switch (*s)			// dispatch on format character
	    {
	    case 'b':			// binary
	       format_number(out,cfgval,width,2) ;
	       break ;
	    case 'o':			// octal
	       format_number(out,cfgval,width,8) ;
	       break ;
	    case 'd':			// decimal
	       format_number(out,cfgval,width,10) ;
	       break ;
	    case 'x':			// hex
	       format_number(out,cfgval,width,16) ;
	       break ;
	    case 'e':
	       format_enabled(out,cfgval,width) ;
	       break ;
	    case 'E':
	       format_enabled(out,cfgval==0,width) ;
	       break ;
	    case 'f':			// flag
	       format_flag(out,cfgval,width) ;
	       break ;
	    case 'n':
	       format_yesno(out,cfgval == 0, width) ;
	       break ;
	    case 'N':
	       format_full_yesno(out,cfgval == 0, width) ;
	       break ;
	    case 'y':
	       format_yesno(out,cfgval,width) ;
	       break ;
	    case 'Y':
	       format_full_yesno(out,cfgval,width) ;
	       break ;
	    case '(':			// enumerated list of values
	       s = format_enum(out,cfgval,width,s,enums) ;
	       break ;
	    case '{':
	       format_charlist(out,cfgval,width,s) ;
	       break ;
	    case '/':
	       s = format_option(out,cfgval,width,s) ;
	       break ;
	    case '|':
	       s = format_alternative(out,cfgval,width,s) ;
	       break ;
	    case '%':			// literal percent sign
	       fputc('%',out) ;
	       break ;
	    case '!':			// rest of line is a comment
	       while (*s && *s != '\n')
		  s++ ;
	       if (!*s)			// back up if we hit the end of string
		  s-- ;
	       s-- ;			// pre-undo the s++ below
	       break ;
	    case '\n':			// paste together two lines
	       // do nothing, already skipping the newline
	       break ;
	    default:
	       // don't know how to handle!  so, just output the format spec
	       fwrite(fmt,sizeof(char),s-fmt,out) ;
	       break ;
	    }
	 s++ ;
	 }
      }
   fflush(out) ;
   return TRUE ;
}


//----------------------------------------------------------------------

static void determine_ROM_size(int bus, int device, int func, int reg)
{
   WORD orig_lo, orig_hi ;
   WORD new_lo, new_hi ;
   read_DWORD_register(bus,device,func,reg,&orig_lo,&orig_hi) ;
   // try setting all address bits
   write_DWORD_register(bus,device,func,reg,0xFC00,0xFFFF) ;
   // check which actually got set
   int read_error = FALSE ;
   if (!read_DWORD_register(bus,device,func,reg,&new_lo,&new_hi))
      read_error = TRUE ;
   // restore original state
   write_DWORD_register(bus,device,func,reg,orig_lo,orig_hi) ;
   if (read_error)
      printf("(error)") ;
   else if (new_lo == 0x0000 && new_hi == 0x0000)
      printf("(no ROM)") ;
   else
      {
      new_lo &= 0xFC00 ;		// mask out low ten bits
      int lowbit = 0 ;
      if (new_lo)
	 for (int i = 10 ; i < 16 ; i++)
	    if ((new_lo & (1U << i)) != 0)
	       {
	       lowbit = i ;
	       break ;
	       }
      if (!lowbit)
	 for (int i = 0 ; i < 16 ; i++)
	    if ((new_hi & (1U << i)) != 0)
	       {
	       lowbit = i + 16 ;
	       break ;
	       }
      const char *ROMstate = (orig_lo & 1) ? "enabled" : "disabled" ;
      if (lowbit < 20)
	 printf("(%dK,%s)",1 << (lowbit - 10),ROMstate) ;
      else
	 printf("(%dM,%s)",1 << (lowbit - 20),ROMstate) ;
      }
}

//----------------------------------------------------------------------

static void determine_region_size(int bus, int device, int func, int reg)
{
   WORD orig_lo, orig_hi ;
   WORD new_lo, new_hi ;
   read_DWORD_register(bus,device,func,reg,&orig_lo,&orig_hi) ;
   // try setting all address bits (preserving the I/O-memory bit)
   write_DWORD_register(bus,device,func,reg,0xFFFC|(orig_lo&1),0xFFFF) ;
   // check which actually got set
   int read_error = FALSE ;
   if (!read_DWORD_register(bus,device,func,reg,&new_lo,&new_hi))
      read_error = TRUE ;
   // restore original state
   write_DWORD_register(bus,device,func,reg,orig_lo,orig_hi) ;
   if (read_error)
      printf("(error)") ;
   else if (new_lo == 0x0000 && new_hi == 0x0000)
      printf("(no region)") ;
   else
      {
      if (orig_lo & 1)			// is it an I/O region?
	 new_lo &= 0xFFFC ;		// mask out low two bits
      else
	 new_lo &= 0xFFF0 ;		// mask out low four bits
      int lowbit = 0 ;
      if (new_lo)
	 for (int i = 2 ; i < 16 ; i++)
	    if ((new_lo & (1U << i)) != 0)
	       {
	       lowbit = i ;
	       break ;
	       }
      if (!lowbit)
	 for (int i = 0 ; i < 16 ; i++)
	    if ((new_hi & (1U << i)) != 0)
	       {
	       lowbit = i + 16 ;
	       break ;
	       }
      if (lowbit < 10)
	 printf("len=%d",1 << lowbit) ;
      else if (lowbit < 20)
	 printf("len=%dK",1 << (lowbit - 10)) ;
      else
	 printf("len=%dM",1 << (lowbit - 20)) ;
      }
}

//----------------------------------------------------------------------

static int dump_base_address(int bus, int device, int func, int number,
			     DWORD base, DWORD nextbase)
{
   if (base)
      {
      printf("\t(%d) %8.08lX = %s ",number,base,((base & 1) ? "I/O" : "mem")) ;
      if (base & 1)
	 {
	 // I/O base address
	 printf("base=%8.08lX ",(base & ~3)) ;
	 determine_region_size(bus,device,func,4*number+0x10) ;
	 putchar('\n') ;
	 }
      else
	 {
	 // memory base address
	 int type = (int)((base & 6) >> 1) ;
	 int used = FALSE ;
	 switch (type)
	    {
	    case 0:
	       printf("base=%8.08lX ",(base & 0xFFFFFFF0L)) ;
	       break ;
	    case 1:
	       printf("base=%6.06lX ",(base & 0x00FFFFF0L)) ;
	       break ;
	    case 2:
	       printf("base=%8.08lX%8.08lX ",nextbase,(base & ~0x0F)) ;
	       used = TRUE ;
	       break ;
	    case 3:
	       printf("!reserved! ") ;
	       break ;
	    }
	 determine_region_size(bus,device,func,4*number+0x10) ;
	 if ((base & 8) != 0)
	    printf(" prefetchable") ;
	 putchar('\n') ;
	 return used ;			// indicate whether next reg. used up
	 }
      }
   return FALSE ;			// base does not extend to next reg.
}

//----------------------------------------------------------------------

static void dump_base_addresses(int bus, int device, int func,
				DWORD base0, DWORD base1, DWORD base2,
				DWORD base3, DWORD base4, DWORD base5)
{
   if (base0 == 0 && base1 == 0 && base2 == 0 && base3 == 0 &&
       base4 == 0 && base5 == 0)
      printf("No base addresses\n") ;
   else
      {
      printf("Base Addresses:\n") ;
      int used ;
      used = dump_base_address(bus,device,func,0,base0,base1) ;
      if (!used)
	 used = dump_base_address(bus,device,func,1,base1,base2) ;
      else
	 used = FALSE ;
      if (!used)
	 used = dump_base_address(bus,device,func,2,base2,base3) ;
      else
	 used = FALSE ;
      if (!used)
	 used = dump_base_address(bus,device,func,3,base3,base4) ;
      else
	 used = FALSE ;
      if (!used)
	 used = dump_base_address(bus,device,func,4,base4,base5) ;
      else
	 used = FALSE ;
      if (!used)
	 dump_base_address(bus,device,func,5,base5,0) ;
      }
}

//----------------------------------------------------------------------

static void dump_PCI_PM_capabilities(const char *caplist)
{
   unsigned int PMC = *(unsigned int*)(caplist+2) ;
   unsigned int PMCSR = *(unsigned int*)(caplist+4) ;
   int PMCSR_ext = caplist[6] ;
   int data = caplist[7] ;
   printf("\t PMC    = ") ;
   write_bits(PMC,PMC_bits,lengthof(PMC_bits)) ;
   printf("\n\t\tDynClk = %d, PCI_PM version = %d\n",
		  (PMC & 0x00C0) >> 6,
		  (PMC & 0x0007)) ;
   printf("\t PMCSR  = %4.04X, data-select=%d ",PMCSR, (PMCSR & 0x1E00) >> 9) ;
   if (PMCSR & 0x6000)
      printf("scale=0.%s1\n","00"+(3-((PMCSR & 0x1E00)>>9))) ;
   else
      printf("unknown/unimplemented\n") ;
   printf("\t\tstate=D%d %s %s %s\n",
                  PMCSR & 0x0003,
                  PMCSR & 0x0010 ? "DynReport" : "",
                  PMCSR & 0x0100 ? "PME#-ena"  : "",
                  PMCSR & 0x8000 ? "PME#-active" : "") ;
   printf("\t PMCSRX = %s %s %s %s\n",
		  PMCSR_ext & 0x80 ? "BusPowerCtrl" : "--",
		  PMCSR_ext & 0x20 ? "state-B2" : "--",
                  PMCSR_ext & 0x40 ? "state-B3" : "--",
		  PMCSR_ext & 0x10 ? "DynamicClock" : "--") ;
   printf("\t Data   = %2.02X\n",data) ;
   return ;
}

//----------------------------------------------------------------------

static void dump_AGP_capabilities(const char *caplist)
{
   static char *agprate[] = { "default speed", "1x", "2x", "illegal",
			      "4x", "illegal", "illegal", "illegal" } ;
   BYTE AGPver = caplist[2] ;
   DWORD AGPstat = *((DWORD*)&caplist[4]) ;
   DWORD AGPcmd = *((DWORD*)&caplist[8]) ;
   printf("\t supported AGP version = %d.%d\n",AGPver/16,AGPver%16) ;
   printf("\t max request queue = %d, AGP side band addressing %ssupported\n",
	  (int)((AGPstat >> 24)&0xFF),((AGPstat&0x200)?"":"not ")) ;
   printf("\t supported transfer type(s): %s%s%s\n",
	  ((AGPstat&1)?"1x ":""),((AGPstat&2)?"2x ":""),
	  ((AGPstat&4)?"4x ":"")) ;
   printf("\t AGP is currently %sabled at %s (sideband addr %s)\n",
	  (AGPcmd&0x100?"en":"dis"),agprate[AGPcmd&7],
	  (AGPcmd&0x200?"on":"off")) ;
   return ;
}

//----------------------------------------------------------------------

static void dump_capabilities_list(int start_offset, const char *cfgdata)
{
   if (!start_offset)
      {
      printf("empty Capabilities list!\n") ;
      return ;
      }
   printf("Capabilities List:\n",start_offset) ;
   do {
      unsigned ID = cfgdata[start_offset] ;
      unsigned next = cfgdata[start_offset+1] ;
      printf("\tID @%2.02X = %2.02X ",start_offset,ID) ;
      switch (ID)
	 {
	 case 0x00:
	    printf("disabled capability\n") ;
	    break ;
	 case 0x01:
	    printf("PCI Power Management\n") ;
	    dump_PCI_PM_capabilities(cfgdata+start_offset) ;
	    break ;
	 case 0x02:
	    printf("AGP Capabilities\n") ;
	    dump_AGP_capabilities(cfgdata+start_offset) ;
	    break ;
	 default:
	    printf("(unknown)\n") ;
	    break ;
	 }
      start_offset = next ;
      } while (start_offset != 0) ;
}

//----------------------------------------------------------------------

static void dump_device_specific_data(unsigned vendor, unsigned device,
				      const char *cfgdata)
{
   if (!cfgdata)
      return ;
   char *format_string ;
   char const *enum_list = 0 ;
   if (!know_device(vendor,device,format_string,enum_list))
      return ;
   format(stdout,cfgdata,format_string,enum_list) ;
   free(format_string) ;
   return ;
}

//----------------------------------------------------------------------

static void write_IO_base_limit(const char *leadin, BYTE low, WORD high)
{
   printf(leadin) ;
   int size = (low & 0x0F) ;
   if (size == 0)
      printf("%4.04X",(low & 0xF0) << 8) ;
   else if (size == 1)
      printf("%8.08lX",((DWORD)high)|((low & 0xF0) << 8)) ;
   else
      printf("<invalid>") ;
   return ;
}

//----------------------------------------------------------------------

static void write_mem_base_limit(const char *leadin, WORD low, DWORD high,
				 DWORD limit_low, DWORD limit_high)
{
   printf(leadin) ;
   int size = (low & 0x0F) ;
   if (size == 0)
      printf(" %4.04X0000",low & 0xFFF0) ;
   else if (size == 1)
      printf(" %8.08lX%4.04X0000",high,(low & 0xFFF0)) ;
   else
      printf(" <invalid>") ;
   size = (limit_low & 0x0F) ;
   if (size == 0)
      printf("/%4.04X0000",limit_low & 0xFFF0) ;
   else if (size == 1)
      printf("/%8.08lX%4.04X0000",limit_high,(limit_low & 0xFFF0)) ;
   else
      printf("/<invalid>") ;
   return ;
}

//----------------------------------------------------------------------

#define setp setprecision

static int dump_PCI_config(int bus, int device, int func, int report_missing,
			   int &is_multifunc)
{
   int i ;
   PCIcfg *cfg = read_PCI_config(bus,device,func) ;
   if (!cfg || cfg->vendorID == 0xFFFF || cfg->deviceID == 0xFFFF)
      {
      if (report_missing)
	 printf("No PCI device at bus %2.02X device %2.02X function %2.02X\n",
		bus,device,func) ;
      return FALSE ;
      }
   if (!first_device)
      printf("-----------------------------------------------------------\n") ;
   first_device = FALSE ;
   printf("PCI bus %2.02X device %2.02X function %2.02X:  ",bus,device,func) ;
   printf("Header Type '") ;
   switch (cfg->header_type & 0x7F)
      {
      case 0x00:
	 printf("non-bridge") ;
	 break ;
      case 0x01:
	 printf("PCI-PCI bridge") ;
	 break ;
      case 0x02:
	 printf("CardBus bridge") ;
	 break ;
      default:
	 printf("other [%2.02X]",cfg->header_type & 0x7F) ;
	 break ;
      }
   if ((cfg->header_type & 0x80) != 0)	// make multi-function flag sticky
      is_multifunc = 1 ;		// since some devs only show on func 0
   printf("' (%s-func)\n",is_multifunc ? "multi" : "single") ;
   const char *class_name = "???" ;
   if (cfg->classcode < lengthof(class_names))
      class_name = class_names[cfg->classcode] ;
   const char *subclass_name = get_subclass_name(cfg->classcode,cfg->subclass);
   if (terse)
      {
      const char *vendorname = get_vendor_name(cfg->vendorID) ;
      char unkvendor[40] ;
      if (strcmp(vendorname,"???") == 0)
	 {
	 sprintf(unkvendor,"(Vendor %4.04X)",cfg->vendorID) ;
	 vendorname = unkvendor ;
	 }
      const char *devname = get_device_name(cfg->vendorID,cfg->deviceID) ;
      char unkdevice[40] ;
      if (strcmp(devname,"???") == 0)
	 {
	 sprintf(unkdevice,"(DeviceID %4.04X)",cfg->deviceID) ;
	 devname = unkdevice ;
	 }
      printf("%-38.38s º Class %2.02X: %-20.20s\tI/F: %2.02X\n"
	     "%-38.38s º SubCl %2.02X: %-20.20s\tRev: %2.02X\n",
	     vendorname,cfg->classcode,class_name,cfg->progIF,
	     devname,cfg->subclass,subclass_name,cfg->revisionID) ;
      return is_multifunc ;
      }
   else
      {
      printf("Vendor:\t%4.04X\t%-50.50s\n",cfg->vendorID,
	     get_vendor_name(cfg->vendorID)) ;
      printf("Device:\t%4.04X\t%-50.50s\n",
	     cfg->deviceID,get_device_name(cfg->vendorID,cfg->deviceID)) ;
      printf("Class:\t  %2.02X\t%-20.20s\tRevision:\t%2.02X\n",
	     cfg->classcode,class_name,cfg->revisionID) ;
      printf("SubClass: %2.02X\t%-20.20s\tProgramI/F:\t%2.02X\n",
	     cfg->subclass,subclass_name,cfg->progIF) ;
      }
   printf("CommandReg:	 %4.04X =",cfg->command_reg) ;
   WRITE_CMD_BITS(cfg->command_reg) ;
   printf("\n"
	  "Status Reg:	 %4.04X =",cfg->status_reg) ;
   WRITE_STAT_BITS(cfg->status_reg) ;
   printf(" (%s)\n",select_timing[(cfg->status_reg & 0x0600) >> 9]) ;
   printf("CacheLine:	   %2.02X\tLatency:\t%2.02X\tBIST:\t     %2.02X\n",
	  cfg->cacheline_size,cfg->latency,cfg->BIST) ;
   switch(cfg->header_type & 0x7F)
      {
      case 0x00:  // non-bridge
	 printf("SubsysVendor:    %4.04X\tSubsysDevice: %4.04X\n",
		cfg->nonbridge.subsystem_vendorID,
		cfg->nonbridge.subsystem_deviceID) ;
	 dump_base_addresses(bus,device,func,
			     cfg->nonbridge.base_address0,
			     cfg->nonbridge.base_address1,
			     cfg->nonbridge.base_address2,
			     cfg->nonbridge.base_address3,
			     cfg->nonbridge.base_address4,
			     cfg->nonbridge.base_address5) ;
	 printf("CardBus:     %8.08lX\tExpansionROM: %8.08lX ",
		cfg->nonbridge.CardBus_CIS,cfg->nonbridge.expansion_ROM) ;
	 determine_ROM_size(bus,device,func,0x30) ;
	 printf("\n") ;
	 printf("INTline:\t   %2.02X\tINTpin:       %2.02X\n",
		cfg->nonbridge.interrupt_line,cfg->nonbridge.interrupt_pin) ;
	 printf("MinGrant:\t   %2.02X\tMaxLatency:   %2.02X\n",
		cfg->nonbridge.min_grant,cfg->nonbridge.max_latency) ;
	 printf("Device-Specific Data:\n 40:") ;
	 for (i = 0 ; i < 48 ; i++)
	    {
	    printf(" %8.08lX ",cfg->nonbridge.device_specific[i]) ;
	    if (i % 6 == 5 && i < 47)
	       printf("\n %2.02X:",4*(i+17)) ;
	    }
	 putchar('\n') ;
	 if (cfg->status_reg & CAPLIST_BIT)
	    dump_capabilities_list(cfg->nonbridge.cap_ptr,(char*)cfg) ;
	 break ;
      case 0x01:  // bridge
	 printf("PrimaryBus:\t   %2.02X\tSecondaryBus:	%2.02X\tSubordinBus: %2.02X\n",
		cfg->bridge.primary_bus,cfg->bridge.secondary_bus,
		cfg->bridge.subordinate_bus) ;
	 printf("SecLatency:\t   %2.02X\tExpansion ROM: %8.08lX ",
		cfg->bridge.secondary_latency,cfg->bridge.expansion_ROM) ;
	 determine_ROM_size(bus,device,func,0x38) ;
	 printf("\n") ;
	 printf("SecStatus:\t %4.04X =",cfg->bridge.secondary_status) ;
	 WRITE_STAT_BITS(cfg->bridge.secondary_status) ;
	 printf(" (%s)\n",select_timing[(cfg->bridge.secondary_status & 0x0600) >> 9]) ;
	 printf("BridgeCntrl:\t %4.04X =",
		cfg->bridge.bridge_control) ;
	 WRITE_BCTRL_BITS(cfg->bridge.bridge_control) ;
	 printf("\n") ;
	 write_mem_base_limit("MemBase/Limit: ",cfg->bridge.memory_base_low,0,
			      cfg->bridge.memory_limit_low,0) ;
	 printf("\t") ;
         write_IO_base_limit("IObase/limit: ",cfg->bridge.IO_base_low,
                             cfg->bridge.IO_base_high) ;
         write_IO_base_limit("/",cfg->bridge.IO_limit_low,
                             cfg->bridge.IO_limit_high) ;
	 printf("\n") ;
	 write_mem_base_limit("PrefBase/Limit:",cfg->bridge.prefetch_base_low,
			      cfg->bridge.prefetch_base_high,
			      cfg->bridge.prefetch_limit_low,
			      cfg->bridge.prefetch_limit_high) ;
	 printf("\tINTline:  %2.02X\tINTpin:  %2.02X\n",
		cfg->bridge.interrupt_line,cfg->bridge.interrupt_pin) ;
	 dump_base_addresses(bus,device,func,
			     cfg->bridge.base_address0,
			     cfg->bridge.base_address1,0,0,0,0) ;
	 printf("Device-Specific Data:\n 40:") ;
 	 for (i = 0 ; i < 48 ; i++)
	    {
	    printf(" %8.08lX ",cfg->bridge.device_specific[i]) ;
	    if (i % 6 == 5 && i < 47)
	       printf("\n %2.02X:",4*(i+17)) ;
	    }
	 putchar('\n') ;
	 break	;
      case 0x02:
	 printf("SubsysVendor: %4.04X\tSubsysDevice: %4.04X\n",
		cfg->cardbus.subsystem_vendorID,
		cfg->cardbus.subsystem_deviceID) ;
	 printf("PCI bus: %2.02X\tCardBus bus: %2.02X\tSubordBus: %2.02X\tLatency: %2.02X\n",
		cfg->cardbus.PCI_bus, cfg->cardbus.CardBus_bus,
		cfg->cardbus.subordinate_bus, cfg->cardbus.latency_timer) ;
	 printf("Memory0: %8.08lX bytes at %8.08lX\n",
		cfg->cardbus.memory_limit0, cfg->cardbus.memory_base0) ;
	 printf("Memory1: %8.08lX bytes at %8.08lX\n",
		cfg->cardbus.memory_limit1, cfg->cardbus.memory_base1) ;
	 printf("I/O range 0: %4.04X ports at %4.04X\n",
		cfg->cardbus.IOlimit_0low, cfg->cardbus.IObase_0low) ;
	 printf("I/O range 1: %4.04X ports at %4.04X\n",
		cfg->cardbus.IOlimit_1low, cfg->cardbus.IObase_1low) ;
	 printf("INTline:  %2.02X\tINTpin:  %2.02X\tBridgeCntrl: %4.04X\n",
		cfg->cardbus.interrupt_line,cfg->cardbus.interrupt_pin,
		cfg->cardbus.bridge_control) ;
	 printf("Legacy Mode base address: %8.08lX\n",
		cfg->cardbus.legacy_baseaddr) ;
	 printf("Device-Specific Data:\n 80:") ;
	 for (i = 0 ; i < 32 ; i++)
	    {
	    printf(" %8.08lX ",cfg->cardbus.vendor_specific[i]) ;
	    if (i % 6 == 5 && i < 47)
	       printf("\n %2.02X:",4*(i+33)) ;
	    }
	 putchar('\n') ;
	 if (cfg->status_reg & CAPLIST_BIT)
	    dump_capabilities_list(cfg->cardbus.cap_ptr,(char*)cfg) ;
	 break ;
      default:
	 printf("Unknown header format %2.02X!\n",cfg->header_type & 0x7F) ;
	 break ;
      }
   if (verbose)
      dump_device_specific_data(cfg->vendorID,cfg->deviceID,(char*)cfg) ;
   if (!report_missing)
      putchar('\n') ;
   return is_multifunc ;
}

//----------------------------------------------------------------------

static int read_device_ID(FILE *fp, char *&ID_data, int maxsize,
			  int pcicfg_format)
{
   char line[MAX_LINE] ;
   long startpos = ftell(fp) ;
   if (!read_nonblank_line(line,sizeof(line),fp,pcicfg_format))
      return FALSE ;
   char *data_end = ID_data + maxsize - (MAX_DEVICE_NAME + 5) ;
   const char *l = line ;
   int is_vendor_line ;
   if (pcicfg_format)
      {
      l = skip_whitespace(l) ;
      is_vendor_line = strncmp(l,"Vendor",6) == 0 ;
      if (is_vendor_line)
	 l = skip_whitespace(l+6) ;	// skip to vendor ID
      }
   else
      {
      is_vendor_line = isxdigit(*l) ;
      }
   if (is_vendor_line)
      {
      *((char**)ID_data) = 0 ;		// pointer to next vendor ID
      ID_data += sizeof(char*) ;
      WORD *length = (WORD*)ID_data ;
      *((WORD*)ID_data) = 0 ;		// length of data for vendor
      ID_data += sizeof(WORD) ;
      WORD ID = hextoint(l) ;		// get the vendor's ID
      *((WORD*)ID_data) = ID ;
      ID_data += sizeof(WORD) ;
      l = skip_whitespace(l) ;		// skip to vendor name
      int count = 0 ;
      // copy the vendor name
      while (*l && *l != '\n' && count++ < MAX_VENDOR_NAME)
	 *ID_data++ = *l++ ;
      *ID_data++ = '\0' ;		// ensure termination
      do {
	 startpos = ftell(fp) ;
	 if (!read_nonblank_line(line,sizeof(line),fp,pcicfg_format))
	    break ;
	 l = line ;
	 int is_device_line ;
	 if (pcicfg_format)
	    {
	    l = skip_whitespace(l) ;
	    is_vendor_line = strncmp(l,"Vendor",6) == 0 ;
	    is_device_line = isxdigit(*l) ;
	    }
	 else
	    {
	    is_vendor_line = isxdigit(*l) ;
	    is_device_line = FALSE ;
	    if (!is_vendor_line)
	       {
	       l = skip_whitespace(l) ;
	       is_device_line = isxdigit(*l) ;
	       }
	    }
	 if (is_device_line)
	    {
	    ID = hextoint(l) ;		// convert device ID
	    if (ID != 0xFFFF)
	       {
	       *((WORD*)ID_data) = ID ;
	       ID_data += sizeof(WORD) ;
	       l = skip_whitespace(l) ; // skip to device name
	       // copy the device name
	       count = 0 ;
	       while (*l && *l != '\n' && count++ < MAX_DEVICE_NAME)
		  *ID_data++ = *l++ ;
	       *ID_data++ = '\0' ;	// ensure termination
	       if (ID_data >= data_end)
		  {
		  fprintf(stderr,"Too much information for a single vendor!\n") ;
		  return TRUE ;
		  }
	       }
	    }
	 } while (!is_vendor_line) ;
      *length = (ID_data - (char*)length) - sizeof(*length) ;
      // back up to start of Vendor line
      (void)fseek(fp,startpos,SEEK_SET) ;
      return TRUE ;
      }
   else // !is_vendor_line
      {
      fprintf(stderr,"non-empty line found, but it is not a vendor ID line!\n");
      return FALSE ;
      }
}

//----------------------------------------------------------------------

static int check_PCICFG_DAT_signature(FILE *fp, int complain = FALSE)
{
   char signature[SIGNATURE_LENGTH] ;
   (void)fseek(fp,0L,SEEK_SET) ;
   signature[0] = '\0' ;
   if (fread(signature,sizeof(char),sizeof(signature),fp) < sizeof(signature))
      return FALSE ;
   int present = strncmp(signature,SIGNATURE,SIGNATURE_LENGTH) == 0 ;
   if (present)
      {
      // skip the rest of the first line
      int c ;
      while ((c = fgetc(fp)) != EOF && c != '\n')
	 ;
      }
   else
      {
      (void)fseek(fp,0L,SEEK_SET) ;
      if (complain)
	 {
	 fprintf(stderr,"Invalid PCICFG.DAT\n") ;
	 if (verbose)
	    fprintf(stderr,"File Signature: \"%6.6s\"\n",signature) ;
	 }
      }
   return present ;
}

//----------------------------------------------------------------------

static int load_device_IDs()
{
   FILE *fp = open_PCICFG_DAT("r") ;
   if (fp)
      {
      int pcicfg_format = check_PCICFG_DAT_signature(fp,TRUE) ;
      char *prev_ID_data = 0 ;
      while (!feof(fp))
	 {
	 char *vendor_ID_data = (char*)malloc(MAX_VENDOR_DATA) ;
	 if (!vendor_ID_data)
	    {
	    fprintf(stderr,"Insufficient memory for PCICFG.DAT contents\n"
		           "Some vendors/devices will not be shown by name\n") ;
	    return FALSE ;
	    }
	 char *ID_data = vendor_ID_data ;
	 if (!read_device_ID(fp,ID_data,MAX_VENDOR_DATA,pcicfg_format))
	    break ;
	 ID_data = (char*)realloc(vendor_ID_data, ID_data - vendor_ID_data) ;
	 if (ID_data)
	    vendor_ID_data = ID_data ;
	 if (prev_ID_data)
	    *((char**)prev_ID_data) = vendor_ID_data ;
	 else
	    device_ID_data = vendor_ID_data ;
	 prev_ID_data = vendor_ID_data ;
	 }
      return TRUE ;
      }
   return FALSE ;   
}

//----------------------------------------------------------------------

static int write_PCICFG_DAT_header(FILE *outfp)
{
   fputs("PCICFG ;<<-- signature - DO NOT CHANGE\n",outfp) ;
   return TRUE ;
}

//----------------------------------------------------------------------

static int copy_initial_comments(FILE *outfp, FILE *datfp)
{
   char line[MAX_LINE] ;
   int is_comment ;
   long startpos ;
   if (verbose)
      printf("copying initial comments:\n") ;
   do {
      line[0] = '\0' ;
      startpos = ftell(datfp) ;
      if (!fgets(line,sizeof(line),datfp))
	 return FALSE ;
      is_comment = is_comment_line(line) ;
      if (is_comment)
	 {
	 fputs(line,outfp) ;
	 if (verbose)
	    printf("\t%s",line) ;
	 }
      } while (is_comment) ;
   fseek(datfp,startpos,SEEK_SET) ;
   return TRUE ;
}

//----------------------------------------------------------------------

static char *skip_string(char *s, char *end)
{
   while (s < end && *s)
      s++ ;
   if (s < end)
      s++ ;				// skip terminating NUL
   return s ;
}

//----------------------------------------------------------------------

static int write_vendor_data(FILE *outfp, WORD ID, char *data, char *end)
{
   if (!outfp || !data || data >= end)
      return FALSE ;
   // output the vendor's name and ID
   fprintf(outfp,"Vendor %4.04X %s\n",ID,data) ;
   data = skip_string(data,end) ;
   // output all of the devices listed under the vendor
   while (data < end)
      {
      ID = *((WORD*)data) ;
      data += sizeof(WORD) ;
      fprintf(outfp,"  %4.04X %s\n",ID,data) ;
      data = skip_string(data,end) ;
      }
   return TRUE ;
}

//----------------------------------------------------------------------

static int merge_vendor_data(FILE *outfp, char *data1, char *data2)
{
   data1 += sizeof(char*) ;		// skip the 'next' field
   WORD length1 = *((WORD*)data1) ;	// get length of data
   data1 += sizeof(WORD) ;
   char *end1 = data1 + length1 ;
   WORD ID1 = *((WORD*)data1) ;		// get vendor ID
   data1 += sizeof(WORD) ;
   data2 += sizeof(char*) ;		// skip the 'next' field
   WORD length2 = *((WORD*)data2) ;	// get length of data
   data2 += sizeof(WORD) ;
   char *end2 = data2 + length2 ;
   WORD ID2 = *((WORD*)data2) ;		// get vendor ID
   data2 += sizeof(WORD) ;
   if (ID1 == ID2)
      {
      fprintf(outfp,"Vendor %4.04X %s\n",ID1,data1) ;
      data1 = skip_string(data1,end1) ;
      data2 = skip_string(data2,end2) ;
      ID1 = *((WORD*)data1) ;
      data1 += sizeof(WORD) ;
      ID2 = *((WORD*)data2) ;
      data2 += sizeof(WORD) ;
      while (data1 < end1 && data2 < end2)
	 {
	 if (ID1 <= ID2)
	    {
	    fprintf(outfp,"  %4.04X %s\n",ID1,data1) ;
	    if (ID1 == ID2)
	       {
	       data2 = skip_string(data2,end2) ;
	       ID2 = *((WORD*)data2) ;
	       data2 += sizeof(WORD) ;
	       }
	    data1 = skip_string(data1,end1) ;
	    ID1 = *((WORD*)data1) ;
	    data1 += sizeof(WORD) ;
	    }
	 else // if (ID1 > ID2)
	    {
	    fprintf(outfp,"  %4.04X %s\n",ID2,data2) ;
	    data2 = skip_string(data2,end2) ;
	    ID2 = *((WORD*)data2) ;
	    data2 += sizeof(WORD) ;
	    }
	 }
      while (data1 < end1)
	 {
	 // copy the remainder of the first file's device IDs
	 fprintf(outfp,"  %4.04X %s\n",ID1,data1) ;
	 data1 = skip_string(data1,end1) ;
	 ID1 = *((WORD*)data1) ;
	 data1 += sizeof(WORD) ;
	 }
      while (data2 < end2)
	 {
	 // copy the remainder of the second file's device IDs
	 fprintf(outfp,"  %4.04X %s\n",ID2,data2) ;
	 data2 = skip_string(data2,end2) ;
	 ID2 = *((WORD*)data2) ;
	 data2 += sizeof(WORD) ;
	 }
      return 0 ;
      }
   else if (ID1 < ID2)
      {
      write_vendor_data(outfp,ID1,data1,end1) ;
      return -1 ;
      }
   else // ID1 > ID2
      {
      write_vendor_data(outfp,ID2,data2,end2) ;
      return +1 ;
      }
}

//----------------------------------------------------------------------

static int merge_info(FILE *outfp, FILE *datfp, FILE *newfp)
{
   if (!outfp || !datfp || !newfp)
      return FALSE ;
   if (!check_PCICFG_DAT_signature(datfp,TRUE))
      {
      fprintf(stderr,"invalid signature in PCICFG.DAT\n") ;
      return FALSE ;
      }
   if (!write_PCICFG_DAT_header(outfp) || !copy_initial_comments(outfp,datfp))
      {
      fprintf(stderr,"error writing new header\n") ;
      return FALSE ;
      }
   int pcicfg_format = check_PCICFG_DAT_signature(newfp,FALSE) ;
   if (verbose)
      printf("new data file is in %s format\n",
	     pcicfg_format ? "PCICFG" : "Merlin's") ;
   if (!copy_initial_comments(outfp,newfp))
      {
      fprintf(stderr,"error copying initial comments\n") ;
      return FALSE ;
      }
   char *data1 = (char*)malloc(MAX_VENDOR_DATA) ;
   char *data2 = (char*)malloc(MAX_VENDOR_DATA) ;
   if (!data1 || !data2)
      {
      fprintf(stderr,"Insufficient memory to merge data!\n") ;
      if (data1)
	 free(data1) ;
      return FALSE ;
      }
   char *dat1 = data1 ;
   char *dat2 = data2 ;
   // load up the first vendor from each file
   if (!read_device_ID(datfp,dat1,MAX_VENDOR_DATA,TRUE) ||
       !read_device_ID(newfp,dat2,MAX_VENDOR_DATA,pcicfg_format))
      {
      free(data1) ;
      free(data2) ;
      fprintf(stderr,"empty data file!\n") ;
      return FALSE ;
      }
   int done1 = FALSE ;
   int done2 = FALSE ;
   do {
      int merge = merge_vendor_data(outfp,data1,data2) ;
      switch (merge)
	 {
	 case -1:
	    dat1 = data1 ;
	    if (!read_device_ID(datfp,dat1,MAX_VENDOR_DATA,TRUE))
	       done1 = TRUE ;
	    break ;
	 case 0:
	    dat1 = data1 ;
	    if (!read_device_ID(datfp,dat1,MAX_VENDOR_DATA,TRUE))
	       done1 = TRUE ;
	    // fall through to +1
	 case +1:
	    dat2 = data2 ;
	    if (!read_device_ID(newfp,dat2,MAX_VENDOR_DATA,pcicfg_format))
	       done2 = TRUE ;
	    break ;
	 default:
	    fprintf(stderr,"Missed case in switch()!\n") ;
	    return FALSE ;
	 }
      } while (!done1 && !done2) ;
   if (!done1)
      {
      // copy any remaining items from first file (we can't possibly have any
      // left over from the second file, since PCICFG.DAT goes up to FFFFh)
      do {
	 dat1 = data1 + sizeof(char*) ;	// reset, but skip the 'next' field
	 WORD length1 = *((WORD*)dat1) ;
	 dat1 += sizeof(WORD) ;
	 char *end1 = data1 + length1 ;
	 WORD ID1 = *((WORD*)dat1) ;	// get vendor ID
	 dat1 += sizeof(WORD) ;
	 write_vendor_data(outfp,ID1,dat1,end1) ;
	 dat1 = data1 ;
	 } while (read_device_ID(datfp,dat1,MAX_VENDOR_DATA,TRUE)) ;
      }
   free(data1) ;
   free(data2) ;
   return TRUE ;
}

//----------------------------------------------------------------------

static int merge_new_info(const char *filename)
{
   if (!filename || !*filename)
      return FALSE ;
   FILE *fp = fopen(filename,"r") ;
   if (fp)
      {
      static char tempfile[] = "pcicfg.$$$" ;
      FILE *datfp = open_PCICFG_DAT("r") ;
      FILE *merged = fopen(tempfile,"w") ;
      if (!datfp)
	 return FALSE ;
      if (!merged)
	 {
	 fprintf(stderr,"Unable to open temporary file for merge\n") ;
	 return FALSE ;
	 }
      int success = merge_info(merged,datfp,fp) ;
      (void) fclose(datfp) ;
      (void) fclose(fp) ;
      (void) fclose(merged) ;
      if (success)
	 {
	 // copy the temporary file over PCICFG.DAT
	 merged = fopen(tempfile,"r") ;
	 fp = open_PCICFG_DAT("w") ;
	 char buffer[BUFSIZ] ;
	 int count ;
	 while ((count = fread(buffer,sizeof(char),sizeof(buffer),merged)) > 0)
	    {
	    if (fwrite(buffer,sizeof(char),count,fp) < count)
	       {
	       fprintf(stderr,"Error copying temporary file to PCICFG.DAT!!\n") ;
	       break ;
	       }
	    }
	 (void) fclose(fp) ;
	 (void) fclose(merged) ;
	 }
      else
	 fprintf(stderr,"Unable to merge new data!\n") ;
      unlink(tempfile) ;
      return success ;
      }
   return FALSE ;
}

//----------------------------------------------------------------------

static int merge_new_info(int argc, char **argv)
{
    if (!backup_PCICFG_DAT())
       {
       fprintf(stderr,"Unable to backup PCICFG.DAT\n") ;
       return 1 ;
       }
    while (argc > 0 && *argv)
       {
       if (!merge_new_info(argv[0]))
	  return 2 ;
       argc-- ;
       argv++ ;
       }
    return 0 ;
}

//----------------------------------------------------------------------

int main(int argc, char **argv)
{
   fprintf(stderr,"PCICFG v" VERSION " (c) Copyright 1997,1998 Ralf Brown\n") ;
   get_exe_directory(argv[0]) ;
   while (argc > 1 && argv[1][0] == '-')
      {
      switch (argv[1][1])
	 {
	 case 'b':
	    bypass_BIOS = TRUE ;
	    if (argv[1][2] == '1')
	       cfg_mech = 1 ;
	    else if (argv[1][2] == '2')
	       cfg_mech = 2 ;
	    else
	       determine_cfg_mech() ;
	    break ;
	 case 'm':
	    // merge new info into PCICFG.DAT
	    return merge_new_info(argc-2,argv+2) ;
	 case 't':
	    terse = TRUE ;
	    break ;
	 case 'v':
	    verbose = TRUE ;
	    break ;
	 default:
	    fprintf(stderr,"unrecognized option '%s'\n",argv[1]) ;
	    break ;
	 }
      argv++ ;
      argc-- ;
      }
   int maxbus = check_PCI_BIOS() ;
   if (maxbus < 0)
      {
      if (!bypass_BIOS)
	 {
	 fprintf(stderr,"\nNo PCI BIOS detected\n") ;
	 return 2 ;
	 }
      else
	 maxbus = 0xFF ;		// have to scan ALL possible buses
      }
   if (!load_device_IDs())
      {
      fprintf(stderr,
	      "Unable to load the list of vendor and device IDs (PCICFG.DAT).\n"
	      "Devices will not be identified by name.\n") ;
      }
   if (argc == 2 && argv[1][0] == '*')
      {
      for (int bus = 0 ; bus <= maxbus ; bus++)
	 {
	 for (int device = 0 ; device < 32 ; device++)
	    {
	    int multifunc = 0 ;
	    for (int func = 0 ; func < 8 ; func++)
	       {
	       if (!dump_PCI_config(bus,device,func,0,multifunc))
		  break ;
	       }
	    }
	 }
      return 0 ;
      }
   if (argc < 4)
      {
      fprintf(stderr,
	      "\nUsage:\tPCICFG [flag(s)] bus device func\n"
	      "\tPCICFG [flag(s)] *         (to scan all devices)\n"
	      "\tPCICFG -m file [file ...]  (to merge new info into PCICFG.DAT)\n"
	      "\n"
	      "Dumps info about the specified PCI device, or all devices\n"
	      "Flags:\n"
	      "\t-bN\tbypass BIOS -- talk directly to PCI hardware ports using\n"
	      "\t\t access mechanism N (1 or 2) [using wrong one can reboot/hang!]\n"
	      "\t-t\tterse -- output only device type and ID\n"
	      "\t-v\tverbose output for known devices\n"
	      "\n"
	      "Use -v for more verbose output on devices specifically recognized by\n"
	      "PCICFG.  Output is generally quite lengthy even without -v, so you\n"
	      "should redirect output into a file or pipe it to MORE or LIST\n") ;
      return 1 ;
      }
   char *end = 0 ;
   int bus = (int)strtol(argv[1],&end,0) ;
   int device = (int)strtol(argv[2],&end,0) ;
   int func = (int)strtol(argv[3],&end,0) ;
   if (bus > maxbus)
      {
      fprintf(stderr,"\nRequested PCI bus does not exist\n") ;
      return 3 ;
      }
   else
      {
      int multifunc = 0 ;
      dump_PCI_config(bus,device,func,1,multifunc) ;
      }
   return 0 ;
}

// end of file pcicfg.cpp //
