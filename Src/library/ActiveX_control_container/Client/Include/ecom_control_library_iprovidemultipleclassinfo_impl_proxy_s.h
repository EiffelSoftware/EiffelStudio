/*-----------------------------------------------------------
Implemented `IProvideMultipleClassInfo' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROVIDEMULTIPLECLASSINFO_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROVIDEMULTIPLECLASSINFO_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IProvideMultipleClassInfo_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IProvideMultipleClassInfo_s.h"

#include "ecom_control_library_ITypeInfo_2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IProvideMultipleClassInfo_impl_proxy
{
public:
	IProvideMultipleClassInfo_impl_proxy (IUnknown * a_pointer);
	virtual ~IProvideMultipleClassInfo_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_class_info(  /* [out] */ EIF_OBJECT pp_ti );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_guid(  /* [in] */ EIF_INTEGER dw_guid_kind,  /* [out] */ GUID * p_guid );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_multi_type_info_count(  /* [out] */ EIF_OBJECT pcti );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_info_of_index(  /* [in] */ EIF_INTEGER iti,  /* [in] */ EIF_INTEGER dw_flags,  /* [out] */ EIF_OBJECT ppti_co_class,  /* [out] */ EIF_OBJECT pdw_tiflags,  /* [out] */ EIF_OBJECT pcdispid_reserved,  /* [out] */ GUID * piid_primary,  /* [out] */ GUID * piid_source );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IProvideMultipleClassInfo * p_IProvideMultipleClassInfo;


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