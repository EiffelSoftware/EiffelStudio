/*-----------------------------------------------------------
Implemented `IEiffelClusterDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERDESCRIPTOR_IMPL_STUB_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERDESCRIPTOR_IMPL_STUB_H__
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

#include "ecom_EiffelComCompiler_IEiffelClusterDescriptor.h"

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
	STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name );


	/*-----------------------------------------------------------
	Cluster description.
	-----------------------------------------------------------*/
	STDMETHODIMP Description(  /* [out, retval] */ BSTR * pbstr_description );


	/*-----------------------------------------------------------
	Cluster Tool Tip.
	-----------------------------------------------------------*/
	STDMETHODIMP ToolTip(  /* [out, retval] */ BSTR * pbstr_tool_top );


	/*-----------------------------------------------------------
	List of classes in cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP Classes(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class );


	/*-----------------------------------------------------------
	Number of classes in cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP ClassCount(  /* [out, retval] */ ULONG * pul_class_count );


	/*-----------------------------------------------------------
	List of subclusters in cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP Clusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster );


	/*-----------------------------------------------------------
	Number of subclusters in cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP ClusterCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP ClusterPath(  /* [out, retval] */ BSTR * pbstr_path );


	/*-----------------------------------------------------------
	Relative path to cluster.
	-----------------------------------------------------------*/
	STDMETHODIMP RelativePath(  /* [out, retval] */ BSTR * pbstr_path );


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	STDMETHODIMP IsOverrideCluster(  /* [out, retval] */ VARIANT_BOOL * pvb_override );


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	STDMETHODIMP IsLibrary(  /* [out, retval] */ VARIANT_BOOL * pvb_library );


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