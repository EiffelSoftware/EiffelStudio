/*-----------------------------------------------------------
Implemented `IAdviseSink' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IAdviseSink_impl_proxy_s.h"
static const IID IID_IAdviseSink_ = {0x0000010f,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IAdviseSink_impl_proxy::IAdviseSink_impl_proxy( IUnknown * a_pointer )
{
  HRESULT hr = 0, hr2 = 0;
  hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  p_unknown = NULL;
  hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

  p_IAdviseSink = NULL;
  hr = a_pointer->QueryInterface(IID_IAdviseSink_, (void **)&p_IAdviseSink);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IAdviseSink_impl_proxy::~IAdviseSink_impl_proxy()
{
  p_unknown->Release ();
  if (p_IAdviseSink!=NULL)
    p_IAdviseSink->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink_impl_proxy::ccom_on_data_change(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc,  /* [in] */ STGMEDIUM * p_stgmed )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink_, (void **)&p_IAdviseSink);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  p_IAdviseSink->OnDataChange((FORMATETC *)p_formatetc,p_stgmed);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink_impl_proxy::ccom_on_view_change(  /* [in] */ EIF_INTEGER dw_aspect,  /* [in] */ EIF_INTEGER lindex )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink_, (void **)&p_IAdviseSink);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG tmp_dw_aspect = 0;
  tmp_dw_aspect = (ULONG)dw_aspect;
  LONG tmp_lindex = 0;
  tmp_lindex = (LONG)lindex;
  
  p_IAdviseSink->OnViewChange(tmp_dw_aspect,tmp_lindex);
    
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink_impl_proxy::ccom_on_rename(  /* [in] */ ::IMoniker * pmk )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink_, (void **)&p_IAdviseSink);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  p_IAdviseSink->OnRename(pmk);
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink_impl_proxy::ccom_on_save()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink_, (void **)&p_IAdviseSink);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  p_IAdviseSink->OnSave ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAdviseSink_impl_proxy::ccom_on_close()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IAdviseSink == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IAdviseSink_, (void **)&p_IAdviseSink);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  p_IAdviseSink->OnClose ();
 
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IAdviseSink_impl_proxy::ccom_item()

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
