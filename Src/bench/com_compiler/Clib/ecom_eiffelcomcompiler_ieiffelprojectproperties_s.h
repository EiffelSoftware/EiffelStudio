/*-----------------------------------------------------------
Eiffel Project Properties. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECTPROPERTIES_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELPROJECTPROPERTIES_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelProjectProperties_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelProjectProperties_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelProjectProperties;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelSystemClusters_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemClusters_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemClusters;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelSystemExternals_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemExternals_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemExternals;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelSystemAssemblies_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemAssemblies_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemAssemblies;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelProjectProperties_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelProjectProperties_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelProjectProperties : public IDispatch
{
public:
	IEiffelProjectProperties () {};
	~IEiffelProjectProperties () {};

	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SystemName(  /* [out, retval] */ BSTR * pbstr_name ) = 0;


	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_SystemName(  /* [in] */ BSTR pbstr_name ) = 0;


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RootClassName(  /* [out, retval] */ BSTR * pbstr_class_name ) = 0;


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_RootClassName(  /* [in] */ BSTR pbstr_class_name ) = 0;


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreationRoutine(  /* [out, retval] */ BSTR * pbstr_routine_name ) = 0;


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_CreationRoutine(  /* [in] */ BSTR pbstr_routine_name ) = 0;


	/*-----------------------------------------------------------
	Namespace generation for cluster
	-----------------------------------------------------------*/
	virtual STDMETHODIMP NamespaceGeneration(  /* [out, retval] */ long * penum_cluster_namespace_generation ) = 0;


	/*-----------------------------------------------------------
	Namespace generation for cluster
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_NamespaceGeneration(  /* [in] */ long penum_cluster_namespace_generation ) = 0;


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DefaultNamespace(  /* [out, retval] */ BSTR * pbstr_namespace ) = 0;


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_DefaultNamespace(  /* [in] */ BSTR pbstr_namespace ) = 0;


	/*-----------------------------------------------------------
	Project type
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ProjectType(  /* [out, retval] */ long * penum_project_type ) = 0;


	/*-----------------------------------------------------------
	Project type
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ProjectType(  /* [in] */ long penum_project_type ) = 0;


	/*-----------------------------------------------------------
	Version of CLR compiler should target
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TargetClrVersion(  /* [out, retval] */ BSTR * pbstr_version ) = 0;


	/*-----------------------------------------------------------
	Version of CLR compiler should target
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_TargetClrVersion(  /* [in] */ BSTR pbstr_version ) = 0;


	/*-----------------------------------------------------------
	.NET Naming convention
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DotNetNamingConvention(  /* [out, retval] */ VARIANT_BOOL * pvb_naming_convention ) = 0;


	/*-----------------------------------------------------------
	.NET Naming convention
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_DotNetNamingConvention(  /* [in] */ VARIANT_BOOL pvb_naming_convention ) = 0;


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateDebugInfo(  /* [out, retval] */ VARIANT_BOOL * pvb_generate ) = 0;


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_GenerateDebugInfo(  /* [in] */ VARIANT_BOOL pvb_generate ) = 0;


	/*-----------------------------------------------------------
	Precompiled file.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PrecompiledLibrary(  /* [out, retval] */ BSTR * pbstr_path ) = 0;


	/*-----------------------------------------------------------
	Precompiled file.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_PrecompiledLibrary(  /* [in] */ BSTR pbstr_path ) = 0;


	/*-----------------------------------------------------------
	Project assertions
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Assertions(  /* [out, retval] */ ULONG * pul_assertions ) = 0;


	/*-----------------------------------------------------------
	Project assertions
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Assertions(  /* [in] */ ULONG pul_assertions ) = 0;


	/*-----------------------------------------------------------
	Project Clusters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemClusters * * pp_ieiffel_system_clusters ) = 0;


	/*-----------------------------------------------------------
	Externals.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Externals(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemExternals * * pp_ieiffel_system_externals ) = 0;


	/*-----------------------------------------------------------
	Assemblies.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Assemblies(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemAssemblies * * pp_ieiffel_system_assemblies ) = 0;


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Title(  /* [out, retval] */ BSTR * pbstr_title ) = 0;


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Title(  /* [in] */ BSTR pbstr_title ) = 0;


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Description(  /* [out, retval] */ BSTR * pbstr_description ) = 0;


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Description(  /* [in] */ BSTR pbstr_description ) = 0;


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Company(  /* [out, retval] */ BSTR * pbstr_company ) = 0;


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Company(  /* [in] */ BSTR pbstr_company ) = 0;


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Product(  /* [out, retval] */ BSTR * ppbstr_product ) = 0;


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Product(  /* [in] */ BSTR ppbstr_product ) = 0;


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Version(  /* [out, retval] */ BSTR * pbstr_version ) = 0;


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Version(  /* [in] */ BSTR pbstr_version ) = 0;


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Trademark(  /* [out, retval] */ BSTR * pbstr_trademark ) = 0;


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Trademark(  /* [in] */ BSTR pbstr_trademark ) = 0;


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Copyright(  /* [out, retval] */ BSTR * pbstr_copyright ) = 0;


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Copyright(  /* [in] */ BSTR pbstr_copyright ) = 0;


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Culture(  /* [out, retval] */ BSTR * pbstr_cultre ) = 0;


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Culture(  /* [in] */ BSTR pbstr_cultre ) = 0;


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP KeyFileName(  /* [out, retval] */ BSTR * pbstr_file_name ) = 0;


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_KeyFileName(  /* [in] */ BSTR pbstr_file_name ) = 0;


	/*-----------------------------------------------------------
	Project working directory
	-----------------------------------------------------------*/
	virtual STDMETHODIMP WorkingDirectory(  /* [out, retval] */ BSTR * pbstr_working_directory ) = 0;


	/*-----------------------------------------------------------
	Project working directory
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_WorkingDirectory(  /* [in] */ BSTR pbstr_working_directory ) = 0;


	/*-----------------------------------------------------------
	Apply changes
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Apply( void ) = 0;



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