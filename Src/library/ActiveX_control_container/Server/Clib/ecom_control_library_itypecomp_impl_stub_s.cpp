/*-----------------------------------------------------------
Implemented `ITypeComp' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ITypeComp_impl_stub_s.h"
static int return_hr_value;

static const IID IID_ITypeComp_ = {0x00020403,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ITypeComp_impl_stub::ITypeComp_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeComp_impl_stub::~ITypeComp_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeComp_impl_stub::RemoteBind(  /* [in] */ LPWSTR sz_name, /* [in] */ ULONG l_hash_val, /* [in] */ USHORT w_flags, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo, /* [out] */ long * p_desc_kind, /* [out] */ ecom_control_library::tagFUNCDESC * * pp_func_desc, /* [out] */ ecom_control_library::tagVARDESC * * pp_var_desc, /* [out] */ ecom_control_library::ITypeComp * * pp_type_comp, /* [out] */ ecom_control_library::DWORD1 * p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_sz_name = NULL;
	if (sz_name != NULL)
	{
		tmp_sz_name = eif_protect (rt_ce.ccom_ce_lpwstr (sz_name, NULL));
	}
	EIF_INTEGER tmp_l_hash_val = (EIF_INTEGER)l_hash_val;
	EIF_INTEGER tmp_w_flags = (EIF_INTEGER)w_flags;
	EIF_OBJECT tmp_pp_tinfo = NULL;
	if (pp_tinfo != NULL)
	{
		tmp_pp_tinfo = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 (pp_tinfo, NULL));
		if (*pp_tinfo != NULL)
			(*pp_tinfo)->AddRef ();
	}
	EIF_OBJECT tmp_p_desc_kind = NULL;
	if (p_desc_kind != NULL)
	{
		tmp_p_desc_kind = eif_protect (rt_ce.ccom_ce_pointed_long (p_desc_kind, NULL));
	}
	EIF_OBJECT tmp_pp_func_desc = NULL;
	if (pp_func_desc != NULL)
	{
		tmp_pp_func_desc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_313 (pp_func_desc, NULL));
	}
	EIF_OBJECT tmp_pp_var_desc = NULL;
	if (pp_var_desc != NULL)
	{
		tmp_pp_var_desc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_316 (pp_var_desc, NULL));
	}
	EIF_OBJECT tmp_pp_type_comp = NULL;
	if (pp_type_comp != NULL)
	{
		tmp_pp_type_comp = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_310 (pp_type_comp, NULL));
		if (*pp_type_comp != NULL)
			(*pp_type_comp)->AddRef ();
	}
	EIF_OBJECT tmp_p_dummy = NULL;
	if (p_dummy != NULL)
	{
		tmp_p_dummy = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (p_dummy, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_bind", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_sz_name != NULL) ? eif_access (tmp_sz_name) : NULL), (EIF_INTEGER)tmp_l_hash_val, (EIF_INTEGER)tmp_w_flags, ((tmp_pp_tinfo != NULL) ? eif_access (tmp_pp_tinfo) : NULL), ((tmp_p_desc_kind != NULL) ? eif_access (tmp_p_desc_kind) : NULL), ((tmp_pp_func_desc != NULL) ? eif_access (tmp_pp_func_desc) : NULL), ((tmp_pp_var_desc != NULL) ? eif_access (tmp_pp_var_desc) : NULL), ((tmp_pp_type_comp != NULL) ? eif_access (tmp_pp_type_comp) : NULL), ((tmp_p_dummy != NULL) ? eif_access (tmp_p_dummy) : NULL));
	
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (((tmp_pp_tinfo != NULL) ? eif_wean (tmp_pp_tinfo) : NULL), pp_tinfo);
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->AddRef ();
	rt_ec.ccom_ec_pointed_long (((tmp_p_desc_kind != NULL) ? eif_wean (tmp_p_desc_kind) : NULL), p_desc_kind);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_313 (((tmp_pp_func_desc != NULL) ? eif_wean (tmp_pp_func_desc) : NULL), pp_func_desc);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_316 (((tmp_pp_var_desc != NULL) ? eif_wean (tmp_pp_var_desc) : NULL), pp_var_desc);
	
	if (*pp_type_comp != NULL)
		(*pp_type_comp)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_310 (((tmp_pp_type_comp != NULL) ? eif_wean (tmp_pp_type_comp) : NULL), pp_type_comp);
	if (*pp_type_comp != NULL)
		(*pp_type_comp)->AddRef ();
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_p_dummy != NULL) ? eif_wean (tmp_p_dummy) : NULL), p_dummy);
	if (tmp_sz_name != NULL)
		eif_wean (tmp_sz_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeComp_impl_stub::RemoteBindType(  /* [in] */ LPWSTR sz_name, /* [in] */ ULONG l_hash_val, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_sz_name = NULL;
	if (sz_name != NULL)
	{
		tmp_sz_name = eif_protect (rt_ce.ccom_ce_lpwstr (sz_name, NULL));
	}
	EIF_INTEGER tmp_l_hash_val = (EIF_INTEGER)l_hash_val;
	EIF_OBJECT tmp_pp_tinfo = NULL;
	if (pp_tinfo != NULL)
	{
		tmp_pp_tinfo = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 (pp_tinfo, NULL));
		if (*pp_tinfo != NULL)
			(*pp_tinfo)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_bind_type", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_sz_name != NULL) ? eif_access (tmp_sz_name) : NULL), (EIF_INTEGER)tmp_l_hash_val, ((tmp_pp_tinfo != NULL) ? eif_access (tmp_pp_tinfo) : NULL));
	
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (((tmp_pp_tinfo != NULL) ? eif_wean (tmp_pp_tinfo) : NULL), pp_tinfo);
	if (*pp_tinfo != NULL)
		(*pp_tinfo)->AddRef ();
	if (tmp_sz_name != NULL)
		eif_wean (tmp_sz_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::ITypeComp_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::ITypeComp_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ITypeComp_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::ITypeComp*>(this);
	else if (riid == IID_ITypeComp_)
		*ppv = static_cast<ecom_control_library::ITypeComp*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif