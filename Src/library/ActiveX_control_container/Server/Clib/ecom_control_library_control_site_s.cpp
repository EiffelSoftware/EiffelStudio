/*-----------------------------------------------------------
Control Site Control interfaces. Help file: 
-----------------------------------------------------------*/

#include "ecom_control_library_control_site_s.h"
static int return_hr_value;

static const CLSID CLSID_control_site_ = {0x3dce6182,0x49ec,0x4033,{0xb6,0x5a,0x58,0x35,0x48,0x57,0xf9,0xb5}};

static const IID IID_IOleClientSite_ = {0x00000118,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IOleInPlaceSiteWindowless_ = {0x922eada0,0x3424,0x11cf,{0xb6,0x70,0x00,0xaa,0x00,0x4c,0xd6,0xd8}};

static const IID IID_IOleInPlaceSiteEx_ = {0x9c2cad80,0x3424,0x11cf,{0xb6,0x70,0x00,0xaa,0x00,0x4c,0xd6,0xd8}};

static const IID IID_IOleInPlaceSite_ = {0x00000119,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IOleWindow_ = {0x00000114,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IOleControlSite_ = {0xb196b289,0xbab4,0x101a,{0xb6,0x9c,0x00,0xaa,0x00,0x34,0x1d,0x07}};

static const IID IID_IOleContainer_ = {0x0000011b,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IObjectWithSite_ = {0xfc4801a3,0x2ba9,0x11cf,{0xa2,0x29,0x00,0xaa,0x00,0x3d,0x73,0x52}};

static const IID IID_IPropertyNotifySink_ = {0x9bfbbc02,0xeff1,0x101a,{0x84,0xed,0x00,0xaa,0x00,0x34,0x1d,0x07}};

static const IID IID_IAxWinAmbientDispatch_ = {0xb6ea2051,0x048a,0x11d1,{0x82,0xb9,0x00,0xc0,0x4f,0xb9,0x94,0x2e}};

static const IID IID_IDocHostUIHandler_ = {0xbd3f23c0,0xd43e,0x11cf,{0x89,0x3b,0x00,0xaa,0x00,0xbd,0xce,0x1a}};

static const IID IID_IAdviseSink_ = {0x0000010f,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IServiceProvider_ = {0x6d5140c1,0x7436,0x11ce,{0x80,0x34,0x00,0xaa,0x00,0x60,0x09,0xfa}};

static const IID LIBID_control_library_ = {0xbde3247e,0x6bc6,0x47f4,{0xa4,0x6f,0xe5,0xae,0xa4,0xf8,0xdf,0x39}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::control_site::control_site( EIF_TYPE_ID tid )
{
  ::OleInitialize (NULL);
  type_id = tid;
  ref_count = 0;
  eiffel_object = eif_create (type_id);
  EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("make_from_pointer", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);
  pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::control_site::control_site( EIF_OBJECT eif_obj )
{
  ::OleInitialize (NULL);
  ref_count = 0;
  eiffel_object = eif_adopt (eif_obj);
  type_id = eif_type (eiffel_object);
  
  pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::control_site::~control_site()
{
  EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("set_item", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
  eif_wean (eiffel_object);
  if (pTypeInfo)
    pTypeInfo->Release ();
  
  ::OleUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::SaveObject( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("save_object", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetMoniker(  /* [in] */ ULONG dw_assign, /* [in] */ ULONG dw_which_moniker, /* [out] */ ::IMoniker * * ppmk )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_dw_assign = (EIF_INTEGER)dw_assign;
  EIF_INTEGER tmp_dw_which_moniker = (EIF_INTEGER)dw_which_moniker;
  EIF_OBJECT tmp_ppmk = NULL;
  if (ppmk != NULL)
  {
    tmp_ppmk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk, NULL));
    if (*ppmk != NULL)
      (*ppmk)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_moniker", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_assign, (EIF_INTEGER)tmp_dw_which_moniker, ((tmp_ppmk != NULL) ? eif_access (tmp_ppmk) : NULL));
  
  if (*ppmk != NULL)
    (*ppmk)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk != NULL) ? eif_wean (tmp_ppmk) : NULL), ppmk);
  if (*ppmk != NULL)
    (*ppmk)->AddRef ();
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetContainer(  /* [out] */ ::IOleContainer * * pp_container )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pp_container = NULL;
  if (pp_container != NULL)
  {
    tmp_pp_container = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_188 (pp_container, NULL));
    if (*pp_container != NULL)
      (*pp_container)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_container", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_container != NULL) ? eif_access (tmp_pp_container) : NULL));
  
  if (*pp_container != NULL)
    (*pp_container)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_188 (((tmp_pp_container != NULL) ? eif_wean (tmp_pp_container) : NULL), pp_container);
  if (*pp_container != NULL)
    (*pp_container)->AddRef ();
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ShowObject( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("show_object", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnShowWindow(  /* [in] */ BOOL  f_show )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_show = (EIF_INTEGER)f_show;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_show_window", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_show);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::RequestNewObjectLayout( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("request_new_object_layout", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetWindow(  /* [out] */ HWND * phwnd )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_phwnd = NULL;
  if (phwnd != NULL)
  {
    tmp_phwnd = eif_protect (rt_ce.ccom_ce_pointed_pointer ((void **)phwnd, NULL));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_window", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_phwnd != NULL) ? eif_access (tmp_phwnd) : NULL));
  
  if ((tmp_phwnd != NULL) && (eif_access (tmp_phwnd) != NULL))
  rt_ec.ccom_ec_pointed_pointer (eif_wean (tmp_phwnd), (void **)phwnd);

  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ContextSensitiveHelp(  /* [in] */ BOOL  f_enter_mode )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_enter_mode = (EIF_INTEGER)f_enter_mode;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("context_sensitive_help", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_enter_mode);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::CanInPlaceActivate( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("can_in_place_activate", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnInPlaceActivate( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("on_in_place_activate", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnUIActivate( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("on_uiactivate", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetWindowContext(  /* [out] */ ::IOleInPlaceFrame * * pp_frame, /* [out] */ ::IOleInPlaceUIWindow * * pp_doc, /* [out] */ ::tagRECT * lprc_pos_rect, /* [out] */ ::tagRECT * lprc_clip_rect, /* [in, out] */ ::tagOIFI * lp_frame_info )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pp_frame = NULL;
  if (pp_frame != NULL)
  {
    tmp_pp_frame = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_226 (pp_frame, NULL));
    if (*pp_frame != NULL)
      (*pp_frame)->AddRef ();
  }
  EIF_OBJECT tmp_pp_doc = NULL;
  if (pp_doc != NULL)
  {
    tmp_pp_doc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_227 (pp_doc, NULL));
    if (*pp_doc != NULL)
      (*pp_doc)->AddRef ();
  }
  EIF_OBJECT tmp_lprc_pos_rect = NULL;
  if (lprc_pos_rect != NULL)
  {
    tmp_lprc_pos_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)lprc_pos_rect));
  }
  EIF_OBJECT tmp_lprc_clip_rect = NULL;
  if (lprc_clip_rect != NULL)
  {
    tmp_lprc_clip_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)lprc_clip_rect));
  }
  EIF_OBJECT tmp_lp_frame_info = NULL;
  if (lp_frame_info != NULL)
  {
    tmp_lp_frame_info = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_229 ((ecom_control_library::tagOIFI *)lp_frame_info));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_window_context", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_frame != NULL) ? eif_access (tmp_pp_frame) : NULL), ((tmp_pp_doc != NULL) ? eif_access (tmp_pp_doc) : NULL), ((tmp_lprc_pos_rect != NULL) ? eif_access (tmp_lprc_pos_rect) : NULL), ((tmp_lprc_clip_rect != NULL) ? eif_access (tmp_lprc_clip_rect) : NULL), ((tmp_lp_frame_info != NULL) ? eif_access (tmp_lp_frame_info) : NULL));
  
  if (*pp_frame != NULL)
    (*pp_frame)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_226 (((tmp_pp_frame != NULL) ? eif_wean (tmp_pp_frame) : NULL), pp_frame);
  if (*pp_frame != NULL)
    (*pp_frame)->AddRef ();
  
  if (*pp_doc != NULL)
    (*pp_doc)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_227 (((tmp_pp_doc != NULL) ? eif_wean (tmp_pp_doc) : NULL), pp_doc);
  if (*pp_doc != NULL)
    (*pp_doc)->AddRef ();
  
  
  
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::Scroll(  /* [in] */ ::tagSIZE scroll_extant )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_scroll_extant = NULL;
  tmp_scroll_extant = eif_protect (grt_ce_control_interfaces2.ccom_ce_record_tag_size_record230 (*((ecom_control_library::tagSIZE*)&scroll_extant)));
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("scroll", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_scroll_extant != NULL) ? eif_access (tmp_scroll_extant) : NULL));
  if (tmp_scroll_extant != NULL)
    eif_wean (tmp_scroll_extant);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnUIDeactivate(  /* [in] */ BOOL f_undoable )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_undoable = (EIF_INTEGER)f_undoable;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_uideactivate", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_undoable);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnInPlaceDeactivate( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("on_in_place_deactivate", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::DiscardUndoState( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("discard_undo_state", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::DeactivateAndUndo( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("deactivate_and_undo", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnPosRectChange(  /* [in] */const ::tagRECT * lprc_pos_rect )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_lprc_pos_rect = NULL;
  if (lprc_pos_rect != NULL)
  {
    tmp_lprc_pos_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)lprc_pos_rect));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_pos_rect_change", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lprc_pos_rect != NULL) ? eif_access (tmp_lprc_pos_rect) : NULL));
  if (tmp_lprc_pos_rect != NULL)
    eif_wean (tmp_lprc_pos_rect);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnInPlaceActivateEx(  /* [out] */ BOOL * pf_no_redraw, /* [in] */ ULONG dw_flags )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pf_no_redraw = NULL;
  if (pf_no_redraw != NULL)
  {
    tmp_pf_no_redraw = eif_protect (rt_ce.ccom_ce_pointed_long ((LONG*)pf_no_redraw, NULL));
  }
  EIF_INTEGER tmp_dw_flags = (EIF_INTEGER)dw_flags;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_in_place_activate_ex", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pf_no_redraw != NULL) ? eif_access (tmp_pf_no_redraw) : NULL), (EIF_INTEGER)tmp_dw_flags);
  rt_ec.ccom_ec_pointed_long (((tmp_pf_no_redraw != NULL) ? eif_wean (tmp_pf_no_redraw) : NULL), (LONG*)pf_no_redraw);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnInPlaceDeactivateEx(  /* [in] */ BOOL f_no_redraw )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_no_redraw = (EIF_INTEGER)f_no_redraw;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_in_place_deactivate_ex", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_no_redraw);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::RequestUIActivate( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("request_uiactivate", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::CanWindowlessActivate( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("can_windowless_activate", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetCapture( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("get_capture", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::SetCapture(  /* [in] */ BOOL f_capture )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_capture = (EIF_INTEGER)f_capture;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_capture", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_capture);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetFocus( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("get_focus", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::SetFocus(  /* [in] */ BOOL f_focus )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_focus = (EIF_INTEGER)f_focus;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_focus", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_focus);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetDC(  /* [in] */const ::tagRECT * p_rect, /* [in] */ ULONG grf_flags, /* [out] */ HDC * ph_dc )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_rect = NULL;
  if (p_rect != NULL)
  {
    tmp_p_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)p_rect));
  }
  EIF_INTEGER tmp_grf_flags = (EIF_INTEGER)grf_flags;
  EIF_OBJECT tmp_ph_dc = NULL;
  if (ph_dc != NULL)
  {
    tmp_ph_dc = eif_protect (rt_ce.ccom_ce_pointed_pointer ((void **)ph_dc, NULL));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_dc", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_rect != NULL) ? eif_access (tmp_p_rect) : NULL), (EIF_INTEGER)tmp_grf_flags, ((tmp_ph_dc != NULL) ? eif_access (tmp_ph_dc) : NULL));
  
  if (tmp_p_rect != NULL)
    eif_wean (tmp_p_rect);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ReleaseDC(  /* [in] */ HDC h_dc )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_POINTER tmp_h_dc = (EIF_POINTER)h_dc;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("release_dc", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)tmp_h_dc);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::InvalidateRect(  /* [in] */const ::tagRECT * p_rect, /* [in] */ BOOL f_erase )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_rect = NULL;
  if (p_rect != NULL)
  {
    tmp_p_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)p_rect));
  }
  EIF_INTEGER tmp_f_erase = (EIF_INTEGER)f_erase;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("invalidate_rect", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_rect != NULL) ? eif_access (tmp_p_rect) : NULL), (EIF_INTEGER)tmp_f_erase);
  if (tmp_p_rect != NULL)
    eif_wean (tmp_p_rect);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::InvalidateRgn(  /* [in] */ HRGN  h_rgn, /* [in] */ BOOL f_erase )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_POINTER tmp_h_rgn = (EIF_POINTER)h_rgn;
  EIF_INTEGER tmp_f_erase = (EIF_INTEGER)f_erase;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("invalidate_rgn", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)tmp_h_rgn, (EIF_INTEGER)tmp_f_erase);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ScrollRect(  /* [in] */ INT dx, /* [in] */ INT dy, /* [in] */const ::tagRECT * p_rect_scroll, /* [in] */const ::tagRECT * p_rect_clip )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_dx = (EIF_INTEGER)dx;
  EIF_INTEGER tmp_dy = (EIF_INTEGER)dy;
  EIF_OBJECT tmp_p_rect_scroll = NULL;
  if (p_rect_scroll != NULL)
  {
    tmp_p_rect_scroll = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)p_rect_scroll));
  }
  EIF_OBJECT tmp_p_rect_clip = NULL;
  if (p_rect_clip != NULL)
  {
    tmp_p_rect_clip = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)p_rect_clip));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("scroll_rect", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dx, (EIF_INTEGER)tmp_dy, ((tmp_p_rect_scroll != NULL) ? eif_access (tmp_p_rect_scroll) : NULL), ((tmp_p_rect_clip != NULL) ? eif_access (tmp_p_rect_clip) : NULL));
  if (tmp_p_rect_scroll != NULL)
    eif_wean (tmp_p_rect_scroll);
  if (tmp_p_rect_clip != NULL)
    eif_wean (tmp_p_rect_clip);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::AdjustRect(  /* [in, out] */ ::tagRECT * prc )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_prc = NULL;
  if (prc != NULL)
  {
    tmp_prc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)prc));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("adjust_rect", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_prc != NULL) ? eif_access (tmp_prc) : NULL));
  
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnDefWindowMessage(  /* [in] */ UINT msg, /* [in] */ UINT w_param, /* [in] */ LONG l_param, /* [out] */ LONG * pl_result )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_msg = (EIF_INTEGER)msg;
  EIF_INTEGER tmp_w_param = (EIF_INTEGER)w_param;
  EIF_INTEGER tmp_l_param = (EIF_INTEGER)l_param;
  EIF_OBJECT tmp_pl_result = NULL;
  if (pl_result != NULL)
  {
    tmp_pl_result = eif_protect (rt_ce.ccom_ce_pointed_long (pl_result, NULL));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_def_window_message", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_msg, (EIF_INTEGER)tmp_w_param, (EIF_INTEGER)tmp_l_param, ((tmp_pl_result != NULL) ? eif_access (tmp_pl_result) : NULL));
  rt_ec.ccom_ec_pointed_long (((tmp_pl_result != NULL) ? eif_wean (tmp_pl_result) : NULL), pl_result);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnControlInfoChanged( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("on_control_info_changed", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::LockInPlaceActive(  /* [in] */ BOOL f_lock )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_lock = (EIF_INTEGER)f_lock;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("lock_in_place_active", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_lock);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetExtendedControl(  /* [out] */ IDispatch * * pp_disp )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pp_disp = NULL;
  if (pp_disp != NULL)
  {
    tmp_pp_disp = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_204 (pp_disp, NULL));
    if (*pp_disp != NULL)
      (*pp_disp)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_extended_control", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_disp != NULL) ? eif_access (tmp_pp_disp) : NULL));
  
  if (*pp_disp != NULL)
    (*pp_disp)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_204 (((tmp_pp_disp != NULL) ? eif_wean (tmp_pp_disp) : NULL), pp_disp);
  if (*pp_disp != NULL)
    (*pp_disp)->AddRef ();
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::TransformCoords(  /* [in, out] */ ::_POINTL * p_ptl_himetric, /* [in, out] */ ::tagPOINTF * p_ptf_container, /* [in] */ ULONG dw_flags )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_ptl_himetric = NULL;
  if (p_ptl_himetric != NULL)
  {
    tmp_p_ptl_himetric = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_205 ((ecom_control_library::_POINTL *)p_ptl_himetric));
  }
  EIF_OBJECT tmp_p_ptf_container = NULL;
  if (p_ptf_container != NULL)
  {
    tmp_p_ptf_container = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_207 ((ecom_control_library::tagPOINTF *)p_ptf_container));
  }
  EIF_INTEGER tmp_dw_flags = (EIF_INTEGER)dw_flags;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("transform_coords", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_ptl_himetric != NULL) ? eif_access (tmp_p_ptl_himetric) : NULL), ((tmp_p_ptf_container != NULL) ? eif_access (tmp_p_ptf_container) : NULL), (EIF_INTEGER)tmp_dw_flags);
  
  
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::TranslateAccelerator(  /* [in] */ MSG * p_msg, /* [in] */ ULONG grf_modifiers )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_msg = NULL;
  if (p_msg != NULL)
  {
    tmp_p_msg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_198 ((ecom_control_library::tagMSG *)p_msg));
  }
  EIF_INTEGER tmp_grf_modifiers = (EIF_INTEGER)grf_modifiers;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("translate_accelerator", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_msg != NULL) ? eif_access (tmp_p_msg) : NULL), (EIF_INTEGER)tmp_grf_modifiers);
  if (tmp_p_msg != NULL)
    eif_wean (tmp_p_msg);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnFocus(  /* [in] */ BOOL f_got_focus )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_got_focus = (EIF_INTEGER)f_got_focus;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_focus", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_got_focus);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ShowPropertyFrame( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("show_property_frame", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ParseDisplayName(  /* [in] */ ::IBindCtx * pbc, /* [in] */ LPWSTR psz_display_name, /* [out] */ ULONG * pch_eaten, /* [out] */ ::IMoniker * * ppmk_out )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pbc = NULL;
  if (pbc != NULL)
  {
    tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
    pbc->AddRef ();
  }
  EIF_OBJECT tmp_psz_display_name = NULL;
  if (psz_display_name != NULL)
  {
    tmp_psz_display_name = eif_protect (rt_ce.ccom_ce_lpwstr (psz_display_name, NULL));
  }
  EIF_OBJECT tmp_pch_eaten = NULL;
  if (pch_eaten != NULL)
  {
    tmp_pch_eaten = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pch_eaten, NULL));
  }
  EIF_OBJECT tmp_ppmk_out = NULL;
  if (ppmk_out != NULL)
  {
    tmp_ppmk_out = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk_out, NULL));
    if (*ppmk_out != NULL)
      (*ppmk_out)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("parse_display_name", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_psz_display_name != NULL) ? eif_access (tmp_psz_display_name) : NULL), ((tmp_pch_eaten != NULL) ? eif_access (tmp_pch_eaten) : NULL), ((tmp_ppmk_out != NULL) ? eif_access (tmp_ppmk_out) : NULL));
  rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pch_eaten != NULL) ? eif_wean (tmp_pch_eaten) : NULL), pch_eaten);
  
  if (*ppmk_out != NULL)
    (*ppmk_out)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk_out != NULL) ? eif_wean (tmp_ppmk_out) : NULL), ppmk_out);
  if (*ppmk_out != NULL)
    (*ppmk_out)->AddRef ();
  if (tmp_pbc != NULL)
    eif_wean (tmp_pbc);
  if (tmp_psz_display_name != NULL)
    eif_wean (tmp_psz_display_name);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::EnumObjects(  /* [in] */ ULONG grf_flags, /* [out] */ ::IEnumUnknown * * ppenum )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_grf_flags = (EIF_INTEGER)grf_flags;
  EIF_OBJECT tmp_ppenum = NULL;
  if (ppenum != NULL)
  {
    tmp_ppenum = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_191 (ppenum, NULL));
    if (*ppenum != NULL)
      (*ppenum)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("enum_objects", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_grf_flags, ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
  
  if (*ppenum != NULL)
    (*ppenum)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_191 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
  if (*ppenum != NULL)
    (*ppenum)->AddRef ();
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::LockContainer(  /* [in] */ BOOL f_lock )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_lock = (EIF_INTEGER)f_lock;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("lock_container", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_lock);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::SetSite(  /* [in] */ IUnknown * p_unk_site )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_unk_site = NULL;
  if (p_unk_site != NULL)
  {
    tmp_p_unk_site = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_unk_site));
    p_unk_site->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_site", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_unk_site != NULL) ? eif_access (tmp_p_unk_site) : NULL));
  if (tmp_p_unk_site != NULL)
    eif_wean (tmp_p_unk_site);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetSite(  /* [in] */ REFIID  riid, /* [out] */ void * * ppv_site )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_riid = NULL;
    
  EIF_OBJECT tmp_ppv_site = NULL;
  if (ppv_site != NULL)
  {
    tmp_ppv_site = eif_protect (rt_ce.ccom_ce_pointed_pointer ((void **)ppv_site, NULL));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_site", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_site != NULL) ? eif_access (tmp_ppv_site) : NULL));
  
  if (tmp_riid != NULL)
    eif_wean (tmp_riid);
  
  HRESULT hr = E_FAIL;
  if (*ppv_site != NULL)
  {
    hr = ((IUnknown *)(*ppv_site))->QueryInterface (riid, (void**)ppv_site);
  }
  
  END_ECATCH;
  return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnChanged(  /* [in] */ LONG disp_id )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_disp_id = (EIF_INTEGER)disp_id;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_changed", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_disp_id);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnRequestEdit(  /* [in] */ LONG disp_id )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_disp_id = (EIF_INTEGER)disp_id;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_request_edit", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_disp_id);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_AllowWindowlessActivation(  /* [in] */ VARIANT_BOOL pb_can_windowless_activate )

/*-----------------------------------------------------------
  Enable or disable windowless activation
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_BOOLEAN tmp_pb_can_windowless_activate = rt_ce.ccom_ce_boolean (pb_can_windowless_activate);
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_allow_windowless_activation", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_pb_can_windowless_activate);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::AllowWindowlessActivation(  /* [out, retval] */ VARIANT_BOOL * pb_can_windowless_activate )

/*-----------------------------------------------------------
  Enable or disable windowless activation
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_BOOLEAN_FUNCTION eiffel_function = 0;
  eiffel_function = eif_boolean_function ("allow_windowless_activation", type_id);
  EIF_BOOLEAN tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "allow_windowless_activation", EIF_BOOLEAN);
  *pb_can_windowless_activate = rt_ec.ccom_ec_boolean (tmp_value);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_BackColor(  /* [in] */ OLE_COLOR pclr_background )

/*-----------------------------------------------------------
  Set the background color
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_pclr_background = (EIF_INTEGER)pclr_background;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_back_color", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_pclr_background);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::BackColor(  /* [out, retval] */ OLE_COLOR * pclr_background )

/*-----------------------------------------------------------
  Set the background color
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_INTEGER_FUNCTION eiffel_function = 0;
  eiffel_function = eif_integer_function ("back_color", type_id);
  EIF_INTEGER tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "back_color", EIF_INTEGER);
  *pclr_background = (OLE_COLOR)tmp_value;
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_ForeColor(  /* [in] */ OLE_COLOR pclr_foreground )

/*-----------------------------------------------------------
  Set the ambient foreground color
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_pclr_foreground = (EIF_INTEGER)pclr_foreground;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_fore_color", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_pclr_foreground);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ForeColor(  /* [out, retval] */ OLE_COLOR * pclr_foreground )

/*-----------------------------------------------------------
  Set the ambient foreground color
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_INTEGER_FUNCTION eiffel_function = 0;
  eiffel_function = eif_integer_function ("fore_color", type_id);
  EIF_INTEGER tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "fore_color", EIF_INTEGER);
  *pclr_foreground = (OLE_COLOR)tmp_value;
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_LocaleID(  /* [in] */ ULONG plcid_locale_id )

/*-----------------------------------------------------------
  Set the ambient locale
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_plcid_locale_id = (EIF_INTEGER)plcid_locale_id;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_locale_id", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_plcid_locale_id);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::LocaleID(  /* [out, retval] */ ULONG * plcid_locale_id )

/*-----------------------------------------------------------
  Set the ambient locale
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_INTEGER_FUNCTION eiffel_function = 0;
  eiffel_function = eif_integer_function ("locale_id", type_id);
  EIF_INTEGER tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "locale_id", EIF_INTEGER);
  *plcid_locale_id = (ULONG)tmp_value;
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_UserMode(  /* [in] */ VARIANT_BOOL pb_user_mode )

/*-----------------------------------------------------------
  Set the ambient user mode
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_BOOLEAN tmp_pb_user_mode = rt_ce.ccom_ce_boolean (pb_user_mode);
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_user_mode", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_pb_user_mode);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::UserMode(  /* [out, retval] */ VARIANT_BOOL * pb_user_mode )

/*-----------------------------------------------------------
  Set the ambient user mode
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_BOOLEAN_FUNCTION eiffel_function = 0;
  eiffel_function = eif_boolean_function ("user_mode", type_id);
  EIF_BOOLEAN tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "user_mode", EIF_BOOLEAN);
  *pb_user_mode = rt_ec.ccom_ec_boolean (tmp_value);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_DisplayAsDefault(  /* [in] */ VARIANT_BOOL pb_display_as_default )

/*-----------------------------------------------------------
  Enable or disable the control as default
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_BOOLEAN tmp_pb_display_as_default = rt_ce.ccom_ce_boolean (pb_display_as_default);
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_display_as_default", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_pb_display_as_default);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::DisplayAsDefault(  /* [out, retval] */ VARIANT_BOOL * pb_display_as_default )

/*-----------------------------------------------------------
  Enable or disable the control as default
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_BOOLEAN_FUNCTION eiffel_function = 0;
  eiffel_function = eif_boolean_function ("display_as_default", type_id);
  EIF_BOOLEAN tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "display_as_default", EIF_BOOLEAN);
  *pb_display_as_default = rt_ec.ccom_ec_boolean (tmp_value);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_Font(  /* [in] */ Font * p_font )

/*-----------------------------------------------------------
  Set the ambient font
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_font = NULL;
  if (p_font != NULL)
  {
    tmp_p_font = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_443 (p_font));
    p_font->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_font", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_font != NULL) ? eif_access (tmp_p_font) : NULL));
  if (tmp_p_font != NULL)
    eif_wean (tmp_p_font);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::a_Font(  /* [out, retval] */ Font * * p_font )

/*-----------------------------------------------------------
  Set the ambient font
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_REFERENCE_FUNCTION eiffel_function = 0;
  eiffel_function = eif_reference_function ("font", type_id);
  EIF_REFERENCE tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "font", EIF_REFERENCE);
  if (tmp_value != NULL)
  {
    EIF_OBJECT tmp_object = eif_protect (tmp_value);
    *p_font = grt_ec_control_interfaces2.ccom_ec_pointed_interface_443 (eif_access (tmp_object));
    if (*p_font != NULL)
      (*p_font)->AddRef ();
    eif_wean (tmp_object);
  }
  else
    *p_font = NULL;
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_MessageReflect(  /* [in] */ VARIANT_BOOL pb_msg_reflect )

/*-----------------------------------------------------------
  Enable or disable message reflection
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_BOOLEAN tmp_pb_msg_reflect = rt_ce.ccom_ce_boolean (pb_msg_reflect);
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_message_reflect", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_pb_msg_reflect);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::MessageReflect(  /* [out, retval] */ VARIANT_BOOL * pb_msg_reflect )

/*-----------------------------------------------------------
  Enable or disable message reflection
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_BOOLEAN_FUNCTION eiffel_function = 0;
  eiffel_function = eif_boolean_function ("message_reflect", type_id);
  EIF_BOOLEAN tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "message_reflect", EIF_BOOLEAN);
  *pb_msg_reflect = rt_ec.ccom_ec_boolean (tmp_value);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ShowGrabHandles(  /* [in] */ VARIANT_BOOL * pb_show_grab_handles )

/*-----------------------------------------------------------
  Show or hide grab handles
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pb_show_grab_handles = NULL;
  if (pb_show_grab_handles != NULL)
  {
    tmp_pb_show_grab_handles = eif_protect (rt_ce.ccom_ce_pointed_boolean (pb_show_grab_handles, NULL));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("show_grab_handles", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pb_show_grab_handles != NULL) ? eif_access (tmp_pb_show_grab_handles) : NULL));
  if (tmp_pb_show_grab_handles != NULL)
    eif_wean (tmp_pb_show_grab_handles);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ShowHatching(  /* [in] */ VARIANT_BOOL * pb_show_hatching )

/*-----------------------------------------------------------
  Are grab handles enabled
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pb_show_hatching = NULL;
  if (pb_show_hatching != NULL)
  {
    tmp_pb_show_hatching = eif_protect (rt_ce.ccom_ce_pointed_boolean (pb_show_hatching, NULL));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("show_hatching", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pb_show_hatching != NULL) ? eif_access (tmp_pb_show_hatching) : NULL));
  if (tmp_pb_show_hatching != NULL)
    eif_wean (tmp_pb_show_hatching);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_DocHostFlags(  /* [in] */ ULONG pdw_doc_host_flags )

/*-----------------------------------------------------------
  Set the DOCHOSTUIFLAG flags
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_pdw_doc_host_flags = (EIF_INTEGER)pdw_doc_host_flags;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_doc_host_flags", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_pdw_doc_host_flags);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::DocHostFlags(  /* [out, retval] */ ULONG * pdw_doc_host_flags )

/*-----------------------------------------------------------
  Set the DOCHOSTUIFLAG flags
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_INTEGER_FUNCTION eiffel_function = 0;
  eiffel_function = eif_integer_function ("doc_host_flags", type_id);
  EIF_INTEGER tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "doc_host_flags", EIF_INTEGER);
  *pdw_doc_host_flags = (ULONG)tmp_value;
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_DocHostDoubleClickFlags(  /* [in] */ ULONG pdw_doc_host_double_click_flags )

/*-----------------------------------------------------------
  Set the DOCHOSTUIDBLCLK flags
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_pdw_doc_host_double_click_flags = (EIF_INTEGER)pdw_doc_host_double_click_flags;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_doc_host_double_click_flags", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_pdw_doc_host_double_click_flags);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::DocHostDoubleClickFlags(  /* [out, retval] */ ULONG * pdw_doc_host_double_click_flags )

/*-----------------------------------------------------------
  Set the DOCHOSTUIDBLCLK flags
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_INTEGER_FUNCTION eiffel_function = 0;
  eiffel_function = eif_integer_function ("doc_host_double_click_flags", type_id);
  EIF_INTEGER tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "doc_host_double_click_flags", EIF_INTEGER);
  *pdw_doc_host_double_click_flags = (ULONG)tmp_value;
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_AllowContextMenu(  /* [in] */ VARIANT_BOOL pb_allow_context_menu )

/*-----------------------------------------------------------
  Enable or disable context menus
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_BOOLEAN tmp_pb_allow_context_menu = rt_ce.ccom_ce_boolean (pb_allow_context_menu);
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_allow_context_menu", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_pb_allow_context_menu);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::AllowContextMenu(  /* [out, retval] */ VARIANT_BOOL * pb_allow_context_menu )

/*-----------------------------------------------------------
  Enable or disable context menus
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_BOOLEAN_FUNCTION eiffel_function = 0;
  eiffel_function = eif_boolean_function ("allow_context_menu", type_id);
  EIF_BOOLEAN tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "allow_context_menu", EIF_BOOLEAN);
  *pb_allow_context_menu = rt_ec.ccom_ec_boolean (tmp_value);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_AllowShowUI(  /* [in] */ VARIANT_BOOL pb_allow_show_ui )

/*-----------------------------------------------------------
  Enable or disable UI
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_BOOLEAN tmp_pb_allow_show_ui = rt_ce.ccom_ce_boolean (pb_allow_show_ui);
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_allow_show_ui", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_pb_allow_show_ui);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::AllowShowUI(  /* [out, retval] */ VARIANT_BOOL * pb_allow_show_ui )

/*-----------------------------------------------------------
  Enable or disable UI
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_BOOLEAN_FUNCTION eiffel_function = 0;
  eiffel_function = eif_boolean_function ("allow_show_ui", type_id);
  EIF_BOOLEAN tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "allow_show_ui", EIF_BOOLEAN);
  *pb_allow_show_ui = rt_ec.ccom_ec_boolean (tmp_value);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::set_OptionKeyPath(  /* [in] */ BSTR pbstr_option_key_path )

/*-----------------------------------------------------------
  Set the option key path
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pbstr_option_key_path = NULL;
  if (pbstr_option_key_path != NULL)
  {
    tmp_pbstr_option_key_path = eif_protect (rt_ce.ccom_ce_bstr (pbstr_option_key_path));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_option_key_path", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbstr_option_key_path != NULL) ? eif_access (tmp_pbstr_option_key_path) : NULL));
  if (tmp_pbstr_option_key_path != NULL)
    eif_wean (tmp_pbstr_option_key_path);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OptionKeyPath(  /* [out, retval] */ BSTR * pbstr_option_key_path )

/*-----------------------------------------------------------
  Set the option key path
-----------------------------------------------------------*/
{
  ECATCH;

  
  EIF_REFERENCE_FUNCTION eiffel_function = 0;
  eiffel_function = eif_reference_function ("option_key_path", type_id);
  EIF_REFERENCE tmp_value = 0;
  if (eiffel_function != NULL)
    tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
  else
    tmp_value = eif_field (eif_access (eiffel_object), "option_key_path", EIF_REFERENCE);
  if (tmp_value != NULL)
  {
    EIF_OBJECT tmp_object = eif_protect (tmp_value);
    *pbstr_option_key_path = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
    eif_wean (tmp_object);
  }
  else
    *pbstr_option_key_path = NULL;
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ShowContextMenu(  /* [in] */ ULONG dw_id, /* [in] */ ::tagPOINT * ppt, /* [in] */ IUnknown * pcmdt_reserved, /* [in] */ IDispatch * pdisp_reserved )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_dw_id = (EIF_INTEGER)dw_id;
  EIF_OBJECT tmp_ppt = NULL;
  if (ppt != NULL)
  {
    tmp_ppt = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_453 ((ecom_control_library::tagPOINT *)ppt));
  }
  EIF_OBJECT tmp_pcmdt_reserved = NULL;
  if (pcmdt_reserved != NULL)
  {
    tmp_pcmdt_reserved = eif_protect (rt_ce.ccom_ce_pointed_unknown (pcmdt_reserved));
    pcmdt_reserved->AddRef ();
  }
  EIF_OBJECT tmp_pdisp_reserved = NULL;
  if (pdisp_reserved != NULL)
  {
    tmp_pdisp_reserved = eif_protect (rt_ce.ccom_ce_pointed_dispatch (pdisp_reserved));
    pdisp_reserved->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("show_context_menu", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_id, ((tmp_ppt != NULL) ? eif_access (tmp_ppt) : NULL), ((tmp_pcmdt_reserved != NULL) ? eif_access (tmp_pcmdt_reserved) : NULL), ((tmp_pdisp_reserved != NULL) ? eif_access (tmp_pdisp_reserved) : NULL));
  if (tmp_ppt != NULL)
    eif_wean (tmp_ppt);
  if (tmp_pcmdt_reserved != NULL)
    eif_wean (tmp_pcmdt_reserved);
  if (tmp_pdisp_reserved != NULL)
    eif_wean (tmp_pdisp_reserved);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetHostInfo(  /* [in, out] */ ::_DOCHOSTUIINFO * p_info )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_info = NULL;
  if (p_info != NULL)
  {
    tmp_p_info = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_455 ((ecom_control_library::_DOCHOSTUIINFO *)p_info));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_host_info", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_info != NULL) ? eif_access (tmp_p_info) : NULL));
  
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ShowUI(  /* [in] */ ULONG dw_id, /* [in] */ ::IOleInPlaceActiveObject * p_active_object, /* [in] */ ::IOleCommandTarget * p_command_target, /* [in] */ ::IOleInPlaceFrame * p_frame, /* [in] */ ::IOleInPlaceUIWindow * p_doc )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_dw_id = (EIF_INTEGER)dw_id;
  EIF_OBJECT tmp_p_active_object = NULL;
  if (p_active_object != NULL)
  {
    tmp_p_active_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_214 (p_active_object));
    p_active_object->AddRef ();
  }
  EIF_OBJECT tmp_p_command_target = NULL;
  if (p_command_target != NULL)
  {
    tmp_p_command_target = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_457 (p_command_target));
    p_command_target->AddRef ();
  }
  EIF_OBJECT tmp_p_frame = NULL;
  if (p_frame != NULL)
  {
    tmp_p_frame = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_225 (p_frame));
    p_frame->AddRef ();
  }
  EIF_OBJECT tmp_p_doc = NULL;
  if (p_doc != NULL)
  {
    tmp_p_doc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_212 (p_doc));
    p_doc->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("show_ui", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_id, ((tmp_p_active_object != NULL) ? eif_access (tmp_p_active_object) : NULL), ((tmp_p_command_target != NULL) ? eif_access (tmp_p_command_target) : NULL), ((tmp_p_frame != NULL) ? eif_access (tmp_p_frame) : NULL), ((tmp_p_doc != NULL) ? eif_access (tmp_p_doc) : NULL));
  if (tmp_p_active_object != NULL)
    eif_wean (tmp_p_active_object);
  if (tmp_p_command_target != NULL)
    eif_wean (tmp_p_command_target);
  if (tmp_p_frame != NULL)
    eif_wean (tmp_p_frame);
  if (tmp_p_doc != NULL)
    eif_wean (tmp_p_doc);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::HideUI( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("hide_ui", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::UpdateUI( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("update_ui", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::EnableModeless(  /* [in] */ BOOL f_enable )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_enable = (EIF_INTEGER)f_enable;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("enable_modeless", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_enable);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnDocWindowActivate(  /* [in] */ BOOL f_activate )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_activate = (EIF_INTEGER)f_activate;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_doc_window_activate", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_activate);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::OnFrameWindowActivate(  /* [in] */ BOOL f_activate )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_f_activate = (EIF_INTEGER)f_activate;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_frame_window_activate", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_activate);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::ResizeBorder(  /* [in] */const ::tagRECT * prc_border, /* [in] */ ::IOleInPlaceUIWindow * p_uiwindow, /* [in] */ BOOL f_rame_window )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_prc_border = NULL;
  if (prc_border != NULL)
  {
    tmp_prc_border = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)prc_border));
  }
  EIF_OBJECT tmp_p_uiwindow = NULL;
  if (p_uiwindow != NULL)
  {
    tmp_p_uiwindow = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_212 (p_uiwindow));
    p_uiwindow->AddRef ();
  }
  EIF_INTEGER tmp_f_rame_window = (EIF_INTEGER)f_rame_window;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("resize_border", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_prc_border != NULL) ? eif_access (tmp_prc_border) : NULL), ((tmp_p_uiwindow != NULL) ? eif_access (tmp_p_uiwindow) : NULL), (EIF_INTEGER)tmp_f_rame_window);
  if (tmp_prc_border != NULL)
    eif_wean (tmp_prc_border);
  if (tmp_p_uiwindow != NULL)
    eif_wean (tmp_p_uiwindow);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::TranslateAccelerator(  /* [in] */ MSG * lpmsg, /* [in] */const GUID * pguid_cmd_group, /* [in] */ ULONG n_cmd_id )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_lpmsg = NULL;
  if (lpmsg != NULL)
  {
    tmp_lpmsg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_198 ((ecom_control_library::tagMSG *)lpmsg));
  }
  EIF_OBJECT tmp_pguid_cmd_group = NULL;
  if (pguid_cmd_group != NULL)
  {
    tmp_pguid_cmd_group = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (pguid_cmd_group));
  }
  EIF_INTEGER tmp_n_cmd_id = (EIF_INTEGER)n_cmd_id;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("idoc_host_uihandler_translate_accelerator1", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lpmsg != NULL) ? eif_access (tmp_lpmsg) : NULL), ((tmp_pguid_cmd_group != NULL) ? eif_access (tmp_pguid_cmd_group) : NULL), (EIF_INTEGER)tmp_n_cmd_id);
  if (tmp_lpmsg != NULL)
    eif_wean (tmp_lpmsg);
  if (tmp_pguid_cmd_group != NULL)
    eif_wean (tmp_pguid_cmd_group);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetOptionKeyPath(  /* [out] */ LPWSTR * pch_key, /* [in] */ ULONG dw )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pch_key = NULL;
  if (pch_key != NULL)
  {
    tmp_pch_key = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_458 (pch_key, NULL));
  }
  EIF_INTEGER tmp_dw = (EIF_INTEGER)dw;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_option_key_path", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pch_key != NULL) ? eif_access (tmp_pch_key) : NULL), (EIF_INTEGER)tmp_dw);
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_458 (((tmp_pch_key != NULL) ? eif_wean (tmp_pch_key) : NULL), pch_key);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetDropTarget(  /* [in] */ ::IDropTarget * p_drop_target, /* [out] */ ::IDropTarget * * pp_drop_target )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_drop_target = NULL;
  if (p_drop_target != NULL)
  {
    tmp_p_drop_target = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_222 (p_drop_target));
    p_drop_target->AddRef ();
  }
  EIF_OBJECT tmp_pp_drop_target = NULL;
  if (pp_drop_target != NULL)
  {
    tmp_pp_drop_target = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_223 (pp_drop_target, NULL));
    if (*pp_drop_target != NULL)
      (*pp_drop_target)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_drop_target", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_drop_target != NULL) ? eif_access (tmp_p_drop_target) : NULL), ((tmp_pp_drop_target != NULL) ? eif_access (tmp_pp_drop_target) : NULL));
  
  if (*pp_drop_target != NULL)
    (*pp_drop_target)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_223 (((tmp_pp_drop_target != NULL) ? eif_wean (tmp_pp_drop_target) : NULL), pp_drop_target);
  if (*pp_drop_target != NULL)
    (*pp_drop_target)->AddRef ();
  if (tmp_p_drop_target != NULL)
    eif_wean (tmp_p_drop_target);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetExternal(  /* [out] */ IDispatch * * pp_dispatch )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pp_dispatch = NULL;
  if (pp_dispatch != NULL)
  {
    tmp_pp_dispatch = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_459 (pp_dispatch, NULL));
    if (*pp_dispatch != NULL)
      (*pp_dispatch)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_external", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_dispatch != NULL) ? eif_access (tmp_pp_dispatch) : NULL));
  
  if (*pp_dispatch != NULL)
    (*pp_dispatch)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_459 (((tmp_pp_dispatch != NULL) ? eif_wean (tmp_pp_dispatch) : NULL), pp_dispatch);
  if (*pp_dispatch != NULL)
    (*pp_dispatch)->AddRef ();
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::TranslateUrl(  /* [in] */ ULONG dw_translate, /* [in] */ OLECHAR * pch_urlin, /* [out] */ OLECHAR * * ppch_urlout )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_INTEGER tmp_dw_translate = (EIF_INTEGER)dw_translate;
  EIF_OBJECT tmp_pch_urlin = NULL;
  if (pch_urlin != NULL)
  {
    tmp_pch_urlin = eif_protect (ccom_wide_str_to_string (pch_urlin));
  }
  EIF_OBJECT tmp_ppch_urlout = NULL;
  if (ppch_urlout != NULL)
  {
    tmp_ppch_urlout = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_462 (ppch_urlout, NULL));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("translate_url", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_translate, ((tmp_pch_urlin != NULL) ? eif_access (tmp_pch_urlin) : NULL), ((tmp_ppch_urlout != NULL) ? eif_access (tmp_ppch_urlout) : NULL));
  
  if (*ppch_urlout != NULL)
    grt_ce_control_interfaces2.ccom_free_memory_pointed_461 (*ppch_urlout);
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_462 (((tmp_ppch_urlout != NULL) ? eif_wean (tmp_ppch_urlout) : NULL), ppch_urlout);
  if (tmp_pch_urlin != NULL)
    eif_wean (tmp_pch_urlin);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::FilterDataObject(  /* [in] */ ::IDataObject * p_do, /* [out] */ ::IDataObject * * pp_doret )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_do = NULL;
  if (p_do != NULL)
  {
    tmp_p_do = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_106 (p_do));
    p_do->AddRef ();
  }
  EIF_OBJECT tmp_pp_doret = NULL;
  if (pp_doret != NULL)
  {
    tmp_pp_doret = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_246 (pp_doret, NULL));
    if (*pp_doret != NULL)
      (*pp_doret)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("filter_data_object", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_do != NULL) ? eif_access (tmp_p_do) : NULL), ((tmp_pp_doret != NULL) ? eif_access (tmp_pp_doret) : NULL));
  
  if (*pp_doret != NULL)
    (*pp_doret)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_246 (((tmp_pp_doret != NULL) ? eif_wean (tmp_pp_doret) : NULL), pp_doret);
  if (*pp_doret != NULL)
    (*pp_doret)->AddRef ();
  if (tmp_p_do != NULL)
    eif_wean (tmp_p_do);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(void) ecom_control_library::control_site::OnDataChange(  /* [in] */ ::tagFORMATETC * p_formatetc, /* [in] */ STGMEDIUM * p_stgmed )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{

  EIF_OBJECT tmp_p_formatetc = NULL;
  if (p_formatetc != NULL)
  {
    tmp_p_formatetc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_2 ((ecom_control_library::tagFORMATETC *)p_formatetc));
  }
  EIF_OBJECT tmp_p_stgmed = NULL;
  if (p_stgmed != NULL)
  {
    tmp_p_stgmed = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_5 (p_stgmed));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_data_change", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_formatetc != NULL) ? eif_access (tmp_p_formatetc) : NULL), ((tmp_p_stgmed != NULL) ? eif_access (tmp_p_stgmed) : NULL));
  if (tmp_p_formatetc != NULL)
    eif_wean (tmp_p_formatetc);
  if (tmp_p_stgmed != NULL)
    eif_wean (tmp_p_stgmed);
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void STDMETHODCALLTYPE ecom_control_library::control_site::OnViewChange(  /* [in] */ DWORD dw_aspect, /* [in] */ LONG lindex )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  EIF_INTEGER tmp_dw_aspect = (EIF_INTEGER)dw_aspect;
  EIF_INTEGER tmp_lindex = (EIF_INTEGER)lindex;
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_view_change", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_aspect, (EIF_INTEGER)tmp_lindex);
 };
/*----------------------------------------------------------------------------------------------------------------------*/

void STDMETHODCALLTYPE  ecom_control_library::control_site::OnRename(  /* [in] */ ::IMoniker * pmk )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  EIF_OBJECT tmp_pmk = NULL;
  if (pmk != NULL)
  {
    tmp_pmk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk));
    pmk->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("on_rename", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk != NULL) ? eif_access (tmp_pmk) : NULL));
  if (tmp_pmk != NULL)
    eif_wean (tmp_pmk);
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void STDMETHODCALLTYPE  ecom_control_library::control_site::OnSave( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("on_save", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void STDMETHODCALLTYPE  ecom_control_library::control_site::OnClose( void )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("on_close", type_id);

  (FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

/*-----------------------------------------------------------
  Get type info
-----------------------------------------------------------*/
{
  if ((itinfo != 0) || (pptinfo == NULL))
    return E_INVALIDARG;
  *pptinfo = NULL;
  if (pTypeInfo == 0)
  {
    HRESULT tmp_hr = 0;
    ITypeLib *pTypeLib = 0;
    tmp_hr = LoadRegTypeLib (LIBID_control_library_, 1, 0, 0, &pTypeLib);
    if (FAILED(tmp_hr))
      return tmp_hr;
    tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IAxWinAmbientDispatch_, &pTypeInfo);
    pTypeLib->Release ();
    if (FAILED(tmp_hr))
      return tmp_hr;
  }
  (*pptinfo = pTypeInfo)->AddRef ();
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetTypeInfoCount( unsigned int * pctinfo )

/*-----------------------------------------------------------
  Get type info count
-----------------------------------------------------------*/
{
  if (pctinfo == NULL)
    return E_NOTIMPL;
  *pctinfo = 1;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

/*-----------------------------------------------------------
  IDs of function names 'rgszNames'
-----------------------------------------------------------*/
{
  if (pTypeInfo == 0)
  {
    HRESULT tmp_hr = 0;
    ITypeLib *pTypeLib = 0;
    tmp_hr = LoadRegTypeLib (LIBID_control_library_, 1, 0, 0, &pTypeLib);
    if (FAILED(tmp_hr))
      return tmp_hr;
    tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IAxWinAmbientDispatch_, &pTypeInfo);
    pTypeLib->Release ();
    if (FAILED(tmp_hr))
      return tmp_hr;
  }
  return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

/*-----------------------------------------------------------
  Invoke function.
-----------------------------------------------------------*/
{
  HRESULT hr = 0;
  int i = 0;

  unsigned int uArgErr;
  if (wFlags & ~(DISPATCH_METHOD | DISPATCH_PROPERTYGET | DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
    return ResultFromScode (E_INVALIDARG);

  if (puArgErr == NULL)
    puArgErr = &uArgErr;

  VARIANTARG * rgvarg = pDispParams->rgvarg;
  DISPID * rgdispidNamedArgs = pDispParams->rgdispidNamedArgs;
  unsigned int cArgs = pDispParams->cArgs;
  unsigned int cNamedArgs = pDispParams->cNamedArgs;
  VARIANTARG ** tmp_value = NULL;

  if (pExcepInfo != NULL)
  {
    pExcepInfo->wCode = 0;
    pExcepInfo->wReserved = 0;
    pExcepInfo->bstrSource = NULL;
    pExcepInfo->bstrDescription = NULL;
    pExcepInfo->bstrHelpFile = NULL;
    pExcepInfo->dwHelpContext = 0;
    pExcepInfo->pvReserved = NULL;
    pExcepInfo->pfnDeferredFillIn = NULL;
    pExcepInfo->scode = 0;
  }
  
  switch (dispID)
  {
    
    case -701:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        OLE_COLOR result = 0;
        
        hr = BackColor (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 19;
          pVarResult->ulVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {19};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 19)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 19);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        OLE_COLOR arg_0 = (OLE_COLOR)tmp_value [0]->ulVal;
        
        hr = set_BackColor ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case -703:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        Font * result = 0;
        
        hr = a_Font (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 9;
          pVarResult->pdispVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {9};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 9)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 9);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        Font * arg_0 = 0;
        IID tmp_iid_0 = {0xbef6e003,0xa874,0x101a,{0x8b,0xba,0x00,0xaa,0x00,0x30,0x0c,0xab}};
        if (tmp_value [0]->vt = VT_UNKNOWN)
        {
          IUnknown * tmp_arg_0 = tmp_value [0]->punkVal;
          if (tmp_arg_0 != NULL)
            hr = tmp_arg_0->QueryInterface (tmp_iid_0, (void**)(&arg_0));
        }
        else if (tmp_value [0]->vt = VT_DISPATCH)
        {
          IDispatch * tmp_arg_0 = tmp_value [0]->pdispVal;
          if (tmp_arg_0 != NULL)
            hr = tmp_arg_0->QueryInterface (tmp_iid_0, (void**)(&arg_0));
        }
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          
          return DISP_E_TYPEMISMATCH;
        }
        
        hr = set_Font ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (arg_0 != NULL)
          arg_0->Release ();
        CoTaskMemFree (tmp_value);
      }
      break;

    case -704:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        OLE_COLOR result = 0;
        
        hr = ForeColor (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 19;
          pVarResult->ulVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {19};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 19)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 19);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        OLE_COLOR arg_0 = (OLE_COLOR)tmp_value [0]->ulVal;
        
        hr = set_ForeColor ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case -705:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        ULONG result = 0;
        
        hr = LocaleID (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 19;
          pVarResult->ulVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {19};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 19)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 19);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        ULONG arg_0 = (ULONG)tmp_value [0]->ulVal;
        
        hr = set_LocaleID ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case -706:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        VARIANT_BOOL result = 0;
        
        hr = MessageReflect (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 11;
          pVarResult->boolVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {11};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 11)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
        
        hr = set_MessageReflect ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case -709:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        VARIANT_BOOL result = 0;
        
        hr = UserMode (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 11;
          pVarResult->boolVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {11};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 11)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
        
        hr = set_UserMode ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case -711:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {16395};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 16395)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 16395);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        VARIANT_BOOL * arg_0 = (VARIANT_BOOL *)tmp_value [0]->pboolVal;
        
        hr = ShowGrabHandles ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case -712:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {16395};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 16395)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 16395);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        VARIANT_BOOL * arg_0 = (VARIANT_BOOL *)tmp_value [0]->pboolVal;
        
        hr = ShowHatching ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case -713:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        VARIANT_BOOL result = 0;
        
        hr = DisplayAsDefault (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 11;
          pVarResult->boolVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {11};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 11)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
        
        hr = set_DisplayAsDefault ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case 1610743828:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        ULONG result = 0;
        
        hr = DocHostDoubleClickFlags (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 19;
          pVarResult->ulVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {19};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 19)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 19);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        ULONG arg_0 = (ULONG)tmp_value [0]->ulVal;
        
        hr = set_DocHostDoubleClickFlags ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case 1610743830:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        VARIANT_BOOL result = 0;
        
        hr = AllowContextMenu (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 11;
          pVarResult->boolVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {11};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 11)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
        
        hr = set_AllowContextMenu ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case 1610743832:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        VARIANT_BOOL result = 0;
        
        hr = AllowShowUI (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 11;
          pVarResult->boolVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {11};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 11)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
        
        hr = set_AllowShowUI ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case 1610743826:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        ULONG result = 0;
        
        hr = DocHostFlags (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 19;
          pVarResult->ulVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {19};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 19)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 19);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        ULONG arg_0 = (ULONG)tmp_value [0]->ulVal;
        
        hr = set_DocHostFlags ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case 1610743834:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        BSTR result = 0;
        
        hr = OptionKeyPath (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 8;
          pVarResult->bstrVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {8};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 8)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
        
        hr = set_OptionKeyPath ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    case 1610743808:
      if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
      {
        if (pDispParams->cArgs != 0)
          return DISP_E_BADPARAMCOUNT;

        VARIANT_BOOL result = 0;
        
        hr = AllowWindowlessActivation (&result);
        
        if (FAILED (hr))
        {
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        if (pVarResult != NULL)
        {
          VariantClear (pVarResult);
          pVarResult->vt = 11;
          pVarResult->boolVal = result;
        }
          
      }
      if (wFlags & (DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
      {
        if (pDispParams->cArgs != 1)
          return DISP_E_BADPARAMCOUNT;

        tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

        VARTYPE vt_type [] = {11};

        if (cNamedArgs >0)
          for (i = 0; i < cNamedArgs; i++)
          {
            tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
          }

        for (i = cArgs; i > cNamedArgs; i--)
        {
          tmp_value [cArgs - i] = &(rgvarg [i - 1]);
        }

        
        if (tmp_value [0]->vt != 11)
        {
          hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 11);
          if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          *puArgErr = 0;
          return DISP_E_TYPEMISMATCH;
        }
      
        }
        VARIANT_BOOL arg_0 = (VARIANT_BOOL)tmp_value [0]->boolVal;
        
        hr = set_AllowWindowlessActivation ( arg_0);
        
        if (FAILED (hr))
        {
          CoTaskMemFree (tmp_value);
          if (pExcepInfo != NULL)
          {
            WCHAR * wide_string = 0;
            wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
            BSTR b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrDescription = b_string;
            wide_string = ccom_create_from_string ("control_interfaces2");
            b_string = SysAllocString (wide_string);
            free (wide_string);
            pExcepInfo->bstrSource = b_string;
            pExcepInfo->wCode = HRESULT_CODE (hr);
          }
          return DISP_E_EXCEPTION;
        }
        CoTaskMemFree (tmp_value);
      }
      break;

    default:
      return DISP_E_MEMBERNOTFOUND;
  }
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::control_site::Release()

/*-----------------------------------------------------------
  Decrement reference count
-----------------------------------------------------------*/
{
  LONG res = InterlockedDecrement (&ref_count);
  if (res  ==  0)
  {
    if (pTypeInfo !=NULL)
    {
      pTypeInfo->Release ();
      pTypeInfo = NULL;
    }
    delete this;
  }
  return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::control_site::AddRef()

/*-----------------------------------------------------------
  Increment reference count
-----------------------------------------------------------*/
{
  return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
  Query Interface.
-----------------------------------------------------------*/
{
  if (riid == IID_IUnknown)
    *ppv = static_cast<::IOleClientSite*>(this);
  else if (riid == IID_IDispatch)
    *ppv = static_cast<ecom_control_library::IAxWinAmbientDispatch*>(this);
  else if (riid == IID_IOleClientSite_)
    *ppv = static_cast<::IOleClientSite*>(this);
  else if (riid == IID_IOleInPlaceSiteWindowless_)
    *ppv = static_cast<::IOleInPlaceSiteWindowless*>(this);
  else if (riid == IID_IOleInPlaceSiteEx_)
    *ppv = static_cast<::IOleInPlaceSiteEx*>(this);
  else if (riid == IID_IOleInPlaceSite_)
    *ppv = static_cast<::IOleInPlaceSite*>(this);
  else if (riid == IID_IOleWindow_)
    *ppv = static_cast<::IOleWindow*>(this);
  else if (riid == IID_IOleControlSite_)
    *ppv = static_cast<::IOleControlSite*>(this);
  else if (riid == IID_IOleContainer_)
    *ppv = static_cast<::IOleContainer*>(this);
  else if (riid == IID_IObjectWithSite_)
    *ppv = static_cast<::IObjectWithSite*>(this);
  else if (riid == IID_IPropertyNotifySink_)
    *ppv = static_cast<::IPropertyNotifySink*>(this);
  else if (riid == IID_IAxWinAmbientDispatch_)
    *ppv = static_cast<ecom_control_library::IAxWinAmbientDispatch*>(this);
  else if (riid == IID_IDocHostUIHandler_)
    *ppv = static_cast<::IDocHostUIHandler*>(this);
  else if (riid == IID_IAdviseSink_)
    *ppv = static_cast<::IAdviseSink*>(this);
  else if (riid == IID_IServiceProvider_)
    *ppv = static_cast<::IServiceProvider*>(this);
  else
    return (*ppv = 0), E_NOINTERFACE;

  reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::control_site::QueryService(  /* [in] */REFGUID  guid_service, /* [in] */REFIID  riid, /* [out] */ void * * ppv_object )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_guid_service = NULL;
  tmp_guid_service = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (&guid_service));

  EIF_OBJECT tmp_riid = NULL;
  tmp_riid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (&riid));
  EIF_OBJECT tmp_ppv_object = NULL;
  if (ppv_object != NULL)
  {
    tmp_ppv_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_431 ((IUnknown * *)ppv_object, NULL));
    if (*ppv_object != NULL)
      (*(IUnknown * *)ppv_object)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("query_service", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), eif_access (tmp_guid_service), eif_access (tmp_riid), ((tmp_ppv_object != NULL) ? eif_access (tmp_ppv_object) : NULL));
  
  if (*ppv_object != NULL)
    (*(IUnknown * *)ppv_object)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_431 (((tmp_ppv_object != NULL) ? eif_wean (tmp_ppv_object) : NULL), (IUnknown * *)ppv_object);
  if (*ppv_object != NULL)
    (*(IUnknown * *)ppv_object)->AddRef ();

  if (tmp_guid_service != NULL)
    eif_wean (tmp_guid_service);
  if (tmp_riid != NULL)
    eif_wean (tmp_riid);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

#ifdef __cplusplus
}
#endif
