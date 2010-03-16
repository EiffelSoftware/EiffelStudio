/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEOBJECT_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEOBJECT_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleInPlaceObject_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceObject_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceObject;
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

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleInPlaceObject_INTERFACE_DEFINED__
#define __ecom_control_library_IOleInPlaceObject_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceObject : public ecom_control_library::IOleWindow
{
public:
	IOleInPlaceObject () {};
	~IOleInPlaceObject () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InPlaceDeactivate( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UIDeactivate( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetObjectRects(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect, /* [in] */ ecom_control_library::tagRECT * lprc_clip_rect ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReactivateAndUndo( void ) = 0;



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