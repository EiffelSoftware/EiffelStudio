/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYPAGE2_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYPAGE2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPropertyPage2_FWD_DEFINED__
#define __ecom_control_library_IPropertyPage2_FWD_DEFINED__
namespace ecom_control_library
{
class IPropertyPage2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPropertyPage_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPropertyPage2_INTERFACE_DEFINED__
#define __ecom_control_library_IPropertyPage2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPropertyPage2 : public ecom_control_library::IPropertyPage
{
public:
	IPropertyPage2 () {};
	~IPropertyPage2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EditProperty(  /* [in] */ LONG disp_id ) = 0;



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