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
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG celt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumFeature * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ith_item(  /* [in] */ ULONG an_index, /* [out] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * rgelt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP count(  /* [out, retval] */ ULONG * return_value ) = 0;



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