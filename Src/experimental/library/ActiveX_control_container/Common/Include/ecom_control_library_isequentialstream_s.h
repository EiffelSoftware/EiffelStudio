/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISEQUENTIALSTREAM_S_H__
#define __ECOM_CONTROL_LIBRARY_ISEQUENTIALSTREAM_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_ISequentialStream_FWD_DEFINED__
#define __ecom_control_library_ISequentialStream_FWD_DEFINED__
namespace ecom_control_library
{
class ISequentialStream;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_ISequentialStream_INTERFACE_DEFINED__
#define __ecom_control_library_ISequentialStream_INTERFACE_DEFINED__
namespace ecom_control_library
{
class ISequentialStream : public IUnknown
{
public:
  ISequentialStream () {};
  ~ISequentialStream () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Read(  /* [out] */ UCHAR * pv, /* [in] */ ULONG cb, /* [out] */ ULONG * pcb_read ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Write(  /* [in] */ UCHAR * pv, /* [in] */ ULONG cb, /* [out] */ ULONG * pcb_written ) = 0;



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
