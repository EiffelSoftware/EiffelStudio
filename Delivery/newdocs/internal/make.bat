rd /q /s newdocs
cvs export -r HEAD -d newdocs Delivery/newdocs
cd newdocs
copy ..\document\eifgen\f_code\document.exe .
document /g
REM Remove goto.html
REM Add one-minute summary
call vi eiffel.hhc
copy d:\delivery\newdocs\default.css .
set PATH=%PATH%;c:\dev\htmlhelp
hhc eiffel.hhp
