/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#include "ecom_gec_folder_browser.h"
ecom_gec_folder_browser grt_ec_folder_browser;

#ifdef __cplusplus
extern "C" {
#endif

ecom_gec_folder_browser::ecom_gec_folder_browser(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_folder_browser::ccom_ec_pointed_cell_1( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif