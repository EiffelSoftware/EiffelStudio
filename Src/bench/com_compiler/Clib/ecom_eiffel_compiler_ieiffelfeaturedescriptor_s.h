/*-----------------------------------------------------------
Eiffel Feature Descriptor.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELFEATUREDESCRIPTOR_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELFEATUREDESCRIPTOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelFeatureDescriptor_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelFeatureDescriptor_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelFeatureDescriptor;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEnumFeature_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEnumFeature_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEnumFeature;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelFeatureDescriptor_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelFeatureDescriptor_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelFeatureDescriptor : public IUnknown
{
public:
	IEiffelFeatureDescriptor () {};
	~IEiffelFeatureDescriptor () {};

	/*-----------------------------------------------------------
	Feature name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Feature external name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP external_name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Name of class where feature is written in.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP written_class(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Name of class where feature was evaluated in.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluated_class(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Feature description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP description(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Feature location, full path to file and line number
	-----------------------------------------------------------*/
	virtual STDMETHODIMP feature_location(  /* [in, out] */ BSTR * file_path, /* [in, out] */ LONG * line_number ) = 0;


	/*-----------------------------------------------------------
	Feature signature.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP signature(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	List of all feature callers, includding callers of ancestor and descendant versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP all_callers(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_callers ) = 0;


	/*-----------------------------------------------------------
	Number of all callers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP all_callers_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of feature callers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP local_callers(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_callers ) = 0;


	/*-----------------------------------------------------------
	Number of local callers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP local_callers_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of feature callers, including callers of descendant versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP descendant_callers(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_callers ) = 0;


	/*-----------------------------------------------------------
	Number of descendant callers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP descendant_callers_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of implementers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP implementers(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_implementers ) = 0;


	/*-----------------------------------------------------------
	Number of feature implementers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP implementer_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of ancestor versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ancestor_versions(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_implementers ) = 0;


	/*-----------------------------------------------------------
	Number of ancestor versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ancestor_version_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of descendant versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP descendant_versions(  /* [out, retval] */ ecom_eiffel_compiler::IEnumFeature * * some_implementers ) = 0;


	/*-----------------------------------------------------------
	Number of descendant versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP descendant_version_count(  /* [out, retval] */ ULONG * return_value ) = 0;


	/*-----------------------------------------------------------
	List of classes, to which feature is exported.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP exported_to(  /* [out, retval] */ SAFEARRAY *  * names ) = 0;


	/*-----------------------------------------------------------
	Is once feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_once(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is external feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_external(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is deferred feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_deferred(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is constant?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_constant(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	is frozen feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_frozen(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is infix?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_infix(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is prefix?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_prefix(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is attribute?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_attribute(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is procedure?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_procedure(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is function?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_function(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is unique?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_unique(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is obsolete feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_obsolete(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Does feature have precondition?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP has_precondition(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Does feature have postcondition?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP has_postcondition(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;



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