/*-----------------------------------------------------------
Implemented `IDataObject' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDataObject_impl_proxy_s.h"
static const IID IID_IDataObject_ = {0x0000010e,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDataObject_impl_proxy::IDataObject_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDataObject_impl_proxy::~IDataObject_impl_proxy()
{
	p_unknown->Release ();
	if (p_IDataObject!=NULL)
		p_IDataObject->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataObject_impl_proxy::ccom_remote_get_data(  /* [in] */ ecom_control_library::tagFORMATETC * pformatetc_in,  /* [out] */ EIF_OBJECT p_remote_medium )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireSTGMEDIUM * tmp_p_remote_medium = 0;
	tmp_p_remote_medium = (ecom_control_library::wireSTGMEDIUM *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_114 (eif_access (p_remote_medium), NULL);
	
	hr = p_IDataObject->RemoteGetData(pformatetc_in,tmp_p_remote_medium);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_114 ((ecom_control_library::wireSTGMEDIUM *)tmp_p_remote_medium, p_remote_medium);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_114 (tmp_p_remote_medium);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataObject_impl_proxy::ccom_remote_get_data_here(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in, out] */ EIF_OBJECT p_remote_medium )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireSTGMEDIUM * tmp_p_remote_medium = 0;
	tmp_p_remote_medium = (ecom_control_library::wireSTGMEDIUM *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_114 (eif_access (p_remote_medium), NULL);
	
	hr = p_IDataObject->RemoteGetDataHere(p_formatetc,tmp_p_remote_medium);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_114 ((ecom_control_library::wireSTGMEDIUM *)tmp_p_remote_medium, p_remote_medium);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_114 (tmp_p_remote_medium);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataObject_impl_proxy::ccom_query_get_data(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IDataObject->QueryGetData(p_formatetc);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataObject_impl_proxy::ccom_get_canonical_format_etc(  /* [in] */ ecom_control_library::tagFORMATETC * pformatect_in,  /* [out] */ ecom_control_library::tagFORMATETC * pformatetc_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IDataObject->GetCanonicalFormatEtc(pformatect_in,pformatetc_out);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataObject_impl_proxy::ccom_remote_set_data(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ EIF_OBJECT pmedium,  /* [in] */ EIF_INTEGER f_release )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireFLAG_STGMEDIUM * tmp_pmedium = 0;
	tmp_pmedium = (ecom_control_library::wireFLAG_STGMEDIUM *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_118 (eif_access (pmedium), NULL);
	LONG tmp_f_release = 0;
	tmp_f_release = (LONG)f_release;
	
	hr = p_IDataObject->RemoteSetData(p_formatetc,tmp_pmedium,tmp_f_release);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_118 (tmp_pmedium);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataObject_impl_proxy::ccom_enum_format_etc(  /* [in] */ EIF_INTEGER dw_direction,  /* [out] */ EIF_OBJECT ppenum_format_etc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_direction = 0;
	tmp_dw_direction = (ULONG)dw_direction;
	ecom_control_library::IEnumFORMATETC * * tmp_ppenum_format_etc = 0;
	tmp_ppenum_format_etc = (ecom_control_library::IEnumFORMATETC * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_121 (eif_access (ppenum_format_etc), NULL);
	
	hr = p_IDataObject->EnumFormatEtc(tmp_dw_direction,tmp_ppenum_format_etc);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_121 ((ecom_control_library::IEnumFORMATETC * *)tmp_ppenum_format_etc, ppenum_format_etc);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_121 (tmp_ppenum_format_etc);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataObject_impl_proxy::ccom_dadvise(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ EIF_INTEGER advf,  /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink,  /* [out] */ EIF_OBJECT pdw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_advf = 0;
	tmp_advf = (ULONG)advf;
	ULONG * tmp_pdw_connection = 0;
	tmp_pdw_connection = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_connection), NULL);
	
	hr = p_IDataObject->DAdvise(p_formatetc,tmp_advf,p_adv_sink,tmp_pdw_connection);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_connection, pdw_connection);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_122 (tmp_pdw_connection);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataObject_impl_proxy::ccom_dunadvise(  /* [in] */ EIF_INTEGER dw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_connection = 0;
	tmp_dw_connection = (ULONG)dw_connection;
	
	hr = p_IDataObject->DUnadvise(tmp_dw_connection);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataObject_impl_proxy::ccom_enum_dadvise(  /* [out] */ EIF_OBJECT ppenum_advise )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataObject_, (void **)&p_IDataObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IEnumSTATDATA * * tmp_ppenum_advise = 0;
	tmp_ppenum_advise = (ecom_control_library::IEnumSTATDATA * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_112 (eif_access (ppenum_advise), NULL);
	
	hr = p_IDataObject->EnumDAdvise(tmp_ppenum_advise);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_112 ((ecom_control_library::IEnumSTATDATA * *)tmp_ppenum_advise, ppenum_advise);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_112 (tmp_ppenum_advise);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IDataObject_impl_proxy::ccom_item()

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