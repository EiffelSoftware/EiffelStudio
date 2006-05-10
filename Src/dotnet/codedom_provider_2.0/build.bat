@ECHO OFF

@REM Setup Eiffel CodeDom Provider EiffelStudio projects

SET EFLAGS=-finalize -keep -batch -c_compile -clean
IF "%ISE_EIFFEL%" == "" ECHO ISE_EIFFEL is not defined !!
IF "%ISE_EIFFEL%" == "" GOTO END
IF "%ISE_PLATFORM%" == "" ECHO ISE_PLATFORM is not defined !!
IF "%ISE_PLATFORM%" == "" GOTO END
SET PATH=%PATH%;%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin
SET TARGET=%1
IF '%1' == '' SET TARGET=debug

IF EXIST bin GOTO BASE
MKDIR bin
MKDIR bin\base
MKDIR bin\cache_browser
MKDIR bin\codedom_provider
MKDIR bin\vision2
MKDIR bin\manager
MKDIR bin\esplit
MKDIR bin\nmap

:BASE
ECHO -
ECHO COMPILING CodeDom.Base
ECHO -
ec -config configuration\base.acex -target base -project_path bin\base -precompile %EFLAGS%
IF EXIST bin\base\EIFGENS\base\F_code\EiffelSoftware.CodeDom.Base.dll GOTO CACHE
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.Base.dll was generated)
GOTO END

:CACHE
ECHO -
ECHO COMPILING Eiffel Cache Browser
ECHO -
ec -config configuration\cache_browser.acex -target cache_browser -project_path bin\cache_browser -precompile %EFLAGS%
IF EXIST bin\cache_browser\EIFGENS\cache_browser\F_code\EiffelSoftware.CodeDom.CacheBrowser.dll GOTO PROVIDER
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.CacheBrowser.dll was generated)
GOTO END

:PROVIDER
ECHO -
ECHO COMPILING Eiffel CodeDom Provider
ECHO -
ec -config configuration\codedom_provider.acex -target %TARGET% -project_path bin\codedom_provider %EFLAGS%
IF EXIST bin\codedom_provider\EIFGENS\%TARGET%\F_code\EiffelSoftware.CodeDom.dll GOTO VISION2
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.dll was generated)
GOTO END

:VISION2
ECHO -
ECHO COMPILING CodeDom.Vision2
ECHO -
ec -config configuration\vision2.acex -target vision2 -project_path bin\vision2 -precompile %EFLAGS%
IF EXIST bin\vision2\EIFGENS\vision2\F_code\EiffelSoftware.CodeDom.Vision2.dll GOTO MANAGER
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.Vision2.dll was generated)
GOTO END


:MANAGER
ECHO -
ECHO COMPILING Eiffel CodeDom Manager
ECHO -
REM FIXME DOESNT WORK YET COPY tools\manager\ecdpman.ico .
REM FIXME DOESNT WORK YET COPY tools\manager\ecdpman.rc .
ec -config configuration\manager.acex -target %TARGET% -project_path bin\manager %EFLAGS%
IF EXIST bin\manager\EIFGENS\%TARGET%\F_code\ecdpman.exe GOTO SPLITTER
ECHO Compilation failed !! (no ecdpman.exe was generated)
GOTO END

:SPLITTER
ECHO -
ECHO COMPILING eSplitter
ECHO -
ec -config configuration\esplit.acex -target graphical_%TARGET% -project_path bin\esplit %EFLAGS%
IF EXIST bin\esplit\EIFGENS\graphical_%TARGET%\F_code\esplitter.exe GOTO SPLIT
ECHO Compilation failed !! (no esplitter.exe was generated)
GOTO END

:SPLIT
ECHO -
ECHO COMPILING eSplit
ECHO -
ec -config configuration\esplit.acex -target console_%TARGET% -project_path bin\esplit %EFLAGS%
IF EXIST bin\esplit\EIFGENS\console_%TARGET%\F_code\esplit.exe GOTO NMAP
ECHO Compilation failed !! (no esplit.exe was generated)
GOTO END

:NMAP
ECHO -
ECHO COMPILING Name Mapper
ECHO -
ec -config configuration\nmap.acex -target %TARGET% -project_path bin\nmap %EFLAGS%
IF EXIST bin\nmap\EIFGENS\%TARGET%\F_code\nmap.exe GOTO END
ECHO Compilation failed !! (no nmap.exe was generated)
GOTO END

:END
ECHO Done compiling EiffelStudio Eiffel CodeDom Provider projects.
