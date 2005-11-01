@ECHO OFF
REM **************************************************
REM Eiffel Codedom Provider documentation build script
REM **************************************************

ECHO Building Documentation
IF EXIST "delivery\Documentation\Eiffel for ASP.NET.chm" GOTO END
IF NOT EXIST delivery\Documentation MKDIR delivery\Documentation
CD checkout\docs
REM in checkout\docs
IF EXIST doc_builder.exe GOTO COMPILEDOC

CD doc_builder
REM in checkout\docs\doc_builder
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL *.epr
ec -finalize -batch -c_compile -ace docbuilder.mswin.ace
IF NOT EXIST EIFGEN\F_code\doc_builder.exe ECHO ERROR: Documentation builder could not be built!
IF NOT EXIST EIFGEN\F_code\doc_builder.exe GOTO END
COPY EIFGEN\F_Code\doc_builder.exe ..\
CD ..
REM in checkout\docs

:COMPILEDOC
IF EXIST codedom.chm GOTO END
doc_builder.exe -gen /xml2help -o /studio -t /mshtml -nohtml xmldoc\projects\codedom.dpr
CD /d C:\doc\Html
hhc docs.hhp
COPY C:\doc\Html\docs.chm "%ECPOriginalPath%\Delivery\documentation\Eiffel for ASP.NET.chm"
CD %ECPOriginalPath%

:END
ECHO Done building documentation.