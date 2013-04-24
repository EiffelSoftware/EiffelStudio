/*-----------------------------------------------------------
Implemented `IAdviseSink' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IADVISESINK_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IADVISESINK_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IAdviseSink_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IAdviseSink_s.h"

#include "ecom_control_library_tagFORMATETC_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_IMoniker_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IAdviseSink_impl_proxy
{
public:
  IAdviseSink_impl_proxy (IUnknown * a_pointer);
  virtual ~IAdviseSink_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_data_change(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ STGMEDIUM * p_stgmed );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_view_change(  /* [in] */ EIF_INTEGER dw_aspect,  /* [in] */ EIF_INTEGER lindex );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_rename(  /* [in] */ ::IMoniker * pmk );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_save();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_close();


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IAdviseSink * p_IAdviseSink;


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
