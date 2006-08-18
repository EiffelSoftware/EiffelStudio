@ECHO OFF
REM **************************************************
REM Eiffel Codedom Provider documentation build script
REM **************************************************

ECHO Building Documentation
TITLE Building Documentation

IF EXIST "delivery\Documentation\Eiffel for ASP.NET.chm" GOTO END
IF NOT EXIST delivery\Documentation MKDIR delivery\Documentation
CD checkout
REM in checkout
IF EXIST docs\doc_builder.exe GOTO COMPILEDOC

SET PATH=%INIT_PATH%;"%1\studio\spec\windows\bin"
SET DOCUMENT_DIR=.
CD tools\doc_builder
REM in checkout\tools\doc_builder

ECHO Registering initial compiler's metadata consumer
TITLE Registering initial compiler's metadata consumer
regasm %ISE_EIFFEL%\studio\spec\windows\bin\EiffelSoftware.MetadataConsumer.dll
IF EXIST %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll.bak COPY /Y %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll.bak %SystemRoot%\system32\libEiffelSoftware.MetadataConsumer.dll
IF EXIST EIFGEN RD /Q /S EIFGEN
IF EXIST *.epr DEL *.epr
ec -finalize -batch -c_compile -config docbuilder.ecf -target doc_builder
IF NOT EXIST EIFGENs\doc_builder\F_code\doc_builder.exe ECHO ERROR: Documentation builder could not be built!
IF NOT EXIST EIFGENs\doc_builder\F_code\doc_builder.exe GOTO END
COPY EIFGENs\doc_builder\F_Code\doc_builder.exe ..\..\docs\

CD ..\..\
REM in checkout

:COMPILEDOC
IF EXIST codedom.chm GOTO END
CD docs\
REM in checkout\docs
IF EXIST C:\doc RD /Q /S C:\doc
IF EXIST C:\doc ECHO Could not delete C:\doc, exiting.
IF EXIST C:\doc GOTO END
MKDIR C:\doc
MKDIR C:\doc\html
doc_builder.exe -gen /xml2help -o /all -t /mshtml -nohtml xmldoc\projects\codedom.dpr
CD /d C:\doc\Html
hhc docs.hhp
COPY C:\doc\Html\docs.chm "%ECPOriginalPath%\Delivery\documentation\Eiffel for ASP.NET.chm"

SET DOCS_BUILT=1

:END
SET PATH=%INIT_PATH%
CD %ECPOriginalPath%
ECHO Done building documentation.
TITLE Done building documentation.