/*-----------------------------------------------------------
Implemented `IEnumConnectionPoints' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMCONNECTIONPOINTS_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMCONNECTIONPOINTS_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IEnumConnectionPoints_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IEnumConnectionPoints_s.h"

#include "ecom_control_library_IConnectionPoint_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IEnumConnectionPoints_impl_proxy
{
public:
	IEnumConnectionPoints_impl_proxy (IUnknown * a_pointer);
	virtual ~IEnumConnectionPoints_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_next(  /* [in] */ EIF_INTEGER c_connections,  /* [out] */ EIF_OBJECT pp_cp,  /* [out] */ EIF_OBJECT pc_fetched );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_skip(  /* [in] */ EIF_INTEGER c_connections );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_reset();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_clone1(  /* [out] */ EIF_OBJECT ppenum );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IEnumConnectionPoints * p_IEnumConnectionPoints;


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