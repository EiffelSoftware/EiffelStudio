/*-----------------------------------------------------------
Implemented `IExternalConnection' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IEXTERNALCONNECTION_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IEXTERNALCONNECTION_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IExternalConnection_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IExternalConnection_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IExternalConnection_impl_proxy
{
public:
	IExternalConnection_impl_proxy (IUnknown * a_pointer);
	virtual ~IExternalConnection_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_add_connection(  /* [in] */ EIF_INTEGER extconn,  /* [in] */ EIF_INTEGER reserved );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_release_connection(  /* [in] */ EIF_INTEGER extconn,  /* [in] */ EIF_INTEGER reserved,  /* [in] */ EIF_INTEGER f_last_release_closes );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IExternalConnection * p_IExternalConnection;


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