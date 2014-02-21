/*-----------------------------------------------------------
Implemented `IPersist' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_IPersist_impl_proxy.h"
static const IID IID_IPersist_ = {0x0000010c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

ecom_MS_TaskSched_lib::IPersist_impl_proxy::IPersist_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	rt.ccom_check_hresult (hr);

	hr = a_pointer->QueryInterface(IID_IPersist_, (void **)&p_IPersist);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IPersist_impl_proxy::~IPersist_impl_proxy()
{
	p_unknown->Release ();
	if (p_IPersist != NULL)
		p_IPersist->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IPersist_impl_proxy::ccom_get_class_id(  /* [out] */ GUID * p_class_id )

/*-----------------------------------------------------------
	
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPersist == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPersist_, (void **)&p_IPersist);
		rt.ccom_check_hresult (hr);
	};
	
	EIF_ENTER_C;
	hr = p_IPersist->GetClassID(p_class_id);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_MS_TaskSched_lib::IPersist_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


