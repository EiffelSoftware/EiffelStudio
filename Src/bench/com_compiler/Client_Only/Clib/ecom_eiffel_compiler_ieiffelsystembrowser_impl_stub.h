/*-----------------------------------------------------------
Implemented `IEiffelSystemBrowser' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMBROWSER_IMPL_STUB_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMBROWSER_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelSystemBrowser_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelSystemBrowser.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelSystemBrowser_impl_stub : public ecom_eiffel_compiler::IEiffelSystemBrowser
{
public:
	IEiffelSystemBrowser_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelSystemBrowser_impl_stub ();

	/*-----------------------------------------------------------
	List of classes in system.
	-----------------------------------------------------------*/
	STDMETHODIMP system_classes(  /* [out, retval] */ ecom_eiffel_compiler::IEnumEiffelClass * * some_classes );


	/*-----------------------------------------------------------
	Number of classes in system.
	-----------------------------------------------------------*/
	STDMETHODIMP class_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of system's clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP system_clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEnumCluster * * some_clusters );


	/*-----------------------------------------------------------
	List of system's external clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP external_clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEnumCluster * * some_clusters );


	/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
	-----------------------------------------------------------*/
	STDMETHODIMP assemblies(  /* [out, retval] */ ecom_eiffel_compiler::IEnumAssembly * * return_value );


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	STDMETHODIMP root_cluster(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterDescriptor * * return_value );


	/*-----------------------------------------------------------
	Cluster descriptor.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_descriptor(  /* [in] */ BSTR cluster_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterDescriptor * * return_value );


	/*-----------------------------------------------------------
	Class descriptor.
	-----------------------------------------------------------*/
	STDMETHODIMP class_descriptor(  /* [in] */ BSTR class_name1, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClassDescriptor * * return_value );


	/*-----------------------------------------------------------
	Feature descriptor.
	-----------------------------------------------------------*/
	STDMETHODIMP feature_descriptor(  /* [in] */ BSTR class_name1, /* [in] */ BSTR feature_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelFeatureDescriptor * * return_value );


	/*-----------------------------------------------------------
	Search classes with names matching `a_string'.
	-----------------------------------------------------------*/
	STDMETHODIMP search_classes(  /* [in] */ BSTR a_string, /* [in] */ VARIANT_BOOL is_substring, /* [out, retval] */ ecom_eiffel_compiler::IEnumEiffelClass * * some_classes );


	/*-----------------------------------------------------------
	Search feature with names matching `a_string'.
	-----------------------------------------------------------*/
	STDMETHODIMP search_features(  /* [in] */ BSTR a_string, /* [in] */ VARIANT_BOOL is_substring, /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_features );


	/*-----------------------------------------------------------
	Retrieve description from dotnet type
	-----------------------------------------------------------*/
	STDMETHODIMP description_from_dotnet_type(  /* [in] */ BSTR a_assembly_name, /* [in] */ BSTR a_full_dotnet_type, /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Retrieve description from dotnet feature
	-----------------------------------------------------------*/
	STDMETHODIMP description_from_dotnet_feature(  /* [in] */ BSTR a_assembly_name, /* [in] */ BSTR a_full_dotnet_type, /* [in] */ BSTR a_feature_signature, /* [out, retval] */ BSTR * return_value );


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