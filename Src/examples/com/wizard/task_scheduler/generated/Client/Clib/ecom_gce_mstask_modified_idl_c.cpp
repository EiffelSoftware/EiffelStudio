/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_gce_mstask_modified_idl_c.h"
ecom_gce_mstask_modified_idl_c grt_ce_mstask_modified_idl_c;

ecom_gce_mstask_modified_idl_c::ecom_gce_mstask_modified_idl_c(  )
{

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_1( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_interface_3( ecom_MS_TaskSched_lib::ITaskTrigger * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::ITaskTrigger * to ITASK_TRIGGER_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ITASK_TRIGGER_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_4( ecom_MS_TaskSched_lib::ITaskTrigger * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::ITaskTrigger * * to CELL [ITASK_TRIGGER_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ITASK_TRIGGER_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_MS_TaskSched_lib::ITaskTrigger * *) a_pointer != NULL)
		tmp_object = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_interface_3 (*(ecom_MS_TaskSched_lib::ITaskTrigger * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_4( ecom_MS_TaskSched_lib::ITaskTrigger * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_MS_TaskSched_lib::ITaskTrigger * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_5( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_6( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_6( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_record_x_systemtime_record7( ecom_MS_TaskSched_lib::_SYSTEMTIME a_record )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_SYSTEMTIME to X_SYSTEMTIME_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_SYSTEMTIME_RECORD", sizeof (ecom_MS_TaskSched_lib::_SYSTEMTIME));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_record_8( ecom_MS_TaskSched_lib::_SYSTEMTIME * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_SYSTEMTIME * to X_SYSTEMTIME_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_SYSTEMTIME_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_9( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_10( ecom_MS_TaskSched_lib::_SYSTEMTIME * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_SYSTEMTIME * * to CELL [X_SYSTEMTIME_RECORD].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [X_SYSTEMTIME_RECORD]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_MS_TaskSched_lib::_SYSTEMTIME * *) a_pointer != NULL)
		tmp_object = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_8 (*(ecom_MS_TaskSched_lib::_SYSTEMTIME * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_10( ecom_MS_TaskSched_lib::_SYSTEMTIME * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_MS_TaskSched_lib::_SYSTEMTIME * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_11( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_12( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_15( void * a_pointer )

/*-----------------------------------------------------------
	Free memory of void *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::free_memory_13( ecom_MS_TaskSched_lib::wireHWND a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_MS_TaskSched_lib::wireHWND.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_16( HRESULT * a_pointer )

/*-----------------------------------------------------------
	Free memory of HRESULT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_17( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_18( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_18( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_19( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_19( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_20( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_21( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_22( UCHAR * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_23( UCHAR * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert UCHAR * * to CELL [CHARACTER_REF].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [CHARACTER_REF]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(UCHAR * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unsigned_character (*(UCHAR * *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_23( UCHAR * * a_pointer )

/*-----------------------------------------------------------
	Free memory of UCHAR * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_22 (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_24( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_25( USHORT * a_pointer )

/*-----------------------------------------------------------
	Free memory of USHORT *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_26( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_27( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_27( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_28( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_28( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_29( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_29( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_30( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_30( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_31( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_32( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_33( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_35( void * a_pointer )

/*-----------------------------------------------------------
	Free memory of void *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_36( void * * a_pointer )

/*-----------------------------------------------------------
	Free memory of void * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_record_ecom_guid37( GUID a_record )

/*-----------------------------------------------------------
	Convert GUID to ECOM_GUID.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "ECOM_GUID", sizeof (GUID));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_record_38( GUID * a_record_pointer )

/*-----------------------------------------------------------
	Convert GUID * to ECOM_GUID.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "ECOM_GUID");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_39( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_39( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_record_x_task_trigger_record41( ecom_MS_TaskSched_lib::_TASK_TRIGGER a_record )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_TASK_TRIGGER to X_TASK_TRIGGER_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_TASK_TRIGGER_RECORD", sizeof (ecom_MS_TaskSched_lib::_TASK_TRIGGER));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_record_42( ecom_MS_TaskSched_lib::_TASK_TRIGGER * a_record_pointer )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_TASK_TRIGGER * to X_TASK_TRIGGER_RECORD.
-----------------------------------------------------------*/
{
	if (a_record_pointer != NULL)
		return rt_ce.ccom_ce_pointed_record (a_record_pointer, "X_TASK_TRIGGER_RECORD");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_alias_ptask_trigger_alias40( ecom_MS_TaskSched_lib::PTASK_TRIGGER an_alias )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::PTASK_TRIGGER to PTASK_TRIGGER_ALIAS.
-----------------------------------------------------------*/
{
EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_OBJECT result = 0;

	type_id = eif_type_id ("PTASK_TRIGGER_ALIAS");
	result = eif_create (type_id);
	make = eif_procedure ("make_from_alias", type_id);

	make (eif_access (result), grt_ce_mstask_modified_idl_c.ccom_ce_pointed_record_42 (an_alias));

	return eif_wean (result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_43( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_43( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_record_x_trigger_type_union_union45( ecom_MS_TaskSched_lib::_TRIGGER_TYPE_UNION a_record )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_TRIGGER_TYPE_UNION to X_TRIGGER_TYPE_UNION_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_TRIGGER_TYPE_UNION_UNION", sizeof (ecom_MS_TaskSched_lib::_TRIGGER_TYPE_UNION));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_record_x_monthlydow_record46( ecom_MS_TaskSched_lib::_MONTHLYDOW a_record )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_MONTHLYDOW to X_MONTHLYDOW_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_MONTHLYDOW_RECORD", sizeof (ecom_MS_TaskSched_lib::_MONTHLYDOW));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_record_x_monthlydate_record47( ecom_MS_TaskSched_lib::_MONTHLYDATE a_record )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_MONTHLYDATE to X_MONTHLYDATE_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_MONTHLYDATE_RECORD", sizeof (ecom_MS_TaskSched_lib::_MONTHLYDATE));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_record_x_weekly_record48( ecom_MS_TaskSched_lib::_WEEKLY a_record )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_WEEKLY to X_WEEKLY_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_WEEKLY_RECORD", sizeof (ecom_MS_TaskSched_lib::_WEEKLY));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_record_x_daily_record49( ecom_MS_TaskSched_lib::_DAILY a_record )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::_DAILY to X_DAILY_RECORD.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X_DAILY_RECORD", sizeof (ecom_MS_TaskSched_lib::_DAILY));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_record_x__midl_iwin_types_0009_union53( ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009 a_record )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009 to X__MIDL_IWIN_TYPES_0009_UNION.
-----------------------------------------------------------*/
{
	return rt_ce.ccom_ce_record (&a_record, "X__MIDL_IWIN_TYPES_0009_UNION", sizeof (ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009));
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_54( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_54( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_interface_56( ecom_MS_TaskSched_lib::IEnumWorkItems * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::IEnumWorkItems * to IENUM_WORK_ITEMS_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IENUM_WORK_ITEMS_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_57( ecom_MS_TaskSched_lib::IEnumWorkItems * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::IEnumWorkItems * * to CELL [IENUM_WORK_ITEMS_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [IENUM_WORK_ITEMS_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(ecom_MS_TaskSched_lib::IEnumWorkItems * *) a_pointer != NULL)
		tmp_object = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_interface_56 (*(ecom_MS_TaskSched_lib::IEnumWorkItems * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_57( ecom_MS_TaskSched_lib::IEnumWorkItems * * a_pointer )

/*-----------------------------------------------------------
	Free memory of ecom_MS_TaskSched_lib::IEnumWorkItems * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_58( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * * to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_58( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_59( IUnknown * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert IUnknown * * to CELL [ECOM_INTERFACE].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [ECOM_INTERFACE]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(IUnknown * *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (*(IUnknown * *) a_pointer));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_59( IUnknown * * a_pointer )

/*-----------------------------------------------------------
	Free memory of IUnknown * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_interface_61( ecom_MS_TaskSched_lib::IScheduledWorkItem * a_interface_pointer )

/*-----------------------------------------------------------
	Convert ecom_MS_TaskSched_lib::IScheduledWorkItem * to ISCHEDULED_WORK_ITEM_INTERFACE.
-----------------------------------------------------------*/
{
	if (a_interface_pointer != NULL)
		return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "ISCHEDULED_WORK_ITEM_IMPL_PROXY");
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_62( LPWSTR * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * to CELL [STRING].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [STRING]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR *) a_pointer != NULL)
		tmp_object = eif_protect (rt_ce.ccom_ce_lpwstr (*(LPWSTR *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_62( LPWSTR * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_gce_mstask_modified_idl_c::ccom_ce_pointed_cell_63( LPWSTR * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
	Convert LPWSTR * * to CELL [CELL [STRING]].
-----------------------------------------------------------*/
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;
	EIF_OBJECT tmp_object = 0;

	type_id = eif_type_id ("CELL [CELL [STRING]]");
	set_item = eif_procedure ("put", type_id);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		result = eif_create (type_id);
	}
	else
		result = an_object;
	if (*(LPWSTR * *) a_pointer != NULL)
		tmp_object = eif_protect (grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_62 (*(LPWSTR * *) a_pointer, NULL));
	set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
	if (tmp_object != NULL)
		eif_wean (tmp_object);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_63( LPWSTR * * a_pointer )

/*-----------------------------------------------------------
	Free memory of LPWSTR * *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
	{
		grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_62 (*a_pointer);
		*a_pointer = NULL;
		CoTaskMemFree (a_pointer);
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_gce_mstask_modified_idl_c::ccom_free_memory_pointed_64( ULONG * a_pointer )

/*-----------------------------------------------------------
	Free memory of ULONG *.
-----------------------------------------------------------*/
{
	if (a_pointer != NULL)
		CoTaskMemFree (a_pointer);
};
/*----------------------------------------------------------------------------------------------------------------------*/


