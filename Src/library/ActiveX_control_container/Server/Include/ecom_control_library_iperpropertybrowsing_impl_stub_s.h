/*-----------------------------------------------------------
Implemented `IPerPropertyBrowsing' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERPROPERTYBROWSING_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERPROPERTYBROWSING_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPerPropertyBrowsing_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IPerPropertyBrowsing_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPerPropertyBrowsing_impl_stub : public ecom_control_library::IPerPropertyBrowsing
{
public:
  IPerPropertyBrowsing_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IPerPropertyBrowsing_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetDisplayString(  /* [in] */ LONG disp_id, /* [out] */ BSTR * p_bstr );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP MapPropertyToPage(  /* [in] */ LONG disp_id, /* [out] */ GUID * p_clsid );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetPredefinedStrings(  /* [in] */ LONG disp_id, /* [out] */ ecom_control_library::tagCALPOLESTR * p_ca_strings_out, /* [out] */ ecom_control_library::tagCADWORD * p_ca_cookies_out );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetPredefinedValue(  /* [in] */ LONG disp_id, /* [in] */ ULONG dw_cookie, /* [out] */ VARIANT * p_var_out );


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
