/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYPAGE_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYPAGE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPropertyPage_FWD_DEFINED__
#define __ecom_control_library_IPropertyPage_FWD_DEFINED__
namespace ecom_control_library
{
class IPropertyPage;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_tagPROPPAGEINFO_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IPropertyPageSite_FWD_DEFINED__
#define __ecom_control_library_IPropertyPageSite_FWD_DEFINED__
namespace ecom_control_library
{
class IPropertyPageSite;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPropertyPage_INTERFACE_DEFINED__
#define __ecom_control_library_IPropertyPage_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPropertyPage : public IUnknown
{
public:
	IPropertyPage () {};
	~IPropertyPage () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetPageSite(  /* [in] */ ecom_control_library::IPropertyPageSite * p_page_site ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Activate(  /* [in] */ ecom_control_library::wireHWND hwnd_parent, /* [in] */ ecom_control_library::tagRECT * p_rect, /* [in] */ LONG b_modal ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Deactivate( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetPageInfo(  /* [out] */ ecom_control_library::tagPROPPAGEINFO * p_page_info ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetObjects(  /* [in] */ ULONG c_objects, /* [in] */ IUnknown * * ppunk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Show(  /* [in] */ UINT n_cmd_show ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Move(  /* [in] */ ecom_control_library::tagRECT * p_rect ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsPageDirty( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Apply( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Help(  /* [in] */ LPWSTR psz_help_dir ) = 0;


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