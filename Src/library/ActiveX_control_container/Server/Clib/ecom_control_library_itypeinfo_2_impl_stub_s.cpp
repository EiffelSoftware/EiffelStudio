/*-----------------------------------------------------------
Implemented `ITypeInfo_2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ITypeInfo_2_impl_stub_s.h"
static int return_hr_value;

static const IID IID_ITypeInfo_2_ = {0x00020401,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ITypeInfo_2_impl_stub::ITypeInfo_2_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeInfo_2_impl_stub::~ITypeInfo_2_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::RemoteGetTypeAttr(  /* [out] */ ecom_control_library::tagTYPEATTR * * pp_type_attr, /* [out] */ ecom_control_library::DWORD1 * p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_type_attr = NULL;
	if (pp_type_attr != NULL)
	{
		tmp_pp_type_attr = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_305 (pp_type_attr, NULL));
	}
	EIF_OBJECT tmp_p_dummy = NULL;
	if (p_dummy != NULL)
	{
		tmp_p_dummy = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (p_dummy, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_type_attr", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_type_attr != NULL) ? eif_access (tmp_pp_type_attr) : NULL), ((tmp_p_dummy != NULL) ? eif_access (tmp_p_dummy) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_305 (((tmp_pp_type_attr != NULL) ? eif_wean (tmp_pp_type_attr) : NULL), pp_type_attr);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_p_dummy != NULL) ? eif_wean (tmp_p_dummy) : NULL), p_dummy);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::GetTypeComp(  /* [out] */ ecom_control_library::ITypeComp * * pp_tcomp )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_tcomp = NULL;
	if (pp_tcomp != NULL)
	{
		tmp_pp_tcomp = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_310 (pp_tcomp, NULL));
		if (*pp_tcomp != NULL)
			(*pp_tcomp)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_type_comp", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_tcomp != NULL) ? eif_access (tmp_pp_tcomp) : NULL));
	
	if (*pp_tcomp != NULL)
		(*pp_tcomp)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_310 (((tmp_pp_tcomp != NULL) ? eif_wean (tmp_pp_tcomp) : NULL), pp_tcomp);
	if (*pp_tcomp != NULL)
		(*pp_tcomp)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::RemoteGetFuncDesc(  /* [in] */ UINT a_index, /* [out] */ ecom_control_library::tagFUNCDESC * * pp_func_desc, /* [out] */ ecom_control_library::DWORD1 * p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_a_index = (EIF_INTEGER)a_index;
	EIF_OBJECT tmp_pp_func_desc = NULL;
	if (pp_func_desc != NULL)
	{
		tmp_pp_func_desc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_313 (pp_func_desc, NULL));
	}
	EIF_OBJECT tmp_p_dummy = NULL;
	if (p_dummy != NULL)
	{
		tmp_p_dummy = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (p_dummy, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_func_desc", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_a_index, ((tmp_pp_func_desc != NULL) ? eif_access (tmp_pp_func_desc) : NULL), ((tmp_p_dummy != NULL) ? eif_access (tmp_p_dummy) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_313 (((tmp_pp_func_desc != NULL) ? eif_wean (tmp_pp_func_desc) : NULL), pp_func_desc);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_p_dummy != NULL) ? eif_wean (tmp_p_dummy) : NULL), p_dummy);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::RemoteGetVarDesc(  /* [in] */ UINT a_index, /* [out] */ ecom_control_library::tagVARDESC * * pp_var_desc, /* [out] */ ecom_control_library::DWORD1 * p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_a_index = (EIF_INTEGER)a_index;
	EIF_OBJECT tmp_pp_var_desc = NULL;
	if (pp_var_desc != NULL)
	{
		tmp_pp_var_desc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_316 (pp_var_desc, NULL));
	}
	EIF_OBJECT tmp_p_dummy = NULL;
	if (p_dummy != NULL)
	{
		tmp_p_dummy = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (p_dummy, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_var_desc", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_a_index, ((tmp_pp_var_desc != NULL) ? eif_access (tmp_pp_var_desc) : NULL), ((tmp_p_dummy != NULL) ? eif_access (tmp_p_dummy) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_316 (((tmp_pp_var_desc != NULL) ? eif_wean (tmp_pp_var_desc) : NULL), pp_var_desc);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_p_dummy != NULL) ? eif_wean (tmp_p_dummy) : NULL), p_dummy);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::RemoteGetNames(  /* [in] */ LONG memid, /* [out] */ BSTR * rg_bstr_names, /* [in] */ UINT c_max_names, /* [out] */ UINT * pc_names )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_memid = (EIF_INTEGER)memid;
	EIF_OBJECT tmp_rg_bstr_names = NULL;
	if (rg_bstr_names != NULL)
	{
		tmp_rg_bstr_names = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_317 (rg_bstr_names, NULL));
	}
	EIF_INTEGER tmp_c_max_names = (EIF_INTEGER)c_max_names;
	EIF_OBJECT tmp_pc_names = NULL;
	if (pc_names != NULL)
	{
		tmp_pc_names = eif_protect (rt_ce.ccom_ce_pointed_unsigned_integer (pc_names, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_names", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_memid, ((tmp_rg_bstr_names != NULL) ? eif_access (tmp_rg_bstr_names) : NULL), (EIF_INTEGER)tmp_c_max_names, ((tmp_pc_names != NULL) ? eif_access (tmp_pc_names) : NULL));
	
	if (*rg_bstr_names != NULL)
		rt_ce.free_memory_bstr (*rg_bstr_names);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_317 (((tmp_rg_bstr_names != NULL) ? eif_wean (tmp_rg_bstr_names) : NULL), rg_bstr_names);
	rt_ec.ccom_ec_pointed_unsigned_integer (((tmp_pc_names != NULL) ? eif_wean (tmp_pc_names) : NULL), pc_names);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::GetRefTypeOfImplType(  /* [in] */ UINT a_index, /* [out] */ ULONG * p_ref_type )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_a_index = (EIF_INTEGER)a_index;
	EIF_OBJECT tmp_p_ref_type = NULL;
	if (p_ref_type != NULL)
	{
		tmp_p_ref_type = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (p_ref_type, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_ref_type_of_impl_type", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_a_index, ((tmp_p_ref_type != NULL) ? eif_access (tmp_p_ref_type) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_p_ref_type != NULL) ? eif_wean (tmp_p_ref_type) : NULL), p_ref_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::GetImplTypeFlags(  /* [in] */ UINT a_index, /* [out] */ INT * p_impl_type_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_a_index = (EIF_INTEGER)a_index;
	EIF_OBJECT tmp_p_impl_type_flags = NULL;
	if (p_impl_type_flags != NULL)
	{
		tmp_p_impl_type_flags = eif_protect (rt_ce.ccom_ce_pointed_integer (p_impl_type_flags, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_impl_type_flags", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_a_index, ((tmp_p_impl_type_flags != NULL) ? eif_access (tmp_p_impl_type_flags) : NULL));
	rt_ec.ccom_ec_pointed_integer (((tmp_p_impl_type_flags != NULL) ? eif_wean (tmp_p_impl_type_flags) : NULL), p_impl_type_flags);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::LocalGetIDsOfNames( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("local_get_ids_of_names", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::LocalInvoke( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("local_invoke", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::RemoteGetDocumentation(  /* [in] */ LONG memid, /* [in] */ ULONG ref_ptr_flags, /* [out] */ BSTR * p_bstr_name, /* [out] */ BSTR * p_bstr_doc_string, /* [out] */ ULONG * pdw_help_context, /* [out] */ BSTR * p_bstr_help_file )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_memid = (EIF_INTEGER)memid;
	EIF_INTEGER tmp_ref_ptr_flags = (EIF_INTEGER)ref_ptr_flags;
	EIF_OBJECT tmp_p_bstr_name = NULL;
	if (p_bstr_name != NULL)
	{
		tmp_p_bstr_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_321 (p_bstr_name, NULL));
	}
	EIF_OBJECT tmp_p_bstr_doc_string = NULL;
	if (p_bstr_doc_string != NULL)
	{
		tmp_p_bstr_doc_string = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_322 (p_bstr_doc_string, NULL));
	}
	EIF_OBJECT tmp_pdw_help_context = NULL;
	if (pdw_help_context != NULL)
	{
		tmp_pdw_help_context = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_help_context, NULL));
	}
	EIF_OBJECT tmp_p_bstr_help_file = NULL;
	if (p_bstr_help_file != NULL)
	{
		tmp_p_bstr_help_file = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_324 (p_bstr_help_file, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_documentation", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_memid, (EIF_INTEGER)tmp_ref_ptr_flags, ((tmp_p_bstr_name != NULL) ? eif_access (tmp_p_bstr_name) : NULL), ((tmp_p_bstr_doc_string != NULL) ? eif_access (tmp_p_bstr_doc_string) : NULL), ((tmp_pdw_help_context != NULL) ? eif_access (tmp_pdw_help_context) : NULL), ((tmp_p_bstr_help_file != NULL) ? eif_access (tmp_p_bstr_help_file) : NULL));
	
	if (*p_bstr_name != NULL)
		rt_ce.free_memory_bstr (*p_bstr_name);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_321 (((tmp_p_bstr_name != NULL) ? eif_wean (tmp_p_bstr_name) : NULL), p_bstr_name);
	
	if (*p_bstr_doc_string != NULL)
		rt_ce.free_memory_bstr (*p_bstr_doc_string);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_322 (((tmp_p_bstr_doc_string != NULL) ? eif_wean (tmp_p_bstr_doc_string) : NULL), p_bstr_doc_string);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_help_context != NULL) ? eif_wean (tmp_pdw_help_context) : NULL), pdw_help_context);
	
	if (*p_bstr_help_file != NULL)
		rt_ce.free_memory_bstr (*p_bstr_help_file);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_324 (((tmp_p_bstr_help_file != NULL) ? eif_wean (tmp_p_bstr_help_file) : NULL), p_bstr_help_file);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::RemoteGetDllEntry(  /* [in] */ LONG memid, /* [in] */ long invkind, /* [in] */ ULONG ref_ptr_flags, /* [out] */ BSTR * p_bstr_dll_name, /* [out] */ BSTR * p_bstr_name, /* [out] */ USHORT * pw_ordinal )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_memid = (EIF_INTEGER)memid;
	EIF_INTEGER tmp_invkind = (EIF_INTEGER)invkind;
	EIF_INTEGER tmp_ref_ptr_flags = (EIF_INTEGER)ref_ptr_flags;
	EIF_OBJECT tmp_p_bstr_dll_name = NULL;
	if (p_bstr_dll_name != NULL)
	{
		tmp_p_bstr_dll_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_326 (p_bstr_dll_name, NULL));
	}
	EIF_OBJECT tmp_p_bstr_name = NULL;
	if (p_bstr_name != NULL)
	{
		tmp_p_bstr_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_327 (p_bstr_name, NULL));
	}
	EIF_OBJECT tmp_pw_ordinal = NULL;
	if (pw_ordinal != NULL)
	{
		tmp_pw_ordinal = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (pw_ordinal, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_dll_entry", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_memid, (EIF_INTEGER)tmp_invkind, (EIF_INTEGER)tmp_ref_ptr_flags, ((tmp_p_bstr_dll_name != NULL) ? eif_access (tmp_p_bstr_dll_name) : NULL), ((tmp_p_bstr_name != NULL) ? eif_access (tmp_p_bstr_name) : NULL), ((tmp_pw_ordinal != NULL) ? eif_access (tmp_pw_ordinal) : NULL));
	
	if (*p_bstr_dll_name != NULL)
		rt_ce.free_memory_bstr (*p_bstr_dll_name);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_326 (((tmp_p_bstr_dll_name != NULL) ? eif_wean (tmp_p_bstr_dll_name) : NULL), p_bstr_dll_name);
	
	if (*p_bstr_name != NULL)
		rt_ce.free_memory_bstr (*p_bstr_name);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_327 (((tmp_p_bstr_name != NULL) ? eif_wean (tmp_p_bstr_name) : NULL), p_bstr_name);
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_pw_ordinal != NULL) ? eif_wean (tmp_pw_ordinal) : NULL), pw_ordinal);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::GetRefTypeInfo(  /* [in] */ ULONG hreftype, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_hreftype = (EIF_INTEGER)hreftype;
	EIF_OBJECT tmp_pp_tinfo = NULL;
	if (pp_tinfo != NULL)
	{
		tmp_pp_tinfo = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 (pp_tinfo, NULL));
		if (*pp_tinfo != NULL)
			(*pp_tinfo)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_ref_type_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_hreftype, ((tmp_pp_tinfo != NULL) ? eif_access (tmp_pp_tinfo) : NULL));
	
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (((tmp_pp_tinfo != NULL) ? eif_wean (tmp_pp_tinfo) : NULL), pp_tinfo);
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::LocalAddressOfMember( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("local_address_of_member", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::RemoteCreateInstance(  /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_riid = NULL;
	if (riid != NULL)
	{
		tmp_riid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid));
	}
	EIF_OBJECT tmp_ppv_obj = NULL;
	if (ppv_obj != NULL)
	{
		tmp_ppv_obj = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_329 (ppv_obj, NULL));
		if (*ppv_obj != NULL)
			(*ppv_obj)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_create_instance", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_obj != NULL) ? eif_access (tmp_ppv_obj) : NULL));
	
	if (*ppv_obj != NULL)
		(*ppv_obj)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_329 (((tmp_ppv_obj != NULL) ? eif_wean (tmp_ppv_obj) : NULL), ppv_obj);
	if (*ppv_obj != NULL)
		(*ppv_obj)->AddRef ();
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::GetMops(  /* [in] */ LONG memid, /* [out] */ BSTR * p_bstr_mops )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_memid = (EIF_INTEGER)memid;
	EIF_OBJECT tmp_p_bstr_mops = NULL;
	if (p_bstr_mops != NULL)
	{
		tmp_p_bstr_mops = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_330 (p_bstr_mops, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_mops", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_memid, ((tmp_p_bstr_mops != NULL) ? eif_access (tmp_p_bstr_mops) : NULL));
	
	if (*p_bstr_mops != NULL)
		rt_ce.free_memory_bstr (*p_bstr_mops);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_330 (((tmp_p_bstr_mops != NULL) ? eif_wean (tmp_p_bstr_mops) : NULL), p_bstr_mops);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::RemoteGetContainingTypeLib(  /* [out] */ ecom_control_library::ITypeLib_2 * * pp_tlib, /* [out] */ UINT * p_index )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_tlib = NULL;
	if (pp_tlib != NULL)
	{
		tmp_pp_tlib = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_333 (pp_tlib, NULL));
		if (*pp_tlib != NULL)
			(*pp_tlib)->AddRef ();
	}
	EIF_OBJECT tmp_p_index = NULL;
	if (p_index != NULL)
	{
		tmp_p_index = eif_protect (rt_ce.ccom_ce_pointed_unsigned_integer (p_index, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_containing_type_lib", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_tlib != NULL) ? eif_access (tmp_pp_tlib) : NULL), ((tmp_p_index != NULL) ? eif_access (tmp_p_index) : NULL));
	
	if (*pp_tlib != NULL)
		(*pp_tlib)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_333 (((tmp_pp_tlib != NULL) ? eif_wean (tmp_pp_tlib) : NULL), pp_tlib);
	if (*pp_tlib != NULL)
		(*pp_tlib)->AddRef ();
	rt_ec.ccom_ec_pointed_unsigned_integer (((tmp_p_index != NULL) ? eif_wean (tmp_p_index) : NULL), p_index);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::LocalReleaseTypeAttr( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("local_release_type_attr", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::LocalReleaseFuncDesc( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("local_release_func_desc", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::LocalReleaseVarDesc( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("local_release_var_desc", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::ITypeInfo_2_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::ITypeInfo_2_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeInfo_2_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::ITypeInfo_2*>(this);
	else if (riid == IID_ITypeInfo_2_)
		*ppv = static_cast<ecom_control_library::ITypeInfo_2*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif