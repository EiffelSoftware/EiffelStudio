/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEACTIVEOBJECT_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEACTIVEOBJECT_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleInPlaceActiveObject_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceActiveObject_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceActiveObject;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleWindow_s.h"

#include "ecom_control_library_tagRECT_s.h"

#ifdef __cplusplus
extern "C" {
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
#ifndef __ecom_control_library_IOleInPlaceActiveObject_INTERFACE_DEFINED__
#define __ecom_control_library_IOleInPlaceActiveObject_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceActiveObject : public ecom_control_library::IOleWindow
{
public:
  IOleInPlaceActiveObject () {};
  ~IOleInPlaceActiveObject () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP TranslateAccelerator( void ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP OnFrameWindowActivate(  /* [in] */ LONG f_activate ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP OnDocWindowActivate(  /* [in] */ LONG f_activate ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP ResizeBorder
          (  /* [in] */ ecom_control_library::tagRECT * prc_border, 
          /* [in] */ REFIID riid, 
          /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_uiwindow, 
          /* [in] */ LONG f_frame_window ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP EnableModeless(  /* [in] */ LONG f_enable ) = 0;



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
