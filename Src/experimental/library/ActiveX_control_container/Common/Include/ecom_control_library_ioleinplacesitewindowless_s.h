/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACESITEWINDOWLESS_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACESITEWINDOWLESS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleInPlaceSiteWindowless_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceSiteWindowless_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceSiteWindowless;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleInPlaceSiteEx_s.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleInPlaceSiteWindowless_INTERFACE_DEFINED__
#define __ecom_control_library_IOleInPlaceSiteWindowless_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceSiteWindowless : public ecom_control_library::IOleInPlaceSiteEx
{
public:
	IOleInPlaceSiteWindowless () {};
	~IOleInPlaceSiteWindowless () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CanWindowlessActivate( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetCapture( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetCapture(  /* [in] */ LONG f_capture ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetFocus( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetFocus(  /* [in] */ LONG f_focus ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetDC(  /* [in] */ ecom_control_library::tagRECT * p_rect, /* [in] */ ULONG grf_flags, /* [out] */ ecom_control_library::wireHDC * ph_dc ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReleaseDC(  /* [in] */ ecom_control_library::wireHDC h_dc ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InvalidateRect(  /* [in] */ ecom_control_library::tagRECT * p_rect, /* [in] */ LONG f_erase ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InvalidateRgn(  /* [in] */ void * h_rgn, /* [in] */ LONG f_erase ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ScrollRect(  /* [in] */ INT dx, /* [in] */ INT dy, /* [in] */ ecom_control_library::tagRECT * p_rect_scroll, /* [in] */ ecom_control_library::tagRECT * p_rect_clip ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AdjustRect(  /* [in, out] */ ecom_control_library::tagRECT * prc ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnDefWindowMessage(  /* [in] */ UINT msg, /* [in] */ UINT w_param, /* [in] */ LONG l_param, /* [out] */ LONG * pl_result ) = 0;



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