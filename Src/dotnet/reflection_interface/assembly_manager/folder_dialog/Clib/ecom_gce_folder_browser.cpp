/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#include "ecom_gce_folder_browser.h"
ecom_gce_folder_browser grt_ce_folder_browser;

#ifdef __cplusplus
extern "C" {
#endif

ecom_gce_folder_browser::ecom_gce_folder_browser(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_folder_browser::ccom_ce_pointed_cell_1( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_folder_browser::ccom_free_memory_pointed_1( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif