/*-----------------------------------------------------------
Implemented `IRunningObjectTable' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IRunningObjectTable_impl_proxy_s.h"
static const IID IID_IRunningObjectTable_ = {0x00000010,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IRunningObjectTable_impl_proxy::IRunningObjectTable_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IRunningObjectTable_, (void **)&p_IRunningObjectTable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IRunningObjectTable_impl_proxy::~IRunningObjectTable_impl_proxy()
{
	p_unknown->Release ();
	if (p_IRunningObjectTable!=NULL)
		p_IRunningObjectTable->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IRunningObjectTable_impl_proxy::ccom_register(  /* [in] */ EIF_INTEGER grf_flags,  /* [in] */ IUnknown * punk_object,  /* [in] */ ecom_control_library::IMoniker * pmk_object_name,  /* [out] */ EIF_OBJECT pdw_register )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IRunningObjectTable == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IRunningObjectTable_, (void **)&p_IRunningObjectTable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_flags = 0;
	tmp_grf_flags = (ULONG)grf_flags;
	ULONG * tmp_pdw_register = 0;
	tmp_pdw_register = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_register), NULL);
	
	hr = p_IRunningObjectTable->Register(tmp_grf_flags,punk_object,pmk_object_name,tmp_pdw_register);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_register, pdw_register);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_100 (tmp_pdw_register);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IRunningObjectTable_impl_proxy::ccom_revoke(  /* [in] */ EIF_INTEGER dw_register )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IRunningObjectTable == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IRunningObjectTable_, (void **)&p_IRunningObjectTable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_register = 0;
	tmp_dw_register = (ULONG)dw_register;
	
	hr = p_IRunningObjectTable->Revoke(tmp_dw_register);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IRunningObjectTable_impl_proxy::ccom_is_running(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IRunningObjectTable == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IRunningObjectTable_, (void **)&p_IRunningObjectTable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IRunningObjectTable->IsRunning(pmk_object_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IRunningObjectTable_impl_proxy::ccom_get_object(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name,  /* [out] */ EIF_OBJECT ppunk_object )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IRunningObjectTable == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IRunningObjectTable_, (void **)&p_IRunningObjectTable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	IUnknown * * tmp_ppunk_object = 0;
	tmp_ppunk_object = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_101 (eif_access (ppunk_object), NULL);
	
	hr = p_IRunningObjectTable->GetObject(pmk_object_name,tmp_ppunk_object);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_101 ((IUnknown * *)tmp_ppunk_object, ppunk_object);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_101 (tmp_ppunk_object);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IRunningObjectTable_impl_proxy::ccom_note_change_time(  /* [in] */ EIF_INTEGER dw_register,  /* [in] */ ecom_control_library::_FILETIME * pfiletime )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IRunningObjectTable == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IRunningObjectTable_, (void **)&p_IRunningObjectTable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_register = 0;
	tmp_dw_register = (ULONG)dw_register;
	
	hr = p_IRunningObjectTable->NoteChangeTime(tmp_dw_register,pfiletime);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IRunningObjectTable_impl_proxy::ccom_get_time_of_last_change(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name,  /* [out] */ ecom_control_library::_FILETIME * pfiletime )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IRunningObjectTable == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IRunningObjectTable_, (void **)&p_IRunningObjectTable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IRunningObjectTable->GetTimeOfLastChange(pmk_object_name,pfiletime);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IRunningObjectTable_impl_proxy::ccom_enum_running(  /* [out] */ EIF_OBJECT ppenum_moniker )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IRunningObjectTable == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IRunningObjectTable_, (void **)&p_IRunningObjectTable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IEnumMoniker * * tmp_ppenum_moniker = 0;
	tmp_ppenum_moniker = (ecom_control_library::IEnumMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_63 (eif_access (ppenum_moniker), NULL);
	
	hr = p_IRunningObjectTable->EnumRunning(tmp_ppenum_moniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_63 ((ecom_control_library::IEnumMoniker * *)tmp_ppenum_moniker, ppenum_moniker);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_63 (tmp_ppenum_moniker);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IRunningObjectTable_impl_proxy::ccom_item()

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