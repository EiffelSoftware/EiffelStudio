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
	STDMETHODIMP retrieve_eiffel_project(  /* [in] */ BSTR a_project_file_name );


	/*-----------------------------------------------------------
	Create new Eiffel project.
	-----------------------------------------------------------*/
	STDMETHODIMP create_eiffel_project(  /* [in] */ BSTR a_ace_file_name, /* [in] */ BSTR a_project_directory_path );


	/*-----------------------------------------------------------
	Full path to .epr file.
	-----------------------------------------------------------*/
	STDMETHODIMP project_file_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Full path to Ace file.
	-----------------------------------------------------------*/
	STDMETHODIMP ace_file_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Project directory.
	-----------------------------------------------------------*/
	STDMETHODIMP project_directory(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Is project valid?
	-----------------------------------------------------------*/
	STDMETHODIMP valid_project(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Last exception raised
	-----------------------------------------------------------*/
	STDMETHODIMP last_exception(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * a_result );


	/*-----------------------------------------------------------
	Compiler.
	-----------------------------------------------------------*/
	STDMETHODIMP compiler(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelCompiler * * return_value );


	/*-----------------------------------------------------------
	Has system been compiled?
	-----------------------------------------------------------*/
	STDMETHODIMP is_compiled(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Has the project updated since last compilation?
	-----------------------------------------------------------*/
	STDMETHODIMP project_has_updated(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	System Browser.
	-----------------------------------------------------------*/
	STDMETHODIMP system_browser(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemBrowser * * return_value );


	/*-----------------------------------------------------------
	Project Properties.
	-----------------------------------------------------------*/
	STDMETHODIMP project_properties(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelProjectProperties * * return_value );


	/*-----------------------------------------------------------
	Completion information
	-----------------------------------------------------------*/
	STDMETHODIMP completion_information(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelCompletionInfo * * return_value );


	/*-----------------------------------------------------------
	Help documentation generator
	-----------------------------------------------------------*/
	STDMETHODIMP html_doc_generator(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * * return_value );


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