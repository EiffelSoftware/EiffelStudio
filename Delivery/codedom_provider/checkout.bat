@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO Checking out source files...
CD checkout
REM in checkout
cvs -z3 export -r%COMPILER_RELEASE% Eiffel
cvs -z3 export -r%RELEASE% runtime
cvs -z3 export -rHEAD -d eclop free_add_ons/eclop
cvs -z3 export -r%RELEASE% -d library.net Src/library.net
cvs -z3 export -r%RELEASE% -d compiler_delivery Delivery/studio
cvs -z3 export -r%RELEASE% -d eifinit_delivery Delivery/eifinit
cvs -z3 export -r%RELEASE% -d precomp_delivery Delivery/precomp

MKDIR tools
CD tools
REM in checkout\tools
cvs -z3 export -rHEAD -d silent_launcher Src/tools/silent_launcher
CD ..
REM in checkout

MKDIR C_library
CD C_library
REM in checkout\C_library
cvs -z3 export -r%RELEASE% -d libpng Src/C_library/libpng
cvs -z3 export -r%RELEASE% -d zlib Src/C_library/zlib
CD ..
REM in checkout

cvs -z3 export -r%RELEASE% -d library free_add_ons/gobo
CD library
REM in checkout\library
tar -xzf gobo_33_win.tgz
cvs -z3 export -r%RELEASE% -d base Src/library/base
cvs -z3 export -rHEAD -d wel Src/library/wel
cvs -z3 export -r%COMPILER_RELEASE% -d vision2 Src/library/vision2
cvs -z3 export -r%RELEASE% -d vision2_extension Src/library/vision2_extension
cvs -z3 export -r%RELEASE% -d time Src/library/time
cvs -z3 export -r%RELEASE% -d helpers Src/library/helpers
cvs -z3 export -r%RELEASE% -d keygen Src/library/keygen
cvs -z3 export -r%RELEASE% -d preferences Src/library/preferences
cvs -z3 export -r%RELEASE% -d thread Src/library/thread
CD ..
REM in checkout

MKDIR dotnet
CD dotnet
REM in checkout\dotnet
cvs -z3 export -r%COMPILER_RELEASE% -d consumer Src/dotnet/consumer
cvs -z3 export -r%COMPILER_RELEASE% -d helpers Src/dotnet/helpers
cvs -z3 export -r%RELEASE% -d eac_browser Src/dotnet/eac_browser
cvs -z3 export -r%CODEDOM_RELEASE% -d codedom_provider Src/dotnet/codedom_provider
MKDIR VisualStudio\tools
CD VisualStudio\tools\
REM in checkout\dotnet\VisualStudio\tools
cvs -z3 export -rHEAD -d documentation_manager Src/dotnet/VisualStudio/tools/documentation_manager/
CD ..\..\..
REM in checkout

CD ..