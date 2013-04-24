/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEOBJECT_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEOBJECT_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleObject_FWD_DEFINED__
#define __ecom_control_library_IOleObject_FWD_DEFINED__
namespace ecom_control_library
{
class IOleObject;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagMSG_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_tagSIZEL_s.h"

#include "ecom_control_library_tagLOGPALETTE_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IOleClientSite_FWD_DEFINED__
#define __ecom_control_library_IOleClientSite_FWD_DEFINED__
namespace ecom_control_library
{
class IOleClientSite;
}
#endif



#ifndef __ecom_control_library_IMoniker_FWD_DEFINED__
#define __ecom_control_library_IMoniker_FWD_DEFINED__
namespace ecom_control_library
{
class IMoniker;
}
#endif



#ifndef __ecom_control_library_IDataObject_FWD_DEFINED__
#define __ecom_control_library_IDataObject_FWD_DEFINED__
namespace ecom_control_library
{
class IDataObject;
}
#endif



#ifndef __ecom_control_library_IEnumOLEVERB_FWD_DEFINED__
#define __ecom_control_library_IEnumOLEVERB_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumOLEVERB;
}
#endif



#ifndef __ecom_control_library_IAdviseSink_FWD_DEFINED__
#define __ecom_control_library_IAdviseSink_FWD_DEFINED__
namespace ecom_control_library
{
class IAdviseSink;
}
#endif



#ifndef __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
#define __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumSTATDATA;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleObject_INTERFACE_DEFINED__
#define __ecom_control_library_IOleObject_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleObject : public IUnknown
{
public:
	IOleObject () {};
	~IOleObject () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetClientSite(  /* [in] */ ecom_control_library::IOleClientSite * p_client_site ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetClientSite(  /* [out] */ ecom_control_library::IOleClientSite * * pp_client_site ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetHostNames(  /* [in] */ LPWSTR sz_container_app, /* [in] */ LPWSTR sz_container_obj ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Close(  /* [in] */ ULONG dw_save_option ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetMoniker(  /* [in] */ ULONG dw_which_moniker, /* [in] */ ecom_control_library::IMoniker * pmk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetMoniker(  /* [in] */ ULONG dw_assign, /* [in] */ ULONG dw_which_moniker, /* [out] */ ecom_control_library::IMoniker * * ppmk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InitFromData(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ LONG f_creation, /* [in] */ ULONG dw_reserved ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetClipboardData(  /* [in] */ ULONG dw_reserved, /* [out] */ ecom_control_library::IDataObject * * pp_data_object ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DoVerb(  /* [in] */ LONG i_verb, /* [in] */ ecom_control_library::tagMSG * lpmsg, /* [in] */ ecom_control_library::IOleClientSite * p_active_site, /* [in] */ LONG lindex, /* [in] */ ecom_control_library::wireHWND hwnd_parent, /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumVerbs(  /* [out] */ ecom_control_library::IEnumOLEVERB * * pp_enum_ole_verb ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Update( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsUpToDate( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetUserClassID(  /* [out] */ GUID * p_clsid ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetUserType(  /* [in] */ ULONG dw_form_of_type, /* [out] */ LPWSTR * psz_user_type ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetExtent(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ ecom_control_library::tagSIZEL * psizel ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetExtent(  /* [in] */ ULONG dw_draw_aspect, /* [out] */ ecom_control_library::tagSIZEL * psizel ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Advise(  /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink, /* [out] */ ULONG * pdw_connection ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Unadvise(  /* [in] */ ULONG dw_connection ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumAdvise(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_advise ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetMiscStatus(  /* [in] */ ULONG dw_aspect, /* [out] */ ULONG * pdw_status ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetColorScheme(  /* [in] */ ecom_control_library::tagLOGPALETTE * p_logpal ) = 0;



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