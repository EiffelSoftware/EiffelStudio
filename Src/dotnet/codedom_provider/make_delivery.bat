@ECHO OFF

REM Setup Eiffel CodeDom Provider delivery, result is put in folder "delivery"

IF EXIST build_studio GOTO :STUDIO
IF EXIST build_envision GOTO :ENVISION
CALL build_studio.bat

IF EXIST delivery RD /Q /S delivery
MKDIR delivery
MKDIR delivery\gac
MKDIR delivery\system32

COPY build_studio\EiffelSoftware.EiffelBase\bin\Release\EiffelSoftware.EiffelBase.dll delivery\gac\
COPY build_studio\EiffelSoftware.EiffelBase\bin\Release\libEiffelSoftware.EiffelBase.dll delivery\system32\
COPY build_studio\EiffelSoftware.EiffelVision2\bin\Release\EiffelSoftware.EiffelVision2.dll delivery\gac\
COPY build_studio\EiffelSoftware.EiffelVision2\bin\Release\libEiffelSoftware.EiffelVision2.dll delivery\system32\
COPY build_studio\EiffelSoftware.CacheBrowser\bin\Release\EiffelSoftware.CacheBrowser.dll delivery\gac\
COPY build_studio\EiffelSoftware.CodeDom\bin\Release\EiffelSoftware.CodeDom.dll delivery\gac\