/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISERVICEPROVIDER_S_H__
#define __ECOM_CONTROL_LIBRARY_ISERVICEPROVIDER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IServiceProvider_FWD_DEFINED__
#define __ecom_control_library_IServiceProvider_FWD_DEFINED__
namespace ecom_control_library
{
class IServiceProvider;
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
#ifndef __ecom_control_library_IServiceProvider_INTERFACE_DEFINED__
#define __ecom_control_library_IServiceProvider_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IServiceProvider : public IUnknown
{
public:
	IServiceProvider () {};
	~IServiceProvider () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteQueryService(  /* [in] */ GUID * guid_service, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_object ) = 0;



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