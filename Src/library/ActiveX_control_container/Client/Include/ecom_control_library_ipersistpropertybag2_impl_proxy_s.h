/*-----------------------------------------------------------
Implemented `IPersistPropertyBag2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTPROPERTYBAG2_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTPROPERTYBAG2_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPersistPropertyBag2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersistPropertyBag2_s.h"

#include "ecom_control_library_IPropertyBag2_s.h"

#include "ecom_control_library_IErrorLog_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPersistPropertyBag2_impl_proxy
{
public:
	IPersistPropertyBag2_impl_proxy (IUnknown * a_pointer);
	virtual ~IPersistPropertyBag2_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_class_id(  /* [out] */ GUID * p_class_id );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_init_new();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_load(  /* [in] */ ecom_control_library::IPropertyBag2 * p_prop_bag,  /* [in] */ ecom_control_library::IErrorLog * p_err_log );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_save(  /* [in] */ ecom_control_library::IPropertyBag2 * p_prop_bag,  /* [in] */ EIF_INTEGER f_clear_dirty,  /* [in] */ EIF_INTEGER f_save_all_properties );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_is_dirty();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IPersistPropertyBag2 * p_IPersistPropertyBag2;


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