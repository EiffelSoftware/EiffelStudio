/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECONTROLSITE_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECONTROLSITE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleControlSite_FWD_DEFINED__
#define __ecom_control_library_IOleControlSite_FWD_DEFINED__
namespace ecom_control_library
{
class IOleControlSite;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library__POINTL_s.h"

#include "ecom_control_library_tagPOINTF_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleControlSite_INTERFACE_DEFINED__
#define __ecom_control_library_IOleControlSite_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleControlSite : public IUnknown
{
public:
	IOleControlSite () {};
	~IOleControlSite () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnControlInfoChanged( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LockInPlaceActive(  /* [in] */ LONG f_lock ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetExtendedControl(  /* [out] */ IDispatch * * pp_disp ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TransformCoords(  /* [in, out] */ ecom_control_library::_POINTL * p_ptl_himetric, /* [in, out] */ ecom_control_library::tagPOINTF * p_ptf_container, /* [in] */ ULONG dw_flags ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg, /* [in] */ ULONG grf_modifiers ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnFocus(  /* [in] */ LONG f_got_focus ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ShowPropertyFrame( void ) = 0;



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