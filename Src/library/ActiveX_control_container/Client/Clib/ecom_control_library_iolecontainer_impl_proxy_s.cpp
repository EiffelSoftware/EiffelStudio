/*-----------------------------------------------------------
Implemented `IOleContainer' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleContainer_impl_proxy_s.h"
static const IID IID_IOleContainer_ = {0x0000011b,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleContainer_impl_proxy::IOleContainer_impl_proxy( IUnknown * a_pointer )
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

  hr = a_pointer->QueryInterface(IID_IOleContainer_, (void **)&p_IOleContainer);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleContainer_impl_proxy::~IOleContainer_impl_proxy()
{
  p_unknown->Release ();
  if (p_IOleContainer!=NULL)
    p_IOleContainer->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleContainer_impl_proxy::ccom_parse_display_name(  /* [in] */ ::IBindCtx * pbc,  /* [in] */ EIF_OBJECT psz_display_name,  /* [out] */ EIF_OBJECT pch_eaten,  /* [out] */ EIF_OBJECT ppmk_out )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleContainer == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleContainer_, (void **)&p_IOleContainer);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LPWSTR tmp_psz_display_name = 0;
  tmp_psz_display_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_display_name), NULL);
  ULONG * tmp_pch_eaten = 0;
  tmp_pch_eaten = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pch_eaten), NULL);
  
  ::IMoniker * * tmp_ppmk_out = 0;
  tmp_ppmk_out = (::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk_out), NULL);
  
  hr = p_IOleContainer->ParseDisplayName(pbc,tmp_psz_display_name,tmp_pch_eaten,tmp_ppmk_out);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pch_eaten, pch_eaten);
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((::IMoniker * *)tmp_ppmk_out, ppmk_out);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_192 (tmp_pch_eaten);
grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk_out);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleContainer_impl_proxy::ccom_enum_objects(  /* [in] */ EIF_INTEGER grf_flags,  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleContainer == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleContainer_, (void **)&p_IOleContainer);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_grf_flags = 0;
  tmp_grf_flags = (ULONG)grf_flags;
  ::IEnumUnknown * * tmp_ppenum = 0;
  tmp_ppenum = (::IEnumUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_191 (eif_access (ppenum), NULL);
  
  hr = p_IOleContainer->EnumObjects(tmp_grf_flags,tmp_ppenum);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_191 ((::IEnumUnknown * *)tmp_ppenum, ppenum);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_191 (tmp_ppenum);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleContainer_impl_proxy::ccom_lock_container(  /* [in] */ EIF_INTEGER f_lock )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleContainer == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleContainer_, (void **)&p_IOleContainer);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG tmp_f_lock = 0;
  tmp_f_lock = (LONG)f_lock;
  
  hr = p_IOleContainer->LockContainer(tmp_f_lock);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleContainer_impl_proxy::ccom_item()

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
