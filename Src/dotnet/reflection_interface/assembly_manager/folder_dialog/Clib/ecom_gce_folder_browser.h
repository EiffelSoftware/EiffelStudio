/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GCE_FOLDER_BROWSER_H__
#define __ECOM_GCE_FOLDER_BROWSER_H__
#ifdef __cplusplus
extern "C" {


class ecom_gce_folder_browser;

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
class ecom_gce_folder_browser
{
public:
	ecom_gce_folder_browser ();
	virtual ~ecom_gce_folder_browser () {};

	/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_1( LPWSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of LPWSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_1( LPWSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert LPWSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_2( LPWSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of LPWSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_2( LPWSTR * a_pointer );



protected:


private:


};
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_folder_browser.h"


#endif