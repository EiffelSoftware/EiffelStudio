/*-----------------------------------------------------------
Implemented `IProvideMultipleClassInfo' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IProvideMultipleClassInfo_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IProvideMultipleClassInfo_ = {0xa7aba9c1,0x8983,0x11cf,{0x8f,0x20,0x00,0x80,0x5f,0x2c,0xd0,0x64}};





#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IProvideMultipleClassInfo_impl_stub::IProvideMultipleClassInfo_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IProvideMultipleClassInfo_impl_stub::~IProvideMultipleClassInfo_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IProvideMultipleClassInfo_impl_stub::GetClassInfo(  /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_ti )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_ti = NULL;
	if (pp_ti != NULL)
	{
		tmp_pp_ti = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 (pp_ti, NULL));
		if (*pp_ti != NULL)
			(*pp_ti)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_class_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_ti != NULL) ? eif_access (tmp_pp_ti) : NULL));
	
	if (*pp_ti != NULL)
		(*pp_ti)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (((tmp_pp_ti != NULL) ? eif_wean (tmp_pp_ti) : NULL), pp_ti);
	if (*pp_ti != NULL)
		(*pp_ti)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IProvideMultipleClassInfo_impl_stub::GetGUID(  /* [in] */ ULONG dw_guid_kind, /* [out] */ GUID * p_guid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_guid_kind = (EIF_INTEGER)dw_guid_kind;
	EIF_OBJECT tmp_p_guid = NULL;
	if (p_guid != NULL)
	{
		tmp_p_guid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (p_guid));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_guid", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_guid_kind, ((tmp_p_guid != NULL) ? eif_access (tmp_p_guid) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IProvideMultipleClassInfo_impl_stub::GetMultiTypeInfoCount(  /* [out] */ ULONG * pcti )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pcti = NULL;
	if (pcti != NULL)
	{
		tmp_pcti = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pcti, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_multi_type_info_count", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pcti != NULL) ? eif_access (tmp_pcti) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pcti != NULL) ? eif_wean (tmp_pcti) : NULL), pcti);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IProvideMultipleClassInfo_impl_stub::GetInfoOfIndex(  /* [in] */ ULONG iti, /* [in] */ ULONG dw_flags, /* [out] */ ecom_control_library::ITypeInfo_2 * * ppti_co_class, /* [out] */ ULONG * pdw_tiflags, /* [out] */ ULONG * pcdispid_reserved, /* [out] */ GUID * piid_primary, /* [out] */ GUID * piid_source )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_iti = (EIF_INTEGER)iti;
	EIF_INTEGER tmp_dw_flags = (EIF_INTEGER)dw_flags;
	EIF_OBJECT tmp_ppti_co_class = NULL;
	if (ppti_co_class != NULL)
	{
		tmp_ppti_co_class = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 (ppti_co_class, NULL));
		if (*ppti_co_class != NULL)
			(*ppti_co_class)->AddRef ();
	}
	EIF_OBJECT tmp_pdw_tiflags = NULL;
	if (pdw_tiflags != NULL)
	{
		tmp_pdw_tiflags = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_tiflags, NULL));
	}
	EIF_OBJECT tmp_pcdispid_reserved = NULL;
	if (pcdispid_reserved != NULL)
	{
		tmp_pcdispid_reserved = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pcdispid_reserved, NULL));
	}
	EIF_OBJECT tmp_piid_primary = NULL;
	if (piid_primary != NULL)
	{
		tmp_piid_primary = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (piid_primary));
	}
	EIF_OBJECT tmp_piid_source = NULL;
	if (piid_source != NULL)
	{
		tmp_piid_source = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (piid_source));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_info_of_index", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_iti, (EIF_INTEGER)tmp_dw_flags, ((tmp_ppti_co_class != NULL) ? eif_access (tmp_ppti_co_class) : NULL), ((tmp_pdw_tiflags != NULL) ? eif_access (tmp_pdw_tiflags) : NULL), ((tmp_pcdispid_reserved != NULL) ? eif_access (tmp_pcdispid_reserved) : NULL), ((tmp_piid_primary != NULL) ? eif_access (tmp_piid_primary) : NULL), ((tmp_piid_source != NULL) ? eif_access (tmp_piid_source) : NULL));
	
	if (*ppti_co_class != NULL)
		(*ppti_co_class)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (((tmp_ppti_co_class != NULL) ? eif_wean (tmp_ppti_co_class) : NULL), ppti_co_class);
	if (*ppti_co_class != NULL)
		(*ppti_co_class)->AddRef ();
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_tiflags != NULL) ? eif_wean (tmp_pdw_tiflags) : NULL), pdw_tiflags);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pcdispid_reserved != NULL) ? eif_wean (tmp_pcdispid_reserved) : NULL), pcdispid_reserved);
	
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IProvideMultipleClassInfo_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IProvideMultipleClassInfo_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IProvideMultipleClassInfo_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IProvideMultipleClassInfo*>(this);
	else if (riid == IID_IProvideMultipleClassInfo_)
		*ppv = static_cast<ecom_control_library::IProvideMultipleClassInfo*>(this);
	else if (riid == IID_IProvideClassInfo2)
		*ppv = static_cast<ecom_control_library::IProvideClassInfo2*>(this);
	else if (riid == IID_IProvideClassInfo)
		*ppv = static_cast<ecom_control_library::IProvideClassInfo*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif