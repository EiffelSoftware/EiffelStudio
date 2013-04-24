/*-----------------------------------------------------------
IDocHostUIHandlerDispatch Interface Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLERDISPATCH_S_H__
#define __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLERDISPATCH_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IDocHostUIHandlerDispatch_FWD_DEFINED__
#define __ecom_control_library_IDocHostUIHandlerDispatch_FWD_DEFINED__
namespace ecom_control_library
{
class IDocHostUIHandlerDispatch;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IDocHostUIHandlerDispatch_INTERFACE_DEFINED__
#define __ecom_control_library_IDocHostUIHandlerDispatch_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IDocHostUIHandlerDispatch : public IDispatch
{
public:
	IDocHostUIHandlerDispatch () {};
	~IDocHostUIHandlerDispatch () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ShowContextMenu(  /* [in] */ ULONG dw_id, /* [in] */ ULONG x, /* [in] */ ULONG y, /* [in] */ IUnknown * pcmdt_reserved, /* [in] */ IDispatch * pdisp_reserved, /* [out, retval] */ HRESULT * dw_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetHostInfo(  /* [in, out] */ ULONG * pdw_flags, /* [in, out] */ ULONG * pdw_double_click ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ShowUI(  /* [in] */ ULONG dw_id, /* [in] */ IUnknown * p_active_object, /* [in] */ IUnknown * p_command_target, /* [in] */ IUnknown * p_frame, /* [in] */ IUnknown * p_doc, /* [out, retval] */ HRESULT * dw_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HideUI( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UpdateUI( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnableModeless(  /* [in] */ VARIANT_BOOL f_enable ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnDocWindowActivate(  /* [in] */ VARIANT_BOOL f_activate ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnFrameWindowActivate(  /* [in] */ VARIANT_BOOL f_activate ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ResizeBorder(  /* [in] */ LONG left, /* [in] */ LONG top, /* [in] */ LONG right, /* [in] */ LONG bottom, /* [in] */ IUnknown * p_uiwindow, /* [in] */ VARIANT_BOOL f_frame_window ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TranslateAccelerator(  /* [in] */ ULONG h_wnd, /* [in] */ ULONG n_message, /* [in] */ ULONG w_param, /* [in] */ ULONG l_param, /* [in] */ BSTR bstr_guid_cmd_group, /* [in] */ ULONG n_cmd_id, /* [out, retval] */ HRESULT * dw_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetOptionKeyPath(  /* [out] */ BSTR * pbstr_key, /* [in] */ ULONG dw ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetDropTarget(  /* [in] */ IUnknown * p_drop_target, /* [out] */ IUnknown * * pp_drop_target ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetExternal(  /* [out] */ IDispatch * * pp_dispatch ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TranslateUrl(  /* [in] */ ULONG dw_translate, /* [in] */ BSTR bstr_urlin, /* [out] */ BSTR * pbstr_urlout ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FilterDataObject(  /* [in] */ IUnknown * p_do, /* [out] */ IUnknown * * pp_doret ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif