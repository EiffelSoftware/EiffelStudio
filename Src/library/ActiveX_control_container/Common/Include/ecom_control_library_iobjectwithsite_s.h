/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOBJECTWITHSITE_S_H__
#define __ECOM_CONTROL_LIBRARY_IOBJECTWITHSITE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IObjectWithSite_FWD_DEFINED__
#define __ecom_control_library_IObjectWithSite_FWD_DEFINED__
namespace ecom_control_library
{
class IObjectWithSite;
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
#ifndef __ecom_control_library_IObjectWithSite_INTERFACE_DEFINED__
#define __ecom_control_library_IObjectWithSite_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IObjectWithSite : public IUnknown
{
public:
	IObjectWithSite () {};
	~IObjectWithSite () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetSite(  /* [in] */ IUnknown * p_unk_site ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetSite(  /* [in] */ GUID * riid, /* [out] */ void * * ppv_site ) = 0;



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