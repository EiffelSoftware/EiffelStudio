/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDROPSOURCE_S_H__
#define __ECOM_CONTROL_LIBRARY_IDROPSOURCE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IDropSource_FWD_DEFINED__
#define __ecom_control_library_IDropSource_FWD_DEFINED__
namespace ecom_control_library
{
class IDropSource;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IDropSource_INTERFACE_DEFINED__
#define __ecom_control_library_IDropSource_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IDropSource : public IUnknown
{
public:
	IDropSource () {};
	~IDropSource () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP QueryContinueDrag(  /* [in] */ LONG f_escape_pressed, /* [in] */ ULONG grf_key_state ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GiveFeedback(  /* [in] */ ULONG dw_effect ) = 0;



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