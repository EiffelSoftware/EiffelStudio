/*-----------------------------------------------------------
Implemented `IEiffelSystemBrowser' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMBROWSER_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMBROWSER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelSystemBrowser_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelSystemBrowser_s.h"

#include "ecom_eiffel_compiler_IEnumClass_s.h"

#include "ecom_eiffel_compiler_IEnumCluster_s.h"

#include "ecom_eiffel_compiler_IEiffelClusterDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelClassDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelFeatureDescriptor_s.h"

#include "ecom_eiffel_compiler_IEnumFeature_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
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
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_cluster_count(  );


	/*-----------------------------------------------------------
	Cluster descriptor.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_cluster_descriptor(  /* [in] */ EIF_OBJECT cluster_name );


	/*-----------------------------------------------------------
	Class descriptor.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_class_descriptor(  /* [in] */ EIF_OBJECT class_name1 );


	/*-----------------------------------------------------------
	Feature descriptor.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_feature_descriptor(  /* [in] */ EIF_OBJECT class_name1,  /* [in] */ EIF_OBJECT feature_name );


	/*-----------------------------------------------------------
	Search classes with names matching `a_string'.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_search_classes(  /* [in] */ EIF_OBJECT a_string,  /* [in] */ EIF_BOOLEAN is_substring );


	/*-----------------------------------------------------------
	Search feature with names matching `a_string'.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_search_features(  /* [in] */ EIF_OBJECT a_string,  /* [in] */ EIF_BOOLEAN is_substring );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemBrowser * p_IEiffelSystemBrowser;


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif