/*-----------------------------------------------------------
Eiffel Cluster Properties (for Ace file). Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERPROPERTIES_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERPROPERTIES_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelClusterProperties_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClusterProperties_FWD_DEFINED__
namespace ecom_EiffelComCompiler
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

#ifndef __ecom_EiffelComCompiler_IEnumClusterExcludes_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumClusterExcludes_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumClusterExcludes;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumClusterProp_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumClusterProp_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumClusterProp;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelClusterProperties_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClusterProperties_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClusterProperties : public IDispatch
{
public:
	IEiffelClusterProperties () {};
	~IEiffelClusterProperties () {};

	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClusterPath(  /* [out, retval] */ BSTR * pbstr_path ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ClusterPath(  /* [in] */ BSTR pbstr_path ) = 0;


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Override(  /* [out, retval] */ VARIANT_BOOL * pvb_override ) = 0;


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Override(  /* [in] */ VARIANT_BOOL pvb_override ) = 0;


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsLibrary(  /* [out, retval] */ VARIANT_BOOL * pvb_library ) = 0;


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_IsLibrary(  /* [in] */ VARIANT_BOOL pvb_library ) = 0;


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP All(  /* [out, retval] */ VARIANT_BOOL * pvb_all ) = 0;


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_All(  /* [in] */ VARIANT_BOOL pvb_all ) = 0;


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UseSystemDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_use_defaults ) = 0;


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_UseSystemDefault(  /* [in] */ VARIANT_BOOL pvb_use_defaults ) = 0;


	/*-----------------------------------------------------------
	Should preconditions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EvaluateRequireByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_require ) = 0;


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EvaluateEnsureByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_ensure ) = 0;


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EvaluateCheckByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_check ) = 0;


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EvaluateLoopByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_loop ) = 0;


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EvaluateInvariantByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_invariant ) = 0;


	/*-----------------------------------------------------------
	Set assertions for cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetAssertions(  /* [in] */ VARIANT_BOOL vb_check, /* [in] */ VARIANT_BOOL vb_require, /* [in] */ VARIANT_BOOL vb_ensure, /* [in] */ VARIANT_BOOL vb_loop, /* [in] */ VARIANT_BOOL vb_invariant ) = 0;


	/*-----------------------------------------------------------
	List of excluded directories.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Excluded(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumClusterExcludes * * pp_ienum_cluster_excludes ) = 0;


	/*-----------------------------------------------------------
	Add a item to exclude.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddExclude(  /* [in] */ BSTR bstr_name ) = 0;


	/*-----------------------------------------------------------
	Remove a item from being excluded.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoveExclude(  /* [in] */ BSTR bstr_name ) = 0;


	/*-----------------------------------------------------------
	Name of the parent cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ParentName(  /* [out, retval] */ BSTR * pbstr_parent_name ) = 0;


	/*-----------------------------------------------------------
	Does the current cluster have a parent cluster?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HasParent(  /* [out, retval] */ VARIANT_BOOL * pvb_has_parent ) = 0;


	/*-----------------------------------------------------------
	List subclusters (list of IEiffelClusterProperties*).
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Subclusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumClusterProp * * pp_ienum_cluster_prop ) = 0;


	/*-----------------------------------------------------------
	Does the current cluster have children?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HasChildren(  /* [out, retval] */ VARIANT_BOOL * pvb_has_children ) = 0;


	/*-----------------------------------------------------------
	Cluster identifier.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClusterId(  /* [out, retval] */ ULONG * pul_id ) = 0;


	/*-----------------------------------------------------------
	Is the cluster in the Eiffel library
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsEiffelLibrary(  /* [out, retval] */ VARIANT_BOOL * pvb_eiffel_library ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster with ISE_EIFFEL env var expanded.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExpandedClusterPath(  /* [out, retval] */ BSTR * pbstr_expanded_path ) = 0;


	/*-----------------------------------------------------------
	Cluster namespace.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClusterNamespace(  /* [out, retval] */ BSTR * pbstr_namespace ) = 0;


	/*-----------------------------------------------------------
	Cluster namespace.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ClusterNamespace(  /* [in] */ BSTR pbstr_namespace ) = 0;



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