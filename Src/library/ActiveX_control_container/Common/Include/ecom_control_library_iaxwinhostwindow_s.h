/*-----------------------------------------------------------
IAxWinHostWindow Interface Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IAXWINHOSTWINDOW_S_H__
#define __ECOM_CONTROL_LIBRARY_IAXWINHOSTWINDOW_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IAxWinHostWindow_FWD_DEFINED__
#define __ecom_control_library_IAxWinHostWindow_FWD_DEFINED__
namespace ecom_control_library
{
class IAxWinHostWindow;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IStream_FWD_DEFINED__
#define __ecom_control_library_IStream_FWD_DEFINED__
namespace ecom_control_library
{
class IStream;
}
#endif



#ifndef __ecom_control_library_IDocHostUIHandlerDispatch_FWD_DEFINED__
#define __ecom_control_library_IDocHostUIHandlerDispatch_FWD_DEFINED__
namespace ecom_control_library
{
class IDocHostUIHandlerDispatch;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IAxWinHostWindow_INTERFACE_DEFINED__
#define __ecom_control_library_IAxWinHostWindow_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IAxWinHostWindow : public IUnknown
{
public:
  IAxWinHostWindow () {};
  ~IAxWinHostWindow () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP CreateControl
        (  /* [in] */ LPWSTR lp_trics_data, 
        /* [in] */ ecom_control_library::wireHWND h_wnd, 
        /* [in] */ ecom_control_library::IStream * p_stream ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP CreateControlEx
      (  /* [in] */ LPWSTR lp_trics_data, 
      /* [in] */ ecom_control_library::wireHWND h_wnd, 
      /* [in] */ ecom_control_library::IStream * p_stream, 
      /* [out] */ IUnknown * * ppunk, 
      /* [in] */ REFIID riid_advise, 
      /* [in] */ IUnknown * punk_advise ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP AttachControl(  /* [in] */ IUnknown * p_unk_control, /* [in] */ ecom_control_library::wireHWND h_wnd ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP QueryControl(  /* [in] */ GUID * riid, /* [out] */ void * * ppv_object ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP SetExternalDispatch(  /* [in] */ IDispatch * p_disp ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP SetExternalUIHandler(  /* [in] */ ecom_control_library::IDocHostUIHandlerDispatch * p_disp ) = 0;



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
