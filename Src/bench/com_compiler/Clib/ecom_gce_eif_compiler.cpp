/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#include "ecom_gce_Eif_compiler.h"
ecom_gce_Eif_compiler grt_ce_Eif_compiler;

#ifdef __cplusplus
extern "C" {
#endif

ecom_gce_Eif_compiler::ecom_gce_Eif_compiler(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_1( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_1( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_2( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_2( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_3( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_3( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_4( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_5( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_5( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_7( ecom_eiffel_compiler::IEiffelCompiler * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompiler *  to IEIFFEL_COMPILER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_COMPILER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_8( ecom_eiffel_compiler::IEiffelCompiler * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompiler * *  to CELL [IEIFFEL_COMPILER_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_COMPILER_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelCompiler * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_7 (*(ecom_eiffel_compiler::IEiffelCompiler * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_8( ecom_eiffel_compiler::IEiffelCompiler * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelCompiler * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_9( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_11( ecom_eiffel_compiler::IEiffelSystemBrowser * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemBrowser *  to IEIFFEL_SYSTEM_BROWSER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_SYSTEM_BROWSER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_12( ecom_eiffel_compiler::IEiffelSystemBrowser * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemBrowser * *  to CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelSystemBrowser * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_11 (*(ecom_eiffel_compiler::IEiffelSystemBrowser * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_12( ecom_eiffel_compiler::IEiffelSystemBrowser * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemBrowser * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_14( ecom_eiffel_compiler::IEiffelProjectProperties * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelProjectProperties *  to IEIFFEL_PROJECT_PROPERTIES_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_PROJECT_PROPERTIES_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_15( ecom_eiffel_compiler::IEiffelProjectProperties * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelProjectProperties * *  to CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelProjectProperties * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_14 (*(ecom_eiffel_compiler::IEiffelProjectProperties * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_15( ecom_eiffel_compiler::IEiffelProjectProperties * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelProjectProperties * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_16( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_17( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_17( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_19( ecom_eiffel_compiler::IEnumEiffelClass * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumEiffelClass *  to IENUM_EIFFEL_CLASS_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_EIFFEL_CLASS_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_20( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumEiffelClass * *  to CELL [IENUM_EIFFEL_CLASS_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_EIFFEL_CLASS_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumEiffelClass * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_19 (*(ecom_eiffel_compiler::IEnumEiffelClass * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_20( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumEiffelClass * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_21( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_23( ecom_eiffel_compiler::IEnumCluster * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCluster *  to IENUM_CLUSTER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_CLUSTER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_24( ecom_eiffel_compiler::IEnumCluster * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCluster * *  to CELL [IENUM_CLUSTER_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_CLUSTER_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumCluster * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_23 (*(ecom_eiffel_compiler::IEnumCluster * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_24( ecom_eiffel_compiler::IEnumCluster * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumCluster * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_25( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_27( ecom_eiffel_compiler::IEiffelClusterDescriptor * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor *  to IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_CLUSTER_DESCRIPTOR_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_28( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor * *  to CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelClusterDescriptor * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_27 (*(ecom_eiffel_compiler::IEiffelClusterDescriptor * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_28( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterDescriptor * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_30( ecom_eiffel_compiler::IEiffelClassDescriptor * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor *  to IEIFFEL_CLASS_DESCRIPTOR_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_CLASS_DESCRIPTOR_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_31( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor * *  to CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelClassDescriptor * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_30 (*(ecom_eiffel_compiler::IEiffelClassDescriptor * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_31( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClassDescriptor * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_33( ecom_eiffel_compiler::IEiffelFeatureDescriptor * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor *  to IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_FEATURE_DESCRIPTOR_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_34( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor * *  to CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelFeatureDescriptor * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_33 (*(ecom_eiffel_compiler::IEiffelFeatureDescriptor * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_34( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelFeatureDescriptor * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_36( ecom_eiffel_compiler::IEnumFeature * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumFeature *  to IENUM_FEATURE_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_FEATURE_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_37( ecom_eiffel_compiler::IEnumFeature * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumFeature * *  to CELL [IENUM_FEATURE_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_FEATURE_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumFeature * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_36 (*(ecom_eiffel_compiler::IEnumFeature * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_37( ecom_eiffel_compiler::IEnumFeature * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumFeature * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_38( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_39( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_40( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_40( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_41( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_41( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_42( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_42( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_43( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_43( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_44( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_46( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_ARRAY [STRING]]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(SAFEARRAY *  *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_safearray_bstr (*(SAFEARRAY *  *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_46( SAFEARRAY *  * a_pointer )

/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_safearray (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_47( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_48( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_49( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_50( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_51( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_52( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_53( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_53( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_54( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_55( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_56( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_57( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_58( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_59( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_59( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_60( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_60( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_61( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_61( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_62( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_62( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_63( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_63( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_64( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_64( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_65( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_66( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_66( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_67( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_68( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_69( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_70( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_71( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_72( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_73( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_74( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_75( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_76( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_77( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_78( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_79( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_80( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_81( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_82( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_83( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_84( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_85( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_86( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_87( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_88( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_89( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_90( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_90( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_91( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_91( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_92( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_92( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_93( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_94( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_95( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_95( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_96( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_96( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_97( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_98( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_99( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_99( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_100( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_100( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_101( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_101( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_103( long * a_pointer )

/*-----------------------------------------------------------
	Free memory of long *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_104( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_105( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_106( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_107( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_108( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_109( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_110( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_112( ecom_eiffel_compiler::IEiffelSystemClusters * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemClusters *  to IEIFFEL_SYSTEM_CLUSTERS_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_SYSTEM_CLUSTERS_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_113( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemClusters * *  to CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelSystemClusters * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_112 (*(ecom_eiffel_compiler::IEiffelSystemClusters * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_113( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemClusters * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_115( ecom_eiffel_compiler::IEnumImportedAssemblies * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumImportedAssemblies *  to IENUM_IMPORTED_ASSEMBLIES_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_IMPORTED_ASSEMBLIES_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_116( ecom_eiffel_compiler::IEnumImportedAssemblies * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumImportedAssemblies * *  to CELL [IENUM_IMPORTED_ASSEMBLIES_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_IMPORTED_ASSEMBLIES_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumImportedAssemblies * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_115 (*(ecom_eiffel_compiler::IEnumImportedAssemblies * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_116( ecom_eiffel_compiler::IEnumImportedAssemblies * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumImportedAssemblies * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_118( ecom_eiffel_compiler::IEnumClusterProp * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterProp *  to IENUM_CLUSTER_PROP_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_CLUSTER_PROP_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_119( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterProp * *  to CELL [IENUM_CLUSTER_PROP_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_CLUSTER_PROP_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumClusterProp * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_118 (*(ecom_eiffel_compiler::IEnumClusterProp * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_119( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumClusterProp * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_121( ecom_eiffel_compiler::IEiffelClusterProperties * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties *  to IEIFFEL_CLUSTER_PROPERTIES_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_CLUSTER_PROPERTIES_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_122( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties * *  to CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelClusterProperties * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_121 (*(ecom_eiffel_compiler::IEiffelClusterProperties * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_122( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterProperties * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_123( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_124( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_125( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_125( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_126( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_126( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_127( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_128( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_129( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_130( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_131( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_132( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_133( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_134( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_135( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_interface_137( ecom_eiffel_compiler::IEnumClusterExcludes * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterExcludes *  to IENUM_CLUSTER_EXCLUDES_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_CLUSTER_EXCLUDES_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_138( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterExcludes * *  to CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumClusterExcludes * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_137 (*(ecom_eiffel_compiler::IEnumClusterExcludes * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_138( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumClusterExcludes * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_139( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_139( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_140( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_141( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_142( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_143( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_143( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_144( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_145( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_145( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_146( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_147( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_147( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_148( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_Eif_compiler::ccom_ce_pointed_cell_149( BSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(BSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_bstr (*(BSTR *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_149( BSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of BSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		rt_ce.free_memory_bstr (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_150( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_Eif_compiler::ccom_free_memory_pointed_151( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif