/*-----------------------------------------------------------
Implemented `IBindCtx' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IBINDCTX_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IBINDCTX_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IBindCtx_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IBindCtx_s.h"

#include "ecom_control_library_tagBIND_OPTS2_s.h"

#include "ecom_control_library_IRunningObjectTable_s.h"

#include "ecom_control_library_IEnumString_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IBindCtx_impl_proxy
{
public:
	IBindCtx_impl_proxy (IUnknown * a_pointer);
	virtual ~IBindCtx_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_register_object_bound(  /* [in] */ IUnknown * punk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_revoke_object_bound(  /* [in] */ IUnknown * punk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_release_bound_objects();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_set_bind_options(  /* [in] */ ecom_control_library::tagBIND_OPTS2 * pbindopts );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_bind_options(  /* [in, out] */ ecom_control_library::tagBIND_OPTS2 * pbindopts );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_running_object_table(  /* [out] */ EIF_OBJECT pprot );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_register_object_param(  /* [in] */ EIF_OBJECT psz_key,  /* [in] */ IUnknown * punk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_object_param(  /* [in] */ EIF_OBJECT psz_key,  /* [out] */ EIF_OBJECT ppunk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum_object_param(  /* [out] */ EIF_OBJECT ppenum );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_revoke_object_param(  /* [in] */ EIF_OBJECT psz_key );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IBindCtx * p_IBindCtx;


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