/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLELINK_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLELINK_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleLink_FWD_DEFINED__
#define __ecom_control_library_IOleLink_FWD_DEFINED__
namespace ecom_control_library
{
class IOleLink;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

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



#ifndef __ecom_control_library_IBindCtx_FWD_DEFINED__
#define __ecom_control_library_IBindCtx_FWD_DEFINED__
namespace ecom_control_library
{
class IBindCtx;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleLink_INTERFACE_DEFINED__
#define __ecom_control_library_IOleLink_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleLink : public IUnknown
{
public:
	IOleLink () {};
	~IOleLink () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetUpdateOptions(  /* [in] */ ULONG dw_update_opt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetUpdateOptions(  /* [out] */ ULONG * pdw_update_opt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetSourceMoniker(  /* [in] */ ecom_control_library::IMoniker * pmk, /* [in] */ GUID * rclsid ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetSourceMoniker(  /* [out] */ ecom_control_library::IMoniker * * ppmk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetSourceDisplayName(  /* [in] */ LPWSTR psz_status_text ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetSourceDisplayName(  /* [out] */ LPWSTR * ppsz_display_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BindToSource(  /* [in] */ ULONG bindflags, /* [in] */ ecom_control_library::IBindCtx * pbc ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BindIfRunning( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetBoundSource(  /* [out] */ IUnknown * * ppunk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UnbindSource( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Update(  /* [in] */ ecom_control_library::IBindCtx * pbc ) = 0;



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