/*-----------------------------------------------------------
Implemented `IEiffelFeatureDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELFEATUREDESCRIPTOR_IMPL_PROXY_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELFEATUREDESCRIPTOR_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelFeatureDescriptor_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelFeatureDescriptor.h"

#include "ecom_eiffel_compiler_IEnumParameter.h"

#include "ecom_eiffel_compiler_IEnumFeature.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelFeatureDescriptor_impl_proxy
{
public:
	IEiffelFeatureDescriptor_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelFeatureDescriptor_impl_proxy ();

	/*-----------------------------------------------------------
	Feature name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


	/*-----------------------------------------------------------
	Feature signature.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_signature(  );


	/*-----------------------------------------------------------
	Is entry a feature?
	-----------------------------------------------------------*/
	void ccom_is_feature(  /* [out] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	Feature external name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_external_name(  );


	/*-----------------------------------------------------------
	Name of class where feature is written in.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_written_class(  );


	/*-----------------------------------------------------------
	Name of class where feature was evaluated in.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_evaluated_class(  );


	/*-----------------------------------------------------------
	Feature description.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_description(  );


	/*-----------------------------------------------------------
	Feature parameters.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_parameters(  );


	/*-----------------------------------------------------------
	Feature return type.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_return_type(  );


	/*-----------------------------------------------------------
	Feature location, full path to file and line number
	-----------------------------------------------------------*/
	void ccom_feature_location(  /* [in, out] */ EIF_OBJECT file_path,  /* [in, out] */ EIF_OBJECT line_number );


	/*-----------------------------------------------------------
	List of all feature callers, includding callers of ancestor and descendant versions.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_all_callers(  );


	/*-----------------------------------------------------------
	Number of all callers.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_all_callers_count(  );


	/*-----------------------------------------------------------
	List of feature callers.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_local_callers(  );


	/*-----------------------------------------------------------
	Number of local callers.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_local_callers_count(  );


	/*-----------------------------------------------------------
	List of feature callers, including callers of descendant versions.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_descendant_callers(  );


	/*-----------------------------------------------------------
	Number of descendant callers.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_descendant_callers_count(  );


	/*-----------------------------------------------------------
	List of implementers.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_implementers(  );


	/*-----------------------------------------------------------
	Number of feature implementers.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_implementer_count(  );


	/*-----------------------------------------------------------
	List of ancestor versions.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ancestor_versions(  );


	/*-----------------------------------------------------------
	Number of ancestor versions.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ancestor_version_count(  );


	/*-----------------------------------------------------------
	List of descendant versions.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_descendant_versions(  );


	/*-----------------------------------------------------------
	Number of descendant versions.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_descendant_version_count(  );


	/*-----------------------------------------------------------
	Is feature exported to all classes?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_exported_to_all(  );


	/*-----------------------------------------------------------
	Is once feature?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_once(  );


	/*-----------------------------------------------------------
	Is external feature?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_external(  );


	/*-----------------------------------------------------------
	Is deferred feature?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_deferred(  );


	/*-----------------------------------------------------------
	Is constant?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_constant(  );


	/*-----------------------------------------------------------
	is frozen feature?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_frozen(  );


	/*-----------------------------------------------------------
	Is infix?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_infix(  );


	/*-----------------------------------------------------------
	Is prefix?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_prefix(  );


	/*-----------------------------------------------------------
	Is attribute?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_attribute(  );


	/*-----------------------------------------------------------
	Is procedure?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_procedure(  );


	/*-----------------------------------------------------------
	Is function?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_function(  );


	/*-----------------------------------------------------------
	Is unique?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_unique(  );


	/*-----------------------------------------------------------
	Is obsolete feature?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_obsolete(  );


	/*-----------------------------------------------------------
	Does feature have precondition?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_has_precondition(  );


	/*-----------------------------------------------------------
	Does feature have postcondition?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_has_postcondition(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * p_IEiffelFeatureDescriptor;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE_c.h"


#endif