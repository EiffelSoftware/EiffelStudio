/*-----------------------------------------------------------
Implemented `IEiffelFeatureDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELFEATUREDESCRIPTOR_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELFEATUREDESCRIPTOR_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelFeatureDescriptor_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelFeatureDescriptor_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelFeatureDescriptor_impl_stub : public ecom_eiffel_compiler::IEiffelFeatureDescriptor
{
public:
	IEiffelFeatureDescriptor_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelFeatureDescriptor_impl_stub ();

	/*-----------------------------------------------------------
	Feature name.
	-----------------------------------------------------------*/
	STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Feature external name.
	-----------------------------------------------------------*/
	STDMETHODIMP external_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Name of class where feature is written in.
	-----------------------------------------------------------*/
	STDMETHODIMP written_class(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Name of class where feature was evaluated in.
	-----------------------------------------------------------*/
	STDMETHODIMP evaluated_class(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Feature description.
	-----------------------------------------------------------*/
	STDMETHODIMP description(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Feature location, full path to file and line number
	-----------------------------------------------------------*/
	STDMETHODIMP feature_location(  /* [in, out] */ BSTR * file_path, /* [in, out] */ LONG * line_number );


	/*-----------------------------------------------------------
	Feature signature.
	-----------------------------------------------------------*/
	STDMETHODIMP signature(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	List of all feature callers, includding callers of ancestor and descendant versions.
	-----------------------------------------------------------*/
	STDMETHODIMP all_callers(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_callers );


	/*-----------------------------------------------------------
	Number of all callers.
	-----------------------------------------------------------*/
	STDMETHODIMP all_callers_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of feature callers.
	-----------------------------------------------------------*/
	STDMETHODIMP local_callers(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_callers );


	/*-----------------------------------------------------------
	Number of local callers.
	-----------------------------------------------------------*/
	STDMETHODIMP local_callers_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of feature callers, including callers of descendant versions.
	-----------------------------------------------------------*/
	STDMETHODIMP descendant_callers(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_callers );


	/*-----------------------------------------------------------
	Number of descendant callers.
	-----------------------------------------------------------*/
	STDMETHODIMP descendant_callers_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of implementers.
	-----------------------------------------------------------*/
	STDMETHODIMP implementers(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_implementers );


	/*-----------------------------------------------------------
	Number of feature implementers.
	-----------------------------------------------------------*/
	STDMETHODIMP implementer_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of ancestor versions.
	-----------------------------------------------------------*/
	STDMETHODIMP ancestor_versions(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_implementers );


	/*-----------------------------------------------------------
	Number of ancestor versions.
	-----------------------------------------------------------*/
	STDMETHODIMP ancestor_version_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of descendant versions.
	-----------------------------------------------------------*/
	STDMETHODIMP descendant_versions(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_implementers );


	/*-----------------------------------------------------------
	Number of descendant versions.
	-----------------------------------------------------------*/
	STDMETHODIMP descendant_version_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	Is feature exported to all classes?
	-----------------------------------------------------------*/
	STDMETHODIMP exported_to_all(  /* [out, retval] */ VARIANT_BOOL * names );


	/*-----------------------------------------------------------
	Is once feature?
	-----------------------------------------------------------*/
	STDMETHODIMP is_once(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is external feature?
	-----------------------------------------------------------*/
	STDMETHODIMP is_external(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is deferred feature?
	-----------------------------------------------------------*/
	STDMETHODIMP is_deferred(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is constant?
	-----------------------------------------------------------*/
	STDMETHODIMP is_constant(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	is frozen feature?
	-----------------------------------------------------------*/
	STDMETHODIMP is_frozen(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is infix?
	-----------------------------------------------------------*/
	STDMETHODIMP is_infix(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is prefix?
	-----------------------------------------------------------*/
	STDMETHODIMP is_prefix(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is attribute?
	-----------------------------------------------------------*/
	STDMETHODIMP is_attribute(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is procedure?
	-----------------------------------------------------------*/
	STDMETHODIMP is_procedure(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is function?
	-----------------------------------------------------------*/
	STDMETHODIMP is_function(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is unique?
	-----------------------------------------------------------*/
	STDMETHODIMP is_unique(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is obsolete feature?
	-----------------------------------------------------------*/
	STDMETHODIMP is_obsolete(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Does feature have precondition?
	-----------------------------------------------------------*/
	STDMETHODIMP has_precondition(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Does feature have postcondition?
	-----------------------------------------------------------*/
	STDMETHODIMP has_postcondition(  /* [out, retval] */ VARIANT_BOOL * return_value );


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif