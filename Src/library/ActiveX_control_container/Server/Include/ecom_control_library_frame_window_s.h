/*-----------------------------------------------------------
OLE Control Container Frame. Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_FRAME_WINDOW_S_H__
#define __ECOM_CONTROL_LIBRARY_FRAME_WINDOW_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class frame_window;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IOleInPlaceFrame_s.h"

#ifdef __cplusplus
extern "C" {
#endif

extern "C" const CLSID CLSID_frame_window_;

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class frame_window : public ecom_control_library::IOleInPlaceFrame, public IProvideClassInfo2
{
public:
  frame_window (EIF_TYPE_ID tid);
  frame_window (EIF_OBJECT eif_obj);
  virtual ~frame_window ();

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
  STDMETHODIMP GetBorder(  /* [out] */ ecom_control_library::tagRECT * lprect_border );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RequestBorderSpace(  /* [in] */ ecom_control_library::tagRECT * pborderwidths );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetBorderSpace(  /* [in] */ ecom_control_library::tagRECT * pborderwidths );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetActiveObject(  /* [in] */ ecom_control_library::IOleInPlaceActiveObject * p_active_object, /* [in] */ LPWSTR psz_obj_name );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP InsertMenus(  /* [in] */ ecom_control_library::wireHMENU hmenu_shared, /* [in, out] */ ecom_control_library::tagOleMenuGroupWidths * lp_menu_widths );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetMenu(  /* [in] */ ecom_control_library::wireHMENU hmenu_shared, /* [in] */ ecom_control_library::wireHGLOBAL holemenu, /* [in] */ ecom_control_library::wireHWND hwnd_active_object );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoveMenus(  /* [in] */ ecom_control_library::wireHMENU hmenu_shared );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetStatusText(  /* [in] */ LPWSTR psz_status_text );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnableModeless(  /* [in] */ LONG f_enable );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * lpmsg, /* [in] */ USHORT w_id );


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
  GetClassInfo
  -----------------------------------------------------------*/
  STDMETHODIMP GetClassInfo( ITypeInfo ** ppti );


  /*-----------------------------------------------------------
  GetGUID
  -----------------------------------------------------------*/
  STDMETHODIMP GetGUID( DWORD dwKind, GUID * pguid );



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
