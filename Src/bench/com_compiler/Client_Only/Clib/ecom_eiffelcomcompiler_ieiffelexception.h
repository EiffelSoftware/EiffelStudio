/*-----------------------------------------------------------
A single exception object Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELEXCEPTION_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELEXCEPTION_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelException_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelException_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelException;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelException_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelException_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelException;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelException_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelException_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelException : public IDispatch
{
public:
	IEiffelException () {};
	~IEiffelException () {};

	/*-----------------------------------------------------------
	Get inner exception
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InnerException(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * pp_ieiffel_exception ) = 0;


	/*-----------------------------------------------------------
	Get exception message
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Message(  /* [out, retval] */ BSTR * pbstr_message ) = 0;


	/*-----------------------------------------------------------
	Retrieve exception type
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExceptionCode(  /* [out, retval] */ long * p_eif_exceptions ) = 0;



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