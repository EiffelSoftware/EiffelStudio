/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ITYPELIB_2_S_H__
#define __ECOM_CONTROL_LIBRARY_ITYPELIB_2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_ITypeLib_2_FWD_DEFINED__
#define __ecom_control_library_ITypeLib_2_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeLib_2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagTLIBATTR_s.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_ITypeInfo_2_FWD_DEFINED__
#define __ecom_control_library_ITypeInfo_2_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeInfo_2;
}
#endif



#ifndef __ecom_control_library_ITypeComp_FWD_DEFINED__
#define __ecom_control_library_ITypeComp_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeComp;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_ITypeLib_2_INTERFACE_DEFINED__
#define __ecom_control_library_ITypeLib_2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class ITypeLib_2 : public IUnknown
{
public:
  ITypeLib_2 () {};
  ~ITypeLib_2 () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetTypeInfoCount(  /* [out] */ UINT * pc_tinfo ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP a_GetTypeInfo(  /* [in] */ UINT a_index, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetTypeInfoType(  /* [in] */ UINT a_index, /* [out] */ long * p_tkind ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetTypeInfoOfGuid(  /* [in] */ GUID * guid, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetLibAttr(  /* [out] */ ecom_control_library::tagTLIBATTR * * pp_tlib_attr, /* [out] */ ecom_control_library::DWORD1 * p_dummy ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetTypeComp(  /* [out] */ ecom_control_library::ITypeComp * * pp_tcomp ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetDocumentation(  /* [in] */ INT a_index, /* [in] */ ULONG ref_ptr_flags, /* [out] */ BSTR * p_bstr_name, /* [out] */ BSTR * p_bstr_doc_string, /* [out] */ ULONG * pdw_help_context, /* [out] */ BSTR * p_bstr_help_file ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP IsName(  /* [in] */ LPWSTR sz_name_buf, /* [in] */ ULONG l_hash_val, /* [out] */ LONG * pf_name, /* [out] */ BSTR * p_bstr_lib_name ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP FindName(  /* [in] */ LPWSTR sz_name_buf, /* [in] */ ULONG l_hash_val, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo, /* [out] */ LONG * rg_mem_id, /* [in, out] */ USHORT * pc_found, /* [out] */ BSTR * p_bstr_lib_name ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP LocalReleaseTLibAttr( void ) = 0;



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
