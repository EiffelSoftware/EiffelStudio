/*-----------------------------------------------------------
Implemented `ITaskTrigger' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_ITaskTrigger_impl_stub.h"
static const IID IID_ITaskTrigger_ = {0x148bd52b,0xa2ab,0x11ce,{0xb1,0x1f,0x00,0xaa,0x00,0x53,0x05,0x03}};

ecom_MS_TaskSched_lib::ITaskTrigger_impl_stub::ITaskTrigger_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::ITaskTrigger_impl_stub::~ITaskTrigger_impl_stub()
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_PROC_STUB;

	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	ECOM_EXIT_PROC_STUB;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskTrigger_impl_stub::SetTrigger(  /* [in] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger )

/*-----------------------------------------------------------
	Sets the task trigger values.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_p_trigger = NULL;
	if (p_trigger != NULL)
	{
		tmp_p_trigger = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_alias_ptask_trigger_alias40 (p_trigger));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_trigger", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_p_trigger != NULL) ? eif_access (tmp_p_trigger) : NULL));
	if (tmp_p_trigger != NULL)
		eif_wean (tmp_p_trigger);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskTrigger_impl_stub::GetTrigger(  /* [out] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger )

/*-----------------------------------------------------------
	Retrieves the current task trigger.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_p_trigger = NULL;
	if (p_trigger != NULL)
	{
		tmp_p_trigger = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_alias_ptask_trigger_alias40 (p_trigger));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_trigger", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_p_trigger != NULL) ? eif_access (tmp_p_trigger) : NULL));
	if (tmp_p_trigger != NULL)
		eif_wean (tmp_p_trigger);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskTrigger_impl_stub::GetTriggerString(  /* [out] */ LPWSTR * ppwsz_trigger )

/*-----------------------------------------------------------
	Retrieves the current task trigger in the form of a string.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_ppwsz_trigger = NULL;
	if (ppwsz_trigger != NULL)
	{
		tmp_ppwsz_trigger = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_43 (ppwsz_trigger, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_trigger_string", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_ppwsz_trigger != NULL) ? eif_access (tmp_ppwsz_trigger) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_43 (((tmp_ppwsz_trigger != NULL) ? eif_wean (tmp_ppwsz_trigger) : NULL), ppwsz_trigger);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::ITaskTrigger_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res == 0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::ITaskTrigger_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	 return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskTrigger_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_MS_TaskSched_lib::ITaskTrigger*>(this);
	else if (riid == IID_ITaskTrigger_)
		*ppv = static_cast<ecom_MS_TaskSched_lib::ITaskTrigger*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


