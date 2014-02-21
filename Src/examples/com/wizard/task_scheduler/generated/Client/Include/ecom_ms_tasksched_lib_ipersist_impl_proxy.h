/*-----------------------------------------------------------
Implemented `IPersist' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IPERSIST_IMPL_PROXY_H__
#define __ECOM_MS_TASKSCHED_LIB_IPERSIST_IMPL_PROXY_H__

#include "decl_ecom_MS_TaskSched_lib_IPersist_impl_proxy.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_IPersist.h"

namespace ecom_MS_TaskSched_lib
{
class IPersist_impl_proxy
{
public:
	IPersist_impl_proxy (IUnknown * a_pointer);
	virtual ~IPersist_impl_proxy ();

	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_get_class_id(  /* [out] */ GUID * p_class_id );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IPersist * p_IPersist;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}

#endif
