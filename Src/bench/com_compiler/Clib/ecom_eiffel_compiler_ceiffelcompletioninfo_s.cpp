/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_CEiffelCompletionInfo_s.h"
static int return_hr_value;

static const CLSID CLSID_CEiffelCompletionInfo_ = {0xaabb3c81,0x5b4c,0x47df,{0xa6,0x83,0x1f,0xd7,0x16,0xe9,0x75,0xc6}};

static const IID IID_IEiffelCompletionInfo_ = {0x06b9f5aa,0x0e7d,0x4d84,{0x80,0x0a,0x38,0x66,0xac,0x70,0x95,0x03}};

static const IID LIBID_eiffel_compiler_ = {0xa81ca1a9,0x3eef,0x4e47,{0xbe,0xae,0xc1,0x63,0x25,0xee,0xfa,0x3f}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::CEiffelCompletionInfo::CEiffelCompletionInfo( EIF_TYPE_ID tid )
{
	type_id = tid;
	ref_count = 0;
	eiffel_object = eif_create (type_id);
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("make_from_pointer", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::CEiffelCompletionInfo::CEiffelCompletionInfo( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::CEiffelCompletionInfo::~CEiffelCompletionInfo()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompletionInfo::add_local(  /* [in] */ BSTR name, /* [in] */ BSTR type )

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

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompletionInfo::add_argument(  /* [in] */ BSTR name, /* [in] */ BSTR type )

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

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompletionInfo::target_features(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out] */ VARIANT * return_names, /* [out] */ VARIANT * return_signatures, /* [out] */ VARIANT * return_image_indexes )

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
		tmp_return_names = eif_protect (grt_ce_ISE.ccom_ce_pointed_record_234 (return_names));
	}
	EIF_OBJECT tmp_return_signatures = NULL;
	if (return_signatures != NULL)
	{
		tmp_return_signatures = eif_protect (grt_ce_ISE.ccom_ce_pointed_record_235 (return_signatures));
	}
	EIF_OBJECT tmp_return_image_indexes = NULL;
	if (return_image_indexes != NULL)
	{
		tmp_return_image_indexes = eif_protect (grt_ce_ISE.ccom_ce_pointed_record_236 (return_image_indexes));
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

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompletionInfo::target_feature(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelFeatureDescriptor * * return_value )

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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_51 (eif_access (tmp_object));
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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::CEiffelCompletionInfo::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::CEiffelCompletionInfo::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompletionInfo::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface.
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelCompletionInfo*>(this);
	else if (riid == IID_IProvideClassInfo)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IProvideClassInfo2)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IEiffelCompletionInfo_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelCompletionInfo*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompletionInfo::GetClassInfo( ITypeInfo ** ppti )

/*-----------------------------------------------------------
	GetClassInfo
-----------------------------------------------------------*/
{
	if (ppti == NULL)
		return E_POINTER;
	ITypeLib * ptl = NULL;
	HRESULT hr = LoadRegTypeLib (LIBID_eiffel_compiler_, 1, 0, 0, &ptl);
	if (SUCCEEDED (hr))
	{
		hr = ptl->GetTypeInfoOfGuid (CLSID_CEiffelCompletionInfo_, ppti);
		ptl->Release ();
	}
	return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompletionInfo::GetGUID( DWORD dwKind, GUID * pguid )

/*-----------------------------------------------------------
	GetGUID
-----------------------------------------------------------*/
{
	if ((dwKind != GUIDKIND_DEFAULT_SOURCE_DISP_IID) ||(!pguid))
		return E_INVALIDARG;
	*pguid = IID_NULL;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif