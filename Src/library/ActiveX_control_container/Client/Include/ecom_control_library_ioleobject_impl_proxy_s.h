/*-----------------------------------------------------------
Implemented `IOleObject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEOBJECT_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEOBJECT_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleObject_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleObject_s.h"

#include "ecom_control_library_IOleClientSite_s.h"

#include "ecom_control_library_IMoniker_s.h"

#include "ecom_control_library_IDataObject_s.h"

#include "ecom_control_library_tagMSG_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_IEnumOLEVERB_s.h"

#include "ecom_control_library_tagSIZEL_s.h"

#include "ecom_control_library_IAdviseSink_s.h"

#include "ecom_control_library_IEnumSTATDATA_s.h"

#include "ecom_control_library_tagLOGPALETTE_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleObject_impl_proxy
{
public:
	IOleObject_impl_proxy (IUnknown * a_pointer);
	virtual ~IOleObject_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_client_site(  /* [in] */ ecom_control_library::IOleClientSite * p_client_site );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_client_site(  /* [out] */ EIF_OBJECT pp_client_site );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_host_names(  /* [in] */ EIF_OBJECT sz_container_app,  /* [in] */ EIF_OBJECT sz_container_obj );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_close(  /* [in] */ EIF_INTEGER dw_save_option );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_moniker(  /* [in] */ EIF_INTEGER dw_which_moniker,  /* [in] */ ecom_control_library::IMoniker * pmk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_moniker(  /* [in] */ EIF_INTEGER dw_assign,  /* [in] */ EIF_INTEGER dw_which_moniker,  /* [out] */ EIF_OBJECT ppmk );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_init_from_data(  /* [in] */ ecom_control_library::IDataObject * p_data_object,  /* [in] */ EIF_INTEGER f_creation,  /* [in] */ EIF_INTEGER dw_reserved );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_clipboard_data(  /* [in] */ EIF_INTEGER dw_reserved,  /* [out] */ EIF_OBJECT pp_data_object );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_do_verb(  /* [in] */ EIF_INTEGER i_verb,  /* [in] */ ecom_control_library::tagMSG * lpmsg,  /* [in] */ ecom_control_library::IOleClientSite * p_active_site,  /* [in] */ EIF_INTEGER lindex,  /* [in] */ EIF_POINTER hwnd_parent,  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum_verbs(  /* [out] */ EIF_OBJECT pp_enum_ole_verb );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_update();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_is_up_to_date();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_user_class_id(  /* [out] */ GUID * p_clsid );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_user_type(  /* [in] */ EIF_INTEGER dw_form_of_type,  /* [out] */ EIF_OBJECT psz_user_type );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_extent(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [in] */ ecom_control_library::tagSIZEL * psizel );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_extent(  /* [in] */ EIF_INTEGER dw_draw_aspect,  /* [out] */ ecom_control_library::tagSIZEL * psizel );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_advise(  /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink,  /* [out] */ EIF_OBJECT pdw_connection );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_unadvise(  /* [in] */ EIF_INTEGER dw_connection );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum_advise(  /* [out] */ EIF_OBJECT ppenum_advise );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_get_misc_status(  /* [in] */ EIF_INTEGER dw_aspect,  /* [out] */ EIF_OBJECT pdw_status );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_color_scheme(  /* [in] */ ecom_control_library::tagLOGPALETTE * p_logpal );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IOleObject * p_IOleObject;


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