/*-----------------------------------------------------------
Implemented `IDocHostUIHandler' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLER_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDocHostUIHandler_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IDocHostUIHandler_s.h"

#include "ecom_control_library_tagPOINT_s.h"

#include "ecom_control_library__DOCHOSTUIINFO_s.h"

#include "ecom_control_library_IOleInPlaceActiveObject_s.h"

#include "ecom_control_library_IOleCommandTarget_s.h"

#include "ecom_control_library_IOleInPlaceFrame_s.h"

#include "ecom_control_library_IOleInPlaceUIWindow_s.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_tagMSG_s.h"

#include "ecom_control_library_IDropTarget_s.h"

#include "ecom_control_library_IDataObject_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDocHostUIHandler_impl_proxy
{
public:
	IDocHostUIHandler_impl_proxy (IUnknown * a_pointer);
	virtual ~IDocHostUIHandler_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_show_context_menu(  /* [in] */ EIF_INTEGER dw_id,  /* [in] */ ecom_control_library::tagPOINT * ppt,  /* [in] */ IUnknown * pcmdt_reserved,  /* [in] */ IDispatch * pdisp_reserved );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_host_info(  /* [in, out] */ ecom_control_library::_DOCHOSTUIINFO * p_info );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_show_ui(  /* [in] */ EIF_INTEGER dw_id,  /* [in] */ ecom_control_library::IOleInPlaceActiveObject * p_active_object,  /* [in] */ ecom_control_library::IOleCommandTarget * p_command_target,  /* [in] */ ecom_control_library::IOleInPlaceFrame * p_frame,  /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_doc );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_hide_ui();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_update_ui();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enable_modeless(  /* [in] */ EIF_INTEGER f_enable );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_doc_window_activate(  /* [in] */ EIF_INTEGER f_activate );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_frame_window_activate(  /* [in] */ EIF_INTEGER f_activate );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_resize_border(  /* [in] */ ecom_control_library::tagRECT * prc_border,  /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_uiwindow,  /* [in] */ EIF_INTEGER f_rame_window );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_translate_accelerator(  /* [in] */ ecom_control_library::tagMSG * lpmsg,  /* [in] */ GUID * pguid_cmd_group,  /* [in] */ EIF_INTEGER n_cmd_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_option_key_path(  /* [out] */ EIF_OBJECT pch_key,  /* [in] */ EIF_INTEGER dw );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_drop_target(  /* [in] */ ecom_control_library::IDropTarget * p_drop_target,  /* [out] */ EIF_OBJECT pp_drop_target );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_external(  /* [out] */ EIF_OBJECT pp_dispatch );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_translate_url(  /* [in] */ EIF_INTEGER dw_translate,  /* [in] */ EIF_OBJECT pch_urlin,  /* [out] */ EIF_OBJECT ppch_urlout );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_filter_data_object(  /* [in] */ ecom_control_library::IDataObject * p_do,  /* [out] */ EIF_OBJECT pp_doret );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IDocHostUIHandler * p_IDocHostUIHandler;


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