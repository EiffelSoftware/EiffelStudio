/*-----------------------------------------------------------
Implemented `IEiffelProject' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELPROJECT_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELPROJECT_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelProject_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelProject_s.h"

#include "ecom_eiffel_compiler_IEiffelCompiler_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemBrowser_s.h"

#include "ecom_eiffel_compiler_IEiffelProjectProperties_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelProject_impl_proxy
{
public:
	IEiffelProject_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelProject_impl_proxy ();

	/*-----------------------------------------------------------
	Retrieve project.
	-----------------------------------------------------------*/
	void ccom_retrieve_project(  /* [in] */ EIF_OBJECT a_project_file_name );


	/*-----------------------------------------------------------
	Create new project.
	-----------------------------------------------------------*/
	void ccom_create_project(  /* [in] */ EIF_OBJECT an_ace_file_name,  /* [in] */ EIF_OBJECT project_directory_path );


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
	Last error message.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_message(  );


	/*-----------------------------------------------------------
	Compiler.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_compiler(  );


	/*-----------------------------------------------------------
	Has system been compiled?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_compiled(  );


	/*-----------------------------------------------------------
	System Browser.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_system_browser(  );


	/*-----------------------------------------------------------
	Project Properties.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_project_properties(  );


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif