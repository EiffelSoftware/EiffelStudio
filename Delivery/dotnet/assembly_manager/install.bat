echo off

call gacutil -silent -nologo -u ISE.Reflection.EiffelComponents
call gacutil -silent -nologo -u ISE.Reflection.EiffelAssemblyCacheNotifier
call gacutil -silent -nologo -u ISE.Reflection.Support
call gacutil -silent -nologo -u ISE.Reflection.EiffelAssemblyCacheHandler
call gacutil -silent -nologo -u ISE.Reflection.CodeGenerator
call gacutil -silent -nologo -u ISE.Reflection.ReflectionInterface
call gacutil -silent -nologo -u ISE.Reflection.Emitter
call gacutil -silent -nologo -u FolderBrowser
call gacutil -silent -nologo -u FolderDialog
call gacutil -silent -nologo -u ISE.Reflection.Formatter
call gacutil -silent -nologo -u ISE.AssemblyManager.WindowsDirectoryExtractor

call gacutil -silent -nologo -i ISE.Reflection.EiffelComponents.dll
call gacutil -silent -nologo -i ISE.Reflection.EiffelAssemblyCacheNotifier.dll
call gacutil -silent -nologo -i ISE.Reflection.Support.dll
call gacutil -silent -nologo -i ISE.Reflection.EiffelAssemblyCacheHandler.dll
call gacutil -silent -nologo -i ISE.Reflection.CodeGenerator.dll
call gacutil -silent -nologo -i ISE.Reflection.ReflectionInterface.dll
call gacutil -silent -nologo -i ISE.Reflection.Emitter.exe
call gacutil -silent -nologo -i FolderBrowser.dll
call gacutil -silent -nologo -i FolderDialog.dll
call gacutil -silent -nologo -i ISE.Reflection.Formatter.dll
call gacutil -silent -nologo -i ISE.AssemblyManager.WindowsDirectoryExtractor.dll

call regsvr32 /s folder_browser.dll
