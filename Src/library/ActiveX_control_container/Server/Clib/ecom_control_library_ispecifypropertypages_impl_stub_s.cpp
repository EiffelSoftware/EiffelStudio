/*-----------------------------------------------------------
Implemented `ISpecifyPropertyPages' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ISpecifyPropertyPages_impl_stub_s.h"
static int return_hr_value;

static const IID IID_ISpecifyPropertyPages_ = {0xb196b28b,0xbab4,0x101a,{0xb6,0x9c,0x00,0xaa,0x00,0x34,0x1d,0x07}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ISpecifyPropertyPages_impl_stub::ISpecifyPropertyPages_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ISpecifyPropertyPages_impl_stub::~ISpecifyPropertyPages_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ISpecifyPropertyPages_impl_stub::GetPages(  /* [out] */ ecom_control_library::tagCAUUID * p_pages )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_pages = NULL;
	if (p_pages != NULL)
	{
		tmp_p_pages = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_379 (p_pages));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_pages", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_pages != NULL) ? eif_access (tmp_p_pages) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::ISpecifyPropertyPages_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::ISpecifyPropertyPages_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ISpecifyPropertyPages_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::ISpecifyPropertyPages*>(this);
	else if (riid == IID_ISpecifyPropertyPages_)
		*ppv = static_cast<ecom_control_library::ISpecifyPropertyPages*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif