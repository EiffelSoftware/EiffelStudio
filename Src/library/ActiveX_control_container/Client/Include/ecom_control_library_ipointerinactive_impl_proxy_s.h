/*-----------------------------------------------------------
Implemented `IPointerInactive' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPOINTERINACTIVE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPOINTERINACTIVE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPointerInactive_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPointerInactive_s.h"

#include "ecom_control_library_tagRECT_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPointerInactive_impl_proxy
{
public:
	IPointerInactive_impl_proxy (IUnknown * a_pointer);
	virtual ~IPointerInactive_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_activation_policy(  /* [out] */ EIF_OBJECT pdw_policy );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_inactive_mouse_move(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ EIF_INTEGER grf_key_state );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_inactive_set_cursor(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ EIF_INTEGER dw_mouse_msg,  /* [in] */ EIF_INTEGER f_set_always );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IPointerInactive * p_IPointerInactive;


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