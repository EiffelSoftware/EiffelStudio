/*-----------------------------------------------------------
Implemented `IViewObjectEx' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IVIEWOBJECTEX_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IVIEWOBJECTEX_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IViewObjectEx_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IViewObjectEx_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IViewObjectEx_impl_stub : public ecom_control_library::IViewObjectEx
{
public:
  IViewObjectEx_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IViewObjectEx_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Draw(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ULONG hdc_target_dev, /* [in] */ ULONG hdc_draw, /* [in] */ ecom_control_library::_RECTL * lprc_bounds, /* [in] */ ecom_control_library::_RECTL * lprc_wbounds, /* [in] */ ecom_control_library::IContinue * p_continue );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetColorSet(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ULONG hic_target_dev, /* [out] */ ecom_control_library::tagLOGPALETTE * * pp_color_set );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Freeze(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [out] */ ULONG * pdw_freeze );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Unfreeze(  /* [in] */ ULONG dw_freeze );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetAdvise(  /* [in] */ ULONG aspects, /* [in] */ ULONG advf, /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetAdvise(  /* [out] */ ULONG * p_aspects, /* [out] */ ULONG * p_advf, /* [out] */ ecom_control_library::IAdviseSink * * pp_adv_sink );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IViewObject2_GetExtent(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [out] */ ecom_control_library::tagSIZEL * lpsizel );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetRect(  /* [in] */ ULONG dw_aspect, /* [out] */ ecom_control_library::_RECTL * p_rect );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetViewStatus(  /* [out] */ ULONG * pdw_status );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP QueryHitPoint(  /* [in] */ ULONG dw_aspect, /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ ecom_control_library::tagPOINT ptl_loc, /* [in] */ LONG l_close_hint, /* [out] */ ULONG * p_hit_result );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP QueryHitRect(  /* [in] */ ULONG dw_aspect, /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ ecom_control_library::tagRECT * p_rect_loc, /* [in] */ LONG l_close_hint, /* [out] */ ULONG * p_hit_result );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetNaturalExtent(  /* [in] */ ULONG dw_aspect, /* [in] */ LONG lindex, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ecom_control_library::wireHDC hic_target_dev, /* [in] */ ecom_control_library::tagExtentInfo * p_extent_info, /* [out] */ ecom_control_library::tagSIZEL * psizel );


  /*-----------------------------------------------------------
  Decrement reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) Release();


  /*-----------------------------------------------------------
  Increment reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) AddRef();


  /*-----------------------------------------------------------
  Query Interface
  -----------------------------------------------------------*/
  STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
  /*-----------------------------------------------------------
  Reference counter
  -----------------------------------------------------------*/
  LONG ref_count;


  /*-----------------------------------------------------------
  Corresponding Eiffel object
  -----------------------------------------------------------*/
  EIF_OBJECT eiffel_object;


  /*-----------------------------------------------------------
  Eiffel type id
  -----------------------------------------------------------*/
  EIF_TYPE_ID type_id;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
