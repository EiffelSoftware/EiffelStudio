/*-----------------------------------------------------------
Implemented `IOleParentUndoUnit' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEPARENTUNDOUNIT_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEPARENTUNDOUNIT_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IOleParentUndoUnit_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleParentUndoUnit_s.h"

#include "ecom_control_library_IOleUndoManager_s.h"

#include "ecom_control_library_IOleUndoUnit_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IOleParentUndoUnit_impl_proxy
{
public:
  IOleParentUndoUnit_impl_proxy (IUnknown * a_pointer);
  virtual ~IOleParentUndoUnit_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_do1(  /* [in] */ ::IOleUndoManager * p_undo_manager );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_description(  /* [out] */ EIF_OBJECT p_bstr );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_unit_type(  /* [out] */ GUID * p_clsid,  /* [out] */ EIF_OBJECT pl_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_on_next_add();


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
  void ccom_find_unit(  /* [in] */ ::IOleUndoUnit * p_uu );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_parent_state(  /* [out] */ EIF_OBJECT pdw_state );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IOleParentUndoUnit * p_IOleParentUndoUnit;


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
