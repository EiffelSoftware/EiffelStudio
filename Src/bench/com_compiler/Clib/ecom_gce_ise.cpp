/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#include "ecom_gce_ISE.h"
ecom_gce_ISE grt_ce_ISE;

#ifdef __cplusplus
extern "C" {
#endif

ecom_gce_ISE::ecom_gce_ISE(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_1( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_1( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_2( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_2( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_3( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_3( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_4( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_5( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_5( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_7( ecom_eiffel_compiler::IEiffelCompiler * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_8( ecom_eiffel_compiler::IEiffelCompiler * * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_8( ecom_eiffel_compiler::IEiffelCompiler * * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_9( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_10( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_12( ecom_eiffel_compiler::IEiffelSystemBrowser * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_13( ecom_eiffel_compiler::IEiffelSystemBrowser * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_12 (*(ecom_eiffel_compiler::IEiffelSystemBrowser * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_13( ecom_eiffel_compiler::IEiffelSystemBrowser * * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_15( ecom_eiffel_compiler::IEiffelProjectProperties * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_16( ecom_eiffel_compiler::IEiffelProjectProperties * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_15 (*(ecom_eiffel_compiler::IEiffelProjectProperties * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_16( ecom_eiffel_compiler::IEiffelProjectProperties * * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_18( ecom_eiffel_compiler::IEiffelCompletionInfo * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompletionInfo *  to IEIFFEL_COMPLETION_INFO_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_COMPLETION_INFO_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_19( ecom_eiffel_compiler::IEiffelCompletionInfo * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompletionInfo * *  to CELL [IEIFFEL_COMPLETION_INFO_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_COMPLETION_INFO_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelCompletionInfo * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_18 (*(ecom_eiffel_compiler::IEiffelCompletionInfo * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_19( ecom_eiffel_compiler::IEiffelCompletionInfo * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelCompletionInfo * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_21( ecom_eiffel_compiler::IEiffelHTMLDocGenerator * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelHTMLDocGenerator *  to IEIFFEL_HTMLDOC_GENERATOR_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_HTMLDOC_GENERATOR_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_22( ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelHTMLDocGenerator * *  to CELL [IEIFFEL_HTMLDOC_GENERATOR_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_HTMLDOC_GENERATOR_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelHTMLDocGenerator * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_21 (*(ecom_eiffel_compiler::IEiffelHTMLDocGenerator * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_22( ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelHTMLDocGenerator * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_23( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_24( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_25( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_25( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_26( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_26( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_27( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_27( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_28( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_28( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_29( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_31( ecom_eiffel_compiler::IEnumEiffelClass * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_32( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_31 (*(ecom_eiffel_compiler::IEnumEiffelClass * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_32( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_33( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_35( ecom_eiffel_compiler::IEnumCluster * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_36( ecom_eiffel_compiler::IEnumCluster * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_35 (*(ecom_eiffel_compiler::IEnumCluster * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_36( ecom_eiffel_compiler::IEnumCluster * * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_37( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_39( ecom_eiffel_compiler::IEiffelClusterDescriptor * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_40( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_39 (*(ecom_eiffel_compiler::IEiffelClusterDescriptor * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_40( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_42( ecom_eiffel_compiler::IEiffelClassDescriptor * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_43( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_42 (*(ecom_eiffel_compiler::IEiffelClassDescriptor * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_43( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_45( ecom_eiffel_compiler::IEiffelFeatureDescriptor * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_46( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_45 (*(ecom_eiffel_compiler::IEiffelFeatureDescriptor * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_46( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_48( ecom_eiffel_compiler::IEnumFeature * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_49( ecom_eiffel_compiler::IEnumFeature * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_48 (*(ecom_eiffel_compiler::IEnumFeature * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_49( ecom_eiffel_compiler::IEnumFeature * * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_50( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_51( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_52( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_52( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_53( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_53( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_54( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_54( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_55( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_55( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_56( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_58( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_58( SAFEARRAY *  * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_59( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_60( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_61( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_62( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_63( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_64( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_65( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_65( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_66( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_67( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_68( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_69( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_70( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_71( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_72( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_72( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_73( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_73( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_74( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_74( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_75( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_75( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_77( ecom_eiffel_compiler::IEnumParameter * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumParameter *  to IENUM_PARAMETER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_PARAMETER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_78( ecom_eiffel_compiler::IEnumParameter * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumParameter * *  to CELL [IENUM_PARAMETER_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_PARAMETER_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumParameter * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_77 (*(ecom_eiffel_compiler::IEnumParameter * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_78( ecom_eiffel_compiler::IEnumParameter * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumParameter * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_79( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_79( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_80( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_80( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_81( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_82( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_83( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_84( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_85( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_86( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_87( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_88( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_89( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_90( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_91( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_92( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_93( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_94( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_95( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_96( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_97( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_98( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_99( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_100( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_101( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_102( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_103( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_103( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_104( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_104( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_105( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_107( ecom_eiffel_compiler::IEiffelParameterDescriptor * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelParameterDescriptor *  to IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_PARAMETER_DESCRIPTOR_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_108( ecom_eiffel_compiler::IEiffelParameterDescriptor * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelParameterDescriptor * *  to CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelParameterDescriptor * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_107 (*(ecom_eiffel_compiler::IEiffelParameterDescriptor * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_108( ecom_eiffel_compiler::IEiffelParameterDescriptor * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelParameterDescriptor * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_109( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_110( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_111( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_111( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_112( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_112( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_113( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_114( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_115( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_115( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_116( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_116( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_117( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_117( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_118( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_119( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_120( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_120( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_121( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_121( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_122( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_123( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_124( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_124( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_125( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_125( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_126( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_126( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_128( long * a_pointer )

/*-----------------------------------------------------------
	Free memory of long *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_129( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_130( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_131( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_132( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_133( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_134( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_135( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_137( ecom_eiffel_compiler::IEiffelSystemClusters * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_138( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_137 (*(ecom_eiffel_compiler::IEiffelSystemClusters * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_138( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_140( ecom_eiffel_compiler::IEiffelSystemExternals * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemExternals *  to IEIFFEL_SYSTEM_EXTERNALS_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_SYSTEM_EXTERNALS_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_141( ecom_eiffel_compiler::IEiffelSystemExternals * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemExternals * *  to CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelSystemExternals * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_140 (*(ecom_eiffel_compiler::IEiffelSystemExternals * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_141( ecom_eiffel_compiler::IEiffelSystemExternals * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemExternals * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_142( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_142( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_144( ecom_eiffel_compiler::IEiffelSystemAssemblies * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemAssemblies *  to IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_SYSTEM_ASSEMBLIES_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_145( ecom_eiffel_compiler::IEiffelSystemAssemblies * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemAssemblies * *  to CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelSystemAssemblies * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_144 (*(ecom_eiffel_compiler::IEiffelSystemAssemblies * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_145( ecom_eiffel_compiler::IEiffelSystemAssemblies * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemAssemblies * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_146( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_146( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_147( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_147( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_148( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_148( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_149( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_149( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_150( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_150( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_151( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_151( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_152( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_152( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_153( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_153( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_154( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_154( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_155( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_155( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_157( ecom_eiffel_compiler::IEnumClusterProp * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_158( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_157 (*(ecom_eiffel_compiler::IEnumClusterProp * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_158( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_160( ecom_eiffel_compiler::IEiffelClusterProperties * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_161( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_160 (*(ecom_eiffel_compiler::IEiffelClusterProperties * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_161( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_162( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_163( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_163( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_164( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_165( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_166( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_166( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_167( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_167( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_168( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_169( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_170( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_171( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_172( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_173( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_174( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_175( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_176( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_178( ecom_eiffel_compiler::IEnumClusterExcludes * a_interface_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_179( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer, EIF_OBJECT an_object )

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
		tmp_object = eif_protect (ccom_ce_pointed_interface_178 (*(ecom_eiffel_compiler::IEnumClusterExcludes * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_179( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_180( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_180( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_181( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_182( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_183( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_184( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_185( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_185( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_186( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_186( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_187( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_187( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_188( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_189( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_189( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_190( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_192( ecom_eiffel_compiler::IEnumIncludePaths * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumIncludePaths *  to IENUM_INCLUDE_PATHS_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_INCLUDE_PATHS_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_193( ecom_eiffel_compiler::IEnumIncludePaths * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumIncludePaths * *  to CELL [IENUM_INCLUDE_PATHS_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_INCLUDE_PATHS_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumIncludePaths * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_192 (*(ecom_eiffel_compiler::IEnumIncludePaths * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_193( ecom_eiffel_compiler::IEnumIncludePaths * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumIncludePaths * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_195( ecom_eiffel_compiler::IEnumObjectFiles * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumObjectFiles *  to IENUM_OBJECT_FILES_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_OBJECT_FILES_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_196( ecom_eiffel_compiler::IEnumObjectFiles * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumObjectFiles * *  to CELL [IENUM_OBJECT_FILES_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_OBJECT_FILES_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumObjectFiles * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_195 (*(ecom_eiffel_compiler::IEnumObjectFiles * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_196( ecom_eiffel_compiler::IEnumObjectFiles * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumObjectFiles * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_197( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_197( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_198( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_199( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_199( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_200( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_201( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_201( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_202( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_203( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_203( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_204( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_206( ecom_eiffel_compiler::IEiffelAssemblyProperties * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelAssemblyProperties *  to IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_ASSEMBLY_PROPERTIES_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_207( ecom_eiffel_compiler::IEiffelAssemblyProperties * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelAssemblyProperties * *  to CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelAssemblyProperties * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_206 (*(ecom_eiffel_compiler::IEiffelAssemblyProperties * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_207( ecom_eiffel_compiler::IEiffelAssemblyProperties * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelAssemblyProperties * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_208( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_209( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_210( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_211( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_212( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_212( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_213( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_213( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_214( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_215( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_217( ecom_eiffel_compiler::IEnumAssembly * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumAssembly *  to IENUM_ASSEMBLY_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_ASSEMBLY_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_218( ecom_eiffel_compiler::IEnumAssembly * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumAssembly * *  to CELL [IENUM_ASSEMBLY_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_ASSEMBLY_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumAssembly * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_217 (*(ecom_eiffel_compiler::IEnumAssembly * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_218( ecom_eiffel_compiler::IEnumAssembly * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumAssembly * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_219( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_219( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_220( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_220( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_221( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_221( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_222( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_222( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_223( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_224( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_225( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_225( BSTR * a_pointer )

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

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_226( BSTR * a_pointer, EIF_OBJECT an_object )

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

void ecom_gce_ISE::ccom_free_memory_pointed_226( BSTR * a_pointer )

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

void ecom_gce_ISE::ccom_free_memory_pointed_227( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_228( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_230( ecom_eiffel_compiler::IEnumCompletionEntry * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCompletionEntry *  to IENUM_COMPLETION_ENTRY_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_COMPLETION_ENTRY_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_231( ecom_eiffel_compiler::IEnumCompletionEntry * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCompletionEntry * *  to CELL [IENUM_COMPLETION_ENTRY_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_COMPLETION_ENTRY_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEnumCompletionEntry * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_230 (*(ecom_eiffel_compiler::IEnumCompletionEntry * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_231( ecom_eiffel_compiler::IEnumCompletionEntry * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumCompletionEntry * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_233( ecom_eiffel_compiler::IEiffelCompletionEntry * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompletionEntry *  to IEIFFEL_COMPLETION_ENTRY_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_COMPLETION_ENTRY_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_cell_234( ecom_eiffel_compiler::IEiffelCompletionEntry * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompletionEntry * *  to CELL [IEIFFEL_COMPLETION_ENTRY_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IEIFFEL_COMPLETION_ENTRY_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_eiffel_compiler::IEiffelCompletionEntry * *) a_pointer != NULL)
		tmp_object = eif_protect (ccom_ce_pointed_interface_233 (*(ecom_eiffel_compiler::IEiffelCompletionEntry * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_234( ecom_eiffel_compiler::IEiffelCompletionEntry * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelCompletionEntry * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_235( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_236( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_237( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_238( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_239( VARIANT_BOOL * a_pointer )

/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_ISE::ccom_ce_pointed_interface_241( ecom_eiffel_compiler::IEiffelHTMLDocEvents * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelHTMLDocEvents *  to IEIFFEL_HTMLDOC_EVENTS_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IEIFFEL_HTMLDOC_EVENTS_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_ISE::ccom_free_memory_pointed_242( VARIANT_BOOL * a_pointer )

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