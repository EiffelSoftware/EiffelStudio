/*-----------------------------------------------------------
Implemented `IEnumConnections' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IEnumConnections_impl_proxy_s.h"
static const IID IID_IEnumConnections_ = {0xb196b287,0xbab4,0x101a,{0xb6,0x9c,0x00,0xaa,0x00,0x34,0x1d,0x07}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IEnumConnections_impl_proxy::IEnumConnections_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEnumConnections_, (void **)&p_IEnumConnections);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumConnections_impl_proxy::~IEnumConnections_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumConnections!=NULL)
		p_IEnumConnections->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IEnumConnections_impl_proxy::ccom_remote_next(  /* [in] */ EIF_INTEGER c_connections,  /* [out] */ ecom_control_library::tagCONNECTDATA * rgcd,  /* [out] */ EIF_OBJECT pc_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumConnections == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumConnections_, (void **)&p_IEnumConnections);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_c_connections = 0;
	tmp_c_connections = (ULONG)c_connections;
	ULONG * tmp_pc_fetched = 0;
	tmp_pc_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pc_fetched), NULL);
	
	hr = p_IEnumConnections->RemoteNext(tmp_c_connections,rgcd,tmp_pc_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pc_fetched, pc_fetched);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_143 (tmp_pc_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IEnumConnections_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER c_connections )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumConnections == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumConnections_, (void **)&p_IEnumConnections);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_c_connections = 0;
	tmp_c_connections = (ULONG)c_connections;
	
	hr = p_IEnumConnections->Skip(tmp_c_connections);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IEnumConnections_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumConnections == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumConnections_, (void **)&p_IEnumConnections);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEnumConnections->Reset ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IEnumConnections_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumConnections == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumConnections_, (void **)&p_IEnumConnections);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IEnumConnections * * tmp_ppenum = 0;
	tmp_ppenum = (ecom_control_library::IEnumConnections * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_146 (eif_access (ppenum), NULL);
	
	hr = p_IEnumConnections->Clone(tmp_ppenum);
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

EIF_POINTER ecom_control_library::IEnumConnections_impl_proxy::ccom_item()

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