@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO Checking out source files...
CD checkout
REM in checkout
ECHO Exporting library.net (%RELEASE%) in checkout...
cvs -z3 -Q export -r%RELEASE% -d library.net Src/library.net
ECHO Exporting eclop (HEAD) in checkout...
cvs -z3 -Q export -r%HEAD -d eclop free_add_ons/eclop
ECHO Exporting Eiffel (%COMPILER_RELEASE%) in checkout...
cvs -z3 -Q export -r%COMPILER_RELEASE% Eiffel
ECHO Exporting runtime (%RELEASE%) in checkout...
cvs -z3 -Q export -r%RELEASE% runtime
ECHO Exporting studio (%RELEASE%) in checkout...
cvs -z3 -Q export -r%RELEASE% -d compiler_delivery Delivery/studio
ECHO Exporting eifinit (%RELEASE%) in checkout...
cvs -z3 -Q export -r%RELEASE% -d eifinit_delivery Delivery/eifinit
ECHO Exporting precomp (%RELEASE%) in checkout...
cvs -z3 -Q export -r%RELEASE% -d precomp_delivery Delivery/precomp

MKDIR tools
CD tools
REM in checkout\tools
ECHO Exporting silent_launcher (%CODEDOM_RELEASE%) in checkout\tools...
cvs -z3 -Q export -r%CODEDOM_RELEASE% -d silent_launcher Src/tools/silent_launcher
CD ..
REM in checkout

MKDIR C_library
CD C_library
REM in checkout\C_library
ECHO Exporting libpng (%RELEASE%) in checkout\C_library...
cvs -z3 -Q export -r%RELEASE% -d libpng Src/C_library/libpng
ECHO Exporting zlib (%RELEASE%) in checkout\C_library...
cvs -z3 -Q export -r%RELEASE% -d zlib Src/C_library/zlib

CD ..\
REM in checkout
MKDIR library
CD library
REM in checkout\library
ECHO Copying GOBO
XCOPY /Q /S %GOBO_SRC% gobo\
ECHO Exporting base (%RELEASE%) in checkout\library...
cvs -z3 -Q export -r%RELEASE% -d base Src/library/base
ECHO Exporting wel (%RELEASE%) in checkout\library...
cvs -z3 -Q export -r%RELEASE% -d wel Src/library/wel
ECHO Exporting vision2 (%COMPILER_RELEASE%) in checkout\library...
cvs -z3 -Q export -r%COMPILER_RELEASE% -d vision2 Src/library/vision2
ECHO Exporting vision2_extension (%COMPILER_RELEASE%) in checkout\library...
cvs -z3 -Q export -r%COMPILER_RELEASE% -d vision2_extension Src/library/vision2_extension
ECHO Exporting thread (%RELEASE%) in checkout\library...
cvs -z3 -Q export -r%RELEASE% -d thread Src/library/thread
ECHO Exporting helpers (%RELEASE%) in checkout\library...
cvs -z3 -Q export -r%RELEASE% -d helpers Src/library/helpers
ECHO Exporting time (%RELEASE%) in checkout\library...
cvs -z3 -Q export -r%RELEASE% -d time Src/library/time
ECHO Exporting keygen (%RELEASE%) in checkout\library...
cvs -z3 -Q export -r%RELEASE% -d keygen Src/library/keygen
ECHO Exporting preferences (%RELEASE%) in checkout\library...
cvs -z3 -Q export -r%RELEASE% -d preferences Src/library/preferences
CD ..
REM in checkout

MKDIR dotnet
CD dotnet
REM in checkout\dotnet
ECHO Exporting consumer (%COMPILER_RELEASE%) in checkout\dotnet...
cvs -z3 -Q export -r%COMPILER_RELEASE% -d consumer Src/dotnet/consumer
ECHO Exporting helpers (%COMPILER_RELEASE%) in checkout\dotnet...
cvs -z3 -Q export -r%COMPILER_RELEASE% -d helpers Src/dotnet/helpers
ECHO Exporting eac_browser (%RELEASE%) in checkout\dotnet...
cvs -z3 -Q export -r%RELEASE% -d eac_browser Src/dotnet/eac_browser
ECHO Exporting codedom_provider (%CODEDOM_RELEASE%) in checkout\dotnet...
cvs -z3 -Q export -r%CODEDOM_RELEASE% -d codedom_provider Src/dotnet/codedom_provider

CD ..\..
