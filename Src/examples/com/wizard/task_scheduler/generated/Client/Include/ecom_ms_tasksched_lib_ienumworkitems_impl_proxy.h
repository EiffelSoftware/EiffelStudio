/*-----------------------------------------------------------
Implemented `IEnumWorkItems' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IENUMWORKITEMS_IMPL_PROXY_H__
#define __ECOM_MS_TASKSCHED_LIB_IENUMWORKITEMS_IMPL_PROXY_H__

#include "decl_ecom_MS_TaskSched_lib_IEnumWorkItems_impl_proxy.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_IEnumWorkItems.h"

#include "decl_ecom_MS_TaskSched_lib_IEnumWorkItems.h"

namespace ecom_MS_TaskSched_lib
{
class IEnumWorkItems_impl_proxy
{
public:
	IEnumWorkItems_impl_proxy (IUnknown * a_pointer);
	virtual ~IEnumWorkItems_impl_proxy ();

	/*-----------------------------------------------------------
	Retrieves the next set of tasks in the enumeration sequence.
	-----------------------------------------------------------*/
	void ccom_next(  /* [in] */ EIF_INTEGER celt,  /* [out] */ EIF_OBJECT rgpwsz_names,  /* [out] */ EIF_OBJECT pcelt_fetched );


	/*-----------------------------------------------------------
	Skips the next set of tasks in the enumeration sequence.
	-----------------------------------------------------------*/
	void ccom_skip(  /* [in] */ EIF_INTEGER celt );


	/*-----------------------------------------------------------
	Resets the enumeration sequence to the beginning. 
	-----------------------------------------------------------*/
	void ccom_reset();


	/*-----------------------------------------------------------
	Creates a new enumeration object in the same state as the current enumeration object: the new object points to the same place in the enumeration sequence.
	-----------------------------------------------------------*/
	void ccom_clone1(  /* [out] */ EIF_OBJECT pp_enum_work_items );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IEnumWorkItems * p_IEnumWorkItems;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}

#endif
