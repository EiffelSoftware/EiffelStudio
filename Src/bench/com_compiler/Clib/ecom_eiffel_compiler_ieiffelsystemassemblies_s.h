/*-----------------------------------------------------------
Eiffel System Assemblies. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMASSEMBLIES_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMASSEMBLIES_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelSystemAssemblies_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemAssemblies_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemAssemblies;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEiffelAssemblyProperties_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelAssemblyProperties_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelAssemblyProperties;
}
#endif



#ifndef __ecom_eiffel_compiler_IEnumAssembly_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumAssembly_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumAssembly;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelSystemAssemblies_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemAssemblies_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemAssemblies : public IUnknown
{
public:
	IEiffelSystemAssemblies () {};
	~IEiffelSystemAssemblies () {};

	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP store( void ) = 0;


	/*-----------------------------------------------------------
	Add a signed assembly to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_assembly(  /* [in] */ BSTR assembly_prefix, /* [in] */ BSTR cluster_name, /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey ) = 0;


	/*-----------------------------------------------------------
	Add a local assembly to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_local_assembly(  /* [in] */ BSTR assembly_prefix, /* [in] */ BSTR cluster_name, /* [in] */ BSTR a_path ) = 0;


	/*-----------------------------------------------------------
	Remove an assembly from the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_assembly(  /* [in] */ BSTR assembly_identifier ) = 0;


	/*-----------------------------------------------------------
	Assembly properties.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assembly_properties(  /* [in] */ BSTR cluster_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelAssemblyProperties * * return_value ) = 0;


	/*-----------------------------------------------------------
	Checks to see if a assembly cluster name is valid
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_valid_cluster_name(  /* [in] */ BSTR cluster_name, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Checks to see if a assembly cluster name has already been added to the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP contains_assembly(  /* [in] */ BSTR cluster_name, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Checks to see if a signed assembly has already been added to the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP contains_gac_assembly(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Checks to see if a unsigned assembly has already been added to the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP contains_local_assembly(  /* [in] */ BSTR a_path, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Retrieves the cluster name for a signed assembly in the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_name_from_gac_assembly(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey, /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Retrieves the cluster name for a unsigned assembly in the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_name_from_local_assembly(  /* [in] */ BSTR a_path, /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Is 'prefix' a valid assembly prefix
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_valid_prefix(  /* [in] */ BSTR assembly_prefix, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assemblies(  /* [out, retval] */ ecom_eiffel_compiler::IEnumAssembly * * return_value ) = 0;



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