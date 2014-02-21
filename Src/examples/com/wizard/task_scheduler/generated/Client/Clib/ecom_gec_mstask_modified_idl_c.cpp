/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_gec_mstask_modified_idl_c.h"
ecom_gec_mstask_modified_idl_c grt_ec_mstask_modified_idl_c;

ecom_gec_mstask_modified_idl_c::ecom_gec_mstask_modified_idl_c(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::ITaskTrigger * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_interface_3( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ITASK_TRIGGER_INTERFACE to ecom_MS_TaskSched_lib::ITaskTrigger *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_MS_TaskSched_lib::ITaskTrigger *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return (ecom_MS_TaskSched_lib::ITaskTrigger *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::ITaskTrigger * * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_4( EIF_REFERENCE eif_ref, ecom_MS_TaskSched_lib::ITaskTrigger * * old )

/*-----------------------------------------------------------
	Convert CELL [ITASK_TRIGGER_INTERFACE] to ecom_MS_TaskSched_lib::ITaskTrigger * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_MS_TaskSched_lib::ITaskTrigger * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_MS_TaskSched_lib::ITaskTrigger * *) CoTaskMemAlloc (sizeof (ecom_MS_TaskSched_lib::ITaskTrigger *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = grt_ec_mstask_modified_idl_c.ccom_ec_pointed_interface_3 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_6( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_SYSTEMTIME ecom_gec_mstask_modified_idl_c::ccom_ec_record_x_systemtime_record7( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_SYSTEMTIME_RECORD to ecom_MS_TaskSched_lib::_SYSTEMTIME.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	return * (ecom_MS_TaskSched_lib::_SYSTEMTIME *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_SYSTEMTIME * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_record_8( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_SYSTEMTIME_RECORD to ecom_MS_TaskSched_lib::_SYSTEMTIME *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_SYSTEMTIME_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return (ecom_MS_TaskSched_lib::_SYSTEMTIME *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_SYSTEMTIME * * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_10( EIF_REFERENCE eif_ref, ecom_MS_TaskSched_lib::_SYSTEMTIME * * old )

/*-----------------------------------------------------------
	Convert CELL [X_SYSTEMTIME_RECORD] to ecom_MS_TaskSched_lib::_SYSTEMTIME * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_MS_TaskSched_lib::_SYSTEMTIME * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_MS_TaskSched_lib::_SYSTEMTIME * *) CoTaskMemAlloc (sizeof (ecom_MS_TaskSched_lib::_SYSTEMTIME *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = grt_ec_mstask_modified_idl_c.ccom_ec_pointed_record_8 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_18( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_19( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

UCHAR * * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_23( EIF_REFERENCE eif_ref, UCHAR * * old )

/*-----------------------------------------------------------
	Convert CELL [CHARACTER_REF] to UCHAR * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	UCHAR * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (UCHAR * *) CoTaskMemAlloc (sizeof (UCHAR *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_22(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_pointed_unsigned_character (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_27( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_28( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_29( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_30( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

GUID ecom_gec_mstask_modified_idl_c::ccom_ec_record_ecom_guid37( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_GUID to GUID.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	return * (GUID *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

GUID * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_record_38( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ECOM_GUID to GUID *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("ECOM_GUID");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return (GUID *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_39( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_TASK_TRIGGER ecom_gec_mstask_modified_idl_c::ccom_ec_record_x_task_trigger_record41( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_TASK_TRIGGER_RECORD to ecom_MS_TaskSched_lib::_TASK_TRIGGER.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	return * (ecom_MS_TaskSched_lib::_TASK_TRIGGER *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_TASK_TRIGGER * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_record_42( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_TASK_TRIGGER_RECORD to ecom_MS_TaskSched_lib::_TASK_TRIGGER *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_TASK_TRIGGER_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return (ecom_MS_TaskSched_lib::_TASK_TRIGGER *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::PTASK_TRIGGER ecom_gec_mstask_modified_idl_c::ccom_ec_alias_ptask_trigger_alias40( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert PTASK_TRIGGER_ALIAS to ecom_MS_TaskSched_lib::PTASK_TRIGGER.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		
		EIF_TYPE_ID type_id = eif_type_id ("X_TASK_TRIGGER_RECORD");
		EIF_PROCEDURE set_shared =  eif_procedure ("set_shared", type_id);
		(FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (eif_object));
		eif_wean (eif_object);
	}
	return (ecom_MS_TaskSched_lib::_TASK_TRIGGER *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_43( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_TRIGGER_TYPE_UNION ecom_gec_mstask_modified_idl_c::ccom_ec_record_x_trigger_type_union_union45( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_TRIGGER_TYPE_UNION_UNION to ecom_MS_TaskSched_lib::_TRIGGER_TYPE_UNION.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	return * (ecom_MS_TaskSched_lib::_TRIGGER_TYPE_UNION *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_MONTHLYDOW ecom_gec_mstask_modified_idl_c::ccom_ec_record_x_monthlydow_record46( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_MONTHLYDOW_RECORD to ecom_MS_TaskSched_lib::_MONTHLYDOW.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	return * (ecom_MS_TaskSched_lib::_MONTHLYDOW *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_MONTHLYDATE ecom_gec_mstask_modified_idl_c::ccom_ec_record_x_monthlydate_record47( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_MONTHLYDATE_RECORD to ecom_MS_TaskSched_lib::_MONTHLYDATE.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	return * (ecom_MS_TaskSched_lib::_MONTHLYDATE *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_WEEKLY ecom_gec_mstask_modified_idl_c::ccom_ec_record_x_weekly_record48( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_WEEKLY_RECORD to ecom_MS_TaskSched_lib::_WEEKLY.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	return * (ecom_MS_TaskSched_lib::_WEEKLY *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::_DAILY ecom_gec_mstask_modified_idl_c::ccom_ec_record_x_daily_record49( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X_DAILY_RECORD to ecom_MS_TaskSched_lib::_DAILY.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	return * (ecom_MS_TaskSched_lib::_DAILY *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009 ecom_gec_mstask_modified_idl_c::ccom_ec_record_x__midl_iwin_types_0009_union53( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert X__MIDL_IWIN_TYPES_0009_UNION to ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	eif_object = eif_protect (eif_ref);
	a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	return * (ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009 *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_54( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IEnumWorkItems * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_interface_56( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert IENUM_WORK_ITEMS_INTERFACE to ecom_MS_TaskSched_lib::IEnumWorkItems *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_MS_TaskSched_lib::IEnumWorkItems *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return (ecom_MS_TaskSched_lib::IEnumWorkItems *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IEnumWorkItems * * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_57( EIF_REFERENCE eif_ref, ecom_MS_TaskSched_lib::IEnumWorkItems * * old )

/*-----------------------------------------------------------
	Convert CELL [IENUM_WORK_ITEMS_INTERFACE] to ecom_MS_TaskSched_lib::IEnumWorkItems * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	ecom_MS_TaskSched_lib::IEnumWorkItems * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (ecom_MS_TaskSched_lib::IEnumWorkItems * *) CoTaskMemAlloc (sizeof (ecom_MS_TaskSched_lib::IEnumWorkItems *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = grt_ec_mstask_modified_idl_c.ccom_ec_pointed_interface_56 (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_58( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

IUnknown * * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_59( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	IUnknown * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_unknown (cell_item);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IScheduledWorkItem * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_interface_61( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
	Convert ISCHEDULED_WORK_ITEM_INTERFACE to ecom_MS_TaskSched_lib::IScheduledWorkItem *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	EIF_POINTER a_pointer = 0;

	if (eif_ref != NULL)
	{
		eif_object = eif_protect (eif_ref);
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		if (a_pointer == NULL)
		{
		EIF_PROCEDURE create_item = 0;
			EIF_TYPE_ID type_id = eif_type (eif_object);
			create_item = eif_procedure ("create_item", type_id);
			(FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
		a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
		}
		((ecom_MS_TaskSched_lib::IScheduledWorkItem *) a_pointer)->AddRef ();
		eif_wean (eif_object);
	}
	return (ecom_MS_TaskSched_lib::IScheduledWorkItem *) a_pointer;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_62( EIF_REFERENCE eif_ref, LPWSTR * old )

/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR *) CoTaskMemAlloc (sizeof (LPWSTR));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (cell_item != NULL)
		*result = rt_ec.ccom_ec_lpwstr (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

LPWSTR * * ecom_gec_mstask_modified_idl_c::ccom_ec_pointed_cell_63( EIF_REFERENCE eif_ref, LPWSTR * * old )

/*-----------------------------------------------------------
	Convert CELL [CELL [STRING]] to LPWSTR * *.
-----------------------------------------------------------*/
{
	EIF_OBJECT eif_object = 0;
	LPWSTR * * result = 0;
	EIF_REFERENCE cell_item = 0;

	eif_object = eif_protect (eif_ref);
	if (old != NULL)
		result = old;
	else
		result = (LPWSTR * *) CoTaskMemAlloc (sizeof (LPWSTR *));
	cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
	if (*result != NULL)
	{
		grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_62(*result);
		*result = NULL;
	}
	if (cell_item != NULL)
		*result = grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_62 (cell_item, NULL);
	eif_wean (eif_object);
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/


