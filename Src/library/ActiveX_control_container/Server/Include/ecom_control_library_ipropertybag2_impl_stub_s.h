/*-----------------------------------------------------------
Implemented `IPropertyBag2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYBAG2_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYBAG2_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPropertyBag2_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IPropertyBag2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPropertyBag2_impl_stub : public ecom_control_library::IPropertyBag2
{
public:
  IPropertyBag2_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IPropertyBag2_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Read(  /* [in] */ ULONG c_properties, /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag, /* [in] */ ecom_control_library::IErrorLog * p_err_log, /* [out] */ VARIANT * pvar_value, /* [out] */ HRESULT * phr_error );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Write(  /* [in] */ ULONG c_properties, /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag, /* [in] */ VARIANT * pvar_value );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP CountProperties(  /* [out] */ ULONG * pc_properties );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetPropertyInfo(  /* [in] */ ULONG i_property, /* [in] */ ULONG c_properties, /* [out] */ ecom_control_library::tagPROPBAG2 * p_prop_bag, /* [out] */ ULONG * pc_properties );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LoadObject(  /* [in] */ LPWSTR pstr_name, /* [in] */ ULONG dw_hint, /* [in] */ IUnknown * punk_object, /* [in] */ ecom_control_library::IErrorLog * p_err_log );


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
