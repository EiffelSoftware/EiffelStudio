/*-----------------------------------------------------------
Implemented `IConnectionPoint' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ICONNECTIONPOINT_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ICONNECTIONPOINT_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IConnectionPoint_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IConnectionPoint_s.h"

#include "ecom_control_library_IConnectionPointContainer_s.h"

#include "ecom_control_library_IEnumConnections_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IConnectionPoint_impl_proxy
{
public:
	IConnectionPoint_impl_proxy (IUnknown * a_pointer);
	virtual ~IConnectionPoint_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_connection_interface(  /* [out] */ GUID * p_iid );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_connection_point_container(  /* [out] */ EIF_OBJECT pp_cpc );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_advise(  /* [in] */ IUnknown * p_unk_sink,  /* [out] */ EIF_OBJECT pdw_cookie );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_unadvise(  /* [in] */ EIF_INTEGER dw_cookie );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum_connections(  /* [out] */ EIF_OBJECT ppenum );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IConnectionPoint * p_IConnectionPoint;


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