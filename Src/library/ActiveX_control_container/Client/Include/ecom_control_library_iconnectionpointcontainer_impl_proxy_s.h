/*-----------------------------------------------------------
Implemented `IConnectionPointContainer' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ICONNECTIONPOINTCONTAINER_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ICONNECTIONPOINTCONTAINER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IConnectionPointContainer_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IConnectionPointContainer_s.h"

#include "ecom_control_library_IEnumConnectionPoints_s.h"

#include "ecom_control_library_IConnectionPoint_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IConnectionPointContainer_impl_proxy
{
public:
	IConnectionPointContainer_impl_proxy (IUnknown * a_pointer);
	virtual ~IConnectionPointContainer_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum_connection_points(  /* [out] */ EIF_OBJECT ppenum );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_find_connection_point(  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT pp_cp );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IConnectionPointContainer * p_IConnectionPointContainer;


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