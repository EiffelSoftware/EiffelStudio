/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ITYPEINFO_2_S_H__
#define __ECOM_CONTROL_LIBRARY_ITYPEINFO_2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_ITypeInfo_2_FWD_DEFINED__
#define __ecom_control_library_ITypeInfo_2_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeInfo_2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagTYPEATTR_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagFUNCDESC_s.h"

#include "ecom_control_library_tagVARDESC_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_ITypeComp_FWD_DEFINED__
#define __ecom_control_library_ITypeComp_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeComp;
}
#endif



#ifndef __ecom_control_library_ITypeInfo_2_FWD_DEFINED__
#define __ecom_control_library_ITypeInfo_2_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeInfo_2;
}
#endif



#ifndef __ecom_control_library_ITypeLib_2_FWD_DEFINED__
#define __ecom_control_library_ITypeLib_2_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeLib_2;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_ITypeInfo_2_INTERFACE_DEFINED__
#define __ecom_control_library_ITypeInfo_2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class ITypeInfo_2 : public IUnknown
{
public:
	ITypeInfo_2 () {};
	~ITypeInfo_2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetTypeAttr(  /* [out] */ ecom_control_library::tagTYPEATTR * * pp_type_attr, /* [out] */ ecom_control_library::DWORD1 * p_dummy ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetTypeComp(  /* [out] */ ecom_control_library::ITypeComp * * pp_tcomp ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetFuncDesc(  /* [in] */ UINT a_index, /* [out] */ ecom_control_library::tagFUNCDESC * * pp_func_desc, /* [out] */ ecom_control_library::DWORD1 * p_dummy ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetVarDesc(  /* [in] */ UINT a_index, /* [out] */ ecom_control_library::tagVARDESC * * pp_var_desc, /* [out] */ ecom_control_library::DWORD1 * p_dummy ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetNames(  /* [in] */ LONG memid, /* [out] */ BSTR * rg_bstr_names, /* [in] */ UINT c_max_names, /* [out] */ UINT * pc_names ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetRefTypeOfImplType(  /* [in] */ UINT a_index, /* [out] */ ULONG * p_ref_type ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetImplTypeFlags(  /* [in] */ UINT a_index, /* [out] */ INT * p_impl_type_flags ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocalGetIDsOfNames( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocalInvoke( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetDocumentation(  /* [in] */ LONG memid, /* [in] */ ULONG ref_ptr_flags, /* [out] */ BSTR * p_bstr_name, /* [out] */ BSTR * p_bstr_doc_string, /* [out] */ ULONG * pdw_help_context, /* [out] */ BSTR * p_bstr_help_file ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetDllEntry(  /* [in] */ LONG memid, /* [in] */ long invkind, /* [in] */ ULONG ref_ptr_flags, /* [out] */ BSTR * p_bstr_dll_name, /* [out] */ BSTR * p_bstr_name, /* [out] */ USHORT * pw_ordinal ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetRefTypeInfo(  /* [in] */ ULONG hreftype, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocalAddressOfMember( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteCreateInstance(  /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetMops(  /* [in] */ LONG memid, /* [out] */ BSTR * p_bstr_mops ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetContainingTypeLib(  /* [out] */ ecom_control_library::ITypeLib_2 * * pp_tlib, /* [out] */ UINT * p_index ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocalReleaseTypeAttr( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocalReleaseFuncDesc( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocalReleaseVarDesc( void ) = 0;



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