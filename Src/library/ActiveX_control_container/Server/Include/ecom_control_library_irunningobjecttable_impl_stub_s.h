/*-----------------------------------------------------------
Implemented `IRunningObjectTable' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IRUNNINGOBJECTTABLE_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IRUNNINGOBJECTTABLE_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IRunningObjectTable_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IRunningObjectTable_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IRunningObjectTable_impl_stub : public ecom_control_library::IRunningObjectTable
{
public:
  IRunningObjectTable_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IRunningObjectTable_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Register(  /* [in] */ ULONG grf_flags, /* [in] */ IUnknown * punk_object, /* [in] */ ecom_control_library::IMoniker * pmk_object_name, /* [out] */ ULONG * pdw_register );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Revoke(  /* [in] */ ULONG dw_register );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IsRunning(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetObject(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name, /* [out] */ IUnknown * * ppunk_object );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP NoteChangeTime(  /* [in] */ ULONG dw_register, /* [in] */ ecom_control_library::_FILETIME * pfiletime );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetTimeOfLastChange(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name, /* [out] */ ecom_control_library::_FILETIME * pfiletime );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnumRunning(  /* [out] */ ecom_control_library::IEnumMoniker * * ppenum_moniker );


  /*-----------------------------------------------------------
  Decrement reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) Release();


  /*-----------------------------------------------------------
  Increment reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) AddRef();


  /*-----------------------------------------------------------
  Query Interface
  -----------------------------------------------------------*/
  STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
  /*-----------------------------------------------------------
  Reference counter
  -----------------------------------------------------------*/
  LONG ref_count;


  /*-----------------------------------------------------------
  Corresponding Eiffel object
  -----------------------------------------------------------*/
  EIF_OBJECT eiffel_object;


  /*-----------------------------------------------------------
  Eiffel type id
  -----------------------------------------------------------*/
  EIF_TYPE_ID type_id;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
