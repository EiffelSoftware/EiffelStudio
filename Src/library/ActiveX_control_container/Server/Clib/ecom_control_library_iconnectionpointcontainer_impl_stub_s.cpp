/*-----------------------------------------------------------
Implemented `IConnectionPointContainer' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IConnectionPointContainer_impl_stub_s.h"
static int return_hr_value;



#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IConnectionPointContainer_impl_stub::IConnectionPointContainer_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IConnectionPointContainer_impl_stub::~IConnectionPointContainer_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IConnectionPointContainer_impl_stub::EnumConnectionPoints(  /* [out] */ ecom_control_library::IEnumConnectionPoints * * ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum = NULL;
	if (ppenum != NULL)
	{
		tmp_ppenum = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_153 (ppenum, NULL));
		if (*ppenum != NULL)
			(*ppenum)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_connection_points", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
	
	if (*ppenum != NULL)
		(*ppenum)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_153 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
	if (*ppenum != NULL)
		(*ppenum)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IConnectionPointContainer_impl_stub::FindConnectionPoint(  /* [in] */ GUID * riid, /* [out] */ ecom_control_library::IConnectionPoint * * pp_cp )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_riid = NULL;
	if (riid != NULL)
	{
		tmp_riid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid));
	}
	EIF_OBJECT tmp_pp_cp = NULL;
	if (pp_cp != NULL)
	{
		tmp_pp_cp = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_149 (pp_cp, NULL));
		if (*pp_cp != NULL)
			(*pp_cp)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("find_connection_point", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_pp_cp != NULL) ? eif_access (tmp_pp_cp) : NULL));
	
	if (*pp_cp != NULL)
		(*pp_cp)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_149 (((tmp_pp_cp != NULL) ? eif_wean (tmp_pp_cp) : NULL), pp_cp);
	if (*pp_cp != NULL)
		(*pp_cp)->AddRef ();
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IConnectionPointContainer_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IConnectionPointContainer_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IConnectionPointContainer_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IConnectionPointContainer*>(this);
	else if (riid == IID_IConnectionPointContainer)
		*ppv = static_cast<ecom_control_library::IConnectionPointContainer*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif