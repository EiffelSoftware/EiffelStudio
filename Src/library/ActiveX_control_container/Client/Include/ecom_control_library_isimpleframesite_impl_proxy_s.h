/*-----------------------------------------------------------
Implemented `ISimpleFrameSite' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISIMPLEFRAMESITE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ISIMPLEFRAMESITE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ISimpleFrameSite_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_ISimpleFrameSite_s.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ISimpleFrameSite_impl_proxy
{
public:
  ISimpleFrameSite_impl_proxy (IUnknown * a_pointer);
  virtual ~ISimpleFrameSite_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_pre_message_filter(  /* [in] */ EIF_POINTER h_wnd,  /* [in] */ EIF_INTEGER msg,  /* [in] */ EIF_INTEGER wp,  /* [in] */ EIF_INTEGER lp,  /* [out] */ EIF_OBJECT pl_result,  /* [out] */ EIF_OBJECT pdw_cookie );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_post_message_filter(  /* [in] */ EIF_POINTER h_wnd,  /* [in] */ EIF_INTEGER msg,  /* [in] */ EIF_INTEGER wp,  /* [in] */ EIF_INTEGER lp,  /* [out] */ EIF_OBJECT pl_result,  /* [in] */ EIF_INTEGER dw_cookie );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::ISimpleFrameSite * p_ISimpleFrameSite;


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
