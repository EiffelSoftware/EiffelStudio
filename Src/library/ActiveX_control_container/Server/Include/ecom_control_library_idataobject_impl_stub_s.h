/*-----------------------------------------------------------
Implemented `IDataObject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDATAOBJECT_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IDATAOBJECT_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDataObject_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IDataObject_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDataObject_impl_stub : public ecom_control_library::IDataObject
{
public:
  IDataObject_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IDataObject_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetData(  /* [in] */ ecom_control_library::tagFORMATETC * pformatetc_in, /* [out] */ ecom_control_library::wireSTGMEDIUM * p_remote_medium );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteGetDataHere(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in, out] */ ecom_control_library::wireSTGMEDIUM * p_remote_medium );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP QueryGetData(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetCanonicalFormatEtc(  /* [in] */ ecom_control_library::tagFORMATETC * pformatect_in, /* [out] */ ecom_control_library::tagFORMATETC * pformatetc_out );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RemoteSetData(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ecom_control_library::wireFLAG_STGMEDIUM * pmedium, /* [in] */ LONG f_release );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnumFormatEtc(  /* [in] */ ULONG dw_direction, /* [out] */ ecom_control_library::IEnumFORMATETC * * ppenum_format_etc );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DAdvise(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ULONG advf, /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink, /* [out] */ ULONG * pdw_connection );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DUnadvise(  /* [in] */ ULONG dw_connection );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnumDAdvise(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_advise );


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
