/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IBINDING_S_H__
#define __ECOM_CONTROL_LIBRARY_IBINDING_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IBinding_FWD_DEFINED__
#define __ecom_control_library_IBinding_FWD_DEFINED__
namespace ecom_control_library
{
class IBinding;
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
#ifndef __ecom_control_library_IBinding_INTERFACE_DEFINED__
#define __ecom_control_library_IBinding_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IBinding : public IUnknown
{
public:
	IBinding () {};
	~IBinding () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Abort( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Suspend( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Resume( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetPriority(  /* [in] */ LONG n_priority ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetPriority(  /* [out] */ LONG * pn_priority ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetBindResult(  /* [out] */ GUID * pclsid_protocol, /* [out] */ ULONG * pdw_result, /* [out] */ LPWSTR * psz_result, /* [in] */ ULONG dw_reserved ) = 0;



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