/*-----------------------------------------------------------
Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_CEIFFELPROJECT_H__
#define __ECOM_EIFFEL_COMPILER_CEIFFELPROJECT_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class CEiffelProject;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelProject.h"

#include "ecom_eiffel_compiler_IEiffelException.h"

#include "ecom_eiffel_compiler_IEiffelCompiler.h"

#include "ecom_eiffel_compiler_IEiffelSystemBrowser.h"

#include "ecom_eiffel_compiler_IEiffelProjectProperties.h"

#include "ecom_eiffel_compiler_IEiffelCompletionInfo.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator.h"

#include "ecom_grt_globals_ISE_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class CEiffelProject
{
public:
	CEiffelProject ();
	CEiffelProject (IUnknown * a_pointer);
	virtual ~CEiffelProject ();

	/*-----------------------------------------------------------
	Retrieve Eiffel Project
	-----------------------------------------------------------*/
	void ccom_retrieve_eiffel_project(  /* [in] */ EIF_OBJECT a_project_file_name );


	/*-----------------------------------------------------------
	Create new Eiffel project.
	-----------------------------------------------------------*/
	void ccom_create_eiffel_project(  /* [in] */ EIF_OBJECT a_ace_file_name,  /* [in] */ EIF_OBJECT a_project_directory_path );


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
	EIF_BOOLEAN ccom_valid_project(  );


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
	EIF_REFERENCE ccom_html_doc_generator(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelProject * p_IEiffelProject;


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