/*-----------------------------------------------------------
Implemented `IObjectWithSite' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOBJECTWITHSITE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOBJECTWITHSITE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IObjectWithSite_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IObjectWithSite_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IObjectWithSite_impl_proxy
{
public:
  IObjectWithSite_impl_proxy (IUnknown * a_pointer);
  virtual ~IObjectWithSite_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_set_site(  /* [in] */ IUnknown * p_unk_site );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_site(  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_site );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IObjectWithSite * p_IObjectWithSite;


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
