/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IVIEWOBJECT_S_H__
#define __ECOM_CONTROL_LIBRARY_IVIEWOBJECT_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IViewObject_FWD_DEFINED__
#define __ecom_control_library_IViewObject_FWD_DEFINED__
namespace ecom_control_library
{
class IViewObject;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagDVTARGETDEVICE_s.h"

#include "ecom_control_library__RECTL_s.h"

#include "ecom_control_library_tagLOGPALETTE_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IContinue_FWD_DEFINED__
#define __ecom_control_library_IContinue_FWD_DEFINED__
namespace ecom_control_library
{
class IContinue;
}
#endif



#ifndef __ecom_control_library_IAdviseSink_FWD_DEFINED__
#define __ecom_control_library_IAdviseSink_FWD_DEFINED__
namespace ecom_control_library
{
class IAdviseSink;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IViewObject_INTERFACE_DEFINED__
#define __ecom_control_library_IViewObject_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IViewObject : public IUnknown
{
public:
  IViewObject () {};
  ~IViewObject () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Draw(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ULONG hdc_target_dev, /* [in] */ ULONG hdc_draw, /* [in] */ ecom_control_library::_RECTL * lprc_bounds, /* [in] */ ecom_control_library::_RECTL * lprc_wbounds, /* [in] */ ecom_control_library::IContinue * p_continue ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetColorSet(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ULONG hic_target_dev, /* [out] */ ecom_control_library::tagLOGPALETTE * * pp_color_set ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Freeze(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ULONG pv_aspect, /* [out] */ ULONG * pdw_freeze ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Unfreeze(  /* [in] */ ULONG dw_freeze ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP SetAdvise(  /* [in] */ ULONG aspects, /* [in] */ ULONG advf, /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetAdvise(  /* [out] */ ULONG * p_aspects, /* [out] */ ULONG * p_advf, /* [out] */ ecom_control_library::IAdviseSink * * pp_adv_sink ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif
