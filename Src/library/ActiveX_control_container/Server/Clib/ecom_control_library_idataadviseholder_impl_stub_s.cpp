/*-----------------------------------------------------------
Implemented `IDataAdviseHolder' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDataAdviseHolder_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IDataAdviseHolder_ = {0x00000110,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDataAdviseHolder_impl_stub::IDataAdviseHolder_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDataAdviseHolder_impl_stub::~IDataAdviseHolder_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataAdviseHolder_impl_stub::Advise(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ ecom_control_library::tagFORMATETC * p_fetc, /* [in] */ ULONG advf, /* [in] */ ecom_control_library::IAdviseSink * p_advise, /* [out] */ ULONG * pdw_connection )

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
	EIF_OBJECT tmp_p_fetc = NULL;
	if (p_fetc != NULL)
	{
		tmp_p_fetc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_2 (p_fetc));
	}
	EIF_INTEGER tmp_advf = (EIF_INTEGER)advf;
	EIF_OBJECT tmp_p_advise = NULL;
	if (p_advise != NULL)
	{
		tmp_p_advise = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_108 (p_advise));
		p_advise->AddRef ();
	}
	EIF_OBJECT tmp_pdw_connection = NULL;
	if (pdw_connection != NULL)
	{
		tmp_pdw_connection = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_connection, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("advise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_data_object != NULL) ? eif_access (tmp_p_data_object) : NULL), ((tmp_p_fetc != NULL) ? eif_access (tmp_p_fetc) : NULL), (EIF_INTEGER)tmp_advf, ((tmp_p_advise != NULL) ? eif_access (tmp_p_advise) : NULL), ((tmp_pdw_connection != NULL) ? eif_access (tmp_pdw_connection) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_connection != NULL) ? eif_wean (tmp_pdw_connection) : NULL), pdw_connection);
	if (tmp_p_data_object != NULL)
		eif_wean (tmp_p_data_object);
	if (tmp_p_fetc != NULL)
		eif_wean (tmp_p_fetc);
	if (tmp_p_advise != NULL)
		eif_wean (tmp_p_advise);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataAdviseHolder_impl_stub::Unadvise(  /* [in] */ ULONG dw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_connection = (EIF_INTEGER)dw_connection;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("unadvise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_connection);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataAdviseHolder_impl_stub::EnumAdvise(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_advise )

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
	eiffel_procedure = eif_procedure ("enum_advise", type_id);

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

STDMETHODIMP ecom_control_library::IDataAdviseHolder_impl_stub::SendOnDataChange(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ ULONG dw_reserved, /* [in] */ ULONG advf )

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
	EIF_INTEGER tmp_dw_reserved = (EIF_INTEGER)dw_reserved;
	EIF_INTEGER tmp_advf = (EIF_INTEGER)advf;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("send_on_data_change", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_data_object != NULL) ? eif_access (tmp_p_data_object) : NULL), (EIF_INTEGER)tmp_dw_reserved, (EIF_INTEGER)tmp_advf);
	if (tmp_p_data_object != NULL)
		eif_wean (tmp_p_data_object);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IDataAdviseHolder_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IDataAdviseHolder_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDataAdviseHolder_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IDataAdviseHolder*>(this);
	else if (riid == IID_IDataAdviseHolder_)
		*ppv = static_cast<ecom_control_library::IDataAdviseHolder*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif