midl folder_browser.idl
tlbimp folder_browser.tlb
csc /t:library /out:ISE.AssemblyManager.FolderDialog.dll FolderDialog.cs /r:FolderBrowser.dll
