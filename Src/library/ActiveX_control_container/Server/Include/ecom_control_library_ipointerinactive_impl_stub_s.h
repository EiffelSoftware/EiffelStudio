/*-----------------------------------------------------------
Implemented `IPointerInactive' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPOINTERINACTIVE_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IPOINTERINACTIVE_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPointerInactive_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IPointerInactive_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPointerInactive_impl_stub : public ecom_control_library::IPointerInactive
{
public:
  IPointerInactive_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IPointerInactive_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetActivationPolicy(  /* [out] */ ULONG * pdw_policy );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnInactiveMouseMove(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ LONG x, /* [in] */ LONG y, /* [in] */ ULONG grf_key_state );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnInactiveSetCursor(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ LONG x, /* [in] */ LONG y, /* [in] */ ULONG dw_mouse_msg, /* [in] */ LONG f_set_always );


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
