/*-----------------------------------------------------------
Task Scheduler.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IPERSIST_H__
#define __ECOM_MS_TASKSCHED_LIB_IPERSIST_H__

#include "decl_ecom_MS_TaskSched_lib_IPersist.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#ifndef __ecom_MS_TaskSched_lib_IPersist_INTERFACE_DEFINED__
#define __ecom_MS_TaskSched_lib_IPersist_INTERFACE_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class IPersist : public IUnknown
{
public:
	IPersist () {};
	~IPersist () {};

	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetClassID(  /* [out] */ GUID * p_class_id ) = 0;



protected:


private:


};
}
#endif

#endif
