/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IEXTERNALCONNECTION_S_H__
#define __ECOM_CONTROL_LIBRARY_IEXTERNALCONNECTION_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IExternalConnection_FWD_DEFINED__
#define __ecom_control_library_IExternalConnection_FWD_DEFINED__
namespace ecom_control_library
{
class IExternalConnection;
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
#ifndef __ecom_control_library_IExternalConnection_INTERFACE_DEFINED__
#define __ecom_control_library_IExternalConnection_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IExternalConnection : public IUnknown
{
public:
	IExternalConnection () {};
	~IExternalConnection () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP_(ULONG) AddConnection(  /* [in] */ ULONG extconn, /* [in] */ ULONG reserved ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP_(ULONG) ReleaseConnection(  /* [in] */ ULONG extconn, /* [in] */ ULONG reserved, /* [in] */ LONG f_last_release_closes ) = 0;



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