/*-----------------------------------------------------------
Implemented `IEiffelCompletionInfo' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONINFO_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONINFO_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelCompletionInfo_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelCompletionInfo_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelCompletionInfo_impl_stub : public ecom_eiffel_compiler::IEiffelCompletionInfo
{
public:
	IEiffelCompletionInfo_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelCompletionInfo_impl_stub ();

	/*-----------------------------------------------------------
	Add a local variable used for solving member completion list
	-----------------------------------------------------------*/
	STDMETHODIMP add_local(  /* [in] */ BSTR name, /* [in] */ BSTR type );


	/*-----------------------------------------------------------
	Add an argument used for solving member completion list
	-----------------------------------------------------------*/
	STDMETHODIMP add_argument(  /* [in] */ BSTR name, /* [in] */ BSTR type );


	/*-----------------------------------------------------------
	Features accessible from target.
	-----------------------------------------------------------*/
	STDMETHODIMP target_features(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out] */ VARIANT * return_names, /* [out] */ VARIANT * return_signatures, /* [out] */ VARIANT * return_image_indexes );


	/*-----------------------------------------------------------
	Feature information
	-----------------------------------------------------------*/
	STDMETHODIMP target_feature(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelFeatureDescriptor * * return_value );


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




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif