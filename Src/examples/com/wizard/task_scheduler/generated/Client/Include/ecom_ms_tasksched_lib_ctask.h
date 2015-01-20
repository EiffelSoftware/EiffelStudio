/*-----------------------------------------------------------
Task. Task Scheduler.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_CTASK_H__
#define __ECOM_MS_TASKSCHED_LIB_CTASK_H__

#include "decl_ecom_MS_TaskSched_lib_CTask.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_ITask.h"

#include "decl_ecom_MS_TaskSched_lib_ITaskTrigger.h"

#include "ecom_MS_TaskSched_lib__SYSTEMTIME.h"

#include "ecom_aliases.h"

#include "ecom_MS_TaskSched_lib_IProvideTaskPage.h"

#include "ecom_MS_TaskSched_lib_IPersistFile.h"

namespace ecom_MS_TaskSched_lib
{
class CTask
{
public:
	CTask (IUnknown * a_pointer);
	virtual ~CTask ();

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
	Assigns a specific application to the current task.
	-----------------------------------------------------------*/
	void ccom_set_application_name(  /* [in] */ EIF_OBJECT pwsz_application_name );


	/*-----------------------------------------------------------
	Retrieves the name of the application that the task is associated with.
	-----------------------------------------------------------*/
	void ccom_get_application_name(  /* [out] */ EIF_OBJECT ppwsz_application_name );


	/*-----------------------------------------------------------
	Sets the command-line parameters for the task.
	-----------------------------------------------------------*/
	void ccom_set_parameters(  /* [in] */ EIF_OBJECT pwsz_parameters );


	/*-----------------------------------------------------------
	Retrieves the command-line parameters of a task.
	-----------------------------------------------------------*/
	void ccom_get_parameters(  /* [out] */ EIF_OBJECT ppwsz_parameters );


	/*-----------------------------------------------------------
	Sets the working directory for the task.
	-----------------------------------------------------------*/
	void ccom_set_working_directory(  /* [in] */ EIF_OBJECT pwsz_working_directory );


	/*-----------------------------------------------------------
	Retrieves the working directory of the task.
	-----------------------------------------------------------*/
	void ccom_get_working_directory(  /* [out] */ EIF_OBJECT ppwsz_working_directory );


	/*-----------------------------------------------------------
	Sets the priority for the task.
	-----------------------------------------------------------*/
	void ccom_set_priority(  /* [in] */ EIF_INTEGER dw_priority );


	/*-----------------------------------------------------------
	Retrieves the priority for the task.
	-----------------------------------------------------------*/
	void ccom_get_priority(  /* [out] */ EIF_OBJECT pdw_priority );


	/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the task.
	-----------------------------------------------------------*/
	void ccom_set_task_flags(  /* [in] */ EIF_INTEGER dw_flags );


	/*-----------------------------------------------------------
	Returns the flags used to modify the behavior of the task.
	-----------------------------------------------------------*/
	void ccom_get_task_flags(  /* [out] */ EIF_OBJECT pdw_flags );


	/*-----------------------------------------------------------
	Sets the maximum length of time the task can run.
	-----------------------------------------------------------*/
	void ccom_set_max_run_time(  /* [in] */ EIF_INTEGER dw_max_run_time_ms );


	/*-----------------------------------------------------------
	Retrieves the maximum length of time the task can run.
	-----------------------------------------------------------*/
	void ccom_get_max_run_time(  /* [out] */ EIF_OBJECT pdw_max_run_time_ms );


	/*-----------------------------------------------------------
	Retrieves the property sheet pages associated with a task.
	-----------------------------------------------------------*/
	void ccom_get_page(  /* [in] */ EIF_INTEGER tp_type,  /* [in] */ EIF_INTEGER f_persist_changes,  /* [out] */ EIF_OBJECT ph_page );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_get_class_id(  /* [out] */ GUID * p_class_id );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_is_dirty();


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_load(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER dw_mode );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_save(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER f_remember );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_save_completed(  /* [in] */ EIF_OBJECT psz_file_name );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_get_cur_file(  /* [out] */ EIF_OBJECT ppsz_file_name );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::ITask * p_ITask;


	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IProvideTaskPage * p_IProvideTaskPage;


	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IPersistFile_2 * p_IPersistFile;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}

#endif
