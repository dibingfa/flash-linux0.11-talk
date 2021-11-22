/*
 * File:	int.c
 *
 * Synopsis:	PC interrupt caller, memory R/W, I/O port R/W
 *
 * System:	MSDOS - Turbo C or Borland C (other compilers need some work)
 *
 * A utility for PC systems programmers to:
 *	- perform and visualise the results of interrupt calls
 *	- use buffers (inc files) to set register pairs
 *	- view the interrupt vector table
 *	- read & write I/O ports
 *
 * NB: This utility must be used with EXTREME CARE. Using bad interrupt and/or
 * I/O calls can destroy data on your memory/disk(s) and might crash your
 * machine.
 *
 * Compatible with int.c ditributed with Ralf Brown's interrupt lists
 * Comments/suggestions welcome on the email address below.
 *
 *
 * Copyright (c) 1992-1994 Angelo Haritsis <ah@doc.ic.ac.uk>
 *
 * Redistribution and use in source and binary forms are permitted provided
 * that the above copyright notice and this paragraph are duplicated in all
 * such forms and that any documentation, advertising materials, and other
 * materials related to such distribution and use acknowledge that the
 * software was developed by Angelo Haritsis.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 * TODO:
 * > -fbuf filename (write mem with vals from a file)
 */

#ifndef lint
static char rcsid[] = "$Header: E:/SRC/MISC\RCS\int.c 1.2 1994/04/11 20:11:36 ah Exp ah $";
#endif

#include <stdio.h>
#include <io.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>
#include <dos.h>

#define PROG "int"
#define VERSION "1.0"
#define NOTREACHED 0


#define PARSE_JUSTARGS	0x01
#define PARSE_NOACTION	0x02

/*
 * Types
 */
typedef int (*fun_ptr) (char **, int *);

typedef struct s_opt {
	char *opts;		/* option name */
	int size;		/* bytes for the ptr element (1, 2, 4);
				 * 0 means execute the function following
				 * parsing (argv, &opt_now)
				 */
	void *ptr;		/* pointer to the data element to be loaded or a function if size = 0 */
} OPTION;

typedef struct s_dbuff {
	unsigned *ptr_to_seg;	/* the area where the segment is held */
	unsigned *ptr_to_off;	/* the area where the offset is held */
	void far *addr; 	/* the address (when explicitly given) */
	char logo[20];
#define DBUFF_HEX 0x01
#define DBUFF_ASC 0x02
#define DBUFF_BIN 0x04
	int mode;		/* display mode */
	long bytes;		/* # of bytes to show */
} DBUFFER;

typedef struct s_doserr {
	int errno;
	int class;
	int action;
	int locus;
} DOS_ERROR;

/*
 * Globals
 */
char switchchar[] = "-+/";

char usage[] =
"usage: " PROG " [-h] [-q] [int=# | int# | -int #] [[-]reg[=]val] ...\n"
"       [-buf sreg:reg=\"str\"]\n"
"       [-d[a|b|hx] sreg:reg[:#bytes]] [-d[a|hx] faraddr[:#bytes]]\n"
"       [-divt int#-int#]]\n"
"       [-in[w] port#] [-out[w] port#,val]\n"
"       str: printf fmt (%#s allowed to setup buffers)\n";

char help[] =
" eg.\n"
"     o Interrupts (+ buffer setup)\n"
"       " PROG " 0x10 -ax 0x12 same as: int int=0x10 ax=0x12 (set VGA graphics mode)\n"
"       " PROG " 0x10 ah=0x10 al=1 bh=9 (set VGA border color; use to adjust display)\n"
"       " PROG " 0x21 -ah 9 -buf ds:dx=\"hello world\\n$\" -q (INT 21,9 'hello world')\n"
"       " PROG " an_int -buf es:bx=\"%512s\" (creates a scratch buffer of 512 bytes)\n"
"       " PROG " 0x33 ax=9 bx=0 cx=0 -fbuf es:bx=cursor.dat (mouse cursor from file)\n"
"     o Memory (-d: display: called after interrupt)\n"
"       " PROG " -q -dhx 0x400049:18 (BIOS video area data)\n"
"       " PROG " -q es=0x40 -bx 0x49 -dhx es:bx:18 (same as above)\n"
"       " PROG " -q -db 0xF8000000:512 >file (binary dump of AMIBIOS serial data)\n"
"     o IVT\n"
"       " PROG " -q -divt (display vectors from interrupt vector table = IVT)\n"
"       " PROG " -q -divt 0x10-0x1F (display IVT slots 0x10 to 0x1F)\n"
"     o I/O Ports\n"
"       " PROG " -out 0x70,0 -in 0x71 (read seconds from CMOS)\n"
"       " PROG " -out 0x70,0 -out 0x71,0 (zero-out seconds in CMOS)\n";

char *int_error[] = {
	NULL,
	"Parse",
};

char str_flags[] = "0N..ODITSZ0A0P1C";  /* 80x86 flag register */

union REGS reg;
struct SREGS sreg;
unsigned int reg_bp, reg_sp, flags;
int int_call;			/* the interrupt to be called */
int dos_errno;
int quiet_mode = 0;		/* quiet means just execute int - no reg display * /* does not apply on display
				 * opts */
int buff_now = 0;
char *buff[10]; 	    /* array of read buffer pointers */

int dbuff_now = 0;
DBUFFER dbuff[10];		/* the buffers to show at end of intr */


/* --- Prototypes --- */
OPTION *parse_an_opt(char *argv[], int *opt_now, int mode);
void doit(void);
void reg_display(void);
int set_int_val(char **argv, int *opt_now);
int ivt_display(char **argv, int *opt_now);
int ioport_out(char **argv, int *opt_now);
int ioport_in(char **argv, int *opt_now);
int read_escape(char **p);
int set_buff(char **argv, int *opt_now);
int set_fbuff(char **argv, int *opt_now);
int set_dbuff(char **argv, int *opt_now);
int dbuff_parse(void **ptr, char *tok);
int set_dbuff(char **argv, int *opt_now);
int show_help(char **argv, int *opt_now);
int set_quiet(char **argv, int *opt_now);
void error_exit(int err, char *s);

/* --- */

/*
 * Structure with all the `action' to be done for an option
 * NB: Care with matching prefixes (longer must come first)
 */
OPTION Opt[] = {

	/* NB: put the longer strings first ! */

	{"$DEFAULT", 0, (void *) set_int_val},
	{"DIVT", 0, (void *) ivt_display},      /* display int vector table */
	{"INT", 2, (void *) &int_call},

	{"OUTW", 0, (void *) ioport_out},       /* I/O port write, read */
	{"OUT", 0, (void *) ioport_out},
	{"INW", 0, (void *) ioport_in},
	{"IN", 0, (void *) ioport_in},

	{"DBUF", 0, (void *) set_dbuff},
	{"FBUF", 0, (void *) set_fbuff},
	{"BUF", 0, (void *) set_buff},
	{"DHX", 0, (void *) set_dbuff},         /* display mem contents (hex) */

	{"FL", 2, (void *) &(reg.x.flags)},     /* set flags (won't affect anything) */

	{"AX", 2, (void *) &(reg.x.ax)},        /* set general registers */
	{"BX", 2, (void *) &(reg.x.bx)},
	{"CX", 2, (void *) &(reg.x.cx)},
	{"DX", 2, (void *) &(reg.x.dx)},
	{"AH", 1, (void *) &(reg.h.ah)},
	{"BH", 1, (void *) &(reg.h.bh)},
	{"CH", 1, (void *) &(reg.h.ch)},
	{"DH", 1, (void *) &(reg.h.dh)},
	{"AL", 1, (void *) &(reg.h.al)},
	{"BL", 1, (void *) &(reg.h.bl)},
	{"CL", 1, (void *) &(reg.h.cl)},
	{"DL", 1, (void *) &(reg.h.dl)},

	{"SI", 2, (void *) &(reg.x.si)},        /* set index, stack registers */
	{"DI", 2, (void *) &(reg.x.di)},
	{"BP", 0, 0},
	{"SP", 0, 0},

	{"CS", 2, (void *) &(sreg.cs)},         /* set segment registers */
	{"DS", 2, (void *) &(sreg.ds)},
	{"ES", 2, (void *) &(sreg.es)},
	{"SS", 2, (void *) &(sreg.ss)},

	{"DA", 0, (void *) set_dbuff},          /* display mem contents (ascii) */
	{"D", 0, (void *) set_dbuff},           /* display mem contents (ascii+hex) */
	{"Q", 0, (void *) set_quiet},           /* quiet (no disply of reg contents) */
	{"H", 0, (void *) show_help},           /* help */
};


int cdecl
main(int argc, char *argv[])
{
	int opt_now;

	if (argc == 1)
		error_exit(0, NULL);

	/* parse the arguments and do proper action */
	for (opt_now = 1; opt_now < argc; opt_now++)
		if (parse_an_opt(argv, &opt_now, 0) == NULL)
			error_exit(1, NULL);
	doit();
	return (0);
}


/*
 * Parses an argument and calls proper function or assigns numbers
 * accordingly. Reentrant.
 */
OPTION *
parse_an_opt(char *argv[], int *opt_now, int mode)
{
	int i, arg_len, get_next_arg;
	char *opts, *optarg, *p;
	long val;

	opts = argv[*opt_now];
	if (strchr(switchchar, opts[0]))	/* option starts with a switch char, skip it */
		opts++, argv[*opt_now]++;
	for (i = 0; i < (sizeof(Opt) / sizeof(OPTION)); i++) {
		arg_len = strlen(Opt[i].opts);
		get_next_arg = opts[arg_len] == 0;
		if (strncmpi(opts, Opt[i].opts, arg_len) == 0) {
			if (mode & PARSE_NOACTION)	/* do not perform action */
				return (&Opt[i]);	/* just return ptr to Opt slot */
			switch (Opt[i].size) {

			case 0: /* call the function */
				if (!(mode & PARSE_JUSTARGS) && Opt[i].ptr != (void *) 0)
					if ((*((fun_ptr) Opt[i].ptr)) (argv, opt_now) == 0)
						return (NULL);	/* error */
				return (&Opt[i]);

			case 1: /* ptr is a byte, short, int */
			case 2:
			case 4:
				if (get_next_arg)
					optarg = argv[++(*opt_now)];	/* get next option */
				else
					optarg = opts + arg_len + 1;	/* skip a separator (eg =) */
				val = strtol(optarg, &p, 0);
				if (p == optarg)
					return (NULL);
				switch (Opt[i].size) {
				case 1:
					*((char *) Opt[i].ptr) = (char) val;
					break;
				case 2:
					*((short *) Opt[i].ptr) = (short) val;
					break;
				case 4:
					*((long *) Opt[i].ptr) = (long) val;
					break;
				}
				return (&Opt[i]);

			default:
				assert(NOTREACHED);
			}
		}
	}
	if (mode & PARSE_JUSTARGS)
		return (&Opt[0]);	/* default */
	else {
		i = (*((fun_ptr) Opt[0].ptr)) (argv, opt_now);	/* default */
		return (i == 0 ? NULL : &Opt[0]);
	}
}

/*
 * Call the interrupt if asked and display the result buffers
 */
void
doit(void)
{
	int i;
	long j;
	unsigned char far *ptr;
	unsigned char b;

	dos_errno = 0;
	if (int_call != -1) {
		reg_bp = _BP;
		reg_sp = _SP;
		flags = _FLAGS;
		reg_display();
	}
	if (int_call > 0 && int_call < 256) {
		quiet_mode || printf("\nINT: 0x%02X\n", int_call);
		int86x(int_call, &reg, &reg, &sreg);	/**/
		if (reg.x.cflag != 0)	/* error occured */
			dos_errno = _doserrno;
		reg_bp = _BP;
		reg_sp = _SP;
		quiet_mode || printf("\n");
		flags = reg.x.flags;
		reg_display();
		if (!quiet_mode && (int_call == 0x21 || int_call == 0x24))	/* dos call */
			printf("DOSERR: %04X (%u)\n", dos_errno, dos_errno);
	}
	/* display dbuffers */

	for (i = 0; i < dbuff_now; i++) {
		ptr = (unsigned char far *) MK_FP(*(dbuff[i].ptr_to_seg), *(dbuff[i].ptr_to_off));

		if (dbuff[i].mode & DBUFF_BIN)		/* binary */
			setmode(1, O_BINARY);
		else
			printf("\n*<%s> {\n", dbuff[i].logo);
		for (j = 0; j < dbuff[i].bytes; j++, ptr++) {
			b = *ptr & 0x00FF;		/* byte to display */
			if (dbuff[i].mode & DBUFF_BIN) {	/* binary */
				putchar(b);
				continue;	/* nothing else */
			}
			if (dbuff[i].mode & DBUFF_HEX)
				printf("%02X", b);
			if (dbuff[i].mode == DBUFF_ASC)
				putchar(iscntrl(b) ? '.' : b);
			else if (dbuff[i].mode & DBUFF_ASC)
				printf("(%c)", iscntrl(b) ? '.' : b);
			if (dbuff[i].mode != DBUFF_ASC)
				printf(" ");
		}
		fflush(stdout);
		if (dbuff[i].mode & DBUFF_BIN)	       /* binary */
			setmode(1, O_TEXT);
		else
			printf("}\n");
	}
	/* free the read buffers allocated */
	for (i = 0; i < buff_now; i++)
		free(buff[i]);
}

void
reg_display(void)
{
	char s[32];
	int i, bit_on;

	if (quiet_mode)
		return;
	printf(
	       "AX=%04X   BX=%04X   CX=%04X   DX=%04X\n"
	       "SI=%04X   DI=%04X   BP=%04X   SP=%04X\n"
	       "CS=%04X   DS=%04X   ES=%04X   SS=%04X",
	       reg.x.ax, reg.x.bx, reg.x.cx, reg.x.dx,
	       reg.x.si, reg.x.di, reg_bp, reg_sp,
	       sreg.cs, sreg.ds, sreg.es, sreg.ss);
	strncpy(s, str_flags, 32);	/* use a scratch copy */
	/* and now the flags */
	flags = reg.x.flags;
	for (i = 0; i < 16; i++) {
		bit_on = (flags & ((unsigned) 0x8000 >> i)) != 0;
		if (s[i] == '.')
			s[i] = bit_on ? '1' : '0';
		else
			s[i] = bit_on ? s[i] : tolower(s[i]);
	}
	printf("   CPU Flags: %16s\n", s);
}

/*
 * 'default' argument function - see if it is an interrupt
 */
int
set_int_val(char **argv, int *opt_now)
{
	long val;
	char *p;

	val = strtol(argv[*opt_now], &p, 0);
	if (val <= 0 || val > 255 || p - argv[*opt_now] != strlen(argv[*opt_now]))
		return (0);	/* problems */
	int_call = (int) val;
	return (1);
}

/*
 * Display a slot of the Interrupt Vector Table
 */
int
ivt_display(char **argv, int *opt_now)
{
	char sfrom[20], sto[20];
	int from, to, i;
	void far *p;

	if ((i = sscanf(argv[*opt_now + 1], "%[0-9xX]-%s", sfrom, sto)) == 2) { /* is a range given ? */
		(*opt_now)++;	/* consume next arg */
		from = (int) strtol(sfrom, (char **) &sfrom, 0);
		to = (int) strtol(sto, (char **) &sto, 0);
	} else {
		from = 0;
		to = 255;
	}
	/* do it now */
	printf("Interrupt Vector Table (0x%02X to 0x%02X)\n", from, to);
	for (i = from; i <= to; i++) {
		disable();	/* just in case ... */
		p = (void far *) *((long far *) (4L * i));
		enable();
		printf(" * 0x%02X (%3u):  %Fp\n", i, i, p);
	}
	printf("\n");
	return (1);
}

int
ioport_out(char **argv, int *opt_now)
{
	char *optarg, sport[10], sval[10];
	int word_op, port, val;

	optarg = argv[*opt_now];
	word_op = (toupper(optarg[3]) == 'W') ? 1 : 0;
	if (isdigit(optarg[3 + word_op]))	/* arg follows with no delimiter */
		optarg += 3 + word_op;
	else
		optarg = argv[++(*opt_now)];
	if (sscanf(optarg, "%[^ ,;]%*[ ,;]%s", sport, sval) != 2)
		return (0);
	port = (int) strtol(sport, (char **) &sport, 0);
	val = (int) strtol(sval, (char **) &sval, 0);
	if (word_op)
		outport(port, (unsigned) val);
	else
		outportb(port, val);
	int_call = -1;
	return (1);
}

int
ioport_in(char **argv, int *opt_now)
{
	char *optarg, sport[10];
	int word_op, port, val;

	optarg = argv[*opt_now];
	word_op = (toupper(optarg[2]) == 'W') ? 1 : 0;
	if (isdigit(optarg[2 + word_op]))	/* arg follows with no delimiter */
		optarg += 2 + word_op;
	else
		optarg = argv[++(*opt_now)];
	if (sscanf(optarg, "%s", sport) != 1)
		return (0);
	port = (int) strtol(sport, (char **) &sport, 0);
	if (word_op) {
		val = inport(port);
		quiet_mode || printf("INW 0x%04X (%5u):  0x%04X (%5u)\n", port, port, val, val);
	} else {
		val = inportb(port);
		quiet_mode || printf("IN 0x%04X (%5u):  0x%02X (%3u)\n", port, port, val, val);
	}
	quiet_mode || printf("\n");
	int_call = -1;
	return (1);
}

#define ESCAPES 10
static int esc_to_code[ESCAPES][2] = {
	{'n', '\n'},
	{'t', '\t'},
	{'v', '\v'},
	{'b', 'b'},
	{'r', '\r'},
	{'f', '\f'},
	{'a', '\a'},
	{'\\', '\\'},
	{'\?', '?'},
	{'\'', '\''},
};

/*
 * returns with *p pointing to char after the one(s) consumed
 */
int
read_escape(char **p)
{
	int i;

	if (isdigit(**p))	/* octal */
		return ((int) strtol(*p, p, 8));
	else if (**p == 'x')    /* hex */
		return ((int) strtol(*p + 1, p, 16));
	for (i = 0; i < ESCAPES; i++)
		if (**p == esc_to_code[i][0]) {
			(*p)++; /* consume it */
			return (esc_to_code[i][1]);
		}
	/* otherwise, return the character un-translated */
	(*p)++; 		/* consume it */
	return (**p);
}


/*
 * load seg register values to point ot the created buffer
 */
void
load_regpair(char *s_seg, char *s_off, void far *buff)
{
	int len;
	char stmp[50], *argv_fake[3];

	/* load the regs */
	argv_fake[0] = stmp;
	argv_fake[1] = "";
	len = 0;
	sprintf(stmp, "-%s 0x%X", s_seg, FP_SEG(buff));
	parse_an_opt(argv_fake, (int *) &len, PARSE_JUSTARGS);	/* make it think it's an option */
	sprintf(stmp, "-%s 0x%X", s_off, FP_OFF(buff));
	parse_an_opt(argv_fake, (int *) &len, PARSE_JUSTARGS);	/* and again for offs register */
}

/*
 * set registers accordingly
 */
int
set_buff(char **argv, int *opt_now)
{
	char *optarg, *p, *dp;
	char s_seg[10], s_off[10];
	char stmp[50];
	static char dummy[] = "";       /* for case of %s in fmt str */
	unsigned int len;

	optarg = argv[++(*opt_now)];	/* s_off pair */
	sscanf(optarg, "%[^:]:%s", &s_seg, &s_off);
	if (s_off[2] == '=')
		s_off[2] = 0;
	optarg = argv[++(*opt_now)];	/* printf like string */
	/* how big a buffer ? */
	len = strlen(optarg);
	/* add the %# lengths (extra buffer space) */
	for (p = strchr(optarg, '%'); p != NULL; p = strchr(p + 1, '%'))
		len += atoi(p + 1);

	if ((buff[buff_now] = (char *) malloc(len)) == NULL)
		return (0);
	/* create escape chars again (since cmd processing makes \ into \\) */
	p = optarg, dp = stmp;
	while (*p)
		if (*p == '\\') {
			p++;	/* consume \ */
			*dp++ = read_escape(&p);
		} else
			*dp++ = *p++;

	/* load the buffer; 5 % fields are enough (XXX ..f func problem if \0 appears before end of fmt) */
	sprintf(buff[buff_now], stmp, dummy, dummy, dummy, dummy, dummy);

	load_regpair(s_seg, s_off, (void far *) buff[buff_now]);
	buff_now++;
	return (1);
}

/*
 * set register pair to point to buffer with data from a file
 */
int
set_fbuff(char **argv, int *opt_now)
{
	char *optarg, *fname;
	char s_seg[10], s_off[80];
	long len;
	FILE *f;

	optarg = argv[++(*opt_now)];	/* s_off pair */
	sscanf(optarg, "%[^:]:%s", &s_seg, &s_off);
	if (s_off[2] == '=') {
		s_off[2] = 0;
		fname = &s_off[3];
	} else
		return (0);

	if ((f = fopen(fname, "rb")) == NULL)
		return (0);
	len = filelength(fileno(f));
	if (len > 65500L || (buff[buff_now] = (char *) malloc((unsigned int)len)) == NULL)
		return (0);
	if (fread(buff[buff_now], (int) len, 1, f) != 1)
		return (0);
	load_regpair(s_seg, s_off, (void far *) buff[buff_now]);
	buff_now++;
	fclose(f);
	return (1);
}

int
dbuff_parse(void **ptr, char *tok)
{
	char stmp[50], *argv_fake[3];
	OPTION *p_opt;
	int len = 0;

	argv_fake[0] = stmp;
	argv_fake[1] = "";
	sprintf(stmp, "-%s 0", tok);
	p_opt = parse_an_opt(argv_fake, &len, PARSE_JUSTARGS | PARSE_NOACTION);
	if (p_opt == NULL || p_opt == &Opt[0])
		return (0);
	*ptr = (unsigned *) p_opt->ptr;
	return (1);
}

/*
 * add to the list of the buffers to be displayed at end
 */
int
set_dbuff(char **argv, int *opt_now)
{
	char mode_char;
	char *optarg, *p;
	char tok[3][15];	/* max 3 tokens of 15 chars each */
	int i;
	long addr;
	unsigned long num = 1L; /* number of bytes to display */
	DBUFFER *dpb;

	dpb = &dbuff[dbuff_now];
	dpb->mode = DBUFF_HEX | DBUFF_ASC;
	mode_char = toupper(argv[*opt_now][1]);
	dpb->mode &= (mode_char == 'A') ? ~DBUFF_HEX : ~0;
	dpb->mode &= (mode_char == 'H') ? ~DBUFF_ASC : ~0;
	if (mode_char == 'B') {         /* binary mode */
		dpb->mode &= ~(DBUFF_HEX | DBUFF_ASC);
		dpb->mode |= DBUFF_BIN;
	}
	optarg = argv[++(*opt_now)];	/* reg pair */
	strncpy(dpb->logo, optarg, 20);
	/* collect tokens */
	for (i = 0, p = strtok(optarg, ":="); p; p = strtok(NULL, ":="))
		strcpy(tok[i++], p);
	if (i > 3)
		return (0);
	/* process them */
	addr = strtoul(tok[0], &p, 0);
	if ((p - tok[0]) > 0) { /* first is addr */
		if (i > 1) {	/* there's a 2nd token */
			num = strtoul(tok[1], &p, 0);
			if ((p - tok[1]) == 0 || num == 0)
				return (0);	/* wrong argument */
		}
		dpb->addr = (void far *) addr;
		dpb->ptr_to_off = (unsigned *) &(dpb->addr);
		dpb->ptr_to_seg = ((unsigned *) &(dpb->addr)) + 1;
	} else {		/* should be Reg:Reg[:#] format */
		if (dbuff_parse((void **) &(dpb->ptr_to_seg), tok[0]) == 0)
			return (0);
		if (dbuff_parse((void **) &(dpb->ptr_to_off), tok[1]) == 0)
			return (0);
		if (i > 2) {	/* num argument */
			num = strtoul(tok[2], &p, 0);
			if ((p - tok[2]) == 0 || num == 0)
				return (0);	/* wrong argument */
		}
	}
	dpb->bytes = num;
	dbuff_now++;		/* have inserted an element */
	return (1);
}

int
set_quiet(char **argv, int *opt_now)
{
	argv = argv, opt_now = opt_now; /* eliminate warning */
	return (quiet_mode = 1);
}

#define fmsg stdout		/* DOS stderr cannot be redir'ed >:-{ */

int
show_help(char **argv, int *opt_now)
{
	argv = argv, opt_now = opt_now; /* eliminate warning */
	fprintf(fmsg,
		PROG ": Execute and investigate interrupts/system data (ver " VERSION ")\n"
		"Copyright (c) 1992-1994 A. Haritsis <ah@doc.ic.ac.uk>. Distribute freely.\n");
	error_exit(0, help);
	return (1);
}

void
error_exit(int err, char *s)
{
	if (err > 0)
		fprintf(fmsg, PROG ": %s error\n", int_error[err]);
	fprintf(fmsg, "%s", usage);
	if (s != NULL)
		fprintf(fmsg, "%s", s);
	exit(err);
}
