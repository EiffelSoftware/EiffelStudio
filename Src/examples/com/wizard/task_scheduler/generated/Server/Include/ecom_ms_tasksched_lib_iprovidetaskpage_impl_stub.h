/*-----------------------------------------------------------
Implemented `IProvideTaskPage' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IPROVIDETASKPAGE_IMPL_STUB_H__
#define __ECOM_MS_TASKSCHED_LIB_IPROVIDETASKPAGE_IMPL_STUB_H__

#include "decl_ecom_MS_TaskSched_lib_IProvideTaskPage_impl_stub.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_server_rt_globals.h"

#include "ecom_MS_TaskSched_lib_IProvideTaskPage.h"

namespace ecom_MS_TaskSched_lib
{
class IProvideTaskPage_impl_stub : public ecom_MS_TaskSched_lib::IProvideTaskPage
{
public:
	IProvideTaskPage_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IProvideTaskPage_impl_stub ();

	/*-----------------------------------------------------------
	Retrieves the property sheet pages associated with a task.
	-----------------------------------------------------------*/
	STDMETHODIMP GetPage(  /* [in] */ long tp_type, /* [in] */ LONG f_persist_changes, /* [out] */ void * * ph_page );


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
