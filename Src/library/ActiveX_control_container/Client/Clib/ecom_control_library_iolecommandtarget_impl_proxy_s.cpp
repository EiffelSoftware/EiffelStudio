/*-----------------------------------------------------------
Implemented `IOleCommandTarget' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleCommandTarget_impl_proxy_s.h"
static const IID IID_IOleCommandTarget_ = {0xb722bccb,0x4e68,0x101b,{0xa2,0xbc,0x00,0xaa,0x00,0x40,0x47,0x70}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleCommandTarget_impl_proxy::IOleCommandTarget_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IOleCommandTarget_, (void **)&p_IOleCommandTarget);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleCommandTarget_impl_proxy::~IOleCommandTarget_impl_proxy()
{
	p_unknown->Release ();
	if (p_IOleCommandTarget!=NULL)
		p_IOleCommandTarget->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleCommandTarget_impl_proxy::ccom_query_status(  /* [in] */ GUID * pguid_cmd_group,  /* [in] */ EIF_INTEGER c_cmds,  /* [in, out] */ ecom_control_library::_tagOLECMD * prg_cmds,  /* [in, out] */ ecom_control_library::_tagOLECMDTEXT * p_cmd_text )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleCommandTarget == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleCommandTarget_, (void **)&p_IOleCommandTarget);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_c_cmds = 0;
	tmp_c_cmds = (ULONG)c_cmds;
	
	hr = p_IOleCommandTarget->QueryStatus(pguid_cmd_group,tmp_c_cmds,prg_cmds,p_cmd_text);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleCommandTarget_impl_proxy::ccom_exec(  /* [in] */ GUID * pguid_cmd_group,  /* [in] */ EIF_INTEGER n_cmd_id,  /* [in] */ EIF_INTEGER n_cmdexecopt,  /* [in] */ VARIANT * pva_in,  /* [in, out] */ VARIANT * pva_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleCommandTarget == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleCommandTarget_, (void **)&p_IOleCommandTarget);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_n_cmd_id = 0;
	tmp_n_cmd_id = (ULONG)n_cmd_id;
	ULONG tmp_n_cmdexecopt = 0;
	tmp_n_cmdexecopt = (ULONG)n_cmdexecopt;
	
	hr = p_IOleCommandTarget->Exec(pguid_cmd_group,tmp_n_cmd_id,tmp_n_cmdexecopt,pva_in,pva_out);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleCommandTarget_impl_proxy::ccom_item()

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