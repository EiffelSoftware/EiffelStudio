/*-----------------------------------------------------------
Implemented `ITypeLib_2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ITypeLib_2_impl_stub_s.h"
static int return_hr_value;

static const IID IID_ITypeLib_2_ = {0x00020402,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ITypeLib_2_impl_stub::ITypeLib_2_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeLib_2_impl_stub::~ITypeLib_2_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::RemoteGetTypeInfoCount(  /* [out] */ UINT * pc_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pc_tinfo = NULL;
	if (pc_tinfo != NULL)
	{
		tmp_pc_tinfo = eif_protect (rt_ce.ccom_ce_pointed_unsigned_integer (pc_tinfo, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_type_info_count", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pc_tinfo != NULL) ? eif_access (tmp_pc_tinfo) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_integer (((tmp_pc_tinfo != NULL) ? eif_wean (tmp_pc_tinfo) : NULL), pc_tinfo);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::a_GetTypeInfo(  /* [in] */ UINT a_index, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_a_index = (EIF_INTEGER)a_index;
	EIF_OBJECT tmp_pp_tinfo = NULL;
	if (pp_tinfo != NULL)
	{
		tmp_pp_tinfo = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 (pp_tinfo, NULL));
		if (*pp_tinfo != NULL)
			(*pp_tinfo)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_type_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_a_index, ((tmp_pp_tinfo != NULL) ? eif_access (tmp_pp_tinfo) : NULL));
	
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (((tmp_pp_tinfo != NULL) ? eif_wean (tmp_pp_tinfo) : NULL), pp_tinfo);
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::GetTypeInfoType(  /* [in] */ UINT a_index, /* [out] */ long * p_tkind )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_a_index = (EIF_INTEGER)a_index;
	EIF_OBJECT tmp_p_tkind = NULL;
	if (p_tkind != NULL)
	{
		tmp_p_tkind = eif_protect (rt_ce.ccom_ce_pointed_long (p_tkind, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_type_info_type", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_a_index, ((tmp_p_tkind != NULL) ? eif_access (tmp_p_tkind) : NULL));
	rt_ec.ccom_ec_pointed_long (((tmp_p_tkind != NULL) ? eif_wean (tmp_p_tkind) : NULL), p_tkind);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::GetTypeInfoOfGuid(  /* [in] */ GUID * guid, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_guid = NULL;
	if (guid != NULL)
	{
		tmp_guid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (guid));
	}
	EIF_OBJECT tmp_pp_tinfo = NULL;
	if (pp_tinfo != NULL)
	{
		tmp_pp_tinfo = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 (pp_tinfo, NULL));
		if (*pp_tinfo != NULL)
			(*pp_tinfo)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_type_info_of_guid", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_guid != NULL) ? eif_access (tmp_guid) : NULL), ((tmp_pp_tinfo != NULL) ? eif_access (tmp_pp_tinfo) : NULL));
	
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (((tmp_pp_tinfo != NULL) ? eif_wean (tmp_pp_tinfo) : NULL), pp_tinfo);
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->AddRef ();
	if (tmp_guid != NULL)
		eif_wean (tmp_guid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::RemoteGetLibAttr(  /* [out] */ ecom_control_library::tagTLIBATTR * * pp_tlib_attr, /* [out] */ ecom_control_library::DWORD1 * p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_tlib_attr = NULL;
	if (pp_tlib_attr != NULL)
	{
		tmp_pp_tlib_attr = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_361 (pp_tlib_attr, NULL));
	}
	EIF_OBJECT tmp_p_dummy = NULL;
	if (p_dummy != NULL)
	{
		tmp_p_dummy = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (p_dummy, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_lib_attr", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_tlib_attr != NULL) ? eif_access (tmp_pp_tlib_attr) : NULL), ((tmp_p_dummy != NULL) ? eif_access (tmp_p_dummy) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_361 (((tmp_pp_tlib_attr != NULL) ? eif_wean (tmp_pp_tlib_attr) : NULL), pp_tlib_attr);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_p_dummy != NULL) ? eif_wean (tmp_p_dummy) : NULL), p_dummy);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::GetTypeComp(  /* [out] */ ecom_control_library::ITypeComp * * pp_tcomp )

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

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::RemoteGetDocumentation(  /* [in] */ INT a_index, /* [in] */ ULONG ref_ptr_flags, /* [out] */ BSTR * p_bstr_name, /* [out] */ BSTR * p_bstr_doc_string, /* [out] */ ULONG * pdw_help_context, /* [out] */ BSTR * p_bstr_help_file )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_a_index = (EIF_INTEGER)a_index;
	EIF_INTEGER tmp_ref_ptr_flags = (EIF_INTEGER)ref_ptr_flags;
	EIF_OBJECT tmp_p_bstr_name = NULL;
	if (p_bstr_name != NULL)
	{
		tmp_p_bstr_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_362 (p_bstr_name, NULL));
	}
	EIF_OBJECT tmp_p_bstr_doc_string = NULL;
	if (p_bstr_doc_string != NULL)
	{
		tmp_p_bstr_doc_string = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_363 (p_bstr_doc_string, NULL));
	}
	EIF_OBJECT tmp_pdw_help_context = NULL;
	if (pdw_help_context != NULL)
	{
		tmp_pdw_help_context = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_help_context, NULL));
	}
	EIF_OBJECT tmp_p_bstr_help_file = NULL;
	if (p_bstr_help_file != NULL)
	{
		tmp_p_bstr_help_file = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_365 (p_bstr_help_file, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_documentation", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_a_index, (EIF_INTEGER)tmp_ref_ptr_flags, ((tmp_p_bstr_name != NULL) ? eif_access (tmp_p_bstr_name) : NULL), ((tmp_p_bstr_doc_string != NULL) ? eif_access (tmp_p_bstr_doc_string) : NULL), ((tmp_pdw_help_context != NULL) ? eif_access (tmp_pdw_help_context) : NULL), ((tmp_p_bstr_help_file != NULL) ? eif_access (tmp_p_bstr_help_file) : NULL));
	
	if (*p_bstr_name != NULL)
		rt_ce.free_memory_bstr (*p_bstr_name);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_362 (((tmp_p_bstr_name != NULL) ? eif_wean (tmp_p_bstr_name) : NULL), p_bstr_name);
	
	if (*p_bstr_doc_string != NULL)
		rt_ce.free_memory_bstr (*p_bstr_doc_string);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_363 (((tmp_p_bstr_doc_string != NULL) ? eif_wean (tmp_p_bstr_doc_string) : NULL), p_bstr_doc_string);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_help_context != NULL) ? eif_wean (tmp_pdw_help_context) : NULL), pdw_help_context);
	
	if (*p_bstr_help_file != NULL)
		rt_ce.free_memory_bstr (*p_bstr_help_file);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_365 (((tmp_p_bstr_help_file != NULL) ? eif_wean (tmp_p_bstr_help_file) : NULL), p_bstr_help_file);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::RemoteIsName(  /* [in] */ LPWSTR sz_name_buf, /* [in] */ ULONG l_hash_val, /* [out] */ LONG * pf_name, /* [out] */ BSTR * p_bstr_lib_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_sz_name_buf = NULL;
	if (sz_name_buf != NULL)
	{
		tmp_sz_name_buf = eif_protect (rt_ce.ccom_ce_lpwstr (sz_name_buf, NULL));
	}
	EIF_INTEGER tmp_l_hash_val = (EIF_INTEGER)l_hash_val;
	EIF_OBJECT tmp_pf_name = NULL;
	if (pf_name != NULL)
	{
		tmp_pf_name = eif_protect (rt_ce.ccom_ce_pointed_long (pf_name, NULL));
	}
	EIF_OBJECT tmp_p_bstr_lib_name = NULL;
	if (p_bstr_lib_name != NULL)
	{
		tmp_p_bstr_lib_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_367 (p_bstr_lib_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_is_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_sz_name_buf != NULL) ? eif_access (tmp_sz_name_buf) : NULL), (EIF_INTEGER)tmp_l_hash_val, ((tmp_pf_name != NULL) ? eif_access (tmp_pf_name) : NULL), ((tmp_p_bstr_lib_name != NULL) ? eif_access (tmp_p_bstr_lib_name) : NULL));
	rt_ec.ccom_ec_pointed_long (((tmp_pf_name != NULL) ? eif_wean (tmp_pf_name) : NULL), pf_name);
	
	if (*p_bstr_lib_name != NULL)
		rt_ce.free_memory_bstr (*p_bstr_lib_name);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_367 (((tmp_p_bstr_lib_name != NULL) ? eif_wean (tmp_p_bstr_lib_name) : NULL), p_bstr_lib_name);
	if (tmp_sz_name_buf != NULL)
		eif_wean (tmp_sz_name_buf);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::RemoteFindName(  /* [in] */ LPWSTR sz_name_buf, /* [in] */ ULONG l_hash_val, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo, /* [out] */ LONG * rg_mem_id, /* [in, out] */ USHORT * pc_found, /* [out] */ BSTR * p_bstr_lib_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_sz_name_buf = NULL;
	if (sz_name_buf != NULL)
	{
		tmp_sz_name_buf = eif_protect (rt_ce.ccom_ce_lpwstr (sz_name_buf, NULL));
	}
	EIF_INTEGER tmp_l_hash_val = (EIF_INTEGER)l_hash_val;
	EIF_OBJECT tmp_pp_tinfo = NULL;
	if (pp_tinfo != NULL)
	{
		tmp_pp_tinfo = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 (pp_tinfo, NULL));
		if (*pp_tinfo != NULL)
			(*pp_tinfo)->AddRef ();
	}
	EIF_OBJECT tmp_rg_mem_id = NULL;
	if (rg_mem_id != NULL)
	{
		tmp_rg_mem_id = eif_protect (rt_ce.ccom_ce_pointed_long (rg_mem_id, NULL));
	}
	EIF_OBJECT tmp_pc_found = NULL;
	if (pc_found != NULL)
	{
		tmp_pc_found = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (pc_found, NULL));
	}
	EIF_OBJECT tmp_p_bstr_lib_name = NULL;
	if (p_bstr_lib_name != NULL)
	{
		tmp_p_bstr_lib_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_370 (p_bstr_lib_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_find_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_sz_name_buf != NULL) ? eif_access (tmp_sz_name_buf) : NULL), (EIF_INTEGER)tmp_l_hash_val, ((tmp_pp_tinfo != NULL) ? eif_access (tmp_pp_tinfo) : NULL), ((tmp_rg_mem_id != NULL) ? eif_access (tmp_rg_mem_id) : NULL), ((tmp_pc_found != NULL) ? eif_access (tmp_pc_found) : NULL), ((tmp_p_bstr_lib_name != NULL) ? eif_access (tmp_p_bstr_lib_name) : NULL));
	
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (((tmp_pp_tinfo != NULL) ? eif_wean (tmp_pp_tinfo) : NULL), pp_tinfo);
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->AddRef ();
	rt_ec.ccom_ec_pointed_long (((tmp_rg_mem_id != NULL) ? eif_wean (tmp_rg_mem_id) : NULL), rg_mem_id);
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_pc_found != NULL) ? eif_wean (tmp_pc_found) : NULL), pc_found);
	
	if (*p_bstr_lib_name != NULL)
		rt_ce.free_memory_bstr (*p_bstr_lib_name);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_370 (((tmp_p_bstr_lib_name != NULL) ? eif_wean (tmp_p_bstr_lib_name) : NULL), p_bstr_lib_name);
	if (tmp_sz_name_buf != NULL)
		eif_wean (tmp_sz_name_buf);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::LocalReleaseTLibAttr( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("local_release_tlib_attr", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::ITypeLib_2_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::ITypeLib_2_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeLib_2_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::ITypeLib_2*>(this);
	else if (riid == IID_ITypeLib_2_)
		*ppv = static_cast<ecom_control_library::ITypeLib_2*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif