/*-----------------------------------------------------------
A single exception object Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELEXCEPTION_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELEXCEPTION_S_H__
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
	virtual STDMETHODIMP inner_exception(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * a_result ) = 0;


	/*-----------------------------------------------------------
	Get exception message
	-----------------------------------------------------------*/
	virtual STDMETHODIMP message(  /* [out, retval] */ BSTR * a_result ) = 0;


	/*-----------------------------------------------------------
	Retrieve exception type
	-----------------------------------------------------------*/
	virtual STDMETHODIMP exception_code(  /* [out, retval] */ long * a_result ) = 0;



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