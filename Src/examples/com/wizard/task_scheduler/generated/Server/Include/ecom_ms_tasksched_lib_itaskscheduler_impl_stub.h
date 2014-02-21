/*-----------------------------------------------------------
Implemented `ITaskScheduler' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ITASKSCHEDULER_IMPL_STUB_H__
#define __ECOM_MS_TASKSCHED_LIB_ITASKSCHEDULER_IMPL_STUB_H__

#include "decl_ecom_MS_TaskSched_lib_ITaskScheduler_impl_stub.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_server_rt_globals.h"

#include "ecom_MS_TaskSched_lib_ITaskScheduler.h"

namespace ecom_MS_TaskSched_lib
{
class ITaskScheduler_impl_stub : public ecom_MS_TaskSched_lib::ITaskScheduler
{
public:
	ITaskScheduler_impl_stub (EIF_OBJECT eif_obj);
	virtual ~ITaskScheduler_impl_stub ();

	/*-----------------------------------------------------------
	Selects the computer that the ITaskScheduler interface operates on.
	-----------------------------------------------------------*/
	STDMETHODIMP SetTargetComputer(  /* [in] */ LPWSTR pwsz_computer );


	/*-----------------------------------------------------------
	Returns the name of the computer on which ITaskScheduler is currently targeted.
	-----------------------------------------------------------*/
	STDMETHODIMP GetTargetComputer(  /* [out] */ LPWSTR * ppwsz_computer );


	/*-----------------------------------------------------------
	Retrieves a pointer to an OLE enumerator object that enumerates the tasks in the current task folder.
	-----------------------------------------------------------*/
	STDMETHODIMP Enum(  /* [out] */ ecom_MS_TaskSched_lib::IEnumWorkItems * * pp_enum_work_items );


	/*-----------------------------------------------------------
	Returns an active interface to the specified task.
	-----------------------------------------------------------*/
	STDMETHODIMP Activate(  /* [in] */ LPWSTR pwsz_name, /* [in] */ GUID * a_riid, /* [out] */ IUnknown * * pp_unk );


	/*-----------------------------------------------------------
	Deletes a task.
	-----------------------------------------------------------*/
	STDMETHODIMP Delete(  /* [in] */ LPWSTR pwsz_name );


	/*-----------------------------------------------------------
	Allocates space for a new task and retrieves its address.
	-----------------------------------------------------------*/
	STDMETHODIMP NewWorkItem(  /* [in] */ LPWSTR pwsz_task_name, /* [in] */ GUID * rclsid, /* [in] */ GUID * a_riid, /* [out] */ IUnknown * * pp_unk );


	/*-----------------------------------------------------------
	Adds a task to the schedule of tasks.
	-----------------------------------------------------------*/
	STDMETHODIMP AddWorkItem(  /* [in] */ LPWSTR pwsz_task_name, /* [in] */ ecom_MS_TaskSched_lib::IScheduledWorkItem * p_work_item );


	/*-----------------------------------------------------------
	Checks the object type.
	-----------------------------------------------------------*/
	STDMETHODIMP IsOfType(  /* [in] */ LPWSTR pwsz_name, /* [in] */ GUID * a_riid );


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
