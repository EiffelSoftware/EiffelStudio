/*-----------------------------------------------------------
Component registration code
-----------------------------------------------------------*/

#ifndef __SERVER_REGISTRATION_H__
#define __SERVER_REGISTRATION_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_CEiffelProject_s.h"

#include "CEiffelProject_factory.h"

#include "ecom_eiffel_compiler_CEiffelCompiler_s.h"

#include "CEiffelCompiler_factory.h"

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

#define ccom_register_server (ccom_register_server_function())

#define ccom_unregister_server (ccom_unregister_server_function())

#define ccom_initialize_com (ccom_initialize_com_function())

#define ccom_cleanup_com (ccom_cleanup_com_function())

	/*-----------------------------------------------------------
	Unregister Server/Component
	-----------------------------------------------------------*/
	EIF_INTEGER Unregister( const REG_DATA *rgEntries, int cEntries );


	/*-----------------------------------------------------------
	Register Server
	-----------------------------------------------------------*/
	EIF_INTEGER Register( const REG_DATA *rgEntries, int cEntries );


	/*-----------------------------------------------------------
	Lock module.
	-----------------------------------------------------------*/
	void LockModule( void );


	/*-----------------------------------------------------------
	Unlock module.
	-----------------------------------------------------------*/
	void UnlockModule( void );


	/*-----------------------------------------------------------
	Register server.
	-----------------------------------------------------------*/
	void ccom_register_server_function();


	/*-----------------------------------------------------------
	Unregister server.
	-----------------------------------------------------------*/
	void ccom_unregister_server_function();


	/*-----------------------------------------------------------
	Initialize server.
	-----------------------------------------------------------*/
	void ccom_initialize_com_function();


	/*-----------------------------------------------------------
	Clean up COM.
	-----------------------------------------------------------*/
	void ccom_cleanup_com_function();

#ifdef __cplusplus
}
#endif

#endif