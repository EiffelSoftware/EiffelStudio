/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEWINDOW_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEWINDOW_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleWindow_FWD_DEFINED__
#define __ecom_control_library_IOleWindow_FWD_DEFINED__
namespace ecom_control_library
{
class IOleWindow;
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

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleWindow_INTERFACE_DEFINED__
#define __ecom_control_library_IOleWindow_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleWindow : public IUnknown
{
public:
	IOleWindow () {};
	~IOleWindow () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetWindow(  /* [out] */ ecom_control_library::wireHWND * phwnd ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ContextSensitiveHelp(  /* [in] */ LONG f_enter_mode ) = 0;



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