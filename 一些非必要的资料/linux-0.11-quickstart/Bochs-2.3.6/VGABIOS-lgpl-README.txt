Plex86/Bochs VGABios
--------------------

The goal of this project is to have a LGPL'd Video Bios in plex86,
Bochs and qemu.
This VGA Bios is very specific to the emulated VGA card.
It is NOT meant to drive a physical vga card.


Cirrus SVGA extension
---------------------

The Cirrus SVGA extension is designed for the Cirrus emulation in Bochs and
qemu. The initial patch for the Cirrus extension has been written by Makoto
Suzuki (suzu).


Install
-------
To compile the VGA Bios you will need :
- gcc
- bcc
- as86
- ld86

Untar the archive, and type make. You should get a "VGABIOS-lgpl-latest.bin"
file. Alternatively, you can use the binary file "VGABIOS-lgpl-latest.bin",
i have compiled for you.

Edit your plex86/bochs conf file, and modify the load-rom command in the
VGA BIOS section, to point to the new vgabios image file.


Debugging
---------
You can get a very basic debugging system: messages printed by the vgabios.
You have to register the "unmapped" device driver in plex86 or bochs, and make
sure it grabs port 0xfff0.

Comment the #undef DEBUG at the beginning of vgabios.c. 
You can then use the "printf" function in the bios. 


Testing
-------
Look at the "testvga.c" file in the archive. This is a minimal Turbo C 2.0 
source file that calls a few int10 functions. Feel free to modify it to suit 
your needs.


Copyright and License
---------------------
This program has been written by Christophe Bothamy
It is protected by the GNU Lesser Public License, which you should
have received a copy of along with this package. 


Reverse Engineering
-------------------
The VGA Bios has been written without reverse-engineering any existing Bios.


Acknowledgment
--------------
The source code contains code ripped from rombios.c of plex86, written
by Kevin Lawton <kevin2001@yahoo.com>

The source code contains fonts from fntcol16.zip (c) by Joseph Gil avalable at :
ftp://ftp.simtel.net/pub/simtelnet/msdos/screen/fntcol16.zip
These fonts are public domain

The source code is based on information taken from :
- Kevin Lawton's vga card emulation for bochs/plex86
- Ralf Brown's interrupts list avalaible at 
  http://www.cs.cmu.edu/afs/cs/user/ralf/pub/WWW/files.html
- Finn Thogersons' VGADOC4b available at http://home.worldonline.dk/~finth/
- Michael Abrash's Graphics Programming Black Book
- Francois Gervais' book "programmation des cartes graphiques cga-ega-vga" 
  edited by sybex
- DOSEMU 1.0.1 source code for several tables values and formulas


Feedback
--------
Please report any bugs, comments, patches for this VGA Bios to info@vruppert.de
You can find the latest release at : http://www.nongnu.org/vgabios/
For any information on bochs, visit the website http://bochs.sourceforge.net/
For any information on qemu, visit the website http://fabrice.bellard.free.fr/qemu/


History
-------
vgabios-0.6a : Aug 19 2006
  - Volker
    . added minimal support for the video parameter table (VPT)
    . Cirrus SVGA now supports the "no clear" bit in Cirrus and VESA mode
    . Bochs VBE protected mode interface improved
    . save/restore video state support for Bochs VBE and standard VGA added
    . generate vbetables.h dynamicly
    . VBE video memory increased to 8 MB (VBE dispi ID changed to B0C4)
    . lots of 4bpp VBE fixes (all 4bpp VBE modes now enabled)
    . VGA compatible setup for VBE modes added

vgabios-0.5d : Dec 29 2005
  - Volker
    . Bochs VBE protected mode interface added (based on a patch by malc@pulsesoft.com)
    . biossums utility now supports VGABIOS sizes up to 64 kBytes
    . VGA mode 0x11: all color planes must be enabled in this 2-color VGA mode

vgabios-0.5c : Jul 07 2005
  - Volker
    . BIOS configuration word usually reports initial mode 80x25 color text
    . vgabios function 0x0e (write teletype): linefeed (0x0a) only increments the
      cursor row value

vgabios-0.5b : May 24 2005
  - Volker
    . fixed return value for the default case in the VBE section (non-debug mode)
    . removed unused stuff

vgabios-0.5a : Mar 07 2005
  - Volker
    . Cirrus SVGA extension (initial patches from Makoto Suzuki, improvements
      from Fabrice Bellard)
    . vgabios image size is now exactly 32k with a checksum
    . a lot of vgabios and vbe functions rewritten in assembler
    . dynamicly generated VBE mode info list
    . write character function for CGA and LINEAR8 modes
    . read/write graphics pixel for some graphics modes
    . text scroll feature for some graphics modes
    . VBE 8-bit DAC support

vgabios-0.4c : Nov 06 2003
  - Christophe
    . fix font problem on initial screen of NT4 Loader
    
vgabios-0.4b : Nov 04 2003
  - Volker 
    . fix offset of character tables
    . optimizations of CRT controller accesses
    . VBE i/o registers changed to 0x01CE/CF 
      (suggestion from Daniel Gimpelevich)
    . "noclear" flag stored in BIOS area
    . fix character height returned by get_font_info function

vgabios-0.4a : Aug 17 2003
  - Volker
    . VBE mode search rewritten (VBE modes with LFB bit removed)
    . many bugfixes and optimizations
    . write character function implemented for graphics modes
    . support for 15bpp, 16bpp, 24bpp and 32bpp VBE modes added
    . SVGA mode 0x6A added
    . VBE modes 0x102, 0x117, 0x118 and 0x142 (Bochs specific)

vgabios-0.3b : Nov 23 2002
  - Christophe
    . added lfb-mode numbers (patch from mathis)
    . updated the Makefile
    . removed display of copyrights. 
    . changed the Copyright string to "LGPL VGABios developers"
  - Volker 
    . set the cursor shape depending on the current font height
    . clear BL before calling int 0x10 function 0x1103 in vgabios_init_func
    . added some text font functions
  - Jeroen
    . Forced to new DISPI (0xb0c1) interface (requires latest bochs vbe code)
    . Added multibuffering support
    . Added new DISPI interface for: virt width, height, x offset, y offset
    . Added LFB modes (to be used with the vbe-lfb patch in bochs)
      see VBE_HAVE_LFB in vbe.c (currently default enabled)
    . updated TODO & docs for changes after bochs 1.4

vgabios-0.3a : Mar 10 2002
  - Christophe
    . Fixed bug in function ah=13
  - Jeroen
    . updated vbebios implementation to new api
    . added vbe_display_api documentation
    . added 640x400x8, 640x480x8, 800x600x8, 1024x768 
      (>640x480 needs a special bochs patch atm)
    . added 320x200x8 vbe support (uses the standard 320x200x8 vga mode to
      display, this allows for testing & having something on screen as well,
      at least until bochs host side display is up & running)
    . adding lfbprof (vbe) testprogram (+some small fixes to it)
    . merging with vbebios 0.2

vgabios-0.2b : Nov 19 2001
  - Christophe
    . Fixed bug in function ah=13

vgabios-0.2a : Nov 09 2001
  - Christophe
    . Included bugfix from techt@pikeonline.net about grayscale summing
    . Added the "IBM" string at org 0x1e as Bart Oldeman suggested
    . Fixed DS and ES that where inverted in the int10 parameters list!
    . The following have been implemented :
	- function ax=1a00, ax=1a01, ah=1b
	- function ax=1130                
    . Added debug messages for unimplemented/unknown functions
      Must be compiled with DEBUG defined. The output is trapped
      by the unknown-ioport driver of plex/bochs (port 0xfff0 is used)

vgabios-0.1a : May 8 2001
  - Christophe
    . First release. The work has been focused only on text mode.
    . The following have been implemented :
	- inits
	- int 10 handler
	- functions ah=00, ah=01, ah=02, ah=03, ah=05, ah=06, ah=07, ah=08
	  ah=09, ah=0a, ah=0e, ah=0f, ax=1000, ax=1001, ax=1002, ax=1003
	  ax=1007, ax=1008, ax=1009, ax=1010, ax=1012, ax=1013, ax=1015
	  ax=1017, ax=1018, ax=1019, ax=101a, ax=101b, ah=12 bl=10,
	  ah=12 bl=30, ah=12 bl=31, ah=12 bl=32, ah=12 bl=33, ah=12 bl=34
	  ah=13
