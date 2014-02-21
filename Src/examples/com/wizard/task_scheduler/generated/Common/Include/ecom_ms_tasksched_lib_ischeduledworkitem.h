/*-----------------------------------------------------------
Abstract base class for any runnable work item that can be scheduled by the task scheduler. Task Scheduler.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ISCHEDULEDWORKITEM_H__
#define __ECOM_MS_TASKSCHED_LIB_ISCHEDULEDWORKITEM_H__

#include "decl_ecom_MS_TaskSched_lib_IScheduledWorkItem.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib__SYSTEMTIME.h"

#include "ecom_aliases.h"

#ifndef __ecom_MS_TaskSched_lib_ITaskTrigger_FWD_DEFINED__
#define __ecom_MS_TaskSched_lib_ITaskTrigger_FWD_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class ITaskTrigger;
}
#endif



#ifndef __ecom_MS_TaskSched_lib_IScheduledWorkItem_INTERFACE_DEFINED__
#define __ecom_MS_TaskSched_lib_IScheduledWorkItem_INTERFACE_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class IScheduledWorkItem : public IUnknown
{
public:
	IScheduledWorkItem () {};
	~IScheduledWorkItem () {};

	/*-----------------------------------------------------------
	Creates a trigger using a work item object.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP CreateTrigger(  /* [out] */ USHORT * pi_new_trigger, /* [out] */ ecom_MS_TaskSched_lib::ITaskTrigger * * pp_trigger ) = 0;


	/*-----------------------------------------------------------
	Deletes a trigger from a work item. 
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP DeleteTrigger(  /* [in] */ USHORT i_trigger ) = 0;


	/*-----------------------------------------------------------
	Retrieves the number of triggers associated with a work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetTriggerCount(  /* [out] */ USHORT * pw_count ) = 0;


	/*-----------------------------------------------------------
	Retrieves a trigger structure.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetTrigger(  /* [in] */ USHORT i_trigger, /* [out] */ ecom_MS_TaskSched_lib::ITaskTrigger * * pp_trigger ) = 0;


	/*-----------------------------------------------------------
	Retrieves a trigger string.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetTriggerString(  /* [in] */ USHORT i_trigger, /* [out] */ LPWSTR * ppwsz_trigger ) = 0;


	/*-----------------------------------------------------------
	Retrieves the work item run times for a specified time period.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetRunTimes(  /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_begin, /* [in] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_end, /* [in, out] */ USHORT * p_count, /* [out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * * rgst_task_times ) = 0;


	/*-----------------------------------------------------------
	Retrieves the next time the work item will run.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetNextRunTime(  /* [in, out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_next_run ) = 0;


	/*-----------------------------------------------------------
	Sets the idle wait time for the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetIdleWait(  /* [in] */ USHORT w_idle_minutes, /* [in] */ USHORT w_deadline_minutes ) = 0;


	/*-----------------------------------------------------------
	Retrieves the idle wait time for the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetIdleWait(  /* [out] */ USHORT * pw_idle_minutes, /* [out] */ USHORT * pw_deadline_minutes ) = 0;


	/*-----------------------------------------------------------
	Runs the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Run( void ) = 0;


	/*-----------------------------------------------------------
	Ends the execution of the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Terminate( void ) = 0;


	/*-----------------------------------------------------------
	Opens the configuration properties for the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP EditWorkItem(  /* [in] */ ecom_MS_TaskSched_lib::wireHWND h_parent, /* [in] */ ULONG dw_reserved ) = 0;


	/*-----------------------------------------------------------
	Retrieves the most recent time the work item began running.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetMostRecentRunTime(  /* [out] */ ecom_MS_TaskSched_lib::_SYSTEMTIME * pst_last_run ) = 0;


	/*-----------------------------------------------------------
	Retrieves the status of the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetStatus(  /* [out] */ HRESULT * phr_status ) = 0;


	/*-----------------------------------------------------------
	Retrieves the work item's last exit code.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetExitCode(  /* [out] */ ULONG * pdw_exit_code ) = 0;


	/*-----------------------------------------------------------
	Sets the comment for the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetComment(  /* [in] */ LPWSTR pwsz_comment ) = 0;


	/*-----------------------------------------------------------
	Retrieves the comment for the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetComment(  /* [out] */ LPWSTR * ppwsz_comment ) = 0;


	/*-----------------------------------------------------------
	Sets the creator of the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetCreator(  /* [in] */ LPWSTR pwsz_creator ) = 0;


	/*-----------------------------------------------------------
	Retrieves the creator of the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetCreator(  /* [out] */ LPWSTR * ppwsz_creator ) = 0;


	/*-----------------------------------------------------------
	Stores application-defined data associated with the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetWorkItemData(  /* [in] */ USHORT cb_data, /* [in] */ UCHAR * rgb_data ) = 0;


	/*-----------------------------------------------------------
	Retrieves application-defined data associated with the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetWorkItemData(  /* [out] */ USHORT * pcb_data, /* [out] */ UCHAR * * prgb_data ) = 0;


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetErrorRetryCount(  /* [in] */ USHORT w_retry_count ) = 0;


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetErrorRetryCount(  /* [out] */ USHORT * pw_retry_count ) = 0;


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetErrorRetryInterval(  /* [in] */ USHORT w_retry_interval ) = 0;


	/*-----------------------------------------------------------
	Not currently implemented.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetErrorRetryInterval(  /* [out] */ USHORT * pw_retry_interval ) = 0;


	/*-----------------------------------------------------------
	Sets the flags that modify the behavior of the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetFlags(  /* [in] */ ULONG dw_flags ) = 0;


	/*-----------------------------------------------------------
	Retrieves the flags that modify the behavior of the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetFlags(  /* [out] */ ULONG * pdw_flags ) = 0;


	/*-----------------------------------------------------------
	Sets the account name and password for the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetAccountInformation(  /* [in] */ LPWSTR pwsz_account_name, /* [in] */ LPWSTR pwsz_password ) = 0;


	/*-----------------------------------------------------------
	Retrieves the account name for the work item.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetAccountInformation(  /* [out] */ LPWSTR * ppwsz_account_name ) = 0;



protected:


private:


};
}
#endif

#endif
