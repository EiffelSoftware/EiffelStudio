/*-----------------------------------------------------------
Eiffel Cluster Descriptor. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERDESCRIPTOR_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCLUSTERDESCRIPTOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelClusterDescriptor_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelClusterDescriptor_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelClusterDescriptor;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEnumEiffelClass_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumEiffelClass_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumEiffelClass;
}
#endif



#ifndef __ecom_eiffel_compiler_IEnumCluster_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumCluster_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumCluster;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelClusterDescriptor_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelClusterDescriptor_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelClusterDescriptor : public IUnknown
{
public:
	IEiffelClusterDescriptor () {};
	~IEiffelClusterDescriptor () {};

	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Cluster description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP description(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Cluster Tool Tip.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP tool_tip(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	List of classes in cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP classes(  /* [out, retval] */ ecom_eiffel_compiler::IEnumEiffelClass * * some_classes ) = 0;


	/*-----------------------------------------------------------
	Number of classes in cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP class_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of subclusters in cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEnumCluster * * some_clusters ) = 0;


	/*-----------------------------------------------------------
	Number of subclusters in cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_path(  /* [out, retval] */ BSTR * path ) = 0;


	/*-----------------------------------------------------------
	Relative path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP relative_path(  /* [out, retval] */ BSTR * path ) = 0;


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_override_cluster(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_library(  /* [out, retval] */ VARIANT_BOOL * path ) = 0;



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