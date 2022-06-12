编译过程:

1).  解压后默认的文件夹位置是在D:\Linux-0.11,如果你不是将文件解压到该目录下,
     你要修改MinGW32目录下的MinGW32.bat文件,将里面的PATH指向MinGW32的bin目录. 
2).  打开Linux-0.11目录,双击MinGW32.bat快捷方式,打开控制台.
3).  make 一下,生成1.44M的Boot.img软盘镜像,要清除编译结果请"make clean"
4).  如果安装了bochs,直接双击bochsrc.bxrc即可运行Linux-0.11了.
5).  也可用其它虚拟机加载Boot.img后运行,如果出现Kernel panic,请把虚拟机里的硬盘删了
6).  在出现Insert root floppy and press ENTER出现以后,将rootimage-0.11.img载入虚拟软驱,回车
  
这就是能在windows环境下编译的Linux 0.11了,不是在Cygwin,也不是在虚拟机里,而是使用MinGW.
下面是在Windows下编译Linux 0.11会遇到的问题和对原文件作的修改:

1.赵炯博士已经将汇编程序中引用的C变量(包括嵌入汇编的C变量)的下划线去掉了,但MinGW的gcc可能是为了与其它Windows下的编译器保持兼容,并不能识别这些不带下划线的C变量,因而还得把原先已经在汇编程序中去掉下划线的C变量加上下划线,同时也要把被C程序引用的汇编程序中的变量加上下划线.

2.MinGW中不带as86编译器,因而把boot目录下原先用as86编译的bootsect.s和setup.s两个程序修改成能用nasm编译的程序.并且更名为bootsect.asm和setup.asm.

3.在Makefile作的主要修改:
  在LDFLAGS中加了--image-base 0x0000  将elf_i386改成i386pe
  将cd 与 make 之间的;改成&,如cd kernel ; make 改成cd kernel & make
  MinGW中没有sync这个程序,可以把它注释掉,更简单的办法是写一个sync.c,这个sync.c只包含一个空的main函数,编译成sync.exe
  因为类似的原因,make dep会出错   

4.生成的system文件是PE格式的(PE是Portable Executable的简称),这是windows下的可执行文件的格式,显然是不能直接执行的,必须加以转化.我实现了通过两种方式加以转化.
1)写一个程序Trans.cpp将system.exe里的代码和数据从PE文件里解析出来,生成一个system.bin文件,这个文件是能被setup模块直接加载的.我已经将这个程序放在了Linux-0.11的tools目录下,要微软的编译器编译.
2)自己写一个PE Loader,这种方式比较麻烦,但是想想自己也能做一个PE Loader,还是满有成就感的,尽管这是一个最简单的Loader.代码是加在Linux-0.11-With-PE-Loader\boot目录下的setup.asm文件里,里面有详细的注释.


5.对tools下的build.c作了修改,使其能生成可引导的1.44M的软盘镜像文件Boot.img

6.在Link的过程中,init目录下的main.c会出现以下错误:
boot/head.o(.text+0x540c):fake: undefined reference to `_main'
init/main.o(.text+0x16f):main.c: undefined reference to `_alloca'
init/main.o(.text+0x174):main.c: undefined reference to `__main'
make: *** [tools/system.exe] Error 1
第一个和最后一个错误还好理解,但中间那个错误那就莫明其妙了,因为Linux 0.11根本没有这个函数,在gcc的编译选项里也有-nostdinc .有一个解释是main函数不是一个普通的函数,MinGW gcc会对它作特殊的处理.解决的办法其实也很简单,把main.c下面的main函数改名为_main,或者是干脆把它改成另外一个函数,就改成start吧.记得把head.s里的_main也改了.

 在最后,要感谢《自己动手写操作系统》的作者于渊，其实我也是先将原先只能在Linux下编译的书里源代码用MinGW移植到Windows下编译的过程中才试着在Windows下编译Linux 0.11源代码的，有了在Windows下编译Linux 0.11源代码的经验，移植高版本的源代码，像0.12,0.95,0.96等等版本应该不会有太大的麻烦了。
 也要感谢Linux内核完全注释的作者赵炯博士，是他拉接了操作系统与操作系统爱好者的距离.
 最后,我也非常想和操作系统爱好者们共同交流心得体会,也希望能多认识一些朋友.
 我的网名:flyfish
 我的QQ:785606288
 E-mail:I2CBus@126.com
 另外,要转载请保持本文件的完整性,请尊重别人的劳动果实.
 
 
