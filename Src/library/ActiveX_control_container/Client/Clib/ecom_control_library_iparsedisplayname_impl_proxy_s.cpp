/*-----------------------------------------------------------
Implemented `IParseDisplayName' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IParseDisplayName_impl_proxy_s.h"
static const IID IID_IParseDisplayName_ = {0x0000011a,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IParseDisplayName_impl_proxy::IParseDisplayName_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IParseDisplayName_, (void **)&p_IParseDisplayName);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IParseDisplayName_impl_proxy::~IParseDisplayName_impl_proxy()
{
	p_unknown->Release ();
	if (p_IParseDisplayName!=NULL)
		p_IParseDisplayName->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IParseDisplayName_impl_proxy::ccom_parse_display_name(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ EIF_OBJECT psz_display_name,  /* [out] */ EIF_OBJECT pch_eaten,  /* [out] */ EIF_OBJECT ppmk_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IParseDisplayName == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IParseDisplayName_, (void **)&p_IParseDisplayName);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_psz_display_name = 0;
	tmp_psz_display_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_display_name), NULL);
	ULONG * tmp_pch_eaten = 0;
	tmp_pch_eaten = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pch_eaten), NULL);
	ecom_control_library::IMoniker * * tmp_ppmk_out = 0;
	tmp_ppmk_out = (ecom_control_library::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk_out), NULL);
	
	hr = p_IParseDisplayName->ParseDisplayName(pbc,tmp_psz_display_name,tmp_pch_eaten,tmp_ppmk_out);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pch_eaten, pch_eaten);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((ecom_control_library::IMoniker * *)tmp_ppmk_out, ppmk_out);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_192 (tmp_pch_eaten);
grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk_out);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IParseDisplayName_impl_proxy::ccom_item()

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