/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocGenerator' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelHTMLDocGenerator_ = {0xaf48d380,0x8f9a,0x436c,{0x97,0x63,0xae,0x1c,0x73,0x2a,0xb3,0xf1}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::IEiffelHTMLDocGenerator_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::~IEiffelHTMLDocGenerator_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::add_excluded_cluster(  /* [in] */ BSTR cluster_full_name )

/*-----------------------------------------------------------
	Exclude a cluster from being generated.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_full_name = NULL;
	if (cluster_full_name != NULL)
	{
		tmp_cluster_full_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_full_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_excluded_cluster", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_cluster_full_name != NULL) ? eif_access (tmp_cluster_full_name) : NULL));
	if (tmp_cluster_full_name != NULL)
		eif_wean (tmp_cluster_full_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::remove_excluded_cluster(  /* [in] */ BSTR cluster_full_name )

/*-----------------------------------------------------------
	Exclude a cluster from being generated.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_full_name = NULL;
	if (cluster_full_name != NULL)
	{
		tmp_cluster_full_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_full_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_excluded_cluster", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_cluster_full_name != NULL) ? eif_access (tmp_cluster_full_name) : NULL));
	if (tmp_cluster_full_name != NULL)
		eif_wean (tmp_cluster_full_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::generate(  /* [in] */ BSTR path )

/*-----------------------------------------------------------
	Exclude a cluster from being generated.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_path = NULL;
	if (path != NULL)
	{
		tmp_path = eif_protect (rt_ce.ccom_ce_bstr (path));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("generate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_path != NULL) ? eif_access (tmp_path) : NULL));
	if (tmp_path != NULL)
		eif_wean (tmp_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	UnlockModule ();
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelHTMLDocGenerator*>(this);
	else if (riid == IID_IEiffelHTMLDocGenerator_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelHTMLDocGenerator*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif