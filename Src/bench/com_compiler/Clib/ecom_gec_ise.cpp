/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#include "ecom_gec_ISE.h"
ecom_gec_ISE grt_ec_ISE;

#ifdef __cplusplus
extern "C" {
#endif

ecom_gec_ISE::ecom_gec_ISE(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_1( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_2( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_3( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEiffelException * ecom_gec_ISE::ccom_ec_pointed_interface_6( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_EXCEPTION_INTERFACE to ecom_EiffelComCompiler::IEiffelException *.
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
		((ecom_EiffelComCompiler::IEiffelException *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelException * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelException * * ecom_gec_ISE::ccom_ec_pointed_cell_7( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelException * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_EXCEPTION_INTERFACE] to ecom_EiffelComCompiler::IEiffelException * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelException * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelException * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelException *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_6 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelCompiler * ecom_gec_ISE::ccom_ec_pointed_interface_9( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_COMPILER_INTERFACE to ecom_EiffelComCompiler::IEiffelCompiler *.
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
		((ecom_EiffelComCompiler::IEiffelCompiler *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelCompiler * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelCompiler * * ecom_gec_ISE::ccom_ec_pointed_cell_10( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelCompiler * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPILER_INTERFACE] to ecom_EiffelComCompiler::IEiffelCompiler * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelCompiler * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelCompiler * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelCompiler *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_9 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelSystemBrowser * ecom_gec_ISE::ccom_ec_pointed_interface_14( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_BROWSER_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemBrowser *.
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
		((ecom_EiffelComCompiler::IEiffelSystemBrowser *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelSystemBrowser * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelSystemBrowser * * ecom_gec_ISE::ccom_ec_pointed_cell_15( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemBrowser * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemBrowser * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelSystemBrowser * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelSystemBrowser * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelSystemBrowser *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_14 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelProjectProperties * ecom_gec_ISE::ccom_ec_pointed_interface_17( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_PROJECT_PROPERTIES_INTERFACE to ecom_EiffelComCompiler::IEiffelProjectProperties *.
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
		((ecom_EiffelComCompiler::IEiffelProjectProperties *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelProjectProperties * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelProjectProperties * * ecom_gec_ISE::ccom_ec_pointed_cell_18( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelProjectProperties * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelProjectProperties * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelProjectProperties * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelProjectProperties * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelProjectProperties *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_17 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelCompletionInfo * ecom_gec_ISE::ccom_ec_pointed_interface_20( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_COMPLETION_INFO_INTERFACE to ecom_EiffelComCompiler::IEiffelCompletionInfo *.
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
		((ecom_EiffelComCompiler::IEiffelCompletionInfo *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelCompletionInfo * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelCompletionInfo * * ecom_gec_ISE::ccom_ec_pointed_cell_21( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelCompletionInfo * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPLETION_INFO_INTERFACE] to ecom_EiffelComCompiler::IEiffelCompletionInfo * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelCompletionInfo * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelCompletionInfo * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelCompletionInfo *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_20 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * ecom_gec_ISE::ccom_ec_pointed_interface_23( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_HTMLDOC_GENERATOR_INTERFACE to ecom_EiffelComCompiler::IEiffelHTMLDocGenerator *.
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
		((ecom_EiffelComCompiler::IEiffelHTMLDocGenerator *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * * ecom_gec_ISE::ccom_ec_pointed_cell_24( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_HTMLDOC_GENERATOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelHTMLDocGenerator *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_23 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_25( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_30( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_31( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_32( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_33( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_35( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEnumEiffelClass * ecom_gec_ISE::ccom_ec_pointed_interface_39( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_EIFFEL_CLASS_INTERFACE to ecom_EiffelComCompiler::IEnumEiffelClass *.
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
		((ecom_EiffelComCompiler::IEnumEiffelClass *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEnumEiffelClass * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumEiffelClass * * ecom_gec_ISE::ccom_ec_pointed_cell_40( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumEiffelClass * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_EIFFEL_CLASS_INTERFACE] to ecom_EiffelComCompiler::IEnumEiffelClass * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEnumEiffelClass * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEnumEiffelClass * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEnumEiffelClass *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_39 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumCluster * ecom_gec_ISE::ccom_ec_pointed_interface_43( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_INTERFACE to ecom_EiffelComCompiler::IEnumCluster *.
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
		((ecom_EiffelComCompiler::IEnumCluster *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEnumCluster * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumCluster * * ecom_gec_ISE::ccom_ec_pointed_cell_44( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumCluster * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_INTERFACE] to ecom_EiffelComCompiler::IEnumCluster * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEnumCluster * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEnumCluster * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEnumCluster *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_43 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumAssembly * ecom_gec_ISE::ccom_ec_pointed_interface_46( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_ASSEMBLY_INTERFACE to ecom_EiffelComCompiler::IEnumAssembly *.
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
		((ecom_EiffelComCompiler::IEnumAssembly *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEnumAssembly * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumAssembly * * ecom_gec_ISE::ccom_ec_pointed_cell_47( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumAssembly * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_ASSEMBLY_INTERFACE] to ecom_EiffelComCompiler::IEnumAssembly * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEnumAssembly * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEnumAssembly * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEnumAssembly *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_46 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelClusterDescriptor * ecom_gec_ISE::ccom_ec_pointed_interface_50( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelClusterDescriptor *.
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
		((ecom_EiffelComCompiler::IEiffelClusterDescriptor *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelClusterDescriptor * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelClusterDescriptor * * ecom_gec_ISE::ccom_ec_pointed_cell_51( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelClusterDescriptor * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelClusterDescriptor * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelClusterDescriptor * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelClusterDescriptor * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelClusterDescriptor *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_50 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelClassDescriptor * ecom_gec_ISE::ccom_ec_pointed_interface_53( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_CLASS_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelClassDescriptor *.
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
		((ecom_EiffelComCompiler::IEiffelClassDescriptor *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelClassDescriptor * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelClassDescriptor * * ecom_gec_ISE::ccom_ec_pointed_cell_54( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelClassDescriptor * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelClassDescriptor * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelClassDescriptor * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelClassDescriptor * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelClassDescriptor *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_53 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelFeatureDescriptor * ecom_gec_ISE::ccom_ec_pointed_interface_56( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelFeatureDescriptor *.
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
		((ecom_EiffelComCompiler::IEiffelFeatureDescriptor *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelFeatureDescriptor * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * ecom_gec_ISE::ccom_ec_pointed_cell_57( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelFeatureDescriptor * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelFeatureDescriptor * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelFeatureDescriptor *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_56 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumFeature * ecom_gec_ISE::ccom_ec_pointed_interface_59( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_FEATURE_INTERFACE to ecom_EiffelComCompiler::IEnumFeature *.
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
		((ecom_EiffelComCompiler::IEnumFeature *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEnumFeature * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumFeature * * ecom_gec_ISE::ccom_ec_pointed_cell_60( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumFeature * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_FEATURE_INTERFACE] to ecom_EiffelComCompiler::IEnumFeature * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEnumFeature * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEnumFeature * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEnumFeature *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_59 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_61( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_62( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_65( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_66( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_67( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_68( EIF_REFERENCE eif_ref, BSTR * old )

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

SAFEARRAY *  * ecom_gec_ISE::ccom_ec_pointed_cell_71( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_80( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_87( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_88( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_89( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_90( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_91( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_92( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEnumParameter * ecom_gec_ISE::ccom_ec_pointed_interface_94( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_PARAMETER_INTERFACE to ecom_EiffelComCompiler::IEnumParameter *.
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
		((ecom_EiffelComCompiler::IEnumParameter *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEnumParameter * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumParameter * * ecom_gec_ISE::ccom_ec_pointed_cell_95( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumParameter * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_PARAMETER_INTERFACE] to ecom_EiffelComCompiler::IEnumParameter * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEnumParameter * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEnumParameter * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEnumParameter *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_94 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_96( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_97( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEiffelParameterDescriptor * ecom_gec_ISE::ccom_ec_pointed_interface_121( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelParameterDescriptor *.
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
		((ecom_EiffelComCompiler::IEiffelParameterDescriptor *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelParameterDescriptor * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelParameterDescriptor * * ecom_gec_ISE::ccom_ec_pointed_cell_122( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelParameterDescriptor * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelParameterDescriptor * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelParameterDescriptor * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelParameterDescriptor * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelParameterDescriptor *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_121 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_125( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_126( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_129( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_130( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_131( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_134( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_135( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEiffelAssemblyProperties * ecom_gec_ISE::ccom_ec_pointed_interface_139( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE to ecom_EiffelComCompiler::IEiffelAssemblyProperties *.
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
		((ecom_EiffelComCompiler::IEiffelAssemblyProperties *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelAssemblyProperties * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelAssemblyProperties * * ecom_gec_ISE::ccom_ec_pointed_cell_140( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelAssemblyProperties * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelAssemblyProperties * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelAssemblyProperties * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelAssemblyProperties * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelAssemblyProperties *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_139 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_143( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_144( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_145( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_146( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_148( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_149( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_151( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_152( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_153( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_156( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_161( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEiffelSystemClusters * ecom_gec_ISE::ccom_ec_pointed_interface_164( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_CLUSTERS_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemClusters *.
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
		((ecom_EiffelComCompiler::IEiffelSystemClusters *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelSystemClusters * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelSystemClusters * * ecom_gec_ISE::ccom_ec_pointed_cell_165( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemClusters * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemClusters * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelSystemClusters * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelSystemClusters * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelSystemClusters *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_164 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelSystemExternals * ecom_gec_ISE::ccom_ec_pointed_interface_167( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_EXTERNALS_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemExternals *.
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
		((ecom_EiffelComCompiler::IEiffelSystemExternals *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelSystemExternals * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelSystemExternals * * ecom_gec_ISE::ccom_ec_pointed_cell_168( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemExternals * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemExternals * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelSystemExternals * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelSystemExternals * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelSystemExternals *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_167 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelSystemAssemblies * ecom_gec_ISE::ccom_ec_pointed_interface_170( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemAssemblies *.
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
		((ecom_EiffelComCompiler::IEiffelSystemAssemblies *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelSystemAssemblies * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelSystemAssemblies * * ecom_gec_ISE::ccom_ec_pointed_cell_171( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemAssemblies * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemAssemblies * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelSystemAssemblies * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelSystemAssemblies * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelSystemAssemblies *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_170 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_172( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_173( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_174( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_175( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_176( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_177( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_178( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_179( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_180( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_181( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEnumClusterProp * ecom_gec_ISE::ccom_ec_pointed_interface_183( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_PROP_INTERFACE to ecom_EiffelComCompiler::IEnumClusterProp *.
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
		((ecom_EiffelComCompiler::IEnumClusterProp *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEnumClusterProp * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumClusterProp * * ecom_gec_ISE::ccom_ec_pointed_cell_184( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumClusterProp * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_PROP_INTERFACE] to ecom_EiffelComCompiler::IEnumClusterProp * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEnumClusterProp * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEnumClusterProp * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEnumClusterProp *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_183 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_185( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEiffelClusterProperties * ecom_gec_ISE::ccom_ec_pointed_interface_187( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_PROPERTIES_INTERFACE to ecom_EiffelComCompiler::IEiffelClusterProperties *.
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
		((ecom_EiffelComCompiler::IEiffelClusterProperties *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelClusterProperties * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelClusterProperties * * ecom_gec_ISE::ccom_ec_pointed_cell_188( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelClusterProperties * * old )

/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelClusterProperties * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEiffelClusterProperties * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEiffelClusterProperties * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEiffelClusterProperties *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_187 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_193( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_194( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEnumClusterExcludes * ecom_gec_ISE::ccom_ec_pointed_interface_205( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_EXCLUDES_INTERFACE to ecom_EiffelComCompiler::IEnumClusterExcludes *.
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
		((ecom_EiffelComCompiler::IEnumClusterExcludes *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEnumClusterExcludes * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumClusterExcludes * * ecom_gec_ISE::ccom_ec_pointed_cell_206( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumClusterExcludes * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE] to ecom_EiffelComCompiler::IEnumClusterExcludes * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEnumClusterExcludes * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEnumClusterExcludes * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEnumClusterExcludes *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_205 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_207( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_212( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_213( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_214( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_216( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_EiffelComCompiler::IEnumIncludePaths * ecom_gec_ISE::ccom_ec_pointed_interface_219( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_INCLUDE_PATHS_INTERFACE to ecom_EiffelComCompiler::IEnumIncludePaths *.
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
		((ecom_EiffelComCompiler::IEnumIncludePaths *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEnumIncludePaths * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumIncludePaths * * ecom_gec_ISE::ccom_ec_pointed_cell_220( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumIncludePaths * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_INCLUDE_PATHS_INTERFACE] to ecom_EiffelComCompiler::IEnumIncludePaths * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEnumIncludePaths * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEnumIncludePaths * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEnumIncludePaths *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_219 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumObjectFiles * ecom_gec_ISE::ccom_ec_pointed_interface_222( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_OBJECT_FILES_INTERFACE to ecom_EiffelComCompiler::IEnumObjectFiles *.
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
		((ecom_EiffelComCompiler::IEnumObjectFiles *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEnumObjectFiles * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumObjectFiles * * ecom_gec_ISE::ccom_ec_pointed_cell_223( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumObjectFiles * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_OBJECT_FILES_INTERFACE] to ecom_EiffelComCompiler::IEnumObjectFiles * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_EiffelComCompiler::IEnumObjectFiles * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_EiffelComCompiler::IEnumObjectFiles * *) CoTaskMemAlloc (sizeof (ecom_EiffelComCompiler::IEnumObjectFiles *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_222 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_224( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_226( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_228( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE::ccom_ec_pointed_cell_230( EIF_REFERENCE eif_ref, BSTR * old )

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

VARIANT * ecom_gec_ISE::ccom_ec_pointed_record_232( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_ISE::ccom_ec_pointed_record_233( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

VARIANT * ecom_gec_ISE::ccom_ec_pointed_record_234( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_VARIANT");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return  (VARIANT * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelHTMLDocEvents * ecom_gec_ISE::ccom_ec_pointed_interface_239( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IEIFFEL_HTMLDOC_EVENTS_INTERFACE to ecom_EiffelComCompiler::IEiffelHTMLDocEvents *.
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
		((ecom_EiffelComCompiler::IEiffelHTMLDocEvents *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_EiffelComCompiler::IEiffelHTMLDocEvents * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif