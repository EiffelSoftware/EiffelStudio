/*-----------------------------------------------------------
Implemented `IEnumSTATDATA' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IEnumSTATDATA_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEnumSTATDATA_ = {0x00000105,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IEnumSTATDATA_impl_stub::IEnumSTATDATA_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IEnumSTATDATA_impl_stub::~IEnumSTATDATA_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IEnumSTATDATA_impl_stub::RemoteNext(  /* [in] */ ULONG celt, /* [out] */ ecom_control_library::tagSTATDATA * rgelt, /* [out] */ ULONG * pcelt_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_celt = (EIF_INTEGER)celt;
	EIF_OBJECT tmp_rgelt = NULL;
	if (rgelt != NULL)
	{
		tmp_rgelt = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_125 (rgelt));
	}
	EIF_OBJECT tmp_pcelt_fetched = NULL;
	if (pcelt_fetched != NULL)
	{
		tmp_pcelt_fetched = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pcelt_fetched, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_next", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_celt, ((tmp_rgelt != NULL) ? eif_access (tmp_rgelt) : NULL), ((tmp_pcelt_fetched != NULL) ? eif_access (tmp_pcelt_fetched) : NULL));
	
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pcelt_fetched != NULL) ? eif_wean (tmp_pcelt_fetched) : NULL), pcelt_fetched);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IEnumSTATDATA_impl_stub::Skip(  /* [in] */ ULONG celt )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_celt = (EIF_INTEGER)celt;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("skip", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_celt);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IEnumSTATDATA_impl_stub::Reset( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("reset", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IEnumSTATDATA_impl_stub::Clone(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum = NULL;
	if (ppenum != NULL)
	{
		tmp_ppenum = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_112 (ppenum, NULL));
		if (*ppenum != NULL)
			(*ppenum)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("clone1", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
	
	if (*ppenum != NULL)
		(*ppenum)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_112 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
	if (*ppenum != NULL)
		(*ppenum)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IEnumSTATDATA_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IEnumSTATDATA_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IEnumSTATDATA_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IEnumSTATDATA*>(this);
	else if (riid == IID_IEnumSTATDATA_)
		*ppv = static_cast<ecom_control_library::IEnumSTATDATA*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif