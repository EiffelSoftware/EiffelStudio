/*-----------------------------------------------------------
Implemented `IBindHost' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IBindHost_impl_proxy_s.h"
static const IID IID_IBindHost_ = {0xfc4801a1,0x2ba9,0x11cf,{0xa2,0x29,0x00,0xaa,0x00,0x3d,0x73,0x52}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IBindHost_impl_proxy::IBindHost_impl_proxy( IUnknown * a_pointer )
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

  p_IBindHost = NULL;
  hr = a_pointer->QueryInterface(IID_IBindHost_, (void **)&p_IBindHost);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBindHost_impl_proxy::~IBindHost_impl_proxy()
{
  p_unknown->Release ();
  if (p_IBindHost!=NULL)
    p_IBindHost->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindHost_impl_proxy::ccom_create_moniker(  /* [in] */ EIF_OBJECT sz_name,  /* [in] */ ::IBindCtx * pbc,  /* [out] */ EIF_OBJECT ppmk,  /* [in] */ EIF_INTEGER dw_reserved )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IBindHost == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IBindHost_, (void **)&p_IBindHost);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LPWSTR tmp_sz_name = 0;
  tmp_sz_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (sz_name), NULL);
  
  ::IMoniker * * tmp_ppmk = 0;
  tmp_ppmk = (::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk), NULL);
  ULONG tmp_dw_reserved = 0;
  tmp_dw_reserved = (ULONG)dw_reserved;
  
  hr = p_IBindHost->CreateMoniker(tmp_sz_name,pbc,tmp_ppmk,tmp_dw_reserved);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((::IMoniker * *)tmp_ppmk, ppmk);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindHost_impl_proxy::ccom_moniker_bind_to_storage(  /* [in] */ ::IMoniker * pmk,  /* [in] */ ::IBindCtx * pbc,  /* [in] */ ::IBindStatusCallback * p_bsc,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_obj )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IBindHost == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IBindHost_, (void **)&p_IBindHost);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  IUnknown * * tmp_ppv_obj = 0;
  tmp_ppv_obj = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_414 (eif_access (ppv_obj), NULL);
  
  hr = p_IBindHost->MonikerBindToStorage(pmk,pbc,p_bsc,*riid,(void **)tmp_ppv_obj);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_414 ((IUnknown * *)tmp_ppv_obj, ppv_obj);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_414 (tmp_ppv_obj);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindHost_impl_proxy::ccom_moniker_bind_to_object(  /* [in] */ ::IMoniker * pmk,  /* [in] */ ::IBindCtx * pbc,  /* [in] */ ::IBindStatusCallback * p_bsc,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_obj )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IBindHost == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IBindHost_, (void **)&p_IBindHost);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  IUnknown * * tmp_ppv_obj = 0;
  tmp_ppv_obj = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_415 (eif_access (ppv_obj), NULL);
  
  hr = p_IBindHost->MonikerBindToObject(pmk,pbc,p_bsc,*riid,(void **)tmp_ppv_obj);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_415 ((IUnknown * *)tmp_ppv_obj, ppv_obj);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_415 (tmp_ppv_obj);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IBindHost_impl_proxy::ccom_item()

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
