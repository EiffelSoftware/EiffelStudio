/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEINPLACESITEEX_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEINPLACESITEEX_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleInPlaceSiteEx_FWD_DEFINED__
#define __ecom_control_library_IOleInPlaceSiteEx_FWD_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceSiteEx;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleInPlaceSite_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleInPlaceSiteEx_INTERFACE_DEFINED__
#define __ecom_control_library_IOleInPlaceSiteEx_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleInPlaceSiteEx : public ecom_control_library::IOleInPlaceSite
{
public:
	IOleInPlaceSiteEx () {};
	~IOleInPlaceSiteEx () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnInPlaceActivateEx(  /* [out] */ LONG * pf_no_redraw, /* [in] */ ULONG dw_flags ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnInPlaceDeactivateEx(  /* [in] */ LONG f_no_redraw ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RequestUIActivate( void ) = 0;



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