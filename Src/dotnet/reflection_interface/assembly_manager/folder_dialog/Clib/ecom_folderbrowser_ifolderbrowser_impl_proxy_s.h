/*-----------------------------------------------------------
Implemented `IFolderBrowser' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_FOLDERBROWSER_IFOLDERBROWSER_IMPL_PROXY_S_H__
#define __ECOM_FOLDERBROWSER_IFOLDERBROWSER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_FolderBrowser
{
class IFolderBrowser_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_FolderBrowser_IFolderBrowser_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_FolderBrowser
{
class IFolderBrowser_impl_proxy
{
public:
	IFolderBrowser_impl_proxy (IUnknown * a_pointer);
	virtual ~IFolderBrowser_impl_proxy ();

	/*-----------------------------------------------------------
	Folder chosen by the user.
	-----------------------------------------------------------*/
	void ccom_folder_name(  /* [out] */ EIF_OBJECT result1 );


	/*-----------------------------------------------------------
	Set initial folder name.
	-----------------------------------------------------------*/
	void ccom_set_starting_folder(  /* [in] */ EIF_OBJECT result1 );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_FolderBrowser::IFolderBrowser * p_IFolderBrowser;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_folder_browser.h"


#endif