/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ICONNECTIONPOINTCONTAINER_S_H__
#define __ECOM_CONTROL_LIBRARY_ICONNECTIONPOINTCONTAINER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IConnectionPointContainer_FWD_DEFINED__
#define __ecom_control_library_IConnectionPointContainer_FWD_DEFINED__
namespace ecom_control_library
{
class IConnectionPointContainer;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IEnumConnectionPoints_FWD_DEFINED__
#define __ecom_control_library_IEnumConnectionPoints_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumConnectionPoints;
}
#endif



#ifndef __ecom_control_library_IConnectionPoint_FWD_DEFINED__
#define __ecom_control_library_IConnectionPoint_FWD_DEFINED__
namespace ecom_control_library
{
class IConnectionPoint;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IConnectionPointContainer_INTERFACE_DEFINED__
#define __ecom_control_library_IConnectionPointContainer_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IConnectionPointContainer : public IUnknown
{
public:
	IConnectionPointContainer () {};
	~IConnectionPointContainer () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumConnectionPoints(  /* [out] */ ecom_control_library::IEnumConnectionPoints * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FindConnectionPoint(  /* [in] */ GUID * riid, /* [out] */ ecom_control_library::IConnectionPoint * * pp_cp ) = 0;



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