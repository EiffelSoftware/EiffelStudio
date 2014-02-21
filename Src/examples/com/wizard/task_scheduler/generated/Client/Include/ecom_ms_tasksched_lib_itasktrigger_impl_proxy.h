/*-----------------------------------------------------------
Implemented `ITaskTrigger' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ITASKTRIGGER_IMPL_PROXY_H__
#define __ECOM_MS_TASKSCHED_LIB_ITASKTRIGGER_IMPL_PROXY_H__

#include "decl_ecom_MS_TaskSched_lib_ITaskTrigger_impl_proxy.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_ITaskTrigger.h"

#include "ecom_aliases.h"

namespace ecom_MS_TaskSched_lib
{
class ITaskTrigger_impl_proxy
{
public:
	ITaskTrigger_impl_proxy (IUnknown * a_pointer);
	virtual ~ITaskTrigger_impl_proxy ();

	/*-----------------------------------------------------------
	Sets the task trigger values.
	-----------------------------------------------------------*/
	void ccom_set_trigger(  /* [in] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger );


	/*-----------------------------------------------------------
	Retrieves the current task trigger.
	-----------------------------------------------------------*/
	void ccom_get_trigger(  /* [out] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger );


	/*-----------------------------------------------------------
	Retrieves the current task trigger in the form of a string.
	-----------------------------------------------------------*/
	void ccom_get_trigger_string(  /* [out] */ EIF_OBJECT ppwsz_trigger );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::ITaskTrigger * p_ITaskTrigger;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}

#endif
