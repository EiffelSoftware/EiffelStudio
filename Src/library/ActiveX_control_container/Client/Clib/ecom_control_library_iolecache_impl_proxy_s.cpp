/*-----------------------------------------------------------
Implemented `IOleCache' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleCache_impl_proxy_s.h"
static const IID IID_IOleCache_ = {0x0000011e,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleCache_impl_proxy::IOleCache_impl_proxy( IUnknown * a_pointer )
{
  HRESULT hr, hr2;
  hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

  hr = a_pointer->QueryInterface(IID_IOleCache_, (void **)&p_IOleCache);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleCache_impl_proxy::~IOleCache_impl_proxy()
{
  p_unknown->Release ();
  if (p_IOleCache!=NULL)
    p_IOleCache->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleCache_impl_proxy::ccom_cache(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ EIF_INTEGER advf,  /* [out] */ EIF_OBJECT pdw_connection )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleCache == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleCache_, (void **)&p_IOleCache);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_advf = 0;
  tmp_advf = (ULONG)advf;
  ULONG * tmp_pdw_connection = 0;
  tmp_pdw_connection = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_connection), NULL);
  
  hr = p_IOleCache->Cache((struct tagFORMATETC *)p_formatetc, tmp_advf, tmp_pdw_connection);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_connection, pdw_connection);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_185 (tmp_pdw_connection);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleCache_impl_proxy::ccom_uncache(  /* [in] */ EIF_INTEGER dw_connection )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleCache == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleCache_, (void **)&p_IOleCache);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_connection = 0;
  tmp_dw_connection = (ULONG)dw_connection;
  
  hr = p_IOleCache->Uncache(tmp_dw_connection);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleCache_impl_proxy::ccom_enum_cache(  /* [out] */ EIF_OBJECT ppenum_statdata )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleCache == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleCache_, (void **)&p_IOleCache);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ::IEnumSTATDATA * * tmp_ppenum_statdata = 0;
  tmp_ppenum_statdata = (::IEnumSTATDATA * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_112 (eif_access (ppenum_statdata), NULL);
  
  hr = p_IOleCache->EnumCache(tmp_ppenum_statdata);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_112 ((::IEnumSTATDATA * *)tmp_ppenum_statdata, ppenum_statdata);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_112 (tmp_ppenum_statdata);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleCache_impl_proxy::ccom_init_cache(  /* [in] */ ::IDataObject * p_data_object )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleCache == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleCache_, (void **)&p_IOleCache);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IOleCache->InitCache(p_data_object);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleCache_impl_proxy::ccom_set_data(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ STGMEDIUM * pmedium,  /* [in] */ EIF_INTEGER f_release )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleCache == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleCache_, (void **)&p_IOleCache);
    if (FAILED (hr))
    {
      if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
        com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
      com_eraise (f.c_format_message (hr), EN_PROG);
    };
  };
  LONG tmp_f_release = 0;
  tmp_f_release = (LONG)f_release;
  
  hr = p_IOleCache->SetData((struct tagFORMATETC *)p_formatetc, pmedium, tmp_f_release);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleCache_impl_proxy::ccom_item()

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
