/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IBINDSTATUSCALLBACK_S_H__
#define __ECOM_CONTROL_LIBRARY_IBINDSTATUSCALLBACK_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IBindStatusCallback_FWD_DEFINED__
#define __ecom_control_library_IBindStatusCallback_FWD_DEFINED__
namespace ecom_control_library
{
class IBindStatusCallback;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library__tagRemBINDINFO_s.h"

#include "ecom_control_library_tagRemSTGMEDIUM_s.h"

#include "ecom_control_library_tagRemFORMATETC_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IBinding_FWD_DEFINED__
#define __ecom_control_library_IBinding_FWD_DEFINED__
namespace ecom_control_library
{
class IBinding;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IBindStatusCallback_INTERFACE_DEFINED__
#define __ecom_control_library_IBindStatusCallback_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IBindStatusCallback : public IUnknown
{
public:
	IBindStatusCallback () {};
	~IBindStatusCallback () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnStartBinding(  /* [in] */ ULONG dw_reserved, /* [in] */ ecom_control_library::IBinding * pib ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetPriority(  /* [out] */ LONG * pn_priority ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnLowResource(  /* [in] */ ULONG reserved ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnProgress(  /* [in] */ ULONG ul_progress, /* [in] */ ULONG ul_progress_max, /* [in] */ ULONG ul_status_code, /* [in] */ LPWSTR sz_status_text ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnStopBinding(  /* [in] */ HRESULT hresult, /* [in] */ LPWSTR sz_error ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetBindInfo(  /* [out] */ ULONG * grf_bindf, /* [in, out] */ ecom_control_library::_tagRemBINDINFO * pbindinfo, /* [in, out] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteOnDataAvailable(  /* [in] */ ULONG grf_bscf, /* [in] */ ULONG dw_size, /* [in] */ ecom_control_library::tagRemFORMATETC * p_formatetc, /* [in] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnObjectAvailable(  /* [in] */ GUID * riid, /* [in] */ IUnknown * punk ) = 0;



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