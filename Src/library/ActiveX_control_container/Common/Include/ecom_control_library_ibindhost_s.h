/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IBINDHOST_S_H__
#define __ECOM_CONTROL_LIBRARY_IBINDHOST_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IBindHost_FWD_DEFINED__
#define __ecom_control_library_IBindHost_FWD_DEFINED__
namespace ecom_control_library
{
class IBindHost;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IBindCtx_FWD_DEFINED__
#define __ecom_control_library_IBindCtx_FWD_DEFINED__
namespace ecom_control_library
{
class IBindCtx;
}
#endif



#ifndef __ecom_control_library_IMoniker_FWD_DEFINED__
#define __ecom_control_library_IMoniker_FWD_DEFINED__
namespace ecom_control_library
{
class IMoniker;
}
#endif



#ifndef __ecom_control_library_IBindStatusCallback_FWD_DEFINED__
#define __ecom_control_library_IBindStatusCallback_FWD_DEFINED__
namespace ecom_control_library
{
class IBindStatusCallback;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IBindHost_INTERFACE_DEFINED__
#define __ecom_control_library_IBindHost_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IBindHost : public IUnknown
{
public:
  IBindHost () {};
  ~IBindHost () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP CreateMoniker(  /* [in] */ LPWSTR sz_name, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [out] */ ecom_control_library::IMoniker * * ppmk, /* [in] */ ULONG dw_reserved ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP MonikerBindToStorage(  /* [in] */ ecom_control_library::IMoniker * pmk, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IBindStatusCallback * p_bsc, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP MonikerBindToObject(  /* [in] */ ecom_control_library::IMoniker * pmk, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IBindStatusCallback * p_bsc, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj ) = 0;



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
