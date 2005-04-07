@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO Checking out source files...
CD checkout
REM in checkout
MKDIR head
MKDIR compiler
CD head
REM in checkout\head
cvs -z3 export -rHEAD -d library.net Src/library.net
cvs -z3 export -rHEAD -d eclop free_add_ons/eclop
CD ..\compiler
REM in checkout\compiler
cvs -z3 export -r%COMPILER_RELEASE% Eiffel
cvs -z3 export -r%RELEASE% runtime
cvs -z3 export -r%RELEASE% -d library.net Src/library.net
cvs -z3 export -r%RELEASE% -d compiler_delivery Delivery/studio
cvs -z3 export -r%RELEASE% -d eifinit_delivery Delivery/eifinit
cvs -z3 export -r%RELEASE% -d precomp_delivery Delivery/precomp

CD ..\head
REM in checkout\head
MKDIR tools
CD tools
REM in checkout\tools
cvs -z3 export -rHEAD -d silent_launcher Src/tools/silent_launcher
CD ..
REM in checkout\head

MKDIR C_library
CD C_library
REM in checkout\head\C_library
cvs -z3 export -rHEAD -d libpng Src/C_library/libpng
cvs -z3 export -rHEAD -d zlib Src/C_library/zlib
CD ..\..\compiler
REM in checkout\compiler
MKDIR C_library
CD C_library
REM in checkout\compiler\C_library
cvs -z3 export -r%RELEASE% -d libpng Src/C_library/libpng
cvs -z3 export -r%RELEASE% -d zlib Src/C_library/zlib

CD ..\..\head
REM in checkout\head
cvs -z3 export -rHEAD -d library free_add_ons/gobo
CD library
REM in checkout\head\library
tar -xzf gobo_33_win.tgz
cvs -z3 export -rHEAD -d base Src/library/base
cvs -z3 export -rHEAD -d wel Src/library/wel
cvs -z3 export -rHEAD -d vision2 Src/library/vision2
cvs -z3 export -rHEAD -d vision2_extension Src/library/vision2_extension
cvs -z3 export -rHEAD -d thread Src/library/thread
cvs -z3 export -rHEAD -d helpers Src/library/helpers
CD ..\..\compiler
REM in checkout\compiler
cvs -z3 export -r%RELEASE% -d library free_add_ons/gobo
CD library
REM in checkout\compiler\library
tar -xzf gobo_33_win.tgz
cvs -z3 export -r%RELEASE% -d base Src/library/base
cvs -z3 export -r%RELEASE% -d wel Src/library/wel
cvs -z3 export -r%COMPILER_RELEASE% -d vision2 Src/library/vision2
cvs -z3 export -r%RELEASE% -d time Src/library/time
cvs -z3 export -r%RELEASE% -d helpers Src/library/helpers
cvs -z3 export -r%RELEASE% -d keygen Src/library/keygen
cvs -z3 export -r%RELEASE% -d preferences Src/library/preferences
CD ..
REM in checkout\compiler

MKDIR dotnet
CD dotnet
REM in checkout\compiler\dotnet
cvs -z3 export -r%COMPILER_RELEASE% -d consumer Src/dotnet/consumer
cvs -z3 export -r%COMPILER_RELEASE% -d helpers Src/dotnet/helpers
cvs -z3 export -r%RELEASE% -d eac_browser Src/dotnet/eac_browser
MKDIR VisualStudio\tools
CD VisualStudio\tools\
REM in checkout\compiler\dotnet\VisualStudio\tools
cvs -z3 export -r%COMPILER_RELEASE% -d documentation_manager Src/dotnet/VisualStudio/tools/documentation_manager/

CD ..\..\..\..\head
REM in checkout\head
MKDIR dotnet
CD dotnet
REM in checkout\head\dotnet
cvs -z3 export -r%CODEDOM_RELEASE% -d codedom_provider Src/dotnet/codedom_provider
cvs -z3 export -r%CODEDOM_RELEASE% -d consumer Src/dotnet/consumer
cvs -z3 export -r%CODEDOM_RELEASE% -d helpers Src/dotnet/helpers

CD..
REM in checkout\head
MKDIR Eiffel\common\parser
CD Eiffel\common\parser
REM in checkout\head\Eiffel\common\parser
cvs -z3 export -r%COMPILER_RELEASE% -d parser Src/common/parser/parser
cvs -z3 export -r%COMPILER_RELEASE% -d ast Src/common/parser/AST
CD ..\..
REM in checkout\head\Eiffel
cvs -z3 export -r%COMPILER_RELEASE% -d API Src/bench/Eiffel/API
cvs -z3 export -r%COMPILER_RELEASE% -d yacc Src/bench/Eiffel/yacc
MKDIR eiffel
CD eiffel
REM in checkout\head\Eiffel\eiffel
cvs -z3 export -r%COMPILER_RELEASE% -d structures Src/bench/Eiffel/eiffel/structures
cvs -z3 export -r%COMPILER_RELEASE% -d const Src/bench/Eiffel/eiffel/const

CD ..\..\..\..
