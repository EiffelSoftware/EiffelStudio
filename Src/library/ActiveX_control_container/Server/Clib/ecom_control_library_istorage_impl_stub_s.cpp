/*-----------------------------------------------------------
Implemented `IStorage' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IStorage_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IStorage_ = {0x0000000b,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IStorage_impl_stub::IStorage_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IStorage_impl_stub::~IStorage_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::CreateStream(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ULONG grf_mode, /* [in] */ ULONG reserved1, /* [in] */ ULONG reserved2, /* [out] */ ecom_control_library::IStream * * ppstm )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pwcs_name = NULL;
	if (pwcs_name != NULL)
	{
		tmp_pwcs_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_name, NULL));
	}
	EIF_INTEGER tmp_grf_mode = (EIF_INTEGER)grf_mode;
	EIF_INTEGER tmp_reserved1 = (EIF_INTEGER)reserved1;
	EIF_INTEGER tmp_reserved2 = (EIF_INTEGER)reserved2;
	EIF_OBJECT tmp_ppstm = NULL;
	if (ppstm != NULL)
	{
		tmp_ppstm = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_77 (ppstm, NULL));
		if (*ppstm != NULL)
			(*ppstm)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("create_stream", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pwcs_name != NULL) ? eif_access (tmp_pwcs_name) : NULL), (EIF_INTEGER)tmp_grf_mode, (EIF_INTEGER)tmp_reserved1, (EIF_INTEGER)tmp_reserved2, ((tmp_ppstm != NULL) ? eif_access (tmp_ppstm) : NULL));
	
	if (*ppstm != NULL)
		(*ppstm)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_77 (((tmp_ppstm != NULL) ? eif_wean (tmp_ppstm) : NULL), ppstm);
	if (*ppstm != NULL)
		(*ppstm)->AddRef ();
	if (tmp_pwcs_name != NULL)
		eif_wean (tmp_pwcs_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::RemoteOpenStream(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ULONG cb_reserved1, /* [in] */ UCHAR * reserved1, /* [in] */ ULONG grf_mode, /* [in] */ ULONG reserved2, /* [out] */ ecom_control_library::IStream * * ppstm )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pwcs_name = NULL;
	if (pwcs_name != NULL)
	{
		tmp_pwcs_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_name, NULL));
	}
	EIF_INTEGER tmp_cb_reserved1 = (EIF_INTEGER)cb_reserved1;
	EIF_OBJECT tmp_reserved1 = NULL;
	if (reserved1 != NULL)
	{
		tmp_reserved1 = eif_protect (rt_ce.ccom_ce_pointed_unsigned_character (reserved1, NULL));
	}
	EIF_INTEGER tmp_grf_mode = (EIF_INTEGER)grf_mode;
	EIF_INTEGER tmp_reserved2 = (EIF_INTEGER)reserved2;
	EIF_OBJECT tmp_ppstm = NULL;
	if (ppstm != NULL)
	{
		tmp_ppstm = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_77 (ppstm, NULL));
		if (*ppstm != NULL)
			(*ppstm)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_open_stream", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pwcs_name != NULL) ? eif_access (tmp_pwcs_name) : NULL), (EIF_INTEGER)tmp_cb_reserved1, ((tmp_reserved1 != NULL) ? eif_access (tmp_reserved1) : NULL), (EIF_INTEGER)tmp_grf_mode, (EIF_INTEGER)tmp_reserved2, ((tmp_ppstm != NULL) ? eif_access (tmp_ppstm) : NULL));
	
	if (*ppstm != NULL)
		(*ppstm)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_77 (((tmp_ppstm != NULL) ? eif_wean (tmp_ppstm) : NULL), ppstm);
	if (*ppstm != NULL)
		(*ppstm)->AddRef ();
	if (tmp_pwcs_name != NULL)
		eif_wean (tmp_pwcs_name);
	if (tmp_reserved1 != NULL)
		eif_wean (tmp_reserved1);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::CreateStorage(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ULONG grf_mode, /* [in] */ ULONG reserved1, /* [in] */ ULONG reserved2, /* [out] */ ecom_control_library::IStorage * * ppstg )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pwcs_name = NULL;
	if (pwcs_name != NULL)
	{
		tmp_pwcs_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_name, NULL));
	}
	EIF_INTEGER tmp_grf_mode = (EIF_INTEGER)grf_mode;
	EIF_INTEGER tmp_reserved1 = (EIF_INTEGER)reserved1;
	EIF_INTEGER tmp_reserved2 = (EIF_INTEGER)reserved2;
	EIF_OBJECT tmp_ppstg = NULL;
	if (ppstg != NULL)
	{
		tmp_ppstg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_282 (ppstg, NULL));
		if (*ppstg != NULL)
			(*ppstg)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("create_storage", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pwcs_name != NULL) ? eif_access (tmp_pwcs_name) : NULL), (EIF_INTEGER)tmp_grf_mode, (EIF_INTEGER)tmp_reserved1, (EIF_INTEGER)tmp_reserved2, ((tmp_ppstg != NULL) ? eif_access (tmp_ppstg) : NULL));
	
	if (*ppstg != NULL)
		(*ppstg)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_282 (((tmp_ppstg != NULL) ? eif_wean (tmp_ppstg) : NULL), ppstg);
	if (*ppstg != NULL)
		(*ppstg)->AddRef ();
	if (tmp_pwcs_name != NULL)
		eif_wean (tmp_pwcs_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::OpenStorage(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ecom_control_library::IStorage * pstg_priority, /* [in] */ ULONG grf_mode, /* [in] */ ecom_control_library::wireSNB snb_exclude, /* [in] */ ULONG reserved, /* [out] */ ecom_control_library::IStorage * * ppstg )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pwcs_name = NULL;
	if (pwcs_name != NULL)
	{
		tmp_pwcs_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_name, NULL));
	}
	EIF_OBJECT tmp_pstg_priority = NULL;
	if (pstg_priority != NULL)
	{
		tmp_pstg_priority = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_280 (pstg_priority));
		pstg_priority->AddRef ();
	}
	EIF_INTEGER tmp_grf_mode = (EIF_INTEGER)grf_mode;
	EIF_OBJECT tmp_snb_exclude = NULL;
	if (snb_exclude != NULL)
	{
		tmp_snb_exclude = eif_protect (grt_ce_control_interfaces2.ccom_ce_alias_wire_snb_alias283 (snb_exclude));
	}
	EIF_INTEGER tmp_reserved = (EIF_INTEGER)reserved;
	EIF_OBJECT tmp_ppstg = NULL;
	if (ppstg != NULL)
	{
		tmp_ppstg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_282 (ppstg, NULL));
		if (*ppstg != NULL)
			(*ppstg)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("open_storage", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pwcs_name != NULL) ? eif_access (tmp_pwcs_name) : NULL), ((tmp_pstg_priority != NULL) ? eif_access (tmp_pstg_priority) : NULL), (EIF_INTEGER)tmp_grf_mode, ((tmp_snb_exclude != NULL) ? eif_access (tmp_snb_exclude) : NULL), (EIF_INTEGER)tmp_reserved, ((tmp_ppstg != NULL) ? eif_access (tmp_ppstg) : NULL));
	
	if (*ppstg != NULL)
		(*ppstg)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_282 (((tmp_ppstg != NULL) ? eif_wean (tmp_ppstg) : NULL), ppstg);
	if (*ppstg != NULL)
		(*ppstg)->AddRef ();
	if (tmp_pwcs_name != NULL)
		eif_wean (tmp_pwcs_name);
	if (tmp_pstg_priority != NULL)
		eif_wean (tmp_pstg_priority);
	if (tmp_snb_exclude != NULL)
		eif_wean (tmp_snb_exclude);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::CopyTo(  /* [in] */ ULONG ciid_exclude, /* [in] */ GUID * rgiid_exclude, /* [in] */ ecom_control_library::wireSNB snb_exclude, /* [in] */ ecom_control_library::IStorage * pstg_dest )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_ciid_exclude = (EIF_INTEGER)ciid_exclude;
	EIF_OBJECT tmp_rgiid_exclude = NULL;
	if (rgiid_exclude != NULL)
	{
		tmp_rgiid_exclude = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (rgiid_exclude));
	}
	EIF_OBJECT tmp_snb_exclude = NULL;
	if (snb_exclude != NULL)
	{
		tmp_snb_exclude = eif_protect (grt_ce_control_interfaces2.ccom_ce_alias_wire_snb_alias283 (snb_exclude));
	}
	EIF_OBJECT tmp_pstg_dest = NULL;
	if (pstg_dest != NULL)
	{
		tmp_pstg_dest = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_280 (pstg_dest));
		pstg_dest->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("copy_to", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_ciid_exclude, ((tmp_rgiid_exclude != NULL) ? eif_access (tmp_rgiid_exclude) : NULL), ((tmp_snb_exclude != NULL) ? eif_access (tmp_snb_exclude) : NULL), ((tmp_pstg_dest != NULL) ? eif_access (tmp_pstg_dest) : NULL));
	if (tmp_rgiid_exclude != NULL)
		eif_wean (tmp_rgiid_exclude);
	if (tmp_snb_exclude != NULL)
		eif_wean (tmp_snb_exclude);
	if (tmp_pstg_dest != NULL)
		eif_wean (tmp_pstg_dest);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::MoveElementTo(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ecom_control_library::IStorage * pstg_dest, /* [in] */ LPWSTR pwcs_new_name, /* [in] */ ULONG grf_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pwcs_name = NULL;
	if (pwcs_name != NULL)
	{
		tmp_pwcs_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_name, NULL));
	}
	EIF_OBJECT tmp_pstg_dest = NULL;
	if (pstg_dest != NULL)
	{
		tmp_pstg_dest = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_280 (pstg_dest));
		pstg_dest->AddRef ();
	}
	EIF_OBJECT tmp_pwcs_new_name = NULL;
	if (pwcs_new_name != NULL)
	{
		tmp_pwcs_new_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_new_name, NULL));
	}
	EIF_INTEGER tmp_grf_flags = (EIF_INTEGER)grf_flags;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("move_element_to", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pwcs_name != NULL) ? eif_access (tmp_pwcs_name) : NULL), ((tmp_pstg_dest != NULL) ? eif_access (tmp_pstg_dest) : NULL), ((tmp_pwcs_new_name != NULL) ? eif_access (tmp_pwcs_new_name) : NULL), (EIF_INTEGER)tmp_grf_flags);
	if (tmp_pwcs_name != NULL)
		eif_wean (tmp_pwcs_name);
	if (tmp_pstg_dest != NULL)
		eif_wean (tmp_pstg_dest);
	if (tmp_pwcs_new_name != NULL)
		eif_wean (tmp_pwcs_new_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::Commit(  /* [in] */ ULONG grf_commit_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_grf_commit_flags = (EIF_INTEGER)grf_commit_flags;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("commit", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_grf_commit_flags);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::Revert( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("revert", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::RemoteEnumElements(  /* [in] */ ULONG reserved1, /* [in] */ ULONG cb_reserved2, /* [in] */ UCHAR * reserved2, /* [in] */ ULONG reserved3, /* [out] */ ecom_control_library::IEnumSTATSTG * * ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_reserved1 = (EIF_INTEGER)reserved1;
	EIF_INTEGER tmp_cb_reserved2 = (EIF_INTEGER)cb_reserved2;
	EIF_OBJECT tmp_reserved2 = NULL;
	if (reserved2 != NULL)
	{
		tmp_reserved2 = eif_protect (rt_ce.ccom_ce_pointed_unsigned_character (reserved2, NULL));
	}
	EIF_INTEGER tmp_reserved3 = (EIF_INTEGER)reserved3;
	EIF_OBJECT tmp_ppenum = NULL;
	if (ppenum != NULL)
	{
		tmp_ppenum = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_289 (ppenum, NULL));
		if (*ppenum != NULL)
			(*ppenum)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_enum_elements", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_reserved1, (EIF_INTEGER)tmp_cb_reserved2, ((tmp_reserved2 != NULL) ? eif_access (tmp_reserved2) : NULL), (EIF_INTEGER)tmp_reserved3, ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
	
	if (*ppenum != NULL)
		(*ppenum)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_289 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
	if (*ppenum != NULL)
		(*ppenum)->AddRef ();
	if (tmp_reserved2 != NULL)
		eif_wean (tmp_reserved2);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::DestroyElement(  /* [in] */ LPWSTR pwcs_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pwcs_name = NULL;
	if (pwcs_name != NULL)
	{
		tmp_pwcs_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("destroy_element", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pwcs_name != NULL) ? eif_access (tmp_pwcs_name) : NULL));
	if (tmp_pwcs_name != NULL)
		eif_wean (tmp_pwcs_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::RenameElement(  /* [in] */ LPWSTR pwcs_old_name, /* [in] */ LPWSTR pwcs_new_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pwcs_old_name = NULL;
	if (pwcs_old_name != NULL)
	{
		tmp_pwcs_old_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_old_name, NULL));
	}
	EIF_OBJECT tmp_pwcs_new_name = NULL;
	if (pwcs_new_name != NULL)
	{
		tmp_pwcs_new_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_new_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("rename_element", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pwcs_old_name != NULL) ? eif_access (tmp_pwcs_old_name) : NULL), ((tmp_pwcs_new_name != NULL) ? eif_access (tmp_pwcs_new_name) : NULL));
	if (tmp_pwcs_old_name != NULL)
		eif_wean (tmp_pwcs_old_name);
	if (tmp_pwcs_new_name != NULL)
		eif_wean (tmp_pwcs_new_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::SetElementTimes(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ecom_control_library::_FILETIME * pctime, /* [in] */ ecom_control_library::_FILETIME * patime, /* [in] */ ecom_control_library::_FILETIME * pmtime )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pwcs_name = NULL;
	if (pwcs_name != NULL)
	{
		tmp_pwcs_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwcs_name, NULL));
	}
	EIF_OBJECT tmp_pctime = NULL;
	if (pctime != NULL)
	{
		tmp_pctime = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_66 (pctime));
	}
	EIF_OBJECT tmp_patime = NULL;
	if (patime != NULL)
	{
		tmp_patime = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_66 (patime));
	}
	EIF_OBJECT tmp_pmtime = NULL;
	if (pmtime != NULL)
	{
		tmp_pmtime = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_66 (pmtime));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_element_times", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pwcs_name != NULL) ? eif_access (tmp_pwcs_name) : NULL), ((tmp_pctime != NULL) ? eif_access (tmp_pctime) : NULL), ((tmp_patime != NULL) ? eif_access (tmp_patime) : NULL), ((tmp_pmtime != NULL) ? eif_access (tmp_pmtime) : NULL));
	if (tmp_pwcs_name != NULL)
		eif_wean (tmp_pwcs_name);
	if (tmp_pctime != NULL)
		eif_wean (tmp_pctime);
	if (tmp_patime != NULL)
		eif_wean (tmp_patime);
	if (tmp_pmtime != NULL)
		eif_wean (tmp_pmtime);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::SetClass(  /* [in] */ GUID * clsid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_clsid = NULL;
	if (clsid != NULL)
	{
		tmp_clsid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (clsid));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_class", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_clsid != NULL) ? eif_access (tmp_clsid) : NULL));
	if (tmp_clsid != NULL)
		eif_wean (tmp_clsid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::SetStateBits(  /* [in] */ ULONG grf_state_bits, /* [in] */ ULONG grf_mask )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_grf_state_bits = (EIF_INTEGER)grf_state_bits;
	EIF_INTEGER tmp_grf_mask = (EIF_INTEGER)grf_mask;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_state_bits", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_grf_state_bits, (EIF_INTEGER)tmp_grf_mask);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::Stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg, /* [in] */ ULONG grf_stat_flag )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pstatstg = NULL;
	if (pstatstg != NULL)
	{
		tmp_pstatstg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_76 (pstatstg));
	}
	EIF_INTEGER tmp_grf_stat_flag = (EIF_INTEGER)grf_stat_flag;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("stat", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pstatstg != NULL) ? eif_access (tmp_pstatstg) : NULL), (EIF_INTEGER)tmp_grf_stat_flag);
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IStorage_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IStorage_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IStorage_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IStorage*>(this);
	else if (riid == IID_IStorage_)
		*ppv = static_cast<ecom_control_library::IStorage*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif