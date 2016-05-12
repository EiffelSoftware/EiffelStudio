@echo off
setlocal EnableDelayedExpansion
if not defined TRANG (
	if not defined JAVA (
		set JAVA=java
	)
	if not defined TRANG_JAR (
		set "TRANG_JAR=trang-20091111\trang.jar"
	)
	set TRANG="!JAVA!" -jar "!TRANG_JAR!"
)
!TRANG! code_template-1.0.rnc code_template-1.0.xsd
endlocal