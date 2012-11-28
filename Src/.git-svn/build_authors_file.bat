@echo off
setlocal

echo (no author) = unknown ^<svn+unknown@eiffel.com^> 
svn log -q https://svn.eiffel.com/eiffelstudio/trunk | grep -e "^r[0-9]" | sed "s/^r[0-9][0-9]* [^ ] \([^ ]*\) .*$/\1 = \1 <svn+\1@eiffel.com>/g" | sort | uniq

:end
