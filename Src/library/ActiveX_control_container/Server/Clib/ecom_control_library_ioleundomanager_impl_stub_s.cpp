/*-----------------------------------------------------------
Implemented `IOleUndoManager' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleUndoManager_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleUndoManager_ = {0xd001f200,0xef97,0x11ce,{0x9b,0xc9,0x00,0xaa,0x00,0x60,0x8e,0x01}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleUndoManager_impl_stub::IOleUndoManager_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleUndoManager_impl_stub::~IOleUndoManager_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::Open(  /* [in] */ ecom_control_library::IOleParentUndoUnit * p_puu )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_puu = NULL;
	if (p_puu != NULL)
	{
		tmp_p_puu = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_170 (p_puu));
		p_puu->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("open", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_puu != NULL) ? eif_access (tmp_p_puu) : NULL));
	if (tmp_p_puu != NULL)
		eif_wean (tmp_p_puu);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::Close(  /* [in] */ ecom_control_library::IOleParentUndoUnit * p_puu, /* [in] */ LONG f_commit )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_puu = NULL;
	if (p_puu != NULL)
	{
		tmp_p_puu = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_170 (p_puu));
		p_puu->AddRef ();
	}
	EIF_INTEGER tmp_f_commit = (EIF_INTEGER)f_commit;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("close", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_puu != NULL) ? eif_access (tmp_p_puu) : NULL), (EIF_INTEGER)tmp_f_commit);
	if (tmp_p_puu != NULL)
		eif_wean (tmp_p_puu);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::Add(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_uu = NULL;
	if (p_uu != NULL)
	{
		tmp_p_uu = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_159 (p_uu));
		p_uu->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_uu != NULL) ? eif_access (tmp_p_uu) : NULL));
	if (tmp_p_uu != NULL)
		eif_wean (tmp_p_uu);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::GetOpenParentState(  /* [out] */ ULONG * pdw_state )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pdw_state = NULL;
	if (pdw_state != NULL)
	{
		tmp_pdw_state = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_state, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_open_parent_state", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pdw_state != NULL) ? eif_access (tmp_pdw_state) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_state != NULL) ? eif_wean (tmp_pdw_state) : NULL), pdw_state);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::DiscardFrom(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_uu = NULL;
	if (p_uu != NULL)
	{
		tmp_p_uu = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_159 (p_uu));
		p_uu->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("discard_from", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_uu != NULL) ? eif_access (tmp_p_uu) : NULL));
	if (tmp_p_uu != NULL)
		eif_wean (tmp_p_uu);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::UndoTo(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_uu = NULL;
	if (p_uu != NULL)
	{
		tmp_p_uu = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_159 (p_uu));
		p_uu->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("undo_to", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_uu != NULL) ? eif_access (tmp_p_uu) : NULL));
	if (tmp_p_uu != NULL)
		eif_wean (tmp_p_uu);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::RedoTo(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_uu = NULL;
	if (p_uu != NULL)
	{
		tmp_p_uu = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_159 (p_uu));
		p_uu->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("redo_to", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_uu != NULL) ? eif_access (tmp_p_uu) : NULL));
	if (tmp_p_uu != NULL)
		eif_wean (tmp_p_uu);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::EnumUndoable(  /* [out] */ ecom_control_library::IEnumOleUndoUnits * * ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum = NULL;
	if (ppenum != NULL)
	{
		tmp_ppenum = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_164 (ppenum, NULL));
		if (*ppenum != NULL)
			(*ppenum)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_undoable", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
	
	if (*ppenum != NULL)
		(*ppenum)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_164 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
	if (*ppenum != NULL)
		(*ppenum)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::EnumRedoable(  /* [out] */ ecom_control_library::IEnumOleUndoUnits * * ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum = NULL;
	if (ppenum != NULL)
	{
		tmp_ppenum = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_164 (ppenum, NULL));
		if (*ppenum != NULL)
			(*ppenum)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_redoable", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
	
	if (*ppenum != NULL)
		(*ppenum)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_164 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
	if (*ppenum != NULL)
		(*ppenum)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::GetLastUndoDescription(  /* [out] */ BSTR * p_bstr )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_bstr = NULL;
	if (p_bstr != NULL)
	{
		tmp_p_bstr = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_172 (p_bstr, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_last_undo_description", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_bstr != NULL) ? eif_access (tmp_p_bstr) : NULL));
	
	if (*p_bstr != NULL)
		rt_ce.free_memory_bstr (*p_bstr);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_172 (((tmp_p_bstr != NULL) ? eif_wean (tmp_p_bstr) : NULL), p_bstr);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::GetLastRedoDescription(  /* [out] */ BSTR * p_bstr )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_bstr = NULL;
	if (p_bstr != NULL)
	{
		tmp_p_bstr = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_173 (p_bstr, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_last_redo_description", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_bstr != NULL) ? eif_access (tmp_p_bstr) : NULL));
	
	if (*p_bstr != NULL)
		rt_ce.free_memory_bstr (*p_bstr);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_173 (((tmp_p_bstr != NULL) ? eif_wean (tmp_p_bstr) : NULL), p_bstr);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::Enable(  /* [in] */ LONG f_enable )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_enable = (EIF_INTEGER)f_enable;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enable", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_enable);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleUndoManager_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleUndoManager_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleUndoManager_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleUndoManager*>(this);
	else if (riid == IID_IOleUndoManager_)
		*ppv = static_cast<ecom_control_library::IOleUndoManager*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif