/*-----------------------------------------------------------
Implemented `IOleInPlaceObjectWindowless' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEOBJECTWINDOWLESS_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEOBJECTWINDOWLESS_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleInPlaceObjectWindowless_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IOleInPlaceObjectWindowless_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleInPlaceObjectWindowless_impl_stub : public ecom_control_library::IOleInPlaceObjectWindowless
{
public:
  IOleInPlaceObjectWindowless_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IOleInPlaceObjectWindowless_impl_stub ();

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
  STDMETHODIMP InPlaceDeactivate( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP UIDeactivate( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetObjectRects(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect, /* [in] */ ecom_control_library::tagRECT * lprc_clip_rect );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ReactivateAndUndo( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnWindowMessage(  /* [in] */ UINT msg, /* [in] */ UINT w_param, /* [in] */ LONG l_param, /* [out] */ LONG * pl_result );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetDropTarget(  /* [out] */ ecom_control_library::IDropTarget * * pp_drop_target );


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
