/*-----------------------------------------------------------
Implemented `ITaskTrigger' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_ITASKTRIGGER_IMPL_STUB_H__
#define __ECOM_MS_TASKSCHED_LIB_ITASKTRIGGER_IMPL_STUB_H__

#include "decl_ecom_MS_TaskSched_lib_ITaskTrigger_impl_stub.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_server_rt_globals.h"

#include "ecom_MS_TaskSched_lib_ITaskTrigger.h"

namespace ecom_MS_TaskSched_lib
{
class ITaskTrigger_impl_stub : public ecom_MS_TaskSched_lib::ITaskTrigger
{
public:
	ITaskTrigger_impl_stub (EIF_OBJECT eif_obj);
	virtual ~ITaskTrigger_impl_stub ();

	/*-----------------------------------------------------------
	Sets the task trigger values.
	-----------------------------------------------------------*/
	STDMETHODIMP SetTrigger(  /* [in] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger );


	/*-----------------------------------------------------------
	Retrieves the current task trigger.
	-----------------------------------------------------------*/
	STDMETHODIMP GetTrigger(  /* [out] */ ecom_MS_TaskSched_lib::PTASK_TRIGGER p_trigger );


	/*-----------------------------------------------------------
	Retrieves the current task trigger in the form of a string.
	-----------------------------------------------------------*/
	STDMETHODIMP GetTriggerString(  /* [out] */ LPWSTR * ppwsz_trigger );


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
