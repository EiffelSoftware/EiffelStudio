/*-----------------------------------------------------------
Implemented `IEiffelClusterDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERDESCRIPTOR_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERDESCRIPTOR_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelClusterDescriptor_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelClusterDescriptor_s.h"

#include "ecom_eiffel_compiler_IEnumClass_s.h"

#include "ecom_eiffel_compiler_IEnumCluster_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelClusterDescriptor_impl_proxy
{
public:
	IEiffelClusterDescriptor_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelClusterDescriptor_impl_proxy ();

	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


	/*-----------------------------------------------------------
	Cluster description.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_description(  );


	/*-----------------------------------------------------------
	Cluster Tool Tip.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_tool_tip(  );


	/*-----------------------------------------------------------
	List of classes in cluster.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_classes(  );


	/*-----------------------------------------------------------
	Number of classes in cluster.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_class_count(  );


	/*-----------------------------------------------------------
	List of subclusters in cluster.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_clusters(  );


	/*-----------------------------------------------------------
	Number of subclusters in cluster.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_cluster_count(  );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_cluster_path(  );


	/*-----------------------------------------------------------
	Relative path to cluster.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_relative_path(  );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_override_cluster(  );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_library(  );


	/*-----------------------------------------------------------
	Should subclusters be included recursively?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_recursive(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterDescriptor * p_IEiffelClusterDescriptor;


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