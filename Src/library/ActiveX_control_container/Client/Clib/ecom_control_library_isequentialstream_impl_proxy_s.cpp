/*-----------------------------------------------------------
Implemented `ISequentialStream' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ISequentialStream_impl_proxy_s.h"
static const IID IID_ISequentialStream_ = {0x0c733a30,0x2a1c,0x11ce,{0xad,0xe5,0x00,0xaa,0x00,0x44,0x77,0x3d}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ISequentialStream_impl_proxy::ISequentialStream_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_ISequentialStream_, (void **)&p_ISequentialStream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ISequentialStream_impl_proxy::~ISequentialStream_impl_proxy()
{
	p_unknown->Release ();
	if (p_ISequentialStream!=NULL)
		p_ISequentialStream->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ISequentialStream_impl_proxy::ccom_remote_read(  /* [out] */ EIF_OBJECT pv,  /* [in] */ EIF_INTEGER cb,  /* [out] */ EIF_OBJECT pcb_read )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ISequentialStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ISequentialStream_, (void **)&p_ISequentialStream);
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
	
	hr = p_ISequentialStream->RemoteRead(tmp_pv,tmp_cb,tmp_pcb_read);
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

void ecom_control_library::ISequentialStream_impl_proxy::ccom_remote_write(  /* [in] */ EIF_OBJECT pv,  /* [in] */ EIF_INTEGER cb,  /* [out] */ EIF_OBJECT pcb_written )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ISequentialStream == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ISequentialStream_, (void **)&p_ISequentialStream);
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
	
	hr = p_ISequentialStream->RemoteWrite(tmp_pv,tmp_cb,tmp_pcb_written);
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

EIF_POINTER ecom_control_library::ISequentialStream_impl_proxy::ccom_item()

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