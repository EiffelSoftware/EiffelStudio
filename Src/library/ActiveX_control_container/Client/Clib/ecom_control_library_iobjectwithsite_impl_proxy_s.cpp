/*-----------------------------------------------------------
Implemented `IObjectWithSite' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IObjectWithSite_impl_proxy_s.h"
static const IID IID_IObjectWithSite_ = {0xfc4801a3,0x2ba9,0x11cf,{0xa2,0x29,0x00,0xaa,0x00,0x3d,0x73,0x52}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IObjectWithSite_impl_proxy::IObjectWithSite_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IObjectWithSite_, (void **)&p_IObjectWithSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IObjectWithSite_impl_proxy::~IObjectWithSite_impl_proxy()
{
	p_unknown->Release ();
	if (p_IObjectWithSite!=NULL)
		p_IObjectWithSite->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IObjectWithSite_impl_proxy::ccom_set_site(  /* [in] */ IUnknown * p_unk_site )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IObjectWithSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IObjectWithSite_, (void **)&p_IObjectWithSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IObjectWithSite->SetSite(p_unk_site);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IObjectWithSite_impl_proxy::ccom_get_site(  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_site )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IObjectWithSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IObjectWithSite_, (void **)&p_IObjectWithSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	void * * tmp_ppv_site = 0;
	tmp_ppv_site = (void * *)rt_ec.ccom_ec_pointed_pointer (eif_access (ppv_site), NULL);
	
	hr = p_IObjectWithSite->GetSite(riid,tmp_ppv_site);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_pointer ((void **)tmp_ppv_site, ppv_site);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_184 (tmp_ppv_site);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IObjectWithSite_impl_proxy::ccom_item()

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