/*-----------------------------------------------------------
Implemented `IProvideClassInfo2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROVIDECLASSINFO2_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROVIDECLASSINFO2_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IProvideClassInfo2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IProvideClassInfo2_s.h"

#include "ecom_control_library_ITypeInfo_2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IProvideClassInfo2_impl_proxy
{
public:
	IProvideClassInfo2_impl_proxy (IUnknown * a_pointer);
	virtual ~IProvideClassInfo2_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_class_info(  /* [out] */ EIF_OBJECT pp_ti );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_guid(  /* [in] */ EIF_INTEGER dw_guid_kind,  /* [out] */ GUID * p_guid );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IProvideClassInfo2 * p_IProvideClassInfo2;


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