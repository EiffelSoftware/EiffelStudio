/*-----------------------------------------------------------
Eiffel Compiler Events. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPILEREVENTS_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPILEREVENTS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelCompilerEvents_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelCompilerEvents_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelCompilerEvents;
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
#ifndef __ecom_EiffelComCompiler_IEiffelCompilerEvents_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelCompilerEvents_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelCompilerEvents : public IDispatch
{
public:
	IEiffelCompilerEvents () {};
	~IEiffelCompilerEvents () {};

	/*-----------------------------------------------------------
	Beginning compilation.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BeginCompile( void ) = 0;


	/*-----------------------------------------------------------
	Start of new degree phase in compilation.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP BeginDegree(  /* [in] */ LONG ul_degree ) = 0;


	/*-----------------------------------------------------------
	Finished compilation.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EndCompile(  /* [in] */ VARIANT_BOOL vb_sucessful ) = 0;


	/*-----------------------------------------------------------
	Should compilation continue.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ShouldContinue(  /* [in, out] */ VARIANT_BOOL * pvb_continue ) = 0;


	/*-----------------------------------------------------------
	Output string.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OutputString(  /* [in] */ BSTR bstr_output ) = 0;


	/*-----------------------------------------------------------
	Last error.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OutputError(  /* [in] */ BSTR bstr_full_error, /* [in] */ BSTR bstr_short_error, /* [in] */ BSTR bstr_code, /* [in] */ BSTR bstr_file_name, /* [in] */ ULONG ul_line, /* [in] */ ULONG ul_col ) = 0;


	/*-----------------------------------------------------------
	Last warning.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OutputWarning(  /* [in] */ BSTR bstr_full_warning, /* [in] */ BSTR bstr_short_warning, /* [in] */ BSTR bstr_code, /* [in] */ BSTR bstr_file_name, /* [in] */ ULONG ul_line, /* [in] */ ULONG ul_col ) = 0;



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