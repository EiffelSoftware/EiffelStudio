/*-----------------------------------------------------------
Implemented `ITypeInfo_2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ITYPEINFO_2_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ITYPEINFO_2_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class ITypeInfo_2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_ITypeInfo_2_s.h"

#include "ecom_control_library_tagTYPEATTR_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_ITypeComp_s.h"

#include "ecom_control_library_tagFUNCDESC_s.h"

#include "ecom_control_library_tagVARDESC_s.h"

#include "ecom_control_library_ITypeLib_2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class ITypeInfo_2_impl_proxy
{
public:
	ITypeInfo_2_impl_proxy (IUnknown * a_pointer);
	virtual ~ITypeInfo_2_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_type_attr(  /* [out] */ EIF_OBJECT pp_type_attr,  /* [out] */ EIF_OBJECT p_dummy );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_type_comp(  /* [out] */ EIF_OBJECT pp_tcomp );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_func_desc(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT pp_func_desc,  /* [out] */ EIF_OBJECT p_dummy );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_var_desc(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT pp_var_desc,  /* [out] */ EIF_OBJECT p_dummy );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_names(  /* [in] */ EIF_INTEGER memid,  /* [out] */ EIF_OBJECT rg_bstr_names,  /* [in] */ EIF_INTEGER c_max_names,  /* [out] */ EIF_OBJECT pc_names );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_ref_type_of_impl_type(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT p_ref_type );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_impl_type_flags(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT p_impl_type_flags );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_local_get_ids_of_names();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_local_invoke();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_documentation(  /* [in] */ EIF_INTEGER memid,  /* [in] */ EIF_INTEGER ref_ptr_flags,  /* [out] */ EIF_OBJECT p_bstr_name,  /* [out] */ EIF_OBJECT p_bstr_doc_string,  /* [out] */ EIF_OBJECT pdw_help_context,  /* [out] */ EIF_OBJECT p_bstr_help_file );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_dll_entry(  /* [in] */ EIF_INTEGER memid,  /* [in] */ EIF_INTEGER invkind,  /* [in] */ EIF_INTEGER ref_ptr_flags,  /* [out] */ EIF_OBJECT p_bstr_dll_name,  /* [out] */ EIF_OBJECT p_bstr_name,  /* [out] */ EIF_OBJECT pw_ordinal );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_ref_type_info(  /* [in] */ EIF_INTEGER hreftype,  /* [out] */ EIF_OBJECT pp_tinfo );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_local_address_of_member();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_create_instance(  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_obj );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_mops(  /* [in] */ EIF_INTEGER memid,  /* [out] */ EIF_OBJECT p_bstr_mops );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_containing_type_lib(  /* [out] */ EIF_OBJECT pp_tlib,  /* [out] */ EIF_OBJECT p_index );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_local_release_type_attr();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_local_release_func_desc();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_local_release_var_desc();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::ITypeInfo_2 * p_ITypeInfo_2;


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