/*-----------------------------------------------------------
Eiffel System Clusters.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMCLUSTERS_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELSYSTEMCLUSTERS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelSystemClusters_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemClusters_FWD_DEFINED__
namespace ecom_eiffel_compiler
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

#ifndef __ecom_eiffel_compiler_IEnumClusterProp_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumClusterProp_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumClusterProp;
}
#endif



#ifndef __ecom_eiffel_compiler_IEiffelClusterProperties_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelClusterProperties_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelClusterProperties;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelSystemClusters_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemClusters_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemClusters : public IDispatch
{
public:
	IEiffelSystemClusters () {};
	~IEiffelSystemClusters () {};

	/*-----------------------------------------------------------
	Cluster tree.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_tree(  /* [out, retval] */ ecom_eiffel_compiler::IEnumClusterProp * * return_value ) = 0;


	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP store( void ) = 0;


	/*-----------------------------------------------------------
	Add a cluster to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_cluster(  /* [in] */ BSTR cluster_name, /* [in] */ BSTR parent_name, /* [in] */ BSTR cluster_path ) = 0;


	/*-----------------------------------------------------------
	Remove a cluster from the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_cluster(  /* [in] */ BSTR cluster_name ) = 0;


	/*-----------------------------------------------------------
	Cluster properties.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_properties(  /* [in] */ BSTR cluster_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterProperties * * return_value ) = 0;


	/*-----------------------------------------------------------
	Cluster properties.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP cluster_properties_by_id(  /* [in] */ ULONG cluster_id, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterProperties * * return_value ) = 0;


	/*-----------------------------------------------------------
	Change cluster name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP change_cluster_name(  /* [in] */ BSTR a_name, /* [in] */ BSTR a_new_name ) = 0;



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