/*-----------------------------------------------------------
Implemented `ITypeLib_2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ITYPELIB_2_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_ITYPELIB_2_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ITypeLib_2_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_ITypeLib_2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ITypeLib_2_impl_stub : public ecom_control_library::ITypeLib_2
{
public:
  ITypeLib_2_impl_stub (EIF_OBJECT eif_obj);
  virtual ~ITypeLib_2_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetTypeInfoCount(  /* [out] */ UINT * pc_tinfo );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP a_GetTypeInfo(  /* [in] */ UINT a_index, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetTypeInfoType(  /* [in] */ UINT a_index, /* [out] */ long * p_tkind );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetTypeInfoOfGuid(  /* [in] */ GUID * guid, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetLibAttr(  /* [out] */ ecom_control_library::tagTLIBATTR * * pp_tlib_attr, /* [out] */ ecom_control_library::DWORD1 * p_dummy );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetTypeComp(  /* [out] */ ecom_control_library::ITypeComp * * pp_tcomp );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetDocumentation(  /* [in] */ INT a_index, /* [in] */ ULONG ref_ptr_flags, /* [out] */ BSTR * p_bstr_name, /* [out] */ BSTR * p_bstr_doc_string, /* [out] */ ULONG * pdw_help_context, /* [out] */ BSTR * p_bstr_help_file );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteIsName(  /* [in] */ LPWSTR sz_name_buf, /* [in] */ ULONG l_hash_val, /* [out] */ LONG * pf_name, /* [out] */ BSTR * p_bstr_lib_name );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteFindName(  /* [in] */ LPWSTR sz_name_buf, /* [in] */ ULONG l_hash_val, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo, /* [out] */ LONG * rg_mem_id, /* [in, out] */ USHORT * pc_found, /* [out] */ BSTR * p_bstr_lib_name );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LocalReleaseTLibAttr( void );


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
