/*-----------------------------------------------------------
Implemented `IAxWinHostWindow' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IAXWINHOSTWINDOW_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IAXWINHOSTWINDOW_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IAxWinHostWindow_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IAxWinHostWindow_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_IStream_s.h"

#include "ecom_control_library_IDocHostUIHandlerDispatch_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IAxWinHostWindow_impl_proxy
{
public:
	IAxWinHostWindow_impl_proxy (IUnknown * a_pointer);
	virtual ~IAxWinHostWindow_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_create_control(  /* [in] */ EIF_OBJECT lp_trics_data,  /* [in] */ EIF_POINTER h_wnd,  /* [in] */ ecom_control_library::IStream * p_stream );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_create_control_ex(  /* [in] */ EIF_OBJECT lp_trics_data,  /* [in] */ EIF_POINTER h_wnd,  /* [in] */ ecom_control_library::IStream * p_stream,  /* [out] */ EIF_OBJECT ppunk,  /* [in] */ GUID * riid_advise,  /* [in] */ IUnknown * punk_advise );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_attach_control(  /* [in] */ IUnknown * p_unk_control,  /* [in] */ EIF_POINTER h_wnd );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_query_control(  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_object );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_external_dispatch(  /* [in] */ IDispatch * p_disp );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_external_uihandler(  /* [in] */ ecom_control_library::IDocHostUIHandlerDispatch * p_disp );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IAxWinHostWindow * p_IAxWinHostWindow;


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