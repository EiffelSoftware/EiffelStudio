/*-----------------------------------------------------------
Implemented `IPersistFile' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IPERSISTFILE_IMPL_STUB_H__
#define __ECOM_MS_TASKSCHED_LIB_IPERSISTFILE_IMPL_STUB_H__

#include "decl_ecom_MS_TaskSched_lib_IPersistFile_impl_stub.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_server_rt_globals.h"

#include "ecom_MS_TaskSched_lib_IPersistFile.h"

namespace ecom_MS_TaskSched_lib
{
class IPersistFile_impl_stub : public ecom_MS_TaskSched_lib::IPersistFile_2
{
public:
	IPersistFile_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IPersistFile_impl_stub ();

	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	STDMETHODIMP GetClassID(  /* [out] */ GUID * p_class_id );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	STDMETHODIMP IsDirty( void );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	STDMETHODIMP Load(  /* [in] */ LPWSTR psz_file_name, /* [in] */ ULONG dw_mode );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	STDMETHODIMP Save(  /* [in] */ LPWSTR psz_file_name, /* [in] */ LONG f_remember );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	STDMETHODIMP SaveCompleted(  /* [in] */ LPWSTR psz_file_name );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	STDMETHODIMP GetCurFile(  /* [out] */ LPWSTR * ppsz_file_name );


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
