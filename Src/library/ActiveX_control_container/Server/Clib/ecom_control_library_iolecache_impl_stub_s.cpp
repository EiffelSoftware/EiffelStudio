/*-----------------------------------------------------------
Implemented `IOleCache' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleCache_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleCache_ = {0x0000011e,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleCache_impl_stub::IOleCache_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleCache_impl_stub::~IOleCache_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleCache_impl_stub::Cache(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ULONG advf, /* [out] */ ULONG * pdw_connection )

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
	EIF_OBJECT tmp_pdw_connection = NULL;
	if (pdw_connection != NULL)
	{
		tmp_pdw_connection = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_connection, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("cache", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_formatetc != NULL) ? eif_access (tmp_p_formatetc) : NULL), (EIF_INTEGER)tmp_advf, ((tmp_pdw_connection != NULL) ? eif_access (tmp_pdw_connection) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_connection != NULL) ? eif_wean (tmp_pdw_connection) : NULL), pdw_connection);
	if (tmp_p_formatetc != NULL)
		eif_wean (tmp_p_formatetc);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleCache_impl_stub::Uncache(  /* [in] */ ULONG dw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_connection = (EIF_INTEGER)dw_connection;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("uncache", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_connection);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleCache_impl_stub::EnumCache(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_statdata )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum_statdata = NULL;
	if (ppenum_statdata != NULL)
	{
		tmp_ppenum_statdata = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_112 (ppenum_statdata, NULL));
		if (*ppenum_statdata != NULL)
			(*ppenum_statdata)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_cache", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum_statdata != NULL) ? eif_access (tmp_ppenum_statdata) : NULL));
	
	if (*ppenum_statdata != NULL)
		(*ppenum_statdata)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_112 (((tmp_ppenum_statdata != NULL) ? eif_wean (tmp_ppenum_statdata) : NULL), ppenum_statdata);
	if (*ppenum_statdata != NULL)
		(*ppenum_statdata)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleCache_impl_stub::InitCache(  /* [in] */ ecom_control_library::IDataObject * p_data_object )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_data_object = NULL;
	if (p_data_object != NULL)
	{
		tmp_p_data_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_106 (p_data_object));
		p_data_object->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("init_cache", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_data_object != NULL) ? eif_access (tmp_p_data_object) : NULL));
	if (tmp_p_data_object != NULL)
		eif_wean (tmp_p_data_object);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleCache_impl_stub::SetData(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ecom_control_library::wireSTGMEDIUM * pmedium, /* [in] */ LONG f_release )

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
		tmp_pmedium = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_114 (pmedium, NULL));
	}
	EIF_INTEGER tmp_f_release = (EIF_INTEGER)f_release;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_data", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_formatetc != NULL) ? eif_access (tmp_p_formatetc) : NULL), ((tmp_pmedium != NULL) ? eif_access (tmp_pmedium) : NULL), (EIF_INTEGER)tmp_f_release);
	if (tmp_p_formatetc != NULL)
		eif_wean (tmp_p_formatetc);
	if (tmp_pmedium != NULL)
		eif_wean (tmp_pmedium);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleCache_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleCache_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleCache_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleCache*>(this);
	else if (riid == IID_IOleCache_)
		*ppv = static_cast<ecom_control_library::IOleCache*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif