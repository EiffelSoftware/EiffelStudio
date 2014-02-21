/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#include "ecom_grt_globals_string_manipulator_idl_c.h"
#include "ecom_gec_string_manipulator_idl_c.h"
ecom_gec_string_manipulator_idl_c grt_ec_string_manipulator_idl_c;

ecom_gec_string_manipulator_idl_c::ecom_gec_string_manipulator_idl_c(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

LPSTR * ecom_gec_string_manipulator_idl_c::ccom_ec_pointed_cell_1( EIF_REFERENCE eif_ref, LPSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPSTR *) CoTaskMemAlloc (sizeof (LPSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/


