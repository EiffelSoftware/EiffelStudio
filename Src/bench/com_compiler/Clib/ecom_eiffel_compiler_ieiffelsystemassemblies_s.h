/*-----------------------------------------------------------
Eiffel System Assemblies.  Help file: 
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
class IEiffelSystemAssemblies : public IDispatch
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
	virtual STDMETHODIMP add_signed_assembly(  /* [in] */ BSTR assembly_identifier, /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey ) = 0;


	/*-----------------------------------------------------------
	Add a unsigned (local) assembly to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_unsigned_assembly(  /* [in] */ BSTR assembly_identifier, /* [in] */ BSTR a_path ) = 0;


	/*-----------------------------------------------------------
	Remove an assembly from the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_assembly(  /* [in] */ BSTR assembly_identifier ) = 0;


	/*-----------------------------------------------------------
	Cluster properties.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assembly_properties(  /* [in] */ BSTR assembly_identifier, /* [out, retval] */ ecom_eiffel_compiler::IEiffelAssemblyProperties * * return_value ) = 0;


	/*-----------------------------------------------------------
	Checks to see if a assembly identifier is valid
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_valid_identifier(  /* [in] */ BSTR assembly_identifier, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Checks to see if a assembly identifier has already been added to the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP contains_assembly(  /* [in] */ BSTR assembly_identifier, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Checks to see if a signed assembly has already been added to the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP contains_signed_assembly(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Checks to see if a unsigned assembly has already been added to the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP contains_unsigned_assembly(  /* [in] */ BSTR a_path, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Retrieves the identifier for a signed assembly in the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP identifier_from_signed_assembly(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey, /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Retrieves the identifier for a unsigned assembly in the project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP identifier_from_unsigned_assembly(  /* [in] */ BSTR a_path, /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Return all of the assemblies in an enumerator
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