/*-----------------------------------------------------------
Implemented `IOleUndoUnit' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleUndoUnit_impl_proxy_s.h"
static const IID IID_IOleUndoUnit_ = {0x894ad3b0,0xef97,0x11ce,{0x9b,0xc9,0x00,0xaa,0x00,0x60,0x8e,0x01}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleUndoUnit_impl_proxy::IOleUndoUnit_impl_proxy( IUnknown * a_pointer )
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

  hr = a_pointer->QueryInterface(IID_IOleUndoUnit_, (void **)&p_IOleUndoUnit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleUndoUnit_impl_proxy::~IOleUndoUnit_impl_proxy()
{
  p_unknown->Release ();
  if (p_IOleUndoUnit!=NULL)
    p_IOleUndoUnit->Release ();
  CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleUndoUnit_impl_proxy::ccom_do1(  /* [in] */ ::IOleUndoManager * p_undo_manager )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleUndoUnit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleUndoUnit_, (void **)&p_IOleUndoUnit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  
  hr = p_IOleUndoUnit->Do(p_undo_manager);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleUndoUnit_impl_proxy::ccom_get_description(  /* [out] */ EIF_OBJECT p_bstr )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleUndoUnit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleUndoUnit_, (void **)&p_IOleUndoUnit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  BSTR * tmp_p_bstr = 0;
  tmp_p_bstr = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_167 (eif_access (p_bstr), NULL);
  
  hr = p_IOleUndoUnit->GetDescription(tmp_p_bstr);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  grt_ce_control_interfaces2.ccom_ce_pointed_cell_167 ((BSTR *)tmp_p_bstr, p_bstr);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_167 (tmp_p_bstr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleUndoUnit_impl_proxy::ccom_get_unit_type(  /* [out] */ GUID * p_clsid,  /* [out] */ EIF_OBJECT pl_id )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleUndoUnit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleUndoUnit_, (void **)&p_IOleUndoUnit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  LONG * tmp_pl_id = 0;
  tmp_pl_id = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (pl_id), NULL);
  
  hr = p_IOleUndoUnit->GetUnitType(p_clsid,tmp_pl_id);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  rt_ce.ccom_ce_pointed_long ((LONG *)tmp_pl_id, pl_id);
  
  grt_ce_control_interfaces2.ccom_free_memory_pointed_168 (tmp_pl_id);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleUndoUnit_impl_proxy::ccom_on_next_add()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_IOleUndoUnit == NULL)
  {
    hr = p_unknown->QueryInterface (IID_IOleUndoUnit_, (void **)&p_IOleUndoUnit);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  hr = p_IOleUndoUnit->OnNextAdd ();
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleUndoUnit_impl_proxy::ccom_item()

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
