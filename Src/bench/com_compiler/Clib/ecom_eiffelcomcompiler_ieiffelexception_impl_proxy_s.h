/*-----------------------------------------------------------
Implemented `IEiffelException' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELEXCEPTION_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELEXCEPTION_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelException_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelException_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelException_impl_proxy
{
public:
	IEiffelException_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelException_impl_proxy ();

	/*-----------------------------------------------------------
	Last error code
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_error_code();


	/*-----------------------------------------------------------
	Last source of exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_source_of_exception();


	/*-----------------------------------------------------------
	Last error description
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_description();


	/*-----------------------------------------------------------
	Last error help file
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_help_file();


	/*-----------------------------------------------------------
	Get inner exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_inner_exception(  );


	/*-----------------------------------------------------------
	Get exception message
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_message(  );


	/*-----------------------------------------------------------
	Retrieve exception type
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_exception_code(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelException * p_IEiffelException;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;


	/*-----------------------------------------------------------
	Exception information
	-----------------------------------------------------------*/
	EXCEPINFO * excepinfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif