/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMCONNECTIONS_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMCONNECTIONS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IEnumConnections_FWD_DEFINED__
#define __ecom_control_library_IEnumConnections_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumConnections;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagCONNECTDATA_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IEnumConnections_FWD_DEFINED__
#define __ecom_control_library_IEnumConnections_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumConnections;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IEnumConnections_INTERFACE_DEFINED__
#define __ecom_control_library_IEnumConnections_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IEnumConnections : public IUnknown
{
public:
	IEnumConnections () {};
	~IEnumConnections () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteNext(  /* [in] */ ULONG c_connections, /* [out] */ ecom_control_library::tagCONNECTDATA * rgcd, /* [out] */ ULONG * pc_fetched ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG c_connections ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IEnumConnections * * ppenum ) = 0;



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