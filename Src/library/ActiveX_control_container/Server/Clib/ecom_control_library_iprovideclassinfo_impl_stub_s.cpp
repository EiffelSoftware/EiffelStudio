/*-----------------------------------------------------------
Implemented `IProvideClassInfo' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IProvideClassInfo_impl_stub_s.h"
static int return_hr_value;



#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IProvideClassInfo_impl_stub::IProvideClassInfo_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IProvideClassInfo_impl_stub::~IProvideClassInfo_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IProvideClassInfo_impl_stub::GetClassInfo(  /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_ti )

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

STDMETHODIMP_(ULONG) ecom_control_library::IProvideClassInfo_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IProvideClassInfo_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IProvideClassInfo_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IProvideClassInfo*>(this);
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