/*-----------------------------------------------------------
Implemented `IBindStatusCallback' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IBINDSTATUSCALLBACK_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IBINDSTATUSCALLBACK_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IBindStatusCallback_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IBindStatusCallback_s.h"

#include "ecom_control_library_IBinding_s.h"

#include "ecom_control_library__tagRemBINDINFO_s.h"

#include "ecom_control_library_tagRemSTGMEDIUM_s.h"

#include "ecom_control_library_tagRemFORMATETC_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IBindStatusCallback_impl_proxy
{
public:
	IBindStatusCallback_impl_proxy (IUnknown * a_pointer);
	virtual ~IBindStatusCallback_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_start_binding(  /* [in] */ EIF_INTEGER dw_reserved,  /* [in] */ ecom_control_library::IBinding * pib );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_priority(  /* [out] */ EIF_OBJECT pn_priority );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_low_resource(  /* [in] */ EIF_INTEGER reserved );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_progress(  /* [in] */ EIF_INTEGER ul_progress,  /* [in] */ EIF_INTEGER ul_progress_max,  /* [in] */ EIF_INTEGER ul_status_code,  /* [in] */ EIF_OBJECT sz_status_text );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_stop_binding(  /* [in] */ EIF_OBJECT hresult,  /* [in] */ EIF_OBJECT sz_error );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_get_bind_info(  /* [out] */ EIF_OBJECT grf_bindf,  /* [in, out] */ ecom_control_library::_tagRemBINDINFO * pbindinfo,  /* [in, out] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_remote_on_data_available(  /* [in] */ EIF_INTEGER grf_bscf,  /* [in] */ EIF_INTEGER dw_size,  /* [in] */ ecom_control_library::tagRemFORMATETC * p_formatetc,  /* [in] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_object_available(  /* [in] */ GUID * riid,  /* [in] */ IUnknown * punk );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IBindStatusCallback * p_IBindStatusCallback;


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