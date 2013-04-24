/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROPERTYBAG_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROPERTYBAG_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPropertyBag_FWD_DEFINED__
#define __ecom_control_library_IPropertyBag_FWD_DEFINED__
namespace ecom_control_library
{
class IPropertyBag;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IErrorLog_FWD_DEFINED__
#define __ecom_control_library_IErrorLog_FWD_DEFINED__
namespace ecom_control_library
{
class IErrorLog;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPropertyBag_INTERFACE_DEFINED__
#define __ecom_control_library_IPropertyBag_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPropertyBag : public IUnknown
{
public:
  IPropertyBag () {};
  ~IPropertyBag () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Read(  /* [in] */ LPWSTR psz_prop_name, /* [out] */ VARIANT * p_var, /* [in] */ ecom_control_library::IErrorLog * p_error_log, /* [in] */ ULONG var_type, /* [in] */ IUnknown * p_unk_obj ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP Write(  /* [in] */ LPWSTR psz_prop_name, /* [in] */ VARIANT * p_var ) = 0;



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
