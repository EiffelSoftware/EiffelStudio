# ecom_client.lib and ecom_server.lib - Makefile for Microsoft C

CC = cl
CFLAGS = /W0 /Ox /DWORKBENCH /D "_WIN32_DCOM" /c /Ic:\eiffel50\bench\spec\windows\include /Ic:\50dev\library\com\spec\windows\include 

OBJ_CLIENT = ecom_folderbrowser_ifolderbrowser_impl_proxy_s.obj 

OBJ_SERVER = ecom_folderbrowser_folderbrowser_s.obj ecom_folderbrowser_ifolderbrowser_impl_stub_s.obj ecom_gce_folder_browser.obj ecom_gec_folder_browser.obj folderbrowser_factory.obj server_registration.obj 

all: ecom_client.lib ecom_server.lib

ecom_server.lib: $(OBJ_SERVER)
	if exist $@ del $@
	lib /OUT:$@ $(OBJ_SERVER)
	del *.obj

ecom_client.lib: $(OBJ_CLIENT)
	if exist $@ del $@
	lib /OUT:$@ $(OBJ_CLIENT)
	del *.obj

.cpp.obj:
	$(CC) $(CFLAGS) $<
