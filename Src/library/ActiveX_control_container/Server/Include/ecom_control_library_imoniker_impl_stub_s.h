/*-----------------------------------------------------------
Implemented `IMoniker' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IMONIKER_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IMONIKER_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IMoniker_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IMoniker_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IMoniker_impl_stub : public ecom_control_library::IMoniker
{
public:
  IMoniker_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IMoniker_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IPersist_GetClassID(  /* [out] */ GUID * p_class_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IsDirty( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Load(  /* [in] */ ecom_control_library::IStream * pstm );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Save(  /* [in] */ ecom_control_library::IStream * pstm, /* [in] */ LONG f_clear_dirty );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetSizeMax(  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_size );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteBindToObject(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ GUID * riid_result, /* [out] */ IUnknown * * ppv_result );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteBindToStorage(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Reduce(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ULONG dw_reduce_how_far, /* [in, out] */ ecom_control_library::IMoniker * * ppmk_to_left, /* [out] */ ecom_control_library::IMoniker * * ppmk_reduced );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ComposeWith(  /* [in] */ ecom_control_library::IMoniker * pmk_right, /* [in] */ LONG f_only_if_not_generic, /* [out] */ ecom_control_library::IMoniker * * ppmk_composite );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Enum(  /* [in] */ LONG f_forward, /* [out] */ ecom_control_library::IEnumMoniker * * ppenum_moniker );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IsEqual(  /* [in] */ ecom_control_library::IMoniker * pmk_other_moniker );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Hash(  /* [out] */ ULONG * pdw_hash );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IsRunning(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ ecom_control_library::IMoniker * pmk_newly_running );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetTimeOfLastChange(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [out] */ ecom_control_library::_FILETIME * pfiletime );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Inverse(  /* [out] */ ecom_control_library::IMoniker * * ppmk );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP CommonPrefixWith(  /* [in] */ ecom_control_library::IMoniker * pmk_other, /* [out] */ ecom_control_library::IMoniker * * ppmk_prefix );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RelativePathTo(  /* [in] */ ecom_control_library::IMoniker * pmk_other, /* [out] */ ecom_control_library::IMoniker * * ppmk_rel_path );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [out] */ LPWSTR * ppsz_display_name );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ParseDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ LPWSTR psz_display_name, /* [out] */ ULONG * pch_eaten, /* [out] */ ecom_control_library::IMoniker * * ppmk_out );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IsSystemMoniker(  /* [out] */ ULONG * pdw_mksys );


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
