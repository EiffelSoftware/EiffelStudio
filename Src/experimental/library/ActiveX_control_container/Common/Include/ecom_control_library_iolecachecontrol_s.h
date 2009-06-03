/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECACHECONTROL_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECACHECONTROL_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleCacheControl_FWD_DEFINED__
#define __ecom_control_library_IOleCacheControl_FWD_DEFINED__
namespace ecom_control_library
{
class IOleCacheControl;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IDataObject_FWD_DEFINED__
#define __ecom_control_library_IDataObject_FWD_DEFINED__
namespace ecom_control_library
{
class IDataObject;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleCacheControl_INTERFACE_DEFINED__
#define __ecom_control_library_IOleCacheControl_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleCacheControl : public IUnknown
{
public:
	IOleCacheControl () {};
	~IOleCacheControl () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnRun(  /* [in] */ ecom_control_library::IDataObject * p_data_object ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnStop( void ) = 0;



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