/*-----------------------------------------------------------
Implemented `IOleInPlaceSiteWindowless' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACESITEWINDOWLESS_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACESITEWINDOWLESS_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleInPlaceSiteWindowless_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IOleInPlaceSiteWindowless_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleInPlaceSiteWindowless_impl_stub : public ecom_control_library::IOleInPlaceSiteWindowless
{
public:
  IOleInPlaceSiteWindowless_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IOleInPlaceSiteWindowless_impl_stub ();

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
