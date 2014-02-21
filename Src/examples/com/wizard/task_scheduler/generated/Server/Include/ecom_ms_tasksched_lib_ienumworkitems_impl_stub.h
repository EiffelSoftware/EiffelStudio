/*-----------------------------------------------------------
Implemented `IEnumWorkItems' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IENUMWORKITEMS_IMPL_STUB_H__
#define __ECOM_MS_TASKSCHED_LIB_IENUMWORKITEMS_IMPL_STUB_H__

#include "decl_ecom_MS_TaskSched_lib_IEnumWorkItems_impl_stub.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_server_rt_globals.h"

#include "ecom_MS_TaskSched_lib_IEnumWorkItems.h"

namespace ecom_MS_TaskSched_lib
{
class IEnumWorkItems_impl_stub : public ecom_MS_TaskSched_lib::IEnumWorkItems
{
public:
	IEnumWorkItems_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEnumWorkItems_impl_stub ();

	/*-----------------------------------------------------------
	Retrieves the next set of tasks in the enumeration sequence.
	-----------------------------------------------------------*/
	STDMETHODIMP Next(  /* [in] */ ULONG celt, /* [out] */ LPWSTR * * rgpwsz_names, /* [out] */ ULONG * pcelt_fetched );


	/*-----------------------------------------------------------
	Skips the next set of tasks in the enumeration sequence.
	-----------------------------------------------------------*/
	STDMETHODIMP Skip(  /* [in] */ ULONG celt );


	/*-----------------------------------------------------------
	Resets the enumeration sequence to the beginning. 
	-----------------------------------------------------------*/
	STDMETHODIMP Reset( void );


	/*-----------------------------------------------------------
	Creates a new enumeration object in the same state as the current enumeration object: the new object points to the same place in the enumeration sequence.
	-----------------------------------------------------------*/
	STDMETHODIMP Clone(  /* [out] */ ecom_MS_TaskSched_lib::IEnumWorkItems * * pp_enum_work_items );


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
