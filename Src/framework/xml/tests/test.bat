setlocal
@echo off
set FILENAME=C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\en\mscorlib.xml

set ECHOTEST=echo [test_xml] 
chdir %~dp0\bin\EIFGENs\xml_parser\F_code
set TEST=test_xml.exe

rem From FILE
set TEST_XML_PARSER=file

%ECHOTEST%  FILE+NULL ------------------------------------------
set TEST_XML_PARSER=null
%TEST% %FILENAME%

rem %ECHOTEST%  FILE+DEBUG -----------------------------------------
rem set TEST_XML_PARSER=debug
rem %TEST% %FILENAME%

%ECHOTEST%  FILE+TREE  -----------------------------------------
set TEST_XML_PARSER=tree
%TEST% %FILENAME%

%ECHOTEST%  FILE+XML_TREE --------------------------------------
set TEST_XML_PARSER=xml_tree
%TEST% %FILENAME%

rem From STRING
set TEST_XML_PARSER_KIND=string

%ECHOTEST%  STRING+NULL ----------------------------------------
set TEST_XML_PARSER=null
%TEST% %FILENAME%

rem %ECHOTEST%  STRING+DEBUG ---------------------------------------
rem set TEST_XML_PARSER=debug
rem %TEST% %FILENAME%

%ECHOTEST%  STRING+TREE ----------------------------------------
set TEST_XML_PARSER=tree
%TEST% %FILENAME%

%ECHOTEST%  STRING+XML_TREE ------------------------------------
set TEST_XML_PARSER=xml_tree
%TEST% %FILENAME%

rem %ECHOTEST%  STRING+XML_TREE_VIS --------------------------------
rem set TEST_XML_PARSER=xml_tree_vis
rem %TEST% %FILENAME%
rem

echo ==========================================================
set ECHOTEST=echo [test_xml_gobo] 
chdir %~dp0\bin\EIFGENs\xml_gobo_parser\F_code
set TEST=test_xml_gobo.exe

rem From FILE
set TEST_XML_PARSER_KIND=file

%ECHOTEST%  FILE+NULL ------------------------------------------
set TEST_XML_PARSER=null
%TEST% %FILENAME%

rem %ECHOTEST%  FILE+DEBUG -----------------------------------------
rem set TEST_XML_PARSER=debug
rem %TEST% %FILENAME%

%ECHOTEST%  FILE+TREE  -----------------------------------------
set TEST_XML_PARSER=tree
%TEST% %FILENAME%

%ECHOTEST%  FILE+XML_TREE --------------------------------------
set TEST_XML_PARSER=xml_tree
%TEST% %FILENAME%

rem From STRING
set TEST_XML_PARSER_KIND=string

%ECHOTEST%  STRING+NULL ----------------------------------------
set TEST_XML_PARSER=null
%TEST% %FILENAME%

rem %ECHOTEST%  STRING+DEBUG ---------------------------------------
rem set TEST_XML_PARSER=debug
rem %TEST% %FILENAME%

%ECHOTEST%  STRING+TREE ----------------------------------------
set TEST_XML_PARSER=tree
%TEST% %FILENAME%

%ECHOTEST%  STRING+XML_TREE ------------------------------------
set TEST_XML_PARSER=xml_tree
%TEST% %FILENAME%

rem %ECHOTEST%  STRING+XML_TREE_VIS --------------------------------
rem set TEST_XML_PARSER=xml_tree_vis
rem %TEST% %FILENAME%

echo ==========================================================
set ECHOTEST=echo [test_gobo_xm] 
chdir %~dp0\bin\EIFGENs\gobo_xm_parser\F_code
set TEST=test_gobo_xm.exe

rem From FILE
set TEST_XML_PARSER_KIND=file

%ECHOTEST%  FILE+NULL ------------------------------------------
set TEST_XML_PARSER=null
%TEST% %FILENAME%

rem %ECHOTEST%  FILE+DEBUG -----------------------------------------
rem set TEST_XML_PARSER=debug
rem %TEST% %FILENAME%

%ECHOTEST%  FILE+TREE  -----------------------------------------
set TEST_XML_PARSER=tree
%TEST% %FILENAME%

%ECHOTEST%  FILE+XML_TREE --------------------------------------
set TEST_XML_PARSER=xml_tree
%TEST% %FILENAME%

rem From STRING
set TEST_XML_PARSER_KIND=string

%ECHOTEST%  STRING+NULL ----------------------------------------
set TEST_XML_PARSER=null
%TEST% %FILENAME%

rem %ECHOTEST%  STRING+DEBUG ---------------------------------------
rem set TEST_XML_PARSER=debug
rem %TEST% %FILENAME%

%ECHOTEST%  STRING+TREE ----------------------------------------
set TEST_XML_PARSER=tree
%TEST% %FILENAME%

%ECHOTEST%  STRING+XML_TREE ------------------------------------
set TEST_XML_PARSER=xml_tree
%TEST% %FILENAME%

rem %ECHOTEST%  STRING+XML_TREE_VIS --------------------------------
rem set TEST_XML_PARSER=xml_tree_vis
rem %TEST% %FILENAME%


endlocal
