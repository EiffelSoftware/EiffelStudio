/*-----------------------------------------------------------
Implemented `IOleInPlaceSiteEx' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACESITEEX_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACESITEEX_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleInPlaceSiteEx_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleInPlaceSiteEx_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_IOleInPlaceFrame_s.h"

#include "ecom_control_library_IOleInPlaceUIWindow_s.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_tagOIFI_s.h"

#include "ecom_control_library_tagSIZE_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleInPlaceSiteEx_impl_proxy
{
public:
	IOleInPlaceSiteEx_impl_proxy (IUnknown * a_pointer);
	virtual ~IOleInPlaceSiteEx_impl_proxy ();

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
	void ccom_can_in_place_activate();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_in_place_activate();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_uiactivate();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_window_context(  /* [out] */ EIF_OBJECT pp_frame,  /* [out] */ EIF_OBJECT pp_doc,  /* [out] */ ecom_control_library::tagRECT * lprc_pos_rect,  /* [out] */ ecom_control_library::tagRECT * lprc_clip_rect,  /* [in, out] */ ecom_control_library::tagOIFI * lp_frame_info );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_scroll(  /* [in] */ ecom_control_library::tagSIZE * scroll_extant );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_uideactivate(  /* [in] */ EIF_INTEGER f_undoable );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_in_place_deactivate();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_discard_undo_state();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_deactivate_and_undo();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_pos_rect_change(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_in_place_activate_ex(  /* [out] */ EIF_OBJECT pf_no_redraw,  /* [in] */ EIF_INTEGER dw_flags );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_in_place_deactivate_ex(  /* [in] */ EIF_INTEGER f_no_redraw );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_request_uiactivate();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IOleInPlaceSiteEx * p_IOleInPlaceSiteEx;


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