/*-----------------------------------------------------------
Implemented `IEiffelProjectProperties' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelProjectProperties_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelProjectProperties_ = {0x635bcc83,0xfd96,0x40ce,{0x93,0x3e,0x53,0x51,0xe1,0xb3,0xe2,0x94}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::IEiffelProjectProperties_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::~IEiffelProjectProperties_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
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

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::namespace_generation(  /* [out, retval] */ long * penu_cluster_namespace_generation )

/*-----------------------------------------------------------
	Namespace generation for cluster
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("namespace_generation", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "namespace_generation", EIF_INTEGER);
	*penu_cluster_namespace_generation = (long)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_namespace_generation(  /* [in] */ long penu_cluster_namespace_generation )

/*-----------------------------------------------------------
	Namespace generation for cluster
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_penu_cluster_namespace_generation = (EIF_INTEGER)penu_cluster_namespace_generation;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_namespace_generation", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_penu_cluster_namespace_generation);
	
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

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::project_type(  /* [out, retval] */ long * penum_project_type )

/*-----------------------------------------------------------
	Project type
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("project_type", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "project_type", EIF_INTEGER);
	*penum_project_type = (long)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_project_type(  /* [in] */ long penum_project_type )

/*-----------------------------------------------------------
	Project type
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_penum_project_type = (EIF_INTEGER)penum_project_type;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_project_type", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_penum_project_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::dot_net_naming_convention(  /* [out, retval] */ VARIANT_BOOL * pvb_naming_convention )

/*-----------------------------------------------------------
	.NET Naming convention
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("dot_net_naming_convention", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "dot_net_naming_convention", EIF_BOOLEAN);
	*pvb_naming_convention = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_dot_net_naming_convention(  /* [in] */ VARIANT_BOOL pvb_naming_convention )

/*-----------------------------------------------------------
	.NET Naming convention
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_pvb_naming_convention = rt_ce.ccom_ce_boolean (pvb_naming_convention);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_dot_net_naming_convention", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_pvb_naming_convention);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::generate_debug_info(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Generate debug info?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("generate_debug_info", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "generate_debug_info", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_generate_debug_info(  /* [in] */ VARIANT_BOOL return_value )

/*-----------------------------------------------------------
	Generate debug info?
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_return_value = rt_ce.ccom_ce_boolean (return_value);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_generate_debug_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::precompiled_library(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Precompiled file.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("precompiled_library", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "precompiled_library", EIF_REFERENCE);
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

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_precompiled_library(  /* [in] */ BSTR return_value )

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
	eiffel_procedure = eif_procedure ("set_precompiled_library", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_return_value != NULL) ? eif_access (tmp_return_value) : NULL));
	if (tmp_return_value != NULL)
		eif_wean (tmp_return_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::assertions(  /* [out, retval] */ ULONG * p_assertions )

/*-----------------------------------------------------------
	Project assertions
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("assertions", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "assertions", EIF_INTEGER);
	*p_assertions = (ULONG)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_assertions(  /* [in] */ ULONG p_assertions )

/*-----------------------------------------------------------
	Project assertions
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_p_assertions = (EIF_INTEGER)p_assertions;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_assertions", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_p_assertions);
	
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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_164 (eif_access (tmp_object));
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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_167 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_170 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
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

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::working_directory(  /* [out, retval] */ BSTR * pbstr_working_directory )

/*-----------------------------------------------------------
	Project working directory
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("working_directory", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "working_directory", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pbstr_working_directory = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pbstr_working_directory = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::set_working_directory(  /* [in] */ BSTR pbstr_working_directory )

/*-----------------------------------------------------------
	Project working directory
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbstr_working_directory = NULL;
	if (pbstr_working_directory != NULL)
	{
		tmp_pbstr_working_directory = eif_protect (rt_ce.ccom_ce_bstr (pbstr_working_directory));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_working_directory", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbstr_working_directory != NULL) ? eif_access (tmp_pbstr_working_directory) : NULL));
	if (tmp_pbstr_working_directory != NULL)
		eif_wean (tmp_pbstr_working_directory);
	
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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelProjectProperties_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
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