@SET PATH=..\MinGW32\bin;..\..\MinGW32\bin;..\..\..\MinGW32\bin;%PATH%

make

..\bochs-2.3.6\bochsdbg -f bochsrc.bxrc -q

