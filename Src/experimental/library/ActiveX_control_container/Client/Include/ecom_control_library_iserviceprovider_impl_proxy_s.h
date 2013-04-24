/*-----------------------------------------------------------
Implemented `IServiceProvider' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISERVICEPROVIDER_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ISERVICEPROVIDER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IServiceProvider_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IServiceProvider_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IServiceProvider_impl_proxy
{
public:
  IServiceProvider_impl_proxy (IUnknown * a_pointer);
  virtual ~IServiceProvider_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_query_service(  /* [in] */ GUID * guid_service,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_object );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IServiceProvider * p_IServiceProvider;


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
