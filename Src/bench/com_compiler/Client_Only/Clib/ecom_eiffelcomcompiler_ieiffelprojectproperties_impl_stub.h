/*-----------------------------------------------------------
Implemented `IEiffelProjectProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECTPROPERTIES_IMPL_STUB_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECTPROPERTIES_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelProjectProperties_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_EiffelComCompiler_IEiffelProjectProperties.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelProjectProperties_impl_stub : public ecom_EiffelComCompiler::IEiffelProjectProperties
{
public:
	IEiffelProjectProperties_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelProjectProperties_impl_stub ();

	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	STDMETHODIMP SystemName(  /* [out, retval] */ BSTR * pbstr_name );


	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_SystemName(  /* [in] */ BSTR pbstr_name );


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	STDMETHODIMP RootClassName(  /* [out, retval] */ BSTR * pbstr_class_name );


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_RootClassName(  /* [in] */ BSTR pbstr_class_name );


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	STDMETHODIMP CreationRoutine(  /* [out, retval] */ BSTR * pbstr_routine_name );


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_CreationRoutine(  /* [in] */ BSTR pbstr_routine_name );


	/*-----------------------------------------------------------
	Namespace generation for cluster
	-----------------------------------------------------------*/
	STDMETHODIMP NamespaceGeneration(  /* [out, retval] */ long * penum_cluster_namespace_generation );


	/*-----------------------------------------------------------
	Namespace generation for cluster
	-----------------------------------------------------------*/
	STDMETHODIMP set_NamespaceGeneration(  /* [in] */ long penum_cluster_namespace_generation );


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	STDMETHODIMP DefaultNamespace(  /* [out, retval] */ BSTR * pbstr_namespace );


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	STDMETHODIMP set_DefaultNamespace(  /* [in] */ BSTR pbstr_namespace );


	/*-----------------------------------------------------------
	Project type
	-----------------------------------------------------------*/
	STDMETHODIMP ProjectType(  /* [out, retval] */ long * penum_project_type );


	/*-----------------------------------------------------------
	Project type
	-----------------------------------------------------------*/
	STDMETHODIMP set_ProjectType(  /* [in] */ long penum_project_type );


	/*-----------------------------------------------------------
	.NET Naming convention
	-----------------------------------------------------------*/
	STDMETHODIMP DotNetNamingConvention(  /* [out, retval] */ VARIANT_BOOL * pvb_naming_convention );


	/*-----------------------------------------------------------
	.NET Naming convention
	-----------------------------------------------------------*/
	STDMETHODIMP set_DotNetNamingConvention(  /* [in] */ VARIANT_BOOL pvb_naming_convention );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	STDMETHODIMP GenerateDebugInfo(  /* [out, retval] */ VARIANT_BOOL * pvb_generate );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	STDMETHODIMP set_GenerateDebugInfo(  /* [in] */ VARIANT_BOOL pvb_generate );


	/*-----------------------------------------------------------
	Precompiled file.
	-----------------------------------------------------------*/
	STDMETHODIMP PrecompiledLibrary(  /* [out, retval] */ BSTR * pbstr_path );


	/*-----------------------------------------------------------
	Precompiled file.
	-----------------------------------------------------------*/
	STDMETHODIMP set_PrecompiledLibrary(  /* [in] */ BSTR pbstr_path );


	/*-----------------------------------------------------------
	Project assertions
	-----------------------------------------------------------*/
	STDMETHODIMP Assertions(  /* [out, retval] */ ULONG * pul_assertions );


	/*-----------------------------------------------------------
	Project assertions
	-----------------------------------------------------------*/
	STDMETHODIMP set_Assertions(  /* [in] */ ULONG pul_assertions );


	/*-----------------------------------------------------------
	Project Clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP Clusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemClusters * * pp_ieiffel_system_clusters );


	/*-----------------------------------------------------------
	Externals.
	-----------------------------------------------------------*/
	STDMETHODIMP Externals(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemExternals * * pp_ieiffel_system_externals );


	/*-----------------------------------------------------------
	Assemblies.
	-----------------------------------------------------------*/
	STDMETHODIMP Assemblies(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemAssemblies * * pp_ieiffel_system_assemblies );


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	STDMETHODIMP Title(  /* [out, retval] */ BSTR * pbstr_title );


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	STDMETHODIMP set_Title(  /* [in] */ BSTR pbstr_title );


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	STDMETHODIMP Description(  /* [out, retval] */ BSTR * pbstr_description );


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	STDMETHODIMP set_Description(  /* [in] */ BSTR pbstr_description );


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	STDMETHODIMP Company(  /* [out, retval] */ BSTR * pbstr_company );


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	STDMETHODIMP set_Company(  /* [in] */ BSTR pbstr_company );


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	STDMETHODIMP Product(  /* [out, retval] */ BSTR * ppbstr_product );


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	STDMETHODIMP set_Product(  /* [in] */ BSTR ppbstr_product );


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	STDMETHODIMP Version(  /* [out, retval] */ BSTR * pbstr_version );


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	STDMETHODIMP set_Version(  /* [in] */ BSTR pbstr_version );


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	STDMETHODIMP Trademark(  /* [out, retval] */ BSTR * pbstr_trademark );


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	STDMETHODIMP set_Trademark(  /* [in] */ BSTR pbstr_trademark );


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	STDMETHODIMP Copyright(  /* [out, retval] */ BSTR * pbstr_copyright );


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	STDMETHODIMP set_Copyright(  /* [in] */ BSTR pbstr_copyright );


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	STDMETHODIMP Culture(  /* [out, retval] */ BSTR * pbstr_cultre );


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	STDMETHODIMP set_Culture(  /* [in] */ BSTR pbstr_cultre );


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	STDMETHODIMP KeyFileName(  /* [out, retval] */ BSTR * pbstr_file_name );


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_KeyFileName(  /* [in] */ BSTR pbstr_file_name );


	/*-----------------------------------------------------------
	Project working directory
	-----------------------------------------------------------*/
	STDMETHODIMP WorkingDirectory(  /* [out, retval] */ BSTR * pbstr_working_directory );


	/*-----------------------------------------------------------
	Project working directory
	-----------------------------------------------------------*/
	STDMETHODIMP set_WorkingDirectory(  /* [in] */ BSTR pbstr_working_directory );


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
#include "ecom_grt_globals_ISE_c.h"


#endif