/*-----------------------------------------------------------
Implemented `IDropSource' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDROPSOURCE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IDROPSOURCE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDropSource_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IDropSource_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDropSource_impl_proxy
{
public:
	IDropSource_impl_proxy (IUnknown * a_pointer);
	virtual ~IDropSource_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_query_continue_drag(  /* [in] */ EIF_INTEGER f_escape_pressed,  /* [in] */ EIF_INTEGER grf_key_state );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_give_feedback(  /* [in] */ EIF_INTEGER dw_effect );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IDropSource * p_IDropSource;


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