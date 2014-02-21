/*-----------------------------------------------------------
Work item object enumerator. Enumerates the work item objects within the Tasks folder. Task Scheduler.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IENUMWORKITEMS_H__
#define __ECOM_MS_TASKSCHED_LIB_IENUMWORKITEMS_H__

#include "decl_ecom_MS_TaskSched_lib_IEnumWorkItems.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#ifndef __ecom_MS_TaskSched_lib_IEnumWorkItems_FWD_DEFINED__
#define __ecom_MS_TaskSched_lib_IEnumWorkItems_FWD_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class IEnumWorkItems;
}
#endif



#ifndef __ecom_MS_TaskSched_lib_IEnumWorkItems_INTERFACE_DEFINED__
#define __ecom_MS_TaskSched_lib_IEnumWorkItems_INTERFACE_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class IEnumWorkItems : public IUnknown
{
public:
	IEnumWorkItems () {};
	~IEnumWorkItems () {};

	/*-----------------------------------------------------------
	Retrieves the next set of tasks in the enumeration sequence.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Next(  /* [in] */ ULONG celt, /* [out] */ LPWSTR * * rgpwsz_names, /* [out] */ ULONG * pcelt_fetched ) = 0;


	/*-----------------------------------------------------------
	Skips the next set of tasks in the enumeration sequence.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Skip(  /* [in] */ ULONG celt ) = 0;


	/*-----------------------------------------------------------
	Resets the enumeration sequence to the beginning. 
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	Creates a new enumeration object in the same state as the current enumeration object: the new object points to the same place in the enumeration sequence.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Clone(  /* [out] */ ecom_MS_TaskSched_lib::IEnumWorkItems * * pp_enum_work_items ) = 0;



protected:


private:


};
}
#endif

#endif
