# ecom.lib - Makefile for Microsoft C

CC = cl
CFLAGS = /W0 /Ox /DWORKBENCH /D "_WIN32_DCOM" /c /I..\..\client\include /I..\..\server\include /I..\..\common\include /IF:\Eiffel50\bench\spec\windows\include /IF:\Eiffel50\library\com\spec\windows\include 

OBJ = ecom_assemblymanagerinterface_assemblymanagerinterface.obj ecom_gce_assemblymanagerinterface_c.obj ecom_gec_assemblymanagerinterface_c.obj 

ecom.lib: $(OBJ)
	if exist $@ del $@
	lib /OUT:$@ $(OBJ)
	del *.obj

.cpp.obj:
	$(CC) $(CFLAGS) $<
