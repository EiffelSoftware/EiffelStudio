@ECHO OFF
REM Compile Eiffel for ASP.NET Wix project and produce msi
SET ECPOriginalPath2=%CD%
CD ..\install
REM in Delivery/codedom_provider/install

IF EXIST Modules RD /Q /S Modules
IF EXIST Modules ECHO Could not delete 'Modules' folder, exiting.
IF EXIST Modules GOTO END
MKDIR Modules

REM Copy images and other resources from studio's install
IF EXIST Binary RD /Q /S Binary
IF EXIST Binary ECHO Could not delete 'Binary' folder, exiting.
IF EXIST Binary GOTO END
MKDIR Binary
XCOPY /Q /S ..\..\scripts\windows\install\Binary\* Binary\
COPY /Y ..\files\eiffel_for_asp_net_left.bmp Binary\
COPY /Y ..\files\eiffel_for_asp_net_top.bmp Binary\
COPY ..\files\efa_license.rtf Binary\

REM DO THIS IF CLSID OF METADATA CONSUMER CHANGED!!! MERGE REGISTRY ENTRIES IN CompilerModule.wxs
REM tallow  -nologo -c ..\delivery\Compiler\studio\spec\windows\bin\EiffelSoftware.MetadataConsumer.dll > Consumer.wxs
CALL %ECPOriginalPath2%\make_module.bat CompilerModule ..\delivery\compiler\
IF "%MMSUCCESS%"=="" GOTO END

CALL %ECPOriginalPath2%\make_module.bat LibrariesModule ..\delivery\compiler\
IF "%MMSUCCESS%"=="" GOTO END

CALL %ECPOriginalPath2%\make_module.bat CodedomModule ..\delivery\codedom\
IF "%MMSUCCESS%"=="" GOTO END

CALL %ECPOriginalPath2%\make_module.bat DocumentationModule ..\delivery\documentation\
IF "%MMSUCCESS%"=="" GOTO END

CALL %ECPOriginalPath2%\make_module.bat SamplesModule ..\samples\
IF "%MMSUCCESS%"=="" GOTO END

candle -nologo Product.wxs
IF NOT EXIST Product.wixobj ECHO Could not compile Product.wxs, exiting.
IF NOT EXIST Product.wixobj GOTO END

light -nologo Product.wixobj -out "Eiffel for ASP.NET 5.6.msi"
IF NOT EXIST "Eiffel for ASP.NET 5.6.msi" ECHO Could not compile Product.wixobj, exiting.
IF NOT EXIST "Eiffel for ASP.NET 5.6.msi" GOTO END
DEL Product.wixobj
COPY "Eiffel for ASP.NET 5.6.msi" ..\

:END
CD %ECPOriginalPath2%
ECHO Done.