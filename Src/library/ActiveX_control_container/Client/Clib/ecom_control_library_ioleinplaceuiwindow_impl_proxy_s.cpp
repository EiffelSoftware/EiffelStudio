/*-----------------------------------------------------------
Implemented `IOleInPlaceUIWindow' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleInPlaceUIWindow_impl_proxy_s.h"
static const IID IID_IOleInPlaceUIWindow_ = {0x00000115,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleInPlaceUIWindow_impl_proxy::IOleInPlaceUIWindow_impl_proxy( IUnknown * a_pointer )
{
  HRESULT hr, hr2;
  hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

  hr = a_pointer->QueryInterface(IID_IOleInPlaceUIWindow_, (void **)&p_IOleInPlaceUIWindow);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceUIWindow_impl_proxy::~IOleInPlaceUIWindow_impl_proxy()
{
  p_unknown->Release ();
  if (p_IOleInPlaceUIWindow!=NULL)
    p_IOleInPlaceUIWindow->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceUIWindow_impl_proxy::ccom_get_window(  /* [out] */ EIF_OBJECT phwnd )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleInPlaceUIWindow == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleInPlaceUIWindow_, (void **)&p_IOleInPlaceUIWindow);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  HWND * tmp_phwnd = 0;
  tmp_phwnd = (HWND *)rt_ec.ccom_ec_pointed_pointer (eif_access (phwnd), NULL);
  
  hr = p_IOleInPlaceUIWindow->GetWindow(tmp_phwnd);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_pointer ((void **)tmp_phwnd, phwnd);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_208 ((void **)tmp_phwnd);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceUIWindow_impl_proxy::ccom_context_sensitive_help(  /* [in] */ EIF_INTEGER f_enter_mode )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleInPlaceUIWindow == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleInPlaceUIWindow_, (void **)&p_IOleInPlaceUIWindow);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG tmp_f_enter_mode = 0;
  tmp_f_enter_mode = (LONG)f_enter_mode;
  
  hr = p_IOleInPlaceUIWindow->ContextSensitiveHelp(tmp_f_enter_mode);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceUIWindow_impl_proxy::ccom_get_border(  /* [out] */ ecom_control_library::tagRECT * lprect_border )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleInPlaceUIWindow == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleInPlaceUIWindow_, (void **)&p_IOleInPlaceUIWindow);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IOleInPlaceUIWindow->GetBorder((struct tagRECT *)lprect_border);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceUIWindow_impl_proxy::ccom_request_border_space(  /* [in] */ ecom_control_library::tagRECT * pborderwidths )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleInPlaceUIWindow == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleInPlaceUIWindow_, (void **)&p_IOleInPlaceUIWindow);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IOleInPlaceUIWindow->RequestBorderSpace((const struct tagRECT *)pborderwidths);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceUIWindow_impl_proxy::ccom_set_border_space(  /* [in] */ ecom_control_library::tagRECT * pborderwidths )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleInPlaceUIWindow == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleInPlaceUIWindow_, (void **)&p_IOleInPlaceUIWindow);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IOleInPlaceUIWindow->SetBorderSpace((const struct tagRECT *)pborderwidths);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceUIWindow_impl_proxy::ccom_set_active_object(  /* [in] */ ::IOleInPlaceActiveObject * p_active_object,  /* [in] */ EIF_OBJECT psz_obj_name )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleInPlaceUIWindow == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleInPlaceUIWindow_, (void **)&p_IOleInPlaceUIWindow);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LPWSTR tmp_psz_obj_name = 0;
  tmp_psz_obj_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_obj_name), NULL);
  
  hr = p_IOleInPlaceUIWindow->SetActiveObject(p_active_object,tmp_psz_obj_name);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleInPlaceUIWindow_impl_proxy::ccom_item()

/*-----------------------------------------------------------
  IUnknown interface
-----------------------------------------------------------*/
{
  return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif
