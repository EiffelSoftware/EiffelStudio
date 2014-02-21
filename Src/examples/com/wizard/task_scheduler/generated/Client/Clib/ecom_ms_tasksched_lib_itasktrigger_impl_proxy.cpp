/*-----------------------------------------------------------
Implemented `ITaskTrigger' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_ITaskTrigger_impl_proxy.h"
static const IID IID_ITaskTrigger_ = {0x148bd52b,0xa2ab,0x11ce,{0xb1,0x1f,0x00,0xaa,0x00,0x53,0x05,0x03}};

ecom_MS_TaskSched_lib::ITaskTrigger_impl_proxy::ITaskTrigger_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	rt.ccom_check_hresult (hr);

	hr = a_pointer->QueryInterface(IID_ITaskTrigger_, (void **)&p_ITaskTrigger);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::ITaskTrigger_impl_proxy::~ITaskTrigger_impl_proxy()
{
	p_unknown->Release ();
	if (p_ITaskTrigger != NULL)
		p_ITaskTrigger->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskTrigger_impl_proxy::ccom_set_trigger(  /* [in] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger )

/*-----------------------------------------------------------
	Sets the task trigger values.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskTrigger == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskTrigger_, (void **)&p_ITaskTrigger);
		rt.ccom_check_hresult (hr);
	};
	
	EIF_ENTER_C;
	hr = p_ITaskTrigger->SetTrigger(p_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskTrigger_impl_proxy::ccom_get_trigger(  /* [out] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger )

/*-----------------------------------------------------------
	Retrieves the current task trigger.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskTrigger == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskTrigger_, (void **)&p_ITaskTrigger);
		rt.ccom_check_hresult (hr);
	};
	
	EIF_ENTER_C;
	hr = p_ITaskTrigger->GetTrigger(p_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::ITaskTrigger_impl_proxy::ccom_get_trigger_string(  /* [out] */ EIF_OBJECT ppwsz_trigger )

/*-----------------------------------------------------------
	Retrieves the current task trigger in the form of a string.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITaskTrigger == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITaskTrigger_, (void **)&p_ITaskTrigger);
		rt.ccom_check_hresult (hr);
	};
	LPWSTR * tmp_ppwsz_trigger = 0;
	tmp_ppwsz_trigger = (LPWSTR *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_43 (eif_access (ppwsz_trigger), NULL);
	
	EIF_ENTER_C;
	hr = p_ITaskTrigger->GetTriggerString(tmp_ppwsz_trigger);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_43 ((LPWSTR *)tmp_ppwsz_trigger, ppwsz_trigger);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_43 (tmp_ppwsz_trigger);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_MS_TaskSched_lib::ITaskTrigger_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


