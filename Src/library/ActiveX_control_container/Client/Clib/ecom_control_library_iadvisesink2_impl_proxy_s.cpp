/*-----------------------------------------------------------
Implemented `IAdviseSink2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IAdviseSink2_impl_proxy_s.h"
static const IID IID_IAdviseSink2_ = {0x00000125,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IAdviseSink2_impl_proxy::IAdviseSink2_impl_proxy( IUnknown * a_pointer )
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

  hr = a_pointer->QueryInterface(IID_IAdviseSink2_, (void **)&p_IAdviseSink2);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IAdviseSink2_impl_proxy::~IAdviseSink2_impl_proxy()
{
  p_unknown->Release ();
  if (p_IAdviseSink2!=NULL)
    p_IAdviseSink2->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink2_impl_proxy::ccom_on_data_change(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ EIF_OBJECT p_stgmed )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink2_, (void **)&p_IAdviseSink2);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ecom_control_library::wireASYNC_STGMEDIUM * tmp_p_stgmed = 0;
  tmp_p_stgmed = (ecom_control_library::wireASYNC_STGMEDIUM *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_6 (eif_access (p_stgmed), NULL);
  
  hr = p_IAdviseSink2->OnDataChange(p_formatetc,tmp_p_stgmed);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_6 (tmp_p_stgmed);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink2_impl_proxy::ccom_on_view_change(  /* [in] */ EIF_INTEGER dw_aspect,  /* [in] */ EIF_INTEGER lindex )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink2_, (void **)&p_IAdviseSink2);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_aspect = 0;
  tmp_dw_aspect = (ULONG)dw_aspect;
  LONG tmp_lindex = 0;
  tmp_lindex = (LONG)lindex;
  
  hr = p_IAdviseSink2->OnViewChange(tmp_dw_aspect,tmp_lindex);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink2_impl_proxy::ccom_on_rename(  /* [in] */ ecom_control_library::IMoniker * pmk )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink2_, (void **)&p_IAdviseSink2);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IAdviseSink2->OnRename(pmk);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink2_impl_proxy::ccom_on_save()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink2_, (void **)&p_IAdviseSink2);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IAdviseSink2->OnSave ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink2_impl_proxy::ccom_on_close()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink2_, (void **)&p_IAdviseSink2);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IAdviseSink2->OnClose ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink2_impl_proxy::ccom_on_link_src_change(  /* [in] */ ecom_control_library::IMoniker * pmk )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink2_, (void **)&p_IAdviseSink2);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IAdviseSink2->OnLinkSrcChange(pmk);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IAdviseSink2_impl_proxy::ccom_item()

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
