/*-----------------------------------------------------------
Implemented `ITypeInfo_2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ITYPEINFO_2_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_ITYPEINFO_2_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ITypeInfo_2_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_ITypeInfo_2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ITypeInfo_2_impl_stub : public ecom_control_library::ITypeInfo_2
{
public:
  ITypeInfo_2_impl_stub (EIF_OBJECT eif_obj);
  virtual ~ITypeInfo_2_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetTypeAttr(  /* [out] */ ecom_control_library::tagTYPEATTR * * pp_type_attr, /* [out] */ ecom_control_library::DWORD1 * p_dummy );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetTypeComp(  /* [out] */ ecom_control_library::ITypeComp * * pp_tcomp );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetFuncDesc(  /* [in] */ UINT a_index, /* [out] */ ecom_control_library::tagFUNCDESC * * pp_func_desc, /* [out] */ ecom_control_library::DWORD1 * p_dummy );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetVarDesc(  /* [in] */ UINT a_index, /* [out] */ ecom_control_library::tagVARDESC * * pp_var_desc, /* [out] */ ecom_control_library::DWORD1 * p_dummy );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetNames(  /* [in] */ LONG memid, /* [out] */ BSTR * rg_bstr_names, /* [in] */ UINT c_max_names, /* [out] */ UINT * pc_names );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetRefTypeOfImplType(  /* [in] */ UINT a_index, /* [out] */ ULONG * p_ref_type );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetImplTypeFlags(  /* [in] */ UINT a_index, /* [out] */ INT * p_impl_type_flags );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LocalGetIDsOfNames( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LocalInvoke( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetDocumentation(  /* [in] */ LONG memid, /* [in] */ ULONG ref_ptr_flags, /* [out] */ BSTR * p_bstr_name, /* [out] */ BSTR * p_bstr_doc_string, /* [out] */ ULONG * pdw_help_context, /* [out] */ BSTR * p_bstr_help_file );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetDllEntry(  /* [in] */ LONG memid, /* [in] */ long invkind, /* [in] */ ULONG ref_ptr_flags, /* [out] */ BSTR * p_bstr_dll_name, /* [out] */ BSTR * p_bstr_name, /* [out] */ USHORT * pw_ordinal );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetRefTypeInfo(  /* [in] */ ULONG hreftype, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LocalAddressOfMember( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteCreateInstance(  /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetMops(  /* [in] */ LONG memid, /* [out] */ BSTR * p_bstr_mops );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetContainingTypeLib(  /* [out] */ ecom_control_library::ITypeLib_2 * * pp_tlib, /* [out] */ UINT * p_index );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LocalReleaseTypeAttr( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LocalReleaseFuncDesc( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP LocalReleaseVarDesc( void );


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
