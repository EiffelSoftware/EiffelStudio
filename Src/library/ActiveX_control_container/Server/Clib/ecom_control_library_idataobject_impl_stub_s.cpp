/*-----------------------------------------------------------
Implemented `IDataObject' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDataObject_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IDataObject_ = {0x0000010e,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDataObject_impl_stub::IDataObject_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDataObject_impl_stub::~IDataObject_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::RemoteGetData(  /* [in] */ ecom_control_library::tagFORMATETC * pformatetc_in, /* [out] */ ecom_control_library::wireSTGMEDIUM * p_remote_medium )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pformatetc_in = NULL;
	if (pformatetc_in != NULL)
	{
		tmp_pformatetc_in = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_2 (pformatetc_in));
	}
	EIF_OBJECT tmp_p_remote_medium = NULL;
	if (p_remote_medium != NULL)
	{
		tmp_p_remote_medium = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_114 (p_remote_medium, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_data", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pformatetc_in != NULL) ? eif_access (tmp_pformatetc_in) : NULL), ((tmp_p_remote_medium != NULL) ? eif_access (tmp_p_remote_medium) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_114 (((tmp_p_remote_medium != NULL) ? eif_wean (tmp_p_remote_medium) : NULL), p_remote_medium);
	if (tmp_pformatetc_in != NULL)
		eif_wean (tmp_pformatetc_in);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::RemoteGetDataHere(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in, out] */ ecom_control_library::wireSTGMEDIUM * p_remote_medium )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_formatetc = NULL;
	if (p_formatetc != NULL)
	{
		tmp_p_formatetc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_2 (p_formatetc));
	}
	EIF_OBJECT tmp_p_remote_medium = NULL;
	if (p_remote_medium != NULL)
	{
		tmp_p_remote_medium = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_114 (p_remote_medium, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_data_here", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_formatetc != NULL) ? eif_access (tmp_p_formatetc) : NULL), ((tmp_p_remote_medium != NULL) ? eif_access (tmp_p_remote_medium) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_114 (((tmp_p_remote_medium != NULL) ? eif_wean (tmp_p_remote_medium) : NULL), p_remote_medium);
	if (tmp_p_formatetc != NULL)
		eif_wean (tmp_p_formatetc);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::QueryGetData(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_formatetc = NULL;
	if (p_formatetc != NULL)
	{
		tmp_p_formatetc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_2 (p_formatetc));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("query_get_data", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_formatetc != NULL) ? eif_access (tmp_p_formatetc) : NULL));
	if (tmp_p_formatetc != NULL)
		eif_wean (tmp_p_formatetc);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::GetCanonicalFormatEtc(  /* [in] */ ecom_control_library::tagFORMATETC * pformatect_in, /* [out] */ ecom_control_library::tagFORMATETC * pformatetc_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pformatect_in = NULL;
	if (pformatect_in != NULL)
	{
		tmp_pformatect_in = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_2 (pformatect_in));
	}
	EIF_OBJECT tmp_pformatetc_out = NULL;
	if (pformatetc_out != NULL)
	{
		tmp_pformatetc_out = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_2 (pformatetc_out));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_canonical_format_etc", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pformatect_in != NULL) ? eif_access (tmp_pformatect_in) : NULL), ((tmp_pformatetc_out != NULL) ? eif_access (tmp_pformatetc_out) : NULL));
	
	if (tmp_pformatect_in != NULL)
		eif_wean (tmp_pformatect_in);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::RemoteSetData(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ecom_control_library::wireFLAG_STGMEDIUM * pmedium, /* [in] */ LONG f_release )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_formatetc = NULL;
	if (p_formatetc != NULL)
	{
		tmp_p_formatetc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_2 (p_formatetc));
	}
	EIF_OBJECT tmp_pmedium = NULL;
	if (pmedium != NULL)
	{
		tmp_pmedium = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_118 (pmedium, NULL));
	}
	EIF_INTEGER tmp_f_release = (EIF_INTEGER)f_release;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_set_data", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_formatetc != NULL) ? eif_access (tmp_p_formatetc) : NULL), ((tmp_pmedium != NULL) ? eif_access (tmp_pmedium) : NULL), (EIF_INTEGER)tmp_f_release);
	if (tmp_p_formatetc != NULL)
		eif_wean (tmp_p_formatetc);
	if (tmp_pmedium != NULL)
		eif_wean (tmp_pmedium);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::EnumFormatEtc(  /* [in] */ ULONG dw_direction, /* [out] */ ecom_control_library::IEnumFORMATETC * * ppenum_format_etc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_direction = (EIF_INTEGER)dw_direction;
	EIF_OBJECT tmp_ppenum_format_etc = NULL;
	if (ppenum_format_etc != NULL)
	{
		tmp_ppenum_format_etc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_121 (ppenum_format_etc, NULL));
		if (*ppenum_format_etc != NULL)
			(*ppenum_format_etc)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_format_etc", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_direction, ((tmp_ppenum_format_etc != NULL) ? eif_access (tmp_ppenum_format_etc) : NULL));
	
	if (*ppenum_format_etc != NULL)
		(*ppenum_format_etc)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_121 (((tmp_ppenum_format_etc != NULL) ? eif_wean (tmp_ppenum_format_etc) : NULL), ppenum_format_etc);
	if (*ppenum_format_etc != NULL)
		(*ppenum_format_etc)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::DAdvise(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ULONG advf, /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink, /* [out] */ ULONG * pdw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_formatetc = NULL;
	if (p_formatetc != NULL)
	{
		tmp_p_formatetc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_2 (p_formatetc));
	}
	EIF_INTEGER tmp_advf = (EIF_INTEGER)advf;
	EIF_OBJECT tmp_p_adv_sink = NULL;
	if (p_adv_sink != NULL)
	{
		tmp_p_adv_sink = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_108 (p_adv_sink));
		p_adv_sink->AddRef ();
	}
	EIF_OBJECT tmp_pdw_connection = NULL;
	if (pdw_connection != NULL)
	{
		tmp_pdw_connection = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_connection, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("dadvise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_formatetc != NULL) ? eif_access (tmp_p_formatetc) : NULL), (EIF_INTEGER)tmp_advf, ((tmp_p_adv_sink != NULL) ? eif_access (tmp_p_adv_sink) : NULL), ((tmp_pdw_connection != NULL) ? eif_access (tmp_pdw_connection) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_connection != NULL) ? eif_wean (tmp_pdw_connection) : NULL), pdw_connection);
	if (tmp_p_formatetc != NULL)
		eif_wean (tmp_p_formatetc);
	if (tmp_p_adv_sink != NULL)
		eif_wean (tmp_p_adv_sink);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::DUnadvise(  /* [in] */ ULONG dw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_connection = (EIF_INTEGER)dw_connection;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("dunadvise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_connection);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::EnumDAdvise(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_advise )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum_advise = NULL;
	if (ppenum_advise != NULL)
	{
		tmp_ppenum_advise = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_112 (ppenum_advise, NULL));
		if (*ppenum_advise != NULL)
			(*ppenum_advise)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_dadvise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum_advise != NULL) ? eif_access (tmp_ppenum_advise) : NULL));
	
	if (*ppenum_advise != NULL)
		(*ppenum_advise)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_112 (((tmp_ppenum_advise != NULL) ? eif_wean (tmp_ppenum_advise) : NULL), ppenum_advise);
	if (*ppenum_advise != NULL)
		(*ppenum_advise)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IDataObject_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IDataObject_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataObject_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IDataObject*>(this);
	else if (riid == IID_IDataObject_)
		*ppv = static_cast<ecom_control_library::IDataObject*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif