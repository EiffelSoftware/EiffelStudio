/*-----------------------------------------------------------
Implemented `IEiffelCompletionInfo' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPLETIONINFO_IMPL_STUB_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPLETIONINFO_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelCompletionInfo_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_EiffelComCompiler_IEiffelCompletionInfo_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelCompletionInfo_impl_stub : public ecom_EiffelComCompiler::IEiffelCompletionInfo
{
public:
	IEiffelCompletionInfo_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelCompletionInfo_impl_stub ();

	/*-----------------------------------------------------------
	Add a local variable used for solving member completion list
	-----------------------------------------------------------*/
	STDMETHODIMP AddLocal(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_type );


	/*-----------------------------------------------------------
	Add an argument used for solving member completion list
	-----------------------------------------------------------*/
	STDMETHODIMP AddArgument(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_type );


	/*-----------------------------------------------------------
	Features accessible from target.
	-----------------------------------------------------------*/
	STDMETHODIMP TargetFeatures(  /* [in] */ BSTR bstr_target, /* [in] */ BSTR bstr_feature_name, /* [in] */ BSTR bstr_file_name, /* [out] */ VARIANT * pvar_names, /* [out] */ VARIANT * pvar_signatures, /* [out] */ VARIANT * pvar_image_indexes );


	/*-----------------------------------------------------------
	Feature information
	-----------------------------------------------------------*/
	STDMETHODIMP TargetFeature(  /* [in] */ BSTR bstr_target, /* [in] */ BSTR bstr_feature_name, /* [in] */ BSTR bstr_file_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor );


	/*-----------------------------------------------------------
	Flush temporary completion features for a specific file
	-----------------------------------------------------------*/
	STDMETHODIMP FlushCompletionFeatures(  /* [in] */ BSTR bstr_file_name );


	/*-----------------------------------------------------------
	Initialize a feature for completion without compiltation
	-----------------------------------------------------------*/
	STDMETHODIMP InitializeFeature(  /* [in] */ BSTR bstr_name, /* [in] */ VARIANT var_arguments, /* [in] */ VARIANT var_argument_types, /* [in] */ BSTR bstr_return_type, /* [in] */ ULONG ul_feature_type, /* [in] */ BSTR bstr_file_name );


	/*-----------------------------------------------------------
	Get type info
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo );


	/*-----------------------------------------------------------
	Get type info count
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfoCount( unsigned int * pctinfo );


	/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
	-----------------------------------------------------------*/
	STDMETHODIMP GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid );


	/*-----------------------------------------------------------
	Invoke function.
	-----------------------------------------------------------*/
	STDMETHODIMP Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
	/*-----------------------------------------------------------
	Reference counter
	-----------------------------------------------------------*/
	LONG ref_count;


	/*-----------------------------------------------------------
	Corresponding Eiffel object
	-----------------------------------------------------------*/
	EIF_OBJECT eiffel_object;


	/*-----------------------------------------------------------
	Eiffel type id
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;


	/*-----------------------------------------------------------
	Type information
	-----------------------------------------------------------*/
	ITypeInfo * pTypeInfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif