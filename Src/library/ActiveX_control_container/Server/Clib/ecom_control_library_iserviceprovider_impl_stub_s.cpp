/*-----------------------------------------------------------
Implemented `IServiceProvider' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IServiceProvider_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IServiceProvider_ = {0x6d5140c1,0x7436,0x11ce,{0x80,0x34,0x00,0xaa,0x00,0x60,0x09,0xfa}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IServiceProvider_impl_stub::IServiceProvider_impl_stub( EIF_OBJECT eif_obj )
{
  ref_count = 0;
  eiffel_object = eif_adopt (eif_obj);
  type_id = eif_type (eiffel_object);
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IServiceProvider_impl_stub::~IServiceProvider_impl_stub()
{
  EIF_PROCEDURE eiffel_procedure;
  eiffel_procedure = eif_procedure ("set_item", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
  eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IServiceProvider_impl_stub::QueryService(  /* [in] */ GUID * guid_service, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_object )

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  ECATCH;

  EIF_OBJECT tmp_guid_service = NULL;
  if (guid_service != NULL)
  {
    tmp_guid_service = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (guid_service));
  }
  EIF_OBJECT tmp_riid = NULL;
  if (riid != NULL)
  {
    tmp_riid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid));
  }
  EIF_OBJECT tmp_ppv_object = NULL;
  if (ppv_object != NULL)
  {
    tmp_ppv_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_431 (ppv_object, NULL));
    if (*ppv_object != NULL)
      (*ppv_object)->AddRef ();
  }
  
  EIF_PROCEDURE eiffel_procedure = 0;
  eiffel_procedure = eif_procedure ("query_service", type_id);

  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_guid_service != NULL) ? eif_access (tmp_guid_service) : NULL), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_object != NULL) ? eif_access (tmp_ppv_object) : NULL));
  
  if (*ppv_object != NULL)
    (*ppv_object)->Release ();
  grt_ec_control_interfaces2.ccom_ec_pointed_cell_431 (((tmp_ppv_object != NULL) ? eif_wean (tmp_ppv_object) : NULL), ppv_object);
  if (*ppv_object != NULL)
    (*ppv_object)->AddRef ();
  if (tmp_guid_service != NULL)
    eif_wean (tmp_guid_service);
  if (tmp_riid != NULL)
    eif_wean (tmp_riid);
  
  END_ECATCH;
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IServiceProvider_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IServiceProvider_impl_stub::AddRef()

/*-----------------------------------------------------------
  Increment reference count
-----------------------------------------------------------*/
{
  return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IServiceProvider_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
  Query Interface
-----------------------------------------------------------*/
{
  if (riid == IID_IUnknown)
    *ppv = static_cast<ecom_control_library::IServiceProvider*>(this);
  else if (riid == IID_IServiceProvider_)
    *ppv = static_cast<ecom_control_library::IServiceProvider*>(this);
  else
    return (*ppv = 0), E_NOINTERFACE;

  reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
  return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif
