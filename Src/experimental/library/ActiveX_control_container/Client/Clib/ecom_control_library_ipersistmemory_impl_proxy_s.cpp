/*-----------------------------------------------------------
Implemented `IPersistMemory' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPersistMemory_impl_proxy_s.h"
static const IID IID_IPersistMemory_ = {0xbd1ae5e0,0xa6ae,0x11ce,{0xbd,0x37,0x50,0x42,0x00,0xc1,0x00,0x00}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPersistMemory_impl_proxy::IPersistMemory_impl_proxy( IUnknown * a_pointer )
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

  p_IPersistMemory = NULL;
  hr = a_pointer->QueryInterface(IID_IPersistMemory_, (void **)&p_IPersistMemory);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPersistMemory_impl_proxy::~IPersistMemory_impl_proxy()
{
  p_unknown->Release ();
  if (p_IPersistMemory!=NULL)
    p_IPersistMemory->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistMemory_impl_proxy::ccom_get_class_id(  /* [out] */ GUID * p_class_id )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistMemory == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistMemory_, (void **)&p_IPersistMemory);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IPersistMemory->GetClassID(p_class_id);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistMemory_impl_proxy::ccom_is_dirty()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistMemory == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistMemory_, (void **)&p_IPersistMemory);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IPersistMemory->IsDirty ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistMemory_impl_proxy::ccom_load(  /* [in] */ EIF_OBJECT p_mem,  /* [in] */ EIF_INTEGER cb_size )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistMemory == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistMemory_, (void **)&p_IPersistMemory);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  UCHAR * tmp_p_mem = 0;
  tmp_p_mem = (UCHAR *)rt_ec.ccom_ec_pointed_unsigned_character (eif_access (p_mem), NULL);
  ULONG tmp_cb_size = 0;
  tmp_cb_size = (ULONG)cb_size;
  
  hr = p_IPersistMemory->Load(tmp_p_mem,tmp_cb_size);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_261 (tmp_p_mem);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistMemory_impl_proxy::ccom_save(  /* [out] */ EIF_OBJECT p_mem,  /* [in] */ EIF_INTEGER f_clear_dirty,  /* [in] */ EIF_INTEGER cb_size )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistMemory == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistMemory_, (void **)&p_IPersistMemory);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  UCHAR * tmp_p_mem = 0;
  tmp_p_mem = (UCHAR *)rt_ec.ccom_ec_pointed_unsigned_character (eif_access (p_mem), NULL);
  LONG tmp_f_clear_dirty = 0;
  tmp_f_clear_dirty = (LONG)f_clear_dirty;
  ULONG tmp_cb_size = 0;
  tmp_cb_size = (ULONG)cb_size;
  
  hr = p_IPersistMemory->Save(tmp_p_mem,tmp_f_clear_dirty,tmp_cb_size);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_character ((UCHAR *)tmp_p_mem, p_mem);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_262 (tmp_p_mem);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistMemory_impl_proxy::ccom_get_size_max(  /* [out] */ EIF_OBJECT pcb_size )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistMemory == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistMemory_, (void **)&p_IPersistMemory);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  ULONG * tmp_pcb_size = 0;
  tmp_pcb_size = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcb_size), NULL);
  
  hr = p_IPersistMemory->GetSizeMax(tmp_pcb_size);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcb_size, pcb_size);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_263 (tmp_pcb_size);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPersistMemory_impl_proxy::ccom_init_new()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IPersistMemory == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IPersistMemory_, (void **)&p_IPersistMemory);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IPersistMemory->InitNew ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IPersistMemory_impl_proxy::ccom_item()

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
