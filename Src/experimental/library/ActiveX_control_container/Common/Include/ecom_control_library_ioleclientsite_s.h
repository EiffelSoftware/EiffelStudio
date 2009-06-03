/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECLIENTSITE_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECLIENTSITE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleClientSite_FWD_DEFINED__
#define __ecom_control_library_IOleClientSite_FWD_DEFINED__
namespace ecom_control_library
{
class IOleClientSite;
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



#ifndef __ecom_control_library_IOleContainer_FWD_DEFINED__
#define __ecom_control_library_IOleContainer_FWD_DEFINED__
namespace ecom_control_library
{
class IOleContainer;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleClientSite_INTERFACE_DEFINED__
#define __ecom_control_library_IOleClientSite_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleClientSite : public IUnknown
{
public:
	IOleClientSite () {};
	~IOleClientSite () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SaveObject( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetMoniker(  /* [in] */ ULONG dw_assign, /* [in] */ ULONG dw_which_moniker, /* [out] */ ecom_control_library::IMoniker * * ppmk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetContainer(  /* [out] */ ecom_control_library::IOleContainer * * pp_container ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ShowObject( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnShowWindow(  /* [in] */ LONG f_show ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RequestNewObjectLayout( void ) = 0;



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