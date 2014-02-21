/*-----------------------------------------------------------
Implemented `ITask' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_ITask_impl_stub.h"
static const IID IID_ITask_ = {0x148bd524,0xa2ab,0x11ce,{0xb1,0x1f,0x00,0xaa,0x00,0x53,0x05,0x03}};

static const IID IID_IScheduledWorkItem_ = {0xa6b952f0,0xa4b1,0x11d0,{0x99,0x7d,0x00,0xaa,0x00,0x68,0x87,0xec}};

ecom_MS_TaskSched_lib::ITask_impl_stub::ITask_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::ITask_impl_stub::~ITask_impl_stub()
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

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::CreateTrigger(  /* [out] */ USHORT * pi_new_trigger, /* [out] */ ecom_MS_TaskSched_lib::ITaskTrigger * * pp_trigger )

/*-----------------------------------------------------------
	Creates a trigger using a work item object.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pi_new_trigger = NULL;
	if (pi_new_trigger != NULL)
	{
		tmp_pi_new_trigger = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (pi_new_trigger, NULL));
	}
	EIF_OBJECT tmp_pp_trigger = NULL;
	if (pp_trigger != NULL)
	{
		tmp_pp_trigger = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_4 (pp_trigger, NULL));
		if (*pp_trigger != NULL)
			(*pp_trigger)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("create_trigger", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pi_new_trigger != NULL) ? eif_access (tmp_pi_new_trigger) : NULL), ((tmp_pp_trigger != NULL) ? eif_access (tmp_pp_trigger) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_pi_new_trigger != NULL) ? eif_wean (tmp_pi_new_trigger) : NULL), pi_new_trigger);
	
	if (*pp_trigger != NULL)
		(*pp_trigger)->Release ();
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_4 (((tmp_pp_trigger != NULL) ? eif_wean (tmp_pp_trigger) : NULL), pp_trigger);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::DeleteTrigger(  /* [in] */ USHORT i_trigger )

/*-----------------------------------------------------------
	Deletes a trigger from a work item. 
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_i_trigger = (EIF_INTEGER)i_trigger;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("delete_trigger", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_i_trigger);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetTriggerCount(  /* [out] */ USHORT * pw_count )

/*-----------------------------------------------------------
	Retrieves the number of triggers associated with a work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pw_count = NULL;
	if (pw_count != NULL)
	{
		tmp_pw_count = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (pw_count, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_trigger_count", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pw_count != NULL) ? eif_access (tmp_pw_count) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_pw_count != NULL) ? eif_wean (tmp_pw_count) : NULL), pw_count);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetTrigger(  /* [in] */ USHORT i_trigger, /* [out] */ ecom_MS_TaskSched_lib::ITaskTrigger * * pp_trigger )

/*-----------------------------------------------------------
	Retrieves a trigger structure.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_i_trigger = (EIF_INTEGER)i_trigger;
	EIF_OBJECT tmp_pp_trigger = NULL;
	if (pp_trigger != NULL)
	{
		tmp_pp_trigger = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_4 (pp_trigger, NULL));
		if (*pp_trigger != NULL)
			(*pp_trigger)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_trigger", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_i_trigger, ((tmp_pp_trigger != NULL) ? eif_access (tmp_pp_trigger) : NULL));
	
	if (*pp_trigger != NULL)
		(*pp_trigger)->Release ();
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_4 (((tmp_pp_trigger != NULL) ? eif_wean (tmp_pp_trigger) : NULL), pp_trigger);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetTriggerString(  /* [in] */ USHORT i_trigger, /* [out] */ LPWSTR * ppwsz_trigger )

/*-----------------------------------------------------------
	Retrieves a trigger string.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_i_trigger = (EIF_INTEGER)i_trigger;
	EIF_OBJECT tmp_ppwsz_trigger = NULL;
	if (ppwsz_trigger != NULL)
	{
		tmp_ppwsz_trigger = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_6 (ppwsz_trigger, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_trigger_string", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_i_trigger, ((tmp_ppwsz_trigger != NULL) ? eif_access (tmp_ppwsz_trigger) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_6 (((tmp_ppwsz_trigger != NULL) ? eif_wean (tmp_ppwsz_trigger) : NULL), ppwsz_trigger);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetRunTimes(  /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_begin, /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_end, /* [in, out] */ USHORT * p_count, /* [out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * * rgst_task_times )

/*-----------------------------------------------------------
	Retrieves the work item run times for a specified time period.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pst_begin = NULL;
	if (pst_begin != NULL)
	{
		tmp_pst_begin = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_8 (pst_begin));
	}
	EIF_OBJECT tmp_pst_end = NULL;
	if (pst_end != NULL)
	{
		tmp_pst_end = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_8 (pst_end));
	}
	EIF_OBJECT tmp_p_count = NULL;
	if (p_count != NULL)
	{
		tmp_p_count = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (p_count, NULL));
	}
	EIF_OBJECT tmp_rgst_task_times = NULL;
	if (rgst_task_times != NULL)
	{
		tmp_rgst_task_times = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_10 (rgst_task_times, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_run_times", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pst_begin != NULL) ? eif_access (tmp_pst_begin) : NULL), ((tmp_pst_end != NULL) ? eif_access (tmp_pst_end) : NULL), ((tmp_p_count != NULL) ? eif_access (tmp_p_count) : NULL), ((tmp_rgst_task_times != NULL) ? eif_access (tmp_rgst_task_times) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_p_count != NULL) ? eif_wean (tmp_p_count) : NULL), p_count);
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_10 (((tmp_rgst_task_times != NULL) ? eif_wean (tmp_rgst_task_times) : NULL), rgst_task_times);
	if (tmp_pst_begin != NULL)
		eif_wean (tmp_pst_begin);
	if (tmp_pst_end != NULL)
		eif_wean (tmp_pst_end);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetNextRunTime(  /* [in, out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_next_run )

/*-----------------------------------------------------------
	Retrieves the next time the work item will run.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pst_next_run = NULL;
	if (pst_next_run != NULL)
	{
		tmp_pst_next_run = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_8 (pst_next_run));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_next_run_time", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pst_next_run != NULL) ? eif_access (tmp_pst_next_run) : NULL));
	
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetIdleWait(  /* [in] */ USHORT w_idle_minutes, /* [in] */ USHORT w_deadline_minutes )

/*-----------------------------------------------------------
	Sets the idle wait time for the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_w_idle_minutes = (EIF_INTEGER)w_idle_minutes;
	EIF_INTEGER tmp_w_deadline_minutes = (EIF_INTEGER)w_deadline_minutes;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_idle_wait", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_w_idle_minutes, (EIF_INTEGER)tmp_w_deadline_minutes);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetIdleWait(  /* [out] */ USHORT * pw_idle_minutes, /* [out] */ USHORT * pw_deadline_minutes )

/*-----------------------------------------------------------
	Retrieves the idle wait time for the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pw_idle_minutes = NULL;
	if (pw_idle_minutes != NULL)
	{
		tmp_pw_idle_minutes = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (pw_idle_minutes, NULL));
	}
	EIF_OBJECT tmp_pw_deadline_minutes = NULL;
	if (pw_deadline_minutes != NULL)
	{
		tmp_pw_deadline_minutes = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (pw_deadline_minutes, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_idle_wait", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pw_idle_minutes != NULL) ? eif_access (tmp_pw_idle_minutes) : NULL), ((tmp_pw_deadline_minutes != NULL) ? eif_access (tmp_pw_deadline_minutes) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_pw_idle_minutes != NULL) ? eif_wean (tmp_pw_idle_minutes) : NULL), pw_idle_minutes);
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_pw_deadline_minutes != NULL) ? eif_wean (tmp_pw_deadline_minutes) : NULL), pw_deadline_minutes);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::Run( void )

/*-----------------------------------------------------------
	Runs the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("run", type_id);

	;
	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	;
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::Terminate( void )

/*-----------------------------------------------------------
	Ends the execution of the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("terminate", type_id);

	;
	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	;
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::EditWorkItem(  /* [in] */ ecom_MS_TaskSched_lib::wireHWND h_parent, /* [in] */ ULONG dw_reserved )

/*-----------------------------------------------------------
	Opens the configuration properties for the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_POINTER tmp_h_parent = (EIF_POINTER)h_parent;
	EIF_INTEGER tmp_dw_reserved = (EIF_INTEGER)dw_reserved;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("edit_work_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_POINTER)tmp_h_parent, (EIF_INTEGER)tmp_dw_reserved);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetMostRecentRunTime(  /* [out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_last_run )

/*-----------------------------------------------------------
	Retrieves the most recent time the work item began running.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pst_last_run = NULL;
	if (pst_last_run != NULL)
	{
		tmp_pst_last_run = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_8 (pst_last_run));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_most_recent_run_time", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pst_last_run != NULL) ? eif_access (tmp_pst_last_run) : NULL));
	
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetStatus(  /* [out] */ HRESULT * phr_status )

/*-----------------------------------------------------------
	Retrieves the status of the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_phr_status = NULL;
	if (phr_status != NULL)
	{
		tmp_phr_status = eif_protect (rt_ce.ccom_ce_pointed_hresult (phr_status, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_status", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_phr_status != NULL) ? eif_access (tmp_phr_status) : NULL));
	rt_ec.ccom_ec_pointed_hresult (((tmp_phr_status != NULL) ? eif_wean (tmp_phr_status) : NULL), phr_status);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetExitCode(  /* [out] */ ULONG * pdw_exit_code )

/*-----------------------------------------------------------
	Retrieves the work item's last exit code.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pdw_exit_code = NULL;
	if (pdw_exit_code != NULL)
	{
		tmp_pdw_exit_code = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_exit_code, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_exit_code", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pdw_exit_code != NULL) ? eif_access (tmp_pdw_exit_code) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_exit_code != NULL) ? eif_wean (tmp_pdw_exit_code) : NULL), pdw_exit_code);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetComment(  /* [in] */ LPWSTR pwsz_comment )

/*-----------------------------------------------------------
	Sets the comment for the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_comment = NULL;
	if (pwsz_comment != NULL)
	{
		tmp_pwsz_comment = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_comment, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_comment", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_comment != NULL) ? eif_access (tmp_pwsz_comment) : NULL));
	if (tmp_pwsz_comment != NULL)
		eif_wean (tmp_pwsz_comment);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetComment(  /* [out] */ LPWSTR * ppwsz_comment )

/*-----------------------------------------------------------
	Retrieves the comment for the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_ppwsz_comment = NULL;
	if (ppwsz_comment != NULL)
	{
		tmp_ppwsz_comment = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_18 (ppwsz_comment, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_comment", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_ppwsz_comment != NULL) ? eif_access (tmp_ppwsz_comment) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_18 (((tmp_ppwsz_comment != NULL) ? eif_wean (tmp_ppwsz_comment) : NULL), ppwsz_comment);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetCreator(  /* [in] */ LPWSTR pwsz_creator )

/*-----------------------------------------------------------
	Sets the creator of the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_creator = NULL;
	if (pwsz_creator != NULL)
	{
		tmp_pwsz_creator = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_creator, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_creator", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_creator != NULL) ? eif_access (tmp_pwsz_creator) : NULL));
	if (tmp_pwsz_creator != NULL)
		eif_wean (tmp_pwsz_creator);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetCreator(  /* [out] */ LPWSTR * ppwsz_creator )

/*-----------------------------------------------------------
	Retrieves the creator of the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_ppwsz_creator = NULL;
	if (ppwsz_creator != NULL)
	{
		tmp_ppwsz_creator = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_19 (ppwsz_creator, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_creator", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_ppwsz_creator != NULL) ? eif_access (tmp_ppwsz_creator) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_19 (((tmp_ppwsz_creator != NULL) ? eif_wean (tmp_ppwsz_creator) : NULL), ppwsz_creator);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetWorkItemData(  /* [in] */ USHORT cb_data, /* [in] */ UCHAR * rgb_data )

/*-----------------------------------------------------------
	Stores application-defined data associated with the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_cb_data = (EIF_INTEGER)cb_data;
	EIF_OBJECT tmp_rgb_data = NULL;
	if (rgb_data != NULL)
	{
		tmp_rgb_data = eif_protect (rt_ce.ccom_ce_pointed_unsigned_character (rgb_data, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_work_item_data", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_cb_data, ((tmp_rgb_data != NULL) ? eif_access (tmp_rgb_data) : NULL));
	if (tmp_rgb_data != NULL)
		eif_wean (tmp_rgb_data);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetWorkItemData(  /* [out] */ USHORT * pcb_data, /* [out] */ UCHAR * * prgb_data )

/*-----------------------------------------------------------
	Retrieves application-defined data associated with the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pcb_data = NULL;
	if (pcb_data != NULL)
	{
		tmp_pcb_data = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (pcb_data, NULL));
	}
	EIF_OBJECT tmp_prgb_data = NULL;
	if (prgb_data != NULL)
	{
		tmp_prgb_data = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_23 (prgb_data, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_work_item_data", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pcb_data != NULL) ? eif_access (tmp_pcb_data) : NULL), ((tmp_prgb_data != NULL) ? eif_access (tmp_prgb_data) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_pcb_data != NULL) ? eif_wean (tmp_pcb_data) : NULL), pcb_data);
	
	if (*prgb_data != NULL)
		grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_22 (*prgb_data);
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_23 (((tmp_prgb_data != NULL) ? eif_wean (tmp_prgb_data) : NULL), prgb_data);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetErrorRetryCount(  /* [in] */ USHORT w_retry_count )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_w_retry_count = (EIF_INTEGER)w_retry_count;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_error_retry_count", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_w_retry_count);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetErrorRetryCount(  /* [out] */ USHORT * pw_retry_count )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pw_retry_count = NULL;
	if (pw_retry_count != NULL)
	{
		tmp_pw_retry_count = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (pw_retry_count, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_error_retry_count", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pw_retry_count != NULL) ? eif_access (tmp_pw_retry_count) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_pw_retry_count != NULL) ? eif_wean (tmp_pw_retry_count) : NULL), pw_retry_count);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetErrorRetryInterval(  /* [in] */ USHORT w_retry_interval )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_w_retry_interval = (EIF_INTEGER)w_retry_interval;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_error_retry_interval", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_w_retry_interval);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetErrorRetryInterval(  /* [out] */ USHORT * pw_retry_interval )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pw_retry_interval = NULL;
	if (pw_retry_interval != NULL)
	{
		tmp_pw_retry_interval = eif_protect (rt_ce.ccom_ce_pointed_unsigned_short (pw_retry_interval, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_error_retry_interval", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pw_retry_interval != NULL) ? eif_access (tmp_pw_retry_interval) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_short (((tmp_pw_retry_interval != NULL) ? eif_wean (tmp_pw_retry_interval) : NULL), pw_retry_interval);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetFlags(  /* [in] */ ULONG dw_flags )

/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_dw_flags = (EIF_INTEGER)dw_flags;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_flags", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_flags);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetFlags(  /* [out] */ ULONG * pdw_flags )

/*-----------------------------------------------------------
	Retrieves the flags that modify the behavior of the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pdw_flags = NULL;
	if (pdw_flags != NULL)
	{
		tmp_pdw_flags = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_flags, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_flags", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pdw_flags != NULL) ? eif_access (tmp_pdw_flags) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_flags != NULL) ? eif_wean (tmp_pdw_flags) : NULL), pdw_flags);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetAccountInformation(  /* [in] */ LPWSTR pwsz_account_name, /* [in] */ LPWSTR pwsz_password )

/*-----------------------------------------------------------
	Sets the account name and password for the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_account_name = NULL;
	if (pwsz_account_name != NULL)
	{
		tmp_pwsz_account_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_account_name, NULL));
	}
	EIF_OBJECT tmp_pwsz_password = NULL;
	if (pwsz_password != NULL)
	{
		tmp_pwsz_password = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_password, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_account_information", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_account_name != NULL) ? eif_access (tmp_pwsz_account_name) : NULL), ((tmp_pwsz_password != NULL) ? eif_access (tmp_pwsz_password) : NULL));
	if (tmp_pwsz_account_name != NULL)
		eif_wean (tmp_pwsz_account_name);
	if (tmp_pwsz_password != NULL)
		eif_wean (tmp_pwsz_password);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetAccountInformation(  /* [out] */ LPWSTR * ppwsz_account_name )

/*-----------------------------------------------------------
	Retrieves the account name for the work item.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_ppwsz_account_name = NULL;
	if (ppwsz_account_name != NULL)
	{
		tmp_ppwsz_account_name = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_27 (ppwsz_account_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_account_information", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_ppwsz_account_name != NULL) ? eif_access (tmp_ppwsz_account_name) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_27 (((tmp_ppwsz_account_name != NULL) ? eif_wean (tmp_ppwsz_account_name) : NULL), ppwsz_account_name);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetApplicationName(  /* [in] */ LPWSTR pwsz_application_name )

/*-----------------------------------------------------------
	Assigns a specific application to the current task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_application_name = NULL;
	if (pwsz_application_name != NULL)
	{
		tmp_pwsz_application_name = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_application_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_application_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_application_name != NULL) ? eif_access (tmp_pwsz_application_name) : NULL));
	if (tmp_pwsz_application_name != NULL)
		eif_wean (tmp_pwsz_application_name);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetApplicationName(  /* [out] */ LPWSTR * ppwsz_application_name )

/*-----------------------------------------------------------
	Retrieves the name of the application that the task is associated with.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_ppwsz_application_name = NULL;
	if (ppwsz_application_name != NULL)
	{
		tmp_ppwsz_application_name = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_28 (ppwsz_application_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_application_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_ppwsz_application_name != NULL) ? eif_access (tmp_ppwsz_application_name) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_28 (((tmp_ppwsz_application_name != NULL) ? eif_wean (tmp_ppwsz_application_name) : NULL), ppwsz_application_name);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetParameters(  /* [in] */ LPWSTR pwsz_parameters )

/*-----------------------------------------------------------
	Sets the command-line parameters for the task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_parameters = NULL;
	if (pwsz_parameters != NULL)
	{
		tmp_pwsz_parameters = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_parameters, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_parameters", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_parameters != NULL) ? eif_access (tmp_pwsz_parameters) : NULL));
	if (tmp_pwsz_parameters != NULL)
		eif_wean (tmp_pwsz_parameters);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetParameters(  /* [out] */ LPWSTR * ppwsz_parameters )

/*-----------------------------------------------------------
	Retrieves the command-line parameters of a task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_ppwsz_parameters = NULL;
	if (ppwsz_parameters != NULL)
	{
		tmp_ppwsz_parameters = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_29 (ppwsz_parameters, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_parameters", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_ppwsz_parameters != NULL) ? eif_access (tmp_ppwsz_parameters) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_29 (((tmp_ppwsz_parameters != NULL) ? eif_wean (tmp_ppwsz_parameters) : NULL), ppwsz_parameters);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetWorkingDirectory(  /* [in] */ LPWSTR pwsz_working_directory )

/*-----------------------------------------------------------
	Sets the working directory for the task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pwsz_working_directory = NULL;
	if (pwsz_working_directory != NULL)
	{
		tmp_pwsz_working_directory = eif_protect (rt_ce.ccom_ce_lpwstr (pwsz_working_directory, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_working_directory", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pwsz_working_directory != NULL) ? eif_access (tmp_pwsz_working_directory) : NULL));
	if (tmp_pwsz_working_directory != NULL)
		eif_wean (tmp_pwsz_working_directory);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetWorkingDirectory(  /* [out] */ LPWSTR * ppwsz_working_directory )

/*-----------------------------------------------------------
	Retrieves the working directory of the task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_ppwsz_working_directory = NULL;
	if (ppwsz_working_directory != NULL)
	{
		tmp_ppwsz_working_directory = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_30 (ppwsz_working_directory, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_working_directory", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_ppwsz_working_directory != NULL) ? eif_access (tmp_ppwsz_working_directory) : NULL));
	grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_30 (((tmp_ppwsz_working_directory != NULL) ? eif_wean (tmp_ppwsz_working_directory) : NULL), ppwsz_working_directory);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetPriority(  /* [in] */ ULONG dw_priority )

/*-----------------------------------------------------------
	Sets the priority for the task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_dw_priority = (EIF_INTEGER)dw_priority;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_priority", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_priority);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetPriority(  /* [out] */ ULONG * pdw_priority )

/*-----------------------------------------------------------
	Retrieves the priority for the task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pdw_priority = NULL;
	if (pdw_priority != NULL)
	{
		tmp_pdw_priority = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_priority, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_priority", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pdw_priority != NULL) ? eif_access (tmp_pdw_priority) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_priority != NULL) ? eif_wean (tmp_pdw_priority) : NULL), pdw_priority);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetTaskFlags(  /* [in] */ ULONG dw_flags )

/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_dw_flags = (EIF_INTEGER)dw_flags;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_task_flags", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_flags);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetTaskFlags(  /* [out] */ ULONG * pdw_flags )

/*-----------------------------------------------------------
	Returns the flags used to modify the behavior of the task.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pdw_flags = NULL;
	if (pdw_flags != NULL)
	{
		tmp_pdw_flags = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_flags, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_task_flags", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pdw_flags != NULL) ? eif_access (tmp_pdw_flags) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_flags != NULL) ? eif_wean (tmp_pdw_flags) : NULL), pdw_flags);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::SetMaxRunTime(  /* [in] */ ULONG dw_max_run_time_ms )

/*-----------------------------------------------------------
	Sets the maximum length of time the task can run.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_INTEGER tmp_dw_max_run_time_ms = (EIF_INTEGER)dw_max_run_time_ms;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_max_run_time", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure)
	 (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_max_run_time_ms);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::GetMaxRunTime(  /* [out] */ ULONG * pdw_max_run_time_ms )

/*-----------------------------------------------------------
	Retrieves the maximum length of time the task can run.
-----------------------------------------------------------*/
{
	EIF_INITIALIZE_AUX_THREAD;
	ECOM_ENTER_STUB;

	EIF_OBJECT tmp_pdw_max_run_time_ms = NULL;
	if (pdw_max_run_time_ms != NULL)
	{
		tmp_pdw_max_run_time_ms = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_max_run_time_ms, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_max_run_time", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure)
	 (eif_access (eiffel_object), ((tmp_pdw_max_run_time_ms != NULL) ? eif_access (tmp_pdw_max_run_time_ms) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_max_run_time_ms != NULL) ? eif_wean (tmp_pdw_max_run_time_ms) : NULL), pdw_max_run_time_ms);
	
	ECOM_EXIT_STUB;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::ITask_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_MS_TaskSched_lib::ITask_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	 return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_MS_TaskSched_lib::ITask_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_MS_TaskSched_lib::ITask*>(this);
	else if (riid == IID_ITask_)
		*ppv = static_cast<ecom_MS_TaskSched_lib::ITask*>(this);
	else if (riid == IID_IScheduledWorkItem_)
		*ppv = static_cast<ecom_MS_TaskSched_lib::IScheduledWorkItem*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


