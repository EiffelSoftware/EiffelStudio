/*-----------------------------------------------------------
Implemented `IPersistFile' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h"
static const IID IID_IPersistFile_ = {0x0000010b,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

ecom_MS_TaskSched_lib::IPersistFile_impl_proxy::IPersistFile_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	rt.ccom_check_hresult (hr);

	hr = a_pointer->QueryInterface(IID_IPersistFile_, (void **)&p_IPersistFile);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IPersistFile_impl_proxy::~IPersistFile_impl_proxy()
{
	p_unknown->Release ();
	if (p_IPersistFile != NULL)
		p_IPersistFile->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IPersistFile_impl_proxy::ccom_get_class_id(  /* [out] */ GUID * p_class_id )

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

void ecom_MS_TaskSched_lib::IPersistFile_impl_proxy::ccom_is_dirty()

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

void ecom_MS_TaskSched_lib::IPersistFile_impl_proxy::ccom_load(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER dw_mode )

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

void ecom_MS_TaskSched_lib::IPersistFile_impl_proxy::ccom_save(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER f_remember )

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

void ecom_MS_TaskSched_lib::IPersistFile_impl_proxy::ccom_save_completed(  /* [in] */ EIF_OBJECT psz_file_name )

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

void ecom_MS_TaskSched_lib::IPersistFile_impl_proxy::ccom_get_cur_file(  /* [out] */ EIF_OBJECT ppsz_file_name )

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

EIF_POINTER ecom_MS_TaskSched_lib::IPersistFile_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


