/*-----------------------------------------------------------
Implemented `IPersistStorage' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTSTORAGE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTSTORAGE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPersistStorage_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersistStorage_s.h"


#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPersistStorage_impl_proxy
{
public:
  IPersistStorage_impl_proxy (IUnknown * a_pointer);
  virtual ~IPersistStorage_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_class_id(  /* [out] */ GUID * p_class_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_is_dirty();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_init_new(  /* [in] */ ::IStorage * pstg );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_load(  /* [in] */ ::IStorage * pstg );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_save(  /* [in] */ ::IStorage * p_stg_save,  /* [in] */ EIF_INTEGER f_same_as_load );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_save_completed(  /* [in] */ ::IStorage * p_stg_new );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_hands_off_storage();


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IPersistStorage * p_IPersistStorage;


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
