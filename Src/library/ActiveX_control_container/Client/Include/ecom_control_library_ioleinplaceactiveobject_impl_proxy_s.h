/*-----------------------------------------------------------
Implemented `IOleInPlaceActiveObject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEACTIVEOBJECT_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEACTIVEOBJECT_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleInPlaceActiveObject_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleInPlaceActiveObject_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_IOleInPlaceUIWindow_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleInPlaceActiveObject_impl_proxy
{
public:
	IOleInPlaceActiveObject_impl_proxy (IUnknown * a_pointer);
	virtual ~IOleInPlaceActiveObject_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_window(  /* [out] */ EIF_OBJECT phwnd );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_context_sensitive_help(  /* [in] */ EIF_INTEGER f_enter_mode );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_translate_accelerator();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_frame_window_activate(  /* [in] */ EIF_INTEGER f_activate );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_doc_window_activate(  /* [in] */ EIF_INTEGER f_activate );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_resize_border(  /* [in] */ ecom_control_library::tagRECT * prc_border,  /* [in] */ GUID * riid,  /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_uiwindow,  /* [in] */ EIF_INTEGER f_frame_window );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enable_modeless(  /* [in] */ EIF_INTEGER f_enable );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IOleInPlaceActiveObject * p_IOleInPlaceActiveObject;


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