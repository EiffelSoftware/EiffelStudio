/*-----------------------------------------------------------
Implemented `IOleControl' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECONTROL_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECONTROL_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleControl_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleControl_s.h"

#include "ecom_control_library_tagCONTROLINFO_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleControl_impl_proxy
{
public:
  IOleControl_impl_proxy (IUnknown * a_pointer);
  virtual ~IOleControl_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_control_info(  /* [out] */ ecom_control_library::tagCONTROLINFO * p_ci );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_mnemonic(  /* [in] */ ecom_control_library::tagMSG * p_msg );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_ambient_property_change(  /* [in] */ EIF_INTEGER disp_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_freeze_events(  /* [in] */ EIF_INTEGER b_freeze );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IOleControl * p_IOleControl;


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
