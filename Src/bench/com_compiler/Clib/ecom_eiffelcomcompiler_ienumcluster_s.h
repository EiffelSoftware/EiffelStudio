/*-----------------------------------------------------------
Eiffel Cluster Enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMCLUSTER_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMCLUSTER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEnumCluster_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumCluster_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumCluster;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelClusterDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClusterDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClusterDescriptor;
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
#ifndef __ecom_EiffelComCompiler_IEnumCluster_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEnumCluster_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumCluster : public IDispatch
{
public:
	IEnumCluster () {};
	~IEnumCluster () {};

	/*-----------------------------------------------------------
	Go to next item in enumerator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor, /* [out] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	Skip `ulCount' items.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG ul_count ) = 0;


	/*-----------------------------------------------------------
	Reset enumerator.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	Clone enumerator.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IthItem(  /* [in] */ ULONG ul_index, /* [out] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerator item count.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Count(  /* [out, retval] */ ULONG * pul_count ) = 0;



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