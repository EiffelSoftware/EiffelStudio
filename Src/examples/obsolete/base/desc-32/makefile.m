CPP_PROJ=/nologo /MT /W3 /GX /YX /Zi /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /c 

LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib /NOLOGO\
 /SUBSYSTEM:windows /DLL /INCREMENTAL:no /PDB:"testdesc.pdb"\
 /MACHINE:I386 /OUT:"testdesc.dll" /IMPLIB:"testdesc.lib" /DEBUG

LINK32_OBJS= testdesc.obj

testdesc.dll: $(LINK32_OBJS)
    link $(LINK32_FLAGS) $(LINK32_OBJS)

testdesc.obj : testdesc.c
	cl $(CPP_PROJ) testdesc.c

