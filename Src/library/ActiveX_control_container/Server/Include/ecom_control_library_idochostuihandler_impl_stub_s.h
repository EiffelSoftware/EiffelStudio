/*-----------------------------------------------------------
Implemented `IDocHostUIHandler' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLER_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLER_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDocHostUIHandler_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IDocHostUIHandler_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDocHostUIHandler_impl_stub : public ecom_control_library::IDocHostUIHandler
{
public:
  IDocHostUIHandler_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IDocHostUIHandler_impl_stub ();

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




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
