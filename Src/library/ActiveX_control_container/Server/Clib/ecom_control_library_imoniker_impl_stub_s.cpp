/*-----------------------------------------------------------
Implemented `IMoniker' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IMoniker_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IMoniker_ = {0x0000000f,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IPersistStream_ = {0x00000109,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IPersist_ = {0x0000010c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IMoniker_impl_stub::IMoniker_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IMoniker_impl_stub::~IMoniker_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::IPersist_GetClassID(  /* [out] */ GUID * p_class_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_class_id = NULL;
	if (p_class_id != NULL)
	{
		tmp_p_class_id = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (p_class_id));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_class_id", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_class_id != NULL) ? eif_access (tmp_p_class_id) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::IsDirty( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("is_dirty", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::Load(  /* [in] */ ecom_control_library::IStream * pstm )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pstm = NULL;
	if (pstm != NULL)
	{
		tmp_pstm = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_71 (pstm));
		pstm->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("load", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pstm != NULL) ? eif_access (tmp_pstm) : NULL));
	if (tmp_pstm != NULL)
		eif_wean (tmp_pstm);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::Save(  /* [in] */ ecom_control_library::IStream * pstm, /* [in] */ LONG f_clear_dirty )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pstm = NULL;
	if (pstm != NULL)
	{
		tmp_pstm = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_71 (pstm));
		pstm->AddRef ();
	}
	EIF_INTEGER tmp_f_clear_dirty = (EIF_INTEGER)f_clear_dirty;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("save", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pstm != NULL) ? eif_access (tmp_pstm) : NULL), (EIF_INTEGER)tmp_f_clear_dirty);
	if (tmp_pstm != NULL)
		eif_wean (tmp_pstm);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::GetSizeMax(  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_size )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pcb_size = NULL;
	if (pcb_size != NULL)
	{
		tmp_pcb_size = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_73 (pcb_size));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_size_max", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pcb_size != NULL) ? eif_access (tmp_pcb_size) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::RemoteBindToObject(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ GUID * riid_result, /* [out] */ IUnknown * * ppv_result )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_pmk_to_left = NULL;
	if (pmk_to_left != NULL)
	{
		tmp_pmk_to_left = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_to_left));
		pmk_to_left->AddRef ();
	}
	EIF_OBJECT tmp_riid_result = NULL;
	if (riid_result != NULL)
	{
		tmp_riid_result = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid_result));
	}
	EIF_OBJECT tmp_ppv_result = NULL;
	if (ppv_result != NULL)
	{
		tmp_ppv_result = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_58 (ppv_result, NULL));
		if (*ppv_result != NULL)
			(*ppv_result)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_bind_to_object", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_pmk_to_left != NULL) ? eif_access (tmp_pmk_to_left) : NULL), ((tmp_riid_result != NULL) ? eif_access (tmp_riid_result) : NULL), ((tmp_ppv_result != NULL) ? eif_access (tmp_ppv_result) : NULL));
	
	if (*ppv_result != NULL)
		(*ppv_result)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_58 (((tmp_ppv_result != NULL) ? eif_wean (tmp_ppv_result) : NULL), ppv_result);
	if (*ppv_result != NULL)
		(*ppv_result)->AddRef ();
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_pmk_to_left != NULL)
		eif_wean (tmp_pmk_to_left);
	if (tmp_riid_result != NULL)
		eif_wean (tmp_riid_result);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::RemoteBindToStorage(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_pmk_to_left = NULL;
	if (pmk_to_left != NULL)
	{
		tmp_pmk_to_left = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_to_left));
		pmk_to_left->AddRef ();
	}
	EIF_OBJECT tmp_riid = NULL;
	if (riid != NULL)
	{
		tmp_riid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid));
	}
	EIF_OBJECT tmp_ppv_obj = NULL;
	if (ppv_obj != NULL)
	{
		tmp_ppv_obj = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_59 (ppv_obj, NULL));
		if (*ppv_obj != NULL)
			(*ppv_obj)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_bind_to_storage", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_pmk_to_left != NULL) ? eif_access (tmp_pmk_to_left) : NULL), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_obj != NULL) ? eif_access (tmp_ppv_obj) : NULL));
	
	if (*ppv_obj != NULL)
		(*ppv_obj)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_59 (((tmp_ppv_obj != NULL) ? eif_wean (tmp_ppv_obj) : NULL), ppv_obj);
	if (*ppv_obj != NULL)
		(*ppv_obj)->AddRef ();
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_pmk_to_left != NULL)
		eif_wean (tmp_pmk_to_left);
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::Reduce(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ULONG dw_reduce_how_far, /* [in, out] */ ecom_control_library::IMoniker * * ppmk_to_left, /* [out] */ ecom_control_library::IMoniker * * ppmk_reduced )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_INTEGER tmp_dw_reduce_how_far = (EIF_INTEGER)dw_reduce_how_far;
	EIF_OBJECT tmp_ppmk_to_left = NULL;
	if (ppmk_to_left != NULL)
	{
		tmp_ppmk_to_left = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk_to_left, NULL));
		if (*ppmk_to_left != NULL)
			(*ppmk_to_left)->AddRef ();
	}
	EIF_OBJECT tmp_ppmk_reduced = NULL;
	if (ppmk_reduced != NULL)
	{
		tmp_ppmk_reduced = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk_reduced, NULL));
		if (*ppmk_reduced != NULL)
			(*ppmk_reduced)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("reduce", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), (EIF_INTEGER)tmp_dw_reduce_how_far, ((tmp_ppmk_to_left != NULL) ? eif_access (tmp_ppmk_to_left) : NULL), ((tmp_ppmk_reduced != NULL) ? eif_access (tmp_ppmk_reduced) : NULL));
	
	if (*ppmk_to_left != NULL)
		(*ppmk_to_left)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk_to_left != NULL) ? eif_wean (tmp_ppmk_to_left) : NULL), ppmk_to_left);
	if (*ppmk_to_left != NULL)
		(*ppmk_to_left)->AddRef ();
	
	if (*ppmk_reduced != NULL)
		(*ppmk_reduced)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk_reduced != NULL) ? eif_wean (tmp_ppmk_reduced) : NULL), ppmk_reduced);
	if (*ppmk_reduced != NULL)
		(*ppmk_reduced)->AddRef ();
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::ComposeWith(  /* [in] */ ecom_control_library::IMoniker * pmk_right, /* [in] */ LONG f_only_if_not_generic, /* [out] */ ecom_control_library::IMoniker * * ppmk_composite )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pmk_right = NULL;
	if (pmk_right != NULL)
	{
		tmp_pmk_right = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_right));
		pmk_right->AddRef ();
	}
	EIF_INTEGER tmp_f_only_if_not_generic = (EIF_INTEGER)f_only_if_not_generic;
	EIF_OBJECT tmp_ppmk_composite = NULL;
	if (ppmk_composite != NULL)
	{
		tmp_ppmk_composite = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk_composite, NULL));
		if (*ppmk_composite != NULL)
			(*ppmk_composite)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("compose_with", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk_right != NULL) ? eif_access (tmp_pmk_right) : NULL), (EIF_INTEGER)tmp_f_only_if_not_generic, ((tmp_ppmk_composite != NULL) ? eif_access (tmp_ppmk_composite) : NULL));
	
	if (*ppmk_composite != NULL)
		(*ppmk_composite)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk_composite != NULL) ? eif_wean (tmp_ppmk_composite) : NULL), ppmk_composite);
	if (*ppmk_composite != NULL)
		(*ppmk_composite)->AddRef ();
	if (tmp_pmk_right != NULL)
		eif_wean (tmp_pmk_right);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::Enum(  /* [in] */ LONG f_forward, /* [out] */ ecom_control_library::IEnumMoniker * * ppenum_moniker )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_forward = (EIF_INTEGER)f_forward;
	EIF_OBJECT tmp_ppenum_moniker = NULL;
	if (ppenum_moniker != NULL)
	{
		tmp_ppenum_moniker = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_63 (ppenum_moniker, NULL));
		if (*ppenum_moniker != NULL)
			(*ppenum_moniker)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_forward, ((tmp_ppenum_moniker != NULL) ? eif_access (tmp_ppenum_moniker) : NULL));
	
	if (*ppenum_moniker != NULL)
		(*ppenum_moniker)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_63 (((tmp_ppenum_moniker != NULL) ? eif_wean (tmp_ppenum_moniker) : NULL), ppenum_moniker);
	if (*ppenum_moniker != NULL)
		(*ppenum_moniker)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::IsEqual(  /* [in] */ ecom_control_library::IMoniker * pmk_other_moniker )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pmk_other_moniker = NULL;
	if (pmk_other_moniker != NULL)
	{
		tmp_pmk_other_moniker = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_other_moniker));
		pmk_other_moniker->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("is_equal1", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk_other_moniker != NULL) ? eif_access (tmp_pmk_other_moniker) : NULL));
	if (tmp_pmk_other_moniker != NULL)
		eif_wean (tmp_pmk_other_moniker);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::Hash(  /* [out] */ ULONG * pdw_hash )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pdw_hash = NULL;
	if (pdw_hash != NULL)
	{
		tmp_pdw_hash = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_hash, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("hash", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pdw_hash != NULL) ? eif_access (tmp_pdw_hash) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_hash != NULL) ? eif_wean (tmp_pdw_hash) : NULL), pdw_hash);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::IsRunning(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ ecom_control_library::IMoniker * pmk_newly_running )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_pmk_to_left = NULL;
	if (pmk_to_left != NULL)
	{
		tmp_pmk_to_left = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_to_left));
		pmk_to_left->AddRef ();
	}
	EIF_OBJECT tmp_pmk_newly_running = NULL;
	if (pmk_newly_running != NULL)
	{
		tmp_pmk_newly_running = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_newly_running));
		pmk_newly_running->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("is_running", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_pmk_to_left != NULL) ? eif_access (tmp_pmk_to_left) : NULL), ((tmp_pmk_newly_running != NULL) ? eif_access (tmp_pmk_newly_running) : NULL));
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_pmk_to_left != NULL)
		eif_wean (tmp_pmk_to_left);
	if (tmp_pmk_newly_running != NULL)
		eif_wean (tmp_pmk_newly_running);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::GetTimeOfLastChange(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [out] */ ecom_control_library::_FILETIME * pfiletime )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_pmk_to_left = NULL;
	if (pmk_to_left != NULL)
	{
		tmp_pmk_to_left = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_to_left));
		pmk_to_left->AddRef ();
	}
	EIF_OBJECT tmp_pfiletime = NULL;
	if (pfiletime != NULL)
	{
		tmp_pfiletime = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_66 (pfiletime));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_time_of_last_change", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_pmk_to_left != NULL) ? eif_access (tmp_pmk_to_left) : NULL), ((tmp_pfiletime != NULL) ? eif_access (tmp_pfiletime) : NULL));
	
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_pmk_to_left != NULL)
		eif_wean (tmp_pmk_to_left);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::Inverse(  /* [out] */ ecom_control_library::IMoniker * * ppmk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppmk = NULL;
	if (ppmk != NULL)
	{
		tmp_ppmk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk, NULL));
		if (*ppmk != NULL)
			(*ppmk)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("inverse", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppmk != NULL) ? eif_access (tmp_ppmk) : NULL));
	
	if (*ppmk != NULL)
		(*ppmk)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk != NULL) ? eif_wean (tmp_ppmk) : NULL), ppmk);
	if (*ppmk != NULL)
		(*ppmk)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::CommonPrefixWith(  /* [in] */ ecom_control_library::IMoniker * pmk_other, /* [out] */ ecom_control_library::IMoniker * * ppmk_prefix )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pmk_other = NULL;
	if (pmk_other != NULL)
	{
		tmp_pmk_other = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_other));
		pmk_other->AddRef ();
	}
	EIF_OBJECT tmp_ppmk_prefix = NULL;
	if (ppmk_prefix != NULL)
	{
		tmp_ppmk_prefix = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk_prefix, NULL));
		if (*ppmk_prefix != NULL)
			(*ppmk_prefix)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("common_prefix_with", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk_other != NULL) ? eif_access (tmp_pmk_other) : NULL), ((tmp_ppmk_prefix != NULL) ? eif_access (tmp_ppmk_prefix) : NULL));
	
	if (*ppmk_prefix != NULL)
		(*ppmk_prefix)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk_prefix != NULL) ? eif_wean (tmp_ppmk_prefix) : NULL), ppmk_prefix);
	if (*ppmk_prefix != NULL)
		(*ppmk_prefix)->AddRef ();
	if (tmp_pmk_other != NULL)
		eif_wean (tmp_pmk_other);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::RelativePathTo(  /* [in] */ ecom_control_library::IMoniker * pmk_other, /* [out] */ ecom_control_library::IMoniker * * ppmk_rel_path )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pmk_other = NULL;
	if (pmk_other != NULL)
	{
		tmp_pmk_other = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_other));
		pmk_other->AddRef ();
	}
	EIF_OBJECT tmp_ppmk_rel_path = NULL;
	if (ppmk_rel_path != NULL)
	{
		tmp_ppmk_rel_path = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk_rel_path, NULL));
		if (*ppmk_rel_path != NULL)
			(*ppmk_rel_path)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("relative_path_to", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk_other != NULL) ? eif_access (tmp_pmk_other) : NULL), ((tmp_ppmk_rel_path != NULL) ? eif_access (tmp_ppmk_rel_path) : NULL));
	
	if (*ppmk_rel_path != NULL)
		(*ppmk_rel_path)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk_rel_path != NULL) ? eif_wean (tmp_ppmk_rel_path) : NULL), ppmk_rel_path);
	if (*ppmk_rel_path != NULL)
		(*ppmk_rel_path)->AddRef ();
	if (tmp_pmk_other != NULL)
		eif_wean (tmp_pmk_other);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::GetDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [out] */ LPWSTR * ppsz_display_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_pmk_to_left = NULL;
	if (pmk_to_left != NULL)
	{
		tmp_pmk_to_left = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_to_left));
		pmk_to_left->AddRef ();
	}
	EIF_OBJECT tmp_ppsz_display_name = NULL;
	if (ppsz_display_name != NULL)
	{
		tmp_ppsz_display_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_67 (ppsz_display_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_display_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_pmk_to_left != NULL) ? eif_access (tmp_pmk_to_left) : NULL), ((tmp_ppsz_display_name != NULL) ? eif_access (tmp_ppsz_display_name) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_67 (((tmp_ppsz_display_name != NULL) ? eif_wean (tmp_ppsz_display_name) : NULL), ppsz_display_name);
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_pmk_to_left != NULL)
		eif_wean (tmp_pmk_to_left);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::ParseDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ LPWSTR psz_display_name, /* [out] */ ULONG * pch_eaten, /* [out] */ ecom_control_library::IMoniker * * ppmk_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_pmk_to_left = NULL;
	if (pmk_to_left != NULL)
	{
		tmp_pmk_to_left = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_to_left));
		pmk_to_left->AddRef ();
	}
	EIF_OBJECT tmp_psz_display_name = NULL;
	if (psz_display_name != NULL)
	{
		tmp_psz_display_name = eif_protect (rt_ce.ccom_ce_lpwstr (psz_display_name, NULL));
	}
	EIF_OBJECT tmp_pch_eaten = NULL;
	if (pch_eaten != NULL)
	{
		tmp_pch_eaten = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pch_eaten, NULL));
	}
	EIF_OBJECT tmp_ppmk_out = NULL;
	if (ppmk_out != NULL)
	{
		tmp_ppmk_out = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk_out, NULL));
		if (*ppmk_out != NULL)
			(*ppmk_out)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("parse_display_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_pmk_to_left != NULL) ? eif_access (tmp_pmk_to_left) : NULL), ((tmp_psz_display_name != NULL) ? eif_access (tmp_psz_display_name) : NULL), ((tmp_pch_eaten != NULL) ? eif_access (tmp_pch_eaten) : NULL), ((tmp_ppmk_out != NULL) ? eif_access (tmp_ppmk_out) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pch_eaten != NULL) ? eif_wean (tmp_pch_eaten) : NULL), pch_eaten);
	
	if (*ppmk_out != NULL)
		(*ppmk_out)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk_out != NULL) ? eif_wean (tmp_ppmk_out) : NULL), ppmk_out);
	if (*ppmk_out != NULL)
		(*ppmk_out)->AddRef ();
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_pmk_to_left != NULL)
		eif_wean (tmp_pmk_to_left);
	if (tmp_psz_display_name != NULL)
		eif_wean (tmp_psz_display_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::IsSystemMoniker(  /* [out] */ ULONG * pdw_mksys )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pdw_mksys = NULL;
	if (pdw_mksys != NULL)
	{
		tmp_pdw_mksys = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_mksys, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("is_system_moniker", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pdw_mksys != NULL) ? eif_access (tmp_pdw_mksys) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_mksys != NULL) ? eif_wean (tmp_pdw_mksys) : NULL), pdw_mksys);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IMoniker_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IMoniker_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IMoniker_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IMoniker*>(this);
	else if (riid == IID_IMoniker_)
		*ppv = static_cast<ecom_control_library::IMoniker*>(this);
	else if (riid == IID_IPersistStream_)
		*ppv = static_cast<ecom_control_library::IPersistStream*>(this);
	else if (riid == IID_IPersist_)
		*ppv = static_cast<ecom_control_library::IPersist*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif