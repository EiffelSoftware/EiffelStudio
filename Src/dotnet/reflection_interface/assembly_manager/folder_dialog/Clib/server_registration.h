/*-----------------------------------------------------------
Component registration code
-----------------------------------------------------------*/

#ifndef __SERVER_REGISTRATION_H__
#define __SERVER_REGISTRATION_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_FolderBrowser_FolderBrowser_s.h"

#include "FolderBrowser_factory.h"

#ifdef __cplusplus
extern "C" {
#endif



struct REG_DATA
{
	const TCHAR *pKeyName;
	const TCHAR *pValueName;
	const TCHAR *pValue;
	BOOL pDelOnUnregister;
};

#define ccom_dll_get_class_object(_arg1_, _arg2_, _arg3_) (ccom_dll_get_class_object_function((CLSID*)_arg1_, (IID*)_arg2_, (void **)_arg3_))

#define ccom_dll_register_server (ccom_dll_register_server_function())

#define ccom_dll_unregister_server (ccom_dll_unregister_server_function())

#define ccom_dll_can_unload_now (ccom_dll_can_unload_now_function())

#ifdef __cplusplus
extern "C" {
#endif
RT_LNK HINSTANCE eif_hInstance;
#ifdef __cplusplus
}
#endif

	/*-----------------------------------------------------------
	Unregister Server/Component
	-----------------------------------------------------------*/
	EIF_INTEGER Unregister( const REG_DATA *rgEntries, int cEntries );


	/*-----------------------------------------------------------
	Register Server
	-----------------------------------------------------------*/
	EIF_INTEGER Register( const REG_DATA *rgEntries, int cEntries );


	/*-----------------------------------------------------------
	DLL get class object funcion
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_dll_get_class_object_function( CLSID * rclsid, IID * riid, void **ppv );


	/*-----------------------------------------------------------
	Register DLL server.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_dll_register_server_function( void );


	/*-----------------------------------------------------------
	Unregister Server.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_dll_unregister_server_function( void );


	/*-----------------------------------------------------------
	Whether component can be unloaded?
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_dll_can_unload_now_function( void );


	/*-----------------------------------------------------------
	Unlock module.
	-----------------------------------------------------------*/
	void UnlockModule( void );


	/*-----------------------------------------------------------
	Lock module.
	-----------------------------------------------------------*/
	void LockModule( void );

#ifdef __cplusplus
}
#endif

#endif