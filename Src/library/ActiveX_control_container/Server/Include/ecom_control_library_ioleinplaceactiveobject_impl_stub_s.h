/*-----------------------------------------------------------
Implemented `IOleInPlaceActiveObject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEACTIVEOBJECT_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEACTIVEOBJECT_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleInPlaceActiveObject_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IOleInPlaceActiveObject_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleInPlaceActiveObject_impl_stub : public ecom_control_library::IOleInPlaceActiveObject
{
public:
  IOleInPlaceActiveObject_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IOleInPlaceActiveObject_impl_stub ();

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
  STDMETHODIMP RemoteTranslateAccelerator( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnFrameWindowActivate(  /* [in] */ LONG f_activate );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnDocWindowActivate(  /* [in] */ LONG f_activate );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteResizeBorder(  /* [in] */ ecom_control_library::tagRECT * prc_border, /* [in] */ GUID * riid, /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_uiwindow, /* [in] */ LONG f_frame_window );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnableModeless(  /* [in] */ LONG f_enable );


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
