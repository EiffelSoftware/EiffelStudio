/*-----------------------------------------------------------
Implemented `IPropertyNotifySink' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYNOTIFYSINK_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYNOTIFYSINK_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPropertyNotifySink_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPropertyNotifySink_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPropertyNotifySink_impl_proxy
{
public:
  IPropertyNotifySink_impl_proxy (IUnknown * a_pointer);
  virtual ~IPropertyNotifySink_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_changed(  /* [in] */ EIF_INTEGER disp_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_request_edit(  /* [in] */ EIF_INTEGER disp_id );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IPropertyNotifySink * p_IPropertyNotifySink;


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
