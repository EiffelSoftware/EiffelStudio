/*-----------------------------------------------------------
Implemented `IPerPropertyBrowsing' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERPROPERTYBROWSING_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERPROPERTYBROWSING_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPerPropertyBrowsing_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPerPropertyBrowsing_s.h"

#include "ecom_control_library_tagCALPOLESTR_s.h"

#include "ecom_control_library_tagCADWORD_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPerPropertyBrowsing_impl_proxy
{
public:
	IPerPropertyBrowsing_impl_proxy (IUnknown * a_pointer);
	virtual ~IPerPropertyBrowsing_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_display_string(  /* [in] */ EIF_INTEGER disp_id,  /* [out] */ EIF_OBJECT p_bstr );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_map_property_to_page(  /* [in] */ EIF_INTEGER disp_id,  /* [out] */ GUID * p_clsid );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_predefined_strings(  /* [in] */ EIF_INTEGER disp_id,  /* [out] */ ecom_control_library::tagCALPOLESTR * p_ca_strings_out,  /* [out] */ ecom_control_library::tagCADWORD * p_ca_cookies_out );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_predefined_value(  /* [in] */ EIF_INTEGER disp_id,  /* [in] */ EIF_INTEGER dw_cookie,  /* [out] */ VARIANT * p_var_out );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IPerPropertyBrowsing * p_IPerPropertyBrowsing;


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