/*-----------------------------------------------------------
Implemented `IDataAdviseHolder' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDATAADVISEHOLDER_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IDATAADVISEHOLDER_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDataAdviseHolder_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IDataAdviseHolder_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDataAdviseHolder_impl_stub : public ecom_control_library::IDataAdviseHolder
{
public:
  IDataAdviseHolder_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IDataAdviseHolder_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Advise(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ ecom_control_library::tagFORMATETC * p_fetc, /* [in] */ ULONG advf, /* [in] */ ecom_control_library::IAdviseSink * p_advise, /* [out] */ ULONG * pdw_connection );


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
  STDMETHODIMP SendOnDataChange(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ ULONG dw_reserved, /* [in] */ ULONG advf );


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
