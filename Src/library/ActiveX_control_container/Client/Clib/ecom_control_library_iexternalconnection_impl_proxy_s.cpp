/*-----------------------------------------------------------
Implemented `IExternalConnection' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IExternalConnection_impl_proxy_s.h"
static const IID IID_IExternalConnection_ = {0x00000019,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IExternalConnection_impl_proxy::IExternalConnection_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IExternalConnection_, (void **)&p_IExternalConnection);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IExternalConnection_impl_proxy::~IExternalConnection_impl_proxy()
{
	p_unknown->Release ();
	if (p_IExternalConnection!=NULL)
		p_IExternalConnection->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_control_library::IExternalConnection_impl_proxy::ccom_add_connection(  /* [in] */ EIF_INTEGER extconn,  /* [in] */ EIF_INTEGER reserved )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IExternalConnection == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IExternalConnection_, (void **)&p_IExternalConnection);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_extconn = 0;
	tmp_extconn = (ULONG)extconn;
	ULONG tmp_reserved = 0;
	tmp_reserved = (ULONG)reserved;
	
	ULONG result = p_IExternalConnection->AddConnection(tmp_extconn,tmp_reserved);

	
	
	EIF_INTEGER eiffel_result =  (EIF_INTEGER)result;
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_control_library::IExternalConnection_impl_proxy::ccom_release_connection(  /* [in] */ EIF_INTEGER extconn,  /* [in] */ EIF_INTEGER reserved,  /* [in] */ EIF_INTEGER f_last_release_closes )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IExternalConnection == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IExternalConnection_, (void **)&p_IExternalConnection);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_extconn = 0;
	tmp_extconn = (ULONG)extconn;
	ULONG tmp_reserved = 0;
	tmp_reserved = (ULONG)reserved;
	LONG tmp_f_last_release_closes = 0;
	tmp_f_last_release_closes = (LONG)f_last_release_closes;
	
	ULONG result = p_IExternalConnection->ReleaseConnection(tmp_extconn,tmp_reserved,tmp_f_last_release_closes);

	
	
	EIF_INTEGER eiffel_result =  (EIF_INTEGER)result;
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IExternalConnection_impl_proxy::ccom_item()

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