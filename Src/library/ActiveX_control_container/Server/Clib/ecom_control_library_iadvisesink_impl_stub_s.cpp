/*-----------------------------------------------------------
Implemented `IAdviseSink' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IAdviseSink_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IAdviseSink_ = {0x0000010f,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IAdviseSink_impl_stub::IAdviseSink_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IAdviseSink_impl_stub::~IAdviseSink_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAdviseSink_impl_stub::RemoteOnDataChange(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ecom_control_library::wireASYNC_STGMEDIUM * p_stgmed )

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
	EIF_OBJECT tmp_p_stgmed = NULL;
	if (p_stgmed != NULL)
	{
		tmp_p_stgmed = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_6 (p_stgmed, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_on_data_change", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_formatetc != NULL) ? eif_access (tmp_p_formatetc) : NULL), ((tmp_p_stgmed != NULL) ? eif_access (tmp_p_stgmed) : NULL));
	if (tmp_p_formatetc != NULL)
		eif_wean (tmp_p_formatetc);
	if (tmp_p_stgmed != NULL)
		eif_wean (tmp_p_stgmed);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAdviseSink_impl_stub::RemoteOnViewChange(  /* [in] */ ULONG dw_aspect, /* [in] */ LONG lindex )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_aspect = (EIF_INTEGER)dw_aspect;
	EIF_INTEGER tmp_lindex = (EIF_INTEGER)lindex;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_on_view_change", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_aspect, (EIF_INTEGER)tmp_lindex);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAdviseSink_impl_stub::RemoteOnRename(  /* [in] */ ecom_control_library::IMoniker * pmk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pmk = NULL;
	if (pmk != NULL)
	{
		tmp_pmk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk));
		pmk->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_on_rename", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk != NULL) ? eif_access (tmp_pmk) : NULL));
	if (tmp_pmk != NULL)
		eif_wean (tmp_pmk);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAdviseSink_impl_stub::RemoteOnSave( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("remote_on_save", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAdviseSink_impl_stub::RemoteOnClose( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("remote_on_close", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IAdviseSink_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IAdviseSink_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAdviseSink_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IAdviseSink*>(this);
	else if (riid == IID_IAdviseSink_)
		*ppv = static_cast<ecom_control_library::IAdviseSink*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif