/*-----------------------------------------------------------
Implemented `IScheduledWorkItem' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h"
static const IID IID_IScheduledWorkItem_ = {0xa6b952f0,0xa4b1,0x11d0,{0x99,0x7d,0x00,0xaa,0x00,0x68,0x87,0xec}};

ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::IScheduledWorkItem_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	rt.ccom_check_hresult (hr);

	hr = a_pointer->QueryInterface(IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::~IScheduledWorkItem_impl_proxy()
{
	p_unknown->Release ();
	if (p_IScheduledWorkItem != NULL)
		p_IScheduledWorkItem->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_create_trigger(  /* [out] */ EIF_OBJECT pi_new_trigger,  /* [out] */ EIF_OBJECT pp_trigger )

/*-----------------------------------------------------------
	Creates a trigger using a work item object.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pi_new_trigger = 0;
	tmp_pi_new_trigger = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pi_new_trigger), NULL);
	ecom_MS_TaskSched_lib::ITaskTrigger * * tmp_pp_trigger = 0;
	tmp_pp_trigger = (ecom_MS_TaskSched_lib::ITaskTrigger * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_4 (eif_access (pp_trigger), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->CreateTrigger(tmp_pi_new_trigger,tmp_pp_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pi_new_trigger, pi_new_trigger);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_4 ((ecom_MS_TaskSched_lib::ITaskTrigger * *)tmp_pp_trigger, pp_trigger);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_1 (tmp_pi_new_trigger);
grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_4 (tmp_pp_trigger);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_delete_trigger(  /* [in] */ EIF_INTEGER i_trigger )

/*-----------------------------------------------------------
	Deletes a trigger from a work item. 
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_i_trigger = 0;
	tmp_i_trigger = (USHORT)i_trigger;
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->DeleteTrigger(tmp_i_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_trigger_count(  /* [out] */ EIF_OBJECT pw_count )

/*-----------------------------------------------------------
	Retrieves the number of triggers associated with a work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pw_count = 0;
	tmp_pw_count = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_count), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetTriggerCount(tmp_pw_count);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_count, pw_count);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_5 (tmp_pw_count);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_trigger(  /* [in] */ EIF_INTEGER i_trigger,  /* [out] */ EIF_OBJECT pp_trigger )

/*-----------------------------------------------------------
	Retrieves a trigger structure.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_i_trigger = 0;
	tmp_i_trigger = (USHORT)i_trigger;
	ecom_MS_TaskSched_lib::ITaskTrigger * * tmp_pp_trigger = 0;
	tmp_pp_trigger = (ecom_MS_TaskSched_lib::ITaskTrigger * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_4 (eif_access (pp_trigger), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetTrigger(tmp_i_trigger,tmp_pp_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_4 ((ecom_MS_TaskSched_lib::ITaskTrigger * *)tmp_pp_trigger, pp_trigger);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_4 (tmp_pp_trigger);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_trigger_string(  /* [in] */ EIF_INTEGER i_trigger,  /* [out] */ EIF_OBJECT ppwsz_trigger )

/*-----------------------------------------------------------
	Retrieves a trigger string.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_i_trigger = 0;
	tmp_i_trigger = (USHORT)i_trigger;
	LPWSTR * tmp_ppwsz_trigger = 0;
	tmp_ppwsz_trigger = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_6 (eif_access (ppwsz_trigger), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetTriggerString(tmp_i_trigger,tmp_ppwsz_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_6 ((LPWSTR *)tmp_ppwsz_trigger, ppwsz_trigger);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_6 (tmp_ppwsz_trigger);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_run_times(  /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_begin,  /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_end,  /* [in, out] */ EIF_OBJECT p_count,  /* [out] */ EIF_OBJECT rgst_task_times )

/*-----------------------------------------------------------
	Retrieves the work item run times for a specified time period.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_p_count = 0;
	tmp_p_count = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (p_count), NULL);
	ecom_MS_TaskSched_lib::_SYSTEMTIME * * tmp_rgst_task_times = 0;
	tmp_rgst_task_times = (ecom_MS_TaskSched_lib::_SYSTEMTIME * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_10 (eif_access (rgst_task_times), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetRunTimes(pst_begin,pst_end,tmp_p_count,tmp_rgst_task_times);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_p_count, p_count);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_10 ((ecom_MS_TaskSched_lib::_SYSTEMTIME * *)tmp_rgst_task_times, rgst_task_times);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_9 (tmp_p_count);
grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_10 (tmp_rgst_task_times);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_next_run_time(  /* [in, out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_next_run )

/*-----------------------------------------------------------
	Retrieves the next time the work item will run.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetNextRunTime(pst_next_run);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_set_idle_wait(  /* [in] */ EIF_INTEGER w_idle_minutes,  /* [in] */ EIF_INTEGER w_deadline_minutes )

/*-----------------------------------------------------------
	Sets the idle wait time for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_w_idle_minutes = 0;
	tmp_w_idle_minutes = (USHORT)w_idle_minutes;
	USHORT tmp_w_deadline_minutes = 0;
	tmp_w_deadline_minutes = (USHORT)w_deadline_minutes;
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->SetIdleWait(tmp_w_idle_minutes,tmp_w_deadline_minutes);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_idle_wait(  /* [out] */ EIF_OBJECT pw_idle_minutes,  /* [out] */ EIF_OBJECT pw_deadline_minutes )

/*-----------------------------------------------------------
	Retrieves the idle wait time for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pw_idle_minutes = 0;
	tmp_pw_idle_minutes = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_idle_minutes), NULL);
	USHORT * tmp_pw_deadline_minutes = 0;
	tmp_pw_deadline_minutes = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_deadline_minutes), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetIdleWait(tmp_pw_idle_minutes,tmp_pw_deadline_minutes);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_idle_minutes, pw_idle_minutes);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_deadline_minutes, pw_deadline_minutes);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_11 (tmp_pw_idle_minutes);
grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_12 (tmp_pw_deadline_minutes);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_run()

/*-----------------------------------------------------------
	Runs the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->Run ();
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_terminate()

/*-----------------------------------------------------------
	Ends the execution of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->Terminate ();
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_edit_work_item(  /* [in] */ EIF_POINTER h_parent,  /* [in] */ EIF_INTEGER dw_reserved )

/*-----------------------------------------------------------
	Opens the configuration properties for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	ecom_MS_TaskSched_lib::wireHWND tmp_h_parent = 0;
	tmp_h_parent = (ecom_MS_TaskSched_lib::wireHWND)h_parent;
	ULONG tmp_dw_reserved = 0;
	tmp_dw_reserved = (ULONG)dw_reserved;
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->EditWorkItem(tmp_h_parent,tmp_dw_reserved);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	grt_ce_mstask_modified_idl_c.free_memory_13 (tmp_h_parent);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_most_recent_run_time(  /* [out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_last_run )

/*-----------------------------------------------------------
	Retrieves the most recent time the work item began running.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetMostRecentRunTime(pst_last_run);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_status(  /* [out] */ EIF_OBJECT phr_status )

/*-----------------------------------------------------------
	Retrieves the status of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	HRESULT * tmp_phr_status = 0;
	tmp_phr_status = (HRESULT *)rt_ec.ccom_ec_pointed_hresult (eif_access (phr_status), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetStatus(tmp_phr_status);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_hresult ((HRESULT *)tmp_phr_status, phr_status);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_16 (tmp_phr_status);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_exit_code(  /* [out] */ EIF_OBJECT pdw_exit_code )

/*-----------------------------------------------------------
	Retrieves the work item's last exit code.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	ULONG * tmp_pdw_exit_code = 0;
	tmp_pdw_exit_code = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_exit_code), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetExitCode(tmp_pdw_exit_code);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_exit_code, pdw_exit_code);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_17 (tmp_pdw_exit_code);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_set_comment(  /* [in] */ EIF_OBJECT pwsz_comment )

/*-----------------------------------------------------------
	Sets the comment for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_comment = 0;
	tmp_pwsz_comment = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_comment), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->SetComment(tmp_pwsz_comment);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_comment(  /* [out] */ EIF_OBJECT ppwsz_comment )

/*-----------------------------------------------------------
	Retrieves the comment for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_comment = 0;
	tmp_ppwsz_comment = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_18 (eif_access (ppwsz_comment), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetComment(tmp_ppwsz_comment);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_18 ((LPWSTR *)tmp_ppwsz_comment, ppwsz_comment);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_18 (tmp_ppwsz_comment);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_set_creator(  /* [in] */ EIF_OBJECT pwsz_creator )

/*-----------------------------------------------------------
	Sets the creator of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_creator = 0;
	tmp_pwsz_creator = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_creator), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->SetCreator(tmp_pwsz_creator);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_creator(  /* [out] */ EIF_OBJECT ppwsz_creator )

/*-----------------------------------------------------------
	Retrieves the creator of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_creator = 0;
	tmp_ppwsz_creator = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_19 (eif_access (ppwsz_creator), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetCreator(tmp_ppwsz_creator);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_19 ((LPWSTR *)tmp_ppwsz_creator, ppwsz_creator);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_19 (tmp_ppwsz_creator);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_set_work_item_data(  /* [in] */ EIF_INTEGER cb_data,  /* [in] */ EIF_OBJECT rgb_data )

/*-----------------------------------------------------------
	Stores application-defined data associated with the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_cb_data = 0;
	tmp_cb_data = (USHORT)cb_data;
	UCHAR * tmp_rgb_data = 0;
	tmp_rgb_data = (UCHAR *)rt_ec.ccom_ec_pointed_unsigned_character (eif_access (rgb_data), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->SetWorkItemData(tmp_cb_data,tmp_rgb_data);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_20 (tmp_rgb_data);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_work_item_data(  /* [out] */ EIF_OBJECT pcb_data,  /* [out] */ EIF_OBJECT prgb_data )

/*-----------------------------------------------------------
	Retrieves application-defined data associated with the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pcb_data = 0;
	tmp_pcb_data = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pcb_data), NULL);
	UCHAR * * tmp_prgb_data = 0;
	tmp_prgb_data = (UCHAR * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_23 (eif_access (prgb_data), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetWorkItemData(tmp_pcb_data,tmp_prgb_data);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pcb_data, pcb_data);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_23 ((UCHAR * *)tmp_prgb_data, prgb_data);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_21 (tmp_pcb_data);
grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_23 (tmp_prgb_data);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_set_error_retry_count(  /* [in] */ EIF_INTEGER w_retry_count )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_w_retry_count = 0;
	tmp_w_retry_count = (USHORT)w_retry_count;
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->SetErrorRetryCount(tmp_w_retry_count);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_error_retry_count(  /* [out] */ EIF_OBJECT pw_retry_count )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pw_retry_count = 0;
	tmp_pw_retry_count = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_retry_count), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetErrorRetryCount(tmp_pw_retry_count);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_retry_count, pw_retry_count);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_24 (tmp_pw_retry_count);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_set_error_retry_interval(  /* [in] */ EIF_INTEGER w_retry_interval )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT tmp_w_retry_interval = 0;
	tmp_w_retry_interval = (USHORT)w_retry_interval;
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->SetErrorRetryInterval(tmp_w_retry_interval);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_error_retry_interval(  /* [out] */ EIF_OBJECT pw_retry_interval )

/*-----------------------------------------------------------
	Not currently implemented.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	USHORT * tmp_pw_retry_interval = 0;
	tmp_pw_retry_interval = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_retry_interval), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetErrorRetryInterval(tmp_pw_retry_interval);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_retry_interval, pw_retry_interval);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_25 (tmp_pw_retry_interval);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_set_flags(  /* [in] */ EIF_INTEGER dw_flags )

/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	ULONG tmp_dw_flags = 0;
	tmp_dw_flags = (ULONG)dw_flags;
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->SetFlags(tmp_dw_flags);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_flags(  /* [out] */ EIF_OBJECT pdw_flags )

/*-----------------------------------------------------------
	Retrieves the flags that modify the behavior of the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	ULONG * tmp_pdw_flags = 0;
	tmp_pdw_flags = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_flags), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetFlags(tmp_pdw_flags);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_flags, pdw_flags);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_26 (tmp_pdw_flags);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_set_account_information(  /* [in] */ EIF_OBJECT pwsz_account_name,  /* [in] */ EIF_OBJECT pwsz_password )

/*-----------------------------------------------------------
	Sets the account name and password for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_account_name = 0;
	tmp_pwsz_account_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_account_name), NULL);
	LPWSTR tmp_pwsz_password = 0;
	tmp_pwsz_password = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_password), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->SetAccountInformation(tmp_pwsz_account_name,tmp_pwsz_password);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_get_account_information(  /* [out] */ EIF_OBJECT ppwsz_account_name )

/*-----------------------------------------------------------
	Retrieves the account name for the work item.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IScheduledWorkItem == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IScheduledWorkItem_, (void **)&p_IScheduledWorkItem);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_account_name = 0;
	tmp_ppwsz_account_name = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_27 (eif_access (ppwsz_account_name), NULL);
	
	EIF_ENTER_C;
	hr = p_IScheduledWorkItem->GetAccountInformation(tmp_ppwsz_account_name);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_27 ((LPWSTR *)tmp_ppwsz_account_name, ppwsz_account_name);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_27 (tmp_ppwsz_account_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_MS_TaskSched_lib::IScheduledWorkItem_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


