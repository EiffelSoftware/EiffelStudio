@echo off

call "%~dp0%\unicode_version.bat"

setlocal enableextensions
	if not exist "ucd\%UNICODE_VERSION%" (
		mkdir "ucd\%UNICODE_VERSION%"
	)
endlocal

if not exist "ucd\%UNICODE_VERSION%\DerivedCoreProperties.txt" (
	bash -c "wget -P 'ucd/%UNICODE_VERSION%' -c 'https://www.unicode.org/Public/%UNICODE_VERSION%/ucd/DerivedCoreProperties.txt'"
)

if not exist "ucd\%UNICODE_VERSION%\UnicodeData.txt" (
	bash -c "wget -P 'ucd/%UNICODE_VERSION%' -c 'https://www.unicode.org/Public/%UNICODE_VERSION%/ucd/UnicodeData.txt'"
)
