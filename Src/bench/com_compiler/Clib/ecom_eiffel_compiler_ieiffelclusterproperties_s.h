/*-----------------------------------------------------------
Eiffel Cluster Properties (for Ace file).  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERPROPERTIES_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERPROPERTIES_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelClusterProperties_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelClusterProperties_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelClusterProperties;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEnumClusterExcludes_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumClusterExcludes_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumClusterExcludes;
}
#endif



#ifndef __ecom_eiffel_compiler_IEnumClusterProp_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumClusterProp_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumClusterProp;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelClusterProperties_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelClusterProperties_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelClusterProperties : public IDispatch
{
public:
	IEiffelClusterProperties () {};
	~IEiffelClusterProperties () {};

	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_path(  /* [out, retval] */ BSTR * path ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_cluster_path(  /* [in] */ BSTR path ) = 0;


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP override(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_override(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_library(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_is_library(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP all(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_all(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP use_system_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_use_system_default(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should preconditions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_require_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_ensure_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_check_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_loop_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_invariant_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Set assertions for cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_assertions(  /* [in] */ VARIANT_BOOL evaluate_check, /* [in] */ VARIANT_BOOL evaluate_require, /* [in] */ VARIANT_BOOL evaluate_ensure, /* [in] */ VARIANT_BOOL evaluate_loop, /* [in] */ VARIANT_BOOL evaluate_invariant ) = 0;


	/*-----------------------------------------------------------
	List of excluded directories.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP excluded(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClusterExcludes * * return_value ) = 0;


	/*-----------------------------------------------------------
	Add a directory to exclude.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_exclude(  /* [in] */ BSTR dir_name ) = 0;


	/*-----------------------------------------------------------
	Remove a directory to exclude.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_exclude(  /* [in] */ BSTR dir_name ) = 0;


	/*-----------------------------------------------------------
	Name of the parent cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP parent_name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Name of the parent cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_parent_name(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Does the current cluster have a parent cluster?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP has_parent(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	List of subclusters (list of IEiffelClusterProperties*).
	-----------------------------------------------------------*/
	virtual STDMETHODIMP subclusters(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClusterProp * * return_value ) = 0;


	/*-----------------------------------------------------------
	Does the current cluster have children?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP has_children(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Cluster identifier.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_id(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	Is the cluster in the Eiffel library
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_eiffel_library(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster with ISE_EIFFEL env var expanded.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP expanded_cluster_path(  /* [out, retval] */ BSTR * path ) = 0;


	/*-----------------------------------------------------------
	Does the path to the cluster exsit
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_path_exists(  /* [out, retval] */ VARIANT_BOOL * exists1 ) = 0;


	/*-----------------------------------------------------------
	Create the cluster path if it doesnt exist
	-----------------------------------------------------------*/
	virtual STDMETHODIMP create_cluster_path(  /* [out, retval] */ VARIANT_BOOL * exists1 ) = 0;


	/*-----------------------------------------------------------
	Does parent cluster have all set and does the cluster path extend upon the parents
	-----------------------------------------------------------*/
	virtual STDMETHODIMP all_cluster_path_not_excluded(  /* [out, retval] */ VARIANT_BOOL * exists1 ) = 0;


	/*-----------------------------------------------------------
	Cluster namespace.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_namespace(  /* [out, retval] */ BSTR * a_namespace ) = 0;


	/*-----------------------------------------------------------
	Cluster namespace.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_cluster_namespace(  /* [in] */ BSTR a_namespace ) = 0;



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