@ECHO OFF

REM Locate the registry key location. This is the only place where the scripts needs to be changed
REM from version to version.
set RegKeyPath=HKEY_LOCAL_MACHINE\SOFTWARE\ISE\Eiffel_22.11

FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "%RegKeyPath%" /v ISE_EIFFEL') DO SET ISE_EIFFEL=%%B
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "%RegKeyPath%" /v ISE_PLATFORM') DO SET ISE_PLATFORM=%%B
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "%RegKeyPath%" /v ISE_C_COMPILER') DO SET ISE_C_COMPILER=%%B

IF "%ISE_EIFFEL:~-1%"=="\" SET ISE_EIFFEL=%ISE_EIFFEL:~0,-1%

ECHO EiffelStudio is ready to be used for the %ISE_PLATFORM% platform and %ISE_C_COMPILER% C compiler.

REM Set PATH so that one can easily access to our compiler and associated tools.
set PATH=%PATH%;%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin;%ISE_EIFFEL%\tools\spec\%ISE_PLATFORM%\bin;%ISE_EIFFEL%\library\gobo\spec\%ISE_PLATFORM%\bin

REM Set mingw path if currently set C compiler.
if %ISE_C_COMPILER%==mingw set PATH=%ISE_EIFFEL%\gcc\%ISE_PLATFORM%\mingw\bin;%ISE_EIFFEL%\gcc\%ISE_PLATFORM%\msys\1.0\bin;%PATH%;

cd "%ISE_EIFFEL%"
