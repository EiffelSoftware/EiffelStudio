REM --- Generate WinForms Control for Microsoft Web Browser Active control ---
REM ------------------------------------------------------------------------------
if "%windir%" == "" set windir=c:\windows
aximp "%windir%\system32\shdocvw.dll"
REM tlbimp mshtml.tlb  -- Use for DHTML DOM interfaces
