/*-----------------------------------------------------------
Implemented `IEiffelSystemClusters' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMCLUSTERS_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMCLUSTERS_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelSystemClusters_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelSystemClusters_s.h"

#include "ecom_EiffelComCompiler_IEnumClusterProp_s.h"

#include "ecom_EiffelComCompiler_IEiffelClusterProperties_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelSystemClusters_impl_proxy
{
public:
	IEiffelSystemClusters_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelSystemClusters_impl_proxy ();

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
	Retrieve enumerator of clusters in tree form.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_get_cluster_tree(  );


	/*-----------------------------------------------------------
	Retrieve enumerator of all defined clusters.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_get_all_clusters(  );


	/*-----------------------------------------------------------
	Get a clusters full name from its name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_get_cluster_full_name(  /* [in] */ EIF_OBJECT bstr_name );


	/*-----------------------------------------------------------
	Retrieve a clusters properties by its name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_get_cluster_properties(  /* [in] */ EIF_OBJECT bstr_name );


	/*-----------------------------------------------------------
	Retrieve a clusters properties by its ID.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_get_cluster_properties_by_id(  /* [in] */ EIF_INTEGER n_cluster_id );


	/*-----------------------------------------------------------
	Change a clusters name.
	-----------------------------------------------------------*/
	void ccom_change_cluster_name(  /* [in] */ EIF_OBJECT bstr_name,  /* [in] */ EIF_OBJECT bstr_new_name );


	/*-----------------------------------------------------------
	Add a cluster to system clusters.
	-----------------------------------------------------------*/
	void ccom_add_cluster(  /* [in] */ EIF_OBJECT bstr_name,  /* [in] */ EIF_OBJECT bstr_parent_name,  /* [in] */ EIF_OBJECT bstr_path );


	/*-----------------------------------------------------------
	Remove a cluster from system clusters.
	-----------------------------------------------------------*/
	void ccom_remove_cluster(  /* [in] */ EIF_OBJECT bstr_name );


	/*-----------------------------------------------------------
	Persist current changes to disk
	-----------------------------------------------------------*/
	void ccom_store();


	/*-----------------------------------------------------------
	Determins if 'bstrName' is available as a cluster name
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_cluster_name_available(  /* [in] */ EIF_OBJECT bstr_name );


	/*-----------------------------------------------------------
	Validates a cluster name
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_valid_cluster_name(  /* [in] */ EIF_OBJECT bstr_name );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemClusters * p_IEiffelSystemClusters;


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