/*-----------------------------------------------------------
Implemented `IEiffelCompilerEvents' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILEREVENTS_IMPL_STUB_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILEREVENTS_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelCompilerEvents_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelCompilerEvents.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelCompilerEvents_impl_stub : public ecom_eiffel_compiler::IEiffelCompilerEvents
{
public:
	IEiffelCompilerEvents_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelCompilerEvents_impl_stub ();

	/*-----------------------------------------------------------
	Should compilation continue.
	-----------------------------------------------------------*/
	STDMETHODIMP should_continue(  /* [in, out] */ VARIANT_BOOL * a_boolean );


	/*-----------------------------------------------------------
	Output string.
	-----------------------------------------------------------*/
	STDMETHODIMP output_string(  /* [in] */ BSTR a_string );


	/*-----------------------------------------------------------
	Last error.
	-----------------------------------------------------------*/
	STDMETHODIMP last_error(  /* [in] */ BSTR error_message, /* [in] */ BSTR file_name, /* [in] */ ULONG line_number );


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
#include "ecom_grt_globals_ISE_c.h"


#endif