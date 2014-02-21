/*-----------------------------------------------------------
Implemented `IPersistFile' interface.
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB_IPERSISTFILE_IMPL_PROXY_H__
#define __ECOM_MS_TASKSCHED_LIB_IPERSISTFILE_IMPL_PROXY_H__

#include "decl_ecom_MS_TaskSched_lib_IPersistFile_impl_proxy.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib_IPersistFile.h"

namespace ecom_MS_TaskSched_lib
{
class IPersistFile_impl_proxy
{
public:
	IPersistFile_impl_proxy (IUnknown * a_pointer);
	virtual ~IPersistFile_impl_proxy ();

	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_get_class_id(  /* [out] */ GUID * p_class_id );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_is_dirty();


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_load(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER dw_mode );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_save(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER f_remember );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_save_completed(  /* [in] */ EIF_OBJECT psz_file_name );


	/*-----------------------------------------------------------
	
	-----------------------------------------------------------*/
	void ccom_get_cur_file(  /* [out] */ EIF_OBJECT ppsz_file_name );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_MS_TaskSched_lib::IPersistFile_2 * p_IPersistFile;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}

#endif
