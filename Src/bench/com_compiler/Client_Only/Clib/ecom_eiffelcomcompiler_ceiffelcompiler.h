/*-----------------------------------------------------------
Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_CEIFFELCOMPILER_H__
#define __ECOM_EIFFELCOMCOMPILER_CEIFFELCOMPILER_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class CEiffelCompiler;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelCompiler.h"

#include "ecom_EiffelComCompiler_IEiffelCompilerEvents.h"

#include "ecom_grt_globals_ISE_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class CEiffelCompiler
{
public:
	CEiffelCompiler (IUnknown * a_pointer);
	virtual ~CEiffelCompiler ();

	/*-----------------------------------------------------------
	Compiler version.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_compiler_version(  );


	/*-----------------------------------------------------------
	Is the compiler a trial version.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_has_signable_generation(  );


	/*-----------------------------------------------------------
	Can product be run? (i.e. is it activated or was run less than 10 times)
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_can_run(  );


	/*-----------------------------------------------------------
	Compile.
	-----------------------------------------------------------*/
	void ccom_compile(  /* [in] */ EIF_INTEGER mode );


	/*-----------------------------------------------------------
	Compile to an already established named pipe.
	-----------------------------------------------------------*/
	void ccom_compile_to_pipe(  /* [in] */ EIF_INTEGER mode,  /* [in] */ EIF_OBJECT bstr_pipe_name );


	/*-----------------------------------------------------------
	Was last compilation successful?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_was_compilation_successful(  );


	/*-----------------------------------------------------------
	Did last compile warrant a call to finish_freezing?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_freezing_occurred(  );


	/*-----------------------------------------------------------
	Eiffel Freeze command name
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_freeze_command_name(  );


	/*-----------------------------------------------------------
	Eiffel Freeze command arguments
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_freeze_command_arguments(  );


	/*-----------------------------------------------------------
	Remove file locks
	-----------------------------------------------------------*/
	void ccom_remove_file_locks();


	/*-----------------------------------------------------------
	Should warning events be raised when compilation raises a warning?
	-----------------------------------------------------------*/
	void ccom_set_display_warnings(  /* [in] */ EIF_BOOLEAN arg_1 );


	/*-----------------------------------------------------------
	Takes a path and expands it using the env vars.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_expand_path(  /* [in] */ EIF_OBJECT bstr_path );


	/*-----------------------------------------------------------
	Generate a cyrptographic key filename.
	-----------------------------------------------------------*/
	void ccom_generate_msil_key_file_name(  /* [in] */ EIF_OBJECT bstr_file_name );


	/*-----------------------------------------------------------
	Hook up call back interface.
	-----------------------------------------------------------*/
	void ccom_enable_call_back_on_ieiffel_compiler_events( EIF_POINTER p_events );


	/*-----------------------------------------------------------
	Tear down call back interface.
	-----------------------------------------------------------*/
	void ccom_disable_call_back_on_ieiffel_compiler_events();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelCompiler * p_IEiffelCompiler;


	/*-----------------------------------------------------------
	Call back interface cookie.
	-----------------------------------------------------------*/
	DWORD cookie_IEiffelCompilerEvents;


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