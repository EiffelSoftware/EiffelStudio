/*-----------------------------------------------------------
Implemented `IDropTarget' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDROPTARGET_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IDROPTARGET_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDropTarget_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IDropTarget_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDropTarget_impl_stub : public ecom_control_library::IDropTarget
{
public:
  IDropTarget_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IDropTarget_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DragEnter(  /* [in] */ ecom_control_library::IDataObject * p_data_obj, /* [in] */ ULONG grf_key_state, /* [in] */ ecom_control_library::_POINTL pt, /* [in, out] */ ULONG * pdw_effect );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DragOver(  /* [in] */ ULONG grf_key_state, /* [in] */ ecom_control_library::_POINTL pt, /* [in, out] */ ULONG * pdw_effect );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DragLeave( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Drop(  /* [in] */ ecom_control_library::IDataObject * p_data_obj, /* [in] */ ULONG grf_key_state, /* [in] */ ecom_control_library::_POINTL pt, /* [in, out] */ ULONG * pdw_effect );


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
