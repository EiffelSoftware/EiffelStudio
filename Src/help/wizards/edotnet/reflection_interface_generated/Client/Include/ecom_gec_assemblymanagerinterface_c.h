/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GEC_ASSEMBLYMANAGERINTERFACE_C_H__
#define __ECOM_GEC_ASSEMBLYMANAGERINTERFACE_C_H__
#ifdef __cplusplus
extern "C" {


class ecom_gec_AssemblyManagerInterface_c;

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
class ecom_gec_AssemblyManagerInterface_c
{
public:
	ecom_gec_AssemblyManagerInterface_c ();
	virtual ~ecom_gec_AssemblyManagerInterface_c () {};

	/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [STRING]] to SAFEARRAY *  *.
	-----------------------------------------------------------*/
	SAFEARRAY *  * ccom_ec_pointed_cell_2( EIF_REFERENCE eif_ref, SAFEARRAY *  * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_4( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [STRING]] to SAFEARRAY *  *.
	-----------------------------------------------------------*/
	SAFEARRAY *  * ccom_ec_pointed_cell_6( EIF_REFERENCE eif_ref, SAFEARRAY *  * old );


	/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [STRING]] to SAFEARRAY *  *.
	-----------------------------------------------------------*/
	SAFEARRAY *  * ccom_ec_pointed_cell_8( EIF_REFERENCE eif_ref, SAFEARRAY *  * old );



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