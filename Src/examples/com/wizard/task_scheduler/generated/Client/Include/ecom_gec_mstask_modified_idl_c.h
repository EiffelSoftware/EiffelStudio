/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GEC_MSTASK_MODIFIED_IDL_C_H__
#define __ECOM_GEC_MSTASK_MODIFIED_IDL_C_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_rt_globals.h"

#include "ecom_aliases.h"

#include "ecom_MS_TaskSched_lib_ITaskTrigger.h"

#include "ecom_MS_TaskSched_lib__SYSTEMTIME.h"

#include "ecom_MS_TaskSched_lib__TASK_TRIGGER.h"

#include "ecom_MS_TaskSched_lib__TRIGGER_TYPE_UNION.h"

#include "ecom_MS_TaskSched_lib__MONTHLYDOW.h"

#include "ecom_MS_TaskSched_lib__MONTHLYDATE.h"

#include "ecom_MS_TaskSched_lib__WEEKLY.h"

#include "ecom_MS_TaskSched_lib__DAILY.h"

#include "ecom_MS_TaskSched_lib___MIDL_IWinTypes_0009.h"

#include "ecom_MS_TaskSched_lib_IEnumWorkItems.h"

#include "ecom_MS_TaskSched_lib_IScheduledWorkItem.h"

class ecom_gec_mstask_modified_idl_c
{
public:
	ecom_gec_mstask_modified_idl_c ();
	virtual ~ecom_gec_mstask_modified_idl_c () {};

	/*-----------------------------------------------------------
	Convert ITASK_TRIGGER_INTERFACE to ecom_MS_TaskSched_lib::ITaskTrigger *.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::ITaskTrigger * ccom_ec_pointed_interface_3( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [ITASK_TRIGGER_INTERFACE] to ecom_MS_TaskSched_lib::ITaskTrigger * *.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::ITaskTrigger * * ccom_ec_pointed_cell_4( EIF_REFERENCE eif_ref, ecom_MS_TaskSched_lib::ITaskTrigger * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_6( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert X_SYSTEMTIME_RECORD to ecom_MS_TaskSched_lib::_SYSTEMTIME.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_SYSTEMTIME ccom_ec_record_x_systemtime_record7( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert X_SYSTEMTIME_RECORD to ecom_MS_TaskSched_lib::_SYSTEMTIME *.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_SYSTEMTIME * ccom_ec_pointed_record_8( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [X_SYSTEMTIME_RECORD] to ecom_MS_TaskSched_lib::_SYSTEMTIME * *.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_SYSTEMTIME * * ccom_ec_pointed_cell_10( EIF_REFERENCE eif_ref, ecom_MS_TaskSched_lib::_SYSTEMTIME * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_18( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_19( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [CHARACTER_REF] to UCHAR * *.
	-----------------------------------------------------------*/
	UCHAR * * ccom_ec_pointed_cell_23( EIF_REFERENCE eif_ref, UCHAR * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_27( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_28( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_29( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_30( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert ECOM_GUID to GUID.
	-----------------------------------------------------------*/
	GUID ccom_ec_record_ecom_guid37( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert ECOM_GUID to GUID *.
	-----------------------------------------------------------*/
	GUID * ccom_ec_pointed_record_38( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_39( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert X_TASK_TRIGGER_RECORD to ecom_MS_TaskSched_lib::_TASK_TRIGGER.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_TASK_TRIGGER ccom_ec_record_x_task_trigger_record41( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert X_TASK_TRIGGER_RECORD to ecom_MS_TaskSched_lib::_TASK_TRIGGER *.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_TASK_TRIGGER * ccom_ec_pointed_record_42( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert PTASK_TRIGGER_ALIAS to ecom_MS_TaskSched_lib::PTASK_TRIGGER.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::PTASK_TRIGGER ccom_ec_alias_ptask_trigger_alias40( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_43( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert X_TRIGGER_TYPE_UNION_UNION to ecom_MS_TaskSched_lib::_TRIGGER_TYPE_UNION.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_TRIGGER_TYPE_UNION ccom_ec_record_x_trigger_type_union_union45( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert X_MONTHLYDOW_RECORD to ecom_MS_TaskSched_lib::_MONTHLYDOW.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_MONTHLYDOW ccom_ec_record_x_monthlydow_record46( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert X_MONTHLYDATE_RECORD to ecom_MS_TaskSched_lib::_MONTHLYDATE.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_MONTHLYDATE ccom_ec_record_x_monthlydate_record47( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert X_WEEKLY_RECORD to ecom_MS_TaskSched_lib::_WEEKLY.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_WEEKLY ccom_ec_record_x_weekly_record48( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert X_DAILY_RECORD to ecom_MS_TaskSched_lib::_DAILY.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::_DAILY ccom_ec_record_x_daily_record49( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert X__MIDL_IWIN_TYPES_0009_UNION to ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009 ccom_ec_record_x__midl_iwin_types_0009_union53( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_54( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_WORK_ITEMS_INTERFACE to ecom_MS_TaskSched_lib::IEnumWorkItems *.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IEnumWorkItems * ccom_ec_pointed_interface_56( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_WORK_ITEMS_INTERFACE] to ecom_MS_TaskSched_lib::IEnumWorkItems * *.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IEnumWorkItems * * ccom_ec_pointed_cell_57( EIF_REFERENCE eif_ref, ecom_MS_TaskSched_lib::IEnumWorkItems * * old );


	/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
	-----------------------------------------------------------*/
	IUnknown * * ccom_ec_pointed_cell_58( EIF_REFERENCE eif_ref, IUnknown * * old );


	/*-----------------------------------------------------------
	Convert CELL [ECOM_INTERFACE] to IUnknown * *.
	-----------------------------------------------------------*/
	IUnknown * * ccom_ec_pointed_cell_59( EIF_REFERENCE eif_ref, IUnknown * * old );


	/*-----------------------------------------------------------
	Convert ISCHEDULED_WORK_ITEM_INTERFACE to ecom_MS_TaskSched_lib::IScheduledWorkItem *.
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IScheduledWorkItem * ccom_ec_pointed_interface_61( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to LPWSTR *.
	-----------------------------------------------------------*/
	LPWSTR * ccom_ec_pointed_cell_62( EIF_REFERENCE eif_ref, LPWSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [CELL [STRING]] to LPWSTR * *.
	-----------------------------------------------------------*/
	LPWSTR * * ccom_ec_pointed_cell_63( EIF_REFERENCE eif_ref, LPWSTR * * old );



protected:


private:


};

#endif
