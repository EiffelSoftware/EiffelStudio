/*-----------------------------------------------------------
Implemented `IEiffelProjectProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELPROJECTPROPERTIES_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELPROJECTPROPERTIES_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelProjectProperties_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelProjectProperties_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelProjectProperties_impl_stub : public ecom_eiffel_compiler::IEiffelProjectProperties
{
public:
	IEiffelProjectProperties_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelProjectProperties_impl_stub ();

	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	STDMETHODIMP system_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_system_name(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	STDMETHODIMP root_class_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_root_class_name(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	STDMETHODIMP creation_routine(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_creation_routine(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Namespace generation for cluster
	-----------------------------------------------------------*/
	STDMETHODIMP namespace_generation(  /* [out, retval] */ long * penu_cluster_namespace_generation );


	/*-----------------------------------------------------------
	Namespace generation for cluster
	-----------------------------------------------------------*/
	STDMETHODIMP set_namespace_generation(  /* [in] */ long penu_cluster_namespace_generation );


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	STDMETHODIMP default_namespace(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	STDMETHODIMP set_default_namespace(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Project type
	-----------------------------------------------------------*/
	STDMETHODIMP project_type(  /* [out, retval] */ long * penum_project_type );


	/*-----------------------------------------------------------
	Project type
	-----------------------------------------------------------*/
	STDMETHODIMP set_project_type(  /* [in] */ long penum_project_type );


	/*-----------------------------------------------------------
	.NET Naming convention
	-----------------------------------------------------------*/
	STDMETHODIMP dot_net_naming_convention(  /* [out, retval] */ VARIANT_BOOL * pvb_naming_convention );


	/*-----------------------------------------------------------
	.NET Naming convention
	-----------------------------------------------------------*/
	STDMETHODIMP set_dot_net_naming_convention(  /* [in] */ VARIANT_BOOL pvb_naming_convention );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	STDMETHODIMP generate_debug_info(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	STDMETHODIMP set_generate_debug_info(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Precompiled file.
	-----------------------------------------------------------*/
	STDMETHODIMP precompiled_library(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Precompiled file.
	-----------------------------------------------------------*/
	STDMETHODIMP set_precompiled_library(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Project assertions
	-----------------------------------------------------------*/
	STDMETHODIMP assertions(  /* [out, retval] */ ULONG * p_assertions );


	/*-----------------------------------------------------------
	Project assertions
	-----------------------------------------------------------*/
	STDMETHODIMP set_assertions(  /* [in] */ ULONG p_assertions );


	/*-----------------------------------------------------------
	Project Clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemClusters * * return_value );


	/*-----------------------------------------------------------
	Externals.
	-----------------------------------------------------------*/
	STDMETHODIMP externals(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemExternals * * return_value );


	/*-----------------------------------------------------------
	Assemblies.
	-----------------------------------------------------------*/
	STDMETHODIMP assemblies(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemAssemblies * * return_value );


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	STDMETHODIMP title(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	STDMETHODIMP set_title(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	STDMETHODIMP description(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	STDMETHODIMP set_description(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	STDMETHODIMP company(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	STDMETHODIMP set_company(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	STDMETHODIMP product(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	STDMETHODIMP set_product(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	STDMETHODIMP version(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	STDMETHODIMP set_version(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	STDMETHODIMP trademark(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	STDMETHODIMP set_trademark(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	STDMETHODIMP copyright(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	STDMETHODIMP set_copyright(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	STDMETHODIMP culture(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	STDMETHODIMP set_culture(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	STDMETHODIMP key_file_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_key_file_name(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Project working directory
	-----------------------------------------------------------*/
	STDMETHODIMP working_directory(  /* [out, retval] */ BSTR * pbstr_working_directory );


	/*-----------------------------------------------------------
	Project working directory
	-----------------------------------------------------------*/
	STDMETHODIMP set_working_directory(  /* [in] */ BSTR pbstr_working_directory );


	/*-----------------------------------------------------------
	Apply changes
	-----------------------------------------------------------*/
	STDMETHODIMP Apply( void );


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
#include "ecom_grt_globals_ISE.h"


#endif