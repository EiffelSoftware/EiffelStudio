/*-----------------------------------------------------------
Implemented `IOleUndoManager' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEUNDOMANAGER_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEUNDOMANAGER_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleUndoManager_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IOleUndoManager_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleUndoManager_impl_stub : public ecom_control_library::IOleUndoManager
{
public:
  IOleUndoManager_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IOleUndoManager_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Open(  /* [in] */ ecom_control_library::IOleParentUndoUnit * p_puu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Close(  /* [in] */ ecom_control_library::IOleParentUndoUnit * p_puu, /* [in] */ LONG f_commit );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Add(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetOpenParentState(  /* [out] */ ULONG * pdw_state );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP DiscardFrom(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP UndoTo(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP RedoTo(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnumUndoable(  /* [out] */ ecom_control_library::IEnumOleUndoUnits * * ppenum );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnumRedoable(  /* [out] */ ecom_control_library::IEnumOleUndoUnits * * ppenum );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetLastUndoDescription(  /* [out] */ BSTR * p_bstr );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetLastRedoDescription(  /* [out] */ BSTR * p_bstr );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Enable(  /* [in] */ LONG f_enable );


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
