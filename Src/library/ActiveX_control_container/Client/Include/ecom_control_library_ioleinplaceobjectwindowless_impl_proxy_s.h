/*-----------------------------------------------------------
Implemented `IOleInPlaceObjectWindowless' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEOBJECTWINDOWLESS_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEOBJECTWINDOWLESS_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleInPlaceObjectWindowless_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleInPlaceObjectWindowless_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_IDropTarget_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleInPlaceObjectWindowless_impl_proxy
{
public:
  IOleInPlaceObjectWindowless_impl_proxy (IUnknown * a_pointer);
  virtual ~IOleInPlaceObjectWindowless_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_window(  /* [out] */ EIF_OBJECT phwnd );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_context_sensitive_help(  /* [in] */ EIF_INTEGER f_enter_mode );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_in_place_deactivate();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_uideactivate();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_set_object_rects(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect,  /* [in] */ ecom_control_library::tagRECT * lprc_clip_rect );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_reactivate_and_undo();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_window_message(  /* [in] */ EIF_INTEGER msg,  /* [in] */ EIF_INTEGER w_param,  /* [in] */ EIF_INTEGER l_param,  /* [out] */ EIF_OBJECT pl_result );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_drop_target(  /* [out] */ EIF_OBJECT pp_drop_target );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IOleInPlaceObjectWindowless * p_IOleInPlaceObjectWindowless;


  /*-----------------------------------------------------------
  Default IUnknown interface pointer
  -----------------------------------------------------------*/
  IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
