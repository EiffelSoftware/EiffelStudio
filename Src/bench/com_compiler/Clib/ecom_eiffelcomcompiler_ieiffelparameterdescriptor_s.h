/*-----------------------------------------------------------
Feature parameter info. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELPARAMETERDESCRIPTOR_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELPARAMETERDESCRIPTOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelParameterDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelParameterDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelParameterDescriptor;
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
#ifndef __ecom_EiffelComCompiler_IEiffelParameterDescriptor_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelParameterDescriptor_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelParameterDescriptor : public IDispatch
{
public:
	IEiffelParameterDescriptor () {};
	~IEiffelParameterDescriptor () {};

	/*-----------------------------------------------------------
	Parameter name
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name ) = 0;


	/*-----------------------------------------------------------
	Parameter display
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Display(  /* [out, retval] */ BSTR * pbstr_display ) = 0;



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