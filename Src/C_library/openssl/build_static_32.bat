@echo on

rem Get start time:
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
  set /A "start=((((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100)"
)

title Script to compile OpenSSL on Windows 32 bits statically
set current_dir=%~dp0

rem Remove the builds directory if it exists
if exist %current_dir%builds rmdir /s /q %current_dir%builds

rem Create the builds directory
mkdir %current_dir%builds
cd builds
mkdir static_32

cd ..

@echo Building a 32-Bit static library (/MT) using the option `no-shared` with VC-WIN32
@echo Compiling OpenSSL 32bits statically

perl Configure no-apps no-docs no-asm no-ssl3 no-zlib no-comp no-autoload-config no-engine no-quic VC-WIN32 no-shared --prefix=%current_dir%builds\static_32 --openssldir=%current_dir%builds\static_32
nmake 
nmake install_sw

rem Get elapsed time:
set /A elapsed=end-start
rem Show elapsed time:
set /A hh=elapsed/(60*60*100), rest=elapsed%%(60*60*100), mm=rest/(60*100), rest%%=60*100, ss=rest/100, cc=rest%%100
if %mm% lss 10 set mm=0%mm%
if %ss% lss 10 set ss=0%ss%
if %cc% lss 10 set cc=0%cc%
echo Elapsed Time: %hh%:%mm%:%ss%.%cc%





