/*-----------------------------------------------------------
Implemented `IOleContainer' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECONTAINER_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECONTAINER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleContainer_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleContainer_s.h"

#include "ecom_control_library_IBindCtx_s.h"

#include "ecom_control_library_IMoniker_s.h"

#include "ecom_control_library_IEnumUnknown_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleContainer_impl_proxy
{
public:
  IOleContainer_impl_proxy (IUnknown * a_pointer);
  virtual ~IOleContainer_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_parse_display_name(  /* [in] */ ::IBindCtx * pbc,  /* [in] */ EIF_OBJECT psz_display_name,  /* [out] */ EIF_OBJECT pch_eaten,  /* [out] */ EIF_OBJECT ppmk_out );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_enum_objects(  /* [in] */ EIF_INTEGER grf_flags,  /* [out] */ EIF_OBJECT ppenum );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_lock_container(  /* [in] */ EIF_INTEGER f_lock );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IOleContainer * p_IOleContainer;


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
