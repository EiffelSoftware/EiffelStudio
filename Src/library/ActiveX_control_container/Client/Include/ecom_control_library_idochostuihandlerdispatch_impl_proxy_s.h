/*-----------------------------------------------------------
Implemented `IDocHostUIHandlerDispatch' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLERDISPATCH_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLERDISPATCH_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDocHostUIHandlerDispatch_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IDocHostUIHandlerDispatch_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDocHostUIHandlerDispatch_impl_proxy
{
public:
  IDocHostUIHandlerDispatch_impl_proxy (IUnknown * a_pointer);
  virtual ~IDocHostUIHandlerDispatch_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  EIF_REFERENCE ccom_show_context_menu(  /* [in] */ EIF_INTEGER dw_id,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ IUnknown * pcmdt_reserved,  /* [in] */ IDispatch * pdisp_reserved );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_host_info(  /* [in, out] */ EIF_OBJECT pdw_flags,  /* [in, out] */ EIF_OBJECT pdw_double_click );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  EIF_REFERENCE ccom_show_ui(  /* [in] */ EIF_INTEGER dw_id,  /* [in] */ IUnknown * p_active_object,  /* [in] */ IUnknown * p_command_target,  /* [in] */ IUnknown * p_frame,  /* [in] */ IUnknown * p_doc );


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
  void ccom_enable_modeless(  /* [in] */ EIF_BOOLEAN f_enable );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_doc_window_activate(  /* [in] */ EIF_BOOLEAN f_activate );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_frame_window_activate(  /* [in] */ EIF_BOOLEAN f_activate );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_resize_border(  /* [in] */ EIF_INTEGER left,  /* [in] */ EIF_INTEGER top,  /* [in] */ EIF_INTEGER right,  /* [in] */ EIF_INTEGER bottom,  /* [in] */ IUnknown * p_uiwindow,  /* [in] */ EIF_BOOLEAN f_frame_window );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  EIF_REFERENCE ccom_translate_accelerator(  /* [in] */ EIF_INTEGER h_wnd,  /* [in] */ EIF_INTEGER n_message,  /* [in] */ EIF_INTEGER w_param,  /* [in] */ EIF_INTEGER l_param,  /* [in] */ EIF_OBJECT bstr_guid_cmd_group,  /* [in] */ EIF_INTEGER n_cmd_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_option_key_path(  /* [out] */ EIF_OBJECT pbstr_key,  /* [in] */ EIF_INTEGER dw );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_drop_target(  /* [in] */ IUnknown * p_drop_target,  /* [out] */ EIF_OBJECT pp_drop_target );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_external(  /* [out] */ EIF_OBJECT pp_dispatch );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_translate_url(  /* [in] */ EIF_INTEGER dw_translate,  /* [in] */ EIF_OBJECT bstr_urlin,  /* [out] */ EIF_OBJECT pbstr_urlout );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_filter_data_object(  /* [in] */ IUnknown * p_do,  /* [out] */ EIF_OBJECT pp_doret );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ecom_control_library::IDocHostUIHandlerDispatch * p_IDocHostUIHandlerDispatch;


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
