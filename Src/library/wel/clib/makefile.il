# ilwel.lib - Makefile for Microsoft C

CC = cl

# Finalized Version
CFLAGS = -nologo -c -Zi -DEIF_IL_DLL -W1 -I..\spec\windows\include -I$(ISE_EIFFEL)\studio\spec\windows\include -DNONAMELESSUNION

# Debug Version
#CFLAGS = -c -Zi -nologo -Od -W4 -I..\spec\windows\include -I$(ISE_EIFFEL)\studio\spec\windows\include -DNONAMELESSUNION

all:: ilwel.lib
	del $@
	del *.obj

.c.obj:
	$(CC) $(CFLAGS) $<

OBJ = 	disptchr.obj \
		enumfont.obj \
		estream.obj \
		msgboxpa.obj \
		diskspace.obj \
		drawstate.obj \
		dynload.obj \
		choose_folder.obj \
		mousehook.obj \
		enum_child_windows.obj

IL_OBJ = $(OBJ)

ilwel.lib: $(IL_OBJ)
	if exist $@ del $@
	lib /NOLOGO /OUT:$@ $(IL_OBJ)
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	copy $@ ..\spec\msc\lib
