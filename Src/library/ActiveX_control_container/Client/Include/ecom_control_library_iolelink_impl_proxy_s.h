/*-----------------------------------------------------------
Implemented `IOleLink' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLELINK_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLELINK_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleLink_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleLink_s.h"

#include "ecom_control_library_IMoniker_s.h"

#include "ecom_control_library_IBindCtx_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleLink_impl_proxy
{
public:
	IOleLink_impl_proxy (IUnknown * a_pointer);
	virtual ~IOleLink_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_update_options(  /* [in] */ EIF_INTEGER dw_update_opt );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_update_options(  /* [out] */ EIF_OBJECT pdw_update_opt );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_source_moniker(  /* [in] */ ecom_control_library::IMoniker * pmk,  /* [in] */ GUID * rclsid );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_source_moniker(  /* [out] */ EIF_OBJECT ppmk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_source_display_name(  /* [in] */ EIF_OBJECT psz_status_text );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_source_display_name(  /* [out] */ EIF_OBJECT ppsz_display_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_bind_to_source(  /* [in] */ EIF_INTEGER bindflags,  /* [in] */ ecom_control_library::IBindCtx * pbc );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_bind_if_running();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_bound_source(  /* [out] */ EIF_OBJECT ppunk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_unbind_source();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_update(  /* [in] */ ecom_control_library::IBindCtx * pbc );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IOleLink * p_IOleLink;


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