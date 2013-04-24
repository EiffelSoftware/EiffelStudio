/*-----------------------------------------------------------
Implemented `IOleInPlaceFrame' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEFRAME_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEFRAME_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleInPlaceFrame_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleInPlaceFrame_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_IOleInPlaceActiveObject_s.h"

#include "ecom_control_library_tagOleMenuGroupWidths_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleInPlaceFrame_impl_proxy
{
public:
	IOleInPlaceFrame_impl_proxy (IUnknown * a_pointer);
	virtual ~IOleInPlaceFrame_impl_proxy ();

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
	void ccom_get_border(  /* [out] */ ecom_control_library::tagRECT * lprect_border );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_request_border_space(  /* [in] */ ecom_control_library::tagRECT * pborderwidths );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_border_space(  /* [in] */ ecom_control_library::tagRECT * pborderwidths );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_active_object(  /* [in] */ ecom_control_library::IOleInPlaceActiveObject * p_active_object,  /* [in] */ EIF_OBJECT psz_obj_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_insert_menus(  /* [in] */ EIF_POINTER hmenu_shared,  /* [in, out] */ ecom_control_library::tagOleMenuGroupWidths * lp_menu_widths );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_menu(  /* [in] */ EIF_POINTER hmenu_shared,  /* [in] */ ecom_control_library::wireHGLOBAL holemenu,  /* [in] */ EIF_POINTER hwnd_active_object );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remove_menus(  /* [in] */ EIF_POINTER hmenu_shared );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_status_text(  /* [in] */ EIF_OBJECT psz_status_text );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enable_modeless(  /* [in] */ EIF_INTEGER f_enable );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_translate_accelerator(  /* [in] */ ecom_control_library::tagMSG * lpmsg,  /* [in] */ EIF_INTEGER w_id );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IOleInPlaceFrame * p_IOleInPlaceFrame;


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