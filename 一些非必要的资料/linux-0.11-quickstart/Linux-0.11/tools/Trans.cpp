#ifndef UNICODE
#define UNICODE
#endif
#define _WIN32_WINNT 0x0501
#include <afx.h>
#include <stdlib.h> 
#include <stdio.h>
#include <strsafe.h>

void ShowError(LPTSTR lpszFunction) 
{ 
    // Retrieve the system error message for the last-error code

    LPVOID lpMsgBuf;
    LPVOID lpDisplayBuf;
    DWORD dw = GetLastError(); 

    FormatMessage(
        FORMAT_MESSAGE_ALLOCATE_BUFFER | 
        FORMAT_MESSAGE_FROM_SYSTEM |
        FORMAT_MESSAGE_IGNORE_INSERTS,
        NULL,
        dw,
        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
        (LPTSTR) &lpMsgBuf,
        0, NULL );

    // Display the error message and exit the process

    lpDisplayBuf = (LPVOID)LocalAlloc(LMEM_ZEROINIT, 
        (lstrlen((LPCTSTR)lpMsgBuf)+lstrlen((LPCTSTR)lpszFunction)+40)*sizeof(TCHAR)); 
    StringCchPrintf((LPTSTR)lpDisplayBuf, 
        LocalSize(lpDisplayBuf) / sizeof(TCHAR),
        TEXT("%s failed with error %d: %s"), 
        lpszFunction, dw, lpMsgBuf); 
 
	char strAnsi[128];
	int len =WideCharToMultiByte( CP_ACP, 0, (LPCWSTR)lpDisplayBuf, -1, strAnsi, 128,NULL,NULL);   
  printf("%s ",strAnsi); 

    LocalFree(lpMsgBuf);
    LocalFree(lpDisplayBuf);
}
void *base;
bool mapExeToMemory(LPCWSTR exeFile)
{
  HANDLE hFile, hMapping;
	hFile = CreateFile(exeFile, GENERIC_READ, 
                   FILE_SHARE_READ | FILE_SHARE_WRITE, 
                   0, 
                   OPEN_EXISTING, 
                   FILE_FLAG_SEQUENTIAL_SCAN, 0);
	if(INVALID_HANDLE_VALUE == hFile )
 	{
 		ShowError(L"CreateFile!");
 		return false;
 	}
 	hMapping = CreateFileMapping(hFile, 0, PAGE_READONLY | SEC_COMMIT, 0, 0, 0);
 	if(NULL == hMapping)
 	{
 		ShowError(L"CreateFileMapping");
 		CloseHandle(hFile);
 		return false;
 	}   
 	base = MapViewOfFile(hMapping,FILE_MAP_READ,0,0,0);
 	if(NULL == base )
 	{
 		ShowError(L"MapViewOfFile");
 		CloseHandle(hMapping);
 		CloseHandle(hFile);
 		return false;
 	}
  CloseHandle(hMapping);
  CloseHandle(hFile);
  return true;
}
bool TranslateFile(LPCWSTR exeFile,LPCWSTR outFile)
{
	CFile *file;
	if(!mapExeToMemory(exeFile))
	{
		return false;
	}
	
	PIMAGE_DOS_HEADER dosHeader = (PIMAGE_DOS_HEADER)base;

	PIMAGE_NT_HEADERS ntHeader = (PIMAGE_NT_HEADERS)((DWORD_PTR)base+dosHeader->e_lfanew);
	
	DWORD sectionNumber = ntHeader->FileHeader.NumberOfSections;
  try
  {
	  file = new CFile(outFile,CFile::typeBinary | CFile::modeWrite | CFile::modeCreate );	  	
  }
  catch(CFileException  ex)
  {
  	ex.ReportError();
  	return false;
  }
  
  try
  {
	  int vSize = 0;
	
		PIMAGE_SECTION_HEADER sectionHeader=IMAGE_FIRST_SECTION(ntHeader);
	
		for(int i=0;i<sectionNumber;i++)
		{
			vSize += sectionHeader[i].Misc.VirtualSize;
		}	
		file->SetLength(vSize);
	
		file->SeekToBegin();
	
		char c = 0;
	
		for(int i=0;i<vSize;i++)
		{
			file->Write(&c,1);
		}
	
		file->SeekToBegin();
		
		for(int i=0;i<sectionNumber;i++)
		{
			int RawOffset = sectionHeader[i].PointerToRawData;
			
			int virtualAddress = sectionHeader[i].VirtualAddress & 0x3ffff;
			
			int sizeOfRawData = sectionHeader[i].SizeOfRawData;
			
			if(sizeOfRawData == 0)
			{
				continue;
			}
			file->Seek(virtualAddress,CFile::begin);
			
			file->Write((char*)base+RawOffset,sizeOfRawData);
		}  	
  }
  catch(CFileException ex)
  {
  	ex.ReportError();
  	file->Close();
  	return false;
  }
  file->Close();
  return true;
}
int _tmain(int argc,LPCWSTR argv[])
{
	if(3 != argc)
	{
		puts("usage: Trans exeFile binFileName");
	}
	TranslateFile(argv[1],argv[2]);
  UnmapViewOfFile(base);	
  return 0;
}