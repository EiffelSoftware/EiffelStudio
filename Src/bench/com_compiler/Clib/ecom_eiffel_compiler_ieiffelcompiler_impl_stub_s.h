/*-----------------------------------------------------------
Implemented `IEiffelCompiler' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelCompiler_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelCompiler_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelCompiler_impl_stub : public ecom_eiffel_compiler::IEiffelCompiler
{
public:
	IEiffelCompiler_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelCompiler_impl_stub ();

	/*-----------------------------------------------------------
	Compile.
	-----------------------------------------------------------*/
	STDMETHODIMP compile( void );


	/*-----------------------------------------------------------
	Finalize.
	-----------------------------------------------------------*/
	STDMETHODIMP finalize( void );


	/*-----------------------------------------------------------
	Precompile.
	-----------------------------------------------------------*/
	STDMETHODIMP precompile( void );


	/*-----------------------------------------------------------
	Compile with piped output.
	-----------------------------------------------------------*/
	STDMETHODIMP compile_to_pipe( void );


	/*-----------------------------------------------------------
	Finalize with piped output.
	-----------------------------------------------------------*/
	STDMETHODIMP finalize_to_pipe( void );


	/*-----------------------------------------------------------
	Precompile with piped output.
	-----------------------------------------------------------*/
	STDMETHODIMP precompile_to_pipe( void );


	/*-----------------------------------------------------------
	Was last compilation successful?
	-----------------------------------------------------------*/
	STDMETHODIMP is_successful(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Did last compile warrant a call to finish_freezing?
	-----------------------------------------------------------*/
	STDMETHODIMP freezing_occurred(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Compiler version.
	-----------------------------------------------------------*/
	STDMETHODIMP compiler_version(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Return ISE_EIFFEL environment var.
	-----------------------------------------------------------*/
	STDMETHODIMP ise_eiffel(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Takes a path and expands it using the env vars.
	-----------------------------------------------------------*/
	STDMETHODIMP expand_path(  /* [in] */ BSTR a_path, /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Generate a cyrptographic key filename.
	-----------------------------------------------------------*/
	STDMETHODIMP generate_msil_keyfile(  /* [in] */ BSTR filename );


	/*-----------------------------------------------------------
	Eiffel Freeze command name
	-----------------------------------------------------------*/
	STDMETHODIMP freeze_command_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Eiffel Freeze command arguments
	-----------------------------------------------------------*/
	STDMETHODIMP freeze_command_arguments(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Is the compiler a trial version.
	-----------------------------------------------------------*/
	STDMETHODIMP has_signable_generation(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Remove file locks
	-----------------------------------------------------------*/
	STDMETHODIMP remove_file_locks( void );


	/*-----------------------------------------------------------
	Output pipe's name
	-----------------------------------------------------------*/
	STDMETHODIMP output_pipe_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Set output pipe's name
	-----------------------------------------------------------*/
	STDMETHODIMP set_output_pipe_name(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Is compiler output sent to pipe `output_pipe_name'
	-----------------------------------------------------------*/
	STDMETHODIMP is_output_piped(  /* [out, retval] */ VARIANT_BOOL * return_value );


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