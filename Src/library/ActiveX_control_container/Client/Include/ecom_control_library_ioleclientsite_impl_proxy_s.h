/*-----------------------------------------------------------
Implemented `IOleClientSite' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECLIENTSITE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECLIENTSITE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleClientSite_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleClientSite_s.h"

#include "ecom_control_library_IMoniker_s.h"

#include "ecom_control_library_IOleContainer_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleClientSite_impl_proxy
{
public:
  IOleClientSite_impl_proxy (IUnknown * a_pointer);
  virtual ~IOleClientSite_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_save_object();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_moniker(  /* [in] */ EIF_INTEGER dw_assign,  /* [in] */ EIF_INTEGER dw_which_moniker,  /* [out] */ EIF_OBJECT ppmk );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_container(  /* [out] */ EIF_OBJECT pp_container );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_show_object();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_show_window(  /* [in] */ EIF_INTEGER f_show );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_request_new_object_layout();


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IOleClientSite * p_IOleClientSite;


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
