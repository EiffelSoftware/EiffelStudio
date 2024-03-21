@echo on

rem Get start time:
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
  set /A "start=((((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100)"
)

title Script to compile OpenSSL on Windows 32 bits dynamically
set current_dir=%~dp0

rem Remove the builds directory if it exists
if exist %current_dir%builds rmdir /s /q %current_dir%builds

rem Create the builds directory
mkdir %current_dir%builds
cd builds
mkdir dynamic_32

cd ..

@echo Building a 32-Bit dynamic library (/MD) using the option `shared` with VC-WIN32
@echo Compiling OpenSSL 32bits dynamic

perl Configure no-apps no-docs no-asm no-ssl3 no-zlib no-comp no-autoload-config no-engine VC-WIN32 shared --prefix=%current_dir%builds\dynamic_32 --openssldir=%current_dir%builds\dynamic_32
nmake 
nmake install_sw




rem Create the builds directory
mkdir %current_dir%spec
cd spec
mkdir win
cd win
mkdir lib
cd lib
mkdir dynamic

cd ..
cd ..
cd ..
cd ..

rem Copy the generated .lib files to the specified directory
xcopy /y /s %current_dir%builds\dynamic_32\lib\*.lib %current_dir%spec\win\lib\dynamic\
rem Copy the generated .lib files to the specified directory
xcopy /y /s %current_dir%builds\dynamic_32\bin\*.dll %current_dir%spec\win\lib\dynamic\




rem Get end time:
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
  set /A "end=((((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100)"
)

rem Get elapsed time:
set /A elapsed=end-start
rem Show elapsed time:
set /A hh=elapsed/(60*60*100), rest=elapsed%%(60*60*100), mm=rest/(60*100), rest%%=60*100, ss=rest/100, cc=rest%%100
if %mm% lss 10 set mm=0%mm%
if %ss% lss 10 set ss=0%ss%
if %cc% lss 10 set cc=0%cc%
echo Elapsed Time: %hh%:%mm%:%ss%.%cc%





