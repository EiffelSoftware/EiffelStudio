/*-----------------------------------------------------------
Feature parameter info.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELPARAMETERDESCRIPTOR_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELPARAMETERDESCRIPTOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelParameterDescriptor_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelParameterDescriptor_FWD_DEFINED__
namespace ecom_eiffel_compiler
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
#ifndef __ecom_eiffel_compiler_IEiffelParameterDescriptor_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelParameterDescriptor_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelParameterDescriptor : public IUnknown
{
public:
	IEiffelParameterDescriptor () {};
	~IEiffelParameterDescriptor () {};

	/*-----------------------------------------------------------
	Parameter name
	-----------------------------------------------------------*/
	virtual STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Parameter display
	-----------------------------------------------------------*/
	virtual STDMETHODIMP display(  /* [out, retval] */ BSTR * return_value ) = 0;



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