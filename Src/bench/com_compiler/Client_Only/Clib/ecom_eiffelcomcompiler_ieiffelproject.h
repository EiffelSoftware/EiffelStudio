/*-----------------------------------------------------------
Eiffel Project. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECT_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECT_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelProject_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelProject_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelProject;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelException_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelException_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelException;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelCompiler_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelCompiler_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelCompiler;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelSystemBrowser_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemBrowser_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemBrowser;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelProjectProperties_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelProjectProperties_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelProjectProperties;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelCompletionInfo_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelCompletionInfo_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelCompletionInfo;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelHtmlDocumentationGenerator;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelProject_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelProject_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelProject : public IDispatch
{
public:
	IEiffelProject () {};
	~IEiffelProject () {};

	/*-----------------------------------------------------------
	Retrieve Eiffel Project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RetrieveEiffelProject(  /* [in] */ BSTR bstr_project_file_name ) = 0;


	/*-----------------------------------------------------------
	Create new Eiffel project from an existing ace file.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateEiffelProject(  /* [in] */ BSTR bstr_ace_file_name, /* [in] */ BSTR bstr_project_directory ) = 0;


	/*-----------------------------------------------------------
	Create new Eiffel project from scratch.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateNewEiffelProject(  /* [in] */ BSTR bstr_project_name, /* [in] */ BSTR bstr_ace_file_name, /* [in] */ BSTR bstr_root_class_name, /* [in] */ BSTR bstr_creation_routine, /* [in] */ BSTR bstr_project_directory ) = 0;


	/*-----------------------------------------------------------
	Full path to .epr file.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ProjectFileName(  /* [out, retval] */ BSTR * pbstr_project_file_name ) = 0;


	/*-----------------------------------------------------------
	Full path to Ace file.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AceFileName(  /* [out, retval] */ BSTR * pbstr_ace_file_name ) = 0;


	/*-----------------------------------------------------------
	Project directory.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ProjectDirectory(  /* [out, retval] */ BSTR * pbstr_project_directory ) = 0;


	/*-----------------------------------------------------------
	Is project valid?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsValidProject(  /* [out, retval] */ VARIANT_BOOL * pvb_valid ) = 0;


	/*-----------------------------------------------------------
	Last exception raised
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LastException(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * pp_ieiffel_exception ) = 0;


	/*-----------------------------------------------------------
	Compiler.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Compiler(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelCompiler * * pp_ieiffel_compiler ) = 0;


	/*-----------------------------------------------------------
	Has system been compiled?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsCompiled(  /* [out, retval] */ VARIANT_BOOL * pvb_compiled ) = 0;


	/*-----------------------------------------------------------
	Has the project updated since last compilation?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ProjectHasUpdated(  /* [out, retval] */ VARIANT_BOOL * pvb_updated ) = 0;


	/*-----------------------------------------------------------
	System Browser.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SystemBrowser(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemBrowser * * pp_eiffel_system_browser ) = 0;


	/*-----------------------------------------------------------
	Project Properties.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ProjectProperties(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelProjectProperties * * pp_ieiffel_project_properties ) = 0;


	/*-----------------------------------------------------------
	Completion information
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CompletionInformation(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelCompletionInfo * * pp_ieiffel_completion_info ) = 0;


	/*-----------------------------------------------------------
	Help documentation generator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HtmlDocumentationGenerator(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator * * pp_ieiffel_html_documentation_generator ) = 0;



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