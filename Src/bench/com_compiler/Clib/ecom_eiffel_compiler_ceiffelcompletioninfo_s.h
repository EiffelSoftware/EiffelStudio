/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_CEIFFELCOMPLETIONINFO_S_H__
#define __ECOM_EIFFEL_COMPILER_CEIFFELCOMPLETIONINFO_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class CEiffelCompletionInfo;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "CEiffelCompletionInfo_factory.h"

#include "ecom_eiffel_compiler_IEiffelCompletionInfo_s.h"

#ifdef __cplusplus
extern "C" {
#endif

extern "C" const CLSID CLSID_CEiffelCompletionInfo_;

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class CEiffelCompletionInfo : public ecom_eiffel_compiler::IEiffelCompletionInfo, public IProvideClassInfo2
{
public:
	CEiffelCompletionInfo (EIF_TYPE_ID tid);
	CEiffelCompletionInfo (EIF_OBJECT eif_obj);
	virtual ~CEiffelCompletionInfo ();

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
	Flush temporary completion features for a specifi file
	-----------------------------------------------------------*/
	STDMETHODIMP flush_completion_features(  /* [in] */ BSTR a_file_name );


	/*-----------------------------------------------------------
	Initialize a feature for completion without compiltation
	-----------------------------------------------------------*/
	STDMETHODIMP initialize_feature(  /* [in] */ BSTR a_name, /* [in] */ VARIANT a_arguments, /* [in] */ VARIANT a_argument_types, /* [in] */ BSTR a_return_type, /* [in] */ ULONG a_feature_type, /* [in] */ BSTR a_file_name );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface.
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );


	/*-----------------------------------------------------------
	GetClassInfo
	-----------------------------------------------------------*/
	STDMETHODIMP GetClassInfo( ITypeInfo ** ppti );


	/*-----------------------------------------------------------
	GetGUID
	-----------------------------------------------------------*/
	STDMETHODIMP GetGUID( DWORD dwKind, GUID * pguid );



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