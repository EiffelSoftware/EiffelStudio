/*-----------------------------------------------------------
Implemented `IEiffelClusterProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERPROPERTIES_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERPROPERTIES_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelClusterProperties_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelClusterProperties_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
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
	Cluster name.
	-----------------------------------------------------------*/
	void ccom_set_name(  /* [in] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_cluster_path(  );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	void ccom_set_cluster_path(  /* [in] */ EIF_OBJECT path );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_override(  );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name.
	-----------------------------------------------------------*/
	void ccom_set_override(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_library(  );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	void ccom_set_is_library(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_all1(  );


	/*-----------------------------------------------------------
	Should all subclusters be included?
	-----------------------------------------------------------*/
	void ccom_set_all(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_use_system_default(  );


	/*-----------------------------------------------------------
	Should use system default?
	-----------------------------------------------------------*/
	void ccom_set_use_system_default(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should preconditions be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_require_by_default(  );


	/*-----------------------------------------------------------
	Should preconditions be evaluated by default?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_require_by_default(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_ensure_by_default(  );


	/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_ensure_by_default(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_check_by_default(  );


	/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_check_by_default(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_loop_by_default(  );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_loop_by_default(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_evaluate_invariant_by_default(  );


	/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
	-----------------------------------------------------------*/
	void ccom_set_evaluate_invariant_by_default(  /* [in] */ EIF_BOOLEAN return_value );


	/*-----------------------------------------------------------
	List of excluded directories.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_excluded(  );


	/*-----------------------------------------------------------
	Add a directory to exclude.
	-----------------------------------------------------------*/
	void ccom_add_exclude(  /* [in] */ EIF_OBJECT dir_name );


	/*-----------------------------------------------------------
	Remove a directory to exclude.
	-----------------------------------------------------------*/
	void ccom_remove_exclude(  /* [in] */ EIF_OBJECT dir_name );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterProperties * p_IEiffelClusterProperties;


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif