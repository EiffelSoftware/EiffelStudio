/*-----------------------------------------------------------
Implemented `IEiffelClusterProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERPROPERTIES_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERPROPERTIES_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelClusterProperties_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelClusterProperties_s.h"

#include "ecom_EiffelComCompiler_IEnumClusterExcludes_s.h"

#include "ecom_EiffelComCompiler_IEnumClusterProp_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelClusterProperties_impl_proxy
{
public:
	IEiffelClusterProperties_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelClusterProperties_impl_proxy ();

	/*-----------------------------------------------------------
	Last error code
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_error_code();


	/*-----------------------------------------------------------
	Last source of exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_source_of_exception();


	/*-----------------------------------------------------------
	Last error description
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_description();


	/*-----------------------------------------------------------
	Last error help file
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_help_file();


	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_cluster_path(  );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	void ccom_set_cluster_path(  /* [in] */ EIF_OBJECT pbstr_path );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_override(  );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	void ccom_set_override(  /* [in] */ EIF_BOOLEAN pvb_override );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_library(  );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	void ccom_set_is_library(  /* [in] */ EIF_BOOLEAN pvb_library );


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_all1(  );


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	void ccom_set_all(  /* [in] */ EIF_BOOLEAN pvb_all );


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_use_system_default(  );


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	void ccom_set_use_system_default(  /* [in] */ EIF_BOOLEAN pvb_use_defaults );


	/*-----------------------------------------------------------
	Should preconditions be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_require_by_default(  );


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_ensure_by_default(  );


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_check_by_default(  );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_loop_by_default(  );


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_invariant_by_default(  );


	/*-----------------------------------------------------------
	Set assertions for cluster.
	-----------------------------------------------------------*/
	void ccom_set_assertions(  /* [in] */ EIF_BOOLEAN vb_check,  /* [in] */ EIF_BOOLEAN vb_require,  /* [in] */ EIF_BOOLEAN vb_ensure,  /* [in] */ EIF_BOOLEAN vb_loop,  /* [in] */ EIF_BOOLEAN vb_invariant );


	/*-----------------------------------------------------------
	List of excluded directories.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_excluded(  );


	/*-----------------------------------------------------------
	Add a item to exclude.
	-----------------------------------------------------------*/
	void ccom_add_exclude(  /* [in] */ EIF_OBJECT bstr_name );


	/*-----------------------------------------------------------
	Remove a item from being excluded.
	-----------------------------------------------------------*/
	void ccom_remove_exclude(  /* [in] */ EIF_OBJECT bstr_name );


	/*-----------------------------------------------------------
	Name of the parent cluster.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_parent_name(  );


	/*-----------------------------------------------------------
	Does the current cluster have a parent cluster?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_has_parent(  );


	/*-----------------------------------------------------------
	List subclusters (list of IEiffelClusterProperties*).
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_subclusters(  );


	/*-----------------------------------------------------------
	Does the current cluster have children?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_has_children(  );


	/*-----------------------------------------------------------
	Cluster identifier.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_cluster_id(  );


	/*-----------------------------------------------------------
	Is the cluster in the Eiffel library
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_eiffel_library(  );


	/*-----------------------------------------------------------
	Full path to cluster with ISE_EIFFEL env var expanded.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_expanded_cluster_path(  );


	/*-----------------------------------------------------------
	Cluster namespace.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_cluster_namespace(  );


	/*-----------------------------------------------------------
	Cluster namespace.
	-----------------------------------------------------------*/
	void ccom_set_cluster_namespace(  /* [in] */ EIF_OBJECT pbstr_namespace );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClusterProperties * p_IEiffelClusterProperties;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;


	/*-----------------------------------------------------------
	Exception information
	-----------------------------------------------------------*/
	EXCEPINFO * excepinfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif