/*-----------------------------------------------------------
Implemented `IAxWinAmbientDispatch' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IAXWINAMBIENTDISPATCH_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IAXWINAMBIENTDISPATCH_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IAxWinAmbientDispatch_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IAxWinAmbientDispatch_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IAxWinAmbientDispatch_impl_stub : public ecom_control_library::IAxWinAmbientDispatch
{
public:
  IAxWinAmbientDispatch_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IAxWinAmbientDispatch_impl_stub ();

  /*-----------------------------------------------------------
  Enable or disable windowless activation
  -----------------------------------------------------------*/
  STDMETHODIMP set_AllowWindowlessActivation(  /* [in] */ VARIANT_BOOL pb_can_windowless_activate );


  /*-----------------------------------------------------------
  Enable or disable windowless activation
  -----------------------------------------------------------*/
  STDMETHODIMP AllowWindowlessActivation(  /* [out, retval] */ VARIANT_BOOL * pb_can_windowless_activate );


  /*-----------------------------------------------------------
  Set the background color
  -----------------------------------------------------------*/
  STDMETHODIMP set_BackColor(  /* [in] */ OLE_COLOR pclr_background );


  /*-----------------------------------------------------------
  Set the background color
  -----------------------------------------------------------*/
  STDMETHODIMP BackColor(  /* [out, retval] */ OLE_COLOR * pclr_background );


  /*-----------------------------------------------------------
  Set the ambient foreground color
  -----------------------------------------------------------*/
  STDMETHODIMP set_ForeColor(  /* [in] */ OLE_COLOR pclr_foreground );


  /*-----------------------------------------------------------
  Set the ambient foreground color
  -----------------------------------------------------------*/
  STDMETHODIMP ForeColor(  /* [out, retval] */ OLE_COLOR * pclr_foreground );


  /*-----------------------------------------------------------
  Set the ambient locale
  -----------------------------------------------------------*/
  STDMETHODIMP set_LocaleID(  /* [in] */ ULONG plcid_locale_id );


  /*-----------------------------------------------------------
  Set the ambient locale
  -----------------------------------------------------------*/
  STDMETHODIMP LocaleID(  /* [out, retval] */ ULONG * plcid_locale_id );


  /*-----------------------------------------------------------
  Set the ambient user mode
  -----------------------------------------------------------*/
  STDMETHODIMP set_UserMode(  /* [in] */ VARIANT_BOOL pb_user_mode );


  /*-----------------------------------------------------------
  Set the ambient user mode
  -----------------------------------------------------------*/
  STDMETHODIMP UserMode(  /* [out, retval] */ VARIANT_BOOL * pb_user_mode );


  /*-----------------------------------------------------------
  Enable or disable the control as default
  -----------------------------------------------------------*/
  STDMETHODIMP set_DisplayAsDefault(  /* [in] */ VARIANT_BOOL pb_display_as_default );


  /*-----------------------------------------------------------
  Enable or disable the control as default
  -----------------------------------------------------------*/
  STDMETHODIMP DisplayAsDefault(  /* [out, retval] */ VARIANT_BOOL * pb_display_as_default );


  /*-----------------------------------------------------------
  Set the ambient font
  -----------------------------------------------------------*/
  STDMETHODIMP set_Font(  /* [in] */ Font * p_font );


  /*-----------------------------------------------------------
  Set the ambient font
  -----------------------------------------------------------*/
  STDMETHODIMP a_Font(  /* [out, retval] */ Font * * p_font );


  /*-----------------------------------------------------------
  Enable or disable message reflection
  -----------------------------------------------------------*/
  STDMETHODIMP set_MessageReflect(  /* [in] */ VARIANT_BOOL pb_msg_reflect );


  /*-----------------------------------------------------------
  Enable or disable message reflection
  -----------------------------------------------------------*/
  STDMETHODIMP MessageReflect(  /* [out, retval] */ VARIANT_BOOL * pb_msg_reflect );


  /*-----------------------------------------------------------
  Show or hide grab handles
  -----------------------------------------------------------*/
  STDMETHODIMP ShowGrabHandles(  /* [in] */ VARIANT_BOOL * pb_show_grab_handles );


  /*-----------------------------------------------------------
  Are grab handles enabled
  -----------------------------------------------------------*/
  STDMETHODIMP ShowHatching(  /* [in] */ VARIANT_BOOL * pb_show_hatching );


  /*-----------------------------------------------------------
  Set the DOCHOSTUIFLAG flags
  -----------------------------------------------------------*/
  STDMETHODIMP set_DocHostFlags(  /* [in] */ ULONG pdw_doc_host_flags );


  /*-----------------------------------------------------------
  Set the DOCHOSTUIFLAG flags
  -----------------------------------------------------------*/
  STDMETHODIMP DocHostFlags(  /* [out, retval] */ ULONG * pdw_doc_host_flags );


  /*-----------------------------------------------------------
  Set the DOCHOSTUIDBLCLK flags
  -----------------------------------------------------------*/
  STDMETHODIMP set_DocHostDoubleClickFlags(  /* [in] */ ULONG pdw_doc_host_double_click_flags );


  /*-----------------------------------------------------------
  Set the DOCHOSTUIDBLCLK flags
  -----------------------------------------------------------*/
  STDMETHODIMP DocHostDoubleClickFlags(  /* [out, retval] */ ULONG * pdw_doc_host_double_click_flags );


  /*-----------------------------------------------------------
  Enable or disable context menus
  -----------------------------------------------------------*/
  STDMETHODIMP set_AllowContextMenu(  /* [in] */ VARIANT_BOOL pb_allow_context_menu );


  /*-----------------------------------------------------------
  Enable or disable context menus
  -----------------------------------------------------------*/
  STDMETHODIMP AllowContextMenu(  /* [out, retval] */ VARIANT_BOOL * pb_allow_context_menu );


  /*-----------------------------------------------------------
  Enable or disable UI
  -----------------------------------------------------------*/
  STDMETHODIMP set_AllowShowUI(  /* [in] */ VARIANT_BOOL pb_allow_show_ui );


  /*-----------------------------------------------------------
  Enable or disable UI
  -----------------------------------------------------------*/
  STDMETHODIMP AllowShowUI(  /* [out, retval] */ VARIANT_BOOL * pb_allow_show_ui );


  /*-----------------------------------------------------------
  Set the option key path
  -----------------------------------------------------------*/
  STDMETHODIMP set_OptionKeyPath(  /* [in] */ BSTR pbstr_option_key_path );


  /*-----------------------------------------------------------
  Set the option key path
  -----------------------------------------------------------*/
  STDMETHODIMP OptionKeyPath(  /* [out, retval] */ BSTR * pbstr_option_key_path );


  /*-----------------------------------------------------------
  Get type info
  -----------------------------------------------------------*/
  STDMETHODIMP GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo );


  /*-----------------------------------------------------------
  Get type info count
  -----------------------------------------------------------*/
  STDMETHODIMP GetTypeInfoCount( unsigned int * pctinfo );


  /*-----------------------------------------------------------
  IDs of function names 'rgszNames'
  -----------------------------------------------------------*/
  STDMETHODIMP GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid );


  /*-----------------------------------------------------------
  Invoke function.
  -----------------------------------------------------------*/
  STDMETHODIMP Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr );


  /*-----------------------------------------------------------
  Decrement reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) Release();


  /*-----------------------------------------------------------
  Increment reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) AddRef();


  /*-----------------------------------------------------------
  Query Interface
  -----------------------------------------------------------*/
  STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
  /*-----------------------------------------------------------
  Reference counter
  -----------------------------------------------------------*/
  LONG ref_count;


  /*-----------------------------------------------------------
  Corresponding Eiffel object
  -----------------------------------------------------------*/
  EIF_OBJECT eiffel_object;


  /*-----------------------------------------------------------
  Eiffel type id
  -----------------------------------------------------------*/
  EIF_TYPE_ID type_id;


  /*-----------------------------------------------------------
  Type information
  -----------------------------------------------------------*/
  ITypeInfo * pTypeInfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
