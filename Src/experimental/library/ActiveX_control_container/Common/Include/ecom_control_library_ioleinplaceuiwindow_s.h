/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEUIWINDOW_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEUIWINDOW_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleInPlaceUIWindow_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceUIWindow_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceUIWindow;
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

#ifndef __ecom_control_library_IOleInPlaceActiveObject_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceActiveObject_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceActiveObject;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleInPlaceUIWindow_INTERFACE_DEFINED__
#define __ecom_control_library_IOleInPlaceUIWindow_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceUIWindow : public ecom_control_library::IOleWindow
{
public:
	IOleInPlaceUIWindow () {};
	~IOleInPlaceUIWindow () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetBorder(  /* [out] */ ecom_control_library::tagRECT * lprect_border ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RequestBorderSpace(  /* [in] */ ecom_control_library::tagRECT * pborderwidths ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetBorderSpace(  /* [in] */ ecom_control_library::tagRECT * pborderwidths ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetActiveObject(  /* [in] */ ecom_control_library::IOleInPlaceActiveObject * p_active_object, /* [in] */ LPWSTR psz_obj_name ) = 0;



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