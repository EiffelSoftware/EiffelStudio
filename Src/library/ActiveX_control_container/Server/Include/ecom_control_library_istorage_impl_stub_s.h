/*-----------------------------------------------------------
Implemented `IStorage' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISTORAGE_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_ISTORAGE_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IStorage_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IStorage_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IStorage_impl_stub : public ecom_control_library::IStorage
{
public:
  IStorage_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IStorage_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP CreateStream(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ULONG grf_mode, /* [in] */ ULONG reserved1, /* [in] */ ULONG reserved2, /* [out] */ ecom_control_library::IStream * * ppstm );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteOpenStream(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ULONG cb_reserved1, /* [in] */ UCHAR * reserved1, /* [in] */ ULONG grf_mode, /* [in] */ ULONG reserved2, /* [out] */ ecom_control_library::IStream * * ppstm );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP CreateStorage(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ULONG grf_mode, /* [in] */ ULONG reserved1, /* [in] */ ULONG reserved2, /* [out] */ ecom_control_library::IStorage * * ppstg );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OpenStorage(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ecom_control_library::IStorage * pstg_priority, /* [in] */ ULONG grf_mode, /* [in] */ ecom_control_library::wireSNB snb_exclude, /* [in] */ ULONG reserved, /* [out] */ ecom_control_library::IStorage * * ppstg );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP CopyTo(  /* [in] */ ULONG ciid_exclude, /* [in] */ GUID * rgiid_exclude, /* [in] */ ecom_control_library::wireSNB snb_exclude, /* [in] */ ecom_control_library::IStorage * pstg_dest );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP MoveElementTo(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ecom_control_library::IStorage * pstg_dest, /* [in] */ LPWSTR pwcs_new_name, /* [in] */ ULONG grf_flags );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Commit(  /* [in] */ ULONG grf_commit_flags );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Revert( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteEnumElements(  /* [in] */ ULONG reserved1, /* [in] */ ULONG cb_reserved2, /* [in] */ UCHAR * reserved2, /* [in] */ ULONG reserved3, /* [out] */ ecom_control_library::IEnumSTATSTG * * ppenum );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DestroyElement(  /* [in] */ LPWSTR pwcs_name );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RenameElement(  /* [in] */ LPWSTR pwcs_old_name, /* [in] */ LPWSTR pwcs_new_name );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetElementTimes(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ecom_control_library::_FILETIME * pctime, /* [in] */ ecom_control_library::_FILETIME * patime, /* [in] */ ecom_control_library::_FILETIME * pmtime );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetClass(  /* [in] */ GUID * clsid );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetStateBits(  /* [in] */ ULONG grf_state_bits, /* [in] */ ULONG grf_mask );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg, /* [in] */ ULONG grf_stat_flag );


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
