/*-----------------------------------------------------------
System Browser. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMBROWSER_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMBROWSER_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelSystemBrowser_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemBrowser_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemBrowser;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumEiffelClass;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumCluster_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumCluster_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumCluster;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumAssembly_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumAssembly_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumAssembly;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelClusterDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClusterDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClusterDescriptor;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelClassDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClassDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClassDescriptor;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelFeatureDescriptor;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumFeature;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelSystemBrowser_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemBrowser_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemBrowser : public IDispatch
{
public:
	IEiffelSystemBrowser () {};
	~IEiffelSystemBrowser () {};

	/*-----------------------------------------------------------
	List of classes in system.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SystemClasses(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	Number of classes in system.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClassCount(  /* [out, retval] */ ULONG * pul_class_count ) = 0;


	/*-----------------------------------------------------------
	List of system's clusters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SystemClusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster ) = 0;


	/*-----------------------------------------------------------
	List of system's external clusters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExternalClusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster ) = 0;


	/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Assemblies(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumAssembly * * pp_ienum_assembly ) = 0;


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClusterCount(  /* [out, retval] */ ULONG * pul_cluster_count ) = 0;


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RootCluster(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor ) = 0;


	/*-----------------------------------------------------------
	Cluster descriptor.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClusterDescriptor(  /* [in] */ BSTR bstr_class_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor ) = 0;


	/*-----------------------------------------------------------
	Class descriptor.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClassDescriptor(  /* [in] */ BSTR bstr_cluster_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClassDescriptor * * pp_ieiffel_class_descriptor ) = 0;


	/*-----------------------------------------------------------
	Feature descriptor.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FeatureDescriptor(  /* [in] */ BSTR bstr_class_name, /* [in] */ BSTR bstr_feature_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor ) = 0;


	/*-----------------------------------------------------------
	Search classes with names matching `a_string'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SearchClasses(  /* [in] */ BSTR bstr_search_str, /* [in] */ VARIANT_BOOL vb_is_substring, /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	Search feature with names matching `a_string'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SearchFeatures(  /* [in] */ BSTR bstr_search_str, /* [in] */ VARIANT_BOOL vb_is_substring, /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Retrieve description from dotnet type
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DescriptionFromDotnetType(  /* [in] */ BSTR bstr_assembly_name, /* [in] */ BSTR bstr_full_dotnet_name, /* [out, retval] */ BSTR * pbstr_description ) = 0;


	/*-----------------------------------------------------------
	Retrieve description from dotnet feature
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DescriptionFromDotnetFeature(  /* [in] */ BSTR bstr_assembly_name, /* [in] */ BSTR bstr_full_dotnet_name, /* [in] */ BSTR bstr_feature_signature, /* [out, retval] */ BSTR * pbstr_description ) = 0;



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