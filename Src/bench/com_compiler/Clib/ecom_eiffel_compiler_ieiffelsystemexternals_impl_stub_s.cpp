/*-----------------------------------------------------------
Implemented `IEiffelSystemExternals' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelSystemExternals_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelSystemExternals_ = {0xea511e88,0x0ff6,0x407b,{0x89,0x56,0xfb,0x41,0x66,0x26,0xb6,0x2a}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::IEiffelSystemExternals_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::~IEiffelSystemExternals_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::store( void )

/*-----------------------------------------------------------
	Save changes.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("store", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::add_include_path(  /* [in] */ BSTR include_path )

/*-----------------------------------------------------------
	Add a include path to the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_include_path = NULL;
	if (include_path != NULL)
	{
		tmp_include_path = eif_protect (rt_ce.ccom_ce_bstr (include_path));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_include_path", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_include_path != NULL) ? eif_access (tmp_include_path) : NULL));
	if (tmp_include_path != NULL)
		eif_wean (tmp_include_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::remove_include_path(  /* [in] */ BSTR include_path )

/*-----------------------------------------------------------
	Remove a include path from the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_include_path = NULL;
	if (include_path != NULL)
	{
		tmp_include_path = eif_protect (rt_ce.ccom_ce_bstr (include_path));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_include_path", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_include_path != NULL) ? eif_access (tmp_include_path) : NULL));
	if (tmp_include_path != NULL)
		eif_wean (tmp_include_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::replace_include_path(  /* [in] */ BSTR new_include_path, /* [in] */ BSTR old_include_path )

/*-----------------------------------------------------------
	Replace an include path in the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_new_include_path = NULL;
	if (new_include_path != NULL)
	{
		tmp_new_include_path = eif_protect (rt_ce.ccom_ce_bstr (new_include_path));
	}
	EIF_OBJECT tmp_old_include_path = NULL;
	if (old_include_path != NULL)
	{
		tmp_old_include_path = eif_protect (rt_ce.ccom_ce_bstr (old_include_path));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("replace_include_path", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_new_include_path != NULL) ? eif_access (tmp_new_include_path) : NULL), ((tmp_old_include_path != NULL) ? eif_access (tmp_old_include_path) : NULL));
	if (tmp_new_include_path != NULL)
		eif_wean (tmp_new_include_path);
	if (tmp_old_include_path != NULL)
		eif_wean (tmp_old_include_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::include_paths(  /* [out, retval] */ ecom_eiffel_compiler::IEnumIncludePaths * * return_value )

/*-----------------------------------------------------------
	Include paths.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("include_paths", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "include_paths", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_218 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::add_object_file(  /* [in] */ BSTR object_file )

/*-----------------------------------------------------------
	Add a object file to the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_object_file = NULL;
	if (object_file != NULL)
	{
		tmp_object_file = eif_protect (rt_ce.ccom_ce_bstr (object_file));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_object_file", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_object_file != NULL) ? eif_access (tmp_object_file) : NULL));
	if (tmp_object_file != NULL)
		eif_wean (tmp_object_file);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::remove_object_file(  /* [in] */ BSTR object_file )

/*-----------------------------------------------------------
	Remove a object file from the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_object_file = NULL;
	if (object_file != NULL)
	{
		tmp_object_file = eif_protect (rt_ce.ccom_ce_bstr (object_file));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_object_file", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_object_file != NULL) ? eif_access (tmp_object_file) : NULL));
	if (tmp_object_file != NULL)
		eif_wean (tmp_object_file);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::replace_object_file(  /* [in] */ BSTR new_include_path, /* [in] */ BSTR old_object_file )

/*-----------------------------------------------------------
	Replace an object file in the project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_new_include_path = NULL;
	if (new_include_path != NULL)
	{
		tmp_new_include_path = eif_protect (rt_ce.ccom_ce_bstr (new_include_path));
	}
	EIF_OBJECT tmp_old_object_file = NULL;
	if (old_object_file != NULL)
	{
		tmp_old_object_file = eif_protect (rt_ce.ccom_ce_bstr (old_object_file));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("replace_object_file", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_new_include_path != NULL) ? eif_access (tmp_new_include_path) : NULL), ((tmp_old_object_file != NULL) ? eif_access (tmp_old_object_file) : NULL));
	if (tmp_new_include_path != NULL)
		eif_wean (tmp_new_include_path);
	if (tmp_old_object_file != NULL)
		eif_wean (tmp_old_object_file);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::object_files(  /* [out, retval] */ ecom_eiffel_compiler::IEnumObjectFiles * * return_value )

/*-----------------------------------------------------------
	Object files.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("object_files", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "object_files", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_221 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelSystemExternals_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelSystemExternals*>(this);
	else if (riid == IID_IEiffelSystemExternals_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelSystemExternals*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif