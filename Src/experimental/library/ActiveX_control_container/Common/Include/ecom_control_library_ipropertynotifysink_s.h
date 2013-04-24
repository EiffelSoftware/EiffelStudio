/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYNOTIFYSINK_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYNOTIFYSINK_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPropertyNotifySink_FWD_DEFINED__
#define __ecom_control_library_IPropertyNotifySink_FWD_DEFINED__
namespace ecom_control_library
{
class IPropertyNotifySink;
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
#ifndef __ecom_control_library_IPropertyNotifySink_INTERFACE_DEFINED__
#define __ecom_control_library_IPropertyNotifySink_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPropertyNotifySink : public IUnknown
{
public:
	IPropertyNotifySink () {};
	~IPropertyNotifySink () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnChanged(  /* [in] */ LONG disp_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnRequestEdit(  /* [in] */ LONG disp_id ) = 0;



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