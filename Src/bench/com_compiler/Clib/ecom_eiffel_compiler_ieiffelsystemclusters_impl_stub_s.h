/*-----------------------------------------------------------
Implemented `IEiffelSystemClusters' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMCLUSTERS_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMCLUSTERS_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelSystemClusters_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelSystemClusters_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelSystemClusters_impl_stub : public ecom_eiffel_compiler::IEiffelSystemClusters
{
public:
	IEiffelSystemClusters_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelSystemClusters_impl_stub ();

	/*-----------------------------------------------------------
	Cluster tree.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_tree(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClusterProp * * return_value );


	/*-----------------------------------------------------------
	Cluster in a flat form.
	-----------------------------------------------------------*/
	STDMETHODIMP flat_clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClusterProp * * return_value );


	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	STDMETHODIMP store( void );


	/*-----------------------------------------------------------
	Add a cluster to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP add_cluster(  /* [in] */ BSTR cluster_name, /* [in] */ BSTR parent_name, /* [in] */ BSTR cluster_path );


	/*-----------------------------------------------------------
	Remove a cluster from the project.
	-----------------------------------------------------------*/
	STDMETHODIMP remove_cluster(  /* [in] */ BSTR cluster_name );


	/*-----------------------------------------------------------
	Cluster properties.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_properties(  /* [in] */ BSTR cluster_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterProperties * * return_value );


	/*-----------------------------------------------------------
	Cluster properties.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_properties_by_id(  /* [in] */ ULONG cluster_id, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterProperties * * return_value );


	/*-----------------------------------------------------------
	Change cluster name.
	-----------------------------------------------------------*/
	STDMETHODIMP change_cluster_name(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_new_name );


	/*-----------------------------------------------------------
	Checks to see if a cluster name is valid
	-----------------------------------------------------------*/
	STDMETHODIMP is_valid_name(  /* [in] */ BSTR cluster_name, /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Retrieves a clusters full name from its name
	-----------------------------------------------------------*/
	STDMETHODIMP get_cluster_fullname(  /* [in] */ BSTR cluster_name, /* [out, retval] */ BSTR * return_value );


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
#include "ecom_grt_globals_ISE.h"


#endif