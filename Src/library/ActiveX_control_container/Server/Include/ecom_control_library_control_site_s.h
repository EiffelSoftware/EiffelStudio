/*-----------------------------------------------------------
Control Site Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_CONTROL_SITE_S_H__
#define __ECOM_CONTROL_LIBRARY_CONTROL_SITE_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class control_site;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_control_library_IAxWinHostWindow_s.h"

#include "ecom_control_library_IOleClientSite_s.h"

#include "ecom_control_library_IOleInPlaceSiteWindowless_s.h"

#include "ecom_control_library_IOleControlSite_s.h"

#include "ecom_control_library_IOleContainer_s.h"

#include "ecom_control_library_IObjectWithSite_s.h"

#include "ecom_control_library_IPropertyNotifySink_s.h"

#include "ecom_control_library_IAxWinAmbientDispatch_s.h"

#include "ecom_control_library_IDocHostUIHandler_s.h"

#include "ecom_control_library_IAdviseSink_s.h"

#include "ecom_control_library_iserviceprovider_s.h"

#ifdef __cplusplus
extern "C" {
#endif

extern "C" const CLSID CLSID_control_site_;

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class control_site : 
  public ecom_control_library::IOleClientSite, 
  public ecom_control_library::IOleInPlaceSiteWindowless, 
  public ecom_control_library::IOleControlSite, 
  public ecom_control_library::IOleContainer, 
  public ecom_control_library::IObjectWithSite, 
  public ecom_control_library::IPropertyNotifySink, 
  public ecom_control_library::IAxWinAmbientDispatch, 
  public ecom_control_library::IDocHostUIHandler, 
  public ecom_control_library::IAdviseSink, 
  public ecom_control_library::IServiceProvider
{
public:
  control_site (EIF_TYPE_ID tid);
  control_site (EIF_OBJECT eif_obj);
  virtual ~control_site ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SaveObject( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetMoniker(  /* [in] */ ULONG dw_assign, /* [in] */ ULONG dw_which_moniker, /* [out] */ ecom_control_library::IMoniker * * ppmk );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetContainer(  /* [out] */ ecom_control_library::IOleContainer * * pp_container );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ShowObject( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnShowWindow(  /* [in] */ LONG f_show );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RequestNewObjectLayout( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetWindow(  /* [out] */ ecom_control_library::wireHWND * phwnd );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ContextSensitiveHelp(  /* [in] */ LONG f_enter_mode );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP CanInPlaceActivate( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnInPlaceActivate( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnUIActivate( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetWindowContext(  /* [out] */ ecom_control_library::IOleInPlaceFrame * * pp_frame, /* [out] */ ecom_control_library::IOleInPlaceUIWindow * * pp_doc, /* [out] */ ecom_control_library::tagRECT * lprc_pos_rect, /* [out] */ ecom_control_library::tagRECT * lprc_clip_rect, /* [in, out] */ ecom_control_library::tagOIFI * lp_frame_info );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Scroll(  /* [in] */ ecom_control_library::tagSIZE scroll_extant );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnUIDeactivate(  /* [in] */ LONG f_undoable );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnInPlaceDeactivate( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DiscardUndoState( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DeactivateAndUndo( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnPosRectChange(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnInPlaceActivateEx(  /* [out] */ LONG * pf_no_redraw, /* [in] */ ULONG dw_flags );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnInPlaceDeactivateEx(  /* [in] */ LONG f_no_redraw );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RequestUIActivate( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP CanWindowlessActivate( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetCapture( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetCapture(  /* [in] */ LONG f_capture );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetFocus( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetFocus(  /* [in] */ LONG f_focus );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetDC(  /* [in] */ ecom_control_library::tagRECT * p_rect, /* [in] */ ULONG grf_flags, /* [out] */ ecom_control_library::wireHDC * ph_dc );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ReleaseDC(  /* [in] */ ecom_control_library::wireHDC h_dc );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP InvalidateRect(  /* [in] */ ecom_control_library::tagRECT * p_rect, /* [in] */ LONG f_erase );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP InvalidateRgn(  /* [in] */ void * h_rgn, /* [in] */ LONG f_erase );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ScrollRect(  /* [in] */ INT dx, /* [in] */ INT dy, /* [in] */ ecom_control_library::tagRECT * p_rect_scroll, /* [in] */ ecom_control_library::tagRECT * p_rect_clip );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP AdjustRect(  /* [in, out] */ ecom_control_library::tagRECT * prc );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnDefWindowMessage(  /* [in] */ UINT msg, /* [in] */ UINT w_param, /* [in] */ LONG l_param, /* [out] */ LONG * pl_result );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnControlInfoChanged( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LockInPlaceActive(  /* [in] */ LONG f_lock );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetExtendedControl(  /* [out] */ IDispatch * * pp_disp );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP TransformCoords(  /* [in, out] */ ecom_control_library::_POINTL * p_ptl_himetric, /* [in, out] */ ecom_control_library::tagPOINTF * p_ptf_container, /* [in] */ ULONG dw_flags );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg, /* [in] */ ULONG grf_modifiers );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnFocus(  /* [in] */ LONG f_got_focus );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ShowPropertyFrame( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ParseDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ LPWSTR psz_display_name, /* [out] */ ULONG * pch_eaten, /* [out] */ ecom_control_library::IMoniker * * ppmk_out );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnumObjects(  /* [in] */ ULONG grf_flags, /* [out] */ ecom_control_library::IEnumUnknown * * ppenum );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LockContainer(  /* [in] */ LONG f_lock );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetSite(  /* [in] */ IUnknown * p_unk_site );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetSite(  /* [in] */ REFIID riid, /* [out] */ void * * ppv_site );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnChanged(  /* [in] */ LONG disp_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnRequestEdit(  /* [in] */ LONG disp_id );


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
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ShowContextMenu(  /* [in] */ ULONG dw_id, /* [in] */ ecom_control_library::tagPOINT * ppt, /* [in] */ IUnknown * pcmdt_reserved, /* [in] */ IDispatch * pdisp_reserved );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetHostInfo(  /* [in, out] */ ecom_control_library::_DOCHOSTUIINFO * p_info );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ShowUI(  /* [in] */ ULONG dw_id, /* [in] */ ecom_control_library::IOleInPlaceActiveObject * p_active_object, /* [in] */ ecom_control_library::IOleCommandTarget * p_command_target, /* [in] */ ecom_control_library::IOleInPlaceFrame * p_frame, /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_doc );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP HideUI( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP UpdateUI( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnableModeless(  /* [in] */ LONG f_enable );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnDocWindowActivate(  /* [in] */ LONG f_activate );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnFrameWindowActivate(  /* [in] */ LONG f_activate );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ResizeBorder(  /* [in] */ ecom_control_library::tagRECT * prc_border, /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_uiwindow, /* [in] */ LONG f_rame_window );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IDocHostUIHandler_TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * lpmsg, /* [in] */ GUID * pguid_cmd_group, /* [in] */ ULONG n_cmd_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetOptionKeyPath(  /* [out] */ LPWSTR * pch_key, /* [in] */ ULONG dw );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetDropTarget(  /* [in] */ ecom_control_library::IDropTarget * p_drop_target, /* [out] */ ecom_control_library::IDropTarget * * pp_drop_target );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetExternal(  /* [out] */ IDispatch * * pp_dispatch );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP TranslateUrl(  /* [in] */ ULONG dw_translate, /* [in] */ SHORT * pch_urlin, /* [out] */ SHORT * * ppch_urlout );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP FilterDataObject(  /* [in] */ ecom_control_library::IDataObject * p_do, /* [out] */ ecom_control_library::IDataObject * * pp_doret );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnDataChange(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ecom_control_library::wireASYNC_STGMEDIUM * p_stgmed );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnViewChange(  /* [in] */ ULONG dw_aspect, /* [in] */ LONG lindex );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnRename(  /* [in] */ ecom_control_library::IMoniker * pmk );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnSave( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnClose( void );


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
  Query Interface.
  -----------------------------------------------------------*/
  STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );


 /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP QueryService(  /* [in] */ GUID * guid_service, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_object );

 


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
