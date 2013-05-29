@echo off
setlocal

set T_HERE=%cd%
if "%ISE_PLATFORM%" == "" goto failure

rem set TMP_SOURCE_TOPDIR=%ISE_EIFFEL%\library
set TMP_SOURCE_TOPDIR=%~dp0%\_libs
if exist %TMP_SOURCE_TOPDIR% svn update _libs
if not exist %TMP_SOURCE_TOPDIR% svn checkout https://svn.eiffel.com/eiffelstudio/trunk/Src/library _libs

set IRON_CREATE_OPTS=create -u jfiat -p jfiat12345 --repository http://iron.eiffel.com/7.3 --batch
set IRON_UPDATE_OPTS=update -u jfiat -p jfiat12345 --repository http://iron.eiffel.com/7.3 --batch
rem set IRON_CREATE_OPTS=create -u jfiat -p test --repository http://localhost:9090/7.3

set IRON_CMD=iron.exe package
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "base" --package-description "Eiffel Base: Kernel library classes, data structure, I/O" --package-archive-source "%TMP_SOURCE_TOPDIR%\base"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "api_wrapper" --package-description "API wrapper: Make it easy to call C routines from dynamically loaded shared libraries" --package-archive-source "%TMP_SOURCE_TOPDIR%\api_wrapper"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "old_argument_parser" --package-description "Argument parser (Obsolete, no unicode support)" --package-archive-source "%TMP_SOURCE_TOPDIR%\argument_parser"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "base_extension" --package-description "Eiffel Base extension" --package-archive-source "%TMP_SOURCE_TOPDIR%\base_extension"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "com" --package-description "Eiffel COM: COM technology (Windows only)" --package-archive-source "%TMP_SOURCE_TOPDIR%\com"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "curl" --package-description "Eiffel cURL wrapper" --package-archive-source "%TMP_SOURCE_TOPDIR%\cURL"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "diff" --package-description "Diff and patch facilities" --package-archive-source "%TMP_SOURCE_TOPDIR%\diff"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "docking" --package-description "Facility to have a customizable UI" --package-archive-source "%TMP_SOURCE_TOPDIR%\docking"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "editor" --package-description "Eiffel Vision2 Editor component" --package-archive-source "%TMP_SOURCE_TOPDIR%\editor"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "eiffel2java" --package-description "Eiffel2Java: Calling Java from Eiffel" --package-archive-source "%TMP_SOURCE_TOPDIR%\Eiffel2Java"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "encoding" --package-description "Transforming text in one encoding to another encoding" --package-archive-source "%TMP_SOURCE_TOPDIR%\encoding"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "event" --package-description " Low level mechanism to receive a UI event when a file/pipe has something new." --package-archive-source "%TMP_SOURCE_TOPDIR%\event"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "graph" --package-description "Representation of graph in UI (See diagram tool in EiffelStudio)" --package-archive-source "%TMP_SOURCE_TOPDIR%\graph"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "i18n" --package-description "Internationalization library" --package-archive-source "%TMP_SOURCE_TOPDIR%\i18n"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "lex" --package-description "Eiffel LEX" --package-archive-source "%TMP_SOURCE_TOPDIR%\lex"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "memory_analyzer" --package-description "Memory analysis" --package-archive-source "%TMP_SOURCE_TOPDIR%\memory_analyzer"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "net" --package-description "Eiffel NET: networking library" --package-archive-source "%TMP_SOURCE_TOPDIR%\net"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "parse" --package-description "Eiffel PARSE" --package-archive-source "%TMP_SOURCE_TOPDIR%\parse"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "preferences" --package-description "Facility to store user preferences" --package-archive-source "%TMP_SOURCE_TOPDIR%\preferences"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "process" --package-description "Eiffel Process:  Facility to start and follow processes" --package-archive-source "%TMP_SOURCE_TOPDIR%\process"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "ribbon" --package-description "Eiffel Ribbon (Windows only)" --package-archive-source "%TMP_SOURCE_TOPDIR%\ribbon"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "store" --package-description "Eiffel Store: Relational database access" --package-archive-source "%TMP_SOURCE_TOPDIR%\store"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "arg_parser" --package-description "Parsing the command line arguments of a program (unicode support)" --package-archive-source "%TMP_SOURCE_TOPDIR%\runtime\process\arg_parser"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "testing" --package-description "Testing facility (autotest library)" --package-archive-source "%TMP_SOURCE_TOPDIR%\testing"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "uri" --package-description "URI lib" --package-archive-source "%TMP_SOURCE_TOPDIR%\text\uri"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "xml" --package-description "XML librarїes" --package-archive-source "%TMP_SOURCE_TOPDIR%\text\parser\xml"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "kmp_matcher" --package-description "KMP Matcher" --package-archive-source "%TMP_SOURCE_TOPDIR%\text\regexp\kmp_matcher"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "thread" --package-description "Eiffel Thread: Threading in Eiffel" --package-archive-source "%TMP_SOURCE_TOPDIR%\thread"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "time" --package-description "Eiffel Time (and date)" --package-archive-source "%TMP_SOURCE_TOPDIR%\time"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "uuid" --package-description "UUID generation facility" --package-archive-source "%TMP_SOURCE_TOPDIR%\uuid"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "vision2" --package-description "Eiffel Vision2: Platform independent UI toolkit" --package-archive-source "%TMP_SOURCE_TOPDIR%\vision2"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "vision2_extension" --package-description "Extension to Eiffel Vision2" --package-archive-source "%TMP_SOURCE_TOPDIR%\vision2_extension"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "web" --package-description "Eiffel Web: basic CGI facility for Eiffel" --package-archive-source "%TMP_SOURCE_TOPDIR%\web"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "web_browser" --package-description "WebBrowser component" --package-archive-source "%TMP_SOURCE_TOPDIR%\web_browser"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "wel" --package-description "Eiffel WEL: UI toolkit for Windows" --package-archive-source "%TMP_SOURCE_TOPDIR%\wel"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "gobo" --package-description "Gobo" --package-archive-source "%TMP_SOURCE_TOPDIR%\gobo"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "gobo_extension" --package-description "Gobo Extension" --package-archive-source "%TMP_SOURCE_TOPDIR%\gobo_extension"

rem current layout
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "base" --index "/eiffelsoftware/base" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "api_wrapper" --index "/eiffelsoftware/api_wrapper"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "old_argument_parser" --index "/eiffelsoftware/argument_parser"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "com" --index "/eiffelsoftware/com"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "base_extension" --index "/eiffelsoftware/base_extension" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "curl"  --index "/eiffelsoftware/curl"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "diff"  --index "/eiffelsoftware/diff"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "docking"  --index "/eiffelsoftware/docking"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "editor" --index "/eiffelsoftware/editor"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "eiffel2java" --index "/eiffelsoftware/eiffel2java"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "encoding"  --index "/eiffelsoftware/encoding"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "event" --index "/eiffelsoftware/event"  
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "graph"  --index "/eiffelsoftware/graph" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "i18n"  --index "/eiffelsoftware/i18n"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "lex"  --index "/eiffelsoftware/lex"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "memory_analyzer"  --index "/eiffelsoftware/memory_analyzer" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "net" --index "/eiffelsoftware/net" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "parse" --index "/eiffelsoftware/parse"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "preferences"  --index "/eiffelsoftware/preferences" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "process" --index "/eiffelsoftware/process"  
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "ribbon" --index "/eiffelsoftware/ribbon"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "store"  --index "/eiffelsoftware/store" 

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "arg_parser" --index "/eiffelsoftware/argument_parser" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "logging" --index "/eiffelsoftware/runtime/logging"  

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "testing" --index "/eiffelsoftware/testing"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "uri"  --index "/eiffelsoftware/uri"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "xml" --index "/eiffelsoftware/xml" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "kmp_matcher"  --index "/eiffelsoftware/text/regexp/kmp_matcher"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "thread" --index "/eiffelsoftware/thread" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "time" --index "/eiffelsoftware/time"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "uuid" --index "/eiffelsoftware/uuid"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "vision2"  --index "/eiffelsoftware/vision2" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "vision2_extension" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "web" --index "/eiffelsoftware/web"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "web_browser" --index "/eiffelsoftware/web_browser"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "wel"  --index "/eiffelsoftware/wel" 

rem new library categorization
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "base" --index "/eiffelsoftware/data_structure/adt/base"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "base_extension" --index "/eiffelsoftware/data_structure/adt/base_extension"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "event" --index "/eiffelsoftware/data_structure/adt/event"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "graph"  --index "/eiffelsoftware/graphic/drawing/graph"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "editor" --index "/eiffelsoftware/graphic/drawing/editor"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "ribbon" --index "/eiffelsoftware/graphic/drawing/ribbon"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "web_browser" --index "/eiffelsoftware/graphic/drawing/web_browser"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "docking"  --index "/eiffelsoftware/graphic/framework/docking"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "preferences"  -index "/eiffelsoftware/graphic/framework/preferences"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "vision2"  --index "/eiffelsoftware/graphic/toolkit/vision2"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "vision2_extension" --index "/eiffelsoftware/graphic/toolkit/vision2_extension"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "wel"  --index "/eiffelsoftware/graphic/toolkit/wel"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "api_wrapper" --index "/eiffelsoftware/language_interface/C/api_wrapper"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "com" --index "/eiffelsoftware/language_interface/COM/com"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "eiffel2java" --index "/eiffelsoftware/language_interface/Java/eiffel2java"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "curl" --index "/eiffelsoftware/network/curl"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "net"  --index "/eiffelsoftware/network/socket/net"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "store"  --index "/eiffelsoftware/persistency/database/store"


%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "memory_analyzer"  --index "/eiffelsoftware/runtime/memory/memory_analyzer"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "arg_parser" --index "/eiffelsoftware/runtime/process/argument_parser"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "process" --index "/eiffelsoftware/runtime/process/process"
rem %IRON_CMD% %IRON_UPDATE_OPTS% --package-name "logging" --index "/eiffelsoftware/runtime/logging"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "thread" --index "/eiffelsoftware/runtime/concurrency/thread"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "testing" --index "/eiffelsoftware/tests/framework/testing"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "encoding"  --index "/eiffelsoftware/text/encoding/encoding"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "i18n"  --index "/eiffelsoftware/text/internationalization/i18n"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "lex"  --index "/eiffelsoftware/text/lexer/lex"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "parse" --index "/eiffelsoftware/parser/parse"
rem %IRON_CMD% %IRON_UPDATE_OPTS% --package-name "xml" --index "/eiffelsoftware/text/parser/xml"
rem %IRON_CMD% %IRON_UPDATE_OPTS% --package-name "kmp_matcher"  --index "/eiffelsoftware/text/regexp/kmp_matcher"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "diff"  --index "/eiffelsoftware/text/utility/diff"
rem %IRON_CMD% %IRON_UPDATE_OPTS% --package-name "uri"  --index "/eiffelsoftware/text/uri"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "uuid" --index "/eiffelsoftware/utility/general/uuid"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "time" --index "/eiffelsoftware/utility/time/time"

goto end
:failure
echo failed!
endlocal
exit /B 0

:end
endlocal
exit /B 0


