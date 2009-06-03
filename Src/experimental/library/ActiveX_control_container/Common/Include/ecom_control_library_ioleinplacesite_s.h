/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACESITE_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACESITE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleInPlaceSite_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceSite_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceSite;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleWindow_s.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_tagOIFI_s.h"

#include "ecom_control_library_tagSIZE_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IOleInPlaceFrame_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceFrame_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceFrame;
}
#endif



#ifndef __ecom_control_library_IOleInPlaceUIWindow_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceUIWindow_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceUIWindow;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleInPlaceSite_INTERFACE_DEFINED__
#define __ecom_control_library_IOleInPlaceSite_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceSite : public ecom_control_library::IOleWindow
{
public:
	IOleInPlaceSite () {};
	~IOleInPlaceSite () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CanInPlaceActivate( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnInPlaceActivate( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnUIActivate( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetWindowContext(  /* [out] */ ecom_control_library::IOleInPlaceFrame * * pp_frame, /* [out] */ ecom_control_library::IOleInPlaceUIWindow * * pp_doc, /* [out] */ ecom_control_library::tagRECT * lprc_pos_rect, /* [out] */ ecom_control_library::tagRECT * lprc_clip_rect, /* [in, out] */ ecom_control_library::tagOIFI * lp_frame_info ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Scroll(  /* [in] */ ecom_control_library::tagSIZE scroll_extant ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnUIDeactivate(  /* [in] */ LONG f_undoable ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnInPlaceDeactivate( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DiscardUndoState( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DeactivateAndUndo( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnPosRectChange(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect ) = 0;



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