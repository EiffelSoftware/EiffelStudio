/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GCE_STRING_MANIPULATOR_IDL_C_H__
#define __ECOM_GCE_STRING_MANIPULATOR_IDL_C_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_rt_globals.h"

#include "ecom_aliases.h"

class ecom_gce_string_manipulator_idl_c
{
public:
	ecom_gce_string_manipulator_idl_c ();
	virtual ~ecom_gce_string_manipulator_idl_c () {};

	/*-----------------------------------------------------------
	Convert LPSTR * to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_1( LPSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of LPSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_1( LPSTR * a_pointer );



protected:


private:


};

#endif
