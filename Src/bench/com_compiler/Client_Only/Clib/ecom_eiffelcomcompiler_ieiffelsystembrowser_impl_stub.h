/*-----------------------------------------------------------
Implemented `IEiffelSystemBrowser' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMBROWSER_IMPL_STUB_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMBROWSER_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelSystemBrowser_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_EiffelComCompiler_IEiffelSystemBrowser.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelSystemBrowser_impl_stub : public ecom_EiffelComCompiler::IEiffelSystemBrowser
{
public:
	IEiffelSystemBrowser_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelSystemBrowser_impl_stub ();

	/*-----------------------------------------------------------
	List of classes in system.
	-----------------------------------------------------------*/
	STDMETHODIMP SystemClasses(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class );


	/*-----------------------------------------------------------
	Number of classes in system.
	-----------------------------------------------------------*/
	STDMETHODIMP ClassCount(  /* [out, retval] */ ULONG * pul_class_count );


	/*-----------------------------------------------------------
	List of system's clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP SystemClusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster );


	/*-----------------------------------------------------------
	List of system's external clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP ExternalClusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster );


	/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
	-----------------------------------------------------------*/
	STDMETHODIMP Assemblies(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumAssembly * * pp_ienum_assembly );


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	STDMETHODIMP ClusterCount(  /* [out, retval] */ ULONG * pul_cluster_count );


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	STDMETHODIMP RootCluster(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor );


	/*-----------------------------------------------------------
	Cluster descriptor.
	-----------------------------------------------------------*/
	STDMETHODIMP ClusterDescriptor(  /* [in] */ BSTR bstr_class_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor );


	/*-----------------------------------------------------------
	Class descriptor.
	-----------------------------------------------------------*/
	STDMETHODIMP ClassDescriptor(  /* [in] */ BSTR bstr_cluster_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClassDescriptor * * pp_ieiffel_class_descriptor );


	/*-----------------------------------------------------------
	Feature descriptor.
	-----------------------------------------------------------*/
	STDMETHODIMP FeatureDescriptor(  /* [in] */ BSTR bstr_class_name, /* [in] */ BSTR bstr_feature_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor );


	/*-----------------------------------------------------------
	Search classes with names matching `a_string'.
	-----------------------------------------------------------*/
	STDMETHODIMP SearchClasses(  /* [in] */ BSTR bstr_search_str, /* [in] */ VARIANT_BOOL vb_is_substring, /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class );


	/*-----------------------------------------------------------
	Search feature with names matching `a_string'.
	-----------------------------------------------------------*/
	STDMETHODIMP SearchFeatures(  /* [in] */ BSTR bstr_search_str, /* [in] */ VARIANT_BOOL vb_is_substring, /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Retrieve description from dotnet type
	-----------------------------------------------------------*/
	STDMETHODIMP DescriptionFromDotnetType(  /* [in] */ BSTR bstr_assembly_name, /* [in] */ BSTR bstr_full_dotnet_name, /* [out, retval] */ BSTR * pbstr_description );


	/*-----------------------------------------------------------
	Retrieve description from dotnet feature
	-----------------------------------------------------------*/
	STDMETHODIMP DescriptionFromDotnetFeature(  /* [in] */ BSTR bstr_assembly_name, /* [in] */ BSTR bstr_full_dotnet_name, /* [in] */ BSTR bstr_feature_signature, /* [out, retval] */ BSTR * pbstr_description );


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