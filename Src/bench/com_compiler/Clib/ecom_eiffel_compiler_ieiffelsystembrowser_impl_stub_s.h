/*-----------------------------------------------------------
Implemented `IEiffelSystemBrowser' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMBROWSER_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMBROWSER_IMPL_STUB_S_H__
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

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelSystemBrowser_s.h"

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
	STDMETHODIMP system_classes(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClass * * some_classes );


	/*-----------------------------------------------------------
	Number of classes in system.
	-----------------------------------------------------------*/
	STDMETHODIMP class_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of system's clusters.
	-----------------------------------------------------------*/
	STDMETHODIMP system_clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEnumCluster * * some_clusters );


	/*-----------------------------------------------------------
	Number of top-level clusters in system.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_count(  /* [out, retval] */ LONG * return_value );


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




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_Eif_compiler.h"


#endif