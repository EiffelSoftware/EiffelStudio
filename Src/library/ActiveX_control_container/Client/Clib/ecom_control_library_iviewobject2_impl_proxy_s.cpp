/*-----------------------------------------------------------
Implemented `IViewObject2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IViewObject2_impl_proxy_s.h"
static const IID IID_IViewObject2_ = {0x00000127,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IViewObject2_impl_proxy::IViewObject2_impl_proxy( IUnknown * a_pointer )
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

  p_IViewObject2 = NULL;
  hr = a_pointer->QueryInterface(IID_IViewObject2_, (void **)&p_IViewObject2);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IViewObject2_impl_proxy::~IViewObject2_impl_proxy()
{
  p_unknown->Release ();
  if (p_IViewObject2!=NULL)
    p_IViewObject2->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObject2_impl_proxy::ccom_draw(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_INTEGER pv_aspect,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [in] */ EIF_INTEGER hdc_target_dev,  /* [in] */ EIF_INTEGER hdc_draw,  /* [in] */ ecom_control_library::_RECTL * lprc_bounds,  /* [in] */ ecom_control_library::_RECTL * lprc_wbounds )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObject2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObject2_, (void **)&p_IViewObject2);
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
  
  hr = p_IViewObject2->Draw(tmp_dw_draw_aspect, tmp_lindex, (void*)tmp_pv_aspect, (DVTARGETDEVICE * )ptd, (HDC)tmp_hdc_target_dev, (HDC)tmp_hdc_draw, (const LPRECTL)lprc_bounds, (const LPRECTL)lprc_wbounds, NULL, 0);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObject2_impl_proxy::ccom_get_color_set(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_INTEGER pv_aspect,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [in] */ EIF_INTEGER hic_target_dev,  /* [out] */ EIF_OBJECT pp_color_set )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObject2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObject2_, (void **)&p_IViewObject2);
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
  
  hr = p_IViewObject2->GetColorSet(tmp_dw_draw_aspect, tmp_lindex, (void *)tmp_pv_aspect, (DVTARGETDEVICE *)ptd, (HDC)tmp_hic_target_dev, (LOGPALETTE **)tmp_pp_color_set);
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

void ecom_control_library::IViewObject2_impl_proxy::ccom_freeze(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_INTEGER pv_aspect,  /* [out] */ EIF_OBJECT pdw_freeze )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObject2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObject2_, (void **)&p_IViewObject2);
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
  
  hr = p_IViewObject2->Freeze(tmp_dw_draw_aspect, tmp_lindex, (void*)tmp_pv_aspect, tmp_pdw_freeze);
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

void ecom_control_library::IViewObject2_impl_proxy::ccom_unfreeze(  /* [in] */ EIF_INTEGER dw_freeze )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObject2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObject2_, (void **)&p_IViewObject2);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_freeze = 0;
  tmp_dw_freeze = (ULONG)dw_freeze;
  
  hr = p_IViewObject2->Unfreeze(tmp_dw_freeze);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObject2_impl_proxy::ccom_set_advise(  /* [in] */ EIF_INTEGER aspects,  /* [in] */ EIF_INTEGER advf,  /* [in] */ ::IAdviseSink * p_adv_sink )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObject2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObject2_, (void **)&p_IViewObject2);
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
  
  hr = p_IViewObject2->SetAdvise(tmp_aspects,tmp_advf,p_adv_sink);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IViewObject2_impl_proxy::ccom_get_advise(  /* [out] */ EIF_OBJECT p_aspects,  /* [out] */ EIF_OBJECT p_advf,  /* [out] */ EIF_OBJECT pp_adv_sink )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObject2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObject2_, (void **)&p_IViewObject2);
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
  
  hr = p_IViewObject2->GetAdvise(tmp_p_aspects,tmp_p_advf,tmp_pp_adv_sink);
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

void ecom_control_library::IViewObject2_impl_proxy::ccom_get_extent(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [out] */ ecom_control_library::tagSIZEL * lpsizel )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IViewObject2 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IViewObject2_, (void **)&p_IViewObject2);
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
  
  hr = p_IViewObject2->GetExtent(tmp_dw_draw_aspect, tmp_lindex, (DVTARGETDEVICE *)ptd, (struct tagSIZE *)lpsizel);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IViewObject2_impl_proxy::ccom_item()

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
