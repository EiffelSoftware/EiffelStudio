/*-----------------------------------------------------------
Eiffel Cluster Properties Enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMCLUSTERPROP_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMCLUSTERPROP_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEnumClusterProp_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumClusterProp_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumClusterProp;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelClusterProperties_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClusterProperties_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClusterProperties;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumClusterProp_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumClusterProp_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumClusterProp;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEnumClusterProp_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEnumClusterProp_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumClusterProp : public IDispatch
{
public:
	IEnumClusterProp () {};
	~IEnumClusterProp () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelClusterProperties * * pp_ieiffel_cluster_properties, /* [out] */ ULONG * pul_fetched ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG ul_count ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumClusterProp * * pp_ienum_cluster_prop ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IthItem(  /* [in] */ ULONG ul_index, /* [out] */ ecom_EiffelComCompiler::IEiffelClusterProperties * * pp_ieiffel_cluster_properties ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Count(  /* [out, retval] */ ULONG * pul_count0 ) = 0;



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