/*-----------------------------------------------------------
Implemented `ITypeComp' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ITYPECOMP_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_ITYPECOMP_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ITypeComp_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_ITypeComp_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ITypeComp_impl_stub : public ecom_control_library::ITypeComp
{
public:
  ITypeComp_impl_stub (EIF_OBJECT eif_obj);
  virtual ~ITypeComp_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteBind(  /* [in] */ LPWSTR sz_name, /* [in] */ ULONG l_hash_val, /* [in] */ USHORT w_flags, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo, /* [out] */ long * p_desc_kind, /* [out] */ ecom_control_library::tagFUNCDESC * * pp_func_desc, /* [out] */ ecom_control_library::tagVARDESC * * pp_var_desc, /* [out] */ ecom_control_library::ITypeComp * * pp_type_comp, /* [out] */ ecom_control_library::DWORD1 * p_dummy );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteBindType(  /* [in] */ LPWSTR sz_name, /* [in] */ ULONG l_hash_val, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo );


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
