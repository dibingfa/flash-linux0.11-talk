DLX Linux hard disk image
-------------------------

DLX is a version of Linux which was small enough to distribute along with
the Bochs Windows binary release.  Because of its small size, a limited
number of linux commands are available.

To boot with the DLX Linux disk image, cd to the dlxlinux directory
and run bochs.

Linux will boot and reach a login: prompt.  Type root followed by RETURN
to log in, and you get a linux command prompt (#).  Have fun!  When you
are done, type reboot at the "#" prompt.  Bochs should exit after stopping
all the tasks on the system.

A collection of larger (and therefore more useful) disk images is at 

  http://bochs.sourceforge.net/diskimages.html

CREDITS:
The official DLX site is at http://www.wu-wien.ac.at/usr/h93/h9301726/dlx.html
DLX was created by Erich and Hannes Boehm.

Bryce Denney converted the floppy into a small hard disk image for bochs.
