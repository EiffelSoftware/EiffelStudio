/*-----------------------------------------------------------
Implemented `IViewObjectEx' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IViewObjectEx_impl_proxy_s.h"
static const IID IID_IViewObjectEx_ = {0x3af24292,0x0c96,0x11ce,{0xa0,0xcf,0x00,0xaa,0x00,0x60,0x0a,0xb8}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IViewObjectEx_impl_proxy::IViewObjectEx_impl_proxy( IUnknown * a_pointer )
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

  hr = a_pointer->QueryInterface(IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IViewObjectEx_impl_proxy::~IViewObjectEx_impl_proxy()
{
  p_unknown->Release ();
  if (p_IViewObjectEx!=NULL)
    p_IViewObjectEx->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_draw(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_INTEGER pv_aspect,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [in] */ EIF_INTEGER hdc_target_dev,  /* [in] */ EIF_INTEGER hdc_draw,  /* [in] */ ecom_control_library::_RECTL * lprc_bounds,  /* [in] */ ecom_control_library::_RECTL * lprc_wbounds )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_draw_aspect = 0;
  tmp_dw_draw_aspect = (ULONG)dw_draw_aspect;
  LONG tmp_lindex = 0;
  tmp_lindex = (LONG)lindex;
  ULONG tmp_pv_aspect = 0;
  tmp_pv_aspect = (ULONG)pv_aspect;
  ULONG tmp_hdc_target_dev = 0;
  tmp_hdc_target_dev = (ULONG)hdc_target_dev;
  ULONG tmp_hdc_draw = 0;
  tmp_hdc_draw = (ULONG)hdc_draw;
  
  hr = p_IViewObjectEx->Draw(tmp_dw_draw_aspect, tmp_lindex, (void*)tmp_pv_aspect, (DVTARGETDEVICE *)ptd, (HDC)tmp_hdc_target_dev, (HDC)tmp_hdc_draw, (const LPRECTL)lprc_bounds, (const LPRECTL)lprc_wbounds, NULL, 0);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_get_color_set(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_INTEGER pv_aspect,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [in] */ EIF_INTEGER hic_target_dev,  /* [out] */ EIF_OBJECT pp_color_set )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_draw_aspect = 0;
  tmp_dw_draw_aspect = (ULONG)dw_draw_aspect;
  LONG tmp_lindex = 0;
  tmp_lindex = (LONG)lindex;
  ULONG tmp_pv_aspect = 0;
  tmp_pv_aspect = (ULONG)pv_aspect;
  ULONG tmp_hic_target_dev = 0;
  tmp_hic_target_dev = (ULONG)hic_target_dev;
  ecom_control_library::tagLOGPALETTE * * tmp_pp_color_set = 0;
  tmp_pp_color_set = (ecom_control_library::tagLOGPALETTE * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_384 (eif_access (pp_color_set), NULL);
  
  hr = p_IViewObjectEx->GetColorSet(tmp_dw_draw_aspect, tmp_lindex, (void *)tmp_pv_aspect, (DVTARGETDEVICE *)ptd, (HDC)tmp_hic_target_dev, (LOGPALETTE **)tmp_pp_color_set);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_384 ((ecom_control_library::tagLOGPALETTE * *)tmp_pp_color_set, pp_color_set);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_384 (tmp_pp_color_set);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_freeze(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_INTEGER pv_aspect,  /* [out] */ EIF_OBJECT pdw_freeze )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_draw_aspect = 0;
  tmp_dw_draw_aspect = (ULONG)dw_draw_aspect;
  LONG tmp_lindex = 0;
  tmp_lindex = (LONG)lindex;
  ULONG tmp_pv_aspect = 0;
  tmp_pv_aspect = (ULONG)pv_aspect;
  ULONG * tmp_pdw_freeze = 0;
  tmp_pdw_freeze = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_freeze), NULL);
  
  hr = p_IViewObjectEx->Freeze(tmp_dw_draw_aspect, tmp_lindex, (void *)tmp_pv_aspect, tmp_pdw_freeze);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_freeze, pdw_freeze);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_385 (tmp_pdw_freeze);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_unfreeze(  /* [in] */ EIF_INTEGER dw_freeze )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_freeze = 0;
  tmp_dw_freeze = (ULONG)dw_freeze;
  
  hr = p_IViewObjectEx->Unfreeze(tmp_dw_freeze);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_set_advise(  /* [in] */ EIF_INTEGER aspects,  /* [in] */ EIF_INTEGER advf,  /* [in] */ ::IAdviseSink * p_adv_sink )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_aspects = 0;
  tmp_aspects = (ULONG)aspects;
  ULONG tmp_advf = 0;
  tmp_advf = (ULONG)advf;
  
  hr = p_IViewObjectEx->SetAdvise(tmp_aspects,tmp_advf,p_adv_sink);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_get_advise(  /* [out] */ EIF_OBJECT p_aspects,  /* [out] */ EIF_OBJECT p_advf,  /* [out] */ EIF_OBJECT pp_adv_sink )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG * tmp_p_aspects = 0;
  tmp_p_aspects = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_aspects), NULL);
  ULONG * tmp_p_advf = 0;
  tmp_p_advf = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_advf), NULL);
  ::IAdviseSink * * tmp_pp_adv_sink = 0;
  tmp_pp_adv_sink = (::IAdviseSink * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_388 (eif_access (pp_adv_sink), NULL);
  
  hr = p_IViewObjectEx->GetAdvise(tmp_p_aspects,tmp_p_advf,tmp_pp_adv_sink);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_p_aspects, p_aspects);
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_p_advf, p_advf);
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_388 ((::IAdviseSink * *)tmp_pp_adv_sink, pp_adv_sink);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_386 (tmp_p_aspects);
grt_ce_control_interfaces2.ccom_free_memory_pointed_387 (tmp_p_advf);
grt_ce_control_interfaces2.ccom_free_memory_pointed_388 (tmp_pp_adv_sink);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_get_extent(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [out] */ ecom_control_library::tagSIZEL * lpsizel )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_draw_aspect = 0;
  tmp_dw_draw_aspect = (ULONG)dw_draw_aspect;
  LONG tmp_lindex = 0;
  tmp_lindex = (LONG)lindex;
  
  hr = p_IViewObjectEx->GetExtent(tmp_dw_draw_aspect, tmp_lindex, (DVTARGETDEVICE *)ptd, (LPSIZEL)lpsizel);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_get_rect(  /* [in] */ EIF_INTEGER dw_aspect,  /* [out] */ ecom_control_library::_RECTL * p_rect )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_aspect = 0;
  tmp_dw_aspect = (ULONG)dw_aspect;
  
  hr = p_IViewObjectEx->GetRect(tmp_dw_aspect, (LPRECTL)p_rect);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_get_view_status(  /* [out] */ EIF_OBJECT pdw_status )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG * tmp_pdw_status = 0;
  tmp_pdw_status = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_status), NULL);
  
  hr = p_IViewObjectEx->GetViewStatus(tmp_pdw_status);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_status, pdw_status);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_389 (tmp_pdw_status);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_query_hit_point(  /* [in] */ EIF_INTEGER dw_aspect,  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds,  /* [in] */ ecom_control_library::tagPOINT * ptl_loc,  /* [in] */ EIF_INTEGER l_close_hint,  /* [out] */ EIF_OBJECT p_hit_result )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_aspect = 0;
  tmp_dw_aspect = (ULONG)dw_aspect;
  LONG tmp_l_close_hint = 0;
  tmp_l_close_hint = (LONG)l_close_hint;
  ULONG * tmp_p_hit_result = 0;
  tmp_p_hit_result = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_hit_result), NULL);
  
  hr = p_IViewObjectEx->QueryHitPoint(tmp_dw_aspect, (LPRECT)p_rect_bounds, *(POINT *)ptl_loc, tmp_l_close_hint, tmp_p_hit_result);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_p_hit_result, p_hit_result);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_390 (tmp_p_hit_result);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_query_hit_rect(  /* [in] */ EIF_INTEGER dw_aspect,  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds,  /* [in] */ ecom_control_library::tagRECT * p_rect_loc,  /* [in] */ EIF_INTEGER l_close_hint,  /* [out] */ EIF_OBJECT p_hit_result )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_aspect = 0;
  tmp_dw_aspect = (ULONG)dw_aspect;
  LONG tmp_l_close_hint = 0;
  tmp_l_close_hint = (LONG)l_close_hint;
  ULONG * tmp_p_hit_result = 0;
  tmp_p_hit_result = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_hit_result), NULL);
  
  hr = p_IViewObjectEx->QueryHitRect(tmp_dw_aspect, (LPRECT)p_rect_bounds, (LPRECT)p_rect_loc, tmp_l_close_hint, tmp_p_hit_result);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_p_hit_result, p_hit_result);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_391 (tmp_p_hit_result);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObjectEx_impl_proxy::ccom_get_natural_extent(  /* [in] */ EIF_INTEGER dw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [in] */ EIF_POINTER hic_target_dev,  /* [in] */ ecom_control_library::tagExtentInfo * p_extent_info,  /* [out] */ ecom_control_library::tagSIZEL * psizel )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObjectEx == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObjectEx_, (void **)&p_IViewObjectEx);
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
  HDC tmp_hic_target_dev = 0;
  tmp_hic_target_dev = (HDC)hic_target_dev;
  
  hr = p_IViewObjectEx->GetNaturalExtent(tmp_dw_aspect, tmp_lindex, (DVTARGETDEVICE* )ptd, tmp_hic_target_dev, (DVEXTENTINFO*)p_extent_info, (LPSIZEL)psizel);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  grt_ce_control_interfaces2.free_memory_232 (tmp_hic_target_dev);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IViewObjectEx_impl_proxy::ccom_item()

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
