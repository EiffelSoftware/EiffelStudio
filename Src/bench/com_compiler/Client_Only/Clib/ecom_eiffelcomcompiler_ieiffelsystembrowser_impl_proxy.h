/*-----------------------------------------------------------
Implemented `IEiffelSystemBrowser' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMBROWSER_IMPL_PROXY_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMBROWSER_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelSystemBrowser_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelSystemBrowser.h"

#include "ecom_EiffelComCompiler_IEnumEiffelClass.h"

#include "ecom_EiffelComCompiler_IEnumCluster.h"

#include "ecom_EiffelComCompiler_IEnumAssembly.h"

#include "ecom_EiffelComCompiler_IEiffelClusterDescriptor.h"

#include "ecom_EiffelComCompiler_IEiffelClassDescriptor.h"

#include "ecom_EiffelComCompiler_IEiffelFeatureDescriptor.h"

#include "ecom_EiffelComCompiler_IEnumFeature.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelSystemBrowser_impl_proxy
{
public:
	IEiffelSystemBrowser_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelSystemBrowser_impl_proxy ();

	/*-----------------------------------------------------------
	List of classes in system.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_system_classes(  );


	/*-----------------------------------------------------------
	Number of classes in system.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_class_count(  );


	/*-----------------------------------------------------------
	List of system's clusters.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_system_clusters(  );


	/*-----------------------------------------------------------
	List of system's external clusters.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_external_clusters(  );


	/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assemblies(  );


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_cluster_count(  );


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_root_cluster(  );


	/*-----------------------------------------------------------
	Cluster descriptor.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_cluster_descriptor(  /* [in] */ EIF_OBJECT bstr_class_name );


	/*-----------------------------------------------------------
	Class descriptor.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_class_descriptor(  /* [in] */ EIF_OBJECT bstr_cluster_name );


	/*-----------------------------------------------------------
	Feature descriptor.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_feature_descriptor(  /* [in] */ EIF_OBJECT bstr_class_name,  /* [in] */ EIF_OBJECT bstr_feature_name );


	/*-----------------------------------------------------------
	Search classes with names matching `a_string'.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_search_classes(  /* [in] */ EIF_OBJECT bstr_search_str,  /* [in] */ EIF_BOOLEAN vb_is_substring );


	/*-----------------------------------------------------------
	Search feature with names matching `a_string'.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_search_features(  /* [in] */ EIF_OBJECT bstr_search_str,  /* [in] */ EIF_BOOLEAN vb_is_substring );


	/*-----------------------------------------------------------
	Retrieve description from dotnet type
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_description_from_dotnet_type(  /* [in] */ EIF_OBJECT bstr_assembly_name,  /* [in] */ EIF_OBJECT bstr_full_dotnet_name );


	/*-----------------------------------------------------------
	Retrieve description from dotnet feature
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_description_from_dotnet_feature(  /* [in] */ EIF_OBJECT bstr_assembly_name,  /* [in] */ EIF_OBJECT bstr_full_dotnet_name,  /* [in] */ EIF_OBJECT bstr_feature_signature );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemBrowser * p_IEiffelSystemBrowser;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE_c.h"


#endif