/*-----------------------------------------------------------
Implemented `IErrorLog' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IErrorLog_impl_proxy_s.h"
static const IID IID_IErrorLog_ = {0x3127ca40,0x446e,0x11ce,{0x81,0x35,0x00,0xaa,0x00,0x4b,0xb8,0x51}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IErrorLog_impl_proxy::IErrorLog_impl_proxy( IUnknown * a_pointer )
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

  p_IErrorLog = NULL;
  hr = a_pointer->QueryInterface(IID_IErrorLog_, (void **)&p_IErrorLog);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IErrorLog_impl_proxy::~IErrorLog_impl_proxy()
{
  p_unknown->Release ();
  if (p_IErrorLog!=NULL)
    p_IErrorLog->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IErrorLog_impl_proxy::ccom_add_error(  /* [in] */ EIF_OBJECT psz_prop_name,  /* [in] */ EXCEPINFO * p_excep_info )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IErrorLog == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IErrorLog_, (void **)&p_IErrorLog);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LPWSTR tmp_psz_prop_name = 0;
  tmp_psz_prop_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_prop_name), NULL);
  
  hr = p_IErrorLog->AddError(tmp_psz_prop_name,p_excep_info);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IErrorLog_impl_proxy::ccom_item()

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
