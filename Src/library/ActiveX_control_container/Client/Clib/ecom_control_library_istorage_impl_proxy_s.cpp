/*-----------------------------------------------------------
Implemented `IStorage' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IStorage_impl_proxy_s.h"
static const IID IID_IStorage_ = {0x0000000b,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IStorage_impl_proxy::IStorage_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

	hr = a_pointer->QueryInterface(IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IStorage_impl_proxy::~IStorage_impl_proxy()
{
	p_unknown->Release ();
	if (p_IStorage!=NULL)
		p_IStorage->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_create_stream(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ EIF_INTEGER grf_mode,  /* [in] */ EIF_INTEGER reserved1,  /* [in] */ EIF_INTEGER reserved2,  /* [out] */ EIF_OBJECT ppstm )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_pwcs_name = 0;
	tmp_pwcs_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_name), NULL);
	ULONG tmp_grf_mode = 0;
	tmp_grf_mode = (ULONG)grf_mode;
	ULONG tmp_reserved1 = 0;
	tmp_reserved1 = (ULONG)reserved1;
	ULONG tmp_reserved2 = 0;
	tmp_reserved2 = (ULONG)reserved2;
	ecom_control_library::IStream * * tmp_ppstm = 0;
	tmp_ppstm = (ecom_control_library::IStream * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_77 (eif_access (ppstm), NULL);
	
	hr = p_IStorage->CreateStream(tmp_pwcs_name,tmp_grf_mode,tmp_reserved1,tmp_reserved2,tmp_ppstm);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_77 ((ecom_control_library::IStream * *)tmp_ppstm, ppstm);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_77 (tmp_ppstm);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_remote_open_stream(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ EIF_INTEGER cb_reserved1,  /* [in] */ EIF_OBJECT reserved1,  /* [in] */ EIF_INTEGER grf_mode,  /* [in] */ EIF_INTEGER reserved2,  /* [out] */ EIF_OBJECT ppstm )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_pwcs_name = 0;
	tmp_pwcs_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_name), NULL);
	ULONG tmp_cb_reserved1 = 0;
	tmp_cb_reserved1 = (ULONG)cb_reserved1;
	UCHAR * tmp_reserved1 = 0;
	tmp_reserved1 = (UCHAR *)rt_ec.ccom_ec_pointed_unsigned_character (eif_access (reserved1), NULL);
	ULONG tmp_grf_mode = 0;
	tmp_grf_mode = (ULONG)grf_mode;
	ULONG tmp_reserved2 = 0;
	tmp_reserved2 = (ULONG)reserved2;
	ecom_control_library::IStream * * tmp_ppstm = 0;
	tmp_ppstm = (ecom_control_library::IStream * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_77 (eif_access (ppstm), NULL);
	
	hr = p_IStorage->RemoteOpenStream(tmp_pwcs_name,tmp_cb_reserved1,tmp_reserved1,tmp_grf_mode,tmp_reserved2,tmp_ppstm);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_77 ((ecom_control_library::IStream * *)tmp_ppstm, ppstm);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_281 (tmp_reserved1);
grt_ce_control_interfaces2.ccom_free_memory_pointed_77 (tmp_ppstm);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_create_storage(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ EIF_INTEGER grf_mode,  /* [in] */ EIF_INTEGER reserved1,  /* [in] */ EIF_INTEGER reserved2,  /* [out] */ EIF_OBJECT ppstg )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_pwcs_name = 0;
	tmp_pwcs_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_name), NULL);
	ULONG tmp_grf_mode = 0;
	tmp_grf_mode = (ULONG)grf_mode;
	ULONG tmp_reserved1 = 0;
	tmp_reserved1 = (ULONG)reserved1;
	ULONG tmp_reserved2 = 0;
	tmp_reserved2 = (ULONG)reserved2;
	ecom_control_library::IStorage * * tmp_ppstg = 0;
	tmp_ppstg = (ecom_control_library::IStorage * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_282 (eif_access (ppstg), NULL);
	
	hr = p_IStorage->CreateStorage(tmp_pwcs_name,tmp_grf_mode,tmp_reserved1,tmp_reserved2,tmp_ppstg);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_282 ((ecom_control_library::IStorage * *)tmp_ppstg, ppstg);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_282 (tmp_ppstg);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_open_storage(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ ecom_control_library::IStorage * pstg_priority,  /* [in] */ EIF_INTEGER grf_mode,  /* [in] */ ecom_control_library::wireSNB snb_exclude,  /* [in] */ EIF_INTEGER reserved,  /* [out] */ EIF_OBJECT ppstg )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_pwcs_name = 0;
	tmp_pwcs_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_name), NULL);
	ULONG tmp_grf_mode = 0;
	tmp_grf_mode = (ULONG)grf_mode;
	ULONG tmp_reserved = 0;
	tmp_reserved = (ULONG)reserved;
	ecom_control_library::IStorage * * tmp_ppstg = 0;
	tmp_ppstg = (ecom_control_library::IStorage * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_282 (eif_access (ppstg), NULL);
	
	hr = p_IStorage->OpenStorage(tmp_pwcs_name,pstg_priority,tmp_grf_mode,snb_exclude,tmp_reserved,tmp_ppstg);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_282 ((ecom_control_library::IStorage * *)tmp_ppstg, ppstg);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_282 (tmp_ppstg);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_copy_to(  /* [in] */ EIF_INTEGER ciid_exclude,  /* [in] */ GUID * rgiid_exclude,  /* [in] */ ecom_control_library::wireSNB snb_exclude,  /* [in] */ ecom_control_library::IStorage * pstg_dest )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ciid_exclude = 0;
	tmp_ciid_exclude = (ULONG)ciid_exclude;
	
	hr = p_IStorage->CopyTo(tmp_ciid_exclude,rgiid_exclude,snb_exclude,pstg_dest);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_move_element_to(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ ecom_control_library::IStorage * pstg_dest,  /* [in] */ EIF_OBJECT pwcs_new_name,  /* [in] */ EIF_INTEGER grf_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_pwcs_name = 0;
	tmp_pwcs_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_name), NULL);
	LPWSTR tmp_pwcs_new_name = 0;
	tmp_pwcs_new_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_new_name), NULL);
	ULONG tmp_grf_flags = 0;
	tmp_grf_flags = (ULONG)grf_flags;
	
	hr = p_IStorage->MoveElementTo(tmp_pwcs_name,pstg_dest,tmp_pwcs_new_name,tmp_grf_flags);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_commit(  /* [in] */ EIF_INTEGER grf_commit_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_commit_flags = 0;
	tmp_grf_commit_flags = (ULONG)grf_commit_flags;
	
	hr = p_IStorage->Commit(tmp_grf_commit_flags);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_revert()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IStorage->Revert ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_remote_enum_elements(  /* [in] */ EIF_INTEGER reserved1,  /* [in] */ EIF_INTEGER cb_reserved2,  /* [in] */ EIF_OBJECT reserved2,  /* [in] */ EIF_INTEGER reserved3,  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_reserved1 = 0;
	tmp_reserved1 = (ULONG)reserved1;
	ULONG tmp_cb_reserved2 = 0;
	tmp_cb_reserved2 = (ULONG)cb_reserved2;
	UCHAR * tmp_reserved2 = 0;
	tmp_reserved2 = (UCHAR *)rt_ec.ccom_ec_pointed_unsigned_character (eif_access (reserved2), NULL);
	ULONG tmp_reserved3 = 0;
	tmp_reserved3 = (ULONG)reserved3;
	ecom_control_library::IEnumSTATSTG * * tmp_ppenum = 0;
	tmp_ppenum = (ecom_control_library::IEnumSTATSTG * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_289 (eif_access (ppenum), NULL);
	
	hr = p_IStorage->RemoteEnumElements(tmp_reserved1,tmp_cb_reserved2,tmp_reserved2,tmp_reserved3,tmp_ppenum);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_289 ((ecom_control_library::IEnumSTATSTG * *)tmp_ppenum, ppenum);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_286 (tmp_reserved2);
grt_ce_control_interfaces2.ccom_free_memory_pointed_289 (tmp_ppenum);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_destroy_element(  /* [in] */ EIF_OBJECT pwcs_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_pwcs_name = 0;
	tmp_pwcs_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_name), NULL);
	
	hr = p_IStorage->DestroyElement(tmp_pwcs_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_rename_element(  /* [in] */ EIF_OBJECT pwcs_old_name,  /* [in] */ EIF_OBJECT pwcs_new_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_pwcs_old_name = 0;
	tmp_pwcs_old_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_old_name), NULL);
	LPWSTR tmp_pwcs_new_name = 0;
	tmp_pwcs_new_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_new_name), NULL);
	
	hr = p_IStorage->RenameElement(tmp_pwcs_old_name,tmp_pwcs_new_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_set_element_times(  /* [in] */ EIF_OBJECT pwcs_name,  /* [in] */ ecom_control_library::_FILETIME * pctime,  /* [in] */ ecom_control_library::_FILETIME * patime,  /* [in] */ ecom_control_library::_FILETIME * pmtime )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_pwcs_name = 0;
	tmp_pwcs_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pwcs_name), NULL);
	
	hr = p_IStorage->SetElementTimes(tmp_pwcs_name,pctime,patime,pmtime);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_set_class(  /* [in] */ GUID * clsid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IStorage->SetClass(clsid);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_set_state_bits(  /* [in] */ EIF_INTEGER grf_state_bits,  /* [in] */ EIF_INTEGER grf_mask )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_state_bits = 0;
	tmp_grf_state_bits = (ULONG)grf_state_bits;
	ULONG tmp_grf_mask = 0;
	tmp_grf_mask = (ULONG)grf_mask;
	
	hr = p_IStorage->SetStateBits(tmp_grf_state_bits,tmp_grf_mask);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStorage_impl_proxy::ccom_stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg,  /* [in] */ EIF_INTEGER grf_stat_flag )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStorage == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStorage_, (void **)&p_IStorage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_stat_flag = 0;
	tmp_grf_stat_flag = (ULONG)grf_stat_flag;
	
	hr = p_IStorage->Stat(pstatstg,tmp_grf_stat_flag);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IStorage_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif