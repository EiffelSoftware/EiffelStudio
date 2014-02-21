/*-----------------------------------------------------------
Task object interface. The primary means of task object manipulation. Task Scheduler.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ITASK_H__
#define __ECOM_MS_TASKSCHED_LIB_ITASK_H__

#include "decl_ecom_MS_TaskSched_lib_ITask.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_IScheduledWorkItem.h"

#ifndef __ecom_MS_TaskSched_lib_ITask_INTERFACE_DEFINED__
#define __ecom_MS_TaskSched_lib_ITask_INTERFACE_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class ITask : public ecom_MS_TaskSched_lib::IScheduledWorkItem
{
public:
	ITask () {};
	~ITask () {};

	/*-----------------------------------------------------------
	Assigns a specific application to the current task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetApplicationName(  /* [in] */ LPWSTR pwsz_application_name ) = 0;


	/*-----------------------------------------------------------
	Retrieves the name of the application that the task is associated with.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetApplicationName(  /* [out] */ LPWSTR * ppwsz_application_name ) = 0;


	/*-----------------------------------------------------------
	Sets the command-line parameters for the task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetParameters(  /* [in] */ LPWSTR pwsz_parameters ) = 0;


	/*-----------------------------------------------------------
	Retrieves the command-line parameters of a task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetParameters(  /* [out] */ LPWSTR * ppwsz_parameters ) = 0;


	/*-----------------------------------------------------------
	Sets the working directory for the task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetWorkingDirectory(  /* [in] */ LPWSTR pwsz_working_directory ) = 0;


	/*-----------------------------------------------------------
	Retrieves the working directory of the task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetWorkingDirectory(  /* [out] */ LPWSTR * ppwsz_working_directory ) = 0;


	/*-----------------------------------------------------------
	Sets the priority for the task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetPriority(  /* [in] */ ULONG dw_priority ) = 0;


	/*-----------------------------------------------------------
	Retrieves the priority for the task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetPriority(  /* [out] */ ULONG * pdw_priority ) = 0;


	/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetTaskFlags(  /* [in] */ ULONG dw_flags ) = 0;


	/*-----------------------------------------------------------
	Returns the flags used to modify the behavior of the task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetTaskFlags(  /* [out] */ ULONG * pdw_flags ) = 0;


	/*-----------------------------------------------------------
	Sets the maximum length of time the task can run.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetMaxRunTime(  /* [in] */ ULONG dw_max_run_time_ms ) = 0;


	/*-----------------------------------------------------------
	Retrieves the maximum length of time the task can run.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetMaxRunTime(  /* [out] */ ULONG * pdw_max_run_time_ms ) = 0;



protected:


private:


};
}
#endif

#endif
