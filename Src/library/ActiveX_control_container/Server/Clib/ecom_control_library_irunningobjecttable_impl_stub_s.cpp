/*-----------------------------------------------------------
Implemented `IRunningObjectTable' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IRunningObjectTable_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IRunningObjectTable_ = {0x00000010,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IRunningObjectTable_impl_stub::IRunningObjectTable_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IRunningObjectTable_impl_stub::~IRunningObjectTable_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IRunningObjectTable_impl_stub::Register(  /* [in] */ ULONG grf_flags, /* [in] */ IUnknown * punk_object, /* [in] */ ecom_control_library::IMoniker * pmk_object_name, /* [out] */ ULONG * pdw_register )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_grf_flags = (EIF_INTEGER)grf_flags;
	EIF_OBJECT tmp_punk_object = NULL;
	if (punk_object != NULL)
	{
		tmp_punk_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (punk_object));
		punk_object->AddRef ();
	}
	EIF_OBJECT tmp_pmk_object_name = NULL;
	if (pmk_object_name != NULL)
	{
		tmp_pmk_object_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_object_name));
		pmk_object_name->AddRef ();
	}
	EIF_OBJECT tmp_pdw_register = NULL;
	if (pdw_register != NULL)
	{
		tmp_pdw_register = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_register, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("register", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_grf_flags, ((tmp_punk_object != NULL) ? eif_access (tmp_punk_object) : NULL), ((tmp_pmk_object_name != NULL) ? eif_access (tmp_pmk_object_name) : NULL), ((tmp_pdw_register != NULL) ? eif_access (tmp_pdw_register) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_register != NULL) ? eif_wean (tmp_pdw_register) : NULL), pdw_register);
	if (tmp_punk_object != NULL)
		eif_wean (tmp_punk_object);
	if (tmp_pmk_object_name != NULL)
		eif_wean (tmp_pmk_object_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IRunningObjectTable_impl_stub::Revoke(  /* [in] */ ULONG dw_register )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_register = (EIF_INTEGER)dw_register;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("revoke", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_register);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IRunningObjectTable_impl_stub::IsRunning(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pmk_object_name = NULL;
	if (pmk_object_name != NULL)
	{
		tmp_pmk_object_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_object_name));
		pmk_object_name->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("is_running", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk_object_name != NULL) ? eif_access (tmp_pmk_object_name) : NULL));
	if (tmp_pmk_object_name != NULL)
		eif_wean (tmp_pmk_object_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IRunningObjectTable_impl_stub::GetObject(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name, /* [out] */ IUnknown * * ppunk_object )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pmk_object_name = NULL;
	if (pmk_object_name != NULL)
	{
		tmp_pmk_object_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_object_name));
		pmk_object_name->AddRef ();
	}
	EIF_OBJECT tmp_ppunk_object = NULL;
	if (ppunk_object != NULL)
	{
		tmp_ppunk_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_101 (ppunk_object, NULL));
		if (*ppunk_object != NULL)
			(*ppunk_object)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_object", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk_object_name != NULL) ? eif_access (tmp_pmk_object_name) : NULL), ((tmp_ppunk_object != NULL) ? eif_access (tmp_ppunk_object) : NULL));
	
	if (*ppunk_object != NULL)
		(*ppunk_object)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_101 (((tmp_ppunk_object != NULL) ? eif_wean (tmp_ppunk_object) : NULL), ppunk_object);
	if (*ppunk_object != NULL)
		(*ppunk_object)->AddRef ();
	if (tmp_pmk_object_name != NULL)
		eif_wean (tmp_pmk_object_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IRunningObjectTable_impl_stub::NoteChangeTime(  /* [in] */ ULONG dw_register, /* [in] */ ecom_control_library::_FILETIME * pfiletime )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_register = (EIF_INTEGER)dw_register;
	EIF_OBJECT tmp_pfiletime = NULL;
	if (pfiletime != NULL)
	{
		tmp_pfiletime = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_66 (pfiletime));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("note_change_time", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_register, ((tmp_pfiletime != NULL) ? eif_access (tmp_pfiletime) : NULL));
	if (tmp_pfiletime != NULL)
		eif_wean (tmp_pfiletime);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IRunningObjectTable_impl_stub::GetTimeOfLastChange(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name, /* [out] */ ecom_control_library::_FILETIME * pfiletime )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pmk_object_name = NULL;
	if (pmk_object_name != NULL)
	{
		tmp_pmk_object_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk_object_name));
		pmk_object_name->AddRef ();
	}
	EIF_OBJECT tmp_pfiletime = NULL;
	if (pfiletime != NULL)
	{
		tmp_pfiletime = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_66 (pfiletime));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_time_of_last_change", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk_object_name != NULL) ? eif_access (tmp_pmk_object_name) : NULL), ((tmp_pfiletime != NULL) ? eif_access (tmp_pfiletime) : NULL));
	
	if (tmp_pmk_object_name != NULL)
		eif_wean (tmp_pmk_object_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IRunningObjectTable_impl_stub::EnumRunning(  /* [out] */ ecom_control_library::IEnumMoniker * * ppenum_moniker )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum_moniker = NULL;
	if (ppenum_moniker != NULL)
	{
		tmp_ppenum_moniker = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_63 (ppenum_moniker, NULL));
		if (*ppenum_moniker != NULL)
			(*ppenum_moniker)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_running", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum_moniker != NULL) ? eif_access (tmp_ppenum_moniker) : NULL));
	
	if (*ppenum_moniker != NULL)
		(*ppenum_moniker)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_63 (((tmp_ppenum_moniker != NULL) ? eif_wean (tmp_ppenum_moniker) : NULL), ppenum_moniker);
	if (*ppenum_moniker != NULL)
		(*ppenum_moniker)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IRunningObjectTable_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IRunningObjectTable_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IRunningObjectTable_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IRunningObjectTable*>(this);
	else if (riid == IID_IRunningObjectTable_)
		*ppv = static_cast<ecom_control_library::IRunningObjectTable*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif