/*-----------------------------------------------------------
Implemented `IFolderBrowser' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_FOLDERBROWSER_IFOLDERBROWSER_IMPL_STUB_S_H__
#define __ECOM_FOLDERBROWSER_IFOLDERBROWSER_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_FolderBrowser
{
class IFolderBrowser_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_FolderBrowser_IFolderBrowser_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_FolderBrowser
{
class IFolderBrowser_impl_stub : public ecom_FolderBrowser::IFolderBrowser
{
public:
	IFolderBrowser_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IFolderBrowser_impl_stub ();

	/*-----------------------------------------------------------
	Folder chosen by the user.
	-----------------------------------------------------------*/
	STDMETHODIMP FolderName(  /* [out] */ LPWSTR * result1 );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
	/*-----------------------------------------------------------
	Reference counter
	-----------------------------------------------------------*/
	LONG ref_count;


	/*-----------------------------------------------------------
	Corresponding Eiffel object
	-----------------------------------------------------------*/
	EIF_OBJECT eiffel_object;


	/*-----------------------------------------------------------
	Eiffel type id
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_folder_browser.h"


#endif