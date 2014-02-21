/*-----------------------------------------------------------
Task Scheduler interface. Provides location transparent manipulation of task and/or queue objects within the Tasks folder. Task Scheduler.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ITASKSCHEDULER_H__
#define __ECOM_MS_TASKSCHED_LIB_ITASKSCHEDULER_H__

#include "decl_ecom_MS_TaskSched_lib_ITaskScheduler.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#ifndef __ecom_MS_TaskSched_lib_IEnumWorkItems_FWD_DEFINED__
#define __ecom_MS_TaskSched_lib_IEnumWorkItems_FWD_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class IEnumWorkItems;
}
#endif



#ifndef __ecom_MS_TaskSched_lib_IScheduledWorkItem_FWD_DEFINED__
#define __ecom_MS_TaskSched_lib_IScheduledWorkItem_FWD_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class IScheduledWorkItem;
}
#endif



#ifndef __ecom_MS_TaskSched_lib_ITaskScheduler_INTERFACE_DEFINED__
#define __ecom_MS_TaskSched_lib_ITaskScheduler_INTERFACE_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class ITaskScheduler : public IUnknown
{
public:
	ITaskScheduler () {};
	~ITaskScheduler () {};

	/*-----------------------------------------------------------
	Selects the computer that the ITaskScheduler interface operates on.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetTargetComputer(  /* [in] */ LPWSTR pwsz_computer ) = 0;


	/*-----------------------------------------------------------
	Returns the name of the computer on which ITaskScheduler is currently targeted.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetTargetComputer(  /* [out] */ LPWSTR * ppwsz_computer ) = 0;


	/*-----------------------------------------------------------
	Retrieves a pointer to an OLE enumerator object that enumerates the tasks in the current task folder.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Enum(  /* [out] */ ecom_MS_TaskSched_lib::IEnumWorkItems * * pp_enum_work_items ) = 0;


	/*-----------------------------------------------------------
	Returns an active interface to the specified task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Activate(  /* [in] */ LPWSTR pwsz_name, /* [in] */ GUID * a_riid, /* [out] */ IUnknown * * pp_unk ) = 0;


	/*-----------------------------------------------------------
	Deletes a task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Delete(  /* [in] */ LPWSTR pwsz_name ) = 0;


	/*-----------------------------------------------------------
	Allocates space for a new task and retrieves its address.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP NewWorkItem(  /* [in] */ LPWSTR pwsz_task_name, /* [in] */ GUID * rclsid, /* [in] */ GUID * a_riid, /* [out] */ IUnknown * * pp_unk ) = 0;


	/*-----------------------------------------------------------
	Adds a task to the schedule of tasks.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP AddWorkItem(  /* [in] */ LPWSTR pwsz_task_name, /* [in] */ ecom_MS_TaskSched_lib::IScheduledWorkItem * p_work_item ) = 0;


	/*-----------------------------------------------------------
	Checks the object type.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP IsOfType(  /* [in] */ LPWSTR pwsz_name, /* [in] */ GUID * a_riid ) = 0;



protected:


private:


};
}
#endif

#endif
