/*-----------------------------------------------------------
Implemented `IPropertyBag2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYBAG2_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYBAG2_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPropertyBag2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPropertyBag2_s.h"

#include "ecom_control_library_tagPROPBAG2_s.h"

#include "ecom_control_library_IErrorLog_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPropertyBag2_impl_proxy
{
public:
	IPropertyBag2_impl_proxy (IUnknown * a_pointer);
	virtual ~IPropertyBag2_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_read(  /* [in] */ EIF_INTEGER c_properties,  /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag,  /* [in] */ ecom_control_library::IErrorLog * p_err_log,  /* [out] */ VARIANT * pvar_value,  /* [out] */ EIF_OBJECT phr_error );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_write(  /* [in] */ EIF_INTEGER c_properties,  /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag,  /* [in] */ VARIANT * pvar_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_count_properties(  /* [out] */ EIF_OBJECT pc_properties );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_property_info(  /* [in] */ EIF_INTEGER i_property,  /* [in] */ EIF_INTEGER c_properties,  /* [out] */ ecom_control_library::tagPROPBAG2 * p_prop_bag,  /* [out] */ EIF_OBJECT pc_properties );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_load_object(  /* [in] */ EIF_OBJECT pstr_name,  /* [in] */ EIF_INTEGER dw_hint,  /* [in] */ IUnknown * punk_object,  /* [in] */ ecom_control_library::IErrorLog * p_err_log );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IPropertyBag2 * p_IPropertyBag2;


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