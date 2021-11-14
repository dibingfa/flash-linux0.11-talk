#
# if you want the ram-disk device, define this to be the
# size in blocks.
#
RAMDISK =  #-DRAMDISK=512

#AS86	=as86 -0 -a
#LD86	=ld86 -0

INC=boot
AS86 = nasm 
DASM = ndisasm

AS	=as
LD	=ld
#LDFLAGS	= -m elf_i386 -Ttext 0 -e startup_32
LDFLAGS	  = -m i386pe   -Ttext 0 -e startup_32 -s -M --image-base 0x0000 
CC	=gcc -march=i386 $(RAMDISK)
CFLAGS	=-Wall -O2 -fomit-frame-pointer -fno-builtin



CPP	=cpp -nostdinc -Iinclude

#
# ROOT_DEV specifies the default root-device when making the image.
# This can be either FLOPPY, /dev/xxxx or empty, in which case the
# default of /dev/hd6 is used by 'build'.
#
ROOT_DEV= #FLOPPY 

BLK_DRV_SRC  = kernel/blk_drv/ll_rw_blk.c kernel/blk_drv/floppy.c \
                kernel/blk_drv/hd.c kernel/blk_drv/ramdisk.c

CHR_DRV_SRC  = kernel/chr_drv/tty_io.c kernel/chr_drv/console.c kernel/chr_drv/keyboard.s \
        kernel/chr_drv/serial.c kernel/chr_drv/rs_io.s \
	      kernel/chr_drv/tty_ioctl.s

KERNEL_SRC  = kernel/sched.c kernel/system_call.s kernel/traps.s kernel/asm.s kernel/fork.c \
	kernel/panic.c kernel/printk.c kernel/vsprintf.c kernel/sys.c kernel/exit.c \
	kernel/signal.c kernel/mktime.c

MM_SRC	= mm/memory.c mm/page.s

FS_SRC=	fs/open.c fs/read_write.c fs/inode.c fs/file_table.c fs/buffer.c fs/super.c \
	fs/block_dev.c fs/char_dev.c fs/file_dev.c fs/stat.c fs/exec.c fs/pipe.c fs/namei.c \
	fs/bitmap.c fs/fcntl.c fs/ioctl.c fs/truncate.c

LIB_SRC  = lib/ctype.c lib/_exit.c lib/open.c lib/close.c lib/errno.c lib/write.c lib/dup.c lib/setsid.c \
	lib/execve.c lib/wait.c lib/string.c lib/malloc.c

ARCHIVES=kernel/kernel.o mm/mm.o fs/fs.o
#ARCHIVES=$(KERNEL_OBJS) mm/mm.o fs/fs.o

DRIVERS =kernel/blk_drv/blk_drv.a kernel/chr_drv/chr_drv.a

MATH	=kernel/math/math.a
LIBS	=lib/lib.a

.c.s:
	$(CC) $(CFLAGS) \
	-nostdinc -Iinclude -S -o $*.s $<
.s.o:
	$(AS)  -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) \
	-nostdinc -Iinclude -c -o $*.o $<

all:	Boot.img

KERNEL_FILE = tools/system.bin

tools/system.bin : tools/system.exe 
	tools/Trans.exe tools/System.exe tools/system.bin
	
Boot.img: boot/bootsect.bin boot/setup.bin $(KERNEL_FILE) tools/build.exe Makefile
#	objcopy -O binary -R .note -R .comment tools/system tools/kernel
	tools\build.exe boot/bootsect.bin boot/setup.bin $(KERNEL_FILE) $(ROOT_DEV)
#	rm tools/kernel -f
#	sync
#	del tools\kernel
	
disk: Image
	dd bs=8192 if=Image of=/dev/fd0

tools/build.exe: tools/build.c
	$(CC) $(CFLAGS)	-o tools/build tools/build.c

boot/head.o: boot/head.s
	gcc -I./include -traditional -c boot/head.s -o boot/head.o
#	move head.o boot/

tools/system.exe:	boot/head.o init/main.o \
		$(ARCHIVES) $(DRIVERS) $(MATH) $(LIBS)
	$(LD) $(LDFLAGS) boot/head.o init/main.o \
	$(ARCHIVES) \
	$(DRIVERS) \
	$(MATH) \
	$(LIBS) \
	-o tools/system.exe >system.map
#	nm tools/system | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aU] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)'| sort > System.map 

kernel/math/math.a:kernel/math/math_emulate.o
#	(cd kernel/math ; make)
	(cd kernel/math & make)
	
kernel/blk_drv/blk_drv.a:$(BLK_DRV_SRC)
#	(cd kernel/blk_drv ; make)
	(cd kernel/blk_drv & make)
	
kernel/chr_drv/chr_drv.a:$(CHR_DRV_SRC)
#	(cd kernel/chr_drv ; make)
	(cd kernel/chr_drv & make)
	
kernel/kernel.o:$(KERNEL_SRC)
#	(cd kernel; make)
	(cd kernel & make)

mm/mm.o:$(MM_SRC)
#	(cd mm; make)
	(cd mm & make)
	
fs/fs.o:$(FS_SRC)
#	(cd fs; make)
	(cd fs & make)
	
lib/lib.a:$(LIB_SRC)
	(cd lib & make)

boot/setup.bin: boot/setup.asm 
	$(AS86) -I"$(INC)"\ -o boot/setup.bin boot/setup.asm
	 $(DASM) -b 16 boot/setup.bin >boot/setup.disasm
#	$(LD86) -s -o boot/setup boot/setup.o
 
boot/bootsect.bin:	boot/bootsect.asm 
	$(AS86) -I"$(INC)"\ -o boot/bootsect.bin boot/bootsect.asm
	$(DASM) -b 16 boot/bootsect.bin >boot/bootsect.disasm
#	$(LD86) -s -o boot/bootsect boot/bootsect.o

tmp.s:	boot/bootsect.s tools/system
#	(echo -n "SYSSIZE = (";ls -l tools/system | grep system \
#		| cut -c25-31 | tr '\012' ' '; echo "+ 15 ) / 16") > tmp.s
	cat boot/bootsect.s >> tmp.s

clean:
#	rm -f Image System.map tmp_make core boot/bootsect boot/setup
#	rm -f init/*.o tools/system tools/build boot/*.o
#	(cd mm;make clean)
#	(cd fs;make clean)
#	(cd kernel;make clean)
#	(cd lib;make clean)
	@del /S /Q *.a *.o system.map tools\system.exe
#	del Image System.map tmp_make core boot\bootsect boot\setup
#	del init\*.o tools\system tools\build boot\*.o
#	(cd mm & make clean)
#	(cd fs & make clean)
#	(cd kernel & make clean)
#	(cd lib &make clean)


backup: clean
	(cd .. ; tar cf - linux | compress16 - > backup.Z)
	sync

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in init/*.c;do echo -n "init/";$(CPP) -M $$i;done) >> tmp_make
#	cp tmp_make Makefile
#	(cd fs; make dep)
#	(cd kernel; make dep)
#	(cd mm; make dep)
	
	copy tmp_make Makefile
	(cd fs & make dep)
	(cd kernel & make dep)
	(cd mm & make dep)

### Dependencies:
init/main.o: init/main.c include/unistd.h include/sys/stat.h \
  include/sys/types.h include/sys/times.h include/sys/utsname.h \
  include/utime.h include/time.h include/linux/tty.h include/termios.h \
  include/linux/sched.h include/linux/head.h include/linux/fs.h \
  include/linux/mm.h include/signal.h include/asm/system.h \
  include/asm/io.h include/stddef.h include/stdarg.h include/fcntl.h
