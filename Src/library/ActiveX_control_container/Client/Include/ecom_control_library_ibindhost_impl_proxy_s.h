/*-----------------------------------------------------------
Implemented `IBindHost' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IBINDHOST_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IBINDHOST_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IBindHost_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IBindHost_s.h"

#include "ecom_control_library_IBindCtx_s.h"

#include "ecom_control_library_IMoniker_s.h"

#include "ecom_control_library_IBindStatusCallback_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IBindHost_impl_proxy
{
public:
	IBindHost_impl_proxy (IUnknown * a_pointer);
	virtual ~IBindHost_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_create_moniker(  /* [in] */ EIF_OBJECT sz_name,  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [out] */ EIF_OBJECT ppmk,  /* [in] */ EIF_INTEGER dw_reserved );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_moniker_bind_to_storage(  /* [in] */ ecom_control_library::IMoniker * pmk,  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IBindStatusCallback * p_bsc,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_obj );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_moniker_bind_to_object(  /* [in] */ ecom_control_library::IMoniker * pmk,  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IBindStatusCallback * p_bsc,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_obj );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IBindHost * p_IBindHost;


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