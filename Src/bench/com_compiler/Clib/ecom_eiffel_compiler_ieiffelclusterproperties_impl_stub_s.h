/*-----------------------------------------------------------
Implemented `IEiffelClusterProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERPROPERTIES_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERPROPERTIES_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelClusterProperties_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelClusterProperties_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelClusterProperties_impl_stub : public ecom_eiffel_compiler::IEiffelClusterProperties
{
public:
	IEiffelClusterProperties_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelClusterProperties_impl_stub ();

	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_name(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_path(  /* [out, retval] */ BSTR * path );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP set_cluster_path(  /* [in] */ BSTR path );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name.
	-----------------------------------------------------------*/
	STDMETHODIMP override(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_override(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	STDMETHODIMP is_library(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	STDMETHODIMP set_is_library(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	STDMETHODIMP all(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	STDMETHODIMP set_all(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	STDMETHODIMP use_system_default(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	STDMETHODIMP set_use_system_default(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should preconditions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_require_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should preconditions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_require_by_default(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_ensure_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_ensure_by_default(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_check_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_check_by_default(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_loop_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_loop_by_default(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_invariant_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_invariant_by_default(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	List of excluded directories.
	-----------------------------------------------------------*/
	STDMETHODIMP excluded(  /* [out, retval] */ SAFEARRAY *  * return_value );


	/*-----------------------------------------------------------
	Add a directory to exclude.
	-----------------------------------------------------------*/
	STDMETHODIMP add_exclude(  /* [in] */ BSTR dir_name );


	/*-----------------------------------------------------------
	Remove a directory to exclude.
	-----------------------------------------------------------*/
	STDMETHODIMP remove_exclude(  /* [in] */ BSTR dir_name );


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif