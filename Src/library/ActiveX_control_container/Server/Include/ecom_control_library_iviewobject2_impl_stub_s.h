/*-----------------------------------------------------------
Implemented `IViewObject2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IVIEWOBJECT2_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IVIEWOBJECT2_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IViewObject2_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IViewObject2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IViewObject2_impl_stub : public ecom_control_library::IViewObject2
{
public:
  IViewObject2_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IViewObject2_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteDraw(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ULONG hdc_target_dev, /* [in] */ ULONG hdc_draw, /* [in] */ ecom_control_library::_RECTL * lprc_bounds, /* [in] */ ecom_control_library::_RECTL * lprc_wbounds, /* [in] */ ecom_control_library::IContinue * p_continue );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetColorSet(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ULONG hic_target_dev, /* [out] */ ecom_control_library::tagLOGPALETTE * * pp_color_set );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteFreeze(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [out] */ ULONG * pdw_freeze );


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
  STDMETHODIMP RemoteGetAdvise(  /* [out] */ ULONG * p_aspects, /* [out] */ ULONG * p_advf, /* [out] */ ecom_control_library::IAdviseSink * * pp_adv_sink );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IViewObject2_GetExtent(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [out] */ ecom_control_library::tagSIZEL * lpsizel );


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
