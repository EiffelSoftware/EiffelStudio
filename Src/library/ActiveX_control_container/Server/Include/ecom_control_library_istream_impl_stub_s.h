/*-----------------------------------------------------------
Implemented `IStream' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISTREAM_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_ISTREAM_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IStream_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IStream_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IStream_impl_stub : public ecom_control_library::IStream
{
public:
  IStream_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IStream_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteRead(  /* [out] */ UCHAR * pv, /* [in] */ ULONG cb, /* [out] */ ULONG * pcb_read );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteWrite(  /* [in] */ UCHAR * pv, /* [in] */ ULONG cb, /* [out] */ ULONG * pcb_written );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteSeek(  /* [in] */ ecom_control_library::_LARGE_INTEGER dlib_move, /* [in] */ ULONG dw_origin, /* [out] */ ecom_control_library::_ULARGE_INTEGER * plib_new_position );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetSize(  /* [in] */ ecom_control_library::_ULARGE_INTEGER lib_new_size );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteCopyTo(  /* [in] */ ecom_control_library::IStream * pstm, /* [in] */ ecom_control_library::_ULARGE_INTEGER cb, /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_read, /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_written );


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
  STDMETHODIMP LockRegion(  /* [in] */ ecom_control_library::_ULARGE_INTEGER lib_offset, /* [in] */ ecom_control_library::_ULARGE_INTEGER cb, /* [in] */ ULONG dw_lock_type );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP UnlockRegion(  /* [in] */ ecom_control_library::_ULARGE_INTEGER lib_offset, /* [in] */ ecom_control_library::_ULARGE_INTEGER cb, /* [in] */ ULONG dw_lock_type );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg, /* [in] */ ULONG grf_stat_flag );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IStream * * ppstm );


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
