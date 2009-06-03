/*-----------------------------------------------------------
Implemented `IPropertyBag' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYBAG_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYBAG_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPropertyBag_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPropertyBag_s.h"

#include "ecom_control_library_IErrorLog_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPropertyBag_impl_proxy
{
public:
  IPropertyBag_impl_proxy (IUnknown * a_pointer);
  virtual ~IPropertyBag_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_read(  /* [in] */ EIF_OBJECT psz_prop_name,  /* [out] */ VARIANT * p_var,  /* [in] */ ::IErrorLog * p_error_log);


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_write(  /* [in] */ EIF_OBJECT psz_prop_name,  /* [in] */ VARIANT * p_var );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IPropertyBag * p_IPropertyBag;


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
