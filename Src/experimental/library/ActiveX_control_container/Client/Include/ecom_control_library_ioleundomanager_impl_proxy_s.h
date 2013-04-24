/*-----------------------------------------------------------
Implemented `IOleUndoManager' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEUNDOMANAGER_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEUNDOMANAGER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleUndoManager_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleUndoManager_s.h"

#include "ecom_control_library_IOleParentUndoUnit_s.h"

#include "ecom_control_library_IOleUndoUnit_s.h"

#include "ecom_control_library_IEnumOleUndoUnits_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleUndoManager_impl_proxy
{
public:
  IOleUndoManager_impl_proxy (IUnknown * a_pointer);
  virtual ~IOleUndoManager_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_open(  /* [in] */ ::IOleParentUndoUnit * p_puu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_close(  /* [in] */ ::IOleParentUndoUnit * p_puu,  /* [in] */ EIF_INTEGER f_commit );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_add(  /* [in] */ ::IOleUndoUnit * p_uu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_open_parent_state(  /* [out] */ EIF_OBJECT pdw_state );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_discard_from(  /* [in] */ ::IOleUndoUnit * p_uu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_undo_to(  /* [in] */ ::IOleUndoUnit * p_uu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_redo_to(  /* [in] */ ::IOleUndoUnit * p_uu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_enum_undoable(  /* [out] */ EIF_OBJECT ppenum );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_enum_redoable(  /* [out] */ EIF_OBJECT ppenum );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_last_undo_description(  /* [out] */ EIF_OBJECT p_bstr );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_last_redo_description(  /* [out] */ EIF_OBJECT p_bstr );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_enable(  /* [in] */ EIF_INTEGER f_enable );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IOleUndoManager * p_IOleUndoManager;


  /*-----------------------------------------------------------
  Default IUnknown interface pointer
  -----------------------------------------------------------*/
  IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
