/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IRUNNABLEOBJECT_S_H__
#define __ECOM_CONTROL_LIBRARY_IRUNNABLEOBJECT_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IRunnableObject_FWD_DEFINED__
#define __ecom_control_library_IRunnableObject_FWD_DEFINED__
namespace ecom_control_library
{
class IRunnableObject;
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



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IRunnableObject_INTERFACE_DEFINED__
#define __ecom_control_library_IRunnableObject_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IRunnableObject : public IUnknown
{
public:
  IRunnableObject () {};
  ~IRunnableObject () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetRunningClass(  /* [out] */ GUID * lp_clsid ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Run(  /* [in] */ ecom_control_library::IBindCtx * pbc ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP IsRunning( void ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP LockRunning(  /* [in] */ LONG f_lock, /* [in] */ LONG f_last_unlock_closes ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP SetContainedObject(  /* [in] */ LONG f_contained ) = 0;



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
