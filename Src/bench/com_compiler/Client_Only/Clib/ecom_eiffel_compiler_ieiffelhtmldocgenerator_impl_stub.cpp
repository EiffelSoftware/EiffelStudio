/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocGenerator' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator_impl_stub.h"
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

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::is_loaded(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Is the project loaded?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_loaded", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_loaded", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::is_corrupted(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Is the project oorrupted?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_corrupted", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_corrupted", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::is_incompatible(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Is the project incompatible with the current version of the compiled?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_incompatible", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_incompatible", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::add_status_callback(  /* [in] */ ecom_eiffel_compiler::IEiffelHTMLDocEvents * new_callback )

/*-----------------------------------------------------------
	Add a callback interface.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_new_callback = NULL;
	if (new_callback != NULL)
	{
		tmp_new_callback = eif_protect (grt_ce_ISE_c.ccom_ce_pointed_interface_242 (new_callback));
		new_callback->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_status_callback", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_new_callback != NULL) ? eif_access (tmp_new_callback) : NULL));
	if (tmp_new_callback != NULL)
		eif_wean (tmp_new_callback);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_stub::remove_status_callback(  /* [in] */ ecom_eiffel_compiler::IEiffelHTMLDocEvents * old_callback )

/*-----------------------------------------------------------
	Remove a callback interface.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_old_callback = NULL;
	if (old_callback != NULL)
	{
		tmp_old_callback = eif_protect (grt_ce_ISE_c.ccom_ce_pointed_interface_242 (old_callback));
		old_callback->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_status_callback", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_old_callback != NULL) ? eif_access (tmp_old_callback) : NULL));
	if (tmp_old_callback != NULL)
		eif_wean (tmp_old_callback);
	
	END_ECATCH;
	return S_OK;
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
	Include a cluster to be generated.
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
	Generate the HTML documents into path.
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