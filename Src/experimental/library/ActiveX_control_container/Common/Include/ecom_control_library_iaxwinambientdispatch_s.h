/*-----------------------------------------------------------
IAxWinAmbientDispatch Interface Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IAXWINAMBIENTDISPATCH_S_H__
#define __ECOM_CONTROL_LIBRARY_IAXWINAMBIENTDISPATCH_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IAxWinAmbientDispatch_FWD_DEFINED__
#define __ecom_control_library_IAxWinAmbientDispatch_FWD_DEFINED__
namespace ecom_control_library
{
class IAxWinAmbientDispatch;
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
#ifndef __ecom_control_library_IAxWinAmbientDispatch_INTERFACE_DEFINED__
#define __ecom_control_library_IAxWinAmbientDispatch_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IAxWinAmbientDispatch : public IDispatch
{
public:
	IAxWinAmbientDispatch () {};
	~IAxWinAmbientDispatch () {};

	/*-----------------------------------------------------------
	Enable or disable windowless activation
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_AllowWindowlessActivation(  /* [in] */ VARIANT_BOOL pb_can_windowless_activate ) = 0;


	/*-----------------------------------------------------------
	Enable or disable windowless activation
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AllowWindowlessActivation(  /* [out, retval] */ VARIANT_BOOL * pb_can_windowless_activate ) = 0;


	/*-----------------------------------------------------------
	Set the background color
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_BackColor(  /* [in] */ OLE_COLOR pclr_background ) = 0;


	/*-----------------------------------------------------------
	Set the background color
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BackColor(  /* [out, retval] */ OLE_COLOR * pclr_background ) = 0;


	/*-----------------------------------------------------------
	Set the ambient foreground color
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ForeColor(  /* [in] */ OLE_COLOR pclr_foreground ) = 0;


	/*-----------------------------------------------------------
	Set the ambient foreground color
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ForeColor(  /* [out, retval] */ OLE_COLOR * pclr_foreground ) = 0;


	/*-----------------------------------------------------------
	Set the ambient locale
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_LocaleID(  /* [in] */ ULONG plcid_locale_id ) = 0;


	/*-----------------------------------------------------------
	Set the ambient locale
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocaleID(  /* [out, retval] */ ULONG * plcid_locale_id ) = 0;


	/*-----------------------------------------------------------
	Set the ambient user mode
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_UserMode(  /* [in] */ VARIANT_BOOL pb_user_mode ) = 0;


	/*-----------------------------------------------------------
	Set the ambient user mode
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UserMode(  /* [out, retval] */ VARIANT_BOOL * pb_user_mode ) = 0;


	/*-----------------------------------------------------------
	Enable or disable the control as default
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_DisplayAsDefault(  /* [in] */ VARIANT_BOOL pb_display_as_default ) = 0;


	/*-----------------------------------------------------------
	Enable or disable the control as default
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DisplayAsDefault(  /* [out, retval] */ VARIANT_BOOL * pb_display_as_default ) = 0;


	/*-----------------------------------------------------------
	Set the ambient font
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Font(  /* [in] */ Font * p_font ) = 0;


	/*-----------------------------------------------------------
	Set the ambient font
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_Font(  /* [out, retval] */ Font * * p_font ) = 0;


	/*-----------------------------------------------------------
	Enable or disable message reflection
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_MessageReflect(  /* [in] */ VARIANT_BOOL pb_msg_reflect ) = 0;


	/*-----------------------------------------------------------
	Enable or disable message reflection
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MessageReflect(  /* [out, retval] */ VARIANT_BOOL * pb_msg_reflect ) = 0;


	/*-----------------------------------------------------------
	Show or hide grab handles
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ShowGrabHandles(  /* [in] */ VARIANT_BOOL * pb_show_grab_handles ) = 0;


	/*-----------------------------------------------------------
	Are grab handles enabled
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ShowHatching(  /* [in] */ VARIANT_BOOL * pb_show_hatching ) = 0;


	/*-----------------------------------------------------------
	Set the DOCHOSTUIFLAG flags
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_DocHostFlags(  /* [in] */ ULONG pdw_doc_host_flags ) = 0;


	/*-----------------------------------------------------------
	Set the DOCHOSTUIFLAG flags
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DocHostFlags(  /* [out, retval] */ ULONG * pdw_doc_host_flags ) = 0;


	/*-----------------------------------------------------------
	Set the DOCHOSTUIDBLCLK flags
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_DocHostDoubleClickFlags(  /* [in] */ ULONG pdw_doc_host_double_click_flags ) = 0;


	/*-----------------------------------------------------------
	Set the DOCHOSTUIDBLCLK flags
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DocHostDoubleClickFlags(  /* [out, retval] */ ULONG * pdw_doc_host_double_click_flags ) = 0;


	/*-----------------------------------------------------------
	Enable or disable context menus
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_AllowContextMenu(  /* [in] */ VARIANT_BOOL pb_allow_context_menu ) = 0;


	/*-----------------------------------------------------------
	Enable or disable context menus
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AllowContextMenu(  /* [out, retval] */ VARIANT_BOOL * pb_allow_context_menu ) = 0;


	/*-----------------------------------------------------------
	Enable or disable UI
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_AllowShowUI(  /* [in] */ VARIANT_BOOL pb_allow_show_ui ) = 0;


	/*-----------------------------------------------------------
	Enable or disable UI
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AllowShowUI(  /* [out, retval] */ VARIANT_BOOL * pb_allow_show_ui ) = 0;


	/*-----------------------------------------------------------
	Set the option key path
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_OptionKeyPath(  /* [in] */ BSTR pbstr_option_key_path ) = 0;


	/*-----------------------------------------------------------
	Set the option key path
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OptionKeyPath(  /* [out, retval] */ BSTR * pbstr_option_key_path ) = 0;



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