/*-----------------------------------------------------------
Implemented `IEiffelProjectProperties' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelProjectProperties_impl_stub.h"
static int return_hr_value;

static const IID IID_IEiffelProjectProperties_ = {0xc212faab,0xfaa8,0x48b9,{0x9d,0x4e,0x2d,0x0c,0xa4,0xeb,0x33,0x54}};

static const IID LIBID_eiffel_compiler_ = {0xa81ca1a9,0x3eef,0x4e47,{0xbe,0xae,0xc1,0x63,0x25,0xee,0xfa,0x3f}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::IEiffelProjectProperties_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::~IEiffelProjectProperties_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::system_name(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	System name.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("system_name", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "system_name", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_system_name(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	System name.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_system_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::root_class_name(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Root class name.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("root_class_name", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "root_class_name", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_root_class_name(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Root class name.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_root_class_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::creation_routine(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Creation routine name.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("creation_routine", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "creation_routine", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_creation_routine(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Creation routine name.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_creation_routine", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::compilation_type(  /* [out, retval] */ long * return_value )

/*-----------------------------------------------------------
	Compilation type.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("compilation_type", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "compilation_type", EIF_INTEGER);
	*return_value = (long)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_compilation_type(  /* [in] */ long return_value )

/*-----------------------------------------------------------
	Compilation type.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_return_value = (EIF_INTEGER)return_value;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_compilation_type", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::console_application(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Is console application?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("console_application", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "console_application", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_console_application(  /* [in] */ VARIANT_BOOL return_value )

/*-----------------------------------------------------------
	Is console application?
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_return_value = rt_ce.ccom_ce_boolean (return_value);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_console_application", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::evaluate_require(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Should preconditions be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("evaluate_require", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "evaluate_require", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_evaluate_require(  /* [in] */ VARIANT_BOOL return_value )

/*-----------------------------------------------------------
	Should preconditions be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_return_value = rt_ce.ccom_ce_boolean (return_value);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_evaluate_require", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::evaluate_ensure(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Should postconditions be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("evaluate_ensure", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "evaluate_ensure", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_evaluate_ensure(  /* [in] */ VARIANT_BOOL return_value )

/*-----------------------------------------------------------
	Should postconditions be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_return_value = rt_ce.ccom_ce_boolean (return_value);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_evaluate_ensure", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::evaluate_check(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Should check assertions be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("evaluate_check", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "evaluate_check", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_evaluate_check(  /* [in] */ VARIANT_BOOL return_value )

/*-----------------------------------------------------------
	Should check assertions be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_return_value = rt_ce.ccom_ce_boolean (return_value);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_evaluate_check", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::evaluate_loop(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Should loop assertions be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("evaluate_loop", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "evaluate_loop", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_evaluate_loop(  /* [in] */ VARIANT_BOOL return_value )

/*-----------------------------------------------------------
	Should loop assertions be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_return_value = rt_ce.ccom_ce_boolean (return_value);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_evaluate_loop", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::evaluate_invariant(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Should class invariants be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("evaluate_invariant", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "evaluate_invariant", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_evaluate_invariant(  /* [in] */ VARIANT_BOOL return_value )

/*-----------------------------------------------------------
	Should class invariants be evaluated?
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_return_value = rt_ce.ccom_ce_boolean (return_value);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_evaluate_invariant", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::debug_info(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Generate debug info?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("debug_info", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "debug_info", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_debug_info(  /* [in] */ VARIANT_BOOL return_value )

/*-----------------------------------------------------------
	Generate debug info?
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_return_value = rt_ce.ccom_ce_boolean (return_value);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_debug_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemClusters * * return_value )

/*-----------------------------------------------------------
	Project Clusters.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("clusters", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "clusters", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE_c.ccom_ec_pointed_interface_126 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::externals(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemExternals * * return_value )

/*-----------------------------------------------------------
	Externals.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("externals", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "externals", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE_c.ccom_ec_pointed_interface_129 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::default_namespace(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Default namespace.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("default_namespace", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "default_namespace", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_default_namespace(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Default namespace.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_default_namespace", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::assemblies(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemAssemblies * * return_value )

/*-----------------------------------------------------------
	Assemblies.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("assemblies", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "assemblies", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE_c.ccom_ec_pointed_interface_133 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::precompiled(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Precompiled file.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("precompiled", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "precompiled", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_precompiled(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Precompiled file.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_precompiled", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::title(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Project title.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("title", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "title", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_title(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Project title.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_title", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::description(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Project description.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("description", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "description", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_description(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Project description.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_description", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::company(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Project company.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("company", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "company", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_company(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Project company.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_company", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::product(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Product.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("product", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "product", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_product(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Product.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_product", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::version(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Project version.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("version", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "version", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_version(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Project version.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_version", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::trademark(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Project trademark.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("trademark", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "trademark", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_trademark(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Project trademark.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_trademark", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::copyright(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Project copyright.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("copyright", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "copyright", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_copyright(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Project copyright.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_copyright", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::key_file_name(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Asembly signing key file name.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("key_file_name", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "key_file_name", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_key_file_name(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Asembly signing key file name.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_key_file_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::culture(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Asembly culture.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("culture", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "culture", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_culture(  /* [in] */ BSTR return_value )

/*-----------------------------------------------------------
	Asembly culture.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_return_value = NULL;
	if (return_value != NULL)
	{
		tmp_return_value = eif_protect (rt_ce.ccom_ce_bstr (return_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_culture", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::Apply( void )

/*-----------------------------------------------------------
	Apply changes
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("apply", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

/*-----------------------------------------------------------
	Get type info
-----------------------------------------------------------*/
{
	if ((itinfo != 0) || (pptinfo == NULL))
		return E_INVALIDARG;
	*pptinfo = NULL;
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_eiffel_compiler_, 0, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelProjectProperties_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::GetTypeInfoCount( unsigned int * pctinfo )

/*-----------------------------------------------------------
	Get type info count
-----------------------------------------------------------*/
{
	if (pctinfo == NULL)
		return E_NOTIMPL;
	*pctinfo = 1;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
-----------------------------------------------------------*/
{
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_eiffel_compiler_, 0, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelProjectProperties_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

/*-----------------------------------------------------------
	Invoke function.
-----------------------------------------------------------*/
{
	HRESULT hr = 0;
	int i = 0;

	unsigned int uArgErr;
	if (wFlags & ~(DISPATCH_METHOD | DISPATCH_PROPERTYGET | DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
		return ResultFromScode (E_INVALIDARG);

	if (puArgErr == NULL)
		puArgErr = &uArgErr;

	VARIANTARG * rgvarg = pDispParams->rgvarg;
	DISPID * rgdispidNamedArgs = pDispParams->rgdispidNamedArgs;
	unsigned int cArgs = pDispParams->cArgs;
	unsigned int cNamedArgs = pDispParams->cNamedArgs;
	VARIANTARG ** tmp_value = NULL;

	if (pExcepInfo != NULL)
	{
		pExcepInfo->wCode = 0;
		pExcepInfo->wReserved = 0;
		pExcepInfo->bstrSource = NULL;
		pExcepInfo->bstrDescription = NULL;
		pExcepInfo->bstrHelpFile = NULL;
		pExcepInfo->dwHelpContext = 0;
		pExcepInfo->pvReserved = NULL;
		pExcepInfo->pfnDeferredFillIn = NULL;
		pExcepInfo->scode = 0;
	}
	
	switch (dispID)
	{
		
		case 142:
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				
				hr = Apply ();
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
			}
			break;

		case 103:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = root_class_name (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_root_class_name ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 104:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = creation_routine (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_creation_routine ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 105:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				VARIANT_BOOL result = 0;
				
				hr = evaluate_require (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {11};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 11)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
				
				hr = set_evaluate_require ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 106:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				VARIANT_BOOL result = 0;
				
				hr = evaluate_ensure (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {11};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 11)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
				
				hr = set_evaluate_ensure ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 107:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				VARIANT_BOOL result = 0;
				
				hr = evaluate_check (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {11};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 11)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
				
				hr = set_evaluate_check ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 108:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				VARIANT_BOOL result = 0;
				
				hr = evaluate_loop (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {11};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 11)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
				
				hr = set_evaluate_loop ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 109:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				VARIANT_BOOL result = 0;
				
				hr = evaluate_invariant (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {11};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 11)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
				
				hr = set_evaluate_invariant ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 111:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				VARIANT_BOOL result = 0;
				
				hr = debug_info (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {11};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 11)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
				
				hr = set_debug_info ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 112:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				ecom_eiffel_compiler::IEiffelSystemClusters * result = 0;
				
				hr = clusters (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 9;
					pVarResult->pdispVal = result;
				}
					
			}
			break;

		case 117:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				ecom_eiffel_compiler::IEiffelSystemExternals * result = 0;
				
				hr = externals (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 9;
					pVarResult->pdispVal = result;
				}
					
			}
			break;

		case 118:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = default_namespace (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_default_namespace ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 119:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				ecom_eiffel_compiler::IEiffelSystemAssemblies * result = 0;
				
				hr = assemblies (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 9;
					pVarResult->pdispVal = result;
				}
					
			}
			break;

		case 120:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = precompiled (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_precompiled ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 121:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				long result = 0;
				
				hr = compilation_type (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 3;
					pVarResult->lVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {3};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 3)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 3);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				long arg_0 = (long)tmp_value [0]->lVal;
				
				hr = set_compilation_type ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 122:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				VARIANT_BOOL result = 0;
				
				hr = console_application (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {11};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 11)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
				
				hr = set_console_application ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 133:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = title (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_title ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 134:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = description (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_description ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 135:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = company (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_company ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 136:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = product (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_product ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 137:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = version (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_version ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 138:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = trademark (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_trademark ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 139:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = copyright (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_copyright ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 140:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = key_file_name (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_key_file_name ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 141:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = culture (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_culture ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 0:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = system_name (&result);
				
				if (FAILED (hr))
				{
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = set_system_name ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		default:
			return DISP_E_MEMBERNOTFOUND;
	}
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		if (pTypeInfo !=NULL)
		{
			pTypeInfo->Release ();
			pTypeInfo = NULL;
		}
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelProjectProperties*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelProjectProperties*>(this);
	else if (riid == IID_IEiffelProjectProperties_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelProjectProperties*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif