/*-----------------------------------------------------------
Implemented `IEiffelCompilerEvents' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPILEREVENTS_IMPL_STUB_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPILEREVENTS_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelCompilerEvents_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_EiffelComCompiler_IEiffelCompilerEvents.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelCompilerEvents_impl_stub : public ecom_EiffelComCompiler::IEiffelCompilerEvents
{
public:
	IEiffelCompilerEvents_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelCompilerEvents_impl_stub ();

	/*-----------------------------------------------------------
	Beginning compilation.
	-----------------------------------------------------------*/
	STDMETHODIMP BeginCompile( void );


	/*-----------------------------------------------------------
	Start of new degree phase in compilation.
	-----------------------------------------------------------*/
	STDMETHODIMP BeginDegree(  /* [in] */ LONG ul_degree );


	/*-----------------------------------------------------------
	Finished compilation.
	-----------------------------------------------------------*/
	STDMETHODIMP EndCompile(  /* [in] */ VARIANT_BOOL vb_sucessful );


	/*-----------------------------------------------------------
	Should compilation continue.
	-----------------------------------------------------------*/
	STDMETHODIMP ShouldContinue(  /* [in, out] */ VARIANT_BOOL * pvb_continue );


	/*-----------------------------------------------------------
	Output string.
	-----------------------------------------------------------*/
	STDMETHODIMP OutputString(  /* [in] */ BSTR bstr_output );


	/*-----------------------------------------------------------
	Last error.
	-----------------------------------------------------------*/
	STDMETHODIMP OutputError(  /* [in] */ BSTR bstr_full_error, /* [in] */ BSTR bstr_short_error, /* [in] */ BSTR bstr_code, /* [in] */ BSTR bstr_file_name, /* [in] */ ULONG ul_line, /* [in] */ ULONG ul_col );


	/*-----------------------------------------------------------
	Last warning.
	-----------------------------------------------------------*/
	STDMETHODIMP OutputWarning(  /* [in] */ BSTR bstr_full_warning, /* [in] */ BSTR bstr_short_warning, /* [in] */ BSTR bstr_code, /* [in] */ BSTR bstr_file_name, /* [in] */ ULONG ul_line, /* [in] */ ULONG ul_col );


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