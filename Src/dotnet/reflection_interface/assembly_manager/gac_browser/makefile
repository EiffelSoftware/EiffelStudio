
SRCLIST = WindowsDirectoryExtractor.cs WindowsDirectoryExtractorInfo.cs

.SUFFIXES: .dll .cs

.cs.dll:
	csc $*.cs

ISE.AssemblyManager.WindowsDirectoryExtractor.dll : $(SRCLIST) makefile WindowsDirectoryExtractor.key
	csc /t:library /out:ISE.AssemblyManager.WindowsDirectoryExtractor.dll $(SRCLIST) 

WindowsDirectoryExtractor.key:
	sn -k WindowsDirectoryExtractor.key