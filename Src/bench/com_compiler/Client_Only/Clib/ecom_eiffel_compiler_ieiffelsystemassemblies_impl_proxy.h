/*-----------------------------------------------------------
Implemented `IEiffelSystemAssemblies' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_PROXY_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelSystemAssemblies_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies.h"

#include "ecom_eiffel_compiler_IEiffelAssemblyProperties.h"

#include "ecom_eiffel_compiler_IEnumAssembly.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelSystemAssemblies_impl_proxy
{
public:
	IEiffelSystemAssemblies_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelSystemAssemblies_impl_proxy ();

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
	Save changes.
	-----------------------------------------------------------*/
	void ccom_store();


	/*-----------------------------------------------------------
	Add a signed assembly to the project.
	-----------------------------------------------------------*/
	void ccom_add_assembly(  /* [in] */ EIF_OBJECT assembly_prefix,  /* [in] */ EIF_OBJECT cluster_name,  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_version,  /* [in] */ EIF_OBJECT a_culture,  /* [in] */ EIF_OBJECT a_publickey );


	/*-----------------------------------------------------------
	Remove an assembly from the project.
	-----------------------------------------------------------*/
	void ccom_remove_assembly(  /* [in] */ EIF_OBJECT assembly_identifier );


	/*-----------------------------------------------------------
	Assembly properties.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_properties(  /* [in] */ EIF_OBJECT cluster_name );


	/*-----------------------------------------------------------
	Checks to see if a assembly cluster name is valid
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_valid_cluster_name(  /* [in] */ EIF_OBJECT cluster_name );


	/*-----------------------------------------------------------
	Checks to see if a assembly cluster name has already been added to the project
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_contains_assembly(  /* [in] */ EIF_OBJECT cluster_name );


	/*-----------------------------------------------------------
	Checks to see if a signed assembly has already been added to the project
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_contains_gac_assembly(  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_version,  /* [in] */ EIF_OBJECT a_culture,  /* [in] */ EIF_OBJECT a_publickey );


	/*-----------------------------------------------------------
	Checks to see if a unsigned assembly has already been added to the project
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_contains_local_assembly(  /* [in] */ EIF_OBJECT a_path );


	/*-----------------------------------------------------------
	Retrieves the cluster name for a signed assembly in the project
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_cluster_name_from_gac_assembly(  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_version,  /* [in] */ EIF_OBJECT a_culture,  /* [in] */ EIF_OBJECT a_publickey );


	/*-----------------------------------------------------------
	Retrieves the cluster name for a unsigned assembly in the project
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_cluster_name_from_local_assembly(  /* [in] */ EIF_OBJECT a_path );


	/*-----------------------------------------------------------
	Is 'prefix' a valid assembly prefix
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_valid_prefix(  /* [in] */ EIF_OBJECT assembly_prefix );


	/*-----------------------------------------------------------
	Has the 'prefix' already been allocated to another assembly
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_prefix_allocated(  /* [in] */ EIF_OBJECT assembly_prefix );


	/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assemblies(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemAssemblies * p_IEiffelSystemAssemblies;


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
#include "ecom_grt_globals_ISE_c.h"


#endif