/*-----------------------------------------------------------
Implemented `IDocHostUIHandler' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDocHostUIHandler_impl_proxy_s.h"
static const IID IID_IDocHostUIHandler_ = {0xbd3f23c0,0xd43e,0x11cf,{0x89,0x3b,0x00,0xaa,0x00,0xbd,0xce,0x1a}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDocHostUIHandler_impl_proxy::IDocHostUIHandler_impl_proxy( IUnknown * a_pointer )
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

  hr = a_pointer->QueryInterface(IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDocHostUIHandler_impl_proxy::~IDocHostUIHandler_impl_proxy()
{
  p_unknown->Release ();
  if (p_IDocHostUIHandler!=NULL)
    p_IDocHostUIHandler->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_show_context_menu(  /* [in] */ EIF_INTEGER dw_id,  /* [in] */ ecom_control_library::tagPOINT * ppt,  /* [in] */ IUnknown * pcmdt_reserved,  /* [in] */ IDispatch * pdisp_reserved )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_id = 0;
  tmp_dw_id = (ULONG)dw_id;
  
  hr = p_IDocHostUIHandler->ShowContextMenu(tmp_dw_id,(struct tagPOINT *)ppt,pcmdt_reserved,pdisp_reserved);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_get_host_info(  /* [in, out] */ ecom_control_library::_DOCHOSTUIINFO * p_info )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
    if (FAILED (hr))
    {
      if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
        com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
      com_eraise (f.c_format_message (hr), EN_PROG);
    };
  };
  
  hr = p_IDocHostUIHandler->GetHostInfo((struct _DOCHOSTUIINFO *)p_info);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_show_ui(  /* [in] */ EIF_INTEGER dw_id,  /* [in] */ ::IOleInPlaceActiveObject * p_active_object,  /* [in] */ ::IOleCommandTarget * p_command_target,  /* [in] */ ::IOleInPlaceFrame * p_frame,  /* [in] */ ::IOleInPlaceUIWindow * p_doc )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_id = 0;
  tmp_dw_id = (ULONG)dw_id;
  
  hr = p_IDocHostUIHandler->ShowUI(tmp_dw_id,p_active_object,p_command_target,p_frame,p_doc);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_hide_ui()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IDocHostUIHandler->HideUI ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_update_ui()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IDocHostUIHandler->UpdateUI ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_enable_modeless(  /* [in] */ EIF_INTEGER f_enable )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG tmp_f_enable = 0;
  tmp_f_enable = (LONG)f_enable;
  
  hr = p_IDocHostUIHandler->EnableModeless(tmp_f_enable);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_on_doc_window_activate(  /* [in] */ EIF_INTEGER f_activate )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG tmp_f_activate = 0;
  tmp_f_activate = (LONG)f_activate;
  
  hr = p_IDocHostUIHandler->OnDocWindowActivate(tmp_f_activate);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_on_frame_window_activate(  /* [in] */ EIF_INTEGER f_activate )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG tmp_f_activate = 0;
  tmp_f_activate = (LONG)f_activate;
  
  hr = p_IDocHostUIHandler->OnFrameWindowActivate(tmp_f_activate);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_resize_border(  /* [in] */ ecom_control_library::tagRECT * prc_border,  /* [in] */ ::IOleInPlaceUIWindow * p_uiwindow,  /* [in] */ EIF_INTEGER f_rame_window )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG tmp_f_rame_window = 0;
  tmp_f_rame_window = (LONG)f_rame_window;
  
  hr = p_IDocHostUIHandler->ResizeBorder((const struct tagRECT *)prc_border,p_uiwindow,tmp_f_rame_window);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_translate_accelerator(  /* [in] */ ecom_control_library::tagMSG * lpmsg,  /* [in] */ GUID * pguid_cmd_group,  /* [in] */ EIF_INTEGER n_cmd_id )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_n_cmd_id = 0;
  tmp_n_cmd_id = (ULONG)n_cmd_id;
  
  hr = p_IDocHostUIHandler->TranslateAccelerator((struct tagMSG *)lpmsg, pguid_cmd_group, tmp_n_cmd_id);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_get_option_key_path(  /* [out] */ EIF_OBJECT pch_key,  /* [in] */ EIF_INTEGER dw )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LPWSTR * tmp_pch_key = 0;
  tmp_pch_key = (LPWSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_458 (eif_access (pch_key), NULL);
  ULONG tmp_dw = 0;
  tmp_dw = (ULONG)dw;
  
  hr = p_IDocHostUIHandler->GetOptionKeyPath(tmp_pch_key,tmp_dw);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_458 ((LPWSTR *)tmp_pch_key, pch_key);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_458 (tmp_pch_key);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_get_drop_target(  /* [in] */ ::IDropTarget * p_drop_target,  /* [out] */ EIF_OBJECT pp_drop_target )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ::IDropTarget * * tmp_pp_drop_target = 0;
  tmp_pp_drop_target = (::IDropTarget * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_223 (eif_access (pp_drop_target), NULL);
  
  hr = p_IDocHostUIHandler->GetDropTarget(p_drop_target,tmp_pp_drop_target);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_223 ((::IDropTarget * *)tmp_pp_drop_target, pp_drop_target);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_223 (tmp_pp_drop_target);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_get_external(  /* [out] */ EIF_OBJECT pp_dispatch )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  IDispatch * * tmp_pp_dispatch = 0;
  tmp_pp_dispatch = (IDispatch * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_459 (eif_access (pp_dispatch), NULL);
  
  hr = p_IDocHostUIHandler->GetExternal(tmp_pp_dispatch);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_459 ((IDispatch * *)tmp_pp_dispatch, pp_dispatch);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_459 (tmp_pp_dispatch);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_translate_url(  /* [in] */ EIF_INTEGER dw_translate,  /* [in] */ EIF_OBJECT pch_urlin,  /* [out] */ EIF_OBJECT ppch_urlout )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_translate = 0;
  tmp_dw_translate = (ULONG)dw_translate;
  OLECHAR * tmp_pch_urlin = 0;
  tmp_pch_urlin = (OLECHAR *)rt_ec.ccom_ec_lpwstr (eif_access (pch_urlin), NULL);
  OLECHAR * * tmp_ppch_urlout = 0;
  tmp_ppch_urlout = (OLECHAR * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_462 (eif_access (ppch_urlout), NULL);
  
  hr = p_IDocHostUIHandler->TranslateUrl(tmp_dw_translate,tmp_pch_urlin,tmp_ppch_urlout);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_462 ((OLECHAR * *)tmp_ppch_urlout, ppch_urlout);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_461 (tmp_pch_urlin);
grt_ce_control_interfaces2.ccom_free_memory_pointed_462 (tmp_ppch_urlout);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_filter_data_object(  /* [in] */ ::IDataObject * p_do,  /* [out] */ EIF_OBJECT pp_doret )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IDocHostUIHandler == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IDocHostUIHandler_, (void **)&p_IDocHostUIHandler);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ::IDataObject * * tmp_pp_doret = 0;
  tmp_pp_doret = (::IDataObject * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_246 (eif_access (pp_doret), NULL);
  
  hr = p_IDocHostUIHandler->FilterDataObject(p_do,tmp_pp_doret);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_246 ((::IDataObject * *)tmp_pp_doret, pp_doret);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_246 (tmp_pp_doret);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IDocHostUIHandler_impl_proxy::ccom_item()

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
