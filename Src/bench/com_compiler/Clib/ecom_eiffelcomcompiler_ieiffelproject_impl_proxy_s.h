/*-----------------------------------------------------------
Implemented `IEiffelProject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECT_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECT_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelProject_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelProject_s.h"

#include "ecom_EiffelComCompiler_IEiffelException_s.h"

#include "ecom_EiffelComCompiler_IEiffelCompiler_s.h"

#include "ecom_EiffelComCompiler_IEiffelSystemBrowser_s.h"

#include "ecom_EiffelComCompiler_IEiffelProjectProperties_s.h"

#include "ecom_EiffelComCompiler_IEiffelCompletionInfo_s.h"

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelProject_impl_proxy
{
public:
	IEiffelProject_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelProject_impl_proxy ();

	/*-----------------------------------------------------------
	Retrieve Eiffel Project
	-----------------------------------------------------------*/
	void ccom_retrieve_eiffel_project(  /* [in] */ EIF_OBJECT bstr_project_file_name );


	/*-----------------------------------------------------------
	Create new Eiffel project from an existing ace file.
	-----------------------------------------------------------*/
	void ccom_create_eiffel_project(  /* [in] */ EIF_OBJECT bstr_ace_file_name,  /* [in] */ EIF_OBJECT bstr_project_directory );


	/*-----------------------------------------------------------
	Create new Eiffel project from scratch.
	-----------------------------------------------------------*/
	void ccom_generate_new_eiffel_project(  /* [in] */ EIF_OBJECT bstr_project_name,  /* [in] */ EIF_OBJECT bstr_ace_file_name,  /* [in] */ EIF_OBJECT bstr_root_class_name,  /* [in] */ EIF_OBJECT bstr_creation_routine,  /* [in] */ EIF_OBJECT bstr_project_directory );


	/*-----------------------------------------------------------
	Full path to .epr file.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_project_file_name(  );


	/*-----------------------------------------------------------
	Full path to Ace file.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ace_file_name(  );


	/*-----------------------------------------------------------
	Project directory.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_project_directory(  );


	/*-----------------------------------------------------------
	Is project valid?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_valid_project(  );


	/*-----------------------------------------------------------
	Last exception raised
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_exception(  );


	/*-----------------------------------------------------------
	Compiler.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_compiler(  );


	/*-----------------------------------------------------------
	Has system been compiled?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_compiled(  );


	/*-----------------------------------------------------------
	Has the project updated since last compilation?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_project_has_updated(  );


	/*-----------------------------------------------------------
	System Browser.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_system_browser(  );


	/*-----------------------------------------------------------
	Project Properties.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_project_properties(  );


	/*-----------------------------------------------------------
	Completion information
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_completion_information(  );


	/*-----------------------------------------------------------
	Help documentation generator
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_html_documentation_generator(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelProject * p_IEiffelProject;


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
#include "ecom_grt_globals_ISE.h"


#endif