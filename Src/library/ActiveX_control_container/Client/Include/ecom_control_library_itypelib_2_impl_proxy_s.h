/*-----------------------------------------------------------
Implemented `ITypeLib_2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ITYPELIB_2_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ITYPELIB_2_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ITypeLib_2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_ITypeLib_2_s.h"

#include "ecom_control_library_ITypeInfo_2_s.h"

#include "ecom_control_library_tagTLIBATTR_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_ITypeComp_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ITypeLib_2_impl_proxy
{
public:
	ITypeLib_2_impl_proxy (IUnknown * a_pointer);
	virtual ~ITypeLib_2_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_type_info_count(  /* [out] */ EIF_OBJECT pc_tinfo );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_type_info(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT pp_tinfo );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_type_info_type(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT p_tkind );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_type_info_of_guid(  /* [in] */ GUID * guid,  /* [out] */ EIF_OBJECT pp_tinfo );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_lib_attr(  /* [out] */ EIF_OBJECT pp_tlib_attr,  /* [out] */ EIF_OBJECT p_dummy );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_type_comp(  /* [out] */ EIF_OBJECT pp_tcomp );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_documentation(  /* [in] */ EIF_INTEGER a_index,  /* [in] */ EIF_INTEGER ref_ptr_flags,  /* [out] */ EIF_OBJECT p_bstr_name,  /* [out] */ EIF_OBJECT p_bstr_doc_string,  /* [out] */ EIF_OBJECT pdw_help_context,  /* [out] */ EIF_OBJECT p_bstr_help_file );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_is_name(  /* [in] */ EIF_OBJECT sz_name_buf,  /* [in] */ EIF_INTEGER l_hash_val,  /* [out] */ EIF_OBJECT pf_name,  /* [out] */ EIF_OBJECT p_bstr_lib_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_find_name(  /* [in] */ EIF_OBJECT sz_name_buf,  /* [in] */ EIF_INTEGER l_hash_val,  /* [out] */ EIF_OBJECT pp_tinfo,  /* [out] */ EIF_OBJECT rg_mem_id,  /* [in, out] */ EIF_OBJECT pc_found,  /* [out] */ EIF_OBJECT p_bstr_lib_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_local_release_tlib_attr();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::ITypeLib_2 * p_ITypeLib_2;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif