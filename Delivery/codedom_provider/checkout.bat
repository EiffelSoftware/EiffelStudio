@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO Checking out source files...
CD checkout
cvs -z3 export -r%COMPILER_RELEASE% -d com_compiler Src/bench/com_compiler
cvs -z3 export -r%COMPILER_RELEASE% Eiffel
cvs -z3 export -r%COMPILER_RELEASE% runtime
cvs -z3 export -rHEAD -d eclop free_add_ons/eclop
cvs -z3 export -r%COMPILER_RELEASE% -d library.net Src/library.net
cvs -z3 export -r%COMPILER_RELEASE% -d compiler_delivery Delivery/studio

MKDIR C_library
CD C_library
cvs -z3 export -r%COMPILER_RELEASE% -d libpng Src/C_library/libpng
cvs -z3 export -r%COMPILER_RELEASE% -d zlib Src/C_library/zlib
CD ..

cvs -z3 export -r%COMPILER_RELEASE% -d library free_add_ons/gobo
CD library
tar -xzf gobo_33_win.tgz
DEL gobo_33*
DEL *.tgz
cvs -z3 export -r%COMPILER_RELEASE% -d base Src/library/base
cvs -z3 export -r%COMPILER_RELEASE% -d wel Src/library/wel
cvs -z3 export -r%COMPILER_RELEASE% -d vision2 Src/library/vision2
cvs -z3 export -r%COMPILER_RELEASE% -d vision2_extension Src/library/vision2_extension
cvs -z3 export -r%COMPILER_RELEASE% -d com Src/library/com
cvs -z3 export -r%COMPILER_RELEASE% -d time Src/library/time
cvs -z3 export -r%COMPILER_RELEASE% -d helpers Src/library/helpers
cvs -z3 export -r%COMPILER_RELEASE% -d keygen Src/library/keygen
CD ..

MKDIR dotnet
CD dotnet
cvs -z3 export -r%COMPILER_RELEASE% -d consumer Src/dotnet/consumer
cvs -z3 export -r%COMPILER_RELEASE% -d helpers Src/dotnet/helpers
cvs -z3 export -r%COMPILER_RELEASE% -d eac_browser Src/dotnet/eac_browser
cvs -z3 export -r%CODEDOM_RELEASE% -d codedom_provider Src/dotnet/codedom_provider
MKDIR VisualStudio\tools
CD VisualStudio\tools\
cvs -z3 export -r%COMPILER_RELEASE% -d documentation_manager Src/dotnet/VisualStudio/tools/documentation_manager/
CD ..\..\..

CD ..