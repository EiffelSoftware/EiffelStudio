/*-----------------------------------------------------------
Eiffel Completion info. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPLETIONINFO_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPLETIONINFO_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelCompletionInfo_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelCompletionInfo_FWD_DEFINED__
namespace ecom_EiffelComCompiler
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

#ifndef __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelFeatureDescriptor;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelCompletionInfo_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelCompletionInfo_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelCompletionInfo : public IDispatch
{
public:
	IEiffelCompletionInfo () {};
	~IEiffelCompletionInfo () {};

	/*-----------------------------------------------------------
	Add a local variable used for solving member completion list
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddLocal(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_type ) = 0;


	/*-----------------------------------------------------------
	Add an argument used for solving member completion list
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddArgument(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_type ) = 0;


	/*-----------------------------------------------------------
	Features accessible from target.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TargetFeatures(  /* [in] */ BSTR bstr_target, /* [in] */ BSTR bstr_feature_name, /* [in] */ BSTR bstr_file_name, /* [out] */ VARIANT * pvar_names, /* [out] */ VARIANT * pvar_signatures, /* [out] */ VARIANT * pvar_image_indexes ) = 0;


	/*-----------------------------------------------------------
	Feature information
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TargetFeature(  /* [in] */ BSTR bstr_target, /* [in] */ BSTR bstr_feature_name, /* [in] */ BSTR bstr_file_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor ) = 0;


	/*-----------------------------------------------------------
	Flush temporary completion features for a specific file
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FlushCompletionFeatures(  /* [in] */ BSTR bstr_file_name ) = 0;


	/*-----------------------------------------------------------
	Initialize a feature for completion without compiltation
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InitializeFeature(  /* [in] */ BSTR bstr_name, /* [in] */ VARIANT var_arguments, /* [in] */ VARIANT var_argument_types, /* [in] */ BSTR bstr_return_type, /* [in] */ ULONG ul_feature_type, /* [in] */ BSTR bstr_file_name ) = 0;



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