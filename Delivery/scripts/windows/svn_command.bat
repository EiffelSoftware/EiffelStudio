@echo off
rem This is required to perform svn commands because they often fails, so we repeat them
rem until they succeed.

set i=0
do while "%i" == "0"
	svn %1 %2 %3 %4 %5 %6 %7
	iff "%?" == "0" then
		set i=1
	endiff
enddo
