/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IERRORLOG_S_H__
#define __ECOM_CONTROL_LIBRARY_IERRORLOG_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IErrorLog_FWD_DEFINED__
#define __ecom_control_library_IErrorLog_FWD_DEFINED__
namespace ecom_control_library
{
class IErrorLog;
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
#ifndef __ecom_control_library_IErrorLog_INTERFACE_DEFINED__
#define __ecom_control_library_IErrorLog_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IErrorLog : public IUnknown
{
public:
	IErrorLog () {};
	~IErrorLog () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddError(  /* [in] */ LPWSTR psz_prop_name, /* [in] */ EXCEPINFO * p_excep_info ) = 0;



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