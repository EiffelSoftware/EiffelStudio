/*-----------------------------------------------------------
Implemented `IEiffelProjectProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELPROJECTPROPERTIES_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELPROJECTPROPERTIES_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelProjectProperties_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelProjectProperties_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemClusters_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemExternals_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelProjectProperties_impl_proxy
{
public:
	IEiffelProjectProperties_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelProjectProperties_impl_proxy ();

	/*-----------------------------------------------------------
	Last error code
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_error_code();


	/*-----------------------------------------------------------
	Last source of exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_source_of_exception();


	/*-----------------------------------------------------------
	Last error description
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_description();


	/*-----------------------------------------------------------
	Last error help file
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_help_file();


	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_system_name(  );


	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	void ccom_set_system_name(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_root_class_name(  );


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	void ccom_set_root_class_name(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_creation_routine(  );


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	void ccom_set_creation_routine(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Compilation type.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_compilation_type(  );


	/*-----------------------------------------------------------
	Compilation type.
	-----------------------------------------------------------*/
	void ccom_set_compilation_type(  /* [in] */ EIF_INTEGER return_value );


	/*-----------------------------------------------------------
	Is console application?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_console_application(  );


	/*-----------------------------------------------------------
	Is console application?
	-----------------------------------------------------------*/
	void ccom_set_console_application(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should preconditions be evaluated?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_require(  );


	/*-----------------------------------------------------------
	Should preconditions be evaluated?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_require(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should postconditions be evaluated?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_ensure(  );


	/*-----------------------------------------------------------
	Should postconditions be evaluated?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_ensure(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should check assertions be evaluated?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_check(  );


	/*-----------------------------------------------------------
	Should check assertions be evaluated?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_check(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_loop(  );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_loop(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should class invariants be evaluated?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_invariant(  );


	/*-----------------------------------------------------------
	Should class invariants be evaluated?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_invariant(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_debug_info(  );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	void ccom_set_debug_info(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Project Clusters.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_clusters(  );


	/*-----------------------------------------------------------
	Externals.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_externals(  );


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_default_namespace(  );


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	void ccom_set_default_namespace(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Assemblies.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assemblies(  );


	/*-----------------------------------------------------------
	Project working directory.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_working_directory(  );


	/*-----------------------------------------------------------
	Project working directory.
	-----------------------------------------------------------*/
	void ccom_set_working_directory(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Update the project Ace file according to the current settings.
	-----------------------------------------------------------*/
	void ccom_update_project_ace_file(  /* [in] */ EIF_OBJECT project_ace_file_name );


	/*-----------------------------------------------------------
	Synchronize the current settings with the project Ace file.
	-----------------------------------------------------------*/
	void ccom_synchronize_with_project_ace_file(  /* [in] */ EIF_OBJECT project_ace_file_name );


	/*-----------------------------------------------------------
	Apply changes
	-----------------------------------------------------------*/
	void ccom_apply();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelProjectProperties * p_IEiffelProjectProperties;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;


	/*-----------------------------------------------------------
	Exception information
	-----------------------------------------------------------*/
	EXCEPINFO * excepinfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif