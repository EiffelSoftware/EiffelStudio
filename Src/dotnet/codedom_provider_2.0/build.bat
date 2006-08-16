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

ECHO -
ECHO Cleaning up
ECHO -

RD /Q /S configuration\EIFGENS

:BASE
ECHO -
ECHO COMPILING CodeDom.Base
ECHO -
ec -config configuration\base.ecf -target base -precompile %EFLAGS%
IF EXIST configuration\EIFGENS\base\F_code\EiffelSoftware.CodeDom.Base2_0.dll GOTO CACHE
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.Base.dll was generated)
GOTO END

:CACHE
ECHO -
ECHO COMPILING Eiffel Cache Browser
ECHO -
ec -config configuration\cache_browser.ecf -target cache_browser -precompile %EFLAGS%
IF EXIST configuration\EIFGENS\cache_browser\F_code\EiffelSoftware.CodeDom.CacheBrowser2_0.dll GOTO PROVIDER
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.CacheBrowser.dll was generated)
GOTO END

:PROVIDER
ECHO -
ECHO COMPILING Eiffel CodeDom Provider
ECHO -
ec -config configuration\codedom_provider.ecf -target codedom_provider_%TARGET% %EFLAGS%
IF EXIST configuration\EIFGENs\codedom_provider_%TARGET%\F_code\EiffelSoftware.CodeDom2_0.dll GOTO VISION2
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.dll was generated)
GOTO END

:VISION2
ECHO -
ECHO COMPILING CodeDom.Vision2
ECHO -
ec -config configuration\vision2.ecf -target vision2 -precompile %EFLAGS%
IF EXIST configuration\EIFGENS\vision2\F_code\EiffelSoftware.CodeDom.Vision2_0.dll GOTO MANAGER
ECHO Compilation failed !! (no EiffelSoftware.CodeDom.Vision2.dll was generated)
GOTO END


:MANAGER
ECHO -
ECHO COMPILING Eiffel CodeDom Manager
ECHO -
REM FIXME DOESNT WORK YET COPY tools\manager\ecdpman.ico .
REM FIXME DOESNT WORK YET COPY tools\manager\ecdpman.rc .
ec -config configuration\manager.ecf -target manager_%TARGET% %EFLAGS%
IF EXIST configuration\EIFGENs\manager_%TARGET%\F_code\ecdpman2_0.exe GOTO SPLITTER
ECHO Compilation failed !! (no ecdpman.exe was generated)
GOTO END

:SPLITTER
ECHO -
ECHO COMPILING eSplitter
ECHO -
ec -config configuration\esplit.ecf -target esplit_graphical_%TARGET% %EFLAGS%
IF EXIST configuration\EIFGENs\esplit_graphical_%TARGET%\F_code\esplitter2_0.exe GOTO SPLIT
ECHO Compilation failed !! (no esplitter.exe was generated)
GOTO END

:SPLIT
ECHO -
ECHO COMPILING eSplit
ECHO -
ec -config configuration\esplit.ecf -target esplit_console_%TARGET% %EFLAGS%
IF EXIST configuration\EIFGENs\esplit_console_%TARGET%\F_code\esplit2_0.exe GOTO NMAP
ECHO Compilation failed !! (no esplit.exe was generated)
GOTO END

:NMAP
ECHO -
ECHO COMPILING Name Mapper
ECHO -
ec -config configuration\nmap.ecf -target nmap_%TARGET% %EFLAGS%
IF EXIST configuration\EIFGENs\nmap_%TARGET%\F_code\nmap2_0.exe GOTO END
ECHO Compilation failed !! (no nmap.exe was generated)
GOTO END

:END
ECHO Done compiling EiffelStudio Eiffel CodeDom Provider projects.
