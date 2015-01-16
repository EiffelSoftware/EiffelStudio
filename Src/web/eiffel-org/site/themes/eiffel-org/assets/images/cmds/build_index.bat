@echo off
setlocal

cd %1
set TMP_HTML=index.html

echo ^<html^>^<head^>^</head^>^<body^> > %TMP_HTML%
echo ^<html^>^<head^> >> %TMP_HTML%
echo ^<link rel="stylesheet" type="text/css" href="style.css"/^> >> %TMP_HTML%
echo ^</head^>^<body^> >> %TMP_HTML%
echo ^<h1^>Icons^</h1^> >> %TMP_HTML%
for %%f in (*.svg) do echo ^<p^>%%~nf^<br/^>^<img src="%%f" width="52" height="52"/^>^</p^> >> %TMP_HTML%

echo ^</body^>^</html^> >> %TMP_HTML%

cd %~dp0

endlocal
