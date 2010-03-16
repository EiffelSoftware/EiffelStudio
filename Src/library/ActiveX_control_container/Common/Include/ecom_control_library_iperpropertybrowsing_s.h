/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERPROPERTYBROWSING_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERPROPERTYBROWSING_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPerPropertyBrowsing_FWD_DEFINED__
#define __ecom_control_library_IPerPropertyBrowsing_FWD_DEFINED__
namespace ecom_control_library
{
class IPerPropertyBrowsing;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagCALPOLESTR_s.h"

#include "ecom_control_library_tagCADWORD_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPerPropertyBrowsing_INTERFACE_DEFINED__
#define __ecom_control_library_IPerPropertyBrowsing_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPerPropertyBrowsing : public IUnknown
{
public:
	IPerPropertyBrowsing () {};
	~IPerPropertyBrowsing () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetDisplayString(  /* [in] */ LONG disp_id, /* [out] */ BSTR * p_bstr ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MapPropertyToPage(  /* [in] */ LONG disp_id, /* [out] */ GUID * p_clsid ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetPredefinedStrings(  /* [in] */ LONG disp_id, /* [out] */ ecom_control_library::tagCALPOLESTR * p_ca_strings_out, /* [out] */ ecom_control_library::tagCADWORD * p_ca_cookies_out ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetPredefinedValue(  /* [in] */ LONG disp_id, /* [in] */ ULONG dw_cookie, /* [out] */ VARIANT * p_var_out ) = 0;



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