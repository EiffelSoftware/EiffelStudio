/*-----------------------------------------------------------
Implemented `IEiffelCompiler' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_IMPL_PROXY_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelCompiler_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelCompiler.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelCompiler_impl_proxy
{
public:
	IEiffelCompiler_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelCompiler_impl_proxy ();

	/*-----------------------------------------------------------
	Compile.
	-----------------------------------------------------------*/
	void ccom_compile();


	/*-----------------------------------------------------------
	Finalize.
	-----------------------------------------------------------*/
	void ccom_finalize();


	/*-----------------------------------------------------------
	Precompile.
	-----------------------------------------------------------*/
	void ccom_precompile();


	/*-----------------------------------------------------------
	Compile with piped output.
	-----------------------------------------------------------*/
	void ccom_compile_to_pipe();


	/*-----------------------------------------------------------
	Finalize with piped output.
	-----------------------------------------------------------*/
	void ccom_finalize_to_pipe();


	/*-----------------------------------------------------------
	Precompile with piped output.
	-----------------------------------------------------------*/
	void ccom_precompile_to_pipe();


	/*-----------------------------------------------------------
	Was last compilation successful?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_successful(  );


	/*-----------------------------------------------------------
	Did last compile warrant a call to finish_freezing?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_freezing_occurred(  );


	/*-----------------------------------------------------------
	Compiler version.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_compiler_version(  );


	/*-----------------------------------------------------------
	Takes a path and expands it using the env vars.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_expand_path(  /* [in] */ EIF_OBJECT a_path );


	/*-----------------------------------------------------------
	Generate a cyrptographic key filename.
	-----------------------------------------------------------*/
	void ccom_generate_msil_keyfile(  /* [in] */ EIF_OBJECT filename );


	/*-----------------------------------------------------------
	Eiffel Freeze command name
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_freeze_command_name(  );


	/*-----------------------------------------------------------
	Eiffel Freeze command arguments
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_freeze_command_arguments(  );


	/*-----------------------------------------------------------
	Is the compiler a trial version.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_has_signable_generation(  );


	/*-----------------------------------------------------------
	Remove file locks
	-----------------------------------------------------------*/
	void ccom_remove_file_locks();


	/*-----------------------------------------------------------
	Output pipe's name
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_output_pipe_name(  );


	/*-----------------------------------------------------------
	Set output pipe's name
	-----------------------------------------------------------*/
	void ccom_set_output_pipe_name(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Is compiler output sent to pipe `output_pipe_name'
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_output_piped(  );


	/*-----------------------------------------------------------
	Can product be run? (i.e. is it activated or was run less than 10 times)
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_can_run(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompiler * p_IEiffelCompiler;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE_c.h"


#endif