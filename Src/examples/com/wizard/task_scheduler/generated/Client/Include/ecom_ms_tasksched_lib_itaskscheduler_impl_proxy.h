/*-----------------------------------------------------------
Implemented `ITaskScheduler' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ITASKSCHEDULER_IMPL_PROXY_H__
#define __ECOM_MS_TASKSCHED_LIB_ITASKSCHEDULER_IMPL_PROXY_H__

#include "decl_ecom_MS_TaskSched_lib_ITaskScheduler_impl_proxy.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_ITaskScheduler.h"

#include "decl_ecom_MS_TaskSched_lib_IEnumWorkItems.h"

#include "decl_ecom_MS_TaskSched_lib_IScheduledWorkItem.h"

namespace ecom_MS_TaskSched_lib
{
class ITaskScheduler_impl_proxy
{
public:
	ITaskScheduler_impl_proxy (IUnknown * a_pointer);
	virtual ~ITaskScheduler_impl_proxy ();

	/*-----------------------------------------------------------
	Selects the computer that the ITaskScheduler interface operates on.
	-----------------------------------------------------------*/
	void ccom_set_target_computer(  /* [in] */ EIF_OBJECT pwsz_computer );


	/*-----------------------------------------------------------
	Returns the name of the computer on which ITaskScheduler is currently targeted.
	-----------------------------------------------------------*/
	void ccom_get_target_computer(  /* [out] */ EIF_OBJECT ppwsz_computer );


	/*-----------------------------------------------------------
	Retrieves a pointer to an OLE enumerator object that enumerates the tasks in the current task folder.
	-----------------------------------------------------------*/
	void ccom_enum(  /* [out] */ EIF_OBJECT pp_enum_work_items );


	/*-----------------------------------------------------------
	Returns an active interface to the specified task.
	-----------------------------------------------------------*/
	void ccom_activate(  /* [in] */ EIF_OBJECT pwsz_name,  /* [in] */ GUID * a_riid,  /* [out] */ EIF_OBJECT pp_unk );


	/*-----------------------------------------------------------
	Deletes a task.
	-----------------------------------------------------------*/
	void ccom_delete(  /* [in] */ EIF_OBJECT pwsz_name );


	/*-----------------------------------------------------------
	Allocates space for a new task and retrieves its address.
	-----------------------------------------------------------*/
	void ccom_new_work_item(  /* [in] */ EIF_OBJECT pwsz_task_name,  /* [in] */ GUID * rclsid,  /* [in] */ GUID * a_riid,  /* [out] */ EIF_OBJECT pp_unk );


	/*-----------------------------------------------------------
	Adds a task to the schedule of tasks.
	-----------------------------------------------------------*/
	void ccom_add_work_item(  /* [in] */ EIF_OBJECT pwsz_task_name,  /* [in] */ ecom_MS_TaskSched_lib::IScheduledWorkItem * p_work_item );


	/*-----------------------------------------------------------
	Checks the object type.
	-----------------------------------------------------------*/
	void ccom_is_of_type(  /* [in] */ EIF_OBJECT pwsz_name,  /* [in] */ GUID * a_riid );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::ITaskScheduler * p_ITaskScheduler;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}

#endif
