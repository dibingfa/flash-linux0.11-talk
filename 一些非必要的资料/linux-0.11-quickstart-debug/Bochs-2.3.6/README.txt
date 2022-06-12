Bochs x86 Pentium+ Emulator
Updated: Mon Dec 24 10:52:00 CET 2007
Version: 2.3.6

WHAT IS BOCHS?

Bochs is a highly portable open source IA-32 (x86) PC emulator
written in C++, that runs on most popular platforms.  It includes
emulation of the Intel x86 CPU, common I/O devices, and a custom
BIOS.  Currently, Bochs can be compiled to emulate a 386, 486,
Pentium/PentiumII/PentiumIII/Pentium4 or x86-64 CPU, including optional 
MMX, SSEx and 3DNow! instructions.  Bochs is capable of running
most Operating Systems inside the emulation, for example Linux, DOS,
Windows 95/98/NT/2000/XP or Windows Vista.
Bochs was written by Kevin Lawton and is currently maintained by 
the Bochs project at "http://bochs.sourceforge.net".

Bochs can be compiled and used in a variety of modes, some which are
still in development.  The 'typical' use of bochs is to provide
complete x86 PC emulation, including the x86 processor, hardware
devices, and memory.  This allows you to run OS's and software within
the emulator on your workstation, much like you have a machine
inside of a machine.  Bochs will allow you to run Windows
applications on a Solaris machine with X11, for example.

Bochs is distributed under the GNU LGPL.  See COPYING for details.

GETTING CURRENT SOURCE CODE 

Source code for Bochs is available from the Bochs home page at
http://bochs.sourceforge.net.  You can download the most recent
release, use CVS to get the latest sources, or grab a CVS
snapshot which is updated nightly.  The releases contain the most
stable code, but if you want the very newest features try the
CVS version instead. 

WHERE ARE THE DOCS?

The Bochs documentation is written in Docbook.  Docbook is a text 
format that can be rendered to many popular browser formats such 
as HTML, PDF, and Postscript.  Each binary release contains the
HTML rendering of the documentation.  Also, you can view the
latest documentation on the web at
  http://bochs.sf.net/doc/docbook/index.html

Some information has not yet been transferred from the older
HTML docs.  These can be found at http://bochs.sf.net/docs-html

WHERE CAN I GET MORE INFORMATION?  HOW DO I REPORT PROBLEMS?

Both the documentation and the Bochs website have instructions on how 
to join the bochs-developers mailing list, which is the primary
forum for discussion of Bochs.  The main page of the website also
has links to bug reports and feature requests.  You can browse and
add to the content in these areas even if you do not have a (free)
SourceForge account.  We need your feedback so that we know what
parts of Bochs to improve.  

There is a patches section on the web site too, if you have made
some changes to Bochs that you want to share.

HOW CAN I HELP?

If you would like contribute to the Bochs project, a good first step
is to join the bochs-developers mailing list, and read the archive
of recent messages to see what's going on.  

If you are a technical person (can follow hardware specs, can write
C/C++) take a look at the list of open bug reports and feature
requests to see if you are interested in working on any of the
problems that are mentioned in them.  If you check out the CVS
sources, make some changes, and create a patch, one of the
developers will be very happy to apply it for you.  Developers who
frequently submit patches, or who embark on major changes in the
source can get write access to CVS.  Be sure to communicate with the
bochs-developers list to avoid several people working on the same
thing without realizing it.

If you are a Bochs user, not a hardware/C++ guru, there are still
many ways you could help out.  For example:
  - write instructions on how to install a particular operating system
  - writing/cleaning up documentation
  - testing out Bochs on every imaginable operating system and 
    reporting how it goes.
