/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IADVISESINK2_S_H__
#define __ECOM_CONTROL_LIBRARY_IADVISESINK2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IAdviseSink2_FWD_DEFINED__
#define __ecom_control_library_IAdviseSink2_FWD_DEFINED__
namespace ecom_control_library
{
class IAdviseSink2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IAdviseSink_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IMoniker_FWD_DEFINED__
#define __ecom_control_library_IMoniker_FWD_DEFINED__
namespace ecom_control_library
{
class IMoniker;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IAdviseSink2_INTERFACE_DEFINED__
#define __ecom_control_library_IAdviseSink2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IAdviseSink2 : public ecom_control_library::IAdviseSink
{
public:
	IAdviseSink2 () {};
	~IAdviseSink2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteOnLinkSrcChange(  /* [in] */ ecom_control_library::IMoniker * pmk ) = 0;



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