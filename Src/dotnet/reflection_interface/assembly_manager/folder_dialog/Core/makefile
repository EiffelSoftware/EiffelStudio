
SRCLIST = FolderDialog.cs FolderDialogInfo.cs

.SUFFIXES: .dll .cs

.cs.dll:
	csc $*.cs

FolderDialog.dll : $(SRCLIST) makefile FolderDialog.key
	csc /t:library /out:FolderDialog.dll $(SRCLIST) /r:FolderBrowser.dll

FolderDialog.key:
	sn -k FolderDialog.key