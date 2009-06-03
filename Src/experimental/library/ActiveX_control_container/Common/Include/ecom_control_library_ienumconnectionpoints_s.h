/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMCONNECTIONPOINTS_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMCONNECTIONPOINTS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IEnumConnectionPoints_FWD_DEFINED__
#define __ecom_control_library_IEnumConnectionPoints_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumConnectionPoints;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IConnectionPoint_FWD_DEFINED__
#define __ecom_control_library_IConnectionPoint_FWD_DEFINED__
namespace ecom_control_library
{
class IConnectionPoint;
}
#endif



#ifndef __ecom_control_library_IEnumConnectionPoints_FWD_DEFINED__
#define __ecom_control_library_IEnumConnectionPoints_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumConnectionPoints;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IEnumConnectionPoints_INTERFACE_DEFINED__
#define __ecom_control_library_IEnumConnectionPoints_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IEnumConnectionPoints : public IUnknown
{
public:
	IEnumConnectionPoints () {};
	~IEnumConnectionPoints () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [in] */ ULONG c_connections, /* [out] */ ecom_control_library::IConnectionPoint * * pp_cp, /* [out] */ ULONG * pc_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IEnumConnectionPoints * * ppenum ) = 0;



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
