/*-----------------------------------------------------------
Implemented `ITaskScheduler' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_ITaskScheduler_impl_proxy.h"
static const IID IID_ITaskScheduler_ = {0x148bd527,0xa2ab,0x11ce,{0xb1,0x1f,0x00,0xaa,0x00,0x53,0x05,0x03}};

ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ITaskScheduler_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	rt.ccom_check_hresult (hr);

	hr = a_pointer->QueryInterface(IID_ITaskScheduler_, (void **)&p_ITaskScheduler);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::~ITaskScheduler_impl_proxy()
{
	p_unknown->Release ();
	if (p_ITaskScheduler != NULL)
		p_ITaskScheduler->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ccom_set_target_computer(  /* [in] */ EIF_OBJECT pwsz_computer )

/*-----------------------------------------------------------
	Selects the computer that the ITaskScheduler interface operates on.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskScheduler == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskScheduler_, (void **)&p_ITaskScheduler);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_computer = 0;
	tmp_pwsz_computer = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_computer), NULL);
	
	EIF_ENTER_C;
	hr = p_ITaskScheduler->SetTargetComputer(tmp_pwsz_computer);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ccom_get_target_computer(  /* [out] */ EIF_OBJECT ppwsz_computer )

/*-----------------------------------------------------------
	Returns the name of the computer on which ITaskScheduler is currently targeted.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskScheduler == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskScheduler_, (void **)&p_ITaskScheduler);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_computer = 0;
	tmp_ppwsz_computer = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_54 (eif_access (ppwsz_computer), NULL);
	
	EIF_ENTER_C;
	hr = p_ITaskScheduler->GetTargetComputer(tmp_ppwsz_computer);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_54 ((LPWSTR *)tmp_ppwsz_computer, ppwsz_computer);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_54 (tmp_ppwsz_computer);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ccom_enum(  /* [out] */ EIF_OBJECT pp_enum_work_items )

/*-----------------------------------------------------------
	Retrieves a pointer to an OLE enumerator object that enumerates the tasks in the current task folder.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskScheduler == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskScheduler_, (void **)&p_ITaskScheduler);
		rt.ccom_check_hresult (hr);
	};
	ecom_MS_TaskSched_lib::IEnumWorkItems * * tmp_pp_enum_work_items = 0;
	tmp_pp_enum_work_items = (ecom_MS_TaskSched_lib::IEnumWorkItems * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_57 (eif_access (pp_enum_work_items), NULL);
	
	EIF_ENTER_C;
	hr = p_ITaskScheduler->Enum(tmp_pp_enum_work_items);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_57 ((ecom_MS_TaskSched_lib::IEnumWorkItems * *)tmp_pp_enum_work_items, pp_enum_work_items);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_57 (tmp_pp_enum_work_items);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ccom_activate(  /* [in] */ EIF_OBJECT pwsz_name,  /* [in] */ GUID * a_riid,  /* [out] */ EIF_OBJECT pp_unk )

/*-----------------------------------------------------------
	Returns an active interface to the specified task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskScheduler == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskScheduler_, (void **)&p_ITaskScheduler);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_name = 0;
	tmp_pwsz_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_name), NULL);
	IUnknown * * tmp_pp_unk = 0;
	tmp_pp_unk = (IUnknown * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_58 (eif_access (pp_unk), NULL);
	
	EIF_ENTER_C;
	hr = p_ITaskScheduler->Activate(tmp_pwsz_name,a_riid,tmp_pp_unk);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_58 ((IUnknown * *)tmp_pp_unk, pp_unk);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_58 (tmp_pp_unk);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ccom_delete(  /* [in] */ EIF_OBJECT pwsz_name )

/*-----------------------------------------------------------
	Deletes a task.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskScheduler == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskScheduler_, (void **)&p_ITaskScheduler);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_name = 0;
	tmp_pwsz_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_name), NULL);
	
	EIF_ENTER_C;
	hr = p_ITaskScheduler->Delete(tmp_pwsz_name);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ccom_new_work_item(  /* [in] */ EIF_OBJECT pwsz_task_name,  /* [in] */ GUID * rclsid,  /* [in] */ GUID * a_riid,  /* [out] */ EIF_OBJECT pp_unk )

/*-----------------------------------------------------------
	Allocates space for a new task and retrieves its address.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskScheduler == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskScheduler_, (void **)&p_ITaskScheduler);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_task_name = 0;
	tmp_pwsz_task_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_task_name), NULL);
	IUnknown * * tmp_pp_unk = 0;
	tmp_pp_unk = (IUnknown * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_59 (eif_access (pp_unk), NULL);
	
	EIF_ENTER_C;
	hr = p_ITaskScheduler->NewWorkItem(tmp_pwsz_task_name,rclsid,a_riid,tmp_pp_unk);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_59 ((IUnknown * *)tmp_pp_unk, pp_unk);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_59 (tmp_pp_unk);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ccom_add_work_item(  /* [in] */ EIF_OBJECT pwsz_task_name,  /* [in] */ ecom_MS_TaskSched_lib::IScheduledWorkItem * p_work_item )

/*-----------------------------------------------------------
	Adds a task to the schedule of tasks.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskScheduler == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskScheduler_, (void **)&p_ITaskScheduler);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_task_name = 0;
	tmp_pwsz_task_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_task_name), NULL);
	
	EIF_ENTER_C;
	hr = p_ITaskScheduler->AddWorkItem(tmp_pwsz_task_name,p_work_item);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ccom_is_of_type(  /* [in] */ EIF_OBJECT pwsz_name,  /* [in] */ GUID * a_riid )

/*-----------------------------------------------------------
	Checks the object type.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskScheduler == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskScheduler_, (void **)&p_ITaskScheduler);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR tmp_pwsz_name = 0;
	tmp_pwsz_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwsz_name), NULL);
	
	EIF_ENTER_C;
	hr = p_ITaskScheduler->IsOfType(tmp_pwsz_name,a_riid);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_MS_TaskSched_lib::ITaskScheduler_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


