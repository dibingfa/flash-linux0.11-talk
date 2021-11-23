x86 中断函数列表

一开始从 stackoverflow 上找到这个网站：
[http://www.ctyme.com/intr/int.htm](http://www.ctyme.com/intr/int.htm)

但是没找到下载地址，所以又搜了下找到了这个网站[Public Files on FTP.CS.CMU.EDU](https://www.cs.cmu.edu/~ralf/files.html)

目录和文件（可按文本格式打开）按照字母序，比如 `inter61a/INTERRUP.A` 包含了 `INT 00` 到 `INT 10`

文中会对指令作出较为详细的描述，以 [最近一篇文章中](https://mp.weixin.qq.com/s/hStc-y-sabP-KwJUDUesTw)的
[INT 13](https://github.com/sunym1993/flash-linux0.11-talk/blob/547ef4b440ff2ed1be2204e459316a39e9a734fc/%E4%B8%80%E4%BA%9B%E9%9D%9E%E5%BF%85%E8%A6%81%E7%9A%84%E8%B5%84%E6%96%99/linux-0.11/boot/bootsect.s#L71) 
为例, 可以看到给 `AX` 赋值了 `#0x0200+SETUPLEN -> #0x0204` 即 `AH=02`

```assembly
mov	ax,#0x0200+SETUPLEN	; service 2, nr of sectors
int	0x13

jnc	ok_load_setup		; ok - continue
```

对应在 `inter61a/INTERRUP.B` 找到如下描述，可知 `CF` 用来做错误位设置，clear 时标志成功，
自然猜测接下来的 `jnc` 指令就是为了检查 READ SECTOR(S) INTO MEMORY 这一操作是否成功。

```shell
INT 13 - DISK - READ SECTOR(S) INTO MEMORY
	AH = 02h
	AL = number of sectors to read (must be nonzero)
	CH = low eight bits of cylinder number
	CL = sector number 1-63 (bits 0-5)
	     high two bits of cylinder (bits 6-7, hard disk only)
	DH = head number
	DL = drive number (bit 7 set for hard disk)
	ES:BX -> data buffer
Return: CF set on error
	    if AH = 11h (corrected ECC error), AL = burst length
	CF clear if successful
	AH = status (see #00234)
	AL = number of sectors transferred (only valid if CF set for some
	      BIOSes)
Notes:	errors on a floppy may be due to the motor failing to spin up quickly
	  enough; the read should be retried at least three times, resetting
	  the disk with AH=00h between attempts
	most BIOSes support "multitrack" reads, where the value in AL
	  exceeds the number of sectors remaining on the track, in which
	  case any additional sectors are read beginning at sector 1 on
	  the following head in the same cylinder; the MSDOS CONFIG.SYS command
	  MULTITRACK (or the Novell DOS DEBLOCK=) can be used to force DOS to
	  split disk accesses which would wrap across a track boundary into two
	  separate calls
	the IBM AT BIOS and many other BIOSes use only the low four bits of
	  DH (head number) since the WD-1003 controller which is the standard
	  AT controller (and the controller that IDE emulates) only supports
	  16 heads
	AWARD AT BIOS and AMI 386sx BIOS have been extended to handle more
	  than 1024 cylinders by placing bits 10 and 11 of the cylinder number
	  into bits 6 and 7 of DH
	under Windows95, a volume must be locked (see INT 21/AX=440Dh/CX=084Bh)
	  in order to perform direct accesses such as INT 13h reads and writes
	all versions of MS-DOS (including MS-DOS 7 [Windows 95]) have a bug
	  which prevents booting on hard disks with 256 heads (FFh), so many
	  modern BIOSes provide mappings with at most 255 (FEh) heads
	some cache drivers flush their buffers when detecting that DOS is
	  bypassed by directly issuing INT 13h from applications.  A dummy
	  read can be used as one of several methods to force cache
	  flushing for unknown caches (e.g. before rebooting).
BUGS:	When reading from floppies, some AMI BIOSes (around 1990-1991) trash
	  the byte following the data buffer, if it is not arranged to an even
	  memory boundary.  A workaround is to either make the buffer word
	  aligned (which may also help to speed up things), or to add a dummy
	  byte after the buffer.
	MS-DOS may leave interrupts disabled on return from this function.
	Apparently some BIOSes or intercepting resident software have bugs
	  that may destroy DX on return or not properly set the Carry flag.
	  At least some Microsoft software frames calls to this function with
	  PUSH DX, STC, INT 13h, STI, POP DX.
	on the original IBM AT BIOS (1984/01/10) this function does not disable
	  interrupts for harddisks (DL >= 80h).	 On these machines the MS-DOS/
	  PC DOS IO.SYS/IBMBIO.COM installs a special filter to bypass the
	  buggy code in the ROM (see CALL F000h:211Eh)
SeeAlso: AH=03h,AH=0Ah,AH=06h"V10DISK.SYS",AH=21h"PS/1",AH=42h"IBM"
SeeAlso: INT 21/AX=440Dh/CX=084Bh,INT 4D/AH=02h

# ···

```
