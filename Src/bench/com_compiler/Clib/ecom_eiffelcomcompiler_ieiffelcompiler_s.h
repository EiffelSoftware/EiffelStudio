/*-----------------------------------------------------------
Eiffel Compiler. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPILER_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPILER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelCompiler_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelCompiler_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelCompiler;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelCompiler_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelCompiler_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelCompiler : public IDispatch
{
public:
	IEiffelCompiler () {};
	~IEiffelCompiler () {};

	/*-----------------------------------------------------------
	Compiler version.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CompilerVersion(  /* [out, retval] */ BSTR * pbstr_version ) = 0;


	/*-----------------------------------------------------------
	Is the compiler a trial version.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HasSignableGeneration(  /* [out, retval] */ VARIANT_BOOL * pvb_signable ) = 0;


	/*-----------------------------------------------------------
	Can product be run? (i.e. is it activated or was run less than 10 times)
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CanRun(  /* [out, retval] */ VARIANT_BOOL * pvb_can_run ) = 0;


	/*-----------------------------------------------------------
	Compile.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Compile(  /* [in] */ long mode ) = 0;


	/*-----------------------------------------------------------
	Compile to an already established named pipe.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CompileToPipe(  /* [in] */ long mode, /* [in] */ BSTR bstr_pipe_name ) = 0;


	/*-----------------------------------------------------------
	Was last compilation successful?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP WasCompilationSuccessful(  /* [out, retval] */ VARIANT_BOOL * pvb_success ) = 0;


	/*-----------------------------------------------------------
	Did last compile warrant a call to finish_freezing?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FreezingOccurred(  /* [out, retval] */ VARIANT_BOOL * pvb_did_freeze ) = 0;


	/*-----------------------------------------------------------
	Eiffel Freeze command name
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FreezeCommandName(  /* [out, retval] */ BSTR * pbstr_cmd_name ) = 0;


	/*-----------------------------------------------------------
	Eiffel Freeze command arguments
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FreezeCommandArguments(  /* [out, retval] */ BSTR * pbstr_cmd_args ) = 0;


	/*-----------------------------------------------------------
	Remove file locks
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoveFileLocks( void ) = 0;


	/*-----------------------------------------------------------
	Should warning events be raised when compilation raises a warning?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_DisplayWarnings(  /* [in] */ VARIANT_BOOL arg_1 ) = 0;


	/*-----------------------------------------------------------
	Takes a path and expands it using the env vars.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExpandPath(  /* [in] */ BSTR bstr_path, /* [out, retval] */ BSTR * pbstr_full_path ) = 0;


	/*-----------------------------------------------------------
	Generate a cyrptographic key filename.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateMsilKeyFileName(  /* [in] */ BSTR bstr_file_name ) = 0;



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