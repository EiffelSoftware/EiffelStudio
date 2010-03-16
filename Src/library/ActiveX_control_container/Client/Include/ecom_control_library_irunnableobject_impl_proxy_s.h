/*-----------------------------------------------------------
Implemented `IRunnableObject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IRUNNABLEOBJECT_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IRUNNABLEOBJECT_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IRunnableObject_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IRunnableObject_s.h"

#include "ecom_control_library_IBindCtx_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IRunnableObject_impl_proxy
{
public:
  IRunnableObject_impl_proxy (IUnknown * a_pointer);
  virtual ~IRunnableObject_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_running_class(  /* [out] */ GUID * lp_clsid );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_run(  /* [in] */ ::IBindCtx * pbc );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_is_running();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_lock_running(  /* [in] */ EIF_INTEGER f_lock,  /* [in] */ EIF_INTEGER f_last_unlock_closes );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_set_contained_object(  /* [in] */ EIF_INTEGER f_contained );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IRunnableObject * p_IRunnableObject;


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
