/*-----------------------------------------------------------
Implemented `IViewObject2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IVIEWOBJECT2_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IVIEWOBJECT2_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IViewObject2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IViewObject2_s.h"

#include "ecom_control_library_tagDVTARGETDEVICE_s.h"

#include "ecom_control_library__RECTL_s.h"

#include "ecom_control_library_IContinue_s.h"

#include "ecom_control_library_tagLOGPALETTE_s.h"

#include "ecom_control_library_IAdviseSink_s.h"

#include "ecom_control_library_tagSIZEL_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IViewObject2_impl_proxy
{
public:
  IViewObject2_impl_proxy (IUnknown * a_pointer);
  virtual ~IViewObject2_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_draw(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_INTEGER pv_aspect,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [in] */ EIF_INTEGER hdc_target_dev,  /* [in] */ EIF_INTEGER hdc_draw,  /* [in] */ ecom_control_library::_RECTL * lprc_bounds,  /* [in] */ ecom_control_library::_RECTL * lprc_wbounds,  /* [in] */ ecom_control_library::IContinue * p_continue );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_color_set(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_INTEGER pv_aspect,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [in] */ EIF_INTEGER hic_target_dev,  /* [out] */ EIF_OBJECT pp_color_set );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_freeze(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_INTEGER pv_aspect,  /* [out] */ EIF_OBJECT pdw_freeze );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_unfreeze(  /* [in] */ EIF_INTEGER dw_freeze );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_set_advise(  /* [in] */ EIF_INTEGER aspects,  /* [in] */ EIF_INTEGER advf,  /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_advise(  /* [out] */ EIF_OBJECT p_aspects,  /* [out] */ EIF_OBJECT p_advf,  /* [out] */ EIF_OBJECT pp_adv_sink );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_extent(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd,  /* [out] */ ecom_control_library::tagSIZEL * lpsizel );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ecom_control_library::IViewObject2 * p_IViewObject2;


  /*-----------------------------------------------------------
  Default IUnknown interface pointer
  -----------------------------------------------------------*/
  IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
