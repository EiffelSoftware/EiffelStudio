/*-----------------------------------------------------------
Implemented `IBindStatusCallback' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IBINDSTATUSCALLBACK_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IBINDSTATUSCALLBACK_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IBindStatusCallback_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IBindStatusCallback_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IBindStatusCallback_impl_stub : public ecom_control_library::IBindStatusCallback
{
public:
  IBindStatusCallback_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IBindStatusCallback_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnStartBinding(  /* [in] */ ULONG dw_reserved, /* [in] */ ecom_control_library::IBinding * pib );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetPriority(  /* [out] */ LONG * pn_priority );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnLowResource(  /* [in] */ ULONG reserved );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnProgress(  /* [in] */ ULONG ul_progress, /* [in] */ ULONG ul_progress_max, /* [in] */ ULONG ul_status_code, /* [in] */ LPWSTR sz_status_text );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnStopBinding(  /* [in] */ HRESULT hresult, /* [in] */ LPWSTR sz_error );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetBindInfo(  /* [out] */ ULONG * grf_bindf, /* [in, out] */ ecom_control_library::_tagRemBINDINFO * pbindinfo, /* [in, out] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteOnDataAvailable(  /* [in] */ ULONG grf_bscf, /* [in] */ ULONG dw_size, /* [in] */ ecom_control_library::tagRemFORMATETC * p_formatetc, /* [in] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnObjectAvailable(  /* [in] */ GUID * riid, /* [in] */ IUnknown * punk );


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
