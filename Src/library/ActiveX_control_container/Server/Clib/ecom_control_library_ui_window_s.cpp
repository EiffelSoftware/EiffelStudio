/*-----------------------------------------------------------
Document Control interfaces. Help file: 
-----------------------------------------------------------*/

#include "ecom_control_library_ui_window_s.h"
static int return_hr_value;

static const CLSID CLSID_ui_window_ = {0x54f4830e,0xf26a,0x4bfe,{0xb1,0x7a,0x71,0x50,0x43,0x55,0x04,0x33}};

static const IID IID_IOleInPlaceUIWindow_ = {0x00000115,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IOleWindow_ = {0x00000114,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID LIBID_control_library_ = {0xbde3247e,0x6bc6,0x47f4,{0xa4,0x6f,0xe5,0xae,0xa4,0xf8,0xdf,0x39}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ui_window::ui_window( EIF_TYPE_ID tid )
{
  type_id = tid;
  ref_count = 0;
  eiffel_object = eif_create (type_id);
  EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("make_from_pointer", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ui_window::ui_window( EIF_OBJECT eif_obj )
{
  ref_count = 0;
  eiffel_object = eif_adopt (eif_obj);
  type_id = eif_type (eiffel_object);
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ui_window::~ui_window()
{
  EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("set_item", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
  eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ui_window::GetWindow(  /* [out] */ HWND * phwnd )

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
  
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ui_window::ContextSensitiveHelp(  /* [in] */ BOOL f_enter_mode )

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

STDMETHODIMP ecom_control_library::ui_window::GetBorder(  /* [out] */ ::tagRECT * lprect_border )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_lprect_border = NULL;
  if (lprect_border != NULL)
  {
    tmp_lprect_border = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)lprect_border));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("get_border", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lprect_border != NULL) ? eif_access (tmp_lprect_border) : NULL));
  
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ui_window::RequestBorderSpace(  /* [in] */const ::tagRECT * pborderwidths )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pborderwidths = NULL;
  if (pborderwidths != NULL)
  {
    tmp_pborderwidths = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)pborderwidths));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("request_border_space", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pborderwidths != NULL) ? eif_access (tmp_pborderwidths) : NULL));
  if (tmp_pborderwidths != NULL)
    eif_wean (tmp_pborderwidths);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ui_window::SetBorderSpace(  /* [in] */const ::tagRECT * pborderwidths )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_pborderwidths = NULL;
  if (pborderwidths != NULL)
  {
    tmp_pborderwidths = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 ((ecom_control_library::tagRECT *)pborderwidths));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_border_space", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pborderwidths != NULL) ? eif_access (tmp_pborderwidths) : NULL));
  if (tmp_pborderwidths != NULL)
    eif_wean (tmp_pborderwidths);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ui_window::SetActiveObject(  /* [in] */ ::IOleInPlaceActiveObject * p_active_object, /* [in] */ LPCOLESTR  psz_obj_name )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_p_active_object = NULL;
  if (p_active_object != NULL)
  {
    tmp_p_active_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_214 (p_active_object));
    p_active_object->AddRef ();
  }
  EIF_OBJECT tmp_psz_obj_name = NULL;
  if (psz_obj_name != NULL)
  {
    tmp_psz_obj_name = eif_protect (rt_ce.ccom_ce_lpwstr ((LPOLESTR)psz_obj_name, NULL));
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("set_active_object", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_active_object != NULL) ? eif_access (tmp_p_active_object) : NULL), ((tmp_psz_obj_name != NULL) ? eif_access (tmp_psz_obj_name) : NULL));
  if (tmp_p_active_object != NULL)
    eif_wean (tmp_p_active_object);
  if (tmp_psz_obj_name != NULL)
    eif_wean (tmp_psz_obj_name);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::ui_window::Release()

/*-----------------------------------------------------------
  Decrement reference count
-----------------------------------------------------------*/
{
  LONG res = InterlockedDecrement (&ref_count);
  if (res  ==  0)
  {
    delete this;
  }
  return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::ui_window::AddRef()

/*-----------------------------------------------------------
  Increment reference count
-----------------------------------------------------------*/
{
  return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::ui_window::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
  Query Interface.
-----------------------------------------------------------*/
{
  if (riid == IID_IUnknown)
    *ppv = static_cast<::IOleInPlaceUIWindow*>(this);
  else if (riid == IID_IOleInPlaceUIWindow_)
    *ppv = static_cast<::IOleInPlaceUIWindow*>(this);
  else if (riid == IID_IOleWindow_)
    *ppv = static_cast<::IOleWindow*>(this);
  else
    return (*ppv = 0), E_NOINTERFACE;

  reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

#ifdef __cplusplus
}
#endif
