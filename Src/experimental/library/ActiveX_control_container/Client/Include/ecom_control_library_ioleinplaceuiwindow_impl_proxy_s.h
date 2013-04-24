/*-----------------------------------------------------------
Implemented `IOleInPlaceUIWindow' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEUIWINDOW_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEUIWINDOW_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleInPlaceUIWindow_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleInPlaceUIWindow_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_IOleInPlaceActiveObject_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleInPlaceUIWindow_impl_proxy
{
public:
  IOleInPlaceUIWindow_impl_proxy (IUnknown * a_pointer);
  virtual ~IOleInPlaceUIWindow_impl_proxy ();

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
  void ccom_get_border(  /* [out] */ ecom_control_library::tagRECT * lprect_border );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_request_border_space(  /* [in] */ ecom_control_library::tagRECT * pborderwidths );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_set_border_space(  /* [in] */ ecom_control_library::tagRECT * pborderwidths );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_set_active_object(  /* [in] */ ::IOleInPlaceActiveObject * p_active_object,  /* [in] */ EIF_OBJECT psz_obj_name );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IOleInPlaceUIWindow * p_IOleInPlaceUIWindow;


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
