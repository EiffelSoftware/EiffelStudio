/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GCE_ASSEMBLYMANAGERINTERFACE_C_H__
#define __ECOM_GCE_ASSEMBLYMANAGERINTERFACE_C_H__
#ifdef __cplusplus
extern "C" {


class ecom_gce_AssemblyManagerInterface_c;

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
class ecom_gce_AssemblyManagerInterface_c
{
public:
	ecom_gce_AssemblyManagerInterface_c ();
	virtual ~ecom_gce_AssemblyManagerInterface_c () {};

	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_2( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_2( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_3( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_4( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_4( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_6( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_6( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_8( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_8( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_9( VARIANT_BOOL * a_pointer );



protected:


private:


};
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_AssemblyManagerInterface_c.h"


#endif