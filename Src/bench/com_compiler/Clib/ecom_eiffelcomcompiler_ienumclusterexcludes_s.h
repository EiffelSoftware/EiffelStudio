/*-----------------------------------------------------------
Eiffel Cluster Exluded Directories Enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMCLUSTEREXCLUDES_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMCLUSTEREXCLUDES_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEnumClusterExcludes_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumClusterExcludes_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumClusterExcludes;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEnumClusterExcludes_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumClusterExcludes_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumClusterExcludes;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEnumClusterExcludes_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEnumClusterExcludes_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumClusterExcludes : public IDispatch
{
public:
	IEnumClusterExcludes () {};
	~IEnumClusterExcludes () {};

	/*-----------------------------------------------------------
	Go to next item in enumerator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ BSTR * pbstr_exclude, /* [out] */ ULONG * pul_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumClusterExcludes * * pp_ienum_cluster_excludes ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IthItem(  /* [in] */ ULONG ul_index, /* [out] */ BSTR * pbstr_exclude ) = 0;


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