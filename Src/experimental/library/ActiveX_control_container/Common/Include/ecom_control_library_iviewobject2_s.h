/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IVIEWOBJECT2_S_H__
#define __ECOM_CONTROL_LIBRARY_IVIEWOBJECT2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IViewObject2_FWD_DEFINED__
#define __ecom_control_library_IViewObject2_FWD_DEFINED__
namespace ecom_control_library
{
class IViewObject2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IViewObject_s.h"

#include "ecom_control_library_tagDVTARGETDEVICE_s.h"

#include "ecom_control_library_tagSIZEL_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IViewObject2_INTERFACE_DEFINED__
#define __ecom_control_library_IViewObject2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IViewObject2 : public ecom_control_library::IViewObject
{
public:
	IViewObject2 () {};
	~IViewObject2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IViewObject2_GetExtent(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ LONG lindex, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [out] */ ecom_control_library::tagSIZEL * lpsizel ) = 0;



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