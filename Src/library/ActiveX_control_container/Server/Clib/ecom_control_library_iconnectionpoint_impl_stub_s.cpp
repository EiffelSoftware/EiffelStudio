/*-----------------------------------------------------------
Implemented `IConnectionPoint' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IConnectionPoint_impl_stub_s.h"
static int return_hr_value;



#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IConnectionPoint_impl_stub::IConnectionPoint_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IConnectionPoint_impl_stub::~IConnectionPoint_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IConnectionPoint_impl_stub::GetConnectionInterface(  /* [out] */ GUID * p_iid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_iid = NULL;
	if (p_iid != NULL)
	{
		tmp_p_iid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (p_iid));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_connection_interface", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_iid != NULL) ? eif_access (tmp_p_iid) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IConnectionPoint_impl_stub::GetConnectionPointContainer(  /* [out] */ ecom_control_library::IConnectionPointContainer * * pp_cpc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_cpc = NULL;
	if (pp_cpc != NULL)
	{
		tmp_pp_cpc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_156 (pp_cpc, NULL));
		if (*pp_cpc != NULL)
			(*pp_cpc)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_connection_point_container", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_cpc != NULL) ? eif_access (tmp_pp_cpc) : NULL));
	
	if (*pp_cpc != NULL)
		(*pp_cpc)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_156 (((tmp_pp_cpc != NULL) ? eif_wean (tmp_pp_cpc) : NULL), pp_cpc);
	if (*pp_cpc != NULL)
		(*pp_cpc)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IConnectionPoint_impl_stub::Advise(  /* [in] */ IUnknown * p_unk_sink, /* [out] */ ULONG * pdw_cookie )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_unk_sink = NULL;
	if (p_unk_sink != NULL)
	{
		tmp_p_unk_sink = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_unk_sink));
		p_unk_sink->AddRef ();
	}
	EIF_OBJECT tmp_pdw_cookie = NULL;
	if (pdw_cookie != NULL)
	{
		tmp_pdw_cookie = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_cookie, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("advise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_unk_sink != NULL) ? eif_access (tmp_p_unk_sink) : NULL), ((tmp_pdw_cookie != NULL) ? eif_access (tmp_pdw_cookie) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_cookie != NULL) ? eif_wean (tmp_pdw_cookie) : NULL), pdw_cookie);
	if (tmp_p_unk_sink != NULL)
		eif_wean (tmp_p_unk_sink);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IConnectionPoint_impl_stub::Unadvise(  /* [in] */ ULONG dw_cookie )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_cookie = (EIF_INTEGER)dw_cookie;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("unadvise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_cookie);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IConnectionPoint_impl_stub::EnumConnections(  /* [out] */ ecom_control_library::IEnumConnections * * ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum = NULL;
	if (ppenum != NULL)
	{
		tmp_ppenum = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_146 (ppenum, NULL));
		if (*ppenum != NULL)
			(*ppenum)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_connections", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
	
	if (*ppenum != NULL)
		(*ppenum)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_146 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
	if (*ppenum != NULL)
		(*ppenum)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IConnectionPoint_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IConnectionPoint_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IConnectionPoint_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IConnectionPoint*>(this);
	else if (riid == IID_IConnectionPoint)
		*ppv = static_cast<ecom_control_library::IConnectionPoint*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif