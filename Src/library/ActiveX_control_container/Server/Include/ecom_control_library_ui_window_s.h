/*-----------------------------------------------------------
Document Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_UI_WINDOW_S_H__
#define __ECOM_CONTROL_LIBRARY_UI_WINDOW_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ui_window;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_control_library_ioleinplaceuiwindow_s.h"

#ifdef __cplusplus
extern "C" {
#endif

extern "C" const CLSID CLSID_ui_window_;

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ui_window : 
  public ::IOleInPlaceUIWindow
{
public:
  ui_window (EIF_TYPE_ID tid);
  ui_window (EIF_OBJECT eif_obj);
  virtual ~ui_window ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetWindow(  /* [out] */ HWND * phwnd );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ContextSensitiveHelp(  /* [in] */ BOOL f_enter_mode );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetBorder(  /* [out] */ ::tagRECT * lprect_border );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RequestBorderSpace(  /* [in] */const ::tagRECT * pborderwidths );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetBorderSpace(  /* [in] */const ::tagRECT * pborderwidths );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetActiveObject(  /* [in] */ ::IOleInPlaceActiveObject * p_active_object, /* [in] */ LPCOLESTR  psz_obj_name );


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
