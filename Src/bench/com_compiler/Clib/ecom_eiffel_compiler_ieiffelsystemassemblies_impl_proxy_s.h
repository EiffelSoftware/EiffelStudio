/*-----------------------------------------------------------
Implemented `IEiffelSystemAssemblies' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_PROXY_S_H__
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

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies_s.h"

#include "ecom_eiffel_compiler_IEiffelAssemblyProperties_s.h"

#include "ecom_eiffel_compiler_IEnumAssembly_s.h"

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
	void ccom_add_signed_assembly(  /* [in] */ EIF_OBJECT assembly_identifier,  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_version,  /* [in] */ EIF_OBJECT a_culture,  /* [in] */ EIF_OBJECT a_publickey );


	/*-----------------------------------------------------------
	Add a unsigned (local) assembly to the project.
	-----------------------------------------------------------*/
	void ccom_add_unsigned_assembly(  /* [in] */ EIF_OBJECT assembly_identifier,  /* [in] */ EIF_OBJECT a_path );


	/*-----------------------------------------------------------
	Remove an assembly from the project.
	-----------------------------------------------------------*/
	void ccom_remove_assembly(  /* [in] */ EIF_OBJECT assembly_identifier );


	/*-----------------------------------------------------------
	Cluster properties.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_properties(  /* [in] */ EIF_OBJECT assembly_identifier );


	/*-----------------------------------------------------------
	Checks to see if a assembly identifier is valid
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_valid_identifier(  /* [in] */ EIF_OBJECT assembly_identifier );


	/*-----------------------------------------------------------
	Checks to see if a assembly identifier has already been added to the project
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_contains_assembly(  /* [in] */ EIF_OBJECT assembly_identifier );


	/*-----------------------------------------------------------
	Checks to see if a signed assembly has already been added to the project
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_contains_signed_assembly(  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_version,  /* [in] */ EIF_OBJECT a_culture,  /* [in] */ EIF_OBJECT a_publickey );


	/*-----------------------------------------------------------
	Checks to see if a unsigned assembly has already been added to the project
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_contains_unsigned_assembly(  /* [in] */ EIF_OBJECT a_path );


	/*-----------------------------------------------------------
	Retrieves the identifier for a signed assembly in the project
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_identifier_from_signed_assembly(  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_version,  /* [in] */ EIF_OBJECT a_culture,  /* [in] */ EIF_OBJECT a_publickey );


	/*-----------------------------------------------------------
	Retrieves the identifier for a unsigned assembly in the project
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_identifier_from_unsigned_assembly(  /* [in] */ EIF_OBJECT a_path );


	/*-----------------------------------------------------------
	Return all of the assemblies in an enumerator
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
#include "ecom_grt_globals_Eif_compiler.h"


#endif