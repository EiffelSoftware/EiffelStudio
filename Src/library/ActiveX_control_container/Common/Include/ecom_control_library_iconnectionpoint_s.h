/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ICONNECTIONPOINT_S_H__
#define __ECOM_CONTROL_LIBRARY_ICONNECTIONPOINT_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IConnectionPoint_FWD_DEFINED__
#define __ecom_control_library_IConnectionPoint_FWD_DEFINED__
namespace ecom_control_library
{
class IConnectionPoint;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IConnectionPointContainer_FWD_DEFINED__
#define __ecom_control_library_IConnectionPointContainer_FWD_DEFINED__
namespace ecom_control_library
{
class IConnectionPointContainer;
}
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
#ifndef __ecom_control_library_IConnectionPoint_INTERFACE_DEFINED__
#define __ecom_control_library_IConnectionPoint_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IConnectionPoint : public IUnknown
{
public:
	IConnectionPoint () {};
	~IConnectionPoint () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetConnectionInterface(  /* [out] */ GUID * p_iid ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetConnectionPointContainer(  /* [out] */ ecom_control_library::IConnectionPointContainer * * pp_cpc ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Advise(  /* [in] */ IUnknown * p_unk_sink, /* [out] */ ULONG * pdw_cookie ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Unadvise(  /* [in] */ ULONG dw_cookie ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumConnections(  /* [out] */ ecom_control_library::IEnumConnections * * ppenum ) = 0;



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