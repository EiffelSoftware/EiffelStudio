/*-----------------------------------------------------------
Task. Task Scheduler.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_CTask.h"
static const CLSID CLSID_CTask_ = {0x148bd520,0xa2ab,0x11ce,{0xb1,0x1f,0x00,0xaa,0x00,0x53,0x05,0x03}};

static const IID IID_ITask_ = {0x148bd524,0xa2ab,0x11ce,{0xb1,0x1f,0x00,0xaa,0x00,0x53,0x05,0x03}};

static const IID IID_IProvideTaskPage_ = {0x4086658a,0xcbbb,0x11cf,{0xb6,0x04,0x00,0xc0,0x4f,0xd8,0xd5,0x65}};

static const IID IID_IPersistFile_ = {0x0000010b,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

ecom_MS_TaskSched_lib::CTask::CTask( IUnknown * a_pointer )
{
	 HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void**)&p_unknown);
	rt.ccom_check_hresult (hr);

	p_ITask = 0;
	hr = a_pointer->QueryInterface(IID_ITask_, (void**)&p_ITask);
	rt.ccom_check_hresult (hr);

	p_IProvideTaskPage = 0;
	hr = a_pointer->QueryInterface(IID_IProvideTaskPage_, (void**)&p_IProvideTaskPage);
	rt.ccom_check_hresult (hr);

	p_IPersistFile = 0;
	hr = a_pointer->QueryInterface(IID_IPersistFile_, (void**)&p_IPersistFile);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::CTask::~CTask()
{
	p_unknown->Release ();
	if (p_ITask != NULL)
		p_ITask->Release ();
	if (p_IProvideTaskPage != NULL)
		p_IProvideTaskPage->Release ();
	if (p_IPersistFile != NULL)
		p_IPersistFile->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_create_trigger(  /* [out] */ EIF_OBJECT pi_new_trigger,  /* [out] */ EIF_OBJECT pp_trigger )

/*-----------------------------------------------------------
	Creates a trigger using a work item object.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pi_new_trigger = 0;
	tmp_pi_new_trigger = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pi_new_trigger), NULL);
	ecom_MS_TaskSched_lib::ITaskTrigger * * tmp_pp_trigger = 0;
	tmp_pp_trigger = (ecom_MS_TaskSched_lib::ITaskTrigger * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_4 (eif_access (pp_trigger), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->CreateTrigger(tmp_pi_new_trigger,tmp_pp_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pi_new_trigger, pi_new_trigger);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_4 ((ecom_MS_TaskSched_lib::ITaskTrigger * *)tmp_pp_trigger, pp_trigger);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_1 (tmp_pi_new_trigger);
grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_4 (tmp_pp_trigger);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_delete_trigger(  /* [in] */ EIF_INTEGER i_trigger )

/*-----------------------------------------------------------
	Deletes a trigger from a work item. 
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_i_trigger = 0;
	tmp_i_trigger = (USHORT)i_trigger;
	
	EIF_ENTER_C;
	hr = p_ITask->DeleteTrigger(tmp_i_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_trigger_count(  /* [out] */ EIF_OBJECT pw_count )

/*-----------------------------------------------------------
	Retrieves the number of triggers associated with a work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pw_count = 0;
	tmp_pw_count = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_count), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetTriggerCount(tmp_pw_count);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_count, pw_count);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_5 (tmp_pw_count);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_trigger(  /* [in] */ EIF_INTEGER i_trigger,  /* [out] */ EIF_OBJECT pp_trigger )

/*-----------------------------------------------------------
	Retrieves a trigger structure.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_i_trigger = 0;
	tmp_i_trigger = (USHORT)i_trigger;
	ecom_MS_TaskSched_lib::ITaskTrigger * * tmp_pp_trigger = 0;
	tmp_pp_trigger = (ecom_MS_TaskSched_lib::ITaskTrigger * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_4 (eif_access (pp_trigger), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetTrigger(tmp_i_trigger,tmp_pp_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_4 ((ecom_MS_TaskSched_lib::ITaskTrigger * *)tmp_pp_trigger, pp_trigger);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_4 (tmp_pp_trigger);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_trigger_string(  /* [in] */ EIF_INTEGER i_trigger,  /* [out] */ EIF_OBJECT ppwsz_trigger )

/*-----------------------------------------------------------
	Retrieves a trigger string.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_i_trigger = 0;
	tmp_i_trigger = (USHORT)i_trigger;
	LPWSTR * tmp_ppwsz_trigger = 0;
	tmp_ppwsz_trigger = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_6 (eif_access (ppwsz_trigger), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetTriggerString(tmp_i_trigger,tmp_ppwsz_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_6 ((LPWSTR *)tmp_ppwsz_trigger, ppwsz_trigger);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_6 (tmp_ppwsz_trigger);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_run_times(  /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_begin,  /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_end,  /* [in, out] */ EIF_OBJECT p_count,  /* [out] */ EIF_OBJECT rgst_task_times )

/*-----------------------------------------------------------
	Retrieves the work item run times for a specified time period.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_p_count = 0;
	tmp_p_count = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (p_count), NULL);
	ecom_MS_TaskSched_lib::_SYSTEMTIME * * tmp_rgst_task_times = 0;
	tmp_rgst_task_times = (ecom_MS_TaskSched_lib::_SYSTEMTIME * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_10 (eif_access (rgst_task_times), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetRunTimes(pst_begin,pst_end,tmp_p_count,tmp_rgst_task_times);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_p_count, p_count);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_10 ((ecom_MS_TaskSched_lib::_SYSTEMTIME * *)tmp_rgst_task_times, rgst_task_times);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_9 (tmp_p_count);
grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_10 (tmp_rgst_task_times);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_next_run_time(  /* [in, out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_next_run )

/*-----------------------------------------------------------
	Retrieves the next time the work item will run.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	
	EIF_ENTER_C;
	hr = p_ITask->GetNextRunTime(pst_next_run);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_idle_wait(  /* [in] */ EIF_INTEGER w_idle_minutes,  /* [in] */ EIF_INTEGER w_deadline_minutes )

/*-----------------------------------------------------------
	Sets the idle wait time for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_w_idle_minutes = 0;
	tmp_w_idle_minutes = (USHORT)w_idle_minutes;
	USHORT tmp_w_deadline_minutes = 0;
	tmp_w_deadline_minutes = (USHORT)w_deadline_minutes;
	
	EIF_ENTER_C;
	hr = p_ITask->SetIdleWait(tmp_w_idle_minutes,tmp_w_deadline_minutes);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_idle_wait(  /* [out] */ EIF_OBJECT pw_idle_minutes,  /* [out] */ EIF_OBJECT pw_deadline_minutes )

/*-----------------------------------------------------------
	Retrieves the idle wait time for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pw_idle_minutes = 0;
	tmp_pw_idle_minutes = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_idle_minutes), NULL);
	USHORT * tmp_pw_deadline_minutes = 0;
	tmp_pw_deadline_minutes = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_deadline_minutes), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetIdleWait(tmp_pw_idle_minutes,tmp_pw_deadline_minutes);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_idle_minutes, pw_idle_minutes);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_deadline_minutes, pw_deadline_minutes);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_11 (tmp_pw_idle_minutes);
grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_12 (tmp_pw_deadline_minutes);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_run()

/*-----------------------------------------------------------
	Runs the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	EIF_ENTER_C;
	hr = p_ITask->Run ();
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_terminate()

/*-----------------------------------------------------------
	Ends the execution of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	EIF_ENTER_C;
	hr = p_ITask->Terminate ();
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_edit_work_item(  /* [in] */ EIF_POINTER h_parent,  /* [in] */ EIF_INTEGER dw_reserved )

/*-----------------------------------------------------------
	Opens the configuration properties for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ecom_MS_TaskSched_lib::wireHWND tmp_h_parent = 0;
	tmp_h_parent = (ecom_MS_TaskSched_lib::wireHWND)h_parent;
	ULONG tmp_dw_reserved = 0;
	tmp_dw_reserved = (ULONG)dw_reserved;
	
	EIF_ENTER_C;
	hr = p_ITask->EditWorkItem(tmp_h_parent,tmp_dw_reserved);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	grt_ce_mstask_modified_idl_c.free_memory_13 (tmp_h_parent);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_most_recent_run_time(  /* [out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_last_run )

/*-----------------------------------------------------------
	Retrieves the most recent time the work item began running.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	
	EIF_ENTER_C;
	hr = p_ITask->GetMostRecentRunTime(pst_last_run);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_status(  /* [out] */ EIF_OBJECT phr_status )

/*-----------------------------------------------------------
	Retrieves the status of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	HRESULT * tmp_phr_status = 0;
	tmp_phr_status = (HRESULT *)rt_ec.ccom_ec_pointed_hresult (eif_access (phr_status), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetStatus(tmp_phr_status);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_hresult ((HRESULT *)tmp_phr_status, phr_status);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_16 (tmp_phr_status);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_exit_code(  /* [out] */ EIF_OBJECT pdw_exit_code )

/*-----------------------------------------------------------
	Retrieves the work item's last exit code.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ULONG * tmp_pdw_exit_code = 0;
	tmp_pdw_exit_code = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_exit_code), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetExitCode(tmp_pdw_exit_code);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_exit_code, pdw_exit_code);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_17 (tmp_pdw_exit_code);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_comment(  /* [in] */ EIF_OBJECT pwsz_comment )

/*-----------------------------------------------------------
	Sets the comment for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_comment = 0;
	tmp_pwsz_comment = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_comment), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->SetComment(tmp_pwsz_comment);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_comment(  /* [out] */ EIF_OBJECT ppwsz_comment )

/*-----------------------------------------------------------
	Retrieves the comment for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_comment = 0;
	tmp_ppwsz_comment = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_18 (eif_access (ppwsz_comment), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetComment(tmp_ppwsz_comment);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_18 ((LPWSTR *)tmp_ppwsz_comment, ppwsz_comment);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_18 (tmp_ppwsz_comment);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_creator(  /* [in] */ EIF_OBJECT pwsz_creator )

/*-----------------------------------------------------------
	Sets the creator of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_creator = 0;
	tmp_pwsz_creator = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_creator), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->SetCreator(tmp_pwsz_creator);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_creator(  /* [out] */ EIF_OBJECT ppwsz_creator )

/*-----------------------------------------------------------
	Retrieves the creator of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_creator = 0;
	tmp_ppwsz_creator = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_19 (eif_access (ppwsz_creator), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetCreator(tmp_ppwsz_creator);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_19 ((LPWSTR *)tmp_ppwsz_creator, ppwsz_creator);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_19 (tmp_ppwsz_creator);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_work_item_data(  /* [in] */ EIF_INTEGER cb_data,  /* [in] */ EIF_OBJECT rgb_data )

/*-----------------------------------------------------------
	Stores application-defined data associated with the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_cb_data = 0;
	tmp_cb_data = (USHORT)cb_data;
	UCHAR * tmp_rgb_data = 0;
	tmp_rgb_data = (UCHAR *)rt_ec.ccom_ec_pointed_unsigned_character (eif_access (rgb_data), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->SetWorkItemData(tmp_cb_data,tmp_rgb_data);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_20 (tmp_rgb_data);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_work_item_data(  /* [out] */ EIF_OBJECT pcb_data,  /* [out] */ EIF_OBJECT prgb_data )

/*-----------------------------------------------------------
	Retrieves application-defined data associated with the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pcb_data = 0;
	tmp_pcb_data = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pcb_data), NULL);
	UCHAR * * tmp_prgb_data = 0;
	tmp_prgb_data = (UCHAR * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_23 (eif_access (prgb_data), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetWorkItemData(tmp_pcb_data,tmp_prgb_data);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pcb_data, pcb_data);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_23 ((UCHAR * *)tmp_prgb_data, prgb_data);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_21 (tmp_pcb_data);
grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_23 (tmp_prgb_data);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_error_retry_count(  /* [in] */ EIF_INTEGER w_retry_count )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_w_retry_count = 0;
	tmp_w_retry_count = (USHORT)w_retry_count;
	
	EIF_ENTER_C;
	hr = p_ITask->SetErrorRetryCount(tmp_w_retry_count);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_error_retry_count(  /* [out] */ EIF_OBJECT pw_retry_count )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pw_retry_count = 0;
	tmp_pw_retry_count = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_retry_count), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetErrorRetryCount(tmp_pw_retry_count);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_retry_count, pw_retry_count);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_24 (tmp_pw_retry_count);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_error_retry_interval(  /* [in] */ EIF_INTEGER w_retry_interval )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_w_retry_interval = 0;
	tmp_w_retry_interval = (USHORT)w_retry_interval;
	
	EIF_ENTER_C;
	hr = p_ITask->SetErrorRetryInterval(tmp_w_retry_interval);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_error_retry_interval(  /* [out] */ EIF_OBJECT pw_retry_interval )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pw_retry_interval = 0;
	tmp_pw_retry_interval = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_retry_interval), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetErrorRetryInterval(tmp_pw_retry_interval);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_retry_interval, pw_retry_interval);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_25 (tmp_pw_retry_interval);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_flags(  /* [in] */ EIF_INTEGER dw_flags )

/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ULONG tmp_dw_flags = 0;
	tmp_dw_flags = (ULONG)dw_flags;
	
	EIF_ENTER_C;
	hr = p_ITask->SetFlags(tmp_dw_flags);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_flags(  /* [out] */ EIF_OBJECT pdw_flags )

/*-----------------------------------------------------------
	Retrieves the flags that modify the behavior of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ULONG * tmp_pdw_flags = 0;
	tmp_pdw_flags = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_flags), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetFlags(tmp_pdw_flags);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_flags, pdw_flags);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_26 (tmp_pdw_flags);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_account_information(  /* [in] */ EIF_OBJECT pwsz_account_name,  /* [in] */ EIF_OBJECT pwsz_password )

/*-----------------------------------------------------------
	Sets the account name and password for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_account_name = 0;
	tmp_pwsz_account_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_account_name), NULL);
	LPWSTR tmp_pwsz_password = 0;
	tmp_pwsz_password = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_password), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->SetAccountInformation(tmp_pwsz_account_name,tmp_pwsz_password);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_account_information(  /* [out] */ EIF_OBJECT ppwsz_account_name )

/*-----------------------------------------------------------
	Retrieves the account name for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_account_name = 0;
	tmp_ppwsz_account_name = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_27 (eif_access (ppwsz_account_name), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetAccountInformation(tmp_ppwsz_account_name);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_27 ((LPWSTR *)tmp_ppwsz_account_name, ppwsz_account_name);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_27 (tmp_ppwsz_account_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_application_name(  /* [in] */ EIF_OBJECT pwsz_application_name )

/*-----------------------------------------------------------
	Assigns a specific application to the current task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_application_name = 0;
	tmp_pwsz_application_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_application_name), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->SetApplicationName(tmp_pwsz_application_name);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_application_name(  /* [out] */ EIF_OBJECT ppwsz_application_name )

/*-----------------------------------------------------------
	Retrieves the name of the application that the task is associated with.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_application_name = 0;
	tmp_ppwsz_application_name = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_28 (eif_access (ppwsz_application_name), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetApplicationName(tmp_ppwsz_application_name);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_28 ((LPWSTR *)tmp_ppwsz_application_name, ppwsz_application_name);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_28 (tmp_ppwsz_application_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_parameters(  /* [in] */ EIF_OBJECT pwsz_parameters )

/*-----------------------------------------------------------
	Sets the command-line parameters for the task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_parameters = 0;
	tmp_pwsz_parameters = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_parameters), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->SetParameters(tmp_pwsz_parameters);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_parameters(  /* [out] */ EIF_OBJECT ppwsz_parameters )

/*-----------------------------------------------------------
	Retrieves the command-line parameters of a task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_parameters = 0;
	tmp_ppwsz_parameters = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_29 (eif_access (ppwsz_parameters), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetParameters(tmp_ppwsz_parameters);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_29 ((LPWSTR *)tmp_ppwsz_parameters, ppwsz_parameters);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_29 (tmp_ppwsz_parameters);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_working_directory(  /* [in] */ EIF_OBJECT pwsz_working_directory )

/*-----------------------------------------------------------
	Sets the working directory for the task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_working_directory = 0;
	tmp_pwsz_working_directory = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_working_directory), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->SetWorkingDirectory(tmp_pwsz_working_directory);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_working_directory(  /* [out] */ EIF_OBJECT ppwsz_working_directory )

/*-----------------------------------------------------------
	Retrieves the working directory of the task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_working_directory = 0;
	tmp_ppwsz_working_directory = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_30 (eif_access (ppwsz_working_directory), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetWorkingDirectory(tmp_ppwsz_working_directory);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_30 ((LPWSTR *)tmp_ppwsz_working_directory, ppwsz_working_directory);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_30 (tmp_ppwsz_working_directory);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_priority(  /* [in] */ EIF_INTEGER dw_priority )

/*-----------------------------------------------------------
	Sets the priority for the task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ULONG tmp_dw_priority = 0;
	tmp_dw_priority = (ULONG)dw_priority;
	
	EIF_ENTER_C;
	hr = p_ITask->SetPriority(tmp_dw_priority);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_priority(  /* [out] */ EIF_OBJECT pdw_priority )

/*-----------------------------------------------------------
	Retrieves the priority for the task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ULONG * tmp_pdw_priority = 0;
	tmp_pdw_priority = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_priority), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetPriority(tmp_pdw_priority);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_priority, pdw_priority);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_31 (tmp_pdw_priority);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_task_flags(  /* [in] */ EIF_INTEGER dw_flags )

/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ULONG tmp_dw_flags = 0;
	tmp_dw_flags = (ULONG)dw_flags;
	
	EIF_ENTER_C;
	hr = p_ITask->SetTaskFlags(tmp_dw_flags);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_task_flags(  /* [out] */ EIF_OBJECT pdw_flags )

/*-----------------------------------------------------------
	Returns the flags used to modify the behavior of the task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ULONG * tmp_pdw_flags = 0;
	tmp_pdw_flags = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_flags), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetTaskFlags(tmp_pdw_flags);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_flags, pdw_flags);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_32 (tmp_pdw_flags);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_set_max_run_time(  /* [in] */ EIF_INTEGER dw_max_run_time_ms )

/*-----------------------------------------------------------
	Sets the maximum length of time the task can run.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ULONG tmp_dw_max_run_time_ms = 0;
	tmp_dw_max_run_time_ms = (ULONG)dw_max_run_time_ms;
	
	EIF_ENTER_C;
	hr = p_ITask->SetMaxRunTime(tmp_dw_max_run_time_ms);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_max_run_time(  /* [out] */ EIF_OBJECT pdw_max_run_time_ms )

/*-----------------------------------------------------------
	Retrieves the maximum length of time the task can run.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITask == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITask_, (void **)&p_ITask);
		rt.ccom_check_hresult (hr);
	};
	ULONG * tmp_pdw_max_run_time_ms = 0;
	tmp_pdw_max_run_time_ms = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_max_run_time_ms), NULL);
	
	EIF_ENTER_C;
	hr = p_ITask->GetMaxRunTime(tmp_pdw_max_run_time_ms);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_max_run_time_ms, pdw_max_run_time_ms);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_33 (tmp_pdw_max_run_time_ms);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_page(  /* [in] */ EIF_INTEGER tp_type,  /* [in] */ EIF_INTEGER f_persist_changes,  /* [out] */ EIF_OBJECT ph_page )

/*-----------------------------------------------------------
	Retrieves the property sheet pages associated with a task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IProvideTaskPage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IProvideTaskPage_, (void **)&p_IProvideTaskPage);
		rt.ccom_check_hresult (hr);
	};
	long tmp_tp_type = 0;
	tmp_tp_type = (long)tp_type;
	LONG tmp_f_persist_changes = 0;
	tmp_f_persist_changes = (LONG)f_persist_changes;
	void * * tmp_ph_page = 0;
	tmp_ph_page = (void * *)rt_ec.ccom_ec_pointed_pointer (eif_access (ph_page), NULL);
	
	EIF_ENTER_C;
	hr = p_IProvideTaskPage->GetPage(tmp_tp_type,tmp_f_persist_changes,tmp_ph_page);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_pointer ((void * *)tmp_ph_page, ph_page);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_36 (tmp_ph_page);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_class_id(  /* [out] */ GUID * p_class_id )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPersistFile == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPersistFile_, (void **)&p_IPersistFile);
		rt.ccom_check_hresult (hr);
	};
	
	EIF_ENTER_C;
	hr = p_IPersistFile->GetClassID(p_class_id);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_is_dirty()

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPersistFile == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPersistFile_, (void **)&p_IPersistFile);
		rt.ccom_check_hresult (hr);
	};
	EIF_ENTER_C;
	hr = p_IPersistFile->IsDirty ();
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_load(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER dw_mode )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPersistFile == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPersistFile_, (void **)&p_IPersistFile);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_psz_file_name = 0;
	tmp_psz_file_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_file_name), NULL);
	ULONG tmp_dw_mode = 0;
	tmp_dw_mode = (ULONG)dw_mode;
	
	EIF_ENTER_C;
	hr = p_IPersistFile->Load(tmp_psz_file_name,tmp_dw_mode);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_save(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER f_remember )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPersistFile == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPersistFile_, (void **)&p_IPersistFile);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_psz_file_name = 0;
	tmp_psz_file_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_file_name), NULL);
	LONG tmp_f_remember = 0;
	tmp_f_remember = (LONG)f_remember;
	
	EIF_ENTER_C;
	hr = p_IPersistFile->Save(tmp_psz_file_name,tmp_f_remember);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_save_completed(  /* [in] */ EIF_OBJECT psz_file_name )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPersistFile == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPersistFile_, (void **)&p_IPersistFile);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_psz_file_name = 0;
	tmp_psz_file_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_file_name), NULL);
	
	EIF_ENTER_C;
	hr = p_IPersistFile->SaveCompleted(tmp_psz_file_name);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::CTask::ccom_get_cur_file(  /* [out] */ EIF_OBJECT ppsz_file_name )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPersistFile == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPersistFile_, (void **)&p_IPersistFile);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppsz_file_name = 0;
	tmp_ppsz_file_name = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_39 (eif_access (ppsz_file_name), NULL);
	
	EIF_ENTER_C;
	hr = p_IPersistFile->GetCurFile(tmp_ppsz_file_name);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_39 ((LPWSTR *)tmp_ppsz_file_name, ppsz_file_name);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_39 (tmp_ppsz_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_MS_TaskSched_lib::CTask::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


