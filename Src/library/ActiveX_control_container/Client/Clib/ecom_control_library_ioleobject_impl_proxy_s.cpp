/*-----------------------------------------------------------
Implemented `IOleObject' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleObject_impl_proxy_s.h"
static const IID IID_IOleObject_ = {0x00000112,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleObject_impl_proxy::IOleObject_impl_proxy( IUnknown * a_pointer )
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

  hr = a_pointer->QueryInterface(IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleObject_impl_proxy::~IOleObject_impl_proxy()
{
  p_unknown->Release ();
  if (p_IOleObject!=NULL)
    p_IOleObject->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_set_client_site(  /* [in] */ ::IOleClientSite * p_client_site )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IOleObject->SetClientSite(static_cast<::IOleClientSite*>(p_client_site));
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_get_client_site(  /* [out] */ EIF_OBJECT pp_client_site )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ::IOleClientSite * * tmp_pp_client_site = 0;
  tmp_pp_client_site = (::IOleClientSite * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_245 (eif_access (pp_client_site), NULL);
  
  hr = p_IOleObject->GetClientSite(tmp_pp_client_site);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_245 ((::IOleClientSite * *)tmp_pp_client_site, pp_client_site);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_245 (tmp_pp_client_site);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_set_host_names(  /* [in] */ EIF_OBJECT sz_container_app,  /* [in] */ EIF_OBJECT sz_container_obj )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LPWSTR tmp_sz_container_app = 0;
  tmp_sz_container_app = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (sz_container_app), NULL);
  LPWSTR tmp_sz_container_obj = 0;
  tmp_sz_container_obj = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (sz_container_obj), NULL);
  
  hr = p_IOleObject->SetHostNames(tmp_sz_container_app,tmp_sz_container_obj);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_close(  /* [in] */ EIF_INTEGER dw_save_option )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_save_option = 0;
  tmp_dw_save_option = (ULONG)dw_save_option;
  
  hr = p_IOleObject->Close(tmp_dw_save_option);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_set_moniker(  /* [in] */ EIF_INTEGER dw_which_moniker,  /* [in] */ ::IMoniker * pmk )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_which_moniker = 0;
  tmp_dw_which_moniker = (ULONG)dw_which_moniker;
  
  hr = p_IOleObject->SetMoniker(tmp_dw_which_moniker,pmk);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_get_moniker(  /* [in] */ EIF_INTEGER dw_assign,  /* [in] */ EIF_INTEGER dw_which_moniker,  /* [out] */ EIF_OBJECT ppmk )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_assign = 0;
  tmp_dw_assign = (ULONG)dw_assign;
  ULONG tmp_dw_which_moniker = 0;
  tmp_dw_which_moniker = (ULONG)dw_which_moniker;
  ::IMoniker * * tmp_ppmk = 0;
  tmp_ppmk = (::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk), NULL);
  
  hr = p_IOleObject->GetMoniker(tmp_dw_assign,tmp_dw_which_moniker,tmp_ppmk);
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

void ecom_control_library::IOleObject_impl_proxy::ccom_init_from_data(  /* [in] */ ::IDataObject * p_data_object,  /* [in] */ EIF_INTEGER f_creation,  /* [in] */ EIF_INTEGER dw_reserved )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG tmp_f_creation = 0;
  tmp_f_creation = (LONG)f_creation;
  ULONG tmp_dw_reserved = 0;
  tmp_dw_reserved = (ULONG)dw_reserved;
  
  hr = p_IOleObject->InitFromData(p_data_object,tmp_f_creation,tmp_dw_reserved);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_get_clipboard_data(  /* [in] */ EIF_INTEGER dw_reserved,  /* [out] */ EIF_OBJECT pp_data_object )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_reserved = 0;
  tmp_dw_reserved = (ULONG)dw_reserved;
  ::IDataObject * * tmp_pp_data_object = 0;
  tmp_pp_data_object = (::IDataObject * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_246 (eif_access (pp_data_object), NULL);
  
  hr = p_IOleObject->GetClipboardData(tmp_dw_reserved,tmp_pp_data_object);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_246 ((::IDataObject * *)tmp_pp_data_object, pp_data_object);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_246 (tmp_pp_data_object);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_do_verb(  /* [in] */ EIF_INTEGER i_verb,  /* [in] */ ecom_control_library::tagMSG * lpmsg,  /* [in] */ ::IOleClientSite * p_active_site,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_POINTER hwnd_parent,  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG tmp_i_verb = 0;
  tmp_i_verb = (LONG)i_verb;
  LONG tmp_lindex = 0;
  tmp_lindex = (LONG)lindex;
  HWND tmp_hwnd_parent = 0;
  tmp_hwnd_parent = (HWND)hwnd_parent;
  
  hr = p_IOleObject->DoVerb(tmp_i_verb, (struct tagMSG *)lpmsg, p_active_site, tmp_lindex, tmp_hwnd_parent, (const struct tagRECT *)lprc_pos_rect);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
 

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_enum_verbs(  /* [out] */ EIF_OBJECT pp_enum_ole_verb )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ::IEnumOLEVERB * * tmp_pp_enum_ole_verb = 0;
  tmp_pp_enum_ole_verb = (::IEnumOLEVERB * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_180 (eif_access (pp_enum_ole_verb), NULL);
  
  hr = p_IOleObject->EnumVerbs(tmp_pp_enum_ole_verb);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_180 ((::IEnumOLEVERB * *)tmp_pp_enum_ole_verb, pp_enum_ole_verb);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_180 (tmp_pp_enum_ole_verb);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_update()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IOleObject->Update ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_is_up_to_date()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IOleObject->IsUpToDate ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_get_user_class_id(  /* [out] */ GUID * p_clsid )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IOleObject->GetUserClassID(p_clsid);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_get_user_type(  /* [in] */ EIF_INTEGER dw_form_of_type,  /* [out] */ EIF_OBJECT psz_user_type )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_form_of_type = 0;
  tmp_dw_form_of_type = (ULONG)dw_form_of_type;
  LPWSTR * tmp_psz_user_type = 0;
  tmp_psz_user_type = (LPWSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_247 (eif_access (psz_user_type), NULL);
  
  hr = p_IOleObject->GetUserType(tmp_dw_form_of_type,tmp_psz_user_type);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_247 ((LPWSTR *)tmp_psz_user_type, psz_user_type);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_247 (tmp_psz_user_type);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_set_extent(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ ecom_control_library::tagSIZEL * psizel )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_draw_aspect = 0;
  tmp_dw_draw_aspect = (ULONG)dw_draw_aspect;
  
  hr = p_IOleObject->SetExtent(tmp_dw_draw_aspect, (struct tagSIZE *)psizel);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_get_extent(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [out] */ ecom_control_library::tagSIZEL * psizel )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_draw_aspect = 0;
  tmp_dw_draw_aspect = (ULONG)dw_draw_aspect;
  
  hr = p_IOleObject->GetExtent(tmp_dw_draw_aspect, (struct tagSIZE *)psizel);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_advise(  /* [in] */ ::IAdviseSink * p_adv_sink,  /* [out] */ EIF_OBJECT pdw_connection )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG * tmp_pdw_connection = 0;
  tmp_pdw_connection = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_connection), NULL);
  
  hr = p_IOleObject->Advise(p_adv_sink,tmp_pdw_connection);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_connection, pdw_connection);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_250 (tmp_pdw_connection);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_unadvise(  /* [in] */ EIF_INTEGER dw_connection )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_connection = 0;
  tmp_dw_connection = (ULONG)dw_connection;
  
  hr = p_IOleObject->Unadvise(tmp_dw_connection);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_enum_advise(  /* [out] */ EIF_OBJECT ppenum_advise )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ::IEnumSTATDATA * * tmp_ppenum_advise = 0;
  tmp_ppenum_advise = (::IEnumSTATDATA * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_112 (eif_access (ppenum_advise), NULL);
  
  hr = p_IOleObject->EnumAdvise(tmp_ppenum_advise);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_112 ((::IEnumSTATDATA * *)tmp_ppenum_advise, ppenum_advise);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_112 (tmp_ppenum_advise);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_get_misc_status(  /* [in] */ EIF_INTEGER dw_aspect,  /* [out] */ EIF_OBJECT pdw_status )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_aspect = 0;
  tmp_dw_aspect = (ULONG)dw_aspect;
  ULONG * tmp_pdw_status = 0;
  tmp_pdw_status = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_status), NULL);
  
  hr = p_IOleObject->GetMiscStatus(tmp_dw_aspect,tmp_pdw_status);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_status, pdw_status);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_251 (tmp_pdw_status);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleObject_impl_proxy::ccom_set_color_scheme(  /* [in] */ ecom_control_library::tagLOGPALETTE * p_logpal )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleObject == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleObject_, (void **)&p_IOleObject);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IOleObject->SetColorScheme((struct tagLOGPALETTE *)p_logpal);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleObject_impl_proxy::ccom_item()

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
