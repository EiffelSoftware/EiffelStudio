/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#include "ecom_gec_Eif_compiler.h"
ecom_gec_Eif_compiler grt_ec_Eif_compiler;

#ifdef __cplusplus
extern "C" {
#endif

ecom_gec_Eif_compiler::ecom_gec_Eif_compiler(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_1( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_2( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_3( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_5( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelCompiler * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_7( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_COMPILER_INTERFACE to ecom_eiffel_compiler::IEiffelCompiler *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEiffelCompiler *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEiffelCompiler * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelCompiler * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_8( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelCompiler * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPILER_INTERFACE] to ecom_eiffel_compiler::IEiffelCompiler * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEiffelCompiler * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEiffelCompiler * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEiffelCompiler *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_7 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemBrowser * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_11( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_BROWSER_INTERFACE to ecom_eiffel_compiler::IEiffelSystemBrowser *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEiffelSystemBrowser *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEiffelSystemBrowser * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemBrowser * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_12( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemBrowser * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemBrowser * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEiffelSystemBrowser * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEiffelSystemBrowser * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEiffelSystemBrowser *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_11 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelProjectProperties * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_14( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_PROJECT_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelProjectProperties *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEiffelProjectProperties *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEiffelProjectProperties * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelProjectProperties * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_15( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelProjectProperties * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelProjectProperties * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEiffelProjectProperties * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEiffelProjectProperties * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEiffelProjectProperties *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_14 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_18( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_19( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_20( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumEiffelClass * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_22( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_EIFFEL_CLASS_INTERFACE to ecom_eiffel_compiler::IEnumEiffelClass *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEnumEiffelClass *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEnumEiffelClass * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumEiffelClass * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_23( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumEiffelClass * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_EIFFEL_CLASS_INTERFACE] to ecom_eiffel_compiler::IEnumEiffelClass * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEnumEiffelClass * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEnumEiffelClass * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEnumEiffelClass *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_22 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumCluster * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_26( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_INTERFACE to ecom_eiffel_compiler::IEnumCluster *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEnumCluster *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEnumCluster * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumCluster * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_27( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumCluster * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_INTERFACE] to ecom_eiffel_compiler::IEnumCluster * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEnumCluster * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEnumCluster * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEnumCluster *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_26 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelClusterDescriptor * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_30( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelClusterDescriptor *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEiffelClusterDescriptor *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEiffelClusterDescriptor * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelClusterDescriptor * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_31( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClusterDescriptor * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelClusterDescriptor * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEiffelClusterDescriptor * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEiffelClusterDescriptor * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEiffelClusterDescriptor *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_30 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelClassDescriptor * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_33( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_CLASS_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelClassDescriptor *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEiffelClassDescriptor *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEiffelClassDescriptor * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelClassDescriptor * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_34( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClassDescriptor * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelClassDescriptor * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEiffelClassDescriptor * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEiffelClassDescriptor * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEiffelClassDescriptor *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_33 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelFeatureDescriptor * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_36( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelFeatureDescriptor *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEiffelFeatureDescriptor *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEiffelFeatureDescriptor * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelFeatureDescriptor * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_37( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelFeatureDescriptor * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelFeatureDescriptor * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEiffelFeatureDescriptor * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEiffelFeatureDescriptor *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_36 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumFeature * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_39( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_FEATURE_INTERFACE to ecom_eiffel_compiler::IEnumFeature *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEnumFeature *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEnumFeature * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumFeature * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_40( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumFeature * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_FEATURE_INTERFACE] to ecom_eiffel_compiler::IEnumFeature * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEnumFeature * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEnumFeature * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEnumFeature *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_39 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_43( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_44( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_45( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_46( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

SAFEARRAY *  * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_49( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [STRING]] to SAFEARRAY *  *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	SAFEARRAY *  * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (SAFEARRAY *  *) CoTaskMemAlloc (sizeof (SAFEARRAY * ));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_safearray(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_safearray_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_56( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_63( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_64( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_65( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_66( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_67( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_68( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_70( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_94( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_95( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_96( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_99( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_100( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_103( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_104( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_105( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemClusters * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_116( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_CLUSTERS_INTERFACE to ecom_eiffel_compiler::IEiffelSystemClusters *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEiffelSystemClusters *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEiffelSystemClusters * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemClusters * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_117( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemClusters * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemClusters * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEiffelSystemClusters * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEiffelSystemClusters * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEiffelSystemClusters *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_116 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumImportedAssemblies * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_119( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_IMPORTED_ASSEMBLIES_INTERFACE to ecom_eiffel_compiler::IEnumImportedAssemblies *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEnumImportedAssemblies *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEnumImportedAssemblies * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumImportedAssemblies * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_120( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumImportedAssemblies * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_IMPORTED_ASSEMBLIES_INTERFACE] to ecom_eiffel_compiler::IEnumImportedAssemblies * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEnumImportedAssemblies * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEnumImportedAssemblies * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEnumImportedAssemblies *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_119 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumIncludePaths * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_122( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_INCLUDE_PATHS_INTERFACE to ecom_eiffel_compiler::IEnumIncludePaths *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEnumIncludePaths *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEnumIncludePaths * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumIncludePaths * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_123( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumIncludePaths * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_INCLUDE_PATHS_INTERFACE] to ecom_eiffel_compiler::IEnumIncludePaths * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEnumIncludePaths * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEnumIncludePaths * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEnumIncludePaths *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_122 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumObjectFiles * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_125( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_OBJECT_FILES_INTERFACE to ecom_eiffel_compiler::IEnumObjectFiles *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEnumObjectFiles *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEnumObjectFiles * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumObjectFiles * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_126( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumObjectFiles * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_OBJECT_FILES_INTERFACE] to ecom_eiffel_compiler::IEnumObjectFiles * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEnumObjectFiles * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEnumObjectFiles * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEnumObjectFiles *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_125 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumClusterProp * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_128( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_PROP_INTERFACE to ecom_eiffel_compiler::IEnumClusterProp *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEnumClusterProp *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEnumClusterProp * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumClusterProp * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_129( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumClusterProp * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_PROP_INTERFACE] to ecom_eiffel_compiler::IEnumClusterProp * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEnumClusterProp * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEnumClusterProp * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEnumClusterProp *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_128 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelClusterProperties * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_131( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelClusterProperties *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEiffelClusterProperties *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEiffelClusterProperties * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelClusterProperties * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_132( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClusterProperties * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelClusterProperties * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEiffelClusterProperties * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEiffelClusterProperties * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEiffelClusterProperties *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_131 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_135( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_136( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumClusterExcludes * ecom_gec_Eif_compiler::ccom_ec_pointed_interface_147( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_EXCLUDES_INTERFACE to ecom_eiffel_compiler::IEnumClusterExcludes *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer  == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_eiffel_compiler::IEnumClusterExcludes *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_eiffel_compiler::IEnumClusterExcludes * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumClusterExcludes * * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_148( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumClusterExcludes * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE] to ecom_eiffel_compiler::IEnumClusterExcludes * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_eiffel_compiler::IEnumClusterExcludes * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_eiffel_compiler::IEnumClusterExcludes * *) CoTaskMemAlloc (sizeof (ecom_eiffel_compiler::IEnumClusterExcludes *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_147 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_149( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_153( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_155( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_157( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_159( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_161( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_163( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_165( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_Eif_compiler::ccom_ec_pointed_cell_167( EIF_REFERENCE eif_ref, BSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	BSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (BSTR *) CoTaskMemAlloc (sizeof (BSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		rt_ce.free_memory_bstr(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_bstr (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif