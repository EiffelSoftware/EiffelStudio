/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTSTREAM_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTSTREAM_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPersistStream_FWD_DEFINED__
#define __ecom_control_library_IPersistStream_FWD_DEFINED__
namespace ecom_control_library
{
class IPersistStream;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersist_s.h"

#include "ecom_control_library__ULARGE_INTEGER_s.h"

#ifdef __cplusplus
extern "C" {
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPersistStream_INTERFACE_DEFINED__
#define __ecom_control_library_IPersistStream_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPersistStream : public ecom_control_library::IPersist
{
public:
  IPersistStream () {};
  ~IPersistStream () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP IsDirty( void ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Load(  /* [in] */ ::IStream * pstm ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Save(  /* [in] */ ::IStream * pstm, /* [in] */ LONG f_clear_dirty ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetSizeMax(  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_size ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif
