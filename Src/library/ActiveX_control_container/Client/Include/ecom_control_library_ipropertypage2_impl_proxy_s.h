/*-----------------------------------------------------------
Implemented `IPropertyPage2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYPAGE2_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYPAGE2_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPropertyPage2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPropertyPage2_s.h"

#include "ecom_control_library_IPropertyPageSite_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_tagPROPPAGEINFO_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPropertyPage2_impl_proxy
{
public:
	IPropertyPage2_impl_proxy (IUnknown * a_pointer);
	virtual ~IPropertyPage2_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_page_site(  /* [in] */ ecom_control_library::IPropertyPageSite * p_page_site );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_activate(  /* [in] */ EIF_POINTER hwnd_parent,  /* [in] */ ecom_control_library::tagRECT * p_rect,  /* [in] */ EIF_INTEGER b_modal );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_deactivate();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_page_info(  /* [out] */ ecom_control_library::tagPROPPAGEINFO * p_page_info );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_objects(  /* [in] */ EIF_INTEGER c_objects,  /* [in] */ EIF_OBJECT ppunk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_show(  /* [in] */ EIF_INTEGER n_cmd_show );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_move(  /* [in] */ ecom_control_library::tagRECT * p_rect );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_is_page_dirty();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_apply();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_help(  /* [in] */ EIF_OBJECT psz_help_dir );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_translate_accelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_edit_property(  /* [in] */ EIF_INTEGER disp_id );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IPropertyPage2 * p_IPropertyPage2;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif