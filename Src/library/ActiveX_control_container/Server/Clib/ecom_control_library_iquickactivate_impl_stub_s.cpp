/*-----------------------------------------------------------
Implemented `IQuickActivate' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IQuickActivate_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IQuickActivate_ = {0xcf51ed10,0x62fe,0x11cf,{0xbf,0x86,0x00,0xa0,0xc9,0x03,0x48,0x36}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IQuickActivate_impl_stub::IQuickActivate_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IQuickActivate_impl_stub::~IQuickActivate_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IQuickActivate_impl_stub::RemoteQuickActivate(  /* [in] */ ecom_control_library::tagQACONTAINER * p_qa_container, /* [out] */ ecom_control_library::tagQACONTROL * p_qa_control )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_qa_container = NULL;
	if (p_qa_container != NULL)
	{
		tmp_p_qa_container = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_395 (p_qa_container));
	}
	EIF_OBJECT tmp_p_qa_control = NULL;
	if (p_qa_control != NULL)
	{
		tmp_p_qa_control = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_397 (p_qa_control));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_quick_activate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_qa_container != NULL) ? eif_access (tmp_p_qa_container) : NULL), ((tmp_p_qa_control != NULL) ? eif_access (tmp_p_qa_control) : NULL));
	
	if (tmp_p_qa_container != NULL)
		eif_wean (tmp_p_qa_container);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IQuickActivate_impl_stub::SetContentExtent(  /* [in] */ ecom_control_library::tagSIZEL * psizel )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psizel = NULL;
	if (psizel != NULL)
	{
		tmp_psizel = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_249 (psizel));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_content_extent", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psizel != NULL) ? eif_access (tmp_psizel) : NULL));
	if (tmp_psizel != NULL)
		eif_wean (tmp_psizel);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IQuickActivate_impl_stub::GetContentExtent(  /* [out] */ ecom_control_library::tagSIZEL * psizel )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psizel = NULL;
	if (psizel != NULL)
	{
		tmp_psizel = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_249 (psizel));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_content_extent", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psizel != NULL) ? eif_access (tmp_psizel) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IQuickActivate_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IQuickActivate_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IQuickActivate_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IQuickActivate*>(this);
	else if (riid == IID_IQuickActivate_)
		*ppv = static_cast<ecom_control_library::IQuickActivate*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif