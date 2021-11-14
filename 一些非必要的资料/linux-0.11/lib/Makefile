#
# Makefile for some libs needed in the kernel.
#
# Note! Dependencies are done automagically by 'make dep', which also
# removes any old dependencies. DON'T put your own dependencies here
# unless it's something special (ie not a .c file).
#

AR	=gar
AS	=gas
LD	=gld
LDFLAGS	=-s -x
CC	=gcc
CFLAGS	=-Wall -O -fstrength-reduce -fomit-frame-pointer -fcombine-regs \
	-finline-functions -mstring-insns -nostdinc -I../include
CPP	=gcc -E -nostdinc -I../include

.c.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<

OBJS  = ctype.o _exit.o open.o close.o errno.o write.o dup.o setsid.o \
	execve.o wait.o string.o malloc.o

lib.a: $(OBJS)
	$(AR) rcs lib.a $(OBJS)
	sync

clean:
	rm -f core *.o *.a tmp_make
	for i in *.c;do rm -f `basename $$i .c`.s;done

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.c;do echo -n `echo $$i | sed 's,\.c,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile

### Dependencies:
_exit.s _exit.o : _exit.c ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
close.s close.o : close.c ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
ctype.s ctype.o : ctype.c ../include/ctype.h 
dup.s dup.o : dup.c ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
errno.s errno.o : errno.c 
execve.s execve.o : execve.c ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
malloc.s malloc.o : malloc.c ../include/linux/kernel.h ../include/linux/mm.h \
  ../include/asm/system.h 
open.s open.o : open.c ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h ../include/stdarg.h 
setsid.s setsid.o : setsid.c ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
string.s string.o : string.c ../include/string.h 
wait.s wait.o : wait.c ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h ../include/sys/wait.h 
write.s write.o : write.c ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
