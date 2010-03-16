/*-----------------------------------------------------------
Implemented `IRunningObjectTable' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IRUNNINGOBJECTTABLE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IRUNNINGOBJECTTABLE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IRunningObjectTable_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IRunningObjectTable_s.h"

#include "ecom_control_library_IMoniker_s.h"

#include "ecom_control_library__FILETIME_s.h"

#include "ecom_control_library_IEnumMoniker_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IRunningObjectTable_impl_proxy
{
public:
  IRunningObjectTable_impl_proxy (IUnknown * a_pointer);
  virtual ~IRunningObjectTable_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_register(  /* [in] */ EIF_INTEGER grf_flags,  /* [in] */ IUnknown * punk_object,  /* [in] */ ::IMoniker * pmk_object_name,  /* [out] */ EIF_OBJECT pdw_register );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_revoke(  /* [in] */ EIF_INTEGER dw_register );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_is_running(  /* [in] */ ::IMoniker * pmk_object_name );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_object(  /* [in] */ ::IMoniker * pmk_object_name,  /* [out] */ EIF_OBJECT ppunk_object );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_note_change_time(  /* [in] */ EIF_INTEGER dw_register,  /* [in] */ ecom_control_library::_FILETIME * pfiletime );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_time_of_last_change(  /* [in] */ ::IMoniker * pmk_object_name,  /* [out] */ ecom_control_library::_FILETIME * pfiletime );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_enum_running(  /* [out] */ EIF_OBJECT ppenum_moniker );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IRunningObjectTable * p_IRunningObjectTable;


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
