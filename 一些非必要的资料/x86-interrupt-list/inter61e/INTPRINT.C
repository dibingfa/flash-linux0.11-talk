/************************************************************************/
/* INTPRINT.C by Ralf Brown.  Donated to the Public Domain.		*/
/* Please do not remove my name from any copies or derivatives.		*/
/************************************************************************/
/* Program History:							*/
/*   v1.00  4/23/89  initial public release				*/
/*		     with 4/30/89 list					*/
/*   v1.10  5/21/89  added -I and -f					*/
/*   v1.11  1/6/90   fixed #endif's for compilers which don't handle	*/
/*		     labels						*/
/*   v1.20  6/8/90   added -r						*/
/*   v1.30  7/14/90  added -b, tables now stay aligned on odd indents	*/
/*   v1.40  10/6/90  added -B based on changes by Naoto Kimura, -w	*/
/*   v1.40a 5/6/91   HP LaserJet II support by Russ Herman		*/
/*   v1.41  7/9/91   HP PCL support by P.J.Farley III			*/
/*   v2.00  9/1/91   modular printer definitions			*/
/*		     printing multipart interrupt list			*/
/*   v2.01  2/9/92   fixed summary entry for non-numeric AX= and AH=	*/
/*		     smarter page breaks				*/
/*   v2.02  2/18/92  bugfix & isxdigit suggested by Aaron West		*/
/*   v2.10  3/14/92  updated to handle extra flags in headings		*/
/*   v2.11  5/23/92  bugfix pointed out by Joe White			*/
/*   v2.20  6/12/92  added -F based on code by Richard Brittain		*/
/*		     added -H and Panasonic printer def by Lewis Paper	*/
/*   v2.21  10/14/92 fixed error in -H/-r interaction			*/
/*		     updated for new 'Bitmask of' section		*/
/*   v2.22   2/15/93 exclude Index: by default, -x to force inclusion	*/
/*		     changed 'Bitmask of' to 'Bitfields for'		*/
/*   v2.23   5/24/93 fix to allow INT/AL= to appear correctly in summary*/
/*   v2.24   7/15/93 -k and infinite-length pages by Bent Lynggaard	*/
/*   v3.00  04jun94  -T, -V, and multi-file break section skipping	*/
/*		     major speedups; checked for BC++3.1 compatibility	*/
/*   v3.01  11jun94  bugfix: crashed with -l0 -L1 on lines >=80 chars   */
/*   v3.02  07jan95  bugfix by Mark Shapiro: garbage with -B -PHP_PCL	*/
/*   v3.03  14jan95  changes for Borland C++ 4.x size minimization	*/
/*   v3.04  25mar95  malloc/sbrk and other bugfixes		        */
/*   v3.10  11feb96  category filters by Bent Lynggard			*/
/*   v3.11  21dec97  support formatting/summarizing other intlist files */
/*   v3.12  25jul98  support for five-char table numbers		*/
/************************************************************************/
/* Recompiling:								*/
/*   Turbo C / Borland C++						*/
/*	tcc -mt -lt -O -a -Z -p -k- intprint				*/
/*      bcc -mt -lt -a -d -O1agim -p intprint.c				*/
/*   Borland C++ 4.x (as .EXE, from John <tenthumbs@bix.com>)		*/
/*	bcc -ms -a -d -O1agim -p intprint.c noehs.lib			*/
/************************************************************************/

#include <ctype.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>		/* S_IREAD, S_IWRITE */

#define VERSION "3.12"

/***********************************************/
/*    portability definitions		       */

#define _other_		/* assume no system-specific match */

/*--------------------------------------------------*/
/* first system: MS-DOS with Turbo/Borland C        */

#ifdef __TURBOC__
#  define PROTOTYPES
#  include <alloc.h>
#  include <io.h>    /* open, close, read, lseek, etc. */
   int _Cdecl isatty(int handle) ;

   /* definitions to reduce size of executable */
   unsigned int _Cdecl _stklen = 1024 ;
   #define close _close
   #define read _read
   #define write _write
   void _Cdecl _setenvp(void) {} /* don't need environment--don't include it */
   void *_Cdecl malloc(size_t size)
	 { void *x = sbrk(size) ; return (x==(char*)-1) ? 0 : x ; }
   void _Cdecl free(void *var) { (void)var ; }
   /* since our free() doesn't do anything, macro it out of existence */
   #define free(p)

   #ifdef __BORLANDC__
   void _Cdecl _setupio(void) {}
   #pragma warn -eff
   /* BC++ v3.1 sets __BORLANDC__ to 0x0410!! */
   #if __BORLANDC__ >= 0x0400 && __BORLANDC__ != 0x0410
   /* Changes by John Sasse to minimize executable size */
   #if 1
      /* the preferred way */
      /* Borland claims they "might" stop supporting these functions. Right */
      #define   _close(a)      _rtl_close(a)
      #define   _creat(a,b)    _rtl_creat(a,b)
      #define   _open(a,b)     _rtl_open(a,b)
      #define   _read(a,b,c)   _rtl_read(a,b,c)
      #define   _write(a,b,c)  _rtl_write(a,b,c)
      #if __BORLANDC__ == 0x400
      /* They forgot to change this in 4.00 only */
      #undef    _read
      #endif
   #else
      #pragma warn -obs    /* the easy way */
   #endif /* 1 */
   #endif /* __BORLANDC__ >= 0x400 */
   #endif /* __BORLANDC__ */

#undef _other_
#endif /* __TURBOC__ */

#ifdef __MSDOS__
#  define LINE_TERMINATOR '\n'
#endif

/*--------------------------------------------------*/
/*   Gnu C compiler                                 */

#ifdef __GNUC__
#define PROTOTYPES
#define NEED_ITOA
#define NEED_ULTOA
#define NEED_STRUPR
#define NEED_STRNICMP

#undef _other_
#endif /* __GNUC__ */

/*--------------------------------------------------*/
/*  generic Unix definitions                        */

#ifdef unix
#  include <sys/unistd.h>	/* open, close, read, lseek, etc. */
#  include <sysent.h>		/* open, close, read, lseek, etc. */
extern int isatty(int) ;
#  define LINE_TERMINATOR '\n'
#endif


/*--------------------------------------------------*/
/*  any other system                                */

#ifdef _other_
/* unknown compiler/system, so set configuration #defines */
#if 0  /* set to 1 if compiler supports ANSI-style prototypes, 0 otherwise */
#define PROTOTYPES
#endif
#if 1  /* set to 0 if library contains strnicmp(), 1 otherwise */
#define NEED_STRNICMP
#endif
#if 1  /* set to 0 if library contains isxdigit(), 1 otherwise */
#define NEED_ISXDIGIT
#endif
#if 1  /* set to 0 if library contains strupr(), 1 otherwise */
#define NEED_STRUPR
#endif
#if 1  /* set to 0 if library contains three-arg itoa(), 1 otherwise */
#define NEED_ITOA
#endif
#if 1  /* set to 0 if library contains three-arg ultoa(), 1 otherwise */
#define NEED_ULTOA
#endif

#endif /* _other_ */

/*--------------------------------------------------*/

/* the last character of the line termination sequence, i.e. '\n' for CRLF */
/* and LF, '\r' if your system uses CR or LFCR */
#ifndef LINE_TERMINATOR
#define LINE_TERMINATOR '\n'
#endif /* LINE_TERMINATOR */

/*--------------------------------------------------*/
/*  catchall for macros which might not be defined  */

#ifndef O_BINARY
#  define O_BINARY 0
#endif

#ifndef _Cdecl
#  define _Cdecl
#endif

/***********************************************/

#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE !FALSE
#endif

/***********************************************/

#define MAXLINE 82   /* at most 80 chars per line (plus CR and newline) */
#define MAXPAGE 200  /* at most 200 lines per page */

#define lengthof(x) (sizeof(x)/sizeof(x[0]))

#ifdef __MSDOS__
#define chars_to_long(a, b, c, d) \
	(a | (((long)b)<<8) | (((long)c)<<16) | (((long)d)<<24))
#define long_div_line chars_to_long('-','-','-','-')
#define divider_line(line) (((long*)line)[0] == long_div_line && \
  ((long*)line)[1] == long_div_line)
#define index_line(l) \
  (((long*)l)[0]==chars_to_long('I','n','d','e')&& \
   ((short*)l)[2]==('x'+':'*0x100))
#else
static char long_chars[] = "----INT Index:" ;
#define divider_line(line) (((long*)line)[0] == ((long*)long_chars)[0]\
  && ((long*)line)[1] == ((long*)long_chars)[0])
#define index_line(line) (((long*)line)[0] == ((long*)long_chars)[2] && \
  ((short*)line)[2] == (short*)long_chars)[6])
#endif
#define section_start(line) is_keyword(line,section_start_keys,lengthof(section_start_keys))
#define start_of_table(line) (is_keyword(line,table_start_keys,lengthof(table_start_keys)))

#define section_file_start(s) (s[0] == '-' && memcmp(s+1,"-------!---Section",18) == 0)


/* category filters definitions and variables */
#define CF_BUFFER_SIZE 26+26+9
typedef enum {CF_EXCLUDE, CF_UNCONDITIONAL, CF_INCLUDE, CF_OVERRIDE,
	CF_ENUM_SIZE} CF_ENUM; /* leave CF_ENUM_SIZE as the last enumetator */
char cf_buffers[CF_ENUM_SIZE][CF_BUFFER_SIZE+1];
char cf_current_category;
#define CF_EXCLUDE_CHAR '<'
#define CF_UNCONDITIONAL_CHAR '>'
#define CF_INCLUDE_CHAR 'i'
#define CF_OVERRIDE_CHAR 'o'

/***********************************************/
/*    stub functions to reduce executable size */
/***********************************************/

#ifdef __BORLANDC__
/* Changes by John Sasse */
/* BC++ v3.1 sets __BORLANDC__ to 0x0410!!  */
#if __BORLANDC__ >= 0x0400 && __BORLANDC__ != 0x0410
/*      Everything within this conditional may be placed in
 *      a separate source file if desired.
 */

/* stack overflow checking can never be allowed inside
   the run-time library */
#pragma option -N-

#include <errno.h>
/* the next 3 include files are necessary only if this
   is compiled as a separate file */
#if 0
#include <io.h>
#include <stdlib.h>
#include <string.h>
#endif

/* declarations */
void _Cdecl      __ErrorMessage (const char *__message);
int  pascal near __IOerror (int  _doserror_);
int  pascal near __DOSerror (int  _doserror_);
void _Cdecl      _abort (void);


/* may be referenced by a lot of things */
int _Cdecl _doserrno = 0;

/*
    The _rtl_* functions all call __IOError which originally
    referenced sys_nerr and sys_errlist. Unfortunately, the
    source file for these also contains perror which calls
    fputs. Hence you get lots of extra code.
    This is a very minimal replacement.
*/
int pascal near __IOerror(int _doserror_)
{
/* if _doserror_ is < 0, it might be a System V error.
   we don't care */
    _doserrno = (_doserror_ < 0) ? (-1) : _doserror_;
    errno = EIO;        /* a default value */
    return (-1);
}

/* __DOSerror and __IOerror are in the same source file.
   This may not actually be called. Better safe ...
*/
#if 1
int pascal near __DOSerror(int _doserror_)
{
    __IOerror(_doserror_);
    return (_doserror_);
}
#endif

/*
   The startup code, among others, references _setargv which
   references abort. The run-time library version says "raise
   (SIGABRT)", bringing in a lot of unnecessary code.
*/
void _Cdecl abort (void)
{
    _abort ();
}

/* necessary to avoid referencing _streams */
#if 1
#define STDERR      2

void _Cdecl __ErrorMessage(const char *msg)
{
    _rtl_write(STDERR, msg, strlen(msg));
}
#endif

/* restore command line state; note the "." */
#pragma option -N.

#endif  /* __BORLANDC__ >= 0x400 */
#endif  /* __BORLANDC__ */

/***********************************************/
/*    replacement file I/O function macros     */
/***********************************************/

typedef struct
   {
   int fd ;
   int buf_maxsize ;
   char *buf ;
   unsigned long bufoffset ;
   int bufsize ;
   int bufpos ;
   int write ;			 /* file is output file if nonzero */
   } IP_FILE ;

#define ip_putc(c,fp) \
  ((fp)->buf[fp->bufpos++]=(c),\
   ((fp)->bufpos>=(fp)->buf_maxsize&&ip_flush(fp)==-1)?-1:0)

/* output the indicated counted string to the given file */
#define ip_putcstr(s,fp) ip_write((s)->str,(s)->len,fp)
/* output the given string literal to the indicated file */
#define ip_putlit(s,fp) ip_write((s),sizeof(s)-1,fp)
/* output the given string variable to the indicated file */
#define ip_puts(s, fp) ip_write(s,strlen(s),fp)

#ifdef __MSDOS__
#define newline(fp) ip_write("\r\n",2,fp)
#else
#define newline(fp) ip_putc('\n',fp)
#endif

/***********************************************/

typedef struct			 /* a counted string */
   {
   int len ;			 /* the string's length */
   char *str ;			 /* the actual contents of the string */
   } cstr ;

#define CSTR(s) { sizeof(s)-1, (s) }  /* for defining a counted string literal */
#define cstrlen(s) ((s)->len)	 /* how long is the counted string? */

typedef struct
   {
   char *name ;			/* for selecting the appropriate printer */
   cstr init1, init2 ;		/* initialization strings */
   cstr marginl, marginc, marginr ; /* margins: duplex even, non-duplex, duplex odd */
   cstr duplex_on ;		/* turn on duplex mode */
   cstr term1, term2 ;		/* cleanup strings */
   cstr bold_on, bold_off ;	/* boldface on/off */
   int indent ;			/* how many extra spaces to indent */
   int lines_per_page ;		/* how many lines to print on each page */
   int page_length ;		/* how many lines on each page */
   int page_width ;		/* how many printable columns per line? */
#ifdef PROTOTYPES
   void (*put_line)(IP_FILE *,int) ;/* function to call to print out divider line */
   void (*set_typeface)(IP_FILE *,char *) ;
#else
   void (*put_line)() ;		/* function to call to print out divider line */
   void (*set_typeface)() ;
#endif /* PROTOTYPES */
   int *flag ;			/* flag to set when using this printer definition */
   } PRINTER_DEF ;

typedef struct filter_list
   {
   struct filter_list *next ;
   char str[1] ;		/* will allocate enough for actual string */
   } FILT_LIST ;

typedef struct
   {
   int part ;
   int first_on_page ; /* TRUE if a new entry starts at the top of the page */
   char desc[32] ;
   int len ;
   } HEADER ;

typedef struct
   {
/*   char *name ;*/
   char name[14] ;
   int length ;
   } KEYWORDS ;

/***********************************************/

#ifdef PROTOTYPES
void usage(void) ;
void fatal(char *msg) ;
void warning(char *msg) ;
int unwanted_section(char *buf) ;
IP_FILE *ip_fdopen(int fd,char *buf,int bufsiz, int maxsiz, int write) ;
IP_FILE *ip_open_write(char *name, int trunc, char *buf, int bufsiz) ;
IP_FILE *ip_open_read(char *name, char *buf, int bufsiz) ;
int ip_close(IP_FILE *fp) ;
unsigned long ip_fgets(char *buf, int max, IP_FILE *fp) ;
int ip_write(char *buf, int count, IP_FILE *fp) ;
int ip_flush(IP_FILE *fp) ;
void get_raw_line(char *buf) ;
void get_line(char *buf) ;
void indent_to(int where,IP_FILE *fp) ;
void put_line(IP_FILE *fp, int len) ;
void HPPCL_put_line(IP_FILE *fp, int len) ;
void HPPCL_set_typeface(IP_FILE *fp,char *typeface) ;
int start_of_entry(char *s) ;
int is_keyword(char *s, KEYWORDS *keys, unsigned int numkeys) ;
void output_line(char *line,IP_FILE *fp) ;
void fill_buffer(int lines, int lines_per_page) ;
int find_page_break(int lines) ;
int summarize(int line, int pages_printed) ;
void start_format(char *line) ;
void write_summary_header(IP_FILE *fp, char *title, int offsets, int tables) ;
void show_offset(int line,IP_FILE *fp) ;
void add_table(int i) ;
void add_category_filter_info(CF_ENUM filter, char *str) ;
FILT_LIST *add_filter_info(FILT_LIST *list,char *str) ;
void build_filter_lists(char *file) ;
int make_description(char *desc,char *type,int line) ;
char *determine_heading(int last) ;
void print_buffer(int last,int body_lines,int lines_per_page,int total_lines,
		  int use_FF) ;
void select_printer(char *name) ;
void display_printers(void) ;
static void reset_printer_and_close(IP_FILE *fp) ;
int _Cdecl main(int argc, char **argv) ;
#else
void put_line() ;
void HPPCL_put_line() ;
void HPPCL_set_typeface() ;
void show_offset() ;
#endif /* PROTOTYPES */

/***********************************************/
/*    I/O buffers			       */
/***********************************************/

char stderr_buf[1] ;
char filter_buf[256] ;
char infile_buf[8192] ;
char outfile_buf[8192] ;
char summary_buf[4096] ;
char formats_buf[3072] ;
char tables_buf[3072] ;

/***********************************************/

IP_FILE *err ;
IP_FILE *infile ;
IP_FILE *outfile ;
char *input_file ;
int input_file_namelen ;

char buffer[MAXPAGE][MAXLINE] ;
unsigned long line_offsets[MAXPAGE] ;
char num[8] ;
int need_summary ;
char summary_line[2*MAXLINE] ;
int summary_line_len ;

int pages_printed = 0 ;
int page_width = 0 ;		/* page width in characters, 0 = use prtdef */
int indent = 0 ;	        /* number of columns to indent lines */
char *indent_string = NULL ;	/* what to add at start of line to indent */
int indent_len = 0 ;	        /* length of indent_string */
int widow_length = 8 ;		/* number of lines to scan for good place to break */
int page_numbers = FALSE ;	/* add page numbers to bottom of page? */
int multi_file = FALSE ;	/* printing multipart interrupt list? */
int out_of_files = FALSE ;	/* hit end of last file for multipart printing? */
int do_summary = FALSE ;	/* create a one-line-per-call summary? */
int do_tables = FALSE ;		/* create a one-line-per-table index? */
int do_formats = FALSE ;	/* create a separate file with data structures? */
int do_filter = FALSE ;		/* using a filtering file? */
int do_headers = FALSE ;	/* add page headings? */
int include_index_lines = FALSE ;
int IBM_chars = FALSE ;		/* printer can handle IBM graphics characters */
int boldface = FALSE ;		/* boldface titles and Return:/Notes: ? */
int printer_bold = FALSE ;	/* boldface using printer control sequences? */
int echo_format = FALSE ;
int duplex = FALSE ;
int HPPCL_mode = FALSE ;
int show_offsets = FALSE ;
int keep_divider_lines = FALSE ;
int exclude_only = TRUE ;
IP_FILE *summary ;
IP_FILE *tables ;
IP_FILE *formats ;
PRINTER_DEF *printer = NULL ;

unsigned long current_line_offset = 0 ;
unsigned long offset_adjust = 0 ;

unsigned int first_page = 0 ;
unsigned int last_page = ~0 ;

int prev_table = 0 ;

FILT_LIST *includes = NULL ;
FILT_LIST *excludes = NULL ;

HEADER header_first = { 0, FALSE, "" } ;
HEADER header_last = { 0, FALSE, "" } ;

/***********************************************/

PRINTER_DEF printers[] =
   {
     { "default",
       CSTR(""), CSTR(""),
       CSTR(""), CSTR(""), CSTR(""),
       CSTR(""),
       CSTR(""), CSTR(""),
       CSTR(""), CSTR(""),
       -1,
       60,
       0,
       79,
       put_line,
       NULL,
       NULL,
     },
     { "Epson FX80, 12 cpi",
       CSTR("\033M"), CSTR(""),
       CSTR("\033l\004"), CSTR("\033l\007"), CSTR("\033l\014"),
       CSTR(""),
       CSTR("\033P"), CSTR("\033l\000"),
       CSTR("\033E"), CSTR("\033F"),
       0,
       60,
       0,
       87,	/* 96 - left margin - 1 right margin */
       put_line,
       NULL,
       NULL,
     },
     { "Panasonic KX-P1124i / 10 cpi Epson",
       CSTR(""), CSTR(""),
       CSTR(""), CSTR(""), CSTR(""),
       CSTR(""),
       CSTR(""), CSTR(""),
       CSTR("\033E"), CSTR("\033F"),
       -1,
       60,
       0,
       79,
       put_line,
       NULL,
       NULL,
     },
     { "HP PCL",
       CSTR("\033(8U"), CSTR(""),
       CSTR("\033&a4c4L"), CSTR("\033&a8c8L"), CSTR("\033&a12c12L"),
       CSTR("\033&l1S"),
       CSTR("\033E"), CSTR(""),
       CSTR("\033(s3B"), CSTR("\033(s0B"),
       0,
       69,
       0,
       87,	/* 96 - left margin - 1 right margin */
       HPPCL_put_line,
       HPPCL_set_typeface,
       &HPPCL_mode,
     },
#define HPPCL_FONT_ON_A "\033(s0p12h10v0s0b"
/* HP PCL4/5 Font select: Roman-8;Upright12Pitch10PointMediumWeight */
#define HPPCL_FONT_ON_B "T\033&l6.8571C"
/* HP PCL4/5 Font select: End typeface select;VMI=7LPI: (48/7)-48th's inches*/
#define HPPCL_IBM_LN_A	"\033&f0S\033*p-15Y\033*c"
/* HP PCL4/5 IBM Line:	Push Pos;Up 15/720";Hor.Rule ???/300ths" long */
#define HPPCL_IBM_LN_B	"a3b0P\033&f1S"
/* HP PCL4/5 IBM Line:	 3/300ths" high,Print rule;Pop Position */
     { "LaserJet II",
       CSTR("\033(10U"),CSTR(""),
       CSTR("\033&a4c4L"), CSTR("\033&a8c8L"), CSTR("\033&a12c12L"),
       CSTR(""),
       CSTR("\033E"),CSTR(""),
       CSTR("\033(s3B"),CSTR("\033(s0B"),
       0,
       54,
       60,
       79,
       put_line,
       NULL,
       &IBM_chars,
     },
   } ;
#define NUM_PRINTERS lengthof(printers)

/***********************************************/

#define KEYWORD_ENTRY(s) { s, sizeof(s)-1 }

KEYWORDS section_start_keys[] =
   {
    KEYWORD_ENTRY("BUG:"),
    KEYWORD_ENTRY("BUGS:"),
    KEYWORD_ENTRY("Desc:"),
    KEYWORD_ENTRY("Index:"),
    KEYWORD_ENTRY("Note:"),
    KEYWORD_ENTRY("Notes:"),
    KEYWORD_ENTRY("Program:"),
    KEYWORD_ENTRY("Range:"),
    KEYWORD_ENTRY("Return:"),
    KEYWORD_ENTRY("SeeAlso:"),
   } ;

KEYWORDS table_start_keys[] =
   {
    KEYWORD_ENTRY("Bitfields "),
    KEYWORD_ENTRY("Call "),
    KEYWORD_ENTRY("Format "),
    KEYWORD_ENTRY("Values "),
   } ;

/***********************************************/

#ifdef isxdigit
#undef NEED_ISXDIGIT
#endif

#ifdef NEED_STRNICMP
#ifdef PROTOTYPES
int strnicmp(char *s1,char *s2,unsigned int len) ;
#endif
int strnicmp(s1,s2,len)
char *s1,*s2 ;
unsigned int len ;
{
   char c1, c2 ;

   while (*s1 && *s2 && len > 0)
      {
      len-- ;
      c1 = (islower(*s1) ? toupper(*s1) : *s1) ;
      c2 = (islower(*s2) ? toupper(*s2) : *s2) ;
      if (c1 != c2 || len == 0)	 /* mismatch or substrings exhausted? */
	 return (c1 - c2) ;
      s1++ ;
      s2++ ;
      }
   return 0 ;  /* strings match exactly on first 'len' characters */
}
#endif /* NEED_STRNICMP */

#ifdef NEED_STRUPR
#ifdef PROTOTYPES
char *strupr(char *s) ;
#endif
char *strupr(s)
char *s ;
{
   char *orig_s = s ;
   char c ;
   
   if (s)
      while (*s)
	 {
	 c = *s ;      
	 *s++ = (islower(c) ? toupper(c) : c) ;
	 }
   return orig_s ;
}
#endif /* NEED_STRUPR */

#ifdef NEED_ISXDIGIT
#ifdef PROTOTYPES
int isxdigit(int c) ;
#endif
int isxdigit(c)
int c ;
{
   return isdigit(c) || (memchr("ABCDEFabcdef",c,12) != NULL) ;
}
#endif /* NEED_ISXDIGIT */

#ifdef NEED_ITOA
#ifdef PROTOTYPES
char *itoa(int num,char *buf,int radix) ;
#endif
char *itoa(num,buf,radix)   /* not everybody has the same itoa() as TurboC */
int num ;		    /* minimal implementation */
char *buf ;
int radix ;
{
   int count = 0 ;
   int i ;
   char tmp ;

   do {
      buf[count++] = "0123456789ABCDEF"[num % radix] ;
      num /= radix ;
   } while (num) ;
   buf[count] = '\0' ;
   if (count > 1)
      for (i = 0 ; i < count / 2 ; i++)
	 {
	 tmp = buf[i] ;
	 buf[i] = buf[count-i-1] ;
	 buf[count-i-1] = tmp ;
	 }
   return buf ;
}
#endif /* NEED_ITOA */

#ifdef NEED_ULTOA
#ifdef PROTOTYPES
char *ultoa(unsigned long num,char *buf,int radix) ;
#endif
char *ultoa(num,buf,radix)   /* not everybody has the same ultoa() as TurboC */
unsigned long num ;	     /* minimal implementation */
char *buf ;
int radix ;
{
   int count = 0 ;
   int i ; 
   char tmp ;

   do {
      buf[count++] = "0123456789ABCDEF"[num % radix] ;
      num /= radix ;
   } while (num) ;
   buf[count] = '\0' ;
   if (count > 1)
      for (i = 0 ; i < count / 2 ; i++)
	 {
	 tmp = buf[i] ;
	 buf[i] = buf[count-i-1] ;
	 buf[count-i-1] = tmp ;
	 }
   return buf ;
}
#endif /* NEED_ULTOA */

/***********************************************/

void usage()
{
   ip_putlit("\
Usage: intprint [options] intlist [>|>>]output\r\n\
Options:\r\n\
Filtering:\t-Ffile\tprint only entries matching filtering info in 'file'\r\n\
\t\t-k\tkeep original divider lines\r\n\
\t\t-rN:M\tprint only pages N through M\r\n\
\t\t-x\tinclude Index: lines in formatted output\r\n\
Formatting:\t-b\tboldface headings\t-B\tbold with control codes\r\n\
\t\t-d\t(duplex) print even/odd pages with different indents\r\n\
\t\t-e\t(elite) 96 chars/line\t-tN\tselect typeface N\r\n\
Pagination:\t-H\tadd page headers\t-iN\tindent N spaces\r\n\
\t\t-p\tnumber pages\t\t-nN\tN pages already printed\r\n\
\t\t-wN\twidow lines control\r\n\
\t\t-lN\tprint length\t\t-LN\ttotal page length\r\n\
\t\t\t(0 = infinite)\t(use linefeeds if > #lines printed)\r\n\
Printer:\t-I\tIBM graphics characters\r\n\
\t\t-Pname\tassume printer 'name'\t-P?\tlist printers\r\n\
Summaries:\t-ffile\tdata structure formats\t-sfile\tINT calls\r\n\
\t\t-Tfile\tlist tables\r\n\
Misc:\t\t-m\tprocess multiple parts\t-V\tmake INTERVUE summary\r\n\
"
	,err) ;
   ip_flush(err) ;
   exit(1) ;
}

/***********************************************/

void fatal(msg)
char *msg ;
{
   ip_putlit("UNRECOVERABLE ERROR:",err) ;
   newline(err) ;
   ip_puts(msg,err) ;
   newline(err) ;
   ip_flush(err) ;
   exit(1) ;
}

/***********************************************/

void warning(msg)
char *msg ;
{
   ip_putlit("Warning: ",err) ;
   ip_puts(msg,err) ;
   newline(err) ;
}

/***********************************************/

IP_FILE *ip_fdopen(fd,buf,bufsiz,maxsiz,write)
int fd ;
char *buf ;
int bufsiz, maxsiz, write ;
{
   IP_FILE *fp = (IP_FILE *)malloc(sizeof(IP_FILE)) ;
   
   if (fp)
      {
      fp->fd = fd ;
      fp->buf = buf ;
      fp->bufsize = bufsiz ;
      fp->buf_maxsize = maxsiz ;
      fp->bufpos = 0 ;
      fp->bufoffset = 0 ;
      fp->write = write ;
      }
   return fp ;
}

/***********************************************/

IP_FILE *ip_open_write(name,trunc,buf,bufsiz)
char *name ;
char *buf ;
int trunc ;
int bufsiz ;
{
   int fd ;
   
   if (name && *name == '\0')
      fd = 1 ;	/* open stdout */
   else
      {
#ifdef __TURBOC__
      if (trunc)
	 fd = _creat(name,0) ;	 /* create with no attribute bits sets */
      else
	 fd = _open(name,O_WRONLY) ;
#else
      if (trunc) trunc = O_TRUNC ;
      fd = open(name,O_WRONLY|O_BINARY|O_CREAT|trunc,S_IREAD|S_IWRITE) ;
#endif
      if (fd == -1)
	 return 0 ;
      if (!trunc)
	 lseek(fd,0L,SEEK_END) ;
      }
   return ip_fdopen(fd,buf,bufsiz,bufsiz,1) ;
}

/***********************************************/

IP_FILE *ip_open_read(name,buf,bufsiz)
char *name ;
char *buf ;
int bufsiz ;
{
   int fd, siz ;

#ifdef __TURBOC__
   if ((fd = _open(name,O_RDONLY)) != -1)
#else
   if ((fd = open(name,O_RDONLY | O_BINARY,0)) != -1)
#endif
      {
      siz = read(fd,buf,bufsiz) ;
      if (siz == -1)
	 return 0 ;
      return ip_fdopen(fd,buf,siz,bufsiz,0) ;
      }
   else
      return 0 ;
}

/***********************************************/

int ip_flush(fp)
IP_FILE *fp ;
{
   if (fp->write && fp->bufpos)
      {
      if (fp->bufpos > fp->buf_maxsize)
	 fp->bufpos = fp->buf_maxsize ;
      if (write(fp->fd,fp->buf,fp->bufpos) == -1)
	 return -1 ;
      fp->bufpos = 0 ;
      }
   return 0 ;
}

/***********************************************/

int ip_close(fp)
IP_FILE *fp ;
{
   if (ip_flush(fp) == -1 || close(fp->fd) == -1)
      return -1 ;
   free(fp) ;
   return 0 ;
}

/***********************************************/

unsigned long ip_fgets(buf, max, fp)
char *buf ;
int max ;
IP_FILE *fp ;
{
   unsigned long line_offset = fp->bufoffset + fp->bufpos ;
   char *end ;
   int len ;
   int new_bufpos ;
   char *fpbuf = fp->buf ;
   int bufpos = fp->bufpos ;
   
   --max ;
   if (bufpos + max < fp->bufsize)
      {
      end = (char *)memchr(fpbuf+bufpos,LINE_TERMINATOR,max) ;
      if (end)
	 {
	 new_bufpos = (end-fpbuf) ;
	 len = new_bufpos++ - bufpos ;
	 /* eradicate rest of multi-character line terminator */
	 while (len > 0 && fpbuf[bufpos+len-1] <= ' ')
	    len-- ;
	 }
      else
	 {
	 len = max ;
	 new_bufpos = bufpos + len ;
	 }
      if (len)
	 memcpy(buf,fpbuf+bufpos,len) ;
      buf[len] = '\0' ;
      bufpos = new_bufpos ;
      }
   else
      {
      for (len = 1 ; len <= max ; len++)
	 {
	 *buf = fpbuf[bufpos++] ;
	 if (bufpos >= fp->bufsize)
	    {
	    if (fp->bufsize < fp->buf_maxsize)
	       {
	       fp->bufsize = bufpos = 0 ;
	       fpbuf[0] = '\0' ;  /* dummy value to ensure empty string */
	       }
	    else
	       {
	       fp->bufoffset += fp->buf_maxsize ;
	       fp->bufsize = read(fp->fd,fpbuf,fp->buf_maxsize) ;
	       bufpos = 0 ;
	       }
	    if (fp->bufsize <= 0)
	       {
	       line_offset = (unsigned long)-1 ; /* signal end of file */
	       if (*buf != LINE_TERMINATOR)
		  *buf++ = LINE_TERMINATOR;
	       break ;
	       }
	    }
	 if (*buf == LINE_TERMINATOR)
	    break ;
	 else
	    buf++ ;
	 }
      if (len > max)	   /* did we overflow before hitting EOL? */
	 *buf = '\0' ;	   /* if yes, plug in the terminator */
      else
	 /* eradicate rest of multi-character line terminator */
	 while (len-- > 0 && *buf <= ' ')
	    *buf-- = '\0' ;
      }
   fp->bufpos = bufpos ;
   return line_offset ;
}

/***********************************************/

int ip_write(buf, count, fp)
char *buf ;
int count ;
IP_FILE *fp ;
{
   if (fp->bufpos + count < fp->buf_maxsize)
      {
      memcpy(fp->buf+fp->bufpos,buf,count) ;
      fp->bufpos += count ;
      }
   else
      while (count > 0)
	 {
	 int partial = fp->buf_maxsize - fp->bufpos ;

	 if (count < partial)
	    partial = count ;
	 memcpy(fp->buf+fp->bufpos,buf,partial) ;
	 buf += partial ;
	 fp->bufpos += partial ;
	 count -= partial ;
	 if (fp->bufpos >= fp->buf_maxsize && ip_flush(fp) == -1)
	       return -1 ;
	 }
   return 0 ;
}

/***********************************************/

#define indent_line(fp) if(indent_string)ip_write(indent_string,indent_len,fp)

/***********************************************/

void indent_to(where,fp)
int where ;
IP_FILE *fp ;
{
   where += indent ;
   while (where >= 8)
      {
      ip_putc('\t',fp) ;
      where -= 8 ;
      }
   if (where)
      ip_write("        ",where,fp) ;
}

/***********************************************/

void put_line(fp,len)
IP_FILE *fp ;
int len ;
{
   static char line[8] = { 196, 196, 196, 196, 196, 196, 196, 196 } ;

   if (IBM_chars)
      {
      while (len >= 8)
	 {
	 ip_write(line,8,fp) ;
	 len -= 8 ;
	 }
      if (len)
	 ip_write(line,len,fp) ;
      }
   else
      {
      while (len >= 8)
	 {
	 ip_write("--------",8,fp) ;
	 len -= 8 ;
	 }
      if (len)
	 ip_write("--------",len,fp) ;
      }
}

/***********************************************/

void HPPCL_put_line(fp,len)
IP_FILE *fp ;
int len ;
{
   ip_putlit(HPPCL_IBM_LN_A,fp) ;
   ip_puts(itoa((len * 25), num, 10),fp) ;
   ip_putlit(HPPCL_IBM_LN_B,fp) ;
}

/***********************************************/

void HPPCL_set_typeface(fp,typeface)
IP_FILE *fp ;
char *typeface ;
{
   ip_putlit(HPPCL_FONT_ON_A,fp) ;
   if (typeface)
      ip_puts(typeface,fp) ;
   else
      ip_putlit("8",fp) ;
   ip_putlit(HPPCL_FONT_ON_B,fp) ;
}

/***********************************************/

int start_of_entry(s)
char *s ;
{
   if (!*s || !isupper(*s))
      return 0 ;
   return memcmp(s,"INT ",4) == 0 ||
	  memcmp(s,"PORT ",5) == 0 ||
	  memcmp(s,"CMOS ",5) == 0 ||
	  memcmp(s,"MEM ",4) == 0 ||
	  memcmp(s,"I2C ",4) == 0 ||
	  memcmp(s,"CALL ",5) == 0 ||
	  memcmp(s,"OPCODE ",7) == 0 ||
	  memcmp(s,"MSR ",4) == 0 ;
}

/***********************************************/

int is_keyword(s,keys,numkeys)
char *s ;
KEYWORDS *keys ;
unsigned int numkeys ;
{
   register int cmp ;
   register unsigned int i ;
   KEYWORDS *currkey ;
   int firstchar = *s ;

   do {
      i = numkeys / 2 ;
      currkey = &keys[i] ;
      cmp = (firstchar - currkey->name[0]) ;
      if (cmp == 0)
         cmp = memcmp(s,currkey->name,currkey->length) ;
      if (cmp < 0)
	 numkeys = i ;
      else if (cmp > 0)
	 {
	 keys = currkey+1 ;
	 numkeys -= i+1 ;
	 }
      else
	 return TRUE ;
      } while (numkeys) ;
   return FALSE ;
}

/***********************************************/

void output_line(line,fp)
char *line ;
IP_FILE *fp ;
{
   if (*line)
      {
      int pos = 0 ;
      int len = strlen(line) ;
      
      indent_line(fp) ;
      if (boldface)
	 {
	 if (start_of_entry(line) || start_of_table(line))
	    {
	    if (printer_bold)
	       {
	       ip_putcstr(&printer->bold_on,fp) ;
	       ip_write(line,len,fp) ;
	       ip_putcstr(&printer->bold_off,fp) ;
	       newline(fp) ;
	       return ;
	       }
	    else
	       {
	       ip_write(line,len,fp) ;
	       ip_putc('\r',fp) ;
	       indent_line(fp) ;
	       }
	    }
	 else if (section_start(line))
	    {
	    pos = (char *)memchr(line,':',len) - line ;
	    if (printer_bold)
	       {
	       ip_putcstr(&printer->bold_on,fp) ;
	       ip_write(line,pos,fp) ;
	       ip_putcstr(&printer->bold_off,fp) ;
	       line += pos ;	   /* adjust because no longer at left edge */
	       len -= pos ;
	       }
	    else
	       {
	       ip_write(line,pos,fp) ;
	       ip_putc('\r',fp) ;
	       indent_line(fp) ;
	       }
	    }
	 } /* boldface */
      if (indent & 7)  /* indenting by other than a multiple of 8 ? */
	 {
	 while (*line)
	    {
	    if (*line == '\t')
	       {
	       ip_write("        ",8-(pos&7),fp) ;
	       pos = 0 ;   /* absolute column doesn't matter, only mod 8 */
	       }
	    else
	       {
	       ip_putc(*line,fp) ;
	       pos++ ;
	       }
	    line++ ;
	    }
	 }
      else
	 ip_write(line,len,fp) ;
      }
   newline(fp) ;
}

/***********************************************/

void get_raw_line(buf)
char *buf ;
{
   static char progress_indicator[] = "ii\r";
   IP_FILE *in ;

   buf[0] = '\0' ;
   if (out_of_files)
      return ;
   current_line_offset = ip_fgets(buf,MAXLINE,infile) ;
   if (current_line_offset == (unsigned long)-1)
      if (multi_file)
	 {
	 offset_adjust += lseek(infile->fd,0L,SEEK_END) ;
	 input_file[input_file_namelen-1]++ ;
	 ip_close(infile) ;
	 if ((in = ip_open_read(input_file,infile_buf,sizeof(infile_buf)))
		   != NULL)
	    {
	    infile = in ;
	    current_line_offset = ip_fgets(buf,MAXLINE,infile) ;
	    }
	 else
	    {
	    out_of_files = TRUE ;
	    return ;
	    }
	 }
      else
	 out_of_files = TRUE ;
   if (start_of_entry(buf) && ((short*)buf)[2] != ((short*)progress_indicator)[0])
      {
      ((short*)progress_indicator)[0] = ((short*)buf)[2] ;
      ip_putlit(progress_indicator, err) ;
      }
}

/***********************************************/

int unwanted_section(buf)
char *buf ;
{
   char str[MAXLINE] ;
   FILT_LIST *p ;

   strcpy(str,buf) ;
   (void) strupr(str) ;
   if (strchr(cf_buffers[CF_EXCLUDE], cf_current_category))
      return TRUE ; /* section is not wanted */
   if (exclude_only)
      goto test_exclude ;
      /* include the section unless it is header-excluded */
   if (strchr(cf_buffers[CF_UNCONDITIONAL], cf_current_category))
      return FALSE ; /* section is unconditionally wanted */
   if (strchr(cf_buffers[CF_INCLUDE], cf_current_category))
      goto test_exclude ; /* section is wanted if not header-excluded */
   /* section may be wanted if an include string matches */
   for (p = includes ; p ; p = p->next)
      if (p->str && strstr(str, p->str) != NULL)
	 goto test_exclude ;
   return TRUE ; /* no include match, the entry is not wanted */
test_exclude:
   if (strchr(cf_buffers[CF_OVERRIDE], cf_current_category))
      return FALSE ; /* overriding header exclutions, section wanted */
   /* if wanted here, set to TRUE if *any* exclude string matches */
   for (p = excludes ; p ; p = p->next)
      if (p->str && strstr(str, p->str) != NULL)
	 return TRUE ;
   return FALSE ; /* not excluded, the section is wanted */
}

/***********************************************/

void get_line(buf)
char *buf ;
{
   static char next_line[MAXLINE] ;
   static int readahead = FALSE ;

   /* get the next line from the file, skipping unwanted entries */
   if (readahead)
      {
      strcpy(buf,next_line) ;
      readahead = FALSE ;
      }
   else
      {
      do {
	 get_raw_line(buf) ;
	 } while (!include_index_lines && index_line(buf)) ;
      if (section_file_start(buf))
	 do {
	    get_raw_line(buf) ;
	    } while (!divider_line(buf)) ;
      if (do_filter && divider_line(buf))
	 {
	 /* if we read a divider line while filtering, we have to look ahead */
	 strcpy(next_line,buf);
	 while (divider_line(next_line))
	    {
	    strcpy(buf,next_line) ; /* we may be returning the divider */
	    get_raw_line(next_line) ;
	    if (start_of_entry(next_line)) /* is it an interrupt entry? */
	       {
	       cf_current_category = buf[8]; /* save the category character */
	       if (unwanted_section(next_line))
	          {
	          while (!divider_line(next_line))
		     get_raw_line(next_line) ;
	          }
	       else /* section is wanted, so return divider and then next line */
	          readahead = TRUE ;
	       }
	    else
	       readahead = TRUE ;
	    }
	 }
      }
}

/***********************************************/

void fill_buffer(lines,lines_per_page)
int lines, lines_per_page ;
{
   int i ;

   /* copy remainder, if any, from last page to top of current page */
   if (lines)
      for (i = lines ; i < lines_per_page ; i++)
	 {
	 strcpy(buffer[i-lines], buffer[i]) ;
	 line_offsets[i-lines] = line_offsets[i] ;
	 }
   else
      lines = lines_per_page ;
   for (i = lines_per_page - lines ; i < lines_per_page ; i++)
      {
      get_line(buffer[i]) ;
      line_offsets[i] = current_line_offset + offset_adjust ;
      }
}

/***********************************************/

int find_page_break(lines)
int lines ;
{
   int i ;
   char *buf ;

   for (i = 0 ; i < widow_length ; i++)
      {
      buf = buffer[lines-i-1] ;
      if (buf[0] == '\0' || divider_line(buf))
	 return lines - i ;
      else if (section_start(buf))
	 return lines - i - 1 ;
      }
   return lines ;
}

/***********************************************/

int summarize(line, pages_printed)
int line, pages_printed ;
{
   char *s, reg ;
   int i ;
   int max_descrip ;
   int len, numlen ;
   int is_INT_entry = 0 ;
   
   s = buffer[line] ;
   if (start_of_entry(s))
      {
      memcpy(summary_line," -- -- -- ",10) ;
      if (s[0] == 'I' && s[1] == 'N')
	 is_INT_entry = 1 ;
      if (is_INT_entry)
	 {
	 summary_line[1] = s[4] ;	 /* output interrupt number */
	 summary_line[2] = s[5] ;
	 len = 4 ;
	 s = buffer[line+1] ;
	 while (*s && isspace(*s))
	    s++ ;
	 if (*s == 'A')
	    {
	    reg = s[1] ;
	    while (*s && *s != '=')
	       s++ ;
	    s++ ;		/* skip the equal sign */
	    while (*s && isspace(*s))
	       s++ ;	/* skip the space between equal sign and number */
	    if (isxdigit(*s) && isxdigit(s[1]))
	       {
	       if (reg == 'L')
		  len += 3 ;
	       summary_line[len++] = *s++ ;
	       summary_line[len++] = *s++ ;
	       if (reg == 'X')
		  {
		  len++ ;
		  summary_line[len++] = *s++ ;
		  summary_line[len] = *s ;
		  }
	       }
	    }
	 }
      else if (s[0] == 'C' && s[1] == 'M')
	 {
	 summary_line[1] = s[5] ;
	 summary_line[2] = s[6] ;
	 }
      else if (s[0] == 'M' && s[1] == 'E')
	 {
	 memcpy(summary_line+1,s+4,4) ;
	 if (s[8] == 'h' && s[9] == ':')
	    memcpy(summary_line+5,s+10,4) ;
	 else
	    memcpy(summary_line+5,s+8,4) ;
	 }
      else if (s[0] == 'I' && s[1] == '2')
	 {
	 summary_line[1] = s[4] ;	/* output bus address */
	 summary_line[2] = s[5] ;
	 if (s[7] == '/')
	    {
	    summary_line[4] = s[8] ;
	    summary_line[5] = s[9] ;
	    if (s[10] != 'h')
	       {
	       summary_line[7] = s[10] ;
	       summary_line[8] = s[11] ;
	       }
	    else if (s[11] == '/')
	       {
	       summary_line[7] = s[12] ;
	       summary_line[8] = s[13] ;
	       }
	    }
	 }
      len = 10 ;
      if (page_numbers)
	 {
	 itoa(pages_printed,num,10) ;
	 numlen = strlen(num) ;
	 for (i = numlen ; i < 3 ; i++)
	    summary_line[len++] = ' ' ;
	 memcpy(summary_line+len,num,numlen) ;
	 len += numlen ;
	 summary_line[len++] = ' ' ;
	 }
      s = buffer[line] + 7 ;	/* find function description */
      if (!is_INT_entry)
	 {
	 while (*s && !isspace(*s))
	    s++ ;
	 s++ ;
	 }
      if (*s && *s != '-')	/* does the heading contain flags? */
	 {
	 while (*s && !isspace(*s))
	    summary_line[len++] = *s++ ;
	 summary_line[len++] = '>' ;
	 summary_line[len++] = ' ' ;
	 while (*s && *s != '-')
	    s++ ;
	 }
      while (*s && !isspace(*s))
	 s++ ;
      while (*s && isspace(*s))
	 s++ ;
      max_descrip = (page_width > sizeof(summary_line)-1)
		    ? sizeof(summary_line)-1
		    : page_width ;
      while (len < max_descrip && *s)
	 summary_line[len++] = *s++ ;
      summary_line[len] = '\0' ;
      summary_line_len = len ;
      return 1 ;
      }
   else
      return 0 ;
}

/***********************************************/

void start_format(line)
char *line ;
{
   indent_line(formats) ;
   (*printer->put_line)(formats,79) ;
   newline(formats) ;
   indent_line(formats) ;
   ip_puts(summary_line,formats) ;
   newline(formats) ;
   indent_line(formats) ;
   ip_putc('\t',formats) ;
   ip_puts(line+10,formats) ;
   newline(formats) ;
   echo_format = TRUE ;
}

/***********************************************/

void show_offset(line,fp)
int line ;
IP_FILE *fp ;
{
   char offset_string[12] ;
   int len ;
   
   ultoa(line_offsets[line],offset_string,16) ;
   len = strlen(offset_string) ;
   ip_write("00000000",8-len,fp) ;
   ip_write(offset_string,len,fp) ;
}

/***********************************************/

void add_table(i)
int i ;
{
   char firstchar ;
   char num[6] ;
   char *end ;
   int len ;
   int summary_width ;
   int offset = 0 ;
   char found = FALSE ;

   prev_table++ ;
   firstchar = buffer[i][0] ;
   if (firstchar == 'C' || firstchar == 'V')  /* Call.. or Values... ? */
      {
      if (i > 0 && buffer[i-1][0] == '(')
	 {
	 memcpy(num,buffer[i-1]+7,5) ;
	 if (isdigit(num[4]))
	    len = 5 ;
	 else
	    len = 4 ;
	 num[len] = '\0' ;
	 found = TRUE ;
	 if (firstchar == 'V') offset = 11 ;
	 }
      }
   else if (firstchar == 'B' || firstchar == 'F') /* Bitfields.. or Format..? */
      {
      end = strrchr(buffer[i+1]+7,'(') ;   /* rule out Bit(s) as only match */
      if (end)
	 {
	 memcpy(num,end+7,5) ;
	 if (isdigit(num[4]))
	    len = 5 ;
	 else
	    len = 4 ;
	 num[len] = '\0' ;
	 found = TRUE ;
	 if (firstchar == 'B')
	    offset = 14 ;
	 else
	    offset = 10 ;
	 }
      }
   if (!found)
      {
      itoa(prev_table,num,10) ;
      len = strlen(num) ;
      }
   indent_line(tables) ;
   if (show_offsets)
      show_offset(i,tables) ;
   ip_write("  0000",6-len,tables) ;
   ip_write(num,len,tables);
   if (page_numbers)
      {
      summary_width = 13 ;
      while (summary_line[summary_width] != ' ')
	 summary_width++ ;
      summary_width++ ;	/* include the blank we found */
      }
   else
      summary_width = 10 ;
   ip_write(summary_line,summary_width,tables) ;
   len = strlen(buffer[i]+offset)-1 ;
   if (len > page_width - summary_width - 5)
      len = page_width - summary_width - 5 ;
   if (len > 0)
      ip_write(buffer[i]+offset,len,tables) ;
   newline(tables) ;
}

/***********************************************/

int make_description(desc,type,line)
char *desc, *type ;
int line ;
{
   char *start = desc ;
   
   summarize(line,pages_printed) ;
   if (type)
      {
      int len = strlen(type) ;
      char *blank = strchr(type,' ') ;
      if (blank)
	 len = blank - type + 1 ;
      memcpy(desc,type,len) ;
      desc += len ;
      }
   else
      {
      memcpy(desc,"INT ", 4) ;
      desc += 4 ;
      }
   *desc++ = summary_line[1] ;
   *desc++ = summary_line[2] ;
   if (summary_line[4] != '-')
      {
      memcpy(desc,", AH=", 5) ;
      desc += 5 ;
      *desc++ = summary_line[4] ;
      *desc++ = summary_line[5] ;
      }
   if (summary_line[7] != '-')
      {
      memcpy(desc,", AL=", 5) ;
      desc += 5 ;
      *desc++ = summary_line[7] ;
      *desc++ = summary_line[8] ;
      }
   *desc = '\0' ;
   return (desc-start)+1 ;
}

/***********************************************/

char *determine_heading(last)
int last ;
{
   int i ;
   static char heading[MAXLINE] ;
   char save[25] ;
   char num[10] ;

   /* ugly hack to keep the combination of -H and -T from showing wrong page */
   /* numbers for tables--copy last summary line from previous page to safe */
   /* place before processing current page, then restore it */
   memcpy(save,summary_line,sizeof(save)) ;
   if (start_of_entry(buffer[0]))
      {
      header_first.len = make_description(header_first.desc,buffer[0],0) ;
      header_first.part = 1 ;
      header_first.first_on_page = TRUE ;
      }
   else if (header_last.part == 0)  /* very first entry? */
      {
      for (i = 0 ; i < last ; i++)
	 if (start_of_entry(buffer[i]))
	    {
	    header_first.len = make_description(header_first.desc,buffer[i],i);
	    header_first.part = 1 ;
	    header_first.first_on_page = TRUE ;
	    break ;
	    }
      }
   else
      {
      header_first.len = header_last.len ;
      memcpy(header_first.desc,header_last.desc,header_last.len) ;
      header_first.part = header_last.part + 1 ;
      header_first.first_on_page = FALSE ;
      }
   /* assume entry spans entire page */
   header_last.len = header_first.len ;
   memcpy(header_last.desc,header_first.desc,header_first.len) ;
   header_last.part = header_first.part ;
   header_last.first_on_page = header_first.first_on_page ;
   /* find last entry on page */
   if (header_first.part > 0)
      {
      for (i = last-1 ; i > 0 ; i--)
	 if (start_of_entry(buffer[i]))
	    {
	    header_last.len = make_description(header_last.desc,buffer[i],i) ;
	    header_last.part = 1 ;
	    header_last.first_on_page = FALSE ;
	    break ;
	    }
      memcpy(heading,header_first.desc,header_first.len) ;
      if (header_first.part > 1)
	 {
	 strcat(heading," (Part ") ;
	 strcat(heading,itoa(header_first.part,num,10)) ;
	 strcat(heading,")") ;
	 }
      if (memcmp(header_first.desc,header_last.desc,header_last.len) != 0 ||
	  header_first.part != header_last.part)
	 {
	 strcat(heading," to ") ;
	 strcat(heading,header_last.desc) ;
	 if (header_last.part > 1)
	    {
	    strcat(heading," (Part ") ;
	    strcat(heading,itoa(header_last.part,num,10)) ;
	    strcat(heading,")") ;
	    }
	 }
      memcpy(summary_line,save,sizeof(save)) ;
      return heading ; 
      }
   else /* no headings yet */
      {
      memcpy(summary_line,save,sizeof(save)) ;
      return NULL ;
      }
}

/***********************************************/

void print_buffer(last,body_lines,lines_per_page,total_lines,use_FF)
int last, body_lines, lines_per_page, total_lines ;
int use_FF ;
{
   int i, len ;
   int headpos ;
   int print_this_page = (pages_printed>=first_page && pages_printed<=last_page);
   
   pages_printed++ ;
   if (do_headers)
      {
      char *heading ;
      
      if ((heading = determine_heading(last)) != NULL)
	 {
	 if (print_this_page)
	    {
	    len = strlen(heading) ;
	    headpos = 40-len/2 ;
	    indent_to(headpos,outfile) ;
	    if (boldface)
	       {
	       if (printer_bold)
		  {
		  ip_putcstr(&printer->bold_on,outfile) ;
		  ip_write(heading,len,outfile) ;
		  ip_putcstr(&printer->bold_off,outfile) ;
		  }
	       else
		  {
		  ip_write(heading,len,outfile) ;
		  ip_putc('\r',outfile) ;
		  indent_to(headpos,outfile) ;
		  ip_write(heading,len,outfile) ;
		  }
	       }
	    else
	       ip_write(heading,len,outfile) ;
	    }
	 }
      newline(outfile) ;
      newline(outfile) ;
      }
   for (i = 0 ; i < last ; i++)
      {
      if (print_this_page)
	 {
	 char *line = buffer[i] ;
	 if (*line)
	    {
	    if (!keep_divider_lines && divider_line(line))
	       {
	       indent_line(outfile) ;
	       (*printer->put_line)(outfile,79) ;
	       newline(outfile) ;
	       echo_format = FALSE ;
	       }
	    else
	       {
	       output_line(line, outfile) ;
	       if (echo_format)
		  output_line(line,formats) ;
	       }
	    }
	 else
	    {
	    newline(outfile) ;
	    echo_format = FALSE ;
	    }
	 }
      /* need summary lines if doing summary, formats, or table index */
      if (need_summary)
	 {
	 if (summarize(i,pages_printed) && do_summary && summary)
	    {
	    if (show_offsets)
	       show_offset(i,summary) ;
	    ip_write(summary_line,summary_line_len,summary) ;
	    newline(summary) ;
	    }
	 if (do_formats && memcmp(buffer[i],"Format ",7) == 0)
	    start_format(buffer[i]) ;
	 if (do_tables && start_of_table(buffer[i]))
	    add_table(i) ;
	 }
      }
   if (print_this_page)
      {
      if (page_numbers)
	 {
	 for (i = last ; i <= body_lines ; i++)
	    newline(outfile) ;
	 itoa(pages_printed, num, 10) ;
	 i = strlen(num) ;
	 if (!duplex)
	    indent_to(38-i/2,outfile) ;
	 else if (pages_printed & 1)	    /* odd-numbered page? */
	    indent_to(75-i/2,outfile) ;
	 else
	    indent_to(2,outfile) ;
	 ip_putlit("- ", outfile) ;
	 ip_write(num, i, outfile) ;
	 ip_putlit(" -", outfile) ;
	 newline(outfile) ;
	 }
      if (use_FF)
	 ip_putc('\f',outfile) ;
      else
	 for (i = page_numbers?lines_per_page:last ; i<total_lines ; i++)
	    newline(outfile) ;
      if (duplex)
	 {
	 if (pages_printed & 1)	       /* next page even or odd? */
	    ip_putcstr(&printer->marginl, outfile) ;	/* even page */
	 else
	    ip_putcstr(&printer->marginr, outfile) ;	/* odd page */
	 }
      }
}

/***********************************************/

void display_printers()
{
   int i ;
   
   ip_putlit("Valid printer names are:",err) ;
   newline(err) ;
   for (i = 0 ; i < NUM_PRINTERS ; i++)
      {
      ip_putc('\t',err) ;
      ip_puts(printers[i].name,err) ;
      newline(err) ;
      }
   ip_putlit("When entering the printer name, use either a dash or an",err) ;
   newline(err) ;
   ip_putlit("underscore in place of blanks.  Case is ignored, and the",err) ;
   newline(err) ;
   ip_putlit("name may be abbreviated to the shortest unique prefix.",err) ;
   newline(err) ;
   exit(1) ;
}

/***********************************************/

void select_printer(name)
char *name ;
{
   int i, len, prt = -1 ;
   
   len = strlen(name) ;
   for (i = 0 ; i < len ; i++)		/* convert dashes and underscores to blanks */
      if (name[i] == '-' || name[i] == '_')
	 name[i] = ' ' ;
   for (i = 0 ; i < NUM_PRINTERS ; i++)
      if (strnicmp(name,printers[i].name,len) == 0)
	 if (prt == -1)
	    prt = i ;
	 else
	    fatal("Ambiguous printer name!  Use -P? to list printers.") ;
   if (prt == -1)
      fatal("Unknown printer name!  Use -P? to list printers.") ;
   else
      printer = &printers[prt] ;
}

/***********************************************/

void add_category_filter_info(filter, str)
CF_ENUM filter ;
char *str ;
/* insert category filter characters into proper buffer, provided they do
   not appear in other filter buffers
*/
{
   static char err_msg[] =
    "Character \"x\" appears in more than one category filter string";
#define err_char_pos 11 /* position of x in err_msg */
   CF_ENUM f ;
   int i = 0, len = strlen(cf_buffers[filter]) ;
   char c, errmsg[80] ;

   while ((c = str[i++]) > ' ' && len < CF_BUFFER_SIZE)
      {
      for (f = filter; ; )
	 {
	 if ((f = (f + 1) % CF_ENUM_SIZE) == filter)
	   break; /* all other filters checked */
	 if (strchr(cf_buffers[f], c))
	    {
	    err_msg[err_char_pos] = c ;
	    fatal(err_msg) ;
	    }
	 }
	 cf_buffers[filter][len++] = c;
      }
#undef err_char_pos
}

/***********************************************/

FILT_LIST *add_filter_info(list,str)
FILT_LIST *list ;
char *str ;
{
   FILT_LIST *newfilt ;
   int len = strlen(str)+1 ;
   
   if ((newfilt = (FILT_LIST *)malloc(sizeof(struct filter_list)+len))
	  != NULL)
      {
      newfilt->next = list ;
      memcpy(newfilt->str,str,len) ;
      strupr(newfilt->str) ;
      }
   else
      fatal("out of memory") ;
   return newfilt ;
}

/***********************************************/

void build_filter_lists(file)
char *file ;
{
   static char err_msg[] = "Unknown command \"x\" in filter file";
#define err_char_pos 17 /* position of x in err_msg */
   IP_FILE *fp ;
   char buf[MAXLINE] ;
   int len ;
   long result ;

   if ((fp = ip_open_read(file,filter_buf,sizeof(filter_buf))) == NULL)
      {
      warning("unable to open filtering file, will print entire list.") ;
      do_filter = FALSE ;
      }
   else /* OK, file is open, so start reading */
      {
      do {
	 buf[0] = '\0' ;
	 result = ip_fgets(buf, sizeof(buf), fp) ;
	 len = strlen(buf) ;
	 if (len > 1)
	    {
	    switch (buf[0])
	       {
	       case '+':
		  includes = add_filter_info(includes,buf+1) ;
		  goto include_too ;
	       case '-':
		  excludes = add_filter_info(excludes,buf+1) ;
		  break ;
		   case CF_EXCLUDE_CHAR:
		  add_category_filter_info(CF_EXCLUDE, buf+1) ;
		  break ;
		   case CF_UNCONDITIONAL_CHAR:
		  add_category_filter_info(CF_UNCONDITIONAL, buf+1) ;
		  goto include_too ;
		   case CF_INCLUDE_CHAR:
		  add_category_filter_info(CF_INCLUDE, buf+1) ;
		  goto include_too ;
		   case CF_OVERRIDE_CHAR:
		  add_category_filter_info(CF_OVERRIDE, buf+1) ;
		  break ;
		   case '#':		/* comment lines */
		  break ;
		   default:
		  err_msg[err_char_pos] = buf[0] ;
		  fatal(err_msg) ;
	 include_too:
		  exclude_only = FALSE;
	       }
	    }
	 } while (result != -1) ;
      ip_close(fp) ;
      do_filter = TRUE ;
      }
#undef err_char_pos
}

/***********************************************/

void write_summary_header(fp,title,show_offsets,show_table)
IP_FILE *fp ;
char *title ;
int show_offsets, show_table ;
{
   /* set up the printer */
   ip_putcstr(&printer->init1,fp) ;
   ip_putcstr(&printer->init2,fp) ;
   ip_putcstr(&printer->marginc,fp) ;
   /* now start writing the actual header */
   indent_to(show_offsets?8:0,fp) ;
   ip_putlit("\t\t\t\t",fp) ;
   ip_puts(title,fp) ;
   newline(fp) ;
   indent_to(show_offsets?8:0,fp) ;
   ip_putlit("\t\t\t\t",fp) ;
   (*printer->put_line)(fp,strlen(title)) ;
   newline(fp) ;
   newline(fp) ;
   indent_line(fp) ;
   if (show_offsets)
      ip_putlit("Offset  ", fp) ;
   if (show_table)
      ip_putlit("Table ",fp) ;
   ip_putlit("INT AH AL", fp) ;
   if (page_numbers)
      ip_putlit(" Page", fp) ;
   ip_putlit("\t\t\tDescription", fp) ;
   newline(fp) ;
   indent_line(fp) ;
   (*printer->put_line)(fp,page_width+(show_offsets?8:0)) ;
   newline(fp) ;
}

/***********************************************/

static void reset_printer_and_close(fp)
IP_FILE *fp ;
{
   ip_putcstr(&printer->term1,fp) ;
   ip_putcstr(&printer->term2,fp) ;
   ip_close(fp) ;
}

/***********************************************/

int _Cdecl main(argc,argv)
int argc ;
char *argv[] ;
{
   int lines_per_page = -1 ;
   int total_lines = -1 ;
   int use_FF = TRUE ;
   int last_line ;
   int body_lines ;
   char *typeface = NULL ;
   char *summary_file = NULL ;
   char *table_file = NULL ;
   char *formats_file = NULL ;
   char *filter_file = NULL ;
   char *last_page_num ;

   err = ip_fdopen(2,stderr_buf,sizeof(stderr_buf),sizeof(stderr_buf),1) ;
   ip_putlit("INTPRINT v", err) ;
   ip_putlit(VERSION, err) ;
   ip_putlit(" by Ralf Brown and others.  Donated to the Public Domain.",err) ;
   newline(err) ;
   ip_flush(err) ;
   if (argc == 1 && isatty(0))
      usage() ;	  /* give help if invoked with no args and keybd input */
   while (argc >= 2 && argv[1][0] == '-')
      {
      switch (argv[1][1])
	 {
	 case 'B':
	    printer_bold = TRUE ;
	    /* fall through to -b */
	 case 'b':
	    boldface = TRUE ;
	    break ;
	 case 'd':
	    duplex = TRUE ;
	    break ;
	 case 'e':
	    indent = 8 ;
	    page_width = 87 ;  /* 96 - indent - 1 right margin */
	    break ;
	 case 'f':
	    formats_file = argv[1]+2 ;
	    break ;
	 case 'F':
	    filter_file = argv[1]+2 ;
	    break ;
	 case 'H':   /* page headers */
	    do_headers = TRUE ;
	    break ;
	 case 'i':
	    indent = atoi(argv[1]+2) ;
	    break ;
	 case 'I':
	    IBM_chars = TRUE ;
	    break ;
	 case 'k':
	    keep_divider_lines = TRUE ;
	    break ;
	 case 'l':
	    lines_per_page = atoi(argv[1]+2) ;
	    break ;
	 case 'L':
	    total_lines = atoi(argv[1]+2) ;
	    break ;
	 case 'm':
	    multi_file = TRUE ;
	    break ;
	 case 'n':
	    pages_printed = atoi(argv[1]+2) ;
	    break ;
	 case 'P':
	    if (argv[1][2] == '?')
	       display_printers() ;
	    else
	       select_printer(argv[1]+2) ;
	    break ;
	 case 'p':
	    page_numbers = TRUE ;
	    break ;
	 case 'r':
	    first_page = atoi(argv[1]+2) ;
	    last_page_num = strchr(argv[1]+2, ':') ;
	    last_page = last_page_num ? atoi(last_page_num+1) : 0 ;
	    if (last_page == 0)
	       last_page = ~0 ;
	    break ;
	 case 's':
	    summary_file = argv[1]+2 ;
	    break ;
	 case 't':
	    typeface = argv[1]+2 ;
	    break ;
	 case 'T':
	    table_file = argv[1]+2 ;
	    break ;
	 case 'V':
	    show_offsets = IBM_chars = TRUE ;
	    break ;
	 case 'w':
	    widow_length = atoi(argv[1]+2) ;
	    break ;
	 case 'x':
	    include_index_lines = TRUE ;
	    break ;
	 default:
	    usage() ;
	 }
      argv++ ;
      argc-- ;
      }
   if (printer == NULL)
      select_printer("default") ;
   /* apply any necessary overrides to parameters */
   if (printer->indent != -1)
      indent = printer->indent ;
   if (lines_per_page < 0)
      lines_per_page = printer->lines_per_page ;
   if (total_lines <= 0)
      total_lines = printer->page_length ;
   if (page_width <= 0)
      page_width = printer->page_width ;
   if (show_offsets && page_width < 80)
      page_width = 80 ;
   if (printer->flag)
      *(printer->flag) = TRUE ;
   if (cstrlen(&printer->bold_on) == 0)	 /* control sequences for bold? */
      printer_bold = FALSE ;		/* if not, don't try to use them */
   /* build the indent string */
   if (indent)
      {
      char *t ;
      int ind = indent ;

      indent_len = indent/8 + indent%8 ;
      t = indent_string = (char *)malloc(indent_len+1) ;
      while (ind >= 8)
	 {
	 *t++ = '\t' ;
	 ind -= 8 ;
	 }
      while (ind > 0)
	 {
	 *t++ = ' ' ;
	 ind-- ;
	 }
      }
   /* open the summary file, if any */
   if (summary_file && *summary_file)
      if ((summary = ip_open_write(summary_file,!pages_printed,summary_buf,
				   sizeof(summary_buf)))
		!= NULL)
	 do_summary = TRUE ;
      else
	 warning("unable to open summary file") ;
   /* open the table index file, if any */
   if (table_file && *table_file)
      if ((tables = ip_open_write(table_file,!pages_printed,tables_buf,
				  sizeof(tables_buf)))
		!= NULL)
	 do_tables = TRUE ;
      else
	 warning("unable to open table index file") ;
   /* open the data formats file, if any */
   if (formats_file && *formats_file)
      if ((formats = ip_open_write(formats_file,!pages_printed,formats_buf,
				   sizeof(formats_buf)))
		!= NULL)
	 do_formats = TRUE ;
      else
	 warning("unable to open formats file") ;
   need_summary = (do_summary || do_formats || do_tables) ;
   /* initialize filtering data, if specified */
   if (filter_file && *filter_file)
      build_filter_lists(filter_file) ;
   if (total_lines <= lines_per_page)
      {
      total_lines = lines_per_page ;
      use_FF = TRUE ;
      }
   else
      use_FF = FALSE ;
   if (argc == 2 || argc == 3)
      {
      input_file = argv[1] ;
      input_file_namelen = strlen(input_file) ;
      if ((infile = ip_open_read(input_file,infile_buf,sizeof(infile_buf))) == NULL)
	 fatal("unable to open input file") ;
      if (argc == 3)
	 {
	 outfile = ip_open_write(argv[2],!pages_printed,outfile_buf,
				 sizeof(outfile_buf)) ;
	 if (outfile == NULL)
	    fatal("unable to open output file") ;
	 }
      else
	 outfile = ip_open_write("",0,outfile_buf,sizeof(outfile_buf)) ;
      }
   else
      usage() ;
   if (lines_per_page > MAXPAGE)
      {
      ip_putlit("Surely you jest!  I can't handle pages that long.",err) ;
      newline(err) ;
      newline(err) ;
      usage() ;
      }
   else if (lines_per_page == 0) /* infinite page? */
      {
      widow_length = 0 ;
      if (total_lines <= 0)
	 total_lines = MAXPAGE ;
      lines_per_page = total_lines ;
      use_FF = do_headers = page_numbers = FALSE ;
      }
   else
      {
      if (lines_per_page < 20)
	 {
	 ip_putlit("Surely your printer can handle at least 20 lines per page!",
		   err) ;
	 newline(err) ;
	 ip_putlit("Adjusting page length....",err) ;
	 newline(err) ;
	 lines_per_page = 20 ;
	 }
      if (widow_length < 3 || widow_length > lines_per_page / 2)
	 {
	 ip_putlit("Widow lines (-w) must be set to at least 3 and at most one-half of the",err) ;
	 newline(err) ;
	 ip_putlit("page length.  Using default of 8 lines.",err) ;
	 newline(err) ;
	 widow_length = 8 ;
	 }
      }
   /* set up the printer */
   ip_putcstr(&printer->init1,outfile) ;
   ip_putcstr(&printer->init2,outfile) ;
   if (printer->set_typeface)
      (*printer->set_typeface)(outfile,typeface) ;
   if (duplex)
      {
      ip_putcstr(&printer->duplex_on,outfile) ;
      if (pages_printed & 1)		  /* next page odd or even? */
	 ip_putcstr(&printer->marginl,outfile) ;	/* even */
      else
	 ip_putcstr(&printer->marginr,outfile) ;	/* odd */
      }
   else
      ip_putcstr(&printer->marginc,outfile) ;	/* non-duplex, so center */
   /* start the auxiliary files if this is the first part processed */
   if (pages_printed == 0)
      {
      /* start the summary file */
      if (do_summary)
	 write_summary_header(summary,"Interrupt Summary",show_offsets,FALSE) ;
      /* start the table index file */
      if (do_tables)
	 write_summary_header(tables,"Table Summary",show_offsets,TRUE) ;
      /* start the data formats file */
      if (do_formats)
	 write_summary_header(formats,"Data Structure Formats",FALSE,FALSE) ;
      }
   if (page_numbers)
      body_lines = lines_per_page - 2 ;
   else
      body_lines = lines_per_page ;
   if (do_headers)
      body_lines -= 2 ;
   last_line = 0 ;
   while (!out_of_files)
      {
      fill_buffer(last_line,body_lines) ;
      last_line = find_page_break(body_lines) ;
      print_buffer(last_line,body_lines,lines_per_page,total_lines,use_FF) ;
      }
   if (last_line < body_lines)
      {
      int i ;
      
      for (i = last_line ; i < body_lines ; i++)
	 {
	 strcpy(buffer[i-last_line], buffer[i]) ;
	 line_offsets[i-last_line] = line_offsets[i] ;
	 }
      print_buffer(body_lines-last_line,body_lines,lines_per_page,total_lines,
		   use_FF) ;
      }
   ip_close(infile) ;
   /* reset the printer */
   reset_printer_and_close(outfile) ;
   ip_puts(itoa(pages_printed, num, 10), err) ;
   ip_putlit(" pages", err) ;
   if (do_summary)
      reset_printer_and_close(summary) ;
   if (do_tables)
      {
      ip_putlit(", ", err) ;
      ip_puts(itoa(prev_table, num, 10), err) ;
      ip_putlit(" tables", err) ;
      reset_printer_and_close(tables) ;
      }
   if (do_formats)
      reset_printer_and_close(formats) ;
   newline(err) ;
   ip_close(err) ;
   return 0 ;
}
