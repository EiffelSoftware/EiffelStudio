/*-----------------------------------------------------------
Feature paramaters enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMPARAMETER_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMPARAMETER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEnumParameter_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumParameter_FWD_DEFINED__
namespace ecom_EiffelComCompiler
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

#ifndef __ecom_EiffelComCompiler_IEiffelParameterDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelParameterDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelParameterDescriptor;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumParameter_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumParameter_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumParameter;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEnumParameter_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEnumParameter_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumParameter : public IDispatch
{
public:
	IEnumParameter () {};
	~IEnumParameter () {};

	/*-----------------------------------------------------------
	Go to next item in enumerator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelParameterDescriptor * * pp_ieiffel_parameter_descriptor, /* [out] */ ULONG * pul_fetched ) = 0;


	/*-----------------------------------------------------------
	Skip `ulCount' items.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG ul_count ) = 0;


	/*-----------------------------------------------------------
	Reset enumerator.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	Clone enumerator.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumParameter * * pp_ienum_parameter ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IthItem(  /* [in] */ ULONG ul_index, /* [out] */ ecom_EiffelComCompiler::IEiffelParameterDescriptor * * pp_ieiffel_parameter_descriptor ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerator item count.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Count(  /* [out, retval] */ ULONG * ul_count ) = 0;



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