/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYBAG2_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYBAG2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPropertyBag2_FWD_DEFINED__
#define __ecom_control_library_IPropertyBag2_FWD_DEFINED__
namespace ecom_control_library
{
class IPropertyBag2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagPROPBAG2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IErrorLog_FWD_DEFINED__
#define __ecom_control_library_IErrorLog_FWD_DEFINED__
namespace ecom_control_library
{
class IErrorLog;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPropertyBag2_INTERFACE_DEFINED__
#define __ecom_control_library_IPropertyBag2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPropertyBag2 : public IUnknown
{
public:
	IPropertyBag2 () {};
	~IPropertyBag2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Read(  /* [in] */ ULONG c_properties, /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag, /* [in] */ ecom_control_library::IErrorLog * p_err_log, /* [out] */ VARIANT * pvar_value, /* [out] */ HRESULT * phr_error ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Write(  /* [in] */ ULONG c_properties, /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag, /* [in] */ VARIANT * pvar_value ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CountProperties(  /* [out] */ ULONG * pc_properties ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetPropertyInfo(  /* [in] */ ULONG i_property, /* [in] */ ULONG c_properties, /* [out] */ ecom_control_library::tagPROPBAG2 * p_prop_bag, /* [out] */ ULONG * pc_properties ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LoadObject(  /* [in] */ LPWSTR pstr_name, /* [in] */ ULONG dw_hint, /* [in] */ IUnknown * punk_object, /* [in] */ ecom_control_library::IErrorLog * p_err_log ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif