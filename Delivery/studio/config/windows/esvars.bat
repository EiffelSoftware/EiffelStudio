@ECHO OFF

REM Locate the registry key location. This is the only place where the scripts needs to be changed
REM from version to version.
set RegKeyPath=HKEY_LOCAL_MACHINE\SOFTWARE\ISE\Eiffel65

FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "%RegKeyPath%" /v ISE_EIFFEL') DO SET ISE_EIFFEL=%%B
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "%RegKeyPath%" /v ISE_PLATFORM') DO SET ISE_PLATFORM=%%B
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "%RegKeyPath%" /v ISE_C_COMPILER') DO SET ISE_C_COMPILER=%%B

ECHO EiffelStudio is ready to be used for the %ISE_PLATFORM% platform and %ISE_C_COMPILER% C compiler.

REM Set PATH so that one can easily access to our compiler and associated tools.
set PATH=%PATH%;%ISE_EIFFEL%\studio\spec\%ISE_PLATFORM%\bin;%ISE_EIFFEL%\tools\spec\%ISE_PLATFORM%\bin

call %COMSPEC%
