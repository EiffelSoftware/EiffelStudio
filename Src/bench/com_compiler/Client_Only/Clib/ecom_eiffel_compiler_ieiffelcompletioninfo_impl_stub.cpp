/*-----------------------------------------------------------
Implemented `IEiffelCompletionInfo' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelCompletionInfo_impl_stub.h"
static int return_hr_value;

static const IID IID_IEiffelCompletionInfo_ = {0x06b9f5aa,0x0e7d,0x4d84,{0x80,0x0a,0x38,0x66,0xac,0x70,0x95,0x03}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::IEiffelCompletionInfo_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::~IEiffelCompletionInfo_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::add_local(  /* [in] */ BSTR name, /* [in] */ BSTR type )

/*-----------------------------------------------------------
	Add a local variable used for solving member completion list
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_name = NULL;
	if (name != NULL)
	{
		tmp_name = eif_protect (rt_ce.ccom_ce_bstr (name));
	}
	EIF_OBJECT tmp_type = NULL;
	if (type != NULL)
	{
		tmp_type = eif_protect (rt_ce.ccom_ce_bstr (type));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_local", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_name != NULL) ? eif_access (tmp_name) : NULL), ((tmp_type != NULL) ? eif_access (tmp_type) : NULL));
	if (tmp_name != NULL)
		eif_wean (tmp_name);
	if (tmp_type != NULL)
		eif_wean (tmp_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::add_argument(  /* [in] */ BSTR name, /* [in] */ BSTR type )

/*-----------------------------------------------------------
	Add an argument used for solving member completion list
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_name = NULL;
	if (name != NULL)
	{
		tmp_name = eif_protect (rt_ce.ccom_ce_bstr (name));
	}
	EIF_OBJECT tmp_type = NULL;
	if (type != NULL)
	{
		tmp_type = eif_protect (rt_ce.ccom_ce_bstr (type));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_argument", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_name != NULL) ? eif_access (tmp_name) : NULL), ((tmp_type != NULL) ? eif_access (tmp_type) : NULL));
	if (tmp_name != NULL)
		eif_wean (tmp_name);
	if (tmp_type != NULL)
		eif_wean (tmp_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::target_features(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out] */ VARIANT * return_names, /* [out] */ VARIANT * return_signatures, /* [out] */ VARIANT * return_image_indexes )

/*-----------------------------------------------------------
	Features accessible from target.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_target = NULL;
	if (target != NULL)
	{
		tmp_target = eif_protect (rt_ce.ccom_ce_bstr (target));
	}
	EIF_OBJECT tmp_feature_name = NULL;
	if (feature_name != NULL)
	{
		tmp_feature_name = eif_protect (rt_ce.ccom_ce_bstr (feature_name));
	}
	EIF_OBJECT tmp_file_name = NULL;
	if (file_name != NULL)
	{
		tmp_file_name = eif_protect (rt_ce.ccom_ce_bstr (file_name));
	}
	EIF_OBJECT tmp_return_names = NULL;
	if (return_names != NULL)
	{
		tmp_return_names = eif_protect (grt_ce_ISE_c.ccom_ce_pointed_record_234 (return_names));
	}
	EIF_OBJECT tmp_return_signatures = NULL;
	if (return_signatures != NULL)
	{
		tmp_return_signatures = eif_protect (grt_ce_ISE_c.ccom_ce_pointed_record_235 (return_signatures));
	}
	EIF_OBJECT tmp_return_image_indexes = NULL;
	if (return_image_indexes != NULL)
	{
		tmp_return_image_indexes = eif_protect (grt_ce_ISE_c.ccom_ce_pointed_record_236 (return_image_indexes));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("target_features", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_target != NULL) ? eif_access (tmp_target) : NULL), ((tmp_feature_name != NULL) ? eif_access (tmp_feature_name) : NULL), ((tmp_file_name != NULL) ? eif_access (tmp_file_name) : NULL), ((tmp_return_names != NULL) ? eif_access (tmp_return_names) : NULL), ((tmp_return_signatures != NULL) ? eif_access (tmp_return_signatures) : NULL), ((tmp_return_image_indexes != NULL) ? eif_access (tmp_return_image_indexes) : NULL));
	
	
	
	if (tmp_target != NULL)
		eif_wean (tmp_target);
	if (tmp_feature_name != NULL)
		eif_wean (tmp_feature_name);
	if (tmp_file_name != NULL)
		eif_wean (tmp_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::target_feature(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelFeatureDescriptor * * return_value )

/*-----------------------------------------------------------
	Feature information
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_target = NULL;
	if (target != NULL)
	{
		tmp_target = eif_protect (rt_ce.ccom_ce_bstr (target));
	}
	EIF_OBJECT tmp_feature_name = NULL;
	if (feature_name != NULL)
	{
		tmp_feature_name = eif_protect (rt_ce.ccom_ce_bstr (feature_name));
	}
	EIF_OBJECT tmp_file_name = NULL;
	if (file_name != NULL)
	{
		tmp_file_name = eif_protect (rt_ce.ccom_ce_bstr (file_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("target_feature", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_target != NULL) ? eif_access (tmp_target) : NULL), ((tmp_feature_name != NULL) ? eif_access (tmp_feature_name) : NULL), ((tmp_file_name != NULL) ? eif_access (tmp_file_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "target_feature", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE_c.ccom_ec_pointed_interface_51 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_target != NULL)
		eif_wean (tmp_target);
	if (tmp_feature_name != NULL)
		eif_wean (tmp_feature_name);
	if (tmp_file_name != NULL)
		eif_wean (tmp_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::flush_completion_features(  /* [in] */ BSTR a_file_name )

/*-----------------------------------------------------------
	Flush temporary completion features for a specifi file
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_file_name = NULL;
	if (a_file_name != NULL)
	{
		tmp_a_file_name = eif_protect (rt_ce.ccom_ce_bstr (a_file_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("flush_completion_features", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_a_file_name != NULL) ? eif_access (tmp_a_file_name) : NULL));
	if (tmp_a_file_name != NULL)
		eif_wean (tmp_a_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::initialize_feature(  /* [in] */ BSTR a_name, /* [in] */ VARIANT a_arguments, /* [in] */ VARIANT a_argument_types, /* [in] */ BSTR a_return_type, /* [in] */ ULONG a_feature_type, /* [in] */ BSTR a_file_name )

/*-----------------------------------------------------------
	Initialize a feature for completion without compiltation
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_name = NULL;
	if (a_name != NULL)
	{
		tmp_a_name = eif_protect (rt_ce.ccom_ce_bstr (a_name));
	}
	EIF_OBJECT tmp_a_arguments = NULL;
	tmp_a_arguments = eif_protect (rt_ce.ccom_ce_variant (a_arguments));
	EIF_OBJECT tmp_a_argument_types = NULL;
	tmp_a_argument_types = eif_protect (rt_ce.ccom_ce_variant (a_argument_types));
	EIF_OBJECT tmp_a_return_type = NULL;
	if (a_return_type != NULL)
	{
		tmp_a_return_type = eif_protect (rt_ce.ccom_ce_bstr (a_return_type));
	}
	EIF_INTEGER tmp_a_feature_type = (EIF_INTEGER)a_feature_type;
	EIF_OBJECT tmp_a_file_name = NULL;
	if (a_file_name != NULL)
	{
		tmp_a_file_name = eif_protect (rt_ce.ccom_ce_bstr (a_file_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("initialize_feature", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_a_name != NULL) ? eif_access (tmp_a_name) : NULL), ((tmp_a_arguments != NULL) ? eif_access (tmp_a_arguments) : NULL), ((tmp_a_argument_types != NULL) ? eif_access (tmp_a_argument_types) : NULL), ((tmp_a_return_type != NULL) ? eif_access (tmp_a_return_type) : NULL), (EIF_INTEGER)tmp_a_feature_type, ((tmp_a_file_name != NULL) ? eif_access (tmp_a_file_name) : NULL));
	if (tmp_a_name != NULL)
		eif_wean (tmp_a_name);
	if (tmp_a_arguments != NULL)
		eif_wean (tmp_a_arguments);
	if (tmp_a_argument_types != NULL)
		eif_wean (tmp_a_argument_types);
	if (tmp_a_return_type != NULL)
		eif_wean (tmp_a_return_type);
	if (tmp_a_file_name != NULL)
		eif_wean (tmp_a_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompletionInfo_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelCompletionInfo*>(this);
	else if (riid == IID_IEiffelCompletionInfo_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelCompletionInfo*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif