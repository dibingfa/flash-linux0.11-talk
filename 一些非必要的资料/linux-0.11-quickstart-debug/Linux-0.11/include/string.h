#ifndef _STRING_H_
#define _STRING_H_

#ifndef NULL
#define NULL ((void *) 0)
#endif

#ifndef _SIZE_T
#define _SIZE_T
typedef unsigned int size_t;
#endif

extern char * strerror(int errno);

/*
 * This string-include defines all string functions as inline
 * functions. Use gcc. It also assumes ds=es=data space, this should be
 * normal. Most of the string-functions are rather heavily hand-optimized,
 * see especially strtok,strstr,str[c]spn. They should work, but are not
 * very easy to understand. Everything is done entirely within the register
 * set, making the functions fast and clean. String instructions have been
 * used through-out, making for "slightly" unclear code :-)
 *
 *		(C) 1991 Linus Torvalds
 */
 
extern inline char * strcpy(char * dest,const char *src)
{
__asm__("cld\n"
	"1:\tlodsb\n\t"
	"stosb\n\t"
	"testb %%al,%%al\n\t"
	"jne 1b"
	::"S" (src),"D" (dest));
return dest;
}

static inline char * strncpy(char * dest,const char *src,int count)
{
__asm__("cld\n"
	"1:\tdecl %2\n\t"
	"js 2f\n\t"
	"lodsb\n\t"
	"stosb\n\t"
	"testb %%al,%%al\n\t"
	"jne 1b\n\t"
	"rep\n\t"
	"stosb\n"
	"2:"
	::"S" (src),"D" (dest),"c" (count));
return dest;
}

extern inline char * strcat(char * dest,const char * src)
{
__asm__("cld\n\t"
	"repne\n\t"
	"scasb\n\t"
	"decl %1\n"
	"1:\tlodsb\n\t"
	"stosb\n\t"
	"testb %%al,%%al\n\t"
	"jne 1b"
	::"S" (src),"D" (dest),"a" (0),"c" (0xffffffff));
return dest;
}

static inline char * strncat(char * dest,const char * src,int count)
{
__asm__("cld\n\t"
	"repne\n\t"
	"scasb\n\t"
	"decl %1\n\t"
	"movl %4,%3\n"
	"1:\tdecl %3\n\t"
	"js 2f\n\t"
	"lodsb\n\t"
	"stosb\n\t"
	"testb %%al,%%al\n\t"
	"jne 1b\n"
	"2:\txorl %2,%2\n\t"
	"stosb"
	::"S" (src),"D" (dest),"a" (0),"c" (0xffffffff),"g" (count)
	);
return dest;
}

extern inline int strcmp(const char * cs,const char * ct)
{
register int __res ;
__asm__("cld\n"
	"1:\tlodsb\n\t"
	"scasb\n\t"
	"jne 2f\n\t"
	"testb %%al,%%al\n\t"
	"jne 1b\n\t"
	"xorl %%eax,%%eax\n\t"
	"jmp 3f\n"
	"2:\tmovl $1,%%eax\n\t"
	"jl 3f\n\t"
	"negl %%eax\n"
	"3:"
	:"=a" (__res):"D" (cs),"S" (ct));
return __res;
}

static inline int strncmp(const char * cs,const char * ct,int count)
{
register int __res ;
__asm__("cld\n"
	"1:\tdecl %3\n\t"
	"js 2f\n\t"
	"lodsb\n\t"
	"scasb\n\t"
	"jne 3f\n\t"
	"testb %%al,%%al\n\t"
	"jne 1b\n"
	"2:\txorl %%eax,%%eax\n\t"
	"jmp 4f\n"
	"3:\tmovl $1,%%eax\n\t"
	"jl 4f\n\t"
	"negl %%eax\n"
	"4:"
	:"=a" (__res):"D" (cs),"S" (ct),"c" (count));
return __res;
}

static inline char * strchr(const char * s,char c)
{
register char * __res ;
__asm__("cld\n\t"
	"movb %%al,%%ah\n"
	"1:\tlodsb\n\t"
	"cmpb %%ah,%%al\n\t"
	"je 2f\n\t"
	"testb %%al,%%al\n\t"
	"jne 1b\n\t"
	"movl $1,%1\n"
	"2:\tmovl %1,%0\n\t"
	"decl %0"
	:"=a" (__res):"S" (s),"0" (c));
return __res;
}

static inline char * strrchr(const char * s,char c)
{
register char * __res; 
__asm__("cld\n\t"
	"movb %%al,%%ah\n"
	"1:\tlodsb\n\t"
	"cmpb %%ah,%%al\n\t"
	"jne 2f\n\t"
	"movl %%esi,%0\n\t"
	"decl %0\n"
	"2:\ttestb %%al,%%al\n\t"
	"jne 1b"
	:"=d" (__res):"0" (0),"S" (s),"a" (c));
return __res;
}

extern inline int strspn(const char * cs, const char * ct)
{
register char * __res;
__asm__("cld\n\t"
	"movl %4,%%edi\n\t"
	"repne\n\t"
	"scasb\n\t"
	"notl %%ecx\n\t"
	"decl %%ecx\n\t"
	"movl %%ecx,%%edx\n"
	"1:\tlodsb\n\t"
	"testb %%al,%%al\n\t"
	"je 2f\n\t"
	"movl %4,%%edi\n\t"
	"movl %%edx,%%ecx\n\t"
	"repne\n\t"
	"scasb\n\t"
	"je 1b\n"
	"2:\tdecl %0"
	:"=S" (__res):"a" (0),"c" (0xffffffff),"0" (cs),"g" (ct)
	);
return __res-cs;
}

extern inline int strcspn(const char * cs, const char * ct)
{
register char * __res;
__asm__("cld\n\t"
	"movl %4,%%edi\n\t"
	"repne\n\t"
	"scasb\n\t"
	"notl %%ecx\n\t"
	"decl %%ecx\n\t"
	"movl %%ecx,%%edx\n"
	"1:\tlodsb\n\t"
	"testb %%al,%%al\n\t"
	"je 2f\n\t"
	"movl %4,%%edi\n\t"
	"movl %%edx,%%ecx\n\t"
	"repne\n\t"
	"scasb\n\t"
	"jne 1b\n"
	"2:\tdecl %0"
	:"=S" (__res):"a" (0),"c" (0xffffffff),"0" (cs),"g" (ct)
	);
return __res-cs;
}

extern inline char * strpbrk(const char * cs,const char * ct)
{
register char * __res ;
__asm__("cld\n\t"
	"movl %4,%%edi\n\t"
	"repne\n\t"
	"scasb\n\t"
	"notl %%ecx\n\t"
	"decl %%ecx\n\t"
	"movl %%ecx,%%edx\n"
	"1:\tlodsb\n\t"
	"testb %%al,%%al\n\t"
	"je 2f\n\t"
	"movl %4,%%edi\n\t"
	"movl %%edx,%%ecx\n\t"
	"repne\n\t"
	"scasb\n\t"
	"jne 1b\n\t"
	"decl %0\n\t"
	"jmp 3f\n"
	"2:\txorl %0,%0\n"
	"3:"
	:"=S" (__res):"a" (0),"c" (0xffffffff),"0" (cs),"g" (ct)
	);
return __res;
}

extern inline char * strstr(const char * cs,const char * ct)
{
register char * __res ;
__asm__("cld\n\t" \
	"movl %4,%%edi\n\t"
	"repne\n\t"
	"scasb\n\t"
	"notl %%ecx\n\t"
	"decl %%ecx\n\t"	/* NOTE! This also sets Z if searchstring='' */
	"movl %%ecx,%%edx\n"
	"1:\tmovl %4,%%edi\n\t"
	"movl %%esi,%%eax\n\t"
	"movl %%edx,%%ecx\n\t"
	"repe\n\t"
	"cmpsb\n\t"
	"je 2f\n\t"		/* also works for empty string, see above */
	"xchgl %%eax,%%esi\n\t"
	"incl %%esi\n\t"
	"cmpb $0,-1(%%eax)\n\t"
	"jne 1b\n\t"
	"xorl %%eax,%%eax\n\t"
	"2:"
	:"=a" (__res):"0" (0),"c" (0xffffffff),"S" (cs),"g" (ct)
	);
return __res;
}

extern inline int strlen(const char * s)
{
register int __res ;
__asm__("cld\n\t"
	"repne\n\t"
	"scasb\n\t"
	"notl %0\n\t"
	"decl %0"
	:"=c" (__res):"D" (s),"a" (0),"0" (0xffffffff));
return __res;
}

extern char * ___strtok;

extern inline char * strtok(char * s,const char * ct)
{
register char * __res ;
__asm__("testl %1,%1\n\t"
	"jne 1f\n\t"
	"testl %0,%0\n\t"
	"je 8f\n\t"
	"movl %0,%1\n"
	"1:\txorl %0,%0\n\t"
	"movl $-1,%%ecx\n\t"
	"xorl %%eax,%%eax\n\t"
	"cld\n\t"
	"movl %4,%%edi\n\t"
	"repne\n\t"
	"scasb\n\t"
	"notl %%ecx\n\t"
	"decl %%ecx\n\t"
	"je 7f\n\t"			/* empty delimeter-string */
	"movl %%ecx,%%edx\n"
	"2:\tlodsb\n\t"
	"testb %%al,%%al\n\t"
	"je 7f\n\t"
	"movl %4,%%edi\n\t"
	"movl %%edx,%%ecx\n\t"
	"repne\n\t"
	"scasb\n\t"
	"je 2b\n\t"
	"decl %1\n\t"
	"cmpb $0,(%1)\n\t"
	"je 7f\n\t"
	"movl %1,%0\n"
	"3:\tlodsb\n\t"
	"testb %%al,%%al\n\t"
	"je 5f\n\t"
	"movl %4,%%edi\n\t"
	"movl %%edx,%%ecx\n\t"
	"repne\n\t"
	"scasb\n\t"
	"jne 3b\n\t"
	"decl %1\n\t"
	"cmpb $0,(%1)\n\t"
	"je 5f\n\t"
	"movb $0,(%1)\n\t"
	"incl %1\n\t"
	"jmp 6f\n"
	"5:\txorl %1,%1\n"
	"6:\tcmpb $0,(%0)\n\t"
	"jne 7f\n\t"
	"xorl %0,%0\n"
	"7:\ttestl %0,%0\n\t"
	"jne 8f\n\t"
	"movl %0,%1\n"
	"8:"
	:"=b" (__res),"=S" (___strtok)
	:"0" (___strtok),"1" (s),"g" (ct)
	);
return __res;
}

static inline void * memcpy(void * dest,const void * src, int n)
{
__asm__("cld\n\t"
	"rep\n\t"
	"movsb"
	::"c" (n),"S" (src),"D" (dest)
	);
return dest;
}

extern inline void * memmove(void * dest,const void * src, int n)
{
if (dest<src)
__asm__("cld\n\t"
	"rep\n\t"
	"movsb"
	::"c" (n),"S" (src),"D" (dest)
	);
else
__asm__("std\n\t"
	"rep\n\t"
	"movsb"
	::"c" (n),"S" (src+n-1),"D" (dest+n-1)
	);
return dest;
}

static inline int memcmp(const void * cs,const void * ct,int count)
{
register int __res ;
__asm__("cld\n\t"
	"repe\n\t"
	"cmpsb\n\t"
	"je 1f\n\t"
	"movl $1,%%eax\n\t"
	"jl 1f\n\t"
	"negl %%eax\n"
	"1:"
	:"=a" (__res):"0" (0),"D" (cs),"S" (ct),"c" (count)
	);
return __res;
}

extern inline void * memchr(const void * cs,char c,int count)
{
register void * __res ;
if (!count)
	return NULL;
__asm__("cld\n\t"
	"repne\n\t"
	"scasb\n\t"
	"je 1f\n\t"
	"movl $1,%0\n"
	"1:\tdecl %0"
	:"=D" (__res):"a" (c),"D" (cs),"c" (count)
	);
return __res;
}

static inline void * memset(void * s,char c,int count)
{
__asm__("cld\n\t"
	"rep\n\t"
	"stosb"
	::"a" (c),"D" (s),"c" (count)
	);
return s;
}

#endif
