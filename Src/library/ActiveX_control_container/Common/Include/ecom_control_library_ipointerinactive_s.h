/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPOINTERINACTIVE_S_H__
#define __ECOM_CONTROL_LIBRARY_IPOINTERINACTIVE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPointerInactive_FWD_DEFINED__
#define __ecom_control_library_IPointerInactive_FWD_DEFINED__
namespace ecom_control_library
{
class IPointerInactive;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagRECT_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPointerInactive_INTERFACE_DEFINED__
#define __ecom_control_library_IPointerInactive_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPointerInactive : public IUnknown
{
public:
	IPointerInactive () {};
	~IPointerInactive () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetActivationPolicy(  /* [out] */ ULONG * pdw_policy ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnInactiveMouseMove(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ LONG x, /* [in] */ LONG y, /* [in] */ ULONG grf_key_state ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnInactiveSetCursor(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ LONG x, /* [in] */ LONG y, /* [in] */ ULONG dw_mouse_msg, /* [in] */ LONG f_set_always ) = 0;



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