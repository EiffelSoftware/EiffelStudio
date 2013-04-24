/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTPROPERTYBAG2_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTPROPERTYBAG2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPersistPropertyBag2_FWD_DEFINED__
#define __ecom_control_library_IPersistPropertyBag2_FWD_DEFINED__
namespace ecom_control_library
{
class IPersistPropertyBag2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersist_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IPropertyBag2_FWD_DEFINED__
#define __ecom_control_library_IPropertyBag2_FWD_DEFINED__
namespace ecom_control_library
{
class IPropertyBag2;
}
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
#ifndef __ecom_control_library_IPersistPropertyBag2_INTERFACE_DEFINED__
#define __ecom_control_library_IPersistPropertyBag2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPersistPropertyBag2 : public ecom_control_library::IPersist
{
public:
	IPersistPropertyBag2 () {};
	~IPersistPropertyBag2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InitNew( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Load(  /* [in] */ ecom_control_library::IPropertyBag2 * p_prop_bag, /* [in] */ ecom_control_library::IErrorLog * p_err_log ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Save(  /* [in] */ ecom_control_library::IPropertyBag2 * p_prop_bag, /* [in] */ LONG f_clear_dirty, /* [in] */ LONG f_save_all_properties ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsDirty( void ) = 0;



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