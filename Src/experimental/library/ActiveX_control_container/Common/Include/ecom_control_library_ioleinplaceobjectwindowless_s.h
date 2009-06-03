/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACEOBJECTWINDOWLESS_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACEOBJECTWINDOWLESS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleInPlaceObjectWindowless_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceObjectWindowless_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceObjectWindowless;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleInPlaceObject_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IDropTarget_FWD_DEFINED__
#define __ecom_control_library_IDropTarget_FWD_DEFINED__
namespace ecom_control_library
{
class IDropTarget;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleInPlaceObjectWindowless_INTERFACE_DEFINED__
#define __ecom_control_library_IOleInPlaceObjectWindowless_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceObjectWindowless : public ecom_control_library::IOleInPlaceObject
{
public:
	IOleInPlaceObjectWindowless () {};
	~IOleInPlaceObjectWindowless () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnWindowMessage(  /* [in] */ UINT msg, /* [in] */ UINT w_param, /* [in] */ LONG l_param, /* [out] */ LONG * pl_result ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetDropTarget(  /* [out] */ ecom_control_library::IDropTarget * * pp_drop_target ) = 0;



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