/*-----------------------------------------------------------
Implemented `IEiffelClusterDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERDESCRIPTOR_IMPL_STUB_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERDESCRIPTOR_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelClusterDescriptor_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_EiffelComCompiler_IEiffelClusterDescriptor_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelClusterDescriptor_impl_stub : public ecom_EiffelComCompiler::IEiffelClusterDescriptor
{
public:
	IEiffelClusterDescriptor_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelClusterDescriptor_impl_stub ();

	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Cluster description.
	-----------------------------------------------------------*/
	STDMETHODIMP description(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Cluster Tool Tip.
	-----------------------------------------------------------*/
	STDMETHODIMP tool_tip(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	List of classes in cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP classes(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * some_classes );


	/*-----------------------------------------------------------
	Number of classes in cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP class_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of subclusters in cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP clusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * some_clusters );


	/*-----------------------------------------------------------
	Number of subclusters in cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_path(  /* [out, retval] */ BSTR * path );


	/*-----------------------------------------------------------
	Relative path to cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP relative_path(  /* [out, retval] */ BSTR * path );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	STDMETHODIMP is_override_cluster(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	STDMETHODIMP is_library(  /* [out, retval] */ VARIANT_BOOL * path );


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