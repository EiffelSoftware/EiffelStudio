/*-----------------------------------------------------------
Implemented `IEiffelException' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELEXCEPTION_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELEXCEPTION_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelException_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelException_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelException_impl_stub : public ecom_eiffel_compiler::IEiffelException
{
public:
	IEiffelException_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelException_impl_stub ();

	/*-----------------------------------------------------------
	Get inner exception
	-----------------------------------------------------------*/
	STDMETHODIMP inner_exception(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelException * * a_result );


	/*-----------------------------------------------------------
	Get exception message
	-----------------------------------------------------------*/
	STDMETHODIMP message(  /* [out, retval] */ BSTR * a_result );


	/*-----------------------------------------------------------
	Retrieve exception type
	-----------------------------------------------------------*/
	STDMETHODIMP exception_code(  /* [out, retval] */ long * a_result );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
	/*-----------------------------------------------------------
	Reference counter
	-----------------------------------------------------------*/
	LONG ref_count;


	/*-----------------------------------------------------------
	Corresponding Eiffel object
	-----------------------------------------------------------*/
	EIF_OBJECT eiffel_object;


	/*-----------------------------------------------------------
	Eiffel type id
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif