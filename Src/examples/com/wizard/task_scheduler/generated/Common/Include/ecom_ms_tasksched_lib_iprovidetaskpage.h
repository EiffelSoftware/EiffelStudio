/*-----------------------------------------------------------
Task property page retrieval interface. With this interface, it is possible to retrieve one or more property pages associated with a task object. Task objects inherit this interface. Task Scheduler.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IPROVIDETASKPAGE_H__
#define __ECOM_MS_TASKSCHED_LIB_IPROVIDETASKPAGE_H__

#include "decl_ecom_MS_TaskSched_lib_IProvideTaskPage.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#ifndef __ecom_MS_TaskSched_lib_IProvideTaskPage_INTERFACE_DEFINED__
#define __ecom_MS_TaskSched_lib_IProvideTaskPage_INTERFACE_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class IProvideTaskPage : public IUnknown
{
public:
	IProvideTaskPage () {};
	~IProvideTaskPage () {};

	/*-----------------------------------------------------------
	Retrieves the property sheet pages associated with a task.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetPage(  /* [in] */ long tp_type, /* [in] */ LONG f_persist_changes, /* [out] */ void * * ph_page ) = 0;



protected:


private:


};
}
#endif

#endif
