/*-----------------------------------------------------------
Eiffel Feature Enumeration. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMFEATURE_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMFEATURE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumFeature;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelFeatureDescriptor;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumFeature;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEnumFeature_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEnumFeature_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumFeature : public IDispatch
{
public:
	IEnumFeature () {};
	~IEnumFeature () {};

	/*-----------------------------------------------------------
	Go to next item in enumerator
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor, /* [out] */ ULONG * pul_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IthItem(  /* [in] */ ULONG ul_index, /* [out] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor ) = 0;


	/*-----------------------------------------------------------
	Retrieve enumerator item count.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Count(  /* [out, retval] */ ULONG * ul_count ) = 0;



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