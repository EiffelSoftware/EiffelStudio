/*-----------------------------------------------------------
Implemented `IBinding' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IBINDING_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IBINDING_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IBinding_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IBinding_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IBinding_impl_proxy
{
public:
	IBinding_impl_proxy (IUnknown * a_pointer);
	virtual ~IBinding_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_abort();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_suspend();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_resume();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_priority(  /* [in] */ EIF_INTEGER n_priority );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_priority(  /* [out] */ EIF_OBJECT pn_priority );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_bind_result(  /* [out] */ GUID * pclsid_protocol,  /* [out] */ EIF_OBJECT pdw_result,  /* [out] */ EIF_OBJECT psz_result,  /* [in] */ EIF_INTEGER dw_reserved );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IBinding * p_IBinding;


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