/****************************************************************/
/*	EEL code file for editing the Interrupt List		*/
/*								*/
/*	Written by Ralf Brown					*/
/*	LastEdit:  30 Aug 98					*/
/*								*/
/*  This EEL file adds the following keybindings:		*/
/*    Shf-Alt-A add an Access: section to the current entry	*/
/*    Shf-Alt-B add another BUG: to the current entry           */
/*    Shf-Alt-D add a Desc: section to the current entry	*/
/*    Sft-Alt-I add an InstallCheck: section to current entry	*/
/*    Shf-Alt-R add a Range: section to the current entry       */
/*    Shf-Alt-S add a Size: section to the current entry	*/
/*	Alt-I	add an Index: section to the current entry;	*/
/*		 add another Index: line if already on Index:	*/
/*      Alt-N   add a new note to current entry or data struct  */
/*      Alt-P   add a Program: section to the current entry     */
/*      Alt-R   insert Return: at start of line                 */
/*	Alt-S	insert SeeAlso: at start of line; add another	*/
/*		 SeeAlso: line if already on SeeAlso:		*/
/*	F11	insert a blank separator line			*/
/*	^F11	create Format of: header			*/
/*	Shf-F11	create Values for: header			*/
/*	Alt-F11 create Call with: header			*/
/*	Alt-F12 create Bitfield for: header			*/
/*	F12	add the interrupt number to the separator line	*/
/*		preceding the current entry			*/
/*	^F12	jump to a specified entry			*/
/*								*/
/*  It adds the following unbound commands:		        */
/*      renumber-tables					        */
/*	make-distribution					*/
/*      filter-region						*/
/*		run region through a specified command; by      */
/*	       	default, the program is given the region on its */
/* 		stdin and its stdout is used to replace the	*/
/*		region; if one or two "%s" are given, they	*/
/*		will be replaced by the input and output (resp) */
/*		file the program should use.			*/
/*								*/ 
/*  Other:							*/
/*	adds intlist-mode for .LST and .1ST files		*/
/*	switches current buffer into intlist-mode on loading	*/
/*      maintains a table counter which is inserted each time   */
/*        a table is created in the text		        */
/*      performs syntax highlighting (Epsilon v7+)		*/
/****************************************************************/

#include "eel.h"
#if EELVERSION >= 70
#include "colcode.h"
#endif /* Epsilon v7.0+ */

keytable intlist_tab ;			/* key table for IntList mode */

/* on repeated F12, how often to display number of entries processed */
/* for fast 386, every 100; for a Pentium, at least 300 or the message */
/* line will lag way behind the actual progress */
#define NUMBER_INT_PROGRESS_INTERVAL 500

/*=============================================================*/
/*    Global Variables					       */
/*=============================================================*/

/* table headings */
char str_format_of[] = "Format of " ;
char str_bitfields_for[] = "Bitfields for " ;

/* section names within an entry */
char size_section[] = "Size:\t" ;
char access_section[] = "Access:\t" ;
char return_section[] = "Return: " ;
char program_section[] = "Program: " ;
char desc_section[] = "Desc:\t" ;
char install_section[] = "InstallCheck:" ;
char range_section[] = "Range:\t" ;
char notes_section[] = "Notes*:\t" ;
char bugs_section[] = "BUGS*:\t" ;
char example_section[] = "Example: " ;
char seealso_section[] = "SeeAlso: " ;
char index_section[] = "Index:\t" ;

#if EELVERSION >= 70
char all_sections[] = "Return:|SeeAlso:|Program:|Desc:|Range:|Notes*:|BUGS*:|Example:|Index:|Access:|InstallCheck:|Size:" ;
char indented_sections[] = "[\t ]*(Return|Notes*):" ;
char table_headers[] = "INT |Format |Values |Bitfields |MEM |CMOS |MSR |CALL |PORT |Call |OPCODE |I2C " ;
#endif /* Epsilon v7.0+ */

/*char table_ID_letters[] = "0123456789CFIMPRS" ;*/
char table_ID_letters[] = "09CFIMPRS" ;
#define ID_LETTER_OFFSET 2

char *(section_order[13]) ;
char *(list_files[13]) ;

#if EELVERSION >= 90
// Lugaru renamed the variable on us!
#define strip_returns translation_type
#endif /* EELVERSION >= 90 */

when_loading()
{
   /* list the sections of an entry in the order they should appear (if */
   /* present at all) */
   section_order[0] = size_section ;
   section_order[1] = access_section ;
   section_order[2] = return_section ;
   section_order[3] = program_section ;
   section_order[4] = desc_section ;
   section_order[5] = install_section ;
   section_order[6] = range_section ;
   section_order[7] = notes_section ;
   section_order[8] = bugs_section ;
   section_order[9] = example_section ;
   section_order[10] = seealso_section ;
   section_order[11] = index_section ;
   section_order[12] = NULL ;
   /* list the files comprising the full interrupt list */
   list_files[0] = "cmos.lst" ;
   list_files[1] = "farcall.lst" ;
   list_files[2] = "memory.lst" ;
   list_files[3] = "ports.lst" ;
   list_files[4] = "interrup.lst" ;
   list_files[5] = "tables.lst" ;
   list_files[6] = "msr.lst" ;
   list_files[7] = "biblio.lst" ;
   list_files[8] = "glossary.lst" ;
   list_files[9] = "opcodes.lst" ;
   list_files[10] = "smm.lst" ;
   list_files[11] = "i2c.lst" ;
   list_files[12] = NULL ;
}

/*=============================================================*/
/*    Buffer-specific variables				       */
/*=============================================================*/

buffer spot table_counter ;

/*=============================================================*/
/*=============================================================*/

int empty_line()
{
   return (character(point-1) == '\n' && character(point) == '\n') ;
}

/*=============================================================*/
/*=============================================================*/

int is_separator_line()
{
   return (empty_line() || parse_string(1,"--------",NULL)) ;
}

/*=============================================================*/
/* search in the specified direction (1 = forward, -1 = back)  */
/* for the next entry separator line			       */
/*=============================================================*/

int to_separator_line(dir)
int dir ;
{
   nl_reverse() ;
   return search(dir,"\n--------") ;
}

/*=============================================================*/
/* move to the location where the specified section of an      */
/* entry begins (if present) or should begin (if not)	       */
/*=============================================================*/

int to_section_start(section)
char *section ;
{
   int i, j, len ;

   for (i = 0 ; section_order[i] ; i++)
      if (strcmp(section,section_order[i]) == 0)
	 break ;
   if (section_order[i])
      {
      while (!is_separator_line())
	 {
	 for (j = i ; section_order[j] ; j++)
	    if (parse_string(1,section_order[j],NULL))
	       {
	       if ((len = parse_string(1,section,NULL)) != 0)
		  {
		  point += len ;
		  return 1 ;	/* section already exists */
		  }
	       return 0 ;	/* section nonexistent, but found position */
	       }
	 if (!nl_forward())
	    break ;
	 }
      return 0 ;	/* section does not yet exist */
      }
   else
      return 0 ;	/* section not found */
}

/*=============================================================*/
/*=============================================================*/

int make_section(section,start_entry,name)
char *section, *name ;
int start_entry ;
{
   int start = point ;

   if (start_entry)
      {
      if (!to_separator_line(-1))  /* find previous separator line */
	 {
	 point = start ;
	 say("Not in an interrupt entry") ;
	 return 0 ;
	 }
      }
   else
      {
      to_begin_line() ;
      while (!empty_line() && !parse_string(1,"\n--------",NULL))
	 if (!nl_reverse())
	    break ;
      }
   point++ ;			     /* skip the newline */
   nl_forward() ;		     /* advance to first line of entry */
   if (!to_section_start(section))
      {
      if (name)
	 stuff(name) ;
      else
	 stuff(section) ;
      stuff("\n") ;
      point-- ; 		     /* back up over inserted newline */
      return 1 ;
      }
   else
      return 0 ;
   return 2 ;  /* just in case */
}

/*=============================================================*/
/*=============================================================*/

int pluralize_section(plural)
char plural ;
{
   point -= 3 ;
   if (curchar() != plural)		/* already plural ? */
      {
      point++ ;
      insert(plural) ;
      }
   nl_forward() ;
   while (!is_separator_line() && parse_string(1,"[ \t]",NULL))
      nl_forward() ;
   stuff("\t\n") ;
   point-- ;
}

/*=============================================================*/
/* Add "SeeAlso: " to the beginning of the current line unless */
/* it is already present; in that case, insert a fresh line    */
/* containing just a SeeAlso: and position the cursor at the   */
/* end of the new line					       */
/*=============================================================*/

command see_also() on intlist_tab[ALT('s')]
{
   to_begin_line() ;
   if (parse_string(1,"SeeAlso: ",NULL) == 0)
      stuff("SeeAlso: ") ;
   else
      {
      nl_forward() ;
      stuff("SeeAlso: \n") ;
      point-- ;
      }
}

/*=============================================================*/
/* Add a Desc: section if the current entry does not already   */
/* have one; if there is already a Desc: section, move to the  */
/* start of it						       */
/*=============================================================*/

command access() on intlist_tab[ALT('A')]
{
   make_section(access_section,1,NULL) ;
}

/*=============================================================*/
/* Add a Desc: section if the current entry does not already   */
/* have one; if there is already a Desc: section, move to the  */
/* start of it						       */
/*=============================================================*/

command desc() on intlist_tab[ALT('D')]
{
   make_section(desc_section,1,NULL) ;
}

/*=============================================================*/
/* Add a InstallCheck: section if the current entry does not   */
/* already have one; if there is already a InstallCheck:       */
/* section, move to the start of it			       */
/*=============================================================*/

command instcheck() on intlist_tab[ALT('I')]
{
   make_section(install_section,1,NULL) ;
}

/*=============================================================*/
/* Add a Range: section if the current entry does not already  */
/* have one; if there is already a Range: section, move to the */
/* start of it						       */
/*=============================================================*/

command range() on intlist_tab[ALT('R')]
{
   make_section(range_section,1,NULL) ;
}

/*=============================================================*/
/* Add a Size: section if the current entry does not already   */
/* have one; if there is already a Size: section, move to the  */
/* start of it						       */
/*=============================================================*/

command memsize() on intlist_tab[ALT('S')]
{
   make_section(size_section,1,NULL) ;
}

/*=============================================================*/
/* Add a "Program: " section to the current entry if it does   */
/* not have one; otherwise, move to the beginning of the       */
/* Program: section					       */
/*=============================================================*/

command program() on intlist_tab[ALT('p')]
{
   make_section(program_section,1,NULL) ;
}

/*=============================================================*/
/* Add an "Index: " section to the current entry if it does    */
/* not have one; otherwise, move to the beginning of the       */
/* Index: section					       */
/*=============================================================*/

command add_index() on intlist_tab[ALT('i')]
{
   to_begin_line() ;
   if (parse_string(1,"Index:",NULL))
      {
      while (parse_string(1,"Index:",NULL))
	 nl_forward() ;
      stuff("Index:\t\n") ;
      point-- ;
      }
   else
      make_section(index_section,1,NULL) ;
}

/*=============================================================*/
/*=============================================================*/

command bug() on intlist_tab[ALT('B')]
{
   if (!make_section(bugs_section,1,"BUG:\t"))
      pluralize_section('S') ;
}

/*=============================================================*/
/* Add "Note: " section to the current entry; change an        */
/* existing Note: to Notes: and position at end of Note:       */
/* section.						       */
/*=============================================================*/

command add_note() on intlist_tab[ALT('n')]
{
   if (!make_section(notes_section,0,"Note:\t"))
      pluralize_section('s') ;
}

/*=============================================================*/
/* Insert "Return: " at the beginning of the current line, if  */
/* not already present					       */
/*=============================================================*/

command returns() on intlist_tab[ALT('r')]
{
   int start = point ;
   
   to_begin_line() ;
   if (parse_string(1,return_section,NULL) == 0)
      stuff(return_section) ;
   else
      point = start ;
}

/*=============================================================*/
/* insert a line of dashes prior to the current cursor line    */
/*=============================================================*/

command separator_line() on intlist_tab[FKEY(11)]
{
   int i ;

   to_begin_line() ;
   for (i = 0 ; i < 45 ; i++)
      insert('-') ;
   insert('\n') ;
}

/*=============================================================*/
/*=============================================================*/

void insert_table_counter()
{
   char counter[6] ;
   save_var point = *table_counter + 4 ;

   /* increment that table counter */
   while (curchar() >= '0')
      {
      if (curchar() < '9')
	 {
	 replace(point,curchar()+1) ;
	 break ;
	 }
      else
	 {
	 replace(point,'0') ;
	 point-- ;
	 }
      }
   restore_vars() ;
   /* and now insert the incremented value at point */
   stuff("(Table ") ;
   grab(*table_counter,*table_counter+5,counter) ;
   stuff(counter) ;
   stuff(")") ;
}

/*=============================================================*/
/* type the name of a structure, then invoke this function     */
/* to create the "Format of X:" and "Offset Size Descr" lines  */
/*=============================================================*/

command structure_header() on intlist_tab[FCTRL(11)]
{
   int start = point ;

   to_begin_line() ;
   if (parse_string(1,str_format_of,NULL) == 0)
      {
      stuff(str_format_of) ;
      to_end_line() ;
      stuff(":\nOffset\tSize\tDescription\t") ;
      insert_table_counter() ;
      stuff("\n 00h\t") ;
      }
   else
      point = start ;
}

/*=============================================================*/
/* Turn the current line into the header for a "Values of"     */
/* section						       */
/*=============================================================*/

command value_header() on intlist_tab[FSHIFT(11)]
{
   int start = point ;
   
   to_begin_line() ;
   if (parse_string(1,"Values for ",NULL) == 0)
      {
      insert_table_counter() ;
      stuff("\nValues for ") ;
      to_end_line() ;
      stuff(":\n ") ;
      }
   else
      point = start ;
}

/*=============================================================*/
/* Turn the current line into the header of a "Call with"      */
/* section						       */
/*=============================================================*/

command call_with_header() on intlist_tab[FALT(11)]
{
   int start = point ;
   
   to_begin_line() ;
   if (parse_string(1,"Call ",NULL) == 0)
      {
      insert_table_counter() ;
      stuff("\nCall ") ;
      to_end_line() ;
      if (character(point-1) != ' ')
	 stuff(" ") ;
      stuff("with:\n") ;
      }
   else
      point = start ;
}

/*=============================================================*/
/* Turn the current line into the header of a "Bitfield for"   */
/* section						       */
/*=============================================================*/

command bitfields_for_header() on intlist_tab[FALT(12)]
{
   int start = point ;
   
   to_begin_line() ;
   if (parse_string(1,str_bitfields_for,NULL) == 0)
      {
      stuff(str_bitfields_for) ;
      to_end_line() ;
      stuff(":\nBit(s)\tDescription\t") ;
      insert_table_counter() ;
      stuff("\n ") ;
      }
   else
      point = start ;
}

/*=============================================================*/
/*=============================================================*/

char grab_int_entry_number(func_num)
char *func_num ;
{
   int i ;
   char c ;
   
   point += 4 ;				/* skip the "INT " */
   func_num[0] = curchar() ;		/* grab the interrupt number */
   point++ ;
   func_num[1] = curchar() ;
   nl_forward() ;			/* skip to second line of entry */
   if (parse_string(1,"[ \t]*A[LHX][ \t]=[ \t][0-9A-F][0-9A-F]+h",NULL))
      {
      re_search(1,"[ \t]*A") ;
      c = curchar() ;
      point += 4 ;			/* skip ch and " = " */
      if (c != 'L')
	 {
	 grab(point,point+((c=='X')?4:2),func_num+2) ;
	 point += ((c=='X')?4:2) ;
	 func_num[(c=='H')?4:6] = '-' ;	/* grab() stuck a NUL into the string */
	 }
      else /* c == 'L' */
	 {
	 func_num[4] = curchar() ;
	 point++ ;
	 func_num[5] = curchar() ;
	 point ++ ;
	 }
      point++ ;
      if (parse_string(1,"[ \t]*subfn [0-9A-F][0-9A-F]+h",NULL))
	 {
	 re_search(1,"[ \t]*subfn ") ;
	 func_num[6] = 'S' ;
	 func_num[7] = 'F' ;
	 for (i = 0 ; i < 4 ; i++)
	    {
	    c = curchar() ;
	    if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F'))
	       {
	       func_num[8+i] = c ;
	       point++ ;
	       }
	    else
	       break ;
	    }
	 }
      nl_forward() ;			/* skip to third line of entry */
      }
   if (parse_string(1,"[ \t]*([BCDES][HILPSX]|VxD) = [0-9A-F][0-9A-F]+h",NULL))
      {
      re_search(1,"[ \t]*") ;
      func_num[6] = curchar() ;
      point++ ;
      func_num[7] = c = curchar() ;
      point += 4 ;			/* skip curchar and " = " */
      if (func_num[6] == 'V')		/* VxD has three letters not two... */
	 point++ ;
      if (c == 'H' || c == 'L')
	 {
	 grab(point,point+2,func_num+8) ;
	 func_num[10] = '-' ;		/* grab() stuck a NUL into the string */
	 }
      else /* c == 'X' || c == 'I' || c == 'P' || c == 'S' */
	 {
	 grab(point,point+4,func_num+8) ;
	 func_num[12] = '-' ;
	 }
      }
   return 1 ;				/* successful and have func number */
}

/*=============================================================*/

char grab_cmos_entry_number(func_num)
char *func_num ;
{
   point += 5 ;			        /* skip the "CMOS " */
   func_num[0] = 'R' ;			/* mark this as a CMOS RAM entry */
   grab(point,point+4,func_num+1) ;
   if (func_num[3] == 'h' && func_num[4] == '-')
      grab(point+4,point+6,func_num+3) ;
   else
      {
      func_num[3] = '-' ;
      func_num[4] = '-' ;
      }
   func_num[5] = '-' ;			/* grab() stuck a NUL into string */
   return 1 ;
}

/*=============================================================*/

char grab_farcall_entry_number(func_num)
char *func_num ;
{
   point += 5 ;				/* skip the "CALL " */
   func_num[0] = '@' ;			/* mark this as a far call entry */
   grab(point,point+4,func_num+1) ;	/* get segment of address */
   grab(point+6,point+10,func_num+5) ;	/* get offset of address */
   func_num[9] = '-' ;			/* grab() stuck a NUL into string */
   return 1 ;
}

/*=============================================================*/

char grab_msr_entry_number(func_num)
char *func_num ;
{
   point += 4 ;				/* skip the "MSR " */
   func_num[0] = 'S' ;			/* mark this as an MSR entry */
   grab(point,point+8,func_num+1) ;     /* get the MSR number */
   func_num[9] = '-' ;	      		/* grab() stuck a NUL into string */
   return 1 ;
}

/*=============================================================*/

char grab_memory_entry_number(func_num)
char *func_num ;
{
   point += 4 ;				/* skip the "MEM " */
   func_num[0] = 'M' ;		        /* mark this as a memory loc entry */
   grab(point,point+6,func_num+1) ;	/* get segment or high word of addr */
   if (func_num[5] == 'h' && func_num[6] == ':') /* segmented address? */
      grab(point+6,point+10,func_num+5) ;	/* get offset of address */
   else
      {
      grab(point+6,point+8,func_num+7) ;/* get low word of the address */
      func_num[0] = 'm' ;		/* indicate linear address */
      }
   func_num[9] = '-' ;			/* grab() stuck a NUL into string */
   return 1 ;
}

/*=============================================================*/

char grab_opcode_name(func_num)
char *func_num ;
{
   int i ;
   point += 7 ;				/* skip the "OPCODE " */
   func_num[0] = 'O' ;			/* mark this as an opcode entry */
   for (i = 2 ; i < 12 ; i++)		/* grab the opcode name and stuff */
      {			   		/*   it into the header line */
      char c = curchar() ;
      if (c == ' ' || c == '\t')
	 break ;
      else
	 {
	 func_num[i] = c ;
	 point++ ;
	 }
      }
   return 1 ;
}

/*=============================================================*/

char grab_port_entry_number(func_num)
char *func_num ;
{
   point += 5 ;				/* skip the "PORT " */
   func_num[0] = 'P' ;			/* mark this as an I/O port entry */
   grab(point,point+4,func_num+1) ;	/* get starting port number */
   func_num[5] = '-' ;			/* grab() stuck a NUL into string */
   if (character(point+4) == '-')
      {
      grab(point+5,point+9,func_num+5) ; /* get ending port number */
      func_num[9] = '-' ;		/* grab() stuck a NUL into string */
      }
   return 1 ;
}

/*=============================================================*/

char grab_i2c_entry_number(func_num)
char *func_num ;
{
   point += 4 ;				/* skip the "I2C " */
   func_num[0] = 'I' ;			/* mark this as an I2C port entry */
   grab(point,point+2,func_num+1) ;	/* get slave address */
   func_num[3] = '-' ;			/* grab() stuck a NUL into string */
   if (character(point+3) == '/')
      {
      grab(point+4,point+6,func_num+3) ; /* get register address */
      func_num[5] = '-' ;		/* grab() stuck a NUL into string */
      if (character(point+6) != 'h' && character(point+6) != '/')
	 {
	 grab(point+6,point+8,func_num+5) ; /* get second byte of reg. addr */
	 func_num[7] = '-' ;		/* grab() stuck a NUL into string */
	 point += 2 ;
	 }
      if (character(point+7) == '/')
	 {
	 func_num[7] = 'S' ;
	 func_num[8] = 'F' ;
	 grab(point+8,point+10,func_num+9) ;
	 func_num[11] = '-' ;
	 if (character(point+10) != 'h')
	    grab(point+10,point+12,func_num+11) ;
	 }
      }
   return 1 ;
}

/*=============================================================*/

char grab_entry_number(func_num)
char *func_num ;
{
   strcpy(func_num,"-------------") ;	/* 13 dashes */
   point++ ;				/* go to first char of separator line */
   nl_forward() ;			/* go to first line of entry */
   if (parse_string(1,"INT ",NULL))	/* is it an interrupt entry? */
      return grab_int_entry_number(func_num) ;
   else if (parse_string(1,"CMOS ",NULL) != 0)
      return grab_cmos_entry_number(func_num) ;
   else if (parse_string(1,"CALL ",NULL) != 0)
      return grab_farcall_entry_number(func_num) ;
   else if (parse_string(1,"MEM ",NULL) != 0)
      return grab_memory_entry_number(func_num) ;
   else if (parse_string(1,"PORT ",NULL) != 0)
      return grab_port_entry_number(func_num) ;
   else if (parse_string(1,"MSR ",NULL) != 0)
      return grab_msr_entry_number(func_num) ;
   else if (parse_string(1,"OPCODE ",NULL) != 0)
      return grab_opcode_name(func_num) ;
   else if (parse_string(1,"I2C ",NULL) != 0)
      return grab_i2c_entry_number(func_num) ;
   else
      return 0 ;
}

/*=============================================================*/
/* Put the interrupt and function number into the separator    */
/* line just above the intlist entry preceding the cursor pos  */
/*=============================================================*/

int number_one_int()
{
   char func_num[14] ;			/* 2->int, 4->AX, 6->extra reg, NUL */
   int oldpoint ;
   
   while (to_separator_line(-1))	/* find previous separator line */
      {
      oldpoint = point ;
      if (grab_entry_number(func_num))	/* does it belong to an intlist entry? */
	 {				/*   if yes, success, else try again */
	 point = oldpoint + 11 ;	/* skip NL and first ten dashes */
	 delete(point,point+13) ;	/* replace 13 dashes by the function */
	 stuff(func_num) ;		/*   number and extra register */
	 point = oldpoint + 9 ;		/* back to category letter position */
	 return 1 ;
	 }
      point = oldpoint ;
      }
   return 0 ;				/* if we get here, we failed */
}

/*=============================================================*/
/* Put the interrupt and function number into the separator    */
/* line just above one or more intlist entries preceding the   */
/* current cursor position, letting user know of progress      */
/*=============================================================*/

command number_int() on intlist_tab[FKEY(12)]
{
   int i, hit_top = 0 ;
   
   for (i = 0 ; i < iter ; i++)
      {
      if (!number_one_int())
	 {
	 hit_top = 1 ;
	 say("No prior entry.") ;
	 break ;
	 }
      if (((i+1) % NUMBER_INT_PROGRESS_INTERVAL) == 0)
	 say("%4d...",i+1) ;
      }
   if (iter > 1 && !hit_top)
      say("Done.") ;
   iter = 1 ;
}

/*=============================================================*/
/*=============================================================*/

int line_has_see_also()
{
   int len ;
   
   to_begin_line() ;
   if ((len = parse_string(1,".*%([sS]ee ",NULL)) != 0)
      {
      point += len ;		/* go to start of cross-reference */
      point += parse_string(1,"also ",NULL) ;
      if (parse_string(1,"INT [0-9A-F]",NULL) ||
	  parse_string(1,"A[XHL] =",NULL)
	 )
	 {
	 point++ ;		/* move into reference */
	 return 1 ;
	 }
      }
   return 0 ;
}

/*=============================================================*/
/*=============================================================*/

int grab_int_reference(ref)
char *ref ;
{
   int begin, start = point ;
   
   re_search(-1,"[, \t\n]") ;	/* backup to start of reference */
   if (curchar() == '\n')	/* start of line? */
      re_search(1,":[ \t]") ;	/* skip the SeeAlso: */
   else if (character(point-1) == 'T' && character(point-2) == 'N')
      point -= 3 ;
   else
      point++ ;			/* back to start of reference */
   begin = point ;
   re_search(1,"[,\n\"]") ;	/* find end of INT-spec */
   point-- ;
   if (curchar() == '\"')	/* extra string at end of INT-spec? */
      {
      point++ ;
      re_search(1,"[\"\n]") ;	/* if yes, run to end of line or string */
      }
   grab(begin,point,ref) ;
   point = start ;
   return 0 ;
}

/*=============================================================*/
/*=============================================================*/

int parse_int_name(entry_name,id,extra_string)
char *entry_name, *id, *extra_string ;
{
   int start = point ;
   int i ;
   char c, *last ;

   for (i = strlen(entry_name)-1 ; i >= 0 ; i--)
      entry_name[i] = toupper(entry_name[i]) ;
   strcpy(id,"------------") ;
   if (strncmp(entry_name,"INT ",4) == 0)
      {
      id[0] = entry_name[4] ;
      id[1] = entry_name[5] ;
      entry_name += 6 ;
      if (entry_name[0] == '/')
	 entry_name++ ;
      }
   else if (to_separator_line(-1))
      {
      id[0] = character(point+11) ;
      id[1] = character(point+12) ;
      }
   point = start ;
   c = entry_name[1] ;
   if (entry_name[0] == 'A' && (c == 'X' || c == 'H' || c == 'L'))
      {
      entry_name += 2 ;
      while (entry_name[0] == ' ' || entry_name[0] == '\t')
	 entry_name++ ;
      if (entry_name[0] == '=')
	 entry_name++ ;
      while (entry_name[0] == ' ' || entry_name[0] == '\t')
	 entry_name++ ;
      if (c != 'L')
	 {
         id[2] = entry_name[0] ;
         id[3] = entry_name[1] ;
	 }
      if (c == 'X')
	 {
	 id[4] = entry_name[2] ;
	 id[5] = entry_name[3] ;
	 entry_name += 4 ;
	 }
      else
	 {
	 if (c == 'L')
	    {
	    id[2] = entry_name[0] ;
	    id[3] = entry_name[1] ;
	    }
	 entry_name += 2 ;
	 }
      if (entry_name[0] == 'H')
	 entry_name++ ;
      if (entry_name[0] == '/')
	 entry_name++ ;
      }
   if (index("ABCDES",entry_name[0]) && index("HILPSXF",entry_name[1]))
      {
      id[6] = entry_name[0] ;
      c = id[7] = entry_name[1] ;
      entry_name += 2 ;
      while (entry_name[0] == ' ' || entry_name[0] == '\t')
	 entry_name++ ;
      if (entry_name[0] == '=')
	 entry_name++ ;
      while (entry_name[0] == ' ' || entry_name[0] == '\t')
	 entry_name++ ;
      id[8] = entry_name[0] ;
      id[9] = entry_name[1] ;
      if (c != 'H' && c != 'L' && (c != 'F' || entry_name[2] != 'h'))
	 {
	 id[10] = entry_name[2] ;
	 id[11] = entry_name[3] ;
	 entry_name += 4 ;
	 }
      else
	 entry_name += 2 ;
      if (entry_name[0] == 'H')
	 entry_name++ ;
      if (entry_name[0] == '/')
	 entry_name++ ;
      }
   if (entry_name[0] == '\"')
      {
      entry_name++ ;
      strcpy(extra_string,entry_name) ;
      last = index(extra_string,'\"') ;
      if (last)
	 *last = '\0' ;
      }
   else
      extra_string[0] = '\0' ;
   return 0 ;
}

/*=============================================================*/
/*=============================================================*/

int hex2_to_int(c1,c2)
char c1, c2 ;
{
   if (c1 >= '0' && c1 <= '9')
      c1 -= '0' ;
   else if (c1 >= 'A' && c1 <= 'F')
      c1 = c1 - 'A' + 10 ;
   else if (c1 >= 'a' && c1 <= 'f')
      c1 = c1 - 'a' + 10 ;
   else
      return -1 ;
   if (c2 >= '0' && c2 <= '9')
      c2 -= '0' ;
   else if (c2 >= 'A' && c2 <= 'F')
      c2 = c2 - 'A' + 10 ;
   else if (c2 >= 'a' && c2 <= 'f')
      c2 = c2 - 'a' + 10 ;
   else
      return -1 ;
   return 16*c1 + c2 ;
}

/*=============================================================*/
/*=============================================================*/

char hex_digit(val)
int val ;
{
   if (val < 0)
      return '-' ;
   else
      return (val > 9) ? ('A' + val - 10) : ('0' + val) ;
}

/*=============================================================*/
/*=============================================================*/

int scan_for_entry(entry,extra_str,first_entry)
char *entry, *extra_str ;
int *first_entry ;
{
   int bestcount = 0 ;
   int bestmatch = -1 ;

   if (extra_str) extra_str = 0 ;  /* for now, to avoid compiler warning */
   *first_entry = 0 ;
   /* scan for the first entry for the desired interrupt number */
   while (to_separator_line(1))
      {
      point += 2 ;
      if (character(point) == entry[0] && character(point+1) == entry[1])
	 break ;
      nl_forward() ;
      }
   /* now scan through the entries for the given interrupt number */
   while (to_separator_line(1))
      {
      int i ;
      char buf[14] ;
      point += 2 ;
      grab(point,point+12,buf) ;
      if ((buf[0] != entry[0] || buf[1] != entry[1]) &&
	  (buf[0] != '-' && buf[1] != '-'))
	 break ;			/* ran out of entries... */
      for (i = 2 ; i <= 12 ; i++)
	 {
	 if (buf[i] != entry[i])
	    break ;
	 }
      if (i > bestcount)
	 {
	 bestcount = i ;
	 bestmatch = point ;
	 if (i > 12)
	    break ;			/* found an exact match */
	 }
      nl_forward() ;
      }
   if (bestmatch == -1)
      return 0 ;			/* we failed */
   else
      {
      *first_entry = bestmatch ;
      point = bestmatch ;		/* back to best-matching entry */
      nl_forward() ;
      return 1 ;			/* we were successful */
      }
}

/*=============================================================*/
/*=============================================================*/

int goto_entry(entry_name)
char *entry_name ;
{
   char int_id[13], extra_string[60] ;
   int start = point, first_entry ;
   int int_num, curr_int ;
   char search_str[22] ;
   
   parse_int_name(entry_name,int_id,extra_string) ;
   int_num = hex2_to_int(int_id[0],int_id[1]) ;
   if (to_separator_line(-1))
      {
      if (character(point+11) == '-')
	 curr_int = -1 ;
      else
	 curr_int = hex2_to_int(character(point+11),character(point+12)) ;
      if (int_num <= 0)
	 point = 0 ;		/* go to top of file */
      else
	 {
	 if (curr_int <= 0)
	    point = 0 ;		/* go to top of file */
	 strcpy(search_str,"--------.-") ;
	 search_str[10] = hex_digit((int_num-1) / 16) ;
	 search_str[11] = hex_digit((int_num-1) % 16) ;
	 search_str[12] = '\0' ;
	 if (!re_search( (int_num<=curr_int)?-1:1, search_str))
	    {
	    say("%s not found.",entry_name) ;
	    iter = 1 ;
	    return 0 ;
	    }
	 to_begin_line() ;
	 }
      }
   else
      point = 0 ;
   if (!scan_for_entry(int_id,extra_string,&first_entry))
      {
      say("%s not found.",entry_name) ;
      if (first_entry)
	 {
	 mark = start ;
	 point = first_entry ;
	 }
      else
	 point = start ;
      }
   if (has_arg)
     iter = 1 ;				/* don't search repeatedly */
   return 0 ;
}

/*=============================================================*/
/*=============================================================*/

command goto_int() on intlist_tab[FCTRL(12)]
{
   char entry_name[60], def_entry[60] ;
   int start = point ;

   to_begin_line() ;
   if (parse_string(1,"SeeAlso: ",NULL) != 0)
      {
      point += 9 ;		/* skip the SeeAlso: */
      if (point < start)	/* if we were originally to the right of     */
	 point = start ;	/* current position, go back to original pos */
      grab_int_reference(def_entry) ;
      get_strdef(entry_name,"Goto Interrupt",def_entry) ;
      }
   else if (line_has_see_also())
      {
      grab_int_reference(def_entry) ;
      get_strdef(entry_name,"Goto Interrupt",def_entry) ;
      }
   else
      get_string(entry_name,"Goto Interrupt: ") ;
   point = start ;
   goto_entry(entry_name) ;
   if (has_arg)
      iter = 1 ;
}

/*=============================================================*/
/*=============================================================*/

void maybe_append_table_number()
{
   if (parse_string(1,".*\t%(Table ",0) == 0)
      {
      int matchsize ;
      /* if the pattern didn't match, there is no table number, */
      /* so add it */
      to_end_line() ;
      matchsize = parse_string(-1,"[ \t]+",0) ;
      if (matchsize)
	 delete(point-matchsize,point) ;
      stuff("\t") ;
      insert_table_counter() ;
      }
}

/*=============================================================*/
/*=============================================================*/

void fix_unnumbered_tables()
{
   spot start = alloc_spot(1) ;
   
   *start = point ;
   point = 0 ;
   while (search(1,"\n\n"))
      {
      switch(curchar())
	 {
	 case 'C':
	    if (parse_string(1,"Call ") != 0)
	       {
	       /* we got Call..., we know it doesn't have a table number */
	       insert_table_counter() ;
	       stuff("\n") ;
	       }
	    break ;
	 case 'V':
	    if (parse_string(1,"Values ") != 0)
	       {
	       /* we know this Values... doesn't have a table number */
	       insert_table_counter() ;
	       stuff("\n") ;
	       }
	    break ;
	 case 'B':
	    if (parse_string(1,"Bitfields ",0) == 0)
	       break ;
	    nl_forward() ;    /* skip to start of next line */
	    maybe_append_table_number() ;
	    break ;
	 case 'F':
	    if (parse_string(1,"Format ",0) == 0)
	       break ;
	    nl_forward() ;    /* skip to start of next line */
	    maybe_append_table_number() ;
	    break ;
	 default:
	    /* not a table header, so ignore it */
	    break ;
	 }
      }
   point = *start ;
   free_spot(start) ;
}

/*=============================================================*/
/*=============================================================*/

int *gather_table_numbers(new_numbers)
int *new_numbers ;
{
   int tcount[9] ;
   char counter[6] ;
   int old_number ;
   int table_type ;
   spot start = alloc_spot(1) ;
   save_var case_fold = 0 ;
   
   tcount[0] = tcount[1] = tcount[2] = tcount[3] = tcount[4] = tcount[5] = 0 ;
   tcount[6] = tcount[7] = tcount[8] = 0 ;
   *start = point ;
   point = 0 ;
   while (search(1,"(Table "))
      {
      char *tbl ;
      int table_offset ;
      grab(point,point+5,counter) ;
      tbl = index(table_ID_letters,counter[0]) ;
      if (tbl)
	 table_offset = (tbl-table_ID_letters) ;
      else
	 table_offset = 0 ;
      old_number = strtoi(counter+1,10) + 10000*table_offset ;
      table_type = (table_offset >= ID_LETTER_OFFSET)
		     ? (table_offset-ID_LETTER_OFFSET+1)
		     : 0 ;
      new_numbers[old_number] = ++(tcount[table_type]) ;
      }
   point = *start ;
   free_spot(start) ;
   return new_numbers ;
}

/*=============================================================*/
/*=============================================================*/

int adjust_table_numbers(new_numbers, dangling)
int *new_numbers ;
int dangling ;
{
   char counter[6] ;
   int old_number ;
   int old_type ;
   char *tbl ;
   int table_offset ;
   spot start = alloc_spot(1) ;
   
   *start = point ;
   point = 0 ;
   while (search(1,"(Table "))
      {
      grab(point,point+5,counter) ;
      tbl = index(table_ID_letters,counter[0]) ;
      if (tbl)
	 {
	 table_offset = 10000*(tbl-table_ID_letters) ;
	 }
      else
	 table_offset = 0 ;
      old_number = strtoi(counter+1,10) + table_offset ;
      old_type = (counter[0] >= '0' && counter[0] <= '9') ? 0 : counter[0] ;
      if (old_number > 0)
	 {
	 delete(point,point+5) ;
	 if (old_type)
	    bprintf("%c%04d",old_type,new_numbers[old_number]%10000) ;
	 else
	    bprintf("%05d",new_numbers[old_number]) ;
	 }
      }
   point = 0 ;
   while (re_search(1,"[, \t]%#[0-9CFIMPRS][0-9][0-9][0-9][0-9]"))
      {
      grab(point-5,point,counter) ;
      tbl = index(table_ID_letters,counter[0]) ;
      if (tbl)
	 table_offset = 10000*(tbl-table_ID_letters) ;
      else
	 table_offset = 0 ;
      old_number = strtoi(counter+1,10) + table_offset ;
      old_type = (counter[0] >= '0' && counter[0] <= '9') ? 0 : counter[0] ;
      if (old_number > 0)
	 {
	 if (new_numbers[old_number])
	    {
	    delete(point-5,point) ;
	    if (old_type)
	       bprintf("%c%04d",old_type,new_numbers[old_number]) ;
	    else
	       bprintf("%05d",new_numbers[old_number]) ;
	    }
	 else /* dangling xref */
	    {
	    dangling++ ;
	    point -= 5 ;
	    stuff("?") ;
	    point += 5 ;
	    }
	 }
      }
   point = *start ;
   free_spot(start) ;
   return dangling ;
}

/*=============================================================*/
/*=============================================================*/

int get_list_file(list_file)
char *list_file ;
{
   char abs_filename[FNAMELEN] ;
   strcpy(abs_filename,list_file) ;
   absolute(abs_filename) ;
   return find_it(abs_filename,1) ;
}

/*=============================================================*/
/*=============================================================*/

command renumber_tables()
{
   int *new_numbers ;
   int num_tables ;
   int dangling ;
   int i ;
   
   for (i = 0 ; list_files[i] ; i++)
      {
      if (get_list_file(list_files[i]) == 0)
	 {
	 say("Renumber Pass 1: numbering unnumbered tables (%s)",
	     list_files[i]) ;
	 fix_unnumbered_tables() ;
	 }
      else
	 say("Renumber Pass 1: forced to skip %s") ;
      }
   num_tables = 10000*strlen(table_ID_letters) ;
   new_numbers = (int*)malloc(num_tables*sizeof(int)) ;
   if (!new_numbers)
      {
      say("Out of memory!") ;
      return ;
      }
   for (i = 0 ; i < num_tables ; i++)
      new_numbers[i] = 0 ;
   for (i = 0 ; list_files[i] ; i++)
      {
      if (get_list_file(list_files[i]) == 0)
	 {
	 say("Renumber Pass 2: gathering table numbers (%s)",
	     list_files[i]) ;
	 gather_table_numbers(new_numbers) ;
	 }
      else
	 say("Renumber Pass 2: forced to skip %s") ;
      }
   dangling = 0 ;
   for (i = 0 ; list_files[i] ; i++)
      {
      if (get_list_file(list_files[i]) == 0)
	 {
	 say("Renumber Pass 3: adjusting table numbers (%s)",
	     list_files[i]) ;
	 dangling = adjust_table_numbers(new_numbers,dangling) ;
	 }
      else
	 say("Renumber Pass 3: forced to skip %s") ;
      }
   free(new_numbers) ;
   if (dangling)
      say("%d dangling cross-references, search for '#?'",dangling) ;
   else
      say("Done") ;
}

/*=============================================================*/
/*=============================================================*/

command make_distribution()
{
   int i ;
   
   for (i = 0 ; list_files[i] ; i++)
      {
      /* switch to proper buffer, or load if not yet in a buffer */
      if (get_list_file(list_files[i]) == 0)
	 {
	 say("Setting divider lines (%s)",list_files[i]) ;
	 point = size() ;
	 while (point > 0)
	    if (!number_one_int())
	       break ;
	 }
      else
	 say("Forced to skip %s !",list_files[i]) ;
      }
   for (i = 0 ; list_files[i] ; i++)
      {
      /* switch to proper buffer, or load if not yet in a buffer */
      if (get_list_file(list_files[i]) == 0)
	 {
	 say("Tabifying file (%s)",list_files[i]) ;
	 mark = 0 ;
	 point = size() ;
	 tabify_region() ;
	 }
      }
   renumber_tables() ;
   save_all_buffers() ;
   say("Ready for distribution") ;
   point = 0 ;
   /* !!! should also split main list automatically */
}

/*=============================================================*/
/*=============================================================*/

void find_table_counter()
{
   save_var point = (size() > 8000) ? size() - 8000 : 0 ;

   search(1,"Highest Table Number = ") ;
   table_counter = alloc_spot(1) ;
}

/*=============================================================*/
/*=============================================================*/

char filter_cmd[128] = "" ;

command filter_region()
{
   char new_filter_cmd[128] ;
   get_strdef(new_filter_cmd,"Filter region through",filter_cmd) ;
   strcpy(filter_cmd,new_filter_cmd) ;
   if (filter_cmd[0] != 0)
      {
      int size ;
      int fd ;
      char *commandline ;
      char *argptr ;
      int numargs = 0 ;
      char filename[128] ;
      char outputfile[128] ;
      int start = point ;
      int end = mark ;
      if (end < start)
	 {
	 start = mark ;
	 end = point ;
	 }
      size = end - start ;
      make_temp_file(filename,3*size) ;
      /* Eps7.0 always generates same temp file!  Thus, we have to manually */
      /* generate a second file name for use as the output file */
      strcpy(outputfile,filename) ;
      strcat(outputfile,"_2") ;
      delete_file(filename) ;
      if (write_part(filename,strip_returns,start,end) != 0)
	 {
	 delete_file(filename) ;
	 return ;
	 }
      fd = lowopen(outputfile,3) ;
      if (fd != -1)
	 lowclose(fd) ;
      /* execute the command on the temporary file */
      commandline = malloc(strlen(filter_cmd)+strlen(filename)+strlen(outputfile)+6) ;
      if (!commandline)
	 {
	 say("out of memory....") ;
	 delete_file(filename) ;
	 return ;
	 }
      argptr = strstr(filter_cmd,"%s") ;
      if (argptr)
	 {
	 numargs++ ;
	 argptr = strstr(argptr+1,"%s") ;
	 if (argptr)
	    numargs++ ;
	 }
      switch (numargs)
	 {
	 case 0:
	    sprintf(commandline,"%s <%s >%s",filter_cmd,filename,outputfile) ;
	    break ;
	 case 1:
	    sprintf(commandline,filter_cmd,filename) ;
	    strcat(commandline," >") ;
	    strcat(commandline,outputfile) ;
	    break ;
	 case 2:
	    sprintf(commandline,filter_cmd,filename,outputfile) ;
	    break ;
	 }
      shell("",commandline,"") ;
      free(commandline) ;
      delete_file(filename) ;
      /* read back the result of the filtering */
      kill_region() ;
      if (do_insert_file(outputfile,strip_returns) != 0)
	 {
	 kill_region() ; 	/* remove any partially-read data */
	 yank() ;		/* restore region to pre-filter state */
	 }
      delete_file(outputfile) ;
      }
}

/*=============================================================*/
/*  Coloring functions for Epsilon v7.0+		       */
/*=============================================================*/

#if EELVERSION >= 70
int int_recolor_range(from, to)
int from, to ;
{
   if (from >= to)
      return to ;
   set_character_color(from,to,-1) ;
   save_var point, matchstart, matchend ;
   point = from ;
   if (to > size())
      to = size() ;
   while (point < to)
      {
      int start = point ;
      int len ;
      char c = curchar() ;
      if (c >= 'A' && c <= 'V')
	 {
	 if (parse_string(1,table_headers,NULL) != 0)
	    {
	    nl_forward() ;
	    point-- ;
	    set_character_color(start,point,color_class c_comment) ;
	    }
	 else if ((len = parse_string(1,all_sections,NULL)) > 0)
	    set_character_color(start,start+len,color_class c_function) ;
	 }
      else if (c == '\t' &&
	       (len = parse_string(1,indented_sections,NULL)) != 0)
	 {
	 while (curchar() == '\t')
	    {
	    point++ ;
	    len-- ;
	    }
	 set_character_color(point,point+len,color_class c_function) ;
	 }
      nl_forward() ;
      }
   return point ;
}
#endif /* Epsilon v7.0+ */

#if EELVERSION >= 70
int int_recolor_from_here(safe)
int safe ;
{
   save_var point ;
   if (safe != point)
      {
      to_begin_line() ;			/* start of line is always 'safe' */
      }
   return point ;
}
#endif /* Epsilon v7.0+ */

/*=============================================================*/
/* Put the current buffer into IntList major mode	       */
/*=============================================================*/

command intlist_mode()
{
   mode_keys = intlist_tab ;
   intlist_tab[')'] = intlist_tab[']'] = (short) show_matching_delimiter;
   delete_hacking_tabs = 0 ;
   major_mode = strsave("IntList") ;
   auto_indent = 0 ;
   margin_right = 79 ;
   want_backups = 1 ;
   undo_size = 200000 ;     /* less than default 500,000 since list is so big */
   find_table_counter() ;
#if EELVERSION >= 70
   recolor_range = int_recolor_range ;
   recolor_from_here = int_recolor_from_here ;
   if (want_code_coloring)
      when_setting_want_code_coloring() ;
#endif /* Epsilon v7.0+ */
   make_mode() ;
}

when_loading()
{
   char *curbuf ;
   int i ;
   
   want_backups = want_backups.default = 1 ;
   strcpy(backup_name,"%pbak/%b%e") ;		/* put backups in BAK subdir */
   one_window() ;
   intlist_mode() ;
   if (exist("interrup.1st"))
      {
      curbuf = bufname ;
      bufname = "interrup.1st" ;
      intlist_mode() ;
      want_code_coloring = 0 ;
      when_setting_want_code_coloring() ;
      bufname = curbuf ;
      }
   for (i = 0 ; list_files[i] ; i++)
      {
      if (exist(list_files[i]))
	 {
	 curbuf = bufname ;
	 bufname = list_files[i] ;
	 intlist_mode() ;
	 bufname = curbuf ;
	 }
      }
#if EELVERSION >= 70
   strcpy(mode_end," %d%p%S%>C%c") ;
#endif /* Epsilon v7.0+ */
#if EELVERSION >= 60 && EELVERSION < 70
   strcpy(mode_end," %d%p%S") ;
#endif /* Epsilon v6.x */
}

/*=============================================================*/
/* automagically switch into interrupt list mode on .LST and .1ST files */

suffix_lst()   { intlist_mode(); }
suffix_1st()   { intlist_mode(); }

/* end of file intlist.e */
