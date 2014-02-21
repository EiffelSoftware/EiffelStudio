/*-----------------------------------------------------------
Implemented `IScheduledWorkItem' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ISCHEDULEDWORKITEM_IMPL_PROXY_H__
#define __ECOM_MS_TASKSCHED_LIB_ISCHEDULEDWORKITEM_IMPL_PROXY_H__

#include "decl_ecom_MS_TaskSched_lib_IScheduledWorkItem_impl_proxy.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_IScheduledWorkItem.h"

#include "decl_ecom_MS_TaskSched_lib_ITaskTrigger.h"

#include "ecom_MS_TaskSched_lib__SYSTEMTIME.h"

#include "ecom_aliases.h"

namespace ecom_MS_TaskSched_lib
{
class IScheduledWorkItem_impl_proxy
{
public:
	IScheduledWorkItem_impl_proxy (IUnknown * a_pointer);
	virtual ~IScheduledWorkItem_impl_proxy ();

	/*-----------------------------------------------------------
	Creates a trigger using a work item object.
	-----------------------------------------------------------*/
	void ccom_create_trigger(  /* [out] */ EIF_OBJECT pi_new_trigger,  /* [out] */ EIF_OBJECT pp_trigger );


	/*-----------------------------------------------------------
	Deletes a trigger from a work item. 
	-----------------------------------------------------------*/
	void ccom_delete_trigger(  /* [in] */ EIF_INTEGER i_trigger );


	/*-----------------------------------------------------------
	Retrieves the number of triggers associated with a work item.
	-----------------------------------------------------------*/
	void ccom_get_trigger_count(  /* [out] */ EIF_OBJECT pw_count );


	/*-----------------------------------------------------------
	Retrieves a trigger structure.
	-----------------------------------------------------------*/
	void ccom_get_trigger(  /* [in] */ EIF_INTEGER i_trigger,  /* [out] */ EIF_OBJECT pp_trigger );


	/*-----------------------------------------------------------
	Retrieves a trigger string.
	-----------------------------------------------------------*/
	void ccom_get_trigger_string(  /* [in] */ EIF_INTEGER i_trigger,  /* [out] */ EIF_OBJECT ppwsz_trigger );


	/*-----------------------------------------------------------
	Retrieves the work item run times for a specified time period.
	-----------------------------------------------------------*/
	void ccom_get_run_times(  /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_begin,  /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_end,  /* [in, out] */ EIF_OBJECT p_count,  /* [out] */ EIF_OBJECT rgst_task_times );


	/*-----------------------------------------------------------
	Retrieves the next time the work item will run.
	-----------------------------------------------------------*/
	void ccom_get_next_run_time(  /* [in, out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_next_run );


	/*-----------------------------------------------------------
	Sets the idle wait time for the work item.
	-----------------------------------------------------------*/
	void ccom_set_idle_wait(  /* [in] */ EIF_INTEGER w_idle_minutes,  /* [in] */ EIF_INTEGER w_deadline_minutes );


	/*-----------------------------------------------------------
	Retrieves the idle wait time for the work item.
	-----------------------------------------------------------*/
	void ccom_get_idle_wait(  /* [out] */ EIF_OBJECT pw_idle_minutes,  /* [out] */ EIF_OBJECT pw_deadline_minutes );


	/*-----------------------------------------------------------
	Runs the work item.
	-----------------------------------------------------------*/
	void ccom_run();


	/*-----------------------------------------------------------
	Ends the execution of the work item.
	-----------------------------------------------------------*/
	void ccom_terminate();


	/*-----------------------------------------------------------
	Opens the configuration properties for the work item.
	-----------------------------------------------------------*/
	void ccom_edit_work_item(  /* [in] */ EIF_POINTER h_parent,  /* [in] */ EIF_INTEGER dw_reserved );


	/*-----------------------------------------------------------
	Retrieves the most recent time the work item began running.
	-----------------------------------------------------------*/
	void ccom_get_most_recent_run_time(  /* [out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_last_run );


	/*-----------------------------------------------------------
	Retrieves the status of the work item.
	-----------------------------------------------------------*/
	void ccom_get_status(  /* [out] */ EIF_OBJECT phr_status );


	/*-----------------------------------------------------------
	Retrieves the work item's last exit code.
	-----------------------------------------------------------*/
	void ccom_get_exit_code(  /* [out] */ EIF_OBJECT pdw_exit_code );


	/*-----------------------------------------------------------
	Sets the comment for the work item.
	-----------------------------------------------------------*/
	void ccom_set_comment(  /* [in] */ EIF_OBJECT pwsz_comment );


	/*-----------------------------------------------------------
	Retrieves the comment for the work item.
	-----------------------------------------------------------*/
	void ccom_get_comment(  /* [out] */ EIF_OBJECT ppwsz_comment );


	/*-----------------------------------------------------------
	Sets the creator of the work item.
	-----------------------------------------------------------*/
	void ccom_set_creator(  /* [in] */ EIF_OBJECT pwsz_creator );


	/*-----------------------------------------------------------
	Retrieves the creator of the work item.
	-----------------------------------------------------------*/
	void ccom_get_creator(  /* [out] */ EIF_OBJECT ppwsz_creator );


	/*-----------------------------------------------------------
	Stores application-defined data associated with the work item.
	-----------------------------------------------------------*/
	void ccom_set_work_item_data(  /* [in] */ EIF_INTEGER cb_data,  /* [in] */ EIF_OBJECT rgb_data );


	/*-----------------------------------------------------------
	Retrieves application-defined data associated with the work item.
	-----------------------------------------------------------*/
	void ccom_get_work_item_data(  /* [out] */ EIF_OBJECT pcb_data,  /* [out] */ EIF_OBJECT prgb_data );


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	void ccom_set_error_retry_count(  /* [in] */ EIF_INTEGER w_retry_count );


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	void ccom_get_error_retry_count(  /* [out] */ EIF_OBJECT pw_retry_count );


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	void ccom_set_error_retry_interval(  /* [in] */ EIF_INTEGER w_retry_interval );


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	void ccom_get_error_retry_interval(  /* [out] */ EIF_OBJECT pw_retry_interval );


	/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the work item.
	-----------------------------------------------------------*/
	void ccom_set_flags(  /* [in] */ EIF_INTEGER dw_flags );


	/*-----------------------------------------------------------
	Retrieves the flags that modify the behavior of the work item.
	-----------------------------------------------------------*/
	void ccom_get_flags(  /* [out] */ EIF_OBJECT pdw_flags );


	/*-----------------------------------------------------------
	Sets the account name and password for the work item.
	-----------------------------------------------------------*/
	void ccom_set_account_information(  /* [in] */ EIF_OBJECT pwsz_account_name,  /* [in] */ EIF_OBJECT pwsz_password );


	/*-----------------------------------------------------------
	Retrieves the account name for the work item.
	-----------------------------------------------------------*/
	void ccom_get_account_information(  /* [out] */ EIF_OBJECT ppwsz_account_name );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IScheduledWorkItem * p_IScheduledWorkItem;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}

#endif
