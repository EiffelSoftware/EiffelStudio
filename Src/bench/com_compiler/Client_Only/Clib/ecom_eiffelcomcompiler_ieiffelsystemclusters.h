/*-----------------------------------------------------------
Eiffel System Clusters. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMCLUSTERS_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMCLUSTERS_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelSystemClusters_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemClusters_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemClusters;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEnumClusterProp_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumClusterProp_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumClusterProp;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEiffelClusterProperties_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClusterProperties_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClusterProperties;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelSystemClusters_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemClusters_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemClusters : public IDispatch
{
public:
	IEiffelSystemClusters () {};
	~IEiffelSystemClusters () {};

	/*-----------------------------------------------------------
	Retrieve enumerator of clusters in tree form.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetClusterTree(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumClusterProp * * pp_ienum_cluster_prop ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerator of all defined clusters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetAllClusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumClusterProp * * pp_ienum_cluster_prop ) = 0;


	/*-----------------------------------------------------------
	Get a clusters full name from its name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetClusterFullName(  /* [in] */ BSTR bstr_name, /* [out, retval] */ BSTR * pbstr_full_name ) = 0;


	/*-----------------------------------------------------------
	Retrieve a clusters properties by its name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetClusterProperties(  /* [in] */ BSTR bstr_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterProperties * * pp_ieiffel_cluster_properties ) = 0;


	/*-----------------------------------------------------------
	Retrieve a clusters properties by its ID.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetClusterPropertiesById(  /* [in] */ ULONG n_cluster_id, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterProperties * * pp_ieiffel_cluster_properties ) = 0;


	/*-----------------------------------------------------------
	Change a clusters name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ChangeClusterName(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_new_name ) = 0;


	/*-----------------------------------------------------------
	Add a cluster to system clusters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddCluster(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_parent_name, /* [in] */ BSTR bstr_path ) = 0;


	/*-----------------------------------------------------------
	Remove a cluster from system clusters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoveCluster(  /* [in] */ BSTR bstr_name ) = 0;


	/*-----------------------------------------------------------
	Persist current changes to disk
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Store( void ) = 0;


	/*-----------------------------------------------------------
	Determins if 'bstrName' is available as a cluster name
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsClusterNameAvailable(  /* [in] */ BSTR bstr_name, /* [out, retval] */ VARIANT_BOOL * pvb_available ) = 0;


	/*-----------------------------------------------------------
	Validates a cluster name
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsValidClusterName(  /* [in] */ BSTR bstr_name, /* [out, retval] */ VARIANT_BOOL * pvb_valid ) = 0;



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