/*
 *  linux/tools/build.c
 *
 *  (C) 1991  Linus Torvalds
 */

/*
 * This file builds a disk-image from three different files:
 *
 * - bootsect: max 510 bytes of 8086 machine code, loads the rest
 * - setup: max 4 sectors of 8086 machine code, sets up system parm
 * - system: 80386 code for actual system
 *
 * It does some checking that all files are of the correct type, and
 * just writes the result to stdout, removing headers and padding to
 * the right amount. It also writes some system data to stderr.
 */

/*
 * Changes by tytso to allow root device specification
 */

#include <stdio.h>	/* fprintf */
#include <string.h>
#include <stdlib.h>	/* contains exit */
#include <sys/types.h>	/* unistd.h needs this */
#include <sys/stat.h>
//#include <linux/fs.h>
#include <unistd.h>	/* contains read/write */
#include <fcntl.h>

#define MINIX_HEADER 32
#define GCC_HEADER 1024

#define SYS_SIZE 0x3000

#define DEFAULT_MAJOR_ROOT 2
#define DEFAULT_MINOR_ROOT 0x1d

/* max nr of sectors of setup: don't change unless you also change
 * bootsect etc */
#define SETUP_SECTS 4

#define STRINGIFY(x) #x

#define MAJOR(a) (((unsigned)(a))>>8)
#define MINOR(a) ((a)&0xff)

void die(char * str)
{
	fprintf(stderr,"%s\n",str);
	exit(1);
}

void usage(void)
{
	die("Usage: build bootsect setup system [rootdev] [> image]");
}

int main(int argc, char ** argv)
{
	int i,c,id;
	char buf[1024];
	char major_root, minor_root;
	struct stat sb;
	int size=512+4*512;
	FILE* imageFile = fopen("Boot.img","wb");
	
	if ((argc != 4) && (argc != 5))
		usage();
	if (argc == 5) {
		if (strcmp(argv[4], "FLOPPY")) {
			if (stat(argv[4], &sb)) {
				perror(argv[4]);
				die("Couldn't stat root device.");
			}
			major_root = MAJOR(sb.st_rdev);
			minor_root = MINOR(sb.st_rdev);
		} else {
			major_root = 0;
			minor_root = 0;
		}
	} else {
		major_root = DEFAULT_MAJOR_ROOT;
		minor_root = DEFAULT_MINOR_ROOT;
	}
	fprintf(stderr, "Root device is (%d, %d)\n", major_root, minor_root);
	if ((major_root != 2) && (major_root != 3) &&
	    (major_root != 0)) {
		fprintf(stderr, "Illegal root device (major = %d)\n",
			major_root);
		die("Bad root device --- major #");
	}
	
	
	for (i=0;i<sizeof buf; i++) buf[i]=0;
//	if ((id=open(argv[1],O_RDONLY,0))<0)
//必须以读二进制方式打开文件,要不然,读出的大小会小于512	
	if ((id=open(argv[1],O_RDONLY|O_BINARY,0))<0)
		die("Unable to open 'boot'");
/*
	if (read(id,buf,MINIX_HEADER) != MINIX_HEADER)
		die("Unable to read header of 'boot'");
	if ( ((long *) buf)[0]!=0x04100301)
	{
		die("Non-Minix header of 'boot'");		
	}
	if (((long *) buf)[1]!=MINIX_HEADER)
	{
		die("Non-Minix header of 'boot'");		
	}

	if (((long *) buf)[3]!=0)
	{
		die("Illegal data segment in 'boot'");		
	}
	if (((long *) buf)[4]!=0)
	{
		die("Illegal bss in 'boot'");		
	}
	if (((long *) buf)[5] != 0)
	{
		die("Non-Minix header of 'boot'");		
	}
	if (((long *) buf)[7] != 0)
	{
		die("Illegal symbol table in 'boot'");		
	}
	*/
	i=read(id,buf,sizeof buf);
	fprintf(stderr,"Boot sector %d bytes.\n",i);
	if (i != 512)
	{
		die("Boot block must be exactly 512 bytes");		
	}
	if ((*(unsigned short *)(buf+510)) != 0xAA55)
	{
		die("Boot block hasn't got boot flag (0xAA55)");		
	}
	//--必须为零,否则mout根文件系统时出错
	buf[508] = 0;//(char) minor_root;
	buf[509] = 0;//(char) major_root;	
	//i=write(1,buf,512);
	i=fwrite(buf,1,512,imageFile);
	if (i!=512)
		die("Write call failed");
	close (id);
	
	if ((id=open(argv[2],O_RDONLY|O_BINARY,0))<0)
		die("Unable to open 'setup'");
	/*
	if (read(id,buf,MINIX_HEADER) != MINIX_HEADER)
		die("Unable to read header of 'setup'");
	if (((long *) buf)[0]!=0x04100301)
		die("Non-Minix header of 'setup'");
	if (((long *) buf)[1]!=MINIX_HEADER)
		die("Non-Minix header of 'setup'");
	if (((long *) buf)[3]!=0)
		die("Illegal data segment in 'setup'");
	if (((long *) buf)[4]!=0)
		die("Illegal bss in 'setup'");
	if (((long *) buf)[5] != 0)
		die("Non-Minix header of 'setup'");
	if (((long *) buf)[7] != 0)
		die("Illegal symbol table in 'setup'");
	*/
	/*	
	for (i=0 ; (c=read(id,buf,sizeof buf))>0 ; i+=c )
		if (write(1,buf,c)!=c)
			die("Write call failed");
	close (id);
	*/
	for (i=0 ; (c=read(id,buf,sizeof buf))>0 ; i+=c )
	{
		if (fwrite(buf,1,c,imageFile)!=c)
		{
			die("Write call failed");			
		}			
	}
	close (id);

	if (i > SETUP_SECTS*512)
	{
		die("Setup exceeds " STRINGIFY(SETUP_SECTS)" sectors - rewrite build/boot/setup");		
	}
	fprintf(stderr,"Setup is %d bytes.\n",i);
	for (c=0 ; c<sizeof(buf) ; c++)
	{
		buf[c] = '\0';		
	}
	
	while (i<SETUP_SECTS*512) 
	{
		c = SETUP_SECTS*512-i;
		if (c > sizeof(buf))
		{
			c = sizeof(buf);			
		}
//		if (write(1,buf,c) != c)
    if( c != fwrite(buf,1,c,imageFile) )
    {
			die("Write call failed");
    }
		i += c;
	}
	
	if ( (id=open(argv[3],O_RDONLY|O_BINARY,0) ) < 0 )
	{
		die("Unable to open 'system'");		
	}
//	if (read(id,buf,GCC_HEADER) != GCC_HEADER)
//		die("Unable to read header of 'system'");
//	if (((long *) buf)[5] != 0)
//		die("Non-GCC header of 'system'");
	for (i=0 ; (c=read(id,buf,sizeof buf))>0 ; i+=c )
	{
		if (fwrite(buf,1,c,imageFile)!= c)
			die("Write call failed");		
	}
	close(id);
	size+=i;
	fprintf(stderr,"System is %d bytes.\n",i);
	if (i > SYS_SIZE*16)
		die("System is too big");
	memset(buf,0,sizeof(buf));

	fprintf(stderr,"total size is  %d bytes.\n",1440*1024);
	
	//1475084
	//1474560
	while(size<1440*1024)
	{
		c = 1440*1024 - size;
		if( c > sizeof(buf) )
		{
			c = sizeof(buf);
		}
		c = fwrite(buf,1,c,imageFile);
		size+=c;
	}
	
	fclose(imageFile);
	return(0);
}
