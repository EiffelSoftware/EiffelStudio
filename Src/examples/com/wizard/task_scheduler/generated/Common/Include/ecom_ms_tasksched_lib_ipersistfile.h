/*-----------------------------------------------------------
Task Scheduler.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IPERSISTFILE_H__
#define __ECOM_MS_TASKSCHED_LIB_IPERSISTFILE_H__

#include "decl_ecom_MS_TaskSched_lib_IPersistFile.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_IPersist.h"

#ifndef __ecom_MS_TaskSched_lib_IPersistFile_2_INTERFACE_DEFINED__
#define __ecom_MS_TaskSched_lib_IPersistFile_2_INTERFACE_DEFINED__
namespace ecom_MS_TaskSched_lib
{
class IPersistFile_2 : public ecom_MS_TaskSched_lib::IPersist
{
public:
	IPersistFile_2 () {};
	~IPersistFile_2 () {};

	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP IsDirty( void ) = 0;


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Load(  /* [in] */ LPWSTR psz_file_name, /* [in] */ ULONG dw_mode ) = 0;


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP Save(  /* [in] */ LPWSTR psz_file_name, /* [in] */ LONG f_remember ) = 0;


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SaveCompleted(  /* [in] */ LPWSTR psz_file_name ) = 0;


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP GetCurFile(  /* [out] */ LPWSTR * ppsz_file_name ) = 0;



protected:


private:


};
}
#endif

#endif
