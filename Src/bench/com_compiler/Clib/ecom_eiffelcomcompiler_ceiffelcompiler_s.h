/*-----------------------------------------------------------
Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_CEIFFELCOMPILER_S_H__
#define __ECOM_EIFFELCOMCOMPILER_CEIFFELCOMPILER_S_H__
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

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "CEiffelCompiler_factory.h"

#include "ecom_EiffelComCompiler_IEiffelCompiler_s.h"

#include "ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler.h"

#ifdef __cplusplus
extern "C" {
#endif

extern "C" const CLSID CLSID_CEiffelCompiler_;

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class CEiffelCompiler : public ecom_EiffelComCompiler::IEiffelCompiler, public IProvideClassInfo2, public IConnectionPointContainer
{
public:
	CEiffelCompiler (EIF_TYPE_ID tid);
	CEiffelCompiler (EIF_OBJECT eif_obj);
	virtual ~CEiffelCompiler ();

	/*-----------------------------------------------------------
	Compiler version.
	-----------------------------------------------------------*/
	STDMETHODIMP CompilerVersion(  /* [out, retval] */ BSTR * pbstr_version );


	/*-----------------------------------------------------------
	Is the compiler a trial version.
	-----------------------------------------------------------*/
	STDMETHODIMP HasSignableGeneration(  /* [out, retval] */ VARIANT_BOOL * pvb_signable );


	/*-----------------------------------------------------------
	Can product be run? (i.e. is it activated or was run less than 10 times)
	-----------------------------------------------------------*/
	STDMETHODIMP CanRun(  /* [out, retval] */ VARIANT_BOOL * pvb_can_run );


	/*-----------------------------------------------------------
	Compile.
	-----------------------------------------------------------*/
	STDMETHODIMP Compile(  /* [in] */ long mode );


	/*-----------------------------------------------------------
	Compile to an already established named pipe.
	-----------------------------------------------------------*/
	STDMETHODIMP CompileToPipe(  /* [in] */ long mode, /* [in] */ BSTR bstr_pipe_name );


	/*-----------------------------------------------------------
	Was last compilation successful?
	-----------------------------------------------------------*/
	STDMETHODIMP WasCompilationSuccessful(  /* [out, retval] */ VARIANT_BOOL * pvb_success );


	/*-----------------------------------------------------------
	Did last compile warrant a call to finish_freezing?
	-----------------------------------------------------------*/
	STDMETHODIMP FreezingOccurred(  /* [out, retval] */ VARIANT_BOOL * pvb_did_freeze );


	/*-----------------------------------------------------------
	Eiffel Freeze command name
	-----------------------------------------------------------*/
	STDMETHODIMP FreezeCommandName(  /* [out, retval] */ BSTR * pbstr_cmd_name );


	/*-----------------------------------------------------------
	Eiffel Freeze command arguments
	-----------------------------------------------------------*/
	STDMETHODIMP FreezeCommandArguments(  /* [out, retval] */ BSTR * pbstr_cmd_args );


	/*-----------------------------------------------------------
	Remove file locks
	-----------------------------------------------------------*/
	STDMETHODIMP RemoveFileLocks( void );


	/*-----------------------------------------------------------
	Should warning events be raised when compilation raises a warning?
	-----------------------------------------------------------*/
	STDMETHODIMP set_DisplayWarnings(  /* [in] */ VARIANT_BOOL arg_1 );


	/*-----------------------------------------------------------
	Takes a path and expands it using the env vars.
	-----------------------------------------------------------*/
	STDMETHODIMP ExpandPath(  /* [in] */ BSTR bstr_path, /* [out, retval] */ BSTR * pbstr_full_path );


	/*-----------------------------------------------------------
	Generate a cyrptographic key filename.
	-----------------------------------------------------------*/
	STDMETHODIMP GenerateMsilKeyFileName(  /* [in] */ BSTR bstr_file_name );


	/*-----------------------------------------------------------
	Get type info
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo );


	/*-----------------------------------------------------------
	Get type info count
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfoCount( unsigned int * pctinfo );


	/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
	-----------------------------------------------------------*/
	STDMETHODIMP GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid );


	/*-----------------------------------------------------------
	Invoke function.
	-----------------------------------------------------------*/
	STDMETHODIMP Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr );


	/*-----------------------------------------------------------
	EnumConnectionPoints of IConnectionPointContainer.
	-----------------------------------------------------------*/
	STDMETHODIMP EnumConnectionPoints( /* [out] */ IEnumConnectionPoints ** ppEnum );


	/*-----------------------------------------------------------
	FindConnectionPoint of IConnectionPointContainer.
	-----------------------------------------------------------*/
	STDMETHODIMP FindConnectionPoint( /* [in] */ REFIID riid, /* [out] */ IConnectionPoint ** ppCP );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface.
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );


	/*-----------------------------------------------------------
	GetClassInfo
	-----------------------------------------------------------*/
	STDMETHODIMP GetClassInfo( ITypeInfo ** ppti );


	/*-----------------------------------------------------------
	GetGUID
	-----------------------------------------------------------*/
	STDMETHODIMP GetGUID( DWORD dwKind, GUID * pguid );



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


	/*-----------------------------------------------------------
	Connection point implemntation for Source Interface IEiffelCompilerEvents.
	-----------------------------------------------------------*/
	ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler * p_ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler;


	/*-----------------------------------------------------------
	Type information
	-----------------------------------------------------------*/
	ITypeInfo * pTypeInfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif