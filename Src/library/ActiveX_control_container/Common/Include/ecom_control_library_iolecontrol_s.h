/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECONTROL_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECONTROL_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleControl_FWD_DEFINED__
#define __ecom_control_library_IOleControl_FWD_DEFINED__
namespace ecom_control_library
{
class IOleControl;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagCONTROLINFO_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleControl_INTERFACE_DEFINED__
#define __ecom_control_library_IOleControl_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleControl : public IUnknown
{
public:
	IOleControl () {};
	~IOleControl () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetControlInfo(  /* [out] */ ecom_control_library::tagCONTROLINFO * p_ci ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnMnemonic(  /* [in] */ ecom_control_library::tagMSG * p_msg ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnAmbientPropertyChange(  /* [in] */ LONG disp_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FreezeEvents(  /* [in] */ LONG b_freeze ) = 0;



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