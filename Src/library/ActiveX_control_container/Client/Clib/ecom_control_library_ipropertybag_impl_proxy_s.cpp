/*-----------------------------------------------------------
Implemented `IPropertyBag' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPropertyBag_impl_proxy_s.h"
static const IID IID_IPropertyBag_ = {0x55272a00,0x42cb,0x11ce,{0x81,0x35,0x00,0xaa,0x00,0x4b,0xb8,0x51}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPropertyBag_impl_proxy::IPropertyBag_impl_proxy( IUnknown * a_pointer )
{
  HRESULT hr, hr2;
  hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  p_unknown = NULL;
  hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

  p_IPropertyBag = NULL;
  hr = a_pointer->QueryInterface(IID_IPropertyBag_, (void **)&p_IPropertyBag);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyBag_impl_proxy::~IPropertyBag_impl_proxy()
{
  p_unknown->Release ();
  if (p_IPropertyBag!=NULL)
    p_IPropertyBag->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyBag_impl_proxy::ccom_read(  /* [in] */ EIF_OBJECT psz_prop_name,  /* [out] */ VARIANT * p_var,  /* [in] */ ::IErrorLog * p_error_log )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPropertyBag == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPropertyBag_, (void **)&p_IPropertyBag);
    if (FAILED (hr))
    {
      if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
        com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
      com_eraise (f.c_format_message (hr), EN_PROG);
    };
  };
  LPWSTR tmp_psz_prop_name = 0;
  tmp_psz_prop_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_prop_name), NULL);
  
  hr = p_IPropertyBag->Read(tmp_psz_prop_name, p_var, p_error_log);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyBag_impl_proxy::ccom_write(  /* [in] */ EIF_OBJECT psz_prop_name,  /* [in] */ VARIANT * p_var )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPropertyBag == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPropertyBag_, (void **)&p_IPropertyBag);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LPWSTR tmp_psz_prop_name = 0;
  tmp_psz_prop_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_prop_name), NULL);
  
  hr = p_IPropertyBag->Write(tmp_psz_prop_name,p_var);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IPropertyBag_impl_proxy::ccom_item()

/*-----------------------------------------------------------
  IUnknown interface
-----------------------------------------------------------*/
{
  return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif
