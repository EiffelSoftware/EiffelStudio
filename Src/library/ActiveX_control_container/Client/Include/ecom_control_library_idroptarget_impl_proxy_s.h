/*-----------------------------------------------------------
Implemented `IDropTarget' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDROPTARGET_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IDROPTARGET_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDropTarget_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IDropTarget_s.h"

#include "ecom_control_library_IDataObject_s.h"

#include "ecom_control_library__POINTL_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDropTarget_impl_proxy
{
public:
	IDropTarget_impl_proxy (IUnknown * a_pointer);
	virtual ~IDropTarget_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_drag_enter(  /* [in] */ ecom_control_library::IDataObject * p_data_obj,  /* [in] */ EIF_INTEGER grf_key_state,  /* [in] */ ecom_control_library::_POINTL * pt,  /* [in, out] */ EIF_OBJECT pdw_effect );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_drag_over(  /* [in] */ EIF_INTEGER grf_key_state,  /* [in] */ ecom_control_library::_POINTL * pt,  /* [in, out] */ EIF_OBJECT pdw_effect );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_drag_leave();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_drop(  /* [in] */ ecom_control_library::IDataObject * p_data_obj,  /* [in] */ EIF_INTEGER grf_key_state,  /* [in] */ ecom_control_library::_POINTL * pt,  /* [in, out] */ EIF_OBJECT pdw_effect );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IDropTarget * p_IDropTarget;


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