/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECACHE2_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECACHE2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleCache2_FWD_DEFINED__
#define __ecom_control_library_IOleCache2_FWD_DEFINED__
namespace ecom_control_library
{
class IOleCache2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleCache_s.h"

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
#ifndef __ecom_control_library_IOleCache2_INTERFACE_DEFINED__
#define __ecom_control_library_IOleCache2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleCache2 : public ecom_control_library::IOleCache
{
public:
	IOleCache2 () {};
	~IOleCache2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteUpdateCache(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ ULONG grf_updf, /* [in] */ LONG p_reserved ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DiscardCache(  /* [in] */ ULONG dw_discard_options ) = 0;



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