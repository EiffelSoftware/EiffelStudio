/*-----------------------------------------------------------
Implemented `IEiffelClusterProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERPROPERTIES_IMPL_STUB_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERPROPERTIES_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelClusterProperties_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_EiffelComCompiler_IEiffelClusterProperties.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelClusterProperties_impl_stub : public ecom_EiffelComCompiler::IEiffelClusterProperties
{
public:
	IEiffelClusterProperties_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelClusterProperties_impl_stub ();

	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP ClusterPath(  /* [out, retval] */ BSTR * pbstr_path );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP set_ClusterPath(  /* [in] */ BSTR pbstr_path );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	STDMETHODIMP Override(  /* [out, retval] */ VARIANT_BOOL * pvb_override );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	STDMETHODIMP set_Override(  /* [in] */ VARIANT_BOOL pvb_override );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	STDMETHODIMP IsLibrary(  /* [out, retval] */ VARIANT_BOOL * pvb_library );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	STDMETHODIMP set_IsLibrary(  /* [in] */ VARIANT_BOOL pvb_library );


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	STDMETHODIMP All(  /* [out, retval] */ VARIANT_BOOL * pvb_all );


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	STDMETHODIMP set_All(  /* [in] */ VARIANT_BOOL pvb_all );


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	STDMETHODIMP UseSystemDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_use_defaults );


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	STDMETHODIMP set_UseSystemDefault(  /* [in] */ VARIANT_BOOL pvb_use_defaults );


	/*-----------------------------------------------------------
	Should preconditions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP EvaluateRequireByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_require );


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP EvaluateEnsureByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_ensure );


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP EvaluateCheckByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_check );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP EvaluateLoopByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_loop );


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP EvaluateInvariantByDefault(  /* [out, retval] */ VARIANT_BOOL * pvb_invariant );


	/*-----------------------------------------------------------
	Set assertions for cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP SetAssertions(  /* [in] */ VARIANT_BOOL vb_check, /* [in] */ VARIANT_BOOL vb_require, /* [in] */ VARIANT_BOOL vb_ensure, /* [in] */ VARIANT_BOOL vb_loop, /* [in] */ VARIANT_BOOL vb_invariant );


	/*-----------------------------------------------------------
	List of excluded directories.
	-----------------------------------------------------------*/
	STDMETHODIMP Excluded(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumClusterExcludes * * pp_ienum_cluster_excludes );


	/*-----------------------------------------------------------
	Add a item to exclude.
	-----------------------------------------------------------*/
	STDMETHODIMP AddExclude(  /* [in] */ BSTR bstr_name );


	/*-----------------------------------------------------------
	Remove a item from being excluded.
	-----------------------------------------------------------*/
	STDMETHODIMP RemoveExclude(  /* [in] */ BSTR bstr_name );


	/*-----------------------------------------------------------
	Name of the parent cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP ParentName(  /* [out, retval] */ BSTR * pbstr_parent_name );


	/*-----------------------------------------------------------
	Does the current cluster have a parent cluster?
	-----------------------------------------------------------*/
	STDMETHODIMP HasParent(  /* [out, retval] */ VARIANT_BOOL * pvb_has_parent );


	/*-----------------------------------------------------------
	List subclusters (list of IEiffelClusterProperties*).
	-----------------------------------------------------------*/
	STDMETHODIMP Subclusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumClusterProp * * pp_ienum_cluster_prop );


	/*-----------------------------------------------------------
	Does the current cluster have children?
	-----------------------------------------------------------*/
	STDMETHODIMP HasChildren(  /* [out, retval] */ VARIANT_BOOL * pvb_has_children );


	/*-----------------------------------------------------------
	Cluster identifier.
	-----------------------------------------------------------*/
	STDMETHODIMP ClusterId(  /* [out, retval] */ ULONG * pul_id );


	/*-----------------------------------------------------------
	Is the cluster in the Eiffel library
	-----------------------------------------------------------*/
	STDMETHODIMP IsEiffelLibrary(  /* [out, retval] */ VARIANT_BOOL * pvb_eiffel_library );


	/*-----------------------------------------------------------
	Full path to cluster with ISE_EIFFEL env var expanded.
	-----------------------------------------------------------*/
	STDMETHODIMP ExpandedClusterPath(  /* [out, retval] */ BSTR * pbstr_expanded_path );


	/*-----------------------------------------------------------
	Cluster namespace.
	-----------------------------------------------------------*/
	STDMETHODIMP ClusterNamespace(  /* [out, retval] */ BSTR * pbstr_namespace );


	/*-----------------------------------------------------------
	Cluster namespace.
	-----------------------------------------------------------*/
	STDMETHODIMP set_ClusterNamespace(  /* [in] */ BSTR pbstr_namespace );


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