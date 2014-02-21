/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#include "ecom_grt_globals_string_manipulator_idl_c.h"
#include "ecom_gce_string_manipulator_idl_c.h"
ecom_gce_string_manipulator_idl_c grt_ce_string_manipulator_idl_c;

ecom_gce_string_manipulator_idl_c::ecom_gce_string_manipulator_idl_c(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_string_manipulator_idl_c::ccom_ce_pointed_cell_1( LPSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpstr (*(LPSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_string_manipulator_idl_c::ccom_free_memory_pointed_1( LPSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/


