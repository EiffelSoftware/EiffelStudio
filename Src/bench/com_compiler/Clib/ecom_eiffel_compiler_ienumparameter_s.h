/*-----------------------------------------------------------
Feature paramaters enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IENUMPARAMETER_S_H__
#define __ECOM_EIFFEL_COMPILER_IENUMPARAMETER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEnumParameter_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumParameter_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumParameter;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEiffelParameterDescriptor_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelParameterDescriptor_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelParameterDescriptor;
}
#endif



#ifndef __ecom_eiffel_compiler_IEnumParameter_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumParameter_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumParameter;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEnumParameter_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEnumParameter_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumParameter : public IUnknown
{
public:
	IEnumParameter () {};
	~IEnumParameter () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_eiffel_compiler::IEiffelParameterDescriptor * * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG celt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_eiffel_compiler::IEnumParameter * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ith_item(  /* [in] */ ULONG an_index, /* [out] */ ecom_eiffel_compiler::IEiffelParameterDescriptor * * rgelt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP count(  /* [out, retval] */ ULONG * return_value ) = 0;



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