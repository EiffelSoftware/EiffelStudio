/*-----------------------------------------------------------
Implemented `IEnumMoniker' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IEnumMoniker_impl_proxy_s.h"
static const IID IID_IEnumMoniker_ = {0x00000102,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IEnumMoniker_impl_proxy::IEnumMoniker_impl_proxy( IUnknown * a_pointer )
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

  p_IEnumMoniker = NULL;
  hr = a_pointer->QueryInterface(IID_IEnumMoniker_, (void **)&p_IEnumMoniker);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumMoniker_impl_proxy::~IEnumMoniker_impl_proxy()
{
  p_unknown->Release ();
  if (p_IEnumMoniker!=NULL)
    p_IEnumMoniker->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IEnumMoniker_impl_proxy::ccom_next(  /* [in] */ EIF_INTEGER celt,  /* [out] */ EIF_OBJECT rgelt,  /* [out] */ EIF_OBJECT pcelt_fetched )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IEnumMoniker == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IEnumMoniker_, (void **)&p_IEnumMoniker);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_celt = 0;
  tmp_celt = (ULONG)celt;
  ::IMoniker * * tmp_rgelt = 0;
  tmp_rgelt = (::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (rgelt), NULL);
  ULONG * tmp_pcelt_fetched = 0;
  tmp_pcelt_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcelt_fetched), NULL);
  
  hr = p_IEnumMoniker->Next(tmp_celt,tmp_rgelt,tmp_pcelt_fetched);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((::IMoniker * *)tmp_rgelt, rgelt);
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcelt_fetched, pcelt_fetched);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_rgelt);
grt_ce_control_interfaces2.ccom_free_memory_pointed_102 (tmp_pcelt_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IEnumMoniker_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER celt )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IEnumMoniker == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IEnumMoniker_, (void **)&p_IEnumMoniker);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_celt = 0;
  tmp_celt = (ULONG)celt;
  
  hr = p_IEnumMoniker->Skip(tmp_celt);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IEnumMoniker_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IEnumMoniker == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IEnumMoniker_, (void **)&p_IEnumMoniker);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IEnumMoniker->Reset ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IEnumMoniker_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IEnumMoniker == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IEnumMoniker_, (void **)&p_IEnumMoniker);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ::IEnumMoniker * * tmp_ppenum = 0;
  tmp_ppenum = (::IEnumMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_63 (eif_access (ppenum), NULL);
  
  hr = p_IEnumMoniker->Clone(tmp_ppenum);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_63 ((::IEnumMoniker * *)tmp_ppenum, ppenum);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_63 (tmp_ppenum);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IEnumMoniker_impl_proxy::ccom_item()

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
