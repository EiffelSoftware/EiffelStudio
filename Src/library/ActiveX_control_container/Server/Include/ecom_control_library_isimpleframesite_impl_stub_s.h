/*-----------------------------------------------------------
Implemented `ISimpleFrameSite' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISIMPLEFRAMESITE_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_ISIMPLEFRAMESITE_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ISimpleFrameSite_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_ISimpleFrameSite_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ISimpleFrameSite_impl_stub : public ecom_control_library::ISimpleFrameSite
{
public:
  ISimpleFrameSite_impl_stub (EIF_OBJECT eif_obj);
  virtual ~ISimpleFrameSite_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP PreMessageFilter(  /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ UINT msg, /* [in] */ UINT wp, /* [in] */ LONG lp, /* [out] */ LONG * pl_result, /* [out] */ ULONG * pdw_cookie );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP PostMessageFilter(  /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ UINT msg, /* [in] */ UINT wp, /* [in] */ LONG lp, /* [out] */ LONG * pl_result, /* [in] */ ULONG dw_cookie );


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
