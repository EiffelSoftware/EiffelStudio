/*-----------------------------------------------------------
Implemented `IEiffelFeatureDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELFEATUREDESCRIPTOR_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELFEATUREDESCRIPTOR_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelFeatureDescriptor_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelFeatureDescriptor_s.h"

#include "ecom_EiffelComCompiler_IEnumParameter_s.h"

#include "ecom_EiffelComCompiler_IEnumFeature_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelFeatureDescriptor_impl_proxy
{
public:
	IEiffelFeatureDescriptor_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelFeatureDescriptor_impl_proxy ();

	/*-----------------------------------------------------------
	Last error code
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_error_code();


	/*-----------------------------------------------------------
	Last source of exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_source_of_exception();


	/*-----------------------------------------------------------
	Last error description
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_description();


	/*-----------------------------------------------------------
	Last error help file
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_help_file();


	/*-----------------------------------------------------------
	Feature name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


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
	Feature signature.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_signature(  );


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
	void ccom_feature_location(  /* [out] */ EIF_OBJECT pbstr_path,  /* [out] */ EIF_OBJECT pul_line );


	/*-----------------------------------------------------------
	List of all feature callers, including callers of ancestor and descendant versions.
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
	EIF_INTEGER ccom_implementers_count(  );


	/*-----------------------------------------------------------
	List of ancestor versions.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ancestor_versions(  );


	/*-----------------------------------------------------------
	Number of ancestor versions.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ancestor_versions_count(  );


	/*-----------------------------------------------------------
	List of descendant versions.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_descendant_versions(  );


	/*-----------------------------------------------------------
	Number of descendant versions.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_descendant_versions_count(  );


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
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * p_IEiffelFeatureDescriptor;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;


	/*-----------------------------------------------------------
	Exception information
	-----------------------------------------------------------*/
	EXCEPINFO * excepinfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif