/*-----------------------------------------------------------
Implemented `IOleObject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEOBJECT_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEOBJECT_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleObject_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IOleObject_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleObject_impl_stub : public ecom_control_library::IOleObject
{
public:
  IOleObject_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IOleObject_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetClientSite(  /* [in] */ ecom_control_library::IOleClientSite * p_client_site );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetClientSite(  /* [out] */ ecom_control_library::IOleClientSite * * pp_client_site );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetHostNames(  /* [in] */ LPWSTR sz_container_app, /* [in] */ LPWSTR sz_container_obj );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Close(  /* [in] */ ULONG dw_save_option );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetMoniker(  /* [in] */ ULONG dw_which_moniker, /* [in] */ ecom_control_library::IMoniker * pmk );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetMoniker(  /* [in] */ ULONG dw_assign, /* [in] */ ULONG dw_which_moniker, /* [out] */ ecom_control_library::IMoniker * * ppmk );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP InitFromData(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ LONG f_creation, /* [in] */ ULONG dw_reserved );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetClipboardData(  /* [in] */ ULONG dw_reserved, /* [out] */ ecom_control_library::IDataObject * * pp_data_object );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DoVerb(  /* [in] */ LONG i_verb, /* [in] */ ecom_control_library::tagMSG * lpmsg, /* [in] */ ecom_control_library::IOleClientSite * p_active_site, /* [in] */ LONG lindex, /* [in] */ ecom_control_library::wireHWND hwnd_parent, /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnumVerbs(  /* [out] */ ecom_control_library::IEnumOLEVERB * * pp_enum_ole_verb );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Update( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IsUpToDate( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetUserClassID(  /* [out] */ GUID * p_clsid );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetUserType(  /* [in] */ ULONG dw_form_of_type, /* [out] */ LPWSTR * psz_user_type );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetExtent(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ ecom_control_library::tagSIZEL * psizel );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetExtent(  /* [in] */ ULONG dw_draw_aspect, /* [out] */ ecom_control_library::tagSIZEL * psizel );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Advise(  /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink, /* [out] */ ULONG * pdw_connection );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Unadvise(  /* [in] */ ULONG dw_connection );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnumAdvise(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_advise );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetMiscStatus(  /* [in] */ ULONG dw_aspect, /* [out] */ ULONG * pdw_status );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP SetColorScheme(  /* [in] */ ecom_control_library::tagLOGPALETTE * p_logpal );


  /*-----------------------------------------------------------
  Decrement reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) Release();


  /*-----------------------------------------------------------
  Increment reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) AddRef();


  /*-----------------------------------------------------------
  Query Interface
  -----------------------------------------------------------*/
  STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
  /*-----------------------------------------------------------
  Reference counter
  -----------------------------------------------------------*/
  LONG ref_count;


  /*-----------------------------------------------------------
  Corresponding Eiffel object
  -----------------------------------------------------------*/
  EIF_OBJECT eiffel_object;


  /*-----------------------------------------------------------
  Eiffel type id
  -----------------------------------------------------------*/
  EIF_TYPE_ID type_id;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
