/*-----------------------------------------------------------
Implemented `IPersistFile_2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTFILE_2_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTFILE_2_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPersistFile_2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersistFile_2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPersistFile_2_impl_proxy
{
public:
	IPersistFile_2_impl_proxy (IUnknown * a_pointer);
	virtual ~IPersistFile_2_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_class_id(  /* [out] */ GUID * p_class_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_is_dirty();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_load(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER dw_mode );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_save(  /* [in] */ EIF_OBJECT psz_file_name,  /* [in] */ EIF_INTEGER f_remember );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_save_completed(  /* [in] */ EIF_OBJECT psz_file_name );


	/*-----------------------------------------------------------
	No description available.
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
	ecom_control_library::IPersistFile_2 * p_IPersistFile_2;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif