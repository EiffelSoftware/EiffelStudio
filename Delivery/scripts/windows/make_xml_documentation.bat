REM To call this script you need:
REM 1 - having in $EIFFEL_SRC library and tools
REM 2 - having created directory for DOCUMENT_DIR
REM
REM Script argument:
REM 	%1 = $ISE_EIFFEL
REM 	%2 = $EIFFEL_SRC
REM 	%3 = Directory where to check out xml documentation
REM 	%4 = type of documentation generation (studio or envision)

set ISE_EIFFEL=%1
set EIFFEL_SRC=%2
set DOCUMENT_DIR=%3
set DOCBUILDER_DIR=%2\tools\doc_builderfromscript


REM --------------------------------------------------------
REM Checkout up to date version of XML documentation files |
REM --------------------------------------------------------

 cvs co -d %DOCUMENT_DIR% Delivery/xmldoc 


REM ---------------------------------------------
REM Checkout and compile the Documentation tool |
REM ---------------------------------------------

cd /d %DOCBUILDER_DIR%
cvs co -d %DOCBUILDER_DIR% Src/tools/doc_builder
%ISE_EIFFEL%\studio\spec\windows\bin\ec.exe -finalize -ace docbuilder_classic.ace -c_compile


REM ---------------------------------------------------------------
REM Compile all required libraries and generate XML documentation |
REM ---------------------------------------------------------------

cd /d %DOCBUILDER_DIR%\resources\xml
%ISE_EIFFEL%\studio\spec\windows\bin\ec -ace all_libs.ace
%ISE_EIFFEL%\studio\spec\windows\bin\ec -flatshort -filter xml -all -project all_libs.epr


REM ------------------------------------------------------
REM Copy XML docs into appropriate written docs location |
REM ------------------------------------------------------

call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\base" %DOCUMENT_DIR%\libraries\base\reference
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\wel" %DOCUMENT_DIR%\libraries\wel\reference\
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\vision2" %DOCUMENT_DIR%\libraries\vision2\reference\
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\com" %DOCUMENT_DIR%\libraries\com\reference\
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\eiffel2java" %DOCUMENT_DIR%\libraries\eiffel2java\reference\
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\lex" %DOCUMENT_DIR%\libraries\lex\reference\
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\parse" %DOCUMENT_DIR%\libraries\parse\reference
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\net" %DOCUMENT_DIR%\libraries\net\reference\
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\thread" %DOCUMENT_DIR%\libraries\thread\reference\
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\time" %DOCUMENT_DIR%\libraries\time\reference\
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\web" %DOCUMENT_DIR%\libraries\web\reference\
call %DOCBUILDER_DIR%\resources\xml\lib_doc_copy.bat "%DOCBUILDER_DIR%\resources\xml\Documentation\store" %DOCUMENT_DIR%\libraries\store\reference\

cd /d %DOCBUILDER_DIR%\EIFGEN\F_code
	
	
REM ----------------------------------------------------------------------------------------
REM Run the documentation tool to generate the documentation for EiffelStudio as .chm file |
REM ----------------------------------------------------------------------------------------

if %4 == studio (
	docbuilder.exe -gen /xml2help -o /studio -t /mshtml %DOCUMENT_DIR%\documentation.dpr
)

REM ----------------------------------------------------------------------------------------
REM Run the documentation tool to generate the documentation for ENViSioN! as VSIP project |
REM ----------------------------------------------------------------------------------------

if %4 == envision (
	docbuilder.exe -gen /xml2help -o /env -t /vsip %DOCUMENT_DIR%\documentation.dpr
)
