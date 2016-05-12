@echo off
setlocal EnableDelayedExpansion
if not defined JING (
	if not defined JAVA (
		set JAVA=java
	)
	if not defined JING_JAR (
		set "JING_JAR=jing-20091111\bin\jing.jar"
	)
	set JING="!JAVA!" -jar "!JING_JAR!"
)
!JING! -c template-1.0.rnc *.code
endlocal