/*-----------------------------------------------------------
Implemented `IEiffelSystemClusters' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMCLUSTERS_IMPL_STUB_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMCLUSTERS_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelSystemClusters_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_EiffelComCompiler_IEiffelSystemClusters.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelSystemClusters_impl_stub : public ecom_EiffelComCompiler::IEiffelSystemClusters
{
public:
	IEiffelSystemClusters_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelSystemClusters_impl_stub ();

	/*-----------------------------------------------------------
	Retrieve enumerator of clusters in tree form.
	-----------------------------------------------------------*/
	STDMETHODIMP GetClusterTree(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumClusterProp * * pp_ienum_cluster_prop );


	/*-----------------------------------------------------------
	Retrieve enumerator of all defined clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP GetAllClusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumClusterProp * * pp_ienum_cluster_prop );


	/*-----------------------------------------------------------
	Get a clusters full name from its name.
	-----------------------------------------------------------*/
	STDMETHODIMP GetClusterFullName(  /* [in] */ BSTR bstr_name, /* [out, retval] */ BSTR * pbstr_full_name );


	/*-----------------------------------------------------------
	Retrieve a clusters properties by its name.
	-----------------------------------------------------------*/
	STDMETHODIMP GetClusterProperties(  /* [in] */ BSTR bstr_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterProperties * * pp_ieiffel_cluster_properties );


	/*-----------------------------------------------------------
	Retrieve a clusters properties by its ID.
	-----------------------------------------------------------*/
	STDMETHODIMP GetClusterPropertiesById(  /* [in] */ ULONG n_cluster_id, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterProperties * * pp_ieiffel_cluster_properties );


	/*-----------------------------------------------------------
	Change a clusters name.
	-----------------------------------------------------------*/
	STDMETHODIMP ChangeClusterName(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_new_name );


	/*-----------------------------------------------------------
	Add a cluster to system clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP AddCluster(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_parent_name, /* [in] */ BSTR bstr_path );


	/*-----------------------------------------------------------
	Remove a cluster from system clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP RemoveCluster(  /* [in] */ BSTR bstr_name );


	/*-----------------------------------------------------------
	Persist current changes to disk
	-----------------------------------------------------------*/
	STDMETHODIMP Store( void );


	/*-----------------------------------------------------------
	Determins if 'bstrName' is available as a cluster name
	-----------------------------------------------------------*/
	STDMETHODIMP IsClusterNameAvailable(  /* [in] */ BSTR bstr_name, /* [out, retval] */ VARIANT_BOOL * pvb_available );


	/*-----------------------------------------------------------
	Validates a cluster name
	-----------------------------------------------------------*/
	STDMETHODIMP IsValidClusterName(  /* [in] */ BSTR bstr_name, /* [out, retval] */ VARIANT_BOOL * pvb_valid );


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