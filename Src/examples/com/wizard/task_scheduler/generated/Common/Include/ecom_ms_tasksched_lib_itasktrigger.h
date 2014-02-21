/*-----------------------------------------------------------
Trigger object interface. A Task object may contain several of these. Task Scheduler.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ITASKTRIGGER_H__
#define __ECOM_MS_TASKSCHED_LIB_ITASKTRIGGER_H__

#include "decl_ecom_MS_TaskSched_lib_ITaskTrigger.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_aliases.h"

#ifndef __ecom_MS_TaskSched_lib_ITaskTrigger_INTERFACE_DEFINED__
#define __ecom_MS_TaskSched_lib_ITaskTrigger_INTERFACE_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class ITaskTrigger : public IUnknown
{
public:
	ITaskTrigger () {};
	~ITaskTrigger () {};

	/*-----------------------------------------------------------
	Sets the task trigger values.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetTrigger(  /* [in] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger ) = 0;


	/*-----------------------------------------------------------
	Retrieves the current task trigger.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetTrigger(  /* [out] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger ) = 0;


	/*-----------------------------------------------------------
	Retrieves the current task trigger in the form of a string.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetTriggerString(  /* [out] */ LPWSTR * ppwsz_trigger ) = 0;



protected:


private:


};
}
#endif

#endif
