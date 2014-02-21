/*-----------------------------------------------------------
Implemented `IProvideTaskPage' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IPROVIDETASKPAGE_IMPL_PROXY_H__
#define __ECOM_MS_TASKSCHED_LIB_IPROVIDETASKPAGE_IMPL_PROXY_H__

#include "decl_ecom_MS_TaskSched_lib_IProvideTaskPage_impl_proxy.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_IProvideTaskPage.h"

namespace ecom_MS_TaskSched_lib
{
class IProvideTaskPage_impl_proxy
{
public:
	IProvideTaskPage_impl_proxy (IUnknown * a_pointer);
	virtual ~IProvideTaskPage_impl_proxy ();

	/*-----------------------------------------------------------
	Retrieves the property sheet pages associated with a task.
	-----------------------------------------------------------*/
	void ccom_get_page(  /* [in] */ EIF_INTEGER tp_type,  /* [in] */ EIF_INTEGER f_persist_changes,  /* [out] */ EIF_OBJECT ph_page );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IProvideTaskPage * p_IProvideTaskPage;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}

#endif
