/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IADVISESINKEX_S_H__
#define __ECOM_CONTROL_LIBRARY_IADVISESINKEX_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IAdviseSinkEx_FWD_DEFINED__
#define __ecom_control_library_IAdviseSinkEx_FWD_DEFINED__
namespace ecom_control_library
{
class IAdviseSinkEx;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IAdviseSink_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IAdviseSinkEx_INTERFACE_DEFINED__
#define __ecom_control_library_IAdviseSinkEx_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IAdviseSinkEx : public ecom_control_library::IAdviseSink
{
public:
  IAdviseSinkEx () {};
  ~IAdviseSinkEx () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP OnViewStatusChange(  /* [in] */ ULONG dw_view_status ) = 0;



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
