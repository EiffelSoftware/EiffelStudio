/*-----------------------------------------------------------
Implemented `IEiffelSystemAssemblies' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMASSEMBLIES_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelSystemAssemblies_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelSystemAssemblies_impl_stub : public ecom_eiffel_compiler::IEiffelSystemAssemblies
{
public:
	IEiffelSystemAssemblies_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelSystemAssemblies_impl_stub ();

	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	STDMETHODIMP store( void );


	/*-----------------------------------------------------------
	Add a signed assembly to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP add_signed_assembly(  /* [in] */ BSTR assembly_identifier, /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey );


	/*-----------------------------------------------------------
	Add a unsigned (local) assembly to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP add_unsigned_assembly(  /* [in] */ BSTR assembly_identifier, /* [in] */ BSTR a_path );


	/*-----------------------------------------------------------
	Remove an assembly from the project.
	-----------------------------------------------------------*/
	STDMETHODIMP remove_assembly(  /* [in] */ BSTR assembly_identifier );


	/*-----------------------------------------------------------
	Cluster properties.
	-----------------------------------------------------------*/
	STDMETHODIMP assembly_properties(  /* [in] */ BSTR assembly_identifier, /* [out, retval] */ ecom_eiffel_compiler::IEiffelAssemblyProperties * * return_value );


	/*-----------------------------------------------------------
	Checks to see if a assembly identifier is valid
	-----------------------------------------------------------*/
	STDMETHODIMP is_valid_identifier(  /* [in] */ BSTR assembly_identifier, /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Checks to see if a assembly identifier has already been added to the project
	-----------------------------------------------------------*/
	STDMETHODIMP contains_assembly(  /* [in] */ BSTR assembly_identifier, /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Checks to see if a signed assembly has already been added to the project
	-----------------------------------------------------------*/
	STDMETHODIMP contains_signed_assembly(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey, /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Checks to see if a unsigned assembly has already been added to the project
	-----------------------------------------------------------*/
	STDMETHODIMP contains_unsigned_assembly(  /* [in] */ BSTR a_path, /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Retrieves the identifier for a signed assembly in the project
	-----------------------------------------------------------*/
	STDMETHODIMP identifier_from_signed_assembly(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_version, /* [in] */ BSTR a_culture, /* [in] */ BSTR a_publickey, /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Retrieves the identifier for a unsigned assembly in the project
	-----------------------------------------------------------*/
	STDMETHODIMP identifier_from_unsigned_assembly(  /* [in] */ BSTR a_path, /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Return all of the assemblies in an enumerator
	-----------------------------------------------------------*/
	STDMETHODIMP assemblies(  /* [out, retval] */ ecom_eiffel_compiler::IEnumAssembly * * return_value );


	/*-----------------------------------------------------------
	Get type info
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo );


	/*-----------------------------------------------------------
	Get type info count
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfoCount( unsigned int * pctinfo );


	/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
	-----------------------------------------------------------*/
	STDMETHODIMP GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid );


	/*-----------------------------------------------------------
	Invoke function.
	-----------------------------------------------------------*/
	STDMETHODIMP Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
	/*-----------------------------------------------------------
	Reference counter
	-----------------------------------------------------------*/
	LONG ref_count;


	/*-----------------------------------------------------------
	Corresponding Eiffel object
	-----------------------------------------------------------*/
	EIF_OBJECT eiffel_object;


	/*-----------------------------------------------------------
	Eiffel type id
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;


	/*-----------------------------------------------------------
	Type information
	-----------------------------------------------------------*/
	ITypeInfo * pTypeInfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_Eif_compiler.h"


#endif