/*-----------------------------------------------------------
Eiffel Cluster Descriptor. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERDESCRIPTOR_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCLUSTERDESCRIPTOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelClusterDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClusterDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
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

#ifndef __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumEiffelClass;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumCluster_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumCluster_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumCluster;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelClusterDescriptor_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClusterDescriptor_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClusterDescriptor : public IDispatch
{
public:
	IEiffelClusterDescriptor () {};
	~IEiffelClusterDescriptor () {};

	/*-----------------------------------------------------------
	Cluster name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name ) = 0;


	/*-----------------------------------------------------------
	Cluster description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Description(  /* [out, retval] */ BSTR * pbstr_description ) = 0;


	/*-----------------------------------------------------------
	Cluster Tool Tip.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ToolTip(  /* [out, retval] */ BSTR * pbstr_tool_top ) = 0;


	/*-----------------------------------------------------------
	List of classes in cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Classes(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	Number of classes in cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClassCount(  /* [out, retval] */ ULONG * pul_class_count ) = 0;


	/*-----------------------------------------------------------
	List of subclusters in cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster ) = 0;


	/*-----------------------------------------------------------
	Number of subclusters in cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClusterCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	Full path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClusterPath(  /* [out, retval] */ BSTR * pbstr_path ) = 0;


	/*-----------------------------------------------------------
	Relative path to cluster.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RelativePath(  /* [out, retval] */ BSTR * pbstr_path ) = 0;


	/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsOverrideCluster(  /* [out, retval] */ VARIANT_BOOL * pvb_override ) = 0;


	/*-----------------------------------------------------------
	Should this cluster be treated as library?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsLibrary(  /* [out, retval] */ VARIANT_BOOL * pvb_library ) = 0;



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