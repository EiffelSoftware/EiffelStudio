/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEFRAME_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEFRAME_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleInPlaceFrame_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceFrame_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceFrame;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleInPlaceUIWindow_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagOleMenuGroupWidths_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleInPlaceFrame_INTERFACE_DEFINED__
#define __ecom_control_library_IOleInPlaceFrame_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceFrame : public ecom_control_library::IOleInPlaceUIWindow
{
public:
	IOleInPlaceFrame () {};
	~IOleInPlaceFrame () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InsertMenus(  /* [in] */ ecom_control_library::wireHMENU hmenu_shared, /* [in, out] */ ecom_control_library::tagOleMenuGroupWidths * lp_menu_widths ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetMenu(  /* [in] */ ecom_control_library::wireHMENU hmenu_shared, /* [in] */ ecom_control_library::wireHGLOBAL holemenu, /* [in] */ ecom_control_library::wireHWND hwnd_active_object ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoveMenus(  /* [in] */ ecom_control_library::wireHMENU hmenu_shared ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetStatusText(  /* [in] */ LPWSTR psz_status_text ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnableModeless(  /* [in] */ LONG f_enable ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * lpmsg, /* [in] */ USHORT w_id ) = 0;



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