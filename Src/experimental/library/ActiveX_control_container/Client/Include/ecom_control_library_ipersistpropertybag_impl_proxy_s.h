/*-----------------------------------------------------------
Implemented `IPersistPropertyBag' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTPROPERTYBAG_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTPROPERTYBAG_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPersistPropertyBag_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersistPropertyBag_s.h"

#include "ecom_control_library_IPropertyBag_s.h"

#include "ecom_control_library_IErrorLog_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPersistPropertyBag_impl_proxy
{
public:
  IPersistPropertyBag_impl_proxy (IUnknown * a_pointer);
  virtual ~IPersistPropertyBag_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_class_id(  /* [out] */ GUID * p_class_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_init_new();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_load(  /* [in] */ ::IPropertyBag * p_prop_bag,  /* [in] */ ::IErrorLog * p_error_log );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_save(  /* [in] */ ::IPropertyBag * p_prop_bag,  /* [in] */ EIF_INTEGER f_clear_dirty,  /* [in] */ EIF_INTEGER f_save_all_properties );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IPersistPropertyBag * p_IPersistPropertyBag;


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
