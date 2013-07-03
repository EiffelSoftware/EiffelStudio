@echo off
setlocal

if not exist "%~dp0set_credential.bat" goto create_set_credential_script
@call %~dp0set_credential.bat

set T_HERE=%cd%
if "%ISE_PLATFORM%" == "" goto failure

set TMP_IRON_REPOSITORY=http://iron.eiffel.com/7.3
set TMP_IRON_ISE_DOMAIN=com.eiffel

set IRON_CREATE_OPTS=create -u %IRON_USERNAME% -p %IRON_PASSWORD% --repository %TMP_IRON_REPOSITORY% --batch
set IRON_UPDATE_OPTS=update -u %IRON_USERNAME% -p %IRON_PASSWORD% --repository %TMP_IRON_REPOSITORY% --batch

rem rem ISE_LIBRARY/library
rem set TMP_SRC_LIBRARY=%ISE_EIFFEL%\library
set TMP_SRC_LIBRARY=%~dp0%\_libs
if exist %TMP_SRC_LIBRARY% svn update _libs
if not exist %TMP_SRC_LIBRARY% svn checkout https://svn.eiffel.com/eiffelstudio/branches/Eiffel_73/Src/library _libs


set IRON_CMD=iron.exe share
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "base" --package-description "Eiffel Base: Kernel library classes, data structure, I/O" --package-archive-source "%TMP_SRC_LIBRARY%\base"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "api_wrapper" --package-description "API wrapper: Make it easy to call C routines from dynamically loaded shared libraries" --package-archive-source "%TMP_SRC_LIBRARY%\api_wrapper"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "old_argument_parser" --package-description "Argument parser (Obsolete, no unicode support)" --package-archive-source "%TMP_SRC_LIBRARY%\argument_parser"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "base_extension" --package-description "Eiffel Base extension" --package-archive-source "%TMP_SRC_LIBRARY%\base_extension"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "com" --package-description "Eiffel COM: COM technology (Windows only)" --package-archive-source "%TMP_SRC_LIBRARY%\com"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "curl" --package-description "Eiffel cURL wrapper" --package-archive-source "%TMP_SRC_LIBRARY%\cURL"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "diff" --package-description "Diff and patch facilities" --package-archive-source "%TMP_SRC_LIBRARY%\diff"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "docking" --package-description "Facility to have a customizable UI" --package-archive-source "%TMP_SRC_LIBRARY%\docking"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "editor" --package-description "Eiffel Vision2 Editor component" --package-archive-source "%TMP_SRC_LIBRARY%\editor"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "eiffel2java" --package-description "Eiffel2Java: Calling Java from Eiffel" --package-archive-source "%TMP_SRC_LIBRARY%\Eiffel2Java"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "encoding" --package-description "Transforming text in one encoding to another encoding" --package-archive-source "%TMP_SRC_LIBRARY%\encoding"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "event" --package-description " Low level mechanism to receive a UI event when a file/pipe has something new." --package-archive-source "%TMP_SRC_LIBRARY%\event"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "graph" --package-description "Representation of graph in UI (See diagram tool in EiffelStudio)" --package-archive-source "%TMP_SRC_LIBRARY%\graph"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "i18n" --package-description "Internationalization library" --package-archive-source "%TMP_SRC_LIBRARY%\i18n"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "lex" --package-description "Eiffel LEX" --package-archive-source "%TMP_SRC_LIBRARY%\lex"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "memory_analyzer" --package-description "Memory analysis" --package-archive-source "%TMP_SRC_LIBRARY%\memory_analyzer"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "net" --package-description "Eiffel NET: networking library" --package-archive-source "%TMP_SRC_LIBRARY%\net"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "parse" --package-description "Eiffel PARSE" --package-archive-source "%TMP_SRC_LIBRARY%\parse"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "preferences" --package-description "Facility to store user preferences" --package-archive-source "%TMP_SRC_LIBRARY%\preferences"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "process" --package-description "Eiffel Process:  Facility to start and follow processes" --package-archive-source "%TMP_SRC_LIBRARY%\process"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "ribbon" --package-description "Eiffel Ribbon (Windows only)" --package-archive-source "%TMP_SRC_LIBRARY%\ribbon"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "store" --package-description "Eiffel Store: Relational database access" --package-archive-source "%TMP_SRC_LIBRARY%\store"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "arg_parser" --package-description "Parsing the command line arguments of a program (unicode support)" --package-archive-source "%TMP_SRC_LIBRARY%\runtime\process\arg_parser"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "testing" --package-description "Testing facility (autotest library)" --package-archive-source "%TMP_SRC_LIBRARY%\testing"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "uri" --package-description "URI lib" --package-archive-source "%TMP_SRC_LIBRARY%\text\uri"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "xml" --package-description "XML librarїes" --package-archive-source "%TMP_SRC_LIBRARY%\text\parser\xml"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "kmp_matcher" --package-description "KMP Matcher" --package-archive-source "%TMP_SRC_LIBRARY%\text\regexp\kmp_matcher"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "thread" --package-description "Eiffel Thread: Threading in Eiffel" --package-archive-source "%TMP_SRC_LIBRARY%\thread"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "time" --package-description "Eiffel Time (and date)" --package-archive-source "%TMP_SRC_LIBRARY%\time"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "uuid" --package-description "UUID generation facility" --package-archive-source "%TMP_SRC_LIBRARY%\uuid"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "vision2" --package-description "Eiffel Vision2: Platform independent UI toolkit" --package-archive-source "%TMP_SRC_LIBRARY%\vision2"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "vision2_extension" --package-description "Extension to Eiffel Vision2" --package-archive-source "%TMP_SRC_LIBRARY%\vision2_extension"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "web" --package-description "Eiffel Web: basic CGI facility for Eiffel" --package-archive-source "%TMP_SRC_LIBRARY%\web"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "web_browser" --package-description "WebBrowser component" --package-archive-source "%TMP_SRC_LIBRARY%\web_browser"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "wel" --package-description "Eiffel WEL: UI toolkit for Windows" --package-archive-source "%TMP_SRC_LIBRARY%\wel"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "gobo-ise" --package-description "Gobo" --package-archive-source "%TMP_SRC_LIBRARY%\gobo"
%IRON_CMD% %IRON_CREATE_OPTS% --package-name "gobo_extension" --package-description "Gobo Extension" --package-archive-source "%TMP_SRC_LIBRARY%\gobo_extension"

rem current layout
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "base" --index "/%TMP_IRON_ISE_DOMAIN%/library/base" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "api_wrapper" --index "/%TMP_IRON_ISE_DOMAIN%/library/api_wrapper"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "old_argument_parser" --index "/%TMP_IRON_ISE_DOMAIN%/library/argument_parser"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "base_extension" --index "/%TMP_IRON_ISE_DOMAIN%/library/base_extension" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "com" --index "/%TMP_IRON_ISE_DOMAIN%/library/com"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "curl"  --index "/%TMP_IRON_ISE_DOMAIN%/library/curl"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "diff"  --index "/%TMP_IRON_ISE_DOMAIN%/library/diff"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "docking"  --index "/%TMP_IRON_ISE_DOMAIN%/library/docking"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "editor" --index "/%TMP_IRON_ISE_DOMAIN%/library/editor"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "eiffel2java" --index "/%TMP_IRON_ISE_DOMAIN%/library/eiffel2java"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "encoding"  --index "/%TMP_IRON_ISE_DOMAIN%/library/encoding"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "event" --index "/%TMP_IRON_ISE_DOMAIN%/library/event"  
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "graph"  --index "/%TMP_IRON_ISE_DOMAIN%/library/graph" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "i18n"  --index "/%TMP_IRON_ISE_DOMAIN%/library/i18n"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "lex"  --index "/%TMP_IRON_ISE_DOMAIN%/library/lex"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "memory_analyzer"  --index "/%TMP_IRON_ISE_DOMAIN%/library/memory_analyzer" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "net" --index "/%TMP_IRON_ISE_DOMAIN%/library/net" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "parse" --index "/%TMP_IRON_ISE_DOMAIN%/library/parse"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "preferences"  --index "/%TMP_IRON_ISE_DOMAIN%/library/preferences" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "process" --index "/%TMP_IRON_ISE_DOMAIN%/library/process"  
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "ribbon" --index "/%TMP_IRON_ISE_DOMAIN%/library/ribbon"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "store"  --index "/%TMP_IRON_ISE_DOMAIN%/library/store" 

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "arg_parser" --index "/%TMP_IRON_ISE_DOMAIN%/library/argument_parser" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "logging" --index "/%TMP_IRON_ISE_DOMAIN%/library/runtime/logging"  

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "testing" --index "/%TMP_IRON_ISE_DOMAIN%/library/testing"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "uri"  --index "/%TMP_IRON_ISE_DOMAIN%/library/uri"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "xml" --index "/%TMP_IRON_ISE_DOMAIN%/library/xml" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "kmp_matcher"  --index "/%TMP_IRON_ISE_DOMAIN%/library/text/regexp/kmp_matcher"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "thread" --index "/%TMP_IRON_ISE_DOMAIN%/library/thread" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "time" --index "/%TMP_IRON_ISE_DOMAIN%/library/time"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "uuid" --index "/%TMP_IRON_ISE_DOMAIN%/library/uuid"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "vision2"  --index "/%TMP_IRON_ISE_DOMAIN%/library/vision2" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "vision2_extension" 
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "web" --index "/%TMP_IRON_ISE_DOMAIN%/library/web"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "web_browser" --index "/%TMP_IRON_ISE_DOMAIN%/library/web_browser"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "wel"  --index "/%TMP_IRON_ISE_DOMAIN%/library/wel" 

rem new library categorization
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "base" --index "/%TMP_IRON_ISE_DOMAIN%/library/data_structure/adt/base"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "base_extension" --index "/%TMP_IRON_ISE_DOMAIN%/library/data_structure/adt/base_extension"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "event" --index "/%TMP_IRON_ISE_DOMAIN%/library/data_structure/adt/event"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "graph"  --index "/%TMP_IRON_ISE_DOMAIN%/library/graphic/drawing/graph"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "editor" --index "/%TMP_IRON_ISE_DOMAIN%/library/graphic/drawing/editor"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "ribbon" --index "/%TMP_IRON_ISE_DOMAIN%/library/graphic/drawing/ribbon"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "web_browser" --index "/%TMP_IRON_ISE_DOMAIN%/library/graphic/drawing/web_browser"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "docking"  --index "/%TMP_IRON_ISE_DOMAIN%/library/graphic/framework/docking"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "preferences" --index "/%TMP_IRON_ISE_DOMAIN%/library/graphic/framework/preferences"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "vision2"  --index "/%TMP_IRON_ISE_DOMAIN%/library/graphic/toolkit/vision2"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "vision2_extension" --index "/%TMP_IRON_ISE_DOMAIN%/library/graphic/toolkit/vision2_extension"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "wel"  --index "/%TMP_IRON_ISE_DOMAIN%/library/graphic/toolkit/wel"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "api_wrapper" --index "/%TMP_IRON_ISE_DOMAIN%/library/language_interface/C/api_wrapper"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "com" --index "/%TMP_IRON_ISE_DOMAIN%/library/language_interface/COM/com"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "eiffel2java" --index "/%TMP_IRON_ISE_DOMAIN%/library/language_interface/Java/eiffel2java"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "curl" --index "/%TMP_IRON_ISE_DOMAIN%/library/network/curl"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "net"  --index "/%TMP_IRON_ISE_DOMAIN%/library/network/socket/net"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "store"  --index "/%TMP_IRON_ISE_DOMAIN%/library/persistency/database/store"


%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "memory_analyzer"  --index "/%TMP_IRON_ISE_DOMAIN%/library/runtime/memory/memory_analyzer"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "arg_parser" --index "/%TMP_IRON_ISE_DOMAIN%/library/runtime/process/argument_parser"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "process" --index "/%TMP_IRON_ISE_DOMAIN%/library/runtime/process/process"
rem %IRON_CMD% %IRON_UPDATE_OPTS% --package-name "logging" --index "/%TMP_IRON_ISE_DOMAIN%/library/runtime/logging"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "thread" --index "/%TMP_IRON_ISE_DOMAIN%/library/runtime/concurrency/thread"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "testing" --index "/%TMP_IRON_ISE_DOMAIN%/library/tests/framework/testing"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "encoding"  --index "/%TMP_IRON_ISE_DOMAIN%/library/text/encoding/encoding"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "i18n"  --index "/%TMP_IRON_ISE_DOMAIN%/library/text/internationalization/i18n"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "lex"  --index "/%TMP_IRON_ISE_DOMAIN%/library/text/lexer/lex"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "parse" --index "/%TMP_IRON_ISE_DOMAIN%/library/parser/parse"
rem %IRON_CMD% %IRON_UPDATE_OPTS% --package-name "xml" --index "/%TMP_IRON_ISE_DOMAIN%/library/text/parser/xml"
rem %IRON_CMD% %IRON_UPDATE_OPTS% --package-name "kmp_matcher"  --index "/%TMP_IRON_ISE_DOMAIN%/library/text/regexp/kmp_matcher"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "diff"  --index "/%TMP_IRON_ISE_DOMAIN%/library/text/utility/diff"
rem %IRON_CMD% %IRON_UPDATE_OPTS% --package-name "uri"  --index "/%TMP_IRON_ISE_DOMAIN%/library/text/uri"

%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "uuid" --index "/%TMP_IRON_ISE_DOMAIN%/library/utility/general/uuid"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "time" --index "/%TMP_IRON_ISE_DOMAIN%/library/utility/time/time"

rem ISE_LIBRARY/contrib/library
rem

set TMP_SRC_CONTRIB=%~dp0%\_contribs
if exist %TMP_SRC_CONTRIB% svn update _contribs
if not exist %TMP_SRC_CONTRIB% svn checkout https://svn.eiffel.com/eiffelstudio/branches/Eiffel_73/Src/contrib/library _contribs

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "gobo" --package-description "Gobosoft.org" --package-archive-source "%TMP_SRC_CONTRIB%\gobo"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "gobo" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/gobo"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "wex" --package-description "Eiffel WEL eXtension" --package-archive-source "%TMP_SRC_CONTRIB%\graphic\toolkit\wex"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "wex" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/graphic/toolkit/wex"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "decimal" --package-description "Math/Decimal lib" --package-archive-source "%TMP_SRC_CONTRIB%\math\decimal"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "decimal" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/math/decimal"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "eapml" --package-description "Eiffel Arbitrary Precision Mathematics Library" --package-archive-source "%TMP_SRC_CONTRIB%\math\eapml"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "eapml" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/math/eapml"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "http_authorization" --package-description "EWF: HTTP_AUTHORIZATION component" --package-archive-source "%TMP_SRC_CONTRIB%\network\authentication\http_authorization"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "http_authorization" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/network/authentication/http_authorization"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "http_client" --package-description "EWF: Simple http client (based on libcurl)" --package-archive-source "%TMP_SRC_CONTRIB%\network\http_client"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "http_client" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/network/http_client"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "http" --package-description "EWF: HTTP protocol classes" --package-archive-source "%TMP_SRC_CONTRIB%\network\protocol\http"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "http" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/network/protocol/http"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "nino" --package-description "EWF:Nino , a standalone Eiffel Web Server (httpd)" --package-archive-source "%TMP_SRC_CONTRIB%\network\server\nino"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "nino" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/network/server/nino"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "ael_printf" --package-description "the Amalasoft Eiffel Printf Cluster is a collection of classes that implements a printf facility for the Eiffel language." --package-archive-source "%TMP_SRC_CONTRIB%\print\ael_printf"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "ael_printf" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/print/ael_printf"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "eclop" --package-description "ECLOP stands for Eiffel Command Line Parser and is a small library for parsing command line options" --package-archive-source "%TMP_SRC_CONTRIB%\runtime\process\eclop"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "eclop" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/runtime/process/eclop"


%IRON_CMD% %IRON_CREATE_OPTS% --package-name "openid_consumer" --package-description "OPENID consumer component" --package-archive-source "%TMP_SRC_CONTRIB%\security\openid\consumer"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "openid_consumer" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/security/openid/consumer"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "svn" --package-description "Subversion wrapper" --package-archive-source "%TMP_SRC_CONTRIB%\svn"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "svn" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/svn"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "espec" --package-description "This library is a simplified version of ESpec without the GUI facilities" --package-archive-source "%TMP_SRC_CONTRIB%\testing\framework\espec"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "espec" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/testing/framework/espec"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "eel" --package-description "An Encryption library in Eiffel" --package-archive-source "%TMP_SRC_CONTRIB%\text\encryption\eel"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "eel" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/text/encryption/eel"


%IRON_CMD% %IRON_CREATE_OPTS% --package-name "json" --package-description "eJSON stands for Eiffel JSON library and is a small Eiffel library for dealing with the JSON format" --package-archive-source "%TMP_SRC_CONTRIB%\text\parser\json"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "json" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/text/parser/json"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "uri_template" --package-description "URI template library (string expander and matcher)" --package-archive-source "%TMP_SRC_CONTRIB%\text\parser\uri_template"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "uri_template" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/text/parser/uri_template"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "error" --package-description "an ERROR library (to manage and propagate errors)" --package-archive-source "%TMP_SRC_CONTRIB%\utility\general\error"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "error" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/utility/general/error"

%IRON_CMD% %IRON_CREATE_OPTS% --package-name "ewf" --package-description "part of the Eiffel Web Framework (the other EWF libraries are available in various 'contrib/library' location)" --package-archive-source "%TMP_SRC_CONTRIB%\web\framework\ewf"
%IRON_CMD% %IRON_UPDATE_OPTS% --package-name "ewf" --index "/%TMP_IRON_ISE_DOMAIN%/contrib/library/web/framework/ewf"

goto end

:create_set_credential_script
echo tooo
echo set IRON_USERNAME=put-your-username > %~dp0set_credential.bat
echo set IRON_PASSWORD=put-your-password >> %~dp0set_credential.bat
echo edit the file "%~dp0set_credential.bat" to set your username and password
goto end

:failure
echo failed!
endlocal
exit /B 0

:end
endlocal
exit /B 0


