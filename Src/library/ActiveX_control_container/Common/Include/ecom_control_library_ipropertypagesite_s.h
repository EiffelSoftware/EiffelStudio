/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYPAGESITE_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYPAGESITE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPropertyPageSite_FWD_DEFINED__
#define __ecom_control_library_IPropertyPageSite_FWD_DEFINED__
namespace ecom_control_library
{
class IPropertyPageSite;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPropertyPageSite_INTERFACE_DEFINED__
#define __ecom_control_library_IPropertyPageSite_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPropertyPageSite : public IUnknown
{
public:
	IPropertyPageSite () {};
	~IPropertyPageSite () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnStatusChange(  /* [in] */ ULONG dw_flags ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetLocaleID(  /* [out] */ ULONG * p_locale_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetPageContainer(  /* [out] */ IUnknown * * ppunk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg ) = 0;



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