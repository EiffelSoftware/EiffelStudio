midl folder_browser.idl
sn -k Key1
tlbimp /keyfile:Key1 folder_browser.tlb

csc /t:module FolderDialog.cs /r:FolderBrowser.dll
sn -k Key2
al folderdialog.netmodule /keyfile:Key2 /out:FolderDialog.dll
