/*-----------------------------------------------------------
Implemented `IEiffelCompiler' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_IMPL_PROXY_S_H__
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

#include "ecom_eiffel_compiler_IEiffelCompiler_s.h"

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
	Return ISE_EIFFEL environment var.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ise_eiffel(  );


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif