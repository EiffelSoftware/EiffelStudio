/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISIMPLEFRAMESITE_S_H__
#define __ECOM_CONTROL_LIBRARY_ISIMPLEFRAMESITE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_ISimpleFrameSite_FWD_DEFINED__
#define __ecom_control_library_ISimpleFrameSite_FWD_DEFINED__
namespace ecom_control_library
{
class ISimpleFrameSite;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_ISimpleFrameSite_INTERFACE_DEFINED__
#define __ecom_control_library_ISimpleFrameSite_INTERFACE_DEFINED__
namespace ecom_control_library
{
class ISimpleFrameSite : public IUnknown
{
public:
	ISimpleFrameSite () {};
	~ISimpleFrameSite () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PreMessageFilter(  /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ UINT msg, /* [in] */ UINT wp, /* [in] */ LONG lp, /* [out] */ LONG * pl_result, /* [out] */ ULONG * pdw_cookie ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PostMessageFilter(  /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ UINT msg, /* [in] */ UINT wp, /* [in] */ LONG lp, /* [out] */ LONG * pl_result, /* [in] */ ULONG dw_cookie ) = 0;



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