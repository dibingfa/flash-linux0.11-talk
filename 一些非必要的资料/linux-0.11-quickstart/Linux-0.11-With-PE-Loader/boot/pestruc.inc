IMAGE_NUMBEROF_DIRECTORY_ENTRIES            equ 16
IMAGE_SIZEOF_SHORT_NAME equ 8


STRUC IMAGE_FILE_HEADER
.Machine RESW 1
.NumberOfSections RESW 1
.TimeDateStamp RESD 1
.PointerToSymbolTable RESD 1
.NumberOfSymbols RESD 1
.SizeOfOptionalHeader RESW 1
.Characteristics RESW 1
ENDSTRUC

STRUC IMAGE_DATA_DIRECTORY
.VirtualAddress RESD 1
.isize RESD 1
ENDSTRUC

STRUC IMAGE_OPTIONAL_HEADER32 
    .Magic                         RESW      1
    .MajorLinkerVersion            RESB      1
    .MinorLinkerVersion            RESB      1
    .SizeOfCode                    RESD      1
    .SizeOfInitializedData         RESD      1
    .SizeOfUninitializedData       RESD      1
    .AddressOfEntryPoint           RESD      1
    .BaseOfCode                    RESD      1
    .BaseOfData                    RESD      1
    .ImageBase                     RESD      1
    .SectionAlignment              RESD      1
    .FileAlignment                 RESD      1
    .MajorOperatingSystemVersion   RESW      1
    .MinorOperatingSystemVersion   RESW      1
    .MajorImageVersion             RESW      1
    .MinorImageVersion             RESW      1
    .MajorSubsystemVersion         RESW      1
    .MinorSubsystemVersion         RESW      1
    .Win32VersionValue             RESD      1
    .SizeOfImage                   RESD      1
    .SizeOfHeaders                 RESD      1
    .CheckSum                      RESD      1
    .Subsystem                     RESW      1
    .DllCharacteristics            RESW      1
    .SizeOfStackReserve            RESD      1
    .SizeOfStackCommit             RESD      1
    .SizeOfHeapReserve             RESD      1
    .SizeOfHeapCommit              RESD      1
    .LoaderFlags                   RESD      1
    .NumberOfRvaAndSizes           RESD      1
    .DataDirectory RESB IMAGE_DATA_DIRECTORY_size*16
 ENDSTRUC

STRUC IMAGE_SECTION_HEADER 
    .Name1                RESB      8 
    .VirtualSize          RESD      1
    .VirtualAddress       RESD      1
    .SizeOfRawData        RESD      1
    .PointerToRawData     RESD      1
    .PointerToRelocations RESD      1
    .PointerToLinenumbers RESD      1
    .NumberOfRelocations  RESW      1
    .NumberOfLinenumbers  RESW      1
    .Characteristics      RESD      1
ENDSTRUC

STRUC IMAGE_NT_HEADERS
  .Signature      RESD 1
  .FileHeader     RESB IMAGE_FILE_HEADER_size
  .OptionalHeader RESB IMAGE_OPTIONAL_HEADER32_size
ENDSTRUC

STRUC IMAGE_DOS_HEADER
  .e_magic      RESW 1
  .e_cblp       RESW 1
  .e_cp         RESW 1
  .e_crlc       RESW 1
  .e_cparhdr    RESW 1
  .e_minalloc   RESW 1
  .e_maxalloc   RESW 1
  .e_ss         RESW 1
  .e_sp         RESW 1
  .e_csum       RESW 1
  .e_ip         RESW 1
  .e_cs         RESW 1
  .e_lfarlc     RESW 1
  .e_ovno       RESW 1
  .e_res4       RESW 4
  .e_oemid      RESW 1
  .e_oeminfo    RESW 1
  .e_res2       RESW 10
  .e_lfanew     RESD 1
ENDSTRUC