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
	Namespace generation for cluster
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_namespace_generation(  );


	/*-----------------------------------------------------------
	Namespace generation for cluster
	-----------------------------------------------------------*/
	void ccom_set_namespace_generation(  /* [in] */ EIF_INTEGER penu_cluster_namespace_generation );


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_default_namespace(  );


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	void ccom_set_default_namespace(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Project type
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_project_type(  );


	/*-----------------------------------------------------------
	Project type
	-----------------------------------------------------------*/
	void ccom_set_project_type(  /* [in] */ EIF_INTEGER penum_project_type );


	/*-----------------------------------------------------------
	.NET Naming convention
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_dot_net_naming_convention(  );


	/*-----------------------------------------------------------
	.NET Naming convention
	-----------------------------------------------------------*/
	void ccom_set_dot_net_naming_convention(  /* [in] */ EIF_BOOLEAN pvb_naming_convention );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_generate_debug_info(  );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	void ccom_set_generate_debug_info(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Precompiled file.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_precompiled_library(  );


	/*-----------------------------------------------------------
	Precompiled file.
	-----------------------------------------------------------*/
	void ccom_set_precompiled_library(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Project assertions
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_assertions(  );


	/*-----------------------------------------------------------
	Project assertions
	-----------------------------------------------------------*/
	void ccom_set_assertions(  /* [in] */ EIF_INTEGER p_assertions );


	/*-----------------------------------------------------------
	Project Clusters.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_clusters(  );


	/*-----------------------------------------------------------
	Externals.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_externals(  );


	/*-----------------------------------------------------------
	Assemblies.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assemblies(  );


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_title(  );


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	void ccom_set_title(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_description(  );


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	void ccom_set_description(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_company(  );


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	void ccom_set_company(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_product(  );


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	void ccom_set_product(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_version(  );


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	void ccom_set_version(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_trademark(  );


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	void ccom_set_trademark(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_copyright(  );


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	void ccom_set_copyright(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_culture(  );


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	void ccom_set_culture(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_key_file_name(  );


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	void ccom_set_key_file_name(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Project working directory
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_working_directory(  );


	/*-----------------------------------------------------------
	Project working directory
	-----------------------------------------------------------*/
	void ccom_set_working_directory(  /* [in] */ EIF_OBJECT pbstr_working_directory );


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