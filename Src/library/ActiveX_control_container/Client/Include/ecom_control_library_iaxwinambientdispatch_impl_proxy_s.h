/*-----------------------------------------------------------
Implemented `IAxWinAmbientDispatch' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IAXWINAMBIENTDISPATCH_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IAXWINAMBIENTDISPATCH_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IAxWinAmbientDispatch_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IAxWinAmbientDispatch_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IAxWinAmbientDispatch_impl_proxy
{
public:
  IAxWinAmbientDispatch_impl_proxy (IUnknown * a_pointer);
  virtual ~IAxWinAmbientDispatch_impl_proxy ();

  /*-----------------------------------------------------------
  Last error code
  -----------------------------------------------------------*/
  EIF_INTEGER ccom_last_error_code();


  /*-----------------------------------------------------------
  Last source of exception
  -----------------------------------------------------------*/
  EIF_REFERENCE ccom_last_source_of_exception();


  /*-----------------------------------------------------------
  Last error description
  -----------------------------------------------------------*/
  EIF_REFERENCE ccom_last_error_description();


  /*-----------------------------------------------------------
  Last error help file
  -----------------------------------------------------------*/
  EIF_REFERENCE ccom_last_error_help_file();


  /*-----------------------------------------------------------
  Enable or disable windowless activation
  -----------------------------------------------------------*/
  void ccom_set_allow_windowless_activation(  /* [in] */ EIF_BOOLEAN pb_can_windowless_activate );


  /*-----------------------------------------------------------
  Enable or disable windowless activation
  -----------------------------------------------------------*/
  EIF_BOOLEAN ccom_allow_windowless_activation(  );


  /*-----------------------------------------------------------
  Set the background color
  -----------------------------------------------------------*/
  void ccom_set_back_color(  /* [in] */ EIF_INTEGER pclr_background );


  /*-----------------------------------------------------------
  Set the background color
  -----------------------------------------------------------*/
  EIF_INTEGER ccom_back_color(  );


  /*-----------------------------------------------------------
  Set the ambient foreground color
  -----------------------------------------------------------*/
  void ccom_set_fore_color(  /* [in] */ EIF_INTEGER pclr_foreground );


  /*-----------------------------------------------------------
  Set the ambient foreground color
  -----------------------------------------------------------*/
  EIF_INTEGER ccom_fore_color(  );


  /*-----------------------------------------------------------
  Set the ambient locale
  -----------------------------------------------------------*/
  void ccom_set_locale_id(  /* [in] */ EIF_INTEGER plcid_locale_id );


  /*-----------------------------------------------------------
  Set the ambient locale
  -----------------------------------------------------------*/
  EIF_INTEGER ccom_locale_id(  );


  /*-----------------------------------------------------------
  Set the ambient user mode
  -----------------------------------------------------------*/
  void ccom_set_user_mode(  /* [in] */ EIF_BOOLEAN pb_user_mode );


  /*-----------------------------------------------------------
  Set the ambient user mode
  -----------------------------------------------------------*/
  EIF_BOOLEAN ccom_user_mode(  );


  /*-----------------------------------------------------------
  Enable or disable the control as default
  -----------------------------------------------------------*/
  void ccom_set_display_as_default(  /* [in] */ EIF_BOOLEAN pb_display_as_default );


  /*-----------------------------------------------------------
  Enable or disable the control as default
  -----------------------------------------------------------*/
  EIF_BOOLEAN ccom_display_as_default(  );


  /*-----------------------------------------------------------
  Set the ambient font
  -----------------------------------------------------------*/
  void ccom_set_font(  /* [in] */ Font * p_font );


  /*-----------------------------------------------------------
  Set the ambient font
  -----------------------------------------------------------*/
  EIF_REFERENCE ccom_font(  );


  /*-----------------------------------------------------------
  Enable or disable message reflection
  -----------------------------------------------------------*/
  void ccom_set_message_reflect(  /* [in] */ EIF_BOOLEAN pb_msg_reflect );


  /*-----------------------------------------------------------
  Enable or disable message reflection
  -----------------------------------------------------------*/
  EIF_BOOLEAN ccom_message_reflect(  );


  /*-----------------------------------------------------------
  Show or hide grab handles
  -----------------------------------------------------------*/
  void ccom_show_grab_handles(  /* [in] */ EIF_OBJECT pb_show_grab_handles );


  /*-----------------------------------------------------------
  Are grab handles enabled
  -----------------------------------------------------------*/
  void ccom_show_hatching(  /* [in] */ EIF_OBJECT pb_show_hatching );


  /*-----------------------------------------------------------
  Set the DOCHOSTUIFLAG flags
  -----------------------------------------------------------*/
  void ccom_set_doc_host_flags(  /* [in] */ EIF_INTEGER pdw_doc_host_flags );


  /*-----------------------------------------------------------
  Set the DOCHOSTUIFLAG flags
  -----------------------------------------------------------*/
  EIF_INTEGER ccom_doc_host_flags(  );


  /*-----------------------------------------------------------
  Set the DOCHOSTUIDBLCLK flags
  -----------------------------------------------------------*/
  void ccom_set_doc_host_double_click_flags(  /* [in] */ EIF_INTEGER pdw_doc_host_double_click_flags );


  /*-----------------------------------------------------------
  Set the DOCHOSTUIDBLCLK flags
  -----------------------------------------------------------*/
  EIF_INTEGER ccom_doc_host_double_click_flags(  );


  /*-----------------------------------------------------------
  Enable or disable context menus
  -----------------------------------------------------------*/
  void ccom_set_allow_context_menu(  /* [in] */ EIF_BOOLEAN pb_allow_context_menu );


  /*-----------------------------------------------------------
  Enable or disable context menus
  -----------------------------------------------------------*/
  EIF_BOOLEAN ccom_allow_context_menu(  );


  /*-----------------------------------------------------------
  Enable or disable UI
  -----------------------------------------------------------*/
  void ccom_set_allow_show_ui(  /* [in] */ EIF_BOOLEAN pb_allow_show_ui );


  /*-----------------------------------------------------------
  Enable or disable UI
  -----------------------------------------------------------*/
  EIF_BOOLEAN ccom_allow_show_ui(  );


  /*-----------------------------------------------------------
  Set the option key path
  -----------------------------------------------------------*/
  void ccom_set_option_key_path(  /* [in] */ EIF_OBJECT pbstr_option_key_path );


  /*-----------------------------------------------------------
  Set the option key path
  -----------------------------------------------------------*/
  EIF_REFERENCE ccom_option_key_path(  );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IAxWinAmbientDispatch * p_IAxWinAmbientDispatch;


  /*-----------------------------------------------------------
  Default IUnknown interface pointer
  -----------------------------------------------------------*/
  IUnknown * p_unknown;


  /*-----------------------------------------------------------
  Exception information
  -----------------------------------------------------------*/
  EXCEPINFO * excepinfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
