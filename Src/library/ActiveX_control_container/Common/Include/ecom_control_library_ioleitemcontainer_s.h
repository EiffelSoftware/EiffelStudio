/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEITEMCONTAINER_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEITEMCONTAINER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleItemContainer_FWD_DEFINED__
#define __ecom_control_library_IOleItemContainer_FWD_DEFINED__
namespace ecom_control_library
{
class IOleItemContainer;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleContainer_s.h"

#ifdef __cplusplus
extern "C" {
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
#ifndef __ecom_control_library_IOleItemContainer_INTERFACE_DEFINED__
#define __ecom_control_library_IOleItemContainer_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleItemContainer : public ecom_control_library::IOleContainer
{
public:
	IOleItemContainer () {};
	~IOleItemContainer () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetObject(  /* [in] */ LPWSTR psz_item, /* [in] */ ULONG dw_speed_needed, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ GUID * riid, /* [out] */ void * * ppv_object ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetObjectStorage(  /* [in] */ LPWSTR psz_item, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ GUID * riid, /* [out] */ void * * ppv_storage ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsRunning(  /* [in] */ LPWSTR psz_item ) = 0;



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