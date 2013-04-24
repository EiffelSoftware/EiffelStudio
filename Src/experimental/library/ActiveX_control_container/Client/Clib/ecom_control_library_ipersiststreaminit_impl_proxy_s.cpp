/*-----------------------------------------------------------
Implemented `IPersistStreamInit' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPersistStreamInit_impl_proxy_s.h"
static const IID IID_IPersistStreamInit_ = {0x7fd52380,0x4e07,0x101b,{0xae,0x2d,0x08,0x00,0x2b,0x2e,0xc7,0x13}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPersistStreamInit_impl_proxy::IPersistStreamInit_impl_proxy( IUnknown * a_pointer )
{
  HRESULT hr, hr2;
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

  p_IPersistStreamInit = NULL;
  hr = a_pointer->QueryInterface(IID_IPersistStreamInit_, (void **)&p_IPersistStreamInit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPersistStreamInit_impl_proxy::~IPersistStreamInit_impl_proxy()
{
  p_unknown->Release ();
  if (p_IPersistStreamInit!=NULL)
    p_IPersistStreamInit->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistStreamInit_impl_proxy::ccom_get_class_id(  /* [out] */ GUID * p_class_id )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistStreamInit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistStreamInit_, (void **)&p_IPersistStreamInit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IPersistStreamInit->GetClassID(p_class_id);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistStreamInit_impl_proxy::ccom_is_dirty()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistStreamInit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistStreamInit_, (void **)&p_IPersistStreamInit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IPersistStreamInit->IsDirty ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistStreamInit_impl_proxy::ccom_load(  /* [in] */ ::IStream * pstm )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistStreamInit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistStreamInit_, (void **)&p_IPersistStreamInit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IPersistStreamInit->Load(pstm);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistStreamInit_impl_proxy::ccom_save(  /* [in] */ ::IStream * pstm,  /* [in] */ EIF_INTEGER f_clear_dirty )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistStreamInit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistStreamInit_, (void **)&p_IPersistStreamInit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG tmp_f_clear_dirty = 0;
  tmp_f_clear_dirty = (LONG)f_clear_dirty;
  
  hr = p_IPersistStreamInit->Save(pstm,tmp_f_clear_dirty);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistStreamInit_impl_proxy::ccom_get_size_max(  /* [out] */ ULARGE_INTEGER * pcb_size )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistStreamInit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistStreamInit_, (void **)&p_IPersistStreamInit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IPersistStreamInit->GetSizeMax(pcb_size);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistStreamInit_impl_proxy::ccom_init_new()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistStreamInit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistStreamInit_, (void **)&p_IPersistStreamInit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IPersistStreamInit->InitNew ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IPersistStreamInit_impl_proxy::ccom_item()

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
