/*-----------------------------------------------------------
Implemented `IBindCtx' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IBindCtx_impl_proxy_s.h"
static const IID IID_IBindCtx_ = {0x0000000e,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IBindCtx_impl_proxy::IBindCtx_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBindCtx_impl_proxy::~IBindCtx_impl_proxy()
{
	p_unknown->Release ();
	if (p_IBindCtx!=NULL)
		p_IBindCtx->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_register_object_bound(  /* [in] */ IUnknown * punk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IBindCtx->RegisterObjectBound(punk);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_revoke_object_bound(  /* [in] */ IUnknown * punk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IBindCtx->RevokeObjectBound(punk);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_release_bound_objects()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IBindCtx->ReleaseBoundObjects ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_remote_set_bind_options(  /* [in] */ ecom_control_library::tagBIND_OPTS2 * pbindopts )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IBindCtx->RemoteSetBindOptions(pbindopts);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_remote_get_bind_options(  /* [in, out] */ ecom_control_library::tagBIND_OPTS2 * pbindopts )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IBindCtx->RemoteGetBindOptions(pbindopts);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_get_running_object_table(  /* [out] */ EIF_OBJECT pprot )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IRunningObjectTable * * tmp_pprot = 0;
	tmp_pprot = (ecom_control_library::IRunningObjectTable * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_86 (eif_access (pprot), NULL);
	
	hr = p_IBindCtx->GetRunningObjectTable(tmp_pprot);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_86 ((ecom_control_library::IRunningObjectTable * *)tmp_pprot, pprot);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_86 (tmp_pprot);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_register_object_param(  /* [in] */ EIF_OBJECT psz_key,  /* [in] */ IUnknown * punk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_psz_key = 0;
	tmp_psz_key = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_key), NULL);
	
	hr = p_IBindCtx->RegisterObjectParam(tmp_psz_key,punk);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_get_object_param(  /* [in] */ EIF_OBJECT psz_key,  /* [out] */ EIF_OBJECT ppunk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_psz_key = 0;
	tmp_psz_key = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_key), NULL);
	IUnknown * * tmp_ppunk = 0;
	tmp_ppunk = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_87 (eif_access (ppunk), NULL);
	
	hr = p_IBindCtx->GetObjectParam(tmp_psz_key,tmp_ppunk);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_87 ((IUnknown * *)tmp_ppunk, ppunk);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_87 (tmp_ppunk);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_enum_object_param(  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IEnumString * * tmp_ppenum = 0;
	tmp_ppenum = (ecom_control_library::IEnumString * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_90 (eif_access (ppenum), NULL);
	
	hr = p_IBindCtx->EnumObjectParam(tmp_ppenum);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_90 ((ecom_control_library::IEnumString * *)tmp_ppenum, ppenum);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_90 (tmp_ppenum);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindCtx_impl_proxy::ccom_revoke_object_param(  /* [in] */ EIF_OBJECT psz_key )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindCtx == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindCtx_, (void **)&p_IBindCtx);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_psz_key = 0;
	tmp_psz_key = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_key), NULL);
	
	hr = p_IBindCtx->RevokeObjectParam(tmp_psz_key);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IBindCtx_impl_proxy::ccom_item()

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