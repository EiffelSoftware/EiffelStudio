midl folder_browser.idl
tlbimp folder_browser.tlb
csc /t:library FolderDialog.cs /r:FolderBrowser.dll
