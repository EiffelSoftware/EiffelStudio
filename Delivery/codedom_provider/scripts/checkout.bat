@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO Checking out source files...
CD checkout
REM in checkout
ECHO Exporting library.net (%CODEDOM_RELEASE%) in checkout...
svn export %SVNURL%/%CODEDOM_RELEASE%/Src/library.net library.net
ECHO Exporting eclop (HEAD) in checkout...
svn export %SVNURL%/trunk/free_add_ons/eclop eclop
ECHO Exporting Eiffel (%CODEDOM_RELEASE%) in checkout...
svn co %SVNURL%/%CODEDOM_RELEASE%/Src/bench/Eiffel Eiffel
svn co %SVNURL%/%CODEDOM_RELEASE%/Src/common Eiffel/common
CD Eiffel
ECHO Exporting serialization classes (%COMPILER_RELEASE%) in override
svn export %SVNURL%/%COMPILER_RELEASE% -d override Src/dotnet/consumer/serialization
CD ..
ECHO Exporting runtime (%RELEASE%) in checkout...
svn export %SVNURL%/%RELEASE%/Src/bench/C C
ECHO Exporting studio (%RELEASE%) in checkout...
svn export %SVNURL%/%RELEASE%/Delivery/studio compiler_delivery 
ECHO Exporting eifinit (%RELEASE%) in checkout...
svn export %SVNURL%/%RELEASE%/Delivery/eifinit eifinit_delivery 

MKDIR tools
CD tools
REM in checkout\tools
ECHO Exporting silent_launcher (%CODEDOM_RELEASE%) in checkout\tools...
svn export %SVNURL%/%CODEDOM_RELEASE%/Src/tools/silent_launcher silent_launcher 
ECHO Exporting compliance_checker (%RELEASE%) in checkout\tools...
svn export %SVNURL%/%COMPILER_RELEASE%/Src/tools/compliance_checker compliance_checker
ECHO Exporting doc_builder (%RELEASE%) in checkout\tools...
svn export %SVNURL%/%RELEASE%/Src/tools/doc_builder doc_builder
CD ..
REM in checkout

MKDIR C_library
CD C_library
REM in checkout\C_library
ECHO Exporting libpng (%RELEASE%) in checkout\C_library...
svn export %SVNURL%/%RELEASE%/Src/C_library/libpng libpng
ECHO Exporting zlib (%RELEASE%) in checkout\C_library...
svn export %SVNURL%/%RELEASE%/Src/C_library/zlib zlib 

CD ..\
REM in checkout
MKDIR library
CD library
REM in checkout\library
ECHO Copying GOBO
XCOPY /Q /S %GOBO_SRC% gobo\
ECHO Exporting base (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/base base
ECHO Exporting wel (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/wel wel
ECHO Exporting vision2 (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/vision2 vision2
ECHO Exporting vision2_extension (%COMPILER_RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/vision2_extension vision2_extension 
ECHO Exporting thread (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/thread thread 
ECHO Exporting helpers (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/helpers helpers
ECHO Exporting time (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/time time
ECHO Exporting keygen (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/keygen keygen
ECHO Exporting preferences (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/preferences preferences
ECHO Exporting editor (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/editor editor
ECHO Exporting pattern (%RELEASE%) in checkout\library...
svn export %SVNURL%/%RELEASE%/Src/library/patterns patterns
CD ..
REM in checkout

MKDIR dotnet
CD dotnet
REM in checkout\dotnet
ECHO Exporting consumer (%CODEDOM_RELEASE%) in checkout\dotnet...
svn export %SVNURL%/%CODEDOM_RELEASE%/Src/dotnet/consumer consumer
ECHO Exporting helpers (%COMPILER_RELEASE%) in checkout\dotnet...
svn export %SVNURL%/%COMPILER_RELEASE%/Src/dotnet/helpers helpers
ECHO Exporting eac_browser (%RELEASE%) in checkout\dotnet...
svn export %SVNURL%/%RELEASE%/Src/dotnet/eac_browser eac_browser
ECHO Exporting codedom_provider (%CODEDOM_RELEASE%) in checkout\dotnet...
svn export %SVNURL%/%CODEDOM_RELEASE%/Src/dotnet/codedom_provider codedom_provider

CD ..\
REM in checkout
MKDIR docs
CD docs
REM in checkout\docs
svn export %SVNURL%/%RELEASE%/Delivery/xmldoc xmldoc

CD ..\..
