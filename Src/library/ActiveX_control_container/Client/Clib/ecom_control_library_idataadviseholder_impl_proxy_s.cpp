/*-----------------------------------------------------------
Implemented `IDataAdviseHolder' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDataAdviseHolder_impl_proxy_s.h"
static const IID IID_IDataAdviseHolder_ = {0x00000110,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDataAdviseHolder_impl_proxy::IDataAdviseHolder_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IDataAdviseHolder_, (void **)&p_IDataAdviseHolder);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDataAdviseHolder_impl_proxy::~IDataAdviseHolder_impl_proxy()
{
	p_unknown->Release ();
	if (p_IDataAdviseHolder!=NULL)
		p_IDataAdviseHolder->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataAdviseHolder_impl_proxy::ccom_advise(  /* [in] */ ecom_control_library::IDataObject * p_data_object,  /* [in] */ ecom_control_library::tagFORMATETC * p_fetc,  /* [in] */ EIF_INTEGER advf,  /* [in] */ ecom_control_library::IAdviseSink * p_advise,  /* [out] */ EIF_OBJECT pdw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataAdviseHolder == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataAdviseHolder_, (void **)&p_IDataAdviseHolder);
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
	
	hr = p_IDataAdviseHolder->Advise(p_data_object,p_fetc,tmp_advf,p_advise,tmp_pdw_connection);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_connection, pdw_connection);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_109 (tmp_pdw_connection);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataAdviseHolder_impl_proxy::ccom_unadvise(  /* [in] */ EIF_INTEGER dw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataAdviseHolder == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataAdviseHolder_, (void **)&p_IDataAdviseHolder);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_connection = 0;
	tmp_dw_connection = (ULONG)dw_connection;
	
	hr = p_IDataAdviseHolder->Unadvise(tmp_dw_connection);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDataAdviseHolder_impl_proxy::ccom_enum_advise(  /* [out] */ EIF_OBJECT ppenum_advise )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataAdviseHolder == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataAdviseHolder_, (void **)&p_IDataAdviseHolder);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IEnumSTATDATA * * tmp_ppenum_advise = 0;
	tmp_ppenum_advise = (ecom_control_library::IEnumSTATDATA * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_112 (eif_access (ppenum_advise), NULL);
	
	hr = p_IDataAdviseHolder->EnumAdvise(tmp_ppenum_advise);
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

void ecom_control_library::IDataAdviseHolder_impl_proxy::ccom_send_on_data_change(  /* [in] */ ecom_control_library::IDataObject * p_data_object,  /* [in] */ EIF_INTEGER dw_reserved,  /* [in] */ EIF_INTEGER advf )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDataAdviseHolder == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDataAdviseHolder_, (void **)&p_IDataAdviseHolder);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_reserved = 0;
	tmp_dw_reserved = (ULONG)dw_reserved;
	ULONG tmp_advf = 0;
	tmp_advf = (ULONG)advf;
	
	hr = p_IDataAdviseHolder->SendOnDataChange(p_data_object,tmp_dw_reserved,tmp_advf);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IDataAdviseHolder_impl_proxy::ccom_item()

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