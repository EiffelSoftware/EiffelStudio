/*-----------------------------------------------------------
Implemented `IPropertyPageSite' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYPAGESITE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYPAGESITE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPropertyPageSite_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPropertyPageSite_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPropertyPageSite_impl_proxy
{
public:
	IPropertyPageSite_impl_proxy (IUnknown * a_pointer);
	virtual ~IPropertyPageSite_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_status_change(  /* [in] */ EIF_INTEGER dw_flags );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_locale_id(  /* [out] */ EIF_OBJECT p_locale_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_page_container(  /* [out] */ EIF_OBJECT ppunk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_translate_accelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IPropertyPageSite * p_IPropertyPageSite;


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
#include "ecom_grt_globals_control_interfaces2.h"


#endif