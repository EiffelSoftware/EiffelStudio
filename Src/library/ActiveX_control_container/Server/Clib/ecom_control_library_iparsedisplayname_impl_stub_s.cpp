/*-----------------------------------------------------------
Implemented `IParseDisplayName' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IParseDisplayName_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IParseDisplayName_ = {0x0000011a,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IParseDisplayName_impl_stub::IParseDisplayName_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IParseDisplayName_impl_stub::~IParseDisplayName_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IParseDisplayName_impl_stub::ParseDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ LPWSTR psz_display_name, /* [out] */ ULONG * pch_eaten, /* [out] */ ecom_control_library::IMoniker * * ppmk_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_psz_display_name = NULL;
	if (psz_display_name != NULL)
	{
		tmp_psz_display_name = eif_protect (rt_ce.ccom_ce_lpwstr (psz_display_name, NULL));
	}
	EIF_OBJECT tmp_pch_eaten = NULL;
	if (pch_eaten != NULL)
	{
		tmp_pch_eaten = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pch_eaten, NULL));
	}
	EIF_OBJECT tmp_ppmk_out = NULL;
	if (ppmk_out != NULL)
	{
		tmp_ppmk_out = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk_out, NULL));
		if (*ppmk_out != NULL)
			(*ppmk_out)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("parse_display_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_psz_display_name != NULL) ? eif_access (tmp_psz_display_name) : NULL), ((tmp_pch_eaten != NULL) ? eif_access (tmp_pch_eaten) : NULL), ((tmp_ppmk_out != NULL) ? eif_access (tmp_ppmk_out) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pch_eaten != NULL) ? eif_wean (tmp_pch_eaten) : NULL), pch_eaten);
	
	if (*ppmk_out != NULL)
		(*ppmk_out)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk_out != NULL) ? eif_wean (tmp_ppmk_out) : NULL), ppmk_out);
	if (*ppmk_out != NULL)
		(*ppmk_out)->AddRef ();
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_psz_display_name != NULL)
		eif_wean (tmp_psz_display_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IParseDisplayName_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IParseDisplayName_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IParseDisplayName_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IParseDisplayName*>(this);
	else if (riid == IID_IParseDisplayName_)
		*ppv = static_cast<ecom_control_library::IParseDisplayName*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif