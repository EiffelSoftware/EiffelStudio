/*-----------------------------------------------------------
Implemented `IOleWindow' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEWINDOW_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEWINDOW_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleWindow_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleWindow_s.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleWindow_impl_proxy
{
public:
  IOleWindow_impl_proxy (IUnknown * a_pointer);
  virtual ~IOleWindow_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_window(  /* [out] */ EIF_OBJECT phwnd );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_context_sensitive_help(  /* [in] */ EIF_INTEGER f_enter_mode );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IOleWindow * p_IOleWindow;


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
