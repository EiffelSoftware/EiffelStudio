/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#include "ecom_gec_ISE_c.h"
ecom_gec_ISE_c grt_ec_ISE_c;

#ifdef __cplusplus
extern "C" {
#endif

ecom_gec_ISE_c::ecom_gec_ISE_c(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_CodeGenerator::PartComparable * ecom_gec_ISE_c::ccom_ec_pointed_interface_2( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert PART_COMPARABLE_INTERFACE to ecom_ISE_Reflection_CodeGenerator::PartComparable *.
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
		((ecom_ISE_Reflection_CodeGenerator::PartComparable *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_CodeGenerator::PartComparable * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_7( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_11( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_EiffelClass * ecom_gec_ISE_c::ccom_ec_pointed_interface_13( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_EIFFEL_CLASS_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_EiffelClass *.
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
		((ecom_ISE_Reflection_EiffelComponents::_EiffelClass *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_EiffelClass * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_EiffelClass * * ecom_gec_ISE_c::ccom_ec_pointed_cell_14( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_EiffelClass * * old )

/*-----------------------------------------------------------
	Convert CELL [X_EIFFEL_CLASS_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_EiffelClass * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_EiffelClass * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_EiffelClass * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_EiffelClass *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_13 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * ecom_gec_ISE_c::ccom_ec_pointed_interface_16( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_EIFFEL_CODE_GENERATOR_INTERFACE to ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator *.
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
		((ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * * ecom_gec_ISE_c::ccom_ec_pointed_cell_17( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * * old )

/*-----------------------------------------------------------
	Convert CELL [X_EIFFEL_CODE_GENERATOR_INTERFACE] to ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_16 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_18( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_19( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_20( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_21( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_22( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_26( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_27( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_28( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_29( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_30( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_31( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_32( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_33( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_34( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_35( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_36( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_37( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_38( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_39( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_40( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_41( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_42( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_43( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_44( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_45( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_46( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_47( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_48( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_49( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_50( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_51( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_52( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_53( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_54( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_55( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_56( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_57( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_58( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_59( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_60( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_61( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_62( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_63( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_64( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_65( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_66( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_67( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_68( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_69( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_70( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_71( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_72( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_73( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_74( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_75( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_76( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_77( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_78( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_79( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_80( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_81( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_82( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_83( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_84( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_85( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_86( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_87( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_88( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_89( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_90( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_91( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_92( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_93( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_94( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_95( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_96( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_97( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_98( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_99( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_100( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_101( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_102( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_103( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_104( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_105( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_106( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_107( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_108( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * ecom_gec_ISE_c::ccom_ec_pointed_interface_110( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_EIFFEL_FEATURE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_EiffelFeature *.
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
		((ecom_ISE_Reflection_EiffelComponents::_EiffelFeature *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_112( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_116( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_117( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_118( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_119( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_120( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_121( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_122( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_126( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_127( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_128( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_129( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_130( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_131( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_132( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_133( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_134( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_135( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_136( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_137( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_138( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_139( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_140( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_141( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_142( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_143( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_144( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_145( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_146( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_147( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_148( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_149( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_150( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_151( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_152( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_153( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_154( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_155( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_156( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_157( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_158( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_159( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_160( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_161( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_162( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_163( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_164( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_165( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_166( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_167( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_168( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_169( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_170( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_171( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_172( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_173( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_174( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_175( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_176( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_177( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_178( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_179( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_180( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_181( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_182( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_183( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_184( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_185( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_186( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_187( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_188( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_189( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_190( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_191( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_192( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_193( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_194( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_195( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_196( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_197( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_198( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_199( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_200( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_201( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_202( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_203( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_204( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_205( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_206( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_207( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_208( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_209( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_210( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_211( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_212( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_213( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_214( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_215( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_216( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_217( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_218( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_219( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_220( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_221( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_222( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_223( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_224( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_225( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_226( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_227( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_228( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_229( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_230( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_231( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_232( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * ecom_gec_ISE_c::ccom_ec_pointed_interface_234( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert PART_COMPARABLE_2_INTERFACE to ecom_ISE_Reflection_EiffelComponents::PartComparable_2 *.
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
		((ecom_ISE_Reflection_EiffelComponents::PartComparable_2 *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_239( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_240( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_241( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_242( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_243( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_ISE_Reflection_EiffelComponents::_ExportClause * ecom_gec_ISE_c::ccom_ec_pointed_interface_248( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_EXPORT_CLAUSE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_ExportClause *.
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
		((ecom_ISE_Reflection_EiffelComponents::_ExportClause *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_ExportClause * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_ExportClause * * ecom_gec_ISE_c::ccom_ec_pointed_cell_249( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_ExportClause * * old )

/*-----------------------------------------------------------
	Convert CELL [X_EXPORT_CLAUSE_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_ExportClause * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_ExportClause * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_ExportClause * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_ExportClause *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_248 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * ecom_gec_ISE_c::ccom_ec_pointed_interface_251( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_NAMED_SIGNATURE_TYPE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType *.
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
		((ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * * ecom_gec_ISE_c::ccom_ec_pointed_cell_252( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * * old )

/*-----------------------------------------------------------
	Convert CELL [X_NAMED_SIGNATURE_TYPE_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_251 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_SelectClause * ecom_gec_ISE_c::ccom_ec_pointed_interface_254( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_SELECT_CLAUSE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_SelectClause *.
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
		((ecom_ISE_Reflection_EiffelComponents::_SelectClause *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_SelectClause * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_SelectClause * * ecom_gec_ISE_c::ccom_ec_pointed_cell_255( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_SelectClause * * old )

/*-----------------------------------------------------------
	Convert CELL [X_SELECT_CLAUSE_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_SelectClause * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_SelectClause * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_SelectClause * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_SelectClause *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_254 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * ecom_gec_ISE_c::ccom_ec_pointed_interface_257( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_FORMAL_NAMED_SIGNATURE_TYPE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType *.
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
		((ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * * ecom_gec_ISE_c::ccom_ec_pointed_cell_258( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * * old )

/*-----------------------------------------------------------
	Convert CELL [X_FORMAL_NAMED_SIGNATURE_TYPE_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_257 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_RenameClause * ecom_gec_ISE_c::ccom_ec_pointed_interface_260( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_RENAME_CLAUSE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_RenameClause *.
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
		((ecom_ISE_Reflection_EiffelComponents::_RenameClause *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_RenameClause * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_RenameClause * * ecom_gec_ISE_c::ccom_ec_pointed_cell_261( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_RenameClause * * old )

/*-----------------------------------------------------------
	Convert CELL [X_RENAME_CLAUSE_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_RenameClause * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_RenameClause * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_RenameClause * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_RenameClause *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_260 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_RedefineClause * ecom_gec_ISE_c::ccom_ec_pointed_interface_263( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_REDEFINE_CLAUSE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_RedefineClause *.
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
		((ecom_ISE_Reflection_EiffelComponents::_RedefineClause *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_RedefineClause * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_RedefineClause * * ecom_gec_ISE_c::ccom_ec_pointed_cell_264( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_RedefineClause * * old )

/*-----------------------------------------------------------
	Convert CELL [X_REDEFINE_CLAUSE_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_RedefineClause * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_RedefineClause * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_RedefineClause * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_RedefineClause *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_263 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_UndefineClause * ecom_gec_ISE_c::ccom_ec_pointed_interface_266( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_UNDEFINE_CLAUSE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_UndefineClause *.
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
		((ecom_ISE_Reflection_EiffelComponents::_UndefineClause *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_UndefineClause * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_UndefineClause * * ecom_gec_ISE_c::ccom_ec_pointed_cell_267( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_UndefineClause * * old )

/*-----------------------------------------------------------
	Convert CELL [X_UNDEFINE_CLAUSE_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_UndefineClause * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_UndefineClause * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_UndefineClause * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_UndefineClause *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_266 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * ecom_gec_ISE_c::ccom_ec_pointed_interface_269( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_EIFFEL_ASSEMBLY_FACTORY_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory *.
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
		((ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * * ecom_gec_ISE_c::ccom_ec_pointed_cell_270( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * * old )

/*-----------------------------------------------------------
	Convert CELL [X_EIFFEL_ASSEMBLY_FACTORY_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_269 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_271( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_274( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_275( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_276( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_277( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_278( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_279( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_280( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_281( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_283( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_284( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_285( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_286( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_287( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_288( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_290( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_292( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_293( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_297( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_298( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_299( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_300( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_301( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_302( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_303( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_304( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_305( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_306( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_307( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_308( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_309( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_313( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_314( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_315( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_316( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_317( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_318( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_322( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_326( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_327( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_328( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_330( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_331( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * * ecom_gec_ISE_c::ccom_ec_pointed_cell_332( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * * old )

/*-----------------------------------------------------------
	Convert CELL [X_EIFFEL_FEATURE_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_EiffelFeature * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_EiffelFeature *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_110 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor * ecom_gec_ISE_c::ccom_ec_pointed_interface_335( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_ASSEMBLY_DESCRIPTOR_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor *.
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
		((ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_336( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_337( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_340( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_341( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_343( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

SAFEARRAY *  * ecom_gec_ISE_c::ccom_ec_pointed_cell_347( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [ECOM_VARIANT]] to SAFEARRAY *  *.
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
		*result = rt_ec.ccom_ec_safearray_variant (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_Parent * ecom_gec_ISE_c::ccom_ec_pointed_interface_349( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_PARENT_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_Parent *.
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
		((ecom_ISE_Reflection_EiffelComponents::_Parent *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_Parent * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_350( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_351( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

SAFEARRAY *  * ecom_gec_ISE_c::ccom_ec_pointed_cell_353( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [ECOM_VARIANT]] to SAFEARRAY *  *.
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
		*result = rt_ec.ccom_ec_safearray_variant (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_355( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_361( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor * * ecom_gec_ISE_c::ccom_ec_pointed_cell_368( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor * * old )

/*-----------------------------------------------------------
	Convert CELL [X_ASSEMBLY_DESCRIPTOR_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_AssemblyDescriptor *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_335 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_369( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_371( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_372( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_373( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_375( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_376( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_378( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_379( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_380( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_381( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_383( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

SAFEARRAY *  * ecom_gec_ISE_c::ccom_ec_pointed_cell_385( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [ECOM_VARIANT]] to SAFEARRAY *  *.
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
		*result = rt_ec.ccom_ec_safearray_variant (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_387( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_388( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

SAFEARRAY *  * ecom_gec_ISE_c::ccom_ec_pointed_cell_390( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [ECOM_VARIANT]] to SAFEARRAY *  *.
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
		*result = rt_ec.ccom_ec_safearray_variant (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_393( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_395( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_397( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_402( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_403( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_408( EIF_REFERENCE eif_ref, BSTR * old )

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

ecom_ISE_Reflection_EiffelComponents::_SignatureType * ecom_gec_ISE_c::ccom_ec_pointed_interface_410( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_SIGNATURE_TYPE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::_SignatureType *.
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
		((ecom_ISE_Reflection_EiffelComponents::_SignatureType *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::_SignatureType * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::_SignatureType * * ecom_gec_ISE_c::ccom_ec_pointed_cell_411( EIF_REFERENCE eif_ref, ecom_ISE_Reflection_EiffelComponents::_SignatureType * * old )

/*-----------------------------------------------------------
	Convert CELL [X_SIGNATURE_TYPE_INTERFACE] to ecom_ISE_Reflection_EiffelComponents::_SignatureType * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_ISE_Reflection_EiffelComponents::_SignatureType * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_ISE_Reflection_EiffelComponents::_SignatureType * *) CoTaskMemAlloc (sizeof (ecom_ISE_Reflection_EiffelComponents::_SignatureType *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = ccom_ec_pointed_interface_410 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_412( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

SAFEARRAY *  * ecom_gec_ISE_c::ccom_ec_pointed_cell_416( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [ECOM_VARIANT]] to SAFEARRAY *  *.
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
		*result = rt_ec.ccom_ec_safearray_variant (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_419( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_420( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_424( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_EiffelComponents::INamedSignatureType * ecom_gec_ISE_c::ccom_ec_pointed_interface_426( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert INAMED_SIGNATURE_TYPE_INTERFACE to ecom_ISE_Reflection_EiffelComponents::INamedSignatureType *.
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
		((ecom_ISE_Reflection_EiffelComponents::INamedSignatureType *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return  (ecom_ISE_Reflection_EiffelComponents::INamedSignatureType * ) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_428( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_429( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_434( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_435( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_440( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_441( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_445( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_446( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_450( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_451( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_452( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_453( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_454( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_455( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_456( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_460( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_461( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_462( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_463( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_464( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_465( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_466( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_467( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_468( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_472( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_473( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_474( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_475( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_476( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_477( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_478( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_479( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_480( EIF_REFERENCE eif_ref, BSTR * old )

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

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_481( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_482( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IDispatch * * ecom_gec_ISE_c::ccom_ec_pointed_cell_483( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IDispatch * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_dispatch (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_484( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_488( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_489( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_490( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_491( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_492( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_493( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_497( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_498( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_499( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_500( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_501( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_502( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_506( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_507( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_508( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_509( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_510( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_511( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_512( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_513( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_514( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_515( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_519( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_520( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_521( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_522( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_523( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_524( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_527( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_528( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_529( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_530( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_531( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_532( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_533( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_537( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_538( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_539( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_540( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_541( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_542( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_543( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_544( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_545( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_546( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_547( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_548( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_549( EIF_REFERENCE eif_ref, BSTR * old )

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

SAFEARRAY *  * ecom_gec_ISE_c::ccom_ec_pointed_cell_554( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [ECOM_VARIANT]] to SAFEARRAY *  *.
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
		*result = rt_ec.ccom_ec_safearray_variant (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

SAFEARRAY *  * ecom_gec_ISE_c::ccom_ec_pointed_cell_556( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [ECOM_VARIANT]] to SAFEARRAY *  *.
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
		*result = rt_ec.ccom_ec_safearray_variant (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_558( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_562( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_563( EIF_REFERENCE eif_ref, BSTR * old )

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

SAFEARRAY *  * ecom_gec_ISE_c::ccom_ec_pointed_cell_565( EIF_REFERENCE eif_ref, SAFEARRAY *  * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [ECOM_VARIANT]] to SAFEARRAY *  *.
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
		*result = rt_ec.ccom_ec_safearray_variant (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_567( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_568( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_572( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_573( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_574( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_575( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_576( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_577( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_580( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_584( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_585( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_586( EIF_REFERENCE eif_ref, BSTR * old )

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

BSTR * ecom_gec_ISE_c::ccom_ec_pointed_cell_587( EIF_REFERENCE eif_ref, BSTR * old )

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