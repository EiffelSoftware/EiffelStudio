setlocal

set CWD=%CD%
set T_REVISION=%1

if "%T_REVISION%" EQU "" goto USAGE
goto START

:USAGE
echo Usage: prog revision
goto EOF

:START


set T_S3_ROOT_URL=s3://ise.deliv/nightly/%T_REVISION%
set T_S3_CP=aws s3 cp --acl public-read
cd %CWD%\standard
for %%f in (*.msi) do %T_S3_CP% "%%f" %T_S3_ROOT_URL%/standard/%%f

cd %CWD%\branded
for %%f in (*.msi) do %T_S3_CP% "%%f" %T_S3_ROOT_URL%/branded/%%f

cd %CWD%\enterprise
for %%f in (*.msi) do %T_S3_CP% "%%f" %T_S3_ROOT_URL%/enterprise/%%f

:EOF
cd %CWD%
