/*-----------------------------------------------------------
Implemented `IOleInPlaceSite' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACESITE_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACESITE_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleInPlaceSite_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IOleInPlaceSite_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleInPlaceSite_impl_stub : public ecom_control_library::IOleInPlaceSite
{
public:
  IOleInPlaceSite_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IOleInPlaceSite_impl_stub ();

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
