rd /q /s newdocs
call cvs export -r HEAD -d newdocs Delivery/newdocs
cd newdocs
copy internal\eiffel.hhc .
copy internal\eiffel.hhp .
copy internal\stop_words.stp .
copy ..\document.exe .
call document /g
REM Remove goto.html
call vi eiffel.hhc
copy ..\docs\default.css .
set PATH=%PATH%;d:\apps\html_help
call hhc eiffel.hhp
cd ..
