/*-----------------------------------------------------------
Eiffel Completion info.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONINFO_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONINFO_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelCompletionInfo_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelCompletionInfo_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelCompletionInfo;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEnumCompletionEntry_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumCompletionEntry_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumCompletionEntry;
}
#endif



#ifndef __ecom_eiffel_compiler_IEiffelFeatureDescriptor_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelFeatureDescriptor_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelFeatureDescriptor;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelCompletionInfo_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelCompletionInfo_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelCompletionInfo : public IUnknown
{
public:
	IEiffelCompletionInfo () {};
	~IEiffelCompletionInfo () {};

	/*-----------------------------------------------------------
	Add a local variable used for solving member completion list
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_local(  /* [in] */ BSTR name, /* [in] */ BSTR type ) = 0;


	/*-----------------------------------------------------------
	Add an argument used for solving member completion list
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_argument(  /* [in] */ BSTR name, /* [in] */ BSTR type ) = 0;


	/*-----------------------------------------------------------
	Features accessible from target.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP target_features(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out, retval] */ ecom_eiffel_compiler::IEnumCompletionEntry * * return_value ) = 0;


	/*-----------------------------------------------------------
	Feature information
	-----------------------------------------------------------*/
	virtual STDMETHODIMP target_feature(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelFeatureDescriptor * * return_value ) = 0;



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