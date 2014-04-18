rem This script is to help compiling the Win x86 version of libfcgi
setlocal 

set E_libFCGI_OUTDIR=%~dp0_win32

set CL_FLAGS= /Ilibfcgi\include /nologo /W3 /WX- /O2 /Ob2  /D _SCL_SECURE_NO_WARNINGS /D _CRT_SECURE_NO_WARNINGS /D NDEBUG /D WIN32 /D _CONSOLE /D LIBFCGI_EXPORTS /D WINVER=0x501 /D _WIN32_WINNT=0x501 /D _SECURE_SCL=0 /D _VC80_UPGRADE=0x0600 /D _WINDLL /D _MBCS /GF /Gm- /EHsc /MD /GS /Gy /fp:precise /Zc:wchar_t /Zc:forScope  /Gd  /errorReport:queue /Fo"%E_libFCGI_OUTDIR%/"

set LINK_FLAGS= /ERRORREPORT:QUEUE /OUT:"%E_libFCGI_OUTDIR%\libfcgi.dll" /INCREMENTAL:NO /NOLOGO  Ws2_32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /TLBID:1 /DYNAMICBASE:NO /IMPLIB:"%E_libFCGI_OUTDIR%\libfcgi.lib" /MACHINE:X86

mkdir %E_libFCGI_OUTDIR%
copy libfcgi\include\fcgi_config_x86.h libfcgi\include\fcgi_config.h
CL.exe /c %CL_FLAGS%   /TC  libfcgi\libfcgi\fcgi_stdio.c libfcgi\libfcgi\fcgiapp.c libfcgi\libfcgi\os_win32.c
CL.exe /c  %CL_FLAGS%  /TP  libfcgi\libfcgi\fcgio.cpp
link.exe %LINK_FLAGS%  /DLL %E_libFCGI_OUTDIR%\fcgi_stdio.obj %E_libFCGI_OUTDIR%\fcgiapp.obj %E_libFCGI_OUTDIR%\os_win32.obj %E_libFCGI_OUTDIR%\fcgio.obj 

copy %E_libFCGI_OUTDIR%\libfcgi.* %~dp0..\spec\lib\windows\msc

endlocal
exit 0
