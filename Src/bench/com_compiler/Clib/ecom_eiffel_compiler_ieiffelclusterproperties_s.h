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
	Cluster name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_name(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_path(  /* [out, retval] */ BSTR * path ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_cluster_path(  /* [in] */ BSTR path ) = 0;


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP override(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name.
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
	Should preconditions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_require_by_default(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_ensure_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_ensure_by_default(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_check_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_check_by_default(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_loop_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_loop_by_default(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_invariant_by_default(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_invariant_by_default(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	List of excluded directories.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP excluded(  /* [out, retval] */ SAFEARRAY *  * return_value ) = 0;


	/*-----------------------------------------------------------
	Add a directory to exclude.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_exclude(  /* [in] */ BSTR dir_name ) = 0;


	/*-----------------------------------------------------------
	Remove a directory to exclude.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_exclude(  /* [in] */ BSTR dir_name ) = 0;



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