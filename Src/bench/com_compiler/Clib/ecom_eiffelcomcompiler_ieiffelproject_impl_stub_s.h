/*-----------------------------------------------------------
Implemented `IEiffelProject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECT_IMPL_STUB_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECT_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelProject_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_EiffelComCompiler_IEiffelProject_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelProject_impl_stub : public ecom_EiffelComCompiler::IEiffelProject
{
public:
	IEiffelProject_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelProject_impl_stub ();

	/*-----------------------------------------------------------
	Retrieve Eiffel Project
	-----------------------------------------------------------*/
	STDMETHODIMP RetrieveEiffelProject(  /* [in] */ BSTR bstr_project_file_name );


	/*-----------------------------------------------------------
	Create new Eiffel project from an existing ace file.
	-----------------------------------------------------------*/
	STDMETHODIMP CreateEiffelProject(  /* [in] */ BSTR bstr_ace_file_name, /* [in] */ BSTR bstr_project_directory );


	/*-----------------------------------------------------------
	Create new Eiffel project from scratch.
	-----------------------------------------------------------*/
	STDMETHODIMP GenerateNewEiffelProject(  /* [in] */ BSTR bstr_project_name, /* [in] */ BSTR bstr_ace_file_name, /* [in] */ BSTR bstr_root_class_name, /* [in] */ BSTR bstr_creation_routine, /* [in] */ BSTR bstr_project_directory );


	/*-----------------------------------------------------------
	Full path to .epr file.
	-----------------------------------------------------------*/
	STDMETHODIMP ProjectFileName(  /* [out, retval] */ BSTR * pbstr_project_file_name );


	/*-----------------------------------------------------------
	Full path to Ace file.
	-----------------------------------------------------------*/
	STDMETHODIMP AceFileName(  /* [out, retval] */ BSTR * pbstr_ace_file_name );


	/*-----------------------------------------------------------
	Project directory.
	-----------------------------------------------------------*/
	STDMETHODIMP ProjectDirectory(  /* [out, retval] */ BSTR * pbstr_project_directory );


	/*-----------------------------------------------------------
	Is project valid?
	-----------------------------------------------------------*/
	STDMETHODIMP IsValidProject(  /* [out, retval] */ VARIANT_BOOL * pvb_valid );


	/*-----------------------------------------------------------
	Last exception raised
	-----------------------------------------------------------*/
	STDMETHODIMP LastException(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * pp_ieiffel_exception );


	/*-----------------------------------------------------------
	Compiler.
	-----------------------------------------------------------*/
	STDMETHODIMP Compiler(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelCompiler * * pp_ieiffel_compiler );


	/*-----------------------------------------------------------
	Has system been compiled?
	-----------------------------------------------------------*/
	STDMETHODIMP IsCompiled(  /* [out, retval] */ VARIANT_BOOL * pvb_compiled );


	/*-----------------------------------------------------------
	Has the project updated since last compilation?
	-----------------------------------------------------------*/
	STDMETHODIMP ProjectHasUpdated(  /* [out, retval] */ VARIANT_BOOL * pvb_updated );


	/*-----------------------------------------------------------
	System Browser.
	-----------------------------------------------------------*/
	STDMETHODIMP SystemBrowser(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemBrowser * * pp_eiffel_system_browser );


	/*-----------------------------------------------------------
	Project Properties.
	-----------------------------------------------------------*/
	STDMETHODIMP ProjectProperties(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelProjectProperties * * pp_ieiffel_project_properties );


	/*-----------------------------------------------------------
	Completion information
	-----------------------------------------------------------*/
	STDMETHODIMP CompletionInformation(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelCompletionInfo * * pp_ieiffel_completion_info );


	/*-----------------------------------------------------------
	Help documentation generator
	-----------------------------------------------------------*/
	STDMETHODIMP HtmlDocumentationGenerator(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator * * pp_ieiffel_html_documentation_generator );


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