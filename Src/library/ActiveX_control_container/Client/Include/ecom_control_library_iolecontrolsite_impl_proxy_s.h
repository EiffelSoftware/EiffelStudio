/*-----------------------------------------------------------
Implemented `IOleControlSite' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECONTROLSITE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECONTROLSITE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleControlSite_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleControlSite_s.h"

#include "ecom_control_library__POINTL_s.h"

#include "ecom_control_library_tagPOINTF_s.h"

#include "ecom_control_library_tagMSG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleControlSite_impl_proxy
{
public:
	IOleControlSite_impl_proxy (IUnknown * a_pointer);
	virtual ~IOleControlSite_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_control_info_changed();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_lock_in_place_active(  /* [in] */ EIF_INTEGER f_lock );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_extended_control(  /* [out] */ EIF_OBJECT pp_disp );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_transform_coords(  /* [in, out] */ ecom_control_library::_POINTL * p_ptl_himetric,  /* [in, out] */ ecom_control_library::tagPOINTF * p_ptf_container,  /* [in] */ EIF_INTEGER dw_flags );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_translate_accelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg,  /* [in] */ EIF_INTEGER grf_modifiers );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_on_focus(  /* [in] */ EIF_INTEGER f_got_focus );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_show_property_frame();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IOleControlSite * p_IOleControlSite;


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