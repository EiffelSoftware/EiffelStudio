/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLER_S_H__
#define __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IDocHostUIHandler_FWD_DEFINED__
#define __ecom_control_library_IDocHostUIHandler_FWD_DEFINED__
namespace ecom_control_library
{
class IDocHostUIHandler;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagPOINT_s.h"

#include "ecom_control_library__DOCHOSTUIINFO_s.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IOleInPlaceActiveObject_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceActiveObject_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceActiveObject;
}
#endif



#ifndef __ecom_control_library_IOleCommandTarget_FWD_DEFINED__
#define __ecom_control_library_IOleCommandTarget_FWD_DEFINED__
namespace ecom_control_library
{
class IOleCommandTarget;
}
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



#ifndef __ecom_control_library_IDropTarget_FWD_DEFINED__
#define __ecom_control_library_IDropTarget_FWD_DEFINED__
namespace ecom_control_library
{
class IDropTarget;
}
#endif



#ifndef __ecom_control_library_IDataObject_FWD_DEFINED__
#define __ecom_control_library_IDataObject_FWD_DEFINED__
namespace ecom_control_library
{
class IDataObject;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IDocHostUIHandler_INTERFACE_DEFINED__
#define __ecom_control_library_IDocHostUIHandler_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IDocHostUIHandler : public IUnknown
{
public:
  IDocHostUIHandler () {};
  ~IDocHostUIHandler () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP ShowContextMenu(  /* [in] */ ULONG dw_id, /* [in] */ ecom_control_library::tagPOINT * ppt, /* [in] */ IUnknown * pcmdt_reserved, /* [in] */ IDispatch * pdisp_reserved ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetHostInfo(  /* [in, out] */ ecom_control_library::_DOCHOSTUIINFO * p_info ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP ShowUI(  /* [in] */ ULONG dw_id, /* [in] */ ecom_control_library::IOleInPlaceActiveObject * p_active_object, /* [in] */ ecom_control_library::IOleCommandTarget * p_command_target, /* [in] */ ecom_control_library::IOleInPlaceFrame * p_frame, /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_doc ) = 0;


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
  virtual STDMETHODIMP EnableModeless(  /* [in] */ LONG f_enable ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP OnDocWindowActivate(  /* [in] */ LONG f_activate ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP OnFrameWindowActivate(  /* [in] */ LONG f_activate ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP ResizeBorder(  /* [in] */ ecom_control_library::tagRECT * prc_border, /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_uiwindow, /* [in] */ LONG f_rame_window ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP IDocHostUIHandler_TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * lpmsg, /* [in] */ GUID * pguid_cmd_group, /* [in] */ ULONG n_cmd_id ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetOptionKeyPath(  /* [out] */ LPWSTR * pch_key, /* [in] */ ULONG dw ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetDropTarget(  /* [in] */ ecom_control_library::IDropTarget * p_drop_target, /* [out] */ ecom_control_library::IDropTarget * * pp_drop_target ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetExternal(  /* [out] */ IDispatch * * pp_dispatch ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP TranslateUrl(  /* [in] */ ULONG dw_translate, /* [in] */ OLECHAR * pch_urlin, /* [out] */ OLECHAR * * ppch_urlout ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP FilterDataObject(  /* [in] */ ecom_control_library::IDataObject * p_do, /* [out] */ ecom_control_library::IDataObject * * pp_doret ) = 0;



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
