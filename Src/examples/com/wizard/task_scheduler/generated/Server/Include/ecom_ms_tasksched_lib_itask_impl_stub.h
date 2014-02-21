/*-----------------------------------------------------------
Implemented `ITask' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ITASK_IMPL_STUB_H__
#define __ECOM_MS_TASKSCHED_LIB_ITASK_IMPL_STUB_H__

#include "decl_ecom_MS_TaskSched_lib_ITask_impl_stub.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_server_rt_globals.h"

#include "ecom_MS_TaskSched_lib_ITask.h"

namespace ecom_MS_TaskSched_lib
{
class ITask_impl_stub : public ecom_MS_TaskSched_lib::ITask
{
public:
	ITask_impl_stub (EIF_OBJECT eif_obj);
	virtual ~ITask_impl_stub ();

	/*-----------------------------------------------------------
	Creates a trigger using a work item object.
	-----------------------------------------------------------*/
	STDMETHODIMP CreateTrigger(  /* [out] */ USHORT * pi_new_trigger, /* [out] */ ecom_MS_TaskSched_lib::ITaskTrigger * * pp_trigger );


	/*-----------------------------------------------------------
	Deletes a trigger from a work item. 
	-----------------------------------------------------------*/
	STDMETHODIMP DeleteTrigger(  /* [in] */ USHORT i_trigger );


	/*-----------------------------------------------------------
	Retrieves the number of triggers associated with a work item.
	-----------------------------------------------------------*/
	STDMETHODIMP GetTriggerCount(  /* [out] */ USHORT * pw_count );


	/*-----------------------------------------------------------
	Retrieves a trigger structure.
	-----------------------------------------------------------*/
	STDMETHODIMP GetTrigger(  /* [in] */ USHORT i_trigger, /* [out] */ ecom_MS_TaskSched_lib::ITaskTrigger * * pp_trigger );


	/*-----------------------------------------------------------
	Retrieves a trigger string.
	-----------------------------------------------------------*/
	STDMETHODIMP GetTriggerString(  /* [in] */ USHORT i_trigger, /* [out] */ LPWSTR * ppwsz_trigger );


	/*-----------------------------------------------------------
	Retrieves the work item run times for a specified time period.
	-----------------------------------------------------------*/
	STDMETHODIMP GetRunTimes(  /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_begin, /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_end, /* [in, out] */ USHORT * p_count, /* [out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * * rgst_task_times );


	/*-----------------------------------------------------------
	Retrieves the next time the work item will run.
	-----------------------------------------------------------*/
	STDMETHODIMP GetNextRunTime(  /* [in, out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_next_run );


	/*-----------------------------------------------------------
	Sets the idle wait time for the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP SetIdleWait(  /* [in] */ USHORT w_idle_minutes, /* [in] */ USHORT w_deadline_minutes );


	/*-----------------------------------------------------------
	Retrieves the idle wait time for the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP GetIdleWait(  /* [out] */ USHORT * pw_idle_minutes, /* [out] */ USHORT * pw_deadline_minutes );


	/*-----------------------------------------------------------
	Runs the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP Run( void );


	/*-----------------------------------------------------------
	Ends the execution of the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP Terminate( void );


	/*-----------------------------------------------------------
	Opens the configuration properties for the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP EditWorkItem(  /* [in] */ ecom_MS_TaskSched_lib::wireHWND h_parent, /* [in] */ ULONG dw_reserved );


	/*-----------------------------------------------------------
	Retrieves the most recent time the work item began running.
	-----------------------------------------------------------*/
	STDMETHODIMP GetMostRecentRunTime(  /* [out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_last_run );


	/*-----------------------------------------------------------
	Retrieves the status of the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP GetStatus(  /* [out] */ HRESULT * phr_status );


	/*-----------------------------------------------------------
	Retrieves the work item's last exit code.
	-----------------------------------------------------------*/
	STDMETHODIMP GetExitCode(  /* [out] */ ULONG * pdw_exit_code );


	/*-----------------------------------------------------------
	Sets the comment for the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP SetComment(  /* [in] */ LPWSTR pwsz_comment );


	/*-----------------------------------------------------------
	Retrieves the comment for the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP GetComment(  /* [out] */ LPWSTR * ppwsz_comment );


	/*-----------------------------------------------------------
	Sets the creator of the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP SetCreator(  /* [in] */ LPWSTR pwsz_creator );


	/*-----------------------------------------------------------
	Retrieves the creator of the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP GetCreator(  /* [out] */ LPWSTR * ppwsz_creator );


	/*-----------------------------------------------------------
	Stores application-defined data associated with the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP SetWorkItemData(  /* [in] */ USHORT cb_data, /* [in] */ UCHAR * rgb_data );


	/*-----------------------------------------------------------
	Retrieves application-defined data associated with the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP GetWorkItemData(  /* [out] */ USHORT * pcb_data, /* [out] */ UCHAR * * prgb_data );


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	STDMETHODIMP SetErrorRetryCount(  /* [in] */ USHORT w_retry_count );


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	STDMETHODIMP GetErrorRetryCount(  /* [out] */ USHORT * pw_retry_count );


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	STDMETHODIMP SetErrorRetryInterval(  /* [in] */ USHORT w_retry_interval );


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	STDMETHODIMP GetErrorRetryInterval(  /* [out] */ USHORT * pw_retry_interval );


	/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP SetFlags(  /* [in] */ ULONG dw_flags );


	/*-----------------------------------------------------------
	Retrieves the flags that modify the behavior of the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP GetFlags(  /* [out] */ ULONG * pdw_flags );


	/*-----------------------------------------------------------
	Sets the account name and password for the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP SetAccountInformation(  /* [in] */ LPWSTR pwsz_account_name, /* [in] */ LPWSTR pwsz_password );


	/*-----------------------------------------------------------
	Retrieves the account name for the work item.
	-----------------------------------------------------------*/
	STDMETHODIMP GetAccountInformation(  /* [out] */ LPWSTR * ppwsz_account_name );


	/*-----------------------------------------------------------
	Assigns a specific application to the current task.
	-----------------------------------------------------------*/
	STDMETHODIMP SetApplicationName(  /* [in] */ LPWSTR pwsz_application_name );


	/*-----------------------------------------------------------
	Retrieves the name of the application that the task is associated with.
	-----------------------------------------------------------*/
	STDMETHODIMP GetApplicationName(  /* [out] */ LPWSTR * ppwsz_application_name );


	/*-----------------------------------------------------------
	Sets the command-line parameters for the task.
	-----------------------------------------------------------*/
	STDMETHODIMP SetParameters(  /* [in] */ LPWSTR pwsz_parameters );


	/*-----------------------------------------------------------
	Retrieves the command-line parameters of a task.
	-----------------------------------------------------------*/
	STDMETHODIMP GetParameters(  /* [out] */ LPWSTR * ppwsz_parameters );


	/*-----------------------------------------------------------
	Sets the working directory for the task.
	-----------------------------------------------------------*/
	STDMETHODIMP SetWorkingDirectory(  /* [in] */ LPWSTR pwsz_working_directory );


	/*-----------------------------------------------------------
	Retrieves the working directory of the task.
	-----------------------------------------------------------*/
	STDMETHODIMP GetWorkingDirectory(  /* [out] */ LPWSTR * ppwsz_working_directory );


	/*-----------------------------------------------------------
	Sets the priority for the task.
	-----------------------------------------------------------*/
	STDMETHODIMP SetPriority(  /* [in] */ ULONG dw_priority );


	/*-----------------------------------------------------------
	Retrieves the priority for the task.
	-----------------------------------------------------------*/
	STDMETHODIMP GetPriority(  /* [out] */ ULONG * pdw_priority );


	/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the task.
	-----------------------------------------------------------*/
	STDMETHODIMP SetTaskFlags(  /* [in] */ ULONG dw_flags );


	/*-----------------------------------------------------------
	Returns the flags used to modify the behavior of the task.
	-----------------------------------------------------------*/
	STDMETHODIMP GetTaskFlags(  /* [out] */ ULONG * pdw_flags );


	/*-----------------------------------------------------------
	Sets the maximum length of time the task can run.
	-----------------------------------------------------------*/
	STDMETHODIMP SetMaxRunTime(  /* [in] */ ULONG dw_max_run_time_ms );


	/*-----------------------------------------------------------
	Retrieves the maximum length of time the task can run.
	-----------------------------------------------------------*/
	STDMETHODIMP GetMaxRunTime(  /* [out] */ ULONG * pdw_max_run_time_ms );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
	/*-----------------------------------------------------------
	Reference counter
	-----------------------------------------------------------*/
	LONG ref_count;


	/*-----------------------------------------------------------
	Corresponding Eiffel object
	-----------------------------------------------------------*/
	EIF_OBJECT eiffel_object;


	/*-----------------------------------------------------------
	Eiffel type id
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;




};
}

#endif
