/*-----------------------------------------------------------
Implemented `IOleItemContainer' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEITEMCONTAINER_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEITEMCONTAINER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleItemContainer_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleItemContainer_s.h"

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
class IOleItemContainer_impl_proxy
{
public:
  IOleItemContainer_impl_proxy (IUnknown * a_pointer);
  virtual ~IOleItemContainer_impl_proxy ();

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
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_object(  /* [in] */ EIF_OBJECT psz_item,  /* [in] */ EIF_INTEGER dw_speed_needed,  /* [in] */ ::IBindCtx * pbc,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_object );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_object_storage(  /* [in] */ EIF_OBJECT psz_item,  /* [in] */ ::IBindCtx * pbc,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_storage );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_is_running(  /* [in] */ EIF_OBJECT psz_item );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IOleItemContainer * p_IOleItemContainer;


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
