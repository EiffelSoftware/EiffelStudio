/*-----------------------------------------------------------
Implemented `IProvideTaskPage' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_IProvideTaskPage_impl_proxy.h"
static const IID IID_IProvideTaskPage_ = {0x4086658a,0xcbbb,0x11cf,{0xb6,0x04,0x00,0xc0,0x4f,0xd8,0xd5,0x65}};

ecom_MS_TaskSched_lib::IProvideTaskPage_impl_proxy::IProvideTaskPage_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	rt.ccom_check_hresult (hr);

	hr = a_pointer->QueryInterface(IID_IProvideTaskPage_, (void **)&p_IProvideTaskPage);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IProvideTaskPage_impl_proxy::~IProvideTaskPage_impl_proxy()
{
	p_unknown->Release ();
	if (p_IProvideTaskPage != NULL)
		p_IProvideTaskPage->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IProvideTaskPage_impl_proxy::ccom_get_page(  /* [in] */ EIF_INTEGER tp_type,  /* [in] */ EIF_INTEGER f_persist_changes,  /* [out] */ EIF_OBJECT ph_page )

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

EIF_POINTER ecom_MS_TaskSched_lib::IProvideTaskPage_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


