/*-----------------------------------------------------------
Implemented `IPersistMemory' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTMEMORY_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTMEMORY_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPersistMemory_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersistMemory_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPersistMemory_impl_proxy
{
public:
	IPersistMemory_impl_proxy (IUnknown * a_pointer);
	virtual ~IPersistMemory_impl_proxy ();

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
	void ccom_remote_load(  /* [in] */ EIF_OBJECT p_mem,  /* [in] */ EIF_INTEGER cb_size );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_save(  /* [out] */ EIF_OBJECT p_mem,  /* [in] */ EIF_INTEGER f_clear_dirty,  /* [in] */ EIF_INTEGER cb_size );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_size_max(  /* [out] */ EIF_OBJECT pcb_size );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_init_new();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IPersistMemory * p_IPersistMemory;


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