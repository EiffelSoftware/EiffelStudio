/*-----------------------------------------------------------
Implemented `IConnectionPoint' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IConnectionPoint_impl_proxy_s.h"


#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IConnectionPoint_impl_proxy::IConnectionPoint_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IConnectionPoint, (void **)&p_IConnectionPoint);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IConnectionPoint_impl_proxy::~IConnectionPoint_impl_proxy()
{
	p_unknown->Release ();
	if (p_IConnectionPoint!=NULL)
		p_IConnectionPoint->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IConnectionPoint_impl_proxy::ccom_get_connection_interface(  /* [out] */ GUID * p_iid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IConnectionPoint == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IConnectionPoint, (void **)&p_IConnectionPoint);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IConnectionPoint->GetConnectionInterface(p_iid);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IConnectionPoint_impl_proxy::ccom_get_connection_point_container(  /* [out] */ EIF_OBJECT pp_cpc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IConnectionPoint == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IConnectionPoint, (void **)&p_IConnectionPoint);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IConnectionPointContainer * * tmp_pp_cpc = 0;
	tmp_pp_cpc = (ecom_control_library::IConnectionPointContainer * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_156 (eif_access (pp_cpc), NULL);
	
	hr = p_IConnectionPoint->GetConnectionPointContainer(tmp_pp_cpc);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_156 ((ecom_control_library::IConnectionPointContainer * *)tmp_pp_cpc, pp_cpc);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_156 (tmp_pp_cpc);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IConnectionPoint_impl_proxy::ccom_advise(  /* [in] */ IUnknown * p_unk_sink,  /* [out] */ EIF_OBJECT pdw_cookie )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IConnectionPoint == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IConnectionPoint, (void **)&p_IConnectionPoint);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG * tmp_pdw_cookie = 0;
	tmp_pdw_cookie = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_cookie), NULL);
	
	hr = p_IConnectionPoint->Advise(p_unk_sink,tmp_pdw_cookie);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_cookie, pdw_cookie);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_157 (tmp_pdw_cookie);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IConnectionPoint_impl_proxy::ccom_unadvise(  /* [in] */ EIF_INTEGER dw_cookie )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IConnectionPoint == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IConnectionPoint, (void **)&p_IConnectionPoint);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_cookie = 0;
	tmp_dw_cookie = (ULONG)dw_cookie;
	
	hr = p_IConnectionPoint->Unadvise(tmp_dw_cookie);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IConnectionPoint_impl_proxy::ccom_enum_connections(  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IConnectionPoint == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IConnectionPoint, (void **)&p_IConnectionPoint);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IEnumConnections * * tmp_ppenum = 0;
	tmp_ppenum = (ecom_control_library::IEnumConnections * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_146 (eif_access (ppenum), NULL);
	
	hr = p_IConnectionPoint->EnumConnections(tmp_ppenum);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_146 ((ecom_control_library::IEnumConnections * *)tmp_ppenum, ppenum);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_146 (tmp_ppenum);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IConnectionPoint_impl_proxy::ccom_item()

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