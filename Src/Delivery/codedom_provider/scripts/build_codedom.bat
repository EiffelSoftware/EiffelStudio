@ECHO OFF
REM *********************************************
REM Eiffel Codedom Provider delivery build script
REM *********************************************

ECHO Building Codedom files
TITLE Building Codedom files

SET EIFFEL_SRC=%CD%\checkout
SET ISE_EIFFEL=%1
SET PATH=%INIT_PATH%;C:\ecdpc

CD checkout\dotnet\codedom_provider_2.0
REM in checkout\dotnet\codedom_provider_2.0
sed -e "s/ec /ecdpc /" build.bat > new_build.bat
IF EXIST old_build.bat DEL old_build.bat
REN build.bat old_build.bat
REN new_build.bat build.bat
CALL build.bat release
IF NOT EXIST configuration\EIFGENS\base\F_code\EiffelSoftware.CodeDom.Base2_0.dll GOTO END
IF NOT EXIST configuration\EIFGENS\cache_browser\F_code\EiffelSoftware.CodeDom.CacheBrowser2_0.dll GOTO END
IF NOT EXIST configuration\EIFGENs\codedom_provider_release\F_code\EiffelSoftware.CodeDom2_0.dll GOTO END
IF NOT EXIST configuration\EIFGENS\vision2\F_code\EiffelSoftware.CodeDom.Vision2_0.dll GOTO END
IF NOT EXIST configuration\EIFGENs\manager_release\F_code\ecdpman2_0.exe GOTO END
IF NOT EXIST configuration\EIFGENs\esplit_graphical_release\F_code\esplitter2_0.exe GOTO END
IF NOT EXIST configuration\EIFGENs\esplit_console_release\F_code\esplit2_0.exe GOTO END
IF NOT EXIST configuration\EIFGENs\nmap_release\F_code\nmap2_0.exe GOTO END

ECHO Copying files
TITLE Copying files
CD ..\..\..\delivery
REM in delivery
MKDIR codedom
CD codedom
REM in delivery\codedom

MKDIR configs
COPY ..\..\files\default.ecd configs\

MKDIR bin
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\cache_browser\F_code\EiffelSoftware.CodeDom.CacheBrowser2_0.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\codedom_provider_release\F_code\EiffelSoftware.Codedom2_0.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\base\F_code\EiffelSoftware.CodeDom.Base2_0.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\base\F_code\libEiffelSoftware.CodeDom.Base2_0.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\vision2\F_code\EiffelSoftware.CodeDom.Vision2_0.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\vision2\F_code\libEiffelSoftware.CodeDom.Vision2_0.dll bin\
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\manager_release\F_code\ecdpman2_0.exe bin\
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\esplit_graphical_release\F_code\esplitter2_0.exe bin\
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\esplit_console_release\F_code\esplit2_0.exe bin\
COPY ..\..\checkout\dotnet\codedom_provider_2.0\configuration\EIFGENs\nmap_release\F_code\nmap2_0.exe bin\
COPY ..\..\checkout\Eiffel\eiffel\com_il_generation\Core\run-time\EiffelSoftware.Runtime.dll bin\

CD bin
REM in delivery\codedom\bin
MKDIR icons
CD icons
REM in delivery\codedom\bin\icons
XCOPY ..\..\..\..\checkout\dotnet\codedom_provider_2.0\tools\manager\icons /E
SET CODEDOM_BUILT=1

CD ..\..\..\..
SET PATH=%INIT_PATH%;

:END
IF "%CODEDOM_BUILT%"=="" ECHO COULD NOT BUILD CODEDOM FILES!!
ECHO Done.
TITLE Done.