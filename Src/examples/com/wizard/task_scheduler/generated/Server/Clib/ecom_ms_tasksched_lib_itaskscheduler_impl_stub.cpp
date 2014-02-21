/*-----------------------------------------------------------
Implemented `ITaskScheduler' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_ITaskScheduler_impl_stub.h"
static const IID IID_ITaskScheduler_ = {0x148bd527,0xa2ab,0x11ce,{0xb1,0x1f,0x00,0xaa,0x00,0x53,0x05,0x03}};

ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::ITaskScheduler_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::~ITaskScheduler_impl_stub()
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

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::SetTargetComputer(  /* [in] */ LPWSTR pwsz_computer )

/*-----------------------------------------------------------
	Selects the computer that the ITaskScheduler interface operates on.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_computer = NULL;
	if (pwsz_computer != NULL)
	{
		tmp_pwsz_computer = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_computer, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_target_computer", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_computer != NULL) ? eif_access (tmp_pwsz_computer) : NULL));
	if (tmp_pwsz_computer != NULL)
		eif_wean (tmp_pwsz_computer);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::GetTargetComputer(  /* [out] */ LPWSTR * ppwsz_computer )

/*-----------------------------------------------------------
	Returns the name of the computer on which ITaskScheduler is currently targeted.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_ppwsz_computer = NULL;
	if (ppwsz_computer != NULL)
	{
		tmp_ppwsz_computer = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_54 (ppwsz_computer, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_target_computer", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_ppwsz_computer != NULL) ? eif_access (tmp_ppwsz_computer) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_54 (((tmp_ppwsz_computer != NULL) ? eif_wean (tmp_ppwsz_computer) : NULL), ppwsz_computer);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::Enum(  /* [out] */ ecom_MS_TaskSched_lib::IEnumWorkItems * * pp_enum_work_items )

/*-----------------------------------------------------------
	Retrieves a pointer to an OLE enumerator object that enumerates the tasks in the current task folder.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pp_enum_work_items = NULL;
	if (pp_enum_work_items != NULL)
	{
		tmp_pp_enum_work_items = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_57 (pp_enum_work_items, NULL));
		if (*pp_enum_work_items != NULL)
			(*pp_enum_work_items)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pp_enum_work_items != NULL) ? eif_access (tmp_pp_enum_work_items) : NULL));
	
	if (*pp_enum_work_items != NULL)
		(*pp_enum_work_items)->Release ();
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_57 (((tmp_pp_enum_work_items != NULL) ? eif_wean (tmp_pp_enum_work_items) : NULL), pp_enum_work_items);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::Activate(  /* [in] */ LPWSTR pwsz_name, /* [in] */ GUID * a_riid, /* [out] */ IUnknown * * pp_unk )

/*-----------------------------------------------------------
	Returns an active interface to the specified task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_name = NULL;
	if (pwsz_name != NULL)
	{
		tmp_pwsz_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_name, NULL));
	}
	EIF_OBJECT tmp_a_riid = NULL;
	if (a_riid != NULL)
	{
		tmp_a_riid = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_38 (a_riid));
	}
	EIF_OBJECT tmp_pp_unk = NULL;
	if (pp_unk != NULL)
	{
		tmp_pp_unk = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_58 (pp_unk, NULL));
		if (*pp_unk != NULL)
			(*pp_unk)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("activate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_name != NULL) ? eif_access (tmp_pwsz_name) : NULL), ((tmp_a_riid != NULL) ? eif_access (tmp_a_riid) : NULL), ((tmp_pp_unk != NULL) ? eif_access (tmp_pp_unk) : NULL));
	
	if (*pp_unk != NULL)
		(*pp_unk)->Release ();
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_58 (((tmp_pp_unk != NULL) ? eif_wean (tmp_pp_unk) : NULL), pp_unk);
	if (tmp_pwsz_name != NULL)
		eif_wean (tmp_pwsz_name);
	if (tmp_a_riid != NULL)
		eif_wean (tmp_a_riid);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::Delete(  /* [in] */ LPWSTR pwsz_name )

/*-----------------------------------------------------------
	Deletes a task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_name = NULL;
	if (pwsz_name != NULL)
	{
		tmp_pwsz_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("delete", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_name != NULL) ? eif_access (tmp_pwsz_name) : NULL));
	if (tmp_pwsz_name != NULL)
		eif_wean (tmp_pwsz_name);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::NewWorkItem(  /* [in] */ LPWSTR pwsz_task_name, /* [in] */ GUID * rclsid, /* [in] */ GUID * a_riid, /* [out] */ IUnknown * * pp_unk )

/*-----------------------------------------------------------
	Allocates space for a new task and retrieves its address.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_task_name = NULL;
	if (pwsz_task_name != NULL)
	{
		tmp_pwsz_task_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_task_name, NULL));
	}
	EIF_OBJECT tmp_rclsid = NULL;
	if (rclsid != NULL)
	{
		tmp_rclsid = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_38 (rclsid));
	}
	EIF_OBJECT tmp_a_riid = NULL;
	if (a_riid != NULL)
	{
		tmp_a_riid = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_38 (a_riid));
	}
	EIF_OBJECT tmp_pp_unk = NULL;
	if (pp_unk != NULL)
	{
		tmp_pp_unk = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_59 (pp_unk, NULL));
		if (*pp_unk != NULL)
			(*pp_unk)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("new_work_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_task_name != NULL) ? eif_access (tmp_pwsz_task_name) : NULL), ((tmp_rclsid != NULL) ? eif_access (tmp_rclsid) : NULL), ((tmp_a_riid != NULL) ? eif_access (tmp_a_riid) : NULL), ((tmp_pp_unk != NULL) ? eif_access (tmp_pp_unk) : NULL));
	
	if (*pp_unk != NULL)
		(*pp_unk)->Release ();
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_59 (((tmp_pp_unk != NULL) ? eif_wean (tmp_pp_unk) : NULL), pp_unk);
	if (tmp_pwsz_task_name != NULL)
		eif_wean (tmp_pwsz_task_name);
	if (tmp_rclsid != NULL)
		eif_wean (tmp_rclsid);
	if (tmp_a_riid != NULL)
		eif_wean (tmp_a_riid);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::AddWorkItem(  /* [in] */ LPWSTR pwsz_task_name, /* [in] */ ecom_MS_TaskSched_lib::IScheduledWorkItem * p_work_item )

/*-----------------------------------------------------------
	Adds a task to the schedule of tasks.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_task_name = NULL;
	if (pwsz_task_name != NULL)
	{
		tmp_pwsz_task_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_task_name, NULL));
	}
	EIF_OBJECT tmp_p_work_item = NULL;
	if (p_work_item != NULL)
	{
		tmp_p_work_item = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_interface_61 (p_work_item));
		p_work_item->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_work_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_task_name != NULL) ? eif_access (tmp_pwsz_task_name) : NULL), ((tmp_p_work_item != NULL) ? eif_access (tmp_p_work_item) : NULL));
	if (tmp_pwsz_task_name != NULL)
		eif_wean (tmp_pwsz_task_name);
	if (tmp_p_work_item != NULL)
		eif_wean (tmp_p_work_item);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::IsOfType(  /* [in] */ LPWSTR pwsz_name, /* [in] */ GUID * a_riid )

/*-----------------------------------------------------------
	Checks the object type.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_name = NULL;
	if (pwsz_name != NULL)
	{
		tmp_pwsz_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_name, NULL));
	}
	EIF_OBJECT tmp_a_riid = NULL;
	if (a_riid != NULL)
	{
		tmp_a_riid = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_38 (a_riid));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("is_of_type", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_name != NULL) ? eif_access (tmp_pwsz_name) : NULL), ((tmp_a_riid != NULL) ? eif_access (tmp_a_riid) : NULL));
	if (tmp_pwsz_name != NULL)
		eif_wean (tmp_pwsz_name);
	if (tmp_a_riid != NULL)
		eif_wean (tmp_a_riid);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	 return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITaskScheduler_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_MS_TaskSched_lib::ITaskScheduler*>(this);
	else if (riid == IID_ITaskScheduler_)
		*ppv = static_cast<ecom_MS_TaskSched_lib::ITaskScheduler*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


