/*-----------------------------------------------------------
Implemented `IStream' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IStream_impl_proxy_s.h"
static const IID IID_IStream_ = {0x0000000c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IStream_impl_proxy::IStream_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IStream_impl_proxy::~IStream_impl_proxy()
{
	p_unknown->Release ();
	if (p_IStream!=NULL)
		p_IStream->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_remote_read(  /* [out] */ EIF_OBJECT pv,  /* [in] */ EIF_INTEGER cb,  /* [out] */ EIF_OBJECT pcb_read )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UCHAR * tmp_pv = 0;
	tmp_pv = (UCHAR *)rt_ec.ccom_ec_pointed_unsigned_character (eif_access (pv), NULL);
	ULONG tmp_cb = 0;
	tmp_cb = (ULONG)cb;
	ULONG * tmp_pcb_read = 0;
	tmp_pcb_read = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcb_read), NULL);
	
	hr = p_IStream->RemoteRead(tmp_pv,tmp_cb,tmp_pcb_read);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_character ((UCHAR *)tmp_pv, pv);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcb_read, pcb_read);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_78 (tmp_pv);
grt_ce_control_interfaces2.ccom_free_memory_pointed_79 (tmp_pcb_read);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_remote_write(  /* [in] */ EIF_OBJECT pv,  /* [in] */ EIF_INTEGER cb,  /* [out] */ EIF_OBJECT pcb_written )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UCHAR * tmp_pv = 0;
	tmp_pv = (UCHAR *)rt_ec.ccom_ec_pointed_unsigned_character (eif_access (pv), NULL);
	ULONG tmp_cb = 0;
	tmp_cb = (ULONG)cb;
	ULONG * tmp_pcb_written = 0;
	tmp_pcb_written = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcb_written), NULL);
	
	hr = p_IStream->RemoteWrite(tmp_pv,tmp_cb,tmp_pcb_written);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcb_written, pcb_written);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_80 (tmp_pv);
grt_ce_control_interfaces2.ccom_free_memory_pointed_81 (tmp_pcb_written);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_remote_seek(  /* [in] */ ecom_control_library::_LARGE_INTEGER * dlib_move,  /* [in] */ EIF_INTEGER dw_origin,  /* [out] */ ecom_control_library::_ULARGE_INTEGER * plib_new_position )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_origin = 0;
	tmp_dw_origin = (ULONG)dw_origin;
	
	hr = p_IStream->RemoteSeek(*(ecom_control_library::_LARGE_INTEGER*)dlib_move,tmp_dw_origin,plib_new_position);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_set_size(  /* [in] */ ecom_control_library::_ULARGE_INTEGER * lib_new_size )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IStream->SetSize(*(ecom_control_library::_ULARGE_INTEGER*)lib_new_size);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_remote_copy_to(  /* [in] */ ecom_control_library::IStream * pstm,  /* [in] */ ecom_control_library::_ULARGE_INTEGER * cb,  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_read,  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_written )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IStream->RemoteCopyTo(pstm,*(ecom_control_library::_ULARGE_INTEGER*)cb,pcb_read,pcb_written);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_commit(  /* [in] */ EIF_INTEGER grf_commit_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_commit_flags = 0;
	tmp_grf_commit_flags = (ULONG)grf_commit_flags;
	
	hr = p_IStream->Commit(tmp_grf_commit_flags);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_revert()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IStream->Revert ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_lock_region(  /* [in] */ ecom_control_library::_ULARGE_INTEGER * lib_offset,  /* [in] */ ecom_control_library::_ULARGE_INTEGER * cb,  /* [in] */ EIF_INTEGER dw_lock_type )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_lock_type = 0;
	tmp_dw_lock_type = (ULONG)dw_lock_type;
	
	hr = p_IStream->LockRegion(*(ecom_control_library::_ULARGE_INTEGER*)lib_offset,*(ecom_control_library::_ULARGE_INTEGER*)cb,tmp_dw_lock_type);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_unlock_region(  /* [in] */ ecom_control_library::_ULARGE_INTEGER * lib_offset,  /* [in] */ ecom_control_library::_ULARGE_INTEGER * cb,  /* [in] */ EIF_INTEGER dw_lock_type )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_lock_type = 0;
	tmp_dw_lock_type = (ULONG)dw_lock_type;
	
	hr = p_IStream->UnlockRegion(*(ecom_control_library::_ULARGE_INTEGER*)lib_offset,*(ecom_control_library::_ULARGE_INTEGER*)cb,tmp_dw_lock_type);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg,  /* [in] */ EIF_INTEGER grf_stat_flag )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_stat_flag = 0;
	tmp_grf_stat_flag = (ULONG)grf_stat_flag;
	
	hr = p_IStream->Stat(pstatstg,tmp_grf_stat_flag);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IStream_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT ppstm )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IStream_, (void **)&p_IStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IStream * * tmp_ppstm = 0;
	tmp_ppstm = (ecom_control_library::IStream * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_77 (eif_access (ppstm), NULL);
	
	hr = p_IStream->Clone(tmp_ppstm);
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

EIF_POINTER ecom_control_library::IStream_impl_proxy::ccom_item()

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