/*-----------------------------------------------------------
Implemented `IAxWinHostWindow' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IAXWINHOSTWINDOW_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IAXWINHOSTWINDOW_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IAxWinHostWindow_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IAxWinHostWindow_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IAxWinHostWindow_impl_stub : public ecom_control_library::IAxWinHostWindow
{
public:
  IAxWinHostWindow_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IAxWinHostWindow_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP CreateControl(  /* [in] */ LPWSTR lp_trics_data, /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ ecom_control_library::IStream * p_stream );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP CreateControlEx(  /* [in] */ LPWSTR lp_trics_data, /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ ecom_control_library::IStream * p_stream, /* [out] */ IUnknown * * ppunk, /* [in] */ GUID * riid_advise, /* [in] */ IUnknown * punk_advise );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP AttachControl(  /* [in] */ IUnknown * p_unk_control, /* [in] */ ecom_control_library::wireHWND h_wnd );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP QueryControl(  /* [in] */ GUID * riid, /* [out] */ void * * ppv_object );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetExternalDispatch(  /* [in] */ IDispatch * p_disp );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetExternalUIHandler(  /* [in] */ ecom_control_library::IDocHostUIHandlerDispatch * p_disp );


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
