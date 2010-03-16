/*-----------------------------------------------------------
Implemented `IPropertyPageSite' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPropertyPageSite_impl_proxy_s.h"
static const IID IID_IPropertyPageSite_ = {0xb196b28c,0xbab4,0x101a,{0xb6,0x9c,0x00,0xaa,0x00,0x34,0x1d,0x07}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPropertyPageSite_impl_proxy::IPropertyPageSite_impl_proxy( IUnknown * a_pointer )
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

  p_IPropertyPageSite = NULL;
  hr = a_pointer->QueryInterface(IID_IPropertyPageSite_, (void **)&p_IPropertyPageSite);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyPageSite_impl_proxy::~IPropertyPageSite_impl_proxy()
{
  p_unknown->Release ();
  if (p_IPropertyPageSite!=NULL)
    p_IPropertyPageSite->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyPageSite_impl_proxy::ccom_on_status_change(  /* [in] */ EIF_INTEGER dw_flags )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPropertyPageSite == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPropertyPageSite_, (void **)&p_IPropertyPageSite);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_flags = 0;
  tmp_dw_flags = (ULONG)dw_flags;
  
  hr = p_IPropertyPageSite->OnStatusChange(tmp_dw_flags);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyPageSite_impl_proxy::ccom_get_locale_id(  /* [out] */ EIF_OBJECT p_locale_id )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPropertyPageSite == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPropertyPageSite_, (void **)&p_IPropertyPageSite);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG * tmp_p_locale_id = 0;
  tmp_p_locale_id = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_locale_id), NULL);
  
  hr = p_IPropertyPageSite->GetLocaleID(tmp_p_locale_id);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_p_locale_id, p_locale_id);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_298 (tmp_p_locale_id);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyPageSite_impl_proxy::ccom_get_page_container(  /* [out] */ EIF_OBJECT ppunk )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPropertyPageSite == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPropertyPageSite_, (void **)&p_IPropertyPageSite);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  IUnknown * * tmp_ppunk = 0;
  tmp_ppunk = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_299 (eif_access (ppunk), NULL);
  
  hr = p_IPropertyPageSite->GetPageContainer(tmp_ppunk);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_299 ((IUnknown * *)tmp_ppunk, ppunk);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_299 (tmp_ppunk);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyPageSite_impl_proxy::ccom_translate_accelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPropertyPageSite == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPropertyPageSite_, (void **)&p_IPropertyPageSite);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IPropertyPageSite->TranslateAccelerator((struct tagMSG *)p_msg);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IPropertyPageSite_impl_proxy::ccom_item()

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
